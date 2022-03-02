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
unit timedeptdepthreport;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, RLReport, ZDataset,
  reporttemplateportrait, db;

type

  { TPortraitReportFormDepth }

  TPortraitReportFormDepth = class(TPortraitReportForm)
    DetailQueryCOLLAR_HI: TFloatField;
    DetailQueryCOMMENT: TStringField;
    DetailQueryCONTRACTOR: TStringField;
    DetailQueryDATE_CONST: TStringField;
    DetailQueryDEPTH: TFloatField;
    DetailQueryINFO_SOURC: TStringField;
    DetailQueryREP_INST: TStringField;
    DetailQuerySITE_ID_NR: TStringField;
    QueryLookups: TZReadOnlyQuery;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    RLDBText12: TRLDBText;
    RLDBText42: TRLDBText;
    RLDBText43: TRLDBText;
    RLDBText44: TRLDBText;
    RLDBText8: TRLDBText;
    RLLabelHeader5: TRLLabel;
    RLLabelHeader6: TRLLabel;
    RLLabelHeader8: TRLLabel;
    SummaryQueryAvgDepth: TFloatField;
    SummaryQueryMaxDepth: TFloatField;
    SummaryQueryMinDepth: TFloatField;
    SummaryQuerySITE_ID_NR: TStringField;
    procedure DetailQueryCOLLAR_HIGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure DetailQueryCONTRACTORGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure DetailQueryDATE_CONSTGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure DetailQueryDEPTHGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure DetailQueryREP_INSTGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure DetailQueryWATER_LEVGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure FooterBandAfterPrint(Sender: TObject);
    procedure FooterBandBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure QueryLookupsBeforeOpen(DataSet: TDataSet);
    procedure RLBandSummaryBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLDBText1AfterPrint(Sender: TObject);
    procedure RLReportPortraitAfterPrint(Sender: TObject);
    procedure RLReportPortraitBeforePrint(Sender: TObject; var PrintIt: Boolean
      );
  private
    PrevRepInst, PrevRepInstText, PrevContr, PrevContrText: ShortString;
    LookupList: TStringList;
  public
    DateLocale: Boolean;
  end;

var
  PortraitReportFormDepth: TPortraitReportFormDepth;

implementation

{$R *.lfm}

uses MainDataModule, VARINIT, strdatetime;

{ TPortraitReportFormDepth }

procedure TPortraitReportFormDepth.DetailQueryWATER_LEVGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if not Sender.IsNull then
  begin
    if Abs(Sender.AsFloat * LengthFactor) >= 10000 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end
  else
    DisplayText := False;
end;

procedure TPortraitReportFormDepth.FooterBandAfterPrint(Sender: TObject);
begin
  LookupList.Clear;
end;

procedure TPortraitReportFormDepth.FooterBandBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  RLMemoLookups.Lines.Clear;
  RLMemoLookups.Lines.Add('Information Source:');
  RLMemoLookups.Lines.AddStrings(LookupList);
end;

procedure TPortraitReportFormDepth.QueryLookupsBeforeOpen(DataSet: TDataSet);
begin
  QueryLookups.Connection := DataModuleMain.ZConnectionLanguage;
end;

procedure TPortraitReportFormDepth.RLBandSummaryBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  with SummaryQuery do
  if Active then
    if FieldByName('MinDepth').Value = FieldByName('MaxDepth').Value then
      PrintIt := False
    else
      PrintIt := True;
end;

procedure TPortraitReportFormDepth.RLDBText1AfterPrint(Sender: TObject);
var
  TheLookup: ShortString;
begin
  TheLookup := ':';
  if QueryLookups.Locate('SEARCH', (Sender as TRLDBText).DataSource.DataSet.FieldByName('INFO_SOURC').Value, []) then
    TheLookup := QueryLookups.FieldByName('SEARCH').AsString + ': ' + QueryLookups.FieldByName('DESCRIBE').AsString;
  if (TheLookup[1] <> ':') and (LookupList.IndexOf(TheLookup) = -1) then
    LookupList.Add(TheLookup);
end;

procedure TPortraitReportFormDepth.RLReportPortraitAfterPrint(Sender: TObject);
begin
  inherited;
  QueryLookups.Close;
end;

procedure TPortraitReportFormDepth.RLReportPortraitBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  QueryLookups.Open;
  LookupList := TStringList.Create;
  LookupList.Duplicates := dupIgnore;
  RLLabelHeader6.Caption := 'Col. & Depth [' + LengthUnit + ']';
end;

procedure TPortraitReportFormDepth.DetailQueryCOLLAR_HIGetText(Sender: TField;
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

procedure TPortraitReportFormDepth.DetailQueryCONTRACTORGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
    if Sender.IsNull and (not PrintNoInfo) then DisplayText := False
  else
  begin
    if Sender.AsString = PrevContr then
      aText := PrevContrText
    else
      aText := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
    PrevContr := Sender.AsString;
    PrevContrText := aText;
  end;
end;

procedure TPortraitReportFormDepth.DetailQueryDATE_CONSTGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  if DateLocale then
    aText := DateToStr(StringToDate(Sender.AsString))
  else
    aText := Sender.AsString;
end;

procedure TPortraitReportFormDepth.DetailQueryDEPTHGetText(Sender: TField;
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

procedure TPortraitReportFormDepth.DetailQueryREP_INSTGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull and (not PrintNoInfo) then DisplayText := False
  else
  begin
    if Sender.AsString = PrevRepInst then
      aText := PrevRepInstText
    else
      aText := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
    PrevRepInst := Sender.AsString;
    PrevRepInstText := aText;
  end;
end;

end.

