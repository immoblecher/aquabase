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
unit Imprtdat;

{$MODE objfpc}

interface

uses LCLIntf, LCLType, Classes, Graphics, Forms, Controls, Buttons, StdCtrls,
  ExtCtrls, Dialogs, ButtonPanel, ComCtrls, XMLPropStorage, Spin, DB,
  dbf, SdfData, SysUtils, FileUtil, ZDataset, ZConnection, ZDbcSqLite;

type

  { TImportdatDlg }

  TImportdatDlg = class(TForm)
    AddBitBtn: TBitBtn;
    Edit1: TEdit;
    OpenDialog: TOpenDialog;
    SpeedButton1: TSpeedButton;
    TableQuery: TZReadOnlyQuery;
    ButtonClear: TButton;
    ButtonPanel1: TButtonPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    ComboBox1: TComboBox;
    FieldListBox: TListBox;
    ImportListBox: TListBox;
    DbaseDataSet: TDbf;
    Label1: TLabel;
    LabelFields: TLabel;
    LabelImportFields: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    MappingsListBox: TListBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    RemoveBitBtn: TBitBtn;
    SdfDataSet: TSdfDataSet;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    StaticText1: TStaticText;
    TableListBox: TListBox;
    XMLPropStorage: TXMLPropStorage;
    ZConnection1: TZConnection;
    StructureQuery: TZReadOnlyQuery;
    procedure CancelButtonClick(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure MappingsListBoxSelectionChange(Sender: TObject; User: boolean);
    procedure OKButtonClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure Splitter2Moved(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure ImportListBoxClick(Sender: TObject);
    procedure RemoveBitBtnClick(Sender: TObject);
    procedure AddBitBtnClick(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
    procedure TableListBoxClick(Sender: TObject);
    procedure ZConnection1AfterConnect(Sender: TObject);
    procedure ZConnection1BeforeConnect(Sender: TObject);
  private
    { Private declarations }
    ImportDataSet: TDataset;
  public
    { Public declarations }
  end;

var
  ImportdatDlg: TImportdatDlg;

implementation

uses VARINIT, MainDataModule, progressbox;

{$R *.lfm}

procedure TImportdatDlg.ImportListBoxClick(Sender: TObject);
begin
  if (TableListBox.ItemIndex > -1) and (FieldListBox.ItemIndex > -1) then
    AddBitBtn.Enabled := True
  else
    AddBitBtn.Enabled := False;
end;

procedure TImportdatDlg.RemoveBitBtnClick(Sender: TObject);
begin
  MappingsListBox.Items.Delete(MappingsListBox.ItemIndex);
  MappingsListBox.SetFocus;
  if MappingsListBox.Items.Count = 0 then
  begin
    RemoveBitBtn.Enabled := False;
    ButtonPanel1.OkButton.Enabled := False;
  end
  else
  begin
    RemoveBitBtn.Enabled := True;
    ButtonPanel1.OkButton.Enabled := True;
  end;
  ButtonPanel1.OKButton.Enabled := MappingsListBox.Items.Count > 0;
end;

procedure TImportdatDlg.AddBitBtnClick(Sender: TObject);
begin
  if ImportListBox.Count > 0 then
  begin
    MappingsListBox.Items.Add(TableListBox.Items[TableListBox.ItemIndex] + ':'
      + FieldListBox.Items[FieldListBox.ItemIndex] + '='
      + ImportListBox.Items[ImportListBox.ItemIndex]);
    MappingsListBox.SetFocus;
    MappingsListBox.Selected[MappingsListBox.Items.Count-1] := True;
    RemoveBitBtn.Enabled := True;
    ButtonPanel1.OkButton.Enabled := True;
  end;
end;

procedure TImportdatDlg.ButtonClearClick(Sender: TObject);
begin
  MappingsListBox.Clear;
  ButtonPanel1.OKButton.Enabled := False;
end;

procedure TImportdatDlg.TableListBoxClick(Sender: TObject);
begin
  AddBitBtn.Enabled := False;
  Screen.Cursor := crSQLWait;
  with TableQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM ' + TableListBox.Items[TableListBox.ItemIndex] + ' WHERE 1<>1');
    Open;
    GetFieldNames(FieldListBox.Items);
    Close;
  end;
  Screen.Cursor := crDefault;
end;

procedure TImportdatDlg.ZConnection1AfterConnect(Sender: TObject);
var
  ErrMsg: AnsiString;
  sc: IZSQLiteConnection;
  loadResult: Word;
begin
  if ZConnection1.Tag = 1 then
  begin
    //Spatially enable main database
    ErrMsg := '';
    sc := ZConnection1.DbcConnection as TZSQLiteConnection;
    sc.enable_load_extension(True);
    {$IFDEF DARWIN}
    loadResult := sc.load_extension('mod_spatialite.dylib', '', ErrMsg);
    {$ELSE}
    loadResult := sc.load_extension('mod_spatialite', '', ErrMsg);
    {$ENDIF}
    if loadResult > 0 then
      {$IFDEF WINDOWS}
      MessageDlg('Could not load "mod_spatialite" for this database! ' + ErrMsg + 'Please make sure it is installed (should be with Aquabase).', mtError, [mbOK], 0);
      {$ENDIF}
      {$IFDEF UNIX}
      MessageDlg('Could not load "mod_spatialite" for this database! ' + ErrMsg + 'Please make sure it is installed and possibly sym-linked to "mod_spatialite" without the ".so".', mtError, [mbOK], 0);
      {$ENDIF}
  end;
end;

procedure TImportdatDlg.ZConnection1BeforeConnect(Sender: TObject);
begin
  with DataModuleMain.ZConnectionDB do
  begin
    ZConnection1.Database := Database;
    ZConnection1.Protocol := Protocol;
    ZConnection1.LibraryLocation := LibraryLocation;
    ZConnection1.Tag := Tag;
    if ZConnection1.Tag > 1 then
    begin
      ZConnection1.HostName := HostName;
      ZConnection1.Port := Port;
      {$IFDEF WINDOWS}
      ZConnection1.User := DataModuleMain.un;
      ZConnection1.Password := DataModuleMain.pw;
      {$ELSE}
      ZConnection1.User := User;
      ZConnection1.Password := Password;
      {$ENDIF}
      if ZConnection1.Tag = 4 then
        ZConnection1.Catalog := Catalog;
    end;
  end;
end;

procedure TImportdatDlg.Splitter1Moved(Sender: TObject);
begin
  LabelFields.Left := FieldListBox.Left + 8;
end;

procedure TImportdatDlg.Splitter2Moved(Sender: TObject);
begin
  LabelImportFields.Left := ImportListBox.Left + 8;
end;

procedure TImportdatDlg.FormCreate(Sender: TObject);
var
  TempList: TStringList;
begin
  XMLPropStorage.FileName := GetUserDir + '/.aquabasesession.xml';
  TempList := TStringList.Create;
  with DataModuleMain do
  begin
    SetComponentFontAndSize(Sender, True);
    ZConnectionDB.DbcConnection.GetMetadata.ClearCache;
    ZConnectionDB.GetTableNames('', TempList); //get all tables
    TableListBox.Items.Assign(GetValidATables(TempList));
    GetValidATables(TempList).Free;
    TableQuery.Connection := ZConnectionDB;
  end;
  TempList.Free;
end;

procedure TImportdatDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TImportdatDlg.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TImportdatDlg.MappingsListBoxSelectionChange(Sender: TObject;
  User: boolean);
begin
  ButtonPanel1.OKButton.Enabled := (MappingsListBox.Items.Count > 0) and (Edit1.Text > '');
end;

procedure TImportdatDlg.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TImportdatDlg.CheckBox1Change(Sender: TObject);
begin
  SpinEdit1.Enabled := CheckBox1.Checked;
end;

procedure TImportdatDlg.CheckBox2Change(Sender: TObject);
begin
  SpinEdit2.Enabled := CheckBox2.Checked;
end;

procedure TImportdatDlg.Edit1Change(Sender: TObject);
begin
  if FileExists(Edit1.Text) then
  begin
    Edit1.Font.Color := clBlack;
    ButtonPanel1.OKButton.Enabled := MappingsListBox.Items.Count > 0;
  end
  else
  begin
    Edit1.Font.Color := clRed;
    ButtonPanel1.OKButton.Enabled := False;
  end;
end;

procedure TImportdatDlg.FormClose(Sender: TObject; var CloseAction: TCloseAction  );
begin
  CloseAction := caFree;
end;

procedure TImportdatDlg.OKButtonClick(Sender: TObject);
var
  TableList, AquabaseFields, ImportFields, ErrorLog: TStringList;
  m, f, t, NrRecs: Integer;
  ColonPos, EqualPos, SubStrCount: SmallInt;
  IgnoreErrors, InsertRow: Boolean;
  InsertStr, FieldsStr, ValuesStr: String;
begin
  Visible := False; //make the import dialog invisible
  {Create list of tables to which data will be imported}
  if UpperCase(ExtractFileExt(Edit1.Text)) = '.DBF' then
    ImportDataSet := DbaseDataSet
  else
    ImportDataSet := SdfDataSet;
  TableList := TStringList.Create;
  TableList.Sorted := True;
  TableList.Duplicates := dupIgnore;
  for t := 0 to MappingsListBox.Items.Count -1 do
    TableList.Add(Copy(MappingsListBox.Items[t], 1, 8));
  AquabaseFields := TStringList.Create;
  ImportFields := TStringList.Create;
  ErrorLog := TStringList.Create;
  NrRecs := ImportDataSet.RecordCount;
  ProgressBoxForm := TProgressBoxForm.Create(Application);
  with ProgressBoxForm do
  begin
    Caption := 'Importing table(s)...';
    ProgressBar1.Max := NrRecs;
    ProgressBar1.Position := 0;
    Label1.Caption := 'Initialising import, please wait...';
    Application.ProcessMessages;
    Show;
  end;
  Application.ProcessMessages;
  ZConnection1.Connect;
  for t := 0 to TableList.Count-1 do
  if not ProgressBoxForm.CancelPressed then
  begin
    //get all the Aquabase and import table table fields into stringlists
    AquabaseFields.Clear;
    ImportFields.Clear;
    IgnoreErrors := False;
    for m := 0 to MappingsListBox.Items.Count - 1 do
    begin
      ColonPos := Pos(':', MappingsListBox.Items[m]);
      EqualPos := Pos('=', MappingsListBox.Items[m]);
      SubStrCount := EqualPos - ColonPos;
      if Copy(MappingsListBox.Items[m], 1, ColonPos-1) = TableList[t] then
      begin
        AquabaseFields.Add(Copy(MappingsListBox.Items[m], ColonPos+1, SubStrCount - 1));
        ImportFields.Add(Copy(MappingsListBox.Items[m], EqualPos+1, Length(MappingsListBox.Items[m])));
      end;
    end;
    //build Aquabase fields string for the table
    FieldsStr := '(';
    for f := 0 to AquabaseFields.Count - 1 do
      if f = AquabaseFields.Count - 1 then
        FieldsStr := FieldsStr + AquabaseFields[f] + ')'
      else
        FieldsStr := FieldsStr + AquabaseFields[f] + ', ';
    //get the Aquabase table structure to identify field types for insert values
    with StructureQuery do
    begin
      SQL.Clear;
      SQL.Add('SELECT * FROM ' + TableList[t] + ' WHERE 1 <> 1');
      Open;
    end;
    Application.ProcessMessages;
    //disable triggers on all tables except when table is BASICINF (update geometry) to reduce server load
    {if UpperCase(TableList[t]) <> 'BASICINF' then
    case ZConnection1.Tag of
    2,3: ZConnection1.ExecuteDirect('ALTER TABLE ' + TableList[t] + ' DISABLE ALL TRIGGERS;');
      4: ZConnection1.ExecuteDirect('ALTER TABLE ' + TableList[t] + ' DISABLE TRIGGER ALL;');
      5: ZConnection1.ExecuteDirect('DISABLE TRIGGER ALL ON ' + TableList[t]);
    end; //of case}
    ProgressBoxForm.ProgressBar1.Position := 0;
    ProgressBoxForm.Label1.Caption := 'Preparing Aquabase table "' + TableList[t] + '", please wait...';
    Application.ProcessMessages;
    Screen.Cursor := crSQLWait;
    Sleep(100);
    Application.ProcessMessages;
    Screen.Cursor := crDefault;
    ImportDataSet.First;
    if CheckBox1.Checked then
      ImportDataSet.MoveBy(SpinEdit1.Value - 1);
    if CheckBox2.Checked then
    begin
      NrRecs := SpinEdit2.Value;
      ProgressBoxForm.ProgressBar1.Max := NrRecs;
    end;
    while (not ProgressBoxForm.CancelPressed) and (not ImportDataSet.EOF) do
    begin
      ProgressBoxForm.ProgressBar1.Position := ImportdataSet.RecNo;
      ProgressBoxForm.Label1.Caption := 'Busy with record ' + IntToStr(ImportDataSet.RecNo) + ' up to ' + IntToStr(NrRecs) + ' with table "' + TableList[t] + '"...';
      Application.ProcessMessages;
      //check if record must be inserted from conditions
      InsertRow := True;
      if CheckBox2.Checked then
        InsertRow := ImportDataSet.RecNo <= SpinEdit2.Value;
      if InsertRow and CheckBox3.Checked then
        InsertRow := ImportDataSet.FieldByName(ComboBox1.Text).AsString > '';
      if InsertRow then
      begin
        //build insert statement and set fields to values from import table
        ValuesStr := '(';
        for f := 0 to AquabaseFields.Count - 1 do
        begin
          if f = AquabaseFields.Count - 1 then
          begin
            if (StructureQuery.FieldByName(AquabaseFields[f]).DataType = ftString) or (StructureQuery.FieldByName(AquabaseFields[f]).DataType = ftBlob) then
              ValuesStr := ValuesStr + QuotedStr(ImportDataSet.FieldByName(ImportFields[f]).AsString) + ');'
            else
              ValuesStr := ValuesStr + ImportDataSet.FieldByName(ImportFields[f]).AsString + ');'
          end
          else
          begin
            if (StructureQuery.FieldByName(AquabaseFields[f]).DataType = ftString) or (StructureQuery.FieldByName(AquabaseFields[f]).DataType = ftBlob) then
              ValuesStr := ValuesStr + QuotedStr(ImportDataSet.FieldByName(ImportFields[f]).AsString) + ', '
            else
              ValuesStr := ValuesStr + ImportDataSet.FieldByName(ImportFields[f]).AsString + ', ';
          end;
        end;
        InsertStr := 'INSERT INTO ' + TableList[t] + ' ' + FieldsStr + ' VALUES ' + ValuesStr;
        try
          ZConnection1.ExecuteDirect(InsertStr);
        except on E: Exception do
          begin
            ErrorLog.Add(E.Message + '. Record ' + IntToStr(ProgressBoxForm.ProgressBar1.Position) + ' not inserted into table ' + TableList[t]);
            Screen.Cursor := crDefault;
            if not IgnoreErrors then
              if  MessageDlg(E.Message + '. Record ' + IntToStr(ProgressBoxForm.ProgressBar1.Position) + ' from the import table will not be inserted into table "' + TableList[t] +'"! This may be due to foreign or unique key violations. "Ignore" prevents further error messages for this table.', mtWarning, [mbOK, mbIgnore], 0) = mrIgnore then
                IgnoreErrors := True;
          end;
        end;
        Application.ProcessMessages;
        if CheckBox2.Checked then
        begin
          if ImportDataSet.RecNo = NrRecs then //is at end of records to be imported
            ImportDataSet.Last
          else
            ImportDataSet.Next;
        end
        else
          ImportDataSet.Next;
      end
      else
        ImportDataSet.Next;
    end;
    //reset sequence on chemistry for postgres
    if (ZConnection1.Tag = 4) and (TableList[t] = 'chem_000') then //reset the autoincement
      ZConnection1.ExecuteDirect('SELECT setval(''chem_000_chm_ref_nr_seq'', (SELECT MAX(chm_ref_nr) from chem_000));');
    //re-enable the triggers
    {if UpperCase(TableList[t]) <> 'BASICINF' then
    case ZConnection1.Tag of
    2,3: ZConnection1.ExecuteDirect('ALTER TABLE ' + TableList[t] + ' ENABLE ALL TRIGGERS;');
      4: ZConnection1.ExecuteDirect('ALTER TABLE ' + TableList[t] + ' ENABLE TRIGGER ALL;');
      5: ZConnection1.ExecuteDirect('ENABLE TRIGGER ALL ON ' + TableList[t]);
    end; //of case}
    //close StructureQuery
    StructureQuery.Close;
    ProgressBoxForm.Finished := True;
  end;
  if ProgressBoxForm.CancelPressed then
  begin
    ProgressBoxForm.Close;
    Application.ProcessMessages;
    MessageDlg('Import process aborted! Your tables may not be completely imported.', mtWarning, [mbOK], 0);
  end
  else
  begin
    ProgressBoxForm.Close;
    Application.ProcessMessages;
    MessageDlg('Import of table(s) completed! Check out your log file "TableImport.log" for error messages.', mtInformation, [mbOk], 0);
  end;
  TableList.Free;
  AquabaseFields.Free;
  ImportFields.Free;
  if ErrorLog.Count > 0 then
    ErrorLog.SaveToFile(WSpaceDir + DirectorySeparator + 'TableImport.log');
  ErrorLog.Free;
  ImportDataSet.Close;
  ZConnection1.Disconnect;
  Close; //close the import dialog
end;

procedure TImportdatDlg.SpeedButton1Click(Sender: TObject);
begin
  with OpenDialog do
  begin
    InitialDir := WSpaceDir;
    Title := 'Select a DBF or CSV file to import';
    if Execute and (Filename <> '') then
    begin
      DbaseDataSet.Close;
      SdfDataSet.Close;
      Edit1.Text := Filename;
      if Lowercase(ExtractFileExt(Filename)) = '.dbf' then
      begin
        DbaseDataSet.FilePath := ExtractFilePath(Filename);
        DbaseDataSet.Tablename := ExtractFileName(Filename);
        try
          DbaseDataSet.Open;
          DbaseDataSet.GetFieldNames(ImportListBox.Items);
          DbaseDataSet.GetFieldNames(ComboBox1.Items);
          SpinEdit1.MaxValue := DbaseDataSet.RecordCount;
          SpinEdit2.MaxValue := DbaseDataSet.RecordCount;
          SpinEdit2.Value := SpinEdit2.MaxValue;
        except on E: Exception do
          MessageDlg('The DBase table does not seem to be in a valid format: ' + E.Message + '! Please fix the import table or try another file.', mtError, [mbOK], 0);
        end;
      end
      else
      if Lowercase(ExtractFileExt(Filename)) = '.csv' then
      begin
        SDFDataSet.FileName := FileName;
        try
          SDFDataSet.Open;
          SDFdataSet.GetFieldNames(ImportListBox.Items);
          SDFdataSet.GetFieldNames(ComboBox1.Items);
          SpinEdit1.MaxValue := SDFdataSet.RecordCount;
          SpinEdit2.MaxValue := SDFdataSet.RecordCount;
          SpinEdit2.Value := SpinEdit2.MaxValue;
        except on E: Exception do
          MessageDlg('The CSV file does not seem to be in a valid format: ' + E.Message + '! Please fix the import table or try another file.', mtError, [mbOK], 0);
        end;
      end;
    end;
  end;
end;

procedure TImportdatDlg.SpinEdit1Change(Sender: TObject);
begin
  SpinEdit2.MinValue := SpinEdit1.Value;
end;

procedure TImportdatDlg.SpinEdit2Change(Sender: TObject);
begin
  SpinEdit1.MaxValue := SpinEdit2.Value;
end;

end.
