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
unit Instrmnt;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLtype, Db, Menus,
  DBCtrls, ExtCtrls, Buttons, StdCtrls, MaskEdit, DBGrids, XMLPropStorage,
  rxlookup, ZDataset, MastDetl;

type

  { TInstrumentForm }

  TInstrumentForm = class(TMasterDetailForm)
    DBMemo1: TDBMemo;
    LinkedQueryDATE_ENTRY: TStringField;
    LinkedQueryDATE_INST: TStringField;
    LinkedQueryDEPTH_INST: TFloatField;
    LinkedQueryINFO_SOURC: TStringField;
    LinkedQueryMANUFACTUR: TStringField;
    LinkedQueryNOTES_YN: TStringField;
    LinkedQueryNOTE_PAD: TBlobField;
    LinkedQueryPARAM_MEAS: TStringField;
    LinkedQueryREP_INST: TStringField;
    LinkedQuerySERIAL_NR: TStringField;
    LinkedQueryTYPE_INST: TStringField;
    Splitter1: TSplitter;
    procedure DBMemo1Enter(Sender: TObject);
    procedure DBMemo1Exit(Sender: TObject);
    procedure DBMemo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure LinkedDataSourceDataChange(Sender: TObject; Field: TField);
    procedure LinkedQueryBeforeInsert(DataSet: TDataSet);
    procedure LinkedQueryBeforePost(DataSet: TDataSet);
    procedure LinkedQueryDATE_INSTSetText(Sender: TField; const aText: string);
    procedure LinkedQueryDATE_INSTValidate(Sender: TField);
    procedure LinkedQueryDEPTH_INSTGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryDEPTH_INSTSetText(Sender: TField; const aText: string);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQuerySetText(Sender: TField; const aText: string);
    procedure LinkedQueryValidate(Sender: TField);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InstrumentForm: TInstrumentForm;

implementation

uses varinit, strdatetime, MainDataModule;

{$R *.lfm}

var
  PrevInfoSource, PrevRepInst: String;

procedure TInstrumentForm.DBMemo1Enter(Sender: TObject);
begin
  Editing := EditLabel + ' ' + Caption;
  if MessageDlg('Record not editable. Go into edit mode now to edit notes?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    LinkedQuery.Edit;
    DBMemo1.ReadOnly := False;
  end;
end;

procedure TInstrumentForm.DBMemo1Exit(Sender: TObject);
begin
  if LinkedQuery.State IN [dsInsert, dsEdit] then
  begin
    if MessageDlg('Changes to current record have not been posted and will be lost! Post record now?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then LinkedQuery.Post
    else LinkedQuery.Cancel;
  end;
  DBMemo1.ReadOnly := True;
end;

procedure TInstrumentForm.DBMemo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssAlt in Shift) then
  begin
    if (Key = VK_F8) then LinkedQuery.Edit;
  end
  else
  case Key of
    VK_F5: LinkedQuery.Refresh;
    VK_F8: if LinkedQuery.State IN [dsInsert, dsEdit] then LinkedQuery.Post;
  end; {of case}
end;

procedure TInstrumentForm.FormCreate(Sender: TObject);
begin
  inherited;
  DBGrid.BorderSpacing.Bottom := 0;
end;

procedure TInstrumentForm.LinkedDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  DBMemo1.Enabled := LinkedQuerySITE_ID_NR.Value > '';
end;

procedure TInstrumentForm.LinkedQueryBeforeInsert(DataSet: TDataSet);
begin
  PrevInfoSource := LinkedQueryINFO_SOURC.Value;
  PrevRepInst := LinkedQueryREP_INST.Value;
end;

procedure TInstrumentForm.LinkedQueryBeforePost(DataSet: TDataSet);
begin
  if LinkedQueryNOTE_PAD.Value = '' then LinkedQueryNOTES_YN.Value := 'N'
  else LinkedQueryNOTES_YN.Value := 'Y'
end;

procedure TInstrumentForm.LinkedQueryDATE_INSTSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := aText;
end;

procedure TInstrumentForm.LinkedQueryDATE_INSTValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TInstrumentForm.LinkedQueryDEPTH_INSTGetText(Sender: TField;
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

procedure TInstrumentForm.LinkedQueryDEPTH_INSTSetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
  begin
    if StrToFloat(aText) = 0 then
    begin
      MessageDlg('A depth of 0.00 is invalid! If you do not have a depth then leave the field blank (NULL). It will be reset now.', mtError, [mbOK], 0);
      Sender.Clear;
      Sender.FocusControl;
    end
    else
    if (not DataModuleMain.BasicinfQueryDEPTH.ISNull) and (StrToFloat(aText) > DataModuleMain.BasicinfQueryDEPTH.Value) then
    begin
      if MessageDlg('This installation depth is deeper than the hole! Are you sure you want to keep it?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      begin
        Sender.Clear;
        Sender.FocusControl;
      end
      else
        Sender.AsFloat := StrToFloat(aText)/LengthFactor;
    end
    else
      Sender.AsFloat := StrToFloat(aText)/LengthFactor;
  end;
end;

procedure TInstrumentForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  LinkedQueryDATE_ENTRY.ReadOnly := False;
  LinkedQueryDATE_ENTRY.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryDATE_ENTRY.ReadOnly := True;
  if PrevRepInst = '' then
  begin
    if DataModuleMain.BasicinfQueryREP_INST.Value <> '' then
      LinkedQueryREP_INST.Value := DataModuleMain.BasicinfQueryREP_INST.Value;
  end
  else
    LinkedQueryREP_INST.Value := PrevRepInst;
  LinkedQueryDATE_INST.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryINFO_SOURC.Value := PrevInfoSource;
  LinkedQueryNOTES_YN.Value := 'N';
end;

procedure TInstrumentForm.LinkedQuerySetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TInstrumentForm.LinkedQueryValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound(Sender.LookupKeyFields, Sender.AsString);
end;

procedure TInstrumentForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption + ', depth installed [' + LengthUnit + ']' ;
end;

end.
