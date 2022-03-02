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
unit Fldmeas;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLtype, MastDetl,
  StdCtrls, Menus, Db, DBCtrls, ExtCtrls, Buttons, DBGrids, MaskEdit,
  XMLPropStorage, DateTimePicker, rxlookup, ZDataset;

type

  { TFldMeasForm }

  TFldMeasForm = class(TMasterDetailForm)
    AMSLCheckBox: TCheckBox;
    DateTimePicker1: TDateTimePicker;
    Label8: TLabel;
    LinkedQueryCOMMENT: TStringField;
    LinkedQueryDATE_ENTRY: TStringField;
    LinkedQueryDATE_MEAS: TStringField;
    LinkedQueryDEPTH_MEAS: TFloatField;
    LinkedQueryINFO_SOURC: TStringField;
    LinkedQueryPARM_MEAS: TStringField;
    LinkedQueryREADING: TFloatField;
    LinkedQueryREP_INST: TStringField;
    LinkedQueryTIME_MEAS: TStringField;
    procedure ChartSpeedButtonClick(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure LinkedQueryAfterOpen(DataSet: TDataSet);
    procedure LinkedQueryAfterRefresh(DataSet: TDataSet);
    procedure LinkedQueryBeforeInsert(DataSet: TDataSet);
    procedure LinkedQueryCOMMENTGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryDATE_MEASValidate(Sender: TField);
    procedure LinkedQueryDEPTH_MEASGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryDEPTH_MEASSetText(Sender: TField; const aText: string);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryREADINGGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryREADINGSetText(Sender: TField; const aText: string);
    procedure LinkedQueryValidate(Sender: TField);
    procedure LinkedQueryTIME_MEASValidate(Sender: TField);
    procedure LinkedQueryUpperSetText(Sender: TField; const aText: string);
    procedure AMSLCheckBoxClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    PrevInfoSource, PrevDate, PrevRepInst: String;
    PrevDepth: Double;
  public
    { Public declarations }
  end;

var
  FldMeasForm: TFldMeasForm;

implementation

uses Timedept, strdatetime, Varinit, MainDataModule;

{$R *.lfm}

procedure TFldMeasForm.LinkedQueryBeforeInsert(DataSet: TDataSet);
begin
  PrevDate := LinkedQueryDATE_MEAS.Value;
  PrevInfoSource := LinkedQueryINFO_SOURC.Value;
  PrevRepInst := LinkedQueryREP_INST.Value;
  PrevDepth := LinkedQueryDEPTH_MEAS.Value;
end;

procedure TFldMeasForm.LinkedQueryCOMMENTGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := UpperCase(Sender.AsString);
end;

procedure TFldMeasForm.ChartSpeedButtonClick(Sender: TObject);
begin
  with TTimeDeptForm.Create(Application) do
  begin
    StartDate := StringToDate(LinkedQueryDATE_MEAS.AsString);
    StartTime := StringToTime(LinkedQueryTIME_MEAS.AsString);
    TimeDeptTable[1] := 'fldmeas_';
    ComboBoxDataChange(ComboBoxData1); //trigger event to update comboboxes
    ShowModal;
  end;
end;

procedure TFldMeasForm.DateTimePicker1Change(Sender: TObject);
begin
  LinkedQuery.Locate('DATE_MEAS', FormatDateTime('YYYYMMDD', DateTimePicker1.Date), []);
end;

procedure TFldMeasForm.LinkedQueryAfterOpen(DataSet: TDataSet);
begin
  inherited;
  DateTimePicker1.Enabled := LinkedQuery.RecordCount > 0;
  if LinkedQuery.RecordCount > 0 then
    DateTimePicker1.Date := StringToDate(LinkedQueryDATE_MEAS.AsString)
  else
    DateTimePicker1.Date := Now;
end;

procedure TFldMeasForm.LinkedQueryAfterRefresh(DataSet: TDataSet);
begin
  inherited;
  DateTimePicker1.Enabled := LinkedQuery.RecordCount > 0;
end;

procedure TFldMeasForm.LinkedQueryDATE_MEASValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TFldMeasForm.LinkedQueryDEPTH_MEASGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.AsFloat > 0 then
  begin
    if AMSLCheckBox.Checked then
      Elevation := DataModuleMain.BasicinfQueryALTITUDE.Value + DataModuleMain.BasicinfQueryCOLLAR_HI.Value
    else
      Elevation := 2 * Sender.AsFloat;
    if (Elevation - Sender.AsFloat) * LengthFactor > 10000 then
      aText := FloatToStrF((Elevation - Sender.AsFloat) * LengthFactor, ffFixed, 15, 0)
    else
      aText := FloatToStrF((Elevation - Sender.AsFloat) * LengthFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TFldMeasForm.LinkedQueryDEPTH_MEASSetText(Sender: TField;
  const aText: string);
begin
  if AMSLCheckBox.Checked then
    Elevation := DataModuleMain.BasicinfQueryALTITUDE.Value + DataModuleMain.BasicinfQueryCOLLAR_HI.Value
  else
  if aText <> '' then
  begin
    Elevation := 2 * StrToFloat(aText);
    Sender.AsFloat := (Elevation - StrToFloat(aText))/LengthFactor;
  end;
end;

procedure TFldMeasForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  LinkedQueryDATE_ENTRY.ReadOnly := False;
  LinkedQueryDATE_ENTRY.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryDATE_ENTRY.ReadOnly := True;
  if PrevDate = '' then
    LinkedQueryDATE_MEAS.Value := FormatDateTime('YYYYMMDD', Date)
  else
    LinkedQueryDATE_MEAS.Value := PrevDate;
  LinkedQueryTIME_MEAS.Value := FormatDateTime('hhnn', Time);
  LinkedQueryINFO_SOURC.Value := PrevInfoSource;
  if PrevRepInst = '' then
  begin
    if DataModuleMain.BasicinfQueryREP_INST.Value <> '' then
      LinkedQueryREP_INST.Value := DataModuleMain.BasicinfQueryREP_INST.Value;
  end
  else
    LinkedQueryREP_INST.Value := PrevRepInst;
  LinkedQueryDEPTH_MEAS.Value := PrevDepth;
end;

procedure TFldMeasForm.LinkedQueryREADINGGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
var
  TheFactor: Real;
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if LinkedQueryPARM_MEAS.AsString = 'C' then
        TheFactor := ECFactor
    else
    if (LinkedQueryPARM_MEAS.AsString = 'P') or (LinkedQueryPARM_MEAS.AsString = 'T') then
      TheFactor := 1
    else
      TheFactor := ChemFactor;
    if Abs(Sender.Value * TheFactor) < 0.001 then
      aText := FloatToStrF(Sender.AsFloat * TheFactor, ffFixed, 15, 5)
    else
    if Abs(Sender.Value * TheFactor) < 0.1 then
      aText := FloatToStrF(Sender.AsFloat * TheFactor, ffFixed, 15, 3)
    else
    if Abs(Sender.Value * TheFactor) < 100 then
      aText := FloatToStrF(Sender.AsFloat * TheFactor, ffFixed, 15, 2)
    else
    if Abs(Sender.Value * TheFactor) < 1000 then
      aText := FloatToStrF(Sender.AsFloat * TheFactor, ffFixed, 15, 1)
    else
      aText := FloatToStrF(Sender.AsFloat * TheFactor, ffFixed, 15, 0);
  end;
end;

procedure TFldMeasForm.LinkedQueryREADINGSetText(Sender: TField;
  const aText: string);
var
  TheFactor: Real;
begin
  if LinkedQueryPARM_MEAS.Value = 'C' then
    TheFactor := ECFactor
  else
  if (LinkedQueryPARM_MEAS.Value = 'P') or (LinkedQueryPARM_MEAS.Value = 'T') then
    TheFactor := 1
  else
    TheFactor := ChemFactor;
  Sender.Value := StrToFloat(aText) / TheFactor;
end;

procedure TFldMeasForm.LinkedQueryValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound(Sender.LookupKeyFields, Sender.AsString);
end;

procedure TFldMeasForm.LinkedQueryTIME_MEASValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidTime(Sender.Value);
end;

procedure TFldMeasForm.LinkedQueryUpperSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TFldMeasForm.AMSLCheckBoxClick(Sender: TObject);
begin
  inherited;
  LinkedQuery.Refresh;
end;

procedure TFldMeasForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption + ' - Depth [' + LengthUnit + '], EC [' + ECUnit + '], other [' + ChemUnit + '], where appl.';
  LinkedLabel.Width := 480;
end;

end.
