{ Copyright (C) 2018 Immo Blecher immo@blecher.co.za

  This source is free software; you can redistribute it and/or modify it under
  the terms of the GNU General Public License as published by the Free
  Software Foundation; either version 2 of the License, or (at your option)
  any later version.

  This code is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

  A copy of the GNU General Public License is available on the World Wide Web
  at http://www.gnu.org/copyleft/gpl.html. You can also obtain it by writing
  to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
  MA 02111-1307, USA.
}
unit Targets;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLtype, MastDetl,
  Menus, Db, DBCtrls, Buttons, ExtCtrls;

type

  { TTargetsForm }

  TTargetsForm = class(TMasterDetailForm)
    LinkedQueryREADING: TFloatField;
    LinkedQueryTARG_TYPE: TStringField;
    LinkedQueryV_DATE_F: TStringField;
    procedure FormActivate(Sender: TObject);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryREADINGGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryREADINGSetText(Sender: TField; const aText: string);
    procedure LinkedQueryTARG_TYPESetText(Sender: TField; const aText: string);
    procedure LinkedQueryTARG_TYPEValidate(Sender: TField);
    procedure LinkedQueryV_DATE_FValidate(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TargetsForm: TTargetsForm;

implementation

{$R *.lfm}
uses strdatetime, Varinit, MainDataModule;

procedure TTargetsForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption + ' - ' + 'Time [hrs/day],' + ' Volume ' +  DisUnit + ', Depth [' + LengthUnit+']';
end;

procedure TTargetsForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  LinkedQueryV_DATE_F.Value := FormatDateTime('YYYYMMDD', Date);
end;

procedure TTargetsForm.LinkedQueryREADINGGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if (LinkedQueryTARG_TYPE.Value = 'AB') and (LinkedQueryREADING.Value <> null) then
    aText := FloatToStrF(LinkedQueryREADING.Value * VolumeFactor * TimeFactor, ffFixed, 8, 3)
  else
  if (LinkedQueryTARG_TYPE.Value = 'UT') and (LinkedQueryREADING.Value <> null) then
    aText := FloatToStrF(LinkedQueryREADING.Value*TimeFactor,fffixed,8,3)
  else
  if (LinkedQueryTARG_TYPE.Value = 'AV') and (LinkedQueryREADING.Value <> null) then
    aText := FloatToStrf(LinkedQueryREADING.Value*TimeFactor,fffixed,8,3)
  else
  if (LinkedQueryTARG_TYPE.Value = 'DD') and (LinkedQueryREADING.Value <> null) then
    aText := FloatToStrf(LinkedQueryREADING.Value*LengthFactor,fffixed,8,3)
  else
  if (LinkedQueryTARG_TYPE.Value = 'WL') and (LinkedQueryREADING.Value <> null) then
    aText := FloatToStrf(LinkedQueryREADING.Value*LengthFactor,fffixed,8,3);
end;

procedure TTargetsForm.LinkedQueryREADINGSetText(Sender: TField;
  const aText: string);
begin
  if (LinkedQueryTARG_TYPE.Value = 'AB') and (LinkedQueryREADING.Value <> null) then
    LinkedQueryREADING.Value := StrToFloat(aText)/VolumeFactor/TimeFactor
  else
  if (LinkedQueryTARG_TYPE.Value = 'UT') and (LinkedQueryREADING.Value <> null) then
    LinkedQueryREADING.Value := StrToFloat(aText)/TimeFactor
  else
  if (LinkedQueryTARG_TYPE.Value = 'AV') and (LinkedQueryREADING.Value <> null) then
    LinkedQueryREADING.Value := StrToFloat(aText)/TimeFactor
  else
  if (LinkedQueryTARG_TYPE.Value = 'DD') and (LinkedQueryREADING.Value <> null) then
    LinkedQueryREADING.Value := StrToFloat(aText)/LengthFactor
  else
  if (LinkedQueryTARG_TYPE.Value = 'WL') and (LinkedQueryREADING.Value <> null) then
    LinkedQueryREADING.Value := StrToFloat(aText)/LengthFactor;
end;

procedure TTargetsForm.LinkedQueryTARG_TYPESetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TTargetsForm.LinkedQueryTARG_TYPEValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('TARG_TYP', Sender.AsString);
end;

procedure TTargetsForm.LinkedQueryV_DATE_FValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

end.
