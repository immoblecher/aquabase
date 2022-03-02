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
unit VARINIT;

{$mode objfpc}{$H+}

interface

uses
  LCLIntf, LCLType, SysUtils, Graphics, Classes, Registry, Dialogs, IniFiles,
  LazFileUtils, FileUtil, ZCompatibility;

  function  ConvertStyle(const S: String): TFontStyles;
  function  ConvertFromStyle(const Style: TFontStyles): String;
  procedure ReadRegistry;
  procedure ReadIniFile;
  procedure ReadEtc;
  function FileExistsExt(const FileName: TFileName; Directory: String): Boolean;
  function GetFileNameOnDisk(const FileName: TFileName; Directory: String): ShortString;

var
  AsN, ShowDMS, AutoEditGrid, UseSQLitePW, PrintNoInfo, UseWSpaceRepSet: Boolean;
  NewSQLite, BusyNewSQLite, Spatialite, LookForUpdate, SaveSettings, WrongDecimal: Boolean;
  HasSelection, CanCut, CanPaste: Boolean;
  WSpaceDir, ProgramDir, SettingsDir, QGISExe, CoordSysDescr: String;
  FilterName, Editing, Country, Language: ShortString;
  ChemStandard: Byte;
  CoordSysNr, OrigCoordSysNr: LongWord;
  CurrentSite, LastSiteID, CurrentTraverse, CurrentProject, CurrentRepNr: ShortString;
  DisUnit, ChemUnit, ECUnit, PressureUnit : ShortString;
  VolumeUnit, LengthUnit, TimeUnit, DiamUnit, ChemStandardDescr: ShortString;
  VolumeFactor, LengthFactor, TimeFactor, DiamFactor, ECFactor, ChemFactor, PressureFactor: Real;
  MaxRecFont, MaxAllFont, MinRecFont, MinAllFont, ReportFont, AppFont: TFont;
  Class0Font, Class1Font, Class2Font, Class3Font, Class4Font: TFont;
  MarkedSiteList: TStringList;
  LeftMargin, TopMargin, BotMargin, LLeftMargin, LTopMargin, LRightMargin: ShortInt;
  ColumnHeaderBandColor, ReportHeaderBandColor: TColor;
  AutoNumber: LongWord;
  FPointSeparator, FCommaSeparator: TFormatSettings;
  Cht1Tag, Cht2Tag: SmallInt;
  {$IFDEF WINDOWS}
  InstalledVer: ShortString;
  VerDiff: Byte;
  {$ENDIF}

const

  {$IFDEF WINDOWS}
    SQLiteLib = 'sqlite3' + SharedSuffix;
    MySQLLib = 'libmysql' + SharedSuffix;
    MariaDBLib = 'libmariadb' + SharedSuffix;
    PostgreLib = 'libpq' + SharedSuffix;
    MSsqlLib = 'sybdb' + SharedSuffix;
    VersionMessage = 'This function was not available on older Aquabase builds (your original installation), which were different from this Aquabase installation! You may have to upgrade to a newer version by running the latest Aquabase update or contacting the developers about the "Aquabase Development and Support Programme".';
  {$ENDIF}

  {$IFDEF LINUX}
  //should pick them up automatically
    SQLiteLib = ''; //'libsqlite3' + SharedSuffix;
    MySQLLib = '';  //'libmysqlclient' + SharedSuffix;
    MariaDBLib = '';  //'libmariadbclient' + SharedSuffix;
    PostgreLib = ''; //'libpq' + SharedSuffix;
    MSsqlLib = ''; //'libsybdb' + SharedSuffix; //Sybase and MSSql via FreeTDS
  {$ENDIF}

  {$IFDEF DARWIN}
    SQLiteLib = '/opt/local/lib/libsqlite3' + SharedSuffix; //installed here with BREW
    MySQLLib = 'libmysqlclient' + SharedSuffix;
    MariaDBLib = 'libmysqlclient' + SharedSuffix;
    PostgreLib = 'libpq' + SharedSuffix;
    MSsqlLib = 'libsybdb' + SharedSuffix; //Sybase and MSSql via FreeTDS
  {$ENDIF}

  SQLiteDBVer = 8;
  MySQLDBVer = 1.1;

  //NGDB_FLAGs constants
  UpdtdFromLatLong = 7; //updated X and Y after Latitude, Longitude had changed from geometry - basicinf
  UpdtdFromXY = 8; //updated after X, Y or Altitude has changed - basicinf
  UpdtdByTrigger = 9; //after geometry has changed - basicinf
  UpdtdInBatch = 10; //updated with Apply Coordinates to WGS84 to Longitude and Latitude - basicinf

  UpdtdFromPmpImprt = 8; //updated during pumptest import - waterlev, discharge, pumptest
  FinishedPmpImprt = 7; //updated during pumptest import - waterlev, discharge, pumptest

  ClassColor: Array[0..4] of TColor = (clBlue, clGreen, $0013E3F4, clRed, clPurple);

  //N as NO3, NO2 as N, N a NH4, PO4 as P
  ParamFactor: Array[0..3] of Real = (4.4263724, 0.304466833, 1.28785367, 0.3261);

implementation

uses MainDataModule;

function ConvertStyle(const S: String): TFontStyles;
begin
  if S = 'bold' then Result := [fsBold]
  else if S = 'italic' then Result := [fsItalic]
  else if S = 'underline' then Result := [fsUnderline]
  else if S = 'strikeout' then Result := [fsStrikeOut]
  else Result := [];
end;

function ConvertFromStyle(const Style: TFontStyles): String;
begin
  if Style = [fsBold] then Result := 'bold'
  else if Style = [fsItalic] then Result := 'italic'
  else if Style = [fsUnderline] then Result := 'underline'
  else if Style = [fsStrikeOut] then Result := 'strikeout'
  else Result := 'regular'
end;

procedure SetClassFonts;
begin
  Class0Font.Name := AppFont.Name;
  Class0Font.Size := AppFont.Size;
  Class0Font.Color := ClassColor[0];
  Class1Font.Name := AppFont.Name;
  Class1Font.Size := AppFont.Size;
  Class1Font.Color := ClassColor[1];
  Class2Font.Name := AppFont.Name;
  Class2Font.Size := AppFont.Size;
  Class2Font.Color := ClassColor[2];
  Class3Font.Name := AppFont.Name;
  Class3Font.Size := AppFont.Size;
  Class3Font.Color := ClassColor[3];
  Class4Font.Name := AppFont.Name;
  Class4Font.Size := AppFont.Size;
  Class4Font.Color := ClassColor[4];
end;

procedure ReadRegistry;
begin
  {$IFDEF WINDOWS}
  //Procedure to read Aquabase Settings
  with TRegistry.Create do
  begin
    //rootkey user
    OpenKey('\Software\Lazarus Projects\Aquabase', False);
    if ValueExists('LookForUpdate') then
      LookForUpdate := ReadBool('LookForUpdate')
    else LookForUpdate := True;
    Openkey('\Control Panel\International', False);
    if Country = '' then
      Country := ReadString('sCountry');
    WrongDecimal := False;
    if ReadString('sDecimal') <> '.' then
    begin
      WriteString('sDecimal', '.');
      WrongDecimal := True;
    end;
    //for backward compatibility
    OpenKey('\Software\Lazarus Projects\Aquabase\SystemPaths', False);
    ProgramDir := ReadString('InstallDir');
    //rootkey local machine
    RootKey := HKEY_LOCAL_MACHINE;
    //Aquabase installed for all users (from 7.3.8.326)
    OpenKeyReadOnly('\SOFTWARE\Lazarus Projects\Aquabase\SystemPaths');
    ProgramDir := ReadString('InstallDir');
    if Copy(ProgramDir, Length(ProgramDir), 1) = '\' then
      Delete(ProgramDir, Length(ProgramDir), 1);
    //check installed version
    OpenKeyReadOnly('\SOFTWARE\Licenses');
    InstalledVer := ReadString('718678DF-6B6F-4F46-9A26-4B971CF1DF33');
    //check fonts
    OpenKeyReadOnly('\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts');
    if ValueExists('Liberation Sans (TrueType)') then
    begin
      AppFont.Name := 'Liberation Sans';
      AppFont.Size := 8;
    end
    else
    begin
      AppFont.Name := 'MS Sans Serif';
      AppFont.Size := 9;
    end;
    SetClassFonts;
    Free;
  end;
  {$ENDIF}
end;

procedure ReadIniFile;
begin
  //for Unix rename to lowercase, just in case
  {$IFDEF UNIX}
  if not FileExists(WSpaceDir + DirectorySeparator + 'workspace.ini') then
    RenameFile(GetFileNameOnDisk('workspace.ini', WSpaceDir), WSpaceDir + DirectorySeparator + 'workspace.ini');
  {$ENDIF}
  with TIniFile.Create(WSpaceDir + DirectorySeparator + 'workspace.ini') do
  begin
    Country := ReadString('International', 'Country', 'Country unknown');
    CoordSysNr := ReadInteger('International', 'CoordSysNr', 2);
    OrigCoordSysNr := ReadInteger('International', 'OrigCoordSysNr', 2);
    CoordSysDescr := ReadString('International', 'CoordSys', 'CRS unknown');
    ShowDMS := ReadBool('International', 'DMS', False);
    //check if database is already connected, e.g. on new Workspace
    with DataModuleMain.ZConnectionDB do
    if not Connected then
    begin
      //read from .ini file
      HostName := ReadString('Database', 'HostName', '');
      Port := ReadInteger('Database', 'Port', 0);
      Protocol := ReadString('Database', 'Protocol', '');
      if Protocol = 'sqlite-3' then
      begin
        UseSQLitePW := ReadBool('Database', 'Password', False);
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
        //check if workspace was created with any other operating system and read a database file
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
        LibraryLocation := ProgramDir + '\' + MySQLLib;
        {$ENDIF}
        {$IFDEF UNIX}
        LibraryLocation := MariaDBLib;
        {$ENDIF}
        Tag := 3;
      end
      else
      if Pos('postgresql', Protocol) = 1 then
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
      if (Pos('FreeTDS', Protocol) = 1) or (Protocol = 'sybase') then
      begin
        Database := ReadString('Database', 'Database', '');
        {$IFDEF WINDOWS}
        ClientCodePage := 'WIN1252';
        LibraryLocation := ProgramDir + '\' + MSsqlLib;
        {$ENDIF}
        {$IFDEF UNIX}
        ClientCodePage := 'UTF-8';
        LibraryLocation := MSsqlLib;
        {$ENDIF}
        Tag := 5;
      end;
    end;
    AutoNumber := ReadInteger('System', 'AutoNumber', 0);
    FilterName := ReadString('Database', 'LastView', 'allsites');
    LastSiteID := ReadString('Database', 'LastSiteID', '');
    if ReadBool('Reports', 'UseSettings', False) then //read report settings for workspace
    begin
      UseWSpaceRepSet := True;
      PrintNoInfo := ReadBool('Reports', 'PrintNoInfo', False);
      LeftMargin := ReadInteger('Reports', 'LeftMargin', 20);
      TopMargin := ReadInteger('Reports', 'TopMargin', 12);
      BotMargin := ReadInteger('Reports', 'BottomMargin', 13);
      LLeftMargin := ReadInteger('Reports', 'LandscapeLeftMargin', 13);
      LTopMargin := ReadInteger('Reports', 'LandscapeTopMargin', 20);
      LRightMargin := ReadInteger('Reports', 'LandscapeRightMargin', 12);
      ColumnHeaderBandColor := ReadInteger('Reports', 'ColumnHeaderBandColour', clMoneyGreen);
      ReportHeaderBandColor := ReadInteger('Reports', 'ReportHeaderBandColour', clSilver);
      ReportFont.Name := ReadString('Reports', 'FontName', 'Arial');
      ReportFont.Size := ReadInteger('Reports', 'FontSize', 8);
      ReportFont.Color := ReadInteger('Reports', 'FontColour', clBlack);
      ReportFont.Style := ConvertStyle(ReadString('Reports', 'FontStyle', 'regular'));
    end
    else
      UseWSpaceRepSet := False;
    Free;
  end;
end;

procedure ReadEtc;
begin
  {$IFDEF LINUX}
  with TIniFile.Create('/etc/aquabase/startrc') do
  begin
    LookForUpdate := ReadBool('General', 'LookForUpdate', False);
    ProgramDir := ReadString('General', ProgramDir, '/usr/share/aquabase');
    Country := ReadString('General', Country, 'South Africa');
    AppFont.Name := ReadString('Fonts', 'AppFontName', 'Liberation Sans');
    AppFont.Size := ReadInteger('Fonts', 'AppFontSize', 8);
    SetClassFonts;
  end;
  {$ENDIF}
  {$IFDEF DARWIN}
  with TIniFile.Create('/opt/local/etc/aquabase/startrc') do
  begin
    LookForUpdate := ReadBool('General', 'LookForUpdate', False);
    ProgramDir := ReadString('General', ProgramDir, '/opt/local/share/aquabase');
    Country := ReadString('General', Country, 'South Africa');
    AppFont.Name := ReadString('Fonts', 'AppFontName', 'Microsoft Sans Serif');
    AppFont.Size := ReadInteger('Fonts', 'AppFontSize', 9);
    SetClassFonts;
  end;
  {$ENDIF}
end;

function FileExistsExt(const FileName: TFileName; Directory: String): Boolean;
begin
  Result := LowerCase(ExtractFileName(FindDiskFileCaseInsensitive(Directory + DirectorySeparator + FileName))) = FileName;
end;

function GetFileNameOnDisk(const FileName: TFileName; Directory: String): ShortString;
begin
  Result := Directory + DirectorySeparator + ExtractFileName(FindDiskFileCaseInsensitive(Directory + DirectorySeparator + FileName));
end;

initialization

  FilterName := '';
  WSpaceDir := '';
  Editing := '';
  Cht1Tag := -1;
  Cht2Tag := -1;
  AppFont := TFont.Create;
  Class0Font := TFont.Create;
  Class1Font := TFont.Create;
  Class2Font := TFont.Create;
  Class3Font := TFont.Create;
  Class4Font := TFont.Create;
  ReportFont := TFont.Create;
  with ReportFont do
  begin
    Color := clBlack;
    Name := 'Default';
    Size := 8;
  end;
  MaxRecFont := TFont.Create;
  with MaxRecFont do
  begin
    Color := clRed;
    Name := 'Default';
    Size := 9;
  end;
  MaxAllFont := TFont.Create;
  with MaxAllFont do
  begin
    Color := clMaroon;
    Name := 'Default';
    Size := 9;
  end;
  MinRecFont := TFont.Create;
  with MinRecFont do
  begin
    Color := clTeal;
    Name := 'Default';
    Size := 9;
  end;
  MinAllFont := TFont.Create;
  with MinAllFont do
  begin
    Color := clBlue;
    Name := 'Default';
    Size := 9;
  end;
  ColumnHeaderBandColor := clMoneyGreen;
  ReportHeaderBandColor := clSilver;
  // Format settings to convert a string to a float
  FPointSeparator := DefaultFormatSettings;
  FPointSeparator.DecimalSeparator := '.';
  FPointSeparator.ThousandSeparator := '#';// disable the thousand separator
  FCommaSeparator := DefaultFormatSettings;
  FCommaSeparator.DecimalSeparator := ',';
  FCommaSeparator.ThousandSeparator := '#';// disable the thousand separator
end.
