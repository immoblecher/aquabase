{ Copyright (C) 2022 Immo Blecher, immo@blecher.co.za

  This source is free software; you can redistribute it and/or modify it under
  the terms of the GNU General Public License as published by the Free
  Software Foundation; either version 2 of the License, or (at your option)
  any later version.

  This code is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

  A copy of the GNU General Public License is available on the World Wide Web
  at <http://www.gnu.org/copyleft/gpl.html>. You can also obtain it by writing
  to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
  MA 02111-1307, USA.
}
unit FCdata;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons,
  StdCtrls, DB, SdfData, ComCtrls, ButtonPanel, EditBtn, DBCtrls, ZDataset,
  DateUtils;

type

  { TfrmFCdata }

  TfrmFCdata = class(TForm)
    ButtonPanel1: TButtonPanel;
    DataSourceWL: TDataSource;
    FileNameEdit1: TFileNameEdit;
    GroupBox2: TGroupBox;
    EndDateComboBox: TComboBox;
    StartDateComboBox: TComboBox;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    Label9: TLabel;
    PumpTestQuery: TZReadOnlyQuery;
    WlQuery: TZReadOnlyQuery;
    DischQuery: TZReadOnlyQuery;
    procedure CancelButtonClick(Sender: TObject);
    procedure DischQueryAfterOpen(DataSet: TDataSet);
    procedure DischQueryBeforeOpen(DataSet: TDataSet);
    procedure FileNameEdit1ButtonClick(Sender: TObject);
    procedure FileNameEdit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure WlQueryAfterOpen(DataSet: TDataSet);
    procedure WlQueryBeforeOpen(DataSet: TDataSet);
    procedure PumpTestQueryAfterOpen(DataSet: TDataSet);
    procedure PumpTestQueryBeforeOpen(DataSet: TDataSet);
    procedure StaticWlQueryWATER_LEVGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
  private
    { Private declarations }
    StaticFound: Boolean;
    csvList: TStringList;
  public
    { Public declarations }
  end;

var
  frmFCdata: TfrmFCdata;

implementation

uses VARINIT, MainDataModule, StrDateTime;

{$R *.lfm}

procedure TfrmFCdata.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmFCdata.DischQueryAfterOpen(DataSet: TDataSet);
begin
  with WlQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT w.DATE_MEAS, w.TIME_MEAS, w.WATER_LEV, w.LEVEL_STAT, w.COMMENT from waterlev w');
    SQL.Add('WHERE w.SITE_ID_NR = ' + QuotedStr(CurrentSite));
    if DataModuleMain.ZConnectionDB.Tag = 1 then //SQLite
    begin
      SQL.Add('AND w.DATE_MEAS || w.TIME_MEAS >= ' + QuotedStr(StringReplace(StartDateComboBox.Text, ' ', '', [])));
      SQL.Add('AND w.DATE_MEAS || w.TIME_MEAS <= ' + QuotedStr(StringReplace(EndDateComboBox.Text, ' ', '', [])));
    end
    else
    begin
      SQL.Add('AND CONCAT(w.DATE_MEAS, w.TIME_MEAS) >= ' + QuotedStr(StringReplace(StartDateComboBox.Text, ' ', '', [])));
      SQL.Add('AND CONCAT(w.DATE_MEAS, w.TIME_MEAS) <= ' + QuotedStr(StringReplace(EndDateComboBox.Text, ' ', '', [])));
    end;
    SQL.Add('ORDER BY w.DATE_MEAS, w.TIME_MEAS');
    Open;
  end;
end;

procedure TfrmFCdata.DischQueryBeforeOpen(DataSet: TDataSet);
begin
  DischQuery.Connection := DataModuleMain.ZConnectionDB;
end;

procedure TfrmFCdata.FileNameEdit1ButtonClick(Sender: TObject);
begin
  FileNameEdit1.InitialDir := WSpaceDir;
end;

procedure TfrmFCdata.FileNameEdit1Change(Sender: TObject);
begin
  ButtonPanel1.OKButton.Enabled := FileNameEdit1.Text > '';
end;

procedure TfrmFCdata.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, False);
  PumpTestQuery.Open;
end;

procedure TfrmFCdata.OKButtonClick(Sender: TObject);
begin
  csvList := TStringList.Create;
  csvList.Add('lvl_stat,t_min,s_m,Q_l_s,comment');
  with DischQuery do //open first as needed after open of WlQuery
  begin
    SQL.Clear;
    SQL.Add('SELECT d.DATE_MEAS, d.TIME_MEAS, d.DISCH_RATE from discharg d');
    SQL.Add('WHERE d.SITE_ID_NR = ' + QuotedStr(CurrentSite));
    if DataModuleMain.ZConnectionDB.Tag = 1 then //SQLite
    begin
      SQL.Add('AND d.DATE_MEAS || d.TIME_MEAS >= ' + QuotedStr(StringReplace(StartDateComboBox.Text, ' ', '', [])));
      SQL.Add('AND d.DATE_MEAS || d.TIME_MEAS <= ' + QuotedStr(StringReplace(EndDateComboBox.Text, ' ', '', [])));
    end
    else
    begin
      SQL.Add('AND CONCAT(d.DATE_MEAS, d.TIME_MEAS) >= ' + QuotedStr(StringReplace(StartDateComboBox.Text, ' ', '', [])));
      SQL.Add('AND CONCAT(d.DATE_MEAS, d.TIME_MEAS) <= ' + QuotedStr(StringReplace(EndDateComboBox.Text, ' ', '', [])));
    end;
    SQL.Add('ORDER BY d.DATE_MEAS, d.TIME_MEAS');
    Open;
  end;
  csvList.SaveToFile(FileNameEdit1.Text);
  csvList.Free;
  if not StaticFound then
    MessageDlg('Finished exporting data to FC! However, there was no initial static water level and therefore your drawdowns may be incorrect.', mtWarning, [mbOk], 0)
  else
    MessageDlg('Finished exporting data to FC!', mtInformation, [mbOk], 0);
end;

procedure TfrmFCdata.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TfrmFCdata.WlQueryAfterOpen(DataSet: TDataSet);
var
  StaticWl, DischRate: Double;
  StartDateTime, TheDateTime: TDateTime;
begin
  StaticWl := 0;
  DischRate := 0;
  while not DataSet.EOF do
  with DataSet do
  begin
    //work out discharge rate
    if DischQuery.Locate('DATE_MEAS;TIME_MEAS', VarArrayOf([FieldByName('DATE_MEAS').Value, FieldByName('TIME_MEAS').Value]), []) then
      DischRate := DischQuery.FieldByName('DISCH_RATE').Value;
    if FieldByName('LEVEL_STAT').Value = 'R' then //recovery, so no discharge rate
      DischRate := 0;
    //if static water level then work out starting static, else add string to csv
    if FieldByName('LEVEL_STAT').Value = 'S' then //determine date/time of and static wl
    begin
      StartDateTime := StringToDate(FieldByName('DATE_MEAS').Value) + StringToTime(FieldByName('TIME_MEAS').Value);
      StaticWl := FieldByName('WATER_LEV').AsFloat;
      if WlQuery.BOF then StaticFound := True; //only if the first record is static
    end
    else
    begin
      TheDateTime := StringToDate(FieldByName('DATE_MEAS').Value) + StringToTime(FieldByName('TIME_MEAS').Value);
      csvList.Add(FieldByName('LEVEL_STAT').AsString + ','
        + IntToStr(MinutesBetween(TheDateTime, StartDateTime)) + ',' //minutes since start
        + FloatToStr(FieldByName('WATER_LEV').AsFloat - StaticWl) + ',' //water level minus stating water level = drawdown
        + FloatToStr(DischRate) + ',' //discharge rate
        + FieldByName('COMMENT').AsString);
    end;
    Next;
  end;
  DataSet.Close;
  DischQuery.Close;
end;

procedure TfrmFCdata.WlQueryBeforeOpen(DataSet: TDataSet);
begin
  WlQuery.Connection := DataModuleMain.ZConnectionDB;
end;

procedure TfrmFCdata.PumpTestQueryAfterOpen(DataSet: TDataSet);
begin
  if DataSet.RecordCount > 0 then
  while not DataSet.EOF do
  begin
    StartDateComboBox.Items.Add(DataSet.FieldByName('DATE_START').Value
      + ' ' + DataSet.FieldByName('TIME_START').Value);
    EndDateComboBox.Items.Add(DataSet.FieldByName('DATE_END').Value
      + ' ' + DataSet.FieldByName('TIME_END').Value);
    DataSet.Next;
  end;
  if StartDateComboBox.Items.Count > 0 then
  begin
    StartDateComboBox.ItemIndex := 0;
    EndDateComboBox.ItemIndex := 0;
  end
  else
    MessageDlg('No pumping test data found!', mtError ,[mbOk], 0);
end;

procedure TfrmFCdata.PumpTestQueryBeforeOpen(DataSet: TDataSet);
begin
  PumpTestQuery.Connection := DataModuleMain.ZConnectionDB;
  PumpTestQuery.Params[0].Value := CurrentSite;
end;

procedure TfrmFCdata.StaticWlQueryWATER_LEVGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if not Sender.IsNull then
  begin
    if Abs(Sender.AsFloat * LengthFactor) > 10000 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 1)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end;
end;

end.
