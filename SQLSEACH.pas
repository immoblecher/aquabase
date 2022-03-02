unit SQLSEACH;

{$mode objfpc}{$H+}

interface

uses Classes, Graphics, Forms, Controls, Buttons, LCLType, StdCtrls, ExtCtrls,
  DBCtrls, DB, ZDataset, SysUtils, Dialogs, ComCtrls, Clipbrd, XMLPropStorage;

type

  { TSQLSearchForm }

  TSQLSearchForm = class(TForm)
    BitBtn1: TBitBtn;
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
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    QueryDataSource: TDataSource;
    Panel1: TPanel;
    SelectLabel: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    DBNavigator1: TDBNavigator;
    HideBtn: TSpeedButton;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    StatusBar1: TStatusBar;
    CloseBitBtn: TBitBtn;
    BitBtnHelp: TBitBtn;
    OpenSpeedButton: TSpeedButton;
    SaveSpeedButton: TSpeedButton;
    OpenQueryDialog: TOpenDialog;
    SaveQueryDialog: TSaveDialog;
    SearchQuery: TZReadOnlyQuery;
    TableListBox: TListBox;
    UnitListBox: TListBox;
    XMLPropStorage: TXMLPropStorage;
    TableQuery: TZReadOnlyQuery;
    procedure EditTablesDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure EditTablesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FieldListBoxDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Memo1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Memo1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure OperatorListBoxDblClick(Sender: TObject);
    procedure QueryDataSourceDataChange(Sender: TObject; Field: TField);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure CloseBitBtnClick(Sender: TObject);
    procedure ListBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TableQueryBeforeOpen(DataSet: TDataSet);
    procedure UnitListBoxDblClick(Sender: TObject);
    procedure HideBtnClick(Sender: TObject);
    procedure TableListBoxClick(Sender: TObject);
    procedure TableListBoxDblClick(Sender: TObject);
    procedure SearchQueryBeforeOpen(DataSet: TDataSet);
    procedure OpenSpeedButtonClick(Sender: TObject);
    procedure SaveSpeedButtonClick(Sender: TObject);
    procedure EditTablesChange(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure BitBtnHelpClick(Sender: TObject);
  private
    { Private declarations }
    TableList: TStringList;
    Nr_Records: Longint;
    Name_Filter: ShortString;
    FormHt, Panel2Ht, Panel3Ht: Word;
  public
    { Public declarations }
  end;

var
  SQLSearchForm: TSQLSearchForm;

implementation

uses Varinit, MainDataModule;

{$R *.lfm}

procedure TSQLSearchForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if HideBtn.Down then
  begin
    Height := FormHt;
    Panel2.Visible := True;
    Panel3.Visible := True;
    Panel4.Visible := True;
    Panel2.Height := Panel2Ht;
    Panel3.Height := Panel3Ht;
    Splitter1.Visible := True;
    Splitter1.Top := Panel3.Top - 5;
    Splitter2.Visible := True;
    Splitter2.Top := Panel4.Top - 5;
    Panel2.Constraints.MinHeight := 80;
    Panel3.Constraints.MinHeight := 60;
    Constraints.MinHeight := 410;
  end;
  TableList.Free;
  CloseAction := caFree;
end;

procedure TSQLSearchForm.EditTablesDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source = TableListBox;
end;

procedure TSQLSearchForm.EditTablesDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  TableListBoxDblClick(Sender);
end;

procedure TSQLSearchForm.FormCreate(Sender: TObject);
var
  i: Word;
begin
  XMLPropStorage.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  with DataModuleMain do
  begin
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
      SQL.Clear;
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
  Name_Filter := FilterName;
  SelectLabel.Caption := SelectLabel.Caption + FilterName + ' f,';
  DataModuleMain.SetComponentFontAndSize(Sender, True);
end;

procedure TSQLSearchForm.FieldListBoxDblClick(Sender: TObject);
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

procedure TSQLSearchForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    BitBtnHelpClick(BitBtnHelp);
end;

procedure TSQLSearchForm.FormShow(Sender: TObject);
begin
  FieldLabel.Left := FieldListBox.Left;
  UnitLabel.Left := UnitListBox.Left;
  OperatorLabel.Left := OperatorListBox.Left;
end;

procedure TSQLSearchForm.Memo1DragDrop(Sender, Source: TObject; X, Y: Integer);
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

procedure TSQLSearchForm.Memo1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := (Source = FieldListBox) or (Source = UnitListBox) or (Source = OperatorListBox);
end;

procedure TSQLSearchForm.OperatorListBoxDblClick(Sender: TObject);
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

procedure TSQLSearchForm.QueryDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  if not SearchQuery.FieldByName('SiteID').IsNull then
  begin
    CurrentSite := SearchQuery.FieldByName('SiteID').AsString;
    StatusBar1.Panels[0].Text := 'Record ' + IntToStr(SearchQuery.RecNo) + ' of '
      + IntToStr(Nr_Records) + ' records';
    DataModuleMain.ZQueryView.Locate('SITE_ID_NR', CurrentSite, []);
  end;
end;

procedure TSQLSearchForm.SpeedButton2Click(Sender: TObject);
begin
  TableList.Clear;
  Memo1.Clear;
  EditTables.Clear;
end;

procedure TSQLSearchForm.SpeedButton1Click(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  Nr_Records := 0;
  SearchQuery.Close;
  try
    SearchQuery.Open;
    SaveSpeedButton.Enabled := True;
    Screen.Cursor := crDefault;
    Nr_Records := SearchQuery.RecordCount;
    if Nr_Records = 0 then
    begin
      StatusBar1.Panels[0].Text := 'No records found';
      MessageDlg('No records found matching query.', mtWarning, [mbOk], 0);
    end
    else
    begin
      StatusBar1.Panels[0].Text := 'Record ' + IntToStr(SearchQuery.RecNo) + ' of '
        + IntToStr(Nr_Records) + ' records';
      CurrentSite := SearchQuery.FieldByName('SiteID').Value;
      DataModuleMain.ZQueryView.Locate('SITE_ID_NR', CurrentSite, []);
      MessageDlg(IntToStr(Nr_Records) +
        ' record(s) found. Showing first record with Site Identifier ' + CurrentSite + ' in open entry form(s).', mtInformation, [mbOK], 0);
    end;
  except on E: Exception do
  begin
    Screen.Cursor := crDefault;
    MessageDlg(E.Message + ' - Check your query and try again!', mtError, [mbOK], 0);
    StatusBar1.Panels[0].Text := 'Error in SQL query statement';
  end;
  end; //of try
end;

procedure TSQLSearchForm.BitBtn1Click(Sender: TObject);

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

procedure TSQLSearchForm.CloseBitBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TSQLSearchForm.ListBoxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then
    (Sender as TListBox).BeginDrag(False, 10);
end;

procedure TSQLSearchForm.TableQueryBeforeOpen(DataSet: TDataSet);
begin
  TableQuery.Connection := DataModuleMain.ZConnectionDB;
end;

procedure TSQLSearchForm.UnitListBoxDblClick(Sender: TObject);
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

procedure TSQLSearchForm.HideBtnClick(Sender: TObject);
begin
  if HideBtn.Down then //reduce height to button and status bars
  begin
    //remember current heights
    FormHt := Height;
    Panel2Ht := Panel2.Height;
    Panel3Ht := Panel3.Height;
    Panel2.Constraints.MinHeight := 0;
    Panel3.Constraints.MinHeight := 0;
    Panel4.Constraints.MinHeight := 0;
    Constraints.MinHeight := 0;
    Panel2.Visible := False;
    Panel3.Visible := False;
    Panel4.Visible := False;
    Splitter1.Visible := False;
    Splitter2.Visible := False;
    Constraints.MaxHeight := Panel1.Height + StatusBar1.Height
  end
  else //restore heights
  begin
    Constraints.MaxHeight := 0;
    Height := FormHt;
    Panel2.Visible := True;
    Panel3.Visible := True;
    Panel4.Visible := True;
    Panel2.Height := Panel2Ht;
    Panel3.Height := Panel3Ht;
    Splitter1.Visible := True;
    Splitter1.Top := Panel3.Top - 5;
    Splitter2.Visible := True;
    Splitter2.Top := Panel4.Top - 5;
    Panel2.Constraints.MinHeight := 80;
    Panel3.Constraints.MinHeight := 60;
    Panel4.Constraints.MinHeight := 80;
    Constraints.MinHeight := 410;
  end;
end;

procedure TSQLSearchForm.TableListBoxClick(Sender: TObject);
begin
  TableQuery.SQL.Clear;
  TableQuery.SQL.Add('SELECT * FROM ' + TableListBox.Items[TableListBox.ItemIndex] + ' WHERE 1<>1');
  TableQuery.Open;
  TableQuery.GetFieldNames(FieldListBox.Items);
  TableQuery.Close;
end;

procedure TSQLSearchForm.TableListBoxDblClick(Sender: TObject);
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

procedure TSQLSearchForm.SearchQueryBeforeOpen(DataSet: TDataSet);
begin
  SearchQuery.Connection := DataModuleMain.ZConnectionDB;
  SearchQuery.SQL.Clear;
  SearchQuery.SQL.Add('Select DISTINCT f.SITE_ID_NR as SiteID from ' + Name_Filter + ' f,');
  SearchQuery.SQL.Add(EditTables.Text);
  if TableList.Count > 0 then SearchQuery.SQL.Add('WHERE ');
  SearchQuery.SQL.Add(Memo1.Text);
end;

procedure TSQLSearchForm.OpenSpeedButtonClick(Sender: TObject);

var WherePos, l: Integer;
    TableStr, SubStr: String;

begin
  OpenQueryDialog.InitialDir := WSpaceDir;
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

procedure TSQLSearchForm.SaveSpeedButtonClick(Sender: TObject);
begin
  SaveQueryDialog.InitialDir := WSpaceDir;
  if SaveQueryDialog.Execute then
  begin
    SearchQuery.SQL.SaveToFile(SaveQueryDialog.FileName);
    OpenQueryDialog.Filename := SaveQueryDialog.FileName;
    StatusBar1.Panels[1].Text := 'SQL Query saved';
  end;
end;

procedure TSQLSearchForm.EditTablesChange(Sender: TObject);
begin
  SaveSpeedButton.Enabled := False;
  StatusBar1.Panels[1].Text := 'SQL Query not saved';
end;

procedure TSQLSearchForm.Memo1Change(Sender: TObject);
begin
  SaveSpeedButton.Enabled := False;
  StatusBar1.Panels[1].Text := 'SQL Query not saved';
end;

procedure TSQLSearchForm.BitBtnHelpClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

end.
