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
unit PMPIMPRT;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Clipbrd, ZDataset, StdCtrls, Forms,
  DBCtrls, DB, DBGrids, ExtCtrls, LCLType, Buttons, Menus, Dialogs,
  XMLPropStorage, EditBtn, DateTimePicker, SpinEx, rxlookup;

type

  { TPmpimprtForm }

  TPmpimprtForm = class(TForm)
    AccuDataSource: TDataSource;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    DBEditX: TDBEdit;
    DBEditY: TDBEdit;
    DBGrid: TDBGrid;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label11: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    LinkedTableINFO_SOURC: TStringField;
    Panel1: TPanel;
    BasicinfDataSource: TDataSource;
    Panel2: TPanel;
    Panel3: TPanel;
    LinkedDataSource: TDataSource;
    CloseBitBtn: TBitBtn;
    BitBtnHelp: TBitBtn;
    LinkedTable: TZTable;
    PmpigenTable: TZTable;
    PmpigenDataSource: TDataSource;
    EditNavigator: TDBNavigator;
    LinkedTableSITE_ID_NR: TStringField;
    LinkedTableDATE_MEAS: TStringField;
    LinkedTableTIME_MEAS: TStringField;
    LinkedTableMETH_MEAS: TStringField;
    LinkedTableLEVEL_STAT: TStringField;
    LinkedTablePIEZOM_NR: TStringField;
    LinkedTableDISCH_TYPE: TStringField;
    LinkedTableMETH_MEASD: TStringField;
    LinkedTableDISCH_RATE: TFloatField;
    LinkedTableCOMMENT: TStringField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DBEditDepth: TDBEdit;
    Label2: TLabel;
    LabelMeth: TLabel;
    LabelDepth: TLabel;
    Label5: TLabel;
    PmpigenTableCONTRACTOR: TStringField;
    PmpigenTableSITE_ID_NR: TStringField;
    PmpigenTableDATE_ENTRY: TStringField;
    PmpigenTableREP_INST: TStringField;
    PmpigenTableMETH_TESTD: TStringField;
    PmpigenTableDEPTH_INTK: TFloatField;
    PmpigenTableDATE_START: TStringField;
    PmpigenTableTIME_START: TStringField;
    PmpigenTableDATE_END: TStringField;
    PmpigenTableTIME_END: TStringField;
    LinkedTableWATER_LEV: TFloatField;
    GroupBox6: TGroupBox;
    CheckBoxDD: TCheckBox;
    ContractDataSource: TDataSource;
    RxDBLookupComboRepInst: TRxDBLookupCombo;
    RxDBLookupComboMethTest: TRxDBLookupCombo;
    RxDBLookupComboAcc: TRxDBLookupCombo;
    RxDBLookupComboContr: TRxDBLookupCombo;
    RxDBLookupComboType: TRxDBLookupCombo;
    SpinEditEx1: TSpinEditEx;
    WLLabel: TLabel;
    TypeDataSource: TDataSource;
    WLEdit: TEdit;
    LinkedTableTIME_SEC: TFloatField;
    BasicinfGroupBox7: TGroupBox;
    Label15: TLabel;
    EditSITE_ID_NR: TDBEdit;
    Label16: TLabel;
    EditNR_ON_MAP: TDBEdit;
    Label17: TLabel;
    EditFARM_NR: TDBEdit;
    Label18: TLabel;
    EditSITE_NAME: TDBEdit;
    XMLPropStorage1: TXMLPropStorage;
    Y_CoordLabel: TLabel;
    X_CoordLabel: TLabel;
    Label22: TLabel;
    AltitudeLabel: TLabel;
    EditALTITUDE: TDBEdit;
    CollarLabel: TLabel;
    EditCOLLAR_HI: TDBEdit;
    DepthLabel: TLabel;
    EditDEPTH: TDBEdit;
    Label25: TLabel;
    Label26: TLabel;
    EditDATE_UPDTD: TDBEdit;
    MethTestDataSource: TDataSource;
    RepInstDataSource: TDataSource;
    Label4: TLabel;
    Label10: TLabel;
    ImportQuery: TZQuery;
    DateQuery: TZReadOnlyQuery;
    ZReadOnlyQueryMethTest: TZReadOnlyQuery;
    ZReadOnlyQueryMethTestDESCRIBE: TStringField;
    ZReadOnlyQueryMethTestSEARCH: TStringField;
    ZReadOnlyQueryRepInst: TZReadOnlyQuery;
    ZReadOnlyQueryCoordAcc: TZReadOnlyQuery;
    ZReadOnlyQueryCoordAccDESCRIBE: TStringField;
    ZReadOnlyQueryCoordAccSEARCH: TStringField;
    ZReadOnlyQueryContractor: TZReadOnlyQuery;
    ZReadOnlyQueryRepInstDESCRIBE: TStringField;
    ZReadOnlyQueryRepInstDESCRIBE1: TStringField;
    ZReadOnlyQueryRepInstSEARCH: TStringField;
    ZReadOnlyQueryRepInstSEARCH1: TStringField;
    ZReadOnlyQuerySiteType: TZReadOnlyQuery;
    ZReadOnlyQueryTopoSetDESCRIBE3: TStringField;
    ZReadOnlyQueryTopoSetSEARCH3: TStringField;
    ZTablePumpTest: TZTable;
    procedure BasicinfDataSourceDataChange(Sender: TObject; Field: TField);
    procedure CheckBoxDDChange(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure DateTimePickerEnter(Sender: TObject);
    procedure DateTimePicker2Change(Sender: TObject);
    procedure EditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditYChange(Sender: TObject);
    procedure DBGridColExit(Sender: TObject);
    procedure DBGridGetCellHint(Sender: TObject; Column: TColumn;
      var AText: String);
    procedure DBGridMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure DBGridTitleClick(Column: TColumn);
    procedure DBPmpIgenEnter(Sender: TObject);
    procedure DBGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EditBasicinfEnter(Sender: TObject);
    procedure EditNavigatorClick(Sender: TObject; Button: TDBNavButtonType);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure ImportQueryAfterCancel(DataSet: TDataSet);
    procedure LinkedTableAfterInsert(DataSet: TDataSet);
    procedure LinkedTableAfterOpen(DataSet: TDataSet);
    procedure LinkedTableAfterPost(DataSet: TDataset);
    procedure LinkedTableBeforeInsert(DataSet: TDataset);
    procedure LinkedTableBeforePost(DataSet: TDataSet);
    procedure LinkedTableNewRecord(DataSet: TDataset);
    procedure LinkedTableDISCH_RATEGetText(Sender: TField;
      var aText: String; DisplayText: Boolean);
    procedure LinkedTableDISCH_RATESetText(Sender: TField;
      const aText: String);
    procedure LinkedTableDISCH_TYPESetText(Sender: TField;
      const aText: String);
    procedure LinkedTableMETH_MEASSetText(Sender: TField;
      const aText: String);
    procedure LinkedTableCOMMENTSetText(Sender: TField;
      const aText: String);
    procedure LinkedTablePostError(DataSet: TDataSet; E: EDatabaseError;
      var DataAction: TDataAction);
    procedure EditXChange(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: char);
    procedure DBGridEnter(Sender: TObject);
    procedure PmpigenTableAfterCancel(DataSet: TDataSet);
    procedure PmpigenTableAfterDelete(DataSet: TDataSet);
    procedure PmpigenTableAfterPost(DataSet: TDataSet);
    procedure PmpigenTableBeforeEdit(DataSet: TDataSet);
    procedure PmpigenTableBeforePost(DataSet: TDataSet);
    procedure PmpigenTablePostError(DataSet: TDataSet; E: EDatabaseError;
      var DataAction: TDataAction);
    procedure LinkedTableMETH_MEASValidate(Sender: TField);
    procedure LinkedTableDISCH_TYPEValidate(Sender: TField);
    procedure LinkedTableDATE_MEASValidate(Sender: TField);
    procedure LinkedTableTIME_MEASValidate(Sender: TField);
    procedure DBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RxDBLookupComboAccClick(Sender: TObject);
    procedure RxDBLookupComboClosePopup(Sender: TObject;
      SearchResult: boolean);
    procedure RxDBLookupComboSelect(Sender: TObject);
    procedure RxDBLookupComboMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure RxDBLookupComboTypeClick(Sender: TObject);
    procedure RxDBLookupComboBasicSelect(Sender: TObject);
    procedure SpinEditEx1Change(Sender: TObject);
    procedure SpinEditEx1Enter(Sender: TObject);
    procedure WLEditExit(Sender: TObject);
    procedure PmpigenTableNewRecord(DataSet: TDataset);
    procedure LinkedTableWATER_LEVGetText(Sender: TField;
      var aText: String; DisplayText: Boolean);
    procedure LinkedTableWATER_LEVSetText(Sender: TField;
      const aText: String);
    procedure LinkedTableLEVEL_STATSetText(Sender: TField;
      const aText: String);
    procedure LinkedTableLEVEL_STATValidate(Sender: TField);
    procedure LinkedTableMETH_MEASDSetText(Sender: TField;
      const aText: String);
    procedure LinkedTableMETH_MEASDValidate(Sender: TField);
    procedure LinkedTablePIEZOM_NRValidate(Sender: TField);
    procedure PmpigenTableDEPTH_INTKGetText(Sender: TField;
      var aText: String; DisplayText: Boolean);
    procedure PmpigenTableDEPTH_INTKSetText(Sender: TField;
      const aText: String);
    procedure DBEditDateExit(Sender: TObject);
    procedure DBEditTimeExit(Sender: TObject);
    procedure DBEditDateEndExit(Sender: TObject);
    procedure DBEditTimeEndExit(Sender: TObject);
    procedure BitBtnHelpClick(Sender: TObject);
    procedure CloseBitBtnClick(Sender: TObject);
    procedure WLEditKeyPress(Sender: TObject; var Key: char);

  private
    { private declarations }
    PrevDateTime: TDateTime; //, PrevTime,
    PrevMethod, PrevStatus, PrevPiez: ShortString;
    PrevType, PrevMethD: ShortString;
    ValidFound, PopupClosed: Boolean;
    StaticWl: Double;
    JumpFieldNr: Byte;
    col, row: LongInt;
    SelFieldName: ShortString;
    TheActiveDBEdit: TDBEdit;
    TheActiveRxDB: TRxDBLookupCombo;
    OldDateTime: TDateTime;
  public
    { public declarations }
  end;

var
  PmpimprtForm: TPmpimprtForm;

implementation

{$R *.lfm}

uses VARINIT, lookup, strdatetime, MainDataModule;

procedure TPmpimprtForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, False);
  //hardcode taborder
  EditCOLLAR_HI.TabOrder := 8;
  EditDEPTH.TabOrder := 9;
  RxDBLookupComboType.TabOrder := 10;
  LinkedTable.Open;
  PmpigenTable.Open;
  ZReadOnlyQueryCoordAcc.Open;
  ZReadOnlyQuerySiteType.Open;
  ZReadOnlyQueryContractor.Open;
  ZReadOnlyQueryRepInst.Open;
  ZReadOnlyQueryMethTest.Open;
  ValidFound := True;
end;

procedure TPmpimprtForm.EditBasicinfEnter(Sender: TObject);
begin
  if EditNavigator.DataSource <> BasicinfDataSource then
  begin
    if EditNavigator.DataSource.DataSet.State IN [dsInsert, dsEdit] then
      if MessageDlg('Changes to current record have not been posted and will be lost! Post record now?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then EditNavigator.DataSource.DataSet.Post
      else
        EditNavigator.DataSource.DataSet.Cancel;
    EditNavigator.DataSource := BasicinfDataSource;
    EditNavigator.VisibleButtons := [nbEdit,nbPost,nbCancel,nbRefresh];
    Editing := 'Editing: Basic information';
  end;
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

procedure TPmpimprtForm.EditNavigatorClick(Sender: TObject;
  Button: TDBNavButtonType);
begin
  case EditNavigator.DataSource.Tag of
    2: begin
         if TheActiveDBEdit <> NIL then
           TheActiveDBEdit.SetFocus
         else
         if TheActiveRxDB <> NIL then
           TheActiveRxDB.SetFocus;
       end;
    3: DBGrid.SetFocus;
  end;
end;

procedure TPmpimprtForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
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
end;

procedure TPmpimprtForm.BasicinfDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  CurrentSite := DataModuleMain.BasicinfQuerySITE_ID_NR.Value;
  if Showing then
  begin
    if CheckBoxDD.Checked then
    begin
      MessageDlg('You have moved to another site, which may make your Drawdown Mode and Static Water Level invalid! These have therefore been disabled.', mtWarning, [mbOK], 0);
      CheckBoxDD.Checked := False;
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
  EditCOLLAR_HI.Enabled := (DataModuleMain.BasicinfQuerySITE_TYPE.Value = 'B')
    or (DataModuleMain.BasicinfQuerySITE_TYPE.Value = 'D')
    or (DataModuleMain.BasicinfQuerySITE_TYPE.Value = 'W');
  EditDEPTH.Enabled := EditCOLLAR_HI.Enabled;
end;

procedure TPmpimprtForm.CheckBoxDDChange(Sender: TObject);
begin
  if CheckBoxDD.Checked then
  begin
    DBGrid.Columns[7].Title.Caption := 'Drawdown';
    Groupbox2.Caption := 'Drawdown [' + LengthUnit + ']';
    WLEdit.Enabled := True;
    if Showing then
    begin
      WLEdit.Text := FloatToStr(StaticWl);
      WLEdit.SetFocus;
    end;
  end
  else
  begin
    DBGrid.Columns[7].Title.Caption := 'Water lev.';
    Groupbox2.Caption := 'Water Level';
    StaticWl := 0;
    WLEdit.Text := FloatToStr(StaticWl);
    WLEdit.Enabled := False;
  end;
  LinkedTable.Refresh;
end;

procedure TPmpimprtForm.DateTimePicker1Change(Sender: TObject);
begin
  if DateTimePicker1.DateTime < DateTimePicker2.DateTime then
  begin
    if PmpigenTable.State IN [dsInsert, dsEdit] then
    begin
      PmpigenTableDATE_START.Value := FormatDateTime('YYYYMMDD', DateTimePicker1.Date);
      PmpigenTableTIME_START.Value := FormatDateTime('hhnn', DateTimePicker1.Time);
    end;
    DateTimePicker2.MinDate := DateTimePicker1.Date;
    OldDateTime := DateTimePicker1.DateTime;
  end
  else
  begin
    MessageDlg('Date/Time started must be before Date/Time ended!', mtError, [mbOK], 0);
    DateTimePicker1.DateTime := OldDateTime;
  end;
end;

procedure TPmpimprtForm.DateTimePickerEnter(Sender: TObject);
begin
  OldDateTime := DateTimePicker1.DateTime;
  EditNavigator.DataSource := PmpigenDataSource;
end;

procedure TPmpimprtForm.DateTimePicker2Change(Sender: TObject);
begin
  if PmpigenTable.State IN [dsInsert, dsEdit] then
  begin
    PmpigenTableDATE_END.Value := FormatDateTime('YYYYMMDD', DateTimePicker2.Date);
    PmpigenTableTIME_END.Value := FormatDateTime('hhnn', DateTimePicker2.Time);
  end;
end;

procedure TPmpimprtForm.EditKeyUp(Sender: TObject; var Key: Word;
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

procedure TPmpimprtForm.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssShift in Shift) and (Key = VK_Delete)
    and (BasicinfDataSource.DataSet.State in [dsEdit, dsInsert]) then
      BasicinfDataSource.DataSet.FindField((Sender as TDBEdit).DataField).Clear;
end;

procedure TPmpimprtForm.EditYChange(Sender: TObject);
begin
  //Set the edit mask of coordinate DBEdits
  if ShowDMS then
    (Sender as TDBEdit).EditMask := '00°00''00.00">L;1;_'
  else
    (Sender as TDBEdit).EditMask := '';
end;

procedure TPmpimprtForm.DBGridColExit(Sender: TObject);
begin
  if DBGrid.Focused and (not ValidFound) then
  begin
    if DBGrid.SelectedField.FieldName = 'PIEZOM_NR' then
      MessageDlg('Invalid number entered! Number must be >= 0 and <= 9.', mtError, [mbOK], 0)
    else
      MessageDlg('"' + DBGrid.SelectedField.AsString + '" is an invalid code for "' + DBGrid.SelectedColumn.Title.Caption + '"!', mtError, [mbOK], 0);
    if DBGrid.SelectedField.LookupKeyFields > '' then
    begin
      DBGrid.SelectedField.Clear;
      ValidFound := True;
      SelFieldName := DBGrid.SelectedField.FieldName;
    end;
    Abort;
  end;
end;

procedure TPmpimprtForm.DBGridGetCellHint(Sender: TObject; Column: TColumn;
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
    AText := 'Pumping Test Detail Information';
    (Sender as TDBGrid).ShowHint := False;
  end;
end;

procedure TPmpimprtForm.DBGridMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  TDBGrid(Sender).MouseToCell(X, Y, col, row);
end;

procedure TPmpimprtForm.DBGridTitleClick(Column: TColumn);
var c: Integer;
begin
  if JumpFieldNr = 0 then
  begin
    Column.Color := clBtnFace;
    JumpFieldNr := Column.Index;
  end
  else
  begin
    for c := 0 to DBGrid.Columns.Count - 1 do //reset all to white
      DBGrid.Columns[c].Color := clWindow;
    if Column.Index <> JumpFieldNr then //set to grey
    begin
      Column.Color := clBtnFace;
      JumpFieldNr := Column.Index;
    end
    else JumpFieldNr := 0;
  end;
end;

procedure TPmpimprtForm.DBPmpIgenEnter(Sender: TObject);
begin
  PopupClosed := False;
  if EditNavigator.DataSource <> PmpIgenDataSource then
  begin
    if EditNavigator.DataSource.DataSet.State IN [dsInsert, dsEdit] then
      if MessageDlg('Changes to current record have not been posted and will be lost! Post record now?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then EditNavigator.DataSource.DataSet.Post
      else EditNavigator.DataSource.DataSet.Cancel;
    EditNavigator.DataSource := PmpigenDataSource;
    EditNavigator.VisibleButtons := [nbInsert,nbDelete,nbEdit,nbPost,nbCancel,nbRefresh];
    Editing := 'Editing: Pumping test information';
  end;
  if Sender is TDBEdit then
  begin
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

procedure TPmpimprtForm.DBGridMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  TheCategory: ShortString;
begin
  DBGridEnter(Sender);
  if Button = mbRight then
  begin
    case DBGrid.SelectedField.Tag of
      1: TheCategory := 'OTHRMEAS';
      2: TheCategory := 'WLV_STAT';
      3: TheCategory := 'DISCTYPE';
      4: TheCategory := 'DISCMEAS';
    else exit;
    end; {of CASE}
    with TLookupForm.Create(Application) do
    begin
      LookupCategory := TheCategory;
      LookupValue := LinkedTable.FieldByName(DBGrid.SelectedField.FieldName).AsString;
      ShowModal;
      if ModalResult = mrOK then
      if LinkedTable.State IN [dsInsert, dsEdit] then
        LinkedTable.FieldByName(DBGrid.SelectedField.FieldName).AsString := LookupValue;
      Close;
    end;
  end;
end;

procedure TPmpimprtForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  RepInst: String;
  WLSaved, DischSaved, PTSaved, CloseAborted: Boolean;
  f: Integer;
begin
  CloseAborted := False;
  if LinkedTable.RecordCount > 0 then
  begin
    case MessageDlg('Do you want to save the pumping test data to the database?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          Screen.Cursor := crSQLWait;
          //do a few checks
          with ImportQuery do
          begin
            SQL.Clear;
            SQL.Add('SELECT * FROM pmpimprt WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
            Open;
            if ImportQuery.RecordCount = 0 then
              MessageDlg('There is no discharge and water level data to import which may prevent another import of data for the same pumping test!', mtInformation, [mbOk], 0);
            Close;
          end;
          //Get reporting institution
          with ImportQuery do
          begin
            SQL.Clear;
            SQL.Add('SELECT SITE_ID_NR, REP_INST FROM pmpigen WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
            Open;
            RepInst := FindField('REP_INST').AsString;
            Close;
          end;
          //Save data to database files
          //First waterlev
          WLSaved := False;
          with ImportQuery do
          begin
            SQL.Clear;
            SQL.Add('INSERT INTO waterlev (SITE_ID_NR, METH_MEAS, LEVEL_STAT, PIEZOM_NR, INFO_SOURC, DATE_MEAS, TIME_MEAS, TIME_SEC, WATER_LEV, COMMENT, NGDB_FLAG) SELECT SITE_ID_NR, METH_MEAS, LEVEL_STAT, PIEZOM_NR, INFO_SOURC, DATE_MEAS, TIME_MEAS, TIME_SEC, WATER_LEV, COMMENT, 8 FROM pmpimprt WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
            try
              ExecSQL;
              WLSaved := True;
            except
              on E:Exception do
              begin
                WLSaved := False;
                Screen.Cursor := crDefault;
                ShowMessage(E.Message + '. Water level data will not be saved!');
              end;
            end;
          end;
          //Then discharge
          if WLSaved then
          begin
            Screen.Cursor := crSQLWait;
            DischSaved := False;
            with ImportQuery do
            begin
              SQL.Clear;
              SQL.Add('INSERT INTO discharg (SITE_ID_NR, REP_INST, INFO_SOURC, DISCH_TYPE, METH_MEAS, DATE_MEAS, TIME_MEAS, DISCH_RATE, COMMENT, NGDB_FLAG) SELECT SITE_ID_NR, ' + QuotedStr(RepInst) + ', INFO_SOURC, DISCH_TYPE, METH_MEASD as METH_MEAS, DATE_MEAS, TIME_MEAS, DISCH_RATE, COMMENT, 8 FROM pmpimprt '
                + 'WHERE DISCH_RATE IS NOT NULL AND TIME_SEC = 0 AND SITE_ID_NR = ' + QuotedStr(CurrentSite));
              try
                ExecSQL;
                DischSaved := True;
              except
                on E:Exception do
                begin
                  DischSaved := False;
                  //Delete the saved water levels
                  DataModuleMain.ZConnectionDB.ExecuteDirect('DELETE FROM waterlev WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite) + ' AND NGDB_FLAG = 8');
                  Screen.Cursor := crDefault;
                  ShowMessage(E.Message + '. Discharge rate data will not be saved and already imported water level data removed!');
                end;
              end;
            end;
            Screen.Cursor := crDefault;
          end;
          //Last pumptest
          if WLSaved and DischSaved then
          begin
            Screen.Cursor := crSQLWait;
            PTSaved := False;
            ZTablePumpTest.Open;
            with ImportQuery do
            begin
              SQL.Clear;
              SQL.Add('SELECT * FROM pmpigen where SITE_ID_NR = ' + QuotedStr(CurrentSite));
              Open;
              try
                while not EOF do
                begin
                  ZTablePumpTest.Insert;
                  for f := 0 to FieldCount - 1 do
                    if (ZTablePumpTest.FindField(Fields[f].FieldName) <> NIL) and (Fields[f].FieldName <> 'id') then
                      ZTablePumpTest.FieldByName(Fields[f].FieldName).Value := Fields[f].Value;
                  ZTablePumpTest.FieldByName('NGDB_FLAG').Value := UpdtdFromPmpImprt;
                  ZTablePumpTest.Post;
                  Next;
                end;
                PTSaved := True;
                ZTablePumpTest.Close;
                Close;
                DataModuleMain.ZConnectionDB.ExecuteDirect('UPDATE pumptest SET NGDB_FLAG = ' + IntToStr(FinishedPmpImprt) + ' WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite) + ' AND NGDB_FLAG = ' + IntToStr(UpdtdFromPmpImprt));
                DataModuleMain.ZConnectionDB.ExecuteDirect('UPDATE discharg SET NGDB_FLAG = ' + IntToStr(FinishedPmpImprt) + ' WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite) + ' AND NGDB_FLAG = ' + IntToStr(UpdtdFromPmpImprt));
                DataModuleMain.ZConnectionDB.ExecuteDirect('UPDATE waterlev SET NGDB_FLAG = ' + IntToStr(FinishedPmpImprt) + ' WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite) + ' AND NGDB_FLAG = ' + IntToStr(UpdtdFromPmpImprt));
              except on E:Exception do
                begin
                  PTSaved := False;
                  ZTablePumpTest.Close;
                  Close;
                  //Delete from pumptest whatever has been imported already
                  DataModuleMain.ZConnectionDB.ExecuteDirect('DELETE FROM pumptest WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite) + ' AND NGDB_FLAG = ' + IntToStr(UpdtdFromPmpImprt));
                  //Delete the saved water levels and discharge rates if something goes wrong
                  DataModuleMain.ZConnectionDB.ExecuteDirect('DELETE FROM waterlev WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite) + ' AND NGDB_FLAG = ' + IntToStr(UpdtdFromPmpImprt));
                  DataModuleMain.ZConnectionDB.ExecuteDirect('DELETE FROM discharg WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite) + ' AND NGDB_FLAG = ' + IntToStr(UpdtdFromPmpImprt));
                  ShowMessage(E.Message + '. Pumping test data will not be saved and already imported discharge and water level data removed!');
                  Screen.Cursor := crDefault;
                end;
              end;
            end;
            Screen.Cursor := crDefault;
          end;
          if WLSaved and DischSaved and PTSaved then
          begin
            Screen.Cursor := crSQLWait;
            //Delete imported data from LinkedTable;
            DataModuleMain.ZConnectionDB.ExecuteDirect('DELETE FROM pmpimprt WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
            //Delete imported data from PmpigenTable;
            DataModuleMain.ZConnectionDB.ExecuteDirect('DELETE FROM pmpigen WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
            Screen.Cursor := crDefault;
            MessageDlg('Finished saving pumping test data to workspace.', mtInformation, [mbOk], 0);
          end
          else
          begin
            Screen.Cursor := crDefault;
            MessageDlg('One or more errors occurred while trying to save pumping test data to the database. Please make sure there are no duplicates and try again, as no data has been imported.',
              mtError, [mbOk], 0);
          end;
        end;
      mrCancel: begin
                  CloseAborted := True;
                  Abort;
                end;
      mrNo: ShowMessage('Data not saved to individual tables in the database. You can return later and chose "Yes" to save.');
    end;
  end; //of case
  if not CloseAborted then
  begin
    {Close all tables and form}
    LinkedTable.Close;
    PmpigenTable.Close;
    ZReadOnlyQueryCoordAcc.Close;
    ZReadOnlyQuerySiteType.Close;
    ZReadOnlyQueryContractor.Close;
    ZReadOnlyQueryRepInst.Close;
    Editing := 'Editing: <none>';
    EditSITE_ID_NR.Hint := CurrentSite;
    CloseAction := caFree;
  end;
end;

procedure TPmpimprtForm.FormActivate(Sender: TObject);
var
  i: Word;
begin
  DataModuleMain.BasicValidFound := True;
  AltitudeLabel.Caption := '&Altitude [' + LengthUnit + ']';
  CollarLabel.Caption := 'Co&llar [' + LengthUnit + ']';
  DepthLabel.Caption :=  'Dept&h [' + LengthUnit + ']';
  Groupbox1.Caption := 'Discharge Rate ' + DisUnit;
  WLLabel.Caption := 'Static water lvl. [' + LengthUnit + ']';
  LabelDepth.Caption := 'Depth to intake [' + LengthUnit + ']';
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
  LabelMeth.Width := 36;
  LabelMeth.Height := 26;
  LabelDepth.Width := 60;
  LabelDepth.height := 26;
  if PmpigenTable.Active then
    PmpigenTable.Refresh;
  if LinkedTable.Active then
    LinkedTable.Refresh;
  if DataModuleMain.BasicinfQueryNGDB_FLAG.Value = 9 then //convert LONGITUDE/LATITUDE to X_COORD/Y_COORD
  if MessageDlg('The geometry of the current site has changed. Do you want to update the coordinates in the database accordingly?', mtInformation, [mbYes, mbNo], 0) = mrYes then
  with DataModuleMain do
  begin
    UpdateCoordsWithCs2cs(BasicinfQueryLONGITUDE.AsString, BasicinfQueryLATITUDE.AsString, BasicinfQuerySITE_ID_NR.Value);
    BasicinfQuery.Refresh;
    ShowMessage('Site coordinates were updated from a changed geometry!');
  end;
end;

procedure TPmpimprtForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not (ActiveControl is TDBGrid) then
  begin
    if ssCtrl in Shift then
    case Key of
      VK_Right: DataModuleMain.ZQueryView.Next;
      VK_Left: DataModuleMain.ZQueryView.Prior;
      VK_F8: begin
               if (ActiveControl is TDBEdit) or (ActiveControl is TRxDBLookupCombo) then
               begin
                 if ActiveControl.Tag = 1 then
                   DataModuleMain.BasicinfQuery.Edit
                 else
                 if ActiveControl.Tag = 2 then
                   PmpigenTable.Edit;
               end;
             end;
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
      VK_F8: if DataModuleMain.BasicinfQuery.State IN [dsInsert, dsEdit] then
               DataModuleMain.BasicinfQuery.Post
             else
             if PmpigenTable.State IN [dsInsert, dsEdit] then
               PmpigenTable.Post;
      VK_ESCAPE: if DataModuleMain.BasicinfQuery.State IN [dsInsert, dsEdit] then
                   DataModuleMain.BasicinfQuery.Cancel
                 else
                 if PmpigenTable.State IN [dsInsert, dsEdit] then
                   PmpigenTable.Cancel;
    end; //of case
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

procedure TPmpimprtForm.FormShow(Sender: TObject);
var
  y, m, d, h, n: Word;
begin
  if PmpigenTable.RecordCount = 0 then //clear the drawdown mode
    CheckBoxDD.Checked := False
  else //set date/time of DateTimePickers
  begin
    y := StrToInt(LeftStr(PmpigenTableDATE_START.Value, 4));
    m := StrToInt(Copy(PmpigenTableDATE_START.Value, 5, 2));
    d := StrToInt(RightStr(PmpigenTableDATE_START.Value, 2));
    h := StrToInt(LeftStr(PmpigenTableTIME_START.Value, 2));
    n := StrToInt(RightStr(PmpigenTableTIME_START.Value, 2));
    DateTimePicker1.Date := EncodeDate(y, m, d);
    DateTimePicker1.Time := EncodeTime(h, n, 0, 0);
    y := StrToInt(LeftStr(PmpigenTableDATE_END.Value, 4));
    m := StrToInt(Copy(PmpigenTableDATE_END.Value, 5, 2));
    d := StrToInt(RightStr(PmpigenTableDATE_END.Value, 2));
    h := StrToInt(LeftStr(PmpigenTableTIME_END.Value, 2));
    n := StrToInt(RightStr(PmpigenTableTIME_END.Value, 2));
    DateTimePicker2.Date := EncodeDate(y, m, d);
    DateTimePicker2.Time := EncodeTime(h, n, 0, 0);
  end;
  if LinkedTable.RecordCount > 0 then //go to the last record in the grid
  begin
    EditNavigator.DataSource := LinkedDataSource;
    EditNavigator.VisibleButtons := [nbInsert,nbDelete,nbEdit,nbPost,nbCancel,nbRefresh];
    Editing := 'Editing: Pumping test time data';
    LinkedTable.Last;
    DBGrid.SetFocus;
  end
  else
  begin
    EditNavigator.DataSource := PmpigenDataSource;
    EditNavigator.VisibleButtons := [nbInsert,nbDelete,nbEdit,nbPost,nbCancel,nbRefresh];
    Editing := 'Editing: Pumping test information';
    RxDBLookupComboContr.SetFocus;
  end;
  if EditSITE_ID_NR.Hint <> CurrentSite then
    CheckBoxDD.Checked := False;
  if CheckBoxDD.Checked then
    Groupbox2.Caption := 'Drawdown [' + LengthUnit + ']'
  else
    Groupbox2.Caption := 'Water Level [' + LengthUnit + ']';
  if WLEdit.Text > '' then
  try
    StaticWl := StrToFloat(WLEdit.Text);
  except on EConvertError do
    StaticWl := 0;
  end;
end;

procedure TPmpimprtForm.ImportQueryAfterCancel(DataSet: TDataSet);
begin
  ValidFound := True;
end;

procedure TPmpimprtForm.LinkedTableAfterInsert(DataSet: TDataSet);
begin
  DBGrid.SetFocus;
end;

procedure TPmpimprtForm.LinkedTableAfterOpen(DataSet: TDataSet);
begin
  LinkedDataSource.AutoEdit := AutoEditData;
end;

procedure TPmpimprtForm.LinkedTableAfterPost(DataSet: TDataset);
begin
  ValidFound := True;
end;

procedure TPmpimprtForm.LinkedTableBeforeInsert(DataSet: TDataset);
begin
  if PmpigenTable.State IN [dsInsert, dsEdit] then
    PmpigenTable.Post;
  if PmpigenTable.RecordCount = 0 then
  begin
    MessageDlg('Please supply general Pumping Test info first!', mtError,
      [mbOk], 0);
    PmpigenTableREP_INST.FocusControl;
    Abort;
  end
  else
  begin
    if (PrevDateTime = 0) or (LinkedTableDATE_MEAS.IsNull) then
      PrevDateTime := StringToDate(PmpIgenTableDATE_START.Value) + StringToTime(PmpIgenTableTIME_START.Value)
    else
      PrevDateTime := StringToDate(LinkedTableDATE_MEAS.Value) + StringToTime(LinkedTableTIME_MEAS.Value);
    PrevMethod := LinkedTableMETH_MEAS.Value;
    PrevStatus := LinkedTableLEVEL_STAT.Value;
    PrevPiez := LinkedTablePIEZOM_NR.Value;
    PrevType := LinkedTableDISCH_TYPE.Value;
    PrevMethD := LinkedTableMETH_MEASD.Value;
  end;
end;

procedure TPmpimprtForm.LinkedTableBeforePost(DataSet: TDataSet);
begin
  LinkedTableINFO_SOURC.Value := 'F';
end;

procedure TPmpimprtForm.LinkedTableNewRecord(DataSet: TDataset);
begin
  if LinkedTable.RecordCount = 0 then
  begin
    LinkedTableDATE_MEAS.Value := PmpigenTableDATE_START.Value;
    LinkedTableTIME_MEAS.Value := PmpigenTableTIME_START.Value;
    LinkedTableTIME_SEC.Value := 0;
    LinkedTableLEVEL_STAT.Value := 'S';
    LinkedTablePIEZOM_NR.Value := '0';
    LinkedTableDISCH_TYPE.Value := 'P';
    LinkedTableMETH_MEASD.Value := 'C';
  end
  else
  begin
    LinkedTableTIME_MEAS.Value := FormatDateTime('hhnn', PrevDateTime
                + 1/1440 * SpinEditEx1.Value);
    LinkedTableDATE_MEAS.Value := FormatDateTime('YYYYMMDD', PrevDateTime
                + 1/1440 * SpinEditEx1.Value);
    LinkedTableTIME_SEC.Value := 0;
    LinkedTableMETH_MEAS.Value := PrevMethod;
    LinkedTableLEVEL_STAT.Value := PrevStatus;
    LinkedTablePIEZOM_NR.Value := PrevPiez;
    LinkedTableDISCH_TYPE.Value := PrevType;
    LinkedTableMETH_MEASD.Value := PrevMethD;
  end;
end;

procedure TPmpimprtForm.LinkedTableDISCH_RATEGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  if not LinkedTableDISCH_RATE.IsNull then
  begin
    if LinkedTableDISCH_RATE.Value = 0 then
      aText := '0.00'
    else
    if LinkedTableDISCH_RATE.Value * VolumeFactor * TimeFactor > 100000 then
      aText := FloatToStrF(LinkedTableDISCH_RATE.Value * VolumeFactor * TimeFactor, ffFixed, 15, 0)
    else
    if LinkedTableDISCH_RATE.Value * VolumeFactor * TimeFactor < 0.01 then
      aText := FloatToStrF(LinkedTableDISCH_RATE.Value * VolumeFactor * TimeFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(LinkedTableDISCH_RATE.Value * VolumeFactor * TimeFactor, ffFixed, 15, 2);
  end;
end;

procedure TPmpimprtForm.LinkedTableDISCH_RATESetText(Sender: TField;
  const aText: String);
begin
  if aText <> '' then
    LinkedTableDISCH_RATE.Value := StrToFloat(aText)/VolumeFactor/TimeFactor;
end;

procedure TPmpimprtForm.LinkedTableDISCH_TYPESetText(Sender: TField;
  const aText: String);
begin
  LinkedTableDISCH_TYPE.Value := UpperCase(aText);
end;

procedure TPmpimprtForm.LinkedTableMETH_MEASSetText(Sender: TField;
  const aText: String);
begin
  LinkedTableMETH_MEAS.Value := UpperCase(aText);
end;

procedure TPmpimprtForm.LinkedTableCOMMENTSetText(Sender: TField;
  const aText: String);
begin
  if AllowSmallChars then
    Sender.Value := aText
  else
    Sender.Value := UpperCase(aText);
end;

procedure TPmpimprtForm.LinkedTablePostError(DataSet: TDataSet;
  E: EDatabaseError; var DataAction: TDataAction);
begin
  ShowMessage(E.Message + '. Record will not be posted!');
  DataAction := daAbort;
end;

procedure TPmpimprtForm.EditXChange(Sender: TObject);
begin
  //Set the edit mask of coordinate DBEdits
  if ShowDMS then
    (Sender as TDBEdit).EditMask := '900°00''00.00">L;1;_'
  else
    (Sender as TDBEdit).EditMask := '';
end;

procedure TPmpimprtForm.EditKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in [#3]) then //<ctrl-c> copy
    DataModuleMain.CheckMaskEditInput(Key);
end;

procedure TPmpimprtForm.DBGridEnter(Sender: TObject);
begin
  if EditNavigator.DataSource <> LinkedDataSource then
  begin
    if EditNavigator.DataSource.DataSet.State IN [dsInsert, dsEdit] then
      if MessageDlg('Changes to current record have not been posted and will be lost! Post record now?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then EditNavigator.DataSource.DataSet.Post
      else
        EditNavigator.DataSource.DataSet.Cancel;
    EditNavigator.DataSource := LinkedDataSource;
    EditNavigator.VisibleButtons := [nbInsert,nbDelete,nbEdit,nbPost,nbCancel,nbRefresh];
    Editing := 'Editing: Pumping Test Data';
  end;
end;

procedure TPmpimprtForm.PmpigenTableAfterCancel(DataSet: TDataSet);
begin
  DateTimePicker1.ReadOnly := True;
  DateTimePicker2.ReadOnly := True;
end;

procedure TPmpimprtForm.PmpigenTableAfterDelete(DataSet: TDataSet);
begin
  LinkedTable.Refresh;
  DateTimePicker1.Date := now;
  DateTimePicker1.Time := StrToTime('06:00');
  DateTimePicker2.Date := now;
  DateTimePicker2.Time := StrToTime('12:00');
end;

procedure TPmpimprtForm.PmpigenTableAfterPost(DataSet: TDataSet);
begin
  Dataset.Refresh;
  DateTimePicker1.ReadOnly := True;
  DateTimePicker2.ReadOnly := True;
end;

procedure TPmpimprtForm.PmpigenTableBeforeEdit(DataSet: TDataSet);
begin
  DateTimePicker1.ReadOnly := False;
  DateTimePicker2.ReadOnly := False;
end;

procedure TPmpimprtForm.PmpigenTableBeforePost(DataSet: TDataSet);
begin
  if PopupClosed then
  begin
    PopupClosed := False;
    Abort;
  end;
end;

procedure TPmpimprtForm.PmpigenTablePostError(DataSet: TDataSet;
  E: EDatabaseError; var DataAction: TDataAction);
begin
  ShowMessage(E.Message + '. Record will not be posted!');
  DataAction := daAbort;
end;

procedure TPmpimprtForm.LinkedTableMETH_MEASValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('OTHRMEAS', Sender.AsString);
end;

procedure TPmpimprtForm.LinkedTableDISCH_TYPEValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('DISCTYPE', Sender.AsString);
end;

procedure TPmpimprtForm.LinkedTableDATE_MEASValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TPmpimprtForm.LinkedTableTIME_MEASValidate(Sender: TField);
begin
  if not ValidTime(Sender.Value) then ValidFound := False
  else ValidFound := True;
end;

procedure TPmpimprtForm.DBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  TheCategory: ShortString;
begin
  if (ssCtrl in Shift) then
  begin
    case Key of
      VK_F8: LinkedTable.Edit;
    end;
  end
  else
  case Key of
    VK_DELETE: if LinkedTable.State IN [dsInsert, dsEdit] then
                 if ssShift in Shift then
                   DBGrid.SelectedField.Clear;
    VK_F5: LinkedTable.Refresh;
    VK_F8: if LinkedTable.State IN [dsInsert, dsEdit] then LinkedTable.Post;
    VK_F9: begin
             case DBGrid.SelectedField.Tag of
               1: TheCategory := 'OTHRMEAS';
               2: TheCategory := 'WLV_STAT';
               3: TheCategory := 'DISCTYPE';
               4: TheCategory := 'DISCMEAS';
             else exit;
             end; {of CASE}
             with TLookupForm.Create(Application) do
             begin
               LookupCategory := TheCategory;
               LookupValue := LinkedTable.FieldByName(DBGrid.SelectedField.FieldName).AsString;
               ShowModal;
               if ModalResult = mrOK then
               if LinkedTable.State IN [dsInsert, dsEdit] then
                 LinkedTable.FieldByName(DBGrid.SelectedField.FieldName).AsString := LookupValue;
               Close;
             end;
           end;
    VK_F11: SpinEditEx1.Value := SpinEditEx1.Value + SpinEditEx1.Increment;
    VK_F12: SpinEditEx1.Value := SpinEditEx1.Value - SpinEditEx1.Increment;
    VK_TAB: if not (ssShift in Shift) and (DBGrid.SelectedIndex = 10) and (LinkedTable.State IN [dsInsert, dsEdit]) then
      LinkedTable.Post;
    VK_RETURN: if (DBGrid.SelectedIndex = DBGrid.Columns.Count - 1) then //is at the last visible column
               begin
                 LinkedTable.Append;
                 if JumpFieldNr > 0 then
                   DBGrid.SelectedIndex := JumpFieldNr
                 else
                   DBGrid.SelectedIndex := 1;
                 Key := 0;
               end
               else
               if JumpFieldNr > 0 then
               begin
                 LinkedTable.Append;
                 DBGrid.SelectedIndex := JumpFieldNr;
                 Key := 0;
               end;
      VK_DOWN: if JumpFieldNr > 0 then
               begin
                 LinkedTable.Append;
                 DBGrid.SelectedIndex := JumpFieldNr;
                 Key := 0;
               end;
  end; {of case}
end;

procedure TPmpimprtForm.RxDBLookupComboAccClick(Sender: TObject);
begin
  RxDBLookupComboAcc.SetFocus;
end;

procedure TPmpimprtForm.RxDBLookupComboClosePopup(Sender: TObject;
  SearchResult: boolean);
begin
  PopupClosed := True;
end;

procedure TPmpimprtForm.RxDBLookupComboSelect(Sender: TObject);
begin
  if (PmpigenTable.State <> dsEdit) and ((PmpigenTable.State <> dsInsert)
    and not PmpigenTable.FieldByName((Sender as TRxDBLookupCombo).DataField).IsNull) then
      (Sender as TRxDBLookupCombo).Text := (Sender as TRxDBLookupCombo).DataSource.DataSet.FieldByName((Sender as TRxDBLookupCombo).DataField).Value;
end;

procedure TPmpimprtForm.RxDBLookupComboMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  (Sender as TRxDBLookupCombo).Hint := DataModuleMain.TranslateCode((Sender as TRxDBLookupCombo).HelpKeyword, (Sender as TRxDBLookupCombo).Value);
end;

procedure TPmpimprtForm.RxDBLookupComboTypeClick(Sender: TObject);
begin
  RxDBLookupComboType.SetFocus;
end;

procedure TPmpimprtForm.RxDBLookupComboBasicSelect(Sender: TObject);
begin
  if (DataModuleMain.BasicinfQuery.State <> dsEdit)
    and (DataModuleMain.BasicinfQuery.State <> dsInsert)
      and not (Sender as TRxDBLookupCombo).DataSource.DataSet.FieldByName((Sender as TRxDBLookupCombo).DataField).IsNull then
        (Sender as TRxDBLookupCombo).Text := (Sender as TRxDBLookupCombo).DataSource.DataSet.FieldByName((Sender as TRxDBLookupCombo).DataField).Value;
end;

procedure TPmpimprtForm.SpinEditEx1Change(Sender: TObject);
begin
  if SpinEditEx1.Value < 10 then
    SpinEditEx1.Increment := 1
  else
  if SpinEditEx1.Value < 100 then
    SpinEditEx1.Increment := 5
  else
  if SpinEditEx1.Value >= 100 then
    SpinEditEx1.Increment := 10;
end;

procedure TPmpimprtForm.SpinEditEx1Enter(Sender: TObject);
begin
  if SpinEditEx1.Value < 10 then
    SpinEditEx1.Increment := 1
  else
  if SpinEditEx1.Value < 100 then
    SpinEditEx1.Increment := 5
  else
  if SpinEditEx1.Value >= 100 then
    SpinEditEx1.Increment := 10;
end;

procedure TPmpimprtForm.WLEditExit(Sender: TObject);
begin
  if WLEdit.Text <> '' then
  try
    StaticWl := StrToFloat(WLEdit.Text);
  except on E: EConvertError do
    begin
      MessageDlg('Invalid water level entered!', mtError, [mbOK], 0);
      WLEdit.Text := '0.00';
      WLEdit.SetFocus;
    end;
  end;
  LinkedTable.Refresh;
end;

procedure TPmpimprtForm.PmpigenTableNewRecord(DataSet: TDataset);
begin
  PmpigenTableREP_INST.Value := DataModuleMain.BasicinfQueryREP_INST.Value;
  DateTimePicker1.Date := now;
  DateTimePicker1.Time := StrToTime('06:00');
  DateTimePicker2.Date := now;
  DateTimePicker2.Time := StrToTime('12:00');
  DateTimePicker1.ReadOnly := False;
  DateTimePicker2.ReadOnly := False;
  PmpigenTableDATE_ENTRY.Value := FormatDateTime('YYYYMMDD', now);
  PmpigenTableDATE_START.Value := FormatDateTime('YYYYMMDD', now);
  PmpigenTableTIME_START.Value := '0600';
  PmpigenTableDATE_END.Value := FormatDateTime('YYYYMMDD', now);
  PmpigenTableTIME_END.Value := '1200';
end;

procedure TPmpimprtForm.LinkedTableWATER_LEVGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  if not LinkedTableWATER_LEV.IsNull then
  begin
    if (LinkedTableWATER_LEV.Value - StaticWl) * LengthFactor >= 1000 then
      aText := FloatToStrF((LinkedTableWATER_LEV.Value - StaticWl) * LengthFactor, ffFixed, 15, 1)
    else
      aText := FloatToStrF((LinkedTableWATER_LEV.Value - StaticWl) * LengthFactor, ffFixed, 15, 2)
  end;
end;

procedure TPmpimprtForm.LinkedTableWATER_LEVSetText(Sender: TField;
  const aText: String);
begin
  if aText <> '' then
    LinkedTableWATER_LEV.Value := (StaticWl + StrToFloat(aText))/LengthFactor;
end;

procedure TPmpimprtForm.LinkedTableLEVEL_STATSetText(Sender: TField;
  const aText: String);
begin
  LinkedTableLEVEL_STAT.Value := UpperCase(aText);
end;

procedure TPmpimprtForm.LinkedTableLEVEL_STATValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('WLV_STAT', Sender.AsString);
  if not ValidFound then
    MessageDlg('Invalid code entered!', mtError, [mbOK], 0);
end;

procedure TPmpimprtForm.LinkedTableMETH_MEASDSetText(Sender: TField;
  const aText: String);
begin
  LinkedTableMETH_MEASD.Value := UpperCase(aText);
end;

procedure TPmpimprtForm.LinkedTableMETH_MEASDValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('DISCMEAS', Sender.AsString);
end;

procedure TPmpimprtForm.LinkedTablePIEZOM_NRValidate(Sender: TField);
begin
  if (LinkedTablePIEZOM_NR.Value >= '0') and
     (LinkedTablePIEZOM_NR.Value <= '9') then
    ValidFound := True
  else
    ValidFound := False;
end;

procedure TPmpimprtForm.PmpigenTableDEPTH_INTKGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  if PmpigenTableDEPTH_INTK.Value <> 0 then
  begin
    if PmpigenTableDEPTH_INTK.Value * LengthFactor > 1000 then
      aText := FloatToStrF(PmpigenTableDEPTH_INTK.Value * LengthFactor, ffFixed, 15, 0)
    else
    if PmpigenTableDEPTH_INTK.Value * LengthFactor < 0.01 then
      aText := FloatToStrF(PmpigenTableDEPTH_INTK.Value * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(PmpigenTableDEPTH_INTK.Value * LengthFactor, ffFixed, 15, 2);
  end;
end;

procedure TPmpimprtForm.PmpigenTableDEPTH_INTKSetText(Sender: TField;
  const aText: String);
begin
  if aText <> '' then
    PmpigenTableDEPTH_INTK.Value := StrToFloat(aText)/LengthFactor;
end;

procedure TPmpimprtForm.DBEditDateExit(Sender: TObject);
begin
  if PmpigenTable.State IN [dsInsert, dsEdit] then
  if not ValidDate(PmpigenTableDATE_START.Value) then
  begin
    MessageDlg('Invalid date entered!', mtError, [mbOK], 0);
    PmpigenTableDATE_START.FocusControl;
  end;
end;

procedure TPmpimprtForm.DBEditTimeExit(Sender: TObject);
begin
  if PmpigenTable.State IN [dsInsert, dsEdit] then
  if not ValidTime(PmpigenTableTIME_START.Value) then
  begin
    MessageDlg('Invalid time entered!', mtError, [mbOK], 0);
    PmpigenTableTIME_START.FocusControl;
  end;
end;

procedure TPmpimprtForm.DBEditDateEndExit(Sender: TObject);
begin
  if PmpigenTable.State IN [dsInsert, dsEdit] then
  if not ValidDate(PmpigenTableDATE_END.Value) then
  begin
    MessageDlg('Invalid date entered!', mtError, [mbOK], 0);
    PmpigenTableDATE_END.FocusControl;
  end;
end;

procedure TPmpimprtForm.DBEditTimeEndExit(Sender: TObject);
begin
  if PmpigenTable.State IN [dsInsert, dsEdit] then
  if not ValidTime(PmpigenTableTIME_END.Value) then
  begin
    MessageDlg('Invalid time entered!', mtError, [mbOK], 0);
    PmpigenTableTIME_END.FocusControl;
  end;
end;
procedure TPmpimprtForm.BitBtnHelpClick(Sender: TObject);
begin
   DataModuleMain.OpenHelp(Sender);
end;

procedure TPmpimprtForm.CloseBitBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TPmpimprtForm.WLEditKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', '.', #8, #9]) then
    Key := #0;
end;

end.
