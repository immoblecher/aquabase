{ Copyright (C) 2025 Immo Blecher, immo@blecher.co.za

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
unit Pumptest;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, LCLtype,
  MastDetl, Menus, Db, DBCtrls, ExtCtrls, Buttons, DBGrids, MaskEdit;

type

  { TPumpTestForm }

  TPumpTestForm = class(TMasterDetailForm)
    DBMemo1: TDBMemo;
    LinkedQueryNOTE_PAD: TWideStringField;
    ObsBhsCheckBox: TCheckBox;
    LinkedQueryCONTRACTOR: TStringField;
    LinkedQueryDATE_END: TStringField;
    LinkedQueryDATE_ENTRY: TStringField;
    LinkedQueryDATE_START: TStringField;
    LinkedQueryDEPTH_INTK: TFloatField;
    LinkedQueryDIST_HOLE1: TFloatField;
    LinkedQueryDIST_HOLE2: TFloatField;
    LinkedQueryDIST_HOLE3: TFloatField;
    LinkedQueryDIST_HOLE4: TFloatField;
    LinkedQueryDIST_HOLE5: TFloatField;
    LinkedQueryDIST_HOLE6: TFloatField;
    LinkedQueryMETH_TESTD: TStringField;
    LinkedQueryNOTES_YN: TStringField;
    LinkedQueryOBS_HOLE_1: TStringField;
    LinkedQueryOBS_HOLE_2: TStringField;
    LinkedQueryOBS_HOLE_3: TStringField;
    LinkedQueryOBS_HOLE_4: TStringField;
    LinkedQueryOBS_HOLE_5: TStringField;
    LinkedQueryOBS_HOLE_6: TStringField;
    LinkedQueryRECC_ABSTR: TFloatField;
    LinkedQueryREP_INST: TStringField;
    LinkedQuerySTORATIV_0: TFloatField;
    LinkedQuerySTORATIV_1: TFloatField;
    LinkedQuerySTORATIV_2: TFloatField;
    LinkedQuerySTORATIV_3: TFloatField;
    LinkedQuerySTORATIV_4: TFloatField;
    LinkedQuerySTORATIV_5: TFloatField;
    LinkedQuerySTORATIV_6: TFloatField;
    LinkedQueryTIME_END: TStringField;
    LinkedQueryTIME_START: TStringField;
    LinkedQueryTRANSMIS_0: TFloatField;
    LinkedQueryTRANSMIS_1: TFloatField;
    LinkedQueryTRANSMIS_2: TFloatField;
    LinkedQueryTRANSMIS_3: TFloatField;
    LinkedQueryTRANSMIS_4: TFloatField;
    LinkedQueryTRANSMIS_5: TFloatField;
    LinkedQueryTRANSMIS_6: TFloatField;
    Splitter1: TSplitter;
    procedure DBMemo1Enter(Sender: TObject);
    procedure DBMemo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LinkedDataSourceDataChange(Sender: TObject; Field: TField);
    procedure LinkedQueryBeforeEdit(DataSet: TDataSet);
    procedure LinkedQueryBeforePost(DataSet: TDataSet);
    procedure LinkedQueryDATE_ENDValidate(Sender: TField);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryOBS_HOLEValidate(Sender: TField);
    procedure LinkedQueryTIME_ENDValidate(Sender: TField);
    procedure LinkedQueryValidate(Sender: TField);
    procedure LinkedQueryTRANSMISGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryTRANSMISSetText(Sender: TField; const aText: string);
    procedure ObsBhsCheckBoxClick(Sender: TObject);
    procedure LinkedQueryUpperSetText(Sender: TField;
      const aText: String);
    procedure LinkedQueryDEPTH_INTKGetText(Sender: TField;
      var aText: String; DisplayText: Boolean);
    procedure LinkedQueryDEPTH_INTKSetText(Sender: TField;
      const aText: String);
    procedure LinkedQueryDATESetText(Sender: TField;
      const aText: String);
    procedure LinkedQueryDATE_STARTValidate(Sender: TField);
    procedure LinkedQueryTIMESetText(Sender: TField;
      const aText: String);
    procedure LinkedQueryTIME_STARTValidate(Sender: TField);
    procedure LinkedQueryRECC_ABSTRGetText(Sender: TField;
      var aText: String; DisplayText: Boolean);
    procedure LinkedQueryRECC_ABSTRSetText(Sender: TField;
      const aText: String);
    procedure LinkedQueryDIST_HOLEGetText(Sender: TField;
      var aText: String; DisplayText: Boolean);
    procedure LinkedQueryDIST_HOLESetText(Sender: TField;
      const aText: String);
    procedure LinkedQueryBeforeInsert(DataSet: TDataSet);
  private
    { Private declarations }
    PrevRepInst, PrevContr, PrevDate, PrevTime: ShortString;
    PrevDepth: Double;
    Validate: Boolean; //to check start/end dates and times
  public
    { Public declarations }
  end;

var
  PumpTestForm: TPumpTestForm;

implementation

uses VARINIT, strdatetime, MainDataModule;

{$R *.lfm}

procedure TPumpTestForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption + ' - Depth [' + LengthUnit
    + '], transm. [' + LengthUnit + '²/d]; abstr. [' + DisUnit + ']';
end;

procedure TPumpTestForm.DBMemo1Enter(Sender: TObject);
begin
  Editing := EditLabel + ' ' + Caption;
  TheActiveDBEdit := NIL;
  TheActiveRxDB := NIL;
  TheActiveDBMemo := DBMemo1;
end;

procedure TPumpTestForm.DBMemo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F5: LinkedQuery.Refresh;
    VK_F8: if (ssCtrl in Shift) then
             LinkedQuery.Edit
           else
             if LinkedQuery.State IN [dsInsert, dsEdit] then
               LinkedQuery.Post;
    VK_ESCAPE: if LinkedQuery.State IN [dsInsert, dsEdit] then
                 LinkedQuery.Cancel;
  end; {of case}
end;

procedure TPumpTestForm.FormCreate(Sender: TObject);
begin
  inherited;
  DBGrid.BorderSpacing.Bottom := 0;
  NotAllFields := True;
end;

procedure TPumpTestForm.LinkedDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  DBMemo1.Enabled := not LinkedQuerySITE_ID_NR.IsNull;
end;

procedure TPumpTestForm.LinkedQueryBeforeEdit(DataSet: TDataSet);
begin
  Validate := True;
end;

procedure TPumpTestForm.LinkedQueryBeforePost(DataSet: TDataSet);
begin
  inherited;
  if LinkedQueryNOTE_PAD.Value = '' then LinkedQuery.FieldByName('NOTES_YN').Value := 'N'
  else LinkedQuery.FieldByName('NOTES_YN').Value := 'Y';
end;

procedure TPumpTestForm.LinkedQueryDATE_ENDValidate(Sender: TField);
begin
  inherited;
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
  if ValidFound then
    if Validate and (LinkedQueryDATE_START.Value + LinkedQueryTIME_START.Value > Sender.Value + LinkedQueryTIME_END.Value) then
    begin
      MessageDlg('Date/Time ended must be after Date/Time started!', mtError, [mbOK], 0);
      ValidFound := False;
    end;
end;

procedure TPumpTestForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  Validate := False;
  LinkedQueryDATE_ENTRY.ReadOnly := False;
  LinkedQueryDATE_ENTRY.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryDATE_ENTRY.ReadOnly := True;
  if PrevRepInst = '' then
    LinkedQueryREP_INST.Value := DataModuleMain.BasicinfQueryREP_INST.Value
  else
    LinkedQueryREP_INST.Value := PrevRepInst;
  LinkedQueryCONTRACTOR.Value := PrevContr;
  if PrevDepth > 0 then
   LinkedQueryDEPTH_INTK.Value := PrevDepth;
  if PrevDate = '' then
  begin
    LinkedQueryDATE_START.Value := FormatDateTime('YYYYMMDD', Date);
    LinkedQueryDATE_END.Value := FormatDateTime('YYYYMMDD', Date);
  end
  else
  begin
    LinkedQueryDATE_START.Value := PrevDate;
    LinkedQueryDATE_END.Value := PrevDate;
  end;
  if PrevTime = '' then
  begin
    LinkedQueryTIME_START.Value := FormatDateTime('hhnn', Time);
    LinkedQueryTIME_END.Value := FormatDateTime('hhnn', Time);
  end
  else
  begin
    LinkedQueryTIME_START.Value := PrevTime;
    LinkedQueryTIME_END.Value := PrevTime;
  end;
  Validate := True;
end;

procedure TPumpTestForm.LinkedQueryOBS_HOLEValidate(Sender: TField);
var
  TheDistance: Real;
  FldIdx: Byte;
begin
  with DataModuleMain.CheckQuery do
  if not Sender.IsNull and (Sender.AsString <> '') then
  begin
    Connection := DataModuleMain.ZConnectionDB;
    SQL.Clear;
    SQL.Add('SELECT SITE_ID_NR FROM basicinf WHERE SITE_ID_NR = ' + QuotedStr(Sender.AsString));
    Open;
    if RecordCount = 0 then
    begin
      ValidFound := False;
      Close;
    end
    else
    begin
      ValidFound := True;
      Close;
      SQL.Clear;
      case DataModuleMain.ZConnectionDB.Tag of
        1: SQL.Add('SELECT ST_Distance(t1.GEOMETRY, t2.GEOMETRY, 1) AS M_APART FROM basicinf AS t1, basicinf AS t2 ');
      2,3: SQL.Add('SELECT ST_Distance(t1.GEOMETRY, t2.GEOMETRY) * 111325 AS M_APART FROM basicinf AS t1, basicinf AS t2 ');
        4: SQL.Add('SELECT ST_Distance(t1.GEOMETRY, t2.GEOMETRY) * 111325 AS M_APART FROM basicinf AS t1, basicinf AS t2 ');
        5: SQL.Add('SELECT t1.GEOMETRY.STDistance(t2.GEOMETRY) * 111325 AS M_APART FROM basicinf AS t1, basicinf AS t2 ');
      end; //of case
      SQL.Add('WHERE t1.SITE_ID_NR = ' + QuotedStr(Sender.Value) + ' AND t2.SITE_ID_NR = ' + QuotedStr(LinkedQuerySITE_ID_NR.Value));
      try
        Open;
        TheDistance := Fields[0].AsFloat;
        Close;
        FldIdx := Sender.Index;
        LinkedQuery.Fields[FldIdx + 1].Value := TheDistance;
      except on E: Exception do
        MessageDlg(E.Message + ': Could not calculate distance between the two Site Identifiers automatically as one or both geometries may be invalid! Try editing both coordinates or run the "Apply Coordinate System" tool to regenerate the geometries. Otherwise enter the distance manually.', mtError, [mbOK], 0);
      end;
    end;
  end;
end;

procedure TPumpTestForm.LinkedQueryTIME_ENDValidate(Sender: TField);
begin
  inherited;
  ValidFound := not Sender.IsNull and ValidTime(Sender.Value);
  if ValidFound then
    if Validate and (LinkedQueryDATE_START.Value + LinkedQueryTIME_START.Value > LinkedQueryDATE_END.Value + Sender.Value) then
    begin
      MessageDlg('Date/Time ended must be after Date/Time started!', mtError, [mbOK], 0);
      ValidFound := False;
    end;
end;

procedure TPumpTestForm.LinkedQueryValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound(Sender.LookupKeyFields, Sender.AsString);
end;

procedure TPumpTestForm.LinkedQueryTRANSMISGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value > 0 then
  begin
    if Sender.Value * LengthFactor > 1000 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
    else
    if Sender.Value * LengthFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TPumpTestForm.LinkedQueryTRANSMISSetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
    Sender.Value := StrToFloat(aText)/LengthFactor;
end;

procedure TPumpTestForm.ObsBhsCheckBoxClick(Sender: TObject);
var
  f: Byte;
begin
  inherited;
  for f := 15 to LinkedQuery.FieldCount - 1 do //don't show NOTES_YN and NOTE_PAD
    LinkedQuery.Fields[f].Visible := ObsBhsCheckbox.Checked;
  NotAllFields := not ObsBhsCheckBox.Checked;
end;

procedure TPumpTestForm.LinkedQueryUpperSetText(Sender: TField;
  const aText: String);
begin
  inherited;
  Sender.Value := UpperCase(aText);
end;

procedure TPumpTestForm.LinkedQueryDEPTH_INTKGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if Sender.AsFloat * LengthFactor > 100 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2)
    else
    if Sender.AsFloat * LengthFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end;
end;

procedure TPumpTestForm.LinkedQueryDEPTH_INTKSetText(Sender: TField;
  const aText: String);
begin
  inherited;
  if aText <> '' then
    Sender.Value := StrToFloat(aText)/LengthFactor;
end;

procedure TPumpTestForm.LinkedQueryDATESetText(Sender: TField;
  const aText: String);
begin
  inherited;
  Sender.Value := aText;
end;

procedure TPumpTestForm.LinkedQueryDATE_STARTValidate(Sender: TField);
begin
  inherited;
  if Sender.IsNull or not ValidDate(Sender.Value) then
    ValidFound := False
  else
  begin
    ValidFound := True;
    if LinkedQueryDATE_END.Value = FormatDateTime('YYYYMMDD', Date) then
      LinkedQueryDATE_END.Value := Sender.Value;
    if Validate and (Sender.Value + LinkedQueryTIME_START.Value > LinkedQueryDATE_END.Value + LinkedQueryTIME_END.Value) then
    begin
      MessageDlg('Date/Time started must be before Date/Time ended!', mtError, [mbOK], 0);
      ValidFound := False;
    end;
  end;
end;

procedure TPumpTestForm.LinkedQueryTIMESetText(Sender: TField; const aText: String);
begin
  inherited;
  Sender.Value := aText;
end;

procedure TPumpTestForm.LinkedQueryTIME_STARTValidate(Sender: TField);
begin
  inherited;
  ValidFound := not Sender.IsNull and ValidTime(Sender.Value);
  if ValidFound then
    if LinkedQuery.State = dsInsert then
      LinkedQueryTIME_END.Value := LinkedQueryTIME_START.Value;
    if Validate and (LinkedQueryDATE_START.Value + Sender.Value > LinkedQueryDATE_END.Value + LinkedQueryTIME_END.Value) then
    begin
      MessageDlg('Date/Time started must be before Date/Time ended!', mtError, [mbOK], 0);
      ValidFound := False;
    end;
end;

procedure TPumpTestForm.LinkedQueryRECC_ABSTRGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if Sender.AsFloat * VolumeFactor * TimeFactor > 100000 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 0)
    else
    if Sender.AsFloat * VolumeFactor * TimeFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 2);
  end;
end;

procedure TPumpTestForm.LinkedQueryRECC_ABSTRSetText(Sender: TField;
  const aText: String);
begin
  inherited;
  if aText <> '' then
    Sender.Value := StrToFloat(aText)/VolumeFactor/TimeFactor;
end;

procedure TPumpTestForm.LinkedQueryDIST_HOLEGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if Sender.AsFloat * LengthFactor > 100 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
    else
    if Sender.AsFloat * LengthFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end;
end;

procedure TPumpTestForm.LinkedQueryDIST_HOLESetText(Sender: TField;
  const aText: String);
begin
  inherited;
  if aText <> '' then
    Sender.Value := StrToFloat(aText)/LengthFactor;
end;

procedure TPumpTestForm.LinkedQueryBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  PrevRepInst := LinkedQueryREP_INST.Value;
  PrevContr := LinkedQueryCONTRACTOR.Value;
  PrevDate := LinkedQueryDATE_END.Value;
  PrevTime := LinkedQueryTIME_END.Value;
  PrevDepth := LinkedQueryDEPTH_INTK.Value;
end;

end.
