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
unit Discharg;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLtype, MastDetl, Db,
  Menus, DBCtrls, ExtCtrls, Buttons;

type

  { TDischargeForm }

  TDischargeForm = class(TMasterDetailForm)
    LinkedQueryCOMMENT: TStringField;
    LinkedQueryDATE_MEAS: TStringField;
    LinkedQueryDISCH_RATE: TFloatField;
    LinkedQueryDISCH_TYPE: TStringField;
    LinkedQueryINFO_SOURC: TStringField;
    LinkedQueryMETH_MEAS: TStringField;
    LinkedQueryREP_INST: TStringField;
    LinkedQueryTIME_MEAS: TStringField;
    procedure ChartSpeedButtonClick(Sender: TObject);
    procedure EditDATE_UPDTDChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure LinkedQueryBeforeInsert(DataSet: TDataSet);
    procedure LinkedQueryDATE_MEASValidate(Sender: TField);
    procedure LinkedQueryDISCH_RATEGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryDISCH_RATESetText(Sender: TField; const aText: string);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryValidate(Sender: TField);
    procedure LinkedQueryTIME_MEASValidate(Sender: TField);
    procedure LinkedQueryUpperSetText(Sender: TField; const aText: string);
    procedure GraphSpeedButtonClick(Sender: TObject);
  private
    { Private declarations }
    PrevRepInst, PrevInfoSource, PrevDate, PrevMethod, PrevType: String;
  public
    { Public declarations }
  end;

var
  DischargeForm: TDischargeForm;

implementation

uses strdatetime, Varinit, TIMEDEPT, MainDataModule;

{$R *.lfm}

procedure TDischargeForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption + ' [' + DisUnit + ']';
end;

procedure TDischargeForm.ChartSpeedButtonClick(Sender: TObject);
begin
  inherited;
  with TTimeDeptForm.Create(Application) do
  begin
    StartDate := StringToDate(LinkedQueryDATE_MEAS.AsString);
    StartTime := StringToTime(LinkedQueryTIME_MEAS.AsString);
    TimeDeptTable[1] := 'DISCHARG';
    ShowModal;
  end;
end;

procedure TDischargeForm.EditDATE_UPDTDChange(Sender: TObject);
begin

end;

procedure TDischargeForm.LinkedQueryBeforeInsert(DataSet: TDataSet);
begin
  PrevRepInst := LinkedQueryREP_INST.Value;
  PrevType := LinkedQueryDISCH_TYPE.Value;
  PrevMethod := LinkedQueryMETH_MEAS.Value;
  PrevInfoSource := LinkedQueryINFO_SOURC.Value;
  PrevDate := LinkedQueryDATE_MEAS.Value;
end;

procedure TDischargeForm.LinkedQueryDATE_MEASValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TDischargeForm.LinkedQueryDISCH_RATEGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if not Sender.IsNull then
  begin
    if Sender.AsFloat = 0 then
      aText := '0.00'
    else
    if Sender.AsFloat * VolumeFactor * TimeFactor > 100000 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 0)
    else
    if Sender.AsFloat * VolumeFactor * TimeFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 2);
  end;
end;

procedure TDischargeForm.LinkedQueryDISCH_RATESetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
    LinkedQueryDISCH_RATE.Value := StrToFloat(aText)/VolumeFactor/TimeFactor;
end;

procedure TDischargeForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  if PrevRepInst = '' then
  begin
    if DataModuleMain.BasicinfQueryREP_INST.Value <> '' then
      LinkedQueryREP_INST.Value := DataModuleMain.BasicinfQueryREP_INST.Value;
  end
  else
    LinkedQueryREP_INST.Value := PrevRepInst;
  LinkedQueryDISCH_TYPE.Value := PrevType;
  LinkedQueryMETH_MEAS.Value := PrevMethod;
  LinkedQueryINFO_SOURC.Value := PrevInfoSource;
  if PrevDate = '' then
    LinkedQueryDATE_MEAS.Value := FormatDateTime('YYYYMMDD', Date)
  else
    LinkedQueryDATE_MEAS.Value := PrevDate;
  LinkedQueryTIME_MEAS.Value := FormatDateTime('hhnn', Time);
end;

procedure TDischargeForm.LinkedQueryValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound(Sender.LookupKeyFields, Sender.AsString);
end;

procedure TDischargeForm.LinkedQueryTIME_MEASValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidTime(Sender.Value);
end;

procedure TDischargeForm.LinkedQueryUpperSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TDischargeForm.GraphSpeedButtonClick(Sender: TObject);
begin

end;

end.
