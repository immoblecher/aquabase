{ Copyright (C) 2021 Immo Blecher, immo@blecher.co.za

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
unit Waterlev;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MastDetl, Buttons,
  StdCtrls, Menus, Db, DBCtrls, ExtCtrls, LCLtype, DBGrids, MaskEdit,
  XMLPropStorage, EditBtn, DateTimePicker, rxlookup, ZDataset;

type

  { TWaterlevelForm }

  TWaterlevelForm = class(TMasterDetailForm)
    AMSLCheckBox: TCheckBox;
    ComboBox1: TComboBox;
    DateTimePicker1: TDateTimePicker;
    Label8: TLabel;
    Label9: TLabel;
    LinkedQueryCOMMENT: TStringField;
    LinkedQueryDATE_MEAS: TStringField;
    LinkedQueryINFO_SOURC: TStringField;
    LinkedQueryLEVEL_STAT: TStringField;
    LinkedQueryMETH_MEAS: TStringField;
    LinkedQueryPIEZOM_NR: TStringField;
    LinkedQueryTIME_MEAS: TStringField;
    LinkedQueryTIME_SEC: TFloatField;
    LinkedQueryWATER_LEV: TFloatField;
    procedure AMSLCheckBoxChange(Sender: TObject);
    procedure ChartSpeedButtonClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure LinkedQueryAfterOpen(DataSet: TDataSet);
    procedure LinkedQueryAfterRefresh(DataSet: TDataSet);
    procedure LinkedQueryBeforeInsert(DataSet: TDataSet);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQuerySetText(Sender: TField; const aText: string);
    procedure LinkedQueryValidate(Sender: TField);
    procedure LinkedQueryPIEZOM_NRValidate(Sender: TField);
    procedure LinkedQueryDATE_MEASValidate(Sender: TField);
    procedure LinkedQueryTIME_MEASValidate(Sender: TField);
    procedure LinkedQueryWATER_LEVGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure LinkedQueryWATER_LEVSetText(Sender: TField;
      const aText: String);
  private
    { Private declarations }
    PrevInfoSource, PrevMeth, PrevStatus, PrevPiez, PrevDate: String;
  public
    { Public declarations }
  end;

var
  WaterlevelForm: TWaterlevelForm;

implementation

uses Timedept, VARINIT, Strdatetime, MainDataModule;

{$R *.lfm}

procedure TWaterlevelForm.FormActivate(Sender: TObject);
begin
  inherited;
  if AMSLCheckbox.Checked then
    LinkedLabel.Caption := Caption + ' [' + LengthUnit + ']'
  else
    LinkedLabel.Caption := Caption + ' [' + LengthUnit + '] b.g.l.';
end;

procedure TWaterlevelForm.LinkedQueryAfterOpen(DataSet: TDataSet);
begin
  inherited;
  DateTimePicker1.Enabled := LinkedQuery.RecordCount > 0;
  if LinkedQuery.RecordCount > 0 then
    DateTimePicker1.Date := StringToDate(LinkedQueryDATE_MEAS.AsString)
  else
    DateTimePicker1.Date := Now;
end;

procedure TWaterlevelForm.LinkedQueryAfterRefresh(DataSet: TDataSet);
begin
  inherited;
  DateTimePicker1.Enabled := LinkedQuery.RecordCount > 0;
end;

procedure TWaterlevelForm.AMSLCheckBoxChange(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  LinkedLabel.ShowHint := not AMSLCheckBox.Checked;
  if AMSLCheckbox.Checked then
    LinkedLabel.Caption := Caption + ' [' + LengthUnit + ']'
  else
    LinkedLabel.Caption := Caption + ' [' + LengthUnit + '] b.g.l.';
  Application.ProcessMessages;
  LinkedQuery.Refresh;
  Screen.Cursor := crDefault;
end;

procedure TWaterlevelForm.ChartSpeedButtonClick(Sender: TObject);
begin
  inherited;
  with TTimeDeptForm.Create(Application) do
  begin
    StartDate := StringToDate(LinkedQueryDATE_MEAS.AsString);
    StartTime := StringToTime(LinkedQueryTIME_MEAS.AsString);
    CheckBoxUseElev1.Checked := AMSLCheckBox.Checked;
    TimeDeptTable[1] := 'WATERLEV';
    ShowModal;
  end;
end;

procedure TWaterlevelForm.ComboBox1Change(Sender: TObject);
begin
  if ComboBox1.ItemIndex = 0 then
    LinkedQuery.SortedFields := 'SITE_ID_NR, DATE_MEAS, TIME_MEAS, TIME_SEC, PIEZOM_NR'
  else
    LinkedQuery.SortedFields := 'SITE_ID_NR, PIEZOM_NR, DATE_MEAS, TIME_MEAS, TIME_SEC';
end;

procedure TWaterlevelForm.DateTimePicker1Change(Sender: TObject);
begin
  LinkedQuery.Locate('DATE_MEAS', FormatDateTime('YYYYMMDD', DateTimePicker1.Date), []);
end;

procedure TWaterlevelForm.LinkedQueryBeforeInsert(DataSet: TDataSet);
begin
  PrevDate := LinkedQueryDATE_MEAS.Value;
  PrevInfoSource := LinkedQueryINFO_SOURC.Value;
  PrevMeth := LinkedQueryMETH_MEAS.Value;
  PrevStatus := LinkedQueryLEVEL_STAT.Value;
  PrevPiez := LinkedQueryPIEZOM_NR.Value;
end;

procedure TWaterlevelForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  LinkedQueryINFO_SOURC.Value := PrevInfoSource;
  LinkedQueryMETH_MEAS.Value := PrevMeth;
  LinkedQueryLEVEL_STAT.Value := PrevStatus;
  if PrevPiez = '' then
    LinkedQueryPIEZOM_NR.Value := '0'
  else
    LinkedQueryPIEZOM_NR.Value := PrevPiez;
  if PrevDate = '' then
    LinkedQueryDATE_MEAS.Value := FormatDateTime('YYYYMMDD', Date)
  else
    LinkedQueryDATE_MEAS.Value := PrevDate;
  LinkedQueryTIME_MEAS.Value := FormatDateTime('hhnn', Time);
  LinkedQueryTIME_SEC.Value := 0.00;
end;

procedure TWaterlevelForm.LinkedQuerySetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;


procedure TWaterlevelForm.LinkedQueryValidate(Sender: TField);
begin
  inherited;
  ValidFound := DataModuleMain.LookupValidFound(Sender.LookupKeyFields, Sender.AsString);
end;

procedure TWaterlevelForm.LinkedQueryPIEZOM_NRValidate(Sender: TField);
begin
  inherited;
  if (LinkedQueryPIEZOM_NR.Value >= '0') and
     (LinkedQueryPIEZOM_NR.Value <= '9') then
    ValidFound := True
  else
    ValidFound := False;
end;

procedure TWaterlevelForm.LinkedQueryDATE_MEASValidate(Sender: TField);
begin
  inherited;
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TWaterlevelForm.LinkedQueryTIME_MEASValidate(Sender: TField);
begin
  inherited;
  ValidFound := not Sender.IsNull and ValidTime(Sender.Value);
end;

procedure TWaterlevelForm.LinkedQueryWATER_LEVGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  inherited;
  if not Sender.IsNull then
  begin
    if AMSLCheckBox.Checked then
    begin
      Elevation := DataModuleMain.BasicinfQueryALTITUDE.Value;
      if Abs((Elevation - Sender.AsFloat) * LengthFactor) > 10000 then
        aText := FloatToStrF((Elevation - Sender.AsFloat) * LengthFactor, ffFixed, 15, 1)
      else
        aText := FloatToStrF((Elevation - Sender.AsFloat) * LengthFactor, ffFixed, 15, 2);
    end
    else
    begin
      if Abs(Sender.AsFloat * LengthFactor) > 10000 then
        aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 1)
      else
        aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
    end;
  end;
end;

procedure TWaterlevelForm.LinkedQueryWATER_LEVSetText(Sender: TField;
  const aText: String);
begin
  inherited;
  if aText <> '' then
  if AMSLCheckBox.Checked then
  begin
    Elevation := DataModuleMain.BasicinfQueryALTITUDE.Value + DataModuleMain.BasicinfQueryCOLLAR_HI.Value;
    Sender.Value := (Elevation - StrToFloat(aText))/LengthFactor;
  end
  else
    Sender.Value := StrToFloat(aText)/LengthFactor;
end;

end.
