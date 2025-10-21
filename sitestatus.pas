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
unit sitestatus;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, DbCtrls, Buttons, Menus, StdCtrls, MaskEdit, MastDetl, db;

type

  { TSiteStatusForm }

  TSiteStatusForm = class(TMasterDetailForm)
    LinkedQueryCOMMENTS: TStringField;
    LinkedQueryDATE_ENTRY: TStringField;
    LinkedQueryDATE_UPDTD: TStringField;
    LinkedQuerySITE_STATU: TStringField;
    procedure LinkedQueryCOMMENTSSetText(Sender: TField; const aText: string);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQuerySITE_STATUSetText(Sender: TField; const aText: string);
    procedure LinkedQuerySITE_STATUValidate(Sender: TField);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  SiteStatusForm: TSiteStatusForm;

implementation

{$R *.lfm}

uses varinit, maindatamodule;

{ TSiteStatusForm }

procedure TSiteStatusForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  LinkedQueryDATE_ENTRY.ReadOnly := False;
  LinkedQueryDATE_ENTRY.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryDATE_ENTRY.ReadOnly := True;
  LinkedQueryDATE_UPDTD.Value := FormatDateTime('YYYYMMDD', Date);
end;

procedure TSiteStatusForm.LinkedQueryCOMMENTSSetText(Sender: TField;
  const aText: string);
begin
  if AllowSmallChars then
    Sender.Value := aText
  else
    Sender.Value := UpperCase(aText);
end;

procedure TSiteStatusForm.LinkedQuerySITE_STATUSetText(Sender: TField;
  const aText: string);
begin
  Sender.AsString := UpperCase(aText);
end;

procedure TSiteStatusForm.LinkedQuerySITE_STATUValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound(Sender.LookupKeyFields, Sender.AsString);
end;

end.

