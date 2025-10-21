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
unit Recommnd;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLtype, Db, Menus,
  StdCtrls, DBCtrls, ExtCtrls, Buttons, DBGrids, MaskEdit, MastDetl;

type

  { TRecommendForm }

  TRecommendForm = class(TMasterDetailForm)
    AMSLCheckBox: TCheckBox;
    DBMemo1: TDBMemo;
    LinkedQueryCRIT_WLEV: TFloatField;
    LinkedQueryDATE_REC: TStringField;
    LinkedQueryDEPTH_INTK: TFloatField;
    LinkedQueryDISCH_RATE: TFloatField;
    LinkedQueryDUTY_CYCLE: TFloatField;
    LinkedQueryDYN_WLEV: TFloatField;
    LinkedQueryNOTES_YN: TStringField;
    LinkedQueryNOTE_PAD: TWideStringField;
    LinkedQueryPRIORITY: TLongintField;
    LinkedQueryREC_EQUIPM: TStringField;
    LinkedQueryREP_INST: TStringField;
    LinkedQueryTYPE_POWER: TStringField;
    LinkedQueryWATER_QUAL: TStringField;
    Splitter1: TSplitter;
    procedure DBMemo1Enter(Sender: TObject);
    procedure DBMemo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormCreate(Sender: TObject);
    procedure LinkedDataSourceDataChange(Sender: TObject; Field: TField);
    procedure LinkedQueryBeforeInsert(DataSet: TDataSet);
    procedure LinkedQueryBeforePost(DataSet: TDataSet);
    procedure LinkedQueryDATE_RECSetText(Sender: TField; const aText: string);
    procedure LinkedQueryDATE_RECValidate(Sender: TField);
    procedure LinkedQueryDEPTH_INTKGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryDEPTH_INTKSetText(Sender: TField; const aText: string);
    procedure LinkedQueryDISCH_RATEGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryDISCH_RATESetText(Sender: TField; const aText: string);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryWLEVSetText(Sender: TField; const aText: string);
    procedure LinkedQueryWLEVGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryValidate(Sender: TField);
    procedure LinkedQueryUpperSetText(Sender: TField; const aText: string);
    procedure AMSLCheckBoxClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RecommendForm: TRecommendForm;

implementation

uses VARINIT, strdatetime, MainDataModule;

{$R *.lfm}

var
  PrevDate, PrevInst: String;
  PrevPriority: ShortInt;

procedure TRecommendForm.FormCreate(Sender: TObject);
begin
  inherited;
  DBGrid.BorderSpacing.Bottom := 0;
end;

procedure TRecommendForm.LinkedDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  DBMemo1.Enabled := LinkedQuerySITE_ID_NR.Value > '';
end;

procedure TRecommendForm.LinkedQueryBeforeInsert(DataSet: TDataSet);
begin
  PrevInst := LinkedQueryREP_INST.Value;
  PrevPriority := LinkedQueryPRIORITY.Value;
  PrevDate := LinkedQueryDATE_REC.Value;
end;

procedure TRecommendForm.LinkedQueryBeforePost(DataSet: TDataSet);
begin
  inherited;
  if LinkedQueryNOTE_PAD.Value = '' then LinkedQueryNOTES_YN.Value := 'N'
  else LinkedQueryNOTES_YN.Value := 'Y';
end;

procedure TRecommendForm.LinkedQueryDATE_RECSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := aText;
end;

procedure TRecommendForm.LinkedQueryDATE_RECValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TRecommendForm.LinkedQueryDEPTH_INTKGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
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

procedure TRecommendForm.LinkedQueryDEPTH_INTKSetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
    Sender.AsFloat := StrToFloat(aText)/LengthFactor;
end;

procedure TRecommendForm.LinkedQueryDISCH_RATEGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
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

procedure TRecommendForm.LinkedQueryDISCH_RATESetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
    Sender.AsFloat := StrToFloat(aText)/VolumeFactor/TimeFactor;
end;

procedure TRecommendForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  if PrevInst = '' then
    LinkedQueryREP_INST.Value := DataModuleMain.BasicinfQueryREP_INST.Value
  else
    LinkedQueryREP_INST.Value := PrevInst;
  LinkedQueryPRIORITY.Value := PrevPriority + 1;
  if PrevDate = '' then
    LinkedQueryDATE_REC.Value := FormatDateTime('YYYYMMDD', Date)
  else
    LinkedQueryDATE_REC.Value := PrevDate;
  LinkedQueryNOTES_YN.Value := 'N';
end;

procedure TRecommendForm.LinkedQueryWLEVSetText(Sender: TField;
  const aText: string);
begin
  if AMSLCheckBox.Checked then
    Elevation := DataModuleMain.BasicinfQueryALTITUDE.Value + DataModuleMain.BasicinfQueryCOLLAR_HI.Value
  else
  if aText <> '' then
    Elevation := 2 * StrToFloat(aText);
  if aText <> '' then
    Sender.AsFloat := (Elevation - StrToFloat(aText))/LengthFactor;
end;

procedure TRecommendForm.LinkedQueryWLEVGetText(Sender: TField;
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
    if (Elevation - Sender.AsFloat) * LengthFactor > 10000 then
      aText := FloatToStrF((Elevation - Sender.AsFloat) * LengthFactor, ffFixed, 15, 0)
    else
    if (Elevation - Sender.AsFloat) * LengthFactor < 0.01 then
      aText := FloatToStrF((Elevation - Sender.AsFloat) * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF((Elevation - Sender.AsFloat) * LengthFactor, ffFixed, 15, 2);
  end;
end;

procedure TRecommendForm.LinkedQueryValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound(Sender.LookupKeyFields, Sender.AsString);
end;

procedure TRecommendForm.LinkedQueryUpperSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := Uppercase(aText);
end;

procedure TRecommendForm.DBMemo1Enter(Sender: TObject);
begin
  Editing := 'Editing: ' + Caption;
  TheActiveDBEdit := NIL;
  TheActiveRxDB := NIL;
  TheActiveDBMemo := DBMemo1;
end;

procedure TRecommendForm.DBMemo1KeyDown(Sender: TObject; var Key: Word;
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

procedure TRecommendForm.AMSLCheckBoxClick(Sender: TObject);
begin
  inherited;
  LinkedQuery.Refresh;
end;

procedure TRecommendForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption + ' - Depth, Water lev. [' + LengthUnit + '], Dis. rate [' + Disunit + '], Duty cycle [h/d]';
  LinkedLabel.Width := 480;
end;

end.
