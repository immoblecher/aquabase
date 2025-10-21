{ Copyright (C) 2018 Immo Blecher, immo@blecher.co.za

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
unit Watersam;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLtype, MastDetl,
  Menus, Db, DBCtrls, ExtCtrls, Buttons;

type

  { TWaterSampleForm }

  TWaterSampleForm = class(TMasterDetailForm)
    LinkedQueryCOMMENT: TStringField;
    LinkedQueryDATE_ENTRY: TStringField;
    LinkedQueryDATE_MEAS: TStringField;
    LinkedQueryREP_INST: TStringField;
    LinkedQuerySAM_NUMBER: TStringField;
    LinkedQueryTIME_MEAS: TStringField;
    procedure FormActivate(Sender: TObject);
    procedure LinkedQueryBeforeInsert(DataSet: TDataSet);
    procedure LinkedQueryCOMMENTSetText(Sender: TField; const aText: string);
    procedure LinkedQueryDATE_MEASValidate(Sender: TField);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryREP_INSTValidate(Sender: TField);
    procedure LinkedQueryTIME_MEASValidate(Sender: TField);
    procedure LinkedQueryUpperSetText(Sender: TField; const aText: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WaterSampleForm: TWaterSampleForm;

implementation

uses varinit, Strdatetime, MainDataModule;

{$R *.lfm}

var PrevRepInst, PrevDate: ShortString;

procedure TWaterSampleForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption;
end;

procedure TWaterSampleForm.LinkedQueryBeforeInsert(DataSet: TDataSet);
begin
  PrevDate := LinkedQueryDATE_MEAS.Value;
  PrevRepInst := LinkedQueryREP_INST.Value;
end;

procedure TWaterSampleForm.LinkedQueryCOMMENTSetText(Sender: TField;
  const aText: string);
begin
  if AllowSmallChars then
    Sender.Value := aText
  else
    Sender.Value := UpperCase(aText);
end;

procedure TWaterSampleForm.LinkedQueryDATE_MEASValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TWaterSampleForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  LinkedQueryREP_INST.Value := PrevRepInst;
  LinkedQueryDATE_ENTRY.ReadOnly := False;
  LinkedQueryDATE_ENTRY.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryDATE_ENTRY.ReadOnly := True;
  if PrevDate = '' then
    LinkedQueryDATE_MEAS.Value := FormatDateTime('YYYYMMDD', Date)
  else
    LinkedQueryDATE_MEAS.Value := PrevDate;
  LinkedQueryTIME_MEAS.Value := FormatDateTime('hhnn', Time);
end;

procedure TWaterSampleForm.LinkedQueryREP_INSTValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('REP_INST', Sender.AsString);
end;

procedure TWaterSampleForm.LinkedQueryTIME_MEASValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidTime(Sender.Value);
end;

procedure TWaterSampleForm.LinkedQueryUpperSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

end.
