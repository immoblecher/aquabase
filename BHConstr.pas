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
unit BHConstr;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLtype, Menus, Db,
  StdCtrls, DBCtrls, Buttons, ExtCtrls, ComCtrls, DBGrids,
  ZDataset, TabDetl;

type

  { TBHConstrForm }

  TBHConstrForm = class(TTabbedMastDetailForm)
    AMSLCheckBox: TCheckBox;
    GraphSpeedButton: TSpeedButton;
    ZQuery1COMMENT: TStringField;
    ZQuery1DATE_CONST: TStringField;
    ZQuery1DEPTH_BOT: TFloatField;
    ZQuery1DEPTH_TOP: TFloatField;
    ZQuery1DIAMETER: TFloatField;
    ZQuery1REP_INST: TStringField;
    ZQuery1SITE_ID_NR: TStringField;
    ZQuery2COMMENT: TStringField;
    ZQuery2DATE_INST: TStringField;
    ZQuery2DEPTH_BOT: TFloatField;
    ZQuery2DEPTH_TOP: TFloatField;
    ZQuery2DIAMETER: TFloatField;
    ZQuery2MATERIAL: TStringField;
    ZQuery2OPEN_LEN: TFloatField;
    ZQuery2OPEN_MADE: TStringField;
    ZQuery2OPEN_TYPE: TStringField;
    ZQuery2OPEN_WIDTH: TFloatField;
    ZQuery2OP_COMMENT: TStringField;
    ZQuery2OP_HOR_DIS: TFloatField;
    ZQuery2OP_VER_DIS: TFloatField;
    ZQuery2REP_INST: TStringField;
    ZQuery2SITE_ID_NR: TStringField;
    ZQuery2THICKNESS: TFloatField;
    ZQuery3COMMENT: TStringField;
    ZQuery3DATE_CONST: TStringField;
    ZQuery3DEPTH_BOT: TFloatField;
    ZQuery3DEPTH_TOP: TFloatField;
    ZQuery3DIAMETER: TFloatField;
    ZQuery3MATERIAL: TStringField;
    ZQuery3OPEN_LEN: TFloatField;
    ZQuery3OPEN_MADE: TStringField;
    ZQuery3OPEN_TYPE: TStringField;
    ZQuery3OPEN_WIDTH: TFloatField;
    ZQuery3OP_COMMENT: TStringField;
    ZQuery3OP_HOR_DIS: TFloatField;
    ZQuery3OP_VER_DIS: TFloatField;
    ZQuery3PIEZO_NR: TLargeintField;
    ZQuery3SITE_ID_NR: TStringField;
    ZQuery3THICKNESS: TFloatField;
    ZQuery4COMMENT: TStringField;
    ZQuery4DATE_CONST: TStringField;
    ZQuery4DEPTH_BOT: TFloatField;
    ZQuery4DEPTH_TOP: TFloatField;
    ZQuery4FILL_TYPE: TStringField;
    ZQuery4INDIAM: TFloatField;
    ZQuery4OUTDIAM: TFloatField;
    ZQuery4SITE_ID_NR: TStringField;
    procedure BasicinfDataSourceDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure DEPTH_TOPValidate(Sender: TField);
    procedure DEPTH_BOTValidate(Sender: TField);
    procedure REP_INSTValidate(Sender: TField);
    procedure DIAMGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure DIAMSetText(Sender: TField; const aText: string);
    procedure DEPTHGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure DEPTHSetText(Sender: TField; const aText: string);
    procedure DATEValidate(Sender: TField);
    procedure FieldUpperSetText(Sender: TField; const aText: string);
    procedure MATERIALValidate(Sender: TField);
    procedure OPEN_TYPEValidate(Sender: TField);
    procedure OPEN_MADEValidate(Sender: TField);
    procedure AMSLCheckBoxClick(Sender: TObject);
    procedure GraphSpeedButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ZQuery4AfterPost(DataSet: TDataSet);
    procedure ZQueryAfterDelete(DataSet: TDataSet);
    procedure ZQuery1AfterPost(DataSet: TDataSet);
    procedure ZQuery1BeforeInsert(DataSet: TDataSet);
    procedure ZQuery1NewRecord(DataSet: TDataSet);
    procedure ZQuery2AfterPost(DataSet: TDataSet);
    procedure ZQuery2BeforeInsert(DataSet: TDataSet);
    procedure ZQuery2NewRecord(DataSet: TDataSet);
    procedure ZQuery3BeforeInsert(DataSet: TDataSet);
    procedure ZQuery3NewRecord(DataSet: TDataSet);
    procedure ZQuery3PIEZO_NRValidate(Sender: TField);
    procedure ZQuery4BeforeInsert(DataSet: TDataSet);
    procedure ZQuery4FILL_TYPEValidate(Sender: TField);
    procedure ZQuery4INDIAMValidate(Sender: TField);
    procedure ZQuery4NewRecord(DataSet: TDataSet);
    procedure ZQuery4OUTDIAMValidate(Sender: TField);
  private
    { Private declarations }
    PrevDate, PrevRepInst, PrevMaterial: ShortString;
    PrevPiez: ShortInt;
    PrevDepth2Bot: Real;
  public
    { Public declarations }
  end;

var
  BHConstrForm: TBHConstrForm;

implementation

{$R *.lfm}

uses Strdatetime, Varinit, MainDataModule, GeollogSetForm;

procedure TBHConstrForm.FormCreate(Sender: TObject);
begin
  inherited;
  ZQuery1.Open;
  GraphSpeedButton.Enabled := ZQuery1.RecordCount > 0;
  ZQuery2.Open;
  ZQuery3.Open;
  ZQuery4.Open;
end;

procedure TBHConstrForm.BasicinfDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if ZQuery1.Active and ZQuery2.Active then
    GraphSpeedButton.Enabled := (ZQuery1.RecordCount > 0) or (ZQuery2.RecordCount > 0);
  LinkedLabel.Caption := 'Borehole/Well - Diameter, thickness and openings ['
    + DiamUnit + ']; depth [' + LengthUnit + ']';
  PageControl.Enabled := (DataModuleMain.BasicinfQuerySITE_TYPE.Value = 'B')
    or (DataModuleMain.BasicinfQuerySITE_TYPE.Value = 'D')
    or (DataModuleMain.BasicinfQuerySITE_TYPE.Value = 'W');
  LinkedLabel.Enabled := PageControl.Enabled;
  DetailNavigator.Enabled := PageControl.Enabled;
end;

procedure TBHConstrForm.DEPTH_TOPValidate(Sender: TField);
begin
  if not Sender.Dataset.FieldByName('DEPTH_BOT').IsNull then
    ValidFound := Sender.Value <= Sender.Dataset.FieldByName('DEPTH_BOT').Value;
end;

procedure TBHConstrForm.DEPTH_BOTValidate(Sender: TField);
begin
  ValidFound := Sender.Value > Sender.Dataset.FieldByName('DEPTH_TOP').Value;
end;

procedure TBHConstrForm.REP_INSTValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('REP_INST', Sender.AsString);
end;

procedure TBHConstrForm.DIAMGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if DiamFactor = 1 then aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 1)
    else
    if DiamFactor < 1 then aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 3);
  end;
end;

procedure TBHConstrForm.DIAMSetText(Sender: TField; const aText: string);
begin
  if aText <> '' then
    Sender.AsFloat := StrToFloat(aText)/DiamFactor;
end;

procedure TBHConstrForm.DEPTHGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if AMSLCheckBox.Checked then
      aText := FloatToStrF(DataModuleMain.BasicinfQueryALTITUDE.Value - Sender.AsFloat * LengthFactor, ffFixed, 15, 2)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end;
end;

procedure TBHConstrForm.DEPTHSetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
  begin
    if AMSLCheckBox.Checked then
      Sender.AsFloat := -StrToFloat(aText)/LengthFactor + DataModuleMain.BasicinfQueryALTITUDE.Value
    else
      Sender.AsFloat := StrToFloat(aText)/LengthFactor;
  end;
end;

procedure TBHConstrForm.DATEValidate(Sender: TField);
begin
  inherited;
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TBHConstrForm.FieldUpperSetText(Sender: TField;
  const aText: string);
begin
  Sender.AsString := UpperCase(aText);
end;

procedure TBHConstrForm.MATERIALValidate(Sender: TField);
begin
  inherited;
  ValidFound := DataModuleMain.LookupValidFound('MATERIAL', Sender.AsString);
end;

procedure TBHConstrForm.OPEN_TYPEValidate(Sender: TField);
begin
  inherited;
  ValidFound := DataModuleMain.LookupValidFound('OPENTYPE', Sender.AsString);
end;

procedure TBHConstrForm.OPEN_MADEValidate(Sender: TField);
begin
  inherited;
  ValidFound := DataModuleMain.LookupValidFound('OPENMADE', Sender.AsString);
end;

procedure TBHConstrForm.AMSLCheckBoxClick(Sender: TObject);
begin
  inherited;
  if ZQuery1.Active then ZQuery1.Refresh;
  if ZQuery2.Active then ZQuery2.Refresh;
  if ZQuery3.Active then ZQuery3.Refresh;
  if ZQuery4.Active then ZQuery4.Refresh;
end;

procedure TBHConstrForm.GraphSpeedButtonClick(Sender: TObject);
begin
  inherited;
  with TGeollogSettingsForm.Create(Application) do
  begin
    PageControl1.ActivePage := LogTab;
    ShowModal;
  end;
end;

procedure TBHConstrForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption + ' - Diameter, thickness and openings ['
    + DiamUnit + ']; depth [' + LengthUnit + ']';
end;

procedure TBHConstrForm.ZQuery4AfterPost(DataSet: TDataSet);
begin
  inherited;
  if ZQuery1.RecordCount = 0 then
    ShowMessage('You have entered Fill Material but there is no Hole information, which makes no sense!');
end;

procedure TBHConstrForm.ZQueryAfterDelete(DataSet: TDataSet);
begin
  GraphSpeedButton.Enabled := (ZQuery1.RecordCount > 0) or (ZQuery2.RecordCount > 0);
end;

procedure TBHConstrForm.ZQuery1AfterPost(DataSet: TDataSet);
begin
  inherited;
  GraphSpeedButton.Enabled := ZQuery1.RecordCount > 0;
end;

procedure TBHConstrForm.ZQuery1BeforeInsert(DataSet: TDataSet);
begin
  PrevRepInst := ZQuery1REP_INST.Value;
  PrevDate := ZQuery1DATE_CONST.Value;
  PrevDepth2Bot := ZQuery1DEPTH_BOT.Value;
end;

procedure TBHConstrForm.ZQuery1NewRecord(DataSet: TDataSet);
begin
  inherited;
  if PrevRepInst = '' then
    ZQuery1REP_INST.Value := DataModuleMain.BasicinfQueryREP_INST.Value
  else
    ZQuery1REP_INST.Value := PrevRepInst;
  if PrevDate = '' then
  begin
    if DataModuleMain.BasicinfQueryDATE_COMPL.Value = '' then
      ZQuery1DATE_CONST.Value := FormatDateTime('YYYYMMDD', Date)
    else
      ZQuery1DATE_CONST.Value := DataModuleMain.BasicinfQueryDATE_COMPL.Value;
  end
  else
    ZQuery1DATE_CONST.Value := PrevDate;
  ZQuery1DEPTH_TOP.Value := PrevDepth2Bot;
  ZQuery1DEPTH_BOT.Value := PrevDepth2Bot + 1;
end;

procedure TBHConstrForm.ZQuery2AfterPost(DataSet: TDataSet);
begin
  inherited;
  GraphSpeedButton.Enabled := ZQuery2.RecordCount > 0;
  if ZQuery1.RecordCount = 0 then
    ShowMessage('You have entered Casing information but there is no Hole information, which makes no sense!');
end;

procedure TBHConstrForm.ZQuery2BeforeInsert(DataSet: TDataSet);
begin
  PrevRepInst := ZQuery2REP_INST.Value;
  PrevDate := ZQuery2DATE_INST.Value;
  PrevMaterial := ZQuery2MATERIAL.Value;
  PrevDepth2Bot := ZQuery2DEPTH_BOT.Value;
end;

procedure TBHConstrForm.ZQuery2NewRecord(DataSet: TDataSet);
var
  ColHi: Real;
begin
  inherited;
  if PrevRepInst = '' then
    ZQuery2REP_INST.Value := DataModuleMain.BasicinfQueryREP_INST.Value
  else
    ZQuery2REP_INST.Value := PrevRepInst;
  if PrevDate = '' then
  begin
    if ZQuery1.RecordCount > 0 then ZQuery2DATE_INST.Value := ZQuery1DATE_CONST.Value
    else
      ZQuery2DATE_INST.Value := FormatDateTime('YYYYMMDD', Date)
  end
  else
    ZQuery2DATE_INST.Value := PrevDate;
  //check if collar height is available
  ColHi := 0;
  with DataModuleMain.CheckQuery do
  begin
    Connection := DataModuleMain.ZConnectionDB;
    SQL.Clear;
    SQL.Add('SELECT SITE_ID_NR, DATE_CONST, COLLAR_HI FROM constrct ');
    SQL.Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite) + ' AND DATE_CONST = ' + QuotedStr(ZQuery2DATE_INST.Value));
    Open;
    if (RecordCount > 0) and (not FieldByName('COLLAR_HI').IsNull) then
      ColHi := FieldByName('COLLAR_HI').AsFloat
    else
    if not DataModuleMain.BasicinfQueryCOLLAR_HI.IsNull then
      ColHi := DataModuleMain.BasicinfQueryCOLLAR_HI.AsFloat;
    Close;
    SQL.Clear;
  end;
  if ColHi <> 0 then
    ZQuery2DEPTH_TOP.AsFloat := - ColHi
  else
    ZQuery2DEPTH_TOP.Value := 0;
  ZQuery2DEPTH_BOT.Value := PrevDepth2Bot + 1;
  ZQuery2OPEN_TYPE.Value := 'N';
end;

procedure TBHConstrForm.ZQuery3BeforeInsert(DataSet: TDataSet);
begin
  PrevDate := ZQuery3DATE_CONST.Value;
  PrevMaterial := ZQuery3MATERIAL.Value;
  PrevDepth2Bot := ZQuery3DEPTH_BOT.Value;
  if ZQuery3PIEZO_NR.IsNull then
    PrevPiez := - 1
  else
    PrevPiez := ZQuery3PIEZO_NR.Value;
end;

procedure TBHConstrForm.ZQuery3NewRecord(DataSet: TDataSet);
begin
  inherited;
  if PrevDate = '' then
    ZQuery3DATE_CONST.Value := FormatDateTime('YYYYMMDD', Date)
  else
    ZQuery3DATE_CONST.Value := PrevDate;
  ZQuery3DEPTH_TOP.Value := PrevDepth2Bot;
  ZQuery3DEPTH_BOT.Value := PrevDepth2Bot + 1;
  ZQuery3PIEZO_NR.Value := PrevPiez + 1;
end;

procedure TBHConstrForm.ZQuery3PIEZO_NRValidate(Sender: TField);
begin
  if (ZQuery3PIEZO_NR.Value >= 0) and
     (ZQuery3PIEZO_NR.Value <= 9) then
    ValidFound := True
  else
    ValidFound := False;
end;

procedure TBHConstrForm.ZQuery4BeforeInsert(DataSet: TDataSet);
begin
  PrevDate := ZQuery4DATE_CONST.Value;
  PrevDepth2Bot := ZQuery4DEPTH_BOT.Value;
end;

procedure TBHConstrForm.ZQuery4FILL_TYPEValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('FILLTYPE', Sender.AsString);
end;

procedure TBHConstrForm.ZQuery4INDIAMValidate(Sender: TField);
begin
  ValidFound := Sender.AsFloat < ZQuery4OUTDIAM.AsFloat;
end;

procedure TBHConstrForm.ZQuery4NewRecord(DataSet: TDataSet);
begin
  inherited;
  if PrevDate = '' then
  begin
    if ZQuery1.RecordCount > 0 then
      ZQuery4DATE_CONST.Value := ZQuery1DATE_CONST.Value
    else
      ZQuery4DATE_CONST.Value := FormatDateTime('YYYYMMDD', Date);
  end
  else
    ZQuery4DATE_CONST.Value := PrevDate;
  ZQuery4DEPTH_TOP.Value := PrevDepth2Bot;
  ZQuery4DEPTH_BOT.Value := PrevDepth2Bot + 1;
end;

procedure TBHConstrForm.ZQuery4OUTDIAMValidate(Sender: TField);
begin
  ValidFound := Sender.Value >= ZQuery4INDIAM.Value;
end;

end.
