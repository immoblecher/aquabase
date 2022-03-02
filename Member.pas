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
unit Member;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ZDataset, MastDetl,
  Menus, Db, DBCtrls, Grids, ExtCtrls, Buttons, StdCtrls, DBGrids, MaskEdit;

type

  { TMemberForm }

  TMemberForm = class(TMasterDetailForm)
    LinkedQueryCOMMENT: TStringField;
    LinkedQueryDATE_FROM: TStringField;
    LinkedQueryDATE_TO: TStringField;
    LinkedQueryDESCRIPTN: TStringField;
    LinkedQueryMEMBER_ID: TStringField;
    MemberListQuery: TZReadOnlyQuery;
    MemberListQueryDESCRIPTN: TStringField;
    MemberListQueryMEMBER_ID: TStringField;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure LinkedQueryAfterPost(DataSet: TDataSet);
    procedure LinkedQueryBeforeEdit(DataSet: TDataSet);
    procedure LinkedQueryDATEValidate(Sender: TField);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryUpperSetText(Sender: TField; const aText: string);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    MemberList, DescrList: TStringList;
  public
    { Public declarations }
  end;

var
  MemberForm: TMemberForm;

implementation

uses Strdatetime, varinit, MainDataModule;

{$R *.lfm}

procedure TMemberForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption;
end;

procedure TMemberForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  inherited;
  MemberList.Free;
  DescrList.Free;
end;

procedure TMemberForm.FormShow(Sender: TObject);
begin
  inherited;
  MemberListQuery.Open;
  while not MemberListQuery.EOF do
  begin
    MemberList.Add(MemberListQueryMEMBER_ID.Value);
    DescrList.Add(MemberListQueryDESCRIPTN.Value);
    MemberListQuery.Next;
  end;
  DBGrid.Columns[2].PickList.AddStrings(MemberList);
  DBGrid.Columns[3].PickList.AddStrings(DescrList);
  MemberListQuery.Close;
end;

procedure TMemberForm.LinkedQueryAfterPost(DataSet: TDataSet);
begin
  inherited;
  MemberList.Add(LinkedQueryMEMBER_ID.Value);
  DescrList.Add(LinkedQueryDESCRIPTN.Value);
  DBGrid.Columns[2].PickList.Clear;
  DBGrid.Columns[2].PickList.AddStrings(MemberList);
  DBGrid.Columns[3].PickList.Clear;
  DBGrid.Columns[3].PickList.AddStrings(DescrList);
end;

procedure TMemberForm.LinkedQueryBeforeEdit(DataSet: TDataSet);
begin
  DBGrid.Columns[2].PickList.Clear;
  DBGrid.Columns[2].PickList.AddStrings(MemberList);
  DBGrid.Columns[3].PickList.Clear;
  DBGrid.Columns[3].PickList.AddStrings(DescrList);
end;

procedure TMemberForm.LinkedQueryDATEValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TMemberForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  if DataModuleMain.BasicinfQueryDATE_COMPL.Value > '' then
    LinkedQueryDATE_FROM.Value := DataModuleMain.BasicinfQueryDATE_COMPL.Value
  else
    LinkedQueryDATE_FROM.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryDATE_TO.Value := FormatDateTime('YYYYMMDD', StringToDate(LinkedQueryDATE_FROM.Value) + 3652.5);
  DBGrid.Columns[2].PickList.Clear;
  DBGrid.Columns[2].PickList.AddStrings(MemberList);
  DBGrid.Columns[3].PickList.Clear;
  DBGrid.Columns[3].PickList.AddStrings(DescrList);
end;

procedure TMemberForm.LinkedQueryUpperSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TMemberForm.FormCreate(Sender: TObject);
begin
  inherited;
  MemberList := TStringList.Create;
  MemberList.Sorted := True;
  MemberList.Duplicates := dupIgnore;
  DescrList := TStringList.Create;
  DescrList.Sorted := True;
  DescrList.Duplicates := dupIgnore;
end;

end.
