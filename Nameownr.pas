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
unit Nameownr;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MastDetl, Menus, Db,
  DBCtrls, ExtCtrls, Buttons, StdCtrls, DBGrids;

type

  { TNameOwnerForm }

  TNameOwnerForm = class(TMasterDetailForm)
    LinkedQueryADDRESS_1: TStringField;
    LinkedQueryADDRESS_2: TStringField;
    LinkedQueryADDRESS_3: TStringField;
    LinkedQueryADDRESS_4: TStringField;
    LinkedQueryALTTELF: TStringField;
    LinkedQueryCNTCTPER: TStringField;
    LinkedQueryDATE_FROM: TStringField;
    LinkedQueryDATE_TO: TStringField;
    LinkedQueryNAME_OWNER: TStringField;
    LinkedQueryTELEPHONE: TStringField;
    procedure FormActivate(Sender: TObject);
    procedure LinkedQueryADDRESS_4GetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryDATEValidate(Sender: TField);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryUpperSetText(Sender: TField; const aText: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NameOwnerForm: TNameOwnerForm;

implementation

uses VARINIT, strdatetime;

{$R *.lfm}

procedure TNameOwnerForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption;
end;

procedure TNameOwnerForm.LinkedQueryADDRESS_4GetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  if Pos('@', Sender.AsString) > 0 then
    aText := LowerCase(Sender.AsString)
  else
    aText := Sender.AsString;
end;

procedure TNameOwnerForm.LinkedQueryDATEValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TNameOwnerForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  LinkedQueryDATE_FROM.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryDATE_TO.Value := FormatDateTime('YYYYMMDD', Date);;
end;

procedure TNameOwnerForm.LinkedQueryUpperSetText(Sender: TField;
  const aText: string);
begin
  if AllowSmallChars then
    Sender.Value := aText
  else
    Sender.Value := UpperCase(aText);
end;

end.
