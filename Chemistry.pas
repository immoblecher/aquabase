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
unit Chemistry;

{$mode objfpc}{$H+}

interface                                          

uses
  SysUtils, Classes, Graphics, Controls, Clipbrd, StdCtrls, Forms, DBCtrls, DB,
  DBGrids, ExtCtrls, ZDataset, Buttons, Menus, math, Dialogs, ComCtrls, LCLType,
  XMLPropStorage, Fileutil, rxlookup;

type

  { TChemistryForm }

  TChemistryForm = class(TForm)
    AccuDataSource: TDataSource;
    DataSource6: TDataSource;
    DBEditAG: TDBEdit;
    DBEditAL: TDBEdit;
    DBEditParam19: TDBEdit;
    DBEditARSENIC: TDBEdit;
    DBEditAU: TDBEdit;
    DBEditB: TDBEdit;
    DBEditBA: TDBEdit;
    DBEditBE: TDBEdit;
    DBEditBI: TDBEdit;
    DBEditBOD: TDBEdit;
    DBEditBR: TDBEdit;
    DBEditCA: TDBEdit;
    DBEditParam4: TDBEdit;
    DBEditCD: TDBEdit;
    DBEditCE: TDBEdit;
    DBEditCFR: TDBEdit;
    DBEditCL: TDBEdit;
    DBEditParam13: TDBEdit;
    DBEditCN: TDBEdit;
    DBEditCO: TDBEdit;
    DBEditCO3: TDBEdit;
    DBEditParam17: TDBEdit;
    DBEditCOD: TDBEdit;
    DBEditCOLR: TDBEdit;
    DBEditCR: TDBEdit;
    DBEditCU: TDBEdit;
    DBEditDEUTERIUM: TDBEdit;
    DBEditDOC: TDBEdit;
    DBEditDOX: TDBEdit;
    DBEditEC: TDBEdit;
    DBEditParam2: TDBEdit;
    DBEditECOL: TDBEdit;
    DBEditENT_VIRUS: TDBEdit;
    DBEditF: TDBEdit;
    DBEditParam16: TDBEdit;
    DBEditFAEC_ECOL: TDBEdit;
    DBEditFAEC_STREP: TDBEdit;
    DBEditFE: TDBEdit;
    DBEditParam20: TDBEdit;
    DBEditH2S: TDBEdit;
    DBEditHCO3: TDBEdit;
    DBEditParam18: TDBEdit;
    DBEditHG: TDBEdit;
    DBEditI: TDBEdit;
    DBEditK: TDBEdit;
    DBEditParam7: TDBEdit;
    DBEditKJED: TDBEdit;
    DBEditLA: TDBEdit;
    DBEditLI: TDBEdit;
    DBEditMACID: TDBEdit;
    DBEditParam12: TDBEdit;
    DBEditMALK: TDBEdit;
    DBEditParam10: TDBEdit;
    DBEditMBAS: TDBEdit;
    DBEditMG: TDBEdit;
    DBEditParam5: TDBEdit;
    DBEditMN: TDBEdit;
    DBEditParam21: TDBEdit;
    DBEditMO: TDBEdit;
    DBEditN: TDBEdit;
    DBEditParam15: TDBEdit;
    DBEditNA: TDBEdit;
    DBEditParam6: TDBEdit;
    DBEditNB: TDBEdit;
    DBEditND: TDBEdit;
    DBEditNI: TDBEdit;
    DBEditNO2: TDBEdit;
    DBEditN_AMONIA: TDBEdit;
    DBEditODR: TDBEdit;
    DBEditOIL: TDBEdit;
    DBEditOXYGEN18: TDBEdit;
    DBEditPACID: TDBEdit;
    DBEditParam11: TDBEdit;
    DBEditPALK: TDBEdit;
    DBEditParam9: TDBEdit;
    DBEditPB: TDBEdit;
    DBEditPD: TDBEdit;
    DBEditPH: TDBEdit;
    DBEditParam1: TDBEdit;
    DBEditPHEN: TDBEdit;
    DBEditPO4: TDBEdit;
    DBEditPROTO_PARA: TDBEdit;
    DBEditPT: TDBEdit;
    DBEditRCARBON: TDBEdit;
    DBEditSB: TDBEdit;
    DBEditSE: TDBEdit;
    DBEditSI: TDBEdit;
    DBEditParam8: TDBEdit;
    DBEditSN: TDBEdit;
    DBEditSO4: TDBEdit;
    DBEditParam14: TDBEdit;
    DBEditSOAP: TDBEdit;
    DBEditSOM_COLI: TDBEdit;
    DBEditSPC: TDBEdit;
    DBEditSPECGRAV: TDBEdit;
    DBEditSR: TDBEdit;
    DBEditSULF: TDBEdit;
    DBEditSUSP_SOLID: TDBEdit;
    DBEditROX: TDBEdit;
    DBEditTA: TDBEdit;
    DBEditTDS: TDBEdit;
    DBEditParam3: TDBEdit;
    DBEditTE: TDBEdit;
    DBEditTEMP: TDBEdit;
    DBEditTI: TDBEdit;
    DBEditTL: TDBEdit;
    DBEditTOC: TDBEdit;
    DBEditTOTAL_COL: TDBEdit;
    DBEditTOT_THM: TDBEdit;
    DBEditTRITIUM: TDBEdit;
    DBEditTST: TDBEdit;
    DBEditTUR: TDBEdit;
    DBEditTVO: TDBEdit;
    DBEditU: TDBEdit;
    DBEditV: TDBEdit;
    DBEditW: TDBEdit;
    DBEditX: TDBEdit;
    DBEditY: TDBEdit;
    DBEditZN: TDBEdit;
    DBEditZR: TDBEdit;
    DBGrid: TDBGrid;
    DBGridDet: TDBGrid;
    DetailNavigator: TDBNavigator;
    EditResults: TEdit;
    GotoBookmark: TMenuItem;
    Label409: TLabel;
    LabelParam2: TLabel;
    Label101: TLabel;
    Label214: TLabel;
    LabelParam6: TLabel;
    LabelParam7: TLabel;
    LabelParam8: TLabel;
    LabelParam9: TLabel;
    LabelParam10: TLabel;
    LabelParam11: TLabel;
    LabelParam12: TLabel;
    LabelParam13: TLabel;
    LabelParam14: TLabel;
    LabelParam16: TLabel;
    MenuItemBookmark1: TMenuItem;
    MenuItemBookMark2: TMenuItem;
    MenuItemGotoBookmark1: TMenuItem;
    MenuItemGotoBookmark2: TMenuItem;
    MenuItemSetBookmarks: TMenuItem;
    Panel2: TPanel;
    Label216: TLabel;
    LabelParam17: TLabel;
    LabelParam18: TLabel;
    LabelParam19: TLabel;
    LabelParam20: TLabel;
    LabelParam21: TLabel;
    Label217: TLabel;
    Label206: TLabel;
    Label202: TLabel;
    LabelParam4: TLabel;
    LabelParam1: TLabel;
    LabelParam3: TLabel;
    LabelParam5: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    Label119: TLabel;
    Label102: TLabel;
    Label120: TLabel;
    Label121: TLabel;
    Label201: TLabel;
    Label218: TLabel;
    Label204: TLabel;
    Label209: TLabel;
    Label215: TLabel;
    Label221: TLabel;
    Label208: TLabel;
    Label108: TLabel;
    Label103: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    Label213: TLabel;
    Label220: TLabel;
    Label210: TLabel;
    Label211: TLabel;
    Label104: TLabel;
    Label207: TLabel;
    Label203: TLabel;
    Label219: TLabel;
    Label205: TLabel;
    Label301: TLabel;
    Label302: TLabel;
    Label303: TLabel;
    Label305: TLabel;
    Label307: TLabel;
    Label308: TLabel;
    Label105: TLabel;
    Label310: TLabel;
    Label311: TLabel;
    Label312: TLabel;
    Label313: TLabel;
    Label314: TLabel;
    Label317: TLabel;
    Label318: TLabel;
    Label306: TLabel;
    Label401: TLabel;
    Label402: TLabel;
    Label106: TLabel;
    Label403: TLabel;
    Label404: TLabel;
    Label405: TLabel;
    Label406: TLabel;
    Label407: TLabel;
    Label408: TLabel;
    Label410: TLabel;
    Label411: TLabel;
    Label321: TLabel;
    Label413: TLabel;
    Label107: TLabel;
    Label316: TLabel;
    Label320: TLabel;
    Label412: TLabel;
    Label319: TLabel;
    Label508: TLabel;
    Label505: TLabel;
    Label502: TLabel;
    Label501: TLabel;
    Label512: TLabel;
    Label516: TLabel;
    Label315: TLabel;
    Label517: TLabel;
    Label520: TLabel;
    Label519: TLabel;
    Label518: TLabel;
    Label513: TLabel;
    Label503: TLabel;
    Label504: TLabel;
    Label506: TLabel;
    Label304: TLabel;
    Label309: TLabel;
    Label212: TLabel;
    Label514: TLabel;
    Label521: TLabel;
    Label511: TLabel;
    Label507: TLabel;
    Label509: TLabel;
    Label515: TLabel;
    Label510: TLabel;
    LinkedQueryALT_NR_1: TStringField;
    LinkedQueryALT_NR_2: TStringField;
    LinkedQueryALT_NR_3: TStringField;
    LinkedQueryALT_NR_4: TStringField;
    LinkedQueryCHM_REF_NR: TLargeintField;
    LinkedQueryCOMMENT: TStringField;
    LinkedQueryDATE_ANAL: TStringField;
    LinkedQueryDATE_SAMPL: TStringField;
    LinkedQueryDEPTH_SAMP: TFloatField;
    LinkedQueryLAB: TStringField;
    LinkedQueryMETH_SAMPL: TStringField;
    LinkedQuerySAMPLE_NR: TStringField;
    LinkedQuerySAMPL_TYPE: TStringField;
    LinkedQuerySITE_ID_NR: TStringField;
    LinkedQueryTIME_PUMP: TLargeintField;
    LinkedQueryTIME_SAMPL: TStringField;
    DBNavigatorView: TDBNavigator;
    LabelParam15: TLabel;
    PageControlChemistry: TPageControl;
    Panel1: TPanel;
    BasicinfDataSource: TDataSource;
    Panel3: TPanel;
    LinkedDataSource: TDataSource;
    CloseBitBtn: TBitBtn;
    BitBtnHelp: TBitBtn;
    PopupMenu1: TPopupMenu;
    RecordText: TStaticText;
    StaticText1: TStaticText;
    TimeSpeedButton: TSpeedButton;
    ChemSpeedButton: TSpeedButton;
    DataSource1: TDataSource;
    BasicinfNavigator: TDBNavigator;
    RxDBLookupComboAcc: TRxDBLookupCombo;
    RxDBLookupComboType: TRxDBLookupCombo;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    AMSLCheckBox: TCheckBox;
    GroupBox1: TGroupBox;
    SiteIDLabel: TLabel;
    NumberLabel: TLabel;
    FarmLabel: TLabel;
    SiteLabel: TLabel;
    EditSITE_ID_NR: TDBEdit;
    EditNR_ON_MAP: TDBEdit;
    EditFARM_NR: TDBEdit;
    EditSITE_NAME: TDBEdit;
    TabSheet7: TTabSheet;
    TypeDataSource: TDataSource;
    XMLPropStorage: TXMLPropStorage;
    Y_CoordLabel: TLabel;
    X_coordLabel: TLabel;
    AccLabel: TLabel;
    AltitudeLabel: TLabel;
    CollarLabel: TLabel;
    DepthLabel: TLabel;
    TypeLabel: TLabel;
    DateLabel: TLabel;
    EditALTITUDE: TDBEdit;
    EditCOLLAR_HI: TDBEdit;
    EditDEPTH: TDBEdit;
    EditDATE_UPDTD: TDBEdit;
    SamplesLabel: TLabel;
    StandardLabel: TLabel;
    ChemStandardLabel: TLabel;
    ChemLabel: TLabel;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DataSource4: TDataSource;
    DataSource5: TDataSource;
    CalcSpeedButton: TSpeedButton;
    DataSourceDetect: TDataSource;
    LinkedQuery: TZQuery;
    ZQuery1: TZQuery;
    ZQuery1Aggressive: TFloatField;
    ZQuery1AL: TFloatField;
    ZQuery1Anions: TFloatField;
    ZQuery1BError: TFloatField;
    ZQuery1CA: TFloatField;
    ZQuery1CaHard: TFloatField;
    ZQuery1Cations: TFloatField;
    ZQuery1CHM_REF_NR: TLargeintField;
    ZQuery1CL: TFloatField;
    ZQuery1CO3: TFloatField;
    ZQuery1Corrosion: TFloatField;
    ZQuery1EC: TFloatField;
    ZQuery1F: TFloatField;
    ZQuery1FE: TFloatField;
    ZQuery1HCO3: TFloatField;
    ZQuery1K: TFloatField;
    ZQuery1Langelier: TFloatField;
    ZQuery1MACID: TFloatField;
    ZQuery1MALK: TFloatField;
    ZQuery1MG: TFloatField;
    ZQuery1MgHard: TFloatField;
    ZQuery1MN: TFloatField;
    ZQuery1N: TFloatField;
    ZQuery1NA: TFloatField;
    ZQuery1PACID: TFloatField;
    ZQuery1PALK: TFloatField;
    ZQuery1PH: TFloatField;
    ZQuery1SAR: TFloatField;
    ZQuery1SI: TFloatField;
    ZQuery1SO4: TFloatField;
    ZQuery1SumTDS: TFloatField;
    ZQuery1TDS: TFloatField;
    ZQuery1TDS7: TFloatField;
    ZQuery1THard: TFloatField;
    ZQuery2: TZQuery;
    ZQuery2ARSENIC: TFloatField;
    ZQuery2B: TFloatField;
    ZQuery2BA: TFloatField;
    ZQuery2BI: TFloatField;
    ZQuery2CD: TFloatField;
    ZQuery2CHM_REF_NR: TLargeintField;
    ZQuery2CN: TFloatField;
    ZQuery2CO: TFloatField;
    ZQuery2CR: TFloatField;
    ZQuery2CU: TFloatField;
    ZQuery2HG: TFloatField;
    ZQuery2MO: TFloatField;
    ZQuery2NI: TFloatField;
    ZQuery2NO2: TFloatField;
    ZQuery2N_AMONIA: TFloatField;
    ZQuery2PB: TFloatField;
    ZQuery2PO4: TFloatField;
    ZQuery2SB: TFloatField;
    ZQuery2SR: TFloatField;
    ZQuery2SULF: TFloatField;
    ZQuery2TI: TFloatField;
    ZQuery2ZN: TFloatField;
    ZQuery3: TZQuery;
    ZQuery3BOD: TFloatField;
    ZQuery3CFR: TFloatField;
    ZQuery3CHM_REF_NR: TLargeintField;
    ZQuery3COD: TFloatField;
    ZQuery3DOC: TFloatField;
    ZQuery3DOX: TFloatField;
    ZQuery3ECOL: TLargeintField;
    ZQuery3ENT_VIRUS: TLargeintField;
    ZQuery3FAEC_ECOL: TLargeintField;
    ZQuery3FAEC_STREP: TLargeintField;
    ZQuery3H2S: TFloatField;
    ZQuery3KJED: TFloatField;
    ZQuery3OIL: TFloatField;
    ZQuery3PHEN: TFloatField;
    ZQuery3PROTO_PARA: TLargeintField;
    ZQuery3SOAP: TFloatField;
    ZQuery3SOM_COLI: TLargeintField;
    ZQuery3SPC: TLargeintField;
    ZQuery3TOC: TFloatField;
    ZQuery3TOTAL_COL: TLargeintField;
    ZQuery3TOT_THM: TFloatField;
    ZQuery3TVO: TLargeintField;
    ZQuery4: TZQuery;
    ZQuery4CHM_REF_NR: TLargeintField;
    ZQuery4COLR: TFloatField;
    ZQuery4DEUTERIUM: TFloatField;
    ZQuery4MBAS: TFloatField;
    ZQuery4ODR: TFloatField;
    ZQuery4OXYGEN18: TFloatField;
    ZQuery4RCARBON: TFloatField;
    ZQuery4ROX: TFloatField;
    ZQuery4SPECGRAV: TFloatField;
    ZQuery4SUSP_SOLID: TFloatField;
    ZQuery4TEMP: TFloatField;
    ZQuery4TRITIUM: TFloatField;
    ZQuery4TST: TFloatField;
    ZQuery4TUR: TFloatField;
    ZQuery5: TZQuery;
    ZQuery5AG: TFloatField;
    ZQuery5AU: TFloatField;
    ZQuery5BE: TFloatField;
    ZQuery5BR: TFloatField;
    ZQuery5CE: TFloatField;
    ZQuery5CHM_REF_NR: TLargeintField;
    ZQuery5CHM_REF_NR1: TLargeintField;
    ZQuery5I: TFloatField;
    ZQuery5LA: TFloatField;
    ZQuery5LI: TFloatField;
    ZQuery5NB: TFloatField;
    ZQuery5ND: TFloatField;
    ZQuery5PD: TFloatField;
    ZQuery5PT: TFloatField;
    ZQuery5SE: TFloatField;
    ZQuery5SN: TFloatField;
    ZQuery5TA: TFloatField;
    ZQuery5TE: TFloatField;
    ZQuery5TL: TFloatField;
    ZQuery5U: TFloatField;
    ZQuery5V: TFloatField;
    ZQuery5W: TFloatField;
    ZQuery5ZR: TFloatField;
    ZQuery6: TZQuery;
    ZQuery6PARAM1: TFloatField;
    ZQuery6PARAM10: TFloatField;
    ZQuery6PARAM11: TFloatField;
    ZQuery6PARAM12: TFloatField;
    ZQuery6PARAM13: TFloatField;
    ZQuery6PARAM14: TFloatField;
    ZQuery6PARAM15: TFloatField;
    ZQuery6PARAM16: TFloatField;
    ZQuery6PARAM17: TFloatField;
    ZQuery6PARAM18: TFloatField;
    ZQuery6PARAM19: TFloatField;
    ZQuery6PARAM2: TFloatField;
    ZQuery6PARAM20: TFloatField;
    ZQuery6PARAM21: TFloatField;
    ZQuery6PARAM3: TFloatField;
    ZQuery6PARAM4: TFloatField;
    ZQuery6PARAM5: TFloatField;
    ZQuery6PARAM6: TFloatField;
    ZQuery6PARAM7: TFloatField;
    ZQuery6PARAM8: TFloatField;
    ZQuery6PARAM9: TFloatField;
    QueryChem6Def: TZReadOnlyQuery;
    ZQuery7: TZQuery;
    ZQuery7CHM_REF_NR: TLongintField;
    ZQuery7COMMENTS: TStringField;
    ZQuery7CPARAMETER: TStringField;
    ZQuery7LIMITS: TStringField;
    ZQuery7METHOD: TStringField;
    ZReadOnlyQueryCoordAcc: TZReadOnlyQuery;
    ZReadOnlyQueryCoordAccDESCRIBE: TStringField;
    ZReadOnlyQueryCoordAccSEARCH: TStringField;
    ZReadOnlyQuerySiteType: TZReadOnlyQuery;
    ZReadOnlyQueryTopoSetDESCRIBE3: TStringField;
    ZReadOnlyQueryTopoSetSEARCH3: TStringField;
    procedure BasicinfDataSourceDataChange(Sender: TObject; Field: TField);
    procedure EditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditClick(Sender: TObject);
    procedure DBEditYChange(Sender: TObject);
    procedure DBGridColExit(Sender: TObject);
    procedure DBGridDetColExit(Sender: TObject);
    procedure DBGridDetGetCellHint(Sender: TObject; Column: TColumn;
      var AText: String);
    procedure DBGridDetMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGridDetMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBGridDetTitleClick(Column: TColumn);
    procedure DBGridGetCellHint(Sender: TObject; Column: TColumn;
      var AText: String);
    procedure DBGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGridMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure DBGridTitleClick(Column: TColumn);
    procedure DetailNavigatorClick(Sender: TObject; Button: TDBNavButtonType);
    procedure DetectionTablePostError(DataSet: TDataSet; E: EDatabaseError;
      var DataAction: TDataAction);
    procedure BasicinfNavigatorClick(Sender: TObject; Button: TDBNavButtonType);
    procedure EditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditResultsEditingDone(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure LinkedQueryAfterOpen(DataSet: TDataSet);
    procedure LinkedQueryBeforeOpen(DataSet: TDataSet);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryPostError(DataSet: TDataSet; E: EDatabaseError;
      var DataAction: TDataAction);
    procedure AMSLCheckBoxClick(Sender: TObject);
    procedure DBLookupListInfoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DEPTH_SAMPValidate(Sender: TField);
    procedure EditXChange(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: char);
    procedure MenuItemSetBookMark2Click(Sender: TObject);
    procedure MenuItemGotoBookmark2Click(Sender: TObject);
    procedure ReportLimits(const Parameter: ShortString; Factor: Byte);
    procedure RxDBLookupComboClick(Sender: TObject);
    procedure RxDBLookupComboSelect(Sender: TObject);
    procedure RxDBLookupComboMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure SamplesLabelClick(Sender: TObject);
    procedure DBGridEnter(Sender: TObject);
    procedure DBEditChemEnter(Sender: TObject);
    procedure EditBasicinfEnter(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure MenuItemGotoBookmark1Click(Sender: TObject);
    procedure MenuItemSetBookmark1Click(Sender: TObject);
    procedure DBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure METH_SAMPLValidate(Sender: TField);
    procedure ChemSpeedButtonClick(Sender: TObject);
    procedure DEPTH_SAMPGetText(Sender: TField; var aText: String; DisplayText: Boolean);
    procedure DEPTH_SAMPSetText(Sender: TField; const aText: String);
    procedure SAMPL_TYPEValidate(Sender: TField);
    procedure PageControlChemistryChange(Sender: TObject);
    procedure LabelDblClick(Sender: TObject);
    procedure ChemQueryGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure NGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure N_AMONIAGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure CalcSpeedButtonClick(Sender: TObject);
    procedure TimeSpeedButtonClick(Sender: TObject);
    procedure NSetText(Sender: TField; const aText: String);
    procedure N_AMONIASetText(Sender: TField;
      const aText: String);
    procedure DBGridDetKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridDetEnter(Sender: TObject);
    procedure UpperSetText(Sender: TField; const aText: String);
    procedure DataSourceDetectDataChange(Sender: TObject; Field: TField);
    procedure LabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DATEValidate(Sender: TField);
    procedure TIME_SAMPLValidate(Sender: TField);
    procedure LinkedDataSourceDataChange(Sender: TObject; Field: TField);
    procedure ECGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure ECSetText(Sender: TField; const aText: String);
    procedure DBEditChemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ChemNoFactorGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure ChemQuerySetText(Sender: TField; const aText: String);
    procedure BitBtnHelpClick(Sender: TObject);
    procedure CloseBitBtnClick(Sender: TObject);
    procedure ZQuery1AfterPost(DataSet: TDataSet);
    procedure ZQuery7BeforeOpen(DataSet: TDataSet);
    procedure ZQueryBeforeOpen(DataSet: TDataSet);
    procedure ZQuery1CalcFields(DataSet: TDataSet);
    procedure ZQuery1CalcsGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure ZQuery1THardGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure ZQuery2NO2GetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure ZQuery2NO2SetText(Sender: TField; const aText: string);
    procedure ZQuery2PO4GetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure ZQuery2PO4SetText(Sender: TField; const aText: string);
    procedure ZQuery6PARAMGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure ZQuery7LIMITSValidate(Sender: TField);
    procedure ZQuery7NewRecord(DataSet: TDataSet);
    procedure ZQuery7SetText(Sender: TField; const aText: string);
    procedure ZQueryPostError(DataSet: TDataSet; E: EDatabaseError;
      var DataAction: TDataAction);
  private
    { private declarations }
    CurrentPar: ShortString;
    JumpFieldNr: Byte;
    row, col : Integer;
    TheActiveDBEdit: TDBEdit;
    TheActiveRxDB: TRxDBLookupCombo;
  public
    { public declarations }
  end;

  TDBNavigatorEx = class(TDBNavigator);

var
  ChemistryForm: TChemistryForm;
  ValidFound: Boolean;

implementation

uses chemchartsettings, TIMEDEPT, LOOKUP, strdatetime, VARINIT, Calcchem, MainDataModule;

resourcestring
  LabelHint = 'Double-Click to view limits';

{$R *.lfm}

var
  CalcParamForm: TCalcForm;

procedure TChemistryForm.FormCreate(Sender: TObject);
var
  i: Integer;
  Chem6DefFound: Boolean;
begin
  Chem6DefFound := False;
  XMLPropStorage.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  TDBNavigatorEx(DBNavigatorView).Buttons[nbRefresh].Enabled := TRUE ;
  DataModuleMain.SetComponentFontAndSize(Sender, False);
  Screen.Cursor := crSQLWait;
  try
    QueryChem6Def.Open;
    Chem6DefFound := True;
  except on E: Exception do
    begin
      Screen.Cursor := crDefault;
      Chem6DefFound := False;
      MessageDlg('The "Other" chemistry parameter defininitons in your default Aquabase settings file have been updated while you are using settings from another folder location! This will be fixed now.', mtInformation, [mbOK], 0);
      //create the definition table
      Screen.Cursor := crSQLWait;
      with QueryChem6Def do
      begin
        SQL.Clear;
        SQL.Add('CREATE TABLE Chem6Def');
        SQL.Add('(ID INTEGER PRIMARY KEY AUTOINCREMENT,');
        SQL.Add('PARAM_FLD   VARCHAR (7),');
        SQL.Add('PARAMETER   VARCHAR (8),');
        SQL.Add('PARAM_DESCR VARCHAR (12),');
        SQL.Add('PARAM_UNIT  VARCHAR (6),');
        SQL.Add('SHOW BOOLEAN DEFAULT (''N''));');
        ExecSQL;
        SQL.Clear;
        for i := 1 to 21 do //fill with default values
        begin
          SQL.Add('INSERT INTO Chem6Def (ID, PARAM_FLD, PARAMETER, PARAM_DESCR, PARAM_UNIT, SHOW)');
          SQL.Add('VALUES(NULL, ''PARAM' + IntToStr(i)+ ''', NULL, NULL, NULL, ''N'');');
          ExecSQL;
          SQL.Clear;
        end;
        SQL.Add('SELECT * FROM Chem6Def');
        Open;
        Chem6DefFound := True;
        Screen.Cursor := crDefault;
      end;
    end;
  end;
  //hardcode taborder
  EditCOLLAR_HI.TabOrder := 8;
  EditDEPTH.TabOrder := 9;
  RxDBLookupComboType.TabOrder := 10;
  //check if any "Other" parameters are active to enable Tabsheet7 and DataSource
  with QueryChem6Def do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT PARAMETER, SHOW FROM Chem6Def WHERE PARAMETER IS NOT NULL AND SHOW = ''Y''');
    Open;
    TabSheet7.TabVisible := RecordCount > 0;
    DataSource6.Enabled := RecordCount > 0;
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM Chem6Def');
    Open;
  end;
  for i := 0 to ComponentCount-1 do
    if (Components[i] is TLabel) and (Copy((Components[i] as TLabel).Name, 1, 5) = 'Label') then
      (Components[i] as TLabel).Hint := LabelHint;
  if Chem6DefFound and TabSheet7.TabVisible then
  for i := 0 to ComponentCount-1 do
  begin
    if (Components[i] is TLabel) and (Components[i].Tag > 6000) then //"Other" labels
    begin
      QueryChem6Def.Locate('ID', Components[i].Tag - 6000, []);
      (Components[i] as TLabel).Caption := QueryChem6Def.FieldByName('PARAMETER').AsString +  ' [' + QueryChem6Def.FieldByName('PARAM_UNIT').AsString + ']';
      (Components[i] as TLabel).Visible := ((Components[i] as TLabel).Caption > '') and QueryChem6Def.FieldByName('SHOW').AsBoolean;
    end
    else
    if (Components[i] is TDBEdit) and (Components[i].Tag > 6000) then //"Other" DBEdits
    begin
      QueryChem6Def.Locate('ID', Components[i].Tag - 6000, []);
      (Components[i] as TDBEdit).Hint := QueryChem6Def.FieldByName('PARAM_DESCR').AsString;
      (Components[i] as TDBEdit).Visible := ((Components[i] as TDBEdit).Hint > '') and QueryChem6Def.FieldByName('SHOW').AsBoolean;
    end
  end;//End for-loop
  QueryChem6Def.Close;
 //create the calculated parameters form (invisible)
  CalcParamForm := TCalcForm.Create(Application);
  with CalcParamForm do
  begin
    for i := 0 to ComponentCount - 1 do
      if (Components[i] is TDBText) then
        (Components[i] as TDBText).DataSource := DataSource1;
  end;
  ValidFound := True;
  Screen.Cursor := crDefault;
end;

procedure TChemistryForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FreeAndNil(CalcParamForm);
  with DataModuleMain do
  begin
    ZQueryView.FreeBookmark(Bookmark1);
    ZQueryView.FreeBookmark(Bookmark2);
  end;
  ZQuery1.Close;
  ZQuery2.Close;
  ZQuery3.Close;
  ZQuery4.Close;
  ZQuery5.Close;
  ZQuery6.Close;
  ZQuery7.Close;
  LinkedQuery.Close;
  ZReadOnlyQueryCoordAcc.Close;
  ZReadOnlyQuerySiteType.Close;
  Editing := 'Editing: <none>';
  CloseAction := caFree;
end;

procedure TChemistryForm.FormActivate(Sender: TObject);
var
  i: Word;
begin
  Screen.Cursor := crSQLWait;
  DataModuleMain.BasicValidFound := True;
  Caption := 'Chemistry Parameters - [' + UpperCase(FilterName) + ']';
  if PageControlChemistry.ActivePageIndex = 2 then
    ChemLabel.Caption := 'Parameters [' + ChemUnit + '], bact. [counts/100ml]'
  else
    ChemLabel.Caption := 'Parameters [' + ChemUnit + '] where applicable';
  ChemStandardLabel.Caption := ChemStandardDescr;
  SamplesLabel.Caption := 'Samples - Depth [' + LengthUnit + ']';
  AltitudeLabel.Caption := '&Altitude [' + LengthUnit + ']';
  CollarLabel.Caption := 'Co&llar [' + LengthUnit + ']';
  DepthLabel.Caption :=  'Dept&h [' + LengthUnit + ']';
  BasicinfNavigator.Enabled := DataModuleMain.NrRecords > 0;
  //check for AsN
  if AsN then
  begin
    Label115.Caption := 'NO3 as N';
    Label214.Caption := 'NO2 as N';
    Label212.Caption := 'NH4 as N';
    Label216.Caption := 'PO4 as P';
  end
  else
  begin
    Label115.Caption := 'NO3';
    Label214.Caption := 'NO2';
    Label212.Caption := 'NH4';
    Label216.Caption := 'PO4';
  end;
  Label102.Caption := 'EC [' + ECUnit + ']';
  //set correct label sizes according to content (autosize not working properly)
  for i := 0 to ComponentCount-1 do
  begin
    if (Components[i] is TLabel) then
    begin
      (Components[i] as TLabel).AutoSize := False;
      (Components[i] as TLabel).Width := (Components[i] as TLabel).Canvas.TextWidth((Components[i] as TLabel).Caption);
      (Components[i] as TLabel).Height := (Components[i] as TLabel).Canvas.TextHeight((Components[i] as TLabel).Caption);
    end;
  end;
  SamplesLabel.Width := Width - 100;
  LinkedQuery.Refresh;
  Screen.Cursor := crDefault;
  if DataModuleMain.BasicinfQueryNGDB_FLAG.Value = 9 then //convert LONGITUDE/LATITUDE to X_COORD/Y_COORD
  if MessageDlg('The geometry of the current site has changed. Do you want to update the coordinates in the database accordingly?', mtInformation, [mbYes, mbNo], 0) = mrYes then
  with DataModuleMain do
  begin
    UpdateCoordsWithCs2cs(BasicinfQueryLONGITUDE.AsString, BasicinfQueryLATITUDE.AsString, BasicinfQuerySITE_ID_NR.Value);
    BasicinfQuery.Refresh;
    ShowMessage('Site coordinates were updated from a changed geometry!');
  end;
end;

procedure TChemistryForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (not (ActiveControl is TDBGrid)) and (ActiveControl.Tag < 1000) then
  begin
    if ssCtrl in Shift then
    begin
      case Key of
        VK_Right: DataModuleMain.ZQueryView.Next;
        VK_Left: DataModuleMain.ZQueryView.Prior;
        VK_F6: with DataModuleMain do
                 if Assigned(Bookmark1) then ZQueryView.GotoBookmark(Bookmark1);
        VK_F7: with DataModuleMain do
                 if Assigned(Bookmark2) then ZQueryView.GotoBookmark(Bookmark2);
        VK_F8: begin
                 DataModuleMain.BasicinfQuery.Edit;
                 if (ActiveControl is TDBEdit) or (ActiveControl is TRxDBLookupCombo)
                   then //stay on the control
                 else EditNR_ON_MAP.SetFocus;
               end;
      78, 110: with PageControlChemistry do
                 if (TabIndex < 6) and TabSheet7.TabVisible then TabIndex := TabIndex + 1
                 else if TabIndex < 4 then TabIndex := TabIndex + 1
                 else TabIndex := TabIndex + 2;
      80, 113: with PageControlChemistry do
                 if TabIndex = 6 then
                 begin
                   if TabSheet7.TabVisible then TabIndex := TabIndex - 1
                   else TabIndex := TabIndex - 2;
                 end
                 else if TabIndex > 0 then TabIndex := TabIndex - 1;
      end {of case}
    end
    else
    if ssAlt in Shift then
      case Key of
        VK_RIGHT: DataModuleMain.ZQueryView.Next;
         VK_LEFT: DataModuleMain.ZQueryView.Prior;
      end {of case}
    else
    case Key of
     VK_F1: if (ActiveControl is TEdit) or (ActiveControl is TDBEdit) or (ActiveControl is TRxDBLookupCombo) then
              BitBtnHelpClick(ActiveControl)
            else
              BitBtnHelpClick(BitBtnHelp);
     VK_F5: begin
               DataModuleMain.ZQueryView.Refresh;
               DataModuleMain.BasicinfQuery.Refresh;
             end;
     VK_F6: with DataModuleMain do
            begin
              ZQueryView.FreeBookmark(Bookmark1);
              Bookmark1 := ZQueryView.GetBookmark;
            end;
     VK_F7: with DataModuleMain do
            begin
              ZQueryView.FreeBookmark(Bookmark2);
              Bookmark2 := ZQueryView.GetBookmark;
            end;
     VK_F8: if DataModuleMain.BasicinfQuery.State IN [dsInsert, dsEdit] then
              DataModuleMain.BasicinfQuery.Post;
     VK_ESCAPE: if DataModuleMain.BasicinfQuery.State IN [dsInsert, dsEdit] then
            DataModuleMain.BasicinfQuery.Cancel;
    end; {of case}
  end
  else
  if (ActiveControl is TDBGrid) and (Key = VK_F1) then
  begin
    if (ActiveControl as TDBGrid).SelectedField.Tag > 0 then //is lookup field then use LookupComboAcc helpcontext
      BitBtnHelpClick(RxDBLookupComboAcc)
    else
      BitBtnHelpClick(ActiveControl);
  end;
end;

procedure TChemistryForm.FormShow(Sender: TObject);
begin
  //open all the tables
  try
    Screen.Cursor := crSQLWait;
    ZReadOnlyQueryCoordAcc.Open;
    ZReadOnlyQuerySiteType.Open;
  finally
    Screen.Cursor := crDefault;
  end;
  try
    LinkedQuery.Open;
  except on E: Exception do
    MessageDlg(E.Message + ' - You may have to contact your database administrator to resolve this error.', mtError, [mbOK], 0);
  end;
end;

procedure TChemistryForm.LinkedQueryAfterOpen(DataSet: TDataSet);
begin
  if LinkedQuery.Active then
  begin
    TimeSpeedButton.Enabled := LinkedQuery.RecordCount > 0;
    LinkedQuery.First;
    LinkedDataSource.AutoEdit := AutoEditGrid;
  end;
end;

procedure TChemistryForm.LinkedQueryBeforeOpen(DataSet: TDataSet);
begin
  LinkedQuery.FetchRow := StrToInt(EditResults.Text);
  LinkedQuery.Params[0].AsString := CurrentSite;
end;

procedure TChemistryForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  LinkedQuerySAMPLE_NR.Value := DataModuleMain.BasicinfQueryNR_ON_MAP.Value;
  LinkedQueryDATE_SAMPL.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryTIME_SAMPL.Value := '0000';
  LinkedQueryDATE_ANAL.Value := FormatDateTime('YYYYMMDD', Date);
  if JumpFieldNr > 0 then
      DBGrid.SelectedField := LinkedQuery.Fields.Fields[JumpFieldNr]
    else
      DBGrid.SelectedField := LinkedQuery.Fields.Fields[2];
end;

procedure TChemistryForm.LinkedQueryPostError(DataSet: TDataSet;
  E: EDatabaseError; var DataAction: TDataAction);
begin
  ShowMessage(E.Message + '. Record will not be posted!');
  DataAction := daAbort;
end;

procedure TChemistryForm.AMSLCheckBoxClick(Sender: TObject);
begin
  LinkedQuery.Refresh;
end;

procedure TChemistryForm.DBLookupListInfoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    DBGrid.Enabled := True;
    DBGrid.SetFocus;
  end;
end;

procedure TChemistryForm.DEPTH_SAMPValidate(Sender: TField);
begin
  if DataModuleMain.BasicinfQueryDEPTH.IsNull then
    ValidFound := True
  else
    ValidFound := Sender.AsFloat <= DataModuleMain.BasicinfQueryDEPTH.AsFloat;
end;

procedure TChemistryForm.EditXChange(Sender: TObject);
begin
  //Set the edit mask of coordinate DBEdits
  if ShowDMS then
    (Sender as TDBEdit).EditMask := '900°00''00.00">L;1;_'
  else
    (Sender as TDBEdit).EditMask := '';
end;

procedure TChemistryForm.EditKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in [#3]) then //<ctrl-c> copy
    DataModuleMain.CheckMaskEditInput(Key);
end;

procedure TChemistryForm.MenuItemSetBookMark2Click(Sender: TObject);
begin
  with DataModuleMain do
  begin
    ZQueryView.FreeBookmark(Bookmark2);
    Bookmark1 := ZQueryView.GetBookmark;
  end;
end;

procedure TChemistryForm.MenuItemGotoBookmark2Click(Sender: TObject);
begin
  with DataModuleMain do
    ZQueryView.GotoBookmark(Bookmark2);
end;

procedure TChemistryForm.ReportLimits(const Parameter: ShortString; Factor: Byte);
var ParamFactor: Real;
    OutputParam, Class0, Class1, Class2, Class3, Class4: ShortString;
    MessageStr: String;
begin
  ParamFactor := 1;
  OutputParam := Parameter;
  if DataModuleMain.ClassTable.Active then
  begin
    if DataModuleMain.ClassTable.Locate('PARAMETER', Parameter, []) then
    begin
      if (Parameter = 'N') and (not AsN) then
      begin
        OutputParam := 'NO3';
        ParamFactor := 4.4263724;
      end
      else
      if (Parameter = 'N_AMONIA') and (not AsN) then
      begin
        OutputParam := 'NH4';
        ParamFactor := 1.28785367;
      end
      else
      if (Parameter = 'NO2') and (not AsN) then
      begin
        OutputParam := 'NO2';
        ParamFactor := 3.28443;
      end
      else
      if Parameter = 'EC' then
      begin
        OutputParam := 'EC';
        ParamFactor := ECFactor;
      end;
      if Factor = 0 then ParamFactor := ParamFactor * ChemFactor;
      Class0 := FloatToStr(DataModuleMain.ClassTableCLASS0.Value * ParamFactor);
      Class1 := FloatToStr(DataModuleMain.ClassTableCLASS1.Value * ParamFactor);
      if Class1 = '999999' then Class1 := 'not defined';
      Class2 := FloatToStr(DataModuleMain.ClassTableCLASS2.Value * ParamFactor);
      if Class2 = '999999' then Class2 := 'not defined';
      Class3 := FloatToStr(DataModuleMain.ClassTableCLASS3.Value * ParamFactor);
      if Class3 = '999999' then Class3 := 'not defined';
      Class4 := ' > ' + FloatToStr(DataModuleMain.ClassTableCLASS3.Value * ParamFactor);
      if Class4 = ' > 999999' then Class4 := 'not defined';
      ShowMessage('Classes for ' + OutputParam + ' in ' + ChemStandardLabel.Caption + ':'
      + #13' '
      + #13'Class 0: 0 - ' + Class0
      + #13'Class 1: ' + Class0 + ' - ' + Class1
      + #13'Class 2: ' + Class1 + ' - ' + Class2
      + #13'Class 3: ' + Class2 + ' - ' + Class3
      + #13'Class 4: ' + Class4);
    end
    else
    if Parameter = 'PH' then
    begin
      DataModuleMain.ClassTable.Locate('PARAMETER', 'PHL', []);
      Class0 := '> ' + FloatToStr(Abs(DataModuleMain.ClassTableCLASS0.Value));
      DataModuleMain.ClassTable.Locate('PARAMETER', 'PHU', []);
      Class0 := Class0 + ' and <=' + FloatToStr(DataModuleMain.ClassTableCLASS0.Value);
      DataModuleMain.ClassTable.Locate('PARAMETER', 'PHL', []);
      Class1 := FloatToStr(Abs(DataModuleMain.ClassTableCLASS1.Value));
      DataModuleMain.ClassTable.Locate('PARAMETER', 'PHU', []);
      Class1 := Class1 + ' and ' + FloatToStr(DataModuleMain.ClassTableCLASS1.Value);
      DataModuleMain.ClassTable.Locate('PARAMETER', 'PHL', []);
      Class2 := FloatToStr(Abs(DataModuleMain.ClassTableCLASS2.Value));
      DataModuleMain.ClassTable.Locate('PARAMETER', 'PHU', []);
      Class2 := Class2 + ' and ' + FloatToStr(DataModuleMain.ClassTableCLASS2.Value);
      DataModuleMain.ClassTable.Locate('PARAMETER', 'PHL', []);
      Class3 := FloatToStr(Abs(DataModuleMain.ClassTableCLASS3.Value));
      DataModuleMain.ClassTable.Locate('PARAMETER', 'PHU', []);
      Class3 := Class3 + ' and ' + FloatToStr(DataModuleMain.ClassTableCLASS3.Value);
      DataModuleMain.ClassTable.Locate('PARAMETER', 'PHL', []);
      Class4 := ' < ' + FloatToStr(Abs(DataModuleMain.ClassTableCLASS3.Value));
      DataModuleMain.ClassTable.Locate('PARAMETER', 'PHU', []);
      Class4 := Class4 + ' and > ' + FloatToStr(DataModuleMain.ClassTableCLASS3.Value);
      ShowMessage('Classes for ' + OutputParam + ' in ' + ChemStandardLabel.Caption + ':'
      + #13' '
      + #13'Class 0: ' + Class0
      + #13'Class 1: ' + Class1
      + #13'Class 2: ' + Class2
      + #13'Class 3: ' + Class3
      + #13'Class 4: ' + Class4);
    end
    else
      MessageDlg('No classes for ' + OutputParam + ' defined in standard ' + ChemStandardLabel.Caption + '!', mtInformation, [mbOK], 0);
  end
  else
  begin
    if DataModuleMain.StandardTable.Locate('PARAMETER', Parameter, []) then
    begin
      if (Parameter = 'N') and (not AsN) then
      begin
        OutputParam := 'NO3';
        ParamFactor := 4.4263724;
      end
      else
      if (Parameter = 'N_AMONIA') and (not AsN) then
      begin
        OutputParam := 'NH4';
        ParamFactor := 1.28785367;
      end
      else
      if Parameter = 'EC' then
      begin
        OutputParam := 'EC';
        ParamFactor := ECFactor;
      end;
      if Factor = 0 then ParamFactor := ParamFactor * ChemFactor;
      MessageStr := 'Limits for ' + OutputParam + ' in ' + ChemStandardLabel.Caption + ':' + #13' ';
      if DataModuleMain.StandardTableSTDRECLO.Value > - 1 then
        MessageStr := MessageStr + #13'Minimum recommended: ' + FloatToStrF(DataModuleMain.StandardTableSTDRECLO.Value * ParamFactor, ffFixed, 15, 3);
      if DataModuleMain.StandardTableSTDMAXLO.Value > - 1 then
        MessageStr := MessageStr + #13'Minimum acceptable: ' + FloatToStrF(DataModuleMain.StandardTableSTDMAXLO.Value * ParamFactor, ffFixed, 15, 3);
      if DataModuleMain.StandardTableSTDRECHI.Value > - 1 then
        MessageStr := MessageStr + #13'Maximum recommended: ' + FloatToStrF(DataModuleMain.StandardTableSTDRECHI.Value * ParamFactor, ffFixed, 15, 3);
      if DataModuleMain.StandardTableSTDMAXHI.Value > - 1 then
        MessageStr := MessageStr + #13'Maximum allowable: ' + FloatToStrF(DataModuleMain.StandardTableSTDMAXHI.Value * ParamFactor, ffFixed, 15, 3);
      ShowMessage(MessageStr);
    end
    else
      ShowMessage('No limits for ' + OutputParam + ' defined in standard ' + ChemStandardLabel.Caption + '!');
  end;
end;

procedure TChemistryForm.RxDBLookupComboClick(Sender: TObject);
begin
  (Sender as TRxDBLookupCombo).SetFocus;
end;

procedure TChemistryForm.RxDBLookupComboSelect(Sender: TObject);
begin
  if (DataModuleMain.BasicinfQuery.State <> dsEdit)
    and (DataModuleMain.BasicinfQuery.State <> dsInsert)
      and not (Sender as TRxDBLookupCombo).DataSource.DataSet.FieldByName((Sender as TRxDBLookupCombo).DataField).IsNull then
        (Sender as TRxDBLookupCombo).Text := (Sender as TRxDBLookupCombo).DataSource.DataSet.FieldByName((Sender as TRxDBLookupCombo).DataField).Value;
end;

procedure TChemistryForm.RxDBLookupComboMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  (Sender as TRxDBLookupCombo).Hint := DataModuleMain.TranslateCode((Sender as TRxDBLookupCombo).HelpKeyword, (Sender as TRxDBLookupCombo).Value);
end;

procedure TChemistryForm.SamplesLabelClick(Sender: TObject);
begin
  Editing := 'Editing: Samples';
  DBGrid.SetFocus;
end;

procedure TChemistryForm.DBGridEnter(Sender: TObject);
begin
  if DataModuleMain.BasicinfQuery.State IN [dsInsert, dsEdit] then
  begin
    if MessageDlg('Changes to Basic Information have not been posted and will be lost! Post record now?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        DataModuleMain.BasicinfQuery.Post
    else
      DataModuleMain.BasicinfQuery.Cancel;
  end
  else
  if ZQuery7.State IN [dsInsert, dsEdit] then
  begin
    if MessageDlg('Changes to Detection Limit information have not been posted and will be lost! Post record now?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        ZQuery7.Post
    else
      ZQuery7.Cancel;
  end
  else
  if DetailNavigator.DataSource.DataSet.State IN [dsInsert, dsEdit] then
  begin
    if MessageDlg('Changes to Chemistry information have not been posted and will be lost! Post record now?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        DetailNavigator.DataSource.DataSet.Post
    else
      DetailNavigator.DataSource.DataSet.Cancel;
  end;
  DetailNavigator.DataSource := LinkedDataSource;
  DetailNavigator.VisibleButtons := [nbFirst,nbPrior,nbNext,nbLast,nbInsert,nbDelete,nbEdit,nbPost,nbCancel,nbRefresh];
  DetailNavigator.Width := 262;
  Editing := 'Editing: Samples';
end;

procedure TChemistryForm.DBEditChemEnter(Sender: TObject);
begin
  if BasicinfDataSource.DataSet.State IN [dsInsert, dsEdit] then
  begin
    if MessageDlg('Changes to Basic information have not been posted and will be lost! Post record now?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        BasicinfDataSource.DataSet.Post
    else
      BasicinfDataSource.DataSet.Cancel;
  end
  else
  if ZQuery7.State IN [dsInsert, dsEdit] then
  begin
    if MessageDlg('Changes to Detection Limit information have not been posted and will be lost! Post record now?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        ZQuery7.Post
    else
      ZQuery7.Cancel;
  end
  else
  if LinkedQuery.State IN [dsInsert, dsEdit] then
  begin
    if MessageDlg('Changes to Sample information have not been posted and will be lost! Post record now?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        LinkedQuery.Post
    else
      LinkedQuery.Cancel;
  end;
  if LinkedQuery.RecordCount > 0 then
  begin
    CurrentPar := (Sender as TDBEdit).DataField;
    DetailNavigator.DataSource := (Sender as TDBEdit).DataSource;
    DetailNavigator.VisibleButtons := [nbDelete,nbEdit,nbPost,nbCancel,nbRefresh];
    DetailNavigator.Width := DetailNavigator.Height * 5 + 5;
    Editing := 'Editing: ' + ((Sender as TDBEdit).Parent as TTabSheet).Hint;
  end;
  if Sender is TDBEdit then
  begin
    TheActiveDBEdit := Sender as TDBEdit;
    TheActiveRxDB := NIL;
  end
end;

procedure TChemistryForm.EditBasicinfEnter(Sender: TObject);
begin
  if LinkedQuery.State IN [dsInsert, dsEdit] then
  begin
    if MessageDlg('Changes to Sample information have not been posted and will be lost! Post record now?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        LinkedQuery.Post
    else
      LinkedQuery.Cancel;
  end
  else
  if ZQuery7.State IN [dsInsert, dsEdit] then
  begin
    if MessageDlg('Changes to Detection Limit information have not been posted and will be lost! Post record now?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        ZQuery7.Post
    else
      ZQuery7.Cancel;
  end
  else
  if DetailNavigator.DataSource.DataSet.State IN [dsInsert, dsEdit] then
  begin
    if MessageDlg('Changes to Chemistry information have not been posted and will be lost! Post record now?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        DetailNavigator.DataSource.DataSet.Post
    else
      DetailNavigator.DataSource.DataSet.Cancel;
  end;
  Editing := 'Editing: Basic information';
  if Sender is TDBEdit then
  begin
    TheActiveDBEdit := Sender as TDBEdit;
    TheActiveRxDB := NIL;
  end
  else
  if Sender is TRxDBLookupCombo then
  begin
    TheActiveRxDB := Sender as TRxDBLookupCombo;
    TheActiveDBEdit := NIL;
  end;
end;

procedure TChemistryForm.PopupMenu1Popup(Sender: TObject);
begin
  with DataModuleMain do
  begin
    MenuItemGotoBookmark1.Enabled := Assigned(BookMark1);
    MenuItemGotoBookmark2.Enabled := Assigned(BookMark1);
  end;
end;

procedure TChemistryForm.MenuItemGotoBookmark1Click(Sender: TObject);
begin
  with DataModuleMain do
    ZQueryView.GotoBookmark(Bookmark1);
end;

procedure TChemistryForm.MenuItemSetBookmark1Click(Sender: TObject);
begin
  with DataModuleMain do
  begin
    ZQueryView.FreeBookmark(Bookmark1);
    Bookmark1 := ZQueryView.GetBookmark;
  end;
end;

procedure TChemistryForm.DBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  TheCategory: ShortString;
begin
  if (ssCtrl in Shift) and (Key = VK_F8) then
    LinkedQuery.Edit
  else
  case Key of
    VK_TAB: if (DBGrid.SelectedIndex = DBGrid.Columns.Count - 1) and (not (ssShift in Shift))then //is at the last column and tabs right
            begin
              LinkedQuery.Append;
              DBGrid.SelectedIndex := 1;
              Key := 0;
            end;
    VK_DELETE: if LinkedQuery.State IN [dsInsert, dsEdit] then
                 if ssShift in Shift then
                   DBGrid.SelectedField.Clear;
    VK_F5: LinkedQuery.Refresh;
    VK_F8: if LinkedQuery.State IN [dsInsert, dsEdit] then LinkedQuery.Post;
    VK_F9:
      begin
        case DBGrid.SelectedField.Tag of
          1: TheCategory := 'SAMPTYPE';
          2: TheCategory := 'METHSAMP';
        else exit;
        end; {of CASE}
        with TLookupForm.Create(Application) do
        begin
          LookupCategory := TheCategory;
          LookupValue := LinkedQuery.FieldByName(DBGrid.SelectedField.FieldName).AsString;
          ShowModal;
          if ModalResult = mrOK then
          if LinkedQuery.State IN [dsInsert, dsEdit] then
            LinkedQuery.FieldByName(DBGrid.SelectedField.FieldName).AsString := LookupValue;
          Close;
        end;
      end;
  end; {of case}
end;

procedure TChemistryForm.METH_SAMPLValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound(Sender.LookupKeyFields, Sender.AsString);
end;

procedure TChemistryForm.ChemSpeedButtonClick(Sender: TObject);
begin
  with TChemChartSettingsForm.Create(Application) do
  begin
    DateTimePickerFrom.Date := StringToDate(LinkedQueryDATE_SAMPL.Value);
    DateTimePickerFrom.Time := StringToTime(LinkedQueryTIME_SAMPL.Value);
    ComboBoxViews.Enabled := False;
    ShowModal;
  end;
end;

procedure TChemistryForm.DEPTH_SAMPGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if AMSLCheckBox.Checked then
      aText := FloatToStrF((DataModuleMain.BasicinfQueryALTITUDE.Value - Sender.AsFloat) * LengthFactor, ffFixed, 15, 2)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end
end;

procedure TChemistryForm.DEPTH_SAMPSetText(Sender: TField;
  const aText: String);
begin
  if aText <> '' then
  begin
    if AMSLCheckBox.Checked then
      LinkedQueryDEPTH_SAMP.Value := (DataModuleMain.BasicinfQueryALTITUDE.Value - StrToFloat(aText))/LengthFactor
    else
      LinkedQueryDEPTH_SAMP.Value := StrToFloat(aText)/LengthFactor;
  end;
end;

procedure TChemistryForm.SAMPL_TYPEValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound(Sender.LookupKeyFields, Sender.AsString);
end;

procedure TChemistryForm.PageControlChemistryChange(Sender: TObject);
begin
  case PageControlChemistry.PageIndex of
  0: begin
       ChemLabel.Caption := 'Parameters [' + ChemUnit + '] where applicable';
       TimeSpeedButton.Hint := 'Time dependent graph of main parameters';
       TimeSpeedButton.Enabled := ZQuery1.RecordCount > 0;
     end;
  1: begin
       ChemLabel.Caption := 'Parameters [' + ChemUnit + '] where applicable';
       TimeSpeedButton.Hint := 'Time dependent graph of additional parameters';
       TimeSpeedButton.Enabled := ZQuery2.RecordCount > 0;
     end;
  2: begin
       ChemLabel.Caption := 'Parameters [' + ChemUnit + '], bact. [counts/100ml]';
       TimeSpeedButton.Hint := 'Time dependent graph of organic/bacteriological parameters';
       TimeSpeedButton.Enabled := ZQuery3.RecordCount > 0;
     end;
  3: begin
       ChemLabel.Caption := 'Parameters [' + ChemUnit + '] where applicable';
       TimeSpeedButton.Hint := 'Time dependent graph of physical properties and isoptopes';
       TimeSpeedButton.Enabled := ZQuery4.RecordCount > 0;
     end;
  4: begin
       ChemLabel.Caption := 'Parameters [' + ChemUnit + '] where applicable';
       TimeSpeedButton.Hint := 'Time dependent graph of rare parameters';
       TimeSpeedButton.Enabled := ZQuery5.RecordCount > 0;
     end;
  5: begin
       ChemLabel.Caption := 'Parameters [' + ChemUnit + '] where applicable';
       TimeSpeedButton.Hint := 'Time dependent graph of other parameters';
       TimeSpeedButton.Enabled := ZQuery6.RecordCount > 0;
     end;
  6: begin
       TimeSpeedButton.Enabled := False;
     end;
  end; {of case}
  ChemLabel.Width := StandardLabel.Left - Chemlabel.Left - 5;
  TheActiveDBEdit := NIL;
  TheActiveRxDB := NIL;
end;

procedure TChemistryForm.LabelDblClick(Sender: TObject);
begin
  ReportLimits(((Sender as TLabel).FocusControl as TDBEdit).DataField, (Sender as TLabel).Tag);
end;

procedure TChemistryForm.ChemQueryGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
var
  Limit: ShortString;
begin
  if (Sender.Value <> -1) and (not Sender.IsNull) then
  begin
    if ZQuery7.Locate('CPARAMETER', Sender.FieldName, []) then
      Limit := ZQuery7LIMITS.AsString + ' '
    else
      Limit := '';
    aText := Limit + DataModuleMain.FormatTheFloat(Sender.Value * ChemFactor);
    if DataModuleMain.ClassTable.Active then
    begin
      if DataModuleMain.ClassTable.Locate('PARAMETER', Sender.FieldName, []) then
        (FindComponent('DBEdit' + Sender.FieldName) as TDBEdit).Font := DataModuleMain.GetFont(Sender.Value)
      else
        (FindComponent('DBEdit' + Sender.FieldName) as TDBEdit).Font := AppFont;
    end
    else
    begin
      if DataModuleMain.StandardTable.Locate('PARAMETER', Sender.FieldName, []) then
        (FindComponent('DBEdit' + Sender.FieldName) as TDBEdit).Font := DataModuleMain.GetFont(Sender.Value)
      else
        (FindComponent('DBEdit' + Sender.FieldName) as TDBEdit).Font := AppFont;
    end;
  end
  else DisplayText := False;
end;

procedure TChemistryForm.NGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
var
  Limit: ShortString;
  TheValue: Double;
begin
  if (not Sender.IsNull) and (Sender.Value > -1) then
  begin
    if ZQuery7.Locate('CPARAMETER', Sender.FieldName, []) then
      Limit := ZQuery7LIMITS.AsString + ' '
    else
      Limit := '';
    if AsN then
    begin
      TheValue := Sender.AsFloat * ChemFactor;
      Label115.Caption := 'NO3 as N';
    end
    else
    begin
      TheValue := Sender.AsFloat * ParamFactor[0] * ChemFactor;
      Label115.Caption := 'NO3';
    end;
    aText := Limit + DataModuleMain.FormatTheFloat(TheValue);
    if DataModuleMain.ClassTable.Active then
    begin
      if DataModuleMain.ClassTable.Locate('PARAMETER', 'N', []) then
        DBEditN.Font := DataModuleMain.GetFont(Sender.Value)
      else DBEditN.Font := AppFont;
    end
    else
    begin
      if DataModuleMain.StandardTable.Locate('PARAMETER', 'N', []) then
        DBEditN.Font := DataModuleMain.GetFont(Sender.Value)
      else DBEditN.Font := AppFont;
    end;
  end
  else DisplayText := False;
end;

procedure TChemistryForm.N_AMONIAGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
var
  Limit: ShortString;
  TheValue: Double;
begin
  if (Sender.Value > -1) and (not Sender.IsNull) then
  begin
    if ZQuery7.Locate('CPARAMETER', Sender.FieldName, []) then
      Limit := ZQuery7LIMITS.AsString + ' '
    else
      Limit := '';
    if AsN then
    begin
      TheValue := Sender.Value * ChemFactor;
      Label212.Caption := 'NH4 as N';
    end
    else
    begin
      TheValue := Sender.AsFloat * ParamFactor[2] * ChemFactor;
      Label212.Caption := 'NH4';
    end;
    aText := Limit + DataModuleMain.FormatTheFloat(TheValue);
    if DataModuleMain.ClassTable.Active then
    begin
      if DataModuleMain.ClassTable.Locate('PARAMETER', 'N_AMONIA', []) then
        DBEditN_AMONIA.Font := DataModuleMain.GetFont(Sender.Value)
      else DBEditN_AMONIA.Font := AppFont;
    end
    else
    begin
      if DataModuleMain.StandardTable.Locate('PARAMETER', 'N_AMONIA', []) then
        DBEditN_AMONIA.Font := DataModuleMain.GetFont(Sender.Value)
      else DBEditN_AMONIA.Font := AppFont;
    end;
  end
  else DisplayText := False;
end;

procedure TChemistryForm.CalcSpeedButtonClick(Sender: TObject);
begin
  CalcParamForm.Show;
end;

procedure TChemistryForm.TimeSpeedButtonClick(Sender: TObject);
begin
  with TTimeDeptForm.Create(Application) do
  begin
    case PageControlChemistry.ActivePageIndex of
    0: begin
         TimeDeptTable[1] := 'CHEM_001';
       end;
    1: begin
         TimeDeptTable[1] := 'CHEM_002';
       end;
    2: begin
         TimeDeptTable[1] := 'CHEM_003';
       end;
    3: begin
         TimeDeptTable[1] := 'CHEM_004';
       end;
    4: begin
         TimeDeptTable[1] := 'CHEM_005';
       end;
    5: begin
         TimeDeptTable[1] := 'CHEM_006';
       end;
    end; //of case
    StartDate := StringToDate(LinkedQueryDATE_SAMPL.AsString);
    StartTime := StringToTime(LinkedQueryTIME_SAMPL.AsString);
    ShowModal;
  end;
end;

procedure TChemistryForm.NSetText(Sender: TField; const aText: String);
var
  TheText: String;
begin
  if aText = '-1' then
    Sender.Value := -1
  else
  if aText <> '' then
  begin
    TheText := aText;
    if (TheText[1] = '<') or (TheText[1] = '>') or (TheText[1] = '#') then //delete the limit signs + one blank
      Delete(TheText, 1, 2);
    if AsN then Sender.Value := StrToFloat(TheText)
      else Sender.Value := (StrToFloat(TheText) / ParamFactor[0]) / ChemFactor;
  end;
end;

procedure TChemistryForm.N_AMONIASetText(Sender: TField; const aText: String);
var
  TheText: String;
begin
  if aText = '-1' then
    Sender.Value := -1
  else
  if aText <> '' then
  begin
    TheText := aText;
    if (TheText[1] = '<') or (TheText[1] = '>') or (TheText[1] = '#') then //delete the limit signs + one blank
      Delete(TheText, 1, 2);
    if AsN then Sender.Value := StrToFloat(TheText)
      else Sender.Value := (StrToFloat(TheText) / ParamFactor[2]) / ChemFactor;
  end;
end;

procedure TChemistryForm.DBGridDetKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssAlt in Shift) then
  begin
    if (Key = VK_F8) then ZQuery7.Edit;
  end
  else
  case Key of
    VK_F5: ZQuery7.Refresh;
    VK_F8: if ZQuery7.State IN [dsInsert, dsEdit] then ZQuery7.Post;
    VK_F9: begin
             with TLookupForm.Create(Application) do
             begin
              LookupCategory := 'LIMTTYPE';
              LookupValue := ZQuery7.FieldByName(DBGridDet.SelectedField.FieldName).AsString;
              ShowModal;
              if ModalResult = mrOK then
                if ZQuery7.State IN [dsInsert, dsEdit] then
                  ZQuery7.FieldByName(DBGridDet.SelectedField.FieldName).AsString := LookupValue;
             end;
           end;
  end; {of case}
end;

procedure TChemistryForm.DBGridDetEnter(Sender: TObject);
begin
  if DataModuleMain.BasicinfQuery.State IN [dsInsert, dsEdit] then
  begin
    if MessageDlg('Changes to Basic information have not been posted and will be lost! Post record now?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        DataModuleMain.BasicinfQuery.Post
    else
      DataModuleMain.BasicinfQuery.Cancel;
  end
  else
  if LinkedQuery.State IN [dsInsert, dsEdit] then
  begin
    if MessageDlg('Changes to Sample information have not been posted and will be lost! Post record now?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        LinkedQuery.Post
    else
      LinkedQuery.Cancel;
  end;
  DetailNavigator.DataSource := DataSourceDetect;
  DetailNavigator.VisibleButtons := [nbFirst,nbPrior,nbNext,nbLast,nbInsert,nbDelete,nbEdit,nbPost,nbCancel,nbRefresh];
  DetailNavigator.Width := 262;
  Editing := 'Editing: Detection Limits';
end;

procedure TChemistryForm.UpperSetText(Sender: TField;
  const aText: String);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TChemistryForm.DataSourceDetectDataChange(Sender: TObject;
  Field: TField);
begin
  if ZQuery7.RecordCount > 0 then
    TabSheet6.Caption := '--> Detection Limits'
  else
    TabSheet6.Caption := 'Detection Limits';
end;

procedure TChemistryForm.LabelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then (Sender as TLabel).BeginDrag(False, 10);
end;

procedure TChemistryForm.DATEValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TChemistryForm.TIME_SAMPLValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidTime(Sender.Value);
end;

procedure TChemistryForm.LinkedDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  ZQuery7.Close;
  ZQuery7.Open;
  ZQuery1.Close;
  ZQuery1.Open;
  ZQuery2.Close;
  ZQuery2.Open;
  ZQuery3.Close;
  ZQuery3.Open;
  ZQuery4.Close;
  ZQuery4.Open;
  ZQuery5.Close;
  ZQuery5.Open;
  if DataSource6.Enabled then
  begin
    ZQuery6.Close;
    ZQuery6.Open;
  end;
  DataSource1.AutoEdit := AutoEditGrid and (LinkedQuery.RecordCount > 0);
  DataSource2.AutoEdit := AutoEditGrid and (LinkedQuery.RecordCount > 0);
  DataSource3.AutoEdit := AutoEditGrid and (LinkedQuery.RecordCount > 0);
  DataSource4.AutoEdit := AutoEditGrid and (LinkedQuery.RecordCount > 0);
  DataSource5.AutoEdit := AutoEditGrid and (LinkedQuery.RecordCount > 0);
  DataSource6.AutoEdit := AutoEditGrid and (LinkedQuery.RecordCount > 0);
  DataSourceDetect.AutoEdit := AutoEditGrid and (LinkedQuery.RecordCount > 0);
  if PageControlChemistry.ActivePageIndex = 2 then
    ChemLabel.Caption := 'Parameters [' + ChemUnit + '], bact. [counts/100ml]'
  else
    ChemLabel.Caption := 'Parameters [' + ChemUnit + '] where applicable';
  RecordText.Caption := 'Sample Record ' + IntToStr(LinkedQuery.RecNo) + ' out of ' + IntToStr(LinkedQuery.RecordCount);
  CalcSpeedButton.Enabled := ZQuery1.RecordCount > 0;
  ChemSpeedButton.Enabled := ZQuery1.RecordCount > 0;
end;

procedure TChemistryForm.ECGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
var
  Limit: ShortString;
begin
  Label102.Caption := 'EC [' + ECUnit + ']';
  if ZQuery7.Locate('CPARAMETER', Sender.FieldName, []) then
    Limit := ZQuery7LIMITS.AsString + ' '
  else
    Limit := '';
  if (Sender.Value <> -1) and (not Sender.IsNull) then
  begin
    aText := Limit + FloatToStrF(Sender.AsFloat * ECFactor, ffFixed, 15, 2);
    if DataModuleMain.ClassTable.Active then
    begin
      if DataModuleMain.ClassTable.Locate('PARAMETER', Sender.FieldName, []) then
        DBEditEC.Font := DataModuleMain.GetFont(Sender.Value)
      else DBEditEC.Font := AppFont;
    end
    else
    begin
      if DataModuleMain.StandardTable.Locate('PARAMETER', Sender.FieldName, []) then
        DBEditEC.Font := DataModuleMain.GetFont(Sender.Value)
      else DBEditEC.Font := AppFont;
    end;
  end
  else DisplayText := False;
end;

procedure TChemistryForm.ECSetText(Sender: TField;
  const aText: String);
var
  TheText: String;
begin
  if aText <> '' then
  begin
    TheText := aText;
    if (TheText[1] = '<') or (TheText[1] = '>') or (TheText[1] = '#') then //delete the limit signs + one blank
      Delete(TheText, 1, 2);
    Sender.Value := StrToFloat(TheText) / ECFactor;
  end;
end;

procedure TChemistryForm.DBEditChemKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  InEditMode: Boolean;
begin
  InEditMode := (Sender as TDBEdit).DataSource.Dataset.State IN [dsInsert, dsEdit];
  if ssCtrl in Shift then
  begin
    case Key of
       VK_F1: begin //'<'
                ZQuery7.Insert;
                ZQuery7CPARAMETER.AsString := TDBEdit(Sender).DataField;
                ZQuery7LIMITS.AsString := '<';
                ZQuery7.Post;
              end;
       VK_F2: begin //'>'
                ZQuery7.Insert;
                ZQuery7CPARAMETER.AsString := TDBEdit(Sender).DataField;
                ZQuery7LIMITS.AsString := '>';
                ZQuery7.Post;
              end;
       VK_F3: begin //'#'
                ZQuery7.Insert;
                ZQuery7CPARAMETER.AsString := TDBEdit(Sender).DataField;
                ZQuery7LIMITS.AsString := '#';
                ZQuery7.Post;
              end;
       VK_F8: (Sender as TDBEdit).DataSource.DataSet.Edit
    end; //of case
  end
  else
  if (ssShift in Shift) and (Key = VK_DELETE) then
  begin
    TDBEdit(Sender).DataSource.DataSet.FieldByName(TDBEdit(Sender).DataField).Value := -1;
  end
  else
  case Key of
      VK_F5: (Sender as TDBEdit).DataSource.DataSet.Refresh;
      VK_F8: if InEditMode then (Sender as TDBEdit).DataSource.DataSet.Post;
  VK_ESCAPE: if InEditMode then (Sender as TDBEdit).DataSource.DataSet.Cancel;
  end; {of case}
end;

procedure TChemistryForm.ChemNoFactorGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
var
  Limit: ShortString;
  TheValue: Double;
begin
  if (Sender.Value <> -1) and (not Sender.IsNull) then
  begin
    if ZQuery7.Locate('CPARAMETER', Sender.FieldName, []) then
      Limit := ZQuery7LIMITS.AsString + ' '
    else
      Limit := '';
    TheValue := Sender.AsFloat;
    if Sender is TLargeintField then
      aText := Limit + FloatToStrF(TheValue, ffFixed, 15, 0)
    else
    if Abs(TheValue) = 0 then
      aText := Limit + FloatToStrF(TheValue, ffFixed, 15, 2)
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
    if DataModuleMain.ClassTable.Active then
    begin
      if DataModuleMain.ClassTable.Locate('PARAMETER', Sender.FieldName, []) then
        (FindComponent('DBEdit' + Sender.FieldName) as TDBEdit).Font := DataModuleMain.GetFont(Sender.Value)
      else
      if Sender.FieldName = 'PH' then
      begin
        if Sender.Value >= 7 then
        begin
          DataModuleMain.ClassTable.Locate('PARAMETER', 'PHU', []);
          DBEditPH.Font := DataModuleMain.GetFont(Sender.Value);
        end
        else
        begin
          DataModuleMain.ClassTable.Locate('PARAMETER', 'PHL', []);
          DBEditPH.Font := DataModuleMain.GetFont(-Sender.Value);
        end;
      end
      else
        (FindComponent('DBEdit' + Sender.FieldName) as TDBEdit).Font := AppFont;
    end
    else
    begin
      if DataModuleMain.StandardTable.Locate('PARAMETER', Sender.FieldName, []) then
        (FindComponent('DBEdit' + Sender.FieldName) as TDBEdit).Font := DataModuleMain.GetFont(Sender.Value)
      else
        (FindComponent('DBEdit' + Sender.FieldName) as TDBEdit).Font := AppFont;
    end;
  end
  else DisplayText := False;
end;

procedure TChemistryForm.ChemQuerySetText(Sender: TField;
  const aText: String);
var
  TheText: String;
begin
  if aText <> '' then
  begin
    TheText := aText;
    if (TheText[1] = '<') or (TheText[1] = '>') or (TheText[1] = '#') then //delete the limit signs + one blank
      Delete(TheText, 1, 2);
    Sender.Value := StrToFloat(TheText) / ChemFactor;
  end;
end;

procedure TChemistryForm.BitBtnHelpClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TChemistryForm.CloseBitBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TChemistryForm.ZQuery1AfterPost(DataSet: TDataSet);
begin
  CalcSpeedButton.Enabled := True;
end;

procedure TChemistryForm.ZQuery7BeforeOpen(DataSet: TDataSet);
begin
  with DataSet as TZQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM deteclim WHERE CHM_REF_NR = ' + IntToStr(LinkedQueryCHM_REF_NR.AsInteger));
  end;
end;

procedure TChemistryForm.ZQueryBeforeOpen(DataSet: TDataSet);
begin
  with DataSet as TZQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM chem_00' + IntToStr(Tag) + ' WHERE CHM_REF_NR = ' + IntToStr(LinkedQueryCHM_REF_NR.AsInteger));
  end;
end;

procedure TChemistryForm.ZQuery1CalcFields(DataSet: TDataSet);
var
  SumTDS, sumCations, sumAnions, THardness, Carbonates, TAlk: Real;
  pK, pCa, pAlk: Real;
  UseTAlk: Boolean;
begin
  pK := 0;
  //Hardness
  if ZQuery1PH.Value < 9 then
  begin
    if ZQuery1HCO3.Value > -1 then
      Carbonates := ZQuery1HCO3.Value
    else
    if ZQuery1MALK.Value > -1 then
      Carbonates := ZQuery1MALK.Value / 0.8202
    else Carbonates := 0;
  end
  else
  begin
    if (ZQuery1HCO3.Value > -1) and (ZQuery1CO3.Value > -1) then
      Carbonates := ZQuery1HCO3.Value + ZQuery1CO3.Value
    else
    if ZQuery1MALK.Value > - 1 then
      Carbonates := ZQuery1MALK.Value / 0.8202
    else Carbonates := 0;
  end;
  //Total TDS
  SumTDS := 0;
  if ZQuery1CA.Value > - 1 then
    SumTDS := SumTDS + ZQuery1CA.Value;
  if ZQuery1MG.Value > - 1 then
    SumTDS := SumTDS + ZQuery1MG.Value;
  if ZQuery1NA.Value > - 1 then
    SumTDS := SumTDS + ZQuery1NA.Value;
  if ZQuery1K.Value > - 1 then
    SumTDS := SumTDS + ZQuery1K.Value;
  if ZQuery1CA.Value > - 1 then
    SumTDS := SumTDS + ZQuery1CA.Value;
  if ZQuery1CL.Value > - 1 then
    SumTDS := SumTDS + ZQuery1CL.Value;
  if ZQuery1SO4.Value > - 1 then
    SumTDS := SumTDS + ZQuery1SO4.Value;
  if ZQuery1N.Value > - 1 then
    SumTDS := SumTDS + ZQuery1N.Value * 4.4263724;
  if ZQuery1F.Value > - 1 then
    SumTDS := SumTDS + ZQuery1F.Value;
  if ZQuery1SI.Value > - 1 then
    SumTDS := SumTDS + ZQuery1SI.Value * 2.1393;
  if ZQuery1FE.Value > - 1 then
    SumTDS := SumTDS + ZQuery1FE.Value;
  if ZQuery1MN.Value > - 1 then
    SumTDS := SumTDS + ZQuery1MN.Value;
  SumTDS := SumTDS + Carbonates;
  if SumTDS > 0 then ZQuery1SumTDS.Value := SumTDS;
  //TDS EC * 7
  if ZQuery1EC.Value > 0 then ZQuery1TDS7.Value := ZQuery1EC.Value * 7;
  {Ion Balance}
  sumCations := 0; //<--Cations from here
  if ZQuery1CA.Value > -1 then
    sumCations := sumCations + ZQuery1CA.Value * CParam[0];
  if ZQuery1MG.Value > -1 then
    sumCations := sumCations + ZQuery1MG.Value * CParam[1];
  if ZQuery1NA.Value > -1 then
    sumCations := sumCations + ZQuery1NA.Value * CParam[2];
  if ZQuery1K.Value > -1 then
    sumCations := sumCations + ZQuery1K.Value * CParam[3];
  if ZQuery1FE.Value > -1 then
    sumCations := sumCations + ZQuery1FE.Value * CParam[13];
  if ZQuery1MN.Value > -1 then
    sumCations := sumCations + ZQuery1MN.Value * CParam[14];
  sumAnions := 0; //<--Anions from here
  if ZQuery1HCO3.Value > -1 then
  begin
    sumAnions := sumAnions + ZQuery1HCO3.Value * CParam[4];
    if ZQuery1CO3.Value > -1 then
      sumAnions := sumAnions + ZQuery1CO3.Value * CParam[9];
  end
  else
  if ZQuery1MALK.Value > -1 then
    sumAnions := sumAnions + ZQuery1MALK.Value / 50;
  if ZQuery1CL.Value > -1 then
    sumAnions := sumAnions + ZQuery1CL.Value * CParam[5];
  if ZQuery1SO4.Value > -1 then
    sumAnions := sumAnions + ZQuery1SO4.Value * CParam[6];
  if ZQuery1N.Value > -1 then
    sumAnions := sumAnions + ZQuery1N.Value * CParam[7];
  if ZQuery1F.Value > -1 then
    sumAnions := sumAnions + ZQuery1F.Value * CParam[8];
  if ZQuery1SI.Value > -1 then
    sumAnions := sumAnions + ZQuery1SI.Value * CParam[12];
  if sumCations > 0 then ZQuery1Cations.Value := sumCations;
  if SumAnions > 0 then ZQuery1Anions.Value := sumAnions;
  if (sumCations + sumAnions) > 0 then ZQuery1BError.Value :=
    (sumCations - sumAnions) * 100 /(sumCations + sumAnions);
  {Total Hardness}
  THardness := (ZQuery1CA.Value * CParam[0] + ZQuery1MG.Value
    * CParam[1]) * 50;
  if THardness > 0 then ZQuery1THard.Value := THardness;
  {Determine use of TAlk}
  UseTAlk := (ZQuery1HCO3.Value > -1) and (ZQuery1CO3.Value > -1);
  if UseTAlk then TAlk := (ZQuery1HCO3.Value * CParam[4] + ZQuery1CO3.Value * CParam[9]) * 50;
  {Carbonate Hardness}
  if UseTAlk and (THardness > 0) then
  begin
    if TAlk <= THardness then ZQuery1CaHard.Value := TAlk
    else if TAlk > THardness then ZQuery1CaHard.Value := THardness;
  end
  else
  if (ZQuery1MALK.Value > -1) and (THardness > 0) then
  begin
    if ZQuery1MALK.Value <= THardness then ZQuery1CaHard.Value := ZQuery1MALK.Value
    else if ZQuery1MALK.Value > THardness then ZQuery1CaHard.Value := THardness;
  end;
  {Magnesium Hardness}
  if ZQuery1MG.Value > 0 then ZQuery1MGHard.Value := ZQuery1MG.Value * 4.116;
  {Aggressive index}
  if UseTAlk then
  begin
    if (TAlk * ZQuery1CA.Value * CParam[0] * 50) > 0 then
      ZQuery1Aggressive.Value := ZQuery1PH.Value + Log10(TAlk * ZQuery1CA.Value * CParam[0] * 50);
  end
  else
  begin
    if (ZQuery1MALK.Value * ZQuery1CA.Value * CParam[0] * 50) > 0 then
    ZQuery1Aggressive.Value := ZQuery1PH.Value + Log10(ZQuery1MALK.Value
      * ZQuery1CA.Value * CParam[0] * 50);
  end;
  {Langelier}
  if SumTDS > 0 then pK := 1.6972 * Power(SumTDS, 0.0516);
  if UseTAlk and (TAlk > 0) and (ZQuery1CA.Value > 0) then
  begin
    pCa := - Log10(ZQuery1CA.Value * CParam[0]/2000);
    pAlk := - Log10(TAlk/50000);
    ZQuery1Langelier.Value := ZQuery1PH.Value - (pK + pCa + pAlk);
  end
  else
  if (ZQuery1CA.Value > 0) and (ZQuery1MALK.Value > 0) then
  begin
    pCa := - Log10(ZQuery1CA.Value * CParam[0]/2000);
    pAlk := - Log10(ZQuery1MALK.Value/50000);
    ZQuery1Langelier.Value := ZQuery1PH.Value - (pK + pCa + pAlk);
  end;
  {Corrosion Tendency}
  if UseTAlk and (TAlk > 0) and (ZQuery1CL.Value > 0) and (ZQuery1SO4.Value > 0) then
    ZQuery1Corrosion.Value := (ZQuery1CL.Value  * CParam[5] + ZQuery1SO4.Value  * CParam[6])
      / (TAlk / 50)
  else
  if (ZQuery1MALK.Value > 0) and (ZQuery1CL.Value > 0) and (ZQuery1SO4.Value > 0) then
    ZQuery1Corrosion.Value := (ZQuery1CL.Value  * CParam[5] + ZQuery1SO4.Value  * CParam[6])
      / (ZQuery1MALK.Value / 50);
  {SAR}
  if (ZQuery1NA.Value > 0) and (ZQuery1CA.Value > 0) and (ZQuery1MG.Value > 0) then
    ZQuery1SAR.Value := (ZQuery1NA.Value * CParam[2]) /
      SQRT((ZQuery1CA.Value * CParam[0] + ZQuery1MG.Value * CParam[1]) / 2)
end;

procedure TChemistryForm.ZQuery1CalcsGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if (Sender.Value <> -1) and (not Sender.IsNull) then
  begin
    if (Abs(Sender.AsFloat) > 0) and (Abs(Sender.AsFloat) < 0.1) then
      aText := FloatToStrF(Sender.AsFloat * ChemFactor, ffFixed, 15, 5)
    else
    if (Abs(Sender.AsFloat) >= 0.1) and (Abs(Sender.AsFloat) < 1) then
      aText := FloatToStrF(Sender.AsFloat * ChemFactor, ffFixed, 15, 3)
    else
    if (Abs(Sender.AsFloat) >=1) and (Abs(Sender.AsFloat) < 1000) then
      aText := FloatToStrF(Sender.AsFloat * ChemFactor, ffFixed, 15, 2)
    else
    if (Abs(Sender.AsFloat) >=1000) and (Abs(Sender.AsFloat) < 10000) then
      aText := FloatToStrF(Sender.AsFloat * ChemFactor, ffFixed, 15, 1)
    else
      aText := FloatToStrF(Sender.AsFloat * ChemFactor, ffFixed, 15, 0);
  end;
end;

procedure TChemistryForm.ZQuery1THardGetText(Sender: TField; var aText: string;
  DisplayText: Boolean);
begin
  if (Sender.Value <> -1) and (not Sender.IsNull) then
  begin
    if (Abs(Sender.AsFloat) > 0) and (Abs(Sender.AsFloat) < 0.1) then
      aText := FloatToStrF(Sender.AsFloat * ChemFactor, ffFixed, 15, 5)
    else
    if (Abs(Sender.AsFloat) >= 0.1) and (Abs(Sender.AsFloat) < 1) then
      aText := FloatToStrF(Sender.AsFloat * ChemFactor, ffFixed, 15, 3)
    else
    if (Abs(Sender.AsFloat) >=1) and (Abs(Sender.AsFloat) < 1000) then
      aText := FloatToStrF(Sender.AsFloat * ChemFactor, ffFixed, 15, 2)
    else
    if (Abs(Sender.AsFloat) >=1000) and (Abs(Sender.AsFloat) < 10000) then
      aText := FloatToStrF(Sender.AsFloat * ChemFactor, ffFixed, 15, 1)
    else aText := FloatToStrF(Sender.AsFloat * ChemFactor, ffFixed, 15, 0);
    if CalcParamForm <> NIL then
    begin
      if DataModuleMain.ClassTable.Active then
      begin
        if DataModuleMain.ClassTable.Locate('PARAMETER', 'TOTHARD', []) then
          CalcParamForm.THARDDBText.Font := DataModuleMain.GetFont(Sender.Value)
        else
          CalcParamForm.THARDDBText.Font := AppFont;
      end
      else
      begin
        if DataModuleMain.StandardTable.Locate('PARAMETER', 'TOTHARD', []) then
          CalcParamForm.THARDDBText.Font := DataModuleMain.GetFont(Sender.Value)
        else
          CalcParamForm.THARDDBText.Font := AppFont;
      end;
    end;
  end
  else DisplayText := False;
end;

procedure TChemistryForm.ZQuery2NO2GetText(Sender: TField; var aText: string;
  DisplayText: Boolean);
var
  Limit: ShortString;
  TheValue: Double;
begin
  if (Sender.Value > -1) and (not Sender.IsNull) then
  begin
    if ZQuery7.Locate('CPARAMETER', Sender.FieldName, []) then
      Limit := ZQuery7LIMITS.AsString + ' '
    else
      Limit := '';
    if AsN then
    begin
      TheValue := Sender.AsFloat * ParamFactor[1] * ChemFactor;
      Label214.Caption := 'NO2 as N';
    end
    else
    begin
      TheValue := Sender.AsFloat * ChemFactor;
      Label214.Caption := 'NO2';
    end;
    if (Abs(TheValue) > 0) and (Abs(TheValue) < 0.0001) then
      aText := Limit + FloatToStrF(TheValue, ffFixed, 15, 5)
    else
    aText := Limit + DataModuleMain.FormatTheFloat(TheValue);
    if DataModuleMain.ClassTable.Active then
    begin
      if DataModuleMain.ClassTable.Locate('PARAMETER', 'NO2', []) then
        DBEditNO2.Font := DataModuleMain.GetFont(Sender.Value)
      else DBEditNO2.Font := AppFont;
    end
    else
    begin
      if DataModuleMain.StandardTable.Locate('PARAMETER', 'NO2', []) then
        DBEditNO2.Font := DataModuleMain.GetFont(Sender.Value)
      else DBEditNO2.Font := AppFont;
    end;
  end
  else DisplayText := False;
end;

procedure TChemistryForm.ZQuery2NO2SetText(Sender: TField; const aText: string);
var
  TheText: String;
begin
  if aText = '-1' then
    Sender.Value := -1
  else
  if aText <> '' then
  begin
    TheText := aText;
    if (TheText[1] = '<') or (TheText[1] = '>') or (TheText[1] = '#') then //delete the limit signs + one blank
      Delete(TheText, 1, 2);
    if AsN then Sender.Value := (StrToFloat(TheText) / ParamFactor[1]) / ChemFactor
      else Sender.Value := StrToFloat(TheText);
  end;
end;

procedure TChemistryForm.ZQuery2PO4GetText(Sender: TField; var aText: string;
  DisplayText: Boolean);
var
  Limit: ShortString;
  TheValue: Double;
begin
  if (Sender.Value > -1) and (not Sender.IsNull) then
  begin
    if ZQuery7.Locate('CPARAMETER', Sender.FieldName, []) then
      Limit := ZQuery7LIMITS.AsString + ' '
    else
      Limit := '';
    if AsN then
    begin
      TheValue := Sender.AsFloat * ParamFactor[3] * ChemFactor;
      Label216.Caption := 'PO4 as P';
    end
    else
    begin
      TheValue := Sender.AsFloat * ChemFactor;
      Label216.Caption := 'PO4';
    end;
    aText := Limit + DataModuleMain.FormatTheFloat(TheValue);
    if DataModuleMain.ClassTable.Active then
    begin
      if DataModuleMain.ClassTable.Locate('PARAMETER', 'PO4', []) then
        DBEditPO4.Font := DataModuleMain.GetFont(Sender.Value)
      else DBEditPO4.Font := AppFont;
    end
    else
    begin
      if DataModuleMain.StandardTable.Locate('PARAMETER', 'PO4', []) then
        DBEditPO4.Font := DataModuleMain.GetFont(Sender.Value)
      else DBEditPO4.Font := AppFont;
    end;
  end
  else DisplayText := False;
end;

procedure TChemistryForm.ZQuery2PO4SetText(Sender: TField; const aText: string);
var
  TheText: String;
begin
  if aText = '-1' then
    Sender.Value := -1
  else
  if aText <> '' then
  begin
    TheText := aText;
    if (TheText[1] = '<') or (TheText[1] = '>') or (TheText[1] = '#') then //delete the limit signs + one blank
      Delete(TheText, 1, 2);
    if AsN then Sender.Value := (StrToFloat(TheText) / ParamFactor[3]) / ChemFactor
    else
      Sender.Value := StrToFloat(TheText);
  end;
end;

procedure TChemistryForm.ZQuery6PARAMGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
var
  Limit: ShortString;
begin
  if ZQuery7.Locate('CPARAMETER', Sender.FieldName, []) then
    Limit := ZQuery7LIMITS.AsString + ' '
  else
    Limit := '';
  if (not Sender.IsNull) and (Sender.Value <> -1) then
  begin
    if (Abs(Sender.AsFloat) = 0) then
      aText := Limit + FloatToStrF(Sender.AsFloat, ffFixed, 15, 2)
    else
    if (Abs(Sender.AsFloat) > 0) and (Abs(Sender.AsFloat) < 0.0001) then
      aText := Limit + FloatToStrF(Sender.AsFloat, ffFixed, 15, 7)
    else
    if (Abs(Sender.AsFloat) >= 0.0001) and (Abs(Sender.AsFloat) < 0.1) then
      aText := Limit + FloatToStrF(Sender.AsFloat, ffFixed, 15, 5)
    else
    if (Abs(Sender.AsFloat) >= 0.1) and (Abs(Sender.AsFloat) < 1) then
      aText := Limit + FloatToStrF(Sender.AsFloat, ffFixed, 15, 3)
    else
    if (Abs(Sender.AsFloat) >= 1) and (Abs(Sender.AsFloat) < 1000) then
      aText := Limit + FloatToStrF(Sender.AsFloat, ffFixed, 15, 2)
    else
    if (Abs(Sender.AsFloat) >= 1000) and (Abs(Sender.AsFloat) < 10000) then
      aText := Limit + FloatToStrF(Sender.AsFloat, ffFixed, 15, 1)
    else aText := Limit + FloatToStrF(Sender.AsFloat, ffFixed, 15, 0);
  end
  else
    DisplayText := False;
end;

procedure TChemistryForm.ZQuery7LIMITSValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('LIMTTYPE', Sender.AsString);
end;

procedure TChemistryForm.ZQuery7NewRecord(DataSet: TDataSet);
begin
  ZQuery7CPARAMETER.Value := CurrentPar;
end;

procedure TChemistryForm.ZQuery7SetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TChemistryForm.ZQueryPostError(DataSet: TDataSet; E: EDatabaseError;
  var DataAction: TDataAction);
begin
  ShowMessage(E.Message + '. Record will not be posted!');
  DataAction := daAbort;
end;

procedure TChemistryForm.DBGridMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  TheCategory: ShortString;
begin
  if Button = mbRight then
  begin
    case DBGrid.SelectedField.Tag of
      1: TheCategory := 'SAMPTYPE';
      2: TheCategory := 'METHSAMP';
    else exit;
    end; {of CASE}
    with TLookupForm.Create(Application) do
    begin
      LookupCategory := TheCategory;
      LookupValue := LinkedQuery.FieldByName(DBGrid.SelectedField.FieldName).AsString;
      ShowModal;
      if ModalResult = mrOK then
      if LinkedQuery.State IN [dsInsert, dsEdit] then
        LinkedQuery.FieldByName(DBGrid.SelectedField.FieldName).AsString := LookupValue;
      Close;
    end;
  end;
end;

procedure TChemistryForm.DBGridMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  TDBGrid(Sender).MouseToCell(X, Y, col, row);
end;

procedure TChemistryForm.DBGridTitleClick(Column: TColumn);
var c: Integer;
begin
  if JumpFieldNr = 0 then
  begin
    Column.Color := clBtnFace;
    JumpFieldNr := Column.Field.Index;
  end
  else
  begin
    for c := 0 to DBGrid.Columns.Count - 1 do //reset all to white
      DBGrid.Columns[c].Color := clWindow;
    if Column.Field.Index <> JumpFieldNr then //set to grey
    begin
      Column.Color := clBtnFace;
      JumpFieldNr := Column.Field.Index;
    end
    else JumpFieldNr := 0;
  end;
end;

procedure TChemistryForm.DetailNavigatorClick(Sender: TObject;
  Button: TDBNavButtonType);
begin
  if DetailNavigator.DataSource = LinkedDataSource then
  try
    case Button of
      nbNext: LinkedQuery.MoveBy(StrToInt(EditResults.Text) - 1); //it moves 1 anyway
      nbPrior: begin
                 if LinkedQuery.RecNo <= StrToInt(EditResults.Text) + 1 then
                   LinkedQuery.First
                 else
                   LinkedQuery.RecNo := LinkedQuery.RecNo - StrToInt(EditResults.Text) + 1; //it moves 1 anyway
               end;
    end; //of case
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TChemistryForm.DetectionTablePostError(DataSet: TDataSet;
  E: EDatabaseError; var DataAction: TDataAction);
begin
  ShowMessage(E.Message + '. Record will not be posted!');
  DataAction := daAbort;
end;

procedure TChemistryForm.BasicinfNavigatorClick(Sender: TObject;
  Button: TDBNavButtonType);
begin
  if TheActiveDBEdit <> NIL then
    TheActiveDBEdit.SetFocus
  else
  if TheActiveRxDB <> NIL then
    TheActiveRxDB.SetFocus;
end;

procedure TChemistryForm.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssShift in Shift) and (Key = VK_Delete)
    and (BasicinfDataSource.DataSet.State in [dsEdit, dsInsert]) then
      BasicinfDataSource.DataSet.FindField((Sender as TDBEdit).DataField).Clear;
end;

procedure TChemistryForm.EditResultsEditingDone(Sender: TObject);
begin
  LinkedQuery.FetchRow := StrToInt(EditResults.Text);
  LinkedQuery.Refresh;
end;

procedure TChemistryForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
var
  z: Byte;
begin
  if BasicinfDataSource.DataSet.State = dsEdit then
    case MessageDlg('Your Basic Information has not been posted. Do you want to post it now and close or continue editing?', mtWarning, [mbYes, mbNo, mbIgnore], 0) of
      mrYes: begin
               BasicinfDataSource.DataSet.Post;
               CanClose := True;
             end;
       mrNo: CanClose := False;
   mrIgnore: begin
               BasicinfDataSource.DataSet.Cancel;
               CanClose := True;
             end;
    end; //of case
  if LinkedDataSource.DataSet.State IN [dsInsert, dsEdit] then
    case MessageDlg('Your Sample Information has not been posted. Do you want to post it now and close or continue editing?', mtWarning, [mbYes, mbNo, mbIgnore], 0) of
      mrYes: begin
               LinkedDataSource.DataSet.Post;
               CanClose := True;
             end;
       mrNo: CanClose := False;
   mrIgnore: begin
               LinkedDataSource.DataSet.Cancel;
               CanClose := True;
             end;
    end; //of case
  for z := 1 to 7 do
  with FindComponent('ZQuery' + IntToStr(z)) as TZQuery do
  if State IN [dsInsert, dsEdit] then
    case MessageDlg('Your Chemistry Information has not been posted. Do you want to post it now and close or continue editing?', mtWarning, [mbYes, mbNo, mbIgnore], 0) of
      mrYes: begin
               Post;
               CanClose := True;
             end;
       mrNo: CanClose := False;
   mrIgnore: begin
               Cancel;
               CanClose := True;
             end;
    end; //of case
end;

procedure TChemistryForm.BasicinfDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  CurrentSite := DataModuleMain.BasicinfQuerySITE_ID_NR.Value;
  if Showing then
  try
    Screen.Cursor := crSQLWait;
    LinkedQuery.Close;
    LinkedQuery.Open;
    Screen.Cursor := crDefault;
  except on E: Exception do
    begin
      Screen.Cursor := crDefault;
      MessageDlg(E.Message + ' - Could not open linked table! Maybe close and open the form again.', mtError, [mbOK], 0);
    end;
  end
  else
  begin
    //Set the edit mask of coordinate DBEdits
    if ShowDMS then
    begin
      DBEditX.EditMask := '900°00''00.00">L;1;_';
      DBEditY.EditMask := '00°00''00.00">L;1;_'
    end
    else
    begin
      DBEditX.EditMask := '';
      DBEditY.EditMask := '';
    end;
  end;
  //Set Labels and formats of coordinate edits if coordinate system has changed
  if dstLO then
  begin
    X_CoordLabel.Caption := XLabel + ' [' + LengthUnit + ']';
    Y_CoordLabel.Caption := YLabel + ' [' + LengthUnit + ']';
  end
  else
  if dstLatLong then //is lat/long
  begin
    if ShowDMS then //show Degrees, minutes, seconds
    begin
      X_CoordLabel.Caption := LongLabel + ' [° '' "]';
      Y_CoordLabel.Caption := LatLabel + ' [° '' "]';
    end
    else
    begin
      X_CoordLabel.Caption := LongLabel + ' [°]';
      Y_CoordLabel.Caption := LatLabel + ' [°]';
    end;
  end
  else
  begin
    X_CoordLabel.Caption := EastLabel + ' [' + LengthUnit + ']';
    Y_CoordLabel.Caption := NorthLabel + ' [' + LengthUnit + ']';
  end;
  X_CoordLabel.Width := 88;
  Y_CoordLabel.Width := 88;
  //check if current site's geometry has changed
  with DataModuleMain.CheckQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT NGDB_FLAG FROM basicinf WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
    Open;
    if FieldByName('NGDB_FLAG').Value = 9 then //convert LONGITUDE/LATITUDE to X_COORD/Y_COORD
    if Showing and (MessageDlg('The geometry of the current site has changed. Do you want to update the coordinates in the database accordingly?', mtInformation, [mbYes, mbNo], 0) = mrYes) then
    begin
      try
        Screen.Cursor := crSQLWait;
        with DataModuleMain do
          UpdateCoordsWithCs2cs(BasicinfQueryLONGITUDE.AsString, BasicinfQueryLATITUDE.AsString, BasicinfQuerySITE_ID_NR.AsString);
        DataModuleMain.BasicinfQuery.Refresh;
      finally
        Screen.Cursor := crDefault;
      end;
      ShowMessage('Site coordinates were updated from a changed geometry!');
    end;
    Close;
    SQL.Clear;
  end;
  EditCOLLAR_HI.Enabled := (DataModuleMain.BasicinfQuerySITE_TYPE.Value = 'B')
    or (DataModuleMain.BasicinfQuerySITE_TYPE.Value = 'D')
    or (DataModuleMain.BasicinfQuerySITE_TYPE.Value = 'W');
  EditDEPTH.Enabled := EditCOLLAR_HI.Enabled;
  Screen.Cursor := crDefault;
end;

procedure TChemistryForm.EditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssShift in Shift) and (Key in [37, 39]) then //something selected with left/right keys
  begin
    CanPaste := False;
    if Sender is TDBEdit then
    begin
      HasSelection := (Sender as TDBEdit).SelLength > 0;
      if BasicinfDataSource.DataSet.State IN [dsEdit, dsInsert] then
      begin
        CanCut := HasSelection;
        CanPaste := True;
      end;
    end;
  end;
end;

procedure TChemistryForm.EditClick(Sender: TObject);
begin
  CanPaste := False;
  if Sender is TDBEdit then
  begin
    HasSelection := (Sender as TDBEdit).SelLength > 0;
    if BasicinfDataSource.DataSet.State IN [dsEdit, dsInsert] then
    begin
      CanCut := HasSelection;
      CanPaste := True;
    end;
  end;
end;

procedure TChemistryForm.DBEditYChange(Sender: TObject);
begin
  //Set the edit mask of coordinate DBEdits
  if ShowDMS then
    (Sender as TDBEdit).EditMask := '00°00''00.00">L;1;_'
  else
    (Sender as TDBEdit).EditMask := '';
end;

procedure TChemistryForm.DBGridColExit(Sender: TObject);
begin
  if DBGrid.Focused and (not ValidFound) then
  begin
    if DBGrid.SelectedField.FieldName = 'DEPTH_SAMP' then
      MessageDlg('Depth sampled must be less than depth of hole! Press <ENTER> or click the cell to enter a valid value.', mtError, [mbOK], 0)
    else
    if Pos('DATE', DBGrid.SelectedField.FieldName) > 0 then
      MessageDlg('Invalid date entered! Press <ENTER> or click the cell to enter a valid date (YYYYMMDD).', mtError, [mbOK], 0)
    else
    if Pos('TIME', DBGrid.SelectedField.FieldName) > 0 then
      MessageDlg('Invalid time entered! Press <ENTER> or click the cell to enter a valid time (HHMM).', mtError, [mbOK], 0)
    else
      MessageDlg('"' + DBGrid.SelectedField.AsString + '" is an invalid code for "' + DBGrid.SelectedColumn.Title.Caption + '"! Press <ENTER> or click the cell to enter a valid lookup code. Alternatively press <F9>, select a lookup code and then <ENTER> to continue editing.', mtError, [mbOK], 0);
    DBGrid.SelectedField.Clear;
    ValidFound := True;
    Abort;
  end;
end;

procedure TChemistryForm.DBGridDetColExit(Sender: TObject);
begin
  if DBGridDet.Focused and (not ValidFound) then
  begin
    MessageDlg('"' + DBGridDet.SelectedField.AsString + '" is an invalid code for "' + DBGridDet.SelectedColumn.Title.Caption + '"!', mtError, [mbOK], 0);
    if DBGridDet.SelectedField.LookupKeyFields > '' then
      DBGridDet.SelectedField.Clear;
    ValidFound := True;
    Abort;
  end;
end;

procedure TChemistryForm.DBGridDetGetCellHint(Sender: TObject; Column: TColumn;
  var AText: String);
begin
  //use the LookupKeyFields property for the code translation, which is not used otherwise
  if (col > 0) and (Column.Field.LookupKeyFields > '') then
  begin
    AText := DataModuleMain.TranslateCode(Column.Field.LookupKeyFields, Column.Field.AsString);
    (Sender as TDBGrid).ShowHint := True;
  end
  else
  begin
    AText := 'Detection Limit Information';
    (Sender as TDBGrid).ShowHint := False;
  end;
end;

procedure TChemistryForm.DBGridDetMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DBGridDetEnter(Sender);
  if Button = mbRight then
  begin
    with TLookupForm.Create(Application) do
    begin
     LookupCategory := 'LIMTTYPE';
     LookupValue := ZQuery7.FieldByName(DBGridDet.SelectedField.FieldName).AsString;
     ShowModal;
     if ModalResult = mrOK then
       if ZQuery7.State IN [dsInsert, dsEdit] then
         ZQuery7.FieldByName(DBGridDet.SelectedField.FieldName).AsString := LookupValue;
    end;
  end;
end;

procedure TChemistryForm.DBGridDetMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  TDBGrid(Sender).MouseToCell(X, Y, col, row);
end;

procedure TChemistryForm.DBGridDetTitleClick(Column: TColumn);
var c: Integer;
begin
  if JumpFieldNr = 0 then
  begin
    Column.Color := clBtnFace;
    JumpFieldNr := Column.Field.Index;
  end
  else
  begin
    for c := 0 to DBGridDet.Columns.Count - 1 do //reset all to white
      DBGridDet.Columns[c].Color := clWindow;
    if Column.Field.Index <> JumpFieldNr then //set to grey
    begin
      Column.Color := clBtnFace;
      JumpFieldNr := Column.Field.Index;
    end
    else JumpFieldNr := 0;
  end;
end;

procedure TChemistryForm.DBGridGetCellHint(Sender: TObject; Column: TColumn;
  var AText: String);
begin
  //use the LookupKeyFields property for the code translation, which is not used otherwise
  if (col > 0) and (Column.Field.LookupKeyFields > '') then
  begin
    AText := DataModuleMain.TranslateCode(Column.Field.LookupKeyFields, Column.Field.AsString);
    (Sender as TDBGrid).ShowHint := True;
  end
  else
  begin
    AText := 'Chemistry Sample Information';
    (Sender as TDBGrid).ShowHint := False;
  end;
end;

end.
