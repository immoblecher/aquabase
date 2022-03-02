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
unit timedeptwlreport;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, RLReport, ZDataset,
  reporttemplateportrait, db;

type

  { TPortraitReportFormWL }

  TPortraitReportFormWL = class(TPortraitReportForm)
    DetailQueryCOMMENT: TStringField;
    DetailQueryDATE_MEAS: TStringField;
    DetailQueryINFO_SOURC: TStringField;
    DetailQueryLEVEL_STAT: TStringField;
    DetailQueryMETH_MEAS: TStringField;
    DetailQueryPIEZOM_NR: TStringField;
    DetailQuerySITE_ID_NR: TStringField;
    DetailQueryTIME_MEAS: TStringField;
    DetailQueryTIME_SEC: TFloatField;
    DetailQueryWATER_LEV: TFloatField;
    QueryLookups: TZReadOnlyQuery;
    RLDBText10: TRLDBText;
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
    RLLabelHeader6: TRLLabel;
    RLLabelHeader7: TRLLabel;
    RLLabelHeader8: TRLLabel;
    SummaryQueryAvgWL: TFloatField;
    SummaryQueryMaxWL: TFloatField;
    SummaryQueryMinWL: TFloatField;
    SummaryQuerySITE_ID_NR: TStringField;
    procedure DetailQueryDATE_MEASGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure DetailQueryLEVEL_STATGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure DetailQueryMETH_MEASGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure DetailQueryTIME_MEASGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure DetailQueryWATER_LEVGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure FooterBandAfterPrint(Sender: TObject);
    procedure FooterBandBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure QueryLookupsBeforeOpen(DataSet: TDataSet);
    procedure RLDBText1AfterPrint(Sender: TObject);
    procedure RLReportPortraitAfterPrint(Sender: TObject);
    procedure RLReportPortraitBeforePrint(Sender: TObject; var PrintIt: Boolean
      );
  private
    PrevMeth, PrevMethText, PrevStat, PrevStatText: ShortString;
    LookupList: TStringList;
  public

  end;

var
  PortraitReportFormWL: TPortraitReportFormWL;

implementation

{$R *.lfm}

uses MainDataModule, VARINIT, strdatetime;

{ TPortraitReportFormWL }

procedure TPortraitReportFormWL.DetailQueryWATER_LEVGetText(Sender: TField;
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

procedure TPortraitReportFormWL.FooterBandAfterPrint(Sender: TObject);
begin
  LookupList.Clear;
end;

procedure TPortraitReportFormWL.FooterBandBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  RLMemoLookups.Lines.Clear;
  RLMemoLookups.Lines.Add('Information Source:');
  RLMemoLookups.Lines.AddStrings(LookupList);
end;

procedure TPortraitReportFormWL.QueryLookupsBeforeOpen(DataSet: TDataSet);
begin
  QueryLookups.Connection := DataModuleMain.ZConnectionLanguage;
end;

procedure TPortraitReportFormWL.RLDBText1AfterPrint(Sender: TObject);
var
  TheLookup: ShortString;
begin
  TheLookup := ':';
  if QueryLookups.Locate('SEARCH', (Sender as TRLDBText).DataSource.DataSet.FieldByName('INFO_SOURC').Value, []) then
    TheLookup := QueryLookups.FieldByName('SEARCH').AsString + ': ' + QueryLookups.FieldByName('DESCRIBE').AsString;
  if (TheLookup[1] <> ':') and (LookupList.IndexOf(TheLookup) = -1) then
    LookupList.Add(TheLookup);
end;

procedure TPortraitReportFormWL.RLReportPortraitAfterPrint(Sender: TObject);
begin
  inherited;
  QueryLookups.Close;
end;

procedure TPortraitReportFormWL.RLReportPortraitBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  QueryLookups.Open;
  LookupList := TStringList.Create;
  LookupList.Duplicates := dupIgnore;
  RLLabelHeader7.Caption := 'W. lev. [' + LengthUnit + ']';
end;

procedure TPortraitReportFormWL.DetailQueryMETH_MEASGetText(Sender: TField;
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

procedure TPortraitReportFormWL.DetailQueryTIME_MEASGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := FormatDateTime('hh:nn', EncodeTime(StrToInt(Copy(Sender.AsString, 1, 2)), StrToInt(Copy(Sender.AsString, 3, 2)), 0, 0));
end;

procedure TPortraitReportFormWL.DetailQueryLEVEL_STATGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull and (not PrintNoInfo) then DisplayText := False
  else
  begin
    if Sender.AsString = PrevStat then
      aText := PrevStatText
    else
      aText := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
    PrevStat := Sender.AsString;
    PrevStatText := aText;
  end;
end;

procedure TPortraitReportFormWL.DetailQueryDATE_MEASGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := DateToStr(StringToDate(Sender.AsString));
end;

end.

