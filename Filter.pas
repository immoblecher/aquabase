{ Copyright (C) 2020 Immo Blecher, immo@blecher.co.za

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
unit Filter;

{$mode objfpc}{$H+}

interface

uses Classes, Graphics, Forms, Controls, Buttons, ZDataset, LCLType,
  StdCtrls, ExtCtrls, DBCtrls, DB, SysUtils, Clipbrd, Dialogs, ComCtrls,
  XMLPropStorage;

type

  { TFilterForm }

  TFilterForm = class(TForm)
    DropTableBitBtn: TBitBtn;
    EditTables: TMemo;
    FieldListBox: TListBox;
    Label1: TLabel;
    FieldLabel: TLabel;
    OperatorLabel: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    UnitLabel: TLabel;
    Memo1: TMemo;
    OperatorListBox: TListBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    SelectLabel: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    OpenSpeedButton: TSpeedButton;
    SaveSpeedButton: TSpeedButton;
    OpenQueryDialog: TOpenDialog;
    SaveQueryDialog: TSaveDialog;
    OkBtn: TBitBtn;
    CloseBtn: TBitBtn;
    BitBtnHelp: TBitBtn;
    ResetToAllBtn: TSpeedButton;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    StatusBar1: TStatusBar;
    TableListBox: TListBox;
    UnitListBox: TListBox;
    XMLPropStorage: TXMLPropStorage;
    SearchQuery: TZReadOnlyQuery;
    TableQuery: TZReadOnlyQuery;
    procedure CloseBtnClick(Sender: TObject);
    procedure EditTablesDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure EditTablesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FieldListBoxDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Memo1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Memo1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OperatorListBoxDblClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure OpenSpeedButtonClick(Sender: TObject);
    procedure SaveSpeedButtonClick(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
    procedure DropTableBitBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TableQueryBeforeOpen(DataSet: TDataSet);
    procedure UnitListBoxDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure TableListBoxClick(Sender: TObject);
    procedure TableListBoxDblClick(Sender: TObject);
    procedure SearchQueryBeforeOpen(DataSet: TDataSet);
    procedure ResetToAllBtnClick(Sender: TObject);
    procedure EditTablesChange(Sender: TObject);
    procedure BitBtnHelpClick(Sender: TObject);
  private
    { Private declarations }
    TableList: TStringList;
    Name_Filter: String;
  public
    { Public declarations }
  end;

var
  FilterForm: TFilterForm;

implementation

{$R *.lfm}

uses MainDataModule, VARINIT, ProvideViewName;

procedure TFilterForm.FieldListBoxDblClick(Sender: TObject);
var TempStr: String;
    sStart: Integer;
begin
  TempStr := Memo1.Text;
  sStart := Memo1.SelStart;
  Insert('t' + IntToStr(TableListBox.ItemIndex) + '.' + FieldListBox.Items[FieldListBox.ItemIndex] + ' ', TempStr, Memo1.SelStart + 1);
  Memo1.Clear;
  Memo1.Text := TempStr;
  Memo1.SelStart := sStart + Length(FieldListBox.Items[FieldListBox.ItemIndex]) + Length(IntToStr(TableListBox.ItemIndex)) + 3;
  Memo1.SetFocus;
end;

procedure TFilterForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    BitBtnHelpClick(BitBtnHelp);
end;

procedure TFilterForm.FormShow(Sender: TObject);
begin
  FieldLabel.Left := FieldListBox.Left;
  UnitLabel.Left := UnitListBox.Left;
  OperatorLabel.Left := OperatorListBox.Left;
end;

procedure TFilterForm.Memo1DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  if Source = FieldListBox then
    FieldListBoxDblClick(Sender)
  else
  if Source = UnitListBox then
    UnitListBoxDblClick(Sender)
  else
  if Source = OperatorListBox then
   OperatorListBoxDblClick(Sender);
end;

procedure TFilterForm.Memo1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := (Source = FieldListBox) or (Source = UnitListBox) or (Source = OperatorListBox);
end;

procedure TFilterForm.Memo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Key=Ord('V'))and(ssCtrl in Shift)) then
  begin
    if Clipboard.HasFormat(CF_TEXT) then
      Memo1.SelText := ClipBoard.AsText;
    Key:=0;
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

procedure TFilterForm.CloseBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TFilterForm.EditTablesDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  TableListBoxDblClick(Sender);
end;

procedure TFilterForm.EditTablesDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source = TableListBox;
end;

procedure TFilterForm.OperatorListBoxDblClick(Sender: TObject);
var TempStr: String;
    sStart: Integer;
begin
  TempStr := Memo1.Text;
  sStart := Memo1.SelStart;
  Insert(OperatorListBox.Items[OperatorListBox.ItemIndex] + ' ', TempStr, Memo1.SelStart + 1);
  Memo1.Clear;
  Memo1.Text := TempStr;
  Memo1.SelStart := sStart + Length(OperatorListBox.Items[OperatorListBox.ItemIndex]) + 1;
  Memo1.SetFocus;
end;

procedure TFilterForm.SpeedButton2Click(Sender: TObject);
begin
  OKBtn.Enabled := False;
  TableList.Clear;
  Memo1.Clear;
  EditTables.Clear;
end;

procedure TFilterForm.SpeedButton1Click(Sender: TObject);

var NoError: Boolean;

begin
  Screen.Cursor := crSQLWait;
  SearchQuery.Close;
  NoError := False;
  try
    SearchQuery.Open;
    Screen.Cursor := crDefault;
    NoError := True;
    if SearchQuery.RecordCount = 0 then
    begin
      MessageDlg('No record found matching query.', mtWarning, [mbOk], 0);
      StatusBar1.Panels[0].Text := 'No records found';
      OKBtn.Enabled := False;
    end
    else
    begin
      OKBtn.Enabled := True;
      SaveSpeedButton.Enabled := True;
      StatusBar1.Panels[0].Text := IntToStr(SearchQuery.RecordCount) + ' record(s) found';
      MessageDlg(IntToStr(SearchQuery.RecordCount) + ' record(s) found! Click "Create" to create a view from this query.', mtInformation, [mbOK], 0);
    end;
  finally
    Screen.Cursor := crDefault;
    if not NoError then
      StatusBar1.Panels[0].Text := 'Error in SQL query statement';
  end; //of try
end;

procedure TFilterForm.Memo1Change(Sender: TObject);
begin
  OkBtn.Enabled := False;
  SaveSpeedButton.Enabled := False;
  StatusBar1.Panels[1].Text := 'SQL Query not saved';
end;

procedure TFilterForm.OpenSpeedButtonClick(Sender: TObject);

var WherePos, l: Integer;
    TableStr, SubStr: String;

begin
  if OpenQueryDialog.Execute then
  begin
    WherePos := 0;
    SearchQuery.SQL.Clear;
    SearchQuery.SQL.LoadfromFile(OpenQueryDialog.FileName);
    SaveQueryDialog.Filename := OpenQueryDialog.FileName;
    EditTables.Clear;
    Memo1.Clear;
    for l := 1 to SearchQuery.SQL.Count - 1 do
      if Pos('WHERE', SearchQuery.SQL.Strings[l]) > 0 then WherePos := l;
    for l := 1 to WherePos - 1 do
      EditTables.Lines.Add(SearchQuery.SQL.Strings[l]);
    for l := WherePos + 1 to SearchQuery.SQL.Count - 1 do
      Memo1.Lines.Add(SearchQuery.SQL.Strings[l]);
    //fix TableList
    SubStr := EditTables.Text;
    while SubStr <> '' do
    begin
      if Pos(',', SubStr) > 0 then
      begin
        TableStr := Copy(Substr, 1, Pos(',', SubStr) -1);
        SubStr := Copy(SubStr, Length(TableStr) + 2, Length(SubStr));
      end
      else
      begin
        TableStr := Copy(Substr, 1, Length(Substr));
        SubStr := '';
      end;
      while TableStr[1] = ' ' do Delete(TableStr, 1, 1);
      TableList.Add(TableStr);
    end;
    StatusBar1.Panels[1].Text := 'SQL Query loaded';
    MessageDlg('Please fix aliases to correspond with new aliases when adding tables!',
      mtInformation, [mbOK, mbHelp], 0);
  end;
end;

procedure TFilterForm.SaveSpeedButtonClick(Sender: TObject);
begin
  if SaveQueryDialog.Execute then
  begin
    SearchQuery.SQL.SaveToFile(SaveQueryDialog.FileName);
    MessageDlg('SQL query saved to file' + SaveQueryDialog.FileName + '!', mtInformation, [mbOK], 0);
  end;
end;

procedure TFilterForm.OkBtnClick(Sender: TObject);
var
  NewViewName: String;
  ViewCreated: Boolean;
begin
  with TProvideViewNameForm.Create(Application) do
  begin
    if ShowModal = mrOK then
    begin
      NewViewName := ViewName;
      if DataModuleMain.ZConnectionDB.Tag = 1 then
      begin
        DataModuleMain.ZConnectionDB.ExecuteDirect('DROP VIEW IF EXISTS [' + NewViewName + '];');
        DataModuleMain.ZConnectionDB.ExecuteDirect('CREATE VIEW [' +
          NewViewName + '] AS ' + SearchQuery.SQL.GetText);
        ViewCreated := True;
      end
      else
      if DataModuleMain.ZConnectionDB.Tag = 5 then
      begin
        DataModuleMain.ZConnectionDB.ExecuteDirect('IF OBJECT_ID('+ QuotedStr(NewViewName) + ', ''V'') IS NOT NULL DROP VIEW ' + NewViewName);
        DataModuleMain.ZConnectionDB.ExecuteDirect('CREATE VIEW ' +
          NewViewName + ' AS ' + SearchQuery.SQL.GetText);
        ViewCreated := True;
      end
      else
      begin
        try
          DataModuleMain.ZConnectionDB.ExecuteDirect('CREATE OR REPLACE VIEW ' +
            NewViewName + ' AS ' + SearchQuery.SQL.GetText);
          ViewCreated := True;
        except on E: Exception do
          MessageDlg(E.Message + ': You may have to select a different name for the View. Alternatively ask your administrator for permissions.', mtError, [mbOK], 0);
        end;
        if ViewCreated and CheckBox1.Checked then
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
      if ViewCreated and (MessageDlg('Do you want to set "' + NewViewName + '" as new view now? This may result in viewing a subset of your data.',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
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
      MessageDlg('Create View cancelled! No View created!', mtInformation, [mbOK],0);
  end;
end;

procedure TFilterForm.DropTableBitBtnClick(Sender: TObject);

var
  m: Integer;

begin
  if TableList.Count -1 > 0 then TableList.Delete(TableList.Count -1);
  EditTables.Lines.Clear;
  EditTables.Lines.Add(TableList[0]);
  for m := 1 to TableList.Count-1 do
  begin
    EditTables.Lines[m-1] := EditTables.Lines[m-1] + ',';
    EditTables.Lines.Add(TableList[m]);
  end;
end;

procedure TFilterForm.FormCreate(Sender: TObject);
var i: Integer;
begin
  XMLPropStorage.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  with DataModuleMain do
  begin
    SetComponentFontAndSize(Sender, True);
    ZConnectionDB.DbcConnection.GetMetadata.ClearCache;
    ZConnectionDB.GetTableNames('', TableListBox.Items); //get all tables
    with CheckQuery do
    begin
      Connection := ZConnectionSettings;
      SQL.Clear;
      SQL.Add('select FILE_NAME from Aquasort');
      Open;
      for i := TableListBox.Count - 1 downto 0 do //check if tables are in Aquasort, otherwise delete from list
        if not Locate('FILE_NAME', UpperCase(TableListBox.Items[i]), []) then
          TableListBox.Items.Delete(i);
      Close;
      Connection := ZConnectionDB;
    end;
  end;
  EditTables.WordWrap := False;
  TableListBox.ItemIndex := 0;
  TableQuery.SQL.Clear;
  TableQuery.SQL.Add('SELECT * FROM ' + TableListBox.Items[0] + ' WHERE 1 <> 1');
  TableQuery.Open;
  TableQuery.GetFieldNames(FieldListBox.Items);
  TableQuery.Close;
  TableList := TStringList.Create;
  Name_Filter := 'allsites';
end;

procedure TFilterForm.ListBoxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then
    (Sender as TListBox).BeginDrag(False, 10);
end;

procedure TFilterForm.TableQueryBeforeOpen(DataSet: TDataSet);
begin
  TableQuery.Connection := DataModuleMain.ZConnectionDB;
end;

procedure TFilterForm.UnitListBoxDblClick(Sender: TObject);
var TempStr, UnitStr: String;
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
  Insert(UnitStr +  ' ', TempStr, Memo1.SelStart + 1);
  Memo1.Clear;
  Memo1.Text := TempStr;
  Memo1.SelStart := sStart + Length(UnitStr) + 1;
  Memo1.SetFocus;
end;

procedure TFilterForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  TableList.Free;
  CloseAction := caFree;
end;

procedure TFilterForm.TableListBoxClick(Sender: TObject);
begin
  TableQuery.SQL.Clear;
  TableQuery.SQL.Add('SELECT * FROM ' + TableListBox.Items[TableListBox.ItemIndex] + ' WHERE 1<>1');
  TableQuery.Open;
  TableQuery.GetFieldNames(FieldListBox.Items);
  TableQuery.Close;
end;

procedure TFilterForm.TableListBoxDblClick(Sender: TObject);

var
  m, ndx, sStart: Integer;
  S, TempStr: String;

begin
  S := TableListBox.Items[TableListBox.ItemIndex] + ' t' + IntToStr(TableListBox.ItemIndex);
  TempStr := Memo1.Text;
  sStart := Memo1.SelStart;
  if FieldListBox.Items.IndexOf('SITE_ID_NR') > -1 then
    Insert('(f.SITE_ID_NR = t' + IntToStr(TableListBox.ItemIndex) + '.SITE_ID_NR) AND ', TempStr, Memo1.SelStart + 1)
  else
  if FieldListBox.Items.IndexOf('CHM_REF_NR') > -1 then
  begin //determine position of CHEM_000
    ndx := TableListBox.Items.IndexOf('chem_000');
    if Pos('chem_000', EditTables.Text) > 0 then
      Insert('(t' + IntToStr(ndx) + '.CHM_REF_NR = t' + IntToStr(TableListBox.ItemIndex) + '.CHM_REF_NR) AND ', TempStr, Memo1.SelStart + 1)
    else //add chem_000
    begin
      TableList.Add('chem_000 t' + IntToStr(TableListBox.Items.IndexOf('chem_000')));
      Insert('(f.SITE_ID_NR = t' + IntToStr(ndx) + '.SITE_ID_NR) AND (t' + IntToStr(ndx) + '.CHM_REF_NR = t' + IntToStr(TableListBox.ItemIndex) + '.CHM_REF_NR) AND ', TempStr, Memo1.SelStart + 1);
    end;
  end
  else
  if FieldListBox.Items.IndexOf('PRO_REF_NR') > -1 then
  begin //for project tables
    ndx := 0;
    for m := 0 to TableListBox.Items.Count -1 do
      if Pos('bhsiting', LowerCase(TableListBox.Items[m])) > 0 then ndx := m;
    if Pos('bhsiting', EditTables.Text) > 0 then
      Insert('(t' + IntToStr(ndx) + '.PRO_REF_NR = t' + IntToStr(TableListBox.ItemIndex) + '.PRO_REF_NR) AND ', TempStr, Memo1.SelStart + 1)
    else //add bhsiting
    begin
      TableList.Add('bhsiting t' + IntToStr(TableListBox.Items.IndexOf('bhsiting')));
      Insert('(f.SITE_ID_NR = t' + IntToStr(ndx) + '.SITE_ID_NR) AND (t' + IntToStr(ndx) + '.PRO_REF_NR = t' + IntToStr(TableListBox.ItemIndex) + '.PRO_REF_NR) AND ', TempStr, Memo1.SelStart + 1);
    end;
  end
  else if FieldListBox.Items.IndexOf('TRAV_NR') > -1 then
  begin //for geophysics tables
    ndx := 0;
    for m := 0 to TableListBox.Items.Count -1 do
      if Pos('recgeoph', LowerCase(TableListBox.Items[m])) > 0 then ndx := m;
    if Pos('recgeoph', EditTables.Text) > 0 then
      Insert('(t' + IntToStr(ndx) + '.TRAV_NR = t' + IntToStr(TableListBox.ItemIndex) + '.TRAV_NR) AND ', TempStr, Memo1.SelStart + 1)
    else //add recgeoph
    begin
      TableList.Add('recgeoph t' + IntToStr(TableListBox.Items.IndexOf('recgeoph')));
      Insert('(f.SITE_ID_NR = t' + IntToStr(ndx) + '.SITE_ID_NR) AND (t' + IntToStr(ndx) + '.TRAV_NR = t' + IntToStr(TableListBox.ItemIndex) + '.TRAV_NR) AND ', TempStr, Memo1.SelStart + 1)
    end;
  end
  else if FieldListBox.Items.IndexOf('REPORT_NR') > -1 then
  begin //for report documents tables
    ndx := 0;
    for m := 0 to TableListBox.Items.Count -1 do
      if Pos('siterpts', LowerCase(TableListBox.Items[m])) > 0 then ndx := m;
    if Pos('siterpts', EditTables.Text) > 0 then
      Insert('(t' + IntToStr(ndx) + '.SITE_ID_NR = t' + IntToStr(TableListBox.ItemIndex) + '.SITE_ID_NR) AND ', TempStr, Memo1.SelStart + 1)
    else //add
    begin
      TableList.Add('siterpts t' + IntToStr(TableListBox.Items.IndexOf('siterpts')));
      Insert('(f.SITE_ID_NR = t' + IntToStr(ndx) + '.SITE_ID_NR) AND (t' + IntToStr(ndx) + '.REPORT_NR = t' + IntToStr(TableListBox.ItemIndex) + '.REPORT_NR) AND ', TempStr, Memo1.SelStart + 1)
    end;
  end;
  TableList.Add(S);
  EditTables.Lines.Clear;
  EditTables.Lines.Add(TableList[0]);
  for m := 1 to TableList.Count-1 do
  begin
    EditTables.Lines[m-1] := EditTables.Lines[m-1] + ',';
    EditTables.Lines.Add(TableList[m]);
  end;
  Memo1.Clear;
  Memo1.Text := TempStr;
  Memo1.SelStart := sStart + Length(TempStr) + 1;
  Memo1.SetFocus;
end;

procedure TFilterForm.SearchQueryBeforeOpen(DataSet: TDataSet);
begin
  SearchQuery.Connection := DataModuleMain.ZConnectionDB;
  SearchQuery.SQL.Clear;
  SearchQuery.SQL.Add('Select DISTINCT f.SITE_ID_NR from ' + Name_Filter + ' f,');
  SearchQuery.SQL.Add(EditTables.Text);
  if TableList.Count > 0 then SearchQuery.SQL.Add('WHERE ');
  SearchQuery.SQL.Add(Memo1.Text);
end;

procedure TFilterForm.ResetToAllBtnClick(Sender: TObject);
begin
  {Reset View to allsites}
  Screen.Cursor := crHourglass;
  DataModuleMain.ZQueryView.Close;
  FilterName := 'allsites';
  DataModuleMain.ZQueryView.Open;
  StatusBar1.Panels[1].Text := 'View reset to "allsites"';
  Screen.Cursor := crDefault;
end;

procedure TFilterForm.EditTablesChange(Sender: TObject);
begin
  OkBtn.Enabled := False;
  SaveSpeedButton.Enabled := False;
  StatusBar1.Panels[1].Text := 'SQL Query not saved';
end;

procedure TFilterForm.BitBtnHelpClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

end.
