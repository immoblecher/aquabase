{ Copyright (C) 2025 Immo Blecher immo@blecher.co.za

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
unit Profilng;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLType, StdCtrls,
  DBCtrls, ExtCtrls, Buttons, DBGrids, ComCtrls, ZDataset, ZSqlMetadata,
  ZAbstractRODataset, Db, Menus, Clipbrd, XMLPropStorage, SpinEx;

type

  { TProfilingForm }

  TProfilingForm = class(TForm)
    CollarLabel: TLabel;
    DataSource7: TDataSource;
    DBGrid6: TDBGrid;
    DBGrid7: TDBGrid;
    DepthLabel: TLabel;
    DetailNavigator: TDBNavigator;
    EditDATE_END: TDBEdit;
    EditDATE_ENTRY: TDBEdit;
    EditDATE_START: TDBEdit;
    EditDATE_UPDTD: TDBEdit;
    EditDIRECTION: TDBEdit;
    EditLENGTH: TDBEdit;
    EditResults: TEdit;
    EditSITE_NAME: TDBEdit;
    EditSITING_LEAD: TDBEdit;
    EditTRAV_NR: TDBEdit;
    EditX_Coord: TDBEdit;
    EditY_Coord: TDBEdit;
    EM34: TTabSheet;
    DBGrid2: TDBGrid;
    Genie: TTabSheet;
    DBGrid3: TDBGrid;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label2: TLabel;
    Label26: TLabel;
    LengthLabel: TLabel;
    LongitudeLabel: TLabel;
    Magnetics: TTabSheet;
    Panel1: TPanel;
    CloseBitBtn: TBitBtn;
    HelpBitBtn: TBitBtn;
    EditNavigator: TDBNavigator;
    Panel2: TPanel;
    Panel4: TPanel;
    ProfilePageControl: TPageControl;
    RecordText: TStaticText;
    DBGrid4: TDBGrid;
    Resistivity: TTabSheet;
    SitingLabel: TLabel;
    SpacingSpinEdit: TSpinEditEx;
    StaticText1: TStaticText;
    GraviTabSheet: TTabSheet;
    TabSheet1: TTabSheet;
    VLFTabSheet: TTabSheet;
    TraverseNavigator: TDBNavigator;
    CurrentComboBox: TComboBox;
    TraverseTable: TZTable;
    TraverseDataSource: TDataSource;
    MagTable: TZTable;
    EMTable: TZTable;
    GenieTable: TZTable;
    ResTable: TZTable;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DataSource4: TDataSource;
    TraverseTableTRAV_NR: TStringField;
    TraverseTableSITE_NAME: TStringField;
    TraverseTableSITE_LEAD: TStringField;
    TraverseTableLONGITUDE: TFloatField;
    TraverseTableLATITUDE: TFloatField;
    TraverseTableDIRECTION: TSmallintField;
    TraverseTableLENGTH: TFloatField;
    TraverseTableDATE_START: TStringField;
    TraverseTableDATE_END: TStringField;
    TraverseTableDATE_ENTER: TStringField;
    TraverseTableDATE_UPDTD: TStringField;
    MagTableTRAV_NR: TStringField;
    MagTablePEG_NR: TStringField;
    MagTableREADING: TFloatField;
    MagTableCOMMENT: TStringField;
    FindTable: TZTable;
    FindTableSITE_ID_NR: TStringField;
    PopupMenu1: TPopupMenu;
    GotoBookmark: TMenuItem;
    SetBookmark: TMenuItem;
    N16: TMenuItem;
    CutMenu: TMenuItem;
    CopyMenu: TMenuItem;
    PasteMenu: TMenuItem;
    FindTableTRAV_NR: TStringField;
    EMTableTRAV_NR: TStringField;
    EMTablePEG_NR: TStringField;
    EMTableVERT_READ: TFloatField;
    EMTableHOR_READ: TFloatField;
    EMTableSPACING: TSmallintField;
    EMTableCOMMENT: TStringField;
    GenieTableTRAV_NR: TStringField;
    GenieTablePEG_NR: TStringField;
    GenieTableREADING: TFloatField;
    GenieTableSPACING: TSmallintField;
    GenieTableCOMMENT: TStringField;
    ResTableTRAV_NR: TStringField;
    ResTablePEG_NR: TStringField;
    ResTableREADING: TFloatField;
    ResTableCOMMENT: TStringField;
    GraphSpeedButton: TSpeedButton;
    DBGrid5: TDBGrid;
    XMLPropStorage1: TXMLPropStorage;
    RecSitesTable: TZTable;
    RecSitesTableTRAV_NR: TStringField;
    RecSitesTableDIST_ORIG: TFloatField;
    RecSitesTableHOR_OFFSET: TFloatField;
    RecSitesTablePRIORITY: TSmallintField;
    RecSitesTableDATE_PRIOR: TStringField;
    RecSitesTableSITE_ID_NR: TStringField;
    RecSitesTableCOMMENT: TStringField;
    DataSource6: TDataSource;
    VLFTable: TZTable;
    DataSource5: TDataSource;
    VLFTableTRAV_NR: TStringField;
    VLFTablePEG_NR: TStringField;
    VLFTableIN_PHASE: TFloatField;
    VLFTableOUT_PHASE: TFloatField;
    VLFTableUNFILTERED: TFloatField;
    VLFTableCOMMENT: TStringField;
    SiteTable: TZTable;
    EMTableSTATION: TFloatField;
    GenieTableSTATION: TFloatField;
    ResTableSTATION: TFloatField;
    VLFTableSTATION: TFloatField;
    MagTableSTATION: TFloatField;
    X_CoordLabel: TLabel;
    Y_CoordLabel: TLabel;
    ZQueryGravi: TZQuery;
    DBMetadata: TZSQLMetadata;
    ZQueryGraviCOMMENTS: TStringField;
    ZQueryGraviPEG_NR: TStringField;
    ZQueryGraviREADING: TZDoubleField;
    ZQueryGraviSTATION: TZInt64Field;
    ZQueryGraviTRAV_NR: TZRawCLobField;
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure DBGrid7GetCellHint(Sender: TObject; Column: TColumn;
      var AText: String);
    procedure DetailNavigatorBeforeAction(Sender: TObject;
      Button: TDBNavButtonType);
    procedure DetailNavigatorClick(Sender: TObject; Button: TDBNavButtonType);
    procedure EditResultsEditingDone(Sender: TObject);
    procedure EMTableAfterOpen(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure GenieTableAfterOpen(DataSet: TDataSet);
    procedure MagTableAfterOpen(DataSet: TDataSet);
    procedure GeophTableCOMMENTSetText(Sender: TField; const aText: string);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure GotoBookmarkClick(Sender: TObject);
    procedure ProfilePageControlEnter(Sender: TObject);
    procedure ResTableAfterOpen(DataSet: TDataSet);
    procedure SetBookmarkClick(Sender: TObject);
    procedure CutMenuClick(Sender: TObject);
    procedure CopyMenuClick(Sender: TObject);
    procedure PasteMenuClick(Sender: TObject);
    procedure GeophTableSetText(Sender: TField; const aText: String);
    procedure CloseBitBtnClick(Sender: TObject);
    procedure TraverseTableDATEValidate(Sender: TField);
    procedure TraverseTableNewRecord(DataSet: TDataSet);
    procedure TraverseTableBeforePost(DataSet: TDataSet);
    procedure TableNewRecord(DataSet: TDataSet);
    procedure GeophysicsTableBeforeInsert(DataSet: TDataSet);
    procedure EditSITE_NAMEClick(Sender: TObject);
    procedure DBGridEnter(Sender: TObject);
    procedure DBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TraverseTableLENGTHGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure TraverseTableLENGTHSetText(Sender: TField;
      const aText: String);
    procedure TraverseDataSourceDataChange(Sender: TObject; Field: TField);
    procedure CurrentComboBoxChange(Sender: TObject);
    procedure GraphSpeedButtonClick(Sender: TObject);
    procedure GroupBox1Click(Sender: TObject);
    procedure DBGrid7Enter(Sender: TObject);
    procedure DBGrid7DblClick(Sender: TObject);
    procedure RecSitesTableSITE_ID_NRSetText(Sender: TField;
      const aText: String);
    procedure RecSitesTableAfterPost(DataSet: TDataSet);
    procedure RecSitesTableBeforeInsert(DataSet: TDataSet);
    procedure RecSitesTableNewRecord(DataSet: TDataSet);
    procedure RecSitesTableDIST_ORIGGetText(Sender: TField;
      var aText: String; DisplayText: Boolean);
    procedure RecSitesTableDIST_ORIGSetText(Sender: TField;
      const aText: String);
    procedure RecSitesTableHOR_OFFSETGetText(Sender: TField;
      var aText: String; DisplayText: Boolean);
    procedure RecSitesTableHOR_OFFSETSetText(Sender: TField;
      const aText: String);
    procedure RecSitesTableDATE_PRIORSetText(Sender: TField;
      const aText: String);
    procedure RecSitesTableDATE_PRIORValidate(Sender: TField);
    procedure RecSitesTableCOMMENTSetText(Sender: TField;
      const aText: String);
    procedure DataSource6DataChange(Sender: TObject; Field: TField);
    procedure VLFTableAfterOpen(DataSet: TDataSet);
    procedure DBGridExit(Sender: TObject);
    procedure ProfilePageControlChange(Sender: TObject);
    procedure HelpBitBtnClick(Sender: TObject);
    procedure SiteTableBeforeOpen(DataSet: TDataSet);
    procedure RecSitesTableSITE_ID_NRValidate(Sender: TField);
    procedure DBGrid7ColEnter(Sender: TObject);
    procedure ZQueryGraviAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    BookMark: TBookmark;
    PrevPeg, PrevDate: ShortString;
    PrevSpacing, PrevStation, ColNr: LongWord;
    ValidFound: Boolean;
  public
    { Public declarations }
  end;

var
  ProfilingForm: TProfilingForm;

implementation

{$R *.lfm}

uses VARINIT, Strdatetime, DistanceDepSettings, selectSiteID, MainDataModule;

procedure TProfilingForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, False);
  CurrentComboBox.ItemIndex := 0;
  ValidFound := True;
end;

procedure TProfilingForm.FormActivate(Sender: TObject);
var
  i: Word;
begin
  LengthLabel.Caption := 'Length [' + LengthUnit + ']';
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
  SitingLabel.Width := 320;
  if CurrentComboBox.ItemIndex = 0 then
  begin
    FindTable.Close;
    FindTable.Open;
    if FindTable.Locate('SITE_ID_NR', CurrentSite, []) then
      TraverseTable.Locate('TRAV_NR', FindTableTRAV_NR.AsString, []);
    FindTable.Close;
  end
  else
  begin
    TraverseTable.Locate('TRAV_NR', CurrentTraverse, []);
    case ProfilePageControl.ActivePage.TabIndex of
    0: begin
         if EditNavigator.DataSource = TraverseDataSource then
         Editing := 'Editing: Traverse information'
         else
           Editing := 'Editing: Magnetics information';
         if MagTable.Active then MagTable.Refresh;
       end;
    1: begin
         if EditNavigator.DataSource = TraverseDataSource then
         Editing := 'Editing: Traverse information'
         else
           Editing := 'Editing: EM-34 information';
         if EMTable.Active then EMTable.Refresh;
       end;
    2: begin
         if EditNavigator.DataSource = TraverseDataSource then
         Editing := 'Editing: Traverse information'
         else
           Editing := 'Editing: Genie information';
         if GenieTable.Active then GenieTable.Refresh;
       end;
    3: begin
         if EditNavigator.DataSource = TraverseDataSource then
           Editing := 'Editing: Traverse information'
         else
           Editing := 'Editing: Resistivity information';
         if ResTable.Active then ResTable.Refresh;
       end;
    4: begin
         if EditNavigator.DataSource = TraverseDataSource then
           Editing := 'Editing: Traverse information'
         else
           Editing := 'Editing: VLF information';
         if VLFTable.Active then VLFTable.Refresh;
       end;
    5: begin
         if EditNavigator.DataSource = TraverseDataSource then
           Editing := 'Editing: Traverse information'
         else
           Editing := 'Editing: Gravimetry information';
         if RecSitesTable.Active then RecSitesTable.Refresh;
       end;
    6: begin
         if EditNavigator.DataSource = TraverseDataSource then
           Editing := 'Editing: Traverse information'
         else
           Editing := 'Editing: Recommended sites';
         if RecSitesTable.Active then RecSitesTable.Refresh;
       end;
    end; {of case}
  end;
  CurrentTraverse := TraverseTableTRAV_NR.Value;
  if TraverseTable.Active then TraverseTable.Refresh;
end;

procedure TProfilingForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  TraverseTable.Close;
  MagTable.Close;
  EMTable.Close;
  GenieTable.Close;
  ResTable.Close;
  VLFTable.Close;
  RecSitesTable.Close;
  TraverseTable.FreeBookmark(Bookmark);
  Editing := 'Editing: <none>';
  CloseAction := caFree;
end;

procedure TProfilingForm.FormShow(Sender: TObject);
begin
  try
    TraverseTable.Open;
    with MagTable do
    begin
      FetchRow := EditResults.Tag;
      Open;
    end;
    with EMTable do
    begin
      FetchRow := EditResults.Tag;
      Open;
    end;
    with GenieTable do
    begin
      FetchRow := EditResults.Tag;
      Open;
    end;
    with ResTable do
    begin
      FetchRow := EditResults.Tag;
      Open;
    end;
    with VLFTable do
    begin
      FetchRow := EditResults.Tag;
      Open;
    end;
    //check for Gravimetry table
    with DBMetadata do
    begin
      Connection := DataModuleMain.ZConnectionDB;
      MetaDataType := mdTables;
      TableName := 'grndgrav';
      Open;
    end;
    if DBMetaData.RecordCount > 0 then //there is a gravimetry table
    with ZQueryGravi do
    begin
      FetchRow := EditResults.Tag;
      Open;
    end;
    DBMetaData.Close;
    with RecSitesTable do
    begin
      FetchRow := EditResults.Tag;
      Open;
    end;
  except on E: Exception do
    MessageDlg(E.Message + ' - You may have to contact your database administrator to resolve this error.', mtError, [mbOK], 0);
  end;
  DetailNavigator.DataSource := TDataSource(FindComponent('DataSource' + IntToStr(ProfilePageControl.ActivePageIndex + 1)));
  RecordText.Caption := 'Record ' + IntToStr(DetailNavigator.DataSource.DataSet.RecNo) + ' out of ' + IntToStr(DetailNavigator.DataSource.DataSet.RecordCount);
  EditResults.Tag := StrToInt(EditResults.Text);
end;

procedure TProfilingForm.GenieTableAfterOpen(DataSet: TDataSet);
begin
  DataSource3.AutoEdit := AutoEditData;
end;

procedure TProfilingForm.MagTableAfterOpen(DataSet: TDataSet);
begin
  DataSource1.AutoEdit := AutoEditData;
end;

procedure TProfilingForm.GeophTableCOMMENTSetText(Sender: TField;
  const aText: string);
begin
  if AllowSmallChars then
    Sender.Value := aText
  else
    Sender.Value := UpperCase(aText);
end;

procedure TProfilingForm.PopupMenu1Popup(Sender: TObject);
var
  HasSelection: Boolean;
begin
  if Assigned(BookMark) then GotoBookmark.Enabled := True
  else GotoBookmark.Enabled := False;
  HasSelection := False;
  if ActiveControl is TDBEdit then
    HasSelection := TDBEdit(ActiveControl).SelLength <> 0
  else
  if ActiveControl is TDBGrid then
    HasSelection := False;
  CutMenu.Enabled := HasSelection;
  CopyMenu.Enabled := HasSelection;
  PasteMenu.Enabled := Clipboard.HasFormat(CF_TEXT);
end;

procedure TProfilingForm.GotoBookmarkClick(Sender: TObject);
begin
  TraverseTable.GotoBookmark(Bookmark);
end;

procedure TProfilingForm.ProfilePageControlEnter(Sender: TObject);
begin
  if TDBGrid(FindComponent('DBGrid' + IntToStr(ProfilePageControl.ActivePage.PageIndex + 1))).DataSource.DataSet.Active then
  begin
    TDBGrid(FindComponent('DBGrid' + IntToStr(ProfilePageControl.ActivePage.PageIndex + 1))).SetFocus;
    DetailNavigator.DataSource := TDataSource(FindComponent('DataSource' + IntToStr(ProfilePageControl.ActivePage.PageIndex + 1)));
  end
  else
    MessageDlg('This table does not yet exist in your database! You may have to upgrade your database to the newest version.', mtWarning, [mbOK], 0);
  RecordText.Caption := 'Record ' + IntToStr(DetailNavigator.DataSource.DataSet.RecNo) + ' out of ' + IntToStr(DetailNavigator.DataSource.DataSet.RecordCount);
end;

procedure TProfilingForm.ResTableAfterOpen(DataSet: TDataSet);
begin
  DataSource4.AutoEdit := AutoEditData;
end;

procedure TProfilingForm.SetBookmarkClick(Sender: TObject);
begin
  TraverseTable.FreeBookmark(Bookmark);
  Bookmark := TraverseTable.GetBookmark;
end;

procedure TProfilingForm.CutMenuClick(Sender: TObject);
begin
  if (ActiveControl is TDBEdit) and (TDBEdit(ActiveControl).DataSource.DataSet.State IN [dsEdit, dsInsert]) then
    TDBEdit(ActiveControl).CutToClipboard
  else
  if (ActiveControl is TDBGrid) and (TDBGrid(ActiveControl).DataSource.DataSet.State IN [dsEdit, dsInsert]) then
    TDBGrid(ActiveControl).SelectedField.Value.CutToClipboard;
end;

procedure TProfilingForm.CopyMenuClick(Sender: TObject);
begin
  if ActiveControl is TDBEdit then
    TDBEdit(ActiveControl).CopyToClipboard
  else
  if ActiveControl is TDBGrid then
    TDBGrid(ActiveControl).SelectedField.Value.CopyToClipboard;
end;

procedure TProfilingForm.PasteMenuClick(Sender: TObject);
begin
  if ActiveControl is TDBEdit then
    TDBEdit(ActiveControl).PasteFromClipboard
  else
  if (ActiveControl is TDBGrid) and (TDBGrid(ActiveControl).DataSource.DataSet.State IN [dsEdit, dsInsert]) then
    TDBGrid(ActiveControl).SelectedField.Value.PasteFromClipboard;
end;

procedure TProfilingForm.GeophTableSetText(Sender: TField;
  const aText: String);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TProfilingForm.CloseBitBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TProfilingForm.TraverseTableDATEValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TProfilingForm.TraverseTableNewRecord(DataSet: TDataSet);
begin
  TraverseTableDATE_START.Value := FormatDateTime('YYYYMMDD', Date);
  TraverseTableDATE_END.Value := FormatDateTime('YYYYMMDD', Date);
  TraverseTableSITE_NAME.FocusControl;
end;

procedure TProfilingForm.TraverseTableBeforePost(DataSet: TDataSet);

var NumberStr: String;
    NewNumber: Integer;

begin
  if TraverseTable.State = dsInsert then
  begin
    with DataModuleMain.CheckQuery do
    begin
      Connection := DataModuleMain.ZConnectionDB;
      SQL.Clear;
      SQL.Add('SELECT MAX(TRAV_NR) FROM profilng');
      Open;
      if not Fields[0].IsNull then
      begin
        NumberStr := RightStr(Fields[0].AsString, 4);
        NewNumber := StrToInt(NumberStr) + 1;
        NumberStr := Format('%4.4d', [NewNumber]);
      end
      else NumberStr := '0001';
      Close;
    end;
    TraverseTableTRAV_NR.Value := FormatDateTime('YYYYMMDD', Date) + 'TRAV' + NumberStr;
  end;
end;

procedure TProfilingForm.TableNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('PEG_NR').Value := PrevPeg;
  if DataSet.RecordCount = 0 then DataSet.FieldByName('STATION').Value := 0 else
    DataSet.FieldByName('STATION').Value := PrevStation + SpacingSpinEdit.Value;
  if DataSet.FindField('SPACING') <> NIL then
    DataSet.FieldByName('SPACING').Value := PrevSpacing;
end;

procedure TProfilingForm.GeophysicsTableBeforeInsert(DataSet: TDataSet);
begin
  PrevPeg := Dataset.Fields[1].AsString;
  PrevStation := Dataset.Fields[2].AsInteger;
  if DataSet.FindField('SPACING') <> NIL then
    PrevSpacing := DataSet.FieldByName('SPACING').Value;
end;

procedure TProfilingForm.EditSITE_NAMEClick(Sender: TObject);
begin
  EditNavigator.Enabled := True;
  EditNavigator.DataSource := TraverseDataSource;
  Editing := 'Editing: Traverse information';
end;

procedure TProfilingForm.DBGridEnter(Sender: TObject);
begin
  if TraverseTable.RecordCount > 0 then
  begin
    EditNavigator.DataSource := TDBGrid(Sender).DataSource;
    Editing := 'Editing: profiling information';
  end
  else
  EditNavigator.Enabled := False;
end;

procedure TProfilingForm.DBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  with TDBGrid(Sender) do
  begin
    if (ssCtrl in Shift) then
    begin
      if (Key = VK_F8) then DataSource.Dataset.Edit;
    end
    else
    case Key of
      VK_F5: DataSource.Dataset.Refresh;
      VK_F8: if DataSource.Dataset.State IN [dsEdit, dsInsert] then DataSource.Dataset.Post;
      VK_F9: if (ProfilePageControl.PageIndex = 6) and (SelectedIndex = 5) then
             begin
               with TFormSelSiteID.Create(Application) do
               begin
                 ShowModal;
                 if (ModalResult = mrOK) and (DataSource.Dataset.State IN [dsInsert, dsEdit]) then
                   DataSource.Dataset.FieldByName('SITE_ID_NR').AsString := LookupSite;
                 Close;
               end;
             end;
      VK_TAB: if (SelectedIndex = LastColumn.Index) and (DataSource.Dataset.State IN [dsInsert, dsEdit]) then
                DataSource.Dataset.Post;
    end; {of case}
  end;
end;

procedure TProfilingForm.TraverseTableLENGTHGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  if not TraverseTableLENGTH.IsNull then
  begin
    if TraverseTableLENGTH.Value * LengthFactor > 1000 then
      aText := FloatToStrF(TraverseTableLENGTH.Value * LengthFactor, ffFixed, 15, 0)
    else
    if TraverseTableLENGTH.Value * LengthFactor < 0.01 then
      aText := FloatToStrF(TraverseTableLENGTH.Value * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(TraverseTableLENGTH.Value * LengthFactor, ffFixed, 15, 2);
  end;
end;

procedure TProfilingForm.TraverseTableLENGTHSetText(Sender: TField;
  const aText: String);
begin
  TraverseTableLENGTH.Value := StrToFloat(aText)/LengthFactor;
end;

procedure TProfilingForm.TraverseDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  CurrentTraverse := TraverseTableTRAV_NR.Value;
end;

procedure TProfilingForm.CurrentComboBoxChange(Sender: TObject);
begin
  if CurrentComboBox.ItemIndex = 0 then
  begin
    FindTable.Close;
    FindTable.Open;
    if FindTable.Locate('SITE_ID_NR', CurrentSite, []) then
      TraverseTable.Locate('TRAV_NR', FindTableTRAV_NR.AsString, []);
    FindTable.Close;
  end
  else
  begin
    TraverseTable.Locate('TRAV_NR', CurrentTraverse, []);
    case ProfilePageControl.ActivePage.TabIndex of
    0: begin
         if EditNavigator.DataSource = TraverseDataSource then
         Editing := 'Editing: Traverse information'
         else
           Editing := 'Editing: Magnetics information';
         if MagTable.Active then MagTable.Refresh;
       end;
    1: begin
         if EditNavigator.DataSource = TraverseDataSource then
         Editing := 'Editing: Traverse information'
         else
           Editing := 'Editing: EM-34 information';
         if EMTable.Active then EMTable.Refresh;
       end;
    2: begin
         if EditNavigator.DataSource = TraverseDataSource then
         Editing := 'Editing: Traverse information'
         else
           Editing := 'Editing: Genie information';
         if GenieTable.Active then GenieTable.Refresh;
       end;
    3: begin
         if EditNavigator.DataSource = TraverseDataSource then
           Editing := 'Editing: Traverse information'
         else
           Editing := 'Editing: Resistivity information';
         if ResTable.Active then ResTable.Refresh;
       end;
    4: begin
         if EditNavigator.DataSource = TraverseDataSource then
           Editing := 'Editing: Traverse information'
         else
           Editing := 'Editing: VLF information';
         if VLFTable.Active then VLFTable.Refresh;
       end;
    5: begin
         if EditNavigator.DataSource = TraverseDataSource then
           Editing := 'Editing: Traverse information'
         else
           Editing := 'Editing: Gravimetry information';
         if RecSitesTable.Active then RecSitesTable.Refresh;
       end;
    6: begin
         if EditNavigator.DataSource = TraverseDataSource then
           Editing := 'Editing: Traverse information'
         else
           Editing := 'Editing: Recommended sites';
         if RecSitesTable.Active then RecSitesTable.Refresh;
       end;
    end; {of case}
  end;
  CurrentTraverse := TraverseTableTRAV_NR.Value;
end;

procedure TProfilingForm.GraphSpeedButtonClick(Sender: TObject);
begin
  with TDistanceDepSettingsForm.Create(Application) do
  begin
    MethIndex := ProfilePageControl.ActivePage.TabIndex;
    TravNr := TraverseTableTRAV_NR.Value;
    Caption := ProfilePageControl.ActivePage.Caption + ' chart settings';
    ShowModal;
  end;
end;

procedure TProfilingForm.GroupBox1Click(Sender: TObject);
begin
  EditNavigator.Enabled := True;
  EditNavigator.DataSource := TraverseDataSource;
  Editing := 'Editing: Traverse information';
  EditSITE_NAME.SetFocus;
end;

procedure TProfilingForm.DBGrid7Enter(Sender: TObject);
begin
  if TraverseTable.RecordCount > 0 then
  begin
    EditNavigator.DataSource := DataSource6;
    Editing := 'Editing: Recommended sites';
  end
  else
  EditNavigator.Enabled := False;
end;

procedure TProfilingForm.DBGrid7DblClick(Sender: TObject);
begin
  case DBGrid7.SelectedIndex of
    5: begin
         with TFormSelSiteID.Create(Application) do
         begin
           LookupSite := RecSitesTableSITE_ID_NR.AsString;
           ShowModal;
           if ModalResult = mrOK then
             if RecSitesTable.State IN [dsInsert, dsEdit] then
               RecSitesTableSITE_ID_NR.AsString := LookupSite;
           Close;
         end;
       end;
  else exit;
  end; {of CASE}
end;

procedure TProfilingForm.RecSitesTableSITE_ID_NRSetText(Sender: TField;
  const aText: String);
begin
  RecSitesTableSITE_ID_NR.Value := UpperCase(aText);
end;

procedure TProfilingForm.RecSitesTableAfterPost(DataSet: TDataSet);
begin
  TraverseTable.Edit;
  TraverseTable.Post;
end;

procedure TProfilingForm.RecSitesTableBeforeInsert(DataSet: TDataSet);
begin
  PrevDate := RecSitesTableDATE_PRIOR.Value;
end;

procedure TProfilingForm.RecSitesTableNewRecord(DataSet: TDataSet);
begin
  RecSitesTableDIST_ORIG.Value := 0.00;
  RecSitesTableHOR_OFFSET.Value := 0.00;
  RecSitesTablePRIORITY.Value := 1;
  if PrevDate = '' then
    RecSitesTableDATE_PRIOR.Value := FormatDateTime('YYYYMMDD', Date)
  else
    RecSitesTableDATE_PRIOR.Value := PrevDate;
  RecSitesTableSITE_ID_NR.Value := CurrentSite;
end;

procedure TProfilingForm.RecSitesTableDIST_ORIGGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  if RecSitesTableDIST_ORIG.Value * LengthFactor > 10000 then
    aText := FloatToStrF(RecSitesTableDIST_ORIG.Value * LengthFactor, ffFixed, 15, 0)
  else
  if RecSitesTableDIST_ORIG.Value * LengthFactor < -10000 then
    aText := FloatToStrF(RecSitesTableDIST_ORIG.Value * LengthFactor, ffFixed, 15, 0)
  else
    aText := FloatToStrF(RecSitesTableDIST_ORIG.Value * LengthFactor, ffFixed, 15, 2);
end;

procedure TProfilingForm.RecSitesTableDIST_ORIGSetText(Sender: TField;
  const aText: String);
begin
  if aText <> '' then
    RecSitesTableDIST_ORIG.Value := StrToFloat(aText)/LengthFactor;
end;

procedure TProfilingForm.RecSitesTableHOR_OFFSETGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  if RecSitesTableHOR_OFFSET.Value * LengthFactor > 100 then
    aText := FloatToStrF(RecSitesTableHOR_OFFSET.Value * LengthFactor, ffFixed, 15, 0)
  else
  if RecSitesTableHOR_OFFSET.Value * LengthFactor < -100 then
    aText := FloatToStrF(RecSitesTableHOR_OFFSET.Value * LengthFactor, ffFixed, 15, 5)
  else
    aText := FloatToStrF(RecSitesTableHOR_OFFSET.Value * LengthFactor, ffFixed, 15, 2);
end;

procedure TProfilingForm.RecSitesTableHOR_OFFSETSetText(Sender: TField;
  const aText: String);
begin
  if aText <> '' then
    RecSitesTableHOR_OFFSET.Value := StrToFloat(aText)/LengthFactor;
end;

procedure TProfilingForm.RecSitesTableDATE_PRIORSetText(Sender: TField;
  const aText: String);
begin
  RecSitesTableDATE_PRIOR.Value := aText;
  ColNr := DBGrid7.SelectedIndex;
end;

procedure TProfilingForm.RecSitesTableDATE_PRIORValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
  if not ValidFound then
    MessageDlg('Invalid date entered!', mtError, [mbOK], 0);
end;

procedure TProfilingForm.RecSitesTableCOMMENTSetText(Sender: TField;
  const aText: String);
begin
  if AllowSmallChars then
    Sender.Value := aText
  else
    Sender.Value := UpperCase(aText);
end;

procedure TProfilingForm.DataSource6DataChange(Sender: TObject;
  Field: TField);
begin
  if RecSitesTableSITE_ID_NR.Value <> '' then
    CurrentSite := RecSitesTableSITE_ID_NR.Value;
  if RecSitesTableTRAV_NR.Value <> '' then
    CurrentTraverse := RecSitesTableTRAV_NR.Value;
  if RecSitesTable.Active then
    RecordText.Caption := 'Record ' + IntToStr(RecSitesTable.RecNo) + ' out of ' + IntToStr(RecSitesTable.RecordCount);
end;

procedure TProfilingForm.VLFTableAfterOpen(DataSet: TDataSet);
begin
  DataSource5.AutoEdit := AutoEditData;
end;

procedure TProfilingForm.DBGridExit(Sender: TObject);
begin
  with TDBGrid(Sender).DataSource.DataSet do
  if State IN [dsInsert, dsEdit] then
  begin
    if MessageDlg('Changes to current record have not been posted and will be lost! Post record now?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then Post
    else Cancel;
  end;
end;

procedure TProfilingForm.ProfilePageControlChange(Sender: TObject);
begin
  GraphSpeedButton.Enabled := ProfilePageControl.ActivePageIndex < ProfilePageControl.PageCount;
  if ProfilePageControl.ActivePageIndex < ProfilePageControl.PageCount then
    GraphSpeedButton.Hint := 'QuickGraph ' + ProfilePageControl.ActivePage.Caption
  else GraphSpeedButton.Hint := '';
  if TDBGrid(FindComponent('DBGrid' + IntToStr(ProfilePageControl.ActivePage.PageIndex + 1))).DataSource.DataSet.Active then
  begin
    TDBGrid(FindComponent('DBGrid' + IntToStr(ProfilePageControl.ActivePage.PageIndex + 1))).SetFocus;
    DetailNavigator.DataSource := TDataSource(FindComponent('DataSource' + IntToStr(ProfilePageControl.ActivePage.PageIndex + 1)));
  end
  else
    MessageDlg('This table does not yet exist in your database! You may have to upgrade your database to the newest version.', mtWarning, [mbOK], 0);
  RecordText.Caption := 'Record ' + IntToStr(DetailNavigator.DataSource.DataSet.RecNo) + ' out of ' + IntToStr(DetailNavigator.DataSource.DataSet.RecordCount);
end;

procedure TProfilingForm.HelpBitBtnClick(Sender: TObject);
begin
   Application.HelpKeyword('EnterEditData');
end;

procedure TProfilingForm.SiteTableBeforeOpen(DataSet: TDataSet);
begin
  SiteTable.Connection := DataModuleMain.ZConnectionDB;
end;

procedure TProfilingForm.RecSitesTableSITE_ID_NRValidate(Sender: TField);
begin
  if Sender.AsString <> '' then
  begin
    SiteTable.Open;
    if SiteTable.Locate('SITE_ID_NR', Sender.AsString, []) then
      ValidFound := True
    else
    begin
      ValidFound := False;
      MessageDlg('Invalid site identifier entered!', mtError, [mbOK], 0);
    end;
    SiteTable.Close;
  end;
end;

procedure TProfilingForm.DBGrid7ColEnter(Sender: TObject);
begin
  if not ValidFound then
  begin
    DBGrid7.SelectedIndex := ColNr;
  end;
end;

procedure TProfilingForm.ZQueryGraviAfterOpen(DataSet: TDataSet);
begin
  DataSource6.AutoEdit := AutoEditData;
end;

procedure TProfilingForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ssCtrl in Shift then
  case Key of
    78: TraverseTable.Next;
    80: TraverseTable.Prior;
    VK_F8: TraverseTable.Edit;
  end {of case}
  else
  if not (ActiveControl is TDBGrid) then
  case Key of
    VK_F5: TraverseTable.Refresh;
    VK_F8: if TraverseTable.State IN [dsInsert, dsEdit] then
             TraverseTable.Post;
    VK_ESCAPE: if TraverseTable.State IN [dsInsert, dsEdit] then
          TraverseTable.Cancel;
  end; {of case}
end;

procedure TProfilingForm.EMTableAfterOpen(DataSet: TDataSet);
begin
  DataSource2.AutoEdit := AutoEditData;
end;

procedure TProfilingForm.DetailNavigatorClick(Sender: TObject; Button: TDBNavButtonType);
begin
  TDBGrid(FindComponent('DBGrid' + IntToStr(ProfilePageControl.ActivePageIndex + 1))).SetFocus;
  try
    case Button of
      nbNext: (Sender as TDBNavigator).DataSource.DataSet.MoveBy(EditResults.Tag - 1); //it moves 1 anyway
      nbPrior: begin
                 if (Sender as TDBNavigator).DataSource.DataSet.RecNo <= EditResults.Tag + 1 then
                   (Sender as TDBNavigator).DataSource.DataSet.First
                 else
                   (Sender as TDBNavigator).DataSource.DataSet.RecNo := (Sender as TDBNavigator).DataSource.DataSet.RecNo - EditResults.Tag + 1; //it moves 1 anyway
               end;
    end; //of case
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TProfilingForm.DetailNavigatorBeforeAction(Sender: TObject;
  Button: TDBNavButtonType);
begin
  case Button of
    nbNext, nbPrior, nbFirst, nbLast: Screen.Cursor := crSQLWait;
  end; //of case
end;

procedure TProfilingForm.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  with Sender as TDataSource do
    if DataSet.Active then RecordText.Caption := 'Record ' + IntToStr(DataSet.RecNo) + ' out of ' + IntToStr(DataSet.RecordCount);
end;

procedure TProfilingForm.DBGrid7GetCellHint(Sender: TObject; Column: TColumn;
  var AText: String);
begin
  if Column.FieldName = 'SITE_ID_NR' then
    AText := 'Dbl-click or F9 to select Site Identifier';
end;

procedure TProfilingForm.EditResultsEditingDone(Sender: TObject);
begin
  EditResults.Tag := StrToInt(EditResults.Text);
  MagTable.FetchRow := EditResults.Tag;
  EMTable.FetchRow := EditResults.Tag;
  GenieTable.FetchRow := EditResults.Tag;
  ResTable.FetchRow := EditResults.Tag;
  VLFTable.FetchRow := EditResults.Tag;
  DetailNavigator.DataSource.DataSet.Refresh;
end;

end.
