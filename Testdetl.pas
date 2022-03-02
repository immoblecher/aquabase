{ Copyright (C) 2020 Immo Blecher, immo@blecher.co.za

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
unit Testdetl;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MastDetl, Menus, Db,
  DBCtrls, ExtCtrls, Buttons, StdCtrls, DBGrids, MaskEdit, XMLPropStorage,
  rxlookup, ZDataset;

type

  { TTestDetlForm }

  TTestDetlForm = class(TMasterDetailForm)
    CheckBoxResDD: TCheckBox;
    LinkedQueryCALIBR_YLD: TFloatField;
    LinkedQueryCOMMENT: TStringField;
    LinkedQueryDATE_START: TStringField;
    LinkedQueryDEPTH_INTK: TFloatField;
    LinkedQueryDESCRIPTN: TStringField;
    LinkedQueryDISCH_RATE: TFloatField;
    LinkedQueryDRAWDOWN: TFloatField;
    LinkedQueryDURATION: TLongintField;
    LinkedQueryDURA_RECOV: TLongintField;
    LinkedQueryPERC_RECOV: TLongintField;
    LinkedQueryPERMEABIL: TFloatField;
    LinkedQueryRECOVERY: TFloatField;
    LinkedQuerySPEC_CAP: TFloatField;
    LinkedQuerySTORAGE: TFloatField;
    LinkedQueryTIME_START: TStringField;
    LinkedQueryTRANSMISS: TFloatField;
    procedure CheckBoxResDDClick(Sender: TObject);
    procedure LinkedQueryBeforeInsert(DataSet: TDataSet);
    procedure LinkedQueryBeforePost(DataSet: TDataSet);
    procedure LinkedQueryCALIBR_YLDGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryCALIBR_YLDSetText(Sender: TField; const aText: string);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryUpperSetText(Sender: TField; const aText: string);
    procedure LinkedQueryDATE_STARTValidate(Sender: TField);
    procedure LinkedQueryDEPTH_INTKGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryDEPTH_INTKSetText(Sender: TField; const aText: string);
    procedure LinkedQueryDISCH_RATEGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryDISCH_RATESetText(Sender: TField; const aText: string);
    procedure LinkedQueryDRAWDOWNGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryDRAWDOWNSetText(Sender: TField; const aText: string);
    procedure LinkedQueryRECOVERYGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryRECOVERYSetText(Sender: TField; const aText: string);
    procedure LinkedQueryTIME_STARTValidate(Sender: TField);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    PrevDateTime: TDateTime;
    PrevDepth: Real;
    PrevDuration: Integer;
  public
    { Public declarations }
  end;

var
  TestDetlForm: TTestDetlForm;

implementation

uses VARINIT, strdatetime;

{$R *.lfm}

procedure TTestDetlForm.LinkedQueryBeforeInsert(DataSet: TDataSet);
begin
  if LinkedQueryDATE_START.IsNull then
  PrevDateTime := 0
  else
    PrevDateTime := StringToDate(LinkedQueryDATE_START.Value) + StringToTime(LinkedQueryTIME_START.Value);
  if LinkedQueryDEPTH_INTK.IsNull then
    PrevDepth := 0
  else
    PrevDepth := LinkedQueryDEPTH_INTK.Value;
  if LinkedQueryDURATION.IsNull then
    PrevDuration := 0
  else
    PrevDuration := LinkedQueryDURATION.Value;
end;

procedure TTestDetlForm.LinkedQueryBeforePost(DataSet: TDataSet);
begin
  inherited;
  if LinkedQueryRECOVERY.IsNull then
  begin
    LinkedQueryPERC_RECOV.ReadOnly := False;
    LinkedQueryPERC_RECOV.Clear;
    LinkedQueryPERC_RECOV.ReadOnly := True;
  end;
end;

procedure TTestDetlForm.LinkedQueryCALIBR_YLDGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.AsFloat > 0 then
  begin
    if Sender.AsFloat * VolumeFactor * TimeFactor > 100000 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 0)
    else
    if Sender.AsFloat * VolumeFactor * TimeFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TTestDetlForm.LinkedQueryCALIBR_YLDSetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
    Sender.AsFloat := StrToFloat(aText)/VolumeFactor/TimeFactor;
end;

procedure TTestDetlForm.CheckBoxResDDClick(Sender: TObject);
var
  c: Byte;
begin
  if CheckBoxResDD.Checked then
  begin
    LinkedLabel.Caption := Caption + ' - Dis./Yld.  [' + DisUnit
      + '], depth, drawd., res. drawd. [' + LengthUnit + '], T [m²/d], k [m/d]';
    for c := 0 to DBGrid.Columns.Count - 1 do
      if DBGrid.Columns[c].Title.Caption = 'Recovery' then
        DBGrid.Columns[c].Title.Caption := 'Res. drawd.'
  end
  else
  begin
    LinkedLabel.Caption := Caption + ' - Dis./Yld. [' + DisUnit
      + '], depth, drawd., recov. [' + LengthUnit + '], T [m²/d], k [m/d]';
    for c := 0 to DBGrid.Columns.Count - 1 do
      if DBGrid.Columns[c].Title.Caption = 'Res. drawd.' then
        DBGrid.Columns[c].Title.Caption := 'Recovery'
  end;
  LinkedQuery.Refresh;
end;

procedure TTestDetlForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  if PrevDateTime = 0 then
    LinkedQueryDATE_START.Value := FormatDateTime('YYYYMMDD', Date)
  else
  begin
    if PrevDuration > 0 then
      LinkedQueryDATE_START.Value := FormatDateTime('YYYYMMDD', PrevDateTime
        + 1/1440 * PrevDuration)
    else
      LinkedQueryDATE_START.Value := FormatDateTime('YYYYMMDD', Date)
  end;
  if PrevDuration > 0 then
    LinkedQueryTIME_START.Value := FormatDateTime('hhnn', PrevDateTime  + 1/1440 * PrevDuration)
  else
    LinkedQueryTIME_START.Value := FormatDateTime('hhnn', Time);
  LinkedQueryDEPTH_INTK.Value := PrevDepth;
  LinkedQueryDURATION.Value := PrevDuration;
end;

procedure TTestDetlForm.LinkedQueryUpperSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TTestDetlForm.LinkedQueryDATE_STARTValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TTestDetlForm.LinkedQueryDEPTH_INTKGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.AsFloat <> 0 then
  begin
    if Sender.AsFloat * LengthFactor > 1000 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 1)
    else
    if Sender.AsFloat * LengthFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TTestDetlForm.LinkedQueryDEPTH_INTKSetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
    Sender.AsFloat := StrToFloat(aText)/LengthFactor;
end;

procedure TTestDetlForm.LinkedQueryDISCH_RATEGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.AsFloat > 0 then
  begin
    if Sender.AsFloat * VolumeFactor * TimeFactor > 100000 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 0)
    else
    if Sender.AsFloat * VolumeFactor * TimeFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TTestDetlForm.LinkedQueryDISCH_RATESetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
    Sender.AsFloat := StrToFloat(aText)/VolumeFactor/TimeFactor;
end;

procedure TTestDetlForm.LinkedQueryDRAWDOWNGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if not Sender.IsNull then
  begin
    if Abs(Sender.AsFloat * LengthFactor) >= 1000 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 1)
    else
    if Abs(Sender.AsFloat * LengthFactor) < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end
end;

procedure TTestDetlForm.LinkedQueryDRAWDOWNSetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
  begin
    Sender.AsFloat := StrToFloat(aText)/LengthFactor;
    if LinkedQueryRECOVERY.AsFloat > 0 then
    begin
      LinkedQueryPERC_RECOV.ReadOnly := False;
      LinkedQueryPERC_RECOV.AsFloat := Round(LinkedQueryRECOVERY.AsFloat/Sender.AsFloat*100);
      LinkedQueryPERC_RECOV.ReadOnly := True;
    end;
  end;
end;

procedure TTestDetlForm.LinkedQueryRECOVERYGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
var
  TheValue: Real;
begin
  if not Sender.IsNull then
  begin
    if CheckBoxResDD.Checked then
      TheValue := LinkedQueryDRAWDOWN.Value - Sender.Value
    else
      TheValue := Sender.AsFloat;
    if TheValue = 0 then
      aText := '0.00'
    else
    if TheValue * LengthFactor >= 1000 then
      aText := FloatToStrF(TheValue * LengthFactor, ffFixed, 15, 1)
    else
    if TheValue * LengthFactor < 0.01 then
      aText := FloatToStrF(TheValue * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(TheValue * LengthFactor, ffFixed, 15, 2);
  end;
end;

procedure TTestDetlForm.LinkedQueryRECOVERYSetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
  begin
    if CheckBoxResDD.Checked then
      Sender.AsFloat := LinkedQueryDRAWDOWN.Value - StrToFloat(aText)/LengthFactor
    else
      Sender.AsFloat := StrToFloat(aText)/LengthFactor;
    if LinkedQueryDRAWDOWN.AsFloat > 0 then
    begin
      LinkedQueryPERC_RECOV.ReadOnly := False;
      LinkedQueryPERC_RECOV.AsFloat := Round(Sender.AsFloat/LinkedQueryDRAWDOWN.AsFloat*100);
      LinkedQueryPERC_RECOV.ReadOnly := True;
    end;
  end;
end;

procedure TTestDetlForm.LinkedQueryTIME_STARTValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidTime(Sender.Value);
end;

procedure TTestDetlForm.FormActivate(Sender: TObject);
var
  c: Byte;
begin
  inherited;
  if CheckBoxResDD.Checked then
  begin
    LinkedLabel.Caption := Caption + ' - Dis./Yld. [' + DisUnit
      + '], depth, drawd., res. drawd. [' + LengthUnit + '], T [m²/d], k [m/d]';
    for c := 0 to DBGrid.Columns.Count - 1 do
      if DBGrid.Columns[c].Title.Caption = 'Recovery' then
        DBGrid.Columns[c].Title.Caption := 'Res. drawd.'
  end
  else
  begin
    LinkedLabel.Caption := Caption + ' - Dis./Yld. [' + DisUnit
      + '], depth, drawd., recov. [' + LengthUnit + '], T [m²/d], k [m/d]';
    for c := 0 to DBGrid.Columns.Count - 1 do
      if DBGrid.Columns[c].Title.Caption = 'Res. drawd.' then
        DBGrid.Columns[c].Title.Caption := 'Recovery'
  end;
end;


end.
