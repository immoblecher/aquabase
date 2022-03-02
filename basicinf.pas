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
unit basicinf;

{$mode objfpc}{$H+}

interface
                                                
uses
  SysUtils, Classes, Graphics, Controls, StdCtrls, Forms, DBCtrls, DB, ExtCtrls,
  Buttons, DBGrids, LCLType, Dialogs, Menus, Clipbrd, ComCtrls, XMLPropStorage,
  ZDataset, rxlookup, Variants;

type

  { TBasicinfForm }

  TBasicinfForm = class(TForm)
    DataSourceMap: TDataSource;
    DataSourceDrain: TDataSource;
    DBEditX: TDBEdit;
    DBEditY: TDBEdit;
    DBNavigatorView: TDBNavigator;
    DBLookupComboCMeth1: TDBLookupComboBox;
    DBTextMember: TDBText;
    DBTextMapRef: TDBText;
    EditDATE_COMPL: TDBEdit;
    Label10: TLabel;
    Label18: TLabel;
    CMethDataSource: TDataSource;
    LabelMapRef: TLabel;
    LabelCompleted: TLabel;
    MemberQueryDATE_TO: TStringField;
    MemberQueryMEMBER_ID: TStringField;
    MemberQuerySITE_ID_NR: TStringField;
    MenuItem1: TMenuItem;
    MenuItemGotoBookmark2: TMenuItem;
    MenuItemGotoBookmark1: TMenuItem;
    MenuItemBookMark2: TMenuItem;
    MenuItemBookmark1: TMenuItem;
    MenuItemSetBookmarks: TMenuItem;
    MenuItemCopy: TMenuItem;
    RxDBLookupComboSurvMeth: TRxDBLookupCombo;
    RxDBLookupComboRegn: TRxDBLookupCombo;
    RxDBLookupComboCoordMeth: TRxDBLookupCombo;
    RxDBLookupComboAcc: TRxDBLookupCombo;
    RxDBLookupComboTopoSet: TRxDBLookupCombo;
    RxDBLookupComboDrain: TRxDBLookupCombo;
    RxDBLookupComboRep: TRxDBLookupCombo;
    RxDBLookupComboInfo: TRxDBLookupCombo;
    RxDBLookupComboSelec: TRxDBLookupCombo;
    RxDBLookupComboType: TRxDBLookupCombo;
    RxDBLookupComboEquip: TRxDBLookupCombo;
    RxDBLookupComboTopoSet5: TRxDBLookupCombo;
    Panel1: TPanel;
    BasicinfDataSource: TDataSource;
    CloseBitBtn: TBitBtn;
    BitBtnHelp: TBitBtn;
    DBNavigatorBasicinf: TDBNavigator;
    PopupMenu1: TPopupMenu;
    RxDBLookupComboStatus: TRxDBLookupCombo;
    RxDBLookupComboPurps: TRxDBLookupCombo;
    RxDBLookupComboConsum: TRxDBLookupCombo;
    RxDBLookupComboApplic: TRxDBLookupCombo;
    GotoBookmark: TMenuItem;
    AccuDataSource: TDataSource;
    MethDataSource: TDataSource;
    TopoDataSource: TDataSource;
    SlctDataSource: TDataSource;
    EqpmDataSource: TDataSource;
    PotbDataSource: TDataSource;
    TypeDataSource: TDataSource;
    StatDataSource: TDataSource;
    PurpDataSource: TDataSource;
    ConsDataSource: TDataSource;
    ApplDataSource: TDataSource;
    InfsDataSource: TDataSource;
    MemberDataSource: TDataSource;
    RegionDataSource: TDataSource;
    RepInstDataSource: TDataSource;
    ImageButton: TSpeedButton;
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    XMLPropStorage: TXMLPropStorage;
    X_CoordLabel: TLabel;
    Y_CoordLabel: TLabel;
    Label12: TLabel;
    AltLabel: TLabel;
    Label15: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    EditSITE_ID_NR: TDBEdit;
    EditNR_ON_MAP: TDBEdit;
    EditREGION_BB: TDBEdit;
    EditALT_NO_: TDBEdit;
    EditALT_NO_2: TDBEdit;
    EditFARM_NR: TDBEdit;
    EditSITE_NAME: TDBEdit;
    EditALTITUDE: TDBEdit;
    DBEditRegnDescr: TDBEdit;
    FilterLabel: TLabel;
    DBSiteGrid: TDBGrid;
    GroupBox2: TGroupBox;
    Label8: TLabel;
    Label13: TLabel;
    Label17: TLabel;
    Label16: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    GroupBox3: TGroupBox;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    BHGroupBox: TGroupBox;
    DiamLabel: TLabel;
    ColLabel: TLabel;
    DepLabel: TLabel;
    EditBH_DIAM: TDBEdit;
    EditCOLLAR_HI: TDBEdit;
    EditDEPTH: TDBEdit;
    GroupBox5: TGroupBox;
    Label27: TLabel;
    Label22: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    RecCountLabel: TLabel;
    Label32: TLabel;
    Label9: TLabel;
    EditDATE_ENTRY: TDBEdit;
    EditDATE_UPDTD: TDBEdit;
    EditNOTES_YN: TDBEdit;
    NRQuery: TZReadOnlyQuery;
    MemberQuery: TZReadOnlyQuery;
    ZReadOnlyQueryMapRef: TZReadOnlyQuery;
    ZReadOnlyQueryApplic: TZReadOnlyQuery;
    ZReadOnlyQueryMapRefsheet50: TStringField;
    ZReadOnlyQueryRep: TZReadOnlyQuery;
    ZReadOnlyQueryCoordAcc: TZReadOnlyQuery;
    ZReadOnlyQueryCoordAccDESCRIBE: TStringField;
    ZReadOnlyQueryCoordAccSEARCH: TStringField;
    ZReadOnlyQueryCoordMeth: TZReadOnlyQuery;
    ZReadOnlyQueryPotabl: TZReadOnlyQuery;
    ZReadOnlyQueryCons: TZReadOnlyQuery;
    ZReadOnlyQueryInfo: TZReadOnlyQuery;
    ZReadOnlyQuerySiteType: TZReadOnlyQuery;
    ZReadOnlyQueryEquip: TZReadOnlyQuery;
    ZReadOnlyQueryPurps: TZReadOnlyQuery;
    ZReadOnlyQuerySurvMeth: TZReadOnlyQuery;
    ZReadOnlyQueryCoordMethDESCRIBE: TStringField;
    ZReadOnlyQueryCoordMethDESCRIBE1: TStringField;
    ZReadOnlyQueryCoordMethSEARCH: TStringField;
    ZReadOnlyQueryCoordMethSEARCH1: TStringField;
    ZReadOnlyQueryRegnDESCRIBE: TStringField;
    ZReadOnlyQueryRegnSEARCH: TStringField;
    ZReadOnlyQueryTopoSet: TZReadOnlyQuery;
    ZReadOnlyQueryRegn: TZReadOnlyQuery;
    ZReadOnlyQueryDrain: TZReadOnlyQuery;
    ZReadOnlyQuerySiteSelec: TZReadOnlyQuery;
    ZReadOnlyQueryStatus: TZReadOnlyQuery;
    ZReadOnlyQueryTopoSetDESCRIBE: TStringField;
    ZReadOnlyQueryTopoSetDESCRIBE1: TStringField;
    ZReadOnlyQueryTopoSetDESCRIBE10: TStringField;
    ZReadOnlyQueryTopoSetDESCRIBE11: TStringField;
    ZReadOnlyQueryTopoSetDESCRIBE2: TStringField;
    ZReadOnlyQueryTopoSetDESCRIBE3: TStringField;
    ZReadOnlyQueryTopoSetDESCRIBE4: TStringField;
    ZReadOnlyQueryTopoSetDESCRIBE5: TStringField;
    ZReadOnlyQueryTopoSetDESCRIBE6: TStringField;
    ZReadOnlyQueryTopoSetDESCRIBE7: TStringField;
    ZReadOnlyQueryTopoSetDESCRIBE8: TStringField;
    ZReadOnlyQueryTopoSetDESCRIBE9: TStringField;
    ZReadOnlyQueryTopoSetSEARCH: TStringField;
    ZReadOnlyQueryTopoSetSEARCH1: TStringField;
    ZReadOnlyQueryTopoSetSEARCH10: TStringField;
    ZReadOnlyQueryTopoSetSEARCH11: TStringField;
    ZReadOnlyQueryTopoSetSEARCH2: TStringField;
    ZReadOnlyQueryTopoSetSEARCH3: TStringField;
    ZReadOnlyQueryTopoSetSEARCH4: TStringField;
    ZReadOnlyQueryTopoSetSEARCH5: TStringField;
    ZReadOnlyQueryTopoSetSEARCH6: TStringField;
    ZReadOnlyQueryTopoSetSEARCH7: TStringField;
    ZReadOnlyQueryTopoSetSEARCH8: TStringField;
    ZReadOnlyQueryTopoSetSEARCH9: TStringField;
    procedure BasicinfDataSourceDataChange(Sender: TObject; Field: TField);
    procedure BitBtnHelpClick(Sender: TObject);
    procedure DBEditRegnDescrKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditYChange(Sender: TObject);
    procedure EditXChange(Sender: TObject);
    procedure DBSiteGridCellClick(Column: TColumn);
    procedure EditClick(Sender: TObject);
    procedure DBNavigatorBasicinfClick(Sender: TObject; Button: TDBNavButtonType);
    procedure EditEnter(Sender: TObject);
    procedure EditNR_ON_MAPExit(Sender: TObject);
    procedure EditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditKeyPress(Sender: TObject; var Key: char);
    procedure MemberQueryBeforeOpen(DataSet: TDataSet);
    procedure MemberQueryMEMBER_IDGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure MenuItemBookMark2Click(Sender: TObject);
    procedure MenuItemCopyClick(Sender: TObject);
    procedure MenuItemGotoBookmark2Click(Sender: TObject);
    procedure RxDBLookupComboMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure RxDBLookupComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RxDBLookupComboRegnChange(Sender: TObject);
    procedure RxDBLookupComboSelect(Sender: TObject);
    procedure RxDBLookupComboTypeChange(Sender: TObject);
    procedure SetBookmark1Click(Sender: TObject);
    procedure GotoBookmark1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure EditNOTES_YNDblClick(Sender: TObject);
    procedure DBLookupComboTypeChange(Sender: TObject);
    procedure ImageButtonClick(Sender: TObject);
    procedure CloseBitBtnClick(Sender: TObject);
    procedure ZReadOnlyQueryMapRefBeforeOpen(DataSet: TDataSet);
    procedure ZReadOnlyQueryMapRefsheet50GetText(Sender: TField;
      var aText: string; DisplayText: Boolean);
  private
    { private declarations }
     TheActiveDBEdit: TDBEdit;
     TheActiveRxDB: TRxDBLookupCombo;
     InsertCancelled: Boolean;
  public
    { public declarations }
    FPointSeparator, FCommaSeparator: TFormatSettings;
  end;

  TDBNavigatorEx = class(TDBNavigator);

var
  BasicinfForm: TBasicinfForm;

implementation

uses VARINIT, Notepad, SiteImages, MainDataModule;

{$R *.lfm}

procedure TBasicinfForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  TDBNavigatorEx(DBNavigatorView).Buttons[nbRefresh].Enabled := TRUE ;
  DataModuleMain.SetComponentFontAndSize(Sender, False);
  DBTextMember.Width := 100;
  Screen.Cursor := crSQLWait;
  ZReadOnlyQueryCoordAcc.Open;
  ZReadOnlyQueryCoordMeth.Open;
  ZReadOnlyQuerySurvMeth.Open;
  ZReadOnlyQueryTopoSet.Open;
  ZReadOnlyQueryDrain.Open;
  ZReadOnlyQuerySiteSelec.Open;
  ZReadOnlyQuerySiteType.Open;
  ZReadOnlyQueryEquip.Open;
  ZReadOnlyQueryPotabl.Open;
  ZReadOnlyQueryStatus.Open;
  ZReadOnlyQueryPurps.Open;
  ZReadOnlyQueryCons.Open;
  ZReadOnlyQueryApplic.Open;
  ZReadOnlyQueryInfo.Open;
  ZReadOnlyQueryRegn.Open;
  ZReadOnlyQueryRep.Open;
  if Country = 'South Africa' then ZReadOnlyQueryMapRef.Open;
  MemberQuery.Open;
  if (Country = 'South Africa') or (Country = 'Lesotho') or (Country = 'Swaziland') then
    RxDBLookupComboDrain.Enabled := True
  else
    RxDBLookupComboDrain.Enabled := False;
  DataModuleMain.CoordsEdited := False;
  Screen.Cursor := crDefault;
end;

procedure TBasicinfForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  MemberQuery.Close;
  ZReadOnlyQueryCoordMeth.Close;
  ZReadOnlyQueryCoordAcc.Close;
  ZReadOnlyQuerySurvMeth.Close;
  ZReadOnlyQueryTopoSet.Close;
  ZReadOnlyQueryDrain.Close;
  ZReadOnlyQuerySiteSelec.Close;
  ZReadOnlyQuerySiteType.Close;
  ZReadOnlyQueryEquip.Close;
  ZReadOnlyQueryPotabl.Close;
  ZReadOnlyQueryStatus.Close;
  ZReadOnlyQueryPurps.Close;
  ZReadOnlyQueryCons.Close;
  ZReadOnlyQueryApplic.Close;
  ZReadOnlyQueryInfo.Close;
  ZReadOnlyQueryRegn.Close;
  ZReadOnlyQueryRep.Close;
  ZReadOnlyQueryMapRef.Close;
  with DataModuleMain do
  begin
     ZQueryView.FreeBookmark(Bookmark1);
     ZQueryView.FreeBookmark(Bookmark2);
  end;
  Editing := 'Editing: <none>';
  CloseAction := caFree;
end;

procedure TBasicinfForm.FormActivate(Sender: TObject);
var
  i: Word;
begin
  DataModuleMain.BasicValidFound := True;
  Caption := 'Basic Site Information - [' + UpperCase(FilterName) + ']';
  CurrentSite := DataModuleMain.BasicinfQuerySITE_ID_NR.Value;
  BasicinfDataSource.AutoEdit := AutoEditGrid;
  LabelMapRef.Visible := Country = 'South Africa';
  DBTextMapRef.Visible := Country = 'South Africa';
  RecCountLabel.Caption := IntToStr(DataModuleMain.NrRecords);
  AltLabel.Caption := Altitudelabel + ' [' + LengthUnit + ']';
  ColLabel.Caption := CollarLabel + ' [' + LengthUnit + ']';
  DepLabel.Caption := DepthLabel + ' [' + LengthUnit + ']';
  DiamLabel.Caption := DiameterLabel + ' [' + DiamUnit + ']';
  //Set formats of coordinate labels
  if dstLO then
  begin
    Y_CoordLabel.Caption := YLabel + ' [' + LengthUnit + ']';
    X_CoordLabel.Caption := XLabel + ' [' + LengthUnit + ']';
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
    Y_CoordLabel.Caption := NorthLabel + ' [' + LengthUnit + ']';
    X_CoordLabel.Caption := EastLabel + ' [' + LengthUnit + ']';
  end;
  Editing := EditLabel + ' Basic information';
  if CoordSysNr = OrigCoordSysNr then
    StatusBar1.SimpleText := 'CRS: ' + CoordSysDescr
  else
    StatusBar1.SimpleText := 'CRS: ' + CoordSysDescr + ' (converted with PROJ Rel. 6.3.1)';
  if DataModuleMain.BasicinfQueryNGDB_FLAG.Value = 9 then //convert LONGITUDE/LATITUDE to X_COORD/Y_COORD
  if MessageDlg('The geometry of the current site has changed. Do you want to update the coordinates in the database accordingly?', mtInformation, [mbYes, mbNo], 0) = mrYes then
  with DataModuleMain do
  begin
    UpdateCoordsWithCs2cs(BasicinfQueryLONGITUDE.AsString, BasicinfQueryLATITUDE.AsString, BasicinfQuerySITE_ID_NR.Value);
    DataModuleMain.BasicinfQuery.Refresh;
    ShowMessage('Site coordinates were updated from a changed geometry!');
  end;
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
  LabelCompleted.Height := 26;
  LabelCompleted.Width := 72;
  RecCountLabel.Width := 80;
end;

procedure TBasicinfForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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
  end {of case}
  else
  case Key of
    VK_F1: if (ActiveControl is TDBEdit) or (ActiveControl is TRxDBLookupCombo) or (ActiveControl is TDBGrid) then
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
    VK_Escape: if DataModuleMain.BasicinfQuery.State IN [dsInsert, dsEdit] then
          DataModuleMain.BasicinfQuery.Cancel;
  end; {of case}
end;

procedure TBasicinfForm.EditKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in [#3]) then //<ctrl-c> copy
    DataModuleMain.CheckMaskEditInput(Key)
end;

procedure TBasicinfForm.MemberQueryBeforeOpen(DataSet: TDataSet);
begin
  MemberQuery.SQL.Clear;
  MemberQuery.SQL.Add('SELECT SITE_ID_NR, MEMBER_ID, DATE_TO FROM member__ WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
end;

procedure TBasicinfForm.MemberQueryMEMBER_IDGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := Sender.AsString;
end;

procedure TBasicinfForm.MenuItemBookMark2Click(Sender: TObject);
begin
  with DataModuleMain do
  begin
     ZQueryView.FreeBookmark(Bookmark2);
     Bookmark2 := ZQueryView.GetBookmark;
  end;
end;

procedure TBasicinfForm.MenuItemCopyClick(Sender: TObject);
begin
  Clipboard.AsText := DataModuleMain.ZQueryViewSITE_ID_NR.AsString;
end;

procedure TBasicinfForm.MenuItemGotoBookmark2Click(Sender: TObject);
begin
  with DataModuleMain do
    ZQueryView.GotoBookmark(Bookmark2);
end;

procedure TBasicinfForm.RxDBLookupComboMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  (Sender as TRxDBLookupCombo).Hint := DataModuleMain.TranslateCode((Sender as TRxDBLookupCombo).HelpKeyword, (Sender as TRxDBLookupCombo).Value);
end;

procedure TBasicinfForm.RxDBLookupComboKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (ssShift in Shift) and (Key = VK_Delete)
    and (BasicinfDataSource.DataSet.State in [dsEdit, dsInsert]) then
      BasicinfDataSource.DataSet.FindField((Sender as TRxDBLookupCombo).DataField).Clear;
end;

procedure TBasicinfForm.RxDBLookupComboRegnChange(Sender: TObject);
begin
  if BasicinfDataSource.DataSet.State IN [dsEdit, dsInsert] then
    BasicinfDataSource.DataSet.FieldByName('REGN_DESCR').Clear;
end;

procedure TBasicinfForm.RxDBLookupComboSelect(Sender: TObject);
begin
  {Change this section in rxlookup ~ line 1255 for this to trigger and work!!!!
  if AResult and Assigned(FDataLink.DataSource) then
    begin
      FDataLink.Edit;
      Visible:=true;
      //next line added by Immo Blecher to prevent Dataset state errors
      if FDataLink.DataSource.DataSet.State IN [dsInsert, dsEdit] then
        NeedUpdateData;//We need to update DataField;
    end;}
  if not (DataModuleMain.BasicinfQuery.State IN [dsEdit, dsInsert])
    and not (Sender as TRxDBLookupCombo).DataSource.DataSet.FieldByName((Sender as TRxDBLookupCombo).DataField).IsNull then
      (Sender as TRxDBLookupCombo).Text := (Sender as TRxDBLookupCombo).DataSource.DataSet.FieldByName((Sender as TRxDBLookupCombo).DataField).Value;
end;

procedure TBasicinfForm.RxDBLookupComboTypeChange(Sender: TObject);
var
  c: Byte;
  AllDisabled: Boolean;
begin
  with DataModuleMain do
  begin
    if not BasicinfQuerySITE_TYPE.IsNull then
    begin
      EditBH_DIAM.Enabled := BasicinfQuerySITE_TYPE.AsString[1] IN ['B', 'D', 'H', 'W', 'X'];
      EditCOLLAR_HI.Enabled := BasicinfQuerySITE_TYPE.AsString[1] IN ['B', 'W'];
      EditDEPTH.Enabled := BasicinfQuerySITE_TYPE.AsString[1] IN ['B', 'D', 'H', 'W', 'X'];
      DiamLabel.Enabled := EditBH_DIAM.Enabled;
      ColLabel.Enabled := EditCOLLAR_HI.Enabled;
      DepLabel.Enabled := EditDEPTH.Enabled;
      RecCountLabel.Caption := IntToStr(NrRecords);
      AllDisabled := False;
      for c := 0 to BHGroupBox.ControlCount -1 do
      begin
        if BHGroupBox.Controls[c].Enabled then
          Break
        else
          AllDisabled := True;
      end;
      BHGroupBox.Enabled := not AllDisabled;
    end;
  end;
end;

procedure TBasicinfForm.SetBookmark1Click(Sender: TObject);
begin
  with DataModuleMain do
  begin
    ZQueryView.FreeBookmark(Bookmark1);
    Bookmark1 := ZQueryView.GetBookmark;
  end;
end;

procedure TBasicinfForm.GotoBookmark1Click(Sender: TObject);
begin
  with DataModuleMain do
    ZQueryView.GotoBookmark(Bookmark1);
end;

procedure TBasicinfForm.PopupMenu1Popup(Sender: TObject);
begin
  MenuItemCopy.Visible := (ActiveControl is TDBGrid);
  MenuItem1.Visible := MenuItemCopy.Visible;
  MenuItemGotoBookmark1.Enabled := Assigned(DataModuleMain.BookMark1);
  MenuItemGotoBookmark2.Enabled := Assigned(DataModuleMain.BookMark2);
end;

procedure TBasicinfForm.EditNOTES_YNDblClick(Sender: TObject);
begin
  with TNotepadForm.Create(Application) do
  begin
    DBMemo.DataSource := BasicinfDataSource;
    Show;
  end;
end;

procedure TBasicinfForm.DBLookupComboTypeChange(Sender: TObject);
begin
  if (DataModuleMain.BasicinfQuerySITE_TYPE.Value = 'B')
    or (DataModuleMain.BasicinfQuerySITE_TYPE.Value = 'D')
    or (DataModuleMain.BasicinfQuerySITE_TYPE.Value = 'W') then
  begin
    BHGroupBox.Enabled := True;
  end
  else
  begin
    BHGroupBox.Enabled := False;
  end;
end;

procedure TBasicinfForm.ImageButtonClick(Sender: TObject);
begin
  with TSiteImageForm.Create(Application) do
  begin
    Show;
  end;
end;

procedure TBasicinfForm.CloseBitBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TBasicinfForm.ZReadOnlyQueryMapRefBeforeOpen(DataSet: TDataSet);
begin
  with ZReadOnlyQueryMapRef.SQL, DataModuleMain do
  begin
    Clear;
    Add('SELECT sheet50 FROM maps50 ');
    Add('WHERE WITHIN(PointFromText(''POINT(' + FloatToStr(BasicinfQueryLONGITUDE.Value) + ' ' + FloatToStr(BasicinfQueryLATITUDE.Value) + ')'', 4326), maps50.GEOMETRY)');
  end;
end;

procedure TBasicinfForm.ZReadOnlyQueryMapRefsheet50GetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if ZReadOnlyQueryMapRef.RecordCount > 0 then
    aText := ZReadOnlyQueryMapRefsheet50.Value
  else
    aText := 'n/a';
end;

procedure TBasicinfForm.BasicinfDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  if not Showing then
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
  if CoordSysNr = OrigCoordSysNr then
    StatusBar1.SimpleText := 'CRS: ' + CoordSysDescr
  else
    StatusBar1.SimpleText := 'CRS: ' + CoordSysDescr + ' (converted with PROJ Rel. 6.3.1)';
  MemberQuery.Close;
  MemberQuery.Open;
  ZReadOnlyQueryMapRef.Close;
  ZReadOnlyQueryMapRef.Open;
end;

procedure TBasicinfForm.BitBtnHelpClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TBasicinfForm.DBEditRegnDescrKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssShift in Shift) and (Key = VK_Delete)
    and (BasicinfDataSource.DataSet.State in [dsEdit, dsInsert]) then
    begin
      if (BasicinfDataSource.DataSet.FindField('REGN_TYPE').AsString = 'MUN')
      or (BasicinfDataSource.DataSet.FindField('REGN_TYPE').AsString = 'WMA') then
        BasicinfDataSource.DataSet.FindField((Sender as TDBEdit).DataField).AsString := '<AUTOMATIC>'
      else
        BasicinfDataSource.DataSet.FindField((Sender as TDBEdit).DataField).Clear;
    end;
end;

procedure TBasicinfForm.EditYChange(Sender: TObject);
begin
  //Set the edit mask of coordinate DBEdits
  if ShowDMS then
    (Sender as TDBEdit).EditMask := '00°00''00.00">L;1;_'
  else
    (Sender as TDBEdit).EditMask := '';
end;

procedure TBasicinfForm.EditXChange(Sender: TObject);
begin
  //Set the edit mask of coordinate DBEdits
  if ShowDMS then
    (Sender as TDBEdit).EditMask := '900°00''00.00">L;1;_'
  else
    (Sender as TDBEdit).EditMask := '';
end;

procedure TBasicinfForm.DBSiteGridCellClick(Column: TColumn);
begin
  HasSelection := True;
  CanCut := False;
  CanPaste := False;
end;

procedure TBasicinfForm.EditClick(Sender: TObject);
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

procedure TBasicinfForm.DBNavigatorBasicinfClick(Sender: TObject;
  Button: TDBNavButtonType);
begin
  if Button = nbInsert then
    EditNR_ON_MAP.SetFocus
  else
  if Button = nbCancel then
    InsertCancelled := True
  else //for clicking EDIT
  if TheActiveDBEdit <> NIL then
    TheActiveDBEdit.SetFocus
  else
  if TheActiveRxDB <> NIL then
    TheActiveRxDB.SetFocus;
end;

procedure TBasicinfForm.EditEnter(Sender: TObject);
begin
  if Sender is TDBEdit then
  begin
    HasSelection := (Sender as TDBEdit).SelLength > 0;
    if BasicinfDataSource.DataSet.State IN [dsEdit, dsInsert] then
    begin
      CanCut := HasSelection;
      CanPaste := True;
    end;
    TheActiveDBEdit := Sender as TDBEdit;
    TheActiveRxDB := NIL;
  end
  else
  if Sender is TRxDBLookupCombo then
  begin
    TheActiveRxDB := Sender as TrxDBLookupCombo;
    TheActiveDBEdit := NIL;
  end;
end;

procedure TBasicinfForm.EditNR_ON_MAPExit(Sender: TObject);
begin
  if InsertCancelled then //prevent asking for number that already exists
    InsertCancelled := False
  else
  if DataModuleMain.BasicinfQuery.State = dsInsert then
  begin
    NRQuery.SQL.Clear;
    NRQuery.SQL.Add('SELECT NR_ON_MAP FROM basicinf WHERE NR_ON_MAP = ' + QuotedStr(EditNR_ON_MAP.Text));
    NRQuery.Open;
    if NRQuery.RecordCount > 0 then
      if MessageDlg('This number already exists! Do you want to use the same number for this site?', mtWarning, [mbYes, mbNo], 0) = mrNo then
      begin
        DataModuleMain.BasicinfQueryNR_ON_MAP.Clear;
        EditNR_ON_MAP.SetFocus;
      end;
    NRQuery.Close;
  end;
end;

procedure TBasicinfForm.EditKeyUp(Sender: TObject; var Key: Word;
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

procedure TBasicinfForm.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssShift in Shift) and (Key = VK_Delete)
    and (BasicinfDataSource.DataSet.State in [dsEdit, dsInsert]) then
      BasicinfDataSource.DataSet.FindField((Sender as TDBEdit).DataField).Clear;
end;

procedure TBasicinfForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if BasicinfDataSource.DataSet.State IN [dsInsert, dsEdit] then
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
end;

initialization

end.
