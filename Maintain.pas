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
unit Maintain;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLtype, MastDetl, Db,
  Menus, DBCtrls, ExtCtrls, Buttons;

type

  { TMaintainForm }

  TMaintainForm = class(TMasterDetailForm)
    LinkedQueryCOMMENT: TStringField;
    LinkedQueryCOND_ENCL: TStringField;
    LinkedQueryCOND_ENGIN: TStringField;
    LinkedQueryCOND_PUMP: TStringField;
    LinkedQueryCOND_RESVR: TStringField;
    LinkedQueryCOND_RISER: TStringField;
    LinkedQueryCOST_MAINT: TFloatField;
    LinkedQueryC_CURRENCY: TStringField;
    LinkedQueryDATE_ENTRY: TStringField;
    LinkedQueryDATE_VISIT: TStringField;
    LinkedQueryINFO_SOURC: TStringField;
    LinkedQueryMAINTAINED: TStringField;
    LinkedQueryREP_INST: TStringField;
    procedure FormActivate(Sender: TObject);
    procedure LinkedQueryCOMMENTSetText(Sender: TField; const aText: string);
    procedure LinkedQueryDATE_VISITValidate(Sender: TField);
    procedure LinkedQueryMAINTAINEDValidate(Sender: TField);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryValidate(Sender: TField);
    procedure LinkedQueryUpperSetText(Sender: TField; const aText: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MaintainForm: TMaintainForm;

implementation

uses Strdatetime, varinit, MainDataModule;

{$R *.lfm}

procedure TMaintainForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption;
end;

procedure TMaintainForm.LinkedQueryCOMMENTSetText(Sender: TField;
  const aText: string);
begin
  if AllowSmallChars then
    Sender.Value := aText
  else
    Sender.Value := UpperCase(aText);
end;

procedure TMaintainForm.LinkedQueryDATE_VISITValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TMaintainForm.LinkedQueryMAINTAINEDValidate(Sender: TField);
begin
  ValidFound := (Sender.AsString = 'T') or (Sender.AsString = 'F');
end;

procedure TMaintainForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  LinkedQueryDATE_ENTRY.ReadOnly := False;
  LinkedQueryDATE_ENTRY.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryDATE_ENTRY.ReadOnly := True;
  LinkedQueryDATE_VISIT.Value := FormatDateTime('YYYYMMDD', Date);
end;

procedure TMaintainForm.LinkedQueryValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound(Sender.LookupKeyFields, Sender.AsString);
end;

procedure TMaintainForm.LinkedQueryUpperSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

end.
