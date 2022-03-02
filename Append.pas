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
unit Append;

{$MODE objfpc}

interface

uses
  LCLType, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, IniFiles,
  Buttons, StdCtrls, Db, ButtonPanel, Menus, ExtCtrls, ZDataset, ZConnection,
  Login, ZAbstractConnection;

type

  { TAppendForm }

  TAppendForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    CheckBox1: TCheckBox;
    ViewComboBox: TComboBox;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    Edit2: TEdit;
    ButtonSelect: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    OpenDialog1: TOpenDialog;
    RadioGroup1: TRadioGroup;
    TableListBox: TListBox;
    Button1: TButton;
    BasicQuery: TZReadOnlyQuery;
    ZConnectionOtherDB: TZConnection;
    procedure ButtonSelectClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure TableListBoxClick(Sender: TObject);
    procedure ZConnectionOtherDBBeforeConnect(Sender: TObject);
  private
    { Private declarations }
    OtherWSpace: AnsiString;
    UseOtherSQLitePW: Boolean;
    {$IFDEF WINDOWS}
    un, pw: String;
    {$ENDIF}
  public
    { Public declarations }
  end;

var
  AppendForm: TAppendForm;

implementation

{$R *.lfm}

uses VARINIT, MainDataModule, Appendprog;

procedure TAppendForm.ButtonSelectClick(Sender: TObject);
var
  i, RecCount: Integer;
  TempTableList, SiteIDList: TStringList;
  WSpaceValid: Boolean;
begin
  UseOtherSQLitePW := False;
  if SelectDirectory(OtherWSpace, [], 1) then
  begin
    if (not FileExists(OtherWSpace + DirectorySeparator + 'workspace.ini')) or (OtherWSpace = WSpaceDir) then
      WSpaceValid := False
    else
    begin
      //Check if it is an old Aquabase workspace
      if FileExistsExt('allsites.db', OtherWSpace) and FileExistsExt('basicinf.dbf', OtherWSpace) and FileExistsExt('workspace.ini', OtherWSpace) then
      begin
        MessageDlg('This is a previous version Aquabase (< Ver. 7.0) workspace, which cannot be opened with this version of Aquabase! Please create a new workspace and import this old version workspace first and then try again.', mtError, [mbOK], 0);
        WSpaceValid := False;
      end
      else
      begin
        //Connect to database
        try
          ZConnectionOtherDB.Connect;
          Application.ProcessMessages;
          WSpaceValid := True;
        except on E:Exception do
          begin
            Screen.Cursor := crDefault;
            MessageDlg(E.Message + ' - Error opening database connection! Please check your server and login settings!', mtError, [mbOK], 0);
            ZConnectionOtherDB.Connected := False;
            WSpaceValid := False;
          end;
        end;
        Screen.Cursor := crDefault;
      end; //checking if valid workspace
    end; //of initial checking for workspace.ini or same workspace as current
    if not WSpaceValid then
       MessageDlg('This is not a valid workspace for importing/appending or error connecting to the database!', mtError, [mbOk], 0)
    else
    begin
      Application.ProcessMessages;
      CheckBox1.Enabled := True;
      //check for duplicate SITE_ID_NRs
      Screen.Cursor := crSQLWait;
      SiteIDList := TStringList.Create;
      BasicQuery.Open;
      RecCount := BasicQuery.RecordCount;
      i := 0;
      while not BasicQuery.EOF do
      begin
        Inc(i);
        if i = RecCount then
          SiteIDList.Add(QuotedStr(BasicQuery.Fields[0].AsString))
        else
          SiteIDList.Add(QuotedStr(BasicQuery.Fields[0].AsString) + ', ');
        BasicQuery.Next;
      end;
      with BasicQuery do
      begin
        Close;
        SQL.Clear;
        Connection := DataModuleMain.ZConnectionDB;
        SQL.Add('SELECT SITE_ID_NR, NR_ON_MAP, SITE_NAME FROM basicinf WHERE SITE_ID_NR IN (');
        SQL.Add(SiteIDList.Text + ')');
        Open;
        SiteIDList.Clear;
        SiteIDList.Add('SITE_ID_NR, NR_ON_MAP, SITE_NAME');
        RecCount := RecordCount;
        if RecCount > 0 then
        begin
          while not EOF do
          begin
            SiteIDList.Add(Fields[0].AsString + ', ' + Fields[1].AsString + ', ' + Fields[2].AsString);
            Next;
          end;
          SiteIDList.SaveToFile(WSpaceDir + DirectorySeparator + 'Site_Duplicates.log');
          Screen.Cursor := crDefault;
          Application.ProcessMessages;
          MessageDlg('SITE_ID_NR Duplicate Error', 'The two workspaces have ' + IntToStr(RecCount) + ' same SITE_ID_NR(s), which would lead to duplicates and therefore key violations! These have been written to the file "Site_Duplicates.log" in your workspace. You may want to resolve this before importing or ignore because of a previously interrupted import ("basicinf" has already been imported).', mtError, [mbOK], 0);
        end
        else
      end;
      SiteIDList.Free;
      //Create the table list
      TempTableList := TStringList.Create;
      ZConnectionOtherDB.DbcConnection.GetMetadata.ClearCache;
      ZConnectionOtherDB.GetTableNames('', TempTableList);
      TempTableList.Sort;
      TempTableList.Move(TempTableList.IndexOf('profilng'), 0);
      TempTableList.Move(TempTableList.IndexOf('proj_man'), 0);
      TempTableList.Move(TempTableList.IndexOf('basicinf'), 0);
      //choose only Aquabase valid tables
      TableListBox.Items.Assign(DataModuleMain.GetValidATables(TempTableList));
      DataModuleMain.GetValidATables(TempTableList).Free;
      TempTableList.Free;
      Edit2.Text := OtherWSpace;
      Edit2.Hint := OtherWSpace;
      Edit2.ShowHint := Edit2.Text > '';
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TAppendForm.Button1Click(Sender: TObject);
begin
  TableListBox.SelectAll;
  ButtonPanel1.OKButton.Enabled := TableListBox.SelCount > 0;
end;

procedure TAppendForm.CancelButtonClick(Sender: TObject);
begin
  Screen.Cursor := crDefault;
  Close;
end;

procedure TAppendForm.CheckBox1Click(Sender: TObject);
var
  TheViews: TStringList;
begin
  if ViewComboBox.Text = '<No View>' then
  begin
    ViewComboBox.Clear;
    ViewComboBox.Items.Add('<Updating Views, please wait...>');
    ViewComboBox.ItemIndex := 0;
    Application.ProcessMessages;
    TheViews := TStringList.Create;
    DataModuleMain.GetAllViews(ZConnectionOtherDB, TheViews);
    ViewComboBox.Items.Assign(TheViews);
    TheViews.Free;
    ViewComboBox.ItemIndex := ViewComboBox.Items.IndexOf('allsites') or ViewComboBox.Items.IndexOf('ALLSITES');
  end;
  ViewComboBox.Enabled := CheckBox1.Checked;
end;

procedure TAppendForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TAppendForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TAppendForm.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
end;

procedure TAppendForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    DataModuleMain.OpenHelp(Sender);
end;

procedure TAppendForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TAppendForm.OKButtonClick(Sender: TObject);
var
  m: Integer;
begin
  with TAppendProgForm.Create(Application) do
  begin
    with ZConnectionOther do
    begin
      Protocol := ZConnectionOtherDB.Protocol;
      Database := ZConnectionOtherDB.Database;
      LibraryLocation := ZConnectionOtherDB.LibraryLocation;
      HostName := ZConnectionOtherDB.HostName;
      Port := ZConnectionOtherDB.Port;
      {$IFDEF WINDOWS}
      User:= un;
      Password := pw;
      {$ELSE}
      User := ZConnectionOtherDB.User;
      Password := ZConnectionOtherDB.Password;
      {$ENDIF}
      Tag := ZConnectionOtherDB.Tag;
      Connect;
    end;
    ZConnectionOtherDB.Disconnect;
    if CheckBox1.Checked then
    begin
      UseView := True;
      ViewToUse := ViewComboBox.Text;
    end;
    TableList := TStringList.Create;
    for m := 0 to TableListBox.Items.Count - 1 do
      if TableListBox.Selected[m] then
        TableList.Add(TableListBox.Items[m]);
    KeepChmRef := RadioGroup1.ItemIndex = 1;
    if RadioGroup1.ItemIndex = 2 then
      HiRefNr := StrToInt(Edit1.Text)
    else
      HiRefNr := 0;
    Show;
  end;
end;

procedure TAppendForm.RadioGroup1Click(Sender: TObject);
begin
  Edit1.Enabled := RadioGroup1.ItemIndex = 2;
end;

procedure TAppendForm.TableListBoxClick(Sender: TObject);
begin
  ButtonPanel1.OKButton.Enabled := TableListBox.SelCount > 0;
end;

procedure TAppendForm.ZConnectionOtherDBBeforeConnect(Sender: TObject);
var
  WSpaceIniFile: TIniFile;
  SQLiteDBExists: Boolean;
begin
  //Read the ini file for the selected workspace
  WSpaceIniFile := TIniFile.Create(OtherWSpace + DirectorySeparator + 'workspace.ini');
  with WSpaceIniFile, ZConnectionOtherDB do
  begin
    HostName := ReadString('Database', 'HostName', '');
    Port := ReadInteger('Database', 'Port', 0);
    Protocol := ReadString('Database', 'Protocol', '');
    if Protocol = 'sqlite-3' then
    begin
      UseOtherSQLitePW := ReadBool('Database', 'Password', False);
      Spatialite := ReadBool('Database', 'Spatialite', True);
      {$IFDEF WINDOWS}
      Database := ReadString('Database', 'Database', '');
      LibraryLocation := ProgramDir + '\' + SQLiteLib;
      {$ENDIF}
      {$IFDEF LINUX}
      Database := ReadString('Database', 'xDatabase', '');
      LibraryLocation := SQLiteLib;
      {$ENDIF}
      {$IFDEF DARWIN}
      Database := ReadString('Database', 'mDatabase', '');
      LibraryLocation := SQLiteLib;
      {$ENDIF}
      if Database = '' then
        Database := ReadString('Database', 'Database', '');
      if Database = '' then
        Database := ReadString('Database', 'xDatabase', '');
      if Database = '' then
        Database := ReadString('Database', 'mDatabase', '');
      Tag := 1;
    end
    else
    if Pos('mysql', Protocol) = 1 then
    begin
      Database := ReadString('Database', 'Database', '');
      {$IFDEF WINDOWS}
      LibraryLocation := ProgramDir + '\' + MySQLLib;
      {$ENDIF}
      {$IFDEF UNIX}
      LibraryLocation := MySQLLib;
      {$ENDIF}
      Tag := 2
    end
    else
    if Pos('MariaDB', Protocol) = 1 then
    begin
      Database := ReadString('Database', 'Database', '');
      {$IFDEF WINDOWS}
      LibraryLocation := ProgramDir + '\' + MariaDBLib;
      {$ENDIF}
      {$IFDEF UNIX}
      LibraryLocation := MariaDBLib;
      {$ENDIF}
      Tag := 3
    end
    else
    if Copy(Protocol, 1, 10) = 'postgresql' then
    begin
      Database := ReadString('Database', 'Database', '');
      {$IFDEF WINDOWS}
      LibraryLocation := ProgramDir + '\' + PostgreLib;
      {$ENDIF}
      {$IFDEF UNIX}
      LibraryLocation := PostgreLib;
      {$ENDIF}
      Catalog := 'pg_catalog';
      Tag := 4;
    end
    else
    if Copy(Protocol, 1, 13) = 'FreeTDS_MsSQL' then
    begin
      Database := ReadString('Database', 'Database', '');
      {$IFDEF WINDOWS}
      LibraryLocation := ProgramDir + '\' + MSsqlLib;
      ClientCodePage := 'WIN1252';
      {$ENDIF}
      {$IFDEF UNIX}
      LibraryLocation := MSsqlLib;
      ClientCodePage := 'UTF-8';
      {$ENDIF}
      Tag := 5;
    end;
  end;
  WSpaceIniFile.Free;
  if (ZConnectionOtherDB.Tag > 1) or UseOtherSQLitePW then
  begin //use Login Form
    {if (ZConnectionOtherDB.User = '') or (ZConnectionOtherDB.Password = '') then
      ZConnectionOtherDB.LoginPrompt := True
    else
      ZConnectionOtherDB.LoginPrompt := False;}
    with TLoginForm.Create(Application) do
    begin
      SQLitePW := UseSQLitePW;
      ShowModal;
      if ModalResult = mrOK then
      begin
        ZConnectionOtherDB.User := EditUserName.Text;
        ZConnectionOtherDB.Password := EditPassword.Text;
        {$IFDEF WINDOWS}
        un := EditUserName.Text;
        pw := EditPassword.Text;
        {$ENDIF}
        Free;
      end
      else
      begin
        Free;
        Abort;
      end;
    end;
  end
  else
  begin
    try
      SQLiteDBExists := True;
      //check if the database exists as per workspace.ini
      repeat
        if not FileExists(ZConnectionOtherDB.Database) then
        begin
          MessageDlg('The path to your SQLite database specified in your workspace is not correct (the database has been moved or the workspace is opened with Aquabase in another operating system)! Please locate your database again now.', mtError, [mbOK], 0);
          SQLiteDBExists := False;
          OpenDialog1.InitialDir := OtherWSpace;
          if OpenDialog1.Execute then
          begin
            SQLiteDBExists := FileExists(OpenDialog1.FileName);
            if SQLiteDBExists then
              ZConnectionOtherDB.Database := OpenDialog1.FileName;
          end;
        end;
      until SQLiteDBExists;
      Application.ProcessMessages;
      Screen.Cursor := crDefault;
    except on E:Exception do
      begin
        Application.ProcessMessages;
        Screen.Cursor := crDefault;
        MessageDlg(E.Message + ': Error opening database connection! Please check your workspace settings!', mtError, [mbOK], 0);
        ZConnectionOtherDB.Connected := False;
      end;
    end; //of try
  end; //use login form or not
end;

end.
