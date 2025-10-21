{ Copyright (C) 2025 Immo Blecher, immo@blecher.co.za

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
unit Main;

{$mode objfpc}{$H+}

interface

uses
  {$IFDEF WINDOWS}
  RLPrintDialog, LazUTF8, windows,
  {$ENDIF}
  {$IFDEF UNIX}
  unix,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, PrintersDlgs, Clipbrd, Forms, Dialogs,
  Buttons, Menus, DBCtrls, ComCtrls, ZDataset, ZSqlProcessor, DBGrids, StrUtils,
  Printers, XMLPropStorage, ExtCtrls, IniFiles, db, ftpsend, Process,
  FileUtil, LCLType, RLPreview, RLFilters, maskedit, Grids, mvMapViewer,
  DefaultTranslator, StdCtrls;

type

  { TMyThread }

  TMyThread = class(TThread)
  private

  protected
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: boolean);
  end;

type

  { TMainForm }

  TMainForm = class(TForm)
    ComboBoxField: TComboBox;
    ComboBoxSearch: TComboBox;
    CoolBar1: TCoolBar;
    Label1: TLabel;
    Label2: TLabel;
    ListBoxWSpaces: TListBox;
    MenuItem11: TMenuItem;
    MenuItemClearFilter: TMenuItem;
    MenuItemQField: TMenuItem;
    MenuItemGetChmRef: TMenuItem;
    MenuItemQuickSearchToolBar: TMenuItem;
    MenuItemStoredCoords: TMenuItem;
    MenuItemOpenQGISProject: TMenuItem;
    MenuItemPrepWSpaceQGIS: TMenuItem;
    MenuItemRecoverIndex: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItemW9: TMenuItem;
    MenuItemW8: TMenuItem;
    MenuItemW7: TMenuItem;
    MenuItemW6: TMenuItem;
    MenuItemW5: TMenuItem;
    MenuItemW4: TMenuItem;
    MenuItemW3: TMenuItem;
    MenuItemW2: TMenuItem;
    MenuItemW1: TMenuItem;
    MenuItemW0: TMenuItem;
    OpenDialogQGISProjects: TOpenDialog;
    PopupMenuMeteo: TPopupMenu;
    PopupMenuSurfaceHydr: TPopupMenu;
    SearchQuery: TZReadOnlyQuery;
    Separator1: TMenuItem;
    Separator2: TMenuItem;
    Separator3: TMenuItem;
    Separator4: TMenuItem;
    SpeedButtonClear: TSpeedButton;
    ToolBar5: TToolBar;
    ToolButtonMeteorology: TToolButton;
    ToolButtonQuickSearch1: TToolButton;
    ToolButtonSurfaceHydr: TToolButton;
    ToolButtonAdditionalInfo: TToolButton;
    ToolButtonBasicinf: TToolButton;
    ToolButtonChemistry: TToolButton;
    ToolButtonCloseWSpace: TToolButton;
    ToolButtonConstruction: TToolButton;
    ToolButtonCopy: TToolButton;
    ToolButtonCreateView: TToolButton;
    ToolButtonCut: TToolButton;
    ToolBar1: TToolBar;
    ToolButtonDischarge: TToolButton;
    DividerViews: TToolButton;
    FontDialog1: TFontDialog;
    ToolButtonGeology: TToolButton;
    ToolButtonHelp: TToolButton;
    MenuItem10: TMenuItem;
    MenuItemGeoSiteList: TMenuItem;
    MenuItem3: TMenuItem;
    S8: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItemDWSAudited: TMenuItem;
    MenuItemSYNOP: TMenuItem;
    MenuItemWeatherSA: TMenuItem;
    MenuItemFlag: TMenuItem;
    MenuItemMeteoReport: TMenuItem;
    MenuItemFieldMeas: TMenuItem;
    MenuItemSiteVisits: TMenuItem;
    MenuItemOwner: TMenuItem;
    MenuItemInstrumentation2: TMenuItem;
    MenuItemComments2: TMenuItem;
    MenuItemDepth: TMenuItem;
    MenuItemPrefs: TMenuItem;
    MenuItemAppFont: TMenuItem;
    ToolButtonOpenWSpace: TToolButton;
    ToolButtonPaste: TToolButton;
    PopupMenuPrefs: TPopupMenu;
    DropdownMenuAdditional: TPopupMenu;
    ToolButtonPreferences: TToolButton;
    ToolButtonPrint: TToolButton;
    ToolButtonQGISGoto: TToolButton;
    ToolButtonQGISMark: TToolButton;
    ToolButtonQuickSearch: TToolButton;
    SeparatorMaps: TMenuItem;
    MenuItemGraduated: TMenuItem;
    MenuItemAllsites: TMenuItem;
    MenuItemViewView: TMenuItem;
    MenuItemViewCurrent: TMenuItem;
    MenuItemMapView: TMenuItem;
    MenuItemCrsinfo: TMenuItem;
    MenuItemFile: TMenuItem;
    ImageListMenu: TImageList;
    MainMenu: TMainMenu;
    MenuItemChemistry: TMenuItem;
    MenuItem1: TMenuItem;
    MenuItemColours: TMenuItem;
    S11: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItemQGISSeparator: TMenuItem;
    MenuItemStartQGIS: TMenuItem;
    MenuItemLookupCodes: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    S10: TMenuItem;
    MenuItemOnline: TMenuItem;
    MenuItemDWS: TMenuItem;
    MenuItem35: TMenuItem;
    MenuItem36: TMenuItem;
    MenuItem37: TMenuItem;
    MenuItem38: TMenuItem;
    MenuItemPressure: TMenuItem;
    MenuItemLithProfile: TMenuItem;
    MenuItemWMS: TMenuItem;
    MenuItemChemData: TMenuItem;
    MenuItemChemImport: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItemBoxWhisker: TMenuItem;
    MenuItemVQB: TMenuItem;
    MenuItemSiteLinked: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItemReportDocs: TMenuItem;
    MenuItemOthrParam: TMenuItem;
    MenuItemChemCharts: TMenuItem;
    MenuItemLookupCodesReport: TMenuItem;
    MenuItemManRec: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItemSiteStatus: TMenuItem;
    MenuItemWriteMember: TMenuItem;
    MenuItemKMLFile: TMenuItem;
    MenuItemQGISMark: TMenuItem;
    MenuItemQGISGoTo: TMenuItem;
    MenuItemQGIS: TMenuItem;
    MenuItem2: TMenuItem;
    SeparatorMapping: TMenuItem;
    MenuItemMeterReadings: TMenuItem;
    S9: TMenuItem;
    DistanceCharts: TMenuItem;
    MenuItemTestingDetails: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItemGroundwaterProperties: TMenuItem;
    MenuItemBHProperties: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItemPumpingTest: TMenuItem;
    MenuItemElectricalCond: TMenuItem;
    MenuItemChemistryUnits: TMenuItem;
    MenuItemDiamMet: TMenuItem;
    MenuItemTime: TMenuItem;
    MenuItemPreferences: TMenuItem;
    MenuItemVolume: TMenuItem;
    MenuItemLength: TMenuItem;
    MenuItemUnits: TMenuItem;
    MenuItemFillMaterialColour: TMenuItem;
    MenuItemLithologyBitmaps: TMenuItem;
    MenuItemLookups: TMenuItem;
    MenuItemCreateEditUserStandards: TMenuItem;
    MenuItemCurrentStandard: TMenuItem;
    MenuItemPaste: TMenuItem;
    MenuItemCopy: TMenuItem;
    MenuItemCut: TMenuItem;
    MenuItemClearMarked: TMenuItem;
    MenuItemRemoveCurrent: TMenuItem;
    MenuItemSaveMarked: TMenuItem;
    MenuItemMarkCurrent: TMenuItem;
    MenuItemMarkSites: TMenuItem;
    SeparatorSQLite: TMenuItem;
    MenuBackUpSQLite: TMenuItem;
    MenuItemCreateView: TMenuItem;
    MenuItemSelectSites: TMenuItem;
    MenuItemSQLSearch: TMenuItem;
    MenuItemQuickSearch: TMenuItem;
    MenuVacuum: TMenuItem;
    MenuSQLiteDB: TMenuItem;
    OpenDialogWorkspace: TOpenDialog;
    MenuItemUpdateCoords: TMenuItem;
    MenuItemLithLog: TMenuItem;
    MenuItemEdit: TMenuItem;
    CreateEditUserStandard: TMenuItem;
    ToolButtonSiteManagement: TToolButton;
    SystemSettings: TMenuItem;
    RemoveCurrentMarkedSite: TMenuItem;
    SaveMarkedSites: TMenuItem;
    MenuItemResetView: TMenuItem;
    MenuItemSQLScript: TMenuItem;
    MenuItemNewSQLite: TMenuItem;
    MenuItemApplyCoords: TMenuItem;
    MenuItemImportOldAquabase: TMenuItem;
    S1: TMenuItem;
    N10: TMenuItem;
    N3: TMenuItem;
    MenuItemNewWorkspace: TMenuItem;
    MenuItemOpenWorkspace: TMenuItem;
    MenuItemPrint: TMenuItem;
    MenuItemPrintSetup: TMenuItem;
    MenuItemExit: TMenuItem;
    DropDownMenuTesting: TPopupMenu;
    DropdownMenuManagement: TPopupMenu;
    MenuItemHelpContents: TMenuItem;
    MenuItemHowToUse: TMenuItem;
    MenuItemAbout: TMenuItem;
    PrintDialog1: TPrintDialog;
    PrintSetupDialog1: TPrinterSetupDialog;
    MenuItemAccessData: TMenuItem;
    MenuItemBasicInformation: TMenuItem;
    MenuItemSurfaceHydrology: TMenuItem;
    MenuItemMeteorology: TMenuItem;
    MenuItemHydrochemistry: TMenuItem;
    MenuItemImport: TMenuItem;
    MenuItemExport: TMenuItem;
    MenuItemReports: TMenuItem;
    MenuItemGroundwater: TMenuItem;
    MenuItemAdditionalInformation: TMenuItem;
    MenuItemEngineering: TMenuItem;
    MenuItemWaterlevel: TMenuItem;
    MenuItemDischargerate: TMenuItem;
    MenuItemConstruction: TMenuItem;
    MenuItemBoreholelogs: TMenuItem;
    MenuItemAquiferTesting: TMenuItem;
    MenuItemPenetrationRate: TMenuItem;
    MenuItemAquifer: TMenuItem;
    MenuItemGeology: TMenuItem;
    SystemSettings1: TMenuItem;
    MenuItemCloseWorkspace: TMenuItem;
    Search1: TMenuItem;
    SetFilter1: TMenuItem;
    AppendDatabaseImport: TMenuItem;
    MenuItemTools: TMenuItem;
    MenuItemChangeSiteIdentifier: TMenuItem;
    MenuItemCharts: TMenuItem;
    MenuItemPageReports: TMenuItem;
    MenuItemColumnarReports: TMenuItem;
    SiteInformation2: TMenuItem;
    MenuChemistryReport: TMenuItem;
    BoreholeLog1: TMenuItem;
    ManagementRecommendation1: TMenuItem;
    ToolButtonTesting: TToolButton;
    TestPumping1: TMenuItem;
    MenuItemStatistics: TMenuItem;
    StageHeight1: TMenuItem;
    DischargeStreamFlow1: TMenuItem;
    MenuItemGeophysics: TMenuItem;
    MenuItemGround: TMenuItem;
    MenuItemDownHole: TMenuItem;
    MenuItemMagneticSuscept: TMenuItem;
    MenuItemProfiling: TMenuItem;
    Sounding1: TMenuItem;
    MenuItemInstrumentation: TMenuItem;
    MenuItemSiteSelection: TMenuItem;
    MenuItemNameofOwner: TMenuItem;
    MenuItemVisitstoSite: TMenuItem;
    OtherCases1: TMenuItem;
    MenuItemReferences: TMenuItem;
    MenuItemComments: TMenuItem;
    MenuItemHoleFinish: TMenuItem;
    MenuItemHoleConstruction: TMenuItem;
    MenuItemInstallation: TMenuItem;
    ChemistryStandard1: TMenuItem;
    MenuItemUseView: TMenuItem;
    ToolBar2: TToolBar;
    ToolBar4: TToolBar;
    ToolBar3: TToolBar;
    DividerCutCopyPaste: TToolButton;
    ToolButtonExit: TToolButton;
    ToolButtonResetView: TToolButton;
    MenuItemFieldMeasurement: TMenuItem;
    MenuItemOtherHole: TMenuItem;
    MenuItemOtherIdentifier: TMenuItem;
    MenuItemOtherData: TMenuItem;
    MenuItemSearchStatus: TMenuItem;
    MenuItemWaterSample: TMenuItem;
    ProjectManagement1: TMenuItem;
    MenuItemProjects: TMenuItem;
    MenuItemRecommendations: TMenuItem;
    LookupCodes1: TMenuItem;
    N14: TMenuItem;
    Units1: TMenuItem;
    MenuItemDeleteSites: TMenuItem;
    MenuItemSitespecific: TMenuItem;
    MenuItemDatabasespecific: TMenuItem;
    MenuItemReconcileSites: TMenuItem;
    S2: TMenuItem;
    PumpingTestData1: TMenuItem;
    Database1: TMenuItem;
    MenuItemMaintenance: TMenuItem;
    MenuItemPumpEngine: TMenuItem;
    StatusBar1: TStatusBar;
    MenuItemExpenditure: TMenuItem;
    MenuItemMember: TMenuItem;
    Length1: TMenuItem;
    ToolButtonUseView: TToolButton;
    Volume1: TMenuItem;
    Time1: TMenuItem;
    DiameterMeteor1: TMenuItem;
    Chemistry4: TMenuItem;
    ElectricalCond1: TMenuItem;
    MenuItemInsertCharacter: TMenuItem;
    Markcurrentsite1: TMenuItem;
    Savemarkedsites1: TMenuItem;
    Clearmarkedsites1: TMenuItem;
    SaveFilterDialog: TSaveDialog;
    Removelastmarkedsite1: TMenuItem;
    Marksites1: TMenuItem;
    ProjectInformation1: TMenuItem;
    SeparatorSQL: TMenuItem;
    SeparatorTools2: TMenuItem;
    MenuItemHelponShortcuts: TMenuItem;
    MenuItemUserdefinedParameters: TMenuItem;
    MenuItemManageFilters: TMenuItem;
    TimeCharts: TMenuItem;
    CurrentStandard1: TMenuItem;
    CreateEditStandard: TMenuItem;
    DepthCharts: TMenuItem;
    N27: TMenuItem;
    Editgeolbitmaps1: TMenuItem;
    ChemistryStandard2: TMenuItem;
    MenuItemStandardParameters: TMenuItem;
    N38: TMenuItem;
    N42: TMenuItem;
    Timedependent1: TMenuItem;
    Waterlevel2: TMenuItem;
    Dischargerate2: TMenuItem;
    Chemistry1: TMenuItem;
    Meterorology1: TMenuItem;
    Depthdependent1: TMenuItem;
    Distancedependent1: TMenuItem;
    MenuItemRainEvaporationHumidity: TMenuItem;
    MenuItemTemperatureRadiationWind: TMenuItem;
    Penetrationrate2: TMenuItem;
    Downtheholegeophysics1: TMenuItem;
    MenuItemGeoelectricMethods: TMenuItem;
    MenuItemRadioactiveMethods: TMenuItem;
    MenuItemRunSQLQuery: TMenuItem;
    FieldMeasurements1: TMenuItem;
    MeterReading2: TMenuItem;
    SiteMonitoringReport: TMenuItem;
    ToolButtonWaterLevel: TToolButton;
    XMLPropStorage1: TXMLPropStorage;
    Yield1: TMenuItem;
    GeophysicalInformation1: TMenuItem;
    MeterReading3: TMenuItem;
    Siteimages1: TMenuItem;
    MenuItemSiteTargets: TMenuItem;
    FillMaterialColour1: TMenuItem;
    SurfaceHydrology2: TMenuItem;
    S3: TMenuItem;
    MenuItemRecentWorkspaces: TMenuItem;
    S4: TMenuItem;
    N35: TMenuItem;
    MenuEditMap: TMenuItem;
    MenuItemHelp: TMenuItem;
    AddEditChemistryTables1: TMenuItem;
    N13: TMenuItem;
    MigrateUserChemistrydatatootherdefinedtables1: TMenuItem;
    DatatoFC1: TMenuItem;
    DropdownMenuConstr: TPopupMenu;
    HoleFinish2: TMenuItem;
    HoleConstruction2: TMenuItem;
    DropdownMenuChem: TPopupMenu;
    WaterSample3: TMenuItem;
    N18: TMenuItem;
    StandardParameters3: TMenuItem;
    UserdefinedParameters4: TMenuItem;
    DropdownMenuLogs: TPopupMenu;
    PenetrationRate3: TMenuItem;
    Aquifer2: TMenuItem;
    Geology2: TMenuItem;
    ZSQLProcessorSpatial: TZSQLProcessor;
    procedure ComboBoxFieldChange(Sender: TObject);
    procedure ComboBoxSearchChange(Sender: TObject);
    procedure ComboBoxSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MenuItemClearFilterClick(Sender: TObject);
    procedure MenuItemGetChmRefClick(Sender: TObject);
    procedure MenuItemQFieldClick(Sender: TObject);
    procedure MenuItemQuickSearchToolBarClick(Sender: TObject);
    procedure MenuItemStoredCoordsClick(Sender: TObject);
    procedure SearchQueryBeforeOpen(DataSet: TDataSet);
    procedure SpeedButtonClearClick(Sender: TObject);
    procedure ToolBar1StartDrag(Sender: TObject; var DragObject: TDragObject
      );
    procedure ToolBar2StartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MenuChemistryReportClick(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItemOpenQGISProjectClick(Sender: TObject);
    procedure MenuItemPrepWSpaceQGISClick(Sender: TObject);
    procedure MenuItemRecoverIndexClick(Sender: TObject);
    procedure MenuItemGeoSiteListClick(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItemSYNOPClick(Sender: TObject);
    procedure MenuItemWeatherSAClick(Sender: TObject);
    procedure MenuItemFlagClick(Sender: TObject);
    procedure MenuItemMeteoReportClick(Sender: TObject);
    procedure MenuItemAllsitesClick(Sender: TObject);
    procedure MenuItemAppFontClick(Sender: TObject);
    procedure MenuItemCrsinfoClick(Sender: TObject);
    procedure MenuItemCutClick(Sender: TObject);
    procedure MenuItemDepthClick(Sender: TObject);
    procedure MenuItemGraduatedClick(Sender: TObject);
    procedure MenuItemPasteClick(Sender: TObject);
    procedure MenuItemPrintSetupClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormWindowStateChange(Sender: TObject);
    procedure DistanceChartsClick(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItemBoxWhiskerClick(Sender: TObject);
    procedure MenuItemChemDataClick(Sender: TObject);
    procedure MenuItemLithLogClick(Sender: TObject);
    procedure MenuItemManageFiltersClick(Sender: TObject);
    procedure MenuBackUpSQLiteClick(Sender: TObject);
    procedure MenuItemColoursClick(Sender: TObject);
    procedure MenuItemStartQGISClick(Sender: TObject);
    procedure MenuItem22Click(Sender: TObject);
    procedure MenuItemDWSClick(Sender: TObject);
    procedure MenuItemLithProfileClick(Sender: TObject);
    procedure MenuItemPressureClick(Sender: TObject);
    procedure MenuItemViewCurrentClick(Sender: TObject);
    procedure MenuItemViewViewClick(Sender: TObject);
    procedure MenuItemVQBClick(Sender: TObject);
    procedure MenuItemChemChartsClick(Sender: TObject);
    procedure MenuItemKMLFileClick(Sender: TObject);
    procedure MenuItemLookupCodesReportClick(Sender: TObject);
    procedure MenuItemOthrParamClick(Sender: TObject);
    procedure MenuItemQGISMarkClick(Sender: TObject);
    procedure MenuItemCopyClick(Sender: TObject);
    procedure MenuItemQGISGoToClick(Sender: TObject);
    procedure MenuItemReloadLookupClick(Sender: TObject);
    procedure MenuItemReportDocsClick(Sender: TObject);
    procedure MenuItemSaveMarkedClick(Sender: TObject);
    procedure MenuItemSiteLinkedClick(Sender: TObject);
    procedure MenuItemSiteStatusClick(Sender: TObject);
    procedure MenuItemWMSClick(Sender: TObject);
    procedure MenuItemWriteMemberClick(Sender: TObject);
    procedure MenuVacuumClick(Sender: TObject);
    procedure OpenDialogWorkspaceCanClose(Sender: TObject; var CanClose: boolean);
    procedure OpenDialogWorkspaceHelpClicked(Sender: TObject);
    procedure ToolBar3StartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure ToolBar4StartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure TimeChartsClick(Sender: TObject);
    procedure MenuItemUpdateCoordsClick(Sender: TObject);
    procedure MenuItemResetViewClick(Sender: TObject);
    procedure MenuItemSQLScriptClick(Sender: TObject);
    procedure MenuItemNewSQLiteClick(Sender: TObject);
    procedure MenuItemPumpingTestClick(Sender: TObject);
    procedure MenuItemApplyCoordsClick(Sender: TObject);
    procedure MenuItemImportOldAquabaseClick(Sender: TObject);
    procedure CreateViewClick(Sender: TObject);
    procedure ShowHint(Sender: TObject);
    procedure AppIdle(Sender: TObject; var Done: Boolean);
    procedure FileNew(Sender: TObject);
    procedure FilePrint(Sender: TObject);
    procedure FileExit(Sender: TObject);
    procedure HelpContents(Sender: TObject);
    procedure HelpHowToUse(Sender: TObject);
    procedure HelpAbout(Sender: TObject);
    procedure MenuItemBasicInformationClick(Sender: TObject);
    procedure MenuItemOpenWorkspaceClick(Sender: TObject);
    procedure ToolButtonQuickSearch1Click(Sender: TObject);
    procedure UpdateMenus;
    procedure MenuItemWaterlevelClick(Sender: TObject);
    procedure MenuItemDischargerateClick(Sender: TObject);
    procedure MenuItemCloseWorkspaceClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure MenuItemGeologyClick(Sender: TObject);
    procedure SQLSearchClick(Sender: TObject);
    procedure SystemSettingsClick(Sender: TObject);
    procedure MenuItemUseViewClick(Sender: TObject);
    procedure MenuItemAquiferClick(Sender: TObject);
    procedure Quicksearch1Click(Sender: TObject);
    procedure SelectSites1Click(Sender: TObject);
    procedure MenuItemHoleFinishClick(Sender: TObject);
    procedure MenuItemHoleConstructionClick(Sender: TObject);
    procedure MenuItemInstallationClick(Sender: TObject);
    procedure MenuItemCommentsClick(Sender: TObject);
    procedure MenuItemReferencesClick(Sender: TObject);
    procedure MenuItemPenetrationRateClick(Sender: TObject);
    procedure MenuItemNameofOwnerClick(Sender: TObject);
    procedure MenuItemOtherIdentifierClick(Sender: TObject);
    procedure MenuItemVisitstoSiteClick(Sender: TObject);
    procedure MenuItemFieldMeasurementClick(Sender: TObject);
    procedure MenuItemSiteSelectionClick(Sender: TObject);
    procedure MenuItemWaterSampleClick(Sender: TObject);
    procedure PumpingTestData1Click(Sender: TObject);
    procedure MenuItemPumpEngineClick(Sender: TObject);
    procedure MenuItemMaintenanceClick(Sender: TObject);
    procedure Database1Click(Sender: TObject);
    procedure MenuItemProjectsClick(Sender: TObject);
    procedure MenuItemManRecClick(Sender: TObject);
    procedure ManagementRecommendation1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItemDeleteSitesClick(Sender: TObject);
    procedure LookupCodesClick(Sender: TObject);
    procedure EditLengthClick(Sender: TObject);
    procedure EditVolumeClick(Sender: TObject);
    procedure EditTimeClick(Sender: TObject);
    procedure EditDiameterMeteorClick(Sender: TObject);
    procedure EditChemistryClick(Sender: TObject);
    procedure EditElectricalCondClick(Sender: TObject);
    procedure MenuItemInstrumentationClick(Sender: TObject);
    procedure StageHeight1Click(Sender: TObject);
    procedure DischargeStreamFlow1Click(Sender: TObject);
    procedure MenuItemExpenditureClick(Sender: TObject);
    procedure MenuItemMemberClick(Sender: TObject);
    procedure MenuItemInsertCharacterClick(Sender: TObject);
    procedure WorkspaceImportClick(Sender: TObject);
    procedure TestingDetails1Click(Sender: TObject);
    procedure LocationandChemistry1Click(Sender: TObject);
    procedure MarkcurrentsiteClick(Sender: TObject);
    procedure SavemarkedsitesClick(Sender: TObject);
    procedure ClearmarkedsitesClick(Sender: TObject);
    procedure RemovecurrentmarkedsiteClick(Sender: TObject);
    procedure LocationandManagement1Click(Sender: TObject);
    procedure LastWSpaceClick(Sender: TObject);
    procedure UpdateWSpaceMenu(Add: Boolean);
    procedure MenuItemMagneticSusceptClick(Sender: TObject);
    procedure TestPumping1Click(Sender: TObject);
    procedure SiteInformation2Click(Sender: TObject);
    procedure MenuItemChangeSiteIdentifierClick(Sender: TObject);
    procedure MeterReading1Click(Sender: TObject);
    procedure MenuItemOtherHoleClick(Sender: TObject);
    procedure MenuItemOtherDataClick(Sender: TObject);
    procedure MenuItemSearchStatusClick(Sender: TObject);
    procedure OtherCases1Click(Sender: TObject);
    procedure MenuItemProfilingClick(Sender: TObject);
    procedure BoreholeLog1Click(Sender: TObject);
    function InitWSpace: Boolean;
    procedure MenuItemHelponShortcutsClick(Sender: TObject);
    procedure MenuItemUserdefinedParametersClick(Sender: TObject);
    procedure BoreholeLog2Click(Sender: TObject);
    procedure CurrentStandardClick(Sender: TObject);
    procedure CreateEditStandardClick(Sender: TObject);
    procedure ProjectInformation1Click(Sender: TObject);
    procedure EditgeolbitmapsClick(Sender: TObject);
    procedure ChemistryStandard2Click(Sender: TObject);
    procedure MenuItemStandardParametersClick(Sender: TObject);
    procedure Waterlevel2Click(Sender: TObject);
    procedure Dischargerate2Click(Sender: TObject);
    procedure Meterorology1Click(Sender: TObject);
    procedure MenuItemRainEvaporationHumidityClick(Sender: TObject);
    procedure MenuItemTemperatureRadiationWindClick(Sender: TObject);
    procedure Chemistry1Click(Sender: TObject);
    procedure GroundwaterProperties1Click(Sender: TObject);
    procedure MenuItemRunSQLQueryClick(Sender: TObject);
    procedure Boreholeproperties1Click(Sender: TObject);
    procedure MenuItemGeoelectricMethodsClick(Sender: TObject);
    procedure MenuItemRadioactiveMethodsClick(Sender: TObject);
    procedure ButtonsUp(const TheToolBar: TToolBar; NotUp: ShortInt);
    procedure FieldMeasurements1Click(Sender: TObject);
    procedure MeterReading2Click(Sender: TObject);
    procedure SiteMonitoringReportClick(Sender: TObject);
    procedure Penetrationrate2Click(Sender: TObject);
    procedure XMLPropStorage1RestoreProperties(Sender: TObject);
    procedure XMLPropStorage1SavingProperties(Sender: TObject);
    procedure Yield1Click(Sender: TObject);
    procedure Downtheholegeophysics1Click(Sender: TObject);
    procedure GeophysicalInformation1Click(Sender: TObject);
    procedure MenuItemReconcileSitesClick(Sender: TObject);
    procedure Distancedependent1Click(Sender: TObject);
    procedure MeterReading3Click(Sender: TObject);
    procedure Siteimages1Click(Sender: TObject);
    procedure MenuItemDatabasespecificClick(Sender: TObject);
    procedure MenuItemSitespecificClick(Sender: TObject);
    procedure MenuItemSiteTargetsClick(Sender: TObject);
    procedure DewateringSummary1Click(Sender: TObject);
    procedure EditFillMaterialColourClick(Sender: TObject);
    procedure SurfaceHydrology2Click(Sender: TObject);
    procedure DatatoFC1Click(Sender: TObject);
  private
    DefaultSettingsDir, TheSearchText: String;
    FileVer, ProdVer, FormName: ShortString;
    WspaceActive: Boolean;
  public

  end;

var
  MainForm: TMainForm;

implementation

uses
  VARINIT, Basicinf, Waterlev, Discharg, Geology, SQLSEACH, Sysset,
  Filter, Aquifer, QUICKSCH, SELSITES, holefinish, INSTALLA, Comments,
  Referenc, Pumptest, BHConstr, Stream, Penetrat, Nameownr, Otherid, Sitevisi,
  Fldmeas, Sitesele, Watersam, PMPIMPRT, Instdetl, Maintain, PROJ_MAN,
  Recommnd, Editform, Instrmnt, Stagehi, Expendit, Member,
  Testdetl, Magnetic, Meteread, Userchem, EditLogPattern,
  Othrhole, Otherdat, Searchst, Specases, NewWSpace, Profilng, Meteor2,
  Meteor1, Chemistry, GWProp, BHProp, Geoelectric, RadioAct, SQLForm,
  Targets, ExpDewater, TIMEDEPT,
  //New 2015
  MainDataModule, SelectView, manviews, applycoord,
  GeollogSetForm, Imprtdat, imprtOldAB, applynewsqlite,
  ChSiteID, Append, runsqlscript, provideviewname, aboutbox, reconsileSites,
  InsChar, DbStats, EditFillColour, Delsites, EditColours, writekml,
  writemember, sitestatus, FCdata, chemchartsettings, reportdocuments,
  fileinfo, sitelinkedreports, hydreservoir, QBuilder, QBEZEOS, importwms,
  boxsettings, loggerimport, importchem, lithprofilesettings,
  //New 2020
  crsinfo, mapview, graduatedmap, flagrecords, importrain, importSYNOP,
  importdwsaudited, geositelist,
  //New 2025
  storedcoordsin, qfieldimport,
  //Reports
  Manrecset, TRepSet, BasicSet, lookuprepset, repsettingschem, repsettingssurfwatr,
  repsettingstimechem, repsettingstimewl, repsettingstimedis, repsettingstimedepth,
  repsettingssitemon, repsettingsmeteor;

resourcestring
  MainMenuFile = '&File';
  MainMenuDatabase = '&Database';
  SPanel1 = '<no view>';
  SPanel2 = '<no site>';
  SPanel3 = 'Editing: <none>';
  SPanel4 = '<no workspace open>';
  SPanelOpening = 'Please wait, opening database "';

{$R *.lfm}

function DownloadFTP(URL, TargetFile: string): boolean;
const
  FTPPort=21;
  FTPScheme='ftp://'; //URI scheme name for FTP URLs
var
  Host: string;
  Port: integer;
  Source: string;
  FoundPos: integer;
begin
  // Strip out scheme info:
  if LeftStr(URL, length(FTPScheme)) = FTPScheme then URL := Copy(URL, length(FTPScheme)+1, length(URL));

  // Crude parsing; could have used URI parsing code in FPC packages...
  FoundPos := pos('/', URL);
  Host := LeftStr(URL, FoundPos-1);
  Source := Copy(URL, FoundPos+1, Length(URL));

  //Check for port numbers:
  FoundPos := pos(':', Host);
  Port := FTPPort;
  if FoundPos > 0 then
  begin
    Host := LeftStr(Host, FoundPos-1);
    Port := StrToIntDef(Copy(Host, FoundPos + 1, Length(Host)), 21);
  end;
  Result := FtpGetFile(Host, IntToStr(Port), Source, TargetFile, 'aquabase@blecher.co.za', 'aqua2015');
  if result = false then ShowMessage('Error checking for/downloading Aquabase Update at '+ URL +'. Details: host: '+ Host +'; port: '+Inttostr(Port)+'; remote path: ' + Source + ' to ' + TargetFile + '. Please check your Internet connection!');
end;

constructor TMyThread.Create(CreateSuspended: boolean);
begin
  FreeOnTerminate := True;
  inherited Create(CreateSuspended);
end;

procedure TMyThread.Execute;
var
  ReadMeText: TStringList;
  AVer: ShortString;
  Process: TProcess;
  i: Integer;
  FileVerInfo: TFileVersionInfo;
begin
  //check if Aquabase update available
  if FileExists(GetTempDir + 'Aquabase_Update.exe') then
  begin
    case MessageDlg('An Aquabase Update has previously been downloaded and is ready for installation! Do you want to update Aquabase now? (Close Aquabase for the update)! "IGNORE" to ask later again, "NO" to delete the download.', mtConfirmation, [mbYes, mbIgnore, mbNo], 0) of
        mrYes: begin
                 Process := TProcess.Create(nil);
                 try
                   Process.InheritHandles := False;
                   Process.Options := [];
                   Process.ShowWindow := swoShow;
                    // Copy default environment variables including DISPLAY variable for GUI application to work
                   for i := 1 to GetEnvironmentVariableCount do
                     Process.Environment.Add(GetEnvironmentString(i));
                   Process.Executable := GetTempDir + 'Aquabase_Update.exe';
                   Process.Execute;
                 finally
                   Process.Free;
                 end;
               end;
         mrNo: begin
                 DeleteFile(GetTempDir + 'Aquabase_Update.exe');
                 DeleteFile(GetTempDir + 'aquabase_readme.txt');
               end;
         mrIgnore: MessageDlg('Aquabase update ignored! You will be asked again next time Aquabase is started.', mtInformation, [mbOK], 0);
    end; //of case
  end
  else
  begin
    ReadMeText := TStringList.Create;
    if DownloadFTP('ftp://ftp.blecher.co.za/readme.txt', GetTempDir + 'aquabase_readme.txt') then
    begin
      ReadMeText.LoadFromFile(GetTempDir + 'aquabase_readme.txt');
      AVer := Copy(ReadMeText[0], Pos('Build: ', ReadmeText[0]) + 7, 9);
      FileVerInfo := TFileVersionInfo.Create(nil);
      FileVerInfo.ReadFileInfo;
      //check for newer file version and download
      if AVer > FileVerInfo.VersionStrings.Values['FileVersion'] then
      begin
        FileVerInfo.Free;
        if DownloadFTP('ftp://ftp.blecher.co.za/Aquabase_Update.exe', GetTempDir + 'Aquabase_Update.exe') then
        begin
          if MessageDlg('An Aquabase Update has been downloaded and is ready for installation! Do you want to update Aquabase now? (Close Aquabase for the update!)', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
          begin
            Process := TProcess.Create(nil);
            try
              Process.InheritHandles := False;
              Process.Options := [];
              Process.ShowWindow := swoShow;

              // Copy default environment variables including DISPLAY variable for GUI application to work
              for i := 1 to GetEnvironmentVariableCount do
                Process.Environment.Add(GetEnvironmentString(i));

              Process.Executable := GetTempDir + 'Aquabase_Update.exe';
              Process.Execute;
            finally
              Process.Free;
            end;
          end;
        end;
      end;
    end;
    // do stuff
    ReadMeText.Free;
  end;
end;

procedure TMainForm.ShowHint(Sender: TObject);
begin
  StatusBar1.Panels[0].Text := Application.Hint;
end;

procedure TMainForm.AppIdle(Sender: TObject; var Done: Boolean);
begin
  if Assigned(Screen.ActiveForm) and (Screen.ActiveForm.Name <> 'MainForm') then
    FormName := Screen.ActiveForm.Name;
  if Screen.FormCount = 1 then //only the mainform
    FormName := '';
  //Update StatusBar
  if WSpaceActive then
    StatusBar1.Panels[1].Text := FilterName;
  if (MarkedSiteList <> Nil) and (MarkedSiteList.IndexOf(CurrentSite) > -1) then
    StatusBar1.Panels[2].Text := CurrentSite + '*'
  else StatusBar1.Panels[2].Text := CurrentSite;
  if Editing > '' then
    StatusBar1.Panels[3].Text := Editing
  else
    StatusBar1.Panels[3].Text := SPanel3;
  //Control Cut, Copy, Paste functions
  MenuItemCut.Enabled := HasSelection and CanCut;
  MenuItemCopy.Enabled := HasSelection;
  MenuItemPaste.Enabled := CanPaste and Clipboard.HasFormat(CF_TEXT);
  ToolButtonCut.Enabled := HasSelection and CanCut;
  ToolButtonCopy.Enabled := HasSelection;
  ToolButtonPaste.Enabled := CanPaste and Clipboard.HasFormat(CF_TEXT);
  //Update Printing Controls
  MenuItemPrint.Enabled := FormName > '';
  //Check for Filter on Basicinf
  MenuItemClearFilter.Enabled := DataModuleMain.BasicinfQuery.Filter <> '';
  //check if settings need to be saved
  if SaveSettings then
  begin
    XMLPropStorage1.Save;
    SaveSettings := False;
  end;
  if ViewChanged then
  begin
    MenuItemResetView.Enabled := FilterName <> 'allsites';
    ToolButtonResetView.Enabled := MenuItemResetView.Enabled;
    ViewChanged := False;
  end;
  Application.ProcessMessages;
end;

procedure TMainForm.FileNew(Sender: TObject);
begin
  with TNewWSpaceForm.Create(Application) do
  begin
    ShowModal;
    if ModalResult = mrOK then
    begin
      FilterName := 'allsites';
      if InitWSpace then
      begin
        CurrentSite := '';
        CopyFile(ProgramDir + DirectorySeparator + 'splash_logo.jpg', WSpaceDir + DirectorySeparator + 'userlogo.jpg');
        UpdateMenus;
        UpdateWSpaceMenu(True);
        MessageDlg('The workspace "' + WSpaceDir + '" was successfully created!',
          mtInformation, [mbOK], 0);
      end
      else MessageDlg('The workspace could not be created!', mtError, [mbOK], 0);
    end
    else
    begin
      WSpaceActive := False;
      WSpaceDir := '';
      StatusBar1.Panels[4].Text := SPanel4;
    end;
  end;
end;

procedure TMainForm.FilePrint(Sender: TObject);
var
  TheActiveForm: TForm;
  myBitMap : TBitMap;
  rct: TRect;
  HScaleFactor, VScaleFactor: Single;
  {$IFDEF WINDOWS}
  PrintDialog: TRLPrintDialog;
  {$ENDIF}
begin
  if FormName > '' then
  begin
    TheActiveForm := Application.FindComponent(FormName) as TForm;
    if TheActiveForm <> NIL then
    case TheActiveForm.Tag of
      50: begin //RLPreview
            {$IFDEF WINDOWS}
            PrintDialog := TRLPrintDialog.CreateNew(Nil);
            with PrintDialog do
            begin
              FromPage := (TheActiveForm.FindComponent('RLPreview1') as TRLPreview).Pages.FirstPageNumber;
              ToPage := (TheActiveForm.FindComponent('RLPreview1') as TRLPreview).Pages.LastPageNumber;
              if Execute then
              begin
                FilterPages((TheActiveForm.FindComponent('RLPreview1') as TRLPreview).Pages, Nil, PrintDialog.FromPage, PrintDialog.ToPage, PrintDialog.PageRanges, 0);
              end;
            end;
            {$ENDIF}
            {$IFDEF UNIX}
            with PrintDialog1 do
            begin
              FromPage := (TheActiveForm.FindComponent('RLPreview1') as TRLPreview).Pages.FirstPageNumber;
              ToPage := (TheActiveForm.FindComponent('RLPreview1') as TRLPreview).Pages.LastPageNumber;
              if Execute then
              begin
                FilterPages((TheActiveForm.FindComponent('RLPreview1') as TRLPreview).Pages, Nil, FromPage, ToPage, '', 0);
              end;
            end;
            {$ENDIF}
          end;
      127, 128, 129:
         if PrintDialog1.Execute then
         begin
           //ActiveMDIChild.Print;
            HScaleFactor:=Printer.XDPI/Screen.PixelsPerInch;
            VScaleFactor:=Printer.YDPI/Screen.PixelsPerInch;
            myBitMap := TBitMap.Create;
            try
              myBitMap.LoadFromDevice(TheActiveForm.Canvas.Handle);
              rct:=Rect(0, 0, trunc(myBitMap.Width*HScaleFactor), trunc(myBitMap.Height*VScaleFactor));
              Printer.Title := TheActiveForm.Caption;
              Printer.BeginDoc;
              try
                Printer.Canvas.StretchDraw(rct, myBitMap);
              finally
                Printer.EndDoc;
              end;
            finally
              myBitMap.Free;
            end;
         end;
    133: if PrintDialog1.Execute then //the map
         begin
            HScaleFactor:=Printer.XDPI/Screen.PixelsPerInch;
            VScaleFactor:=Printer.YDPI/Screen.PixelsPerInch;
            myBitMap := TBitMap.Create;
            try
              myBitMap.LoadFromDevice((TheActiveForm.FindChildControl('MapView') as TMapView).Canvas.Handle);
              rct:=Rect(0, 0, trunc(myBitMap.Width*HScaleFactor), trunc(myBitMap.Height*VScaleFactor));
              Printer.Title := TheActiveForm.Caption;
              Printer.BeginDoc;
              try
                Printer.Canvas.StretchDraw(rct, myBitMap);
              finally
                Printer.EndDoc;
              end;
            finally
              myBitMap.Free;
            end;
         end;
    end; {of case}
    if TheActiveForm <> NIL then
      TheActiveForm.BringToFront;
  end
  else
    MessageDlg('No form active for printing! Please click on a form first and try again.', mtWarning, [mbOK], 0);
end;

procedure TMainForm.FileExit(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    DataModuleMain.OpenHelp(Sender);
end;

procedure TMainForm.ToolBar2StartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  CoolBar1.Bands[1].Break := False;
end;

procedure TMainForm.ToolBar1StartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  CoolBar1.Bands[0].Break := False;
end;

procedure TMainForm.MenuItemStoredCoordsClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
    if VerDiff > 2 then
      MessageDlg(VersionMessage, mtError,[mbOK], 0)
    else
    {$ENDIF}
  with TFormStoredCoords.Create(Application) do
  begin
    ShowModal;
  end;
end;

procedure TMainForm.ComboBoxSearchChange(Sender: TObject);
begin
  ToolButtonQuickSearch1.Hint := 'Search';
  ToolButtonQuickSearch1.Enabled := ComboBoxSearch.Text > '';
  SearchQuery.Close;
end;

procedure TMainForm.ComboBoxSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    ToolButtonQuickSearch1Click(Sender);
end;

procedure TMainForm.MenuItemClearFilterClick(Sender: TObject);
begin
  with DataModuleMain do
  begin
    BasicinfQuery.Filter := '';
    ZQueryView.Close;
    ZQueryView.Open;
  end;
end;

procedure TMainForm.MenuItemGetChmRefClick(Sender: TObject);
begin
  with DataModuleMain.CheckQuery do
  begin
    Connection := DataModuleMain.ZConnectionDB;
    SQL.Clear;
    SQL.Add('SELECT max(CHM_REF_NR) from  chem_000');
    Open;
    MessageDlg('The highest chemistry reference number in this database is '
      + Fields[0].AsString + '.', mtInformation, [mbOK], 0);
    Close;
  end;
end;

procedure TMainForm.MenuItemQFieldClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 2 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  begin
    if not FileExists(WSpaceDir + '/QFieldProject.gpkg') then
    begin
      if MessageDlg('This procedure will prepare your workspace for data entry and management in QField.' +
        ' Only sites in the current View will be transferred to the QField project database!' +
        ' You can then transfer the QFieldProject.gpkg in the workspace to your tablet or phone into a location where QField can find it.', mtInformation, [mbOK, mbCancel], 0) = mrOK then
        begin
          CopyFile(ProgramDir + DirectorySeparator + 'defaults' + DirectorySeparator + 'QFieldProject_za.gpkg', WSpaceDir + DirectorySeparator + 'QFieldProject.gpkg');
          with TFormQFieldImport.Create(Application) do
            ShowModal;
        end;
    end
    else
    begin
      if MessageDlg('This workspace has already been prepared for data entry and management in QField! Are you sure you want to prepare and open the workspace again?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        CopyFile(ProgramDir + DirectorySeparator + 'defaults' + DirectorySeparator + 'QFieldProject_za.gpkg', WSpaceDir + DirectorySeparator + 'QFieldProject.gpkg');
        with TFormQFieldImport.Create(Application) do
          ShowModal;
      end;
    end;
  end;
end;

procedure TMainForm.MenuItemQuickSearchToolBarClick(Sender: TObject);
begin
  ComboBoxSearch.SetFocus;
end;

procedure TMainForm.ComboBoxFieldChange(Sender: TObject);
begin
  ToolButtonQuickSearch1.Hint := 'Search';
  ToolButtonQuickSearch1.Enabled := ComboBoxSearch.Text > '';
  SearchQuery.Close;
end;

procedure TMainForm.SearchQueryBeforeOpen(DataSet: TDataSet);
begin
  with SearchQuery do
  begin
    Connection := DataModuleMain.ZConnectionDB;
    SQL.Clear;
    SQL.Add('SELECT * FROM basicinf ');
    case DataModuleMain.ZConnectionDB.Tag of
      1: SQL.Add('WHERE ' + ComboBoxField.Text + ' LIKE ' + QuotedStr('%' + ComboBoxSearch.Text + '%'));
      2, 3, 5: SQL.Add('WHERE LOWER(' + ComboBoxField.Text + ') LIKE LOWER(' + QuotedStr('%' + ComboBoxSearch.Text + '%') + ')');
      4: SQL.Add('WHERE ' + ComboBoxField.Text + ' ILIKE ' + QuotedStr('%' + ComboBoxSearch.Text + '%'));
    end; //of case
  end;
end;

procedure TMainForm.SpeedButtonClearClick(Sender: TObject);
begin
  with ComboBoxSearch do
  begin
    TheSearchText := Text;
    Clear;
    Text := TheSearchText;
    SetFocus;
  end;
end;

procedure TMainForm.MenuChemistryReportClick(Sender: TObject);
begin
  with TChemReportSettingsForm.Create(Application) do
    Show;
end;

procedure TMainForm.MenuItem10Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 3 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TFormDWSAudited.Create(Application) do
  begin
    SingleSite := True;
    ShowModal;
  end;
end;

procedure TMainForm.MenuItemOpenQGISProjectClick(Sender: TObject);
var
  AProcess: TProcess;
begin
  with OpenDialogQGISProjects do
  begin
    InitialDir := WSpaceDir;
    if Execute and
      (MessageDlg('Are you sure you want to open this project in QGIS?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    begin
      AProcess := TProcess.Create(nil);
      try
        {$IFDEF WINDOWS}
        AProcess.Executable := QGISExe;
        {$ENDIF}
        {$IFDEF UNIX}
        AProcess.Executable := 'qgis';
        {$ENDIF}
        AProcess.Parameters.Add('--nologo');
        AProcess.Parameters.Add('--project');
        AProcess.Parameters.Add(OpenDialogQGISProjects.FileName);
        AProcess.Execute;
        MessageDlg('QGIS has been started with project ' + OpenDialogQGISProjects.FileName + '. Please wait a few moments for the map window to open...', mtInformation, [mbOK], 0);
      except on E: EProcess do
        MessageDlg('QGIS could not be started! Please check the path to your QGIS executable in the Aquabase Preferences.', mtInformation, [mbOK], 0);
      end;
      AProcess.Free;
    end;
  end;
end;

procedure TMainForm.MenuItemPrepWSpaceQGISClick(Sender: TObject);
var
  AProcess: TProcess;
begin
  if not FileExists(WSpaceDir + '/Aquabase Data Management.qgz') then
  begin
    if MessageDlg('This procedure will prepare and open your workspace for data entry and management in QGIS.' + LineEnding + LineEnding +
      'Make sure to enable the initial macros, which will set all necessary database settings and set the map extent to the visible sites.' +
      ' If some layers could not be openend, you can just keep those unavailable layers, which may automatically become available at a later stage.' +
      ' You can also remove those layers or any other layers not required.' + LineEnding + LineEnding +
      'If all goes well you may save the project with a new name in your workspace and close and open it again to disable the macros in your QGIS project properties.' +
      ' You can from then on open your QGIS projects in the workspace directly from Aquabase.', mtInformation, [mbOK, mbCancel], 0) = mrOK then
      begin
        CopyFile(ProgramDir + DirectorySeparator + 'defaults' + DirectorySeparator + 'Aquabase Data Management.qgz', WSpaceDir + DirectorySeparator + 'Aquabase Data Management.qgz');
        AProcess := TProcess.Create(nil);
        try
          {$IFDEF WINDOWS}
          AProcess.Executable := QGISExe;
          {$ENDIF}
          {$IFDEF UNIX}
          AProcess.Executable := 'qgis';
          {$ENDIF}
          AProcess.Parameters.Add('--nologo');
          AProcess.Parameters.Add('--project');
          AProcess.Parameters.Add('Aquabase Data Management.qgz');
          AProcess.Execute;
          MessageDlg('QGIS has been started with this workspace. Make sure to enable the macros to prepare the QGIS project for this workspace! Please wait a few moments for the map window to open with the initial project...', mtInformation, [mbOK], 0);
        except on E: EProcess do
          MessageDlg('QGIS could not be started! Please check the path to your QGIS executable in the Aquabase Preferences.', mtInformation, [mbOK], 0);
        end;
        AProcess.Free;
      end;
  end
  else
  begin
    if MessageDlg('This workspace has already been prepared for data entry and management in QGIS! Are you sure you want to prepare and open the workspace again?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      CopyFile(ProgramDir + DirectorySeparator + 'defaults' + DirectorySeparator + 'Aquabase Data Management.qgz', WSpaceDir + DirectorySeparator + 'Aquabase Data Management.qgz');
      AProcess := TProcess.Create(nil);
      try
        {$IFDEF WINDOWS}
        AProcess.Executable := QGISExe;
        {$ENDIF}
        {$IFDEF UNIX}
        AProcess.Executable := 'qgis';
        {$ENDIF}
        AProcess.Parameters.Add('--nologo');
        AProcess.Parameters.Add('--project');
        AProcess.Parameters.Add('Aquabase Data Management.qgz');
        AProcess.Execute;
        MessageDlg('QGIS has been started with this workspace. Make sure to enable the macros again to prepare the QGIS project for this workspace! Please wait a few moments for the map window to open with the initial project...', mtInformation, [mbOK], 0);
      except on E: EProcess do
        MessageDlg('QGIS could not be started! Please check the path to your QGIS executable in the Aquabase Preferences.', mtInformation, [mbOK], 0);
      end;
      AProcess.Free;
    end;
  end;
end;

procedure TMainForm.MenuItemRecoverIndexClick(Sender: TObject);
begin
  if MessageDlg('Recover spatial index', 'This will recover the required SpatiaLite/Geopackage database indexes. Are you sure you want to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Screen.Cursor := crSQLWait;
    with DataModuleMain.ZConnectionDB do
    begin
      ExecuteDirect('SELECT RecoverSpatialIndex(' + QuotedStr('basicinf') + ', ' + QuotedStr('GEOMETRY') + ')');
      ExecuteDirect('SELECT RecoverSpatialIndex(' + QuotedStr('profilng') + ', ' + QuotedStr('GEOMETRY') + ')');
    end;
    Screen.Cursor := crDefault;
    ShowMessage('Spatial indexes for tables "basicinf" and "profilng" have been recovered.');
  end;
end;

procedure TMainForm.MenuItemGeoSiteListClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 3 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TGeoSiteListForm.Create(Application) do
  begin
    ShowModal
  end;
end;

procedure TMainForm.MenuItem3Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 3 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TEditLookupForm.Create(Application) do
  begin
    EditDataSource.DataSet := ChemParamsQuery;
    Caption := 'Edit Chemistry Parameters for Reports';
    ShowModal
  end;
end;

procedure TMainForm.MenuItem8Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 3 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TFormDWSAudited.Create(Application) do
  begin
    SingleSite := False;
    ShowModal;
  end;
end;

procedure TMainForm.MenuItemSYNOPClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 3 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  if DataModuleMain.BasicinfQuerySITE_TYPE.AsString = 'N' then
    with TFormSYNOP.Create(Application) do
      ShowModal
  else
    MessageDlg('This site does not seem to be a meteorological station! Please move to a site that is a meteorological station (lookup code "N") before attempting this import function.', mtError, [mbOK], 0);
end;

procedure TMainForm.MenuItemWeatherSAClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 3 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TImportRainForm.Create(Application) do
    Show;
end;

procedure TMainForm.MenuItemFlagClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
    if VerDiff > 2 then
      MessageDlg(VersionMessage, mtError,[mbOK], 0)
    else
    {$ENDIF}
  with TFlagForm.Create(Application) do
  begin
    ShowModal;
  end;
end;

procedure TMainForm.MenuItemMeteoReportClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
    if VerDiff > 2 then
      MessageDlg(VersionMessage, mtError,[mbOK], 0)
    else
    {$ENDIF}
  with TMeteoReportSettingsForm.Create(Application) do
  begin
    with AvailableTablesList do
    begin
      Add('basicinf');
      Add('rainfall');
      Add('humidity');
      Add('pan_evap');
      Add('air_temp');
      Add('pressure');
      Add('solaradi');
      Add('windvdir');
    end;
    ShowModal;
  end;
end;

procedure TMainForm.MenuItemAllsitesClick(Sender: TObject);
var
  CreateTheMap: Boolean;
begin
  CreateTheMap := True;
  {$IFDEF WINDOWS}
  if VerDiff > 2 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  if DataModuleMain.ZQueryView.RecordCount > 5000 then
    if MessageDlg('The "allsites" View has more than 5000 records, which may take a while to display on the map! Are you sure you want to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      CreateTheMap := True
    else
      CreateTheMap := False;
  if CreateTheMap then
  begin
    with TMapViewForm.Create(Application) do
    begin
      UseView := 'allsites';
      TheFactor := LengthFactor;
      TheUnit := LengthUnit + ' a.m.s.l.';
      Show;
    end;
  end;
end;

procedure TMainForm.MenuItemAppFontClick(Sender: TObject);
begin
  FontDialog1.Font := AppFont;
  if FontDialog1.Execute then
  begin
    AppFont := FontDialog1.Font;
    Font := AppFont;
    StatusBar1.Font := AppFont;
    ShowMessage('Font changed to ' + AppFont.Name + '. Only new windows will have the changed font!');
    if AppFont.Size >= 9 then
      ShowMessage('Your font size is >= 9 which, depending on the font type and spacing, may not diplay completely in the spaces available!');
  end;
end;

procedure TMainForm.MenuItemCrsinfoClick(Sender: TObject);
begin
  with TCRSInfoForm.Create(Application) do
    Show;
end;

procedure TMainForm.MenuItemCutClick(Sender: TObject);
var
  TheActiveForm: TForm;
begin
  TheActiveForm := Application.FindComponent(FormName) as TForm;
  with TheActiveForm do
  begin
    if (ActiveControl is TStringCellEditor) then
    with (ActiveControl as TStringCellEditor) do
    begin
      if SelLength > 0 then
        Clipboard.AsText := SelText;
      SelText := '';
      SetFocus;
      HasSelection := False;
      CanCut := False;
    end
    else
    if ActiveControl is TDBEdit then
    with (ActiveControl as TDBEdit) do
    begin
      CutToClipBoard;
      DataSource.DataSet.FieldByName(DataField).Value := Text;
      SetFocus;
      CanCut := False;
    end
    else
    if ActiveControl is TMaskEdit then
    with (ActiveControl as TMaskEdit) do
    begin
      CutToClipBoard;
      if Name = 'MaskEditX' then
        DataModuleMain.EditX := Text
      else
      if Name = 'MaskEditY' then
        DataModuleMain.EditY := Text;
      SetFocus;
      CanCut := False;
    end;
    if (ActiveControl is TDBGrid) and (FormName <> 'BasicinfForm') then
    with (ActiveControl as TDBGrid) do
    begin
      ClipBoard.AsText := SelectedField.AsString;
      SelectedField.Clear;
      SetFocus;
      CanCut := False;
    end;
  end;
end;

procedure TMainForm.MenuItemDepthClick(Sender: TObject);
begin
  with TDepthReportSettingsForm.Create(Application) do
    ShowModal;
end;

procedure TMainForm.MenuItemGraduatedClick(Sender: TObject);
begin
  with TFormGraduatedPnts.Create(Application) do
    ShowModal;
end;

procedure TMainForm.MenuItemPasteClick(Sender: TObject);
var
  TheActiveForm: TForm;
begin
  TheActiveForm := Application.FindComponent(FormName) as TForm;
  with TheActiveForm do
  begin
    if (ActiveControl is TStringCellEditor) then
    with (ActiveControl as TStringCellEditor) do
    begin
      Text := Clipboard.AsText;
      SetFocus;
    end
    else
    if (ActiveControl is TDBGrid) then
    with (ActiveControl as TDBGrid) do
    begin
      SelectedField.AsString := ClipBoard.AsText;
      SetFocus;
    end
    else
    if ActiveControl is TDBEdit then
    with (ActiveControl as TDBEdit) do
    begin
      PasteFromClipBoard;
      DataSource.DataSet.FieldByName(DataField).Value := Text;
      SetFocus;
    end
    else
    if ActiveControl is TMaskEdit then
    with (ActiveControl as TMaskEdit) do
    begin
      PasteFromClipBoard;
      if Name = 'MaskEditX' then
        DataModuleMain.EditX := Text
      else
      if Name = 'MaskEditY' then
        DataModuleMain.EditY := Text;
      SetFocus;
    end;
  end;
end;

procedure TMainForm.HelpContents(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TMainForm.HelpHowToUse(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TMainForm.HelpAbout(Sender: TObject);
begin
  with TAboutBoxForm.Create(Application) do
  begin
    ShowModal;
    Free;
  end;
end;

procedure TMainForm.MenuItemBasicInformationClick(Sender: TObject);
begin
  with TBasicinfForm.Create(Application) do
    Show;
end;

procedure TMainForm.MenuItemOpenWorkspaceClick(Sender: TObject);
begin
  OpenDialogWorkspace.InitialDir := GetUserDir;
  if OpenDialogWorkspace.Execute then
  begin
    WSpaceDir := ExtractFileDir(OpenDialogWorkspace.FileName);
    if not FileExistsExt('workspace.ini', WSpaceDir) then
    begin
     WSpaceActive := False;
     WSpaceDir := '';
     StatusBar1.Panels[4].Text := SPanel4;
     MessageDlg('This is not a valid workspace! Please select a valid Aquabase workspace.', mtError, [mbOk], 0);
    end
    else
    begin
      InitWSpace;
      UpdateWSpaceMenu(True);
    end;
  end;
  UpdateMenus;
end;

procedure TMainForm.ToolButtonQuickSearch1Click(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  TheSearchText := ComboBoxSearch.Text;
  if ComboBoxSearch.Items.IndexOf(TheSearchText) = -1 then
  begin
    if ComboBoxSearch.Items.Count = 100 then //delete the last one
      ComboBoxSearch.Items.Delete(99);
    ComboBoxSearch.Items.Insert(0, TheSearchText);
    ComboBoxSearch.ItemIndex := 0;
  end;
  with SearchQuery do
  begin
    if not Active then
      Open;
    if ToolButtonQuickSearch1.Hint = 'Find next' then
    begin
      if not EOF then
      begin
        Next;
        if Pos(ComboBoxSearch.Text, SearchQuery.FieldByName(ComboBoxField.Text).AsString) > -1 then
        begin
          CurrentSite := SearchQuery.FieldByName('SITE_ID_NR').AsString;
          DataModuleMain.ZQueryView.Locate('SITE_ID_NR', CurrentSite, []);
          ToolButtonQuickSearch1.Hint := 'Find next';
        end
        else
        begin
          Screen.Cursor := crDefault;
          MessageDlg('No match found for search criterion! Please make sure you are searching for information in the correct field and View', mtError, [mbOK], 0);
          ToolButtonQuickSearch1.Hint := 'Search';
          SearchQuery.Close;
        end;
      end
      else
      begin
        Screen.Cursor := crDefault;
        MessageDlg('No further match found for search criterion! Please make sure you are searching for information in the correct field and View', mtError, [mbOK], 0);
        ToolButtonQuickSearch1.Hint := 'Search';
        SearchQuery.Close;
      end;
    end
    else //search first
    begin
      if (RecordCount > 0) and (Pos(ComboBoxSearch.Text, SearchQuery.FieldByName(ComboBoxField.Text).AsString) > -1) then
      begin
        CurrentSite := SearchQuery.FieldByName('SITE_ID_NR').AsString;
        DataModuleMain.ZQueryView.Locate('SITE_ID_NR', CurrentSite, []);
        if RecordCount > 1 then
          ToolButtonQuickSearch1.Hint := 'Find next';
      end
      else
      begin
        Screen.Cursor := crDefault;
        MessageDlg('No match found for search criterion! Please make sure you are searching for information in the correct field and View', mtError, [mbOK], 0);
        ToolButtonQuickSearch1.Hint := 'Search';
        SearchQuery.Close;
      end;
    end;
  end;
  Screen.Cursor := crDefault;
end;

procedure TMainForm.UpdateMenus;
begin
  //Enable or disable menus when workspace is active or not
  MenuItemRecentWorkspaces.Enabled := not WspaceActive;
  MenuItemNewWorkspace.Enabled := not WSpaceActive;
  MenuItemOpenWorkspace.Enabled := not WSpaceActive;
  MenuItemCloseWorkspace.Enabled := WSpaceActive;
  //all others
  if WSpaceActive then
    MenuItemFile.Caption := MainMenuDatabase
  else
    MenuItemFile.Caption := MainMenuFile;
  MenuItemAccessData.Visible := WspaceActive;
  MenuItemUseView.Enabled:= WspaceActive;
  MenuItemResetView.Enabled := WspaceActive and (FilterName <> 'allsites');
  S2.Visible := WspaceActive;
  MenuItemImport.Visible := WspaceActive;
  MenuItemExport.Visible := WspaceActive;
  S3.Visible := WspaceActive;
  MenuSQLiteDB.Visible := DataModuleMain.ZConnectionDB.Tag = 1;
  MenuItemWMS.Visible := Country = 'South Africa';
  MenuItemDWS.Visible := Country = 'South Africa';
  MenuItemOnline.Visible := Country = 'South Africa';
  MenuItemDWSAudited.Visible := Country = 'South Africa';
  MenuItemGeoSiteList.Visible := Country = 'South Africa';
  MenuItemQField.Visible := Country = 'South Africa';
  SeparatorSQLite.Visible := MenuSQLiteDB.Visible;
  //top menu items
  MenuItemEdit.Visible := WspaceActive;
  MenuItemTools.Visible := WspaceActive;
  MenuItemReports.Visible := WspaceActive;
  MenuItemCharts.Visible := WspaceActive;
  //enable or disable buttons
  ToolButtonOpenWSpace.Enabled := not WSpaceActive;
  ToolButtonCloseWSpace.Enabled := WSpaceActive;
  ToolButtonCut.Enabled := WSpaceActive;
  ToolButtonCopy.Enabled := WSpaceActive;
  ToolButtonPaste.Enabled := WSpaceActive;
  ToolButtonUseView.Enabled := WSpaceActive;
  ToolButtonResetView.Enabled := WspaceActive and (FilterName <> 'allsites');
  ToolButtonPrint.Enabled := WSpaceActive;
  ToolButtonQuickSearch.Enabled := WSpaceActive;
  ToolButtonCreateView.Enabled := WSpaceActive;

  ToolButtonBasicinf.Enabled := WSpaceActive;
  ToolButtonConstruction.Enabled := WSpaceActive;
  ToolButtonWaterLevel.Enabled := WSpaceActive;
  ToolButtonDischarge.Enabled := WSpaceActive;
  ToolButtonTesting.Enabled := WSpaceActive;
  ToolButtonChemistry.Enabled := WSpaceActive;
  ToolButtonGeology.Enabled := WSpaceActive;
  ToolButtonAdditionalInfo.Enabled := WSpaceActive;
  ToolButtonSiteManagement.Enabled := WSpaceActive;
  ToolButtonSurfaceHydr.Enabled := WSpaceActive;
  ToolButtonMeteorology.Enabled := WSpaceActive;

  ToolButtonQGISGoto.Enabled := WSpaceActive;
  ToolButtonQGISMark.Enabled := WSpaceActive;
  ToolButtonPreferences.Enabled := WSpaceActive;
  ToolBar5.Enabled := WSpaceActive;
  ComboBoxField.Height := 22;
  ComboBoxSearch.Height := 22;
  MainForm.SetFocus;
end;

procedure TMainForm.MenuItemWaterlevelClick(Sender: TObject);
begin
  with TWaterlevelForm.Create(Application) do
  begin;
    Caption := WLCaption;
    Show;
  end;
end;

procedure TMainForm.MenuItemDischargerateClick(Sender: TObject);
begin
  with TDischargeForm.Create(Application) do
  begin
    Caption := DisCaption;
    Show;
  end;
end;

procedure TMainForm.MenuItemCloseWorkspaceClick(Sender: TObject);
var
  i: Word;
  CanCloseWSpace: Boolean;
  SQLiteFileName: String;
begin
  CanCloseWSpace := True;
  if BusyNewSQLite then
  begin
    if MessageDlg('You are busy applying a new SpatiaLite database and should not close the workspace now! If you do you will have to start again. Are you sure you want to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      CanCloseWSpace := False;
  end;
  if CanCloseWSpace then
  begin
    FreeAndNil(MarkedSiteList);
    if SettingsDir = WSpaceDir then
      SettingsDir := DefaultSettingsDir; //reset to the default
    for i := Application.ComponentCount - 1 downto 0 do
    begin
      if not (Application.Components[i] is TMainForm) and not (Application.Components[i] is THintWindow) then  //TMainForm is classname of your main form
      try
        if Application.Components[i] is TForm then
          (Application.Components[i] as TForm).Close; // TForm is your base class
      except
        // Your code here... leave blank to do nothing
      end;
    end;
    with DataModuleMain do
    begin
      LookupTable.Close;
      BasicinfQuery.Close;
      ZQueryView.Close;
      SQLiteFileName := ZConnectionDB.Database;
      ZConnectionLanguage.Disconnect;
      ZConnectionSettings.Disconnect;
      ZConnectionProj.Disconnect;
      ZConnectionDB.Disconnect;
    end;
    if NewSQLite then
    begin
      if not RenameFile(SQLiteFileName, WSpaceDir + DirectorySeparator + FormatDateTime('YYYYMMDD', Date) + '-' + FormatDateTime('hhnn', Time) + '-' + ExtractFileName(SQLiteFileName)) then
        MessageDlg('Could not create backup database file from ' + ExtractFileName(SQLiteFileName) + '! Maybe it was open in another application? You have to close the workspace and rename it manually.', mtWarning, [mbOK], 0);
      if (RightStr(SQLiteFileName, 7) = '.sqlite') and not RenameFile(WSpaceDir + DirectorySeparator + 'aquabase_new.sqlite', SQLiteFileName) then
        MessageDlg('Could not rename "aquabase_new.sqlite" to ' + ExtractFileName(SQLiteFileName) + '! You have to close the workspace and rename it manually.', mtWarning, [mbOK], 0)
      else
      if (RightStr(SQLiteFileName, 5) = '.gpkg') and not RenameFile(WSpaceDir + DirectorySeparator + 'aquabase_new.gpkg', SQLiteFileName) then
        MessageDlg('Could not rename "aquabase_new.gpkg" to ' + ExtractFileName(SQLiteFileName) + '! You have to close the workspace and rename it manually.', mtWarning, [mbOK], 0);
      NewSQLite := False;
    end;
    try
      with TIniFile.Create(WSpaceDir + DirectorySeparator + 'workspace.ini') do
      begin
        WriteString('Database', 'LastView', FilterName);
        WriteString('Database', 'LastSiteID', CurrentSite);
        WriteBool('Database', 'Spatialite', Spatialite);
        //for QuickSearch toolbar
        if ComboBoxSearch.Items.Count > 0 then
        begin
          WriteInteger('Searches', 'SearchCount', ComboBoxSearch.Items.Count);
          for i := 0 to ComboBoxSearch.Items.Count - 1 do
            WriteString('Searches', 'Search' + IntToStr(i), ComboBoxSearch.Items[i]);
          ComboBoxSearch.Clear;
        end;
        Free;
      end;
    except on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
    DeleteFile(WSpaceDir + DirectorySeparator + '.workspace.lck'); //delete the lock file
    WSpaceActive := False;
    WSpaceDir := '';
    CurrentSite := '';
    FilterName := '';
    StatusBar1.Panels[1].Text := SPanel1;
    StatusBar1.Panels[4].Text := SPanel4;
    Editing := SPanel3;
    UpdateMenus;
    Screen.Cursor := crDefault;
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
{$IFDEF WINDOWS}
var
  ReadMeText: TStringList;
  AVer: ShortString;
{$ENDIF}
begin
  {$IFDEF WINDOWS}
  if FileExists(GetTempDir + 'aquabase_readme.txt') then
  begin
    ReadMeText := TStringList.Create;
    ReadMeText.LoadFromFile(GetTempDir + 'aquabase_readme.txt');
    AVer := Copy(ReadMeText[0], Pos('Build: ', ReadmeText[0]) + 7, 9);
    if AVer <= FileVer then
    begin
      DeleteFile(GetTempDir + 'aquabase_readme.txt');
      DeleteFile(GetTempDir + 'Aquabase_Update.exe');
    end;
    ReadMeText.Free;
  end;
  {$ENDIF}
  CoolBar1.Bands[2].Visible := True;
  if WSpaceActive then MenuItemCloseWorkspaceClick(Sender);
  CloseAction := caFree;
end;

procedure TMainForm.MenuItemGeologyClick(Sender: TObject);
begin
  with TGeologyForm.Create(Application) do
  begin
    Caption := 'Geology';
    Show;
  end;
end;

procedure TMainForm.SQLSearchClick(Sender: TObject);
begin
  with TSQLSearchForm.Create(Application) do
    Show;
end;

procedure TMainForm.SystemSettingsClick(Sender: TObject);
begin
  if SysSetDlgForm = nil then
  begin
    SysSetDlgForm := TSysSetDlgForm.Create(Application);
    SysSetDlgForm.Show;
  end
  else
    SysSetDlgForm.BringToFront;
end;

procedure TMainForm.MenuItemUseViewClick(Sender: TObject);
begin
  with TSelectViewForm.Create(Application) do
    ShowModal;
  StatusBar1.Panels[1].Text := FilterName;
  ViewChanged := True;
end;

procedure TMainForm.MenuItemAquiferClick(Sender: TObject);
begin
  with TAquiferForm.Create(Application) do
  begin
    Caption := 'Aquifer';
    Show;
  end;
end;

procedure TMainForm.Quicksearch1Click(Sender: TObject);
begin
  if WSpaceActive then
  begin
    if Assigned(Screen.ActiveForm) then
    begin
      if Screen.ActiveForm.Name = 'ProjManForm' then
        with TQuickSearchForm.Create(Application) do
        begin
          Tag := 1;
          Caption := QckSearchCaption + FilterName + '" View';
        end
      else
      if Screen.ActiveForm.Name = 'ProfilingForm' then
        with TQuickSearchForm.Create(Application) do
        begin
          Tag := 2;
          Caption := QckSearchCaption + FilterName + '" View';
        end
      else
        with TQuickSearchForm.Create(Application) do
        begin
          Tag := 0;
          Caption := QckSearchCaption + FilterName + '" View';
        end;
    end
    else
    with TQuickSearchForm.Create(Application) do
    begin
      Tag := 0;
      Caption := QckSearchCaption + FilterName + '" View';
    end;
  end;
end;

procedure TMainForm.SelectSites1Click(Sender: TObject);
begin
  with TSelectSitesDlg.Create(Application) do
  begin
    ShowModal;
    Free;
  end;
end;

procedure TMainForm.MenuItemHoleFinishClick(Sender: TObject);
begin
  with THoleConstForm.Create(Application) do
  begin
    Caption := 'Hole Finish';
    Show;
  end;
end;

procedure TMainForm.MenuItemHoleConstructionClick(Sender: TObject);
begin
  with TBHConstrForm.Create(Application) do
  begin
    Caption := 'Borehole Construction';
    Show;
  end;
end;

procedure TMainForm.MenuItemInstallationClick(Sender: TObject);
begin
  with TInstallForm.Create(Application) do
  begin
    Caption := 'Installation';
    Show;
  end;
end;

procedure TMainForm.MenuItemCommentsClick(Sender: TObject);
begin
  with TCommentsForm.Create(Application) do
  begin
    Caption := 'Comments';
    Show;
  end;
end;

procedure TMainForm.MenuItemReferencesClick(Sender: TObject);
begin
  with TReferencesForm.Create(Application) do
  begin
    Caption := 'References';
    Show;
  end;
end;

procedure TMainForm.MenuItemPenetrationRateClick(Sender: TObject);
begin
  with TPenetrationForm.Create(Application) do
  begin
    Caption := 'Penetration Rate';
    Show;
  end;
end;

procedure TMainForm.MenuItemNameofOwnerClick(Sender: TObject);
begin
  with TNameOwnerForm.Create(Application) do
  begin
    Caption := 'Name and Address of Owner';
    Show;
  end;
end;

procedure TMainForm.MenuItemOtherIdentifierClick(Sender: TObject);
begin
  with TOtherIdForm.Create(Application) do
  begin
    Caption := 'Other Identifier';
    Show;
  end;
end;

procedure TMainForm.MenuItemVisitstoSiteClick(Sender: TObject);
begin
  with TSiteVisitorForm.Create(Application) do
  begin
    Caption := 'Name and Address of Site Visitor';
    Show;
  end;
end;

procedure TMainForm.MenuItemFieldMeasurementClick(Sender: TObject);
begin
  with TFldMeasForm.Create(Application) do
  begin
    Caption := 'Field Measurements';
    Show;
  end;
end;

procedure TMainForm.MenuItemSiteSelectionClick(Sender: TObject);
begin
  with TSiteSelectionForm.Create(Application) do
  begin
    Caption := 'Site Selection';
    Show;
  end;
end;

procedure TMainForm.MenuItemWaterSampleClick(Sender: TObject);
begin
  with TWaterSampleForm.Create(Application) do
  begin
    Caption := 'Water Samples';
    Show;
  end;
end;

procedure TMainForm.PumpingTestData1Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 5 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TPmpimprtForm.Create(Application) do
    Show;
end;

procedure TMainForm.MenuItemPumpEngineClick(Sender: TObject);
begin
  with TAddInstallForm.Create(Application) do
  begin
    Caption := 'Pump/Engine Details';
    Show;
  end;
end;

procedure TMainForm.MenuItemMaintenanceClick(Sender: TObject);
begin
  with TMaintainForm.Create(Application) do
  begin
    Caption := 'Maintenance';
    Show;
  end;
end;

procedure TMainForm.Database1Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 3 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TImportDatDlg.Create(Application) do
    Show;
end;

procedure TMainForm.MenuItemProjectsClick(Sender: TObject);
begin
  with TProjManForm.Create(Application) do
    Show;
end;

procedure TMainForm.MenuItemManRecClick(Sender: TObject);
begin
  with TRecommendForm.Create(Application) do
  begin
    Caption := 'Management Recommendations';
    Show;
  end;
end;

procedure TMainForm.ManagementRecommendation1Click(Sender: TObject);
begin
  with TManRecSetForm.Create(Application) do
  begin
    TitleEdit.Text := 'Management Recommendations';
    ShowModal;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  {$IFDEF WINDOWS}
  MyThread : TMyThread;
  ReadMeText: TStringList;
  AVer: ShortString;
  {$ENDIF}
  FileVerInfo: TFileVersionInfo;
  plugin_ver, old_plugin_ver: Real;
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  if WindowState = wsMinimized then WindowState := wsNormal;
  FileVerInfo := TFileVersionInfo.Create(nil);
  FileVerInfo.ReadFileInfo;
  ProdVer := FileVerInfo.VersionStrings.Values['ProductVersion'];
  FileVer := FileVerInfo.VersionStrings.Values['FileVersion'];
  Caption := 'Aquabase ' + Copy(ProdVer, 1, 4) + ' - Build: ' + FileVer;
  {$IFDEF WINDOWS}
  ReadRegistry;
  //check if wrong Decimal was set in registry and inform user
  if WrongDecimal then
    MessageDlg('Your Windows Registry had an incorrect Decimal Number Format setting to work with Aquabase and SQL! It has been changed to a "." (dot). You must restart Aquabase to make the new format settings effective!', mtWarning, [mbOK], 0);
  //check for old Aquabase install
  VerDiff := StrToInt(Copy(FileVerInfo.VersionStrings.Values['FileVersion'], 7, 3)) - StrToInt(Copy(InstalledVer, 7, 3));
  {$ENDIF}
  {$IFDEF UNIX}
  ReadEtc;
  {$ENDIF}
  DataModuleMain := TDataModuleMain.Create(Application);
  Application.OnHint := @ShowHint;
  Application.OnIdle := @AppIdle;
  //check for the QGIS plugin
  {$IFDEF WINDOWS}
  if DirectoryExists(ProgramDir + '\plugins\QGIS\Aquabase') and DirectoryExists(GetUserDir + '\Application Data\QGIS\QGIS3') then //plugin and qgis is installed
  begin
    if not DirectoryExists(GetUserDir + '\Application Data\QGIS\QGIS3\profiles\default\python\plugins\Aquabase') then
      CopyDirTree(ProgramDir + '\plugins\QGIS\Aquabase', GetUserDir + '\Application Data\QGIS\QGIS3\profiles\default\python\plugins\Aquabase', [cffOverwriteFile, cffCreateDestDirectory, cffPreserveTime])
    else //check for newer version
    begin
      with TIniFile.Create(GetUserDir + '\Application Data\QGIS\QGIS3\profiles\default\python\plugins\Aquabase\metadata.txt') do
      begin
        old_plugin_ver := ReadFloat('general', 'version', 0);
        Free;
      end;
      with TIniFile.Create(ProgramDir + '\plugins\QGIS\Aquabase\metadata.txt') do
      begin
        plugin_ver := ReadFloat('general', 'version', 0);
        Free;
      end;
      if plugin_ver > old_plugin_ver then //there is a newer version, so copy again
        CopyDirTree(ProgramDir + '\plugins\QGIS\Aquabase', GetUserDir + '\Application Data\QGIS\QGIS3\profiles\default\python\plugins\Aquabase', [cffOverwriteFile, cffPreserveTime])
    end;
  end;
  MenuItemQGIS.Visible := DirectoryExists(GetUserDir + '\Application Data\QGIS\QGIS3');
  MenuItemQGISGoto.Visible := DirectoryExists(GetUserDir + '\Application Data\QGIS\QGIS3\profiles\default\python\plugins\Aquabase');
  MenuItemQGISMark.Visible := DirectoryExists(GetUserDir + '\Application Data\QGIS\QGIS3\profiles\default\python\plugins\Aquabase');
  MenuItemQGISSeparator.Visible := DirectoryExists(GetUserDir + '\Application Data\QGIS\QGIS3\profiles\default\python\plugins\Aquabase');
  {$ENDIF}
  {$IFDEF LINUX}
  if DirectoryExists('/usr/share/aquabase/plugins/QGIS/Aquabase') and DirectoryExists(GetUserDir + '/.local/share/QGIS/QGIS3/profiles/default/python/plugins') then //plugin and qgis is installed
  begin
    if not DirectoryExists(GetUserDir + '/.local/share/QGIS/QGIS3/profiles/default/python/plugins/Aquabase') then //copy the plugin
      CopyDirTree('/usr/share/aquabase/plugins/QGIS/Aquabase', GetUserDir + '/.local/share/QGIS/QGIS3/profiles/default/python/plugins/Aquabase', [cffCreateDestDirectory, cffPreserveTime])
    else //check for newer version
    begin
      with TIniFile.Create(GetUserDir + '/.local/share/QGIS/QGIS3/profiles/default/python/plugins/Aquabase/metadata.txt') do
      begin
        old_plugin_ver := ReadFloat('general', 'version', 0);
        Free;
      end;
      with TIniFile.Create('/usr/share/aquabase/plugins/QGIS/Aquabase/metadata.txt') do
      begin
        plugin_ver := ReadFloat('general', 'version', 0);
        Free;
      end;
      if plugin_ver > old_plugin_ver then //there is a newer version, so copy again
        CopyDirTree('/usr/share/aquabase/plugins/QGIS/Aquabase', GetUserDir + '/.local/share/QGIS/QGIS3/profiles/default/python/plugins/Aquabase', [cffOverwriteFile, cffPreserveTime])
    end;
  end;
  MenuItemQGIS.Visible := DirectoryExists(GetUserDir + '/.local/share/QGIS/QGIS3');
  MenuItemQGISGoto.Visible := DirectoryExists(GetUserDir + '/.local/share/QGIS/QGIS3/profiles/default/python/plugins/Aquabase');
  MenuItemQGISMark.Visible := DirectoryExists(GetUserDir + '/.local/share/QGIS/QGIS3/profiles/default/python/plugins/Aquabase');
  MenuItemQGISSeparator.Visible := DirectoryExists(GetUserDir + '/.local/share/QGIS/QGIS3/profiles/default/python/plugins/Aquabase');
  {$ENDIF}
  with CoolBar1 do
  begin
    Bands[2].Visible := MenuItemQGISGoto.Visible;
    AutosizeBands;
  end;
  with Constraints do
  begin
    MaxWidth := Screen.Width;
    MinHeight := CoolBar1.Height + StatusBar1.Height + 10;
  end;
  ToolBar3.Visible := MenuItemQGISGoto.Visible;
  //update the statusbar
  StatusBar1.Panels[1].Text := SPanel1;
  StatusBar1.Panels[2].Text := SPanel2;
  StatusBar1.Panels[3].Text := SPanel3;
  StatusBar1.Panels[4].Text := SPanel4;
  Application.ProcessMessages;
  //delete update files if it is already updated
  {$IFDEF WINDOWS}
  if FileExists(GetTempDir + 'aquabase_readme.txt') then
  begin
    ReadMeText := TStringList.Create;
    ReadMeText.LoadFromFile(GetTempDir + 'aquabase_readme.txt');
    AVer := Copy(ReadMeText[0], Pos('Build: ', ReadmeText[0]) + 7, 9);
    if AVer <= FileVerInfo.VersionStrings.Values['FileVersion'] then
    begin
      DeleteFile(GetTempDir + 'aquabase_readme.txt');
      DeleteFile(GetTempDir + 'Aquabase_Update.exe');
    end;
    ReadMeText.Free;
  end;
  FileVerInfo.Free;
  if LookForUpdate then
  begin
    //thread for ftp download
    MyThread := TMyThread.Create(True); // With the True parameter it doesn't start automatically
    if Assigned(MyThread.FatalException) then
      raise MyThread.FatalException;
    // Here the code initialises anything required before the threads starts executing
    MyThread.Start;
  end;
  {$ENDIF}
end;

procedure TMainForm.MenuItemDeleteSitesClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 5 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TDelSitesDlg.Create(Application) do
    ShowModal;
end;

procedure TMainForm.LookupCodesClick(Sender: TObject);
begin
  if DataModuleMain.LookupTable.ReadOnly then
    MessageDlg('Your Lookup table seems to be read-only! You can move your Settings files to another folder in your Preferences to enable writing new Lookup codes.', mtWarning, [mbOK], 0);
  {$IFDEF WINDOWS}
  if VerDiff > 5 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TEditLookupForm.Create(Application) do
  begin
    EditDataSource.DataSet := LookupQuery;
    Caption := 'Edit Lookup Codes';
    ShowModal;
  end;
end;

procedure TMainForm.EditLengthClick(Sender: TObject);
begin
  with TEditLookupForm.Create(Application) do
  begin
    UnitTableName := 'lengunit';
    EditDataSource.DataSet := UnitQuery;
    Caption := 'Edit Length Units';
    ShowModal;
  end;
end;

procedure TMainForm.EditVolumeClick(Sender: TObject);
begin
  with TEditLookupForm.Create(Application) do
  begin
    UnitTableName := 'volmunit';
    EditDataSource.DataSet := UnitQuery;
    Caption := 'Edit Volume Units';
    ShowModal;
  end;
end;

procedure TMainForm.EditTimeClick(Sender: TObject);
begin
  with TEditLookupForm.Create(Application) do
  begin
    UnitTableName := 'timeunit';
    EditDataSource.DataSet := UnitQuery;
    Caption := 'Edit Time Units';
    ShowModal;
  end;
end;

procedure TMainForm.EditDiameterMeteorClick(Sender: TObject);
begin
  with TEditLookupForm.Create(Application) do
  begin
    UnitTableName := 'diamunit';
    EditDataSource.DataSet := UnitQuery;
    Caption := 'Edit Diameter and Meteorology Units';
    ShowModal;
  end;
end;

procedure TMainForm.EditChemistryClick(Sender: TObject);
begin
  with TEditLookupForm.Create(Application) do
  begin
    UnitTableName := 'chemunit';
    EditDataSource.DataSet := UnitQuery;
    Caption := 'Edit Chemistry Units';
    ShowModal;
  end;
end;

procedure TMainForm.EditElectricalCondClick(Sender: TObject);
begin
  with TEditLookupForm.Create(Application) do
  begin
    UnitTableName := 'elecunit';
    EditDataSource.DataSet := UnitQuery;
    Caption := 'Edit Electrical Conductivity Units';
    ShowModal;
  end;
end;

procedure TMainForm.MenuItemInstrumentationClick(Sender: TObject);
begin
  with TInstrumentForm.Create(Application) do
  begin
    Caption := 'Instrumentation';
    Show;
  end;
end;

procedure TMainForm.StageHeight1Click(Sender: TObject);
begin
  with TStageHiForm.Create(Application) do
  begin
    Caption := 'Stage Height';
    Show;
  end;
end;

procedure TMainForm.DischargeStreamFlow1Click(Sender: TObject);
begin
  with TStreamForm.Create(Application) do
  begin
    Caption := 'Stream/Spillway Discharge/Intake Rate & Flow Velocity';
    Show;
  end;
end;

procedure TMainForm.MenuItemExpenditureClick(Sender: TObject);
begin
  with TExpenditureForm.Create(Application) do
  begin
    Caption := 'Project Expenditure';
    Show;
  end;
end;

procedure TMainForm.MenuItemMemberClick(Sender: TObject);
begin
  with TMemberForm.Create(Application) do
  begin
    Caption := 'Member of a Group';
    Show;
  end;
end;

procedure TMainForm.MenuItemInsertCharacterClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 5 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TInsCharForm.Create(Application) do
    ShowModal;
end;

procedure TMainForm.WorkspaceImportClick(Sender: TObject);
begin
  with TAppendForm.Create(Application) do
    ShowModal;
end;

procedure TMainForm.TestingDetails1Click(Sender: TObject);
begin
  with TTestdetlForm.Create(Application) do
  begin
    Caption := 'Testing Details';
    Show;
  end;
end;

procedure TMainForm.LocationandChemistry1Click(Sender: TObject);
begin
  MessageDlg('This report has not been implemented yet!', mtInformation, [mbOK], mrOK);
end;

procedure TMainForm.MarkcurrentsiteClick(Sender: TObject);
begin
  {Procedure to save current site in list}
  if CurrentSite <> '' then MarkedSiteList.Add(CurrentSite);
end;

procedure TMainForm.SavemarkedsitesClick(Sender: TObject);
var InString, NewViewName: String;
    s: Integer;
begin
  InString := '';
  if MarkedSiteList.Count > 0 then
  begin
    with TProvideViewNameForm.Create(Application) do
    begin
      if ShowModal = mrOK then
      begin
        for s := 0 to MarkedSiteList.Count - 1 do
          InString := InString + QuotedStr(MarkedSiteList.Strings[s]) + ', ';
        //Delete last comma
        Delete(InString, Length(InString) - 1, 2);
        NewViewName := ViewName;
        Free;
        if DataModuleMain.ZConnectionDB.Tag = 1 then
        begin
          DataModuleMain.ZConnectionDB.ExecuteDirect('DROP VIEW IF EXISTS [' + NewViewName + '];');
          DataModuleMain.ZConnectionDB.ExecuteDirect('CREATE VIEW [' +
            NewViewName + '] AS SELECT SITE_ID_NR FROM basicinf WHERE SITE_ID_NR IN (' + InString + ')');
        end
        else
        if DataModuleMain.ZConnectionDB.Tag = 5 then
        begin
          DataModuleMain.ZConnectionDB.ExecuteDirect('IF OBJECT_ID('+ QuotedStr(NewViewName) + ', ''V'') IS NOT NULL DROP VIEW ' + NewViewName);
          DataModuleMain.ZConnectionDB.ExecuteDirect('CREATE VIEW ' +
            NewViewName + ' AS SELECT SITE_ID_NR FROM basicinf WHERE SITE_ID_NR IN (' + InString + ')');
        end
        else
        begin
          DataModuleMain.ZConnectionDB.ExecuteDirect('CREATE OR REPLACE VIEW ' +
            NewViewName + ' AS SELECT SITE_ID_NR FROM basicinf WHERE SITE_ID_NR IN (' + InString + ')');
          if CheckBox1.Checked then
          try
            if DataModuleMain.ZConnectionDB.Tag = 4 then //postgresql
              DataModuleMain.ZConnectionDB.ExecuteDirect('GRANT SELECT ON TABLE ' + NewViewName + ' TO public')
            else
              DataModuleMain.ZConnectionDB.ExecuteDirect('GRANT SELECT ON TABLE `' + NewViewName + '` TO ''%''@''%''');
          except on E: Exception do
            MessageDlg(E.Message + ': Ask your database administrator for "GRANT" permissions.', mtError, [mbOK], 0);
          end;
        end;
        if MessageDlg('Do you want to set "' + NewViewName + '" as new filter?',
          mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          with DataModuleMain.ZQueryView do
          begin
            Close;
            FilterName := NewViewName;
            Open;
          end;
        end;
      end
      else
        MessageDlg('Create View cancelled! No view will be created from the marked sites!', mtInformation, [mbOK],0);
    end;
  end
  else MessageDlg('No sites marked for new view!', mtError, [mbOK], 0);
end;

procedure TMainForm.ClearmarkedsitesClick(Sender: TObject);
begin
  if MessageDlg('Are you sure you want to clear all marked sites?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then MarkedSiteList.Clear;
  MessageDlg('Marked site list has been deleted!', mtInformation, [mbOK], 0);
end;

procedure TMainForm.RemovecurrentmarkedsiteClick(Sender: TObject);
begin
  if MarkedSiteList.IndexOf(CurrentSite) > -1 then
    MarkedSiteList.Delete(MarkedSiteList.IndexOf(CurrentSite))
  else
    MessageDlg('Current site is not marked!', mtError, [mbOK], 0);
end;

procedure TMainForm.LocationandManagement1Click(Sender: TObject);
begin
  MessageDlg('This report has not been implemented yet!', mtInformation, [mbOK], mrOK);
end;

procedure TMainForm.LastWSpaceClick(Sender: TObject);
begin
  if not FileExistsExt('workspace.ini', (Sender as TMenuItem).Caption) then
  begin
    WSpaceActive := False;
    MessageDlg('This is not a valid workspace! It will be removed from the Recent Workspaces list.', mtError, [mbOk], 0);
  end
  else
  begin
    ChDir((Sender as TMenuItem).Caption);
    WSpaceDir := (Sender as TMenuItem).Caption;
    InitWSpace;
    UpdateWSpaceMenu(False);
  end;
  UpdateMenus;
end;

procedure TMainForm.UpdateWSpaceMenu(Add: Boolean);
var
  w: Byte;
begin
  if Add then //update the last workspaces menu, if workspace was opened or new one created
  begin
    //check if this workspace has been opened before and therefore is in the list already
    //if it is not then add the new workspace in list on top
    if (WSpaceDir > '') and (ListBoxWSpaces.Items.IndexOf(WSpaceDir) = -1) then
    begin
      ListBoxWSpaces.Items.Insert(0, WSpaceDir);
      if ListBoxWSpaces.Count = 11 then //make sure there are always <= 10
        ListBoxWSpaces.Items.Delete(10);
    end;
  end
  else
  begin
    //check if the workspaces still exists, otherwise delete from list
    if ListBoxWSpaces.Count > 0 then
    for w := 0 to ListBoxWSpaces.Count - 1 do
      if not DirectoryExists(ListBoxWSpaces.Items[w]) then
        ListBoxWSpaces.Items.Delete(w);
  end;
  //if a workspace is selected (so not on Aquabase startup)
  if WSpaceDir > '' then
  begin
    ListBoxWSpaces.Items.Delete(ListBoxWSpaces.Items.IndexOf(WSpaceDir)); //put it on top
    ListBoxWSpaces.Items.Insert(0, WSpaceDir);
  end;
  //clear the recent workspaces menu
  for w := 0 to 9 do
  begin
    (FindComponent('MenuItemW' + IntToStr(w)) as TMenuItem).Caption := '';
    (FindComponent('MenuItemW' + IntToStr(w)) as TMenuItem).Visible := False;
  end;
  //add the list to submenu
  if ListBoxWSpaces.Count = 11 then //make sure there are always <= 10
    ListBoxWSpaces.Items.Delete(10);
  if ListBoxWSpaces.Count > 0 then
  for w := 0 to ListBoxWSpaces.Count - 1 do
  begin
    (FindComponent('MenuItemW' + IntToStr(w)) as TMenuItem).Caption := ListBoxWSpaces.Items[w];
    (FindComponent('MenuItemW' + IntToStr(w)) as TMenuItem).Visible := True;
  end;
end;

procedure TMainForm.MenuItemMagneticSusceptClick(Sender: TObject);
begin
  with TMagneticSusForm.Create(Application) do
  begin
    Caption := 'Magnetic Susceptibility';
    Show;
  end;
end;

procedure TMainForm.TestPumping1Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 5 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TTestRepSetForm.Create(Application) do
  begin
    ShowModal;
  end;
end;

procedure TMainForm.SiteInformation2Click(Sender: TObject);
begin
  with TBasicReportSetForm.Create(Application) do
  begin
    TitleEdit.Text := 'SITE INFORMATION REPORT';
    with AvailableTablesList do
    begin
      Add('basicinf');
      Add('holediam');
      Add('casing__');
      Add('piezomet');
      Add('holefill');
      Add('aquifer_');
      Add('discharg');
      Add('waterlev');
      Add('pumptest');
      Add('testdetl');
      Add('recommnd');
      Add('installa');
      Add('instdetl');
    end;
    ShowModal;
  end;
end;

procedure TMainForm.MenuItemChangeSiteIdentifierClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 5 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TChangeSiteIDForm.Create(Application) do
  begin
    ShowModal;
    if ModalResult = mrOK then
    begin
      DataModuleMain.ZQueryView.Refresh;
      DataModuleMain.ZQueryView.Locate('SITE_ID_NR', CurrentSite, []);
    end;
    Free;
  end;
end;

procedure TMainForm.MeterReading1Click(Sender: TObject);
begin
  with TMeterReadingForm.Create(Application) do
   begin
    Caption := 'Meter Reading';
    Show;
  end;
end;

procedure TMainForm.MenuItemOtherHoleClick(Sender: TObject);
begin
  with TOtherHoleForm.Create(Application) do
  begin
    Caption := 'Other Hole';
    Show;
  end;
end;

procedure TMainForm.MenuItemOtherDataClick(Sender: TObject);
begin
  with TOtherDataForm.Create(Application) do
  begin
    Caption := 'Other Data';
    Show;
  end;
end;

procedure TMainForm.MenuItemSearchStatusClick(Sender: TObject);
begin
  with TSearchStatusForm.Create(Application) do
  begin
    Caption := 'Search Status';
    Show;
  end;
end;

procedure TMainForm.OtherCases1Click(Sender: TObject);
begin
  with TSpecCasesForm.Create(Application) do
  begin
    Caption := 'Special Cases';
    Show;
  end;
end;

procedure TMainForm.MenuItemProfilingClick(Sender: TObject);
begin
  with TProfilingForm.Create(Application) do
    Show;
end;

procedure TMainForm.BoreholeLog1Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 5 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TGeollogSettingsForm.Create(Application) do
  begin
    IsReport := True;
    ShowModal;
  end;
end;

function TMainForm.InitWSpace: Boolean;
var
  i, SCount: Word;
  WSpaceLocked: Boolean;
  LockFileText: TStringList;
  ComputerName: String;
  {$IFDEF WINDOWS}
  l: DWORD;
  {$ENDIF}
begin
  WSpaceLocked := False;
  ReadIniFile;
  //Check if it is an old Aquabase workspace
  if FileExistsExt('allsites.db', WSpaceDir) and FileExistsExt('basicinf.dbf', WSpaceDir) and FileExistsExt('workspace.ini', WSpaceDir) then
  begin
    MessageDlg('This is a previous version Aquabase (< Ver. 7.0) workspace, which cannot be opened with this version of Aquabase! Please create a new workspace and import this old version workspace.', mtError, [mbOK], 0);
    WSpaceActive := false;
    WSpaceDir := '';
    CurrentSite := '';
    FilterName := '';
    StatusBar1.Panels[1].Text := SPanel1;
    StatusBar1.Panels[4].Text := SPanel4;
    Editing := SPanel3;
  end
  else
  //check if it is a valid workspace
  if (DataModuleMain.ZConnectionDB.Database = '') or (DataModuleMain.ZConnectionDB.Protocol = '') then
  begin
    MessageDlg('This is not a valid Aquabase workspace or your "workspace.ini" is invalid or corrupt. Please open a valid workspace or create a new workspace.', mtError, [mbOK], 0);
    WSpaceActive := False;
    WSpaceDir := '';
    CurrentSite := '';
    FilterName := '';
    StatusBar1.Panels[1].Text := SPanel1;
    StatusBar1.Panels[4].Text := SPanel4;
    Editing := SPanel3;
  end
  else //check if workspace is locked
  if FileExists(WSpaceDir + DirectorySeparator + '.workspace.lck') then
  begin
    WSpaceLocked := True;
    if MessageDlg('It seems that this workspace has been opened by another user already, or was not closed properly on the last exit! This may cause problems with your workspace settings! Are you sure you want to continue?', mtWarning, [mbYes, mbNo], 0) = mrYes then
    begin
      WSpaceLocked := False;
      DeleteFile(WSpaceDir + DirectorySeparator + '.workspace.lck');
    end;
  end;
  if WSpaceLocked = False then
  begin
    Screen.Cursor := crSQLWait;
    StatusBar1.Panels[4].Text := SPanelOpening + DataModuleMain.ZConnectionDB.Database + '"...';
    //Connect to database
    try
      with DataModuleMain.ZConnectionDB do
      begin
        if not Connected then
          Connect;
        if Connected then
        begin
          WspaceActive := True;
          Result := True;
        end
        else
        begin
          WspaceActive := False;
          Result := False;
        end;
      end;
    except on E: Exception do
      begin
        Screen.Cursor := crDefault;
        MessageDlg(E.Message + ': Error opening database connection! Please check your database, server and login settings!', mtError, [mbOK], 0);
        DataModuleMain.ZConnectionDB.Disconnect;
        WSpaceActive := False;
        Result := False;
      end;
    end;
    Application.ProcessMessages;
    if WSpaceActive then
    begin
      //finally open the basic information table
      DataModuleMain.BasicinfQuery.Open;
      StatusBar1.Panels[1].Text := FilterName;
      StatusBar1.Panels[2].Text := CurrentSite;
      StatusBar1.Panels[4].Text := WSpaceDir + ' [' + ExtractFilename(DataModuleMain.ZConnectionDB.Database) + ']';
      LockFileText := TStringList.Create;
      //open settings tables
      DataModuleMain.ZConnectionSettings.Connect;
      //open language tables
      DataModuleMain.ZConnectionLanguage.Connect;
      {$IFDEF LINUX}
      ComputerName := GetHostName;
      {$ENDIF}
      {$IFDEF DARWIN}
      ComputerName := GetEnvironmentVariable('HOSTNAME');
      {$ENDIF}
      {$IFDEF WINDOWS}
      l := 255;
      ComputerName := '';
      SetLength(ComputerName, l);
      GetComputerName(PChar(ComputerName), l);
      SetLength(ComputerName, l);
      {$ENDIF}
      LockFileText.Add('User "' + GetEnvironmentVariable('USER') + '", on: ' + DateToStr(Now) + ' ' + TimeToStr(Now) + ', Computer: "' + ComputerName + '"');
      LockFileText.SaveToFile(WSpaceDir + DirectorySeparator + '.workspace.lck');
      LockFileText.Free;
      if FilterName <> 'allsites' then
        MessageDlg('This workspace has been opened with the active View "' + FilterName + '", which may not show all sites in the database! You can reset the view to "allsites" under the Database menu item.', mtInformation, [mbOK], 0);
      MarkedSiteList := TStringList.Create;
      MarkedSiteList.Sorted := True;
      MarkedSiteList.Duplicates := dupIgnore;
      //for QuickSearch toolbar
      ComboBoxSearch.Clear;
      with TIniFile.Create(WSpaceDir + DirectorySeparator + 'workspace.ini') do
      begin
        SCount := ReadInteger('Searches', 'SearchCount', 0);
        if SCount > 0 then
        for i := 0 to SCount - 1 do
          ComboBoxSearch.Items.Add(ReadString('Searches', 'Search' + IntToStr(i), '')) ;
        Free;
      end;
    end //of WSpaceActive
    else //reset variables and connection settings
    begin
      CurrentSite := '';
      WSpaceDir := '';
      FilterName := '';
      Editing := '';
      StatusBar1.Panels[1].Text := SPanel1;
      StatusBar1.Panels[2].Text := SPanel2;
      StatusBar1.Panels[3].Text := SPanel3;
      StatusBar1.Panels[4].Text := SPanel4;
      with DataModuleMain.ZConnectionDB do
      begin
        Database := '';
        HostName := '';
        LibraryLocation := '';
        Password := '';
        Port := 0;
        Protocol := '';
        User := '';
        LoginPrompt := False;
      end;
      Screen.Cursor := crDefault;
      {$IFDEF WINDOWS}
        if MessageDlg('Workspace could not be opened due cancellation of login, an invalid database or misconfiguration in the "workspace.ini"! Do you want to view the workspace configuration now?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
          ExecuteProcess(LazUTF8.UTF8ToSys('notepad.exe'), WSpaceDir + '\workspace.ini', []);
      {$ENDIF}
      {$IFDEF UNIX}
        MessageDlg('Workspace could not be opened due cancellation of login, an invalid database or misconfiguration in the "workspace.ini"! Please check your workspace settings and try again.', mtError, [mbOK], 0);
      {$ENDIF}
    end;
    Application.ProcessMessages;
    Screen.Cursor := crDefault;
  end
  else //workspace is locked and user does not want to continue
  begin
    MessageDlg('This Aquabase workspace is locked by another user or was not closed properly on the last exit. See the ".workspace.lck" file (hidden) in the workspace for more information. Opening workspace aborted.', mtInformation, [mbOK], 0);
    WSpaceActive := False;
    WSpaceDir := '';
    CurrentSite := '';
    FilterName := '';
    StatusBar1.Panels[1].Text := SPanel1;
    StatusBar1.Panels[4].Text := SPanel4;
    Editing := SPanel3;
  end;
end;

procedure TMainForm.MenuItemHelponShortcutsClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TMainForm.MenuItemUserdefinedParametersClick(Sender: TObject);
begin
  with TUserChemistryForm.Create(Application) do
    Show;
end;

procedure TMainForm.BoreholeLog2Click(Sender: TObject);
begin
  with TGeollogSettingsForm.Create(Application) do
    ShowModal;
end;

procedure TMainForm.CurrentStandardClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 5 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TEditLookupForm.Create(Application) do
  begin
    if ChemStandard = 2 then
      EditDataSource.DataSet := ClassQuery
    else
      EditDataSource.DataSet := StandardQuery;
    Caption := 'Editing Chemistry Standard';
    StandardTableName := DataModuleMain.GetChemStdFileName;
    ShowModal;
  end;
end;

procedure TMainForm.CreateEditStandardClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 3 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TEditLookupForm.Create(Application) do
  begin
    EditDataSource.DataSet := DataModuleMain.StandDescrTable;
    Caption := 'Edit Chemistry Standards';
    ShowModal;
  end;
end;

procedure TMainForm.ProjectInformation1Click(Sender: TObject);
begin
  MessageDlg('This report has not been implemented yet!', mtInformation, [mbOK], mrOK);
end;

procedure TMainForm.EditgeolbitmapsClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 5 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TEditLogpatternForm.Create(Application) do
    Show;
end;

procedure TMainForm.ChemistryStandard2Click(Sender: TObject);
begin
  MessageDlg('This report has not been implemented yet!', mtInformation, [mbOK], mrOK);
end;

procedure TMainForm.MenuItemStandardParametersClick(Sender: TObject);
begin
  with TChemistryForm.Create(Application) do
  begin
    Show;
  end;
end;

procedure TMainForm.Waterlevel2Click(Sender: TObject);
begin
  with TTimeWLReportSettingsForm.Create(Application) do
    ShowModal;
end;

procedure TMainForm.Dischargerate2Click(Sender: TObject);
begin
  with TTimeDisReportSettingsForm.Create(Application) do
    ShowModal;
end;

procedure TMainForm.Meterorology1Click(Sender: TObject);
begin
  MessageDlg('This report has not been implemented yet!', mtInformation, [mbOK], mrOK);
end;

procedure TMainForm.MenuItemRainEvaporationHumidityClick(Sender: TObject);
begin
  with TMeteorologyForm1.Create(Application) do
  begin
    Caption := 'Meteorology: Hydrologic Parameters';
    Show;
  end;
end;

procedure TMainForm.MenuItemTemperatureRadiationWindClick(Sender: TObject);
begin
  with TMeteorologyForm2.Create(Application) do
  begin
    Caption := 'Meteorology: Atmospheric Parameters';
    Show;
  end;
end;

procedure TMainForm.Chemistry1Click(Sender: TObject);
begin
  with TTimeChemReportSettingsForm.Create(Application) do
    ShowModal;
end;

procedure TMainForm.GroundwaterProperties1Click(Sender: TObject);
begin
  with TGWPropertiesForm.Create(Application) do
  begin
    Caption := 'Down-the-hole Groundwater Properties - [' + UpperCase(FilterName) + ']';
    Caption := 'Down-the-hole Groundwater Properties';
    Show;
  end;
end;

procedure TMainForm.MenuItemRunSQLQueryClick(Sender: TObject);
begin
  with TSQLQueryForm.Create(Application) do
    Show;
end;

procedure TMainForm.Boreholeproperties1Click(Sender: TObject);
begin
  with TBHPropertiesForm.Create(Application) do
  begin
    Caption := 'Borehole Properties';
    Show;
  end;
end;

procedure TMainForm.MenuItemGeoelectricMethodsClick(Sender: TObject);
begin
  with TGeoElectricForm.Create(Application) do
  begin
    Caption := 'Geoelectric Methods';
    Show;
  end;
end;

procedure TMainForm.MenuItemRadioactiveMethodsClick(Sender: TObject);
begin
  with TRadioActiveForm.Create(Application) do
  begin
    Caption := 'Radioactive Methods';
    Show;
  end;
end;

procedure TMainForm.ButtonsUp(const TheToolBar: TToolBar; NotUp: ShortInt);

var m: Byte;

begin
  for m := 0 to TheToolBar.ButtonCount - 1 do
    if m <> NotUp then TheToolBar.Buttons[m].Down := False;
end;

procedure TMainForm.FieldMeasurements1Click(Sender: TObject);
begin
  MessageDlg('This report has not been implemented yet!', mtInformation, [mbOK], mrOK);
end;

procedure TMainForm.MeterReading2Click(Sender: TObject);
begin
  MessageDlg('This report has not been implemented yet!', mtInformation, [mbOK], mrOK);
end;

procedure TMainForm.SiteMonitoringReportClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 2 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TSiteMonRepSetForm.Create(Application) do
  begin
    TitleEdit.Text := 'SITE MONITORING REPORT';
    ShowModal;
  end;
end;

procedure TMainForm.Penetrationrate2Click(Sender: TObject);
begin
  MessageDlg('This report has not been implemented yet!', mtInformation, [mbOK], mrOK);
end;

procedure TMainForm.XMLPropStorage1RestoreProperties(Sender: TObject);
var
  TempStandard: ShortString;
begin
  AutoEditData := StrToBool(XMLPropStorage1.StoredValues[0].Value);
  Language := XMLPropStorage1.StoredValues[1].Value;
  if Language = '' then Language := 'English';
  if XMLPropStorage1.StoredValues[2].Value = '' then
    SettingsDir := ProgramDir
  else SettingsDir := XMLPropStorage1.StoredValues[2].Value;
  if (not FileExists(SettingsDir + DirectorySeparator + 'settings.sqlite')) then
    SettingsDir := ProgramDir;
  DefaultSettingsDir := SettingsDir;
  VolumeUnit := XMLPropStorage1.StoredValues[3].Value;
  if VolumeUnit = '' then VolumeUnit := 'l';
  LengthUnit := XMLPropStorage1.StoredValues[4].Value;
  if LengthUnit = '' then LengthUnit := 'm';
  TimeUnit := XMLPropStorage1.StoredValues[5].Value;
  if TimeUnit = '' then TimeUnit := 's';
  DiamUnit := XMLPropStorage1.StoredValues[6].Value;
  if DiamUnit = '' then DiamUnit := 'mm';
  ChemUnit := XMLPropStorage1.StoredValues[7].Value;
  if ChemUnit = '' then ChemUnit := 'mg/l';
  ECUnit := XMLPropStorage1.StoredValues[8].Value;
  if ECUnit = '' then ECUnit := 'mS/m';
  PressureUnit := XMLPropStorage1.StoredValues[9].Value;
  if PressureUnit = '' then PressureUnit := 'Pa';
  if XMLPropStorage1.StoredValues[10].Value = '' then
    AsN := True
  else
    AsN := StrToBool(XMLPropStorage1.StoredValues[10].Value);
  TempStandard := XMLPropStorage1.StoredValues[11].Value; //check if this is still an old value
  if TempStandard = '' then
    ChemStandard := 0
  else //there is a value
  if Length(TempStandard) > 2 then //still old format stored in XML
  begin
    with DataModuleMain.StandDescrTable do
    begin
      Open;
      if Locate('STAND_DESCR', TempStandard, [loCaseInsensitive]) then
        ChemStandard := FieldByName('ID').AsInteger
      else
        ChemStandard := 0;
      Close;
    end;
  end
  else //already new format = Word
  try
    ChemStandard := StrToInt(TempStandard);
  except on EConvertError do
    begin
      MessageDlg('Invalid chemistry standard found! Resetting to the first available valid standard.', mtWarning, [mbOK], 0);
      ChemStandard := 0;
    end;
  end; //of try
  MaxRecFont.Name := XMLPropStorage1.StoredValues[12].Value;
  if MaxRecFont.Name = '' then MaxRecFont.Name := 'Default';
  MaxRecFont.Size := StrToInt(XMLPropStorage1.StoredValues[13].Value);
  MaxRecFont.Color := StringToColor(XMLPropStorage1.StoredValues[14].Value);
  MaxAllFont.Name := XMLPropStorage1.StoredValues[15].Value;
  if MaxAllFont.Name = '' then MaxAllFont.Name := 'Default';
  MaxAllFont.Size := StrToInt(XMLPropStorage1.StoredValues[16].Value);
  MaxAllFont.Color := StringToColor(XMLPropStorage1.StoredValues[17].Value);
  if XMLPropStorage1.StoredValues[18].Value = '' then
    MaxAllFont.Style := [fsBold]
  else
    MaxAllFont.Style := ConvertStyle(XMLPropStorage1.StoredValues[18].Value);
  MinRecFont.Name := XMLPropStorage1.StoredValues[19].Value;
  if MinRecFont.Name = '' then MinRecFont.Name := 'Default';
  MinRecFont.Size := StrToInt(XMLPropStorage1.StoredValues[20].Value);
  MinRecFont.Color := StringToColor(XMLPropStorage1.StoredValues[21].Value);
  MinAllFont.Name := XMLPropStorage1.StoredValues[22].Value;
  if MinAllFont.Name = '' then MinAllFont.Name := 'Default';
  MinAllFont.Size := StrToInt(XMLPropStorage1.StoredValues[23].Value);
  MinAllFont.Color := StringToColor(XMLPropStorage1.StoredValues[24].Value);
  if XMLPropStorage1.StoredValues[25].Value = '' then
    MinAllFont.Style := [fsBold]
  else
    MinAllFont.Style := ConvertStyle(XMLPropStorage1.StoredValues[25].Value);
  LeftMargin := StrToInt(XMLPropStorage1.StoredValues[26].Value);
  TopMargin := StrToInt(XMLPropStorage1.StoredValues[27].Value);
  BotMargin := StrToInt(XMLPropStorage1.StoredValues[28].Value);
  ColumnHeaderBandColor := StringToColor(XMLPropStorage1.StoredValues[29].Value);
  LLeftMargin := StrToInt(XMLPropStorage1.StoredValues[30].Value);
  LTopMargin := StrToInt(XMLPropStorage1.StoredValues[31].Value);
  LRightMargin := StrToInt(XMLPropStorage1.StoredValues[32].Value);
  ReportHeaderBandColor := StringToColor(XMLPropStorage1.StoredValues[33].Value);
  Country := XMLPropStorage1.StoredValues[34].Value;
  if Country = '' then Country := 'South Africa';
  PrintNoInfo := StrToBool(XMLPropStorage1.StoredValues[35].Value);
  ReportFont.Name := XMLPropStorage1.StoredValues[36].Value;
  if ReportFont.Name = '' then ReportFont.Name := 'Arial';
  if XMLPropStorage1.StoredValues[37].Value = '' then
    ReportFont.Size := 8
  else
    ReportFont.Size := StrToInt(XMLPropStorage1.StoredValues[37].Value);
  if XMLPropStorage1.StoredValues[38].Value = '' then
    ReportFont.Color := clBlack
  else
    ReportFont.Color := StringToColor(XMLPropStorage1.StoredValues[38].Value);
  if XMLPropStorage1.StoredValues[39].Value = '' then
    ReportFont.Style := []
  else
    ReportFont.Style := ConvertStyle(XMLPropStorage1.StoredValues[39].Value);
  DisUnit := VolumeUnit + '/' + TimeUnit;
  QGISExe := XMLPropStorage1.StoredValues[40].Value;
  if QGISExe = '' then QGISExe := 'qgis';
end;

procedure TMainForm.XMLPropStorage1SavingProperties(Sender: TObject);
begin
  XMLPropStorage1.StoredValues[0].Value := BoolToStr(AutoEditData);
  XMLPropStorage1.StoredValues[1].Value := Language;
  if SettingsDir <> WSpaceDir then
    XMLPropStorage1.StoredValues[2].Value := SettingsDir;
  XMLPropStorage1.StoredValues[3].Value := VolumeUnit;
  XMLPropStorage1.StoredValues[4].Value := LengthUnit;
  XMLPropStorage1.StoredValues[5].Value := TimeUnit;
  XMLPropStorage1.StoredValues[6].Value := DiamUnit;
  XMLPropStorage1.StoredValues[7].Value := ChemUnit;
  XMLPropStorage1.StoredValues[8].Value := ECUnit;
  XMLPropStorage1.StoredValues[9].Value := PressureUnit;
  XMLPropStorage1.StoredValues[10].Value := BoolToStr(AsN);
  XMLPropStorage1.StoredValues[11].Value := IntToStr(ChemStandard);
  XMLPropStorage1.StoredValues[12].Value := MaxRecFont.Name;
  XMLPropStorage1.StoredValues[13].Value := IntToStr(MaxRecFont.Size);
  XMLPropStorage1.StoredValues[14].Value := IntToStr(MaxRecFont.Color);
  XMLPropStorage1.StoredValues[15].Value := MaxAllFont.Name;
  XMLPropStorage1.StoredValues[16].Value := IntToStr(MaxAllFont.Size);
  XMLPropStorage1.StoredValues[17].Value := IntToStr(MaxAllFont.Color);
  XMLPropStorage1.StoredValues[18].Value := ConvertFromStyle(MaxAllFont.Style);
  XMLPropStorage1.StoredValues[19].Value := MinRecFont.Name;
  XMLPropStorage1.StoredValues[20].Value := IntToStr(MinRecFont.Size);
  XMLPropStorage1.StoredValues[21].Value := IntToStr(MinRecFont.Color);
  XMLPropStorage1.StoredValues[22].Value := MinAllFont.Name;
  XMLPropStorage1.StoredValues[23].Value := IntToStr(MinAllFont.Size);
  XMLPropStorage1.StoredValues[24].Value := IntToStr(MinAllFont.Color);
  XMLPropStorage1.StoredValues[25].Value := ConvertFromStyle(MinAllFont.Style);
  XMLPropStorage1.StoredValues[26].Value := IntToStr(LeftMargin);
  XMLPropStorage1.StoredValues[27].Value := IntToStr(TopMargin);
  XMLPropStorage1.StoredValues[28].Value := IntToStr(BotMargin);
  XMLPropStorage1.StoredValues[29].Value := IntToStr(ColumnHeaderBandColor);
  XMLPropStorage1.StoredValues[30].Value := IntToStr(LLeftMargin);
  XMLPropStorage1.StoredValues[31].Value := IntToStr(LTopMargin);
  XMLPropStorage1.StoredValues[32].Value := IntToStr(LRightMargin);
  XMLPropStorage1.StoredValues[33].Value := IntToStr(ReportHeaderBandColor);
  XMLPropStorage1.StoredValues[34].Value := Country;
  XMLPropStorage1.StoredValues[35].Value := BoolToStr(PrintNoInfo);
  XMLPropStorage1.StoredValues[36].Value := ReportFont.Name;
  XMLPropStorage1.StoredValues[37].Value := IntToStr(ReportFont.Size);
  XMLPropStorage1.StoredValues[38].Value := IntToStr(ReportFont.Color);
  XMLPropStorage1.StoredValues[39].Value := ConvertFromStyle(ReportFont.Style);
  XMLPropStorage1.StoredValues[40].Value := QGISExe;
end;

procedure TMainForm.Yield1Click(Sender: TObject);
begin
  MessageDlg('This report has not been implemented yet!', mtInformation, [mbOK], mrOK);
end;

procedure TMainForm.Downtheholegeophysics1Click(Sender: TObject);
begin
  MessageDlg('This report has not been implemented yet!', mtInformation, [mbOK], mrOK);
end;

procedure TMainForm.GeophysicalInformation1Click(Sender: TObject);
begin
  MessageDlg('This report has not been implemented yet!', mtInformation, [mbOK], mrOK);
end;

procedure TMainForm.MenuItemReconcileSitesClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 5 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TFormReconcile.Create(Application) do
    ShowModal;
end;

procedure TMainForm.Distancedependent1Click(Sender: TObject);
begin
  MessageDlg('This report has not been implemented yet!', mtInformation, [mbOK], mrOK);
end;

procedure TMainForm.MeterReading3Click(Sender: TObject);
begin
  MessageDlg('This report has not been implemented yet!', mtInformation, [mbOK], mrOK);
end;

procedure TMainForm.Siteimages1Click(Sender: TObject);
begin
  MessageDlg('This report has not been implemented yet!', mtInformation, [mbOK], mrOK);
end;

procedure TMainForm.MenuItemDatabasespecificClick(Sender: TObject);
begin
  with TdbStatForm.Create(Application) do
    Show;
end;

procedure TMainForm.MenuItemSitespecificClick(Sender: TObject);
begin
  with TdbStatForm.Create(Application) do
  begin
    SiteStats := True;
    Show;
  end;
end;

procedure TMainForm.MenuItemSiteTargetsClick(Sender: TObject);
begin
  with TTargetsForm.Create(Application) do
  begin
    Caption := 'Targets';
    Show;
  end;
end;

procedure TMainForm.DewateringSummary1Click(Sender: TObject);
begin
  with TExpDewaterForm.Create(Application) do
    Show;
end;

procedure TMainForm.EditFillMaterialColourClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 5 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TEditFillColourForm.Create(Application) do
    Show;
end;

procedure TMainForm.SurfaceHydrology2Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
    if VerDiff > 2 then
      MessageDlg(VersionMessage, mtError,[mbOK], 0)
    else
    {$ENDIF}
  with TSurfWatrRepSettingsForm.Create(Application) do
  begin
    with AvailableTablesList do
    begin
      Add('basicinf');
      Add('stage_hi');
      Add('flow_dis');
      Add('strmvelo');
      Add('intake__');
    end;
    ShowModal;
  end;
end;

procedure TMainForm.DatatoFC1Click(Sender: TObject);
begin
  with TfrmFCData.Create(Application) do
    ShowModal;
end;

procedure TMainForm.MenuItemImportOldAquabaseClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 5 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TImprtOldABForm.Create(Application) do
    Show;
end;

procedure TMainForm.CreateViewClick(Sender: TObject);
begin
  with TFilterForm.Create(Application) do
    Show;
end;

procedure TMainForm.MenuItemManageFiltersClick(Sender: TObject);
begin
  with TManageViewsForm.Create(Application) do
    Show;
end;

procedure TMainForm.MenuBackUpSQLiteClick(Sender: TObject);
var
  SQLiteFileName: String;
begin
  if MessageDlg('Backup SQLite/Geopackage database', 'This will create a SQLite/Geopackage backup database in your workspace. Are you sure you want to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Screen.Cursor := crSQLWait;
    with DataModuleMain.ZConnectionDB do
    begin
      ExecuteDirect('PRAGMA journal_mode = Delete;');
      SQLiteFileName := Database;
    end;
    if not CopyFile(SQLiteFileName, WSpaceDir + DirectorySeparator + 'Backup-' + FormatDateTime('YYYYMMDD', Date) + '-' + FormatDateTime('hhnn', Time) + '-' + ExtractFileName(SQLiteFileName)) then
    begin
      Screen.Cursor := crDefault;
      MessageDlg('Could not create backup database file from ' + ExtractFileName(SQLiteFileName) + '! Maybe it was open in another application?', mtWarning, [mbOK], 0);
    end
    else
    begin
      Screen.Cursor := crDefault;
      MessageDlg(ExtractFileName(SQLiteFileName) + ' successfully backed up!', mtInformation, [mbOK], 0);
    end;
    DataModuleMain.ZConnectionDB.ExecuteDirect('PRAGMA journal_mode = WAL;');
  end;
end;

procedure TMainForm.MenuItemColoursClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 5 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TEditColoursForm.Create(Application) do
    Show;
end;

procedure TMainForm.MenuItemStartQGISClick(Sender: TObject);
var
  AProcess: TProcess;
begin
  AProcess := TProcess.Create(nil);
  try
    {$IFDEF WINDOWS}
    AProcess.Executable := QGISExe;
    {$ENDIF}
    {$IFDEF UNIX}
    AProcess.Executable := 'qgis';
    {$ENDIF}
    AProcess.Execute;
    MessageDlg('QGIS has been started!', mtInformation, [mbOK], 0);
  except on E: EProcess do
    MessageDlg('QGIS could not be started! Please check the path to your QGIS executable in the Aquabase Preferences.', mtInformation, [mbOK], 0);
  end;
  AProcess.Free;
end;

procedure TMainForm.MenuItem22Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 3 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  if MessageDlg('Are you sure you want to synchronize the current Lookup table with the Default Lookup table? "No" will keep your current Lookup as is and you might not have the latest Lookup codes from recent updates.', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    DataModuleMain.ZConnectionDefaults.Connect;
end;

procedure TMainForm.MenuItemDWSClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 3 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with THydResForm.Create(Application) do
    Show;
end;

procedure TMainForm.MenuItemLithProfileClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 2 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TLithProfileSettingsForm.Create(Application) do
    ShowModal;
end;

procedure TMainForm.MenuItemPressureClick(Sender: TObject);
begin
  with TEditLookupForm.Create(Application) do
  begin
    UnitTableName := 'presunit';
    EditDataSource.DataSet := UnitQuery;
    Caption := 'Edit Atmospheric Pressure Units';
    ShowModal;
  end;
end;

procedure TMainForm.MenuItemViewCurrentClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 2 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TMapViewForm.Create(Application) do
  begin
    UseCurrent := True;
    UseView := FilterName;
    TheFactor := LengthFactor;
    TheUnit := LengthUnit + ' a.m.s.l.';
    Show;
  end;
end;

procedure TMainForm.MenuItemViewViewClick(Sender: TObject);
var
  CreateTheMap: Boolean;
begin
  CreateTheMap := True;
  {$IFDEF WINDOWS}
  if VerDiff > 2 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  if DataModuleMain.ZQueryView.RecordCount > 5000 then
    if MessageDlg('Your current View "' + FilterName + '" has more than 5000 records, which may take a while to display on the map! Are you sure you want to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      CreateTheMap := True
    else
      CreateTheMap := False;
  if CreateTheMap then
  begin
    Cursor := crHourGlass;
    Application.ProcessMessages;
    with TMapViewForm.Create(Application) do
    begin
      UseView := FilterName;
      TheFactor := LengthFactor;
      TheUnit := LengthUnit + ' a.m.s.l.';
      Show;
    end;
  end;
end;

procedure TMainForm.MenuItemVQBClick(Sender: TObject);
var
  meuqb: TOQBuilderDialog;
  zeosengine: TOQBEngineZEOS;
begin
  {$IFDEF WINDOWS}
  if VerDiff > 3 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  try
    meuqb := TOQBuilderDialog.Create(nil);
    zeosengine := TOQBEngineZEOS.Create(nil);
    zeosengine.Connection := DataModuleMain.ZConnectionDB;
    meuqb.OQBEngine := zeosengine;
    meuqb.OQBEngine.DatabaseName := DataModuleMain.ZConnectionDB.Database;
    // for schema PostgreSQL
    zeosengine.SchemaPostgreSQL := 'public';
    zeosengine.ShowSystemTables := False;
    if meuqb.Execute then
      if meuqb.SQL.Text > '' then
        Clipboard.AsText := meuqb.SQL.Text;
  finally
    meuqb.Free;
    zeosengine.Free;
  end;
end;

procedure TMainForm.MenuItemChemChartsClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 5 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TChemChartSettingsForm.Create(Application) do
  begin
    FromMainMenu := True;
    ShowModal;
  end;
end;

procedure TMainForm.MenuItemKMLFileClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 3 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TWriteKMLForm.Create(Application) do
    ShowModal;
end;

procedure TMainForm.MenuItemLookupCodesReportClick(Sender: TObject);
begin
  with TLookupRepSetForm.Create(Application) do
  begin
    ShowModal;
  end;
end;

procedure TMainForm.MenuItemOthrParamClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 3 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TEditLookupForm.Create(Application) do
  begin
    EditDataSource.DataSet := Chem6DefQuery;
    Caption := 'Edit Other Parameters';
    ShowModal;
  end;
end;

procedure TMainForm.MenuItemQGISMarkClick(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  DataModuleMain.ZConnectionDB.ExecuteDirect('UPDATE basicinf SET QUADRANT = ''1'' WHERE QUADRANT = ''7'''); //reset
  DataModuleMain.ZConnectionDB.ExecuteDirect('UPDATE basicinf SET QUADRANT = ''7'' WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
  Screen.Cursor := crDefault;
  MessageDlg('Current site marked as selection in QGIS! Please use the Aquabase/QGIS plugin to go to the selected site in QGIS.', mtInformation, [mbOK], 0);
end;

procedure TMainForm.MenuItemCopyClick(Sender: TObject);
var
  TheActiveForm: TForm;
begin
  TheActiveForm := Application.FindComponent(FormName) as TForm;
  with TheActiveForm do
  begin
    if (ActiveControl is TStringCellEditor) then
    with (ActiveControl as TStringCellEditor) do
    begin
      if SelLength > 0 then
        Clipboard.AsText := SelText;
      SetFocus;
      HasSelection := False;
    end
    else
    if (ActiveControl is TDBGrid) then
    with (ActiveControl as TDBGrid) do
    begin
      ClipBoard.AsText := SelectedField.AsString;
      SetFocus;
    end
    else
    if ActiveControl is TDBEdit then
    with (ActiveControl as TDBEdit) do
    begin
      CopyToClipBoard;
      SetFocus;
      HasSelection := False;
    end
    else
    if ActiveControl is TMaskEdit then
    with (ActiveControl as TMaskEdit) do
    begin
      CopyToClipBoard;
      SetFocus;
      HasSelection := False;
    end;
  end;
end;

procedure TMainForm.MenuItemQGISGoToClick(Sender: TObject);
begin
  with DataModuleMain.CheckQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT SITE_ID_NR FROM basicinf WHERE QUADRANT = ''8''');
    Open;
    if RecordCount = 1 then
      DataModuleMain.ZQueryView.Locate('SITE_ID_NR', FieldByName('SITE_ID_NR').Value, [])
    else
      MessageDlg('No site selected in QGIS! Please use the Aquabase/QGIS plugin to select and register a single site.', mtError, [mbOK], 0);
    Close;
    SQL.Clear;
  end;
end;

procedure TMainForm.MenuItemReloadLookupClick(Sender: TObject);
begin
  DataModuleMain.LookupTable.Refresh;
  ShowMessage('Lookup codes table successfully reloaded. You may have to close and reopen entry forms for any new lookup codes to be shown.');
end;

procedure TMainForm.MenuItemReportDocsClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 3 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TReportDocsForm.Create(Application) do
    Show;
end;

procedure TMainForm.MenuItemSaveMarkedClick(Sender: TObject);
var
  InString, NewViewName: String;
  s: Integer;
begin
  InString := '';
  if MarkedSiteList.Count > 0 then
  begin
    with TProvideViewNameForm.Create(Application) do
    begin
      if ShowModal = mrOK then
      begin
        for s := 0 to MarkedSiteList.Count - 1 do
          InString := InString + QuotedStr(MarkedSiteList.Strings[s]) + ', ';
        //Delete last comma
        Delete(InString, Length(InString) - 1, 2);
        NewViewName := ViewName;
        if DataModuleMain.ZConnectionDB.Tag = 1 then
        begin
          DataModuleMain.ZConnectionDB.ExecuteDirect('DROP VIEW IF EXISTS [' + NewViewName + '];');
          DataModuleMain.ZConnectionDB.ExecuteDirect('CREATE VIEW [' +
            NewViewName + '] AS SELECT SITE_ID_NR FROM basicinf WHERE SITE_ID_NR IN (' + InString + ')');
        end
        else
        if DataModuleMain.ZConnectionDB.Tag = 5 then
        begin
          DataModuleMain.ZConnectionDB.ExecuteDirect('IF OBJECT_ID('+ QuotedStr(NewViewName) + ', ''V'') IS NOT NULL DROP VIEW ' + NewViewName);
          DataModuleMain.ZConnectionDB.ExecuteDirect('CREATE VIEW ' +
            NewViewName + ' AS SELECT SITE_ID_NR FROM basicinf WHERE SITE_ID_NR IN (' + InString + ')');
        end
        else
        begin
          DataModuleMain.ZConnectionDB.ExecuteDirect('CREATE OR REPLACE VIEW ' +
            NewViewName + ' AS SELECT SITE_ID_NR FROM basicinf WHERE SITE_ID_NR IN (' + InString + ')');
          if CheckBox1.Checked then
          try
            if DataModuleMain.ZConnectionDB.Tag = 4 then //postgresql
              DataModuleMain.ZConnectionDB.ExecuteDirect('GRANT SELECT ON TABLE ' + NewViewName + ' TO public')
            else
              DataModuleMain.ZConnectionDB.ExecuteDirect('GRANT SELECT ON TABLE `' + NewViewName + '` TO ''%''@''%''');
          except on E: Exception do
            MessageDlg(E.Message + ': Ask your database administrator for "GRANT" permissions.', mtError, [mbOK], 0);
          end;
        end;
        Close;
        if MessageDlg('Do you want to set "' + NewViewName + '" as new filter?',
          mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          with DataModuleMain.ZQueryView do
          begin
            Close;
            FilterName := NewViewName;
            Open;
          end;
        end;
      end
      else
        MessageDlg('Create View cancelled! No view will be created from the marked sites!', mtInformation, [mbOK],0);
    end;
  end
  else MessageDlg('There are no marked sites for a new view!', mtError, [mbOK], 0);
end;

procedure TMainForm.MenuItemSiteLinkedClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 3 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TSiteReportDetailForm.Create(Application) do
  begin
    Caption := 'Site-Linked Reports';
    Show;
  end;
end;

procedure TMainForm.MenuItemSiteStatusClick(Sender: TObject);
begin
  with TSiteStatusForm.Create(Application) do
  begin
    Caption := 'Site Status';
    Show;
  end;
end;

procedure TMainForm.MenuItemWMSClick(Sender: TObject);
begin
  with TImportWMSForm.Create(Application) do
    ShowModal;
end;

procedure TMainForm.MenuItemWriteMemberClick(Sender: TObject);
begin
  with TWriteMemberForm.Create(Application) do
    ShowModal;
end;

procedure TMainForm.MenuVacuumClick(Sender: TObject);
begin
  if MessageDlg('Vacuum SQLite database', 'This will clean-up the SQLite database in your workspace. Are you sure you want to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Screen.Cursor := crSQLWait;
    DataModuleMain.ZConnectionDB.ExecuteDirect('vacuum');
    Screen.Cursor := crDefault;
    ShowMessage('Done with VACUUM. Your database should be smaller and faster now.');
  end;
end;

procedure TMainForm.OpenDialogWorkspaceCanClose(Sender: TObject; var CanClose: boolean);
begin
  CanClose := OpenDialogWorkspace.Tag = 0; //cannot close if Help was opened
  OpenDialogWorkspace.Tag := 0; //reset so that it can be closed
end;

procedure TMainForm.OpenDialogWorkspaceHelpClicked(Sender: TObject);
begin
  OpenDialogWorkspace.Tag := 1;
  DataModuleMain.OpenHelp(Sender);
end;

procedure TMainForm.ToolBar3StartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  CoolBar1.Bands[2].Break := False;
end;

procedure TMainForm.ToolBar4StartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  CoolBar1.Bands[3].Break := False;
end;

procedure TMainForm.TimeChartsClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 5 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TTimeDeptForm.Create(Application) do
  begin
    ComboBoxData1.Enabled := True;
    ComboBoxView1.Enabled := True;
    TabSheetTopRightAxis.TabVisible := True;
    TabSheetBotChart.TabVisible := True;
    ShowModal;
  end;
end;

procedure TMainForm.MenuItemUpdateCoordsClick(Sender: TObject);
begin
  //check for NGDB_FLAG = 9 (geometry changed)
  with DataModuleMain.CheckQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT SITE_ID_NR, LONGITUDE, LATITUDE, ALTITUDE, NGDB_FLAG FROM basicinf WHERE NGDB_FLAG = ' + IntToStr(UpdtdByTrigger));
    Open;
    if RecordCount > 0 then
    begin
      if MessageDlg('It seems that ' + IntToStr(RecordCount) + ' site geometries have changed. Do you want to update the coordinates accordingly now?', mtConfirmation, [mbYes, mbNo], mrNo) = mrYes then
      begin
        Screen.Cursor := crSQLWait;
        First;
        while not EOF do
        begin
          DataModuleMain.UpdateCoordsWithCs2cs(FieldByName('LONGITUDE').Value, FieldByName('LATITUDE').Value, FieldByName('SITE_ID_NR').Value);
          Next;
        end;
        DataModuleMain.BasicinfQuery.Refresh;
        Screen.Cursor := crDefault;
        Application.ProcessMessages;
      end
      else
        MessageDlg('You have selected not to update the coordinates now.', mtInformation, [mbOK], 0);
    end
    else
      MessageDlg('There are no changed geometries and therefore no coordinates to be updated.', mtInformation, [mbOK], 0);
    Close;
    SQL.Clear;
  end;
end;

procedure TMainForm.MenuItemResetViewClick(Sender: TObject);
var
  LastCurrentSite: ShortString;
begin
  LastCurrentSite := CurrentSite;
  with DataModuleMain.ZQueryView do
  begin
    Close;
    FilterName := 'allsites';
    Open;
    Locate('SITE_ID_NR', LastCurrentSite, []);
  end;
  MenuItemResetView.Enabled := False;
  ToolButtonResetView.Enabled := False;
  ShowMessage('The default "allsites" is now the active View.');
end;

procedure TMainForm.MenuItemSQLScriptClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 5 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  if MessageDlg('WARNING - This may be dangerous for your database!', 'Now, here come DEVILS! If you are sure you know what you are doing, you may continue. Otherwise cancel!', mtWarning, [mbOK, mbCancel], 0) = mrOK then
  begin
    with TSQLScriptForm.Create(Application) do
      Show;
  end;
end;

procedure TMainForm.MenuItemNewSQLiteClick(Sender: TObject);
begin
  with TApplyNewSQLiteForm.Create(Application) do
    Show;
end;

procedure TMainForm.MenuItemPumpingTestClick(Sender: TObject);
begin
  with TPumptestForm.Create(Application) do
  begin
    Caption := 'Pumping Test';
    Show;
  end;
end;

procedure TMainForm.MenuItemApplyCoordsClick(Sender: TObject);
var GeomFound, ApplyCoords: Boolean;
begin
  //check if there are unresolved geometries
  with DataModuleMain.CheckQuery do
  begin
    Connection := DataModuleMain.ZConnectionDB;
    SQL.Clear;
    SQL.Add('SELECT SITE_ID_NR, NGDB_FLAG FROM basicinf WHERE NGDB_FLAG = ' + IntToStr(UpdtdByTrigger));
    Open;
    GeomFound := RecordCount > 0;
    Close;
    SQL.Clear;
  end;
  if GeomFound then
  begin
    if MessageDlg('There are unresolved geometries for which the coordinates have not been updated! These will be overwritten if you continue. Are you sure you want to continue?', mtWarning, [mbYes, mbNo], 0) = mrYes then
      ApplyCoords := True
    else
      ApplyCoords := False;
  end
  else ApplyCoords := True;
  if ApplyCoords then
  begin
    ApplyCoordForm := TApplyCoordForm.Create(Application);
    ApplyCoordForm.ShowModal;
  end;
end;

procedure TMainForm.MenuItemPrintSetupClick(Sender: TObject);
begin
  PrintDialog1.Execute;
end;

procedure TMainForm.FormActivate(Sender: TObject);
var
  TempTableList: TStringList;
begin
  //Check if there is a view for qgis_selection
  if WSpaceActive and MenuItemQGIS.Visible then
  with DataModuleMain.CheckQuery do
  begin
    Screen.Cursor := crSQLWait;
    Connection := DataModuleMain.ZConnectionDB;
    SQL.Clear;
    SQL.Add('SELECT QUADRANT FROM basicinf WHERE QUADRANT = ' + QuotedStr('9'));
    Open;
    Screen.Cursor := crDefault;
    if RecordCount > 0 then
    begin
      TempTableList := TStringList.Create;
      DataModuleMain.ZConnectionDB.DbcConnection.GetMetadata.ClearCache;
      DataModuleMain.ZConnectionDB.GetTableNames('qgis_selection', TempTableList);
      if TempTableList.Count = 0 then
      begin
        MessageDlg('It seems that there are sites that have been selected from Basic Information in QGIS. The "qgis_selection" view will therefore be created now. Use the view to see the selection!', mtInformation, [mbOK], 0);
        DataModulemain.ZConnectionDB.ExecuteDirect('CREATE VIEW qgis_selection AS SELECT SITE_ID_NR FROM basicinf WHERE QUADRANT = ''9''');
      end;
      TempTableList.Free;
    end;
    Close;
  end;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  if WindowState = wsMaximized then Height := 70; //for now, check when adding toolbars
  with StatusBar1 do
  begin
    Panels[0].Width := Round(Width * 0.25);
    Panels[1].Width := Round(Width * 0.15);
    Panels[2].Width := 100;
    Panels[3].Width := Round(Width * 0.15);
  end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  DefaultMonitor := dmPrimary;
  case Tag of
    0: WindowState := wsNormal;
    1: WindowState := wsNormal; //to make sure the minimized window actually opens and the user can see it
    2: WindowState := wsMaximized;
  end;
  UpdateWSpaceMenu(False);
  UpdateMenus;
  AppFont := MainForm.Font;
  StatusBar1.UseSystemFont := False;
  StatusBar1.ParentFont := False;
  StatusBar1.Font.Assign(AppFont);
end;

procedure TMainForm.FormWindowStateChange(Sender: TObject);
begin
  case WindowState of
    wsNormal: Tag := 0;
    wsMinimized: Tag := 1;
    wsMaximized: Tag := 2;
  end;
  if Tag = 2 then Height := 70;
end;

procedure TMainForm.DistanceChartsClick(Sender: TObject);
begin
  ShowMessage('This function has not been re-implemented yet! But as they say: Watch this space!');
end;

procedure TMainForm.MenuItem4Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 2 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TLoggerImportForm.Create(Application) do
    ShowModal;
end;

procedure TMainForm.MenuItemBoxWhiskerClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 2 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TBoxSettingsForm.Create(Application) do
    Show;
end;

procedure TMainForm.MenuItemChemDataClick(Sender: TObject);
begin
  with TImportChemForm.Create(Application) do
    ShowModal;
end;

procedure TMainForm.MenuItemLithLogClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 5 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with DataModuleMain.CheckQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT SITE_ID_NR FROM holediam WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
    Open;
    if RecordCount > 0 then
    with TGeollogSettingsForm.Create(Application) do
    begin
      IsReport := False;
      ShowModal;
    end
    else
      MessageDlg('There is no borehole diameter information for the current site (is this a borehole/well?)! Log not possible.', mtError, [mbOK], 0);
    Close;
    SQL.Clear;
  end;
end;

end.
