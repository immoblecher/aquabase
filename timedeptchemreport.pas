{ Copyright (C) 2021 Immo Blecher immo@blecher.co.za

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
unit TimeDeptChemReport;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, 
    reporttemplatelandscape, db, RLReport, ZDataset;

type

  { TLandscapeReportFormChem }

  TLandscapeReportFormChem = class(TLandscapeReportForm)
    ChemQuery1: TZReadOnlyQuery;
    ChemQuery1AL: TFloatField;
    ChemQuery1CA: TFloatField;
    ChemQuery1CHM_REF_NR: TLargeintField;
    ChemQuery1CL: TFloatField;
    ChemQuery1CO3: TFloatField;
    ChemQuery1EC: TFloatField;
    ChemQuery1F: TFloatField;
    ChemQuery1FE: TFloatField;
    ChemQuery1HCO3: TFloatField;
    ChemQuery1K: TFloatField;
    ChemQuery1MACID: TFloatField;
    ChemQuery1MALK: TFloatField;
    ChemQuery1MG: TFloatField;
    ChemQuery1MN: TFloatField;
    ChemQuery1N: TFloatField;
    ChemQuery1NA: TFloatField;
    ChemQuery1PACID: TFloatField;
    ChemQuery1PALK: TFloatField;
    ChemQuery1PH: TFloatField;
    ChemQuery1SI: TFloatField;
    ChemQuery1SO4: TFloatField;
    ChemQuery1TDS: TFloatField;
    ChemQuery2: TZReadOnlyQuery;
    ChemQuery2ARSENIC: TFloatField;
    ChemQuery2B: TFloatField;
    ChemQuery2BA: TFloatField;
    ChemQuery2BI: TFloatField;
    ChemQuery2CD: TFloatField;
    ChemQuery2CHM_REF_NR: TLargeintField;
    ChemQuery2CN: TFloatField;
    ChemQuery2CO: TFloatField;
    ChemQuery2CR: TFloatField;
    ChemQuery2CU: TFloatField;
    ChemQuery2HG: TFloatField;
    ChemQuery2MO: TFloatField;
    ChemQuery2NI: TFloatField;
    ChemQuery2NO2: TFloatField;
    ChemQuery2N_AMONIA: TFloatField;
    ChemQuery2PB: TFloatField;
    ChemQuery2PO4: TFloatField;
    ChemQuery2SB: TFloatField;
    ChemQuery2SR: TFloatField;
    ChemQuery2SULF: TFloatField;
    ChemQuery2TI: TFloatField;
    ChemQuery2ZN: TFloatField;
    ChemQuery3: TZReadOnlyQuery;
    ChemQuery3BOD: TFloatField;
    ChemQuery3CFR: TFloatField;
    ChemQuery3CHM_REF_NR: TLargeintField;
    ChemQuery3COD: TFloatField;
    ChemQuery3DOC: TFloatField;
    ChemQuery3DOX: TFloatField;
    ChemQuery3ECOL: TLargeintField;
    ChemQuery3ENT_VIRUS: TLargeintField;
    ChemQuery3FAEC_ECOL: TLargeintField;
    ChemQuery3FAEC_STREP: TLargeintField;
    ChemQuery3H2S: TFloatField;
    ChemQuery3KJED: TFloatField;
    ChemQuery3OIL: TFloatField;
    ChemQuery3PHEN: TFloatField;
    ChemQuery3PROTO_PARA: TLargeintField;
    ChemQuery3SOAP: TFloatField;
    ChemQuery3SOM_COLI: TLargeintField;
    ChemQuery3SPC: TLargeintField;
    ChemQuery3TOC: TFloatField;
    ChemQuery3TOTAL_COL: TLargeintField;
    ChemQuery3TOT_THM: TFloatField;
    ChemQuery3TVO: TLargeintField;
    ChemQuery4: TZReadOnlyQuery;
    ChemQuery4CHM_REF_NR: TLargeintField;
    ChemQuery4COLR: TFloatField;
    ChemQuery4DEUTERIUM: TFloatField;
    ChemQuery4MBAS: TFloatField;
    ChemQuery4ODR: TFloatField;
    ChemQuery4OXYGEN18: TFloatField;
    ChemQuery4RCARBON: TFloatField;
    ChemQuery4SPECGRAV: TFloatField;
    ChemQuery4SUSP_SOLID: TFloatField;
    ChemQuery4TEMP: TFloatField;
    ChemQuery4TRITIUM: TFloatField;
    ChemQuery4TST: TFloatField;
    ChemQuery4TUR: TFloatField;
    ChemQuery5: TZReadOnlyQuery;
    ChemQuery5AG: TFloatField;
    ChemQuery5AU: TFloatField;
    ChemQuery5BE: TFloatField;
    ChemQuery5BR: TFloatField;
    ChemQuery5CE: TFloatField;
    ChemQuery5CHM_REF_NR: TLargeintField;
    ChemQuery5I: TFloatField;
    ChemQuery5LA: TFloatField;
    ChemQuery5LI: TFloatField;
    ChemQuery5NB: TFloatField;
    ChemQuery5ND: TFloatField;
    ChemQuery5PD: TFloatField;
    ChemQuery5PT: TFloatField;
    ChemQuery5SE: TFloatField;
    ChemQuery5SN: TFloatField;
    ChemQuery5TA: TFloatField;
    ChemQuery5TE: TFloatField;
    ChemQuery5TL: TFloatField;
    ChemQuery5U: TFloatField;
    ChemQuery5V: TFloatField;
    ChemQuery5W: TFloatField;
    ChemQuery5ZR: TFloatField;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DataSource4: TDataSource;
    DataSource5: TDataSource;
    RLDBResult1: TRLDBResult;
    RLDBTextMax0: TRLDBText;
    RLDBTextAvg0: TRLDBText;
    RLDBTextMin1: TRLDBText;
    RLDBTextMax1: TRLDBText;
    RLDBTextAvg1: TRLDBText;
    RLDBTextMin2: TRLDBText;
    RLDBTextMax2: TRLDBText;
    RLDBTextAvg2: TRLDBText;
    RLDBTextMin3: TRLDBText;
    RLDBTextMax3: TRLDBText;
    RLDBTextAvg3: TRLDBText;
    RLDBTextMin4: TRLDBText;
    RLDBTextMax4: TRLDBText;
    RLDBTextAvg4: TRLDBText;
    RLDBTextMin5: TRLDBText;
    RLDBTextMax5: TRLDBText;
    RLDBTextAvg5: TRLDBText;
    RLDBTextMin6: TRLDBText;
    RLDBTextMax6: TRLDBText;
    RLDBTextAvg6: TRLDBText;
    RLDBTextMin7: TRLDBText;
    RLDBTextMax7: TRLDBText;
    RLDBTextAvg7: TRLDBText;
    RLDBTextMin8: TRLDBText;
    RLDBTextMax8: TRLDBText;
    RLDBTextAvg8: TRLDBText;
    RLDBTextMin9: TRLDBText;
    RLDBTextMax9: TRLDBText;
    RLDBTextAvg9: TRLDBText;
    RLDBTextMin10: TRLDBText;
    RLDBTextMax10: TRLDBText;
    RLDBTextAvg10: TRLDBText;
    RLDBTextMin11: TRLDBText;
    RLDBTextMax11: TRLDBText;
    RLDBTextAvg11: TRLDBText;
    RLDBTextMin12: TRLDBText;
    RLDBTextMax12: TRLDBText;
    RLDBTextAvg12: TRLDBText;
    RLDBTextMin13: TRLDBText;
    RLDBTextMax13: TRLDBText;
    RLDBTextAvg13: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBTextMin0: TRLDBText;
    RLDBTextParam0: TRLDBText;
    RLDBTextParam1: TRLDBText;
    RLDBTextParam10: TRLDBText;
    RLDBTextParam11: TRLDBText;
    RLDBTextParam12: TRLDBText;
    RLDBTextParam13: TRLDBText;
    RLDBTextParam2: TRLDBText;
    RLDBTextParam3: TRLDBText;
    RLDBTextParam4: TRLDBText;
    RLDBTextParam5: TRLDBText;
    RLDBTextParam6: TRLDBText;
    RLDBTextParam7: TRLDBText;
    RLDBTextParam8: TRLDBText;
    RLDBTextParam9: TRLDBText;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabelParam0: TRLLabel;
    RLLabelParam1: TRLLabel;
    RLLabelParam10: TRLLabel;
    RLLabelParam11: TRLLabel;
    RLLabelParam12: TRLLabel;
    RLLabelParam13: TRLLabel;
    RLLabelParam2: TRLLabel;
    RLLabelParam3: TRLLabel;
    RLLabelParam4: TRLLabel;
    RLLabelParam5: TRLLabel;
    RLLabelParam6: TRLLabel;
    RLLabelParam7: TRLLabel;
    RLLabelParam8: TRLLabel;
    RLLabelParam9: TRLLabel;
    QueryParams: TZReadOnlyQuery;
    RLMemoLookups: TRLMemo;
    QueryLookups: TZReadOnlyQuery;
    QueryLimits: TZQuery;
    QueryLimitsCHM_REF_NR: TLongintField;
    QueryLimitsCOMMENTS: TStringField;
    QueryLimitsCPARAMETER: TStringField;
    QueryLimitsLIMITS: TStringField;
    QueryLimitsMETHOD: TStringField;
    RLMemoLegend: TRLMemo;
    procedure ChemQueryGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure FooterBandAfterPrint(Sender: TObject);
    procedure FooterBandBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure QueryParamsBeforeOpen(DataSet: TDataSet);
    procedure RLBandSummaryBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLDBText8AfterPrint(Sender: TObject);
    procedure RLReportLandscapeAfterPrint(Sender: TObject);
    procedure RLReportLandscapeBeforePrint(Sender: TObject; var PrintIt: Boolean
      );
    function GetSymbol(const ChemValue: Variant): ShortString;
    procedure SummaryQueryAfterOpen(DataSet: TDataSet);
    procedure SummaryGetText(Sender: TField; var aText: string; DisplayText: Boolean
      );
  private
    LookupList: TStringList;
  public
    ParamsList: TStringList;
  end;

var
  LandscapeReportFormChem: TLandscapeReportFormChem;

implementation

{$R *.lfm}

uses VARINIT, MainDataModule;

{ TLandscapeReportFormChem }

function TLandscapeReportFormChem.GetSymbol(const ChemValue: Variant): ShortString;
begin
  Result := '';
  with DataModuleMain do
  if ClassTable.Active then
  begin
    if ChemValue > ClassTableCLASS3.Value then
      Result := ' ‡'
    else if ChemValue > ClassTableCLASS2.Value then
      Result := ' †'
    else if ChemValue > ClassTableCLASS1.Value then
      Result := ' #'
    else if ChemValue > ClassTableCLASS0.Value then
      Result := ' !';
  end
  else
  begin
    if (ChemValue > StandardTableSTDMAXHI.Value) and (StandardTableSTDMAXHI.Value > -1) then
      Result := ' ‡'
    else if (ChemValue > StandardTableSTDRECHI.Value) and (StandardTableSTDRECHI.Value > -1) then
      Result := ' †'
    else if (ChemValue < StandardTableSTDMAXLO.Value) and (StandardTableSTDMAXLO.Value > -1)  then
      Result := ' #'
    else if (ChemValue < StandardTableSTDRECLO.Value) and (StandardTableSTDRECLO.Value > -1)  then
      Result := ' !';
  end;
end;

procedure TLandscapeReportFormChem.SummaryQueryAfterOpen(DataSet: TDataSet);
var
  f: Byte;
begin
  with Dataset do
  for f := 0 to FieldCount - 1 do
    Fields[f].OnGetText := @SummaryGetText;
end;

procedure TLandscapeReportFormChem.SummaryGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull or (Sender.Value = -1) then
    DisplayText := False
  else
  begin
    if Sender.Tag = 1 then //the mg/l
    begin
      if AsN then
      begin
        if Sender.Origin = 'NO2' then
          aText := DataModuleMain.FormatTheFloat(Sender.Value * ParamFactor[1] * ChemFactor)
        else
        if Sender.Origin = 'PO4' then
          aText := DataModuleMain.FormatTheFloat(Sender.Value * ParamFactor[3] * ChemFactor)
        else  //all other mg/l
          aText := DataModuleMain.FormatTheFloat(Sender.Value * ChemFactor)
      end
      else
      begin
        if Sender.Origin = 'N' then
          aText := DataModuleMain.FormatTheFloat(Sender.Value * ParamFactor[0] * ChemFactor)
        else
        if Sender.Origin = 'N_AMONIA' then
          aText := DataModuleMain.FormatTheFloat(Sender.Value * ParamFactor[2] * ChemFactor)
        else //all other mg/l
          aText := DataModuleMain.FormatTheFloat(Sender.Value * ChemFactor)
      end;
    end
    else
    if Sender.Origin = 'EC' then
      aText := DataModuleMain.FormatTheFloat(Sender.Value * ECFactor)
    else //for all others (without units/dimensions)
    if Sender.FieldDef.DataType = ftFloat then
      aText := DataModuleMain.FormatTheFloat(Sender.Value)
    else
      aText := Sender.AsString;
    if DataModuleMain.ClassTable.Active then
    begin
      if DataModuleMain.ClassTable.Locate('PARAMETER', Sender.Origin, []) then
        aText := aText + GetSymbol(Sender.Value);
    end
    else
    begin
      if DataModuleMain.StandardTable.Locate('PARAMETER', Sender.Origin, []) then
        aText := aText + GetSymbol(Sender.Value);
    end;
  end;
end;

procedure TLandscapeReportFormChem.RLReportLandscapeBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
var
  p, CWidth: Byte;
  TheRLDBText, TheRLDBMin, TheRLDBMax, TheRLDBAvg: TRLDBText;
  TheRLLabel: TRLLabel;
  SpaceAvail, NewLeft: Word;
begin
  inherited;
  ChemQuery1.Connection := DataModuleMain.ZConnectionDB;
  ChemQuery2.Connection := DataModuleMain.ZConnectionDB;
  ChemQuery3.Connection := DataModuleMain.ZConnectionDB;
  ChemQuery4.Connection := DataModuleMain.ZConnectionDB;
  ChemQuery5.Connection := DataModuleMain.ZConnectionDB;
  SummaryQuery.Connection := DataModuleMain.ZConnectionDB;
  QueryLimits.Connection := DataModuleMain.ZConnectionDB;
  QueryLookups.Connection := DataModuleMain.ZConnectionLanguage;
  ChemQuery1.Open;
  ChemQuery2.Open;
  ChemQuery3.Open;
  ChemQuery4.Open;
  ChemQuery5.Open;
  QueryLimits.Open;
  QueryLookups.Open;
  if RLBandSummary.Visible then
    SummaryQuery.Open;
  LookupList := TStringList.Create;
  LookupList.Duplicates := dupIgnore;
  //set Lengend
  with RLMemoLegend.Lines do
  begin
    Add(ChemStandardDescr);
    if DataModuleMain.ClassTable.Active then
    begin
      Add('! = Class 1');
      Add('# = Class 2');
      Add('† = Class 3');
      Add('‡ = Class 4');
    end
    else
    if DataModuleMain.StandardTable.TableName = 'SANS241' then
    begin
      Add('‡ = Value exceeds recommended limit');
    end
    else
    begin
      Add('! = Value exceeds minimum allowable limit');
      Add('# = Value exceeds recommended minimum limit');
      Add('† = Value exceeds recommended maximum limit');
      Add('‡ = Value exceeds maximum allowable limit');
    end;
    Add('Concentrations in [' + ChemUnit + '] where applicable');
  end;
  //Determine width of Labels/DBText etc.
  if ParamsList.Count >= 10 then
    SpaceAvail := 810
  else
  if ParamsList.Count < 3 then
    SpaceAvail := 240
  else
  if ParamsList.Count < 6 then
    SpaceAvail := 406
  else
  if ParamsList.Count < 8 then
    SpaceAvail := 608
  else
    SpaceAvail := 720;
  CWidth := Round(SpaceAvail/ParamsList.Count) - 2;
  NewLeft := 232; //Start of first Label/DBText
  //set labels and datasources/fields
  QueryParams.Open;
  for p := 0 to ParamsList.Count - 1 do
  begin
    //set RLDBTexts
    TheRLDBText := (FindComponent('RLDBTextParam' + IntToStr(p)) as TRLDBText);
    if ChemQuery1.FindField(ParamsList[p]) <> Nil then
      TheRLDBText.DataSource := DataSource1
    else
    if ChemQuery2.FindField(ParamsList[p]) <> Nil then
      TheRLDBText.DataSource := DataSource2
    else
    if ChemQuery3.FindField(ParamsList[p]) <> Nil then
      TheRLDBText.DataSource := DataSource3
    else
    if ChemQuery4.FindField(ParamsList[p]) <> Nil then
      TheRLDBText.DataSource := DataSource4
    else
    if ChemQuery5.FindField(ParamsList[p]) <> Nil then
      TheRLDBText.DataSource := DataSource5;
    TheRLDBText.DataField := ParamsList[p];
    TheRLDBText.Left := NewLeft;
    TheRLDBText.Width := CWidth;
    TheRLDBText.Visible:= True;
    //Set RLLabels
    TheRLLabel := (FindComponent('RLLabelParam' + IntToStr(p)) as TRLLabel);
    if QueryParams.Locate('PARAMETER', ParamsList[p], []) then
    begin
      TheRLLabel.Caption := QueryParams.FieldByName('PARA_SHORT').Value;
      if (TheRLLabel.Caption = 'NO3 as N') and not AsN then
        TheRLLabel.Caption := 'NO3';
      if (TheRLLabel.Caption = 'N_AMONIA') and not AsN then
        TheRLLabel.Caption := 'NH4';
      if (TheRLLabel.Caption = 'NO2') and AsN then
        TheRLLabel.Caption := 'NO2 as N';
      if (TheRLLabel.Caption = 'PO4') and AsN then
        TheRLLabel.Caption := 'PO4 as P';
      if QueryParams.FieldByName('UNIT').Value = 'mg/l' then
        TheRLDBText.DataSource.DataSet.FieldByName(ParamsList[p]).Tag := 1 //for calculating with chemfactor
      else
      if QueryParams.FieldByName('UNIT').Value > '' then
        TheRLLabel.Caption := TheRLLabel.Caption + ' [' + QueryParams.FieldByName('UNIT').Value + ']'
    end
    else
      TheRLLabel.Caption := ParamsList[p];
    TheRLLabel.Left := NewLeft;
    TheRLLabel.Width := CWidth;
    TheRLLabel.Visible := True;
    //set SummaryQuery Field Origins and same tag as RLDBText
    if RLBandSummary.Visible and SummaryQuery.Active then
    begin
      TheRLDBMin := (FindComponent('RLDBTextMin' + IntToStr(p)) as TRLDBText);
      TheRLDBMin.Left := NewLeft;
      TheRLDBMin.Width := CWidth;
      TheRLDBMax := (FindComponent('RLDBTextMax' + IntToStr(p)) as TRLDBText);
      TheRLDBMax.Left := NewLeft;
      TheRLDBMax.Width := CWidth;
      TheRLDBAvg := (FindComponent('RLDBTextAvg' + IntToStr(p)) as TRLDBText);
      TheRLDBAvg.Left := NewLeft;
      TheRLDBAvg.Width := CWidth;
      SummaryQuery.FieldByName('Min'+ IntToStr(p)).Origin := ParamsList[p];
      SummaryQuery.FieldByName('Max'+ IntToStr(p)).Origin := ParamsList[p];
      SummaryQuery.FieldByName('Avg'+ IntToStr(p)).Origin := ParamsList[p];
      SummaryQuery.FieldByName('Min'+ IntToStr(p)).Tag := TheRLDBText.DataSource.DataSet.FieldByName(ParamsList[p]).Tag; //for calculating with chemfactor
      SummaryQuery.FieldByName('Max'+ IntToStr(p)).Tag := TheRLDBText.DataSource.DataSet.FieldByName(ParamsList[p]).Tag; //for calculating with chemfactor
      SummaryQuery.FieldByName('Avg'+ IntToStr(p)).Tag := TheRLDBText.DataSource.DataSet.FieldByName(ParamsList[p]).Tag; //for calculating with chemfactor
    end;
    NewLeft := NewLeft + 2 + CWidth;
  end;
  QueryParams.Close;
end;

procedure TLandscapeReportFormChem.RLReportLandscapeAfterPrint(Sender: TObject);
begin
  inherited;
  ChemQuery1.Close;
  ChemQuery2.Close;
  ChemQuery3.Close;
  ChemQuery4.Close;
  ChemQuery5.Close;
  QueryLimits.Close;
  SummaryQuery.Close;
  QueryLookups.Close;
  LookupList.Free;
end;

procedure TLandscapeReportFormChem.ChemQueryGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
var
  Limit: ShortString;
begin
  if Sender.IsNull or (Sender.Value = -1) then
    DisplayText := False
  else
  begin
    if QueryLimits.Locate('CPARAMETER', Sender.FieldName, []) then
      Limit := QueryLimitsLIMITS.AsString + ' '
    else
      Limit := '';
    if Sender.Tag = 1 then //the mg/l
    begin
      if AsN then
      begin
        if Sender.FieldName = 'NO2' then
          aText := Limit + DataModuleMain.FormatTheFloat(Sender.Value * ParamFactor[1] * ChemFactor)
        else
        if Sender.FieldName = 'PO4' then
          aText := Limit + DataModuleMain.FormatTheFloat(Sender.Value * ParamFactor[3] * ChemFactor)
        else
          aText := Limit + DataModuleMain.FormatTheFloat(Sender.Value * ChemFactor)
      end
      else
      begin
        if Sender.FieldName = 'N' then
          aText := Limit + DataModuleMain.FormatTheFloat(Sender.Value * ParamFactor[0] * ChemFactor)
        else
        if Sender.FieldName = 'N_AMONIA' then
          aText := Limit + DataModuleMain.FormatTheFloat(Sender.Value * ParamFactor[2] * ChemFactor)
        else
          aText := Limit + DataModuleMain.FormatTheFloat(Sender.Value * ChemFactor)
      end;
    end
    else
    if Sender.FieldName = 'EC' then
      aText := Limit + DataModuleMain.FormatTheFloat(Sender.Value * ECFactor)
    else //for all others (without units/dimensions)
    if Sender.FieldDef.DataType = ftFloat then
      aText := Limit + DataModuleMain.FormatTheFloat(Sender.Value)
    else
      aText := Limit + Sender.AsString;
    if DataModuleMain.ClassTable.Active then
    begin
      if DataModuleMain.ClassTable.Locate('PARAMETER', Sender.FieldName, []) then
        aText := aText + GetSymbol(Sender.AsFloat);
    end
    else
    begin
      if DataModuleMain.StandardTable.Locate('PARAMETER', Sender.FieldName, []) then
        aText := aText + GetSymbol(Sender.AsFloat);
    end;
  end;
end;

procedure TLandscapeReportFormChem.FooterBandAfterPrint(Sender: TObject);
begin
  LookupList.Clear;
end;

procedure TLandscapeReportFormChem.FooterBandBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  RLMemoLookups.Lines.Clear;
  RLMemoLookups.Lines.Add('Sample Types:');
  RLMemoLookups.Lines.AddStrings(LookupList);
end;

procedure TLandscapeReportFormChem.QueryParamsBeforeOpen(DataSet: TDataSet);
begin
  QueryParams.Connection := DataModuleMain.ZConnectionLanguage;
end;

procedure TLandscapeReportFormChem.RLBandSummaryBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  with SummaryQuery do
  if Active then
    if FieldByName('Min0').Value = FieldByName('Max0').Value then
      PrintIt := False
    else
      PrintIt := True;
end;

procedure TLandscapeReportFormChem.RLDBText8AfterPrint(Sender: TObject);
var
  TheLookup: ShortString;
begin
  TheLookup := ':';
  if QueryLookups.Locate('SEARCH', (Sender as TRLDBText).DataSource.DataSet.FieldByName('SAMPL_TYPE').Value, []) then
    TheLookup := QueryLookups.FieldByName('SEARCH').AsString + ': ' + QueryLookups.FieldByName('DESCRIBE').AsString;
  if (TheLookup[1] <> ':') and (LookupList.IndexOf(TheLookup) = -1) then
    LookupList.Add(TheLookup);
end;

end.

