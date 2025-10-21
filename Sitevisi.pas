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
unit Sitevisi;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MastDetl, Menus, Db,
  DBCtrls, ExtCtrls, Buttons;

type

  { TSiteVisitorForm }

  TSiteVisitorForm = class(TMasterDetailForm)
    LinkedQueryADDR1_VISI: TStringField;
    LinkedQueryADDR2_VISI: TStringField;
    LinkedQueryADDR3_VISI: TStringField;
    LinkedQueryADDR4_VISI: TStringField;
    LinkedQueryDATE_VISIT: TStringField;
    LinkedQueryNAME_VISIT: TStringField;
    LinkedQueryTELEPHONE: TStringField;
    procedure FormActivate(Sender: TObject);
    procedure LinkedQueryADDR4_VISIGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryDATE_VISITValidate(Sender: TField);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryUpperSetText(Sender: TField; const aText: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SiteVisitorForm: TSiteVisitorForm;

implementation

uses Strdatetime, varinit;

{$R *.lfm}

procedure TSiteVisitorForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption;
end;

procedure TSiteVisitorForm.LinkedQueryADDR4_VISIGetText(Sender: TField;
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

procedure TSiteVisitorForm.LinkedQueryDATE_VISITValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TSiteVisitorForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  LinkedQueryDATE_VISIT.Value := FormatDateTime('YYYYMMDD', Date);
end;

procedure TSiteVisitorForm.LinkedQueryUpperSetText(Sender: TField;
  const aText: string);
begin
  if AllowSmallChars then
    Sender.Value := aText
  else
    Sender.Value := UpperCase(aText);
end;

end.
