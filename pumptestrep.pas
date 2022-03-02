{ Copyright (C) 2022 Immo Blecher, immo@blecher.co.za

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
unit PumpTestRep;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, RLReport, TAGraph, TATransformations,
  TASeries, TATypes, TAChartUtils, TASources, TAChartAxis, TAChartAxisUtils,
  ZDataset, ZConnection, Forms, Controls, Graphics, Dialogs;

type

  { TPumpTestRepForm }

  TPumpTestRepForm = class(TForm)
    BasicinfDataSource: TDataSource;
    BasicinfTable: TZTable;
    BasicinfTableALTITUDE: TFloatField;
    BasicinfTableALT_NO_1: TStringField;
    BasicinfTableALT_NO_2: TStringField;
    BasicinfTableBH_DIAM: TFloatField;
    BasicinfTableCOLLAR_HI: TFloatField;
    BasicinfTableDEPTH: TFloatField;
    BasicinfTableFARM_NR: TStringField;
    BasicinfTableNR_ON_MAP: TStringField;
    BasicinfTableREP_INST: TStringField;
    BasicinfTableSITE_ID_NR: TStringField;
    BasicinfTableSITE_NAME: TStringField;
    BasicinfTableSITE_PURPS: TStringField;
    BasicinfTableSITE_STATU: TStringField;
    BasicinfTableSITE_TYPE: TStringField;
    BasicinfTableUSE_APPLIC: TStringField;
    BasicinfTableUSE_CONSUM: TStringField;
    BasicinfTableX_COORD: TFloatField;
    BasicinfTableY_COORD: TFloatField;
    BottomAxisTransformations: TChartAxisTransformations;
    BottomAxisTransform: TLogarithmAxisTransform;
    DischargeBand: TRLBand;
    DischargeDataSource: TDataSource;
    DischargeQueryCOMMENT: TStringField;
    DischargeQueryDATE_MEAS: TStringField;
    DischargeQueryDISCH_RATE: TFloatField;
    DischargeQueryDISCH_TYPE: TStringField;
    DischargeQueryMETH_MEAS: TStringField;
    DischargeQuerySITE_ID_NR: TStringField;
    DischargeQueryTIME_MEAS: TStringField;
    DischargeRLBand: TRLBand;
    DischargeSubDetail: TRLSubDetail;
    LeftAxisTransformations: TChartAxisTransformations;
    RightAxisTransformations: TChartAxisTransformations;
    CommentMemo: TRLMemo;
    ConstantWLQueryDATE_MEAS: TStringField;
    ConstantWLQueryPIEZOM_NR: TStringField;
    ConstantWLQuerySITE_ID_NR: TStringField;
    ConstantWLQueryTIME_MEAS: TStringField;
    ConstantWLQueryWATER_LEV: TFloatField;
    CoordLabel: TRLLabel;
    DataSourcePTest: TDataSource;
    CDischargeQuery: TZReadOnlyQuery;
    FooterBand: TRLBand;
    LeftAxisAutoScale: TAutoScaleAxisTransform;
    PumpTestBand: TRLBand;
    PumpTestReport: TRLReport;
    PumpTestSubDetail: TRLSubDetail;
    RightAxisAutoScale: TAutoScaleAxisTransform;
    RLBand1: TRLBand;
    RLBand5: TRLBand;
    RLBand6: TRLBand;
    RLBandConstant: TRLBand;
    RLBandHeader: TRLBand;
    RLBandMulti: TRLBand;
    RLDBMemo1: TRLDBMemo;
    RLDBMemo2: TRLDBMemo;
    RLDBText1: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText12: TRLDBText;
    RLDBText13: TRLDBText;
    RLDBText131: TRLDBText;
    RLDBText132: TRLDBText;
    RLDBText133: TRLDBText;
    RLDBText134: TRLDBText;
    RLDBText135: TRLDBText;
    RLDBText136: TRLDBText;
    RLDBText139: TRLDBText;
    RLDBText14: TRLDBText;
    RLDBText140: TRLDBText;
    RLDBText141: TRLDBText;
    RLDBText142: TRLDBText;
    RLDBText143: TRLDBText;
    RLDBText144: TRLDBText;
    RLDBText145: TRLDBText;
    RLDBText147: TRLDBText;
    RLDBText15: TRLDBText;
    RLDBText17: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText73: TRLDBText;
    RLDBText74: TRLDBText;
    RLDBText75: TRLDBText;
    RLDBText76: TRLDBText;
    RLDBText77: TRLDBText;
    RLDBText78: TRLDBText;
    RLDBText79: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText80: TRLDBText;
    RLDBText84: TRLDBText;
    RLDBText85: TRLDBText;
    RLDBText86: TRLDBText;
    RLDBText87: TRLDBText;
    RLDBText88: TRLDBText;
    RLDBText89: TRLDBText;
    RLDBText9: TRLDBText;
    RLDBText90: TRLDBText;
    RLDBText91: TRLDBText;
    RLDBText92: TRLDBText;
    RLDBText93: TRLDBText;
    RLDBText94: TRLDBText;
    RLDBText95: TRLDBText;
    RLDBText96: TRLDBText;
    RLDBText97: TRLDBText;
    RLDBText98: TRLDBText;
    RLDBText99: TRLDBText;
    RLDBTextX_COORD: TRLDBText;
    RLDBTextY_COORD: TRLDBText;
    RLImageLogo: TRLImage;
    RLLabel10: TRLLabel;
    RLLabel100: TRLLabel;
    RLLabel101: TRLLabel;
    RLLabel102: TRLLabel;
    RLLabel103: TRLLabel;
    RLLabel104: TRLLabel;
    RLLabel105: TRLLabel;
    RLLabel106: TRLLabel;
    RLLabel108: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel112: TRLLabel;
    RLLabel113: TRLLabel;
    RLLabel114: TRLLabel;
    RLLabel115: TRLLabel;
    RLLabel116: TRLLabel;
    RLLabel117: TRLLabel;
    RLLabel118: TRLLabel;
    RLLabel119: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel120: TRLLabel;
    RLLabel121: TRLLabel;
    RLLabel122: TRLLabel;
    RLLabel123: TRLLabel;
    RLLabel124: TRLLabel;
    RLLabel125: TRLLabel;
    RLLabel126: TRLLabel;
    RLLabel127: TRLLabel;
    RLLabel128: TRLLabel;
    RLLabel129: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel130: TRLLabel;
    RLLabel131: TRLLabel;
    RLLabel132: TRLLabel;
    RLLabel133: TRLLabel;
    RLLabel134: TRLLabel;
    RLLabel135: TRLLabel;
    RLLabel136: TRLLabel;
    RLLabel137: TRLLabel;
    RLLabel138: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel17: TRLLabel;
    RLLabel192: TRLLabel;
    RLLabel193: TRLLabel;
    RLLabel194: TRLLabel;
    RLLabel195: TRLLabel;
    RLLabel196: TRLLabel;
    RLLabel197: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel200: TRLLabel;
    RLLabel201: TRLLabel;
    RLLabel202: TRLLabel;
    RLLabel203: TRLLabel;
    RLLabel204: TRLLabel;
    RLLabel205: TRLLabel;
    RLLabel206: TRLLabel;
    RLLabel207: TRLLabel;
    RLLabel208: TRLLabel;
    RLLabel210: TRLLabel;
    RLLabel211: TRLLabel;
    RLLabel212: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel91: TRLLabel;
    RLLabel92: TRLLabel;
    RLLabel94: TRLLabel;
    RLLabel95: TRLLabel;
    RLLabel96: TRLLabel;
    RLLabel97: TRLLabel;
    RLLabel98: TRLLabel;
    RLLabel99: TRLLabel;
    RLLabelPiez: TRLLabel;
    RLLabelWLDate: TRLLabel;
    RLMemoUserDetails: TRLMemo;
    RLReport1: TRLReport;
    RLSystemInfoDate: TRLSystemInfo;
    RLSystemInfoPageNr: TRLSystemInfo;
    RLSystemInfoTitle: TRLSystemInfo;
    StepQuery: TZReadOnlyQuery;
    TestingBand: TRLBand;
    TestingQueryCALIBR_YLD: TFloatField;
    TestingQueryQ_ST: TFloatField;
    ListChartSourceMarks: TListChartSource;
    MultiRateWLQueryDATE_MEAS: TStringField;
    MultiRateWLQueryPIEZOM_NR: TStringField;
    MultiRateWLQuerySITE_ID_NR: TStringField;
    MultiRateWLQueryTIME_MEAS: TStringField;
    MultiRateWLQueryWATER_LEV: TFloatField;
    PumpTestQueryDATE_END: TStringField;
    PumpTestQueryDATE_START: TStringField;
    PumpTestQueryDEPTH_INTK: TFloatField;
    PumpTestQueryMETH_TESTD: TStringField;
    PumpTestQueryREP_INST: TStringField;
    PumpTestQuerySITE_ID_NR: TStringField;
    PumpTestQuerySTORATIV_0: TFloatField;
    PumpTestQueryTIME_END: TStringField;
    PumpTestQueryTIME_START: TStringField;
    PumpTestQueryTRANSMIS_0: TFloatField;
    TestingDataSource: TDataSource;
    TestingQueryDEPTH_INTK: TFloatField;
    TestingQueryDESCRIPTN: TStringField;
    TestingQueryDISCH_RATE: TFloatField;
    TestingQueryDRAWDOWN: TFloatField;
    TestingQueryDURATION: TLongintField;
    TestingQueryDURA_RECOV: TLongintField;
    TestingQueryPERC_RECOV: TLongintField;
    TestingQueryPERMEABIL: TFloatField;
    TestingQueryRECOVERY: TFloatField;
    TestingQuerySITE_ID_NR: TStringField;
    TestingQuerySPEC_CAP: TFloatField;
    TestingQuerySTORAGE: TFloatField;
    TestingQueryTIME_START: TStringField;
    TestingQueryTRANSMISS: TFloatField;
    TestingSubDetail: TRLSubDetail;
    WaterlevBand: TRLBand;
    WaterlevDataSource: TDataSource;
    WaterlevDataSourceBasic: TDataSource;
    WaterlevQueryBasic: TZReadOnlyQuery;
    WaterlevQueryBasicDATE_MEAS: TStringField;
    WaterlevQueryBasicPIEZOM_NR: TStringField;
    WaterlevQueryBasicSITE_ID_NR: TStringField;
    WaterlevQueryBasicWATER_LEV: TFloatField;
    PumpTestQuery: TZReadOnlyQuery;
    MultiRateWLQuery: TZReadOnlyQuery;
    ConstantWLQuery: TZReadOnlyQuery;
    TestingQuery: TZReadOnlyQuery;
    MDischargeQuery: TZReadOnlyQuery;
    WaterlevQueryCOMMENT: TStringField;
    WaterlevQueryDATE_MEAS: TStringField;
    WaterlevQueryLEVEL_STAT: TStringField;
    WaterlevQueryMETH_MEAS: TStringField;
    WaterlevQueryPIEZOM_NR: TStringField;
    WaterlevQuerySITE_ID_NR: TStringField;
    WaterlevQueryTIME_MEAS: TStringField;
    WaterlevQueryTIME_SEC: TFloatField;
    WaterlevQueryWATER_LEV: TFloatField;
    WaterlevRLBand: TRLBand;
    WaterlevSubDetail: TRLSubDetail;
    X_CoordLabel: TRLLabel;
    Y_CoordLabel: TRLLabel;
    DischargeQuery: TZReadOnlyQuery;
    WaterlevQuery: TZReadOnlyQuery;
    procedure BasicinfTableALTITUDEGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfTableBeforeOpen(DataSet: TDataSet);
    procedure BasicinfTableBH_DIAMGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfTableCOLLAR_HIGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfTableDEPTHGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfTableSITE_ID_NRGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure CDischargeQueryBeforeOpen(DataSet: TDataSet);
    procedure DischargeQueryBeforeOpen(DataSet: TDataSet);
    procedure DischargeQueryDATE_MEASGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure DischargeQueryDISCH_RATEGetText(Sender: TField;
      var aText: string; DisplayText: Boolean);
    procedure DischargeQueryTIME_MEASGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure MDischargeQueryBeforeOpen(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure LookupsGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfTableX_COORDGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfTableY_COORDGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure ConstantWLQueryBeforeOpen(DataSet: TDataSet);
    procedure MultiRateWLQueryBeforeOpen(DataSet: TDataSet);
    procedure ColumnBandBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure PumpTestQueryBeforeOpen(DataSet: TDataSet);
    procedure PumpTestQueryDATE_ENDGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure PumpTestQueryDATE_STARTGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure PumpTestQueryDEPTH_INTKGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure PumpTestQueryTIME_ENDGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure PumpTestQueryTIME_STARTGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure PumpTestReportAfterPrint(Sender: TObject);
    procedure PumpTestReportBeforePrint(Sender: TObject; var PrintIt: boolean);
    procedure RLBandConstantBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBandHeaderBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBandMultiBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure StepQueryBeforeOpen(DataSet: TDataSet);
    procedure TestingQueryBeforeOpen(DataSet: TDataSet);
    procedure TestingQueryCalcFields(DataSet: TDataSet);
    procedure TestingQueryCALIBR_YLDGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure TestingQueryDEPTH_INTKGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure TestingQueryDISCH_RATEGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure TestingQueryDRAWDOWNGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure TestingQueryQ_STGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure TestingQueryRECOVERYGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure TestingQueryTIME_STARTGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure WaterlevQueryBasicBeforeOpen(DataSet: TDataSet);
    procedure WaterlevQueryBasicDATE_MEASGetText(Sender: TField;
      var aText: string; DisplayText: Boolean);
    procedure WaterlevQueryBasicWATER_LEVGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure WaterlevQueryBeforeOpen(DataSet: TDataSet);
    procedure WaterlevQueryDATE_MEASGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure WaterlevQueryTIME_MEASGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure WaterlevQueryWATER_LEVGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
  private
    { private declarations }
    XCoord, YCoord: ShortString;
  public
    { public declarations }
    MRateStartDate, MRateStartTime, MRateEndDate, MRateEndTime, MultiPiezo: ShortString;
    ConstStartDate, ConstStartTime, ConstEndDate, ConstEndTime, ConstPiezo: ShortString;
    HiRes, DDown, ShowMulti, ShowConstant, MUseLeft, MUseTime: Boolean;
    CUseLeft, CUseTime, ShowAllTests, SeriesShowPnts, StepsShowPnts, DischShowPnts: Boolean;
    ChartBandHeight, ConstLMax, ConstLMin, ConstTMax, ConstTMin, NrSteps: Word;
    MLeftAxisTitle, WLDateTime, ConstantTitle, MultiTitle: ShortString;
    MLeftAxisRangeMax, MLeftAxisRangeMin, MBottomAxisRangeMax, MBottomAxisRangeMin: Real;
    SerColr, StepsColr, DischColr: TColor;
    ResFactor, LineWidth: Byte;
  end;

var
  PumpTestRepForm: TPumpTestRepForm;

implementation

{$R *.lfm}

uses VARINIT, StrDateTime, MainDataModule;

{ TPumpTestRepForm }

procedure TPumpTestRepForm.LookupsGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull and (not PrintNoInfo) then DisplayText := False
  else
    aText := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
end;

procedure TPumpTestRepForm.BasicinfTableALTITUDEGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNULL then DisplayText := False
  else
  begin
    if Sender.AsFloat > 0 then
    begin
      if Sender.AsFloat * LengthFactor > 10000 then
        aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
      else
      if Sender.AsFloat * LengthFactor < 0.01 then
        aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
      else
        aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
    end
    else
    if Sender.AsFloat < 0 then
    begin
      if Sender.AsFloat * LengthFactor < -10000 then
        aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
      else
      if Sender.AsFloat * LengthFactor > -0.01 then
        aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
      else
        aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
    end
    else aText := '0.00';
  end;
end;

procedure TPumpTestRepForm.BasicinfTableBeforeOpen(DataSet: TDataSet);
begin
  BasicinfTable.Connection := DataModuleMain.ZConnectionDB;
  Dataset.Filter := 'SITE_ID_NR = ' + QuotedStr(CurrentSite);
  Dataset.Filtered := True;
end;

procedure TPumpTestRepForm.BasicinfTableBH_DIAMGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if BasicinfTableBH_DIAM.Value > 0 then
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(BasicinfTableBH_DIAM.Value * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(BasicinfTableBH_DIAM.Value * DiamFactor, ffFixed, 15, 2);
  end
  else aText := '';
end;

procedure TPumpTestRepForm.BasicinfTableCOLLAR_HIGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.AsFloat > 0 then
  begin
    if Sender.AsFloat * LengthFactor > 100 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
    else
    if Sender.AsFloat * LengthFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end
  else
    aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
end;

procedure TPumpTestRepForm.BasicinfTableDEPTHGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value > 0 then
  begin
    if Sender.Value * LengthFactor > 1000 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
    else
    if Sender.Value * LengthFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end;
end;

procedure TPumpTestRepForm.BasicinfTableSITE_ID_NRGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := Sender.Value;
  with DataModuleMain do
    cs2cs(BasicinfQueryX_COORD.AsString, BasicinfQueryY_COORD.AsString, GetMapRef(BasicinfQuerySITE_ID_NR.AsString), OrigCoordSysNr, CoordSysNr, XCoord, YCoord);
end;

procedure TPumpTestRepForm.CDischargeQueryBeforeOpen(DataSet: TDataSet);
begin
  CDischargeQuery.Connection := DataModuleMain.ZConnectionDB;
  with CDischargeQuery.SQL do
  begin
    Add('SELECT SITE_ID_NR, DATE_MEAS, TIME_MEAS, DISCH_RATE from discharg');
    Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
    if DataModuleMain.ZConnectionDB.Protocol = 'sqlite-3' then
    begin
      Add('AND DATE_MEAS || TIME_MEAS >= ' + QuotedStr(ConstStartDate + ConstStartTime));
      Add('AND DATE_MEAS || TIME_MEAS <= ' + QuotedStr(ConstEndDate + ConstEndTime));
    end
    else
    begin
      Add('AND CONCAT(DATE_MEAS, TIME_MEAS) >= ' + QuotedStr(ConstStartDate + ConstStartTime));
      Add('AND CONCAT(DATE_MEAS, TIME_MEAS) <= ' + QuotedStr(ConstEndDate + ConstEndTime));
    end;
    Add('ORDER BY DATE_MEAS, TIME_MEAS');
  end;
end;

procedure TPumpTestRepForm.DischargeQueryBeforeOpen(DataSet: TDataSet);
begin
  DischargeQuery.Connection := DataModuleMain.ZConnectionDB;
  with DischargeQuery.SQL do
  begin
    Add('SELECT * FROM discharg');
    Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
    if DataModuleMain.ZConnectionDB.Tag = 1 then
    begin
      Add('AND (DATE_MEAS || TIME_MEAS >= ' + QuotedStr(MRateStartDate + MRateStartTime));
      Add('AND DATE_MEAS || TIME_MEAS <= ' + QuotedStr(MRateEndDate + MRateEndTime) + ')');
      Add('OR (DATE_MEAS || TIME_MEAS >= ' + QuotedStr(ConstStartDate + ConstStartTime));
      Add('AND DATE_MEAS || TIME_MEAS <= ' + QuotedStr(ConstEndDate + ConstEndTime) + ')');
    end
    else
    begin
      Add('AND (CONCAT(DATE_MEAS, TIME_MEAS) >= ' + QuotedStr(MRateStartDate + MRateStartTime));
      Add('AND CONCAT(DATE_MEAS, TIME_MEAS) <= ' + QuotedStr(MRateEndDate + MRateEndTime) + ')');
      Add('OR (CONCAT(DATE_MEAS, TIME_MEAS) >= ' + QuotedStr(ConstStartDate + ConstStartTime));
      Add('AND CONCAT(DATE_MEAS, TIME_MEAS) <= ' + QuotedStr(ConstEndDate + ConstEndTime) + ')');
    end;
    Add('ORDER BY DATE_MEAS, TIME_MEAS');
  end;
end;

procedure TPumpTestRepForm.DischargeQueryDATE_MEASGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := DateToStr(StringToDate(Sender.AsString));
end;

procedure TPumpTestRepForm.DischargeQueryDISCH_RATEGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.AsFloat = 0 then
   aText := '0.00'
  else
  if Sender.AsFloat * VolumeFactor * TimeFactor > 100000 then
    aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 0)
  else
  if (Sender.AsFloat * VolumeFactor * TimeFactor < 0.01) and (Sender.AsFloat * VolumeFactor * TimeFactor > 0) then
    aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 5)
  else
  if Sender.AsFloat * VolumeFactor * TimeFactor = 0 then DisplayText := False
  else
    aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 2);
end;

procedure TPumpTestRepForm.DischargeQueryTIME_MEASGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := FormatDateTime('hh:nn', EncodeTime(StrToInt(Copy(Sender.AsString, 1, 2)), StrToInt(Copy(Sender.AsString, 3, 2)), 0, 0));
end;

procedure TPumpTestRepForm.FormCreate(Sender: TObject);
var
  c: Word;
begin
  for c := 0 to ComponentCount - 1 do
  if Components[c] is TControl then
  begin
    with (Components[c] as TControl).Font do
    begin
      Name := ReportFont.Name;
      Color := ReportFont.Color;
      if Components[c] is TRLLabel then
      begin
        Style := [fsBold];
        case Components[c].Tag of
          0: Size := ReportFont.Size;
          1: Size := ReportFont.Size + 2;
          2: Size := ReportFont.Size - 2;
        end;
      end
      else
      if Components[c] is TRLSystemInfo then
      begin
        Size := ReportFont.Size + Components[c].Tag;
        if Components[c].Tag = 2 then
          Style := [fsBold,fsItalic];
      end
      else
      begin
        Size := ReportFont.Size;
        Style := ReportFont.Style;
      end;
    end;
    if (Components[c] is TRLBand) and (TRLBand(Components[c]).GroupIndex >= 3)
      then TRLBand(Components[c]).Color := ColumnHeaderBandColor;
  end;
end;

procedure TPumpTestRepForm.MDischargeQueryBeforeOpen(DataSet: TDataSet);
begin
  MDischargeQuery.Connection := DataModuleMain.ZConnectionDB;
  with MDischargeQuery.SQL do
  begin
    Add('SELECT SITE_ID_NR, DATE_MEAS, TIME_MEAS, DISCH_RATE FROM discharg');
    Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
    if DataModuleMain.ZConnectionDB.Protocol = 'sqlite-3' then
    begin
      Add('AND DATE_MEAS || TIME_MEAS >= ' + QuotedStr(MRateStartDate + MRateStartTime));
      Add('AND DATE_MEAS || TIME_MEAS <= ' + QuotedStr(MRateEndDate + MRateEndTime));
    end
    else
    begin
      Add('AND CONCAT(DATE_MEAS, TIME_MEAS) >= ' + QuotedStr(MRateStartDate + MRateStartTime));
      Add('AND CONCAT(DATE_MEAS, TIME_MEAS) <= ' + QuotedStr(MRateEndDate + MRateEndTime));
    end;
    Add('ORDER BY DATE_MEAS, TIME_MEAS');
  end;
end;

procedure TPumpTestRepForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TPumpTestRepForm.BasicinfTableX_COORDGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := XCoord;
end;

procedure TPumpTestRepForm.BasicinfTableY_COORDGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := YCoord;
end;

procedure TPumpTestRepForm.ConstantWLQueryBeforeOpen(DataSet: TDataSet);
begin
  ConstantWLQuery.Connection := DataModuleMain.ZConnectionDB;
  with ConstantWLQuery.SQL do
  begin
    Add('SELECT SITE_ID_NR, PIEZOM_NR, DATE_MEAS, TIME_MEAS, WATER_LEV from waterlev');
    Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
    if DataModuleMain.ZConnectionDB.Tag = 1 then
    begin
      Add('AND DATE_MEAS || TIME_MEAS >= ' + QuotedStr(ConstStartDate + ConstStartTime));
      Add('AND DATE_MEAS || TIME_MEAS <= ' + QuotedStr(ConstEndDate + ConstEndTime));
    end
    else
    begin
      Add('AND CONCAT(DATE_MEAS, TIME_MEAS) >= ' + QuotedStr(ConstStartDate + ConstStartTime));
      Add('AND CONCAT(DATE_MEAS, TIME_MEAS) <= ' + QuotedStr(ConstEndDate + ConstEndTime));
    end;
    Add('AND PIEZOM_NR = ' + QuotedStr(ConstPiezo));
    Add('ORDER BY DATE_MEAS, TIME_MEAS');
  end;
end;

procedure TPumpTestRepForm.MultiRateWLQueryBeforeOpen(DataSet: TDataSet);
begin
  MultiRateWLQuery.Connection := DataModuleMain.ZConnectionDB;
  with MultiRateWLQuery.SQL do
  begin
    Add('SELECT SITE_ID_NR, PIEZOM_NR, DATE_MEAS, TIME_MEAS, WATER_LEV from waterlev');
    Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
    if DataModuleMain.ZConnectionDB.Tag = 1 then
    begin
      Add('AND DATE_MEAS || TIME_MEAS >= ' + QuotedStr(MRateStartDate + MRateStartTime));
      Add('AND DATE_MEAS || TIME_MEAS <= ' + QuotedStr(MRateEndDate + MRateEndTime));
    end
    else
    begin
      Add('AND CONCAT(DATE_MEAS, TIME_MEAS) >= ' + QuotedStr(MRateStartDate + MRateStartTime));
      Add('AND CONCAT(DATE_MEAS, TIME_MEAS) <= ' + QuotedStr(MRateEndDate + MRateEndTime));
    end;
    Add('AND PIEZOM_NR = ' + QuotedStr(MultiPiezo));
    Add('ORDER BY DATE_MEAS, TIME_MEAS');
  end;
end;

procedure TPumpTestRepForm.ColumnBandBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  TRLBand(Sender).Color := ColumnHeaderBandColor;
end;

procedure TPumpTestRepForm.PumpTestQueryBeforeOpen(DataSet: TDataSet);
begin
  with PumpTestQuery do
  begin
    Connection := DataModuleMain.ZConnectionDB;
    SQL.Add('SELECT * FROM pumptest');
    SQL.Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
    if not ShowAllTests then
    begin
      if Connection.Tag = 1 then
      begin
        SQL.Add('AND (DATE_START || TIME_START >= ' + QuotedStr(MRateStartDate + MRateStartTime));
        SQL.Add('AND DATE_END || TIME_END <= ' + QuotedStr(MRateEndDate + MRateEndTime) + ')');
        SQL.Add('OR (DATE_START || TIME_START >= ' + QuotedStr(ConstStartDate + ConstStartTime));
        SQL.Add('AND DATE_END || TIME_END <= ' + QuotedStr(ConstEndDate + ConstEndTime) + ')');
      end
      else
      begin
        SQL.Add('AND (CONCAT(DATE_START, TIME_START) >= ' + QuotedStr(MRateStartDate + MRateStartTime));
        SQL.Add('AND CONCAT(DATE_END, TIME_END) <= ' + QuotedStr(MRateEndDate + MRateEndTime) + ')');
        SQL.Add('OR (CONCAT(DATE_START, TIME_START) >= ' + QuotedStr(ConstStartDate + ConstStartTime));
        SQL.Add('AND CONCAT(DATE_END, TIME_END) <= ' + QuotedStr(ConstEndDate + ConstEndTime) + ')');
      end;
    end;
    SQL.Add('ORDER BY DATE_START, TIME_START');
  end;
end;

procedure TPumpTestRepForm.PumpTestQueryDATE_ENDGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := DateToStr(StringToDate(Sender.AsString));
end;

procedure TPumpTestRepForm.PumpTestQueryDATE_STARTGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := DateToStr(StringToDate(Sender.AsString));
end;

procedure TPumpTestRepForm.PumpTestQueryDEPTH_INTKGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.AsFloat > 0 then
  begin
    if Sender.AsFloat * LengthFactor > 100 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2)
    else
    if Sender.AsFloat * LengthFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end
  else aText := '';
end;

procedure TPumpTestRepForm.PumpTestQueryTIME_ENDGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := FormatDateTime('hh:nn', EncodeTime(StrToInt(Copy(Sender.AsString, 1, 2)), StrToInt(Copy(Sender.AsString, 3, 2)), 0, 0));
end;

procedure TPumpTestRepForm.PumpTestQueryTIME_STARTGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := FormatDateTime('hh:nn', EncodeTime(StrToInt(Copy(Sender.AsString, 1, 2)), StrToInt(Copy(Sender.AsString, 3, 2)), 0, 0));
end;

procedure TPumpTestRepForm.PumpTestReportAfterPrint(Sender: TObject);
begin
  //Close tables
  BasicinfTable.Close;
  WaterlevQueryBasic.Close;
  TestingQuery.Close;
  PumpTestQuery.Close;
  WaterlevQuery.Close;
  DischargeQuery.Close;
end;

procedure TPumpTestRepForm.PumpTestReportBeforePrint(Sender: TObject;
  var PrintIt: boolean);
begin
  //set report fonts
  Coordlabel.Caption := 'Coordinate System: ' + CoordSysDescr;
  CoordLabel.Font.Size := ReportFont.Size - 1;
  with PumpTestReport do
  begin
    Margins.LeftMargin := LeftMargin;
    Margins.TopMargin := TopMargin;
    Margins.BottomMargin := BotMargin;
    Margins.RightMargin := 10 - LeftMargin + 10;
  end;
  //Set Labels of coordinate edits
  if dstLO then
  begin
    Y_CoordLabel.Caption := 'Y Coord. ' + '[' + LengthUnit + ']';
    X_CoordLabel.Caption := 'X Coord. ' + '[' + LengthUnit + ']';
  end
  else
  if dstLatLong then //is lat/long
  begin
    if ShowDMS then //show Degrees, minutes, seconds
    begin
      X_CoordLabel.Caption := 'Longitude [° '' "]';
      Y_CoordLabel.Caption := 'Latitude [° '' "]';
    end
    else
    begin
      X_CoordLabel.Caption := 'Longitude [°]';
      Y_CoordLabel.Caption := 'Latitude [°]';
    end;
  end
  else
  begin
    X_CoordLabel.Caption := 'Easting ' + '[' + LengthUnit + ']';
    Y_CoordLabel.Caption := 'Northing ' + '[' + LengthUnit + ']';
  end;
  {Set Units in labels}
  RLLabel10.Caption := RLLabel10.Caption + ' [' + LengthUnit + ']:';
  RLLabel14.Caption := RLLabel14.Caption + ' [' + DiamUnit + ']:';
  RLLabel15.Caption := RLLabel15.Caption + ' [' + LengthUnit + ']:';
  RLLabel16.Caption := RLLabel16.Caption + ' [' + LengthUnit + ']:';
  RLLabel17.Caption := RLLabel17.Caption + ' [' + LengthUnit + ']:';
  RLLabel108.Caption := RLLabel108.Caption + ' [' + LengthUnit + ']';
  RLLabel123.Caption := RLLabel123.Caption + ' [' + LengthUnit + ']';
  RLLabel120.Caption := RLLabel120.Caption + ' [' + DisUnit + ']';
  RLLabel138.Caption := RLLabel138.Caption + ' [' + DisUnit + ']';
  RLLabel118.Caption := '[' + LengthUnit + ']';
  RLLabel126.Caption := '[' + LengthUnit + ']';
  if FileExists(WSpaceDir + DirectorySeparator + 'userlogo.jpg') then
    RLImageLogo.Picture.LoadFromFile(WSpaceDir + DirectorySeparator + 'userlogo.jpg')
  else
  if FileExists(WSpaceDir + DirectorySeparator + 'userlogo.bmp') then
    RLImageLogo.Picture.LoadFromFile(WSpaceDir + DirectorySeparator + 'userlogo.bmp');
  //Open all tables
  Screen.Cursor := crSQLWait;
  Sleep(100); //to process the messages and show components of forms
  Application.ProcessMessages;
  BasicinfTable.Open;
  if FileExists(WSpaceDir + DirectorySeparator + 'Userinfo.txt') then
    RLMemoUserDetails.Lines.LoadFromFile(WSpaceDir + DirectorySeparator + 'Userinfo.txt')
  else
    RLMemoUserDetails.Lines.Add(DataModuleMain.TranslateCode('REP_INST', BasicinfTableREP_INST.AsString));
  WaterlevQueryBasic.Open;
  PumpTestQuery.Open;
  TestingQuery.Open;
  DischargeQuery.Active := DischargeSubDetail.Visible;
  WaterlevQuery.Active := WaterlevSubDetail.Visible;
  Screen.Cursor := crDefault;
  Application.ProcessMessages;
  //enable relevant bands
  PumpTestBand.Enabled := PumpTestQuery.Active;
  PumpTestSubDetail.Enabled := PumpTestQuery.Active;
  TestingBand.Enabled := TestingQuery.Active;
  TestingSubDetail.Enabled := TestingQuery.Active;
end;

procedure TPumpTestRepForm.RLBandConstantBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
var bmp: TBitmap;
    ConstantChart: TChart;
    CRightAxis: TChartAxis;
    ConstantSeries, CDisLineSeries: TLineSeries;
    CDisAreaSeries: TAreaSeries;
    Minute, StartDateTime, NewDateTime: Real;
    ConstStatWL: Real;
begin
  if ShowConstant then
  begin
    //Create the charts
    bmp := TBitmap.Create;
    ConstantChart := TChart.Create(Self);
    with ConstantChart do
    begin
      BackColor := clWhite;
      Color := clWhite;
      if HiRes then
        MarginsExternal.Right := 24
      else
        MarginsExternal.Right := 8;
      LeftAxis.Title.LabelFont.Name := ReportFont.Name;
      LeftAxis.Marks.LabelFont.Name := ReportFont.Name;
      BottomAxis.Title.LabelFont.Name := ReportFont.Name;
      BottomAxis.Marks.LabelFont.Name := ReportFont.Name;
      Title.Text.Clear;
      Title.Text.Add(ConstantTitle);
      Title.Brush.Color := clWhite;
      Title.Font.Name := ReportFont.Name;
      Title.Font.Color := clBlack;
      Title.Font.Style := [fsBold, fsItalic];
      if HiRes then
      begin
        Title.Font.Size := 9 * ResFactor;
        Title.Margins.Top := 10 * ResFactor;
      end
      else
      begin
        Title.Font.Size := 9;
        Title.Margins.Top := 10;
      end;
      Title.Visible := True;
      BottomAxis.Transformations := BottomAxisTransformations;
      BottomAxis.Title.Caption := 'Time [min] from Start';
      BottomAxis.Marks.LabelFont.Orientation := 900;
      BottomAxis.Marks.LabelFont.Quality := fqAntialiased;
      BottomAxis.Marks.Format := '%.0f';
      BottomAxis.Marks.Source := ListChartSourceMarks;
      if HiRes then
      begin
        BottomAxis.Marks.LabelFont.Size := 7 * ResFactor;
        BottomAxis.Margin := 5 * ResFactor;
        BottomAxis.Title.LabelFont.Size := 9 * ResFactor;
        BottomAxis.AxisPen.Width := ResFactor;
        BottomAxis.Grid.Width := ResFactor;
      end
      else
      begin
        BottomAxis.Marks.LabelFont.Size := 7;
        BottomAxis.Margin := 5;
        BottomAxis.Title.LabelFont.Size := 9;
      end;
      BottomAxis.Intervals.Options := [];
      BottomAxis.Title.Visible := True;
      if DDown then LeftAxis.Title.Caption := 'Drawdown [' + LengthUnit + ']'
      else LeftAxis.Title.Caption := 'Water Level [' + LengthUnit + ']';
      LeftAxis.Title.Visible := True;
      if HiRes then
      begin
        LeftAxis.Marks.LabelFont.Size := 7 * ResFactor;
        LeftAxis.Title.LabelFont.Size := 9 * ResFactor;
        LeftAxis.Margin := 5 * ResFactor;
        LeftAxis.Intervals.MinLength := 10 * ResFactor;
        LeftAxis.Intervals.MaxLength := LeftAxis.Intervals.MinLength * ResFactor;
        LeftAxis.AxisPen.Width := ResFactor;
        LeftAxis.Grid.Width := ResFactor;
      end
      else
      begin
        LeftAxis.Marks.LabelFont.Size := 7;
        LeftAxis.Title.LabelFont.Size := 9;
        LeftAxis.Margin := 5;
      end;
      LeftAxis.Transformations := LeftAxisTransformations;
      if CUseLeft then
      begin
        LeftAxis.Range.UseMax := True;
        LeftAxis.Range.UseMin := True;
        LeftAxis.Range.Max := ConstLMax;
        LeftAxis.Range.Min := ConstLMin;
      end
      else
      begin
        LeftAxis.Range.UseMax := False;
        LeftAxis.Range.UseMin := False;
      end;
      //check if Discharge must be shown, then create and set right axis
      if CDischargeQuery.Tag > 0 then
      begin
        CRightAxis := TChartAxis.Create(AxisList);
        with CRightAxis do
        begin
          Title.LabelFont.Name := ReportFont.Name;
          Title.Caption := 'Discharge Rate [' + DisUnit + ']';
          Title.LabelFont.Color := DischColr;
          Title.LabelFont.Orientation := 2700;
          Title.Visible := True;
          Marks.LabelFont.Name := ReportFont.Name;
          Alignment := calRight;
          Transformations := RightAxisTransformations;
          Grid.Visible := False;
          if HiRes then
          begin
            Marks.LabelFont.Size := 7 * ResFactor;
            Title.LabelFont.Size := 9 * ResFactor;
            Margin := 3 * ResFactor;
            Intervals.MinLength := 10 * ResFactor;
            Intervals.MaxLength := LeftAxis.Intervals.MinLength * ResFactor;
            AxisPen.Width := ResFactor;
          end
          else
          begin
            Marks.LabelFont.Size := 7;
            Title.LabelFont.Size := 9;
            Margin := 5;
          end;
        end;
      end;
      if CUseTime then
      begin
        BottomAxis.Range.UseMax := True;
        BottomAxis.Range.UseMin := True;
        BottomAxis.Range.Max := ConstTMax;
        BottomAxis.Range.Min := ConstTMin;
        if BottomAxis.Range.Min = 0 then BottomAxis.Range.Min := 0.1;
      end
      else
      begin
        BottomAxis.Range.UseMax := False;
        BottomAxis.Range.Min := 0.1;
        BottomAxis.Range.UseMin := True;
      end;
    end;
    ConstantSeries := TLineSeries.Create(ConstantChart);
    with ConstantSeries do
    begin
      ShowLines := True;
      LinePen.Width := LineWidth;
      ShowPoints := SeriesShowPnts;
      Pointer.Style := psRectangle;
      Pointer.Pen.Color := clBlack;
      if HiRes then
      begin
        LinePen.Width := LineWidth * ResFactor;
        Pointer.HorizSize := ResFactor;
        Pointer.VertSize := ResFactor;
      end
      else
      begin
        Pointer.HorizSize := 1;
        Pointer.VertSize := 1;
      end;
      Title := 'Constant Rate Test';
      SeriesColor := SerColr;
      AxisIndexX := 1;
      AxisIndexY := 0;
    end;
    ConstantChart.AddSeries(ConstantSeries);
    ConstantChart.Series[0].Active := True;
    ConstantWLQuery.Open;
    Application.ProcessMessages;
    if DDown then
      ConstStatWL := ConstantWLQueryWATER_LEV.AsFloat
    else ConstStatWL := 0;
    StartDateTime := StringToDate(ConstStartDate) + StringToTime(ConstStartTime);
    while not ConstantWLQuery.EOF do
    begin
      NewDateTime := StringToDate(ConstantWLQueryDATE_MEAS.Value)
        + StringToTime(ConstantWLQueryTIME_MEAS.Value);
      Minute := 1440 * (NewDateTime - StartDateTime);
      if Minute = 0 then
        ConstantSeries.AddXY(0.1, -(ConstantWLQueryWATER_LEV.Value - ConstStatWL) * LengthFactor, '', clBlack)
      else
        ConstantSeries.AddXY(Minute, -(ConstantWLQueryWATER_LEV.Value - ConstStatWL) * LengthFactor, '', clBlack);
      ConstantWLQuery.Next;
    end;
    ConstantWLQuery.Close;
    //create discharge series if selected
    if CDischargeQuery.Tag > 0 then
    begin
      CDischargeQuery.Open;
      if CDischargeQuery.Tag = 1 then //LineSeries
      begin
        CDisLineSeries := TLineSeries.Create(ConstantChart);
        with CDisLineSeries do
        begin
          AxisIndexX := 1;
          AxisIndexY := 2;
          SeriesColor := DischColr;
          LineType := ltStepXY;
          LinePen.Width := LineWidth;
          ShowPoints := DischShowPnts;
          if HiRes then
          begin
            LinePen.Width := LineWidth * ResFactor;
            Pointer.HorizSize := ResFactor;
            Pointer.VertSize := ResFactor;
          end
          else
          begin
            Pointer.HorizSize := 2;
            Pointer.VertSize := 2;
          end;
          while not CDischargeQuery.EOF do
          begin
            NewDateTime := StringToDate(CDischargeQuery.FieldByName('DATE_MEAS').Value)
              + StringToTime(CDischargeQuery.FieldByName('TIME_MEAS').Value);
            Minute := Round(1440 * (NewDateTime - StartDateTime));
            if Minute = 0 then Minute := 0.1;
            CDisLineSeries.AddXY(Minute, (CDischargeQuery.FieldByName('DISCH_RATE').AsFloat) * VolumeFactor/TimeFactor, '', DischColr);
            CDischargeQuery.Next;
          end;
        end;
        ConstantChart.AddSeries(CDisLineSeries);
      end
      else
      if CDischargeQuery.Tag = 2 then //AreaSeries
      begin
        CDisAreaSeries := TAreaSeries.Create(ConstantChart);
        with CDisAreaSeries do
        begin
          AxisIndexX := 1;
          AxisIndexY := 2;
          SeriesColor := clSkyBlue;
          ConnectType := ctStepXY;
          AreaLinesPen.Style := psClear;
          while not CDischargeQuery.EOF do
          begin
            NewDateTime := StringToDate(CDischargeQuery.FieldByName('DATE_MEAS').Value)
              + StringToTime(CDischargeQuery.FieldByName('TIME_MEAS').Value);
            Minute := Round(1440 * (NewDateTime - StartDateTime));
            if Minute = 0 then Minute := 0.1;
            CDisAreaSeries.AddXY(Minute, (CDischargeQuery.FieldByName('DISCH_RATE').AsFloat) * VolumeFactor/TimeFactor, '', DischColr);
            CDischargeQuery.Next;
          end;
        end;
        ConstantChart.AddSeries(CDisAreaSeries);
      end;
    end;
    RLBandConstant.Height := ChartBandHeight;
    //Load chart into RLBand Background
    if HiRes then
      bmp.SetSize(ResFactor * RLBandConstant.Width, ResFactor * RLBandConstant.Height)
    else
      bmp.SetSize(RLBandConstant.Width, RLBandConstant.Height);
    ConstantChart.PaintOnCanvas(bmp.Canvas, Rect(0, 0, bmp.Width, bmp.Height));
    RLBandConstant.Background.Picture.Bitmap.Assign(bmp);
    ConstantChart.Free;
    bmp.Free;
  end
  else
    RLBandConstant.Visible := False;
end;

procedure TPumpTestRepForm.RLBandHeaderBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  RLBandHeader.Color := ReportHeaderBandColor;
end;

procedure TPumpTestRepForm.RLBandMultiBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
var m, StepsAdded: Integer;
    bmp: TBitmap;
    MultiRateChart: TChart;
    MRightAxis: TChartAxis;
    MultirateSeries, MDisLineSeries: TLineSeries;
    StepSeries: Array[1..9] of TLineSeries;
    MDisAreaSeries: TAreaSeries;
    Minute, StartDateTime, NewDateTime: Real;
    MultiStatWL: Real;
    CumulativeSteps: array of Integer;
begin
  if ShowMulti then
  begin
    //Create the charts
    bmp := TBitmap.Create;
    MultirateChart := TChart.Create(Self);
    with MultirateChart do
    begin
      BackColor := clWhite;
      Color := clWhite;
      LeftAxis.Title.LabelFont.Name := ReportFont.Name;
      LeftAxis.Marks.LabelFont.Name := ReportFont.Name;
      BottomAxis.Title.LabelFont.Name := ReportFont.Name;
      BottomAxis.Marks.LabelFont.Name := ReportFont.Name;
      Title.Text.Clear;
      Title.Text.Add(MultiTitle);
      Title.Brush.Color := clWhite;
      Title.Font.Name := ReportFont.Name;
      Title.Font.Color := clBlack;
      Title.Font.Style := [fsBold,fsItalic];
      if HiRes then
      begin
        MarginsExternal.Right := 8 * ResFactor;
        Title.Font.Size := 9 * ResFactor;
        Title.Margins.Top := 10 * ResFactor;
      end
      else
      begin
        MarginsExternal.Right := 8;
        Title.Font.Size := 9;
      end;
      Title.Font.Quality := fqAntialiased;
      Title.Visible := True;
      BottomAxis.Transformations := BottomAxisTransformations;
      BottomAxis.Title.Caption := 'Time [min] from Start';
      BottomAxis.Marks.LabelFont.Orientation := 900;
      BottomAxis.Marks.LabelFont.Quality := fqAntialiased;
      BottomAxis.Marks.Format := '%.0f';
      BottomAxis.Marks.Source := ListChartSourceMarks;
      if HiRes then
      begin
        BottomAxis.Marks.LabelFont.Size := 7 * ResFactor;
        BottomAxis.Margin := 5 * ResFactor;
        BottomAxis.Title.LabelFont.Size := 9 * ResFactor;
        BottomAxis.AxisPen.Width := ResFactor;
        BottomAxis.Grid.Width := ResFactor;
      end
      else
      begin
        BottomAxis.Marks.LabelFont.Size := 7;
        BottomAxis.Margin := 5;
        BottomAxis.Title.LabelFont.Size := 9;
      end;
      BottomAxis.Intervals.Options := [];
      BottomAxis.Title.Visible := True;
      LeftAxis.Title.Caption := MLeftAxisTitle;
      if HiRes then
      begin
        LeftAxis.Marks.LabelFont.Size := 7 * ResFactor;
        LeftAxis.Title.LabelFont.Size := 9 * ResFactor;
        LeftAxis.Margin := 3 * ResFactor;
        LeftAxis.Intervals.MinLength := 10 * ResFactor;
        LeftAxis.Intervals.MaxLength := LeftAxis.Intervals.MinLength * ResFactor;
        LeftAxis.AxisPen.Width := ResFactor;
        LeftAxis.Grid.Width := ResFactor;
      end
      else
      begin
        LeftAxis.Marks.LabelFont.Size := 7;
        LeftAxis.Title.LabelFont.Size := 9;
        LeftAxis.Margin := 5;
      end;
      LeftAxis.Title.Visible := True;
      LeftAxis.Transformations := LeftAxisTransformations;
      if MUseLeft then
      begin
        LeftAxis.Range.Max := MLeftAxisRangeMax;
        LeftAxis.Range.Min := MLeftAxisRangeMin;
        LeftAxis.Range.UseMax := True;
        LeftAxis.Range.UseMin := True;
      end
      else
      begin
        LeftAxis.Range.UseMax := False;
        LeftAxis.Range.UseMin := False;
      end;
      //check if Discharge must be shown, then create and set right axis
      if MDischargeQuery.Tag > 0 then
      begin
        MRightAxis := TChartAxis.Create(AxisList);
        with MRightAxis do
        begin
          Title.LabelFont.Name := ReportFont.Name;
          Title.Caption := 'Discharge Rate [' + DisUnit + ']';
          Title.LabelFont.Orientation := 2700;
          Title.LabelFont.Color := DischColr;
          Title.Visible := True;
          Marks.LabelFont.Name := ReportFont.Name;
          Alignment := calRight;
          Transformations := RightAxisTransformations;
          Grid.Visible := False;
          if HiRes then
          begin
            Marks.LabelFont.Size := 7 * ResFactor;
            Title.LabelFont.Size := 9 * ResFactor;
            Margin := 3 * ResFactor;
            Intervals.MinLength := 10 * ResFactor;
            Intervals.MaxLength := LeftAxis.Intervals.MinLength * ResFactor;
            AxisPen.Width := ResFactor;
          end
          else
          begin
            Marks.LabelFont.Size := 7;
            Title.LabelFont.Size := 9;
            Margin := 5;
          end;
        end;
      end;
      if MUseTime then
      begin
        BottomAxis.Range.Max := MBottomAxisRangeMax;
        BottomAxis.Range.Min := MBottomAxisRangeMin;
        if BottomAxis.Range.Min = 0 then BottomAxis.Range.Min := 0.1;
        BottomAxis.Range.UseMax := True;
        BottomAxis.Range.UseMin := True;
      end
      else
      begin
        BottomAxis.Range.UseMax := False;
        BottomAxis.Range.Min := 0.1;
        BottomAxis.Range.UseMin := True;
      end;
    end;
    MultirateSeries := TLineSeries.Create(MultirateChart);
    with MultirateSeries do
    begin
      ShowLines := True;
      LinePen.Width := LineWidth;
      ShowPoints := SeriesShowPnts;
      Pointer.Style := psRectangle;
      Pointer.Pen.Color := clBlack;
      if HiRes then
      begin
        LinePen.Width := LineWidth * ResFactor;
        Pointer.HorizSize := ResFactor;
        Pointer.VertSize := ResFactor;
      end
      else
      begin
        Pointer.HorizSize := 1;
        Pointer.VertSize := 1;
      end;
      Title := 'Full Multirate Test';
      SeriesColor := SerColr;
      AxisIndexX := 1;
      AxisIndexY := 0;
    end;
    MultirateChart.AddSeries(MultirateSeries);
    MultiRateChart.Series[0].Active := True;
    if NrSteps > 0 then
    begin
      //create series for steps
      for m := 1 to NrSteps do
      begin
        StepSeries[m] := TLineSeries.Create(MultirateChart);
        StepSeries[m].ShowLines := True;
        StepSeries[m].LinePen.Width := LineWidth;
        StepSeries[m].ShowPoints := StepsShowPnts;
        StepSeries[m].Pointer.Style := psCircle;
        StepSeries[m].Pointer.Pen.Color := clBlack;
        if HiRes then
        begin
          StepSeries[m].LinePen.Width := LineWidth * ResFactor;
          StepSeries[m].Pointer.HorizSize := ResFactor;
          StepSeries[m].Pointer.VertSize := ResFactor;
        end
        else
        begin
          StepSeries[m].Pointer.HorizSize := 1;
          StepSeries[m].Pointer.VertSize := 1;
        end;
        StepSeries[m].Title := 'Step ' + IntToStr(m + 1);
        StepSeries[m].SeriesColor := StepsColr;
        StepSeries[m].AxisIndexY := 0;
        StepSeries[m].AxisIndexX := 1;
        MultirateChart.AddSeries(StepSeries[m]);
        MultiRateChart.Series[m].Active := True;
      end;
      //create step lengths
      SetLength(CumulativeSteps, 10);
      StepQuery.Open;
      StepsAdded := 0;
      if StepQuery.RecordCount = 0 then
      begin
        NrSteps := 0;
        Application.ProcessMessages;
        MessageDlg('There are no or incomplete steps entered in your Testing Details. No additional steps will be shown!', mtError, [mbOK], 0);
      end
      else
      for m := 0 to NrSteps do
      begin
        if m = 0 then
          CumulativeSteps[m] := StepQuery.FieldByName('DURATION').AsInteger
        else
          CumulativeSteps[m] := StepsAdded + StepQuery.FieldByName('DURATION').AsInteger;
        StepsAdded := CumulativeSteps[m];
        StepQuery.Next;
      end;
      StepQuery.Close;
    end
    else NrSteps := 0;
    //Get waterlevels
    MultiRateWLQuery.Open;
    Application.ProcessMessages;
    if DDown then
      MultiStatWL := MultiRateWLQueryWATER_LEV.AsFloat
    else
      MultiStatWL := 0;
    StartDateTime := StringToDate(MRateStartDate) + StringToTime(MRateStartTime);
    while not MultiRateWLQuery.EOF do
    begin
      NewDateTime := StringToDate(MultiRateWLQueryDATE_MEAS.Value)
        + StringToTime(MultiRateWLQueryTIME_MEAS.Value);
      Minute := Round(1440 * (NewDateTime - StartDateTime));
      if Minute = 0 then Minute := 0.1;
      MultirateSeries.AddXY(Minute, -(MultiRateWLQueryWATER_LEV.Value - MultiStatWL) * LengthFactor, '', clBlack);
      //for additional steps
      if NrSteps > 0 then
      begin
        for m := 1 to NrSteps do
        begin
          if (Minute >= CumulativeSteps[m-1]) and (Minute <= CumulativeSteps[m]) then
          begin
            if Minute - CumulativeSteps[m-1] = 0 then
              StepSeries[m].AddXY(0.1, -(MultiRateWLQueryWATER_LEV.Value - MultiStatWL) * LengthFactor, '', clBlack)
            else
              StepSeries[m].AddXY(Minute - CumulativeSteps[m-1], -(MultiRateWLQueryWATER_LEV.Value - MultiStatWL) * LengthFactor, '', clBlack);
          end;
        end;
      end;
      Application.ProcessMessages;
      MultiRateWLQuery.Next;
    end;
    MultiRateWLQuery.Close;
    //create discharge series if selected
    if MDischargeQuery.Tag > 0 then
    begin
      MDischargeQuery.Open;
      if MDischargeQuery.Tag = 1 then //LineSeries
      begin
        MDisLineSeries := TLineSeries.Create(MultiRateChart);
        with MDisLineSeries do
        begin
          AxisIndexX := 1;
          AxisIndexY := 2;
          SeriesColor := DischColr;
          LineType := ltStepXY;
          LinePen.Width := LineWidth;
          ShowPoints := DischShowPnts;
          if HiRes then
          begin
            LinePen.Width := LineWidth * ResFactor;
            Pointer.HorizSize := ResFactor;
            Pointer.VertSize := ResFactor;
          end
          else
          begin
            Pointer.HorizSize := 2;
            Pointer.VertSize := 2;
          end;
          while not MDischargeQuery.EOF do
          begin
            NewDateTime := StringToDate(MDischargeQuery.FieldByName('DATE_MEAS').Value)
              + StringToTime(MDischargeQuery.FieldByName('TIME_MEAS').Value);
            Minute := Round(1440 * (NewDateTime - StartDateTime));
            if Minute = 0 then Minute := 0.1;
            MDisLineSeries.AddXY(Minute, (MDischargeQuery.FieldByName('DISCH_RATE').AsFloat) * VolumeFactor/TimeFactor, '', DischColr);
            MDischargeQuery.Next;
          end;
        end;
        MultiRateChart.AddSeries(MDisLineSeries);
      end
      else
      if MDischargeQuery.Tag = 2 then //AreaSeries
      begin
        MDisAreaSeries := TAreaSeries.Create(MultiRateChart);
        with MDisAreaSeries do
        begin
          AxisIndexX := 1;
          AxisIndexY := 2;
          SeriesColor := clSkyBlue;
          ConnectType := ctStepXY;
          AreaLinesPen.Style := psClear;
          while not MDischargeQuery.EOF do
          begin
            NewDateTime := StringToDate(MDischargeQuery.FieldByName('DATE_MEAS').Value)
              + StringToTime(MDischargeQuery.FieldByName('TIME_MEAS').Value);
            Minute := Round(1440 * (NewDateTime - StartDateTime));
            if Minute = 0 then Minute := 0.1;
            MDisAreaSeries.AddXY(Minute, (MDischargeQuery.FieldByName('DISCH_RATE').AsFloat) * VolumeFactor/TimeFactor, '', DischColr);
            MDischargeQuery.Next;
          end;
        end;
        MultiRateChart.AddSeries(MDisAreaSeries);
      end;
    end;
    RLBandMulti.Height := ChartBandHeight;
    //Load chart into RLBand Background
    if HiRes then
      bmp.SetSize(ResFactor * RLBandMulti.Width, ResFactor * RLBandMulti.Height)
    else
      bmp.SetSize(RLBandMulti.Width, RLBandMulti.Height);
    MultirateChart.PaintOnCanvas(bmp.Canvas, Rect(0, 0, bmp.Width, bmp.Height));
    RLBandMulti.Background.Picture.Bitmap.Assign(bmp);
    MultirateChart.Free;
    bmp.Free;
    Application.ProcessMessages;
  end
  else
    RLBandMulti.Visible := False;
end;

procedure TPumpTestRepForm.StepQueryBeforeOpen(DataSet: TDataSet);
begin
  StepQuery.Connection := DataModuleMain.ZConnectionDB;
  with StepQuery.SQL do
  begin
    Clear;
    Add('SELECT SITE_ID_NR, DATE_START, TIME_START, DURATION from testdetl');
    Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
    if DataModuleMain.ZConnectionDB.Tag = 1 then
      Add('AND DATE_START || TIME_START >= ' + QuotedStr(MRateStartDate + MRateStartTime))
    else
      Add('AND CONCAT(DATE_START, TIME_START) >= ' + QuotedStr(MRateStartDate + MRateStartTime));
    Add('ORDER BY SITE_ID_NR, DATE_START, TIME_START');
  end;
end;

procedure TPumpTestRepForm.TestingQueryBeforeOpen(DataSet: TDataSet);
begin
  //Dates/Times started/ended are determined in PumpTestQuery.BeforeOpen
  with TestingQuery do
  begin
    Connection := DataModuleMain.ZConnectionDB;
    SQL.Add('SELECT * FROM testdetl');
    SQL.Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
    if not ShowAllTests then
    begin
      if Connection.Tag = 1 then
      begin
        SQL.Add('AND (DATE_START || TIME_START >= ' + QuotedStr(MRateStartDate + MRateStartTime));
        SQL.Add('AND DATE_START || TIME_START < ' + QuotedStr(MRateEndDate + MRateEndTime) + ')');
        SQL.Add('OR DATE_START || TIME_START >= ' + QuotedStr(ConstStartDate + ConstStartTime));
      end
      else
      begin
        SQL.Add('AND (CONCAT(DATE_START, TIME_START) >= ' + QuotedStr(MRateStartDate + MRateStartTime));
        SQL.Add('AND CONCAT(DATE_START, TIME_START) < ' + QuotedStr(MRateEndDate + MRateEndTime) + ')');
        SQL.Add('OR CONCAT(DATE_START, TIME_START) >= ' + QuotedStr(ConstStartDate + ConstStartTime));
      end;
    end;
    SQL.Add('ORDER BY DATE_START, TIME_START');
  end;
end;

procedure TPumpTestRepForm.TestingQueryCalcFields(DataSet: TDataSet);
begin
  if TestingQueryDRAWDOWN.Value > 0 then
    TestingQueryQ_ST.Value := TestingQueryDISCH_RATE.Value / TestingQueryDRAWDOWN.Value;
end;

procedure TPumpTestRepForm.TestingQueryCALIBR_YLDGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.AsFloat > 0 then
  begin
    if Sender.AsFloat * VolumeFactor * TimeFactor > 100000 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 0)
    else
    if Sender.AsFloat * VolumeFactor * TimeFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 2);
  end
  else aText := '';
end;

procedure TPumpTestRepForm.TestingQueryDEPTH_INTKGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.AsFloat > 0 then
  begin
    if Sender.AsFloat * LengthFactor > 100 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2)
    else
    if Sender.AsFloat * LengthFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end
  else aText := '';
end;

procedure TPumpTestRepForm.TestingQueryDISCH_RATEGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.AsFloat > 0 then
  begin
    if Sender.AsFloat * VolumeFactor * TimeFactor > 100000 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 0)
    else
    if Sender.AsFloat * VolumeFactor * TimeFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 2);
  end
  else aText := '';
end;

procedure TPumpTestRepForm.TestingQueryDRAWDOWNGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.AsFloat > 0 then
  begin
    if Sender.AsFloat * LengthFactor > 100 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
    else
    if Sender.AsFloat * LengthFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end
  else aText := '';
end;

procedure TPumpTestRepForm.TestingQueryQ_STGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.AsFloat > 0 then aText := FloatToStrF(Sender.AsFloat, ffFixed, 15, 3)
  else DisplayText := False;
end;

procedure TPumpTestRepForm.TestingQueryRECOVERYGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.AsFloat > 0 then
  begin
    if Sender.AsFloat * LengthFactor > 100 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
    else
    if Sender.AsFloat * LengthFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end
  else aText := '';
end;

procedure TPumpTestRepForm.TestingQueryTIME_STARTGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := FormatDateTime('hh:nn', EncodeTime(StrToInt(Copy(Sender.AsString, 1, 2)), StrToInt(Copy(Sender.AsString, 3, 2)), 0, 0));
end;

procedure TPumpTestRepForm.WaterlevQueryBasicBeforeOpen(DataSet: TDataSet);
begin
  with WaterlevQueryBasic do
  begin
    Connection := DataModuleMain.ZConnectionDB;
    Params[0].AsString := CurrentSite;
    Params[1].AsString := Copy(WLDateTime, 1, 8);
    Params[2].AsString := Copy(WLDateTime, 10, 4);
  end;
end;

procedure TPumpTestRepForm.WaterlevQueryBasicDATE_MEASGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := DateToStr(StringToDate(Sender.AsString));
end;

procedure TPumpTestRepForm.WaterlevQueryBasicWATER_LEVGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.AsFloat > 0 then
  begin
    if Abs((Sender.AsFloat) * LengthFactor) > 10000 then
      aText := FloatToStrF((Sender.AsFloat) * LengthFactor, ffFixed, 15, 0)
    else
      aText := FloatToStrF((Sender.AsFloat) * LengthFactor, ffFixed, 15, 2);
  end
  else aText := '';
end;

procedure TPumpTestRepForm.WaterlevQueryBeforeOpen(DataSet: TDataSet);
begin
  WaterlevQuery.Connection := DataModuleMain.ZConnectionDB;
  with WaterlevQuery.SQL do
  begin
    Add('SELECT * FROM waterlev');
    Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
    if DataModuleMain.ZConnectionDB.Tag = 1 then
    begin
      Add('AND (DATE_MEAS || TIME_MEAS >= ' + QuotedStr(MRateStartDate + MRateStartTime));
      Add('AND DATE_MEAS || TIME_MEAS <= ' + QuotedStr(MRateEndDate + MRateEndTime) + ')');
      Add('OR (DATE_MEAS || TIME_MEAS >= ' + QuotedStr(ConstStartDate + ConstStartTime));
      Add('AND DATE_MEAS || TIME_MEAS <= ' + QuotedStr(ConstEndDate + ConstEndTime) + ')');
    end
    else
    begin
      Add('AND (CONCAT(DATE_MEAS, TIME_MEAS) >= ' + QuotedStr(MRateStartDate + MRateStartTime));
      Add('AND CONCAT(DATE_MEAS, TIME_MEAS) <= ' + QuotedStr(MRateEndDate + MRateEndTime) + ')');
      Add('OR (CONCAT(DATE_MEAS, TIME_MEAS) >= ' + QuotedStr(ConstStartDate + ConstStartTime));
      Add('AND CONCAT(DATE_MEAS, TIME_MEAS) <= ' + QuotedStr(ConstEndDate + ConstEndTime) + ')');
    end;
  end;
end;

procedure TPumpTestRepForm.WaterlevQueryDATE_MEASGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := DateToStr(StringToDate(Sender.AsString));
end;

procedure TPumpTestRepForm.WaterlevQueryTIME_MEASGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := FormatDateTime('hh:nn', EncodeTime(StrToInt(Copy(Sender.AsString, 1, 2)), StrToInt(Copy(Sender.AsString, 3, 2)), 0, 0));
end;

procedure TPumpTestRepForm.WaterlevQueryWATER_LEVGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if not Sender.IsNull then
  begin
    if Abs(Sender.AsFloat * LengthFactor) > 10000 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end
  else
    DisplayText := False;
end;

end.

