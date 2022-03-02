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
unit man_rep;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Interfaces, RLReport, ZDataset, Forms,
  Controls, Graphics, Dialogs, Math;

type

  { TManRecForm }

  TManRecForm = class(TForm)
    ExtractAddParamQueryADD_PARAM: TFloatField;
    ExtractAddParamQueryCHM_REF_NR: TLargeintField;
    AquiferBand: TRLBand;
    AquiferTableAQUI_TYPE: TStringField;
    AquiferTableCOMMENT: TStringField;
    AquiferTableDEPTH_BOT: TFloatField;
    AquiferTableDEPTH_TOP: TFloatField;
    AquiferTableMETH_MEAS: TStringField;
    AquiferTableSITE_ID_NR: TStringField;
    AquiferTableYIELD: TFloatField;
    BasicinfDataSource: TDataSource;
    BasicinfQueryALTITUDE: TFloatField;
    BasicinfQueryALT_NO_1: TStringField;
    BasicinfQueryALT_NO_2: TStringField;
    BasicinfQueryBH_DIAM: TFloatField;
    BasicinfQueryCOLLAR_HI: TFloatField;
    BasicinfQueryDEPTH: TFloatField;
    BasicinfQueryFARM_NR: TStringField;
    BasicinfQueryNR_ON_MAP: TStringField;
    BasicinfQueryREP_INST: TStringField;
    BasicinfQuerySITE_ID_NR: TStringField;
    BasicinfQuerySITE_NAME: TStringField;
    BasicinfQuerySITE_PURPS: TStringField;
    BasicinfQuerySITE_STATU: TStringField;
    BasicinfQuerySITE_TYPE: TStringField;
    BasicinfQueryUSE_APPLIC: TStringField;
    BasicinfQueryUSE_CONSUM: TStringField;
    BasicinfQueryX_COORD: TFloatField;
    BasicinfQueryY_COORD: TFloatField;
    CasingTableDEPTH_BOT: TFloatField;
    CasingTableDEPTH_TOP: TFloatField;
    CasingTableDIAMETER: TFloatField;
    CasingTableMATERIAL: TStringField;
    CasingTableOPEN_LEN: TFloatField;
    CasingTableOPEN_TYPE: TStringField;
    CasingTableOPEN_WIDTH: TFloatField;
    CasingTableOP_HOR_DIS: TFloatField;
    CasingTableOP_VER_DIS: TFloatField;
    CasingTableSITE_ID_NR: TStringField;
    CasingTableTHICKNESS: TFloatField;
    Chem003TableCHM_REF_NR: TLongintField;
    Chem003TableECOL: TFloatField;
    Chem003TableFAEC_ECOL: TFloatField;
    Chem003TableSPC: TFloatField;
    Chem003TableTOTAL_COL: TFloatField;
    Chem0QueryCHM_REF_NR: TLargeintField;
    Chem0QueryCOMMENT: TStringField;
    Chem0QueryDATE_ANAL: TStringField;
    Chem0QueryDATE_SAMPL: TStringField;
    Chem0QueryDEPTH_SAMP: TFloatField;
    Chem0QueryLAB: TStringField;
    Chem0QuerySAMPLE_NR: TStringField;
    Chem0QuerySITE_ID_NR: TStringField;
    Chem0QueryTIME_SAMPL: TStringField;
    Chem1QueryAggressive: TFloatField;
    Chem1QueryAL: TFloatField;
    Chem1QueryAnions: TFloatField;
    Chem1QueryBError: TFloatField;
    Chem1QueryCA: TFloatField;
    Chem1QueryCaHard: TFloatField;
    Chem1QueryCations: TFloatField;
    Chem1QueryCHM_REF_NR: TLargeintField;
    Chem1QueryCL: TFloatField;
    Chem1QueryCO3: TFloatField;
    Chem1QueryCorrosion: TFloatField;
    Chem1QueryEC: TFloatField;
    Chem1QueryF: TFloatField;
    Chem1QueryFE: TFloatField;
    Chem1QueryHCO3: TFloatField;
    Chem1QueryK: TFloatField;
    Chem1QueryLANGELIER: TFloatField;
    Chem1QueryMACID: TFloatField;
    Chem1QueryMALK: TFloatField;
    Chem1QueryMG: TFloatField;
    Chem1QueryMgHard: TFloatField;
    Chem1QueryMN: TFloatField;
    Chem1QueryN: TFloatField;
    Chem1QueryNA: TFloatField;
    Chem1QueryPACID: TFloatField;
    Chem1QueryPALK: TFloatField;
    Chem1QueryPH: TFloatField;
    Chem1QuerySAR: TFloatField;
    Chem1QuerySI: TFloatField;
    Chem1QuerySO4: TFloatField;
    Chem1QuerySumTDS: TFloatField;
    Chem1QueryTDS: TFloatField;
    Chem1QueryTDS7: TFloatField;
    Chem1QueryTHard: TFloatField;
    DataSourceAddParam: TDataSource;
    estingTableTIME_START: TStringField;
    InstallaTableDATE_INSTL: TStringField;
    InstallaTableDEPTH_INTK: TFloatField;
    InstallaTableMANUFACTUR: TStringField;
    InstallaTablePOWER_RATG: TFloatField;
    InstallaTableSITE_ID_NR: TStringField;
    InstallaTableTYPE_INSTL: TStringField;
    InstallaTableTYPE_POWER: TStringField;
    InstDetlTableDATE_INSTL: TStringField;
    InstDetlTableE_MANUF: TStringField;
    InstDetlTableSITE_ID_NR: TStringField;
    NotesRLDBMemo: TRLDBMemo;
    RecommendDataSource: TDataSource;
    FooterBand: TRLBand;
    RecommendTableCRIT_WLEV: TFloatField;
    RecommendTableDEPTH_INTK: TFloatField;
    RecommendTableDISCH_RATE: TFloatField;
    RecommendTableDUTY_CYCLE: TFloatField;
    RecommendTableDYN_WLEV: TFloatField;
    RecommendTableNOTE_PAD: TBlobField;
    RecommendTablePRIORITY: TLongintField;
    RecommendTableREC_EQUIPM: TStringField;
    RecommendTableSITE_ID_NR: TStringField;
    RecommendTableTYPE_POWER: TStringField;
    RecommendTableWATER_QUAL: TStringField;
    RLBand4: TRLBand;
    RLBand5: TRLBand;
    RLBand6: TRLBand;
    RLBand7: TRLBand;
    RLDBText56: TRLDBText;
    RLDBText57: TRLDBText;
    RLDBText58: TRLDBText;
    RLDBText59: TRLDBText;
    RLDBText60: TRLDBText;
    RLDBText61: TRLDBText;
    RLDBText62: TRLDBText;
    RLDBText63: TRLDBText;
    RLDBText64: TRLDBText;
    RLDBText65: TRLDBText;
    RLDBText66: TRLDBText;
    RLDBText67: TRLDBText;
    RLDBText68: TRLDBText;
    RLDBText69: TRLDBText;
    RLDBText70: TRLDBText;
    RLDBText71: TRLDBText;
    RLDBText72: TRLDBText;
    RLDBText73: TRLDBText;
    RLDBText74: TRLDBText;
    RLDBText75: TRLDBText;
    RLDBText76: TRLDBText;
    RLDBText77: TRLDBText;
    RLDBText78: TRLDBText;
    RLDBText79: TRLDBText;
    RLDBText80: TRLDBText;
    RLDBText81: TRLDBText;
    RLDBText82: TRLDBText;
    RLDBText83: TRLDBText;
    RLDBText84: TRLDBText;
    RLDBText85: TRLDBText;
    RLDBText86: TRLDBText;
    RLDBText87: TRLDBText;
    RLDBText88: TRLDBText;
    RLDBText89: TRLDBText;
    RLDBTextAddParam: TRLDBText;
    RLDBTextLab: TRLDBText;
    RLDBTextDate: TRLDBText;
    RLDBText91: TRLDBText;
    RLDBText92: TRLDBText;
    RLDBText93: TRLDBText;
    RLDBText94: TRLDBText;
    RLDBText96: TRLDBText;
    RLDBText97: TRLDBText;
    RLDBTextY_COORD: TRLDBText;
    RLImageLogo: TRLImage;
    RLLabel105: TRLLabel;
    RLLabel106: TRLLabel;
    RLLabel107: TRLLabel;
    RLLabel110: TRLLabel;
    RLLabel111: TRLLabel;
    RLLabel112: TRLLabel;
    RLLabel113: TRLLabel;
    RLLabel114: TRLLabel;
    RLLabel115: TRLLabel;
    RLLabel116: TRLLabel;
    RLLabel117: TRLLabel;
    RLLabel119: TRLLabel;
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
    RecommendBand: TRLBand;
    RLLabel18: TRLLabel;
    RLLabel66: TRLLabel;
    RLLabel67: TRLLabel;
    RLLabelStandard: TRLLabel;
    RLLabelAnal: TRLLabel;
    RLLabelOn: TRLLabel;
    RLLabelAddParam: TRLLabel;
    RLMemoUserDetails: TRLMemo;
    TestingTableSPEC_CAP: TFloatField;
    WaterlevQueryDATE_MEAS: TStringField;
    WaterlevQueryPIEZOM_NR: TStringField;
    WaterlevQuerySITE_ID_NR: TStringField;
    WaterlevQueryWATER_LEV: TFloatField;
    Y_CoordLabel: TRLLabel;
    CommentMemo: TRLMemo;
    RLSystemInfo2: TRLSystemInfo;
    TestingDataSource: TDataSource;
    TestingBand: TRLBand;
    TestingSubDetail: TRLSubDetail;
    Chem000DataSource: TDataSource;
    Chem001DataSource: TDataSource;
    Chem003DataSource: TDataSource;
    AquiferDataSource: TDataSource;
    CasingDataSource: TDataSource;
    InstDetlDataSource: TDataSource;
    EquipDataSource: TDataSource;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    CasingBand: TRLBand;
    RLDBText18: TRLDBText;
    RLDBText19: TRLDBText;
    RLDBText20: TRLDBText;
    RLDBText21: TRLDBText;
    RLDBText22: TRLDBText;
    RLDBText23: TRLDBText;
    RLDBText24: TRLDBText;
    RLDBText25: TRLDBText;
    RLDBText26: TRLDBText;
    RLDBText27: TRLDBText;
    RLDBText28: TRLDBText;
    RLDBText29: TRLDBText;
    RLDBText30: TRLDBText;
    RLDBText31: TRLDBText;
    RLDBTextPH: TRLDBText;
    RLDBTextEC: TRLDBText;
    RLDBTextTDS: TRLDBText;
    RLDBTextMALK: TRLDBText;
    RLDBTextCA: TRLDBText;
    RLDBTextMG: TRLDBText;
    RLDBTextNA: TRLDBText;
    RLDBTextK: TRLDBText;
    RLDBTextSI: TRLDBText;
    RLDBTextAL: TRLDBText;
    RLDBTextFE: TRLDBText;
    RLDBTextMN: TRLDBText;
    RLDBTextCL: TRLDBText;
    RLDBTextN: TRLDBText;
    RLDBTextSO4: TRLDBText;
    RLDBTextF: TRLDBText;
    RLDBTextECOL: TRLDBText;
    RLDBTextFAEC_ECOL: TRLDBText;
    RLDBTextTOTAL_COL: TRLDBText;
    RLDBTextSPC: TRLDBText;
    RLDBText52: TRLDBText;
    RLDBText53: TRLDBText;
    RLDBText54: TRLDBText;
    RLDBText55: TRLDBText;
    RLDraw3: TRLDraw;
    RLLabel100: TRLLabel;
    RLLabel101: TRLLabel;
    RLLabel102: TRLLabel;
    RLLabel103: TRLLabel;
    RLLabel104: TRLLabel;
    RLLabel108: TRLLabel;
    RLLabel109: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel21: TRLLabel;
    RLLabel22: TRLLabel;
    RLLabel23: TRLLabel;
    RLLabel24: TRLLabel;
    RLLabel25: TRLLabel;
    RLLabel26: TRLLabel;
    RLLabel27: TRLLabel;
    RLLabel28: TRLLabel;
    RLLabel29: TRLLabel;
    RLLabel30: TRLLabel;
    RLLabel31: TRLLabel;
    RLLabel32: TRLLabel;
    RLLabel33: TRLLabel;
    RLLabel34: TRLLabel;
    RLLabel35: TRLLabel;
    RLLabel36: TRLLabel;
    RLLabel37: TRLLabel;
    RLLabel38: TRLLabel;
    RLLabel39: TRLLabel;
    RLLabel40: TRLLabel;
    RLLabelEC: TRLLabel;
    RLLabel42: TRLLabel;
    RLLabel43: TRLLabel;
    RLLabel44: TRLLabel;
    RLLabel45: TRLLabel;
    RLLabel46: TRLLabel;
    RLLabel47: TRLLabel;
    RLLabel48: TRLLabel;
    RLLabel49: TRLLabel;
    RLLabel50: TRLLabel;
    RLLabel51: TRLLabel;
    RLLabel52: TRLLabel;
    RLLabel53: TRLLabel;
    RLLabel54: TRLLabel;
    RLLabel55: TRLLabel;
    RLLabel56: TRLLabel;
    RLLabel57: TRLLabel;
    RLLabel58: TRLLabel;
    RLLabel59: TRLLabel;
    RLLabel60: TRLLabel;
    RLLabel61: TRLLabel;
    RLLabel62: TRLLabel;
    RLLabel63: TRLLabel;
    RLLabel64: TRLLabel;
    RLLabel65: TRLLabel;
    CoordLabel: TRLLabel;
    RLLabel71: TRLLabel;
    RLLabel72: TRLLabel;
    RLLabel73: TRLLabel;
    RLLabel74: TRLLabel;
    RLLabel75: TRLLabel;
    RLLabel76: TRLLabel;
    RLLabel77: TRLLabel;
    RLLabel78: TRLLabel;
    RLLabel79: TRLLabel;
    RLLabel80: TRLLabel;
    RLLabel81: TRLLabel;
    RLLabel82: TRLLabel;
    RLLabel83: TRLLabel;
    RLLabel84: TRLLabel;
    RLLabel85: TRLLabel;
    RLLabel86: TRLLabel;
    RLLabel87: TRLLabel;
    RLLabel88: TRLLabel;
    RLLabel89: TRLLabel;
    RLLabel90: TRLLabel;
    RLLabel91: TRLLabel;
    RLLabel92: TRLLabel;
    RLLabel93: TRLLabel;
    RLLabel94: TRLLabel;
    RLLabel95: TRLLabel;
    RLLabel96: TRLLabel;
    RLLabel97: TRLLabel;
    RLLabel98: TRLLabel;
    RLLabel99: TRLLabel;
    RLMemoConcentrations: TRLMemo;
    AquiferSubDetail: TRLSubDetail;
    CasingSubDetail: TRLSubDetail;
    RecommendSubDetail: TRLSubDetail;
    TestingTableCOMMENT: TStringField;
    TestingTableDATE_START: TStringField;
    TestingTableDEPTH_INTK: TFloatField;
    TestingTableDESCRIPTN: TStringField;
    TestingTableDISCH_RATE: TFloatField;
    TestingTableDRAWDOWN: TFloatField;
    TestingTableDURATION: TLongintField;
    TestingTableDURA_RECOV: TLongintField;
    TestingTablePERC_RECOV: TLongintField;
    TestingTableRECOVERY: TFloatField;
    TestingTableSITE_ID_NR: TStringField;
    TestingTableSTORAGE: TFloatField;
    TestingTableTRANSMISS: TFloatField;
    WaterlevDataSource: TDataSource;
    DataSourceView: TDataSource;
    RLBand1: TRLBand;
    RLBandHeader: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    RLDBText12: TRLDBText;
    RLDBText13: TRLDBText;
    RLDBText14: TRLDBText;
    RLDBText15: TRLDBText;
    RLDBText17: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBTextX_COORD: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLLabel1: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel17: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    X_CoordLabel: TRLLabel;
    ManRecReport: TRLReport;
    RLSystemInfo1: TRLSystemInfo;
    InstallaTable: TZTable;
    InstDetlTable: TZTable;
    Chem003Table: TZTable;
    AquiferTable: TZTable;
    CasingTable: TZTable;
    TestingTable: TZTable;
    RecommendTable: TZTable;
    WaterlevQuery: TZReadOnlyQuery;
    Chem1Query: TZReadOnlyQuery;
    Chem0Query: TZReadOnlyQuery;
    BasicinfQuery: TZReadOnlyQuery;
    ExtractAddParamQuery: TZReadOnlyQuery;
    FindParamQuery: TZReadOnlyQuery;
    LimitsQuery: TZQuery;
    LimitsQueryCHM_REF_NR: TLongintField;
    LimitsQueryCOMMENTS: TStringField;
    LimitsQueryCPARAMETER: TStringField;
    LimitsQueryLIMITS: TStringField;
    LimitsQueryMETHOD: TStringField;
    ZTableViewReport: TZTable;
    ZTableViewReportSITE_ID_NR: TStringField;
    procedure BasicinfQuerySITE_ID_NRGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LimitsQueryBeforeOpen(DataSet: TDataSet);
    procedure TableBeforeOpen(DataSet: TDataSet);
    procedure Chem0QueryDATEGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure Chem1QueryECGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure ChemQueryAsNGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure ChemNoFactorGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure ExtractAddParamQueryADD_PARAMGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure AquiferTableAQUI_TYPEGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure AquiferTableMETH_MEASGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure AquiferTableYIELDGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryALTITUDEGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryBeforeOpen(DataSet: TDataSet);
    procedure BasicinfQueryBH_DIAMGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryCOLLAR_HIGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryDEPTHGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryREP_INSTGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQuerySITE_PURPSGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQuerySITE_STATUGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQuerySITE_TYPEGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryUSE_APPLICGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryUSE_CONSUMGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryX_COORDGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryY_COORDGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure DEPTHGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure DIAM_OPENGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure CasingTableMATERIALGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure CasingTableOPEN_TYPEGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure Chem0QueryBeforeOpen(DataSet: TDataSet);
    procedure Chem0QueryDEPTH_SAMPGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure Chem1QueryBeforeOpen(DataSet: TDataSet);
    procedure Chem1QueryCalcFields(DataSet: TDataSet);
    procedure ChemGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure DataSourceViewDataChange(Sender: TObject; Field: TField);
    procedure ExtractAddParamQueryBeforeOpen(DataSet: TDataSet);
    procedure InstallaTableDEPTH_INTKGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure InstallaTableMANUFACTURGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure InstallaTableTYPE_INSTLGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure InstallaTableTYPE_POWERGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure InstDetlTableE_MANUFGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure ManRecReportAfterPrint(Sender: TObject);
    procedure ManRecReportBeforePrint(Sender: TObject; var PrintIt: boolean);
    function OpenTable(const Table2Open: TZTable): Boolean;
    procedure RecommendTableREC_EQUIPMGetText(Sender: TField;
      var aText: string; DisplayText: Boolean);
    procedure RecommendTableTYPE_POWERGetText(Sender: TField;
      var aText: string; DisplayText: Boolean);
    procedure TestingTableDISCH_RATEGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure TestingTableDRAWDOWNGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure TestingTableRECOVERYGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure WaterlevQueryBeforeOpen(DataSet: TDataSet);
    procedure WaterlevQueryWATER_LEVGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure WaterlevTableWATER_LEVGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
  private
    { private declarations }
    XCoord, YCoord: ShortString;
  public
    { public declarations }
    TheUsedTablesList, TheFilterList: TStringList;
    UseConstraints, UseView, DoPageBreak, ShowAddParam, ShowLab: Boolean;
    UseResDD, ShowStandard: Boolean;
    ViewName, AddParam: ShortString;
  end;

var
  ManRecForm: TManRecForm;

implementation

{$R *.lfm}

uses VARINIT, maindatamodule, strdatetime;

{ TManRecForm }

procedure TManRecForm.BasicinfQueryY_COORDGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := YCoord;
end;

procedure TManRecForm.DEPTHGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then DisplayText := False
  else
    aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
end;

procedure TManRecForm.DIAM_OPENGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 2);
  end;
end;

procedure TManRecForm.CasingTableMATERIALGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := DataModuleMain.TranslateCode('MATERIAL', Sender.AsString);
end;

procedure TManRecForm.CasingTableOPEN_TYPEGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := DataModuleMain.TranslateCode('OPENTYPE', Sender.AsString);
end;

procedure TManRecForm.Chem0QueryBeforeOpen(DataSet: TDataSet);
var
  FilterIndex: ShortInt;
begin
  Chem0Query.Connection := DataModuleMain.ZConnectionDB;
  with Chem0Query.SQL do
  begin
    Clear;
    Add('SELECT SITE_ID_NR, SAMPLE_NR, DATE_SAMPL, TIME_SAMPL, DEPTH_SAMP, LAB, DATE_ANAL, COMMENT, CHM_REF_NR FROM chem_000');
    Add('WHERE SITE_ID_NR = ' + QuotedStr(ZTableViewReportSITE_ID_NR.Value));
  end;
  FilterIndex := TheUsedTablesList.IndexOf('chem_000');
  if FilterIndex > - 1 then
  begin
    Chem0Query.Filter := TheFilterList.Strings[FilterIndex];
    Chem0Query.Filtered := UseConstraints and (Dataset.Filter > '');
  end;
end;

procedure TManRecForm.Chem0QueryDEPTH_SAMPGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if not Sender.IsNull then
    aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2)
  else DisplayText := False;
end;

procedure TManRecForm.Chem1QueryBeforeOpen(DataSet: TDataSet);
var
  FilterIndex: ShortInt;
begin
  Chem1Query.Connection := DataModuleMain.ZConnectionDB;
  with Chem1Query do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM chem_001');
    SQL.Add('WHERE CHM_REF_NR = ' + IntToStr(Chem0QueryCHM_REF_NR.AsInteger));
  end;
  FilterIndex := TheUsedTablesList.IndexOf('chem_001');
  if FilterIndex > - 1 then
  begin
    Chem1Query.Filter := TheFilterList.Strings[FilterIndex] + ' AND CHM_REF_NR = ' + IntToStr(Chem0QueryCHM_REF_NR.AsInteger);
    Chem1Query.Filtered := UseConstraints and (Dataset.Filter > '');
  end;
end;

procedure TManRecForm.Chem1QueryCalcFields(DataSet: TDataSet);
var
  SumTDS, sumCations, sumAnions, THardness, Carbonates, TAlk: Real;
  pK, pCa, pAlk: Real;
  UseTAlk: Boolean;
begin
  pK := 0;
  {Total TDS}
  if Chem1QueryPH.Value < 9 then
  begin
    if Chem1QueryHCO3.Value > -1 then
      Carbonates := Chem1QueryHCO3.Value
    else
      Carbonates := Chem1QueryMALK.Value / 0.8202;
  end
  else
  begin
    if (Chem1QueryHCO3.Value > -1) and (Chem1QueryCO3.Value > -1) then
      Carbonates := Chem1QueryHCO3.Value + Chem1QueryCO3.Value
    else
      Carbonates := Chem1QueryMALK.Value / 0.8202;
  end;
  SumTDS := Chem1QueryCA.Value + Chem1QueryMG.Value + Chem1QueryNA.Value
    + Chem1QueryK.Value + Carbonates + Chem1QueryCL.Value + Chem1QuerySO4.Value
    + Chem1QueryN.Value * 4.4263724 + Chem1QueryF.Value + Chem1QuerySI.Value * 2.1393
    + Chem1QueryFE.Value;
  if SumTDS > 0 then Chem1QuerySumTDS.Value := SumTDS;
  {TDS EC * 7}
  if Chem1QueryEC.Value > 0 then Chem1QueryTDS7.Value := Chem1QueryEC.Value * 7;
  {Ion Balance}
  sumCations := 0; //<--Cations from here
  if Chem1QueryCA.Value > -1 then
    sumCations := sumCations + Chem1QueryCA.Value * CParam[0];
  if Chem1QueryMG.Value > -1 then
    sumCations := sumCations + Chem1QueryMG.Value * CParam[1];
  if Chem1QueryNA.Value > -1 then
    sumCations := sumCations + Chem1QueryNA.Value * CParam[2];
  if Chem1QueryK.Value > -1 then
    sumCations := sumCations + Chem1QueryK.Value * CParam[3];
  if DataModuleMain.StandardTable.Locate('PARAMETER', 'FE', []) and (Chem1QueryFE.Value > DataModuleMain.StandardTableSTDRECHI.Value)
  then sumCations := sumCations + Chem1QueryFE.Value * CParam[13];
  if DataModuleMain.StandardTable.Locate('PARAMETER', 'MN', []) and (Chem1QueryMN.Value > DataModuleMain.StandardTableSTDRECHI.Value)
  then sumCations := sumCations + Chem1QueryMN.Value * CParam[14];
  sumAnions := 0; //<--Anions from here
  if Chem1QueryHCO3.Value > -1 then
  begin
    sumAnions := sumAnions + Chem1QueryHCO3.Value * CParam[4];
    if Chem1QueryCO3.Value > -1 then
      sumAnions := sumAnions + Chem1QueryCO3.Value * CParam[9];
  end
  else
  if Chem1QueryMALK.Value > -1 then
    sumAnions := sumAnions + Chem1QueryMALK.Value / 50;
  if Chem1QueryCL.Value > -1 then
    sumAnions := sumAnions + Chem1QueryCL.Value * CParam[5];
  if Chem1QuerySO4.Value > -1 then
    sumAnions := sumAnions + Chem1QuerySO4.Value * CParam[6];
  if Chem1QueryN.Value > -1 then
    sumAnions := sumAnions + Chem1QueryN.Value * CParam[7];
    //sumAnions := sumAnions + Chem1QueryN.Value * 4.4263724 * CParam[11];
  if Chem1QueryF.Value > -1 then
    sumAnions := sumAnions + Chem1QueryF.Value * CParam[8];
  if Chem1QuerySI.Value > -1 then
    sumAnions := sumAnions + Chem1QuerySI.Value * CParam[12];
  if sumCations > 0 then Chem1QueryCations.Value := sumCations;
  if SumAnions > 0 then Chem1QueryAnions.Value := sumAnions;
  if (sumCations + sumAnions) > 0 then Chem1QueryBError.Value :=
    (sumCations - sumAnions) * 100 /(sumCations + sumAnions);
  {Total Hardness}
  THardness := (Chem1QueryCA.Value * CParam[0] + Chem1QueryMG.Value
    * CParam[1]) * 50;
  if THardness > 0 then Chem1QueryTHard.Value := THardness;
  {Determine use of TAlk}
  UseTAlk := (Chem1QueryHCO3.Value > -1) and (Chem1QueryCO3.Value > -1);
  if UseTAlk then TAlk := (Chem1QueryHCO3.Value * CParam[4] + Chem1QueryCO3.Value * CParam[9]) * 50;
  {Carbonate Hardness}
  if UseTAlk and (THardness > 0) then
  begin
    if TAlk <= THardness then Chem1QueryCaHard.Value := TAlk
    else if TAlk > THardness then Chem1QueryCaHard.Value := THardness;
  end
  else
  if (Chem1QueryMALK.Value > -1) and (THardness > 0) then
  begin
    if Chem1QueryMALK.Value <= THardness then Chem1QueryCaHard.Value := Chem1QueryMALK.Value
    else if Chem1QueryMALK.Value > THardness then Chem1QueryCaHard.Value := THardness;
  end;
  {Magnesium Hardness}
  if Chem1QueryMG.Value > 0 then Chem1QueryMGHard.Value := Chem1QueryMG.Value * 4.116;
  {Aggressive index}
  if UseTAlk then
  begin
    if (TAlk * Chem1QueryCA.Value * CParam[0] * 50) > 0 then
      Chem1QueryAggressive.Value := Chem1QueryPH.Value + Log10(TAlk * Chem1QueryCA.Value * CParam[0] * 50);
  end
  else
  begin
    if (Chem1QueryMALK.Value * Chem1QueryCA.Value * CParam[0] * 50) > 0 then
    Chem1QueryAggressive.Value := Chem1QueryPH.Value + Log10(Chem1QueryMALK.Value
      * Chem1QueryCA.Value * CParam[0] * 50);
  end;
  {Langelier}
  if SumTDS > 0 then pK := 1.6972 * Power(SumTDS, 0.0516);
  if UseTAlk and (TAlk > 0) and (Chem1QueryCA.Value > 0) then
  begin
    pCa := - Log10(Chem1QueryCA.Value * CParam[0]/2000);
    pAlk := - Log10(TAlk/50000);
    Chem1QueryLangelier.Value := Chem1QueryPH.Value - (pK + pCa + pAlk);
  end
  else
  if (Chem1QueryCA.Value > 0) and (Chem1QueryMALK.Value > 0) then
  begin
    pCa := - Log10(Chem1QueryCA.Value * CParam[0]/2000);
    pAlk := - Log10(Chem1QueryMALK.Value/50000);
    Chem1QueryLangelier.Value := Chem1QueryPH.Value - (pK + pCa + pAlk);
  end;
  {Corrosion Tendency}
  if UseTAlk and (TAlk > 0) and (Chem1QueryCL.Value > 0) and (Chem1QuerySO4.Value > 0) then
    Chem1QueryCorrosion.Value := (Chem1QueryCL.Value  * CParam[5] + Chem1QuerySO4.Value  * CParam[6])
      / (TAlk / 50)
  else
  if (Chem1QueryMALK.Value > 0) and (Chem1QueryCL.Value > 0) and (Chem1QuerySO4.Value > 0) then
    Chem1QueryCorrosion.Value := (Chem1QueryCL.Value  * CParam[5] + Chem1QuerySO4.Value  * CParam[6])
      / (Chem1QueryMALK.Value / 50);
  {SAR}
  if (Chem1QueryNA.Value > 0) and (Chem1QueryCA.Value > 0) and (Chem1QueryMG.Value > 0) then
    Chem1QuerySAR.Value := (Chem1QueryNA.Value * CParam[2]) /
      SQRT((Chem1QueryCA.Value * CParam[0] + Chem1QueryMG.Value * CParam[1]) / 2)
  //old wrong??? calculation
  {pK := 0;
  //Total TDS
  if Chem1QueryPH.Value < 9 then
  begin
    if Chem1QueryHCO3.Value > -1 then
      Carbonates := Chem1QueryHCO3.Value
    else
      Carbonates := Chem1QueryMALK.Value / 0.8202;
  end
  else
  begin
    if (Chem1QueryHCO3.Value > -1) and (Chem1QueryCO3.Value > -1) then
      Carbonates := Chem1QueryHCO3.Value + Chem1QueryCO3.Value
    else
      Carbonates := Chem1QueryMALK.Value / 0.8202;
  end;
  //Ion Balance
  sumCations := 0;
  if Chem1QueryCA.Value > -1 then
    sumCations := sumCations + Chem1QueryCA.Value * CParam[0];
  if Chem1QueryMG.Value > -1 then
    sumCations := sumCations + Chem1QueryMG.Value * CParam[1];
  if Chem1QueryNA.Value > -1 then
    sumCations := sumCations + Chem1QueryNA.Value * CParam[2];
  if Chem1QueryK.Value > -1 then
    sumCations := sumCations + Chem1QueryK.Value * CParam[3];
  sumAnions := 0;
  if Chem1QueryHCO3.Value > -1 then
  begin
    sumAnions := sumAnions + Chem1QueryHCO3.Value * CParam[4];
    if Chem1QueryCO3.Value > -1 then
      sumAnions := sumAnions + Chem1QueryCO3.Value * CParam[9];
  end
  else
  if Chem1QueryMALK.Value > -1 then
    sumAnions := sumAnions + Chem1QueryMALK.Value / 50;
  if Chem1QueryCL.Value > -1 then
    sumAnions := sumAnions + Chem1QueryCL.Value * CParam[5];
  if Chem1QuerySO4.Value > -1 then
    sumAnions := sumAnions + Chem1QuerySO4.Value * CParam[6];
  if Chem1QueryN.Value > -1 then
    sumAnions := sumAnions + Chem1QueryN.Value * CParam[7];
  if Chem1QueryF.Value > -1 then
    sumAnions := sumAnions + Chem1QueryF.Value * CParam[8];
  if sumCations > 0 then Chem1QueryCations.Value := sumCations;
  if SumAnions > 0 then Chem1QueryAnions.Value := sumAnions;
  if (sumCations + sumAnions) > 0 then
    Chem1QueryBError.Value := (sumCations - sumAnions) * 100 /(sumCations + sumAnions);
  //Total Hardness
  THardness := (Chem1QueryCA.Value * CParam[0] + Chem1QueryMG.Value
    * CParam[1]) * 50;
  if THardness > 0 then Chem1QueryTHard.Value := THardness;
  //Determine use of TAlk
  UseTAlk := (Chem1QueryHCO3.Value > -1) and (Chem1QueryCO3.Value > -1);
  if UseTAlk then TAlk := (Chem1QueryHCO3.Value * CParam[4] + Chem1QueryCO3.Value * CParam[9]) * 50;
  //Carbonate Hardness
  if UseTAlk and (THardness > 0) then
  begin
    if TAlk <= THardness then Chem1QueryCaHard.Value := TAlk
    else if TAlk > THardness then Chem1QueryCaHard.Value := THardness;
  end
  else
  if (Chem1QueryMALK.Value > -1) and (THardness > 0) then
  begin
    if Chem1QueryMALK.Value <= THardness then Chem1QueryCaHard.Value := Chem1QueryMALK.Value
    else if Chem1QueryMALK.Value > THardness then Chem1QueryCaHard.Value := THardness;
  end;
  //Magnesium Hardness
  if Chem1QueryMG.Value > 0 then Chem1QueryMGHard.Value := Chem1QueryMG.Value * 4.116;
  //Aggressive index
  if UseTAlk then
  begin
    if (TAlk * Chem1QueryCA.Value * CParam[0] * 50) > 0 then
      Chem1QueryAggressive.Value := Chem1QueryPH.Value + Log10(TAlk * Chem1QueryCA.Value * CParam[0] * 50);
  end
  else
  begin
    if (Chem1QueryMALK.Value * Chem1QueryCA.Value * CParam[0] * 50) > 0 then
    Chem1QueryAggressive.Value := Chem1QueryPH.Value + Log10(Chem1QueryMALK.Value
      * Chem1QueryCA.Value * CParam[0] * 50);
  end;
  //Langelier
  if SumTDS > 0 then pK := 1.6972 * Power(SumTDS, 0.0516);
  if UseTAlk and (TAlk > 0) and (Chem1QueryCA.Value > 0) then
  begin
    pCa := - Log10(Chem1QueryCA.Value * CParam[0]/2000);
    pAlk := - Log10(TAlk/50000);
    Chem1QueryLANGELIER.Value := Chem1QueryPH.Value - (pK + pCa + pAlk);
  end
  else
  if (Chem1QueryCA.Value > 0) and (Chem1QueryMALK.Value > 0) then
  begin
    pCa := - Log10(Chem1QueryCA.Value * CParam[0]/2000);
    pAlk := - Log10(Chem1QueryMALK.Value/50000);
    Chem1QueryLangelier.Value := Chem1QueryPH.Value - (pK + pCa + pAlk);
  end;
  //Corrosion Tendency
  if UseTAlk and (TAlk > 0) and (Chem1QueryCL.Value > 0) and (Chem1QuerySO4.Value > 0) then
    Chem1QueryCorrosion.Value := (Chem1QueryCL.Value  * CParam[5] + Chem1QuerySO4.Value  * CParam[6])
      / (TAlk / 50)
  else
  if (Chem1QueryMALK.Value > 0) and (Chem1QueryCL.Value > 0) and (Chem1QuerySO4.Value > 0) then
    Chem1QueryCorrosion.Value := (Chem1QueryCL.Value  * CParam[5] + Chem1QuerySO4.Value  * CParam[6])
      / (Chem1QueryMALK.Value / 50);
  //SAR
  if (Chem1QueryNA.Value > 0) and (Chem1QueryCA.Value > 0) and (Chem1QueryMG.Value > 0) then
    Chem1QuerySAR.Value := (Chem1QueryNA.Value * CParam[2]) /
      SQRT((Chem1QueryCA.Value * CParam[0] + Chem1QueryMG.Value * CParam[1]) / 2)}
end;

procedure TManRecForm.ChemGetText(Sender: TField; var aText: string;
  DisplayText: Boolean);
var
  Limit: ShortString;
  TheValue: Double;
begin
  if (Sender.Value <> -1) and (not Sender.IsNull) then
  begin
    if LimitsQuery.Locate('CPARAMETER', Sender.FieldName, []) then
      Limit := LimitsQueryLIMITS.AsString + ' '
    else
      Limit := '';
    TheValue := Sender.Value * ChemFactor;
    if (Abs(TheValue) > 0) and (Abs(TheValue) < 0.0001) then
      aText := Limit + FloatToStrF(TheValue, ffFixed, 15, 5)
    else
    if Abs(TheValue) < 0.001 then
      aText := Limit + FloatToStrF(TheValue, ffFixed, 15, 4)
    else
    if Abs(TheValue) < 0.01 then
      aText := Limit + FloatToStrF(TheValue, ffFixed, 15, 3)
    else
    if Abs(TheValue) < 100 then
      aText := Limit + FloatToStrF(TheValue, ffFixed, 15, 2)
    else
    if Abs(TheValue) < 1000 then
      aText := Limit + FloatToStrF(TheValue, ffFixed, 15, 1)
    else
      aText := Limit + FloatToStrF(TheValue, ffFixed, 15, 0);
    if ShowStandard then
    begin
      if DataModuleMain.ClassTable.Active then
      begin
        if DataModuleMain.ClassTable.Locate('PARAMETER', Sender.FieldName, []) then
          (FindComponent('RLDBText' + Sender.FieldName) as TRLDBText).Font := DataModuleMain.GetFont(Sender.Value)
        else
          (FindComponent('RLDBText' + Sender.FieldName) as TRLDBText).Font := AppFont;
      end
      else
      begin
        if DataModuleMain.StandardTable.Locate('PARAMETER', Sender.FieldName, []) then
          (FindComponent('RLDBText' + Sender.FieldName) as TRLDBText).Font := DataModuleMain.GetFont(Sender.Value)
        else
          (FindComponent('RLDBText' + Sender.FieldName) as TRLDBText).Font := AppFont;
      end;
    end;
  end
  else DisplayText := False;
end;

procedure TManRecForm.DataSourceViewDataChange(Sender: TObject; Field: TField);
begin
  BasicinfQuery.Close;
  BasicinfQuery.Open;
  Chem0Query.Close;
  Chem0Query.Open;
  Chem1Query.Close;
  Chem1Query.Open;
  WaterlevQuery.Close;
  WaterlevQuery.Open;
end;

procedure TManRecForm.ExtractAddParamQueryBeforeOpen(DataSet: TDataSet);
begin
  ExtractAddParamQuery.Connection := DataModuleMain.ZConnectionDB;
end;

procedure TManRecForm.BasicinfQueryX_COORDGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := XCoord;
end;

procedure TManRecForm.BasicinfQueryBH_DIAMGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if not Sender.IsNull then
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TManRecForm.BasicinfQueryCOLLAR_HIGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if not Sender.IsNull then
  begin
    if Abs(Sender.AsFloat * LengthFactor) > 100 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 1)
    else
    if Abs(Sender.AsFloat * LengthFactor) = 0 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2)
    else
    if Abs(Sender.AsFloat * LengthFactor) < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 3)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end
  else
    DisplayText := False;
end;

procedure TManRecForm.BasicinfQueryALTITUDEGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNULL then DisplayText := False
  else
  begin
    if Abs(Sender.AsFloat * LengthFactor) > 10000 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
    else
    if (Abs(Sender.AsFloat * LengthFactor) < 0.01) and (Abs(Sender.AsFloat * LengthFactor) > 0) then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end;
end;

procedure TManRecForm.BasicinfQueryBeforeOpen(DataSet: TDataSet);
begin
  BasicinfQuery.Connection := DataModuleMain.ZConnectionDB;
  with BasicinfQuery.SQL do
  begin
    Clear;
    Add('SELECT SITE_ID_NR, NR_ON_MAP, SITE_TYPE, FARM_NR, SITE_NAME, X_COORD, Y_COORD, ALTITUDE, ALT_NO_1, ALT_NO_2, REP_INST, BH_DIAM, DEPTH, COLLAR_HI, SITE_STATU, SITE_PURPS, USE_CONSUM, USE_APPLIC');
    Add('FROM basicinf');
    Add('WHERE SITE_ID_NR = ' + QuotedStr(ZTableViewReportSITE_ID_NR.Value));
  end;
end;

procedure TManRecForm.AquiferTableMETH_MEASGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := DataModuleMain.TranslateCode('DISCMEAS', Sender.AsString);
end;

procedure TManRecForm.AquiferTableYIELDGetText(Sender: TField;
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
  else DisplayText := False;
end;

procedure TManRecForm.AquiferTableAQUI_TYPEGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := DataModuleMain.TranslateCode('AQUITYPE', Sender.AsString);
end;

procedure TManRecForm.ExtractAddParamQueryADD_PARAMGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.AsFloat > -1 then
    aText := Sender.AsString
  else
    DisplayText := False;
end;

procedure TManRecForm.Chem1QueryECGetText(Sender: TField; var aText: string;
  DisplayText: Boolean);
var
  Limit: ShortString;
begin
  if LimitsQuery.Locate('CPARAMETER', Sender.FieldName, []) then
    Limit := LimitsQueryLIMITS.AsString + ' '
  else
    Limit := '';
  if (Sender.Value <> -1) and (not Sender.IsNull) then
  begin
    aText := Limit + FloatToStrF(Sender.AsFloat * ECFactor, ffFixed, 15, 2);
    if ShowStandard then
    begin
      if DataModuleMain.ClassTable.Active then
      begin
        if DataModuleMain.ClassTable.Locate('PARAMETER', Sender.FieldName, []) then
          RLDBTextEC.Font := DataModuleMain.GetFont(Sender.Value)
        else RLDBTextEC.Font := AppFont;
      end
      else
      begin
        if DataModuleMain.StandardTable.Locate('PARAMETER', Sender.FieldName, []) then
          RLDBTextEC.Font := DataModuleMain.GetFont(Sender.Value)
        else RLDBTextEC.Font := AppFont;
      end;
    end;
  end
  else DisplayText := False;
end;

procedure TManRecForm.Chem0QueryDATEGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    aText := DateToStr(StringToDate(Sender.AsString));
  end;
end;

procedure TManRecForm.TableBeforeOpen(DataSet: TDataSet);
begin
  (DataSet as TZTable).Connection := DataModuleMain.ZConnectionDB;
end;

procedure TManRecForm.LimitsQueryBeforeOpen(DataSet: TDataSet);
begin
  (DataSet as TZQuery).Connection := DataModuleMain.ZConnectionDB;
end;

procedure TManRecForm.BasicinfQuerySITE_ID_NRGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := Sender.Value;
  with DataModuleMain do
    cs2cs(BasicinfQueryX_COORD.AsString, BasicinfQueryY_COORD.AsString, GetMapRef(BasicinfQuerySITE_ID_NR.AsString), OrigCoordSysNr, CoordSysNr, XCoord, YCoord);
end;

procedure TManRecForm.ChemQueryAsNGetText(Sender: TField; var aText: string;
  DisplayText: Boolean);
var
  Limit: ShortString;
  TheValue: Double;
begin
  if (not Sender.IsNull) and (Sender.Value > -1) then
  begin
    if LimitsQuery.Locate('CPARAMETER', Sender.FieldName, []) then
      Limit := LimitsQueryLIMITS.AsString + ' '
    else
      Limit := '';
    if AsN then
      TheValue := Sender.AsFloat * ChemFactor
    else
      TheValue := Sender.AsFloat * ParamFactor[Sender.Tag] * ChemFactor;
    if (Abs(TheValue) > 0) and (Abs(TheValue) < 0.0001) then
      aText := Limit + FloatToStrF(TheValue, ffFixed, 15, 5)
    else
    if Abs(TheValue) < 0.001 then
      aText := Limit + FloatToStrF(TheValue, ffFixed, 15, 4)
    else
    if Abs(TheValue) < 0.01 then
      aText := Limit + FloatToStrF(TheValue, ffFixed, 15, 3)
    else
    if Abs(TheValue) < 100 then
      aText := Limit + FloatToStrF(TheValue, ffFixed, 15, 2)
    else
    if Abs(TheValue) < 1000 then
      aText := Limit + FloatToStrF(TheValue, ffFixed, 15, 1)
    else
      aText := Limit + FloatToStrF(TheValue, ffFixed, 15, 0);
    if ShowStandard then
    begin
      if DataModuleMain.ClassTable.Active then
      begin
        if DataModuleMain.ClassTable.Locate('PARAMETER', Sender.FieldName, []) then
          TRLDBText(FindComponent('RLDBText' + Sender.FieldName)).Font := DataModuleMain.GetFont(Sender.Value)
        else TRLDBText(FindComponent('RLDBText' + Sender.FieldName)).Font := AppFont;
      end
      else
      begin
        if DataModuleMain.StandardTable.Locate('PARAMETER', Sender.FieldName, []) then
          TRLDBText(FindComponent('RLDBText' + Sender.FieldName)).Font := DataModuleMain.GetFont(Sender.Value)
        else TRLDBText(FindComponent('RLDBText' + Sender.FieldName)).Font := AppFont;
      end;
    end;
  end
  else DisplayText := False;
end;

procedure TManRecForm.ChemNoFactorGetText(Sender: TField; var aText: string;
  DisplayText: Boolean);
var
  Limit: ShortString;
  TheValue: Double;
begin
  if (Sender.Value <> -1) and (not Sender.IsNull) then
  begin
    if LimitsQuery.Locate('CPARAMETER', Sender.FieldName, []) then
      Limit := LimitsQueryLIMITS.AsString + ' '
    else
      Limit := '';
    TheValue := Sender.AsFloat;
    if Sender.FieldDef.DataType = ftLargeint then
      aText := Limit + FloatToStrF(TheValue, ffFixed, 15, 0)
    else
    if (Abs(TheValue) > 0) and (Abs(TheValue) < 0.0001) then
      aText := Limit + FloatToStrF(TheValue, ffFixed, 15, 5)
    else
    if Abs(TheValue) < 0.001 then
      aText := Limit + FloatToStrF(TheValue, ffFixed, 15, 4)
    else
    if Abs(TheValue) < 0.01 then
      aText := Limit + FloatToStrF(TheValue, ffFixed, 15, 3)
    else
    if Abs(TheValue) < 100 then
      aText := Limit + FloatToStrF(TheValue, ffFixed, 15, 2)
    else
    if Abs(TheValue) < 1000 then
      aText := Limit + FloatToStrF(TheValue, ffFixed, 15, 1)
    else
      aText := Limit + FloatToStrF(TheValue, ffFixed, 15, 0);
    if ShowStandard then
    begin
      if DataModuleMain.ClassTable.Active then
      begin
        if DataModuleMain.ClassTable.Locate('PARAMETER', Sender.FieldName, []) then
          (FindComponent('RLDBText' + Sender.FieldName) as TRLDBText).Font := DataModuleMain.GetFont(Sender.Value)
        else
        if Sender.FieldName = 'PH' then
        begin
          if Sender.Value >= 7 then
          begin
            DataModuleMain.ClassTable.Locate('PARAMETER', 'PHU', []);
            RLDBTextPH.Font := DataModuleMain.GetFont(Sender.Value);
          end
          else
          begin
            DataModuleMain.ClassTable.Locate('PARAMETER', 'PHL', []);
            RLDBTextPH.Font := DataModuleMain.GetFont(-Sender.Value);
          end;
        end
        else
          (FindComponent('RLDBText' + Sender.FieldName) as TRLDBText).Font := AppFont;
      end
      else
      begin
        if DataModuleMain.StandardTable.Locate('PARAMETER', Sender.FieldName, []) then
          (FindComponent('RLDBText' + Sender.FieldName) as TRLDBText).Font := DataModuleMain.GetFont(Sender.Value)
        else
          (FindComponent('RLDBText' + Sender.FieldName) as TRLDBText).Font := AppFont;
      end;
    end;
  end
  else DisplayText := False;
end;

procedure TManRecForm.BasicinfQueryDEPTHGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if not Sender.IsNull then
  begin
    if Sender.Value * LengthFactor > 1000 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
    else
    if Sender.Value * LengthFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TManRecForm.BasicinfQueryREP_INSTGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := DataModuleMain.TranslateCode('REP_INST', Sender.AsString);
end;

procedure TManRecForm.BasicinfQuerySITE_PURPSGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := DataModuleMain.TranslateCode('SITEPURP', Sender.AsString);
end;

procedure TManRecForm.BasicinfQuerySITE_STATUGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := DataModuleMain.TranslateCode('SITESTAT', Sender.AsString);
end;

procedure TManRecForm.BasicinfQuerySITE_TYPEGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := DataModuleMain.TranslateCode('SITETYPE', Sender.AsString);
end;

procedure TManRecForm.BasicinfQueryUSE_APPLICGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := DataModuleMain.TranslateCode('APPLICAT', Sender.AsString);
end;

procedure TManRecForm.BasicinfQueryUSE_CONSUMGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := DataModuleMain.TranslateCode('WATRCONS', Sender.AsString);
end;

procedure TManRecForm.InstallaTableDEPTH_INTKGetText(Sender: TField;
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
  end
  else aText := '';
end;

procedure TManRecForm.InstallaTableMANUFACTURGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Length(Sender.AsString) > 4 then
    aText := Sender.AsString
  else
    aText := DataModuleMain.TranslateCode('PUMPMANU', Sender.AsString);
end;

procedure TManRecForm.InstallaTableTYPE_INSTLGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := DataModuleMain.TranslateCode('TYPEINST', Sender.AsString);
end;

procedure TManRecForm.InstallaTableTYPE_POWERGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := DataModuleMain.TranslateCode('TYPEPOWR', Sender.AsString);
end;

procedure TManRecForm.InstDetlTableE_MANUFGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Length(Sender.AsString) > 4 then
    aText := Sender.AsString
  else
    aText := DataModuleMain.TranslateCode('ENGNMANU', Sender.AsString);
end;

procedure TManRecForm.ManRecReportAfterPrint(Sender: TObject);
begin
  BasicinfQuery.Close;
  WaterlevQuery.Close;
  Chem0Query.Close;
  Chem1Query.Close;
  Chem003Table.Close;
  ExtractAddParamQuery.Close;
  InstallaTable.Close;
  InstDetlTable.Close;
  AquiferTable.Close;
  CasingTable.Close;
  TestingTable.Close;
  RecommendTable.Close;
  LimitsQuery.Close;
  ZTableViewReport.Close;
  DataModuleMain.LookupTable.Filtered := False;
end;

procedure TManRecForm.ManRecReportBeforePrint(Sender: TObject;
  var PrintIt: boolean);
var c: Word;
    i: Integer;
begin
  //set report fonts
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TRLLabel then
    begin
      with (Components[i] as TRLLabel).Font do
      begin
        Name := ReportFont.Name;
        Color := ReportFont.Color;
        if Components[i].Tag = 0 then
          Size := ReportFont.Size
        else Size := ReportFont.Size + 2;
      end;
    end
    else
    if Components[i] is TRLDBText then
    begin
      with (Components[i] as TRLDBText).Font do
      begin
        Name := ReportFont.Name;
        Color := ReportFont.Color;
        Size := ReportFont.Size;
        Style := ReportFont.Style;
      end;
    end
    else
    if Components[i] is TRLSystemInfo then
    begin
      with (Components[i] as TRLSystemInfo).Font do
      begin
        Name := ReportFont.Name;
        Color := ReportFont.Color;
        //Style := ReportFont.Style;
        if Components[i].Tag = 0 then
          Size := ReportFont.Size
        else Size := ReportFont.Size + 2;
      end;
    end
    else
    if Components[i] is TRLMemo then
    begin
      with (Components[i] as TRLMemo).Font do
      begin
        Name := ReportFont.Name;
        Color := ReportFont.Color;
        if (Components[i] as TRLMemo).Name <> 'RLMemoConcentrations' then
          Size := ReportFont.Size;
        Style := ReportFont.Style;
      end;
    end
    else
    if Components[i] is TRLDBMemo then
    begin
      with (Components[i] as TRLDBMemo).Font do
      begin
        Name := ReportFont.Name;
        Color := ReportFont.Color;
        Size := ReportFont.Size;
        Style := ReportFont.Style;
      end;
    end;
  end;
  Coordlabel.Caption := 'Coordinate System: ' + CoordSysDescr;
  CoordLabel.Font.Size := ReportFont.Size - 1;
  RLLabelStandard.Font.Size := ReportFont.Size - 1;
  with ManRecReport do
  begin
    Margins.LeftMargin := LeftMargin;
    Margins.TopMargin := TopMargin;
    Margins.BottomMargin := BotMargin;
    Margins.RightMargin := 10 - LeftMargin + 10;
  end;
  if DoPageBreak then
    RLBand1.PageBreaking := pbBeforePrint
  else
    RLBand1.PageBreaking := pbNone;
  RLBandHeader.Color := ReportHeaderBandColor;
  for c := 0 to ComponentCount - 1 do
    if (Components[c] is TRLBand) and (TRLBand(Components[c]).GroupIndex >= 3)
      then TRLBand(Components[c]).Color := ColumnHeaderBandColor;
  if UseView then
    ZTableViewReport.TableName := ViewName
  else
  begin
    ZTableViewReport.Tablename := FilterName;
    ZTableViewReport.Filter := 'SITE_ID_NR = ' + QuotedStr(CurrentSite);
    ZTableViewReport.Filtered := True;
  end;
  DataModuleMain.LookupTable.Filtered := True;
  //open standards tables
  if ShowStandard then
    RLLabelStandard.Caption := RLLabelStandard.Caption + ' ' + ChemStandardDescr
  else
    RLLabelStandard.Visible := False;
  //Open tables
  ZTableViewReport.Open;
  //with ViewDataSourceChange basicinf, waterlev chem etc get openend as well
  OpenTable(Chem003Table);
  OpenTable(InstallaTable);
  OpenTable(InstDetlTable);
  LimitsQuery.Open;
  AquiferSubDetail.Enabled := OpenTable(AquiferTable);
  CasingSubDetail.Enabled := OpenTable(CasingTable);
  TestingSubDetail.Enabled := OpenTable(TestingTable);
  RecommendSubDetail.Enabled := OpenTable(RecommendTable);
  //Get the additional parameter
  if ShowAddParam then
  begin
    RLDBTextAddParam.Visible := True;
    RLLabelAddParam.Visible := True;
    for i := 1 to 5 do
    with FindParamQuery do
    begin
      Connection := DataModuleMain.ZConnectionDB;
      SQL.Clear;
      SQL.Add('SELECT * FROM chem_00' + IntToStr(i) + ' LIMIT 1');
      Open;
      if FindField(AddParam) <> nil then
      begin
        RLLabelAddParam.Caption := AddParam + ':';
        Close;
        Break;
      end
      else
        Close;
    end;
    with ExtractAddParamQuery do
    begin
      Connection := DataModuleMain.ZConnectionDB;
      SQL.Clear;
      SQL.Add('SELECT CHM_REF_NR, ' + AddParam  + ' AS ADD_PARAM' + ' FROM chem_00' + IntToStr(i));
      Open;
    end;
  end;
  //Show Laboratory info when checked
  if ShowLab then
  begin
    RLLabelAnal.Visible := True;
    RLDBTextLab.Visible := True;
    RLLabelOn.Visible := True;
    RLDBTextDate.Visible := True;
  end;
  //Set Labels of coordinate edits
  Application.ProcessMessages;
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
  if UseResDD then
    RLLabel104.Caption := 'Res. drawdown';
  {Set Units in labels}
  RLLabel10.Caption := RLLabel10.Caption + ' [' + LengthUnit + ']:';
  RLLabel14.Caption := RLLabel14.Caption + ' [' + DiamUnit + ']:';
  RLLabel15.Caption := RLLabel15.Caption + ' [' + LengthUnit + ']:';
  RLLabel16.Caption := RLLabel16.Caption + ' [' + LengthUnit + ']:';
  RLLabel17.Caption := RLLabel17.Caption + ' [' + LengthUnit + ']:';
  RLLabel30.Caption := RLLabel30.Caption + ' [' + LengthUnit + ']:';
  RLLabel37.Caption := RLLabel37.Caption + ' [' + LengthUnit + ']:';
  RLLabel72.Caption := RLLabel72.Caption + ' [' + LengthUnit + ']';
  RLLabel73.Caption := RLLabel73.Caption + ' [' + LengthUnit + ']';
  RLLabel74.Caption := RLLabel74.Caption + ' [' + DisUnit + ']';
  RLLabel79.Caption := RLLabel79.Caption + ' [' + LengthUnit + ']';
  RLLabel80.Caption := RLLabel80.Caption + ' [' + LengthUnit + ']';
  RLLabel93.Caption := '[' + DiamUnit + ']';
  RLLabel92.Caption := '[' + DiamUnit + ']';
  RLLabel85.Caption := RLLabel85.Caption + ' [' + DiamUnit + ']:';
  RLLabel108.Caption := RLLabel108.Caption + ' [' + LengthUnit + ']';
  RLLabel102.Caption := RLLabel102.Caption + ' [' + DisUnit + ']';
  RLLabel107.Caption := '[' + LengthUnit + ']';
  RLLabel100.Caption := '[' + LengthUnit + ']';
  RLLabel123.Caption := RLLabel123.Caption + ' [' + LengthUnit + ']';
  RLLabel120.Caption := RLLabel120.Caption + ' [' + DisUnit + ']';
  RLLabel121.Caption := RLLabel121.Caption + ' [' + LengthUnit + ']';
  RLLabel129.Caption := RLLabel129.Caption + ' [' + LengthUnit + ']';
  if AsN then RLLabel53.Caption := 'NO3 as N:'
  else RLLabel53.Caption := 'NO3:';
  RLLabelEC.Caption := RLLabelEC.Caption + ' [' + ECUnit + ']:';
  RLMemoConcentrations.Lines.Clear;
  RLMemoConcentrations.Lines.Add('Concentrations in [' + ChemUnit + '] where applicable');
  RLMemoConcentrations.Lines.Add('Bacteriological parameters in [counts/100ml]');
  if FileExists(WSpaceDir + '/Userinfo.txt') then
    RLMemoUserDetails.Lines.LoadFromFile(WSpaceDir + '/Userinfo.txt');
  if FileExists(WSpaceDir + '/userlogo.jpg') then
    RLImageLogo.Picture.LoadFromFile(WSpaceDir + '/userlogo.jpg')
  else
  if FileExists(WSpaceDir + '/userlogo.bmp') then
    RLImageLogo.Picture.LoadFromFile(WSpaceDir + '/userlogo.bmp');
  Application.ProcessMessages;
end;

function TManRecForm.OpenTable(const Table2Open: TZTable): Boolean;
var FilterIndex: ShortInt;
begin
  FilterIndex := TheUsedTablesList.IndexOf(Table2Open.Tablename);
  if FilterIndex > - 1 then
  begin
    Table2Open.Filter := TheFilterList.Strings[FilterIndex];
    Table2Open.Filtered := UseConstraints and (Table2Open.Filter > '');
  end;
  Table2Open.Connection := DataModuleMain.ZConnectionDB;
  Table2Open.Open;
  Result := True;
end;

procedure TManRecForm.RecommendTableREC_EQUIPMGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := DataModuleMain.TranslateCode('EQUIPMNT', Sender.AsString);
end;

procedure TManRecForm.RecommendTableTYPE_POWERGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := DataModuleMain.TranslateCode('TYPEPOWR', Sender.AsString);
end;

procedure TManRecForm.TestingTableDISCH_RATEGetText(Sender: TField;
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

procedure TManRecForm.TestingTableDRAWDOWNGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    aText := ''
  else
  begin
    if Sender.AsFloat * LengthFactor > 1000 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
    else
    if Sender.AsFloat * LengthFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end;
end;

procedure TManRecForm.TestingTableRECOVERYGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
var
  TheValue: Real;
begin
  if not Sender.IsNull then
  begin
    if UseResDD then
      TheValue := TestingTableDRAWDOWN.Value - Sender.Value
    else
      TheValue := Sender.AsFloat;
    if TheValue * LengthFactor >= 1000 then
      aText := FloatToStrF(TheValue * LengthFactor, ffFixed, 15, 1)
    else
    if TheValue * LengthFactor < 0.01 then
      aText := FloatToStrF(TheValue * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(TheValue * LengthFactor, ffFixed, 15, 2);
  end;
end;

procedure TManRecForm.WaterlevQueryBeforeOpen(DataSet: TDataSet);
var
  FilterIndex: ShortInt;
begin
  WaterlevQuery.Connection := DataModuleMain.ZConnectionDB;
  with WaterlevQuery do
  begin
    Connection := DataModuleMain.ZConnectionDB;
    SQL.Clear;
    SQL.Add('SELECT SITE_ID_NR, PIEZOM_NR, DATE_MEAS, TIME_MEAS, WATER_LEV FROM waterlev');
    SQL.Add('WHERE LEVEL_STAT = ' + QuotedStr('S') + ' AND SITE_ID_NR = ' + QuotedStr(ZTableViewReportSITE_ID_NR.Value));
  end;
  FilterIndex := TheUsedTablesList.IndexOf('waterlev');
  if FilterIndex > - 1 then
  begin
    WaterlevQuery.Filter := TheFilterList.Strings[FilterIndex];
    WaterlevQuery.Filtered := UseConstraints and (Dataset.Filter > '');
  end;
end;

procedure TManRecForm.WaterlevQueryWATER_LEVGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if not Sender.IsNull then
  begin
    if Abs((Sender.AsFloat) * LengthFactor) > 10000 then
      aText := FloatToStrF((Sender.AsFloat) * LengthFactor, ffFixed, 15, 0)
    else
      aText := FloatToStrF((Sender.AsFloat) * LengthFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TManRecForm.WaterlevTableWATER_LEVGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := FloatToStrF((Sender.AsFloat) * LengthFactor, ffFixed, 15, 2);
end;

end.

