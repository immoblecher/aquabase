{ Copyright (C) 2019 Immo Blecher, immo@blecher.co.za

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
unit SQLForm;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, DBGrids,
  ZAbstractRODataset, ExtCtrls, StdCtrls, Buttons, ComCtrls, Db, fpstdexports,
  ZDataset, Menus, DBCtrls, XMLPropStorage, fpdataexporter, Clipbrd, Grids,
  RxDBGridPrintGrid, rxdbgrid, RxDBGridExportPdf, LCLType,
  RxSortZeos, RxDBGridExportSpreadSheet;

type

  { TSQLQueryForm }

  TSQLQueryForm = class(TForm)
    FPDataExporter: TFPDataExporter;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    RxDBGrid: TRxDBGrid;
    RxDBGridExportPDF1: TRxDBGridExportPDF;
    RxDBGridExportSpreadSheet1: TRxDBGridExportSpreadSheet;
    RxDBGridPrint1: TRxDBGridPrint;
    RxSortZeos1: TRxSortZeos;
    SpeedButtonNotes: TSpeedButton;
    Splitter1: TSplitter;
    SplitterBottom: TSplitter;
    StandardExportFormats: TStandardExportFormats;
    StatusBar1: TStatusBar;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    Memo1: TMemo;
    SplitterTop: TSplitter;
    TableListBox: TListBox;
    FieldListBox: TListBox;
    UnitListBox: TListBox;
    OperatorListBox: TListBox;
    TableLabel: TLabel;
    FieldLabel: TLabel;
    UnitLabel: TLabel;
    OperatorLabel: TLabel;
    SpeedButtonRunQuery: TSpeedButton;
    SpeedButtonClear: TSpeedButton;
    OpenSpeedButton: TSpeedButton;
    SaveSpeedButton: TSpeedButton;
    SearchQuery: TZQuery;
    OpenQueryDialog: TOpenDialog;
    SaveQueryDialog: TSaveDialog;
    QueryDataSource: TDataSource;
    HelpButton: TBitBtn;
    Label4: TLabel;
    StatementListBox: TListBox;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    DBNavigator1: TDBNavigator;
    XMLPropStorage: TXMLPropStorage;
    TableQuery: TZReadOnlyQuery;
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    procedure Memo1Click(Sender: TObject);
    procedure Memo1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Memo1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure QueryDataSourceDataChange(Sender: TObject; Field: TField);
    procedure SearchQueryAfterOpen(DataSet: TDataSet);
    procedure SpeedButtonNotesClick(Sender: TObject);
    procedure ListBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TableListBoxClick(Sender: TObject);
    procedure TableListBoxDblClick(Sender: TObject);
    procedure FieldListBoxDblClick(Sender: TObject);
    procedure UnitListBoxDblClick(Sender: TObject);
    procedure OperatorListBoxDblClick(Sender: TObject);
    procedure SpeedButtonClearClick(Sender: TObject);
    procedure SpeedButtonRunQueryClick(Sender: TObject);
    procedure OpenSpeedButtonClick(Sender: TObject);
    procedure SaveSpeedButtonClick(Sender: TObject);
    procedure StatementListBoxDblClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SearchQueryAfterClose(DataSet: TDataSet);
    procedure Memo1Change(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGridOnGetText(Sender: TField; var aText: string; DisplayText: Boolean);
  private
    { Private declarations }
    ThisSiteID, TheValue: ShortString;
  public
    { Public declarations }
  end;

var
  SQLQueryForm: TSQLQueryForm;

implementation

{$R *.lfm}

uses VARINIT, MainDataModule, notepad;

procedure TSQLQueryForm.DBGridOnGetText(Sender: TField; var aText: string; DisplayText: Boolean);
begin
  if (DisplayText) then aText := Sender.AsString;
end;

procedure TSQLQueryForm.FormCreate(Sender: TObject);
var
  i: Byte;
  ViewList, TempTableList: TStringList;
begin
  XMLPropStorage.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  TempTableList := TStringList.Create;
  ViewList := TStringList.Create;
  with DataModuleMain do
  begin
    ZConnectionDB.DbcConnection.GetMetadata.ClearCache;
    ZConnectionDB.GetTableNames('', TempTableList);
    TableListBox.Items.Assign(DataModuleMain.GetValidATables(TempTableList));
    GetValidATables(TempTableList).Free;
    GetAllViews(ZConnectionDB, ViewList);
  end;
  for i := 0 to ViewList.Count - 1 do //add all views
    TableListBox.Items.Add(ViewList[i]);
  TempTableList.Free;
  ViewList.Free;
  TableListBox.ItemIndex := 0;
  TableQuery.SQL.Clear;
  TableQuery.SQL.Add('SELECT * FROM ' + TableListBox.Items[0] + ' WHERE 1 <> 1');
  TableQuery.Open;
  TableQuery.GetFieldNames(FieldListBox.Items);
  TableQuery.Close;
end;

procedure TSQLQueryForm.DBGrid1CellClick(Column: TColumn);
begin
  TheValue := Column.Field.AsString;
end;

procedure TSQLQueryForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SearchQuery.Close;
  CloseAction := caFree;
end;

procedure TSQLQueryForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(HelpButton);
end;

procedure TSQLQueryForm.FormShow(Sender: TObject);
begin
  FieldLabel.Left := FieldListBox.Left;
  UnitLabel.Left := UnitListBox.Left;
  OperatorLabel.Left := OperatorListBox.Left;
end;

procedure TSQLQueryForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TSQLQueryForm.Memo1Click(Sender: TObject);
begin
  SpeedButtonRunQuery.Enabled := Memo1.Text > '';
  SaveSpeedButton.Enabled := Memo1.Text > '';
end;

procedure TSQLQueryForm.Memo1DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  if Source = StatementListBox then
    StatementListBoxDblClick(Sender)
  else
  if Source = TableListBox then
    TableListBoxDblClick(Sender)
  else
  if Source = FieldListBox then
    FieldListBoxDblClick(Sender)
  else
  if Source = UnitListBox then
    UnitListBoxDblClick(Sender)
  else
  if Source = OperatorListBox then
   OperatorListBoxDblClick(Sender);
end;

procedure TSQLQueryForm.Memo1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := (Source = StatementListBox)
    or (Source = TableListBox)
     or (Source = FieldListBox)
      or (Source = UnitListBox)
       or (Source = OperatorListBox);
end;

procedure TSQLQueryForm.Memo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Key=Ord('V'))and(ssCtrl in Shift)) then
  begin
    if Clipboard.HasFormat(CF_TEXT) then
      Memo1.SelText := ClipBoard.AsText;
    Key:=0;
    SpeedButtonRunQuery.Enabled := Memo1.Text > '';
    SaveSpeedButton.Enabled := Memo1.Text > '';
  end
  else
  if ((Key=Ord('C'))and(ssCtrl in Shift)) then
  begin
    Clipboard.AsText := Memo1.SelText;
    Key:=0;
  end
  else
  if ((Key=Ord('A'))and(ssCtrl in Shift)) then
  begin
    Memo1.SelectAll;
    Key:=0;
  end
  else
  if ((Key=Ord('X'))and(ssCtrl in Shift)) then
  begin
    Clipboard.AsText := Memo1.SelText;
    Memo1.SelText := '';
    Key:=0;
  end;
end;

procedure TSQLQueryForm.MenuItem1Click(Sender: TObject);
begin
  if not DataModuleMain.ZQueryView.Locate('SITE_ID_NR', ThisSiteID, []) then
    MessageDlg('This site was not found in the current view! You can reset the view to "allsites" and try again.', mtError, [mbOK], 0);
end;

procedure TSQLQueryForm.MenuItem2Click(Sender: TObject);
begin
  ClipBoard.AsText := TheValue;
end;

procedure TSQLQueryForm.PopupMenu1Popup(Sender: TObject);
begin
  MenuItem1.Enabled := RxDBGrid.DataSource.DataSet.FindField('SITE_ID_NR') <> NIL;
  MenuItem2.Enabled := RxDBGrid.SelectedField <> NIL;
end;

procedure TSQLQueryForm.QueryDataSourceDataChange(Sender: TObject; Field: TField);
begin
  if SearchQuery.FindField('SITE_ID_NR') <> NIL then
  begin
    if not SearchQuery.FieldByName('SITE_ID_NR').IsNull then
    begin
      ThisSiteID := SearchQuery.FieldByName('SITE_ID_NR').Value;
      MenuItem1.Enabled := True;
    end
    else
    MenuItem1.Enabled := False;
  end;
end;

procedure TSQLQueryForm.SearchQueryAfterOpen(DataSet: TDataSet);
var
  f: Integer;
begin
  RxDBGrid.Enabled := SearchQuery.Active;
  for f := 0 to SearchQuery.FieldCount -1 do
    if SearchQuery.Fields[f].DataType = ftFloat then
      TFloatField(SearchQuery.Fields[f]).DisplayFormat := '0.#####';
end;

procedure TSQLQueryForm.SpeedButtonNotesClick(Sender: TObject);
begin
  with TNotepadForm.Create(Application) do
  begin
    DBMemo.DataSource := QueryDataSource;
    DBMemo.ReadOnly := True;
    Show;
  end;
end;

procedure TSQLQueryForm.ListBoxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then
    (Sender as TListBox).BeginDrag(False, 10);
end;

procedure TSQLQueryForm.TableListBoxClick(Sender: TObject);
begin
  TableQuery.SQL.Clear;
  TableQuery.SQL.Add('SELECT * FROM ' + TableListBox.Items[TableListBox.ItemIndex] + ' WHERE 1<>1');
  TableQuery.Open;
  TableQuery.GetFieldNames(FieldListBox.Items);
  TableQuery.Close;
end;

procedure TSQLQueryForm.TableListBoxDblClick(Sender: TObject);
var TempStr: AnsiString;
    sStart: Integer;
begin
  TempStr := Memo1.Text;
  sStart := Memo1.SelStart;
  if Pos('SELECT', TempStr) > 0 then
  begin
    Insert(TableListBox.Items[TableListBox.ItemIndex] + ' t' + IntToStr(TableListBox.ItemIndex) + ' ', TempStr, Memo1.SelStart + 1);
    Memo1.Clear;
    Memo1.Text := TempStr;
    Memo1.SelStart := sStart + Length(TableListBox.Items[TableListBox.ItemIndex]) + Length(IntToStr(TableListBox.ItemIndex)) + 3
  end
  else
  begin
    Insert(TableListBox.Items[TableListBox.ItemIndex] + ' ', TempStr, Memo1.SelStart + 1);
    Memo1.Clear;
    Memo1.Text := TempStr;
    Memo1.SelStart := sStart + Length(TableListBox.Items[TableListBox.ItemIndex]) + Length(IntToStr(TableListBox.ItemIndex)) + 1;
  end;
  Memo1.SetFocus;
  SpeedButtonRunQuery.Enabled := Memo1.Text > '';
  SaveSpeedButton.Enabled := Memo1.Text > '';
end;

procedure TSQLQueryForm.FieldListBoxDblClick(Sender: TObject);
var TempStr: AnsiString;
    sStart: Integer;
begin
  TempStr := Memo1.Text;
  sStart := Memo1.SelStart;
  if Pos('SELECT', TempStr) > 0 then
  begin
    Insert('t' + IntToStr(TableListBox.ItemIndex) + '.' + FieldListBox.Items[FieldListBox.ItemIndex] + ' ', TempStr, Memo1.SelStart + 1);
    Memo1.Clear;
    Memo1.Text := TempStr;
    Memo1.SelStart := sStart + Length(FieldListBox.Items[FieldListBox.ItemIndex]) + Length(IntToStr(TableListBox.ItemIndex)) + 3;
  end
  else
  begin
    Insert(FieldListBox.Items[FieldListBox.ItemIndex] + ' ', TempStr, Memo1.SelStart + 1);
    Memo1.Clear;
    Memo1.Text := TempStr;
    Memo1.SelStart := sStart + Length(FieldListBox.Items[FieldListBox.ItemIndex]) + Length(IntToStr(TableListBox.ItemIndex)) + 1;
  end;
  Memo1.SetFocus;
  SpeedButtonRunQuery.Enabled := Memo1.Text > '';
  SaveSpeedButton.Enabled := Memo1.Text > '';
end;

procedure TSQLQueryForm.UnitListBoxDblClick(Sender: TObject);
var TempStr: AnsiString;
    UnitStr: String;
    sStart: Integer;
begin
  TempStr := Memo1.Text;
  UnitStr := '* ';
  case UnitListBox.ItemIndex of
  0: UnitStr := UnitStr + FloatToStr(LengthFactor);
  1: UnitStr := UnitStr + FloatToStr(VolumeFactor);
  2: UnitStr := UnitStr + FloatToStrF(VolumeFactor * TimeFactor, ffFixed, 10, 7);
  3: UnitStr := UnitStr + FloatToStr(DiamFactor);
  4: UnitStr := UnitStr + FloatToStr(ECFactor);
  5: if AsN then UnitStr := UnitStr + '1'
     else UnitStr := UnitStr + '4.4263724';
  6: if AsN then UnitStr := UnitStr + '1'
     else UnitStr := UnitStr + '1.28785367';
  end; {of case}
  sStart := Memo1.SelStart;
  Insert(UnitStr + ' ', TempStr, Memo1.SelStart + 1);
  Memo1.Clear;
  Memo1.Text := TempStr;
  Memo1.SelStart := sStart + Length(UnitStr) + 1;
  Memo1.SetFocus;
  SpeedButtonRunQuery.Enabled := Memo1.Text > '';
  SaveSpeedButton.Enabled := Memo1.Text > '';
end;

procedure TSQLQueryForm.OperatorListBoxDblClick(Sender: TObject);
var TempStr: AnsiString;
    sStart: Integer;
begin
  TempStr := Memo1.Text;
  sStart := Memo1.SelStart;
  Insert(OperatorListBox.Items[OperatorListBox.ItemIndex] + ' ', TempStr, Memo1.SelStart + 1);
  Memo1.Clear;
  Memo1.Text := TempStr;
  Memo1.SelStart := sStart + Length(OperatorListBox.Items[OperatorListBox.ItemIndex]) + 1;
  Memo1.SetFocus;
  SpeedButtonRunQuery.Enabled := Memo1.Text > '';
  SaveSpeedButton.Enabled := Memo1.Text > '';
end;

procedure TSQLQueryForm.SpeedButtonClearClick(Sender: TObject);
begin
  Memo1.Clear;
  SearchQuery.Close;
  SpeedButtonRunQuery.Enabled := False;
  StatusBar1.Panels[1].Text := '';
end;

procedure TSQLQueryForm.SpeedButtonRunQueryClick(Sender: TObject);
var
  c: Word;
begin
  SpeedButtonNotes.Enabled := False;
  StatusBar1.Panels[2].Text := '';
  SearchQuery.Close;
  SearchQuery.UnPrepare;
  StatusBar1.Panels[1].Text := '';
  try
    SearchQuery.Connection := DataModuleMain.ZConnectionDB;
    SearchQuery.SQL.Clear;
    SearchQuery.SQL.AddStrings(Memo1.Text);
    if Pos('SELECT', UpperCase(SearchQuery.SQL.Text)) = 1 then
    begin
      Screen.Cursor := crSQLWait;
      SearchQuery.Prepare;
      SearchQuery.Open;
      Screen.Cursor := crDefault;
      StatusBar1.Panels[0].Text := 'SQL query successful';
      if SearchQuery.RecordCount > 0 then
      begin
        StatusBar1.Panels[1].Text := IntToStr(SearchQuery.RecordCount) + ' record(s) found';
        SpeedButton3.Enabled := True;
      end
      else
        StatusBar1.Panels[1].Text := 'No record(s) found';
      if SearchQuery.FindField('NOTE_PAD') <> NIL then
      begin
        SpeedButtonNotes.Enabled := True;
        (SearchQuery.FieldByName('NOTE_PAD') as TBlobField).BlobType := ftMemo;
      end
      else
      begin
        SpeedButtonNotes.Enabled := False;
      end;
    end
    else
    begin
      if MessageDlg('This query might change data or table/database structures! Are you sure you want to continue?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        Screen.Cursor := crSQLWait;
        SearchQuery.Prepare;
        SearchQuery.ExecSQL;
        StatusBar1.Panels[0].Text := 'SQL query successful';
        StatusBar1.Panels[1].Text := 'No record(s) viewable';
      end
      else
      begin
        StatusBar1.Panels[0].Text := '';
        StatusBar1.Panels[1].Text := '';
      end;
    end;
  except on E: Exception do
    begin
      Screen.Cursor := crDefault;
      MessageDlg('Error in SQL query statement', E.Message + ' - Query could not be opened/executed.', mtError, [mbOK], 0);
      SpeedButtonRunQuery.Enabled := False;
      StatusBar1.Panels[0].Text := 'Error in SQL query statement!';
    end;
  end; //of try
  if RxDBGrid.Columns.Count > 0 then
  for c := 0 to RxDBGrid.Columns.Count - 1 do
    RxDBGrid.Columns[c].Title.Alignment:= taLeftJustify;
  Screen.Cursor := crDefault;
end;

procedure TSQLQueryForm.OpenSpeedButtonClick(Sender: TObject);
begin
  OpenQueryDialog.InitialDir := WSpaceDir;
  if OpenQueryDialog.Execute then
  begin
    SaveQueryDialog.Filename := OpenQueryDialog.FileName;
    Memo1.Clear;
    Memo1.Lines.LoadFromFile(OpenQueryDialog.FileName);
    StatusBar1.Panels[2].Text := 'SQL Query loaded';
    ShowMessage('Please fix aliases to correspond with new aliases when adding tables!');
    SpeedButtonRunQuery.Enabled := Memo1.Text > '';
    SaveSpeedButton.Enabled := Memo1.Text > '';
  end;
end;

procedure TSQLQueryForm.SaveSpeedButtonClick(Sender: TObject);
begin
  SaveQueryDialog.InitialDir := WSpaceDir;
  if SaveQueryDialog.Execute then
  begin
    Memo1.Lines.SaveToFile(SaveQueryDialog.FileName);
    OpenQueryDialog.Filename := SaveQueryDialog.FileName;
    StatusBar1.Panels[2].Text := 'SQL query saved';
  end;
end;

procedure TSQLQueryForm.StatementListBoxDblClick(Sender: TObject);
var TempStr: AnsiString;
    sStart: Integer;
begin
  TempStr := Memo1.Text;
  sStart := Memo1.SelStart;
  Insert(StatementListBox.Items[StatementListBox.ItemIndex] + ' ', TempStr, sStart + 1);
  Memo1.Clear;
  Memo1.Text := TempStr;
  Memo1.SelStart := sStart + Length(StatementListBox.Items[StatementListBox.ItemIndex]) + 1;
  Memo1.SetFocus;
  SpeedButtonRunQuery.Enabled := Memo1.Text > '';
  SaveSpeedButton.Enabled := Memo1.Text > '';
end;

procedure TSQLQueryForm.SpeedButton3Click(Sender: TObject);
begin
  StatusBar1.Panels[2].Text := '';
  if FPDataExporter.Execute then
    StatusBar1.Panels[2].Text := 'Query results successfully exported!';
end;


procedure TSQLQueryForm.SearchQueryAfterClose(DataSet: TDataSet);
begin
  SpeedButton3.Enabled := False;
end;

procedure TSQLQueryForm.Memo1Change(Sender: TObject);
begin
  SpeedButtonRunQuery.Enabled := Memo1.Text > '';
  SaveSpeedButton.Enabled := Memo1.Text > '';
end;

procedure TSQLQueryForm.SpeedButton4Click(Sender: TObject);
begin
  TableListBox.Clear;
  DataModuleMain.ZConnectionDB.DbcConnection.GetMetadata.ClearCache;
  DataModuleMain.ZConnectionDB.GetTableNames('', TableListBox.Items);
  TableListBox.ItemIndex := 0;
  TableQuery.SQL.Clear;
  TableQuery.SQL.Add('SELECT * FROM ' + TableListBox.Items[0] + ' LIMIT 1');
  TableQuery.Open;
  TableQuery.GetFieldNames(FieldListBox.Items);
  TableQuery.Close;
end;

procedure TSQLQueryForm.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

end.
