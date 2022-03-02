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
unit timedeptdisreport;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, RLReport, ZDataset,
  reporttemplateportrait, db;

type

  { TPortraitReportFormDis }

  TPortraitReportFormDis = class(TPortraitReportForm)
    DetailQueryCOMMENT: TStringField;
    DetailQueryDATE_MEAS: TStringField;
    DetailQueryDISCH_RATE: TFloatField;
    DetailQueryDISCH_TYPE: TStringField;
    DetailQueryINFO_SOURC: TStringField;
    DetailQueryMETH_MEAS: TStringField;
    DetailQueryREP_INST: TStringField;
    DetailQuerySITE_ID_NR: TStringField;
    DetailQueryTIME_MEAS: TStringField;
    QueryLookupInfoSrc: TZReadOnlyQuery;
    QueryLookupRepInst: TZReadOnlyQuery;
    RLDBText11: TRLDBText;
    RLDBText12: TRLDBText;
    RLDBText42: TRLDBText;
    RLDBText43: TRLDBText;
    RLDBText44: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLLabelHeader4: TRLLabel;
    RLLabelHeader5: TRLLabel;
    RLLabelHeader7: TRLLabel;
    RLLabelHeader8: TRLLabel;
    SummaryQueryAvgDISCH: TFloatField;
    SummaryQueryMaxDISCH: TFloatField;
    SummaryQueryMinDISCH: TFloatField;
    SummaryQuerySITE_ID_NR: TStringField;
    procedure DetailQueryDISCH_RATEGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure DetailQueryDISCH_TYPEGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure DetailQueryMETH_MEASGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure FooterBandAfterPrint(Sender: TObject);
    procedure FooterBandBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure QueryLookupInfoSrcBeforeOpen(DataSet: TDataSet);
    procedure QueryLookupRepInstBeforeOpen(DataSet: TDataSet);
    procedure RLDBText1AfterPrint(Sender: TObject);
    procedure RLDBText7AfterPrint(Sender: TObject);
    procedure RLReportPortraitAfterPrint(Sender: TObject);
    procedure RLReportPortraitBeforePrint(Sender: TObject; var PrintIt: Boolean
      );
  private
    PrevMeth, PrevMethText, PrevType, PrevTypeText: ShortString;
    LookupListInfoSrc, LookupListRepInst: TStringList;
  public

  end;

var
  PortraitReportFormDis: TPortraitReportFormDis;

implementation

{$R *.lfm}

uses MainDataModule, VARINIT;

{ TPortraitReportFormDis }

procedure TPortraitReportFormDis.FooterBandAfterPrint(Sender: TObject);
begin
  LookupListInfoSrc.Clear;
  LookupListRepInst.Clear;
end;

procedure TPortraitReportFormDis.FooterBandBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  RLMemoLookups.Lines.Clear;
  if LookupListInfoSrc.Count > 0 then
  begin
    RLMemoLookups.Lines.Add('Information Source:');
    RLMemoLookups.Lines.AddStrings(LookupListInfoSrc);
  end;
  if LookupListRepInst.Count > 0 then
  begin
    RLMemoLookups.Lines.Add('Reporting Institution:');
    RLMemoLookups.Lines.AddStrings(LookupListRepInst);
  end;
end;

procedure TPortraitReportFormDis.QueryLookupInfoSrcBeforeOpen(DataSet: TDataSet);
begin
  QueryLookupInfoSrc.Connection := DataModuleMain.ZConnectionLanguage;
end;

procedure TPortraitReportFormDis.QueryLookupRepInstBeforeOpen(DataSet: TDataSet);
begin
  QueryLookupRepInst.Connection := DataModuleMain.ZConnectionLanguage;
end;

procedure TPortraitReportFormDis.RLDBText1AfterPrint(Sender: TObject);
var
  TheLookup: ShortString;
begin
  TheLookup := ':';
  if QueryLookupInfoSrc.Locate('SEARCH', (Sender as TRLDBText).DataSource.DataSet.FieldByName('INFO_SOURC').Value, []) then
    TheLookup := QueryLookupInfoSrc.FieldByName('SEARCH').AsString + ': ' + QueryLookupInfoSrc.FieldByName('DESCRIBE').AsString;
  if (TheLookup[1] <> ':') and (LookupListInfoSrc.IndexOf(TheLookup) = -1) then
    LookupListInfoSrc.Add(TheLookup);
end;

procedure TPortraitReportFormDis.RLDBText7AfterPrint(Sender: TObject);
var
  TheLookup: ShortString;
begin
  TheLookup := ':';
  if QueryLookupRepInst.Locate('SEARCH', (Sender as TRLDBText).DataSource.DataSet.FieldByName('REP_INST').Value, []) then
    TheLookup := QueryLookupRepInst.FieldByName('SEARCH').AsString + ': ' + QueryLookupRepInst.FieldByName('DESCRIBE').AsString;
  if (TheLookup[1] <> ':') and (LookupListRepInst.IndexOf(TheLookup) = -1) then
    LookupListRepInst.Add(TheLookup);
end;

procedure TPortraitReportFormDis.RLReportPortraitAfterPrint(Sender: TObject);
begin
  inherited;
  QueryLookupInfoSrc.Close;
  QueryLookupRepInst.Close;
end;

procedure TPortraitReportFormDis.RLReportPortraitBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  QueryLookupInfoSrc.Open;
  QueryLookupRepInst.Open;
  LookupListInfoSrc := TStringList.Create;
  LookupListInfoSrc.Duplicates := dupIgnore;
  LookupListRepInst := TStringList.Create;
  LookupListRepInst.Duplicates := dupIgnore;
  RLLabelHeader7.Caption := 'Dis. Rate [' + DisUnit + ']';
end;

procedure TPortraitReportFormDis.DetailQueryMETH_MEASGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull and (not PrintNoInfo) then DisplayText := False
  else
  begin
    if Sender.AsString = PrevMeth then
      aText := PrevMethText
    else
      aText := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
    PrevMeth := Sender.AsString;
    PrevMethText := aText;
  end;
end;

procedure TPortraitReportFormDis.DetailQueryDISCH_RATEGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
 if not Sender.IsNull then
  begin
    if Sender.AsFloat = 0 then
      aText := '0.00'
    else
    if Sender.AsFloat * VolumeFactor * TimeFactor > 100000 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 0)
    else
    if Sender.AsFloat * VolumeFactor * TimeFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 2);
  end;
end;

procedure TPortraitReportFormDis.DetailQueryDISCH_TYPEGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull and (not PrintNoInfo) then DisplayText := False
  else
  begin
    if Sender.AsString = PrevType then
      aText := PrevTypeText
    else
      aText := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
    PrevType := Sender.AsString;
    PrevTypeText := aText;
  end;
end;

end.

