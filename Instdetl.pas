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
unit Instdetl;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLtype,
  Menus, Db, DBCtrls, ExtCtrls, Buttons, ZDataset, MastDetl;

type

  { TAddinstallForm }

  TAddinstallForm = class(TMasterDetailForm)
    LinkedQueryCLAS_RISER: TStringField;
    LinkedQueryCOMMENT: TStringField;
    LinkedQueryCOST_EQUIP: TFloatField;
    LinkedQueryDATE_ENTRY: TStringField;
    LinkedQueryDATE_INSTL: TStringField;
    LinkedQueryDIAM_RISER: TFloatField;
    LinkedQueryE_MANUF: TStringField;
    LinkedQueryE_MODEL: TStringField;
    LinkedQueryE_PUL_DIAM: TFloatField;
    LinkedQueryE_SERIALNR: TStringField;
    LinkedQueryMAT_ENCL: TStringField;
    LinkedQueryP_PUL_DIAM: TFloatField;
    LinkedQueryP_RPM: TFloatField;
    LinkedQueryTYPE_ENCL: TStringField;
    LinkedQueryTYPE_RISER: TStringField;
    procedure FormActivate(Sender: TObject);
    procedure LinkedQueryCOMMENTSetText(Sender: TField; const aText: string);
    procedure LinkedQueryDATE_INSTLValidate(Sender: TField);
    procedure LinkedQueryDIAMGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryDIAMSetText(Sender: TField; const aText: string);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryValidate(Sender: TField);
    procedure LinkedQueryUpperSetText(Sender: TField; const aText: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddinstallForm: TAddinstallForm;

implementation

uses varinit, strdatetime, MainDataModule;

{$R *.lfm}

procedure TAddinstallForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption + ' - Diameter [' + DiamUnit + ']';
end;

procedure TAddinstallForm.LinkedQueryCOMMENTSetText(Sender: TField;
  const aText: string);
begin
  if AllowSmallChars then
    Sender.Value := aText
  else
    Sender.Value := UpperCase(aText);
end;

procedure TAddinstallForm.LinkedQueryDATE_INSTLValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TAddinstallForm.LinkedQueryDIAMGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.AsFloat > 0 then
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TAddinstallForm.LinkedQueryDIAMSetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
    Sender.AsFloat := StrToFloat(aText)/DiamFactor;
end;

procedure TAddinstallForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  LinkedQueryDATE_ENTRY.ReadOnly := False;
  LinkedQueryDATE_ENTRY.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryDATE_ENTRY.ReadOnly := True;
  LinkedQueryDATE_INSTL.Value := FormatDateTime('YYYYMMDD', Date);
end;

procedure TAddinstallForm.LinkedQueryValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound(Sender.LookupKeyFields, Sender.AsString);
end;

procedure TAddinstallForm.LinkedQueryUpperSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;


end.
