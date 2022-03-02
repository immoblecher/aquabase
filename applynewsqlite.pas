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
unit applynewsqlite;

{$mode delphi}

interface

uses
  Classes, SysUtils, db, FileUtil, ZDataset, ZConnection, ZSqlProcessor,
  ZDbcSqLite, Forms, Controls, Graphics, Dialogs, ButtonPanel, StdCtrls,
  ComCtrls, DbCtrls, ExtCtrls;

type

  { TApplyNewSQLiteForm }

  TApplyNewSQLiteForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    DefinitionQuery: TZReadOnlyQuery;
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    StaticText2: TStaticText;
    ViewQuery: TZReadOnlyQuery;
    ZConnectionNew: TZConnection;
    ZQueryImg: TZQuery;
    ZReadOnlyQuery: TZReadOnlyQuery;
    ZQueryOldFields: TZReadOnlyQuery;
    ZQueryNewFields: TZReadOnlyQuery;
    ZSQLProcessorViews: TZSQLProcessor;
    procedure CloseButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure ZReadOnlyQueryBeforeOpen(DataSet: TDataSet);
    procedure ZQueryOldFieldsBeforeOpen(DataSet: TDataSet);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  ApplyNewSQLiteForm: TApplyNewSQLiteForm;

implementation

{$R *.lfm}

uses MainDataModule, VARINIT;

{ TApplyNewSQLiteForm }

procedure TApplyNewSQLiteForm.OKButtonClick(Sender: TObject);
var OldTableList, TempTableList, TableList, FieldList, OldFieldList, ErrorList: TStringList;
    t, f, i: Byte;
    ValueString, SQLStr, ExeStr: String;
    ViewList: TStringList;
    Stream: TStream;
    sc: IZSQLiteConnection;
    CurRec, v: Integer;
    IgnoreMsg: Boolean;
    ErrMsg: String;
    loadResult: Word;
begin
  if MessageDlg('Are you sure you want to apply a new SQLite format to your workspace?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    BusyNewSQLite := True;
    ErrorList := TStringList.Create;
    ButtonPanel1.OKButton.Enabled := False;
    ButtonPanel1.CloseButton.Enabled := False;
    Panel1.Caption := 'Please wait for the conversion process to complete. At the end you will have to close the workspace and open it again to activate the new format.';
    Application.ProcessMessages;
    //copy the new aquabase.sqlite to the workspace
    CopyFile(ProgramDir + DirectorySeparator + 'Databases' + DirectorySeparator + 'SQLite'  + DirectorySeparator + 'aquabase.sqlite',
      WSpaceDir + DirectorySeparator + 'aquabase_new.sqlite');
    //set connection parameters
    {$IFDEF WINDOWS}
    ZConnectionNew.LibraryLocation := ProgramDir + '\' + SQLiteLib;
    {$ELSE}
    ZConnectionNew.LibraryLocation := SQLiteLib;
    {$ENDIF}
    //get the old table list
    OldTableList := TStringList.Create;
    DataModuleMain.ZConnectionDB.DbcConnection.GetMetadata.ClearCache;
    DataModuleMain.ZConnectionDB.GetTableNames('', OldTableList);
    //get all the views and add them as scripts to ZSQLProcessor
    ViewList := TStringList.Create;
    with DefinitionQuery do
    begin
      SQL.Clear;
      SQL.AddText('SELECT name FROM sqlite_master WHERE type = ' + QuotedStr('view'));
      Open;
      while not EOF do
      begin
        with ViewQuery do
        begin
          SQL.Clear;
          SQL.Add('SELECT * FROM "' + DefinitionQuery.FieldByName('name').AsString + '" LIMIT 1');
          Open;
          if UpperCase(Fields[0].FieldName) = 'SITE_ID_NR' then
            ViewList.Add(DefinitionQuery.FieldByName('name').AsString);
          Close;
        end;
        Next;
      end;
    end;
    for v := 0 to ViewList.Count -1 do
    with DefinitionQuery do
    if ViewList[v] <> 'allsites' then
    begin
      SQL.Clear;
      SQL.AddText('SELECT sql FROM sqlite_master WHERE name = ' + QuotedStr(ViewList[v]) + ';');
      Open;
      ZSQLProcessorViews.Script.Add(DefinitionQuery.FieldByName('sql').AsString + ';');
      Close;
    end;
    //set up new connection
    ZConnectionNew.Database := WSpaceDir + DirectorySeparator + 'aquabase_new.sqlite';
    ZConnectionNew.Connect;
    ZConnectionNew.ExecuteDirect('PRAGMA foreign_keys = ON;'); //Enable foreign keys on sqlite
    //Spatially enable main database
    sc := ZConnectionNew.DbcConnection as TZSQLiteConnection;
    sc.enable_load_extension(True);
    {$IFDEF DARWIN}
    loadResult := sc.load_extension('mod_spatialite.dylib', '', ErrMsg);
    {$ELSE}
    loadResult := sc.load_extension('mod_spatialite', '', ErrMsg);
    {$ENDIF}
    if loadResult > 0 then
      {$IFDEF WINDOWS}
      MessageDlg('Could not load ' + ErrMsg + ' library! Please make sure it is installed (should be with Aquabase).', mtError, [mbOK], 0);
      {$ENDIF}
      {$IFDEF UNIX}
      MessageDlg('Could not load ' + ErrMsg + ' library! Please make sure it is installed and (on Linux) possibly sym-linked to "mod_spatialite" without the ".so".', mtError, [mbOK], 0);
      {$ENDIF}
    //create field list according to new structure and build query
    TempTableList := TStringList.Create;
    TempTableList.Sorted := True;
    TableList := TStringList.Create;
    FieldList := TStringList.Create;
    OldFieldList := TStringList.Create;
    ZConnectionNew.DbcConnection.GetMetadata.ClearCache;
    ZConnectionNew.GetTableNames('', TempTableList);
    //choose only Aquabase valid tables
    TableList.Assign(DataModuleMain.GetValidATables(TempTableList));
    DataModuleMain.GetValidATables(TempTableList).Free;
    TempTableList.Free;
    for i := TableList.Count - 1 downto 0 do
    begin
      if (OldTableList.IndexOf(TableList.Strings[i]) = -1) then
        TableList.Delete(i); //remove tables that are not in the old table list (like new tables)
    end;
    OldTableList.Free;
    ProgressBar1.Max := TableList.Count;
    //run through tables (basicinf and proj_man, profilng first) and insert data in new database
    TableList.Move(TableList.IndexOf('profilng'), 0);
    TableList.Move(TableList.IndexOf('proj_man'), 0);
    TableList.Move(TableList.IndexOf('basicinf'), 0);
    for t := 0 to TableList.Count - 1 do
    begin
      IgnoreMsg := False;
      ZReadOnlyQuery.SQL.Clear;
      SQLStr := 'SELECT ';
      //get fields of old table
      with ZQueryOldFields do
      begin
        Connection := DataModuleMain.ZConnectionDB;
        SQL.Add('SELECT * FROM ' + TableList.Strings[t]);
        SQL.Add('WHERE 1 <> 1');
        Open;
        GetFieldNames(OldFieldList);
      end;
      //get fields of new table
      with ZQueryNewFields do
      begin
        SQL.Add('SELECT * FROM ' + TableList.Strings[t]);
        SQL.Add('WHERE 1 <> 1');
        Open;
        GetFieldNames(FieldList);
      end;
      //add fields to sql query
      for f := 0 to FieldList.Count - 1 do
      begin
        if OldFieldList.IndexOf(FieldList.Strings[f]) > -1 then
          SQLStr := SQLStr + (FieldList.Strings[f] + ', ')
        else //field does not exist in old table, so needs Null or 0 value in new table
        begin
          if ZQueryNewFields.FieldByName(FieldList.Strings[f]).DataType = ftString then
            SQLStr := SQLStr + 'Null, '
          else SQLStr := SQLStr + '0, ';
        end;
      end;
      //remove last comma space
      Delete(SQLStr, Length(SQLStr) - 1, 2);
      //add FROM clause and open
      SQLStr := SQLStr + ' FROM ' + TableList.Strings[t];
      ZReadOnlyQuery.SQL.Add(SQLStr);
      ZReadOnlyQuery.Open;
      CurRec := 0;
      ProgressBar1.Max := ZReadOnlyQuery.RecordCount;
      ProgressBar1.Position := 0;
      Application.ProcessMessages;
      //run through records and add to new database
      while not ZReadOnlyQuery.EOF do
      begin
        StaticText2.Caption := 'Busy on table ' + TableList.Strings[t] + ' with record ' + IntToStr(ZReadOnlyQuery.RecNo) + ' of ' + IntToStr(ProgressBar1.Max) + '...';
        ProgressBar1.Position := CurRec;
        Application.ProcessMessages;
        ValueString := '(';
        for f := 0 to FieldList.Count -1 do
        begin
          if ZReadOnlyQuery.Fields[f].FieldName = '0' then
            ValueString := ValueString + IntToStr(ZReadOnlyQuery.RecNo) + ', '
          else
          if (ZReadOnlyQuery.Fields[f].FieldName = 'Null') OR (ZReadOnlyQuery.Fields[f].FieldName = 'GEOMETRY') then
            ValueString := ValueString + 'Null, '
          else
          if ZReadOnlyQuery.Fields[f].DataType = ftLargeInt then
            ValueString := ValueString + IntToStr(ZReadOnlyQuery.Fields[f].AsInteger) + ', '
          else
          if ZReadOnlyQuery.Fields[f].DataType = ftString then
              ValueString := ValueString + QuotedStr(ZReadOnlyQuery.Fields[f].AsString) + ', '
          else
          if ZReadOnlyQuery.Fields[f].DataType = ftFloat then
            ValueString := ValueString + FloatToStr(ZReadOnlyQuery.Fields[f].AsFloat) + ', '
          else
          if ZReadOnlyQuery.Fields[f].DataType = ftInteger then
            ValueString := ValueString + IntToStr(ZReadOnlyQuery.Fields[f].AsInteger) + ', '
          else //for BLOB with image
          if (ZQueryNewFields.Fields[f].DataType = ftBlob) and (ZQueryNewFields.Fields[f].FieldName = 'SITE_IMAGE') then
            ValueString := ValueString + ':pBlob, ' //Set to BLOB parameter
          else //for BLOB with data (e.g. report documents)
          if (ZQueryNewFields.Fields[f].DataType = ftBlob) and (ZQueryNewFields.Fields[f].FieldName = 'REP_DOC') then
            ValueString := ValueString + ':pBlob, ' //Set to BLOB parameter
          else
            ValueString := ValueString + QuotedStr(ZReadOnlyQuery.Fields[f].AsString) + ', ';
        end;
        //remove last comma and add bracket
        Delete(ValueString, Length(ValueString) - 1, 2);
        ValueString := ValueString + ')';
        //insert the Value String into the table of the new database
        if TableList.Strings[t] = 'basicimg' then //use ZQueryImg to update
        begin
          if not ZReadOnlyQuery.FieldByName('SITE_IMAGE').IsNull then
          begin
            try
              Stream := ZReadOnlyQuery.CreateBlobStream(ZReadOnlyQuery.FieldByName('SITE_IMAGE'), bmRead);
              ZQueryImg.SQL.Clear;
              ExeStr := 'INSERT INTO basicimg VALUES ' + ValueString;
              ZQueryImg.SQL.Add(ExeStr);
              ZQueryImg.Params[0].DataType := ftBlob;
              ZQueryImg.Params[0].LoadFromStream(Stream, ftBlob);
              ZQueryImg.ExecSQL;
            except on E: Exception do
              begin
                Application.ProcessMessages;
                if not IgnoreMsg then
                  if MessageDlg(E.Message + '. Record will not be inserted into the new database in order to retain integrity! Click <Ignore> to stop receiving error messages for table "basicimg" or <OK> to continue. Error written to "ApplyNewSQLite.log" in your workspace.', mtError, [mbOK, mbIgnore], 0) = mrIgnore then
                    IgnoreMsg := True;
                ErrorList.Add(ExeStr + ' could not be executed with record No. ' + IntToStr(CurRec));
              end;
            end;
            Stream.Free;
          end;
        end
        else
        if TableList.Strings[t] = 'rprtdocs' then //use ZQueryImg to update
        begin
          if not ZReadOnlyQuery.FieldByName('REP_DOC').IsNull then
          begin
            try
              Stream := ZReadOnlyQuery.CreateBlobStream(ZReadOnlyQuery.FieldByName('REP_DOC'), bmRead);
              ZQueryImg.SQL.Clear;
              ExeStr := 'INSERT INTO rprtdocs VALUES ' + ValueString;
              ZQueryImg.SQL.Add(ExeStr);
              ZQueryImg.Params[0].DataType := ftBlob;
              ZQueryImg.Params[0].LoadFromStream(Stream, ftBlob);
              ZQueryImg.ExecSQL;
            except on E: Exception do
              begin
                Application.ProcessMessages;
                if not IgnoreMsg then
                  if MessageDlg(E.Message + '. Record will not be inserted into the new database in order to retain integrity! Click <Ignore> to stop receiving error messages for table "basicimg" or <OK> to continue. Error written to "ApplyNewSQLite.log" in your workspace.', mtError, [mbOK, mbIgnore], 0) = mrIgnore then
                    IgnoreMsg := True;
                ErrorList.Add(ExeStr + ' could not be executed with record No. ' + IntToStr(CurRec));
              end;
            end;
            Stream.Free;
          end;
        end
        else
        try
          ExeStr := 'INSERT INTO ' + TableList.Strings[t] + ' VALUES ' + ValueString;
          ZConnectionNew.ExecuteDirect(ExeStr);
        except on E: Exception do
          begin
            Application.ProcessMessages;
            if not IgnoreMsg then
              if MessageDlg(E.Message + '. Record will not be inserted into the new database in order to retain integrity! Click <Ignore> to stop receiving error messages for table "' + TableList.Strings[t] + '" or <OK> to continue. Error written to "ApplyNewSQLite.log" in your workspace.', mtError, [mbOK, mbIgnore], 0) = mrIgnore then
                IgnoreMsg := True;
            ErrorList.Add(ExeStr + ' could not be executed with record No. ' + IntToStr(CurRec));
          end;
        end;
        Inc(CurRec);
        ZReadOnlyQuery.Next;
      end;
      ZReadOnlyQuery.Close;
      ZQueryNewFields.Close;
      ZQueryNewFields.SQL.Clear;
      ZQueryOldFields.Close;
      ZQueryOldFields.SQL.Clear;
    end;
    ErrorList.SaveToFile(WSpaceDir + DirectorySeparator + 'ApplyNewSQLite.log');
    ErrorList.Free;
    FieldList.Free;
    OldFieldList.Free;
    TableList.Free;
    //recreate the views in the new database
    try
      ZSQLProcessorViews.Execute;
    except on E: Exception do
      MessageDlg(E.Message + ' - Could not transfer some or all of the views to the new database format!', mtError, [mbOK], 0);
    end;
    //Reset NGDB_FLAG to 0 (these are set to 9 by trigger as the geometries are copied over and therefore changed
    ZConnectionNew.ExecuteDirect('UPDATE basicinf SET NGDB_FLAG = ' + IntToStr(UpdtdInBatch) + ' WHERE GEOMETRY IS NOT NULL');
    ZConnectionNew.Connected := False;
    NewSQLite := True;
    ButtonPanel1.CloseButton.Enabled := True;
    StaticText2.Caption := 'Finished applying new SQLite database';
    ProgressBar1.Max := 100;
    ProgressBar1.Position := 100;
    Application.ProcessMessages;
    ShowMessage('Remember to close the workspace now and reopen it to activate the new SQLite database!');
    BusyNewSQLite := False;
    Close;
  end
  else
    ShowMessage('Applying the new SQLite database cancelled! You can always do this at a later stage.');
end;

procedure TApplyNewSQLiteForm.ZReadOnlyQueryBeforeOpen(DataSet: TDataSet);
begin
  (DataSet as TZReadOnlyQuery).Connection := DataModuleMain.ZConnectionDB;
end;

procedure TApplyNewSQLiteForm.ZQueryOldFieldsBeforeOpen(DataSet: TDataSet);
begin
  ZQueryOldFields.Connection := DataModuleMain.ZConnectionDB;
end;

procedure TApplyNewSQLiteForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TApplyNewSQLiteForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TApplyNewSQLiteForm.FormCloseQuery(Sender: TObject;
  var CanClose: boolean);
begin
  if ZReadOnlyQuery.Active then
  begin
    MessageDlg('You cannot interrupt this process as your new SQLite format will not be applied properly!', mtWarning, [mbOK], 0);
    CanClose := False;
  end
  else CanClose := True;
end;

procedure TApplyNewSQLiteForm.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, False);
end;

end.

