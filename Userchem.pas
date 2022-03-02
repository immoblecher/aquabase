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
unit Userchem;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Clipbrd, ZDataset,
  StdCtrls, Forms, DBCtrls, DB, DBGrids, ExtCtrls, LCLType,
  Buttons, Menus, Dialogs, ComCtrls, XMLPropStorage, Fileutil, rxlookup;

type

  { TUserChemistryForm }

  TUserChemistryForm = class(TForm)
    AccuDataSource: TDataSource;
    DBEditX: TDBEdit;
    DBEditY: TDBEdit;
    DBGrid: TDBGrid;
    DefTableDESCRIPTION: TStringField;
    DetailNavigator: TDBNavigator;
    EditResults: TEdit;
    GotoBookmark: TMenuItem;
    GraphSpeedButton: TSpeedButton;
    MenuItemSetBookmark1: TMenuItem;
    MenuItemSetBookMark2: TMenuItem;
    MenuItemDelete: TMenuItem;
    MenuItemGotoBookmark1: TMenuItem;
    MenuItemGotoBookmark2: TMenuItem;
    MenuItemSetBookmarks: TMenuItem;
    DBNavigatorView: TDBNavigator;
    Panel1: TPanel;
    BasicinfDataSource: TDataSource;
    Panel2: TPanel;
    Panel3: TPanel;
    LinkedDataSource: TDataSource;
    CloseBitBtn: TBitBtn;
    BitBtnHelp: TBitBtn;
    LinkedQuery: TZQuery;
    LinkedQuerySITE_ID_NR: TStringField;
    LinkedQuerySAMPLE_NR: TStringField;
    LinkedQueryDATE_SAMPL: TStringField;
    LinkedQueryTIME_SAMPL: TStringField;
    LinkedQueryMETH_SAMPL: TStringField;
    LinkedQueryALT_NR_1: TStringField;
    LinkedQueryALT_NR_2: TStringField;
    LinkedQueryALT_NR_3: TStringField;
    LinkedQueryALT_NR_4: TStringField;
    LinkedQueryTIME_PUMP: TSmallintField;
    LinkedQueryDEPTH_SAMP: TFloatField;
    LinkedQueryDATE_ANAL: TStringField;
    LinkedQueryLAB: TStringField;
    LinkedQueryCOMMENT: TStringField;
    LinkedQueryCHM_REF_NR: TFloatField;
    EditNavigator: TDBNavigator;
    PopupMenu1: TPopupMenu;
    RecordText: TStaticText;
    RxDBLookupComboAcc: TRxDBLookupCombo;
    RxDBLookupComboType: TRxDBLookupCombo;
    StandardLabel: TLabel;
    ChemStandardLabel: TLabel;
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
    StaticText1: TStaticText;
    TypeDataSource: TDataSource;
    XMLPropStorage: TXMLPropStorage;
    Y_CoordLabel: TLabel;
    X_CoordLabel: TLabel;
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
    LinkedQuerySAMPL_TYPE: TStringField;
    SamplesLabel: TLabel;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    ParameterTabSheet: TTabSheet;
    TabSheet3: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    DBEdit20: TDBEdit;
    DBEdit21: TDBEdit;
    DBGrid2: TDBGrid;
    DBGridDet: TDBGrid;
    ZQuery1: TZQuery;
    ZQuery1CHM_REF_NR: TFloatField;
    ZQuery1PH: TFloatField;
    ZQuery1EC: TFloatField;
    ZQuery1TDS: TFloatField;
    ZQuery1CA: TFloatField;
    ZQuery1MG: TFloatField;
    ZQuery1NA: TFloatField;
    ZQuery1K: TFloatField;
    ZQuery1SI: TFloatField;
    ZQuery1PALK: TFloatField;
    ZQuery1MALK: TFloatField;
    ZQuery1MACID: TFloatField;
    ZQuery1PACID: TFloatField;
    ZQuery1CL: TFloatField;
    ZQuery1SO4: TFloatField;
    ZQuery1N: TFloatField;
    ZQuery1F: TFloatField;
    ZQuery1CO3: TFloatField;
    ZQuery1HCO3: TFloatField;
    ZQuery1AL: TFloatField;
    ZQuery1FE: TFloatField;
    ZQuery1MN: TFloatField;
    DataSource1: TDataSource;
    ZQuery2: TZQuery;
    ZQuery2CHM_REF_NR: TFloatField;
    ZQuery2N_AMONIA: TFloatField;
    ZQuery2NO2: TFloatField;
    ZQuery2PO4: TFloatField;
    ZQuery2SULF: TFloatField;
    ZQuery2CN: TFloatField;
    ZQuery2B: TFloatField;
    ZQuery2SB: TFloatField;
    ZQuery2BI: TFloatField;
    ZQuery2CU: TFloatField;
    ZQuery2PB: TFloatField;
    ZQuery2ZN: TFloatField;
    ZQuery2CR: TFloatField;
    ZQuery2NI: TFloatField;
    ZQuery2TI: TFloatField;
    ZQuery2HG: TFloatField;
    ZQuery2MO: TFloatField;
    ZQuery2CO: TFloatField;
    ZQuery2BA: TFloatField;
    ZQuery2SR: TFloatField;
    ZQuery2CD: TFloatField;
    DataSource2: TDataSource;
    ZQuery3: TZQuery;
    ZQuery3CHM_REF_NR: TFloatField;
    ZQuery3COD: TFloatField;
    ZQuery3CFR: TFloatField;
    ZQuery3DOC: TFloatField;
    ZQuery3BOD: TFloatField;
    ZQuery3H2S: TFloatField;
    ZQuery3PHEN: TFloatField;
    ZQuery3OIL: TFloatField;
    ZQuery3SOAP: TFloatField;
    ZQuery3KJED: TFloatField;
    ZQuery3ECOL: TFloatField;
    ZQuery3FAEC_ECOL: TFloatField;
    ZQuery3SPC: TFloatField;
    ZQuery3FAEC_STREP: TFloatField;
    DataSource3: TDataSource;
    ZQuery4: TZQuery;
    ZQuery4CHM_REF_NR: TFloatField;
    ZQuery4COLR: TFloatField;
    ZQuery4ODR: TFloatField;
    ZQuery4TST: TFloatField;
    ZQuery4SPECGRAV: TFloatField;
    ZQuery4MBAS: TFloatField;
    ZQuery4TEMP: TFloatField;
    ZQuery4TUR: TFloatField;
    ZQuery4SUSP_SOLID: TFloatField;
    ZQuery4DEUTERIUM: TFloatField;
    ZQuery4TRITIUM: TFloatField;
    ZQuery4OXYGEN18: TFloatField;
    ZQuery4RCARBON: TFloatField;
    DataSource4: TDataSource;
    ZQuery5: TZQuery;
    ZQuery5CHM_REF_NR: TFloatField;
    ZQuery5LI: TFloatField;
    ZQuery5CE: TFloatField;
    ZQuery5AU: TFloatField;
    ZQuery5AG: TFloatField;
    ZQuery5PT: TFloatField;
    ZQuery5TE: TFloatField;
    ZQuery5TL: TFloatField;
    ZQuery5W: TFloatField;
    ZQuery5V: TFloatField;
    ZQuery5U: TFloatField;
    ZQuery5SE: TFloatField;
    ZQuery5BE: TFloatField;
    ZQuery5BR: TFloatField;
    ZQuery5I: TFloatField;
    DataSource5: TDataSource;
    ZQuery7: TZQuery;
    ZQuery7CHM_REF_NR: TFloatField;
    ZQuery7CPARAMETER: TStringField;
    ZQuery7METHOD: TStringField;
    ZQuery7LIMITS: TStringField;
    DetectionTableCOMMENT: TStringField;
    DataSource6: TDataSource;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    DBEdit22: TDBEdit;
    DBEdit23: TDBEdit;
    DBEdit24: TDBEdit;
    DBEdit25: TDBEdit;
    DBEdit26: TDBEdit;
    DBEdit27: TDBEdit;
    DBEdit28: TDBEdit;
    DataSource7: TDataSource;
    ZQuery6: TZQuery;
    FloatField1: TFloatField;
    ZQuery6CPARAMETER: TStringField;
    ZQuery6PARAM_REF: TStringField;
    ZQuery6UNIT: TStringField;
    ZQuery6READING: TFloatField;
    Image1: TImage;
    ZQuery3DOX: TFloatField;
    ZQuery6COMMENT: TStringField;
    ZQuery6SYMBOL: TStringField;
    ZQuery3TOTAL_COL: TFloatField;
    ZQuery3TVO: TFloatField;
    ChemLabel: TLabel;
    EntryPopupMenu: TPopupMenu;
    Clearall1: TMenuItem;
    Save1: TMenuItem;
    Open1: TMenuItem;
    DefTable: TZTable;
    DefTablePosition: TIntegerField;
    DefTableParameter: TStringField;
    DefTableLabel_Descr: TStringField;
    DefTableHint_Descr: TStringField;
    DefTableDataSource: TIntegerField;
    ZQuery2ARSENIC: TFloatField;
    ZQuery5SN: TFloatField;
    ZQuery5PD: TFloatField;
    ZQuery5ZR: TFloatField;
    ZQuery5LA: TFloatField;
    ZQuery5NB: TFloatField;
    ZQuery5TA: TFloatField;
    ZQuery5ND: TFloatField;
    ChangeQuery: TZQuery;
    ZQuery3TOC: TFloatField;
    ZQuery3SOM_COLI: TFloatField;
    ZQuery3ENT_VIRUS: TFloatField;
    ZQuery3PROTO_PARA: TFloatField;
    ZQuery3TOT_THM: TFloatField;
    ParamListQuery: TZReadOnlyQuery;
    ZReadOnlyQueryCoordAcc: TZReadOnlyQuery;
    ZReadOnlyQueryCoordAccDESCRIBE: TStringField;
    ZReadOnlyQueryCoordAccSEARCH: TStringField;
    ZReadOnlyQuerySiteType: TZReadOnlyQuery;
    ZReadOnlyQueryTopoSetDESCRIBE3: TStringField;
    ZReadOnlyQueryTopoSetSEARCH3: TStringField;
    procedure BasicinfDataSourceDataChange(Sender: TObject; Field: TField);
    procedure EditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditClick(Sender: TObject);
    procedure EditYChange(Sender: TObject);
    procedure DetailNavigatorClick(Sender: TObject; Button: TDBNavButtonType);
    procedure EditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditResultsEditingDone(Sender: TObject);
    procedure MenuItemGotoBookmark1Click(Sender: TObject);
    procedure MenuItemGotoBookmark2Click(Sender: TObject);
    procedure MenuItemSetBookmark1Click(Sender: TObject);
    procedure MenuItemSetBookMark2Click(Sender: TObject);
    procedure ZQuery1BeforeOpen(DataSet: TDataSet);
    procedure ZQuery2BeforeOpen(DataSet: TDataSet);
    procedure ZQuery2NO2GetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure ZQuery2NO2SetText(Sender: TField; const aText: string);
    procedure ZQuery2PO4GetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure ZQuery2PO4SetText(Sender: TField; const aText: string);
    procedure ZQuery3BeforeOpen(DataSet: TDataSet);
    procedure ZQuery4BeforeOpen(DataSet: TDataSet);
    procedure ZQuery5BeforeOpen(DataSet: TDataSet);
    procedure DBEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBGridDetColExit(Sender: TObject);
    procedure DBGridDetGetCellHint(Sender: TObject; Column: TColumn;
      var AText: String);
    procedure DBGridDetMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGridDetMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBGridDetTitleClick(Column: TColumn);
    procedure DBGridColExit(Sender: TObject);
    procedure DBGridGetCellHint(Sender: TObject; Column: TColumn;
      var AText: String);
    procedure DBGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGridMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure DBGridTitleClick(Column: TColumn);
    procedure EditNavigatorClick(Sender: TObject; Button: TDBNavButtonType);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LinkedQueryAfterOpen(DataSet: TDataSet);
    procedure AMSLCheckBoxClick(Sender: TObject);
    procedure DBLookupListInfoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LinkedQueryBeforeOpen(DataSet: TDataSet);
    procedure LinkedQueryNewRecord(DataSet: TDataset);
    procedure LinkedQueryPostError(DataSet: TDataSet; E: EDatabaseError;
      var DataAction: TDataAction);
    procedure LinkedQueryUpperSetText(Sender: TField;
      const aText: String);
    procedure EditKeyPress(Sender: TObject; var Key: char);
    procedure EditXChange(Sender: TObject);
    procedure MenuItemDeleteClick(Sender: TObject);
    procedure RxDBLookupComboClick(Sender: TObject);
    procedure RxDBLookupComboSelect(Sender: TObject);
    procedure RxDBLookupComboMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure SamplesLabelClick(Sender: TObject);
    procedure DBGridEnter(Sender: TObject);
    procedure EditBasicinfEnter(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure DBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LinkedQueryMETH_SAMPLValidate(Sender: TField);
    procedure LinkedQueryDEPTH_SAMPGetText(Sender: TField;
      var aText: String; DisplayText: Boolean);
    procedure LinkedQueryDEPTH_SAMPSetText(Sender: TField;
      const aText: String);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LinkedQuerySAMPL_TYPEValidate(Sender: TField);
    procedure DataSource6DataChange(Sender: TObject; Field: TField);
    procedure DBGridDetKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridDetEnter(Sender: TObject);
    procedure LabelDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure LabelDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure DBEditChemEnter(Sender: TObject);
    procedure LabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Image1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ChemTableGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure ZQuery2N_AMONIASetText(Sender: TField;
      const aText: String);
    procedure ZQuery1NSetText(Sender: TField; const aText: String);
    procedure ZQuery1NGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure ZQuery2N_AMONIAGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure ZQuery6AfterOpen(DataSet: TDataSet);
    procedure ZQuery6BeforeOpen(DataSet: TDataSet);
    procedure ZQuery6NewRecord(DataSet: TDataSet);
    procedure ZQuery6CalcFields(DataSet: TDataSet);
    procedure ZQuery6READINGGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure UserChemTableSetText(Sender: TField;
      const aText: String);
    procedure ZQuery6BeforeEdit(DataSet: TDataSet);
    procedure DBGrid2Enter(Sender: TObject);
    procedure DBGrid2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ZQuery6AfterPost(DataSet: TDataSet);
    procedure Save1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Clearall1Click(Sender: TObject);
    procedure EntryPopupMenuPopup(Sender: TObject);
    procedure SetChemLabels;
    procedure GraphSpeedButtonClick(Sender: TObject);
    procedure LinkedDataSourceDataChange(Sender: TObject; Field: TField);
    procedure LinkedQueryDATEValidate(Sender: TField);
    procedure LinkedQueryTIME_SAMPLValidate(Sender: TField);
    procedure ZQuery1ECSetText(Sender: TField; const aText: String);
    procedure ZQuery1ECGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure ZQuery6CPARAMETERValidate(Sender: TField);
    procedure ChemNoFactorGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure ChemTableSetText(Sender: TField; const aText: String);
    procedure PageControlChange(Sender: TObject);
    procedure BitBtnHelpClick(Sender: TObject);
    procedure CloseBitBtnClick(Sender: TObject);
    procedure ZQuery7LIMITSValidate(Sender: TField);
    function FormatTheFloat(const TheFloat: Double): ShortString;
    procedure ZQuery7NewRecord(DataSet: TDataSet);
  private
    { private declarations }
    CurrentPar: ShortString;
    ParameterList, UnitList, DragList: TStringList;
    JumpFieldNr: Byte;
    row, col : Integer;
    TheActiveDBEdit: TDBEdit;
    TheActiveRxDB: TRxDBLookupCombo;
  public
    { public declarations }
  end;

  TMyGrid = Class(TDBGrid);
  TDBNavigatorEx = class(TDBNavigator);

var
  UserChemistryForm: TUserChemistryForm;
  ValidFound: Boolean;

implementation

uses Timedept, Lookup, strdatetime, VARINIT, MainDataModule, definitiondescr,
     selectdef;

{$R *.lfm}

function TUserChemistryForm.FormatTheFloat(const TheFloat: Double): ShortString;
begin
  if TheFloat = 0 then
    Result := '0.00'
  else
  if Abs(TheFloat) < 0.001 then
    Result := FloatToStrF(TheFloat, ffFixed, 15, 5)
  else
  if Abs(TheFloat) < 0.01 then
    Result := FloatToStrF(TheFloat, ffFixed, 15, 4)
  else
  if Abs(TheFloat) < 0.1 then
    Result := FloatToStrF(TheFloat, ffFixed, 15, 3)
  else
  if Abs(TheFloat) < 1000 then
    Result := FloatToStrF(TheFloat, ffFixed, 15, 2)
  else
  if Abs(TheFloat) < 100000 then
    Result := FloatToStrF(TheFloat, ffFixed, 15, 1)
  else
    Result := FloatToStrF(TheFloat, ffFixed, 15, 0);
end;

procedure TUserChemistryForm.ZQuery7NewRecord(DataSet: TDataSet);
begin
  ZQuery7CPARAMETER.Value := CurrentPar;
end;

procedure TUserChemistryForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  TDBNavigatorEx(DBNavigatorView).Buttons[nbRefresh].Enabled := TRUE ;
  DataModuleMain.SetComponentFontAndSize(Sender, False);
  //hardcode taborder
  EditCOLLAR_HI.TabOrder := 8;
  EditDEPTH.TabOrder := 9;
  RxDBLookupComboType.TabOrder := 10;
  DragList := TStringList.Create;
  DragList.Sorted := True;
  DragList.Duplicates := dupIgnore;
  ParameterList := TStringList.Create;
  ParameterList.Sorted := True;
  ParameterList.Duplicates := dupIgnore;
  UnitList := TStringList.Create;
  UnitList.Sorted := True;
  UnitList.Duplicates := dupIgnore;
  DataModuleMain.CoordsEdited := False;
  ValidFound := True;
end;

procedure TUserChemistryForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  DragList.Free;
  ParameterList.Free;
  UnitList.Free;
  with DataModuleMain do
  begin
    ZQueryView.FreeBookmark(Bookmark1);
    ZQueryView.FreeBookmark(Bookmark2);
  end;
  LinkedQuery.Close;
  ZQuery1.Close;
  ZQuery2.Close;
  ZQuery3.Close;
  ZQuery4.Close;
  ZQuery5.Close;
  ZReadOnlyQueryCoordAcc.Close;
  ZReadOnlyQuerySiteType.Close;
  Editing := 'Editing: <none>';
  CloseAction := caFree;
end;

procedure TUserChemistryForm.FormActivate(Sender: TObject);
var
  TempTag: Integer;
  i: Word;
begin
  DataModuleMain.BasicValidFound := True;
  CurrentSite := DataModuleMain.BasicinfQuerySITE_ID_NR.Value;
  Caption := 'User-defined Parameters - [' + UpperCase(FilterName) + ']';
  ChemStandardLabel.Caption := ChemStandardDescr;
  //Check for AsN
  if FindComponent('ZQuery1N').Tag > 0 then
  begin
    TempTag := (FindComponent('ZQuery1N')).Tag;
    if AsN then
      (FindComponent('Label' + IntToStr(TempTag)) as TLabel).Caption := 'NO&3 as N'
    else
      (FindComponent('Label' + IntToStr(TempTag)) as TLabel).Caption := 'NO&3';
  end;
  if FindComponent('ZQuery2N_AMONIA').Tag > 0 then
  begin
    TempTag := (FindComponent('ZQuery2N_AMONIA')).Tag;
    if AsN then
      (FindComponent('Label' + IntToStr(TempTag)) as TLabel).Caption := 'NH&4 as N'
    else
      (FindComponent('Label' + IntToStr(TempTag)) as TLabel).Caption := 'NH&4';
  end;
  if FindComponent('ZQuery2NO2').Tag > 0 then
  begin
    TempTag := (FindComponent('ZQuery2NO2')).Tag;
    if AsN then
      (FindComponent('Label' + IntToStr(TempTag)) as TLabel).Caption := 'N&O2 as N'
    else
      (FindComponent('Label' + IntToStr(TempTag)) as TLabel).Caption := 'N&O2';
  end;
  if FindComponent('ZQuery2PO4').Tag > 0 then
  begin
    TempTag := (FindComponent('ZQuery2PO4')).Tag;
    if AsN then
      (FindComponent('Label' + IntToStr(TempTag)) as TLabel).Caption := 'P&O4 as P'
    else
      (FindComponent('Label' + IntToStr(TempTag)) as TLabel).Caption := 'P&O4';
  end;
  //Check for EC
  if FindComponent('ZQuery1EC').Tag > 0 then
  begin
    TempTag := (FindComponent('ZQuery1EC')).Tag;
    (FindComponent('Label' + IntToStr(TempTag)) as TLabel).Caption := 'EC [' + ECUnit + ']';
  end;
  SamplesLabel.Caption := 'Samples - Depth [' + LengthUnit + ']';
  AltitudeLabel.Caption := '&Altitude [' + LengthUnit + ']';
  CollarLabel.Caption := 'Co&llar [' + LengthUnit + ']';
  DepthLabel.Caption :=  'Dept&h [' + LengthUnit + ']';
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
  if EditNavigator.DataSource = BasicinfDataSource then
    Editing := 'Editing: Basic information'
  else
    if EditNavigator.DataSource = LinkedDataSource then
      Editing := 'Editing: Samples'
    else
      Editing := 'Editing: User-defined Parameters';
  EditNavigator.Enabled := DataModuleMain.NrRecords > 0;
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
  if LinkedQuery.Active then
  LinkedQuery.Refresh;
  if ZQuery1.Active then
    ZQuery1.Refresh;
  if ZQuery2.Active then
    ZQuery2.Refresh;
  if ZQuery3.Active then
    ZQuery3.Refresh;
  if ZQuery4.Active then
    ZQuery4.Refresh;
  if ZQuery5.Active then
    ZQuery5.Refresh;
  if ZQuery6.Active then
    ZQuery6.Refresh;
  if ZQuery7.Active then
    ZQuery7.Refresh;
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

procedure TUserChemistryForm.FormShow(Sender: TObject);
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
    with ParamListQuery do
    begin
      SQL.Add('SELECT DISTINCT CPARAMETER FROM userchem');
      Open;
      while not EOF do
      begin
        ParameterList.Add(FieldByName('CPARAMETER').AsString);
        Next;
      end;
      Close;
      SQL.Clear;
      SQL.Add('SELECT DISTINCT UNIT FROM userchem');
      Open;
      while not EOF do
      begin
        UnitList.Add(FieldByName('UNIT').AsString);
        Next;
      end;
      Close;
    end;
  except on E: Exception do
    MessageDlg(E.Message + ' - You may have to contact your database administrator to resollve this error.', mtError, [mbOK], 0);
  end;
  DBGrid2.Columns[0].PickList.AddStrings(ParameterList);
  DBGrid2.Columns[2].PickList.AddStrings(UnitList);
  if ParameterTabsheet.Hint <> '' then
    SetChemLabels;
end;

procedure TUserChemistryForm.LinkedQueryAfterOpen(DataSet: TDataSet);
begin
  LinkedDataSource.AutoEdit := AutoEditGrid;
end;

procedure TUserChemistryForm.AMSLCheckBoxClick(Sender: TObject);
begin
  LinkedQuery.Refresh;
end;

procedure TUserChemistryForm.DBLookupListInfoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    DBGrid.Enabled := True;
    DBGrid.SetFocus;
  end;
end;

procedure TUserChemistryForm.LinkedQueryBeforeOpen(DataSet: TDataSet);
begin
  LinkedQuery.FetchRow := StrToInt(EditResults.Text);
  LinkedQuery.Params[0].AsString := CurrentSite;
end;

procedure TUserChemistryForm.LinkedQueryNewRecord(DataSet: TDataset);
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

procedure TUserChemistryForm.LinkedQueryPostError(DataSet: TDataSet;
  E: EDatabaseError; var DataAction: TDataAction);
begin
  ShowMessage(E.Message + '. Record will not be posted!');
  DataAction := daAbort;
end;

procedure TUserChemistryForm.LinkedQueryUpperSetText(Sender: TField;
  const aText: String);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TUserChemistryForm.EditKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in [#3]) then //<ctrl-c> copy
    DataModuleMain.CheckMaskEditInput(Key);
end;

procedure TUserChemistryForm.EditXChange(Sender: TObject);
begin
  //Set the edit mask of coordinate DBEdits
  if ShowDMS then
    (Sender as TDBEdit).EditMask := '900°00''00.00">L;1;_'
  else
    (Sender as TDBEdit).EditMask := '';
end;

procedure TUserChemistryForm.MenuItemDeleteClick(Sender: TObject);
begin
  with TSelectDefForm.Create(Application) do
  begin
    ShowModal;
    if ModalResult = mrOK then
    begin
      if ComboBox1.Text = ParameterTabSheet.Hint then
        MessageDlg('You cannot delete the currently active definition!', mtError, [mbOK], 0)
      else
      if MessageDlg('Are you sure you want to delete the selected definition permanently?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        DataModuleMain.ZConnectionSettings.ExecuteDirect('DELETE FROM userentr WHERE DESCRIPTION = ' + QuotedStr(ComboBox1.Text))
    end;
  end;
end;

procedure TUserChemistryForm.RxDBLookupComboClick(Sender: TObject);
begin
  (Sender as TRxDBLookupCombo).SetFocus;
end;

procedure TUserChemistryForm.RxDBLookupComboSelect(Sender: TObject);
begin
  if (DataModuleMain.BasicinfQuery.State <> dsEdit)
    and (DataModuleMain.BasicinfQuery.State <> dsInsert)
      and not (Sender as TRxDBLookupCombo).DataSource.DataSet.FieldByName((Sender as TRxDBLookupCombo).DataField).IsNull then
        (Sender as TRxDBLookupCombo).Text := (Sender as TRxDBLookupCombo).DataSource.DataSet.FieldByName((Sender as TRxDBLookupCombo).DataField).Value;
end;

procedure TUserChemistryForm.RxDBLookupComboMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  (Sender as TRxDBLookupCombo).Hint := DataModuleMain.TranslateCode((Sender as TRxDBLookupCombo).HelpKeyword, (Sender as TRxDBLookupCombo).Value);
end;

procedure TUserChemistryForm.SamplesLabelClick(Sender: TObject);
begin
  EditNavigator.DataSource := LinkedDataSource;
  EditNavigator.VisibleButtons := [nbInsert,nbDelete,nbEdit,nbPost,nbCancel,nbRefresh];
  EditNavigator.Width := 156;
  Editing := 'Editing: Samples';
  DBGrid.SetFocus;
end;

procedure TUserChemistryForm.DBGridEnter(Sender: TObject);
begin
  if EditNavigator.DataSource.Tag = 0 then
  begin
    if DataModuleMain.BasicinfQuery.State IN [dsInsert, dsEdit] then
    begin
      if MessageDlg('Changes to Basic Information have not been posted and will be lost! Post record now?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then DataModuleMain.BasicinfQuery.Post
      else DataModuleMain.BasicinfQuery.Cancel;
    end;
  end
  else
  if EditNavigator.DataSource.Tag < 8 then
  begin
    if EditNavigator.DataSource.DataSet.State IN [dsInsert, dsEdit] then
    begin
      if MessageDlg('Changes to Chemistry Information have not been posted and will be lost! Post record now?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then EditNavigator.DataSource.DataSet.Post
      else EditNavigator.DataSource.DataSet.Cancel;
    end;
  end;
  EditNavigator.DataSource := LinkedDataSource;
  EditNavigator.VisibleButtons := [nbInsert,nbDelete,nbEdit,nbPost,nbCancel,nbRefresh];
  EditNavigator.Width := EditNavigator.Height * 6 + 6;
  Editing := 'Editing: Samples';
end;

procedure TUserChemistryForm.EditBasicinfEnter(Sender: TObject);
begin
  if EditNavigator.DataSource.Tag = 8 then
  begin
    if EditNavigator.DataSource.DataSet.State IN [dsInsert, dsEdit] then
    begin
      if MessageDlg('Changes to Sample information have not been posted and will be lost! Post record now?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then EditNavigator.DataSource.DataSet.Post
      else EditNavigator.DataSource.DataSet.Cancel;
    end;
  end
  else
  if EditNavigator.DataSource.Tag >= 1 then
  begin
    if EditNavigator.DataSource.DataSet.State IN [dsInsert, dsEdit] then
    begin
      if MessageDlg('Changes to Chemistry information have not been posted and will be lost! Post record now?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then EditNavigator.DataSource.DataSet.Post
      else EditNavigator.DataSource.DataSet.Cancel;
    end;
  end;
  EditNavigator.DataSource := BasicinfDataSource;
  EditNavigator.VisibleButtons := [nbEdit,nbPost,nbCancel,nbRefresh];
  EditNavigator.Width := EditNavigator.Height * 4 + 4;
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

procedure TUserChemistryForm.PopupMenu1Popup(Sender: TObject);
begin
  with DataModuleMain do
  begin
    MenuItemGotoBookmark1.Enabled := Assigned(BookMark1);
    MenuItemGotoBookmark2.Enabled := Assigned(BookMark1);
  end;
end;

procedure TUserChemistryForm.DBGridKeyDown(Sender: TObject; var Key: Word;
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

procedure TUserChemistryForm.LinkedQueryMETH_SAMPLValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('METHSAMP', Sender.AsString);
end;

procedure TUserChemistryForm.LinkedQueryDEPTH_SAMPGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if AMSLCheckBox.Checked then
      aText := FloatToStrF((DataModuleMain.BasicinfQueryALTITUDE.Value - LinkedQueryDEPTH_SAMP.Value) * LengthFactor, ffFixed, 15, 2)
    else
      aText := FloatToStrF(LinkedQueryDEPTH_SAMP.Value * LengthFactor, ffFixed, 15, 2);
  end
end;

procedure TUserChemistryForm.LinkedQueryDEPTH_SAMPSetText(Sender: TField;
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

procedure TUserChemistryForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (not (ActiveControl is TDBGrid)) and (ActiveControl.Tag < 1000) then
  begin
    if ssCtrl in Shift then
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
    78, 110: with PageControl do
               if TabIndex < 2 then TabIndex := TabIndex + 1;
    80, 113: with PageControl do
               if TabIndex > 0 then TabIndex := TabIndex - 1;
    end {of case}
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
  end;
end;

procedure TUserChemistryForm.LinkedQuerySAMPL_TYPEValidate(
  Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('SAMPTYPE', Sender.AsString);
end;

procedure TUserChemistryForm.DataSource6DataChange(Sender: TObject;
  Field: TField);
begin
  if ZQuery7.RecordCount> 0 then
    TabSheet3.Caption := '-->Detection Limits'
  else
    TabSheet3.Caption := 'Detection Limits';
end;

procedure TUserChemistryForm.DBGridDetKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssAlt in Shift) then
  begin
    if (Key = VK_F8) then ZQuery7.Edit;
  end
  else
  case Key of
    VK_F1: begin
             if DBGridDet.SelectedField.Tag > 0 then //is lookup field then use LookupComboAcc helpcontext
               BitBtnHelpClick(RxDBLookupComboAcc)
             else
               BitBtnHelpClick(DBGridDet);
           end;
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
                  ZQuery7.FieldByName(DBGrid.SelectedField.FieldName).AsString := LookupValue;
             end;
           end;
  end; {of case}
end;

procedure TUserChemistryForm.DBGridDetEnter(Sender: TObject);
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
  DetailNavigator.DataSource := DataSource7;
  DetailNavigator.VisibleButtons := [nbFirst,nbPrior,nbNext,nbLast,nbInsert,nbDelete,nbEdit,nbPost,nbCancel,nbRefresh];
  DetailNavigator.Width := 262;
  Editing := 'Editing: Detection Limits';
end;

procedure TUserChemistryForm.LabelDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if Copy((Sender as TLabel).Caption, 1, 9) = 'Parameter' then
  begin
    if (Source is TLabel) and (((Source as TLabel).Parent as TTabSheet).Name = 'ParameterTabSheet') then
      Accept := (Source is TLabel)
    else
      Accept := (Source is TLabel) and (DragList.IndexOf(((Source as TLabel).FocusControl as TDBEdit).DataField) = -1);
  end
  else Accept := False;
end;

procedure TUserChemistryForm.LabelDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  DSTag: Byte;
  DField: String;
begin
  if not ZQuery1.Active then
    ZQuery1.Open;
  if not ZQuery2.Active then
    ZQuery2.Open;
  if not ZQuery3.Active then
    ZQuery3.Open;
  if not ZQuery4.Active then
    ZQuery4.Open;
  if not ZQuery5.Active then
    ZQuery5.Open;
  if (Source is TLabel) then
  begin
    (Sender as TLabel).Caption := (Source as TLabel).Caption;
    (Sender as TLabel).Font.Color := clBlack;
    DSTag := (((Source as TLabel).FocusControl) as TDBEdit).DataSource.Tag;
    case DSTag of
      1: (((Sender as TLabel).FocusControl) as TDBEdit).DataSource := DataSource1;
      2: (((Sender as TLabel).FocusControl) as TDBEdit).DataSource := DataSource2;
      3: (((Sender as TLabel).FocusControl) as TDBEdit).DataSource := DataSource3;
      4: (((Sender as TLabel).FocusControl) as TDBEdit).DataSource := DataSource4;
      5: (((Sender as TLabel).FocusControl) as TDBEdit).DataSource := DataSource5;
    end; //of case
    DField := (((Source as TLabel).FocusControl) as TDBEdit).DataField;
    DragList.Add(DField);
    (((Sender as TLabel).FocusControl) as TDBEdit).DataField := DField;
    (((Sender as TLabel).FocusControl) as TDBEdit).Hint := (((Source as TLabel).FocusControl) as TDBEdit).Hint;
    (((Sender as TLabel).FocusControl) as TDBEdit).Enabled := True;
    (FindComponent('ZQuery' + IntToStr(DSTag) + DField)).Tag :=
      (Sender as TLabel).Tag;
    case DSTag of
      1: ZQuery1.Refresh;
      2: ZQuery2.Refresh;
      3: ZQuery3.Refresh;
      4: ZQuery4.Refresh;
      5: ZQuery5.Refresh;
    end; //of case
    if (((Source as TLabel).Parent as TTabSheet).Name = 'ParameterTabSheet') and
      ((Sender as TLabel).Tag <> (Source as TLabel).Tag) then
    begin
      (Source as TLabel).Caption := 'Parameter' + IntToStr((Source as TLabel).Tag);
      (Source as TLabel).Font.Color := clGray;
      (Source as TLabel).OnDblClick := nil;
      (Sender as TLabel).Hint := '';
      (((Source as TLabel).FocusControl) as TDBEdit).Enabled := False;
      (((Source as TLabel).FocusControl) as TDBEdit).DataField := '';
      (((Source as TLabel).FocusControl) as TDBEdit).Hint := '';
      (((Source as TLabel).FocusControl) as TDBEdit).DataSource := nil;
    end;
  end;
end;

procedure TUserChemistryForm.DBEditChemEnter(Sender: TObject);
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

procedure TUserChemistryForm.LabelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if (ssLeft in Shift) and (Copy((Sender as TLabel).Caption, 1, 9) <> 'Parameter')
    then (Sender as TLabel).BeginDrag(False, 10);
end;

procedure TUserChemistryForm.Image1DragDrop(Sender, Source: TObject; X,
  Y: Integer);

var DField: String;
    DSTag: ShortInt;

begin
  if (Source is TLabel) then
  begin
    DField := (((Source as TLabel).FocusControl) as TDBEdit).DataField;
    DSTag := (((Source as TLabel).FocusControl) as TDBEdit).DataSource.Tag;
    (Source as TLabel).Caption := 'Parameter' + IntToStr((Source as TLabel).Tag);
    (Source as TLabel).Font.Color := clGray;
    (Source as TLabel).OnDblClick := nil;
    (Source as TLabel).Hint := '';
    (((Source as TLabel).FocusControl) as TDBEdit).Enabled := False;
    (((Source as TLabel).FocusControl) as TDBEdit).DataField := '';
    (((Source as TLabel).FocusControl) as TDBEdit).Hint := '';
    (((Source as TLabel).FocusControl) as TDBEdit).DataSource := nil;
    (FindComponent('ZQuery' + IntToStr(DSTag) + DField)).Tag := 0;
    DragList.Delete(DragList.IndexOf(DField));
  end;
end;

procedure TUserChemistryForm.Image1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source is TLabel);
end;

procedure TUserChemistryForm.ChemTableGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
var
  Limit: ShortString;
begin
  if (Sender.Tag > 0) and (Sender.Value <> -1) and (not Sender.IsNull) then
  begin
    if ZQuery7.Locate('CPARAMETER', Sender.FieldName, []) then
      Limit := ZQuery7LIMITS.AsString + ' '
    else
      Limit := '';
    aText := Limit + FormatTheFloat(Sender.Value * ChemFactor);
    if DataModuleMain.ClassTable.Active then
    begin
      if DataModuleMain.ClassTable.Locate('PARAMETER', Sender.FieldName, []) then
        (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := DataModuleMain.GetFont(Sender.Value)
      else
        (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := AppFont;
    end
    else
    begin
      if DataModuleMain.StandardTable.Locate('PARAMETER', Sender.FieldName, []) then
        (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := DataModuleMain.GetFont(Sender.Value)
      else
        (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := AppFont;
    end;
  end
  else DisplayText := False;
end;

procedure TUserChemistryForm.ZQuery2N_AMONIASetText(Sender: TField;
  const aText: String);
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

procedure TUserChemistryForm.ZQuery1NSetText(Sender: TField;
  const aText: String);
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

procedure TUserChemistryForm.ZQuery1NGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
var
  Limit: ShortString;
  TheValue: Double;
begin
  if (Sender.Tag > 0) and (Sender.Value <> -1) and (not Sender.IsNull) then
  begin
    if ZQuery7.Locate('CPARAMETER', Sender.FieldName, []) then
      Limit := ZQuery7LIMITS.AsString + ' '
    else
      Limit := '';
    if AsN then
    begin
      TheValue := Sender.AsFloat * ChemFactor;
      (FindComponent('Label' + IntToStr(Sender.Tag)) as TLabel).Caption := 'NO3 as N';
    end
    else
    begin
      TheValue := Sender.AsFloat * ParamFactor[0] * ChemFactor;
      (FindComponent('Label' + IntToStr(Sender.Tag)) as TLabel).Caption := 'NO3';
    end;
    aText := Limit + FormatTheFloat(TheValue);
    if DataModuleMain.ClassTable.Active then
    begin
      if DataModuleMain.ClassTable.Locate('PARAMETER', 'N', []) then
        (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := DataModuleMain.GetFont(Sender.Value)
      else (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := AppFont;
    end
    else
    begin
      if DataModuleMain.StandardTable.Locate('PARAMETER', 'N', []) then
        (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := DataModuleMain.GetFont(Sender.Value)
      else (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := AppFont;
    end;
  end
  else DisplayText := False;
end;

procedure TUserChemistryForm.ZQuery2N_AMONIAGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
var
  Limit: ShortString;
  TheValue: Double;
begin
  if (Sender.Tag > 0) and (Sender.Value > -1) and (not Sender.IsNull) then
  begin
    if ZQuery7.Locate('CPARAMETER', Sender.FieldName, []) then
      Limit := ZQuery7LIMITS.AsString + ' '
    else
      Limit := '';
    if AsN then
    begin
      TheValue := Sender.Value * ChemFactor;
      (FindComponent('Label' + IntToStr(Sender.Tag)) as TLabel).Caption := 'NH4 as N';
    end
    else
    begin
      TheValue := Sender.AsFloat * ParamFactor[2] * ChemFactor;
      (FindComponent('Label' + IntToStr(Sender.Tag)) as TLabel).Caption := 'NH4';
    end;
    aText := Limit + FormatTheFloat(TheValue);
    if DataModuleMain.ClassTable.Active then
    begin
      if DataModuleMain.ClassTable.Locate('PARAMETER', 'N_AMONIA', []) then
        (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := DataModuleMain.GetFont(Sender.Value)
      else (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := AppFont;
    end
    else
    begin
      if DataModuleMain.StandardTable.Locate('PARAMETER', 'N_AMONIA', []) then
        (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := DataModuleMain.GetFont(Sender.Value)
      else (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := AppFont;
    end;
  end
  else DisplayText := False;
end;

procedure TUserChemistryForm.ZQuery6AfterOpen(DataSet: TDataSet);
begin
  DataSource7.AutoEdit := AutoEditGrid;
end;

procedure TUserChemistryForm.ZQuery6BeforeOpen(DataSet: TDataSet);
begin
  ZQuery6.SQL.Clear;
  ZQuery6.SQL.Add('SELECT * FROM userchem WHERE CHM_REF_NR = ' + IntToStr(LinkedQueryCHM_REF_NR.AsInteger));
end;

procedure TUserChemistryForm.ZQuery6NewRecord(DataSet: TDataSet);
begin
  ZQuery6UNIT.Value := 'mg/l';
  ZQuery6READING.AsFloat := -1;
end;

procedure TUserChemistryForm.ZQuery6CalcFields(DataSet: TDataSet);
begin
  {Determine Symbol}
  if DataModuleMain.StandardTable.Locate('PARAMETER', ZQuery6CPARAMETER.Value, []) then
  begin
    if (ZQuery6READING.Value > DataModuleMain.StandardTableSTDMAXHI.Value) and (DataModuleMain.StandardTableSTDMAXHI.Value > -1)
      then ZQuery6SYMBOL.Value := '‡'
    else if (ZQuery6READING.Value > DataModuleMain.StandardTableSTDRECHI.Value) and (DataModuleMain.StandardTableSTDRECHI.Value > -1)
      then ZQuery6SYMBOL.Value := '†'
    else if (ZQuery6READING.Value < DataModuleMain.StandardTableSTDMAXLO.Value) and (DataModuleMain.StandardTableSTDMAXLO.Value > -1)
      then ZQuery6SYMBOL.Value := '¡'
    else if (ZQuery6READING.Value < DataModuleMain.StandardTableSTDRECLO.Value) and (DataModuleMain.StandardTableSTDRECLO.Value > -1)
      then ZQuery6SYMBOL.Value := '!'
    else ZQuery6SYMBOL.Value := '';
  end
  else ZQuery6SYMBOL.Value := '';
end;

procedure TUserChemistryForm.ZQuery6READINGGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
var
  Limit: ShortString;
begin
  if (Sender.Value <> -1) and (not Sender.IsNull) then
  begin
    if ZQuery7.Locate('CPARAMETER', ZQuery6CPARAMETER.AsString, []) then
      Limit := ZQuery7LIMITS.AsString + ' '
    else
      Limit := '';
    aText := Limit + FormatTheFloat(Sender.Value);
  end
  else DisplayText := False;
end;

procedure TUserChemistryForm.UserChemTableSetText(Sender: TField;
  const aText: String);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TUserChemistryForm.ZQuery6BeforeEdit(DataSet: TDataSet);
begin
  DBGrid2.Columns[0].PickList.Clear;
  DBGrid2.Columns[0].PickList.AddStrings(ParameterList);
  DBGrid2.Columns[2].PickList.Clear;
  DBGrid2.Columns[2].PickList.AddStrings(UnitList);
end;

procedure TUserChemistryForm.DBGrid2Enter(Sender: TObject);
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
  DetailNavigator.DataSource := DataSource6;
  DetailNavigator.VisibleButtons := [nbFirst,nbPrior,nbNext,nbLast,nbInsert,nbDelete,nbEdit,nbPost,nbCancel,nbRefresh];
  DetailNavigator.Width := 262;
  Editing := 'Editing: User-def. Parameters';
  DBGrid2.Columns[0].PickList.Clear;
  DBGrid2.Columns[0].PickList.AddStrings(ParameterList);
  DBGrid2.Columns[2].PickList.Clear;
  DBGrid2.Columns[2].PickList.AddStrings(UnitList);
end;

procedure TUserChemistryForm.DBGrid2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  InEditMode: Boolean;
begin
  InEditMode := (Sender as TDBGrid).DataSource.Dataset.State IN [dsInsert, dsEdit];
  if ssCtrl in Shift then
  begin
    case Key of
       VK_F1: begin //'<'
                ZQuery7.Insert;
                ZQuery7CPARAMETER.AsString := TDBGrid(Sender).DataSource.Dataset.FieldByName('CPARAMETER').AsString;
                ZQuery7LIMITS.AsString := '<';
                ZQuery7.Post;
              end;
       VK_F2: begin //'>'
                ZQuery7.Insert;
                ZQuery7CPARAMETER.AsString := TDBGrid(Sender).DataSource.Dataset.FieldByName('CPARAMETER').AsString;
                ZQuery7LIMITS.AsString := '>';
                ZQuery7.Post;
              end;
       VK_F3: begin //'#'
                ZQuery7.Insert;
                ZQuery7CPARAMETER.AsString := TDBGrid(Sender).DataSource.Dataset.FieldByName('CPARAMETER').AsString;
                ZQuery7LIMITS.AsString := '#';
                ZQuery7.Post;
              end;
       VK_F8: (Sender as TDBEdit).DataSource.DataSet.Edit
    end; //of case
  end
  else
  begin
    case Key of
      VK_F1: begin
               if DBGrid2.SelectedField.Tag > 0 then //is lookup field then use LookupComboAcc helpcontext
                 BitBtnHelpClick(RxDBLookupComboAcc)
               else
                 BitBtnHelpClick(DBGrid2);
             end;
      VK_F5: ZQuery6.Refresh;
      VK_F8: if InEditMode then ZQuery6.Post;
    end; {of case}
  end;
end;

procedure TUserChemistryForm.ZQuery6AfterPost(DataSet: TDataSet);
begin
  ParameterList.Add(ZQuery6CPARAMETER.AsString);
  UnitList.Add(ZQuery6UNIT.AsString);
  DBGrid2.Columns[0].PickList.Clear;
  DBGrid2.Columns[0].PickList.AddStrings(ParameterList);
  DBGrid2.Columns[2].PickList.Clear;
  DBGrid2.Columns[2].PickList.AddStrings(UnitList);
end;

procedure TUserChemistryForm.Save1Click(Sender: TObject);
var MyLabel: TLabel;
    t: SmallInt;
begin
  with TDescrForm.Create(Application) do
  begin
    ShowModal;
    if ModalResult = mrOK then
    begin
      Screen.Cursor := crSQLWait;
      DefTable.Open;
      for t := 1 to 28 do
      begin
        MyLabel := (Self.FindComponent('Label' + IntToStr(t)) as TLabel);
        if Pos('Parameter', MyLabel.Caption) = 0 then
        begin
          DefTable.Append;
          DefTablePOSITION.Value := t;
          DefTablePARAMETER.Value := (MyLabel.FocusControl as TDBEdit).DataField;
          DefTableLABEL_DESCR.Value := MyLabel.Caption;
          DefTableHINT_DESCR.Value := (MyLabel.FocusControl as TDBEdit).Hint;
          DefTableDATASOURCE.Value := (MyLabel.FocusControl as TDBEdit).DataSource.Tag;
          DefTableDESCRIPTION.Value := LabeledEdit1.Text;
          DefTable.Post;
        end;
      end;
      DefTable.Close;
      ParameterTabSheet.Hint := LabeledEdit1.Text;
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TUserChemistryForm.Open1Click(Sender: TObject);
begin
  if DragList.Count > 0 then
    MessageDlg('You cannot open the definition over the existing definition. Clear current definition first!', mtError, [mbOK], 0)
  else
  begin
    with TSelectDefForm.Create(Application) do
    begin
      ShowModal;
      if ModalResult = mrOK then
      begin
        ParameterTabSheet.Hint := ComboBox1.Text;
        SetChemLabels;
      end;
    end;
  end;
end;

procedure TUserChemistryForm.Clearall1Click(Sender: TObject);
var m: Byte;
    DField: String;
    MyLabel: TLabel;
begin
  if MessageDlg('Are you sure you want to clear the current definition?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    for m := 1 to 28 do
    begin
      MyLabel := (FindComponent('Label' + IntToStr(m)) as TLabel);
      MyLabel.Caption := 'Parameter' + IntToStr(m);
      MyLabel.Font.Color := clGray;
      MyLabel.OnDblClick := nil;
      MyLabel.Hint := '';
      MyLabel.Tag := m;
      ((MyLabel.FocusControl) as TDBEdit).Enabled := False;
      ((MyLabel.FocusControl) as TDBEdit).DataField := '';
      ((MyLabel.FocusControl) as TDBEdit).Hint := '';
      ((MyLabel.FocusControl) as TDBEdit).DataSource := nil;
      DField := ((MyLabel.FocusControl) as TDBEdit).DataField;
      if DField <> '' then
        (FindComponent('ZQuery' + IntToStr(m) + DField)).Tag := 0;
    end;
    DragList.Clear;
    if MessageDlg('Definition cleared! Do you also want to clear the default definition?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      ParameterTabSheet.Hint := '';
    end;
  end;
end;

procedure TUserChemistryForm.EntryPopupMenuPopup(Sender: TObject);
begin
  Save1.Enabled := DragList.Count > 0;
  ClearAll1.Enabled := DragList.Count > 0;
  MenuItemDelete.Enabled := DragList.Count > 0;
end;

procedure TUserChemistryForm.SetChemLabels;
var MyLabel: TLabel;
begin
  with DefTable do
  begin
    Filter := 'DESCRIPTION = ' + QuotedStr(ParameterTabSheet.Hint);
    Filtered := True;
    Open;
    if RecordCount > 0 then
    while not EOF do
    begin
      if DefTablePARAMETER.Value > '' then
      begin
        MyLabel := (Self.FindComponent('Label' + IntToStr(DefTablePOSITION.Value)) as TLabel);
        with (Self.FindComponent('DBEdit' + IntToStr(DefTablePOSITION.Value)) as TDBEdit) do
        begin
          case DefTableDATASOURCE.Value of
            1: DataSource := DataSource1;
            2: DataSource := DataSource2;
            3: DataSource := DataSource3;
            4: DataSource := DataSource4;
            5: DataSource := DataSource5;
          end;
          DataField := DefTablePARAMETER.Value;
          Hint := DefTableHINT_DESCR.Value;
          Enabled := True;
        end;
        MyLabel.Caption := DefTableLABEL_DESCR.Value;
        MyLabel.Font.Color := clBlack;
        DragList.Add((MyLabel.FocusControl as TDBEdit).DataField);
        Self.FindComponent('ZQuery' + IntToStr(DefTableDATASOURCE.Value) + DefTablePARAMETER.Value).Tag :=
          MyLabel.Tag;
      end;
      Next;
    end;
    Close;
  end;
  ZQuery1.Refresh;
  ZQuery2.Refresh;
  ZQuery3.Refresh;
  ZQuery4.Refresh;
  ZQuery5.Refresh;
end;

procedure TUserChemistryForm.GraphSpeedButtonClick(Sender: TObject);
begin
  with TTimeDeptForm.Create(Application) do
  begin
    TimeDeptTable[1] := 'userchem';
    StartDate := StringToDate(LinkedQueryDATE_SAMPL.AsString);
    StartTime := StringToTime(LinkedQueryTIME_SAMPL.AsString);
    ShowModal;
  end;
end;

procedure TUserChemistryForm.LinkedDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  ZQuery7.Close; //open det. limits first
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
  ZQuery6.Close;
  ZQuery6.Open;
  DataSource1.AutoEdit := LinkedQuery.RecordCount > 0;
  DataSource2.AutoEdit := LinkedQuery.RecordCount > 0;
  DataSource3.AutoEdit := LinkedQuery.RecordCount > 0;
  DataSource4.AutoEdit := LinkedQuery.RecordCount > 0;
  DataSource5.AutoEdit := LinkedQuery.RecordCount > 0;
  DataSource6.AutoEdit := LinkedQuery.RecordCount > 0;
  DataSource7.AutoEdit := LinkedQuery.RecordCount > 0;
  DBGridDet.Enabled := LinkedQuery.RecordCount > 0;
  DBGrid2.Enabled := LinkedQuery.RecordCount > 0;
  RecordText.Caption := 'Sample Record ' + IntToStr(LinkedQuery.RecNo) + ' out of ' + IntToStr(LinkedQuery.RecordCount);
  ChemLabel.Caption := 'Parameters [' + ChemUnit + ']';
end;

procedure TUserChemistryForm.LinkedQueryDATEValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TUserChemistryForm.LinkedQueryTIME_SAMPLValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidTime(Sender.Value);
end;

procedure TUserChemistryForm.ZQuery1ECSetText(Sender: TField;
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

procedure TUserChemistryForm.ZQuery1ECGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
var
  Limit: ShortString;
begin
  if ZQuery7.Locate('CPARAMETER', Sender.FieldName, []) then
    Limit := ZQuery7LIMITS.AsString + ' '
  else
    Limit := '';
  if (Sender.Tag > 0) and (Sender.Value <> -1) and (not Sender.IsNull) then
  begin
    aText := Limit + FloatToStrF(Sender.AsFloat * ECFactor, ffFixed, 15, 2);
    if DataModuleMain.ClassTable.Active then
    begin
      if DataModuleMain.ClassTable.Locate('PARAMETER', 'EC', []) then
        (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := DataModuleMain.GetFont(Sender.Value)
      else (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := AppFont;
    end
    else
    begin
      if DataModuleMain.StandardTable.Locate('PARAMETER', 'EC', []) then
        (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := DataModuleMain.GetFont(Sender.Value)
      else (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := AppFont;
    end;
  end
  else DisplayText := False;
end;

procedure TUserChemistryForm.ZQuery6CPARAMETERValidate(Sender: TField);
var
  ParamExists: Boolean;
begin
  ParamExists := False;
  if ZQuery1.FindField(ZQuery6CPARAMETER.AsString) <> nil then ParamExists := True;
  if ZQuery2.FindField(ZQuery6CPARAMETER.AsString) <> nil then ParamExists := True;
  if ZQuery3.FindField(ZQuery6CPARAMETER.AsString) <> nil then ParamExists := True;
  if ZQuery4.FindField(ZQuery6CPARAMETER.AsString) <> nil then ParamExists := True;
  if ZQuery5.FindField(ZQuery6CPARAMETER.AsString) <> nil then ParamExists := True;
  if not ParamExists then
  begin
    ValidFound := True
  end
  else
  begin
    ValidFound := False;
    MessageDlg('Parameter already exists in your chemistry tables and value should be entered there! Please use a different name here!', mtError, [mbOK], 0);
  end;
end;

procedure TUserChemistryForm.ChemNoFactorGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
var
  Limit: ShortString;
  TheValue: Double;
begin
  if (Sender.Tag > 0) and (Sender.Value <> -1) and (not Sender.IsNull) then
  begin
    if ZQuery7.Locate('CPARAMETER', Sender.FieldName, []) then
      Limit := ZQuery7LIMITS.AsString + ' '
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
    if DataModuleMain.ClassTable.Active then
    begin
      if DataModuleMain.ClassTable.Locate('PARAMETER', Sender.FieldName, []) then
        (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := DataModuleMain.GetFont(Sender.Value)
      else
      if Sender.FieldName = 'PH' then
      begin
        if Sender.Value >= 7 then
        begin
          DataModuleMain.ClassTable.Locate('PARAMETER', 'PHU', []);
          (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := DataModuleMain.GetFont(Sender.Value);
        end
        else
        begin
          DataModuleMain.ClassTable.Locate('PARAMETER', 'PHL', []);
          (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := DataModuleMain.GetFont(-Sender.Value);
        end;
      end
      else
        (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := AppFont;
    end
    else
    begin
      if DataModuleMain.StandardTable.Locate('PARAMETER', Sender.FieldName, []) then
        (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := DataModuleMain.GetFont(Sender.Value)
      else
        (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := AppFont;
    end;
  end
  else DisplayText := False;
end;

procedure TUserChemistryForm.ChemTableSetText(Sender: TField; const aText: String);
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

procedure TUserChemistryForm.PageControlChange(Sender: TObject);
begin
  if PageControl.ActivePage.TabIndex = 1 then
    ChemLabel.Caption := 'Parameters [' + ChemUnit + '] where applicable'
  else
    ChemLabel.Caption := 'Parameters';
  TheActiveDBEdit := NIL;
  TheActiveRxDB := NIL;
end;

procedure TUserChemistryForm.BitBtnHelpClick(Sender: TObject);
begin
   DataModuleMain.OpenHelp(Sender);
end;

procedure TUserChemistryForm.CloseBitBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TUserChemistryForm.ZQuery7LIMITSValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('LIMTTYPE', Sender.AsString);
end;

procedure TUserChemistryForm.DBGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
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

procedure TUserChemistryForm.DBGridMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  gridrow, gridcol : integer;
  rec : integer;
begin
  TDBGrid(Sender).MouseToCell(X, Y, gridcol, gridrow);

  if dgTitles in TDBGrid(Sender).Options then
    Dec(gridrow);
  if dgIndicator in TDBGrid(Sender).Options then
    Dec(gridcol);

  if TMyGrid(TDBGrid(Sender)).DataLink.Active and
     (gridrow >= 0) and (gridcol >= 0) then
  begin
    rec := TMyGrid(TDBGrid(Sender)).DataLink.ActiveRecord;
    try
      TMyGrid(TDBGrid(Sender)).DataLink.ActiveRecord := row;
      if TDBGrid(Sender).Columns[gridcol].Field.Tag > 0 then
      begin
        //use the LookupKeyFields property for the code translation, which is not used otherwise
        TDBGrid(Sender).Hint := DataModuleMain.TranslateCode(TDBGrid(Sender).Columns[gridcol].Field.LookupKeyFields, TDBGrid(Sender).Columns[gridcol].Field.AsString);
        TDBGrid(Sender).ShowHint := True;
      end
      else TDBGrid(Sender).ShowHint := False;
      Application.ActivateHint(Mouse.CursorPos);
    finally
      TMyGrid(TDBGrid(Sender)).DataLink.ActiveRecord := rec;
    end;
  end;
end;

procedure TUserChemistryForm.DBGridTitleClick(Column: TColumn);
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

procedure TUserChemistryForm.EditNavigatorClick(Sender: TObject;
  Button: TDBNavButtonType);
begin
  if TheActiveDBEdit <> NIL then
    TheActiveDBEdit.SetFocus
  else
  if TheActiveRxDB <> NIL then
    TheActiveRxDB.SetFocus;
end;

procedure TUserChemistryForm.FormCloseQuery(Sender: TObject;
  var CanClose: boolean);
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

procedure TUserChemistryForm.BasicinfDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  CurrentSite := DataModuleMain.BasicinfQuerySITE_ID_NR.Value;
  if Showing then
  try
    Screen.Cursor := crSQLWait;
    LinkedQuery.Close;
    LinkedQuery.Open;
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

procedure TUserChemistryForm.EditKeyUp(Sender: TObject; var Key: Word;
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

procedure TUserChemistryForm.EditClick(Sender: TObject);
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

procedure TUserChemistryForm.EditYChange(Sender: TObject);
begin
  //Set the edit mask of coordinate DBEdits
  if ShowDMS then
    (Sender as TDBEdit).EditMask := '00°00''00.00">L;1;_'
  else
    (Sender as TDBEdit).EditMask := '';
end;

procedure TUserChemistryForm.DetailNavigatorClick(Sender: TObject;
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

procedure TUserChemistryForm.EditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (ssShift in Shift) and (Key = VK_Delete)
    and (BasicinfDataSource.DataSet.State in [dsEdit, dsInsert]) then
      BasicinfDataSource.DataSet.FindField((Sender as TDBEdit).DataField).Clear;
end;

procedure TUserChemistryForm.EditResultsEditingDone(Sender: TObject);
begin
  LinkedQuery.FetchRow := StrToInt(EditResults.Text);
  LinkedQuery.Refresh;
end;

procedure TUserChemistryForm.MenuItemGotoBookmark1Click(Sender: TObject);
begin
  with DataModuleMain do
    ZQueryView.GotoBookmark(Bookmark1);
end;

procedure TUserChemistryForm.MenuItemGotoBookmark2Click(Sender: TObject);
begin
  with DataModuleMain do
    ZQueryView.GotoBookmark(Bookmark2);
end;

procedure TUserChemistryForm.MenuItemSetBookmark1Click(Sender: TObject);
begin
  with DataModuleMain do
  begin
    ZQueryView.FreeBookmark(Bookmark1);
    Bookmark1 := ZQueryView.GetBookmark;
  end;
end;

procedure TUserChemistryForm.MenuItemSetBookMark2Click(Sender: TObject);
begin
  with DataModuleMain do
  begin
    ZQueryView.FreeBookmark(Bookmark2);
    Bookmark2 := ZQueryView.GetBookmark;
  end;
end;

procedure TUserChemistryForm.ZQuery1BeforeOpen(DataSet: TDataSet);
begin
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('SELECT * FROM chem_001 WHERE CHM_REF_NR = ' + IntToStr(LinkedQueryCHM_REF_NR.AsInteger));
end;

procedure TUserChemistryForm.ZQuery2BeforeOpen(DataSet: TDataSet);
begin
  ZQuery2.SQL.Clear;
  ZQuery2.SQL.Add('SELECT * FROM chem_002 WHERE CHM_REF_NR = ' + IntToStr(LinkedQueryCHM_REF_NR.AsInteger));
end;

procedure TUserChemistryForm.ZQuery2NO2GetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
var
  Limit: ShortString;
  TheValue: Double;
begin
  if (Sender.Tag > 0) and (Sender.Value > -1) and (not Sender.IsNull) then
  begin
    if ZQuery7.Locate('CPARAMETER', Sender.FieldName, []) then
      Limit := ZQuery7LIMITS.AsString + ' '
    else
      Limit := '';
    if AsN then
    begin
      TheValue := Sender.AsFloat * ParamFactor[1] * ChemFactor;
      (FindComponent('Label' + IntToStr(Sender.Tag)) as TLabel).Caption := 'N&O2 as N';
    end
    else
    begin
      TheValue := Sender.AsFloat * ChemFactor;
      (FindComponent('Label' + IntToStr(Sender.Tag)) as TLabel).Caption := 'N&O2';
    end;
    aText := Limit + FormatTheFloat(TheValue);
    if DataModuleMain.ClassTable.Active then
    begin
      if DataModuleMain.ClassTable.Locate('PARAMETER', 'NO2', []) then
        (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := DataModuleMain.GetFont(Sender.Value)
      else (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := AppFont;
    end
    else
    begin
      if DataModuleMain.StandardTable.Locate('PARAMETER', 'NO2', []) then
        (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := DataModuleMain.GetFont(Sender.Value)
      else (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := AppFont;
    end;
  end
  else DisplayText := False;
end;

procedure TUserChemistryForm.ZQuery2NO2SetText(Sender: TField;
  const aText: string);
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

procedure TUserChemistryForm.ZQuery2PO4GetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
var
  Limit: ShortString;
  TheValue: Double;
begin
  if (Sender.Tag > 0) and (Sender.Value > -1) and (not Sender.IsNull) then
  begin
    if ZQuery7.Locate('CPARAMETER', Sender.FieldName, []) then
      Limit := ZQuery7LIMITS.AsString + ' '
    else
      Limit := '';
    if AsN then
    begin
      TheValue := Sender.AsFloat * ParamFactor[3] * ChemFactor;
      (FindComponent('Label' + IntToStr(Sender.Tag)) as TLabel).Caption := 'P&O4 as P';
    end
    else
    begin
      TheValue := Sender.AsFloat * ChemFactor;
      (FindComponent('Label' + IntToStr(Sender.Tag)) as TLabel).Caption := 'P&O4';
    end;
    aText := Limit + FormatTheFloat(TheValue);
    if DataModuleMain.ClassTable.Active then
    begin
      if DataModuleMain.ClassTable.Locate('PARAMETER', 'PO4', []) then
        (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := DataModuleMain.GetFont(Sender.Value)
      else (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := AppFont;
    end
    else
    begin
      if DataModuleMain.StandardTable.Locate('PARAMETER', 'PO4', []) then
        (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := DataModuleMain.GetFont(Sender.Value)
      else (FindComponent('DBEdit' + IntToStr(Sender.Tag)) as TDBEdit).Font := AppFont;
    end;
  end
  else DisplayText := False;
end;

procedure TUserChemistryForm.ZQuery2PO4SetText(Sender: TField;
  const aText: string);
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
      else Sender.Value := StrToFloat(TheText);
  end;
end;

procedure TUserChemistryForm.ZQuery3BeforeOpen(DataSet: TDataSet);
begin
  ZQuery3.SQL.Clear;
  ZQuery3.SQL.Add('SELECT * FROM chem_003 WHERE CHM_REF_NR = ' + IntToStr(LinkedQueryCHM_REF_NR.AsInteger));
end;

procedure TUserChemistryForm.ZQuery4BeforeOpen(DataSet: TDataSet);
begin
  ZQuery4.SQL.Clear;
  ZQuery4.SQL.Add('SELECT * FROM chem_004 WHERE CHM_REF_NR = ' + IntToStr(LinkedQueryCHM_REF_NR.AsInteger));
end;

procedure TUserChemistryForm.ZQuery5BeforeOpen(DataSet: TDataSet);
begin
  ZQuery5.SQL.Clear;
  ZQuery5.SQL.Add('SELECT * FROM chem_005 WHERE CHM_REF_NR = ' + IntToStr(LinkedQueryCHM_REF_NR.AsInteger));
end;

procedure TUserChemistryForm.DBEditKeyDown(Sender: TObject; var Key: Word;
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
  case Key of
      VK_F5: (Sender as TDBEdit).DataSource.DataSet.Refresh;
      VK_F8: if InEditMode then (Sender as TDBEdit).DataSource.DataSet.Post;
  VK_ESCAPE: if InEditMode then (Sender as TDBEdit).DataSource.DataSet.Cancel;
  end; {of case}
end;

procedure TUserChemistryForm.DBGridDetColExit(Sender: TObject);
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

procedure TUserChemistryForm.DBGridDetGetCellHint(Sender: TObject;
  Column: TColumn; var AText: String);
begin
  //use the LookupKeyFields property for the code translation, which is not used otherwise
  if (col > 0) and (Column.Field.LookupKeyFields > '') then
  begin
    AText := DataModuleMain.TranslateCode(Column.Field.LookupKeyFields, Column.Field.AsString);
    (Sender as TDBGrid).ShowHint := True;
  end
  else
  begin
    AText := 'Detection Limits Information';
    (Sender as TDBGrid).ShowHint := False;
  end;
end;

procedure TUserChemistryForm.DBGridDetMouseDown(Sender: TObject;
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
         ZQuery7.FieldByName(DBGrid.SelectedField.FieldName).AsString := LookupValue;
    end;
  end;
end;

procedure TUserChemistryForm.DBGridDetMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  TDBGrid(Sender).MouseToCell(X, Y, col, row);
end;

procedure TUserChemistryForm.DBGridDetTitleClick(Column: TColumn);
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

procedure TUserChemistryForm.DBGridColExit(Sender: TObject);
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

procedure TUserChemistryForm.DBGridGetCellHint(Sender: TObject;
  Column: TColumn; var AText: String);
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
