{ Copyright (C) 2019 Immo Blecher immo@blecher.co.za

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
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLType,
  StdCtrls, DBCtrls, ExtCtrls, Buttons, DBGrids, ComCtrls, ZDataset,
  Spin, Db, Menus, Clipbrd, XMLPropStorage;

type

  { TProfilingForm }

  TProfilingForm = class(TForm)
    Panel1: TPanel;
    CloseBitBtn: TBitBtn;
    HelpBitBtn: TBitBtn;
    EditNavigator: TDBNavigator;
    TraverseNavigator: TDBNavigator;
    Panel3: TPanel;
    SitingLabel: TLabel;
    SpacingSpinEdit: TSpinEdit;
    Label1: TLabel;
    CurrentComboBox: TComboBox;
    TraverseTable: TZTable;
    TraverseDataSource: TDataSource;
    MagTable: TZTable;
    EMTable: TZTable;
    GenieTable: TZTable;
    ResTable: TZTable;
    MagDataSource: TDataSource;
    EMDataSource: TDataSource;
    GenieDataSource: TDataSource;
    ResDataSource: TDataSource;
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
    ProfilePageControl: TPageControl;
    Magnetics: TTabSheet;
    MagDBGrid: TDBGrid;
    EM34: TTabSheet;
    EMDBGrid: TDBGrid;
    Genie: TTabSheet;
    GenieDBGrid: TDBGrid;
    Resistivity: TTabSheet;
    ResDBGrid: TDBGrid;
    GraphSpeedButton: TSpeedButton;
    GroupBox1: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    EditTRAV_NR: TDBEdit;
    EditSITE_NAME: TDBEdit;
    EditSITING_LEAD: TDBEdit;
    XMLPropStorage: TXMLPropStorage;
    X_CoordLabel: TLabel;
    Y_CoordLabel: TLabel;
    LongitudeLabel: TLabel;
    LengthLabel: TLabel;
    CollarLabel: TLabel;
    DepthLabel: TLabel;
    Label2: TLabel;
    Label26: TLabel;
    EditX_Coord: TDBEdit;
    EditY_Coord: TDBEdit;
    EditDIRECTION: TDBEdit;
    EditLENGTH: TDBEdit;
    EditDATE_START: TDBEdit;
    EditDATE_END: TDBEdit;
    EditDATE_ENTRY: TDBEdit;
    EditDATE_UPDTD: TDBEdit;
    TabSheetRecSites: TTabSheet;
    RecDBGrid: TDBGrid;
    RecSitesTable: TZTable;
    RecSitesTableTRAV_NR: TStringField;
    RecSitesTableDIST_ORIG: TFloatField;
    RecSitesTableHOR_OFFSET: TFloatField;
    RecSitesTablePRIORITY: TSmallintField;
    RecSitesTableDATE_PRIOR: TStringField;
    RecSitesTableSITE_ID_NR: TStringField;
    RecSitesTableCOMMENT: TStringField;
    RecSitesDataSource: TDataSource;
    TabSheet1: TTabSheet;
    VLFDBGrid: TDBGrid;
    VLFTable: TZTable;
    VLFDataSource: TDataSource;
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
    procedure EMTableAfterOpen(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure GenieTableAfterOpen(DataSet: TDataSet);
    procedure MagTableAfterOpen(DataSet: TDataSet);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure GotoBookmarkClick(Sender: TObject);
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
    procedure MagTableNewRecord(DataSet: TDataSet);
    procedure EMTableNewRecord(DataSet: TDataSet);
    procedure GeophysicsTableBeforeInsert(DataSet: TDataSet);
    procedure EMTableBeforeInsert(DataSet: TDataSet);
    procedure GenieTableNewRecord(DataSet: TDataSet);
    procedure GenieTableBeforeInsert(DataSet: TDataSet);
    procedure ResTableNewRecord(DataSet: TDataSet);
    procedure EditSITE_NAMEClick(Sender: TObject);
    procedure MagDBGridEnter(Sender: TObject);
    procedure EMDBGridEnter(Sender: TObject);
    procedure GenieDBGridEnter(Sender: TObject);
    procedure ResDBGridEnter(Sender: TObject);
    procedure MagDBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EMDBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GenieDBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ResDBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TraverseTableLENGTHGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure TraverseTableLENGTHSetText(Sender: TField;
      const aText: String);
    procedure TraverseDataSourceDataChange(Sender: TObject; Field: TField);
    procedure CurrentComboBoxChange(Sender: TObject);
    procedure GraphSpeedButtonClick(Sender: TObject);
    procedure GroupBox1Click(Sender: TObject);
    procedure RecDBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RecDBGridEnter(Sender: TObject);
    procedure RecDBGridDblClick(Sender: TObject);
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
    procedure RecSitesDataSourceDataChange(Sender: TObject; Field: TField);
    procedure VLFDBGridEnter(Sender: TObject);
    procedure VLFDBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure VLFTableAfterOpen(DataSet: TDataSet);
    procedure VLFTableNewRecord(DataSet: TDataSet);
    procedure MagDBGridExit(Sender: TObject);
    procedure ProfilePageControlChange(Sender: TObject);
    procedure HelpBitBtnClick(Sender: TObject);
    procedure SiteTableBeforeOpen(DataSet: TDataSet);
    procedure RecSitesTableSITE_ID_NRValidate(Sender: TField);
    procedure RecDBGridColEnter(Sender: TObject);
  private
    { Private declarations }
    BookMark: TBookmark;
    PrevPeg, PrevDate: ShortString;
    PrevSpacing, PrevStation, ColNr: Integer;
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
  XMLPropStorage.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, False);
  TraverseTable.Open;
  MagTable.Open;
  EMTable.Open;
  GenieTable.Open;
  ResTable.Open;
  VLFTable.Open;
  RecSitesTable.Open;
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

procedure TProfilingForm.GenieTableAfterOpen(DataSet: TDataSet);
begin
  GenieDataSource.AutoEdit := AutoEditData;
end;

procedure TProfilingForm.MagTableAfterOpen(DataSet: TDataSet);
begin
  MagDataSource.AutoEdit := AutoEditData;
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

procedure TProfilingForm.ResTableAfterOpen(DataSet: TDataSet);
begin
  ResDataSource.AutoEdit := AutoEditData;
end;

procedure TProfilingForm.SetBookmarkClick(Sender: TObject);
begin
  TraverseTable.FreeBookmark(Bookmark);
  Bookmark := TraverseTable.GetBookmark;
end;

procedure TProfilingForm.CutMenuClick(Sender: TObject);
begin
  if ActiveControl is TDBEdit then
    TDBEdit(ActiveControl).CutToClipboard
  else
  if ActiveControl is TDBGrid then
    {TDBGrid(ActiveControl).CutToClipboard;}
end;

procedure TProfilingForm.CopyMenuClick(Sender: TObject);
begin
  if ActiveControl is TDBEdit then
    TDBEdit(ActiveControl).CopyToClipboard
  else
  if ActiveControl is TDBGrid then
    {TDBGrid(ActiveControl).CopyToClipboard;}
end;

procedure TProfilingForm.PasteMenuClick(Sender: TObject);
begin
  if ActiveControl is TDBEdit then
    TDBEdit(ActiveControl).PasteFromClipboard
  else
  if ActiveControl is TDBGrid then
    {TDBGrid(ActiveControl).PasteFromClipboard;}
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
        NumberStr := Copy(Fields[0].AsString, 13, 4);
        NewNumber := StrToInt(NumberStr) + 1;
        NumberStr := Format('%4.4d', [NewNumber]);
      end
      else NumberStr := '0001';
      Close;
    end;
    TraverseTableTRAV_NR.Value := FormatDateTime('YYYYMMDD', Date) + 'TRAV' + NumberStr;
  end;
end;

procedure TProfilingForm.MagTableNewRecord(DataSet: TDataSet);
begin
  MagTablePEG_NR.Value := PrevPeg;
  if MagTable.RecordCount = 0 then MagTableSTATION.Value := 0 else
    MagTableSTATION.Value := PrevStation + SpacingSpinEdit.Value;
end;

procedure TProfilingForm.EMTableNewRecord(DataSet: TDataSet);
begin
  EMTablePEG_NR.Value := PrevPeg;
  if EMTable.RecordCount = 0 then EMTableSTATION.Value := 0 else
    EMTableSTATION.Value := PrevStation + SpacingSpinEdit.Value;
  EMTableSPACING.Value := PrevSpacing;
end;

procedure TProfilingForm.GeophysicsTableBeforeInsert(DataSet: TDataSet);
begin
  PrevPeg := Dataset.Fields[1].AsString;
  PrevStation := Dataset.Fields[2].AsInteger;
end;

procedure TProfilingForm.EMTableBeforeInsert(DataSet: TDataSet);
begin
  PrevPeg := Dataset.Fields[1].AsString;
  PrevStation := Dataset.Fields[2].AsInteger;
  PrevSpacing := EMTableSPACING.AsInteger;
end;

procedure TProfilingForm.GenieTableNewRecord(DataSet: TDataSet);
begin
  GenieTablePEG_NR.Value := PrevPeg;
  if GenieTable.RecordCount = 0 then GenieTableSTATION.Value := 0 else
    GenieTableSTATION.Value := PrevStation + SpacingSpinEdit.Value;
  GenieTableSPACING.Value := PrevSpacing;
end;

procedure TProfilingForm.GenieTableBeforeInsert(DataSet: TDataSet);
begin
  PrevPeg := Dataset.Fields[1].AsString;
  PrevStation := Dataset.Fields[2].AsInteger;
  PrevSpacing := GenieTableSPACING.AsInteger;
end;

procedure TProfilingForm.ResTableNewRecord(DataSet: TDataSet);
begin
  ResTablePEG_NR.Value := PrevPeg;
  if ResTable.RecordCount = 0 then ResTableSTATION.Value := 0 else
    ResTableSTATION.Value := PrevStation + SpacingSpinEdit.Value;
end;

procedure TProfilingForm.EditSITE_NAMEClick(Sender: TObject);
begin
  EditNavigator.Enabled := True;
  EditNavigator.DataSource := TraverseDataSource;
  Editing := 'Editing: Traverse information';
end;

procedure TProfilingForm.MagDBGridEnter(Sender: TObject);
begin
  if TraverseTable.RecordCount > 0 then
  begin
    EditNavigator.DataSource := MagDataSource;
    Editing := 'Editing: Magnetics information';
  end
  else
  EditNavigator.Enabled := False;
end;

procedure TProfilingForm.EMDBGridEnter(Sender: TObject);
begin
  if TraverseTable.RecordCount > 0 then
  begin
    EditNavigator.DataSource := EMDataSource;
    Editing := 'Editing: EM-34 information';
  end
  else
  EditNavigator.Enabled := False;
end;

procedure TProfilingForm.GenieDBGridEnter(Sender: TObject);
begin
  if TraverseTable.RecordCount > 0 then
  begin
    EditNavigator.DataSource := GenieDataSource;
    Editing := 'Editing: Genie information';
  end
  else
  EditNavigator.Enabled := False;
end;

procedure TProfilingForm.ResDBGridEnter(Sender: TObject);
begin
  if TraverseTable.RecordCount > 0 then
  begin
    EditNavigator.DataSource := ResDataSource;
    Editing := 'Editing: Resistivity information';
  end
  else
  EditNavigator.Enabled := False;
end;

procedure TProfilingForm.MagDBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssAlt in Shift) then
  begin
    if (Key = VK_F8) then MagTable.Edit;
  end
  else
  case Key of
    VK_F5: MagTable.Refresh;
    VK_F8: MagTable.Post;
  end; {of case}
end;

procedure TProfilingForm.EMDBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssAlt in Shift) then
  begin
    if (Key = VK_F8) then EMTable.Edit;
  end
  else
  case Key of
    VK_F5: EMTable.Refresh;
    VK_F8: EMTable.Post;
  end; {of case}
end;

procedure TProfilingForm.GenieDBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssAlt in Shift) then
  begin
    if (Key = VK_F8) then GenieTable.Edit;
  end
  else
  case Key of
    VK_F5: GenieTable.Refresh;
    VK_F8: GenieTable.Post;
  end; {of case}
end;

procedure TProfilingForm.ResDBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssAlt in Shift) then
  begin
    if (Key = VK_F8) then ResTable.Edit;
  end
  else
  case Key of
    VK_F5: ResTable.Refresh;
    VK_F8: ResTable.Post;
  end; {of case}
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
           Editing := 'Editing: Recommended sites';
         if RecSitesTable.Active then RecSitesTable.Refresh;
       end;
    end; {of case}
  end;
  CurrentTraverse := TraverseTableTRAV_NR.Value;
end;

procedure TProfilingForm.GraphSpeedButtonClick(Sender: TObject);

var  SpecDistanceDepSettingsForm : TDistanceDepSettingsForm ;

begin
  SpecDistanceDepSettingsForm := TDistanceDepSettingsForm.Create(Application) ;
  with SpecDistanceDepSettingsForm do
  begin
    MethIndex := ProfilePageControl.ActivePage.TabIndex;
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

procedure TProfilingForm.RecDBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssAlt in Shift) then
  begin
    if (Key = VK_F8) then RecSitesTable.Edit;
  end
  else
  case Key of
    VK_F5: RecSitesTable.Refresh;
    VK_F8: RecSitesTable.Post;
  end; {of case}
end;

procedure TProfilingForm.RecDBGridEnter(Sender: TObject);
begin
  if TraverseTable.RecordCount > 0 then
  begin
    EditNavigator.DataSource := RecSitesDataSource;
    Editing := 'Editing: Recommended sites';
  end
  else
  EditNavigator.Enabled := False;
end;

procedure TProfilingForm.RecDBGridDblClick(Sender: TObject);
begin
  case RecDBGrid.SelectedIndex of
    4: begin
      with TFormSelSiteID.Create(Application) do
      begin
        ShowModal;
        if ModalResult = mrOK then
        if RecSitesTable.State IN [dsInsert, dsEdit] then
          RecSitesTable.FieldByName(RecDBGrid.SelectedField.FieldName).AsString := SiteIDQuerySITE_ID_NR.Value;
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
  ColNr := RecDBGrid.SelectedIndex;
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
  RecSitesTableCOMMENT.Value := UpperCase(aText);
end;

procedure TProfilingForm.RecSitesDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  if RecSitesTableSITE_ID_NR.Value <> '' then
    CurrentSite := RecSitesTableSITE_ID_NR.Value;
  if RecSitesTableTRAV_NR.Value <> '' then
    CurrentTraverse := RecSitesTableTRAV_NR.Value;
end;

procedure TProfilingForm.VLFDBGridEnter(Sender: TObject);
begin
  if TraverseTable.RecordCount > 0 then
  begin
    EditNavigator.DataSource := VLFDataSource;
    Editing := 'Editing: VLF information';
  end
  else
  EditNavigator.Enabled := False;
end;

procedure TProfilingForm.VLFDBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssAlt in Shift) then
  begin
    if (Key = VK_F8) then VLFTable.Edit;
  end
  else
  case Key of
    VK_F5: VLFTable.Refresh;
    VK_F8: VLFTable.Post;
  end; {of case}
end;

procedure TProfilingForm.VLFTableAfterOpen(DataSet: TDataSet);
begin
  VLFDataSource.AutoEdit := AutoEditData;
end;

procedure TProfilingForm.VLFTableNewRecord(DataSet: TDataSet);
begin
  VLFTablePEG_NR.Value := PrevPeg;
  if VLFTable.RecordCount = 0 then VLFTableSTATION.Value := 0 else
    VLFTableSTATION.Value := PrevStation + SpacingSpinEdit.Value;
end;

procedure TProfilingForm.MagDBGridExit(Sender: TObject);
begin
  if MagTable.State IN [dsInsert, dsEdit] then
  begin
    if MessageDlg('Changes to current record have not been posted and will be lost! Post record now?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then MagTable.Post
    else MagTable.Cancel;
  end;
end;

procedure TProfilingForm.ProfilePageControlChange(Sender: TObject);
begin
  GraphSpeedButton.Enabled := ProfilePageControl.ActivePage.TabIndex < 5;
  if ProfilePageControl.ActivePage.TabIndex < 5 then
    GraphSpeedButton.Hint := 'QuickGraph ' + ProfilePageControl.ActivePage.Caption
  else GraphSpeedButton.Hint := '';
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

procedure TProfilingForm.RecDBGridColEnter(Sender: TObject);
begin
  if not ValidFound then
  begin
    RecDBGrid.SelectedIndex := ColNr;
  end;
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
  EMDataSource.AutoEdit := AutoEditData;
end;

end.
