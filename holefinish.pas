{ Copyright (C) 2020 Immo Blecher, immo@blecher.co.za

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
unit holefinish;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, Menus, DBCtrls,
  ExtCtrls, Buttons, StdCtrls, DBGrids, MaskEdit, XMLPropStorage, rxlookup,
  ZDataset, MastDetl;

type

  { THoleConstForm }

  THoleConstForm = class(TMasterDetailForm)
    GraphSpeedButton: TSpeedButton;
    LinkedQueryCOLLAR_HI: TFloatField;
    LinkedQueryCOMMENT: TStringField;
    LinkedQueryCONST_METH: TStringField;
    LinkedQueryCONTRACTOR: TStringField;
    LinkedQueryCOST_CONST: TFloatField;
    LinkedQueryDATE_CONST: TStringField;
    LinkedQueryDATE_ENTRY: TStringField;
    LinkedQueryDEPTH: TFloatField;
    LinkedQueryDURA_DEVEL: TLongintField;
    LinkedQueryINFO_SOURC: TStringField;
    LinkedQueryMETH_DEVEL: TStringField;
    LinkedQueryREP_INST: TStringField;
    LinkedQuerySPEC_TREAT: TStringField;
    LinkedQueryTYPE_FINIS: TStringField;
    procedure LinkedQueryAfterPost(DataSet: TDataSet);
    procedure LinkedQueryBeforeEdit(DataSet: TDataSet);
    procedure LinkedQueryBeforeInsert(DataSet: TDataSet);
    procedure LinkedQueryCOLLAR_HIGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryCOLLAR_HISetText(Sender: TField; const aText: string);
    procedure LinkedQueryDATE_CONSTValidate(Sender: TField);
    procedure LinkedQueryDEPTHGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryDEPTHSetText(Sender: TField; const aText: string);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryValidate(Sender: TField);
    procedure LinkedQueryUpperSetText(Sender: TField; const aText: string);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    DepthChanged, CollarChanged: Boolean;
    LatestDepth, LatestCollar: Double;
  public
    { Public declarations }
  end;

var
  HoleConstForm: THoleConstForm;

implementation

uses VARINIT, strDatetime, MainDataModule;

var
  PrevInfoSource, PrevRepInst: String;

{$R *.lfm}

procedure THoleConstForm.LinkedQueryBeforeInsert(DataSet: TDataSet);
begin
  PrevInfoSource := LinkedQueryINFO_SOURC.Value;
  PrevRepInst := LinkedQueryREP_INST.Value;
end;

procedure THoleConstForm.LinkedQueryAfterPost(DataSet: TDataSet);
begin
  inherited;
  if DepthChanged or CollarChanged then
  if MessageDlg('Update latest depth and collar in Basic Information too?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    DataModuleMain.BasicinfQuery.Edit;
    if LatestDepth > -999999 then
      DataModuleMain.BasicinfQueryDEPTH.Value := LatestDepth;
    if LatestCollar > -999999 then
      DataModuleMain.BasicinfQueryCOLLAR_HI.Value := LatestCollar;
    DataModuleMain.BasicinfQuery.Post;
  end;
  DepthChanged := False;
  CollarChanged := False;
end;

procedure THoleConstForm.LinkedQueryBeforeEdit(DataSet: TDataSet);
begin
  LatestDepth := -999999;
  LatestCollar := -999999;
end;

procedure THoleConstForm.LinkedQueryCOLLAR_HIGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if Abs(Sender.AsFloat * LengthFactor) > 100 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
    else
    if (Sender.AsFloat > 0) and (Abs(Sender.AsFloat * LengthFactor) < 0.01) then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end
end;

procedure THoleConstForm.LinkedQueryCOLLAR_HISetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
  begin
    LatestCollar := StrToFloat(aText)/LengthFactor;
    Sender.AsFloat := LatestCollar;
    CollarChanged := True;
  end
  else
    LatestCollar := -999999;
end;

procedure THoleConstForm.LinkedQueryDATE_CONSTValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure THoleConstForm.LinkedQueryDEPTHGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if Sender.AsFloat * LengthFactor > 1000 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
    else
    if (Sender.AsFloat > 0) and (Sender.AsFloat * LengthFactor < 0.01) then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end;
end;

procedure THoleConstForm.LinkedQueryDEPTHSetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
  begin
    LatestDepth := StrToFloat(aText)/LengthFactor;
    Sender.AsFloat := LatestDepth;
    DepthChanged := True;
  end
  else
    LatestDepth := -999999;
end;

procedure THoleConstForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  LinkedQueryDATE_ENTRY.ReadOnly := False;
  LinkedQueryDATE_ENTRY.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryDATE_ENTRY.ReadOnly := True;
  LatestDepth := -999999;
  LatestCollar := -999999;
  if PrevRepInst = '' then
  begin
    if DataModuleMain.BasicinfQueryREP_INST.Value <> '' then
      LinkedQueryREP_INST.Value := DataModuleMain.BasicinfQueryREP_INST.Value;
  end
  else
    LinkedQueryREP_INST.Value := PrevRepInst;
  if DataModuleMain.BasicinfQueryDATE_COMPL.AsString = '' then
      LinkedQueryDATE_CONST.Value := FormatDateTime('YYYYMMDD', Date)
  else
    LinkedQueryDATE_CONST.Value := DataModuleMain.BasicinfQueryDATE_COMPL.Value;
  LinkedQueryINFO_SOURC.Value := PrevInfoSource;
end;

procedure THoleConstForm.LinkedQueryValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound(Sender.LookupKeyFields, Sender.AsString);
end;

procedure THoleConstForm.LinkedQueryUpperSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

procedure THoleConstForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption + ' - Depth, collar [' + LengthUnit + ']';
end;

end.
