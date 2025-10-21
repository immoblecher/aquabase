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
unit INSTALLA;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MastDetl,
  Menus, Db, DBCtrls, ExtCtrls, Buttons;

type

  { TInstallForm }

  TInstallForm = class(TMasterDetailForm)
    LinkedQueryCOMMENT: TStringField;
    LinkedQueryDATE_ENTRY: TStringField;
    LinkedQueryDATE_INSTL: TStringField;
    LinkedQueryDEPTH_INTK: TFloatField;
    LinkedQueryINFO_SOURC: TStringField;
    LinkedQueryMANUFACTUR: TStringField;
    LinkedQueryMONIT_FACI: TStringField;
    LinkedQueryPOWER_METR: TStringField;
    LinkedQueryPOWER_RATG: TFloatField;
    LinkedQueryREP_INST: TStringField;
    LinkedQueryRESER_TYPE: TStringField;
    LinkedQuerySERIAL_NR: TStringField;
    LinkedQuerySIZE_RESER: TFloatField;
    LinkedQueryTYPE_INSTL: TStringField;
    LinkedQueryTYPE_POWER: TStringField;
    BasicinfTableEQUIPMENT: TStringField;
    procedure FormActivate(Sender: TObject);
    procedure LinkedQueryAfterDelete(DataSet: TDataSet);
    procedure LinkedQueryAfterPost(DataSet: TDataSet);
    procedure LinkedQueryBeforeInsert(DataSet: TDataSet);
    procedure LinkedQueryBeforeOpen(DataSet: TDataSet);
    procedure LinkedQueryCOMMENTSetText(Sender: TField; const aText: string);
    procedure LinkedQueryDATE_INSTLValidate(Sender: TField);
    procedure LinkedQueryDEPTH_INTKGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryDEPTH_INTKSetText(Sender: TField; const aText: string);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryValidate(Sender: TField);
    procedure LinkedQuerySIZE_RESERGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQuerySIZE_RESERSetText(Sender: TField; const aText: string);
    procedure LinkedQueryUpperSetText(Sender: TField; const aText: string);
  private
    { Private declarations }
    EquipmChanged: Boolean;
  public
    { Public declarations }
  end;

var
  InstallForm: TInstallForm;

implementation

uses strdatetime, VARINIT, MainDataModule;

{$R *.lfm}

var
  PrevInfoSource, PrevRepInst: String;

procedure TInstallForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption + ' - Depth [' + LengthUnit + ']; volume ['
    + VolumeUnit + ']';
  LinkedLabel.Width := 480;
end;

procedure TInstallForm.LinkedQueryAfterDelete(DataSet: TDataSet);
begin
  if MessageDlg('Do you want to update the latest equipment in Basic Information too?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    LinkedQuery.Last;
    DataModuleMain.BasicinfQuery.Edit;
    DataModuleMain.BasicinfQueryEQUIPMENT.Value := LinkedQueryTYPE_INSTL.Value;
    DataModuleMain.BasicinfQuery.Post;
  end;
end;

procedure TInstallForm.LinkedQueryAfterPost(DataSet: TDataSet);
begin
  inherited;
  if EquipmChanged then
  if MessageDlg('Do you want to update the latest equipment in Basic Information too?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    LinkedQuery.Last;
    DataModuleMain.BasicinfQuery.Edit;
    DataModuleMain.BasicinfQueryEQUIPMENT.Value := LinkedQueryTYPE_INSTL.Value;
    DataModuleMain.BasicinfQuery.Post;
  end;
  EquipmChanged := False;
end;

procedure TInstallForm.LinkedQueryBeforeInsert(DataSet: TDataSet);
begin
  PrevInfoSource := LinkedQueryINFO_SOURC.Value;
  PrevRepInst := LinkedQueryREP_INST.Value;
end;

procedure TInstallForm.LinkedQueryBeforeOpen(DataSet: TDataSet);
begin
  LinkedQuery.SQL.Clear;
  LinkedQuery.SQL.Add('SELECT * FROM installa WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
end;

procedure TInstallForm.LinkedQueryCOMMENTSetText(Sender: TField;
  const aText: string);
begin
  if AllowSmallChars then
    Sender.Value := aText
  else
    Sender.Value := UpperCase(aText);
end;

procedure TInstallForm.LinkedQueryDATE_INSTLValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TInstallForm.LinkedQueryDEPTH_INTKGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if Sender.AsFloat * LengthFactor > 1000 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 1)
    else
    if Sender.AsFloat * LengthFactor < 0.1 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end;
end;

procedure TInstallForm.LinkedQueryDEPTH_INTKSetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
    LinkedQueryDEPTH_INTK.Value := StrToFloat(aText)/LengthFactor;
end;

procedure TInstallForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  if PrevRepInst = '' then
    LinkedQueryREP_INST.Value := DataModuleMain.BasicinfQueryREP_INST.Value
  else
    LinkedQueryREP_INST.Value := PrevRepInst;
  LinkedQueryDATE_ENTRY.ReadOnly := False;
  LinkedQueryDATE_ENTRY.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryDATE_ENTRY.ReadOnly := True;
  LinkedQueryDATE_INSTL.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryINFO_SOURC.Value := PrevInfoSource;
end;

procedure TInstallForm.LinkedQueryValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound(Sender.LookupKeyFields, Sender.AsString);
end;

procedure TInstallForm.LinkedQuerySIZE_RESERGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if Sender.AsFloat * VolumeFactor > 100 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor, ffFixed, 15, 0)
    else
    if Sender.AsFloat * VolumeFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor, ffFixed, 15, 2);
  end;
end;

procedure TInstallForm.LinkedQuerySIZE_RESERSetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
    Sender.AsFloat := StrToFloat(aText)/VolumeFactor;
end;

procedure TInstallForm.LinkedQueryUpperSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
  EquipmChanged := True;
end;

end.
