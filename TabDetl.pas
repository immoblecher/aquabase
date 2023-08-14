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
unit TabDetl;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Clipbrd, ZDataset, Math,
  StdCtrls, Forms, DBCtrls, DB, DBGrids, ExtCtrls, LCLType, Buttons, Menus,
  Dialogs, ComCtrls, XMLPropStorage, rxlookup;

type

  { TTabbedMastDetailForm }

  TTabbedMastDetailForm = class(TForm)
    AccuDataSource: TDataSource;
    AltLabel: TLabel;
    ColLabel: TLabel;
    DBEditX: TDBEdit;
    DBEditY: TDBEdit;
    DBFilterNavigator: TDBNavigator;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    DBGrid4: TDBGrid;
    DepLabel: TLabel;
    DetailNavigator: TDBNavigator;
    EditALTITUDE: TDBEdit;
    EditCOLLAR_HI: TDBEdit;
    EditDATE_UPDTD: TDBEdit;
    EditDEPTH: TDBEdit;
    EditFARM_NR: TDBEdit;
    EditNR_ON_MAP: TDBEdit;
    EditResults: TEdit;
    EditSITE_ID_NR: TDBEdit;
    EditSITE_NAME: TDBEdit;
    GotoBookmark: TMenuItem;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    LinkedLabel: TLabel;
    MenuItemBookmark1: TMenuItem;
    MenuItemBookMark2: TMenuItem;
    MenuItemGotoBookmark1: TMenuItem;
    MenuItemGotoBookmark2: TMenuItem;
    MenuItemSetBookmarks: TMenuItem;
    PageControl: TPageControl;
    Panel1: TPanel;
    BasicinfDataSource: TDataSource;
    CloseBitBtn: TBitBtn;
    BitBtnHelp: TBitBtn;
    EditNavigator: TDBNavigator;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    PopupMenu1: TPopupMenu;
    RecordText: TStaticText;
    RxDBLookupComboAcc: TRxDBLookupCombo;
    RxDBLookupComboType: TRxDBLookupCombo;
    StaticText1: TStaticText;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TypeDataSource: TDataSource;
    XMLPropStorage: TXMLPropStorage;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DataSource4: TDataSource;
    X_CoordLabel: TLabel;
    Y_CoordLabel: TLabel;
    ZQuery1: TZQuery;
    ZQuery2: TZQuery;
    ZQuery3: TZQuery;
    ZQuery4: TZQuery;
    ZReadOnlyQueryCoordAcc: TZReadOnlyQuery;
    ZReadOnlyQueryCoordAccDESCRIBE: TStringField;
    ZReadOnlyQueryCoordAccSEARCH: TStringField;
    ZReadOnlyQuerySiteType: TZReadOnlyQuery;
    ZReadOnlyQueryTopoSetDESCRIBE3: TStringField;
    ZReadOnlyQueryTopoSetSEARCH3: TStringField;
    procedure BasicinfDataSourceDataChange(Sender: TObject; Field: TField);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure DataSource1StateChange(Sender: TObject);
    procedure DataSource2DataChange(Sender: TObject; Field: TField);
    procedure DataSource2StateChange(Sender: TObject);
    procedure DataSource3DataChange(Sender: TObject; Field: TField);
    procedure DataSource3StateChange(Sender: TObject);
    procedure DataSource4DataChange(Sender: TObject; Field: TField);
    procedure DataSource4StateChange(Sender: TObject);
    procedure EditYChange(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure DBGrid3CellClick(Column: TColumn);
    procedure DBGrid4CellClick(Column: TColumn);
    procedure DBGridGetCellHint(Sender: TObject; Column: TColumn;
      var AText: String);
    procedure DBGridMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBGridTitleClick(Column: TColumn);
    procedure DBGridColExit(Sender: TObject);
    procedure DBGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DetailNavigatorBeforeAction(Sender: TObject;
      Button: TDBNavButtonType);
    procedure DetailNavigatorClick(Sender: TObject; Button: TDBNavButtonType);
    procedure EditNavigatorClick(Sender: TObject; Button: TDBNavButtonType);
    procedure EditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditClick(Sender: TObject);
    procedure EditResultsEditingDone(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure EditBasicinfEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: char);
    procedure MaskEditEditingDone(Sender: TObject);
    procedure EditXChange(Sender: TObject);
    procedure MaskEditExit(Sender: TObject);
    procedure MenuItemBookMark2Click(Sender: TObject);
    procedure MenuItemGotoBookmark2Click(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure PageControlEnter(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure GotoBookmark1Click(Sender: TObject);
    procedure RxDBLookupComboClick(Sender: TObject);
    procedure RxDBLookupComboMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure RxDBLookupComboSelect(Sender: TObject);
    procedure SetBookmark1Click(Sender: TObject);
    procedure DBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEnter(Sender: TObject);
    procedure BitBtnHelpClick(Sender: TObject);
    procedure CloseBitBtnClick(Sender: TObject);
    procedure TabSheet1Exit(Sender: TObject);
    procedure TabSheet2Exit(Sender: TObject);
    procedure TabSheet3Exit(Sender: TObject);
    procedure TabSheet4Exit(Sender: TObject);
    procedure ZQuery2NewRecord(DataSet: TDataSet);
    procedure ZQuery3NewRecord(DataSet: TDataSet);
    procedure ZQuery4NewRecord(DataSet: TDataSet);
    procedure ZQueryBeforeOpen(DataSet: TDataSet);
    procedure ZQueryAfterOpen(DataSet: TDataSet);
    procedure ZQuery1NewRecord(DataSet: TDataSet);
    procedure ZQueryPostError(DataSet: TDataSet; E: EDatabaseError;
      var DataAction: TDataAction);
    procedure ZQueryAfterCancel(DataSet: TDataSet);
    procedure ZQueryAfterPost(DataSet: TDataSet);
    procedure ZQueryBeforePost(DataSet: TDataSet);
  private
    { private declarations }
    JumpFieldNr: Byte;
    row, col : Integer;
    TheActiveDBEdit: TDBEdit;
    TheActiveRxDB: TRxDBLookupCombo;
  public
    { public declarations }
    ValidFound: Boolean;
  end;

  TDBNavigatorEx = class(TDBNavigator);

var
  TabbedMastDetailForm: TTabbedMastDetailForm;

implementation

{$R *.lfm}

uses VARINIT, MainDataModule, LOOKUP;

procedure TTabbedMastDetailForm.FormCreate(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  XMLPropStorage.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  TDBNavigatorEx(DBFilterNavigator).Buttons[nbRefresh].Enabled := TRUE ;
  Label1.Caption := SiteIDLabel;
  Label2.Caption := NrLabel;
  Label3.Caption := DistrLabel;
  Label4.Caption := SiteNameLabel;
  Label5.Caption := CoordAccLabel;
  AltLabel.Caption := AltitudeLabel;
  ColLabel.Caption := CollarLabel;
  DepLabel.Caption := DepthLabel;
  Label6.Caption := SiteTypeLabel;
  Label7.Caption := DateUpdtLabel;
  DataModuleMain.SetComponentFontAndSize(Sender, False);
  //hardcode taborder
  EditCOLLAR_HI.TabOrder := 8;
  EditDEPTH.TabOrder := 9;
  RxDBLookupComboType.TabOrder := 10;
  ValidFound := True;
  DataModuleMain.CoordsEdited := False;
  Screen.Cursor := crDefault;
end;

procedure TTabbedMastDetailForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  with DataModuleMain do
  begin
    ZQueryView.FreeBookmark(Bookmark1);
    ZQueryView.FreeBookmark(Bookmark2);
  end;
  ZReadOnlyQueryCoordAcc.Close;
  ZReadOnlyQuerySiteType.Close;
  DataModuleMain.AquaSortTable.Close;
  Editing := 'Editing: <none>';
  ZQuery1.Close;
  ZQuery2.Close;
  ZQuery3.Close;
  ZQuery4.Close;
  CloseAction := caFree;
end;

procedure TTabbedMastDetailForm.FormActivate(Sender: TObject);
var
  i: Word;
begin
  Screen.Cursor := crSQLWait;
  BasicinfDataSource.AutoEdit := AutoEditData;
  DataModuleMain.BasicValidFound := True;
  BitBtnHelp.Hint := 'Help on ' + Caption;
  //Set Labels
  AltLabel.Caption := AltitudeLabel + ' [' + LengthUnit + ']';
  ColLabel.Caption := CollarLabel + ' [' + LengthUnit + ']';
  DepLabel.Caption := DepthLabel + ' [' + LengthUnit + ']';
  if EditNavigator.DataSource = BasicinfDataSource then
    Editing := EditLabel + ' Basic information'
  else
    Editing := EditLabel + ' ' + Caption;
  EditNavigator.Enabled := DataModuleMain.NrRecords > 0;
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
  LinkedLabel.Width := Width - 100;
  Screen.Cursor := crDefault;
  if DataModuleMain.BasicinfQueryNGDB_FLAG.Value = 9 then //convert LONGITUDE/LATITUDE to X_COORD/Y_COORD
  if MessageDlg('The geometry of the current site has changed. Do you want to update the coordinates in the database accordingly?', mtInformation, [mbYes, mbNo], 0) = mrYes then
  with DataModuleMain do
  begin
    UpdateCoordsWithCs2cs(BasicinfQueryLONGITUDE.AsString, BasicinfQueryLATITUDE.AsString, BasicinfQuerySITE_ID_NR.AsString);
    BasicinfQuery.Refresh;
    ShowMessage('Site coordinates were updated from a changed geometry!');
  end;
end;

procedure TTabbedMastDetailForm.EditBasicinfEnter(Sender: TObject);
begin
  if DetailNavigator.DataSource.DataSet.State IN [dsInsert, dsEdit] then
    if MessageDlg('Changes to current record have not been posted and will be lost! Post record now?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    DetailNavigator.DataSource.DataSet.Post
  else
    DetailNavigator.DataSource.DataSet.Cancel;
  Editing := 'Editing: Basic information';
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
    TheActiveRxDB := Sender as TRxDBLookupCombo;
    TheActiveDBEdit := NIL;
  end;
end;

procedure TTabbedMastDetailForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not (ActiveControl is TDBGrid) then
  begin
    if ssCtrl in Shift then
    case Key of
      VK_RIGHT: DataModuleMain.ZQueryView.Next;
      VK_LEFT: DataModuleMain.ZQueryView.Prior;
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
             begin
               if TabIndex < 3 then TabIndex := TabIndex + 1;
               if not ActivePage.TabVisible then TabIndex := TabIndex - 1;
             end;
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

procedure TTabbedMastDetailForm.FormShow(Sender: TObject);
begin
  //open all the tables
  try
    Screen.Cursor := crSQLWait;
    ZReadOnlyQueryCoordAcc.Open;
    ZReadOnlyQuerySiteType.Open;
    DataModuleMain.AquaSortTable.Open;
  finally
    Screen.Cursor := crDefault;
  end;
  try
    with ZQuery1 do
    begin
      FetchRow := EditResults.Tag;
      Params[0].AsString := CurrentSite;
      Open;
    end;
    with ZQuery2 do
    begin
      FetchRow := EditResults.Tag;
      Params[0].AsString := CurrentSite;
      Open;
    end;
    if ZQuery3.Tag > 0 then
    with ZQuery3 do
    begin
      FetchRow := EditResults.Tag;
      Params[0].AsString := CurrentSite;
      Open;
    end;
    if ZQuery4.Tag > 0 then
    with ZQuery4 do
    begin
      FetchRow := EditResults.Tag;
      Params[0].AsString := CurrentSite;
      Open;
    end;
  except on E: Exception do
    MessageDlg(E.Message + ' - You may have to contact your database administrator to resolve this error.', mtError, [mbOK], 0);
  end;
  DetailNavigator.DataSource := TDataSource(FindComponent('DataSource' + IntToStr(PageControl.ActivePageIndex + 1)));
  RecordText.Caption := 'Record ' + IntToStr(DetailNavigator.DataSource.DataSet.RecNo) + ' out of ' + IntToStr(DetailNavigator.DataSource.DataSet.RecordCount);
  EditResults.Text := IntToStr(EditResults.Tag);
end;

procedure TTabbedMastDetailForm.EditKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in [#3]) then //<ctrl-c> copy
    DataModuleMain.CheckMaskEditInput(Key);
end;

procedure TTabbedMastDetailForm.MaskEditEditingDone(Sender: TObject);
begin

end;

procedure TTabbedMastDetailForm.EditXChange(Sender: TObject);
begin
  //Set the edit mask of coordinate DBEdits
  if ShowDMS then
    (Sender as TDBEdit).EditMask := '900°00''00.00">L;1;_'
  else
    (Sender as TDBEdit).EditMask := '';
end;

procedure TTabbedMastDetailForm.MaskEditExit(Sender: TObject);
begin

end;

procedure TTabbedMastDetailForm.MenuItemBookMark2Click(Sender: TObject);
begin
  with DataModuleMain do
  begin
    ZQueryView.FreeBookmark(Bookmark2);
    Bookmark2 := ZQueryView.GetBookmark;
  end;
end;

procedure TTabbedMastDetailForm.MenuItemGotoBookmark2Click(Sender: TObject);
begin
  with DataModuleMain do
    ZQueryView.GotoBookmark(Bookmark2);
end;

procedure TTabbedMastDetailForm.PageControlChange(Sender: TObject);
begin
  TDBGrid(FindComponent('DBGrid' + IntToStr(PageControl.ActivePage.Tag))).SetFocus;
  DetailNavigator.DataSource := TDataSource(FindComponent('DataSource' + IntToStr(PageControl.ActivePage.Tag)));
  RecordText.Caption := 'Record ' + IntToStr(DetailNavigator.DataSource.DataSet.RecNo) + ' out of ' + IntToStr(DetailNavigator.DataSource.DataSet.RecordCount);
end;

procedure TTabbedMastDetailForm.PageControlEnter(Sender: TObject);
begin
  TDBGrid(FindComponent('DBGrid' + IntToStr(PageControl.ActivePage.Tag))).SetFocus;
  DetailNavigator.DataSource := TDataSource(FindComponent('DataSource' + IntToStr(PageControl.ActivePage.Tag)));
  RecordText.Caption := 'Record ' + IntToStr(DetailNavigator.DataSource.DataSet.RecNo) + ' out of ' + IntToStr(DetailNavigator.DataSource.DataSet.RecordCount);
end;

procedure TTabbedMastDetailForm.PopupMenu1Popup(Sender: TObject);
begin
  MenuItemGotoBookmark1.Enabled := Assigned(DataModuleMain.BookMark1);
  MenuItemGotoBookmark2.Enabled := Assigned(DataModuleMain.BookMark2);
end;

procedure TTabbedMastDetailForm.GotoBookmark1Click(Sender: TObject);
begin
  with DataModuleMain do
    ZQueryView.GotoBookmark(Bookmark1);
end;

procedure TTabbedMastDetailForm.RxDBLookupComboClick(Sender: TObject);
begin
  (Sender as TRxDBLookupCombo).SetFocus;
end;

procedure TTabbedMastDetailForm.RxDBLookupComboMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  (Sender as TRxDBLookupCombo).Hint := DataModuleMain.TranslateCode((Sender as TRxDBLookupCombo).HelpKeyword, (Sender as TRxDBLookupCombo).Value);
end;

procedure TTabbedMastDetailForm.RxDBLookupComboSelect(Sender: TObject);
begin
  if not (DataModuleMain.BasicinfQuery.State IN [dsEdit, dsInsert])
    and not (Sender as TRxDBLookupCombo).DataSource.DataSet.FieldByName((Sender as TRxDBLookupCombo).DataField).IsNull then
      (Sender as TRxDBLookupCombo).Text := (Sender as TRxDBLookupCombo).DataSource.DataSet.FieldByName((Sender as TRxDBLookupCombo).DataField).Value;
end;

procedure TTabbedMastDetailForm.SetBookmark1Click(Sender: TObject);
begin
  with DataModuleMain do
  begin
    ZQueryView.FreeBookmark(Bookmark1);
    Bookmark1 := ZQueryView.GetBookmark;
  end;
end;

procedure TTabbedMastDetailForm.DBGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  TheCategory: ShortString;
begin
  TheCategory := '';
  if (ssCtrl in Shift) and (Key = VK_F8) then
    TDBGrid(Sender).DataSource.DataSet.Edit
  else
  case Key of
   VK_RETURN: if (TDBGrid(Sender).SelectedIndex = TDBGrid(Sender).Columns.Count - 1) and (not (ssShift in Shift))then //is at the last column and tabs right
              begin
                TDBGrid(Sender).DataSource.DataSet.Append;
                TDBGrid(Sender).SelectedIndex := 1;
                Key := 0;
              end;
    VK_TAB: if not (ssShift in Shift) then //tab forward
            if (TDBGrid(Sender).SelectedIndex = TDBGrid(Sender).Columns.Count - 1) and (not (ssShift in Shift))then //is at the last column and tabs right
            begin
              TDBGrid(Sender).DataSource.DataSet.Append;
              TDBGrid(Sender).SelectedIndex := 1;
              Key := 0;
            end;
    VK_DELETE: if TDBGrid(Sender).DataSource.DataSet.State IN [dsInsert, dsEdit] then
                 if ssShift in Shift then
                   TDBGrid(Sender).SelectedField.Clear;
    VK_F5: TDBGrid(Sender).DataSource.DataSet.Refresh;
    VK_F8: if TDBGrid(Sender).DataSource.DataSet.State IN [dsInsert, dsEdit] then
             (Sender as TDBGrid).DataSource.DataSet.Post;
    VK_F9: begin
             TheCategory := (Sender as TDBGrid).SelectedField.LookupKeyFields;
             if TheCategory > '' then
             with TLookupForm.Create(Application) do
             begin
               LookupCategory := TheCategory;
               LookupValue := (Sender as TDBGrid).DataSource.DataSet.FieldByName((Sender as TDBGrid).SelectedField.FieldName).AsString;
               ShowModal;
               if ModalResult = mrOK then
                 if (Sender as TDBGrid).DataSource.DataSet.State IN [dsInsert, dsEdit] then
                   (Sender as TDBGrid).DataSource.DataSet.FieldByName((Sender as TDBGrid).SelectedField.FieldName).AsString := LookupValue;
               Close;
             end;
           end;
  end; {of key case}
end;

procedure TTabbedMastDetailForm.DBGridEnter(Sender: TObject);
begin
  if DataModuleMain.BasicinfQuery.State IN [dsInsert, dsEdit] then
    if MessageDlg('Changes to Basic Information have not been posted and will be lost! Post record now?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then DataModuleMain.BasicinfQuery.Post
    else
      DataModuleMain.BasicinfQuery.Cancel;
  Editing := EditLabel + ' ' + Caption;
  HasSelection := not TDBGrid(Sender).SelectedField.IsNull;
  CanCut := TDBGrid(Sender).DataSource.DataSet.State IN [dsEdit, dsInsert];
  CanPaste := TDBGrid(Sender).DataSource.DataSet.State IN [dsEdit, dsInsert];
end;

procedure TTabbedMastDetailForm.BitBtnHelpClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TTabbedMastDetailForm.CloseBitBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TTabbedMastDetailForm.TabSheet1Exit(Sender: TObject);
var c: Integer;
begin
  for c := 0 to DBGrid1.Columns.Count - 1 do //reset all to white
    DBGrid1.Columns[c].Color := clWindow;
  JumpFieldNr := 0;
end;

procedure TTabbedMastDetailForm.TabSheet2Exit(Sender: TObject);
var c: Integer;
begin
  for c := 0 to DBGrid2.Columns.Count - 1 do //reset all to white
    DBGrid2.Columns[c].Color := clWindow;
  JumpFieldNr := 0;
end;

procedure TTabbedMastDetailForm.TabSheet3Exit(Sender: TObject);
var c: Integer;
begin
  for c := 0 to DBGrid3.Columns.Count - 1 do //reset all to white
    DBGrid3.Columns[c].Color := clWindow;
  JumpFieldNr := 0;
end;

procedure TTabbedMastDetailForm.TabSheet4Exit(Sender: TObject);
var c: Integer;
begin
  for c := 0 to DBGrid4.Columns.Count - 1 do //reset all to white
    DBGrid4.Columns[c].Color := clWindow;
  JumpFieldNr := 0;
end;

procedure TTabbedMastDetailForm.ZQuery2NewRecord(DataSet: TDataSet);
begin
  if DataSet.FindField('REP_INST') <> NIL then
    Dataset.FieldByName('REP_INST').Value := DataModuleMain.BasicinfQueryREP_INST.Value;
  if JumpFieldNr > 0 then
    DBGrid2.SelectedField := Dataset.Fields.Fields[JumpFieldNr]
  else
    DBGrid2.SelectedField := Dataset.Fields.Fields[1];

end;

procedure TTabbedMastDetailForm.ZQuery3NewRecord(DataSet: TDataSet);
begin
  if DataSet.FindField('REP_INST') <> NIL then
    Dataset.FieldByName('REP_INST').Value := DataModuleMain.BasicinfQueryREP_INST.Value;
  if JumpFieldNr > 0 then
    DBGrid3.SelectedField := Dataset.Fields.Fields[JumpFieldNr]
  else
    DBGrid3.SelectedField := Dataset.Fields.Fields[1];
end;

procedure TTabbedMastDetailForm.ZQuery4NewRecord(DataSet: TDataSet);
begin
  if DataSet.FindField('REP_INST') <> NIL then
    Dataset.FieldByName('REP_INST').Value := DataModuleMain.BasicinfQueryREP_INST.Value;
  if JumpFieldNr > 0 then
    DBGrid4.SelectedField := Dataset.Fields.Fields[JumpFieldNr]
  else
    DBGrid4.SelectedField := Dataset.Fields.Fields[1];
end;

procedure TTabbedMastDetailForm.ZQueryBeforeOpen(DataSet: TDataSet);
begin
  TZQuery(DataSet).FetchRow := EditResults.Tag;
  TZQuery(DataSet).Params[0].AsString := CurrentSite;
end;

procedure TTabbedMastDetailForm.ZQueryAfterOpen(DataSet: TDataSet);
begin
  (FindComponent('DataSource' + IntToStr(Dataset.Tag)) as TDataSource).AutoEdit := AutoEditData;
end;

procedure TTabbedMastDetailForm.ZQuery1NewRecord(DataSet: TDataSet);
begin
  if DataSet.FindField('REP_INST') <> NIL then
    Dataset.FieldByName('REP_INST').Value := DataModuleMain.BasicinfQueryREP_INST.Value;
  if JumpFieldNr > 0 then
    DBGrid1.SelectedField := Dataset.Fields.Fields[JumpFieldNr]
  else
    DBGrid1.SelectedField := Dataset.Fields.Fields[1];
end;

procedure TTabbedMastDetailForm.ZQueryPostError(DataSet: TDataSet;
  E: EDatabaseError; var DataAction: TDataAction);
begin
  ShowMessage(E.Message + '. Record will not be posted!');
  DataAction := daAbort;
end;

procedure TTabbedMastDetailForm.ZQueryAfterCancel(DataSet: TDataSet);
begin
  ValidFound := True;
end;

procedure TTabbedMastDetailForm.ZQueryAfterPost(DataSet: TDataSet);
begin
  ValidFound := True;
end;

procedure TTabbedMastDetailForm.ZQueryBeforePost(DataSet: TDataSet);
begin
  if not ValidFound then
  begin
    MessageDlg('You are trying to post a record with invalid values in the current field! Please TAB left or right to obtain reason for this error.', mtError, [mbOK], 0);
    Abort;
  end;
end;

procedure TTabbedMastDetailForm.DBGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  TheCategory: ShortString;
begin
  DBGridEnter(Sender);
  TheCategory := '';
  if Button = mbRight then
  begin
    TheCategory := (Sender as TDBGrid).SelectedField.LookupKeyFields;
    if TheCategory > '' then
    with TLookupForm.Create(Application) do
    begin
      LookupCategory := TheCategory;
      LookupValue := (Sender as TDBGrid).DataSource.DataSet.FieldByName((Sender as TDBGrid).SelectedField.FieldName).AsString;
      ShowModal;
      if ModalResult = mrOK then
        if (Sender as TDBGrid).DataSource.DataSet.State IN [dsInsert, dsEdit] then
          (Sender as TDBGrid).DataSource.DataSet.FieldByName((Sender as TDBGrid).SelectedField.FieldName).AsString := LookupValue;
      Close;
    end;
  end;
end;

procedure TTabbedMastDetailForm.DetailNavigatorBeforeAction(Sender: TObject;
  Button: TDBNavButtonType);
begin
  case Button of
    nbNext, nbPrior, nbFirst, nbLast: Screen.Cursor := crSQLWait;
  end; //of case
end;

procedure TTabbedMastDetailForm.DetailNavigatorClick(Sender: TObject;
  Button: TDBNavButtonType);
begin
  TDBGrid(FindComponent('DBGrid' + IntToStr(PageControl.ActivePageIndex + 1))).SetFocus;
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

procedure TTabbedMastDetailForm.EditNavigatorClick(Sender: TObject;
  Button: TDBNavButtonType);
begin
  if TheActiveDBEdit <> NIL then
    TheActiveDBEdit.SetFocus
  else
  if TheActiveRxDB <> NIL then
    TheActiveRxDB.SetFocus;
end;

procedure TTabbedMastDetailForm.EditKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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

procedure TTabbedMastDetailForm.EditClick(Sender: TObject);
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
  end
end;

procedure TTabbedMastDetailForm.EditResultsEditingDone(Sender: TObject);
begin
  EditResults.Tag := StrToInt(EditResults.Text);
  ZQuery1.FetchRow := EditResults.Tag;
  ZQuery2.FetchRow := EditResults.Tag;
  if ZQuery3.Active then
    ZQuery3.FetchRow := EditResults.Tag;
  if ZQuery4.Active then
    ZQuery4.FetchRow := EditResults.Tag;
  DetailNavigator.DataSource.DataSet.Refresh;
end;

procedure TTabbedMastDetailForm.EditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (ssShift in Shift) and (Key = VK_Delete)
    and (BasicinfDataSource.DataSet.State in [dsEdit, dsInsert]) then
      BasicinfDataSource.DataSet.FindField((Sender as TDBEdit).DataField).Clear;
end;

procedure TTabbedMastDetailForm.FormCloseQuery(Sender: TObject;
  var CanClose: boolean);
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
  if DetailNavigator.DataSource.DataSet.State IN [dsInsert, dsEdit] then
    case MessageDlg('Your Detail table information has not been posted. Do you want to post it now and close or continue editing?', mtWarning, [mbYes, mbNo, mbIgnore], 0) of
      mrYes: begin
               DetailNavigator.DataSource.DataSet.Post;
               CanClose := True;
             end;
       mrNo: CanClose := False;
   mrIgnore: begin
               DetailNavigator.DataSource.DataSet.Cancel;
               CanClose := True;
             end;
    end; //of case
end;

procedure TTabbedMastDetailForm.BasicinfDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  CurrentSite := DataModuleMain.BasicinfQuerySITE_ID_NR.Value;
  //close and open the tables
  if Showing then
  try
    Screen.Cursor := crSQLWait;
    ZQuery1.Close;
    ZQuery1.Open;
    ZQuery2.Close;
    ZQuery2.Open;
    ZQuery3.Close;
    ZQuery3.Active := ZQuery3.Tag > 0;
    ZQuery4.Close;
    ZQuery4.Active := ZQuery4.Tag > 0;
    Screen.Cursor := crDefault;
  except on E: Exception do
    begin
      Screen.Cursor := crDefault;
      MessageDlg(E.Message + ' - Could not open linked detail table! Maybe close and open the form again.', mtError, [mbOK], 0);
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
  if not (BasicinfDataSource.DataSet.State IN [dsInsert, dsEdit]) then
  with DataModuleMain do
  begin
    if not BasicinfQuerySITE_TYPE.IsNull then
    begin
      EditCOLLAR_HI.Enabled := BasicinfQuerySITE_TYPE.AsString[1] IN ['B', 'W'];
      EditDEPTH.Enabled := BasicinfQuerySITE_TYPE.AsString[1] IN ['B', 'D', 'H', 'W', 'X'];
      ColLabel.Enabled := EditCOLLAR_HI.Enabled;
      DepLabel.Enabled := EditDEPTH.Enabled;
    end;
  end;
end;

procedure TTabbedMastDetailForm.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
  if ZQuery1.Active then RecordText.Caption := 'Record ' + IntToStr(ZQuery1.RecNo) + ' out of ' + IntToStr(ZQuery1.RecordCount);
end;

procedure TTabbedMastDetailForm.DataSource1StateChange(Sender: TObject);
begin
  if DBGrid1.DataSource.DataSet.Active then
  begin
    HasSelection := not DBGrid1.SelectedField.IsNull;
    CanCut := DBGrid1.DataSource.DataSet.State IN [dsEdit, dsInsert];
    CanPaste := DBGrid1.DataSource.DataSet.State IN [dsEdit, dsInsert];
  end;
end;

procedure TTabbedMastDetailForm.DataSource2DataChange(Sender: TObject;
  Field: TField);
begin
  if ZQuery2.Active then RecordText.Caption := 'Record ' + IntToStr(ZQuery2.RecNo) + ' out of ' + IntToStr(ZQuery2.RecordCount);
end;

procedure TTabbedMastDetailForm.DataSource2StateChange(Sender: TObject);
begin
  if DBGrid2.DataSource.DataSet.Active then
  begin
    HasSelection := not DBGrid2.SelectedField.IsNull;
    CanCut := DBGrid2.DataSource.DataSet.State IN [dsEdit, dsInsert];
    CanPaste := DBGrid2.DataSource.DataSet.State IN [dsEdit, dsInsert];
  end;
end;

procedure TTabbedMastDetailForm.DataSource3DataChange(Sender: TObject;
  Field: TField);
begin
  if ZQuery3.Active then RecordText.Caption := 'Record ' + IntToStr(ZQuery3.RecNo) + ' out of ' + IntToStr(ZQuery3.RecordCount);
end;

procedure TTabbedMastDetailForm.DataSource3StateChange(Sender: TObject);
begin
  if DBGrid3.DataSource.DataSet.Active then
  begin
    HasSelection := not DBGrid3.SelectedField.IsNull;
    CanCut := DBGrid3.DataSource.DataSet.State IN [dsEdit, dsInsert];
    CanPaste := DBGrid3.DataSource.DataSet.State IN [dsEdit, dsInsert];
  end;
end;

procedure TTabbedMastDetailForm.DataSource4DataChange(Sender: TObject;
  Field: TField);
begin
  if ZQuery4.Active then RecordText.Caption := 'Record ' + IntToStr(ZQuery4.RecNo) + ' out of ' + IntToStr(ZQuery4.RecordCount);
end;

procedure TTabbedMastDetailForm.DataSource4StateChange(Sender: TObject);
begin
  if DBGrid4.DataSource.DataSet.Active then
  begin
    HasSelection := not DBGrid4.SelectedField.IsNull;
    CanCut := DBGrid4.DataSource.DataSet.State IN [dsEdit, dsInsert];
    CanPaste := DBGrid4.DataSource.DataSet.State IN [dsEdit, dsInsert];
  end;
end;

procedure TTabbedMastDetailForm.EditYChange(Sender: TObject);
begin
  //Set the edit mask of coordinate DBEdits
  if ShowDMS then
    (Sender as TDBEdit).EditMask := '00°00''00.00">L;1;_'
  else
    (Sender as TDBEdit).EditMask := '';
end;

procedure TTabbedMastDetailForm.DBGrid1CellClick(Column: TColumn);
begin
  HasSelection := not DBGrid1.SelectedField.IsNull;
  CanCut := DBGrid1.DataSource.DataSet.State IN [dsEdit, dsInsert];
  CanPaste := DBGrid1.DataSource.DataSet.State IN [dsEdit, dsInsert];
end;

procedure TTabbedMastDetailForm.DBGrid2CellClick(Column: TColumn);
begin
  HasSelection := not DBGrid2.SelectedField.IsNull;
  CanCut := DBGrid2.DataSource.DataSet.State IN [dsEdit, dsInsert];
  CanPaste := DBGrid2.DataSource.DataSet.State IN [dsEdit, dsInsert];
end;

procedure TTabbedMastDetailForm.DBGrid3CellClick(Column: TColumn);
begin
  HasSelection := not DBGrid3.SelectedField.IsNull;
  CanCut := DBGrid3.DataSource.DataSet.State IN [dsEdit, dsInsert];
  CanPaste := DBGrid3.DataSource.DataSet.State IN [dsEdit, dsInsert];
end;

procedure TTabbedMastDetailForm.DBGrid4CellClick(Column: TColumn);
begin
  HasSelection := not DBGrid4.SelectedField.IsNull;
  CanCut := DBGrid4.DataSource.DataSet.State IN [dsEdit, dsInsert];
  CanPaste := DBGrid4.DataSource.DataSet.State IN [dsEdit, dsInsert];
end;

procedure TTabbedMastDetailForm.DBGridGetCellHint(Sender: TObject;
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
    AText := Caption + ' Information';
    (Sender as TDBGrid).ShowHint := False;
  end;
end;

procedure TTabbedMastDetailForm.DBGridMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  TDBGrid(Sender).MouseToCell(X, Y, col, row);
end;

procedure TTabbedMastDetailForm.DBGridTitleClick(Column: TColumn);
var c: Integer;
begin
  if JumpFieldNr = 0 then
  begin
    Column.Color := clBtnFace;
    JumpFieldNr := Column.Field.Index;
  end
  else
  begin
    for c := 0 to TDBGrid(ActiveControl).Columns.Count - 1 do //reset all to white
      TDBGrid(ActiveControl).Columns[c].Color := clWindow;
    if Column.Field.Index <> JumpFieldNr then //set to grey
    begin
      Column.Color := clBtnFace;
      JumpFieldNr := Column.Field.Index;
    end
    else JumpFieldNr := 0;
  end;
end;

procedure TTabbedMastDetailForm.DBGridColExit(Sender: TObject);
begin
  if (Sender as TDBGrid).Focused and (not ValidFound) then
  begin
    if (Sender as TDBGrid).SelectedField.FieldName = 'DEPTH_BOT' then
      MessageDlg('Depth-to-bottom must be greater than depth-to-top! Press <ENTER> or click the cell to enter a valid value.', mtError, [mbOK], 0)
    else
    if (Sender as TDBGrid).SelectedField.FieldName = 'DEPTH_TOP' then
      MessageDlg('Depth-to-top must be less than depth-to-bottom! Press <ENTER> or click the cell to enter a valid value.', mtError, [mbOK], 0)
    else
    if Pos('DATE', (Sender as TDBGrid).SelectedField.FieldName) > 0 then
      MessageDlg('Invalid date entered! Press <ENTER> or click the cell to enter a valid date (YYYYMMDD).', mtError, [mbOK], 0)
    else
    if Pos('TIME', (Sender as TDBGrid).SelectedField.FieldName) > 0 then
      MessageDlg('Invalid time entered! Press <ENTER> or click the cell to enter a valid time (HHMM).', mtError, [mbOK], 0)
    else
    if (Sender as TDBGrid).SelectedField.FieldName = 'SITE_ID_NR' then
        MessageDlg('Invalid site identifier entered! Press <ENTER> or click the cell to enter a valid site identifier.', mtError, [mbOK], 0)
    else
    if (Sender as TDBGrid).SelectedField.FieldName = 'INDIAM' then
        MessageDlg('Inner diameter must be less than outer diameter! Press <ENTER> or click the cell to enter a valid value.', mtError, [mbOK], 0)
    else
    if (Sender as TDBGrid).SelectedField.FieldName = 'OUTDIAM' then
        MessageDlg('Outer diameter must be greater than inner diameter! Press <ENTER> or click the cell to enter a valid value.', mtError, [mbOK], 0)
    else
    if (Sender as TDBGrid).SelectedField.FieldName = 'DIRECTION' then
        MessageDlg('Direction must be >= 0° and <= 360°! Press <ENTER> or click the cell to enter a valid value.', mtError, [mbOK], 0)
    else
    if Pos('PIEZO', (Sender as TDBGrid).SelectedField.FieldName) > 0 then
      MessageDlg('Invalid number entered! Number must be >= 0 and <= 9. Press <ENTER> or click the cell to enter a valid value.', mtError, [mbOK], 0)
    else
      MessageDlg('"' + TDBGrid(Sender).SelectedField.AsString + '" is an invalid code for "' + TDBGrid(Sender).SelectedColumn.Title.Caption + '"! Press <ENTER> or click the cell to enter a valid lookup code. Alternatively press <F9>, select a lookup code and then <ENTER> to continue editing.', mtError, [mbOK], 0);
    TDBGrid(Sender).SelectedField.Clear;
    ValidFound := True;
    Abort;
  end;
end;

end.
