{ Copyright (C) 2020 Immo Blecher immo@blecher.co.za

  This source is free software; you can redistribute it and/or modify it under
  the terms of the GNU General Public License as published by the Free
  Software Foundation; either version 2 of the License, or (at your option)
  any later version.

  This code is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

  A copy of the GNU General Public License is available on the World Wide Web
  at http://www.gnu.org/copyleft/gpl.html. You can also obtain it by writing
  to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
  MA 02111-1307, USA.
}
unit NewWSpace;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLType, StdCtrls,
  Buttons, ExtCtrls, DbCtrls, ComCtrls, ButtonPanel, EditBtn, Inifiles, Db,
  ZDataset, ZConnection, FileUtil, Math;

type

  { TNewWSpaceForm }

  TNewWSpaceForm = class(TForm)
    BitBtnTest: TBitBtn;
    ButtonRetrieveMaria: TButton;
    ButtonRetrieveMSsql: TButton;
    ButtonPanel1: TButtonPanel;
    ComboBoxDBMaria: TComboBox;
    ComboBoxDBPostgre: TComboBox;
    ComboBoxDBMSsql: TComboBox;
    ComboBoxProtocolMaria: TComboBox;
    ComboBoxProtocolMSsql: TComboBox;
    DirectoryEdit1: TDirectoryEdit;
    Edit1: TEdit;
    EditHostMSsql: TEdit;
    EditPasswordMSsql: TEdit;
    EditPortMSsql: TEdit;
    EditHostMaria: TEdit;
    EditPasswordMaria: TEdit;
    EditPortMaria: TEdit;
    EditUserNameMaria: TEdit;
    EditUserNameMSsql: TEdit;
    Label1: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    ButtonRetrieveMySQL: TButton;
    ButtonRetrievePostgre: TButton;
    OpenDialog1: TOpenDialog;
    ComboBoxCountry: TComboBox;
    ComboBoxCoordSys: TComboBox;
    ComboBoxProtocolMySQL: TComboBox;
    ComboBoxDBMySQL: TComboBox;
    ComboBoxProtocolPostgre: TComboBox;
    EditPortMySQL: TEdit;
    EditPortPostgre: TEdit;
    EditHostMySQL: TEdit;
    EditHostPostgre: TEdit;
    EditPasswordmySQL: TEdit;
    EditPasswordPostgre: TEdit;
    EditPasswdSQLite: TEdit;
    EditUserNameMySQL: TEdit;
    EditUserNamePostgre: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    Label15: TLabel;
    CoordLabel: TLabel;
    PageControl1: TPageControl;
    PWCheckBox: TCheckBox;
    SpeedButton1: TSpeedButton;
    TabSheetSQLite: TTabSheet;
    TabSheetMySQL: TTabSheet;
    TabSheetPostgre: TTabSheet;
    TabSheetMariaDB: TTabSheet;
    TabSheetMSsql: TTabSheet;
    TestButton: TPanelBitBtn;
    ZConnection1: TZConnection;
    PostgreDBQuery: TZReadOnlyQuery;
    ZQueryCountries: TZReadOnlyQuery;
    procedure ButtonRetrieveMariaClick(Sender: TObject);
    procedure ButtonRetrieveMSsqlClick(Sender: TObject);
    procedure ComboBoxCountryChange(Sender: TObject);
    procedure DirectoryEdit1AcceptDirectory(Sender: TObject; var Value: String);
    procedure DirectoryEdit1ButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure ButtonRetrieveMySQLClick(Sender: TObject);
    procedure ButtonRetrievePostgreClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure PWCheckBoxClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure TestButtonClick(Sender: TObject);
  private
    { Private declarations }
    ConnectionSuccess: Boolean;
  public
    { Public declarations }
  end;

var
  NewWSpaceForm: TNewWSpaceForm;

implementation

uses VARINIT, MainDataModule;

{$R *.lfm}

procedure TNewWSpaceForm.ButtonRetrieveMySQLClick(Sender: TObject);
begin
  with ZConnection1 do
  begin
    HostName := EditHostMySQL.Text;
    Port := StrToInt(EditPortMySQL.Text);
    Protocol := ComboBoxProtocolMySQL.Text;
    {$IFDEF WINDOWS}
      LibraryLocation := ProgramDir + '\libmysql.dll';
    {$ENDIF}
    {$IFDEF UNIX}
      LibraryLocation := MySQLLib;
    {$ENDIF}
    User := EditUserNameMySQL.Text;
    Password := EditPasswordMySQL.Text;
    Database := '';
    try
      Screen.Cursor := crSQLWait;
      Connect;
      with ComboBoxDBMySQL do
      begin
        GetCatalogNames(Items);
        Items.Delete(ComboBoxDBMySQL.Items.IndexOf('information_schema'));
        Items.Delete(ComboBoxDBMySQL.Items.IndexOf('mysql'));
        Items.Delete(ComboBoxDBMySQL.Items.IndexOf('performance_schema'));
        ItemIndex := 0;
      end;
      Screen.Cursor := crDefault;
      MessageDlg('Connection to MySQL server successful and databases/schemas retrieved!', mtInformation, [mbOK], mrOK);
    except on E: Exception do
      begin
        Screen.Cursor := crDefault;
        MessageDlg(E.Message + ' Could not connect to MySQL server with current settings!', mtError, [mbOK], mrOK);
      end;
    end;
  end;
end;

procedure TNewWSpaceForm.ButtonRetrievePostgreClick(Sender: TObject);
begin
  with ZConnection1 do
  begin
    HostName := EditHostPostgre.Text;
    Port := StrToInt(EditPortPostgre.Text);
    Protocol := ComboBoxProtocolPostgre.Text;
    {$IFDEF WINDOWS}
      LibraryLocation := ProgramDir + '\libpq.dll';
    {$ENDIF}
    {$IFDEF UNIX}
      LibraryLocation := PostgreLib;
    {$ENDIF}
    User := EditUserNamePostgre.Text;
    Password := EditPasswordPostgre.Text;
    Database := 'postgres';
    try
      Screen.Cursor := crSQLWait;
      Connect;
      with PostgreDBQuery do
      begin
        Open;
        ComboBoxDBPostgre.Clear;
        while not EOF do
        begin
          if (Fields[0].AsString <> 'postgres') and (Pos('template', Fields[0].AsString) = 0) then
            ComboBoxDBPostgre.Items.Add(Fields[0].AsString);
          Next;
        end;
        Close;
      end;
      Screen.Cursor := crDefault;
      ComboBoxDBPostgre.ItemIndex := 0;
      MessageDlg('Connection to PostgreSQL server successful and databases/schemas retrieved!', mtInformation, [mbOK], mrOK);
      Disconnect;
    except on E: Exception do
      begin
        Disconnect;
        Screen.Cursor := crDefault;
        MessageDlg(E.Message + ' Could not connect to PostgreSQL server with current settings!', mtError, [mbOK], mrOK);
      end;
    end;
  end;
end;

procedure TNewWSpaceForm.PageControl1Change(Sender: TObject);
begin
  ConnectionSuccess := False;
  ButtonPanel1.OKButton.Enabled := False;
end;

procedure TNewWSpaceForm.ComboBoxCountryChange(Sender: TObject);
begin
  ComboBoxCoordSys.Clear;
  with DataModuleMain.ZQueryProj do
  begin
    //check for "St. Islands" spellings
    if Pos('St ', ComboBoxCountry.Text) = 1 then
      begin
        if Pos('Helena', ComboBoxCountry.Text) > 1 then
          Params[0].AsString := '%Helena Island%'
        else
        if Pos('Vincent', ComboBoxCountry.Text) > 1 then
          Params[0].AsString := '%Vincent%'
        else
          Params[0].AsString := '%' + Copy(ComboBoxCountry.Text, 4, 12) + '%'
      end
    else
      Params[0].AsString := '%' + ComboBoxCountry.Text + '%';
    Open;
    //Fill coordinate systems combobox
    while not EOF do
    begin
      ComboBoxCoordSys.Items.Add(Fields[1].Value);
      Next;
    end;
    Close
  end;
  //for LO countries
  if ComboBoxCountry.Text = 'South Africa' then
  begin
    ComboBoxCoordSys.Items.Add('Cape (LO from Map Reference)');
    ComboBoxCoordSys.Items.Add('Hartebeethoek94 (LO from Map Reference)');
  end
  else
  if ComboBoxCountry.Text = 'Lesotho' then
  begin
    ComboBoxCoordSys.Items.Add('Cape (LO from Map Reference)');
    ComboBoxCoordSys.Items.Add('Hartebeethoek94 (LO from Map Reference)');
  end
  else
  if ComboBoxCountry.Text = 'Namibia' then
  begin
    ComboBoxCoordSys.Items.Add('Schwarzeck (LO from Map Reference)');
  end;
  //set combobox to WGS84 if exists otherwise 0
  if ComboBoxCoordSys.Items.IndexOf('WGS 84 (geographic 3D)') > -1 then
    ComboBoxCoordSys.ItemIndex := ComboBoxCoordSys.Items.IndexOf('WGS 84 (geographic 3D)')
  else
    ComboBoxCoordSys.ItemIndex := 0;
end;

procedure TNewWSpaceForm.DirectoryEdit1AcceptDirectory(Sender: TObject;
  var Value: String);
begin
  if FileExistsExt('workspace.ini', Value) then
  begin
    DirectoryEdit1.Text := '';
    BitBtnTest.Enabled := False;
    MessageDlg('This folder is a workspace already! Please choose a different folder.',
      mtWarning, [mbOK], 0);
  end
  else
  if not FileExistsExt('workspace.ini', Value)
    and not FileExistsExt('aquabase.exe', Value) then
  begin
    WSpaceDir := Value;
    if Edit1.Text = '' then //database is not selected yet
      Edit1.Text := WSpaceDir + DirectorySeparator + ExtractFilename(WSpaceDir) + '.sqlite';
    BitBtnTest.Enabled := True;
  end;
end;

procedure TNewWSpaceForm.DirectoryEdit1ButtonClick(Sender: TObject);
begin
  DirectoryEdit1.RootDir := GetUserDir;
end;

procedure TNewWSpaceForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  with DataModuleMain do
  begin
    ZQueryProj.Close;
    ZConnectionProj.Disconnect;
  end;
end;

procedure TNewWSpaceForm.FormCreate(Sender: TObject);
var
  i: Byte;
  Protocols: TStringList;
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  BitBtnTest.Width := 120;
  BitBtnTest.Height := 26;
  //PageControl1.ActivePageIndex := 1; //dont show 1st invisible page
  DataModuleMain.ZConnectionLanguage.Connect;
  with ZQueryCountries do
  begin
    Open;
    //Fill Country combobox
    while not EOF do
    begin
      ComboBoxCountry.Items.Add(Fields[0].AsString);
      Next;
    end;
    Close;
  end;
  ComboBoxCountry.ItemIndex := ComboBoxCountry.Items.IndexOf('South Africa') ;
  DataModuleMain.ZConnectionProj.Connect;
  with DataModuleMain.ZQueryProj do
  begin
    Params[0].AsString := '%' + ComboBoxCountry.Text + '%';
    Open;
    //Fill coordinate systems combobox
    while not EOF do
    begin
      ComboBoxCoordSys.Items.Add(Fields[1].Value);
      Next;
    end;
    Close;
  end;
  ComboBoxCoordSys.Items.Add('Cape (LO from Map Reference)');
  ComboBoxCoordSys.Items.Add('Hartebeesthoek94 (LO from Map Reference)');
  ComboBoxCoordSys.ItemIndex := ComboBoxCoordSys.Items.IndexOf('Hartebeesthoek94 (geographic 3D)');
  //Fill protocol comboboxes
  Protocols := TStringList.Create;
  DataModuleMain.ZConnectionSettings.GetProtocolNames(Protocols);
  for i := 0 to Protocols.Count -1 do //MySQL
  begin
    if Pos('mysql', Protocols.Strings[i]) = 1 then
    begin
      ComboboxProtocolMySQL.Items.Add(Protocols.Strings[i]);
    end;
  end;
  ComboBoxProtocolMySQL.ItemIndex := 0;
  for i := 0 to Protocols.Count -1 do //PostgreSQL
  begin
    if Pos('postgresql', Protocols.Strings[i]) = 1 then
    begin
      ComboboxProtocolPostgre.Items.Add(Protocols.Strings[i]);
    end;
  end;
  ComboBoxProtocolPostgre.ItemIndex := 0;
  Protocols.Free;
end;

procedure TNewWSpaceForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TNewWSpaceForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TNewWSpaceForm.ButtonRetrieveMariaClick(Sender: TObject);
begin
  with ZConnection1 do
  begin
    HostName := EditHostMaria.Text;
    Port := StrToInt(EditPortMaria.Text);
    Protocol := ComboBoxProtocolMaria.Text;
    {$IFDEF WINDOWS}
      LibraryLocation := ProgramDir + '\' + MariaDBLib;
    {$ENDIF}
    {$IFDEF UNIX}
      LibraryLocation := MariaDBLib;
    {$ENDIF}
    User := EditUserNameMaria.Text;
    Password := EditPasswordMaria.Text;
    Database := '';
    try
      Connect;
      with ComboBoxDBMaria do
      begin
        GetCatalogNames(Items);
        Items.Delete(ComboBoxDBMaria.Items.IndexOf('information_schema'));
        Items.Delete(ComboBoxDBMaria.Items.IndexOf('mysql'));
        Items.Delete(ComboBoxDBMaria.Items.IndexOf('performance_schema'));
        ItemIndex := 0;
      end;
      Disconnect;
      MessageDlg('Connection to MariaDB server successful and databases/schemas retrieved!', mtInformation, [mbOK], mrOK);
    except on E: Exception do
      begin
        Disconnect;
        MessageDlg(E. Message + ' Could not connect to MariaDB server with current settings!', mtError, [mbOK], mrOK);
      end;
    end;
  end;
end;

procedure TNewWSpaceForm.ButtonRetrieveMSsqlClick(Sender: TObject);
begin
  with ZConnection1 do
  begin
    HostName := EditHostMSsql.Text;
    Port := StrToInt(EditPortMSsql.Text);
    Protocol := ComboBoxProtocolMSsql.Text;
    if Copy(Protocol, 1, 13) = 'FreeTDS_MsSQL' then
    begin
      {$IFDEF UNIX}
      LibraryLocation := MSsqlLib;
      ClientCodePage := 'UTF-8';
      {$ENDIF}
      {$IFDEF WINDOWS}
      ClientCodePage := 'WIN1252';
      LibraryLocation := ProgramDir + '\' + MSsqlLib;
      {$ENDIF}
    end;
    User := EditUserNameMSsql.Text;
    Password := EditPasswordMSsql.Text;
    try
      Connect;
      with ComboBoxDBMSsql do
      begin
        GetCatalogNames(Items);
        Items.Delete(ComboBoxDBMSsql.Items.IndexOf('master'));
        Items.Delete(ComboBoxDBMSsql.Items.IndexOf('model'));
        Items.Delete(ComboBoxDBMSsql.Items.IndexOf('msdb'));
        Items.Delete(ComboBoxDBMSsql.Items.IndexOf('tempdb'));
        ItemIndex := 0;
      end;
      Disconnect;
      MessageDlg('Connection to MS SQLServer server successful and databases/schemas retrieved!', mtInformation, [mbOK], mrOK);
    except on E: Exception do
      begin
        Disconnect;
        MessageDlg(E. Message + ' Could not connect to MS SQLServer server with current settings!', mtError, [mbOK], mrOK);
      end;
    end;
  end;
end;

procedure TNewWSpaceForm.OKButtonClick(Sender: TObject);
var
  WSpaceIniFile: TIniFile;
begin
  WSpaceDir := DirectoryEdit1.Text;
  CopyFile(ProgramDir + DirectorySeparator + 'defaults' + DirectorySeparator + 'workspace.ini', WSpaceDir + DirectorySeparator + 'workspace.ini', True);
  if (not FileExists(WspaceDir + DirectorySeparator + 'userlogo.jpg')) and (not FileExists(WspaceDir + DirectorySeparator + 'userlogo.bmp')) then
    CopyFile(ProgramDir + DirectorySeparator + 'splash_logo.jpg', WSpaceDir + DirectorySeparator + 'userlogo.jpg', True);
  WSpaceIniFile := TIniFile.Create(WSpaceDir + DirectorySeparator + 'workspace.ini');
  Country := ComboBoxCountry.Text;
  WSpaceIniFile.WriteString('International', 'Country', Country);
  WSpaceIniFile.WriteString('International', 'CoordSys', ComboBoxCoordSys.Text);
  //check for LO from Map Ref first and set CoordSyNr
  if Pos('LO from Map', ComboBoxCoordSys.Text) >= 1 then
  begin
    if Country = 'South Africa' then
    begin
      if Pos('Cape', ComboBoxCoordSys.Text) = 1 then
        CoordSysNr := 2
      else
        CoordSysNr := 1;
    end
    else
    if Country = 'Lesotho' then
    begin
      if Pos('Cape', ComboBoxCoordSys.Text) = 1 then
        CoordSysNr := 4
      else
        CoordSysNr := 3;
    end
    else
    if Country = 'Namibia' then
    begin
      CoordSysNr := 7;
    end;
  end
  else //for all non-LO
  with DataModuleMain.ZQueryProj do
  begin
    Open;
    Locate('crs', ComboBoxCoordSys.Text, []);
    CoordSysNr := FieldByName('SRID').AsInteger;
    Close;
  end;
  WSpaceIniFile.WriteInteger('International', 'CoordSysNr', CoordSysNr);
  WSpaceIniFile.WriteInteger('International', 'OrigCoordSysNr', CoordSysNr);
  //check if coordinates are LO
  srcLO := InRange(OrigCoordSysNr, 1, 7)
    or InRange(OrigCoordSysNr, 2046, 2055)
    or InRange(OrigCoordSysNr, 22275, 22293) //all RSA LOs
    or InRange(OrigCoordSysNr, 29371, 29385); //all Nam LOs
  dstLO := srcLO;
  case PageControl1.ActivePage.Tag of
    1: begin //sqlite
         if (not FileExists(Edit1.Text)) and (not ConnectionSuccess) then
         begin
           MessageDlg('The SQLite/SpatiaLite database does not exist! It will now be created in your workspace folder.',
             mtInformation, [mbOK], mrOK);
           CopyFile(ProgramDir + DirectorySeparator + 'Databases' + DirectorySeparator + 'SQLite' + DirectorySeparator + 'aquabase.sqlite', WSpaceDir + DirectorySeparator + ExtractFileName(WSpaceDir) + '.sqlite');
         end;
         WSpaceIniFile.WriteString('Database', 'Protocol', 'sqlite-3');
         {$IFDEF WINDOWS}
           WSpaceIniFile.WriteString('Database', 'Database', Edit1.Text);
         {$ENDIF}
         {$IFDEF LINUX}
           WSpaceIniFile.WriteString('Database', 'xDatabase', Edit1.Text);
         {$ENDIF}
         {$IFDEF DARWIN}
           WSpaceIniFile.WriteString('Database', 'mDatabase', Edit1.Text);
         {$ENDIF}
         DataModuleMain.ZConnectionDB.Database := Edit1.Text;
         if PWCheckBox.Checked then
           WSpaceIniFile.WriteBool('Database', 'Password', True);
       end;
    2: begin //Mysql
         DataModuleMain.ZConnectionDB.User := EditUserNameMySQL.Text;
         DataModuleMain.ZConnectionDB.Password := EditPasswordMySQL.Text;
         DataModuleMain.ZConnectionDB.Tag := 2;
         with WSpaceIniFile do
         begin
           WriteString('Database', 'Protocol', ComboBoxProtocolMySQL.Text);
           WriteString('Database', 'Database', ComboBoxDBMySQL.Text);
           WriteString('Database', 'HostName', EditHostMySQL.Text);
           WriteInteger('Database', 'Port', StrToInt(EditPortMySQL.Text));
           WriteString('Database', 'LibraryLocation', ZConnection1.LibraryLocation);
         end;
       end;
    3: begin //MariaDB
         DataModuleMain.ZConnectionDB.User := EditUserNameMaria.Text;
         DataModuleMain.ZConnectionDB.Password := EditPasswordMaria.Text;
         DataModuleMain.ZConnectionDB.Tag := 3;
         with WSpaceIniFile do
         begin
           WriteString('Database', 'Protocol', ComboBoxProtocolMaria.Text);
           WriteString('Database', 'Database', ComboBoxDBMaria.Text);
           WriteString('Database', 'HostName', EditHostMaria.Text);
           WriteInteger('Database', 'Port', StrToInt(EditPortMaria.Text));
           WriteString('Database', 'LibraryLocation', ZConnection1.LibraryLocation);
         end;
       end;
    4: begin //Postgresl
         DataModuleMain.ZConnectionDB.User := EditUserNamePostgre.Text;
         DataModuleMain.ZConnectionDB.Password := EditPasswordPostgre.Text;
         DataModuleMain.ZConnectionDB.Tag := 4;
         with WSpaceIniFile do
         begin
           WriteString('Database', 'Protocol', ComboBoxProtocolPostgre.Text);
           WriteString('Database', 'Database', ComboBoxDBPostgre.Text);
           WriteString('Database', 'HostName', EditHostPostgre.Text);
           WriteInteger('Database', 'Port', StrToInt(EditPortPostgre.Text));
           WriteString('Database', 'LibraryLocation', ZConnection1.LibraryLocation);
         end;
       end;
    5: begin //SQLServer
         DataModuleMain.ZConnectionDB.User := EditUserNameMSsql.Text;
         DataModuleMain.ZConnectionDB.Password := EditPasswordMSsql.Text;
         DataModuleMain.ZConnectionDB.Tag := 5;
         with WSpaceIniFile do
         begin
           WriteString('Database', 'Protocol', ComboBoxProtocolMSsql.Text);
           WriteString('Database', 'Database', ComboBoxDBMSsql.Text);
           WriteString('Database', 'HostName', EditHostMSsql.Text);
           WriteInteger('Database', 'Port', StrToInt(EditPortMSsql.Text));
           WriteString('Database', 'LibraryLocation', ZConnection1.LibraryLocation);
         end;
       end;
  end; //of case
  WSpaceIniFile.Free;
end;

procedure TNewWSpaceForm.PWCheckBoxClick(Sender: TObject);
begin
  EditPasswdSQLite.Enabled := PWCheckBox.Checked;
end;

procedure TNewWSpaceForm.SpeedButton1Click(Sender: TObject);
begin
  if Edit1.Text > '' then
    OpenDialog1.InitialDir := ExtractFilePath(Edit1.Text)
  else
    OpenDialog1.InitialDir := GetUserDir;
  if OpenDialog1.Execute then
  //check if it is a valid Aquabase SQLite database
  with ZConnection1 do
  begin
    Database := OpenDialog1.FileName;
    Protocol := 'sqlite-3';
    Connect;
    try
      ExecuteDirect('select site_id_nr from basicinf where 1 <> 1');
      Edit1.Text := OpenDialog1.FileName;
    except on E: Exception do
      MessageDlg('This does not seem to be a valid Aquabase SQLite database!', mtError, [mbOK], 0);
    end;
    Disconnect;
    Database := '';
    Protocol := '';
  end;
end;

procedure TNewWSpaceForm.TestButtonClick(Sender: TObject);
begin
  ConnectionSuccess := False;
  if PageControl1.ActivePage = TabSheetSQLite then
  begin
    if not FileExists(Edit1.Text) then
    begin
      MessageDlg('The SQLite/SpatiaLite database does not exist! It will now be created in your workspace folder.',
        mtInformation, [mbOK], mrOK);
      CopyFile(ProgramDir + DirectorySeparator + 'Databases' + DirectorySeparator + 'SQLite' + DirectorySeparator + 'aquabase.sqlite', WSpaceDir + DirectorySeparator + ExtractFileName(WSpaceDir) + '.sqlite');
    end;
    with ZConnection1 do
    begin
      Protocol := 'sqlite-3';
      {$IFDEF WINDOWS}
        LibraryLocation := ProgramDir + '\' + SQLiteLib;
      {$ENDIF}
      {$IFDEF UNIX}
        LibraryLocation := SQLiteLib;
      {$ENDIF}
      Password := EditPasswdSQLite.Text;
      Database := Edit1.Text;
      try
        Connect;
        //check if it is a valid Aquabase database
        ConnectionSuccess := ExecuteDirect('select site_id_nr from basicinf where 1 <> 1');
        MessageDlg('Connection to SQLite/SpatiaLite database successful!', mtInformation, [mbOK], mrOK);
      except on E: Exception do
        MessageDlg(E. Message + ': Could not connect to SQLite/SpatiaLite database with current settings or this is not a valid Aquabase database!', mtError, [mbOK], mrOK);
      end;
    end;
  end
  else if PageControl1.ActivePage = TabSheetMySQL then
  with ZConnection1 do
  begin
    HostName := EditHostMySQL.Text;
    Port := StrToInt(EditPortMySQL.Text);
    Protocol := ComboBoxProtocolMySQL.Text;
    {$IFDEF WINDOWS}
      LibraryLocation := ProgramDir + '\' + MySQLLib;
    {$ENDIF}
    {$IFDEF UNIX}
      LibraryLocation := MySQLLib;
    {$ENDIF}
    User := EditUserNameMySQL.Text;
    Password := EditPasswordMySQL.Text;
    Database := ComboBoxDBMySQL.Text;
    try
      Connect;
      //check if it is a valid Aquabase database
      ConnectionSuccess := ExecuteDirect('select site_id_nr from basicinf where 1 <> 1');
      MessageDlg('Connection to MySQL server successful!', mtInformation, [mbOK], mrOK);
    except on E: Exception do
      MessageDlg(E.Message + ': Could not connect to MySQL server with current settings or this is not a valid Aquabase database!', mtError, [mbOK], mrOK);
    end
  end
  else if PageControl1.ActivePage = TabSheetMariaDB then
  with ZConnection1 do
  begin
    HostName := EditHostMaria.Text;
    Port := StrToInt(EditPortMaria.Text);
    Protocol := ComboBoxProtocolMaria.Text;
    {$IFDEF WINDOWS}
      LibraryLocation := ProgramDir + '\' + MariaDBLib;
    {$ENDIF}
    {$IFDEF UNIX}
      LibraryLocation := MariaDBLib;
    {$ENDIF}
    User := EditUserNameMaria.Text;
    Password := EditPasswordMaria.Text;
    Database := ComboBoxDBMaria.Text;
    try
      Connect;
      //check if it is a valid Aquabase database
      ConnectionSuccess := ExecuteDirect('select site_id_nr from basicinf where 1 <> 1');
      MessageDlg('Connection to MariaDB server successful!', mtInformation, [mbOK], mrOK);
    except on E: Exception do
      MessageDlg(E.Message + ': Could not connect to MariaDB server with current settings or this is not a valid Aquabase database!', mtError, [mbOK], mrOK);
    end
  end
  else if PageControl1.ActivePage = TabSheetPostgre then
  begin
    with ZConnection1 do
    begin
      HostName := EditHostPostgre.Text;
      Port := StrToInt(EditPortPostgre.Text);
      Protocol := ComboBoxProtocolPostgre.Text;
      {$IFDEF WINDOWS}
        LibraryLocation := ProgramDir + '\libpq.dll';
      {$ENDIF}
      {$IFDEF UNIX}
        LibraryLocation := PostgreLib;
      {$ENDIF}
      Catalog := 'public';
      User := EditUserNamePostgre.Text;
      Password := EditPasswordPostgre.Text;
      Database := ComboBoxDBPostgre.Text;
      try
        Connect;
        //check if it is a valid Aquabase database
        ConnectionSuccess := ExecuteDirect('select site_id_nr from basicinf where 1 <> 1');
        MessageDlg('Connection to PostgreSQL server successful!', mtInformation, [mbOK], mrOK);
      except on E: Exception do
        MessageDlg(E.Message + ': Could not connect to PostgreSQL server with current settings or this is not a valid Aquabase database!', mtError, [mbOK], mrOK);
      end;
    end
  end
  else if PageControl1.ActivePage = TabSheetMSsql then
  begin
    with ZConnection1 do
    begin
      HostName := EditHostMSsql.Text;
      Port := StrToInt(EditPortMSsql.Text);
      Protocol := ComboBoxProtocolMSsql.Text;
      {$IFDEF WINDOWS}
      LibraryLocation := ProgramDir + '\' + MSsqlLib;
      ClientCodePage := 'WIN1252';
      {$ENDIF}
      {$IFDEF UNIX}
      Protocol := MSsqlLib;
      ClientCodePage := 'UTF-8';
      {$ENDIF}
      User := EditUserNameMSsql.Text;
      Password := EditPasswordMSsql.Text;
      Database := ComboBoxDBMSsql.Text;
      try
        Connect;
        //check if it is a valid Aquabase database
        ConnectionSuccess := ExecuteDirect('select site_id_nr from basicinf where 1 <> 1');
        MessageDlg('Connection to MS SQLServer successful!', mtInformation, [mbOK], mrOK);
      except on E: Exception do
        MessageDlg(E.Message + ': Could not connect to MS SQLServer with current settings or this is not a valid Aquabase database!', mtError, [mbOK], mrOK);
      end
    end
  end;
  ZConnection1.Disconnect;
  Buttonpanel1.OKButton.Enabled := ConnectionSuccess;
end;

end.
