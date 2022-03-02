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
unit siteinfo;

{$mode delphi}

interface

uses
  Classes, SysUtils, db, FileUtil, RLReport, ZDataset, Forms,
  Controls, Graphics, Dialogs, DbCtrls;

type

  { TSiteInfoReportForm }

  TSiteInfoReportForm = class(TForm)
    AquiferBand: TRLBand;
    InstdetlBand: TRLBand;
    InstdetlBand1: TRLBand;
    InstdetlRLBand: TRLBand;
    InstdetlRLBand1: TRLBand;
    InstdetlSubDetail: TRLSubDetail;
    InstdetlDataSource: TDataSource;
    InstallaBand1: TRLBand;
    InstallaDataSource: TDataSource;
    InstallaRLBand1: TRLBand;
    InstallaSubDetail1: TRLSubDetail;
    InstallaQueryCOMMENT: TStringField;
    InstallaQueryDATE_INSTL: TStringField;
    InstallaQueryDEPTH_INTK: TFloatField;
    InstallaQueryINFO_SOURC: TStringField;
    InstallaQueryMANUFACTUR: TStringField;
    InstallaQueryMONIT_FACI: TStringField;
    InstallaQueryPOWER_METR: TStringField;
    InstallaQueryPOWER_RATG: TFloatField;
    InstallaQueryREP_INST: TStringField;
    InstallaQueryRESER_TYPE: TStringField;
    InstallaQuerySERIAL_NR: TStringField;
    InstallaQuerySITE_ID_NR: TStringField;
    InstallaQuerySIZE_RESER: TFloatField;
    InstallaQueryTYPE_INSTL: TStringField;
    InstallaQueryTYPE_POWER: TStringField;
    InstallaBand: TRLBand;
    InstallaSubDetail: TRLSubDetail;
    InstdetlSubDetail1: TRLSubDetail;
    InstdetlQueryCLAS_RISER: TStringField;
    InstdetlQueryCOMMENT: TStringField;
    InstdetlQueryCOST_EQUIP: TFloatField;
    InstdetlQueryDATE_INSTL: TStringField;
    InstdetlQueryDIAM_RISER: TFloatField;
    InstdetlQueryE_MANUF: TStringField;
    InstdetlQueryE_MODEL: TStringField;
    InstdetlQueryE_PUL_DIAM: TFloatField;
    InstdetlQueryE_SERIALNR: TStringField;
    InstdetlQueryMAT_ENCL: TStringField;
    InstdetlQueryP_PUL_DIAM: TFloatField;
    InstdetlQueryP_RPM: TFloatField;
    InstdetlQuerySITE_ID_NR: TStringField;
    InstdetlQueryTYPE_ENCL: TStringField;
    InstdetlQueryTYPE_RISER: TStringField;
    PumptestQueryDATE_END: TStringField;
    PumptestQueryDATE_START: TStringField;
    PumptestQueryDEPTH_INTK: TFloatField;
    PumptestQueryMETH_TESTD: TStringField;
    PumptestQueryREP_INST: TStringField;
    PumptestQuerySITE_ID_NR: TStringField;
    PumptestQuerySTORATIV_0: TFloatField;
    PumptestQueryTIME_END: TStringField;
    PumptestQueryTIME_START: TStringField;
    PumptestQueryTRANSMIS_0: TFloatField;
    InstallaRLBand: TRLBand;
    RLDBMemo1: TRLDBMemo;
    RLDBMemo2: TRLDBMemo;
    RLDBMemo3: TRLDBMemo;
    RLDBMemo4: TRLDBMemo;
    RLDBText147: TRLDBText;
    RLDBText148: TRLDBText;
    RLDBText149: TRLDBText;
    RLDBText150: TRLDBText;
    RLDBText151: TRLDBText;
    RLDBText152: TRLDBText;
    RLDBText153: TRLDBText;
    RLDBText154: TRLDBText;
    RLDBText155: TRLDBText;
    RLDBText156: TRLDBText;
    RLDBText157: TRLDBText;
    RLDBText158: TRLDBText;
    RLDBText159: TRLDBText;
    RLDBText160: TRLDBText;
    RLDBText161: TRLDBText;
    RLDBText162: TRLDBText;
    RLDBText163: TRLDBText;
    RLDBText164: TRLDBText;
    RLDBText165: TRLDBText;
    RLDBText166: TRLDBText;
    RLDBText167: TRLDBText;
    RLDBText168: TRLDBText;
    RLDBText169: TRLDBText;
    RLDBText170: TRLDBText;
    RLDBText171: TRLDBText;
    RLDBText172: TRLDBText;
    RLDBText173: TRLDBText;
    RLDBText174: TRLDBText;
    RLLabel212: TRLLabel;
    RLLabel213: TRLLabel;
    RLLabel214: TRLLabel;
    RLLabel215: TRLLabel;
    RLLabel216: TRLLabel;
    RLLabel217: TRLLabel;
    RLLabel218: TRLLabel;
    RLLabel219: TRLLabel;
    RLLabel220: TRLLabel;
    RLLabel221: TRLLabel;
    RLLabel222: TRLLabel;
    RLLabel223: TRLLabel;
    RLLabel224: TRLLabel;
    RLLabel225: TRLLabel;
    RLLabel226: TRLLabel;
    RLLabel227: TRLLabel;
    RLLabel228: TRLLabel;
    RLLabel229: TRLLabel;
    RLLabel230: TRLLabel;
    RLLabel231: TRLLabel;
    RLLabel232: TRLLabel;
    RLLabel233: TRLLabel;
    RLLabel234: TRLLabel;
    RLLabel235: TRLLabel;
    RLLabel236: TRLLabel;
    RLLabel237: TRLLabel;
    RLLabel238: TRLLabel;
    RLLabel239: TRLLabel;
    RLLabel240: TRLLabel;
    RLLabel241: TRLLabel;
    RLLabel242: TRLLabel;
    RLLabel243: TRLLabel;
    RLLabel244: TRLLabel;
    RLLabel245: TRLLabel;
    RLLabel246: TRLLabel;
    RLLabel247: TRLLabel;
    RLSystemInfoReportTitle: TRLSystemInfo;
    WaterlevDataSource: TDataSource;
    DischargeBand: TRLBand;
    AquiferDataSource: TDataSource;
    AquiferSubDetail: TRLSubDetail;
    WaterlevBand: TRLBand;
    DischargeDataSource: TDataSource;
    WaterlevRLBand: TRLBand;
    DischargeSubDetail: TRLSubDetail;
    AquiferQuery: TZReadOnlyQuery;
    AquiferQueryAQUI_TYPE: TStringField;
    AquiferQueryCOMMENT: TStringField;
    AquiferQueryDEPTH_BOT: TFloatField;
    AquiferQueryDEPTH_TOP: TFloatField;
    AquiferQueryINFO_SOURC: TStringField;
    AquiferQueryMETH_MEAS: TStringField;
    AquiferQueryREP_INST: TStringField;
    AquiferQuerySITE_ID_NR: TStringField;
    AquiferQueryYIELD: TFloatField;
    BasicinfDataSource: TDataSource;
    BasicinfQuery: TZReadOnlyQuery;
    BasicinfQueryALTITUDE: TFloatField;
    BasicinfQueryALT_NO_1: TStringField;
    BasicinfQueryALT_NO_2: TStringField;
    BasicinfQueryBH_DIAM: TFloatField;
    BasicinfQueryCOLLAR_HI: TFloatField;
    BasicinfQueryCOORD_ACC: TStringField;
    BasicinfQueryCOORD_METH: TStringField;
    BasicinfQueryDATE_COMPL: TStringField;
    BasicinfQueryDEPTH: TFloatField;
    BasicinfQueryDRAINAGE_R: TStringField;
    BasicinfQueryEQUIPMENT: TStringField;
    BasicinfQueryFARM_NR: TStringField;
    BasicinfQueryNR_ON_MAP: TStringField;
    BasicinfQueryREGION_BB: TStringField;
    BasicinfQueryREGN_DESCR: TStringField;
    BasicinfQueryREGN_TYPE: TStringField;
    BasicinfQueryREP_INST: TStringField;
    BasicinfQuerySITE_ID_NR: TStringField;
    BasicinfQuerySITE_NAME: TStringField;
    BasicinfQuerySITE_PURPS: TStringField;
    BasicinfQuerySITE_STATU: TStringField;
    BasicinfQuerySITE_TYPE: TStringField;
    BasicinfQuerySURV_METH: TStringField;
    BasicinfQueryTOPO_SETTG: TStringField;
    BasicinfQueryUSE_APPLIC: TStringField;
    BasicinfQueryUSE_CONSUM: TStringField;
    BasicinfQueryX_COORD: TFloatField;
    BasicinfQueryY_COORD: TFloatField;
    WaterlevSubDetail: TRLSubDetail;
    DischargeQueryCOMMENT: TStringField;
    DischargeQueryDATE_MEAS: TStringField;
    DischargeQueryDISCH_RATE: TFloatField;
    DischargeQueryDISCH_TYPE: TStringField;
    DischargeQueryINFO_SOURC: TStringField;
    DischargeQueryMETH_MEAS: TStringField;
    DischargeQueryREP_INST: TStringField;
    DischargeQuerySITE_ID_NR: TStringField;
    DischargeQueryTIME_MEAS: TStringField;
    HoleFillDataSource: TDataSource;
    HoleFillBand: TRLBand;
    HoleFillRLBand: TRLBand;
    HoleFillSubDetail: TRLSubDetail;
    HoleFillQueryCOMMENT: TStringField;
    HoleFillQueryDATE_CONST: TStringField;
    HoleFillQueryDEPTH_BOT: TFloatField;
    HoleFillQueryDEPTH_TOP: TFloatField;
    HoleFillQueryFILL_TYPE: TStringField;
    HoleFillQueryINDIAM: TFloatField;
    HoleFillQueryOUTDIAM: TFloatField;
    HoleFillQuerySITE_ID_NR: TStringField;
    PiezomBand: TRLBand;
    PiezomRLBand: TRLBand;
    PiezomSubDetail: TRLSubDetail;
    PiezomDataSource: TDataSource;
    HoleBand: TRLBand;
    CasingBand: TRLBand;
    CasingDataSource: TDataSource;
    HoleSubDetail: TRLSubDetail;
    CasingSubDetail: TRLSubDetail;
    CasingQuery: TZReadOnlyQuery;
    CasingQueryDATE_INST: TStringField;
    CasingQueryDEPTH_BOT: TFloatField;
    CasingQueryDEPTH_TOP: TFloatField;
    CasingQueryDIAMETER: TFloatField;
    CasingQueryMATERIAL: TStringField;
    CasingQueryOPEN_LEN: TFloatField;
    CasingQueryOPEN_TYPE: TStringField;
    CasingQueryOPEN_WIDTH: TFloatField;
    CasingQueryOP_HOR_DIS: TFloatField;
    CasingQueryOP_VER_DIS: TFloatField;
    CasingQuerySITE_ID_NR: TStringField;
    CasingQueryTHICKNESS: TFloatField;
    CommentMemo: TRLMemo;
    CoordLabel: TRLLabel;
    HoleDataSource: TDataSource;
    HoleQueryCOMMENT: TStringField;
    HoleQueryDATE_CONST: TStringField;
    HoleQueryDEPTH_BOT: TFloatField;
    HoleQueryDEPTH_TOP: TFloatField;
    HoleQueryDIAMETER: TFloatField;
    HoleQueryREP_INST: TStringField;
    HoleQuerySITE_ID_NR: TStringField;
    PiezomQueryDATE_CONST: TStringField;
    PiezomQueryDEPTH_BOT: TFloatField;
    PiezomQueryDEPTH_TOP: TFloatField;
    PiezomQueryDIAMETER: TFloatField;
    PiezomQueryMATERIAL: TStringField;
    PiezomQueryOPEN_LEN: TFloatField;
    PiezomQueryOPEN_TYPE: TStringField;
    PiezomQueryOPEN_WIDTH: TFloatField;
    PiezomQueryOP_HOR_DIS: TFloatField;
    PiezomQueryOP_VER_DIS: TFloatField;
    PiezomQueryPIEZO_NR: TLongintField;
    PiezomQuerySITE_ID_NR: TStringField;
    PiezomQueryTHICKNESS: TFloatField;
    PTestDataSource: TDataSource;
    DataSourceView: TDataSource;
    FooterBand: TRLBand;
    NotesRLDBMemo: TRLDBMemo;
    PumpTestBand: TRLBand;
    CasingRLBand: TRLBand;
    DischargeRLBand: TRLBand;
    RLDBText107: TRLDBText;
    RLDBText108: TRLDBText;
    RLDBText109: TRLDBText;
    RLDBText110: TRLDBText;
    RLDBText111: TRLDBText;
    RLDBText112: TRLDBText;
    RLDBText113: TRLDBText;
    RLDBText114: TRLDBText;
    RLDBText115: TRLDBText;
    RLDBText116: TRLDBText;
    RLDBText117: TRLDBText;
    RLDBText118: TRLDBText;
    RLDBText119: TRLDBText;
    RLDBText120: TRLDBText;
    RLDBText121: TRLDBText;
    RLDBText122: TRLDBText;
    RLDBText123: TRLDBText;
    RLDBText124: TRLDBText;
    RLDBText125: TRLDBText;
    RLDBText126: TRLDBText;
    RLDBText127: TRLDBText;
    RLDBText128: TRLDBText;
    RLDBText129: TRLDBText;
    RLDBText130: TRLDBText;
    RLDBText131: TRLDBText;
    RLDBText132: TRLDBText;
    RLDBText133: TRLDBText;
    RLDBText134: TRLDBText;
    RLDBText135: TRLDBText;
    RLDBText136: TRLDBText;
    RLDBText138: TRLDBText;
    RLDBText139: TRLDBText;
    RLDBText140: TRLDBText;
    RLDBText141: TRLDBText;
    RLDBText142: TRLDBText;
    RLDBText143: TRLDBText;
    RLDBText144: TRLDBText;
    RLDBText145: TRLDBText;
    RLDBText146: TRLDBText;
    RLDBText15: TRLDBText;
    RLDBText18: TRLDBText;
    RLDBText19: TRLDBText;
    RLDBText20: TRLDBText;
    RLDBText21: TRLDBText;
    RLDBText22: TRLDBText;
    RLDBText23: TRLDBText;
    RLDBText24: TRLDBText;
    RLDBText25: TRLDBText;
    RLDBText26: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText66: TRLDBText;
    RLDBText68: TRLDBText;
    RLDBText69: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText70: TRLDBText;
    RLDBText71: TRLDBText;
    RLDBText80: TRLDBText;
    RLDBText83: TRLDBText;
    RLDBText97: TRLDBText;
    RLDraw1: TRLDraw;
    RLDraw2: TRLDraw;
    RLDraw3: TRLDraw;
    RLDraw4: TRLDraw;
    RLLabel107: TRLLabel;
    RLLabel109: TRLLabel;
    RLLabel110: TRLLabel;
    RLLabel111: TRLLabel;
    RLLabel116: TRLLabel;
    RLLabel149: TRLLabel;
    RLLabel150: TRLLabel;
    RLLabel151: TRLLabel;
    RLLabel152: TRLLabel;
    RLLabel153: TRLLabel;
    RLLabel154: TRLLabel;
    RLLabel155: TRLLabel;
    RLLabel156: TRLLabel;
    RLLabel157: TRLLabel;
    RLLabel158: TRLLabel;
    RLLabel159: TRLLabel;
    RLLabel160: TRLLabel;
    RLLabel161: TRLLabel;
    RLLabel162: TRLLabel;
    RLLabel163: TRLLabel;
    RLLabel164: TRLLabel;
    RLLabel165: TRLLabel;
    RLLabel166: TRLLabel;
    RLLabel167: TRLLabel;
    RLLabel168: TRLLabel;
    RLLabel169: TRLLabel;
    RLLabel17: TRLLabel;
    RLLabel170: TRLLabel;
    RLLabel171: TRLLabel;
    RLLabel172: TRLLabel;
    RLLabel173: TRLLabel;
    RLLabel174: TRLLabel;
    RLLabel175: TRLLabel;
    RLLabel176: TRLLabel;
    RLLabel177: TRLLabel;
    RLLabel178: TRLLabel;
    RLLabel179: TRLLabel;
    RLLabel180: TRLLabel;
    RLLabel181: TRLLabel;
    RLLabel182: TRLLabel;
    RLLabel183: TRLLabel;
    RLLabel184: TRLLabel;
    RLLabel185: TRLLabel;
    RLLabel186: TRLLabel;
    RLLabel187: TRLLabel;
    RLLabel188: TRLLabel;
    RLLabel189: TRLLabel;
    RLLabel190: TRLLabel;
    RLLabel191: TRLLabel;
    RLLabel192: TRLLabel;
    RLLabel193: TRLLabel;
    RLLabel194: TRLLabel;
    RLLabel195: TRLLabel;
    RLLabel196: TRLLabel;
    RLLabel197: TRLLabel;
    RLLabel198: TRLLabel;
    RLLabel199: TRLLabel;
    RLLabel200: TRLLabel;
    RLLabel201: TRLLabel;
    RLLabel202: TRLLabel;
    RLLabel204: TRLLabel;
    RLLabel205: TRLLabel;
    RLLabel206: TRLLabel;
    RLLabel207: TRLLabel;
    RLLabel208: TRLLabel;
    RLLabel209: TRLLabel;
    RLLabel210: TRLLabel;
    RLLabel22: TRLLabel;
    RLLabel23: TRLLabel;
    RLLabel24: TRLLabel;
    RLLabel25: TRLLabel;
    RLLabel26: TRLLabel;
    RLLabel27: TRLLabel;
    RLLabel28: TRLLabel;
    RLLabel29: TRLLabel;
    RLLabel30: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel83: TRLLabel;
    RLLabel85: TRLLabel;
    RLLabel86: TRLLabel;
    RLLabel87: TRLLabel;
    RLLabel88: TRLLabel;
    RLLabel89: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel90: TRLLabel;
    RLLabel91: TRLLabel;
    RLLabel92: TRLLabel;
    SiteInfoReport: TRLReport;
    PumpTestSubDetail: TRLSubDetail;
    RecommendBand: TRLBand;
    RecommendDataSource: TDataSource;
    RecommendSubDetail: TRLSubDetail;
    RecommendQuery: TZReadOnlyQuery;
    RecommendQueryCRIT_WLEV: TFloatField;
    RecommendQueryDEPTH_INTK: TFloatField;
    RecommendQueryDISCH_RATE: TFloatField;
    RecommendQueryDUTY_CYCLE: TFloatField;
    RecommendQueryDYN_WLEV: TFloatField;
    RecommendQueryNOTE_PAD: TBlobField;
    RecommendQueryPRIORITY: TLongintField;
    RecommendQueryREC_EQUIPM: TStringField;
    RecommendQuerySITE_ID_NR: TStringField;
    RecommendQueryTYPE_POWER: TStringField;
    RecommendQueryWATER_QUAL: TStringField;
    RLBand1: TRLBand;
    RLBand4: TRLBand;
    RLBand5: TRLBand;
    RLBand6: TRLBand;
    HoleRLBand: TRLBand;
    RLBand8: TRLBand;
    RLBandHeader: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText100: TRLDBText;
    RLDBText101: TRLDBText;
    RLDBText102: TRLDBText;
    RLDBText103: TRLDBText;
    RLDBText104: TRLDBText;
    RLDBText105: TRLDBText;
    RLDBText106: TRLDBText;
    RLDBText11: TRLDBText;
    RLDBText12: TRLDBText;
    RLDBText13: TRLDBText;
    RLDBText14: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
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
    RLDBText67: TRLDBText;
    RLDBText73: TRLDBText;
    RLDBText74: TRLDBText;
    RLDBText75: TRLDBText;
    RLDBText76: TRLDBText;
    RLDBText77: TRLDBText;
    RLDBText78: TRLDBText;
    RLDBText79: TRLDBText;
    RLDBText8: TRLDBText;
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
    RLLabel139: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel140: TRLLabel;
    RLLabel141: TRLLabel;
    RLLabel142: TRLLabel;
    RLLabel143: TRLLabel;
    RLLabel144: TRLLabel;
    RLLabel145: TRLLabel;
    RLLabel146: TRLLabel;
    RLLabel147: TRLLabel;
    RLLabel148: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel66: TRLLabel;
    RLLabel7: TRLLabel;
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
    RLLabel84: TRLLabel;
    RLLabel93: TRLLabel;
    RLLabel94: TRLLabel;
    RLLabel95: TRLLabel;
    RLLabel96: TRLLabel;
    RLLabel97: TRLLabel;
    RLLabel98: TRLLabel;
    RLLabel99: TRLLabel;
    RLMemoUserDetails: TRLMemo;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    TestingBand: TRLBand;
    TestingDataSource: TDataSource;
    TestingSubDetail: TRLSubDetail;
    TestingQuery: TZReadOnlyQuery;
    TestingQueryDATE_START: TStringField;
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
    WaterlevQueryCOMMENT: TStringField;
    WaterlevQueryDATE_MEAS: TStringField;
    WaterlevQueryINFO_SOURC: TStringField;
    WaterlevQueryLEVEL_STAT: TStringField;
    WaterlevQueryMETH_MEAS: TStringField;
    WaterlevQueryPIEZOM_NR: TStringField;
    WaterlevQuerySITE_ID_NR: TStringField;
    WaterlevQueryTIME_MEAS: TStringField;
    WaterlevQueryTIME_SEC: TFloatField;
    WaterlevQueryWATER_LEV: TFloatField;
    X_CoordLabel: TRLLabel;
    Y_CoordLabel: TRLLabel;
    PumptestQuery: TZReadOnlyQuery;
    HoleQuery: TZReadOnlyQuery;
    PiezomQuery: TZReadOnlyQuery;
    HoleFillQuery: TZReadOnlyQuery;
    DischargeQuery: TZReadOnlyQuery;
    WaterlevQuery: TZReadOnlyQuery;
    InstallaQuery: TZReadOnlyQuery;
    InstdetlQuery: TZReadOnlyQuery;
    ViewQuery: TZReadOnlyQuery;
    procedure AquiferQueryBeforeOpen(DataSet: TDataSet);
    procedure AquiferQueryDEPTH_BOTGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure AquiferQueryDEPTH_TOPGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure AquiferQueryYIELDGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfDataSourceDataChange(Sender: TObject; Field: TField);
    procedure BasicinfQueryALTITUDEGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryBeforeOpen(DataSet: TDataSet);
    procedure BasicinfQueryBH_DIAMGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryCOLLAR_HIGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryDEPTHGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQuerySITE_ID_NRGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure CasingQueryBeforeOpen(DataSet: TDataSet);
    procedure DataSourceViewDataChange(Sender: TObject; Field: TField);
    procedure DischargeQueryBeforeOpen(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure HoleFillQueryBeforeOpen(DataSet: TDataSet);
    procedure HoleQueryBeforeOpen(DataSet: TDataSet);
    procedure InstallaQueryBeforeOpen(DataSet: TDataSet);
    procedure InstdetlQueryBeforeOpen(DataSet: TDataSet);
    procedure LookupsGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryX_COORDGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryY_COORDGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure CasingQueryDEPTH_BOTGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure CasingQueryDEPTH_TOPGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure CasingQueryDIAMETERGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure CasingTableOPENGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure CasingQueryTHICKNESSGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure DischargeQueryDISCH_RATEGetText(Sender: TField;
      var aText: string; DisplayText: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure HoleFillQueryDEPTH_BOTGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure HoleFillQueryDEPTH_TOPGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure HoleFillQueryINDIAMGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure HoleFillQueryOUTDIAMGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure HoleTableDEPTH_BOTGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure HoleQueryDEPTH_TOPGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure HoleQueryDIAMETERGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure InstallaQueryDEPTH_INTKGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure InstdetlQueryDIAM_RISERGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure InstdetlQueryE_PUL_DIAMGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure InstdetlQueryP_PUL_DIAMGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure PiezomQueryBeforeOpen(DataSet: TDataSet);
    procedure PiezomQueryDEPTH_BOTGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure PiezomQueryDEPTH_TOPGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure PiezomQueryDIAMETERGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure PiezomQueryOPEN_LENGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure PiezomQueryOPEN_WIDTHGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure PiezomQueryOP_HOR_DISGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure PiezomQueryOP_VER_DISGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure PiezomQueryTHICKNESSGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure PumptestQueryBeforeOpen(DataSet: TDataSet);
    procedure PumptestQueryDEPTH_INTKGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure RecommendQueryBeforeOpen(DataSet: TDataSet);
    procedure RecommendQueryDEPTH_INTKGetText(Sender: TField;
      var aText: string; DisplayText: Boolean);
    procedure RecommendQueryDISCH_RATEGetText(Sender: TField;
      var aText: string; DisplayText: Boolean);
    procedure SiteInfoReportBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure TestingQueryBeforeOpen(DataSet: TDataSet);
    procedure TestingQueryDEPTH_INTKGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure TestingQueryDISCH_RATEGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure TestingQueryDRAWDOWNGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure TestingQueryPERMEABILGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure TestingQueryRECOVERYGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure TestingQueryTRANSMISSGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure WaterlevQueryBeforeOpen(DataSet: TDataSet);
    procedure WaterlevQueryWATER_LEVGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure ViewQueryBeforeOpen(DataSet: TDataSet);
  private
    { private declarations }
    XCoord, YCoord: ShortString;
    PrevRepInst, PrevInfoSrc, PrevType, PrevMethMeas, PrevLvlStat: ShortString;
    PrevParmMeas, PrevMethSamp, PrevSampType: ShortString;
    RepInstDescr, InfoSrcDescr, TypeDescr, MethMeasDescr, LvlStatDescr: ShortString;
    ParmMeasDescr, MethSampDescr, SampTypeDescr: ShortString;
  public
    { public declarations }
    TheUsedTablesList, TheFilterList: TStringList;
    UseConstr, UseCurrentSite, ShowConstr, ShowAquifer, ShowDischarge: Boolean;
    ShowWL, ShowTesting, ShowInstall, ShowSiteMan: Boolean;
    ViewName: String;
  end;

var
  SiteInfoReportForm: TSiteInfoReportForm;

implementation

{$R *.lfm}

uses MainDataModule, Varinit;

{ TSiteInfoReportForm }

procedure TSiteInfoReportForm.TestingQueryBeforeOpen(DataSet: TDataSet);
begin
  TestingQuery.Connection := DataModuleMain.ZConnectionDB;
  TestingQuery.SQL.Clear;
  TestingQuery.SQL.Add('SELECT * FROM testdetl WHERE SITE_ID_NR = ' + QuotedStr(ViewQuery.Fields[0].AsString));
end;

procedure TSiteInfoReportForm.FormCreate(Sender: TObject);
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
  CoordLabel.Font.Size := ReportFont.Size - 1;
  TheUsedTablesList := TStringList.Create;
  TheFilterList := TStringList.Create
end;

procedure TSiteInfoReportForm.HoleFillQueryDEPTH_BOTGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
    aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
end;

procedure TSiteInfoReportForm.HoleFillQueryDEPTH_TOPGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
    aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
end;

procedure TSiteInfoReportForm.HoleFillQueryINDIAMGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TSiteInfoReportForm.HoleFillQueryOUTDIAMGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TSiteInfoReportForm.HoleTableDEPTH_BOTGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
    aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
end;

procedure TSiteInfoReportForm.HoleQueryDEPTH_TOPGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
    aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
end;

procedure TSiteInfoReportForm.HoleQueryDIAMETERGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TSiteInfoReportForm.InstallaQueryDEPTH_INTKGetText(Sender: TField;
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
  else DisplayText := False;
end;

procedure TSiteInfoReportForm.InstdetlQueryDIAM_RISERGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TSiteInfoReportForm.InstdetlQueryE_PUL_DIAMGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TSiteInfoReportForm.InstdetlQueryP_PUL_DIAMGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TSiteInfoReportForm.PiezomQueryBeforeOpen(DataSet: TDataSet);
begin
  PiezomQuery.Connection := DataModuleMain.ZConnectionDB;
  PiezomQuery.SQL.Clear;
  PiezomQuery.SQL.Add('SELECT * FROM piezomet WHERE SITE_ID_NR = ' + QuotedStr(ViewQuery.Fields[0].AsString));
end;

procedure TSiteInfoReportForm.PiezomQueryDEPTH_BOTGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
    aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
end;

procedure TSiteInfoReportForm.PiezomQueryDEPTH_TOPGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
    aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
end;

procedure TSiteInfoReportForm.PiezomQueryDIAMETERGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TSiteInfoReportForm.PiezomQueryOPEN_LENGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TSiteInfoReportForm.PiezomQueryOPEN_WIDTHGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TSiteInfoReportForm.PiezomQueryOP_HOR_DISGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TSiteInfoReportForm.PiezomQueryOP_VER_DISGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TSiteInfoReportForm.PiezomQueryTHICKNESSGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TSiteInfoReportForm.PumptestQueryBeforeOpen(DataSet: TDataSet);
begin
  PumptestQuery.Connection := DataModuleMain.ZConnectionDB;
  PumptestQuery.SQL.Clear;
  PumptestQuery.SQL.Add('SELECT * FROM pumptest WHERE SITE_ID_NR = ' + QuotedStr(ViewQuery.Fields[0].AsString));
end;

procedure TSiteInfoReportForm.PumptestQueryDEPTH_INTKGetText(Sender: TField;
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
  else DisplayText := False;
end;

procedure TSiteInfoReportForm.RecommendQueryBeforeOpen(DataSet: TDataSet);
begin
  RecommendQuery.Connection := DataModuleMain.ZConnectionDB;
  RecommendQuery.SQL.Clear;
  RecommendQuery.SQL.Add('SELECT * FROM recommnd WHERE SITE_ID_NR = ' + QuotedStr(ViewQuery.Fields[0].AsString));
end;

procedure TSiteInfoReportForm.RecommendQueryDEPTH_INTKGetText(Sender: TField;
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
  else DisplayText := False;
end;

procedure TSiteInfoReportForm.RecommendQueryDISCH_RATEGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.AsFloat * VolumeFactor * TimeFactor > 100000 then
    aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 0)
  else
  if Sender.AsFloat * VolumeFactor * TimeFactor < 0.01 then
    aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 5)
  else
  if Sender.AsFloat * VolumeFactor * TimeFactor = 0 then DisplayText := False
  else
    aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 3);
end;

procedure TSiteInfoReportForm.SiteInfoReportBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  with SiteInfoReport do
  begin
    Margins.LeftMargin := LeftMargin;
    Margins.TopMargin := TopMargin;
    Margins.BottomMargin := BotMargin;
    Margins.RightMargin := 10 - LeftMargin + 10;
  end;
  RLBandHeader.Color := ReportHeaderBandColor;
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
  {Set Units in labels}
  RLLabel10.Caption := RLLabel10.Caption + ' [' + LengthUnit + ']:';
  RLLabel14.Caption := RLLabel14.Caption + ' [' + DiamUnit + ']:';
  RLLabel15.Caption := RLLabel15.Caption + ' [' + LengthUnit + ']:';
  RLLabel16.Caption := RLLabel16.Caption + ' [' + LengthUnit + ']:';
  RLLabel71.Caption := RLLabel71.Caption + ' [' + LengthUnit + ']';
  RLLabel72.Caption := RLLabel72.Caption + ' [' + LengthUnit + ']';
  RLLabel73.Caption := RLLabel73.Caption + ' [' + LengthUnit + ']';
  RLLabel79.Caption := RLLabel79.Caption + ' [' + LengthUnit + ']';
  RLLabel80.Caption := RLLabel80.Caption + ' [' + LengthUnit + ']';
  RLLabel85.Caption := RLLabel85.Caption + ' [' + LengthUnit + ']';
  RLLabel86.Caption := RLLabel86.Caption + ' [' + LengthUnit + ']';
  RLLabel93.Caption := '[' + DiamUnit + ']';
  RLLabel108.Caption := RLLabel108.Caption + ' [' + LengthUnit + ']';
  RLLabel118.Caption := '[' + LengthUnit + ']';
  RLLabel120.Caption := RLLabel120.Caption + ' [' + DisUnit + ']';
  RLLabel121.Caption := '[' + LengthUnit + '²/d]';
  RLLabel123.Caption := RLLabel123.Caption + ' [' + LengthUnit + ']';
  RLLabel126.Caption := '[' + LengthUnit + ']';
  RLLabel131.Caption := '[' + LengthUnit + '/d]';
  RLLabel139.Caption := RLLabel139.Caption + ' [' + DisUnit + ']';
  RLLabel140.Caption := RLLabel140.Caption+ ' [' + LengthUnit + ']';
  RLLabel141.Caption := RLLabel141.Caption + ' [' + LengthUnit + ']';
  RLLabel144.Caption := RLLabel144.Caption + ' [' + LengthUnit + ']';
  RLLabel149.Caption := '[' + DisUnit + ']';
  RLLabel152.Caption := RLLabel152.Caption + ' [' + LengthUnit + ']';
  RLLabel153.Caption := RLLabel153.Caption + ' [' + LengthUnit + ']';
  RLLabel158.Caption := RLLabel158.Caption + ' [' + DiamUnit + ']:';
  RLLabel166.Caption := '[' + DiamUnit + ']';
  RLLabel176.Caption := RLLabel176.Caption + ' [' + DiamUnit + ']:';
  RLLabel183.Caption := '[' + DiamUnit + ']';
  RLLabel184.Caption := '[' + DiamUnit + ']';
  RLLabel188.Caption := '[' + DiamUnit + ']';
  RLLabel191.Caption := '[' + DiamUnit + ']';
  RLLabel200.Caption := '[' + DisUnit + ']';
  RLLabel210.Caption := '[' + LengthUnit + ']';
  RLLabel219.Caption := RLLabel219.Caption + ' [' + LengthUnit + ']';
  RLLabel238.Caption := RLLabel238.Caption + ' [' + DiamUnit + ']:';
  RLLabel240.Caption := RLLabel240.Caption + ' [' + DiamUnit + ']:';
  RLLabel247.Caption := RLLabel247.Caption + ' [' + DiamUnit + ']:';
  CoordLabel.Caption := CoordLabel.Caption + CoordSysDescr;
  if FileExists(WSpaceDir + DirectorySeparator + 'Userinfo.txt') then
    RLMemoUserDetails.Lines.LoadFromFile(WSpaceDir + DirectorySeparator + 'Userinfo.txt');
  if FileExists(WSpaceDir + DirectorySeparator + 'userlogo.jpg') then
    RLImageLogo.Picture.LoadFromFile(WSpaceDir + DirectorySeparator + 'userlogo.jpg')
  else
  if FileExists(WSpaceDir + DirectorySeparator + 'userlogo.bmp') then
    RLImageLogo.Picture.LoadFromFile(WSpaceDir + DirectorySeparator + 'userlogo.bmp');
  Application.ProcessMessages;
  //Open tables
  ViewQuery.Open;
end;

procedure TSiteInfoReportForm.BasicinfQueryX_COORDGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := XCoord;
end;

procedure TSiteInfoReportForm.BasicinfQueryBH_DIAMGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TSiteInfoReportForm.BasicinfQueryALTITUDEGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value = NULL then DisplayText := False
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

procedure TSiteInfoReportForm.BasicinfQueryBeforeOpen(DataSet: TDataSet);
begin
  BasicinfQuery.Connection := DataModuleMain.ZConnectionDB;
  BasicinfQuery.SQL.Clear;
  BasicinfQuery.SQL.Add('SELECT * FROM basicinf WHERE SITE_ID_NR = ' + QuotedStr(ViewQuery.Fields[0].AsString));
end;

procedure TSiteInfoReportForm.AquiferQueryDEPTH_TOPGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
    aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
end;

procedure TSiteInfoReportForm.AquiferQueryYIELDGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
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

procedure TSiteInfoReportForm.BasicinfDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  if Field = NIL then
  begin
    HoleQuery.Close;
    HoleQuery.Active := ShowConstr;
    CasingQuery.Close;
    CasingQuery.Active := ShowConstr;
    PiezomQuery.Close;
    PiezomQuery.Active := ShowConstr;
    HoleFillQuery.Close;
    HoleFillQuery.Active := ShowConstr;
    AquiferQuery.Close;
    AquiferQuery.Active := ShowAquifer;
    DischargeQuery.Close;
    DischargeQuery.Active := ShowDischarge;
    WaterlevQuery.Close;
    WaterlevQuery.Active := ShowWL;
    InstallaQuery.Close;
    InstallaQuery.Active := ShowInstall;
    InstdetlQuery.Close;
    InstdetlQuery.Active := ShowInstall;
    PumptestQuery.Close;
    PumptestQuery.Active := ShowTesting;
    TestingQuery.Close;
    TestingQuery.Active := ShowTesting;
    RecommendQuery.Close;
    RecommendQuery.Active := ShowTesting;
  end;
end;

procedure TSiteInfoReportForm.AquiferQueryDEPTH_BOTGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
    aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
end;

procedure TSiteInfoReportForm.AquiferQueryBeforeOpen(DataSet: TDataSet);
begin
  AquiferQuery.Connection := DataModuleMain.ZConnectionDB;
  AquiferQuery.SQL.Clear;
  AquiferQuery.SQL.Add('SELECT * FROM aquifer_ WHERE SITE_ID_NR = ' + QuotedStr(ViewQuery.Fields[0].AsString));
end;

procedure TSiteInfoReportForm.BasicinfQueryCOLLAR_HIGetText(Sender: TField;
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

procedure TSiteInfoReportForm.BasicinfQueryDEPTHGetText(Sender: TField;
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
  else DisplayText := False;
end;

procedure TSiteInfoReportForm.BasicinfQuerySITE_ID_NRGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := Sender.Value;
  with DataModuleMain do
    cs2cs(BasicinfQueryX_COORD.AsString, BasicinfQueryY_COORD.AsString, GetMapRef(BasicinfQuerySITE_ID_NR.AsString), OrigCoordSysNr, CoordSysNr, XCoord, YCoord);
end;

procedure TSiteInfoReportForm.CasingQueryBeforeOpen(DataSet: TDataSet);
begin
  CasingQuery.Connection := DataModuleMain.ZConnectionDB;
  CasingQuery.SQL.Clear;
  CasingQuery.SQL.Add('SELECT * FROM casing__ WHERE SITE_ID_NR = ' + QuotedStr(ViewQuery.Fields[0].AsString));
end;

procedure TSiteInfoReportForm.DataSourceViewDataChange(Sender: TObject;
  Field: TField);
begin
  if Field = NIL then
  begin
    BasicinfQuery.Close;
    BasicinfQuery.Open;
  end;
end;

procedure TSiteInfoReportForm.DischargeQueryBeforeOpen(DataSet: TDataSet);
begin
  DischargeQuery.Connection := DataModuleMain.ZConnectionDB;
  DischargeQuery.SQL.Clear;
  DischargeQuery.SQL.Add('SELECT * FROM discharg WHERE SITE_ID_NR = ' + QuotedStr(ViewQuery.Fields[0].AsString));
end;

procedure TSiteInfoReportForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TSiteInfoReportForm.HoleFillQueryBeforeOpen(DataSet: TDataSet);
begin
  HoleFillQuery.Connection := DataModuleMain.ZConnectionDB;
  HoleFillQuery.SQL.Clear;
  HoleFillQuery.SQL.Add('SELECT * FROM holefill WHERE SITE_ID_NR = ' + QuotedStr(ViewQuery.Fields[0].AsString));
end;

procedure TSiteInfoReportForm.HoleQueryBeforeOpen(DataSet: TDataSet);
begin
  HoleQuery.Connection := DataModuleMain.ZConnectionDB;
  HoleQuery.SQL.Clear;
  HoleQuery.SQL.Add('SELECT * FROM holediam WHERE SITE_ID_NR = ' + QuotedStr(ViewQuery.Fields[0].AsString));
end;

procedure TSiteInfoReportForm.InstallaQueryBeforeOpen(DataSet: TDataSet);
begin
  InstallaQuery.Connection := DataModuleMain.ZConnectionDB;
  InstallaQuery.SQL.Clear;
  InstallaQuery.SQL.Add('SELECT * FROM installa WHERE SITE_ID_NR = ' + QuotedStr(ViewQuery.Fields[0].AsString));
end;

procedure TSiteInfoReportForm.InstdetlQueryBeforeOpen(DataSet: TDataSet);
begin
  InstDetlQuery.Connection := DataModuleMain.ZConnectionDB;
  InstDetlQuery.SQL.Clear;
  InstDetlQuery.SQL.Add('SELECT * FROM instdetl WHERE SITE_ID_NR = ' + QuotedStr(ViewQuery.Fields[0].AsString));
end;

procedure TSiteInfoReportForm.LookupsGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull and (not PrintNoInfo) then DisplayText := False
  else
  case Sender.Tag of
    1: begin
         if Sender.AsString <> PrevRepInst then
         begin
           RepInstDescr := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
           aText := RepInstDescr;
         end
         else
           aText := RepInstDescr;
         PrevRepInst := Sender.AsString;
       end;
    2: begin
         if Sender.AsString <> PrevInfoSrc then
         begin
           InfoSrcDescr := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
           aText := InfoSrcDescr;
         end
         else
           aText := InfoSrcDescr;
         PrevInfoSrc := Sender.AsString;
       end;
    3: begin
         if Sender.AsString <> PrevType then
         begin
           TypeDescr := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
           aText := TypeDescr;
         end
         else
           aText := TypeDescr;
         PrevType := Sender.AsString;
       end;
    4: begin
         if Sender.AsString <> PrevMethMeas then
         begin
           MethMeasDescr := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
           aText := MethMeasDescr;
         end
         else
           aText := MethMeasDescr;
         PrevMethMeas := Sender.AsString;
       end;
    5: begin
         if Sender.AsString <> PrevLvlStat then
         begin
           LvlStatDescr := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
           aText := LvlStatDescr;
         end
         else
           aText := LvlStatDescr;
         PrevLvlStat := Sender.AsString;
       end;
    6: begin
         if Sender.AsString <> PrevParmMeas then
         begin
           ParmMeasDescr := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
           aText := ParmMeasDescr;
         end
         else
           aText := ParmMeasDescr;
         PrevParmMeas := Sender.AsString;
       end;
    7: begin
         if Sender.AsString <> PrevSampType then
         begin
           SampTypeDescr := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
           aText := SampTypeDescr;
         end
         else
           aText := SampTypeDescr;
         PrevSampType := Sender.AsString;
       end;
    8: begin
         if Sender.AsString <> PrevMethSamp then
         begin
           MethSampDescr := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
           aText := MethSampDescr;
         end
         else
           aText := MethSampDescr;
         PrevMethSamp := Sender.AsString;
       end;
    else //for all others, e.g. not repeating in columns
      aText := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
  end; //of case
end;

procedure TSiteInfoReportForm.BasicinfQueryY_COORDGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := YCoord;
end;

procedure TSiteInfoReportForm.CasingQueryDEPTH_BOTGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
    aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
end;

procedure TSiteInfoReportForm.CasingQueryDEPTH_TOPGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
    aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
end;

procedure TSiteInfoReportForm.CasingQueryDIAMETERGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TSiteInfoReportForm.CasingTableOPENGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TSiteInfoReportForm.CasingQueryTHICKNESSGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TSiteInfoReportForm.DischargeQueryDISCH_RATEGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
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

procedure TSiteInfoReportForm.TestingQueryDEPTH_INTKGetText(Sender: TField;
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
  else DisplayText := False;
end;

procedure TSiteInfoReportForm.TestingQueryDISCH_RATEGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
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

procedure TSiteInfoReportForm.TestingQueryDRAWDOWNGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
    aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
end;

procedure TSiteInfoReportForm.TestingQueryPERMEABILGetText(Sender: TField;
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
  else DisplayText := False;
end;

procedure TSiteInfoReportForm.TestingQueryRECOVERYGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
    aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
end;

procedure TSiteInfoReportForm.TestingQueryTRANSMISSGetText(Sender: TField;
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
  else DisplayText := False;
end;

procedure TSiteInfoReportForm.WaterlevQueryBeforeOpen(DataSet: TDataSet);
begin
  WaterlevQuery.Connection := DataModuleMain.ZConnectionDB;
  WaterlevQuery.SQL.Clear;
  WaterlevQuery.SQL.Add('SELECT * FROM waterlev WHERE SITE_ID_NR = ' + QuotedStr(ViewQuery.Fields[0].AsString));
end;

procedure TSiteInfoReportForm.WaterlevQueryWATER_LEVGetText(Sender: TField;
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

procedure TSiteInfoReportForm.ViewQueryBeforeOpen(DataSet: TDataSet);
begin
  with ViewQuery do
  begin
    Connection := DataModuleMain.ZConnectionDB;
    SQL.Clear;
    SQL.Add('SELECT * FROM ' + ViewName);
    if UseCurrentSite then
      SQL.Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
  end;
end;

end.

