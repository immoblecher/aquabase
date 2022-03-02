{ Copyright (C) 2022 Immo Blecher immo@blecher.co.za

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
unit logreport;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, RLReport, ZDataset, Forms,
  Controls, Graphics, Dialogs, DbCtrls;

type

  { TLogReportForm }

  TLogReportForm = class(TForm)
    AquiferBand: TRLBand;
    ChartRLBand2: TRLBand;
    DTHChartRLImage2: TRLImage;
    GeologyHeaderBand: TRLBand;
    AquiferDataSource: TDataSource;
    AquiferSubDetail: TRLSubDetail;
    GeologyHeaderBand1: TRLBand;
    GeologyHeaderBand2: TRLBand;
    GeologySubDetail: TRLSubDetail;
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
    CasingBand: TRLBand;
    CasingDataSource: TDataSource;
    CasingRLBand: TRLBand;
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
    ConstructionDataSource: TDataSource;
    ConstructionHeaderBand1: TRLBand;
    ConstructionRLBand1: TRLBand;
    ConstructionSubDetail1: TRLSubDetail;
    ConstructionQueryCOLLAR_HI: TFloatField;
    ConstructionQueryCOMMENT: TStringField;
    ConstructionQueryCONST_METH: TStringField;
    ConstructionQueryCONTRACTOR: TStringField;
    ConstructionQueryCOST_CONST: TFloatField;
    ConstructionQueryDATE_CONST: TStringField;
    ConstructionQueryDEPTH: TFloatField;
    ConstructionQueryDURA_DEVEL: TLongintField;
    ConstructionQueryINFO_SOURC: TStringField;
    ConstructionQueryMETH_DEVEL: TStringField;
    ConstructionQueryREP_INST: TStringField;
    ConstructionQuerySITE_ID_NR: TStringField;
    ConstructionQuerySPEC_TREAT: TStringField;
    ConstructionQueryTYPE_FINIS: TStringField;
    GeologyDataSource: TDataSource;
    DTHChartRLImage1: TRLImage;
    ConstructionHeaderBand: TRLBand;
    ConstructionSubDetail: TRLSubDetail;
    LogChartRLImage2: TRLImage;
    RepCommentMemo: TRLMemo;
    CoordLabel: TRLLabel;
    DataSourceView: TDataSource;
    FooterBand: TRLBand;
    GeologySubDetail1: TRLSubDetail;
    GeologySubDetail2: TRLSubDetail;
    GeologyQueryBOULDERS: TLongintField;
    GeologyQueryCLAY: TLongintField;
    GeologyQueryCOBBLY: TLongintField;
    GeologyQueryDEPTH_BOT: TFloatField;
    GeologyQueryDEPTH_TOP: TFloatField;
    GeologyQueryFEATR_ATTR: TStringField;
    GeologyQueryGRANULAR: TLongintField;
    GeologyQueryLITH_CODE: TStringField;
    GeologyQueryNOTE_PAD: TBlobField;
    GeologyQueryPEBBLY: TLongintField;
    GeologyQueryPRIM_COLOR: TStringField;
    GeologyQueryPRIM_FEATR: TStringField;
    GeologyQueryROUNDNESS: TStringField;
    GeologyQuerySAND_COARS: TLongintField;
    GeologyQuerySAND_FINE: TLongintField;
    GeologyQuerySAND_MEDIU: TLongintField;
    GeologyQuerySECO_COLOR: TStringField;
    GeologyQuerySECO_FEATR: TStringField;
    GeologyQuerySILT_COARS: TLongintField;
    GeologyQuerySILT_FINE: TLongintField;
    GeologyQuerySILT_MEDIU: TLongintField;
    GeologyQuerySITE_ID_NR: TStringField;
    GeologyQuerySORTING: TStringField;
    GeologyQueryTEXTURE: TStringField;
    HoleBand: TRLBand;
    HoleDataSource: TDataSource;
    HoleFillBand: TRLBand;
    HoleFillDataSource: TDataSource;
    HoleFillRLBand: TRLBand;
    HoleFillSubDetail: TRLSubDetail;
    HoleFillQuery: TZReadOnlyQuery;
    HoleFillQueryCOMMENT: TStringField;
    HoleFillQueryDATE_CONST: TStringField;
    HoleFillQueryDEPTH_BOT: TFloatField;
    HoleFillQueryDEPTH_TOP: TFloatField;
    HoleFillQueryFILL_TYPE: TStringField;
    HoleFillQueryINDIAM: TFloatField;
    HoleFillQueryOUTDIAM: TFloatField;
    HoleFillQuerySITE_ID_NR: TStringField;
    HoleRLBand: TRLBand;
    HoleSubDetail: TRLSubDetail;
    HoleQuery: TZReadOnlyQuery;
    HoleQueryCOMMENT: TStringField;
    HoleQueryDATE_CONST: TStringField;
    HoleQueryDEPTH_BOT: TFloatField;
    HoleQueryDEPTH_TOP: TFloatField;
    HoleQueryDIAMETER: TFloatField;
    HoleQueryREP_INST: TStringField;
    HoleQuerySITE_ID_NR: TStringField;
    LogChartRLImage1: TRLImage;
    ChartRLBand1: TRLBand;
    PiezomBand: TRLBand;
    PiezomDataSource: TDataSource;
    PiezomRLBand: TRLBand;
    PiezomSubDetail: TRLSubDetail;
    PiezomQuery: TZReadOnlyQuery;
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
    AquiferRLBand: TRLBand;
    RLBand10: TRLBand;
    RLBand11: TRLBand;
    RLBand9: TRLBand;
    RLDBMemo1: TRLDBMemo;
    RLDBMemo2: TRLDBMemo;
    RLDBMemo3: TRLDBMemo;
    RLDBMemo4: TRLDBMemo;
    RLDBMemo5: TRLDBMemo;
    RLDBText100: TRLDBText;
    RLDBText101: TRLDBText;
    RLDBText102: TRLDBText;
    RLDBText103: TRLDBText;
    RLDBText104: TRLDBText;
    RLDBText105: TRLDBText;
    RLDBText106: TRLDBText;
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
    RLDBText137: TRLDBText;
    RLDBText138: TRLDBText;
    RLDBText139: TRLDBText;
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
    RLDBText56: TRLDBText;
    RLDBText57: TRLDBText;
    RLDBText58: TRLDBText;
    RLDBText59: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText60: TRLDBText;
    RLDBText61: TRLDBText;
    RLDBText62: TRLDBText;
    RLDBText63: TRLDBText;
    RLDBText64: TRLDBText;
    RLDBText66: TRLDBText;
    RLDBText68: TRLDBText;
    RLDBText7: TRLDBText;
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
    RLDBText84: TRLDBText;
    RLDBText85: TRLDBText;
    RLDBText86: TRLDBText;
    RLDBText87: TRLDBText;
    RLDBText88: TRLDBText;
    RLDBText89: TRLDBText;
    RLDBText90: TRLDBText;
    RLDBText91: TRLDBText;
    RLDBText93: TRLDBText;
    RLDBText94: TRLDBText;
    RLDBText95: TRLDBText;
    RLDBText97: TRLDBText;
    RLDBText98: TRLDBText;
    RLDBText99: TRLDBText;
    RLDraw1: TRLDraw;
    RLDraw2: TRLDraw;
    RLDraw3: TRLDraw;
    RLDraw4: TRLDraw;
    RLLabel100: TRLLabel;
    RLLabel101: TRLLabel;
    RLLabel102: TRLLabel;
    RLLabel103: TRLLabel;
    RLLabel104: TRLLabel;
    RLLabel105: TRLLabel;
    RLLabel106: TRLLabel;
    RLLabel107: TRLLabel;
    RLLabel108: TRLLabel;
    RLLabel109: TRLLabel;
    RLLabel110: TRLLabel;
    RLLabel111: TRLLabel;
    RLLabel112: TRLLabel;
    RLLabel113: TRLLabel;
    RLLabel114: TRLLabel;
    RLLabel115: TRLLabel;
    RLLabel116: TRLLabel;
    RLLabel117: TRLLabel;
    RLLabel118: TRLLabel;
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
    RLLabel140: TRLLabel;
    RLLabel141: TRLLabel;
    RLLabel142: TRLLabel;
    RLLabel143: TRLLabel;
    RLLabel144: TRLLabel;
    RLLabel145: TRLLabel;
    RLLabel146: TRLLabel;
    RLLabel147: TRLLabel;
    RLLabel148: TRLLabel;
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
    RLLabel195: TRLLabel;
    RLLabel22: TRLLabel;
    RLLabel23: TRLLabel;
    RLLabel24: TRLLabel;
    RLLabel25: TRLLabel;
    RLLabel26: TRLLabel;
    RLLabel27: TRLLabel;
    RLLabel28: TRLLabel;
    RLLabel29: TRLLabel;
    RLLabel30: TRLLabel;
    RLLabel71: TRLLabel;
    RLLabel72: TRLLabel;
    RLLabel73: TRLLabel;
    RLLabel74: TRLLabel;
    RLLabel75: TRLLabel;
    RLLabel76: TRLLabel;
    RLLabel77: TRLLabel;
    RLLabel79: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel80: TRLLabel;
    RLLabel81: TRLLabel;
    RLLabel83: TRLLabel;
    RLLabel85: TRLLabel;
    RLLabel86: TRLLabel;
    RLLabel87: TRLLabel;
    RLLabel88: TRLLabel;
    RLLabel89: TRLLabel;
    RLLabel9: TRLLabel;
    GeolLogReport: TRLReport;
    RLBandBasicinf: TRLBand;
    ConstructionRLBand: TRLBand;
    RLBandHeader: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    RLDBText12: TRLDBText;
    RLDBText13: TRLDBText;
    RLDBText14: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText65: TRLDBText;
    RLDBText67: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLDBTextX_COORD: TRLDBText;
    RLDBTextY_COORD: TRLDBText;
    RLImageLogo: TRLImage;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel78: TRLLabel;
    RLLabel82: TRLLabel;
    RLLabel84: TRLLabel;
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
    RLMemoUserDetails: TRLMemo;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfo3: TRLSystemInfo;
    X_CoordLabel: TRLLabel;
    Y_CoordLabel: TRLLabel;
    ConstructionQuery: TZReadOnlyQuery;
    GeologyQuery: TZReadOnlyQuery;
    ZQueryView: TZReadOnlyQuery;
    procedure AquiferQueryYIELDGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryALTITUDEGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryBH_DIAMGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryCOLLAR_HIGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryDEPTHGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQuerySITE_ID_NRGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryX_COORDGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryY_COORDGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure CasingQueryDATE_INSTGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure ConstructionQueryDATE_CONSTGetText(Sender: TField;
      var aText: string; DisplayText: Boolean);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure GeolLogReportAfterPrint(Sender: TObject);
    procedure HoleFillQueryDATE_CONSTGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure HoleQueryDATE_CONSTGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure PiezomQueryDATE_CONSTGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure THICKNESS_OPENGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure ConstructionQueryCOLLAR_HIGetText(Sender: TField;
      var aText: string; DisplayText: Boolean);
    procedure ConstructionQueryDEPTHGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LookupsGetText(Sender: TField;
      var aText: string; DisplayText: Boolean);
    procedure DEPTH_BOTGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure DEPTH_TOPGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure DIAMETERGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure GeolLogReportBeforePrint(Sender: TObject; var PrintIt: boolean);
    procedure ZQueryBeforeOpen(DataSet: TDataSet);
  private
    { private declarations }
    XCoord, YCoord: ShortString;
  public
    { public declarations }
    TableList, RepFilterList: TStringlist;
  end;

var
  LogReportForm: TLogReportForm;

implementation

{$R *.lfm}

uses VARINIT, MainDataModule, strdatetime;

{ TLogReportForm }

procedure TLogReportForm.GeolLogReportBeforePrint(Sender: TObject;
  var PrintIt: boolean);
begin
  CoordLabel.Caption := CoordLabel.Caption + CoordSysDescr;
  with GeolLogReport do
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
  RLLabel89.Caption := RLLabel89.Caption + ' [' + LengthUnit + ']';
  RLLabel81.Caption := RLLabel81.Caption + ' [' + LengthUnit + ']';
  RLLabel93.Caption := RLLabel93.Caption + ' [' + LengthUnit + ']';
  RLLabel97.Caption := '[' + DiamUnit + ']';
  RLLabel152.Caption := RLLabel152.Caption + ' [' + LengthUnit + ']';
  RLLabel153.Caption := RLLabel153.Caption + ' [' + LengthUnit + ']';
  RLLabel166.Caption := '[' + DiamUnit + ']';
  RLLabel165.Caption := '[' + DiamUnit + ']';
  RLLabel158.Caption := RLLabel158.Caption + ' [' + DiamUnit + ']';
  RLLabel170.Caption := RLLabel170.Caption + ' [' + LengthUnit + ']';
  RLLabel171.Caption := RLLabel171.Caption + ' [' + LengthUnit + ']';
  RLLabel184.Caption := '[' + DiamUnit + ']';
  RLLabel183.Caption := '[' + DiamUnit + ']';
  RLLabel176.Caption := RLLabel176.Caption + ' [' + DiamUnit + ']';
  RLLabel99.Caption := RLLabel99.Caption + ' [' + LengthUnit + ']';
  RLLabel100.Caption := RLLabel100.Caption + ' [' + LengthUnit + ']';
  RLLabel188.Caption := '[' + DiamUnit + ']';
  RLLabel191.Caption := '[' + DiamUnit + ']';
  RLLabel72.Caption := RLLabel72.Caption + ' [' + LengthUnit + ']';
  RLLabel73.Caption := RLLabel73.Caption + ' [' + LengthUnit + ']';
  RLLabel149.Caption := '[' + DisUnit + ']:';
  RLLabel108.Caption := RLLabel108.Caption + ' [' + LengthUnit + ']';
  RLLabel114.Caption := RLLabel114.Caption + ' [' + LengthUnit + ']';
  RLLabel142.Caption := RLLabel142.Caption + ' [' + LengthUnit + ']';
  RLLabel143.Caption := RLLabel143.Caption + ' [' + LengthUnit + ']';
  RLLabel128.Caption := RLLabel128.Caption + ' [' + LengthUnit + ']';
  RLLabel129.Caption := RLLabel129.Caption + ' [' + LengthUnit + ']';
  if FileExists(WSpaceDir + DirectorySeparator + 'Userinfo.txt') then
    RLMemoUserDetails.Lines.LoadFromFile(WSpaceDir + DirectorySeparator + 'Userinfo.txt');
  if FileExists(WSpaceDir + DirectorySeparator + 'userlogo.jpg') then
    RLImageLogo.Picture.LoadFromFile(WSpaceDir + DirectorySeparator + 'userlogo.jpg')
  else if FileExists(WSpaceDir + DirectorySeparator + 'userlogo.bmp') then
    RLImageLogo.Picture.LoadFromFile(WSpaceDir + DirectorySeparator + 'userlogo.bmp');
  //Open all tables
  Screen.Cursor := crSQLWait;
  Sleep(100); //to process the messages and show components of forms
  Application.ProcessMessages;
  ZQueryView.Open;
  BasicinfQuery.Open;
  ConstructionQuery.Active := ConstructionSubDetail.Visible;
  HoleQuery.Active := HoleSubDetail.Visible;
  CasingQuery.Active := CasingSubDetail.Visible;
  PiezomQuery.Active := PiezomSubDetail.Visible;
  HoleFillQuery.Active := HoleFillSubDetail.Visible;
  AquiferQuery.Active := AquiferSubDetail.Visible;
  GeologyQuery.Active := GeologySubDetail.Visible;
end;

procedure TLogReportForm.ZQueryBeforeOpen(DataSet: TDataSet);
begin
  (DataSet as TZReadOnlyQuery).Connection := DataModuleMain.ZConnectionDB;
  (DataSet as TZReadOnlyQuery).Params[0].Value := CurrentSite;
end;

procedure TLogReportForm.DEPTH_BOTGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if not Sender.IsNull then
    aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2)
  else
    DisplayText := False;
end;

procedure TLogReportForm.DEPTH_TOPGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if not Sender.IsNull then
    aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2)
  else
    DisplayText := False;
end;

procedure TLogReportForm.DIAMETERGetText(Sender: TField;
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
  else
    DisplayText := False;
end;

procedure TLogReportForm.BasicinfQueryX_COORDGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := XCoord;
end;

procedure TLogReportForm.BasicinfQueryBH_DIAMGetText(Sender: TField;
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

procedure TLogReportForm.BasicinfQueryALTITUDEGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
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

procedure TLogReportForm.AquiferQueryYIELDGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
   DisplayText := False
  else
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
end;

procedure TLogReportForm.BasicinfQueryCOLLAR_HIGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if Sender.AsFloat * LengthFactor > 100 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
    else
    if Sender.AsFloat * LengthFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end;
end;

procedure TLogReportForm.BasicinfQueryDEPTHGetText(Sender: TField;
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

procedure TLogReportForm.BasicinfQuerySITE_ID_NRGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := Sender.Value;
  with DataModuleMain do
    cs2cs(BasicinfQueryX_COORD.AsString, BasicinfQueryY_COORD.AsString, GetMapRef(BasicinfQuerySITE_ID_NR.AsString), OrigCoordSysNr, CoordSysNr, XCoord, YCoord);
end;

procedure TLogReportForm.BasicinfQueryY_COORDGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := YCoord;
end;

procedure TLogReportForm.CasingQueryDATE_INSTGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := DateToStr(StringToDate(Sender.AsString));
end;

procedure TLogReportForm.ConstructionQueryDATE_CONSTGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := DateToStr(StringToDate(Sender.AsString));
end;

procedure TLogReportForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TLogReportForm.FormCreate(Sender: TObject);
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

procedure TLogReportForm.GeolLogReportAfterPrint(Sender: TObject);
begin
  Screen.Cursor := crDefault;
end;

procedure TLogReportForm.HoleFillQueryDATE_CONSTGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := DateToStr(StringToDate(Sender.AsString));
end;

procedure TLogReportForm.HoleQueryDATE_CONSTGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := DateToStr(StringToDate(Sender.AsString));
end;

procedure TLogReportForm.PiezomQueryDATE_CONSTGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := DateToStr(StringToDate(Sender.AsString));
end;

procedure TLogReportForm.THICKNESS_OPENGetText(Sender: TField;
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

procedure TLogReportForm.ConstructionQueryCOLLAR_HIGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if not Sender.IsNull then
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
    DisplayText := False;
end;

procedure TLogReportForm.ConstructionQueryDEPTHGetText(Sender: TField;
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

procedure TLogReportForm.LookupsGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull and (not PrintNoInfo) then
    DisplayText := False
  else
    aText := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
end;

end.

