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
unit Specases;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MastDetl, Db, Menus,
  DBCtrls, StdCtrls, ExtCtrls, Buttons, LCLtype, DBGrids, MaskEdit;

type

  { TSpecCasesForm }

  TSpecCasesForm = class(TMasterDetailForm)
    LinkedQueryDEPTH_DEEP: TFloatField;
    LinkedQueryDEPTH_LATE: TFloatField;
    LinkedQueryDEPTH_SHAL: TFloatField;
    LinkedQueryDIAMETER: TFloatField;
    LinkedQueryDIP_TUN_DR: TLongintField;
    LinkedQueryLENGTH_PTD: TFloatField;
    LinkedQueryLEN_LATERL: TFloatField;
    LinkedQueryMESH_SCRN: TFloatField;
    LinkedQueryMETH_CONST: TStringField;
    LinkedQueryNR_HOLES: TLongintField;
    LinkedQuerySTRIKE_PTD: TLongintField;
    AMSLCheckBox: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure LinkedQueryDEPTHGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryDEPTHSetText(Sender: TField; const aText: string);
    procedure LinkedQueryDIAMETERGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryDIAMETERSetText(Sender: TField; const aText: string);
    procedure LinkedQueryLENGTHGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryLENGTHSetText(Sender: TField; const aText: string);
    procedure LinkedQueryMETH_CONSTSetText(Sender: TField; const aText: string);
    procedure LinkedQueryMETH_CONSTValidate(Sender: TField);
    procedure AMSLCheckBoxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SpecCasesForm: TSpecCasesForm;

implementation

uses varinit, MainDataModule;

{$R *.lfm}

procedure TSpecCasesForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption + ' - Depth [' + LengthUnit + '], Diam./Mesh [' + DiamUnit + ']';
end;

procedure TSpecCasesForm.LinkedQueryDEPTHGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if AMSLCheckBox.Checked then
    Elevation := DataModuleMain.BasicinfQueryALTITUDE.Value
  else
    Elevation := 2 * Sender.AsFloat;
  if Sender.AsFloat <> 0 then
    aText := FloatToStrF((Elevation - Sender.AsFloat) * LengthFactor, ffFixed, 15, 2)
  else DisplayText := False;
end;

procedure TSpecCasesForm.LinkedQueryDEPTHSetText(Sender: TField;
  const aText: string);
begin
  if AMSLCheckBox.Checked then
    Elevation := DataModuleMain.BasicinfQueryALTITUDE.Value
  else
  if aText <> '' then
    Elevation := 2 * StrToFloat(aText);
  if aText <> '' then
    Sender.AsFloat := (Elevation - StrToFloat(aText))/LengthFactor;
end;

procedure TSpecCasesForm.LinkedQueryDIAMETERGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.AsFloat <> 0 then
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TSpecCasesForm.LinkedQueryDIAMETERSetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
    Sender.AsFloat := StrToFloat(aText)/DiamFactor;
end;

procedure TSpecCasesForm.LinkedQueryLENGTHGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.AsFloat <> 0 then
  begin
    if Sender.AsFloat * LengthFactor > 100 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
    else
    if Sender.AsFloat * LengthFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TSpecCasesForm.LinkedQueryLENGTHSetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
    Sender.AsFloat := StrToFloat(aText)/LengthFactor;
end;

procedure TSpecCasesForm.LinkedQueryMETH_CONSTSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TSpecCasesForm.LinkedQueryMETH_CONSTValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('CONSMETH', Sender.AsString);
end;

procedure TSpecCasesForm.AMSLCheckBoxClick(Sender: TObject);
begin
  inherited;
  LinkedQuery.Refresh;
end;

end.
