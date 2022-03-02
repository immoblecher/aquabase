unit imprtOldAB;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, dbf, LazFileUtils, ZDataset, Forms, Controls,
  Graphics, Dialogs, ButtonPanel, ExtCtrls, StdCtrls, db;

type

  { TImprtOldABForm }

  TImprtOldABForm = class(TForm)
    Button1: TButton;
    ButtonPanel1: TButtonPanel;
    Dbf1: TDbf;
    Label1: TLabel;
    Label2: TLabel;
    LabeledEdit1: TLabeledEdit;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    ZTable1: TZTable;
    procedure Button1Click(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { private declarations }
    ImportCancelled: Boolean;
    ErrorEncountered: Boolean;
    LogList, ProgressList: TStringList;
  public
    { public declarations }
  end;

var
  ImprtOldABForm: TImprtOldABForm;

implementation

{$R *.lfm}

uses MainDataModule, varinit;

{ TImprtOldABForm }

procedure TImprtOldABForm.Button1Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  SelectDirectoryDialog1.Options := [ofPathMustExist,ofOldStyleDialog,ofEnableSizing,ofViewDetail];
  {$ENDIF}
 if SelectDirectoryDialog1.Execute then
  begin
    if FileExistsExt('basicinf.dbf', SelectDirectoryDialog1.FileName) and
      FileExistsExt('workspace.ini', SelectDirectoryDialog1.FileName) then
    begin
      LabeledEdit1.Text := SelectDirectoryDialog1.FileName;
      Label1.Enabled := True;
    end
    else
      MessageDlg('This is not a valid previous version Aquabase DBase workspace!', mtError, [mbOK], 0);;
  end;
end;

procedure TImprtOldABForm.CancelButtonClick(Sender: TObject);
begin
  if MessageDlg('Are you sure you want to cancel the incomplete import?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    ImportCancelled := True;
    ButtonPanel1.CloseButton.Enabled := True;
    ButtonPanel1.OKButton.Enabled := False;
    ButtonPanel1.CancelButton.Enabled := False;
  end
  else
    ImportCancelled := False;
end;

procedure TImprtOldABForm.OKButtonClick(Sender: TObject);
var TableList: TStringList;
  m, f, FC, p: Word;
  RecCount: Integer;
  dbfFN: ShortString;
  sStream, dStream: TStream;
  TableFound: Boolean;
begin
  ButtonPanel1.OKButton.Enabled := False;
  ButtonPanel1.CloseButton.Enabled := False;
  ButtonPanel1.CancelButton.Enabled := True;
  TableFound := False;
  LogList := TStringList.Create;
  ProgressList := TStringList.Create;
  Label2.Visible := True;
  Dbf1.FilePath := LabeledEdit1.Text;
  TableList := TStringList.Create;
  TableList.Sorted := True;
  DataModuleMain.ZConnectionDB.GetTableNames('', '', TableList);
  ZTable1.Connection := DataModuleMain.ZConnectionDB;
  //basicinf first
  if not FileExists(WSpaceDir + DirectorySeparator + 'ImportProgress.log') then
  begin
    Dbf1.TableName := GetFileNameOnDisk('basicinf.dbf', SelectDirectoryDialog1.FileName);
    ZTable1.TableName := 'basicinf';
    Label1.Caption := 'Processing table basicinf...';
    Application.ProcessMessages;
    Dbf1.Open;
    RecCount := Dbf1.RecordCount;
    FC := Dbf1.FieldCount - 1;
    ZTable1.Open;
    ErrorEncountered := False;
    while not Dbf1.EOF do
    begin
      Label2.Caption := 'Record ' + IntToStr(Dbf1.RecNo) + ' of ' + IntToStr(RecCount);
      Application.ProcessMessages;
      if Importcancelled then Exit;
      ZTable1.Insert;
      for f := 0 to FC do
      begin
        dbfFN := Dbf1.Fields[f].FieldName;
        if ZTable1.FindField(dbfFN) <> NIL then
          ZTable1.FieldByName(dbfFN).Value := Dbf1.Fields[f].Value;
      end;
      try
        ZTable1.Post;
      except on E:EDatabaseError do
        begin
          LogList.Add(E.Message + ' in Record No. ' + IntToStr(Dbf1.RecNo) + ' of table ' + ZTable1.TableName);
          ErrorEncountered := True;
          ZTable1.Cancel;
        end;
      end;
      Dbf1.Next;
    end;
    Dbf1.Close;
    ZTable1.Close;
    TableList.Delete(TableList.IndexOf('basicinf'));
    ProgressList.Add('Finished importing table basicinf');
    ProgressList.SaveToFile(WSpaceDir + DirectorySeparator + 'ImportProgress.log');
  end
  else
  begin
    ProgressList.LoadFromFile(WSpaceDir + DirectorySeparator + 'ImportProgress.log');
    TableList.Delete(TableList.IndexOf('basicinf'));
  end;
  //then proj_man
  if FileExistsExt('proj_man.dbf', SelectDirectoryDialog1.FileName) then
  begin
    for p := 0 to ProgressList.Count - 1 do
    begin
      TableFound := Pos('proj_man', ProgressList[p]) > 0;
      if TableFound then Break;
    end;
    if not TableFound then
    begin
      Label1.Caption := 'Processing table proj_man...';
      Application.ProcessMessages;
      if Importcancelled then Exit;
      Dbf1.TableName := GetFileNameOnDisk('proj_man.dbf', SelectDirectoryDialog1.FileName);
      ZTable1.TableName := 'proj_man';
      Dbf1.Open;
      RecCount := Dbf1.RecordCount;
      FC := Dbf1.FieldCount - 1;
      ZTable1.Open;
      while not Dbf1.EOF do
      begin
        Label2.Caption := 'Record ' + IntToStr(Dbf1.RecNo) + ' of ' + IntToStr(RecCount);
        Application.ProcessMessages;
        ZTable1.Insert;
        for f := 0 to FC do
        begin
          dbfFN := Dbf1.Fields[f].FieldName;
          if ZTable1.FindField(dbfFN) <> NIL then
            ZTable1.FieldByName(dbfFN).Value := Dbf1.Fields[f].Value;
        end;
        try
          ZTable1.Post;
        except on E:EDatabaseError do
          begin
            LogList.Add(E.Message + ' in Record No. ' + IntToStr(Dbf1.RecNo) + ' of table ' + ZTable1.TableName);
            ErrorEncountered := True;
            ZTable1.Cancel;
          end;
        end;
        Dbf1.Next;
      end;
      Dbf1.Close;
      ZTable1.Close;
      TableList.Delete(TableList.IndexOf('proj_man'));
      ProgressList.Add('Finished importing table proj_man');
      ProgressList.SaveToFile(WSpaceDir + DirectorySeparator + 'ImportProgress.log');
    end
    else
      TableList.Delete(TableList.IndexOf('proj_man'));
  end;
  //last profilng
  if FileExistsExt('profilng.dbf', SelectDirectoryDialog1.FileName) then
  begin
    for p := 0 to ProgressList.Count - 1 do
    begin
      TableFound := Pos('profilng', ProgressList[p]) > 0;
      if TableFound then Break;
    end;
    if not TableFound then
    begin
      Label1.Caption := 'Processing table profilng...';
      Application.ProcessMessages;
      if Importcancelled then Exit;
      Dbf1.TableName := GetFileNameOnDisk('profilng.dbf', SelectDirectoryDialog1.FileName);
      ZTable1.TableName := 'profilng';
      Dbf1.Open;
      RecCount := Dbf1.RecordCount;
      FC := Dbf1.FieldCount - 1;
      ZTable1.Open;
      while not Dbf1.EOF do
      begin
        Label2.Caption := 'Record ' + IntToStr(Dbf1.RecNo) + ' of ' + IntToStr(RecCount);
        Application.ProcessMessages;
        ZTable1.Insert;
        for f := 0 to FC do
        begin
          dbfFN := Dbf1.Fields[f].FieldName;
          if ZTable1.FindField(dbfFN) <> NIL then
           ZTable1.FieldByName(dbfFN).Value := Dbf1.Fields[f].Value;
        end;
        try
          ZTable1.Post;
        except on E:EDatabaseError do
          begin
            LogList.Add(E.Message + ' in Record No. ' + IntToStr(Dbf1.RecNo) + ' of table ' + ZTable1.TableName);
            ErrorEncountered := True;
            ZTable1.Cancel;
          end;
        end;
        Dbf1.Next;
      end;
      Dbf1.Close;
      ZTable1.Close;
      TableList.Delete(TableList.IndexOf('profilng'));
      ProgressList.Add('Finished importing table profilng');
      ProgressList.SaveToFile(WSpaceDir + DirectorySeparator + 'ImportProgress.log');
    end
    else
      TableList.Delete(TableList.IndexOf('profilng'));
  end;
  //then all other tables
  for m := 0 to TableList.Count -1 do
  begin
    if FileExistsExt(TableList[m] + '.dbf', SelectDirectoryDialog1.FileName) then
    begin
      for p := 0 to ProgressList.Count - 1 do
      begin
        TableFound := Pos(TableList[m], ProgressList[p]) > 0;
        if TableFound then Break;
      end;
      if not TableFound then
      begin
        Dbf1.TableName := GetFileNameOnDisk(TableList[m] + '.dbf', SelectDirectoryDialog1.FileName);;
        ZTable1.TableName := TableList[m];
        Label1.Caption := 'Processing table ' + TableList[m] + '...';
        Application.ProcessMessages;
        if Importcancelled then Exit;
        Dbf1.Open;
        RecCount := Dbf1.RecordCount;
        FC := Dbf1.FieldCount - 1;
        ZTable1.Open;
        while not Dbf1.EOF do
        begin
          Label2.Caption := 'Record ' + IntToStr(Dbf1.RecNo) + ' of ' + IntToStr(RecCount);
          Application.ProcessMessages;
          ZTable1.Insert;
          for f := 0 to FC do
          begin
            dbfFN := Dbf1.Fields[f].FieldName;
            if ZTable1.FindField(dbfFN) <> NIL then
            begin
              if (DBF1.Fields[f].FieldName = 'SITE_IMAGE') and (not DBF1.Fields[f].IsNull) then
              begin //for image Blobs
                try
                  sStream := Dbf1.CreateBlobStream(Dbf1.FieldByName('SITE_IMAGE'), bmRead);
                  sStream.Position := 0;
                  dStream := ZTable1.CreateBlobStream(ZTable1.FieldByName('SITE_IMAGE'), bmWrite);
                  dStream.CopyFrom(sStream, sStream.Size);
                  dStream.Position := 0;
                  (ZTable1.FieldByName('SITE_IMAGE') as TBlobField).LoadFromStream(dStream);
                finally
                  sStream.Free;
                  dStream.Free;
                end
              end
              else
              begin
                if dbfFN = 'LIMIT' then
                  dbfFN := 'LIMITS';
                if dbfFN = 'COMMENT' then
                begin
                  if ZTable1.FindField('COMMENTS') <> NIL then
                    dbfFN := 'COMMENTS';
                end;
                ZTable1.FieldByName(dbfFN).Value := Dbf1.Fields[f].Value;
              end;
            end;
          end;
          try
            ZTable1.Post;
          except on E: EDatabaseError do
            begin
              LogList.Add(E.Message + ' in Record No. ' + IntToStr(Dbf1.RecNo) + ' of table ' + ZTable1.TableName);
              ErrorEncountered := True;
              ZTable1.Cancel;
            end;
          end;
          Dbf1.Next;
        end;
        Dbf1.Close;
        ZTable1.Close;
        ProgressList.Add('Finished importing table ' + ZTable1.TableName);
        ProgressList.SaveToFile(WSpaceDir + DirectorySeparator + 'ImportProgress.log');
      end;
    end;
  end;
  Label1.Caption := 'Finished processing previous version Aquabase workspace import.';
  Label2.Caption := '';
  Application.ProcessMessages;
  MessageDlg('Successfully imported Aquabase dBase tables into this workspace.', mtInformation, [mbOK], 0);
  if ErrorEncountered then
    MessageDlg('However, errors were encountered during import, most probably due to duplicates and/or foreign key violations in your old workspace, which were ignored. Please check number of records in old and new tables and consult the "ImportError.log" file in your workspace.', mtWarning, [mbOK], 0);
  LogList.SaveToFile(WSpaceDir + DirectorySeparator + 'ImportError.log');
  LogList.Free;
  ProgressList.Free;
  DeleteFile(WSpaceDir + DirectorySeparator + 'ImportProgress.log');
  ButtonPanel1.OKButton.Enabled := False;
  ButtonPanel1.CloseButton.Enabled := True;
  ButtonPanel1.CancelButton.Enabled := False;
  DataModuleMain.BasicinfQuery.Refresh;
  DataModuleMain.ZQueryView.Refresh;
  DataModuleMain.NrRecords := DataModuleMain.ZQueryView.RecordCount;
end;

end.

