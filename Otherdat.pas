{ Copyright (C) 2021 Immo Blecher, immo@blecher.co.za

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
unit Otherdat;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MastDetl, Menus, Db,
  DBCtrls, ExtCtrls, Buttons, StdCtrls, DBGrids;

type

  { TOtherDataForm }

  TOtherDataForm = class(TMasterDetailForm)
    LinkedQueryDATA_TYPE: TStringField;
    LinkedQueryFORMAT: TStringField;
    LinkedQueryLOCATION: TStringField;
    LinkedQueryLOGG_TYPE: TStringField;
    LinkedTableDATA_TYPE: TStringField;
    LinkedTableLOGG_TYPE: TStringField;
    LinkedTableLOCATION: TStringField;
    LinkedTableFORMAT: TStringField;
    procedure LinkedQueryDATA_TYPESetText(Sender: TField; const aText: string);
    procedure FormActivate(Sender: TObject);
    procedure LinkedQueryFORMATSetText(Sender: TField; const aText: string);
    procedure LinkedQueryLOCATIONSetText(Sender: TField; const aText: string);
    procedure LinkedQueryLOGG_TYPESetText(Sender: TField; const aText: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OtherDataForm: TOtherDataForm;

implementation

uses VARINIT;

{$R *.lfm}

procedure TOtherDataForm.LinkedQueryDATA_TYPESetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TOtherDataForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption;
end;

procedure TOtherDataForm.LinkedQueryFORMATSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TOtherDataForm.LinkedQueryLOCATIONSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TOtherDataForm.LinkedQueryLOGG_TYPESetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

end.
