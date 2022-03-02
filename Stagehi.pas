{ Copyright (C) 2018 Immo Blecher, immo@blecher.co.za

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
unit Stagehi;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLtype, MastDetl,
  StdCtrls, Buttons, Menus, Db, DBCtrls, ExtCtrls, DBGrids, MaskEdit,
  XMLPropStorage, DateTimePicker, rxlookup, ZDataset;

type

  { TStageHiForm }

  TStageHiForm = class(TMasterDetailForm)
    DateTimePicker1: TDateTimePicker;
    Label8: TLabel;
    LinkedQueryCOMMENTS: TStringField;
    LinkedQueryDATE_MEAS: TStringField;
    LinkedQueryINFO_SOURC: TStringField;
    LinkedQuerySTAGE_HIGH: TFloatField;
    LinkedQueryTIME_MEAS: TStringField;
    AMSLCheckBox: TCheckBox;
    procedure BasicinfDataSourceDataChange(Sender: TObject; Field: TField);
    procedure ChartSpeedButtonClick(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure DBGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LinkedQueryAfterOpen(DataSet: TDataSet);
    procedure LinkedQueryAfterRefresh(DataSet: TDataSet);
    procedure LinkedQueryBeforeInsert(DataSet: TDataSet);
    procedure LinkedQueryDATE_MEASValidate(Sender: TField);
    procedure LinkedQueryINFO_SOURCValidate(Sender: TField);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQuerySTAGE_HIGHGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQuerySTAGE_HIGHSetText(Sender: TField; const aText: string);
    procedure LinkedQueryTIME_MEASValidate(Sender: TField);
    procedure LinkedQueryUpperSetText(Sender: TField; const aText: string);
    procedure FormActivate(Sender: TObject);
    procedure AMSLCheckBoxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StageHiForm: TStageHiForm;

implementation

uses Timedept, VARINIT, strdatetime, MainDataModule;

var
  PrevDate, PrevInfoSource: String;

{$R *.lfm}

procedure TStageHiForm.LinkedQueryBeforeInsert(DataSet: TDataSet);
begin
  PrevDate := LinkedQueryDATE_MEAS.Value;
  PrevInfoSource := LinkedQueryINFO_SOURC.Value;
end;

procedure TStageHiForm.DBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
end;

procedure TStageHiForm.LinkedQueryAfterOpen(DataSet: TDataSet);
begin
  inherited;
  DateTimePicker1.Enabled := LinkedQuery.RecordCount > 0;
  if LinkedQuery.RecordCount > 0 then
    DateTimePicker1.Date := StringToDate(LinkedQueryDATE_MEAS.AsString)
  else
    DateTimePicker1.Date := Now;
end;

procedure TStageHiForm.LinkedQueryAfterRefresh(DataSet: TDataSet);
begin
  inherited;
  DateTimePicker1.Enabled := LinkedQuery.RecordCount > 0;
end;

procedure TStageHiForm.ChartSpeedButtonClick(Sender: TObject);
var
  CreateChart: Boolean;
begin
  inherited;
  CreateChart := True;
  if (LinkedQuery.RecordCount > 10000) then
    if (MessageDlg('This site has more than 10 000 readings and the chart could therefore take a while to produce! Are you sure you want to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
      CreateChart := True
    else
      CreateChart := False;
  if CreateChart then
  with TTimeDeptForm.Create(Application) do
  begin
    StartDate := StringToDate(LinkedQueryDATE_MEAS.AsString);
    StartTime := StringToTime(LinkedQueryTIME_MEAS.AsString);
    TimeDeptTable[1] := 'stage_hi';
    ShowModal;
  end;
end;

procedure TStageHiForm.DateTimePicker1Change(Sender: TObject);
begin
  LinkedQuery.Locate('DATE_MEAS', FormatDateTime('YYYYMMDD', DateTimePicker1.Date), []);
end;

procedure TStageHiForm.BasicinfDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  DBGrid.Enabled := DataModuleMain.BasicinfQuerySITE_TYPE.AsString[1]
    IN ['C', 'G', 'P', 'R', 'S', 'X'];
  LinkedLabel.Enabled := DBGrid.Enabled;
  DetailNavigator.Enabled := DBGrid.Enabled;
  if not DetailNavigator.Enabled then
    ShowMessage('This site type does not seem to allow Stage Height readings!');
end;

procedure TStageHiForm.LinkedQueryDATE_MEASValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TStageHiForm.LinkedQueryINFO_SOURCValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('IS_SURHY', Sender.AsString);
end;

procedure TStageHiForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  LinkedQueryINFO_SOURC.Value := PrevInfoSource;
  if PrevDate = '' then
    LinkedQueryDATE_MEAS.Value := FormatDateTime('YYYYMMDD', Date)
  else
    LinkedQueryDATE_MEAS.Value := PrevDate;
  LinkedQueryTIME_MEAS.Value := FormatDateTime('hhnn', Time);
end;

procedure TStageHiForm.LinkedQuerySTAGE_HIGHGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if AMSLCheckBox.Checked then
      Elevation := DataModuleMain.BasicinfQueryALTITUDE.Value + DataModuleMain.BasicinfQueryCOLLAR_HI.Value
    else
      Elevation := 2 * Sender.AsFloat;
    aText := FloatToStrF((Elevation - Sender.AsFloat) * LengthFactor, ffFixed, 15, 3);
  end
end;

procedure TStageHiForm.LinkedQuerySTAGE_HIGHSetText(Sender: TField;
  const aText: string);
begin
  if AMSLCheckBox.Checked then
    Elevation := DataModuleMain.BasicinfQueryALTITUDE.Value + DataModuleMain.BasicinfQueryCOLLAR_HI.Value
  else
  if Text <> '' then
    Elevation := 2 * StrToFloat(aText);
  if Text <> '' then
    Sender.AsFloat := (Elevation - StrToFloat(aText))/LengthFactor;
end;

procedure TStageHiForm.LinkedQueryTIME_MEASValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidTime(Sender.Value);
end;

procedure TStageHiForm.LinkedQueryUpperSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TStageHiForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption + ' [' + LengthUnit + ']';
end;

procedure TStageHiForm.AMSLCheckBoxClick(Sender: TObject);
begin
  inherited;
  LinkedQuery.Refresh;
end;

end.
