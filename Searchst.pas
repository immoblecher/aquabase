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
unit Searchst;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MastDetl,
  Menus, Db, DBCtrls, ExtCtrls, Buttons, StdCtrls, DBGrids, ZDataset;

type

  { TSearchStatusForm }

  TSearchStatusForm = class(TMasterDetailForm)
    LinkedQueryDATE_ENTRY: TStringField;
    LinkedQueryREP_INST: TStringField;
    LinkedQueryTYPE_PERIO: TStringField;
    procedure LinkedQueryBeforeInsert(DataSet: TDataSet);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryREP_INSTValidate(Sender: TField);
    procedure LinkedQueryUpperSetText(Sender: TField; const aText: string);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SearchStatusForm: TSearchStatusForm;

implementation

uses varinit, MainDataModule;

var
  PrevRepInst: ShortString;

{$R *.lfm}


procedure TSearchStatusForm.LinkedQueryBeforeInsert(DataSet: TDataSet);
begin
  PrevRepInst := LinkedQueryREP_INST.Value;
end;

procedure TSearchStatusForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  LinkedQueryDATE_ENTRY.ReadOnly := False;
  LinkedQueryDATE_ENTRY.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryDATE_ENTRY.ReadOnly := True;
  LinkedQueryREP_INST.Value := PrevRepInst;
end;

procedure TSearchStatusForm.LinkedQueryREP_INSTValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('REP_INST', Sender.AsString);
end;

procedure TSearchStatusForm.LinkedQueryUpperSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TSearchStatusForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption;
end;

end.
