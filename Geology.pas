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
unit Geology;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLtype, DBCtrls, Db,
  Menus, ExtCtrls, Buttons, StdCtrls, DBGrids, MaskEdit, MastDetl;

type

  { TGeologyForm }

  TGeologyForm = class(TMasterDetailForm)
    AMSLCheckBox: TCheckBox;
    GrainCheckBox: TCheckBox;
    DBMemo1: TDBMemo;
    LinkedQueryBOULDERS: TLongintField;
    LinkedQueryCLAY: TLongintField;
    LinkedQueryCOBBLY: TLongintField;
    LinkedQueryDATE_ENTRY: TStringField;
    LinkedQueryDEPTH_BOT: TFloatField;
    LinkedQueryDEPTH_TOP: TFloatField;
    LinkedQueryFEATR_ATTR: TStringField;
    LinkedQueryGRANULAR: TLongintField;
    LinkedQueryINFO_SOURC: TStringField;
    LinkedQueryLITH_CODE: TStringField;
    LinkedQueryNOTES_YN: TStringField;
    LinkedQueryNOTE_PAD: TBlobField;
    LinkedQueryPEBBLY: TLongintField;
    LinkedQueryPRIM_COLOR: TStringField;
    LinkedQueryPRIM_FEATR: TStringField;
    LinkedQueryROUNDNESS: TStringField;
    LinkedQuerySAND_COARS: TLongintField;
    LinkedQuerySAND_FINE: TLongintField;
    LinkedQuerySAND_MEDIU: TLongintField;
    LinkedQuerySECO_COLOR: TStringField;
    LinkedQuerySECO_FEATR: TStringField;
    LinkedQuerySILT_COARS: TLongintField;
    LinkedQuerySILT_FINE: TLongintField;
    LinkedQuerySILT_MEDIU: TLongintField;
    LinkedQuerySORTING: TStringField;
    LinkedQueryTEXTURE: TStringField;
    LinkedQueryUNIT_NAME: TStringField;
    Splitter1: TSplitter;
    procedure AMSLCheckBoxClick(Sender: TObject);
    procedure BasicinfDataSourceDataChange(Sender: TObject; Field: TField);
    procedure ChartSpeedButtonClick(Sender: TObject);
    procedure DBMemo1Enter(Sender: TObject);
    procedure DBMemo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure LinkedDataSourceDataChange(Sender: TObject; Field: TField);
    procedure LinkedQueryBeforeInsert(DataSet: TDataSet);
    procedure LinkedQueryBeforePost(DataSet: TDataSet);
    procedure LinkedQueryDEPTHGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryDEPTHSetText(Sender: TField; const aText: string);
    procedure LinkedQueryDEPTH_BOTValidate(Sender: TField);
    procedure LinkedQueryDEPTH_TOPValidate(Sender: TField);
    procedure LinkedQueryValidate(Sender: TField);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQuerySetText(Sender: TField; const aText: string);
    procedure LinkedQueryUpperSetText(Sender: TField; const aText: string);
    procedure FormActivate(Sender: TObject);
    procedure GrainCheckBoxClick(Sender: TObject);
  private
    { Private declarations }
    PrevDate, PrevInfoSource: ShortString;
    PrevDepth2Bot: Real;
  public
    { Public declarations }
  end;

var
  GeologyForm: TGeologyForm;

implementation

uses VARINIT, MainDataModule, GeollogSetForm;

{$R *.lfm}

procedure TGeologyForm.AMSLCheckBoxClick(Sender: TObject);
begin
  inherited;
  LinkedQuery.Refresh;
end;

procedure TGeologyForm.BasicinfDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  DBGrid.Enabled := (DataModuleMain.BasicinfQuerySITE_TYPE.AsString = 'B')
    or (DataModuleMain.BasicinfQuerySITE_TYPE.AsString = 'D')
    or (DataModuleMain.BasicinfQuerySITE_TYPE.AsString = 'M')
    or (DataModuleMain.BasicinfQuerySITE_TYPE.AsString = 'W');
  LinkedLabel.Enabled := DBGrid.Enabled;
  DetailNavigator.Enabled := DBGrid.Enabled;
end;

procedure TGeologyForm.ChartSpeedButtonClick(Sender: TObject);
begin
  with TGeollogSettingsForm.Create(Application) do
  begin
    PageControl1.ActivePage := LogTab;
    ShowModal;
  end;
end;

procedure TGeologyForm.DBMemo1Enter(Sender: TObject);
begin
  Editing := EditLabel + ' ' + Caption;
  TheActiveDBEdit := NIL;
  TheActiveRxDB := NIL;
  TheActiveDBMemo := DBMemo1;
end;

procedure TGeologyForm.DBMemo1KeyDown(Sender: TObject; var Key: Word;
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

procedure TGeologyForm.FormCreate(Sender: TObject);
begin
  inherited;
  DBGrid.BorderSpacing.Bottom := 0;
  NotAllFields := True;
end;

procedure TGeologyForm.LinkedDataSourceDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  DBMemo1.Enabled := LinkedQuerySITE_ID_NR.Value > '';
end;

procedure TGeologyForm.LinkedQueryBeforeInsert(DataSet: TDataSet);
begin
  PrevDate := LinkedQueryDATE_ENTRY.Value;
  PrevInfoSource := LinkedQueryINFO_SOURC.Value;
  PrevDepth2Bot := LinkedQueryDEPTH_BOT.Value;
end;

procedure TGeologyForm.LinkedQueryBeforePost(DataSet: TDataSet);
begin
  inherited;
  if LinkedQuery.FieldByName('NOTE_PAD').Value = '' then LinkedQuery.FieldByName('NOTES_YN').Value := 'N'
  else
    LinkedQuery.FieldByName('NOTES_YN').Value := 'Y';
end;

procedure TGeologyForm.LinkedQueryDEPTHGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if AMSLCheckBox.Checked then
    Elevation := DataModuleMain.BasicinfQueryALTITUDE.Value
  else
    Elevation := 2 * Sender.AsFloat;
  if Sender.AsString <> '' then
    aText := FloatToStrF((Elevation - Sender.AsFloat) * LengthFactor, ffFixed, 15, 2);
end;

procedure TGeologyForm.LinkedQueryDEPTHSetText(Sender: TField;
  const aText: string);
begin
  if AMSLCheckBox.Checked then
    Elevation := DataModuleMain.BasicinfQueryALTITUDE.Value
  else
  if aText <> '' then
    Elevation := 2 * StrToFloat(aText);
  if aText <> '' then
    Sender.Value := (Elevation - StrToFloat(aText))/LengthFactor;
end;

procedure TGeologyForm.LinkedQueryDEPTH_BOTValidate(Sender: TField);
begin
  if Sender.Value <= LinkedQueryDEPTH_TOP.Value then ValidFound := False
  else ValidFound := True;
end;

procedure TGeologyForm.LinkedQueryDEPTH_TOPValidate(Sender: TField);
begin
  if not Sender.Dataset.FieldByName('DEPTH_BOT').IsNull then
    ValidFound := Sender.Value <= Sender.Dataset.FieldByName('DEPTH_BOT').Value;
end;

procedure TGeologyForm.LinkedQueryValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound(Sender.LookupKeyFields, Sender.AsString);
end;

procedure TGeologyForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  LinkedQueryDATE_ENTRY.ReadOnly := False;
  LinkedQueryDATE_ENTRY.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryDATE_ENTRY.ReadOnly := True;
  LinkedQueryINFO_SOURC.Value := PrevInfoSource;
  LinkedQueryDEPTH_TOP.Value := PrevDepth2Bot;
  LinkedQueryDEPTH_BOT.Value := PrevDepth2Bot + 1;
end;

procedure TGeologyForm.LinkedQuerySetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := aText;
end;

procedure TGeologyForm.LinkedQueryUpperSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TGeologyForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption + ' - Depth [' + LengthUnit + ']';
end;

procedure TGeologyForm.GrainCheckBoxClick(Sender: TObject);
var
  f: Byte;
begin
  inherited;
  for f := 17 to LinkedQuery.FieldCount - 1 do //don't show NOTES_YN and NOTE_PAD
    LinkedQuery.Fields[f].Visible := GrainCheckbox.Checked;
  NotAllFields := not GrainCheckBox.Checked;
end;

end.
