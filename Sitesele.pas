{ Copyright (C) 2024 Immo Blecher, immo@blecher.co.za

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
unit Sitesele;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLtype, MastDetl,
  Menus, Db, DBCtrls, ExtCtrls, Buttons, StdCtrls, DBGrids, MaskEdit;

type

  { TSiteSelectionForm }

  TSiteSelectionForm = class(TMasterDetailForm)
    DBMemo1: TDBMemo;
    LinkedQueryNOTE_PAD: TWideStringField;
    LinkedQueryREP_INST: TStringField;
    procedure FormActivate(Sender: TObject);
    procedure LinkedQueryREP_INSTSetText(Sender: TField; const aText: string);
    procedure LinkedQueryREP_INSTValidate(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SiteSelectionForm: TSiteSelectionForm;

implementation

uses varinit, MainDataModule;

{$R *.lfm}

procedure TSiteSelectionForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption;
end;

procedure TSiteSelectionForm.LinkedQueryREP_INSTSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TSiteSelectionForm.LinkedQueryREP_INSTValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('REP_INST', Sender.AsString);
end;

end.
