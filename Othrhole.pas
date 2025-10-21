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
unit Othrhole;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ZDataset,
  MastDetl, Menus, Db, DBCtrls, ExtCtrls, Buttons, LCLtype, StdCtrls,
  DBGrids;

type

  { TOtherHoleForm }

  TOtherHoleForm = class(TMasterDetailForm)
    AllsitesQuerySITE_ID_NR: TStringField;
    LinkedQueryCOMMENT: TStringField;
    LinkedQueryDATE_END: TStringField;
    LinkedQueryDATE_ENTRY: TStringField;
    LinkedQueryDATE_START: TStringField;
    LinkedQueryOTHER_HOLE: TStringField;
    LinkedQueryREP_INST: TStringField;
    LinkedQuerySOURCE: TStringField;
    LinkedQueryTYPE_MEAS: TStringField;
    LinkedQueryUNIT_MEAS: TStringField;
    AllsitesQuery: TZReadOnlyQuery;
    procedure LinkedQueryBeforeInsert(DataSet: TDataSet);
    procedure LinkedQueryCOMMENTSetText(Sender: TField; const aText: string);
    procedure LinkedQueryDATE_ENDValidate(Sender: TField);
    procedure LinkedQueryDATE_STARTValidate(Sender: TField);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryOTHER_HOLEValidate(Sender: TField);
    procedure LinkedQueryValidate(Sender: TField);
    procedure LinkedQueryUpperSetText(Sender: TField; const aText: string);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OtherHoleForm: TOtherHoleForm;

implementation

uses varinit, strdatetime, MainDataModule;

var
  PrevInfoSource, PrevRepInst, PrevType, PrevUnit: ShortString;

{$R *.lfm}


procedure TOtherHoleForm.LinkedQueryBeforeInsert(DataSet: TDataSet);
begin
  PrevRepInst := LinkedQueryREP_INST.Value;
  PrevInfoSource := LinkedQuerySOURCE.Value;
  PrevType := LinkedQueryTYPE_MEAS.Value;
  PrevUnit := LinkedQueryUNIT_MEAS.Value;
end;

procedure TOtherHoleForm.LinkedQueryCOMMENTSetText(Sender: TField;
  const aText: string);
begin
  if AllowSmallChars then
    Sender.Value := aText
  else
    Sender.Value := UpperCase(aText);
end;

procedure TOtherHoleForm.LinkedQueryDATE_ENDValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TOtherHoleForm.LinkedQueryDATE_STARTValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TOtherHoleForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  LinkedQueryREP_INST.Value := PrevRepInst;
  LinkedQuerySOURCE.Value := PrevInfoSource;
  LinkedQueryDATE_ENTRY.ReadOnly := False;
  LinkedQueryDATE_ENTRY.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryDATE_ENTRY.ReadOnly := True;
  LinkedQueryDATE_START.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryDATE_END.Value := FormatDateTime('YYYYMMDD', Date);
end;

procedure TOtherHoleForm.LinkedQueryOTHER_HOLEValidate(Sender: TField);
begin
  AllsitesQuery.Open;
  ValidFound := (LinkedQueryOTHER_HOLE.AsString = '') or
    (AllsitesQuery.Locate('SITE_ID_NR', LinkedQueryOTHER_HOLE.AsString, []));
  AllsitesQuery.Close;
end;

procedure TOtherHoleForm.LinkedQueryValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound(Sender.LookupKeyFields, Sender.AsString);
end;

procedure TOtherHoleForm.LinkedQueryUpperSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TOtherHoleForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption;
end;

end.
