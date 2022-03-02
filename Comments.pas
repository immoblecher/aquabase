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
unit Comments;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MastDetl, DBCtrls, Db,
  Menus, ExtCtrls, Buttons, StdCtrls, DBGrids, MaskEdit;

type

  { TCommentsForm }

  TCommentsForm = class(TMasterDetailForm)
    DBMemo1: TDBMemo;
    LinkedQueryDATE_ENTRY: TStringField;
    LinkedQueryNOTE_PAD: TBlobField;
    LinkedQueryREP_INST: TStringField;
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryREP_INSTSetText(Sender: TField; const aText: string);
    procedure DBMemoEnter(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure LinkedQueryREP_INSTValidate(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CommentsForm: TCommentsForm;

implementation

uses Varinit, MainDataModule;

{$R *.lfm}

procedure TCommentsForm.LinkedQueryREP_INSTSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TCommentsForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  LinkedQueryDATE_ENTRY.ReadOnly := False;
  LinkedQueryDATE_ENTRY.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryDATE_ENTRY.ReadOnly := True;
end;

procedure TCommentsForm.DBMemoEnter(Sender: TObject);
begin
  inherited;
  Editing := 'Editing: Comments';
end;

procedure TCommentsForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption;
end;

procedure TCommentsForm.LinkedQueryREP_INSTValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('REP_INST', Sender.AsString);
end;

end.
