{ Copyright (C) 2023 Immo Blecher, immo@blecher.co.za

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
unit imprtOldAB;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, dbf, LazFileUtils, ZDataset, Forms, Controls,
  Graphics, Dialogs, ButtonPanel, ExtCtrls, StdCtrls, EditBtn, db;

type

  { TImprtOldABForm }

  TImprtOldABForm = class(TForm)
    Button1: TButton;
    ButtonPanel1: TButtonPanel;
    Dbf1: TDbf;
    DirectoryEdit1: TDirectoryEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ZTable1: TZTable;
    procedure CancelButtonClick(Sender: TObject);
    procedure DirectoryEdit1AcceptDirectory(Sender: TObject; var Value: String);
    procedure DirectoryEdit1ButtonClick(Sender: TObject);
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

procedure TImprtOldABForm.DirectoryEdit1AcceptDirectory(Sender: TObject;
  var Value: String);
begin
  if Value <> WSpaceDir then
  begin
    if FileExistsExt('basicinf.dbf', Value) and
      FileExistsExt('allsites.db', Value) and
      FileExistsExt('workspace.ini', Value) then
    begin
      Label1.Enabled := True;
      ButtonPanel1.OKButton.Enabled := True;
    end
    else
    begin
      MessageDlg('This is not a valid previous version Aquabase DBase workspace!', mtError, [mbOK], 0);
      DirectoryEdit1.Directory := '';
      ButtonPanel1.OKButton.Enabled := False;
    end;
  end
  else
  begin
    MessageDlg('The current workspace cannot be selected as an Aquabase DBase workspace!', mtError, [mbOK], 0);;
    DirectoryEdit1.Directory := '';
    ButtonPanel1.OKButton.Enabled := False;
  end;
end;

procedure TImprtOldABForm.DirectoryEdit1ButtonClick(Sender: TObject);
begin
  DirectoryEdit1.Directory := WSpaceDir;
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
  Dbf1.FilePath := DirectoryEdit1.Directory;
  TableList := TStringList.Create;
  TableList.Sorted := True;
  DataModuleMain.ZConnectionDB.GetTableNames('', '', TableList);
  ZTable1.Connection := DataModuleMain.ZConnectionDB;
  //basicinf first
  if not FileExists(WSpaceDir + DirectorySeparator + 'ImportProgress.log') then
  begin
    Dbf1.TableName := GetFileNameOnDisk('basicinf.dbf', DirectoryEdit1.Directory);
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
  if FileExistsExt('proj_man.dbf', DirectoryEdit1.Directory) then
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
      Dbf1.TableName := GetFileNameOnDisk('proj_man.dbf', DirectoryEdit1.Directory);
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
  if FileExistsExt('profilng.dbf', DirectoryEdit1.Directory) then
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
      Dbf1.TableName := GetFileNameOnDisk('profilng.dbf', DirectoryEdit1.Directory);
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
    if FileExistsExt(TableList[m] + '.dbf', DirectoryEdit1.Directory) then
    begin
      for p := 0 to ProgressList.Count - 1 do
      begin
        TableFound := Pos(TableList[m], ProgressList[p]) > 0;
        if TableFound then Break;
      end;
      if not TableFound then
      begin
        Dbf1.TableName := GetFileNameOnDisk(TableList[m] + '.dbf', DirectoryEdit1.Directory);;
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

