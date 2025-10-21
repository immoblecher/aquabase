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
unit sitelinkedreports;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DBGrids, DbCtrls, MaskEdit, Buttons, Menus, ZDataset, MastDetl, db;

type

  { TSiteReportDetailForm }

  TSiteReportDetailForm = class(TMasterDetailForm)
    LinkedQueryCOMMENTS: TStringField;
    LinkedQueryDATE_ENTRY: TStringField;
    LinkedQueryREPORT_NR: TStringField;
    LinkedQueryREP_INST: TStringField;
    PickListQuery: TZReadOnlyQuery;
    procedure FormActivate(Sender: TObject);
    procedure LinkedDataSourceDataChange(Sender: TObject; Field: TField);
    procedure LinkedQueryCOMMENTSSetText(Sender: TField; const aText: string);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryREPORT_NRSetText(Sender: TField; const aText: string);
    procedure LinkedQueryREPORT_NRValidate(Sender: TField);
    procedure LinkedQueryUpperSetText(Sender: TField; const aText: string);
  private

  public

  end;

var
  SiteReportDetailForm: TSiteReportDetailForm;

implementation

{$R *.lfm}

uses VARINIT;

{ TSiteReportDetailForm }

procedure TSiteReportDetailForm.LinkedDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if Field = NIL then
    CurrentRepNr := LinkedQueryREPORT_NR.AsString;
  DBGrid.Columns[2].PickList.Clear;
  with PickListQuery do
  begin
    Params[0].AsString := LinkedQueryREP_INST.AsString;
    Open;
    while not EOF do
    begin
      DBGrid.Columns[2].PickList.Add(Fields[0].AsString);
      Next;
    end;
    Close;
  end;
end;

procedure TSiteReportDetailForm.LinkedQueryCOMMENTSSetText(Sender: TField;
  const aText: string);
begin
  if AllowSmallChars then
    Sender.Value := aText
  else
    Sender.Value := UpperCase(aText);
end;

procedure TSiteReportDetailForm.FormActivate(Sender: TObject);
begin
  DBGrid.Columns[2].PickList.Clear;
  with PickListQuery do
  begin
  Params[0].AsString := LinkedQueryREP_INST.AsString;
    Open;
    while not EOF do
    begin
      DBGrid.Columns[2].PickList.Add(Fields[0].AsString);
      Next;
    end;
    Close;
  end;
end;

procedure TSiteReportDetailForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  LinkedQueryDATE_ENTRY.ReadOnly := False;
  LinkedQueryDATE_ENTRY.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryDATE_ENTRY.ReadOnly := True;
end;

procedure TSiteReportDetailForm.LinkedQueryREPORT_NRSetText(Sender: TField;
  const aText: string);
begin
  if AllowSmallChars then
    Sender.Value := aText
  else
    Sender.Value := UpperCase(aText);
end;

procedure TSiteReportDetailForm.LinkedQueryREPORT_NRValidate(Sender: TField);
begin
  if DBGrid.Columns[2].PickList.IndexOf(Sender.Value) = -1 then
    MessageDlg('The entered Report Number does not exist in the Report Documents table! You may want to change the number here or add it to the Report Documents table.', mtWarning, [mbOk], 0);
end;

procedure TSiteReportDetailForm.LinkedQueryUpperSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

end.

