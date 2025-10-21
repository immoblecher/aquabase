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
unit importchem;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, dbf, SdfData, FileUtil, Forms, Controls, Graphics, Dialogs,
  ButtonPanel, StdCtrls, Grids, XMLPropStorage, ZDataset, DB, ZSqlProcessor, LCLType;

type

  { TImportChemForm }

  TImportChemForm = class(TForm)
    ButtonBrowse: TButton;
    ButtonPanel1: TButtonPanel;
    DbaseDataSet: TDbf;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    OpenDialog: TOpenDialog;
    SdfDataSet: TSdfDataSet;
    StringGrid1: TStringGrid;
    XMLPropStorage1: TXMLPropStorage;
    ChemQuery: TZReadOnlyQuery;
    ChemTable: TZTable;
    RefNrQuery: TZReadOnlyQuery;
    ZSQLProcessor1: TZSQLProcessor;
    procedure ButtonBrowseClick(Sender: TObject);
    procedure ChemTablePostError(DataSet: TDataSet; E: EDatabaseError;
      var DataAction: TDataAction);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure StringGrid1EditingDone(Sender: TObject);
    procedure StringGrid1ValidateEntry(sender: TObject; aCol, aRow: Integer;
      const OldValue: string; var NewValue: String);
  private
    ImportDataSet: TDataset;
    ErrorLog: TStringList;
    IgnoreErrors: Boolean;
  public

  end;

var
  ImportChemForm: TImportChemForm;

implementation

{$R *.lfm}

uses VARINIT, MainDataModule, progressbox;

{ TImportChemForm }

procedure TImportChemForm.ButtonBrowseClick(Sender: TObject);
var
  FieldList: TStringList;
  m: Word;
begin
  FieldList := TStringList.Create;
  with OpenDialog do
  begin
    InitialDir := WSpaceDir;
    Title := 'Select DBF or CSV file to import';
    if Execute and (Filename <> '') then
    begin
      DbaseDataSet.Close;
      SdfDataSet.Close;
      Edit1.Text := Lowercase(Filename);
      if Lowercase(ExtractFileExt(Filename)) = '.dbf' then
      begin
        DbaseDataSet.FilePath := ExtractFilePath(Filename);
        DbaseDataSet.Tablename := ExtractFileName(Filename);
        try
          DbaseDataSet.Open;
          DbaseDataSet.GetFieldNames(FieldList);
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
          SDFdataSet.GetFieldNames(FieldList);
        except on E: Exception do
          MessageDlg('The CSV file does not seem to be in a valid format: ' + E.Message + '! Please fix the import table or try another file.', mtError, [mbOK], 0);
        end;
      end;
    end;
  end;
  //fill the grid
  if FieldList.Count > 0 then //is a valid import table with found fields
  begin
    for m := StringGrid1.RowCount - 1 downto 1 do
      StringGrid1.DeleteRow(m);
    for m := 0 to FieldList.Count - 1 do
      StringGrid1.InsertRowWithValues(m + 1, [IntToStr(m + 1), FieldList.Strings[m], '<DO NOT IMPORT>', '1']);
    //fill the parameter picklist
    for m := 0 to 6 do
    with ChemQuery do
    begin
      SQL.Clear;
      SQL.Add('SELECT * FROM chem_00' + IntToStr(m) + ' WHERE 1<>1');
      Open;
      GetFieldNames(FieldList);
      Close;
      StringGrid1.Columns[1].PickList.AddStrings(FieldList);
    end;
    //clean picklist
    while StringGrid1.Columns[1].PickList.IndexOf('CHM_REF_NR') >=0 do
      StringGrid1.Columns[1].PickList.Delete(StringGrid1.Columns[1].PickList.IndexOf('CHM_REF_NR'));
  end;
  FieldList.Free;
end;

procedure TImportChemForm.ChemTablePostError(DataSet: TDataSet;
  E: EDatabaseError; var DataAction: TDataAction);
begin
  DataAction := daAbort;
  ErrorLog.Add(E.Message + '. Record ' + IntToStr(ProgressBoxForm.ProgressBar1.Position) + ' not inserted into table ' + (Dataset as TZTable).TableName);
  Screen.Cursor := crDefault;
  if not IgnoreErrors then
    if  MessageDlg(E.Message + '. Record ' + IntToStr(ProgressBoxForm.ProgressBar1.Position) + ' from the import table will not be inserted into table "' + (Dataset as TZTable).TableName +'"! This may be due to foreign or unique key violations. "Ignore" prevents further error messages for this table.', mtWarning, [mbOK, mbIgnore], 0) = mrIgnore then
      IgnoreErrors := True;
end;

procedure TImportChemForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TImportChemForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TImportChemForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if Visible and (Edit1.Text > '') and (MessageDlg('Are you sure you want to close this form without importing anything?', mtConfirmation, [mbYes, mbNo], 0) = mrNo) then
    CanClose := False
  else
    CanClose := True;
end;

procedure TImportChemForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage1.FileName := GetUserDir + '/.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, False);
end;

procedure TImportChemForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TImportChemForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TImportChemForm.OKButtonClick(Sender: TObject);
var
  NrRecs, LastRefNr, RefNr, TheInt: LongInt;
  m, GreaterPos, ColonPos: Byte;
  f: Word;
  FieldList, MappingsList: TStringList;
  AquabaseField, ImportField: TField;
  TheFactor, TheValue: Real;
  ValueFound:Boolean;
begin
  //check which dataset to use
  if ExtractFileExt(Edit1.Text) = '.dbf' then
    ImportDataSet := DbaseDataSet
  else
    ImportDataSet := SdfDataSet;
  NrRecs := ImportDataSet.RecordCount;
  FieldList := TStringList.Create;
  MappingsList := TStringList.Create;
  ErrorLog := TStringList.Create;
  Visible := False; //make the import dialog invisible
  ProgressBoxForm := TProgressBoxForm.Create(Application);
  with ProgressBoxForm do
  begin
    Caption := 'Importing chemistry...';
    ProgressBar1.Max := NrRecs;
    ProgressBar1.Position := 0;
    Label1.Caption := 'Initialising import, please wait...';
    ProgressBoxForm.Show;
  end;
  Sleep(100);
  Application.ProcessMessages;
  //get starting chemistry ref nr CHM_REF_NR
  RefNrQuery.Open;
  LastRefNr := RefNrQuery.Fields[0].AsInteger;
  RefNrQuery.Close;
  //run through all tables and check for fields mapped, then import
  for m := 0 to 6 do
  if not ProgressBoxForm.CancelPressed then
  begin
    with ChemTable do
    begin
      TableName := 'chem_00' + IntToStr(m);
      ProgressBoxForm.ProgressBar1.Position := 0;
      ProgressBoxForm.Label1.Caption := 'Opening table "' + TableName + '", please wait...';
      Application.ProcessMessages;
      Screen.Cursor := crSQLWait;
      Sleep(100);
      Application.ProcessMessages;
      Open;
      GetFieldNames(FieldList);
      Screen.Cursor := crDefault;
      MappingsList.Clear;
      for f := 1 to StringGrid1.RowCount - 1 do //check which mapped fields are in table fieldlist
      begin
        if FieldList.IndexOf(StringGrid1.Cells[2, f]) >= 0 then
          MappingsList.Add(StringGrid1.Cells[1, f] + '>' + StringGrid1.Cells[2, f] + ':' + StringGrid1.Cells[3, f]);
      end;
      if MappingsList.Count > 0 then //if there are any fields mapped for that table then import data
      begin
        ImportDataSet.First;
        RefNr := LastRefNr; //begin with the last ref nr from database = reset
        while (not ProgressBoxForm.CancelPressed) and (not ImportDataSet.EOF) do
        begin
          ProgressBoxForm.ProgressBar1.Position := ProgressBoxForm.ProgressBar1.Position + 1;
          ProgressBoxForm.Label1.Caption := 'Busy with record ' + IntToStr(ProgressBoxForm.ProgressBar1.Position) + ' out of ' + IntToStr(NrRecs) + ' with table "' + TableName + '"...';
          Application.ProcessMessages;
          ValueFound := False;
          Append;
          Inc(RefNr);
          for f := 0 to MappingsList.Count - 1 do //map field values to each other
          begin
            FieldByName('CHM_REF_NR').AsInteger := RefNr;
            GreaterPos := Pos('>', MappingsList.Strings[f]);
            ColonPos := Pos(':', MappingsList.Strings[f]);
            AquabaseField := FieldByName(Copy(MappingsList.Strings[f], GreaterPos + 1, ColonPos - GreaterPos - 1));
            ImportField := ImportDataSet.FieldByName(Copy(MappingsList.Strings[f], 1, GreaterPos - 1));
            TheFactor := StrToFloat(Copy(MappingsList.Strings[f], ColonPos + 1, Length(MappingsList.Strings[f]) - ColonPos));
            if not ImportField.IsNull then
            begin
              //check for detection limits
              if AquabaseField.DataType = ftFloat then //float fields
              begin
                if Pos('<', ImportField.Value) > 0 then
                begin
                  TheValue := StrToFloat(StringReplace(ImportField.Value, '<', '', [rfReplaceAll]));
                  ValueFound := True;
                  ZSQLProcessor1.Script.Add('INSERT INTO deteclim (CHM_REF_NR, CPARAMETER, LIMITS) VALUES ('
                    + IntToStr(RefNr) + ', ' + QuotedStr(UpperCase(AquabaseField.FieldName)) + ', ' + QuotedStr('<') + ');');
                end
                else
                if Pos('>', ImportField.Value) > 0 then
                begin
                  TheValue := StrToFloat(StringReplace(ImportField.Value, '>', '', [rfReplaceAll]));
                  ValueFound := True;
                  ZSQLProcessor1.Script.Add('INSERT INTO deteclim (CHM_REF_NR, CPARAMETER, LIMITS) VALUES ('
                    + IntToStr(RefNr) + ', ' + QuotedStr(UpperCase(AquabaseField.FieldName)) + ', ' + QuotedStr('>') + ');');
                end
                else
                if Pos('#', ImportField.Value) > 0 then
                begin
                  TheValue := StrToFloat(StringReplace(ImportField.Value, '#', '', [rfReplaceAll]));
                  ValueFound := True;
                  ZSQLProcessor1.Script.Add('INSERT INTO deteclim (CHM_REF_NR, CPARAMETER, LIMITS) VALUES ('
                    + IntToStr(RefNr) + ', ' + QuotedStr(UpperCase(AquabaseField.FieldName)) + ', ' + QuotedStr('"') + ');');
                end
                else
                try
                  TheValue := ImportField.Value;
                  ValueFound := True;
                except on E: EVariantError do //weird other text in import field
                  begin
                    //to do: -1 must be NULL
                    TheValue := -1;
                    MessageDlg('Could not transfer field "' + ImportField.FieldName +'" value into "' + ChemTable.TableName + '" table for Ref. Nr. ' + IntToStr(RefNr) + ': ' + E.Message + '!', mtError, [mbOK], 0);
                    ErrorLog.Add('Could not transfer field "' + ImportField.FieldName +'" value into "' + ChemTable.TableName + '" table for Ref. Nr. ' + IntToStr(RefNr) + ': ' + E.Message);
                  end;
                end;
                if (TheValue = -1) or (TheValue = NULL) then
                  AquabaseField.Value := NULL
                else
                  AquabaseField.Value := TheValue * TheFactor;
              end
              else
              if (AquabaseField.DataType = ftLargeInt) then //integer fields
              begin
                if Pos('<', ImportField.Value) > 0 then
                begin
                  TheInt := StrToInt(StringReplace(ImportField.Value, '<', '', [rfReplaceAll]));
                  ValueFound := True;
                  ZSQLProcessor1.Script.Add('INSERT INTO deteclim (CHM_REF_NR, CPARAMETER, LIMITS) VALUES ('
                    + IntToStr(RefNr) + ', ' + QuotedStr(UpperCase(AquabaseField.FieldName)) + ', ' + QuotedStr('<') + ');');
                end
                else
                if Pos('>', ImportField.Value) > 0 then
                begin
                  TheInt := StrToInt(StringReplace(ImportField.Value, '>', '', [rfReplaceAll]));
                  ValueFound := True;
                  ZSQLProcessor1.Script.Add('INSERT INTO deteclim (CHM_REF_NR, CPARAMETER, LIMITS) VALUES ('
                    + IntToStr(RefNr) + ', ' + QuotedStr(UpperCase(AquabaseField.FieldName)) + ', ' + QuotedStr('>') + ');');
                end
                else
                if Pos('#', ImportField.Value) > 0 then
                begin
                  TheInt := StrToInt(StringReplace(ImportField.Value, '#', '', [rfReplaceAll]));
                  ValueFound := True;
                  ZSQLProcessor1.Script.Add('INSERT INTO deteclim (CHM_REF_NR, CPARAMETER, LIMITS) VALUES ('
                    + IntToStr(RefNr) + ', ' + QuotedStr(UpperCase(AquabaseField.FieldName)) + ', ' + QuotedStr('"') + ');');
                end
                else
                try
                  TheInt := ImportField.AsLargeInt;
                  ValueFound := True;
                except on E: EVariantError do
                  begin
                    TheInt := -1;
                    MessageDlg('Could not transfer field "' + ImportField.FieldName +'" value into "' + ChemTable.TableName + '" table for Ref. Nr. ' + IntToStr(RefNr) + ': ' + E.Message + '!', mtError, [mbOK], 0);
                    ErrorLog.Add('Could not transfer field "' + ImportField.FieldName +'" value into "' + ChemTable.TableName + '" table for Ref. Nr. ' + IntToStr(RefNr) + ': ' + E.Message);
                  end;
                end;
                if (TheInt = -1) or (TheInt = NULL) then
                  AquabaseField.Value := NULL
                else
                  AquabaseField.AsInteger := Round(TheInt * TheFactor);
              end
              else //character fields, there are none in chem_001 to chem_006
                AquabaseField.Value := UpperCase(ImportField.Value);
            end;
          end;
          if m = 0 then //the chem_000 table, post because we need chm_ref_nr's
            Post
          else //check if there are any values in the record, if so then post
          begin
            if ValueFound then
              Post
            else
              Cancel;
          end;
          ImportDataSet.Next;
        end;
      end;
      Close;
    end;
    ProgressBoxForm.Finished := True;
  end;
  if ProgressBoxForm.CancelPressed then
  begin
    ProgressBoxForm.Close;
    Application.ProcessMessages;
    MessageDlg('Import process aborted! Your chemistry is not completely imported and therefore all imported records so far will now be removed!', mtWarning, [mbOK], 0);
    DataModuleMain.ZConnectionDB.ExecuteDirect('DELETE FROM chem_000 WHERE chm_ref_nr > ' + IntToStr(LastRefNr) + ';');
  end
  else
  begin
    //process detection limits
    ProgressBoxForm.Label1.Caption := 'Processing values for the detection limits, please wait...';
    ProgressBoxForm.ProgressBar1.Position := Round(NrRecs/2);
    Application.ProcessMessages;
    Screen.Cursor := crSQLWait;
    Sleep(100);
    Application.ProcessMessages;
    if ZSQLProcessor1.Script.Count > 0 then
      ZSQLProcessor1.Execute;
    ProgressBoxForm.ProgressBar1.Position := NrRecs;
    Application.ProcessMessages;
    Sleep(100);
    //clean up chem_000 where there are no values in other chemistry tables
    ProgressBoxForm.Label1.Caption := 'Cleaning up chemistry samples without results, please wait...';
    Application.ProcessMessages;
    Screen.Cursor := crSQLWait;
    Sleep(100);
    Application.ProcessMessages;
    with ZSQLProcessor1.Script do
    begin
      Clear;
      Add('DELETE FROM chem_000');
      Add('WHERE chm_ref_nr > ' + IntToStr(LastRefNr));
      Add('AND chm_ref_nr NOT IN (SELECT chm_ref_nr FROM chem_001 WHERE chm_ref_nr > ' + IntToStr(LastRefNr) + ')');
      Add('AND chm_ref_nr NOT IN (SELECT chm_ref_nr FROM chem_002 WHERE chm_ref_nr > ' + IntToStr(LastRefNr) + ')');
      Add('AND chm_ref_nr NOT IN (SELECT chm_ref_nr FROM chem_003 WHERE chm_ref_nr > ' + IntToStr(LastRefNr) + ')');
      Add('AND chm_ref_nr NOT IN (SELECT chm_ref_nr FROM chem_004 WHERE chm_ref_nr > ' + IntToStr(LastRefNr) + ')');
      Add('AND chm_ref_nr NOT IN (SELECT chm_ref_nr FROM chem_005 WHERE chm_ref_nr > ' + IntToStr(LastRefNr) + ')');
      Add('AND chm_ref_nr NOT IN (SELECT chm_ref_nr FROM chem_006 WHERE chm_ref_nr > ' + IntToStr(LastRefNr) + ');');
    end;
    ZSQLProcessor1.Execute;
    Screen.Cursor := crDefault;
    ProgressBoxForm.Close;
    Application.ProcessMessages;
    MessageDlg('Import of table(s) completed successfully! The first Chemistry Reference Number used was ' + IntToStr(LastRefNr + 1) + '. If there were errors, check out your log file "ChemistryImport.log" for error messages.', mtInformation, [mbOk], 0);
  end;
  if DataModuleMain.ZConnectionDB.Tag = 4 then //reset the autoincement
    DataModuleMain.ZConnectionDB.ExecuteDirect('SELECT setval(''chem_000_chm_ref_nr_seq'', (SELECT MAX(chm_ref_nr) from chem_000));');
  if ErrorLog.Count > 0 then
    ErrorLog.SaveToFile(WSpaceDir + DirectorySeparator + 'ChemistryImport.log');
  ErrorLog.Free;
  FieldList.Free;
  MappingsList.Free;
  ImportDataset.Close;
  Close; //close the import dialog
end;

procedure TImportChemForm.StringGrid1EditingDone(Sender: TObject);
var
  m: Word;
begin
  for m := 1 to StringGrid1.RowCount - 1 do
  begin
    if UpperCase(StringGrid1.Cells[2, m]) = 'SITE_ID_NR' then
    begin
      ButtonPanel1.OKButton.Enabled := True;
      Break;
    end
    else
      ButtonPanel1.OKButton.Enabled :=False;
  end;
end;

procedure TImportChemForm.StringGrid1ValidateEntry(sender: TObject; aCol,
  aRow: Integer; const OldValue: string; var NewValue: String);
begin
  if aCol = 2 then //check if the field typed in is in PickList
  begin
    if StringGrid1.Columns[1].PickList.IndexOf(NewValue) = -1 then
    begin
      MessageDlg('The field "' + NewValue + '" does not exist in the chemistry tables! Maybe you want to select it from the dropdown list?', mtError, [mbOK], 0);
      NewValue := OldValue;
    end;
  end
  else
  if aCol = 3 then //check if the field typed in is numeric
  begin
    try
      StrToFloat(NewValue);
    except on E: EConvertError do
      begin
        MessageDlg('The factor must be a numeric value! Maybe you want to select it from the dropdown list?', mtError, [mbOK], 0);
        NewValue := OldValue;
      end;
    end;
  end;
end;

end.

