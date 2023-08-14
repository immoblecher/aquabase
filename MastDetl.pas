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
unit MastDetl;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Clipbrd, ZDataset, Math,
  StdCtrls, Forms, DBCtrls, DB, Grids, ExtCtrls, LCLType, Buttons, Menus,
  Dialogs, DBGrids, XMLPropStorage, rxlookup;

type

  { TMasterDetailForm }

  TMasterDetailForm = class(TForm)
    AccuDataSource: TDataSource;
    AltLabel: TLabel;
    BasicDBNavigator: TDBNavigator;
    ColLabel: TLabel;
    DBEditX: TDBEdit;
    DBEditY: TDBEdit;
    DBGrid: TDBGrid;
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
    MenuItemSetBookmark1: TMenuItem;
    MenuItemSetBookMark2: TMenuItem;
    MenuItemGotoBookmark1: TMenuItem;
    MenuItemGotoBookmark2: TMenuItem;
    MenuItemSetBookmarks: TMenuItem;
    Panel2: TPanel;
    Panel4: TPanel;
    PopupMenu1: TPopupMenu;
    RecordText: TStaticText;
    RxDBLookupComboAcc: TRxDBLookupCombo;
    RxDBLookupComboType: TRxDBLookupCombo;
    StaticText1: TStaticText;
    ViewNavigator: TDBNavigator;
    ChartSpeedButton: TSpeedButton;
    LinkedQuerySITE_ID_NR: TStringField;
    Panel1: TPanel;
    BasicinfDataSource: TDataSource;
    LinkedDataSource: TDataSource;
    CloseBitBtn: TBitBtn;
    BitBtnHelp: TBitBtn;
    TypeDataSource: TDataSource;
    XMLPropStorage: TXMLPropStorage;
    LinkedQuery: TZQuery;
    X_CoordLabel: TLabel;
    Y_CoordLabel: TLabel;
    ZReadOnlyQueryCoordAcc: TZReadOnlyQuery;
    ZReadOnlyQueryCoordAccDESCRIBE: TStringField;
    ZReadOnlyQueryCoordAccSEARCH: TStringField;
    ZReadOnlyQuerySiteType: TZReadOnlyQuery;
    ZReadOnlyQueryTopoSetDESCRIBE3: TStringField;
    ZReadOnlyQueryTopoSetSEARCH3: TStringField;
    procedure BasicDBNavigatorClick(Sender: TObject; Button: TDBNavButtonType);
    procedure BasicinfDataSourceDataChange(Sender: TObject; Field: TField);
    procedure EditYChange(Sender: TObject);
    procedure DBGridCellClick(Column: TColumn);
    procedure DBGridColExit(Sender: TObject);
    procedure DBGridGetCellHint(Sender: TObject; Column: TColumn;
      var AText: String);
    procedure DBGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGridMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure DBGridTitleClick(Column: TColumn);
    procedure DetailNavigatorBeforeAction(Sender: TObject;
      Button: TDBNavButtonType);
    procedure DetailNavigatorClick(Sender: TObject; Button: TDBNavButtonType);
    procedure EditClick(Sender: TObject);
    procedure EditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditResultsEditingDone(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure LinkedDataSourceDataChange(Sender: TObject; Field: TField);
    procedure LinkedDataSourceStateChange(Sender: TObject);
    procedure LinkedQueryAfterCancel(DataSet: TDataSet);
    procedure LinkedQueryAfterDelete(DataSet: TDataSet);
    procedure LinkedQueryAfterOpen(DataSet: TDataSet);
    procedure DBGridEnter(Sender: TObject);
    procedure EditBasicinfEnter(Sender: TObject);
    procedure LinkedQueryAfterPost(DataSet: TDataSet);
    procedure LinkedQueryAfterRefresh(DataSet: TDataSet);
    procedure LinkedQueryBeforeOpen(DataSet: TDataSet);
    procedure LinkedQueryBeforePost(DataSet: TDataSet);
    procedure LinkedQueryBeforeRefresh(DataSet: TDataSet);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryPostError(DataSet: TDataSet; E: EDatabaseError;
      var DataAction: TDataAction);
    procedure EditKeyPress(Sender: TObject; var Key: char);
    procedure EditXChange(Sender: TObject);
    procedure MenuItemSetBookMark2Click(Sender: TObject);
    procedure MenuItemGotoBookmark2Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure MenuItemGotoBookmark1Click(Sender: TObject);
    procedure RxDBLookupComboClick(Sender: TObject);
    procedure RxDBLookupComboMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure RxDBLookupComboSelect(Sender: TObject);
    procedure MenuItemSetBookmark1Click(Sender: TObject);
    procedure DBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtnHelpClick(Sender: TObject);
    procedure CloseBitBtnClick(Sender: TObject);
  private
    { private declarations }
    JumpFieldNr: Byte;
    row, col: LongInt;
  public
    { public declarations }
    ValidFound: Boolean;
    NotAllFields: Boolean; //NotAllFields shown in grid, e.g. geology and pumptest
    Elevation: Real;
    TheActiveDBEdit: TDBEdit;
    TheActiveRxDB: TRxDBLookupCombo;
    TheActiveDBMemo: TDBMemo;
  end;

  TDBNavigatorEx = class(TDBNavigator);

var
  MasterDetailForm: TMasterDetailForm;

implementation

uses VARINIT, MainDataModule, LOOKUP, selectSiteID;

{$R *.lfm}

procedure TMasterDetailForm.FormCreate(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  XMLPropStorage.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  TDBNavigatorEx(ViewNavigator).Buttons[nbRefresh].Enabled := TRUE ;
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
  GroupBox1.Caption := GrpBoxCaption;
  DataModuleMain.SetComponentFontAndSize(Sender, False);
  //hardcode taborder
  EditCOLLAR_HI.TabOrder := 8;
  EditDEPTH.TabOrder := 9;
  RxDBLookupComboType.TabOrder := 10;
  ValidFound := True;
  DataModuleMain.CoordsEdited := False;
  Screen.Cursor := crDefault;
end;

procedure TMasterDetailForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  with DataModuleMain do
  begin
    ZQueryView.FreeBookmark(Bookmark1);
    ZQueryView.FreeBookmark(Bookmark2);
    Editing := EditLabel + ' <none>';
  end;
  LinkedQuery.Close;
  ZReadOnlyQueryCoordAcc.Close;
  ZReadOnlyQuerySiteType.Close;
  CloseAction := caFree;
end;

procedure TMasterDetailForm.FormActivate(Sender: TObject);
var
  i: Word;
begin
  Screen.Cursor := crSQLWait;
  ChartSpeedButton.Enabled := LinkedQuery.RecordCount > 0;
  BasicinfDataSource.AutoEdit := AutoEditData;
  DataModuleMain.BasicValidFound := True;
  BitBtnHelp.Hint := 'Help on ' + Caption;
  DBGrid.Hint := Caption + ' Information';
  AltLabel.Caption := AltitudeLabel + ' [' + LengthUnit + ']';
  ColLabel.Caption := CollarLabel + ' [' + LengthUnit + ']';
  DepLabel.Caption := DepthLabel + ' [' + LengthUnit + ']';
  if DBGrid.Focused then
    Editing := EditLabel + ' ' + Caption
  else
    Editing := EditLabel + ' Basic information';
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
  LinkedLabel.Width := 320;
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

procedure TMasterDetailForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (not (ActiveControl is TDBGrid)) and (not (ActiveControl is TDBMemo)) then
  begin
    if ssCtrl in Shift then
      case key of
        VK_RIGHT: DataModuleMain.ZQueryView.Next;
        VK_LEFT: DataModuleMain.ZQueryView.Prior;
        VK_F6: with DataModuleMain do
                 if Assigned(Bookmark1) then ZQueryView.GotoBookmark(Bookmark1);
        VK_F7: with DataModuleMain do
                 if Assigned(Bookmark2) then ZQueryView.GotoBookmark(Bookmark2);
      end //of case
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
      VK_F8: if ssCtrl in Shift then
               DataModuleMain.BasicinfQuery.Edit
             else
               if DataModuleMain.BasicinfQuery.State IN [dsInsert, dsEdit] then
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

procedure TMasterDetailForm.FormShow(Sender: TObject);
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

procedure TMasterDetailForm.LinkedDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  RecordText.Caption := 'Record ' + IntToStr(LinkedQuery.RecNo) + ' out of ' + IntToStr(LinkedQuery.RecordCount);
end;

procedure TMasterDetailForm.LinkedDataSourceStateChange(Sender: TObject);
begin
  if DBGrid.DataSource.DataSet.Active then
  begin
    HasSelection := not DBGrid.SelectedField.IsNull;
    CanCut := DBGrid.DataSource.DataSet.State IN [dsEdit, dsInsert];
    CanPaste := DBGrid.DataSource.DataSet.State IN [dsEdit, dsInsert];
  end;
end;

procedure TMasterDetailForm.LinkedQueryAfterCancel(DataSet: TDataSet);
begin
  ValidFound := True;
end;

procedure TMasterDetailForm.LinkedQueryAfterDelete(DataSet: TDataSet);
begin
  ChartSpeedButton.Enabled := LinkedQuery.RecordCount > 1;
end;

procedure TMasterDetailForm.LinkedQueryAfterOpen(DataSet: TDataSet);
begin
  if LinkedQuery.Active then
  begin
    ChartSpeedButton.Enabled := LinkedQuery.RecordCount > 1;
    LinkedQuery.First;
    LinkedDataSource.AutoEdit := AutoEditData;
  end;
  Screen.Cursor := crDefault;
end;

procedure TMasterDetailForm.DBGridEnter(Sender: TObject);
begin
  if DataModuleMain.BasicinfQuery.State = dsEdit then
  begin
    if MessageDlg('Changes to Basic Information have not been posted and will be lost! Post record now?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then DataModuleMain.BasicinfQuery.Post
    else DataModuleMain.BasicinfQuery.Cancel;
  end;
  Editing := EditLabel + ' ' + Caption;
  HasSelection := not DBGrid.SelectedField.IsNull;
  CanCut := DBGrid.DataSource.DataSet.State IN [dsEdit, dsInsert];
  CanPaste := DBGrid.DataSource.DataSet.State IN [dsEdit, dsInsert];
end;

procedure TMasterDetailForm.EditBasicinfEnter(Sender: TObject);
begin
  if LinkedQuery.State IN [dsInsert, dsEdit] then
  begin
    if MessageDlg('Changes to current record have not been posted and will be lost! Post record now?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then LinkedQuery.Post
    else LinkedQuery.Cancel;
  end;
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
    TheActiveDBMemo := NIL;
  end;
end;

procedure TMasterDetailForm.LinkedQueryAfterPost(DataSet: TDataSet);
begin
  ValidFound := True;
  ChartSpeedButton.Enabled := LinkedQuery.RecordCount > 1;
end;

procedure TMasterDetailForm.LinkedQueryAfterRefresh(DataSet: TDataSet);
begin
  ChartSpeedButton.Enabled := LinkedQuery.RecordCount > 1;
  Screen.Cursor := crDefault;
end;

procedure TMasterDetailForm.LinkedQueryBeforeOpen(DataSet: TDataSet);
begin
  LinkedQuery.FetchRow := StrToInt(EditResults.Text);
  LinkedQuery.Params[0].AsString := CurrentSite;
end;

procedure TMasterDetailForm.LinkedQueryBeforePost(DataSet: TDataSet);
begin
  if not ValidFound then
  begin
    MessageDlg('You are trying to post a record with invalid values in the current field! Please TAB left or right to obtain reason for this error.', mtError, [mbOK], 0);
    DBGrid.SetFocus;
    Abort;
  end;
end;

procedure TMasterDetailForm.LinkedQueryBeforeRefresh(DataSet: TDataSet);
begin
  Screen.Cursor := crSQLWait;
end;

procedure TMasterDetailForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  LinkedQuerySITE_ID_NR.Value := CurrentSite;
  if LinkedQuery.FindField('REP_INST') <> NIL then
    LinkedQuery.FieldByName('REP_INST').Value := DataModuleMain.BasicinfQueryREP_INST.Value;
  if JumpFieldNr > 0 then
    DBGrid.SelectedField := LinkedQuery.Fields.Fields[JumpFieldNr]
  else
    DBGrid.SelectedField := LinkedQuery.Fields.Fields[1];
end;

procedure TMasterDetailForm.LinkedQueryPostError(DataSet: TDataSet;
  E: EDatabaseError; var DataAction: TDataAction);
begin
  ShowMessage(E.Message + '. Record will not be posted!');
  DataAction := daAbort;
end;

procedure TMasterDetailForm.EditKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in [#3]) then //<ctrl-c> copy
    DataModuleMain.CheckMaskEditInput(Key);
end;

procedure TMasterDetailForm.EditXChange(Sender: TObject);
begin
  //Set the edit mask of coordinate DBEdits
  if ShowDMS then
    (Sender as TDBEdit).EditMask := '900°00''00.00">L;1;_'
  else
    (Sender as TDBEdit).EditMask := '';
end;

procedure TMasterDetailForm.MenuItemSetBookMark2Click(Sender: TObject);
begin
  with DataModuleMain do
  begin
     ZQueryView.FreeBookmark(Bookmark2);
     Bookmark2 := ZQueryView.GetBookmark;
  end;
end;

procedure TMasterDetailForm.MenuItemGotoBookmark2Click(Sender: TObject);
begin
  with DataModuleMain do
    ZQueryView.GotoBookmark(Bookmark2);
end;

procedure TMasterDetailForm.PopupMenu1Popup(Sender: TObject);
begin
  MenuItemGotoBookmark1.Enabled := Assigned(DataModuleMain.Bookmark1);
  MenuItemGotoBookmark2.Enabled := Assigned(DataModuleMain.Bookmark2);
end;

procedure TMasterDetailForm.MenuItemGotoBookmark1Click(Sender: TObject);
begin
  with DataModuleMain do
    ZQueryView.GotoBookmark(Bookmark1);
end;

procedure TMasterDetailForm.RxDBLookupComboClick(Sender: TObject);
begin
  (Sender as TRxDBLookupCombo).SetFocus;
end;

procedure TMasterDetailForm.RxDBLookupComboMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  (Sender as TRxDBLookupCombo).Hint := DataModuleMain.TranslateCode((Sender as TRxDBLookupCombo).HelpKeyword, (Sender as TRxDBLookupCombo).Value);
end;

procedure TMasterDetailForm.RxDBLookupComboSelect(Sender: TObject);
begin
  if not (DataModuleMain.BasicinfQuery.State IN [dsInsert, dsEdit])
      and not (Sender as TRxDBLookupCombo).DataSource.DataSet.FieldByName((Sender as TRxDBLookupCombo).DataField).IsNull then
        (Sender as TRxDBLookupCombo).Text := (Sender as TRxDBLookupCombo).DataSource.DataSet.FieldByName((Sender as TRxDBLookupCombo).DataField).Value;
end;

procedure TMasterDetailForm.MenuItemSetBookmark1Click(Sender: TObject);
begin
  with DataModuleMain do
  begin
    ZQueryView.FreeBookmark(Bookmark1);
    Bookmark1 := ZQueryView.GetBookmark;
  end;
end;

procedure TMasterDetailForm.DBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  AppendNewRec: Boolean;
  TheCategory: ShortString;
begin
  AppendNewRec := False;
  TheCategory := '';
  case Key of
    VK_RETURN:
      begin
        if (DBGrid.SelectedIndex = DBGrid.Columns.Count - 1) then //is at the last visible column
          AppendNewRec := True
        else
        if NotAllFields and (DBGrid.SelectedIndex = DBGrid.Tag) then //for geology and pumping test: the grid tags have been set to 14 and 12 respectively (nr of columns)
            AppendNewRec := True;
        if AppendNewRec then
        begin
          LinkedQuery.Append;
          DBGrid.SelectedIndex := 1;
          Key := 0;
        end;
      end;
    VK_TAB: if not (ssShift in Shift) then //tab forward
            begin
              if (DBGrid.SelectedIndex = DBGrid.Columns.Count - 1) then //is at the last visible column and tabs right
                AppendNewRec := True
              else
              if NotAllFields and (DBGrid.SelectedIndex = DBGrid.Tag) then //for geology and pumping test: the grid tags have been set to 14 and 12 respectively (nr of columns)
                  AppendNewRec := True;
              if AppendNewRec then
              begin
                LinkedQuery.Append;
                DBGrid.SelectedIndex := 1;
                Key := 0;
              end;
            end;
    VK_DELETE: if LinkedQuery.State IN [dsInsert, dsEdit] then
                  if ssShift in Shift then
                    DBGrid.SelectedField.Clear;
    VK_F5: LinkedQuery.Refresh;
    VK_F8: if (ssCtrl in Shift) then
             LinkedQuery.Edit
           else
           if LinkedQuery.State IN [dsInsert, dsEdit] then
             LinkedQuery.Post;
    VK_F9: begin
             case DBGrid.SelectedField.Tag of
              99: DBGrid.SelectedField.Tag := 100; //reset the Observation Borehole field tag to default of 100
             100: begin
                    DBGrid.SelectedField.Tag := 99; //to prevent runnig this again after site selection
                    with TFormSelSiteID.Create(Application) do
                    begin
                      LookupSite := LinkedQuery.FieldByName(DBGrid.SelectedField.FieldName).AsString;
                      ShowModal;
                      if ModalResult = mrOK then
                      begin
                        if LinkedDataSource.AutoEdit then
                          LinkedQuery.Edit;
                        if LinkedQuery.State IN [dsInsert, dsEdit] then
                          LinkedQuery.FieldByName(DBGrid.SelectedField.FieldName).AsString := LookupSite;
                      end;
                      Close;
                    end;
                  end;
              else TheCategory := DBGrid.SelectedField.LookupKeyFields;
            end; //of F9 case
            if TheCategory > '' then //only the lookups
            with TLookupForm.Create(Application) do
            begin
              LookupCategory := TheCategory;
              LookupValue := LinkedQuery.FieldByName(DBGrid.SelectedField.FieldName).AsString;
              ShowModal;
              if ModalResult = mrOK then
              begin
                if LinkedDataSource.AutoEdit then
                LinkedQuery.Edit;
                if (LinkedQuery.State IN [dsInsert, dsEdit]) or LinkedDataSource.AutoEdit then
                  LinkedQuery.FieldByName(DBGrid.SelectedField.FieldName).AsString := LookupValue;
              end;
              Close;
            end;
          end;
  end; //of Key case
end;

procedure TMasterDetailForm.BitBtnHelpClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TMasterDetailForm.CloseBitBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TMasterDetailForm.DBGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  TheCategory: ShortString;
begin
  DBGridEnter(Sender);
  TheCategory := '';
  if Button = mbRight then
  begin
    case DBGrid.SelectedField.Tag of
     99: DBGrid.SelectedField.Tag := 100; //reset the Observation Borehole field tag to default of 100
    100: begin
           DBGrid.SelectedField.Tag := 99; //to prevent runnig this again after site selection
           with TFormSelSiteID.Create(Application) do
           begin
             LookupSite := LinkedQuery.FieldByName(DBGrid.SelectedField.FieldName).AsString;
             ShowModal;
             if ModalResult = mrOK then
             begin
               if LinkedDataSource.AutoEdit then
                 LinkedQuery.Edit;
               if LinkedQuery.State IN [dsInsert, dsEdit] then
                 LinkedQuery.FieldByName(DBGrid.SelectedField.FieldName).AsString := LookupSite;
             end;
             Close;
           end;
         end;
      else TheCategory := DBGrid.SelectedField.LookupKeyFields;
    end; {of CASE}
    if TheCategory > '' then //only the lookups
    with TLookupForm.Create(Application) do
    begin
      LookupCategory := TheCategory;
      LookupValue := LinkedQuery.FieldByName(DBGrid.SelectedField.FieldName).AsString;
      ShowModal;
      if ModalResult = mrOK then
      begin
        if LinkedDataSource.AutoEdit then
        LinkedQuery.Edit;
        if (LinkedQuery.State IN [dsInsert, dsEdit]) or LinkedDataSource.AutoEdit then
          LinkedQuery.FieldByName(DBGrid.SelectedField.FieldName).AsString := LookupValue;
      end;
      Close;
    end;
  end;
end;

procedure TMasterDetailForm.DBGridMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  TDBGrid(Sender).MouseToCell(X, Y, col, row);
end;

procedure TMasterDetailForm.DBGridTitleClick(Column: TColumn);
var c: Byte;
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

procedure TMasterDetailForm.DetailNavigatorBeforeAction(Sender: TObject;
  Button: TDBNavButtonType);
begin
  case Button of
    nbNext, nbPrior, nbFirst, nbLast: Screen.Cursor := crSQLWait;
  end; //of case
end;

procedure TMasterDetailForm.DetailNavigatorClick(Sender: TObject;
  Button: TDBNavButtonType);
begin
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
  if TheActiveDBMemo <> NIL then
    TheActiveDBMemo.SetFocus
  else
    DBGrid.SetFocus;
end;

procedure TMasterDetailForm.EditClick(Sender: TObject);
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

procedure TMasterDetailForm.EditKeyUp(Sender: TObject; var Key: Word;
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

procedure TMasterDetailForm.EditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (ssShift in Shift) and (Key = VK_Delete)
    and (BasicinfDataSource.DataSet.State in [dsEdit, dsInsert]) then
      BasicinfDataSource.DataSet.FindField((Sender as TDBEdit).DataField).Clear;
end;

procedure TMasterDetailForm.EditResultsEditingDone(Sender: TObject);
begin
  LinkedQuery.FetchRow := StrToInt(EditResults.Text);
  LinkedQuery.Refresh;
end;

procedure TMasterDetailForm.FormCloseQuery(Sender: TObject;
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
  if LinkedDataSource.DataSet.State IN [dsInsert, dsEdit] then
    case MessageDlg('Your Detail table information has not been posted. Do you want to post it now and close or continue editing?', mtWarning, [mbYes, mbNo, mbIgnore], 0) of
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
end;

procedure TMasterDetailForm.BasicinfDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  CurrentSite := DataModuleMain.BasicinfQuerySITE_ID_NR.Value;
  //close and open the tables
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

procedure TMasterDetailForm.EditYChange(Sender: TObject);
begin
  //Set the edit mask of coordinate DBEdits
  if ShowDMS then
    (Sender as TDBEdit).EditMask := '00°00''00.00">L;1;_'
  else
    (Sender as TDBEdit).EditMask := '';
end;

procedure TMasterDetailForm.DBGridCellClick(Column: TColumn);
begin
  HasSelection := not DBGrid.SelectedField.IsNull;
  CanCut := DBGrid.DataSource.DataSet.State IN [dsEdit, dsInsert];
  CanPaste := DBGrid.DataSource.DataSet.State IN [dsEdit, dsInsert];
end;

procedure TMasterDetailForm.BasicDBNavigatorClick(Sender: TObject;
  Button: TDBNavButtonType);
begin
  if TheActiveDBEdit <> NIL then
    TheActiveDBEdit.SetFocus
  else
  if TheActiveRxDB <> NIL then
    TheActiveRxDB.SetFocus;
end;

procedure TMasterDetailForm.DBGridColExit(Sender: TObject);
var
  UseYield: Boolean;
begin
  UseYield := False;
  if DBGrid.Focused and (not ValidFound) then
  with DBGrid.SelectedField do
  begin
    if FieldName = 'DEPTH_BOT' then
      MessageDlg('Depth-to-bottom must be greater than depth-to-top and less than the depth of hole! Press <ENTER> or click the cell to enter a valid value.', mtError, [mbOK], 0)
    else
    if FieldName = 'DEPTH_TOP' then
      MessageDlg('Depth-to-top must be less than depth-to-bottom! Press <ENTER> or click the cell to enter a valid value.', mtError, [mbOK], 0)
    else
    if FieldName = 'YIELD' then
    begin
      if MessageDlg('The progressive yield should be greater than the previous yield! Are you sure you want to keep this yield value?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        UseYield := True;
    end
    else
    if Pos('DATE', FieldName) > 0 then
      MessageDlg('Invalid date entered! Press <ENTER> or click the cell to enter a valid date (YYYYMMDD).', mtError, [mbOK], 0)
    else
    if Pos('TIME', FieldName) > 0 then
      MessageDlg('Invalid time entered! Press <ENTER> or click the cell to enter a valid time (HHMM).', mtError, [mbOK], 0)
    else
    if (FieldName = 'SITE_ID_NR')
      or (FieldName = 'OTHER_HOLE') then
        MessageDlg('Invalid site identifier entered! Press <ENTER> or click the cell to enter a valid site identifier.', mtError, [mbOK], 0)
    else
    if FieldName = 'PIEZOM_NR' then
      MessageDlg('Invalid number entered! Number must be >= 0 and <= 9. Press <ENTER> or click the cell to enter a valid value.', mtError, [mbOK], 0)
    else
    if Pos('OBS_HOLE', FieldName) > 0 then
       MessageDlg('This Site Identifier does not seem to exist in your database!', mtWarning, [mbOK], 0)
    else
      MessageDlg('"' + AsString + '" is an invalid code for "' + DBGrid.SelectedColumn.Title.Caption + '"! Press <ENTER> or click the cell to enter a valid lookup code. Alternatively press <F9>, select a lookup code and then <ENTER> to continue editing.', mtError, [mbOK], 0);
    ValidFound := True;
    if Pos('OBS_HOLE', FieldName) > 0 then
    begin
      if MessageDlg('Do you still want to use the non-existing Site Identifier (which does not make much sense)?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        Clear;
    end
    else
    if FieldName = 'YIELD' then
    begin
      if not UseYield then
      begin
        Clear;
        Abort;
      end;
    end
    else
    begin
      Clear;
      Abort;
    end;
  end;
end;

procedure TMasterDetailForm.DBGridGetCellHint(Sender: TObject; Column: TColumn;
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
    AText := Caption + ' Information';
    (Sender as TDBGrid).ShowHint := False;
  end;
end;

end.
