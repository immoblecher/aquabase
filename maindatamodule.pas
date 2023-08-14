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
unit MainDataModule;

{$mode objfpc}{$H+}

interface

uses
  Forms, Classes, sysutils, db, FileUtil, ZConnection, ZDataset, Dialogs,
  DBGrids, Controls, maskedit, IniFiles, Process, StrUtils, Graphics, ExtCtrls,
  rxlookup, Menus, ZSqlProcessor, ZSqlMetadata, ZSqlMonitor, ZDbcSqLite, math,
  rxDBGrid, ComCtrls, StdCtrls, help, ZScriptParser;

type

  { TDataModuleMain }

  TDataModuleMain = class(TDataModule)
    AquaSortTable: TZTable;
    BasicinfQuery: TZQuery;
    BasicinfQueryALTITUDE: TFloatField;
    BasicinfQueryALT_NO_1: TStringField;
    BasicinfQueryALT_NO_2: TStringField;
    BasicinfQueryBH_DIAM: TFloatField;
    BasicinfQueryCOLLAR_HI: TFloatField;
    BasicinfQueryCOORD_ACC: TStringField;
    BasicinfQueryCOORD_METH: TStringField;
    BasicinfQueryDATE_COMPL: TStringField;
    BasicinfQueryDATE_ENTRY: TStringField;
    BasicinfQueryDATE_UPDTD: TStringField;
    BasicinfQueryDEPTH: TFloatField;
    BasicinfQueryDRAINAGE_R: TStringField;
    BasicinfQueryEQUIPMENT: TStringField;
    BasicinfQueryFARM_NR: TStringField;
    BasicinfQueryINFO_SOURC: TStringField;
    BasicinfQueryLATITUDE: TFloatField;
    BasicinfQueryLONGITUDE: TFloatField;
    BasicinfQueryNGDB_FLAG: TLongintField;
    BasicinfQueryNOTES_YN: TStringField;
    BasicinfQueryNOTE_PAD: TBlobField;
    BasicinfQueryNR_ON_MAP: TStringField;
    BasicinfQueryOGR_FID: TLargeintField;
    BasicinfQueryPOTABILITY: TStringField;
    BasicinfQueryREGION_BB: TStringField;
    BasicinfQueryREGN_DESCR: TStringField;
    BasicinfQueryREGN_TYPE: TStringField;
    BasicinfQueryREP_INST: TStringField;
    BasicinfQuerySITE_ID_NR: TStringField;
    BasicinfQuerySITE_NAME: TStringField;
    BasicinfQuerySITE_PURPS: TStringField;
    BasicinfQuerySITE_SELEC: TStringField;
    BasicinfQuerySITE_STATU: TStringField;
    BasicinfQuerySITE_TYPE: TStringField;
    BasicinfQuerySURV_METH: TStringField;
    BasicinfQueryTOPO_SETTG: TStringField;
    BasicinfQueryUSE_APPLIC: TStringField;
    BasicinfQueryUSE_CONSUM: TStringField;
    BasicinfQueryX_COORD: TFloatField;
    BasicinfQueryY_COORD: TFloatField;
    CheckQuery: TZReadOnlyQuery;
    ClassTableCLASS0: TFloatField;
    ClassTableCLASS1: TFloatField;
    ClassTableCLASS2: TFloatField;
    ClassTableCLASS3: TFloatField;
    ClassTablePARAMETER: TStringField;
    ClassTablePARA_DESCR: TStringField;
    ClassTableUNIT: TStringField;
    DataSourceView: TDataSource;
    ConvCoordsQuery: TZReadOnlyQuery;
    IdleTimerSQL: TIdleTimer;
    ImageListNavs: TImageList;
    LookupTableADJECTIVE: TStringField;
    LookupTableDEFAULT_CO: TLargeintField;
    LookupTableDESCRIBE: TStringField;
    LookupTableID: TLongintField;
    LookupTableIN_NGDB: TBooleanField;
    LookupTableLEN_CODE: TStringField;
    LookupTableLEN_DESC: TStringField;
    LookupTableLOGS_BMP: TStringField;
    LookupTableSEARCH: TStringField;
    LookupTableSEARCH1: TStringField;
    LookupTableUSED_FOR: TStringField;
    LookupTableUSED_FOR1: TStringField;
    OpenDialog1: TOpenDialog;
    StandardTable: TZTable;
    StandardTablePARAMETER: TStringField;
    StandardTablePARA_DESCR: TStringField;
    StandardTablePARA_SHORT: TStringField;
    StandardTableSTDMAXHI: TFloatField;
    StandardTableSTDMAXLO: TFloatField;
    StandardTableSTDRECHI: TFloatField;
    StandardTableSTDRECLO: TFloatField;
    StandardTableUNIT: TStringField;
    StandDescrTable: TZTable;
    StandDescrTableID: TLongintField;
    StandDescrTableSTAND_DESCR: TStringField;
    StandDescrTableTABLE_NAME: TStringField;
    ZConnectionCountries: TZConnection;
    ZConnectionDefaults: TZConnection;
    ZConnectionDB: TZConnection;
    ZConnectionProj: TZConnection;
    ZConnectionSettings: TZConnection;
    ZConnectionLanguage: TZConnection;
    LookupTable: TZTable;
    UnitTable: TZTable;
    ClassTable: TZTable;
    ZQueryLookup: TZQuery;
    ZQueryMapLookup: TZReadOnlyQuery;
    ZQueryProj: TZReadOnlyQuery;
    ZQueryView: TZReadOnlyQuery;
    ZQueryViewSITE_ID_NR: TStringField;
    ZQueryDefaultLookup: TZReadOnlyQuery;
    ZQueryMap: TZReadOnlyQuery;
    ZQueryMapsheet50: TStringField;
    DBMetadata: TZSQLMetadata;
    SRIDQuery: TZReadOnlyQuery;
    ZSQLMonitor1: TZSQLMonitor;
    ZSQLProcessorDB: TZSQLProcessor;
    ZSQLProcessorLookup: TZSQLProcessor;
    procedure BasicinfQueryAfterCancel(DataSet: TDataSet);
    procedure BasicinfQueryAfterDelete(DataSet: TDataSet);
    procedure BasicinfQueryAfterOpen(DataSet: TDataSet);
    procedure BasicinfQueryAfterPost(DataSet: TDataSet);
    procedure BasicinfQueryAfterRefresh(DataSet: TDataSet);
    procedure BasicinfQueryALTITUDEGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryALTITUDESetText(Sender: TField; const aText: string);
    procedure BasicinfQueryBeforeDelete(DataSet: TDataSet);
    procedure BasicinfQueryBeforeInsert(DataSet: TDataSet);
    procedure BasicinfQueryBeforePost(DataSet: TDataSet);
    procedure BasicinfQueryBH_DIAMGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryBH_DIAMSetText(Sender: TField; const aText: string);
    procedure BasicinfQueryCOLLAR_HIGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryCOLLAR_HISetText(Sender: TField; const aText: string
      );
    procedure BasicinfQueryDATE_COMPLValidate(Sender: TField);
    procedure BasicinfQueryDEPTHGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryDEPTHSetText(Sender: TField; const aText: string);
    procedure BasicinfQueryNewRecord(DataSet: TDataSet);
    procedure BasicinfQueryPostError(DataSet: TDataSet; E: EDatabaseError;
      var DataAction: TDataAction);
    procedure BasicinfQueryREGN_TYPEValidate(Sender: TField);
    procedure BasicinfQueryX_COORDGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryX_COORDSetText(Sender: TField; const aText: string);
    procedure BasicinfQueryY_COORDGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryY_COORDSetText(Sender: TField; const aText: string);
    procedure ConvCoordsQueryBeforeOpen(DataSet: TDataSet);
    procedure DataSourceViewDataChange(Sender: TObject; Field: TField);
    procedure IdleTimerSQLTimer(Sender: TObject);
    procedure LookupTableBeforeOpen(DataSet: TDataSet);
    procedure LookupTablePostError(DataSet: TDataSet; E: EDatabaseError;
      var DataAction: TDataAction);
    function LookupValidFound(const UsedForCode, FieldValue: ShortString): Boolean;
    procedure StandardTableBeforeOpen(DataSet: TDataSet);
    procedure StandDescrTableAfterCancel(DataSet: TDataSet);
    procedure StandDescrTableAfterDelete(DataSet: TDataSet);
    procedure StandDescrTableAfterEdit(DataSet: TDataSet);
    procedure StandDescrTableAfterPost(DataSet: TDataSet);
    procedure StandDescrTableBeforeDelete(DataSet: TDataSet);
    procedure StandDescrTableBeforeEdit(DataSet: TDataSet);
    procedure StandDescrTableBeforePost(DataSet: TDataSet);
    procedure StandDescrTableNewRecord(DataSet: TDataSet);
    procedure ZConnectionCountriesAfterConnect(Sender: TObject);
    procedure ZConnectionCountriesBeforeConnect(Sender: TObject);
    procedure ZConnectionDBAfterConnect(Sender: TObject);
    procedure ZConnectionDBAfterDisconnect(Sender: TObject);
    procedure ZConnectionDBBeforeConnect(Sender: TObject);
    procedure ZConnectionDBLogin(Sender: TObject; var Username: string;
      var Password: string);
    procedure ZConnectionDefaultsAfterConnect(Sender: TObject);
    procedure ZConnectionDefaultsBeforeConnect(Sender: TObject);
    procedure ZConnectionLanguageAfterConnect(Sender: TObject);
    procedure ZConnectionLanguageBeforeConnect(Sender: TObject);
    procedure ZConnectionProjAfterConnect(Sender: TObject);
    procedure ZConnectionProjBeforeConnect(Sender: TObject);
    procedure ZConnectionSettingsAfterConnect(Sender: TObject);
    procedure ZConnectionSettingsBeforeConnect(Sender: TObject);
    procedure ZQueryProjBeforeOpen(DataSet: TDataSet);
    procedure ZQueryViewBeforeOpen(DataSet: TDataSet);
    procedure ZQueryDefaultLookupAfterClose(DataSet: TDataSet);
    procedure ZSQLProcessorDBError(Processor: TZSQLProcessor;
      StatementIndex: Integer; E: Exception;
      var ErrorHandleAction: TZErrorHandleAction);
    procedure ZQueryViewAfterOpen(DataSet: TDataSet);
    procedure ZQueryViewAfterRefresh(DataSet: TDataSet);
  private
    { private declarations }
    AddNewSite, IsNewTable: Boolean;
    NewSiteID: ShortString;
    NewX_COORD, NewY_COORD: Double;
    function GetSymbol(const PValue: Real; Parameter: ShortString): ShortString;
    function GetShortParam(const Parameter: ShortString): ShortString;
    function GetParamUnit(const Parameter: ShortString): ShortString;
  public
    { public declarations }
    {$IFDEF WINDOWS}
    un, pw: String;
    {$ENDIF}
    Bookmark1, Bookmark2: TBookmark;
    EditX, EditY: ShortString;
    CoordsEdited: Boolean;
    BasicValidFound: Boolean;
    NrRecords: LongWord;
    SpecHelpForm: THelpForm;
    CountryDB: ShortString;
    function GetChemStdFileName: ShortString;
    function TranslateCode(const UsedFor, FieldValue: ShortString): ShortString;
    procedure CheckMaskEditInput(var TheKey: char);
    function ValidateMaskEdit(Sender: TObject): Boolean;
    function GetFont(const ChemValue: Real): TFont;
    function FormatTheFloat(const TheFloat: Double): ShortString;
    procedure OpenHelp(Sender: TObject);
    procedure GetAllViews(const TheConnection: TZConnection; var TheList: TStringList);
    function GetMapRef(const SiteID: ShortString): ShortString;
    //new conversion  to get and set text
    function cs2cs(const fromX, fromY, MapRef: ShortString; srcSRID, dstSRID: LongWord; out toX, toY: ShortString): Boolean;
    procedure UpdateCoordsWithCs2cs(const Longitude, Latitude, SiteID: ShortString); //after moving point in GIS
    procedure SetComponentFontAndSize(Sender: TObject; SetLabels: Boolean);
    function GetValidATables(const InList: TStringList): TStringList;
  end;

const                            {Ca       Mg       Na       K        HCO3}
  CParam: array[0..19] of Real = (0.04990, 0.08226, 0.04350, 0.02557, 0.01639,
                                 {Cl      SO4      N          F        CO3}
                                 0.02821, 0.02082, 0.0713944, 0.05264, 0.03333,
                                 {OH      NO3      Si         Fe         Mn}
                                 0.05880, 0.01613, 0.0356049, 0.0179083, 0.0182023,
                                 {Al      Cu       Sr       Ba       SiO3}
                                 0.11120, 0.03147, 0.02283, 0.01456, 0.02629);

  LO_Country_Mid: Array of String = ('2925AA', '2928AD', '2631AA', '2631CB', '2217AA', '2421CC');

var
  DataModuleMain: TDataModuleMain;
  srcLatLong, dstLatLong, srcLO, dstLO: Boolean; //src = stored coordinates, dst = viewed coordinates
  AlwaysIgnore: Boolean;

ResourceString
  CoordMsg = 'Oops, something went wrong with a coordinate conversion! Your selected coordinate system may not be available in your database! Please upgrade your database or select a different coordinate system.';
  ChemStdDelMsg = 'Chemistry standard deleted. Your current chemistry standard is now ';
  ChemStdDelConfMsg = 'Are you really sure you want to delete the current chemistry standard? This cannot be undone! You may have to close open chemistry entry forms.';

  LongLabel = '&Longitude';
  LatLabel = 'Latit&ude';
  NorthLabel = 'Northing';
  EastLabel = 'Easting';
  YLabel = '&Y Coord.';
  XLabel = '&X Coord.';
  EditLabel = 'Editing:';
  SiteIDLabel = '&Site Identifier';
  NrLabel = '&Number';
  DistrLabel = 'Distr./&Farm Nr.';
  SiteNameLabel = 'Site Name/&Description';
  CoordAccLabel = '&Coord. Acc.';
  AltitudeLabel = '&Altitude';
  CollarLabel = 'Co&llar';
  DepthLabel = 'Dept&h';
  DiameterLabel = '&Dia.';
  SiteTypeLabel = 'Site &Type';
  DateUpdtLabel = 'Date Info updated';

  GrpBoxCaption = 'Basic Site Information';
  QckSearchCaption = 'Quick Search in "';

  WLCaption = 'Water Level';
  DisCaption = 'Discharge Rate';

implementation

{$R *.lfm}

uses VARINIT, NEWSITE, strdatetime, progressbox, Login, ButtonPanel;

{ TDataModuleMain }

//Convert from decimal degrees to degree, minute, second
function DegToDMS(coord: Real): String;
var D, M, S: ShortString;
    Min: Real;
begin
  D := FloatToStr(Int(coord));
  Min := Frac(coord) * 60;
  M := FloatToStr(Int(Min));
  M := Format('%.2d', [StrToInt(M)]);
  S :=  Format('%.*s%f', [5 - Length(Format('%f',[Frac(Min) * 60])), '00000', Frac(Min) * 60]);
  DegToDMS := D + '°' + M + '''' + S + '"';
end;

//Convert from Degree, minute, second to decimal degrees
function DMSToDeg(coord: String): Real;
var D, M, S: String;
    DecD, DecM, DecS: Double;
begin
  D := Copy(coord, 1, Pos('°', coord) - 1);
  DecD := StrToFloat(D);
  M := Copy(coord, Pos('°', coord) + 2, 2);
  DecM := StrToFloat(M)/60;
  S := Copy(coord, Pos('°', coord) + 5, 5);
  DecS := StrToFloat(S)/3600;
  if (Pos('W', coord) > 0) or (Pos('S', coord) > 0) then
    Result := -DecD - DecM - DecS
  else
    Result := DecD + DecM + DecS;
end;

function TDataModuleMain.cs2cs(const fromX, fromY, MapRef: ShortString; srcSRID, dstSRID: LongWord; out toX, toY: ShortString): Boolean;
var
  cmd, OutStr: String;
  LO: Byte;
  xValue, yValue: Double;
  gotDMS, outDMS, srcSRIDgeogr, dstSRIDgeogr: Boolean;
  ProjProc: TProcess;
  OutStrList: TStringList;
begin
  srcSRIDgeogr := False;
  dstSRIDgeogr := False;
  //check if SRIDs are geographic or not
  with SRIDQuery do
  begin
    if Locate('code', srcSRID, []) then
      srcSRIDgeogr := Pos('geographic', Fields[1].AsString) > 0 //is LatLong
    else
      srcSRIDgeogr := False;
    if Locate('code', dstSRID, []) then
      dstSRIDgeogr := Pos('geographic', Fields[1].AsString) > 0 //is LatLong
    else
      dstSRIDgeogr := False;
  end;
  //check if DMS has been sent; this prevents conversions to DMS output when posting data
  gotDMS := Pos('°', fromX) > 0;
  if srcSRIDgeogr then //is lat/long
  begin
    if gotDMS then //convert input coords to decimals, because it is lat/long
    begin
      xValue := DMStoDeg(fromX);
      yValue := DMStoDeg(fromY);
    end
    else //make floats
    begin
      xValue := StrToFloat(fromX);
      yValue := StrToFloat(fromY);
    end;
  end
  else //make floats with length factors
  begin
    xValue := StrToFloat(fromX) / LengthFactor;
    yValue := StrToFloat(fromY) / LengthFactor;
  end;
  if srcSRID = dstSRID then //don't convert, just copy from to
  begin
    Result := True;
    if dstSRIDgeogr then //check for DMS to send back
    begin
      if ShowDMS and not gotDMS then //send Degrees, minutes, seconds
      begin
        if xValue < 0 then toX := DegToDMS(Abs(xValue)) + 'W'
        else toX := DegToDMS(xValue) + 'E';
        if xValue < 100 then toX := '0' + toX;
        if yValue < 0 then toY := DegToDMS(Abs(yValue)) + 'S'
        else toY := DegToDMS(yValue) + 'N';
      end
      else
      begin
        toX := FloatToStrF(xValue, ffFixed, 15, 7);
        toY := FloatToStrF(yValue, ffFixed, 15, 7);
      end;
    end
    else
    begin
      toX := FloatToStrF(xValue * LengthFactor, ffFixed, 15, 2);
      toY := FloatToStrF(yValue * LengthFactor, ffFixed, 15, 2);
    end;
  end
  else //convert coordinates
  begin
    //check if coordinates are worked out from map reference
    if InRange(srcSRID, 1, 7) or
      InRange(dstSRID, 1, 7) then
    begin
      //replace map-referenced SRIDs relevant proper SRID
      if Copy(MapRef, 3, 2) < '11' then
        LO := 11 //smallest most western LO
      else
        LO := StrToInt(Copy(MapRef, 3,2));
      if LO and 1 <> 1 then Inc(LO); //find nearest uneven LO and replace LO
      begin
        if srcSRID IN [1,3,5] then //Hartebeesthoek
          srcSRID := 2046 + Round((LO - 15)/2) //difference between LO and 15 (lowest LO)
        else
        if srcSRID IN [2,4,6] then //Cape
          srcSRID := 22260 + LO
        else
        if srcSRID = 7 then //Schwarzeck
          srcSRID := 29360 + LO;
        if dstSRID IN [1,3,5] then //Hartebeesthoek
          dstSRID := 2046 + Round((LO - 15)/2) //difference between LO and 15 (lowest LO)
        else
        if dstSRID IN [2,4,6] then //Cape
          dstSRID := 22260 + LO
        else
        if dstSRID = 7 then //Schwarzeck
          dstSRID := 29360 + LO;
      end;
    end;
    //check for SA LO systems to swap coordinates
    if InRange(srcSRID, 2046, 2055)
      or InRange(srcSRID, 22275, 22293) //all RSA LOs
      or InRange(srcSRID, 29371, 29385) then //all Nam LOs
    begin
      //setup the command to send to cs2cs and swap X and Y
      cmd := 'echo ' + FloatToStr(yValue) + ' ' + FloatToStr(xValue) + ' | cs2cs ';
    end
    else
    begin
      //setup the command to send to cs2cs
      cmd := 'echo ' + FloatToStr(xValue) + ' ' + FloatToStr(yValue) + ' | cs2cs ';
    end;
    if dstSRIDgeogr then //is lat/long, so have 7 decimals after comma
      cmd := cmd + '-f %.7f ';
    if Proj_Version < '8.0.0' then
      cmd := cmd + '+init=EPSG:' + IntToStr(srcSRID) + ' +init=EPSG:' + IntToStr(dstSRID)
    else
      cmd := cmd + '+init=EPSG:' + IntToStr(srcSRID) + ' +to' + ' +init=EPSG:' + IntToStr(dstSRID);
    OutStrList := TStringList.Create;
    ProjProc := TProcess.Create(nil);
    with ProjProc do
    begin
      Options := [poUsePipes, poWaitOnExit];
      {$IFDEF UNIX}
      Executable := '/bin/bash';
      Parameters.Add('-c');
      {$ENDIF}
      {$IFDEF WINDOWS}
      ShowWindow := swoHIDE;
      Executable := 'c:\windows\system32\cmd.exe';
      Parameters.Add('/c');
      CurrentDirectory := ProgramDir;
      {$ENDIF}
      Parameters.Add(cmd);
      Execute;
      OutStrList.LoadFromStream(Output);
    end;
    if ProjProc.ExitStatus = 0 then
    begin
      //return the output from cs2cs as two unformatted strings
      OutStr := OutStrList[0]; //it's only one line
      outDMS := Pos('d', OutStr) > 0; //if inverse the output is in DMS
      if InRange(dstSRID, 2046, 2055)
        or InRange(dstSRID, 22275, 22293) //all RSA LOs
        or InRange(dstSRID, 29371, 29385) then //all Nam LOs
      begin //swap x and y
        xValue := StrToFloat(ExtractWord(2, OutStr, [#9, ' '])) * LengthFactor;
        yValue := StrToFloat(ExtractWord(1, OutStr, [#9])) * LengthFactor;
        toX := FloatToStrF(xValue, ffFixed, 15, 2);
        toY := FloatToStrF(yValue, ffFixed, 15, 2);
      end
      else //do not swap x and y
      begin
        if dstSRIDgeogr then //is lat/long
        begin
          if ShowDMS and not gotDMS then //show Degrees, minutes, seconds
          begin
            xValue := StrToFloat(ExtractWord(1, OutStr, [#9]));
            yValue := StrToFloat(ExtractWord(2, OutStr, [#9, ' ']));
            if xValue < 0 then toX := DegToDMS(Abs(xValue)) + 'W'
            else toX := DegToDMS(xValue) + 'E';
            if Abs(xValue) < 100 then toX := '0' + toX;
            if yValue < 0 then toY := DegToDMS(Abs(yValue)) + 'S'
            else toY := DegToDMS(yValue) + 'N';
          end
          else
          begin
            toX := ExtractWord(1, OutStr, [#9]);
            toY := ExtractWord(2, OutStr, [#9, ' ']);
          end
        end
        else
        begin
          if outDMS then
          begin
            OutStr := StringReplace(OutStr, 'd', '°', [rfReplaceAll]);
            xValue := DMSToDeg(ExtractWord(1, OutStr, [#9]));
            yValue := DMSToDeg(ExtractWord(2, OutStr, [#9, ' ']));
          end
          else
          begin
            xValue := StrToFloat(ExtractWord(1, OutStr, [#9])) * LengthFactor;
            yValue := StrToFloat(ExtractWord(2, OutStr, [#9, ' '])) * LengthFactor;
          end;
          toX := FloatToStrF(xValue, ffFixed, 15, 2);
          toY := FloatToStrF(yValue, ffFixed, 15, 2);
        end;
      end;
      Result := True;
    end
    else
      Result := False;
    ProjProc.Free;
    OutStrList.Free;
  end;
//trial with database coordinate conversions
{var
  LO: Byte;
  xValue, yValue, xTemp: Double;
  gotDMS, srcSRIDgeogr, dstSRIDgeogr: Boolean;
  stSetSRID, stMakePoint: ShortString;
begin
  srcSRIDgeogr := False;
  dstSRIDgeogr := False;
  //check if SRIDs are geographic or not
  with SRIDQuery do
  begin
    if Locate('code', IntToStr(srcSRID), []) then
      srcSRIDgeogr := Pos('geographic', Fields[1].AsString) > 0 //is LatLong
    else
      srcSRIDgeogr := False;
    if Locate('code', IntToStr(dstSRID), []) then
      dstSRIDgeogr := Pos('geographic', Fields[1].AsString) > 0 //is LatLong
    else
      dstSRIDgeogr := False;
  end;
  //check if DMS has been sent; this prevents conversions to DMS output when posting data
  gotDMS := Pos('°', fromX) > 0;
  if srcSRIDgeogr then //is lat/long
  begin
    if gotDMS then //convert input coords to decimals, because it is lat/long
    begin
      xValue := DMStoDeg(fromX);
      yValue := DMStoDeg(fromY);
    end
    else //make floats
    begin
      xValue := StrToFloat(fromX);
      yValue := StrToFloat(fromY);
    end;
  end
  else //make floats with length factors
  begin
    xValue := StrToFloat(fromX) / LengthFactor;
    yValue := StrToFloat(fromY) / LengthFactor;
  end;
  if srcSRID = dstSRID then //don't convert, just copy from to
  begin
    Result := True;
    if dstSRIDgeogr then //check for DMS to send back
    begin
      if ShowDMS and not gotDMS then //send Degrees, minutes, seconds
      begin
        if xValue < 0 then toX := DegToDMS(Abs(xValue)) + 'W'
        else toX := DegToDMS(xValue) + 'E';
        if xValue < 100 then toX := '0' + toX;
        if yValue < 0 then toY := DegToDMS(Abs(yValue)) + 'S'
        else toY := DegToDMS(yValue) + 'N';
      end
      else
      begin
        toX := FloatToStrF(xValue, ffFixed, 15, 7);
        toY := FloatToStrF(yValue, ffFixed, 15, 7);
      end;
    end
    else
    begin
      toX := FloatToStrF(xValue * LengthFactor, ffFixed, 15, 2);
      toY := FloatToStrF(yValue * LengthFactor, ffFixed, 15, 2);
    end;
  end
  else //convert coordinates
  begin
    //check if coordinates are worked out from map reference
    if InRange(srcSRID, 1, 7) or
      InRange(dstSRID, 1, 7) then
    begin
      //replace map-referenced SRIDs relevant proper SRID
      if Copy(MapRef, 3, 2) < '11' then
        LO := 11 //smallest most western LO
      else
        LO := StrToInt(Copy(MapRef, 3,2));
      if LO and 1 <> 1 then Inc(LO); //find nearest uneven LO and replace LO
      begin
        if srcSRID IN [1,3,5] then //Hartebeesthoek
          srcSRID := 2046 + Round((LO - 15)/2) //difference between LO and 15 (lowest LO)
        else
        if srcSRID IN [2,4,6] then //Cape
          srcSRID := 22260 + LO
        else
        if srcSRID = 7 then //Schwarzeck
          srcSRID := 29360 + LO;
        if dstSRID IN [1,3,5] then //Hartebeesthoek
          dstSRID := 2046 + Round((LO - 15)/2) //difference between LO and 15 (lowest LO)
        else
        if dstSRID IN [2,4,6] then //Cape
          dstSRID := 22260 + LO
        else
        if dstSRID = 7 then //Schwarzeck
          dstSRID := 29360 + LO;
      end;
    end;
    //check for LO systems to swap coordinates
    if InRange(srcSRID, 2046, 2055)
      or InRange(srcSRID, 22275, 22293) //all RSA LOs
      or InRange(srcSRID, 29371, 29385) then //all Nam LOs
    //swap x and y
    begin
      xTemp := xValue;
      xValue := yValue;
      yValue := xTemp;
    end;
    with ConvCoordsQuery do
    begin
      if ZConnectionDB.Tag = 1 then
      begin
        stSetSRID := 'SetSrid';
        stMakePoint := 'MakePoint';
      end
      else
      begin
        stSetSRID := 'ST_SetSrid';
        stMakePoint := 'ST_MakePoint';
      end;
      SQL.Clear;
      SQL.Add('select st_x(st_transform(' + stSetSrid + '(' + stMakePoint +'(' + FloatToStr(xValue)
        + ', ' + FloatToStr(yValue) + '), ' + IntToStr(srcSRID) + '), ' + IntToStr(dstSRID)
        + ')) as X, st_y(st_transform(' + stSetSrid + '(' + stMakePoint + '(' + FloatToStr(xValue)
        + ', ' + FloatToStr(yValue) + '), ' + IntToStr(srcSRID) + '), ' + IntToStr(dstSRID)
        + ')) as Y;');
      try
        Open;
        if FieldByName('X').IsNull or FieldByName('Y').IsNull then
        begin
          Result := False;
          toX := '0';
          toY := '0';
          Screen.Cursor := crDefault;
        end
        else
          Result := True;
      except
        begin
          Result := False;
          toX := '0';
          toY := '0';
          Screen.Cursor := crDefault;
        end;
      end;
      if Result = True then
      begin
        //check if destination is LO
        if InRange(dstSRID, 2046, 2055)
          or InRange(dstSRID, 22275, 22293) //all RSA LOs
          or InRange(dstSRID, 29371, 29385) then //all Nam LOs
        begin //swap x and y
          xValue := FieldByName('Y').Value * LengthFactor;
          yValue := FieldByName('X').Value * LengthFactor;
          toX := FloatToStrF(xValue, ffFixed, 15, 3);
          toY := FloatToStrF(yValue, ffFixed, 15, 3);
        end
        else //do not swap x and y
        begin
          xValue := FieldByName('X').Value * LengthFactor;
          yValue := FieldByName('Y').Value * LengthFactor;
          if dstSRIDgeogr then //is lat/long
          begin
            if ShowDMS and not gotDMS then //show Degrees, minutes, seconds
            begin
              if xValue < 0 then toX := DegToDMS(Abs(xValue)) + 'W'
              else toX := DegToDMS(xValue) + 'E';
              if Abs(xValue) < 100 then toX := '0' + toX;
              if yValue < 0 then toY := DegToDMS(Abs(yValue)) + 'S'
              else toY := DegToDMS(yValue) + 'N';
            end
            else
            begin
              toX := FloatToStrF(xValue, ffFixed, 15, 7);
              toY := FloatToStrF(yValue, ffFixed, 15, 7);
            end
          end
          else
          begin
            toX := FloatToStrF(xValue, ffFixed, 15, 3);
            toY := FloatToStrF(yValue, ffFixed, 15, 3);
          end;
        end;
        Close;
      end;
    end;
  end;}
end;

procedure TDataModuleMain.UpdateCoordsWithCs2cs(const Longitude, Latitude, SiteID: ShortString); //after moving point in GIS
var
  XStr, YStr: ShortString;
begin
  //update X_COORD and Y_COORD from Longitude/Latitude, which may have been changed by trigger
  if OrigCoordSysNr = CoordSysNr then //both are in Longitude/Latitude
  begin
    ZConnectionDB.ExecuteDirect('UPDATE basicinf SET Y_COORD = LATITUDE, X_COORD = LONGITUDE, NGDB_FLAG = ' +
      IntToStr(UpdtdFromLatLong) + ' WHERE SITE_ID_NR = ' + QuotedStr(SiteID));
  end
  else
  begin
    if cs2cs(Longitude, Latitude, GetMapRef(SiteID), 4326, OrigCoordSysNr, XStr, YStr) then
    begin
      if InRange(OrigCoordSysNr, 1, 7) then
      begin
        ZConnectionDB.ExecuteDirect('UPDATE basicinf SET Y_COORD = '
          + XStr + ', X_COORD = ' + YStr + ', NGDB_FLAG = ' +
        IntToStr(UpdtdFromLatLong) + ' WHERE SITE_ID_NR = ' + QuotedStr(SiteID));
      end
      else
      begin
        ZConnectionDB.ExecuteDirect('UPDATE basicinf SET Y_COORD = '
          + YStr + ', X_COORD = ' + XStr + ', NGDB_FLAG = '
          + IntToStr(UpdtdFromLatLong) + ' WHERE SITE_ID_NR = ' + QuotedStr(SiteID))
      end;
    end
    else
      ShowMessage(CoordMsg);
  end;
end;

procedure TDataModuleMain.SetComponentFontAndSize(Sender: TObject; SetLabels: Boolean);
var
  i: Word;
begin
  with Sender as TForm do
  for i := 0 to ComponentCount-1 do
  begin
    if (Components[i] is TControl) then
    begin
      with (Components[i] as TControl) do
      begin
        with Font do
        begin
          Name := AppFont.Name;
          Size := AppFont.Size;
        end;//Done with Font
      end;//Done with TControl
      if (Components[i] is TDBGrid) then
      begin
        (Components[i] as TDBGrid).TitleFont.Assign(AppFont);
      end
      else
      if Components[i] is TRxDBLookupCombo then
      with Components[i] as TRxDBLookupCombo do
      begin
        AutoSize := False;
        Height := 22;
      end
      else
      if (Components[i] is TRxDBGrid) then
      begin
        (Components[i] as TRxDBGrid).TitleFont.Assign(AppFont);
        (Components[i] as TRxDBGrid).DefaultRowHeight := 19;
      end
      else
      if (Components[i] is TStatusBar) then
      begin
        (Components[i] as TStatusBar).UseSystemFont := False;
        (Components[i] as TStatusBar).ParentFont := False;
        (Components[i] as TStatusBar).Font.Assign(AppFont);
      end
      else
      if (Components[i] is TButtonPanel) then
      begin
        (Components[i] as TButtonPanel).CancelButton.Font.Assign(AppFont);
        (Components[i] as TButtonPanel).CloseButton.Font.Assign(AppFont);
        (Components[i] as TButtonPanel).HelpButton.Font.Assign(AppFont);
        (Components[i] as TButtonPanel).OKButton.Font.Assign(AppFont);
      end
      else
      if (Components[i] is TLabeledEdit) then
      begin
        (Components[i] as TLabeledEdit).EditLabel.Font.Assign(AppFont);
        (Components[i] as TLabeledEdit).Font.Assign(AppFont);
      {$IFDEF LINUX}
      end
      else
      if (Components[i] is TLabel) and SetLabels then
      begin
        (Components[i] as TLabel).AutoSize := False;
        (Components[i] as TLabel).Width := (Components[i] as TLabel).Canvas.TextWidth((Components[i] as TLabel).Caption);
        (Components[i] as TLabel).Height := (Components[i] as TLabel).Canvas.TextHeight((Components[i] as TLabel).Caption);
      {$ENDIF}
      end;
    end;//End if TControl
  end;//End for-loop
end;

procedure TDataModuleMain.GetAllViews(const TheConnection: TZConnection; var TheList: TStringList);
var
  Ignore: Boolean;
  ViewQuery, DefinitionQuery: TZReadOnlyQuery;
begin
  Ignore := False;
  ViewQuery := TZReadOnlyQuery.Create(Self);
  DefinitionQuery := TZReadOnlyQuery.Create(Self);
  with DefinitionQuery do
  begin
    SQL.Clear;
    Connection := TheConnection;
    case TheConnection.Tag of
      1: SQL.AddText('SELECT name, sql FROM sqlite_master WHERE type = ' + QuotedStr('view'));
    2,3: SQL.AddText('SELECT TABLE_NAME, VIEW_DEFINITION FROM INFORMATION_SCHEMA.VIEWS WHERE table_schema = ' + QuotedStr(TheConnection.Database));
      4: SQL.AddText('select viewname, definition from pg_catalog.pg_views where schemaname NOT IN (''pg_catalog'', ''information_schema'') order by schemaname, viewname;');
      5: SQL.AddText('SELECT table_name, view_definition from INFORMATION_SCHEMA.views;');
    end; //of case
    Open;
    while not EOF do
    begin
      with ViewQuery do //check if the view can be openend and site_id_nr is 1st (distinct) field
      begin
        SQL.Clear;
        Connection := TheConnection;
        //get the structure
        case TheConnection.Tag of
        2,3: SQL.Add('SELECT * FROM `' + DefinitionQuery.Fields[0].AsString + '` WHERE 1 <> 1');
          5: SQL.Add('SELECT * FROM ' + DefinitionQuery.Fields[0].AsString + ' WHERE 1 <> 1')
        else
          SQL.Add('SELECT * FROM "' + DefinitionQuery.Fields[0].AsString + '" WHERE 1 <> 1');
        end; //of case
        try
          Open;
          if (UpperCase(Fields[0].FieldName) = 'SITE_ID_NR') then //check if distinct
          begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT count(site_id_nr) - count(distinct site_id_nr) as diff from ' + DefinitionQuery.Fields[0].AsString);
            Open;
            if Fields[0].Value = 0 then
              TheList.Add(DefinitionQuery.Fields[0].AsString);
          end;
        except on E:Exception do
          if not Ignore and not AlwaysIgnore then
            case QuestionDlg('Load Views Error', E.Message +
              ' - Please ask your database administrator to check permissions for this View, if you need access. Do you want to prevent further view permission error messages? "Always Ignore" will prevent these messages for this session.',
              mtError, [mrYesToAll, mrIgnore, 'Always Ignore', mrOK], '') of
                mrYesToAll: Ignore := True;
                mrIgnore: begin
                            Ignore := True;
                            AlwaysIgnore := True;
                          end;
            end; //of case
        end;
        Close;
      end;
      Next;
    end;
  end;
  ViewQuery.Free;
  DefinitionQuery.Free;
end;

function TDataModuleMain.GetValidATables(const InList: TStringList): TStringList;
var
  t: Word;
begin
  Result := TStringList.Create;
  with CheckQuery do
  begin
    Connection := ZConnectionSettings;
    SQL.Clear;
    SQL.Add('select FILE_NAME from Aquasort');
    Open;
    for t := InList.Count - 1 downto 0 do //check if tables are in Aquasort, otherwise delete from list
      if not Locate('FILE_NAME', InList[t], [loCaseInsensitive]) then
        InList.Delete(t);
    Close;
    Connection := ZConnectionDB;
  end;
  Result.Assign(InList);
end;

procedure TDataModuleMain.OpenHelp(Sender: TObject);
var
  n: Integer;
  FormCreatedNew: Boolean;
begin
  if SpecHelpForm = NIL then
  begin
    SpecHelpForm := THelpForm.Create(NIL);
    FormCreatedNew := True;
  end
  else
    FormCreatedNew := False;
  with SpecHelpForm do
  begin
    for n := 0 to TreeView1.Items.Count - 1 do
    begin
      if (Sender is TMenuItem) then
      begin
        if TreeView1.Items[n].SelectedIndex = (Sender as TMenuItem).HelpContext then
          TreeView1.Selected := TreeView1.Items[n];
      end
      else
      if (Sender is TOpenDialog) then
      begin
        if TreeView1.Items[n].SelectedIndex = (Sender as TOpenDialog).HelpContext then
          TreeView1.Selected := TreeView1.Items[n];
      end
      else
      if TreeView1.Items[n].SelectedIndex = (Sender as TControl).HelpContext then
        TreeView1.Selected := TreeView1.Items[n];
    end;
  end;
  if FormCreatedNew then
    SpecHelpForm.Show
  else
    SpecHelpForm.BringToFront;
end;

function TDataModuleMain.GetFont(const ChemValue: Real): TFont;
begin
  if DataModuleMain.ClassTable.Active then
  begin
    if ChemValue > ClassTableCLASS3.Value then
      Result := Class4Font
    else if ChemValue > ClassTableCLASS2.Value then
      Result := Class3Font
    else if ChemValue > ClassTableCLASS1.Value then
      Result := Class2Font
    else if ChemValue > ClassTableCLASS0.Value then
      Result := Class1Font
    else
      Result := Class0Font;
  end
  else
  begin
    if (ChemValue > StandardTableSTDMAXHI.Value) and (StandardTableSTDMAXHI.Value > -1) then
      Result := MaxAllFont
    else if (ChemValue > StandardTableSTDRECHI.Value) and (StandardTableSTDRECHI.Value > -1) then
      Result := MaxRecFont
    else if (ChemValue < StandardTableSTDMAXLO.Value) and (StandardTableSTDMAXLO.Value > -1)  then
      Result := MinAllFont
    else if (ChemValue < StandardTableSTDRECLO.Value) and (StandardTableSTDRECLO.Value > -1)  then
      Result := MinRecFont
    else Result := AppFont;
  end;
end;

function TDataModuleMain.FormatTheFloat(const TheFloat: Double): ShortString;
begin
  if TheFloat = 0 then
    Result := '0.00'
  else
  if Abs(TheFloat) < 0.001 then
    Result := FloatToStrF(TheFloat, ffFixed, 15, 5)
  else
  if Abs(TheFloat) < 0.01 then
    Result := FloatToStrF(TheFloat, ffFixed, 15, 4)
  else
  if Abs(TheFloat) < 0.1 then
    Result := FloatToStrF(TheFloat, ffFixed, 15, 3)
  else
  if Abs(TheFloat) < 1000 then
    Result := FloatToStrF(TheFloat, ffFixed, 15, 2)
  else
  if Abs(TheFloat) < 100000 then
    Result := FloatToStrF(TheFloat, ffFixed, 15, 1)
  else
    Result := FloatToStrF(TheFloat, ffFixed, 15, 0);
end;

function TDataModuleMain.ValidateMaskEdit(Sender: TObject): Boolean;
var
  s: ShortString;
begin
  Result := True;
  with (Sender as TMaskEdit) do
  begin
    s := EditText;
    if Name = 'MaskEditX' then
    begin
      if StrToFloat(Copy(s, 1, Pos('°', s) - 1)) = 180 then //minutes/seconds can only be 0
      begin
        if (StrToFloat(Copy(s, Pos('°', s) + 2, 2)) > 0) or
            (StrToFloat(Copy(s, Pos('°', s) + 5, 5)) > 0) or
              not ((Pos('E', s) > 0) or (Pos('W', s) > 0)) then
          Result := False;
      end
      else
      begin
        if (StrToFloat(Copy(s, 1, Pos('°', s) - 1)) > 180) or
          (StrToFloat(Copy(s, Pos('°', s) + 2, 2)) >= 60) or
            (StrToFloat(Copy(s, Pos('°', s) + 5, 5)) >= 60) or
              not ((Pos('E', s) > 0) or (Pos('W', s) > 0)) then
          Result := False;
      end;
    end
    else
    begin
      if StrToFloat(Copy(s, 1, Pos('°', s) - 1)) = 90 then //minutes/seconds can only be 0
      begin
        if (StrToFloat(Copy(s, Pos('°', s) + 2, 2)) > 0) or
            (StrToFloat(Copy(s, Pos('°', s) + 5, 5)) > 0) or
              not ((Pos('N', s) > 0) or (Pos('S', s) > 0)) then
          Result := False;
      end
      else
      begin
        if (StrToFloat(Copy(s, 1, Pos('°', s) - 1)) > 90) or
          (StrToFloat(Copy(s, Pos('°', s) + 2, 2)) >= 60) or
            (StrToFloat(Copy(s, Pos('°', s) + 5, 5)) >= 60) or
              not ((Pos('N', s) > 0) or (Pos('S', s) > 0)) then
          Result := False;
      end;
    end;
  end;
end;

procedure TDataModuleMain.CheckMaskEditInput(var TheKey: char);
begin
  CoordsEdited := False;
  if BasicinfQuery.State IN [dsInsert, dsEdit] then
  begin
    if ShowDMS then
    begin
      if not (TheKey in ['0'..'9', '.', 'E', 'W', 'N', 'S', 'e', 'w', 'n', 's', #8, #9, #22, #24]) then TheKey := #0
      else
      if TheKey in ['0'..'9', '.', 'E', 'W', 'N', 'S', 'e', 'w', 'n', 's', #8, #22, #24] then //numbers, point, Backspace, Paste, Cut
        CoordsEdited := True;
    end
    else
    begin
      if not (TheKey in ['0'..'9', '-', '.', #176, #39, #8, #9, #22, #24]) then TheKey := #0
      else
      if TheKey in ['0'..'9', '-', '.', #8, #22, #24] then //numbers, minus, point, Backspace, Paste, Cut
        CoordsEdited := True;
    end;
  end
  else
    TheKey := #0;//to prevent editing the maskedit
end;

function TDataModuleMain.TranslateCode(const UsedFor, FieldValue: ShortString): ShortString;
begin
  LookupTable.Filter := 'USED_FOR = ' + QuotedStr(UsedFor);
  LookupTable.Filtered := True;
  if LookupTable.Locate('SEARCH', FieldValue, []) then
    Result := LookupTableDESCRIBE.Value
  else Result := 'No info or invalid code';
  LookupTable.Filtered := False;
end;

function TDataModuleMain.LookupValidFound(const UsedForCode,
  FieldValue: ShortString): Boolean;
begin
  LookupTable.Filter := 'USED_FOR = ' + QuotedStr(UsedForCode);
  LookupTable.Filtered := True;
  if LookupTable.Locate('SEARCH', UpperCase(FieldValue), []) then
    LookupValidFound := True
  else
    LookupValidFound := False;
  LookupTable.Filtered := False;
  LookupTable.Filter := '';
end;

procedure TDataModuleMain.StandardTableBeforeOpen(DataSet: TDataSet);
begin
  StandardTable.TableName := GetChemStdFileName;
end;

procedure TDataModuleMain.StandDescrTableAfterCancel(DataSet: TDataSet);
begin
  IsNewTable := False;
end;

procedure TDataModuleMain.StandDescrTableAfterDelete(DataSet: TDataSet);
begin
  ChemStandard := StandDescrTable.FieldByName('ID').AsInteger;
  MessageDlg(ChemStdDelMsg + StandDescrTable.FieldByName('STAND_DESCR').AsString, mtInformation, [mbOK], 0);
end;

procedure TDataModuleMain.StandDescrTableAfterEdit(DataSet: TDataSet);
begin
  StandDescrTableTABLE_NAME.ReadOnly := False;
end;

procedure TDataModuleMain.StandDescrTableAfterPost(DataSet: TDataSet);
begin
  if IsNewTable then
    ZConnectionLanguage.ExecuteDirect('CREATE TABLE IF NOT EXISTS ' + StandDescrTableTABLE_NAME.AsString + ' (PARAMETER VARCHAR (10) PRIMARY KEY ASC, PARA_DESCR VARCHAR (25), PARA_SHORT VARCHAR (8), UNIT VARCHAR (7), STDRECLO NUMERIC (5, 1), STDRECHI NUMERIC (10, 5), STDMAXLO NUMERIC (5, 1), STDMAXHI NUMERIC (11, 5))');
  IsNewTable := False;
end;

procedure TDataModuleMain.StandDescrTableBeforeDelete(DataSet: TDataSet);
begin
  if StandDescrTable.RecordCount > 1 then
  begin
    if MessageDlg(ChemStdDelConfMsg, mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Abort
    else
      ZConnectionLanguage.ExecuteDirect('DROP TABLE ' + StandDescrTableTABLE_NAME.AsString);
  end
  else
  begin
    MessageDlg('You need at least one valid chemistry standard for Aquabase to work with! Nothing will therefore be deleted.',
      mtWarning, [mbOK], 0);
    Abort;
  end
end;

procedure TDataModuleMain.StandDescrTableBeforeEdit(DataSet: TDataSet);
begin
  StandDescrTableTABLE_NAME.ReadOnly := True;
end;

procedure TDataModuleMain.StandDescrTableBeforePost(DataSet: TDataSet);
begin
  if Pos('.', StandDescrTable.FieldByName('TABLE_NAME').Value) > 0 then
  begin
    MessageDlg('You cannot use file extensions in the table name!', mtError, [mbOK], 0);
    Abort;
  end;
end;

procedure TDataModuleMain.StandDescrTableNewRecord(DataSet: TDataSet);
begin
  IsNewTable := True;
end;

procedure TDataModuleMain.ZConnectionCountriesAfterConnect(Sender: TObject);
begin
  with CheckQuery do
  begin
    Connection := ZConnectionCountries;
    SQL.Clear;
    SQL.Add('SELECT * FROM Countries WHERE C_NAME = ' + QuotedStr(Country));
    Open;
    CountryDB := FieldByName('LANG_1').AsString;
    Close;
    SQL.Clear;
  end;
end;

procedure TDataModuleMain.ZConnectionCountriesBeforeConnect(Sender: TObject);
begin
  with ZConnectionCountries do
  begin
    Database := ProgramDir + DirectorySeparator + 'countries.db3';
    LibraryLocation := SQLiteLib;
  end;
end;

procedure TDataModuleMain.ZConnectionDBAfterConnect(Sender: TObject);
var
  sc: IZSQLiteConnection;
  SchemaVer, loadResult: Word;
  MySQLOld: Boolean;
  HoleLogList: TStringList;
  ErrMsg: String;
begin
  //check if this is a valid Aquabase database
  with DBMetadata do
  begin
    Connection := ZConnectionDB;
    MetaDataType := mdTables;
    TableName := 'basicinf';
    Open;
  end;
  if DBMetaData.RecordCount = 0 then
  begin
    DBMetaData.Close;
    MessageDlg('This workspace does not point to a valid Aquabase database! The workspace will therefore be closed now. Please open a workspace with a valid Aquabase database.', mtError, [mbOK], 0);
    ZConnectionDB.Disconnect;
  end
  else //do a few checks and balances
  begin
    Screen.Cursor := crSQLWait;
    DBMetaData.Close;
    //make sure allsites view exists
    with DBMetaData do
    begin
      Connection := ZConnectionDB;
      MetaDataType := mdTables;
      TableName := 'allsites';
      Open;
    end;
    if DBMetadata.RecordCount = 0 then
    begin
      ZConnectionDB.ExecuteDirect('CREATE VIEW allsites AS SELECT SITE_ID_NR FROM basicinf');
      Screen.Cursor := crDefault;
      MessageDlg('The "allsites" View did not exist in your database and has been created.', mtInformation, [mbOK], 0);
    end;
    //check if the last view exists
    Screen.Cursor := crSQLWait;
    with DBMetaData do
    begin
      Connection := ZConnectionDB;
      MetaDataType := mdTables;
      TableName := FilterName;
      Open;
    end;
    if DBMetadata.RecordCount = 0 then
    begin
      Screen.Cursor := crDefault;
      MessageDlg('The last used "' + FilterName + '" View did not exist in your database or could not be opened (database locked by other application?)! The "allsites" view has therefore been activated.', mtInformation, [mbOK], 0);
      FilterName := 'allsites';
    end;
    Screen.Cursor := crSQLWait;
    try
      ZQueryView.Open;
    except on E: Exception do
      begin
        MessageDlg(E.Message + ' - Could not open the View "' + FilterName + '". Defaulting to "allsites" View', mtError, [mbOK], 0);
        FilterName := 'allsites';
        ZQueryView.Open;
      end;
    end;
    if LastSiteID > '' then
      ZQueryView.Locate('SITE_ID_NR', LastSiteID, []);
    if ZConnectionDB.Tag = 1 then //sqlite
    begin
      ZConnectionDB.ExecuteDirect('PRAGMA foreign_keys = ON;'); //Enable foreign keys on sqlite
      //Check SQLite database user version and take action
      with CheckQuery do
      begin
        Screen.Cursor := crSQLWait;
        Connection := ZConnectionDB;
        SQL.Clear;
        SQL.Add('PRAGMA schema_version;');
        Open;
        SchemaVer := FieldByName('schema_version').Value;
        Close;
        SQL.Clear;
        SQL.Add('PRAGMA user_version;');
        Open;
        Application.ProcessMessages;
        if FieldByName('user_version').Value < SQLiteDBVer then
        begin
          if FieldByName('user_version').Value <= 5 then
          begin
            Screen.Cursor := crDefault;
            MessageDlg('Your SQLite database Ver. ' + FieldByName('user_version').AsString
            + '.' + IntToStr(SchemaVer) + ' is older than Ver. '
              + IntToStr(SQLiteDBVer) + '.x! Your database should therefore be updated as a matter of urgency under "Tools|SQLite Database" to take advantage of the latest features and prevent errors or data corruption!', mtWarning, [mbOK], 0);
          end
          else
          begin
            Screen.Cursor := crDefault;
            MessageDlg('Your SQLite database Ver. ' + FieldByName('user_version').AsString
            + '.' + IntToStr(SchemaVer) + ' is older than Ver. '
              + IntToStr(SQLiteDBVer) + '.x! Your database should therefore be updated under "Tools|SQLite Database" to take advantage of the latest features and prevent errors or data corruption!', mtWarning, [mbOK], 0);
          end;
          Close;
          SQL.Clear;
        end
        else
        if FieldByName('user_version').Value = 7 then
        //fix basicinf spatial triggers
        begin
          ZSQLProcessorDB.Script.Clear;
          ZSQLProcessorDB.Script.LoadFromFile(ProgramDir + DirectorySeparator + 'Databases' + DirectorySeparator + 'SQLite' + DirectorySeparator + 'fix_basicinf_triggers.sql');
          ZSQLProcessorDB.Execute;
        end;
      end;
      //check deteclim for ID primary key and create if not there
      Screen.Cursor := crSQLWait;
      with DBMetadata do
      begin
        Connection := ZConnectionDB;
        MetaDataType := mdPrimaryKeys;
        TableName := 'deteclim';
        Open;
      end;
      if DBMetadata.RecordCount = 0 then
      begin
        ZSQLProcessorDB.Script.Clear;
        ZSQLProcessorDB.Script.LoadFromFile(ProgramDir + DirectorySeparator + 'Databases' + DirectorySeparator + 'SQLite' + DirectorySeparator + 'id_add_deteclim.sql');
        ZSQLProcessorDB.Execute;
      end;
      DBMetadata.Close;
      //fix chemistry triggers if they are old
      with DBMetadata do
      begin
        Connection := ZConnectionDB;
        MetaDataType := mdTriggers;
        TriggerName := 'chem_000_before_update';
        TableName := 'chem_000';
        Open;
      end;
      if DBMetadata.RecordCount > 0 then
      begin
        ZSQLProcessorDB.Script.Clear;
        ZSQLProcessorDB.Script.LoadFromFile(ProgramDir + DirectorySeparator + 'Databases' + DirectorySeparator + 'SQLite' + DirectorySeparator + 'fix_chemistry_triggers.sql');
        ZSQLProcessorDB.Execute;
      end;
      DBMetadata.Close;
      //Spatially enable main database
      ErrMsg := '';
      sc := ZConnectionDB.DbcConnection as TZSQLiteConnection;
      sc.enable_load_extension(True);
      {$IFDEF DARWIN}
      loadResult := sc.load_extension('mod_spatialite.dylib', NIL, ErrMsg);
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
      if not Spatialite then
        ShowMessage('Your SQLite database seems to be spatially-disabled! Please enable it under Tools|SQLite Database to benefit from the spatial functions.');
      Application.ProcessMessages;
    end //of sqlite
    else //check for MySQL/MariaDB database upgrades
    if (ZConnectionDB.Tag = 2) or (ZConnectionDB.Tag = 3) then
    begin
      Screen.Cursor := crSQLWait;
      //check DB version
      MySQLOld := False;
      with CheckQuery do
      begin
        SQL.Clear;
        SQL.Add('SELECT VER_NR FROM db_version ORDER BY ID');
        try
          Open;
          //check if new = no records
          if RecordCount = 0 then //insert the current (latest) DB version
            ZConnectionDB.ExecuteDirect('INSERT INTO `db_version` (`VER_NR`) VALUES (' + QuotedStr(FloatToStr(MySQLDBVer)) + ')')
          else
          begin
            Last;
            MySQLOld := FieldByName('VER_NR').Value < MySQLDBVer;
          end;
        except on E: Exception do
          begin
            Screen.Cursor := crDefault;
            MessageDlg('Your MySQL Version is outdated. It will be automatically updated now.', mtInformation, [mbOk], 0);
            MySQLOld := True;
          end;
        end;
        Close;
        SQL.Clear;
      end;
      //Run MySQL updates if MySQLOld
      if MySQLOld then
      begin
        ZSQLProcessorDB.Script.LoadFromFile(ProgramDir + DirectorySeparator + 'Databases' + DirectorySeparator + 'MySQL' + DirectorySeparator + 'update1to1_1.sql');
        ZSQLProcessorDB.Execute;
      end;
      Screen.Cursor := crDefault;
    end; //of MySQL/MariaDB
    //start idle timer to ping remote servers
    if ZConnectionDB.Tag > 1 then //start the timer to keep connection alive
      IdleTimerSQL.AutoEnabled := True;
    //Check if there are sites where there is casing but no holediam information
    with DBMetadata do
    begin
      Connection := ZConnectionDB;
      MetaDataType := mdTables;
      TableName := 'no_holediam';
      Open;
    end;
    if DBMetaData.RecordCount = 0 then //there is no hole diam view so check again
    with CheckQuery do
    begin
      Screen.Cursor := crSQLWait;
      Connection := ZConnectionDB;
      SQL.Clear;
      SQL.Add('SELECT DISTINCT SITE_ID_NR FROM casing__ WHERE SITE_ID_NR NOT IN (SELECT DISTINCT SITE_ID_NR FROM holediam)');
      Open;
      Screen.Cursor := crDefault;
      if not FileExists(WSpaceDir + DirectorySeparator + 'holediam.log') and (RecordCount > 0) then
        if MessageDlg('Missing hole depth and diameter', 'There are ' + IntToStr(RecordCount) + ' sites with casing information, but no hole depth and diameter information! Do you want to write the Site IDs of these to "holediam.log" in your workspace, create the View "no_holediam" and ignore this message in future?', mtWarning, [mbYes, mbNo], 0) = mrYes then
        begin
          HoleLogList := TStringList.Create;
          while not EOF do
          begin
            HoleLogList.Add(CheckQuery.Fields[0].AsString);
            Next;
          end;
          HoleLogList.SaveToFile(WSpaceDir + DirectorySeparator + 'holediam.log');
          HoleLogList.Free;
          ZConnectionDB.ExecuteDirect('CREATE VIEW no_holediam AS SELECT DISTINCT SITE_ID_NR FROM casing__ WHERE SITE_ID_NR NOT IN (SELECT DISTINCT SITE_ID_NR FROM holediam)');
        end;
      Close;
    end;
    DBMetadata.Close;
    //check for the Cl2 field and move data to CFR field in chem_003
    with CheckQuery do
    begin
      Screen.Cursor := crSQLWait;
      Connection := ZConnectionDB;
      SQL.Clear;
      SQL.Add('SELECT * FROM chem_004 WHERE 1 <> 1');
      FieldDefs.Update;
      if FieldDefs.IndexOf('Cl2') > 0 then //the field exists
      begin
        SQL.Clear;
        SQL.Add('SELECT Cl2 FROM chem_004 WHERE Cl2 > -1');
        Open;
        //if there are records transfer them
        if RecordCount > 0 then
        with ZConnectionDB do
        begin
          //insert chem. ref. nr. in chem_003 if it doesn't exist
          ExecuteDirect('INSERT INTO chem_003 (CHM_REF_NR) SELECT CHM_REF_NR FROM chem_004 WHERE chem_004.CHM_REF_NR NOT IN (SELECT CHM_REF_NR FROM chem_003) AND chem_004.Cl2 > -1');
          //then update the records
          ExecuteDirect('UPDATE chem_003 SET CFR = (SELECT Cl2 FROM chem_004 WHERE chem_004.CHM_REF_NR = chem_003.CHM_REF_NR)');
          //then set Cl2 field null
          ExecuteDirect('UPDATE chem_004 SET Cl2 = -1');
        end;
        Close;
      end;
      Screen.Cursor := crDefault;
    end;
    //check for contractor field
    with CheckQuery do
    begin
      Screen.Cursor := crSQLWait;
      Connection := ZConnectionDB;
      SQL.Clear;
      SQL.Add('SELECT DISTINCT CONTRACTOR FROM pumptest WHERE 1<>1');
      try
        Open;
        Close;
        Screen.Cursor := crDefault;
      except on E: Exception do
        begin
          Close;
          Screen.Cursor := crDefault;
          MessageDlg('The new field "CONTRACTOR" for "Contractor" in pumping test table not found, but will be created now! Please make sure you have database permissions to change tables.', mtInformation, [mbOK], 0);
          try
            DataModuleMain.ZConnectionDB.ExecuteDirect('ALTER TABLE pumptest ADD COLUMN CONTRACTOR VARCHAR (4)');
          except on Ex: Exception do
            MessageDlg(Ex.Message + ' - New field not created. Make sure you have database permissions to change tables!', mtError, [mbOK], 0);
          end;
        end;
      end;
      SQL.Clear;
    end;
    with CheckQuery do
    begin
      Screen.Cursor := crSQLWait;
      Connection := ZConnectionDB;
      SQL.Clear;
      SQL.Add('SELECT DISTINCT CONTRACTOR FROM pmpigen WHERE 1 <> 1');
      try
        Open;
        Close;
        Screen.Cursor := crDefault;
      except on E: Exception do
        begin
          Close;
          Screen.Cursor := crDefault;
          MessageDlg('The new field "CONTRACTOR" for "Contractor" in pumping test import table not found, but will be created now! Please make sure you have database permissions to change tables.', mtInformation, [mbOK], 0);
          try
            DataModuleMain.ZConnectionDB.ExecuteDirect('ALTER TABLE pmpigen ADD COLUMN CONTRACTOR VARCHAR (4)');
          except on Ex: Exception do
            MessageDlg(Ex.Message + ' - New field not created. Make sure you have database permissions to change tables!', mtError, [mbOK], 0);
          end;
        end;
      end;
      SQL.Clear;
    end;
    //check time measured field in DTH tables
    with CheckQuery do
    begin
      Screen.Cursor := crSQLWait;
      Connection := ZConnectionDB;
      SQL.Clear;
      SQL.Add('SELECT DISTINCT TIME_MEAS FROM bhg_temp WHERE 1<>1');
      try
        Open;
        Close;
        Screen.Cursor := crDefault;
      except on E: Exception do
        begin
          Close;
          Screen.Cursor := crDefault;
          MessageDlg('The new field "TIME_MEAS" for "Time measured" in groundwater property tables not found, but will be created now! Please make sure you have database permissions to change tables.', mtInformation, [mbOK], 0);
          try
            DataModuleMain.ZConnectionDB.ExecuteDirect('ALTER TABLE bhg_temp ADD COLUMN TIME_MEAS VARCHAR (4)');
            DataModuleMain.ZConnectionDB.ExecuteDirect('ALTER TABLE eleccond ADD COLUMN TIME_MEAS VARCHAR (4)');
            DataModuleMain.ZConnectionDB.ExecuteDirect('ALTER TABLE flowvelo ADD COLUMN TIME_MEAS VARCHAR (4)');
            DataModuleMain.ZConnectionDB.ExecuteDirect('ALTER TABLE usr_dthp ADD COLUMN TIME_MEAS VARCHAR (4)');
          except on Ex: Exception do
            MessageDlg(Ex.Message + ' - New field not created. Make sure you have database permissions to change tables!', mtError, [mbOK], 0);
          end;
        end;
      end;
      SQL.Clear;
    end;
    //check for DATE_ENTRY field in Comments
    with CheckQuery do
    begin
      Screen.Cursor := crSQLWait;
      Connection := ZConnectionDB;
      SQL.Clear;
      SQL.Add('SELECT DISTINCT DATE_ENTRY FROM comments WHERE 1<>1');
      try
        Open;
        Close;
        Screen.Cursor := crDefault;
      except on E: Exception do
        begin
          Close;
          Screen.Cursor := crDefault;
          MessageDlg('The new field "DATE_ENTRY" for "Date entered" in Comments table was not found, but will be created now! Please make sure you have database permissions to change tables.', mtInformation, [mbOK], 0);
          try
            DataModuleMain.ZConnectionDB.ExecuteDirect('ALTER TABLE comments ADD COLUMN DATE_ENTRY VARCHAR (8)');
          except on Ex: Exception do
            MessageDlg(Ex.Message + ' - New field not created. Make sure you have database permissions to change tables!', mtError, [mbOK], 0);
          end;
        end;
      end;
      SQL.Clear;
    end;
    //check for CALIBR_YLD field in testdetl
    with CheckQuery do
    begin
      Screen.Cursor := crSQLWait;
      Connection := ZConnectionDB;
      SQL.Clear;
      SQL.Add('SELECT DISTINCT CALIBR_YLD FROM testdetl WHERE 1<>1');
      try
        Open;
        Close;
        Screen.Cursor := crDefault;
      except on E: Exception do
        begin
          Close;
          Screen.Cursor := crDefault;
          MessageDlg('The new field "CALIBR_YLD" for "Calibrated Yield" in Testdetl table was not found, but will be created now! Please make sure you have database permissions to change tables.', mtInformation, [mbOK], 0);
          try
            DataModuleMain.ZConnectionDB.ExecuteDirect('ALTER TABLE testdetl ADD COLUMN CALIBR_YLD DOUBLE');
          except on Ex: Exception do
            MessageDlg(Ex.Message + ' - New field not created. Make sure you have database permissions to change tables!', mtError, [mbOK], 0);
          end;
        end;
      end;
      SQL.Clear;
    end;
    //check for DEPTH_INST field in genequip
    with CheckQuery do
    begin
      Screen.Cursor := crSQLWait;
      Connection := ZConnectionDB;
      SQL.Clear;
      SQL.Add('SELECT DISTINCT DEPTH_INST FROM genequip WHERE 1<>1');
      try
        Open;
        Close;
        Screen.Cursor := crDefault;
      except on E: Exception do
        begin
          Close;
          Screen.Cursor := crDefault;
          MessageDlg('The new field "DEPTH_INST" for "Depth installed" in Genequip table was not found, but will be created now! Please make sure you have database permissions to change tables.', mtInformation, [mbOK], 0);
          try
            DataModuleMain.ZConnectionDB.ExecuteDirect('ALTER TABLE genequip ADD COLUMN DEPTH_INST DOUBLE');
          except on Ex: Exception do
            MessageDlg(Ex.Message + ' - New field not created. Make sure you have database permissions to change tables!', mtError, [mbOK], 0);
          end;
        end;
      end;
      SQL.Clear;
    end;
    //check for ROX field in chem_004
    with CheckQuery do
    begin
      Screen.Cursor := crSQLWait;
      Connection := ZConnectionDB;
      SQL.Clear;
      SQL.Add('SELECT DISTINCT ROX FROM chem_004 WHERE 1<>1');
      try
        Open;
        Close;
        Screen.Cursor := crDefault;
      except on E: Exception do
        begin
          Close;
          Screen.Cursor := crDefault;
          MessageDlg('The new field "ROX" for "Redox" in CHEM_004 table was not found, but will be created now! Please make sure you have database permissions to change tables.', mtInformation, [mbOK], 0);
          try
            DataModuleMain.ZConnectionDB.ExecuteDirect('ALTER TABLE chem_004 ADD COLUMN ROX DOUBLE DEFAULT ( -1)');
          except on Ex: Exception do
            MessageDlg(Ex.Message + ' - New field not created. Make sure you have database permissions to change tables!', mtError, [mbOK], 0);
          end;
        end;
      end;
      SQL.Clear;
    end;
    //check for CONDITION field in humidity
    with CheckQuery do
    begin
      Screen.Cursor := crSQLWait;
      Connection := ZConnectionDB;
      SQL.Clear;
      SQL.Add('SELECT DISTINCT CONDITIONS FROM humidity WHERE 1<>1');
      try
        Open;
        Close;
        Screen.Cursor := crDefault;
      except on E: Exception do
        begin
          Close;
          Screen.Cursor := crDefault;
          MessageDlg('The new field "CONDITIONS" for "Weather conditions" in Humidity table was not found, but will be created now! Please make sure you have database permissions to change tables.', mtInformation, [mbOK], 0);
          try
            DataModuleMain.ZConnectionDB.ExecuteDirect('ALTER TABLE humidity ADD COLUMN CONDITIONS VARCHAR (36)');
          except on Ex: Exception do
            MessageDlg(Ex.Message + ' - New field not created. Make sure you have database permissions to change tables!', mtError, [mbOK], 0);
          end;
        end;
      end;
      SQL.Clear;
    end;
    //check if src and dst SRIDs are geographic
    ZConnectionProj.Connect; //connect to the proj database
    SRIDQuery.Open; //to check SRIDS when converting coordinates
    with SRIDQuery do //to determine if src is LatLong
    begin
      if Locate('code', OrigCoordSysNr, []) then
        srcLatLong := Pos('geographic', Fields[1].AsString) > 0 //is LatLong
      else
        srcLatLong := False;
      if Locate('code', CoordSysNr, []) then
        dstLatLong := Pos('geographic', Fields[1].AsString) > 0 //is LatLong
      else
        dstLatLong := False;
    end;
    //check if stored coordinates are LO
    srcLO := InRange(OrigCoordSysNr, 1, 7)
      or InRange(OrigCoordSysNr, 2046, 2055)
      or InRange(OrigCoordSysNr, 22275, 22293) //all RSA LOs
      or InRange(OrigCoordSysNr, 29371, 29385); //all Nam LOs
    //check if viewed coordinates are LO
    dstLO := InRange(CoordSysNr, 1, 7)
      or InRange(CoordSysNr, 2046, 2055)
      or InRange(CoordSysNr, 22275, 22293) //all RSA LOs
      or InRange(CoordSysNr, 29371, 29385); //all Nam LOs
    //check size of the ZSQLMonitor file and confirm
    if (FileSize(ZSQLMonitor1.FileName) > 102400000) and
      (MessageDlg('Your SQL monitor file in your Workspace ("ZSQLMonitor.log") is > 100MB and is growing fast! Do you want to clear it now? (It is safe to do so, but if you want to save it, exit Aquabase and rename it first. A new one will be created then.)', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    begin
      ZSQLMonitor1.Active := False;
      DeleteFile(ZSQLMonitor1.FileName);
      ZSQLMonitor1.Active := True;
    end;
  end;
end;

procedure TDataModuleMain.ZConnectionDBAfterDisconnect(Sender: TObject);
begin
  SRIDQuery.Close;
  ZConnectionProj.Disconnect;
  with ZConnectionDB do //reset
  begin
    Database := '';
    HostName := '';
    LibraryLocation := '';
    Password := '';
    Port := 0;
    Protocol := '';
    User := '';
    LoginPrompt := False;
  end;
  IdleTimerSQL.AutoEnabled := False;
  ZSQLMonitor1.Save();
end;

procedure TDataModuleMain.ZConnectionDBBeforeConnect(Sender: TObject);
var
  SQLiteDBExists: Boolean;
begin
  //start the Monitor
  ZSQLMonitor1.FileName := WSpaceDir + DirectorySeparator + 'ZSQLMonitor.log';
  ZSQLMonitor1.Active := True;
  //login if required
  if (ZConnectionDB.Tag > 1) or UseSQLitePW then
  begin //use Login Form
    if (DataModuleMain.ZConnectionDB.User = '') or (DataModuleMain.ZConnectionDB.Password = '') then
      ZConnectionDB.LoginPrompt := True
    else
      ZConnectionDB.LoginPrompt := False;
    Screen.Cursor := crDefault;
  end
  else //do not use Login Form (for sqlite)
  begin
    SQLiteDBExists := True;
    //check if the database exists as per workspace.ini
    repeat
      if not FileExists(ZConnectionDB.Database) then
      begin
        MessageDlg('The path to your SQLite database specified in your workspace is not correct (the database has been moved or the workspace is opened with Aquabase in another operating system)! Please locate your database again now.', mtError, [mbOK], 0);
        SQLiteDBExists := False;
        OpenDialog1.InitialDir := WSpaceDir;
        if OpenDialog1.Execute then
        begin
          SQLiteDBExists := FileExists(OpenDialog1.FileName);
          if SQLiteDBExists then
          begin
            ZConnectionDB.Database := OpenDialog1.FileName;
            with TIniFile.Create(WSpaceDir + DirectorySeparator + 'workspace.ini') do
            begin
              {$IFDEF WINDOWS}
                WriteString('Database', 'Database', ZConnectionDB.Database);
              {$ENDIF}
              {$IFDEF LINUX}
                WriteString('Database', 'xDatabase', ZConnectionDB.Database);
              {$ENDIF}
              {$IFDEF DARWIN}
                WriteString('Database', 'mDatabase', ZConnectionDB.Database);
              {$ENDIF}
              Free;
            end;
          end;
        end;
      end;
    until SQLiteDBExists;
  end;
  Screen.Cursor := crSQLWait;
end;

procedure TDataModuleMain.ZConnectionDBLogin(Sender: TObject;
  var Username: string; var Password: string);
begin
  with TLoginForm.Create(Application) do
  begin
    SQLitePW := UseSQLitePW;
    ShowModal;
    if ModalResult = mrOK then
    begin
      Username := EditUserName.Text;
      Password := EditPassword.Text;
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
end;

procedure TDataModuleMain.ZConnectionDefaultsAfterConnect(Sender: TObject);
var
  f, BeforeCount, AfterCount, DescrChanged: Word;
  TheProgressBox: TProgressBoxForm;
begin
  if LookupTable.ReadOnly then
    MessageDlg('Your Lookup table is read-only and can therefore not be updated!', mtError, [mbOK], 0)
  else
  with ZQueryDefaultLookup do
  begin
    ZQueryLookup.Open;
    DescrChanged := 0;
    BeforeCount := LookupTable.RecordCount;
    Open;
    TheProgressBox := TProgressBoxForm.Create(Application);
    TheProgressBox.ProgressBar1.Max := RecordCount;
    TheProgressBox.Label1.Caption := 'Busy checking Default Lookup table record...';
    TheProgressBox.Show;
    while (not EOF) and (not TheProgressBox.CancelPressed) do
    begin
      TheProgressBox.ProgressBar1.Position := TheProgressBox.ProgressBar1.Position + 1;
      Application.ProcessMessages;
      if not ZQueryLookup.Locate('U_CODE', FieldByName('USED_FOR').AsString + FieldByName('SEARCH').AsString, []) then //if the code doesn't exist
      //insert the row from default lookup table into the current lookup table
      begin
        LookupTable.Append;
        LookupTable.Fields[0] := NIL; //the ID field
        for f := 1 to FieldCount - 1 do //all the other fields
          LookupTable.Fields[f].Value := Fields[f].Value;
        LookupTable.Post;
      end
      else //check the description
      begin
        ZQueryLookup.Locate('U_CODE', FieldByName('USED_FOR').AsString + FieldByName('SEARCH').AsString, []);
        if ZQueryLookup.Fields[1].Value <> Fields[3].Value then
        if MessageDlg('The description for code "' + Fields[2].AsString + '": "'
          + Fields[3].AsString + '" in the Default Lookups is not the same as "'
            + ZQueryLookup.Fields[1].AsString + '" in your Lookups! Do you want to keep your Lookup code?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        begin
          ZQueryLookup.Edit;
          ZQueryLookup.Fields[1].Value := Fields[3].Value;
          ZQueryLookup.Post;
          Inc(DescrChanged);
        end;
      end;
      Next;
    end;
    Close;
    TheProgressBox.Close;
    Application.ProcessMessages;
    LookupTable.Refresh;
    ZQueryLookup.Close;
    AfterCount := LookupTable.RecordCount;
    ShowMessage(IntToStr(AfterCount - BeforeCount) + ' lookup codes were added to your Lookup table and ' + IntToStr(DescrChanged) + ' Description(s) changed!')
  end;
end;

procedure TDataModuleMain.ZConnectionDefaultsBeforeConnect(Sender: TObject);
begin
  with ZConnectionCountries do
  begin
    Connect;
    Disconnect;
  end;
  with ZConnectionDefaults do
  begin
    Database := ProgramDir + DirectorySeparator + 'defaults' + DirectorySeparator + CountryDB + '.sqlite';
    LibraryLocation := SQLiteLib;
  end;
end;

procedure TDataModuleMain.ZConnectionLanguageAfterConnect(Sender: TObject);
var
  sc: IZSQLiteConnection;
  ErrMsg: String;
  loadResult: Word;
  UpDateTag: Byte;
begin
  //Spatially enable language database for spatial queries on catchments and maps50
  ErrMsg := '';
  Screen.Cursor := crSQLWait;
  sc := ZConnectionLanguage.DbcConnection as TZSQLiteConnection;
  sc.enable_load_extension(True);
  {$IFDEF DARWIN}
  loadResult := sc.load_extension('mod_spatialite.dylib', '', ErrMsg);
  {$ELSE}
  loadResult := sc.load_extension('mod_spatialite', '', ErrMsg);
  {$ENDIF}
  if loadResult > 0 then
    {$IFDEF WINDOWS}
    MessageDlg('Could not load "mod_spatialite" for language database! ' + ErrMsg + 'Please make sure it is installed (should be with Aquabase).', mtError, [mbOK], 0);
    {$ENDIF}
    {$IFDEF UNIX}
    MessageDlg('Could not load "mod_spatialite" for language database! ' + ErrMsg + 'Please make sure it is installed and (on Linux) possibly sym-linked to "mod_spatialite" without the ".so".', mtError, [mbOK], 0);
    {$ENDIF}
  {Read Units}
  with UnitTable do
  begin
    TableName := 'lengunit';
    Open;
    Locate('UNIT', LengthUnit, []);
    LengthFactor := FieldByName('FACTOR').Value;
    Close;
    TableName := 'volmunit';
    Open;
    Locate('UNIT', VolumeUnit, []);
    VolumeFactor := FieldByName('FACTOR').Value;
    Close;
    TableName := 'timeunit';
    Open;
    Locate('UNIT', TimeUnit, []);
    TimeFactor := FieldByName('FACTOR').Value;
    Close;
    TableName := 'diamunit';
    Open;
    Locate('UNIT', DiamUnit, []);
    DiamFactor := FieldByName('FACTOR').Value;
    Close;
    TableName := 'elecunit';
    Open;
    Locate('UNIT', ECUnit, []);
    ECFactor := FieldByName('FACTOR').Value;
    Close;
    TableName := 'chemunit';
    Open;
    Locate('UNIT', ChemUnit, []);
    ChemFactor := FieldByName('FACTOR').Value;
    Close;
    TableName := 'presunit';
    Open;
    Locate('UNIT', PressureUnit, []);
    PressureFactor := FieldByName('FACTOR').Value;
    Close;
  end;
  DisUnit := VolumeUnit + '/' + TimeUnit;
  //update Countries and map tables if settings are not in the program dir
  if ZConnectionDB.Connected and (SettingsDir <> ProgramDir) then //only do when workspace is active
  begin
    with CheckQuery do
    begin
      Connection := ZConnectionCountries;
      SQL.Clear;
      SQL.Add('select C_NAME from Countries where C_NAME = ' + QuotedStr('Congo (DRC)')); //random selection to check whether the table is old
      Open;
      if RecordCount > 0 then //it is the old country table
      begin //update to a new version with script
        with ZSQLProcessorDB do
        begin
          Clear;
          Connection := ZConnectionLanguage;
          Delimiter := ';';
          Script.LoadFromFile(ProgramDir + DirectorySeparator + 'Databases' + DirectorySeparator + 'SQLite' + DirectorySeparator + 'create_countries.sql');
          Execute;
          Clear;
          Delimiter := '$$';
          Connection := ZConnectionDB;
        end;
      end;
      Close;
      Connection := ZConnectionDB;
    end;
    ZConnectionCountries.Disconnect; //close the countries database
    //check if the map lookup tables exist, otherwise create them
    UpdateTag := 0;
    with DBMetadata do
    begin
      Connection := ZConnectionLanguage;
      MetaDataType := mdTables;
      TableName := 'municipalities';
      Open;
      if RecordCount = 0 then
        UpdateTag := 2; //if not found update the last 2 map tables
      Close;
    end;
    with DBMetadata do
    begin
      Connection := ZConnectionLanguage;
      MetaDataType := mdTables;
      TableName := 'catchments';
      Open;
      if RecordCount = 0 then
        UpdateTag := 3; //if not found update the all 3 map tables
      Close;
    end;
    if UpdateTag > 0 then
    begin
      Screen.Cursor := crDefault;
      MessageDlg('Your Aquabase Settings Databases in your non-default location seem to be outdated and will be upgraded now.', mtInformation, [mbOK], 0);
      Screen.Cursor := crSQLWait;
      with ZSQLProcessorDB do
      begin
        Connection := ZConnectionLanguage;
        Delimiter := ';';
        if UpdateTag >= 2 then
        begin
          Script.LoadFromFile(ProgramDir + DirectorySeparator + 'Databases' + DirectorySeparator + 'SQLite' + DirectorySeparator + 'create_municipalities.sql');
          Execute;
          Script.LoadFromFile(ProgramDir + DirectorySeparator + 'Databases' + DirectorySeparator + 'SQLite' + DirectorySeparator + 'create_wmas.sql');
          Execute;
        end;
        if UpdateTag = 3 then
        begin
          Script.LoadFromFile(ProgramDir + DirectorySeparator + 'Databases' + DirectorySeparator + 'SQLite' + DirectorySeparator + 'create_catchments.sql');
          Execute;
        end;
        Connection := ZConnectionDB;
        Delimiter := '$$';
      end;
      Screen.Cursor := crDefault;
      ShowMessage('Aquabase Settings Databases in non-default location successfully updated!');
    end;
    //check if SANS241 exists if it is non-default settings
    if InRange(AnsiIndexStr(Country, LO_Countries), 0, 4) then
    begin
      with DBMetadata do
      begin
        Connection := ZConnectionLanguage;
        MetaDataType := mdTables;
        TableName := 'SANS241';
        Open;
      end;
      if DBMetaData.RecordCount = 0 then //SANS241 doesn't exist
      begin
        with ZSQLProcessorDB do
        begin
          Clear;
          Connection := ZConnectionLanguage;
          Delimiter := ';';
          Script.LoadFromFile(ProgramDir + DirectorySeparator + 'Databases' + DirectorySeparator + 'SQLite' + DirectorySeparator + 'create_sans241.sql');
          Execute;
          Clear;
          Delimiter := '$$';
          Connection := ZConnectionDB;
        end;
      end
      else //it exists then update if outdated (Microcystin is not there)
      begin
        with CheckQuery do
        begin
          Connection := ZConnectionLanguage;
          SQL.Clear;
          SQL.Add('select PARAMETER from SANS241 where PARAMETER = ' + QuotedStr('MICROCYST'));
          Open;
          if RecordCount = 0 then //it is the old SANS241 table
          begin //update to a new version with script
            with ZSQLProcessorDB do
            begin
              Clear;
              Connection := ZConnectionLanguage;
              Delimiter := ';';
              Script.LoadFromFile(ProgramDir + DirectorySeparator + 'Databases' + DirectorySeparator + 'SQLite' + DirectorySeparator + 'create_sans241.sql');
              Execute;
              Clear;
              Delimiter := '$$';
              Connection := ZConnectionDB;
            end;
          end;
          Close;
          Connection := ZConnectionDB;
        end;
      end;
      DBMetadata.Close;
    end;
    //check if chemparams table exists if it is non-default settings
    with DBMetadata do
    begin
      Connection := ZConnectionLanguage;
      MetaDataType := mdTables;
      TableName := 'chemparams';
      Open;
    end;
    if DBMetaData.RecordCount = 0 then //doesn't exist
    begin
      with ZSQLProcessorDB do
      begin
        Clear;
        Connection := ZConnectionLanguage;
        Delimiter := ';';
        Script.LoadFromFile(ProgramDir + DirectorySeparator + 'Databases' + DirectorySeparator + 'SQLite' + DirectorySeparator + 'create_params.sql');
        Execute;
        Clear;
        Delimiter := '$$';
        Connection := ZConnectionDB;
      end;
    end;
    DBMetadata.Close;
  end;
  //open the chemistry standards table
  StandDescrTable.Open;
  if StandDescrTable.Locate('ID', ChemStandard, []) then
  begin
    ChemStandardDescr := StandDescrTable.FieldByName('STAND_DESCR').AsString;
    StandardTable.TableName := StandDescrTable.FieldByName('TABLE_NAME').AsString;
  end
  else
  begin
    ChemStandardDescr := 'No valid standard selected! Setting standard to default "WHO"';
    StandardTable.TableName := 'WHO';
  end;
  if StandDescrTable.FieldByName('TABLE_NAME').AsString = 'chmclass' then //for SA domestic classes
  begin
    StandardTable.Close;
    ClassTable.Open;
  end
  else
  begin
    ClassTable.Close;
    StandardTable.Open;
  end;
  StandDescrTable.Close;
  //open the lookups
  LookupTable.Open;
  Screen.Cursor := crDefault;
end;

procedure TDataModuleMain.ZConnectionLanguageBeforeConnect(Sender: TObject);
begin
  if SettingsDir = ProgramDir then
    LookupTable.ReadOnly := True
  else
  if FileExists(WSpaceDir + DirectorySeparator + 'settings.sqlite') then
    SettingsDir := WSpaceDir; //use settings in workspace (override default)
  with ZConnectionCountries do
  begin
    Connect;
    Disconnect;
  end;
  with ZConnectionLanguage do
  begin
    Database := SettingsDir + DirectorySeparator + CountryDB + '.sqlite';
    LibraryLocation := SQLiteLib;
  end;
end;

procedure TDataModuleMain.ZConnectionProjAfterConnect(Sender: TObject);
begin
  //check PROJ version
  with CheckQuery do
  begin
    SQL.Clear;
    Connection := ZConnectionProj;
    SQL.Add('SELECT * FROM metadata WHERE key = ''PROJ.VERSION''');
    Open;
    if RecordCount > 0 then
      Proj_Version := FieldByName('value').AsString
    else
      Proj_Version := '6.3.1'; //previous version in Aquabase: no entry in metadata table
    Close;
    SQL.Clear;
    Connection := ZConnectionDB;
  end;
end;

procedure TDataModuleMain.ZConnectionProjBeforeConnect(Sender: TObject);
begin
  with ZConnectionProj do
  begin
    LibraryLocation := SQLiteLib;
    {$IFDEF UNIX}
    if FileExists('/usr/share/proj/proj.db') then
      Database := '/usr/share/proj/proj.db'
    else
    if FileExists('/usr/local/share/proj/proj.db') then
      Database := '/usr/local/share/proj/proj.db'
    else
      MessageDlg('Cannot find the PROJ database! Maybe PROJ is not installed or your version is older than 5.0.', mtError, [mbOK], 0);
    {$ENDIF}
    {$IFDEF WINDOWS}
      Database := ProgramDir + '\share\proj\proj.db';
    {$ENDIF}
  end;
end;

procedure TDataModuleMain.ZConnectionSettingsAfterConnect(Sender: TObject);
var
  AquaSortProcessor: TZSQLProcessor;
begin
  with CheckQuery do //check chemistry user standards table
  begin
    Connection := ZConnectionSettings;
    SQL.Clear;
    try
      SQL.Add('SELECT ID FROM Ustddesc'); //check if it is the new table
      Open;
      Close;
    except on Exception do //otherwise create in new format and add default records
      begin
        Close;
        with ZConnectionSettings do
        begin
          ExecuteDirect('BEGIN TRANSACTION;');
          ExecuteDirect('ALTER TABLE Ustddesc RENAME TO Ustddesc_old;');
          ExecuteDirect('CREATE TABLE Ustddesc (ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, STAND_DESCR VARCHAR (32), TABLE_NAME VARCHAR (12));');
          ExecuteDirect('INSERT INTO Ustddesc VALUES(0, "SABS for human consumption", "SABS");');
          ExecuteDirect('INSERT INTO Ustddesc VALUES(NULL, "WHO for human consumption", "WHO");');
          ExecuteDirect('INSERT INTO Ustddesc VALUES(NULL, "SA Domestic Water Quality Guide", "chmclass");');
          ExecuteDirect('INSERT INTO Ustddesc VALUES(NULL, "SANS 241:2015", "SANS241");');
          ExecuteDirect('INSERT INTO Ustddesc SELECT NULL,* FROM Ustddesc_old;');
          ExecuteDirect('DROP TABLE Ustddesc_old;');
          ExecuteDirect('COMMIT;');
        end;
      end;
    end;
  end;
  //update Aquasort table
  if ExtractFilePath(ZConnectionSettings.Database) <> ProgramDir + DirectorySeparator then
  with CheckQuery do //check if AquaSort table is old in non-default folders and replace
  begin
    SQL.Clear;
    SQL.Add('SELECT UNITYVAL_TIME FROM Aquasort WHERE TIME_ID = 1'); //check if it is the new table
    Open;
    if Fields[0].Value <> '°C' then
    begin
      AquaSortProcessor := TZSQLProcessor.Create(Self);
      with AquaSortProcessor do
      begin
        Connection := ZConnectionSettings;
        DelimiterType := dtDelimiter;
        Delimiter := ';';
        Script.LoadFromFile(ProgramDir + DirectorySeparator + 'Databases'
          + DirectorySeparator + 'SQLite' + DirectorySeparator +  'create_aquasort.sql');
        Execute;
        Free;
      end;
    end;
    Close;
    Connection := ZConnectionDB;
    SQL.Clear;
  end;
end;

procedure TDataModuleMain.ZConnectionSettingsBeforeConnect(Sender: TObject);
begin
  if FileExists(WSpaceDir + DirectorySeparator + 'settings.sqlite') then
    SettingsDir := WSpaceDir; //use settings in workspace (override default)
  with ZConnectionSettings do
  begin
    Database := SettingsDir + DirectorySeparator + 'settings.sqlite';
    LibraryLocation := SQLiteLib;
  end;
end;

procedure TDataModuleMain.ZQueryProjBeforeOpen(DataSet: TDataSet);
var
  TheCountry: String;
begin
  //check for "St. Islands" spellings
  if Pos('St ', Country) = 1 then
    begin
      if Pos('Helena', Country) > 1 then
        TheCountry := '%Helena Island%'
      else
      if Pos('Vincent', Country) > 1 then
        TheCountry := '%Vincent%'
      else
        TheCountry := '%' + Copy(Country, 4, 12) + '%'
    end
  else
    TheCountry := '%' + Country + '%';
  ZQueryProj.SQL.Clear;
  if Proj_Version < '8.0.0' then
  with ZQueryProj.SQL do
  begin
    Add('select cast(crs_view.code as Integer) as SRID, crs_view.name || '' ('' || crs_view.type || '')'' as crs from area');
    Add('join crs_view on (crs_view.area_of_use_code = area.code)');
    Add('and (area.description like ' + QuotedStr(TheCountry) + ' or SRID = 4326)');
    Add('and SRID > 0 and SRID < 100000');
    Add('and (crs_view.type like ''geographic%'' or crs_view.type = ''projected'')');
    Add('and crs_view.deprecated = 0');
  end
  else
  with ZQueryProj.SQL do
  begin
    Add('select cast(crs_view.code as Integer) as SRID, crs_view.name || '' ('' || crs_view.type || '')'' as crs from usage');
    Add('join crs_view on (crs_view.code = usage.object_code)');
    Add('join extent on (extent.code = usage.extent_code)');
    Add('and (extent.description like ' + QuotedStr(TheCountry) + ' or SRID = 4326)');
    Add('and SRID > 0 and SRID < 100000');
    Add('and (crs_view.type like ''geographic%'' or crs_view.type = ''projected'')');
    Add('and crs_view.deprecated = 0');
  end;
end;

procedure TDataModuleMain.ZQueryViewBeforeOpen(DataSet: TDataSet);
begin
  with ZQueryView do
  begin
    Connection := ZConnectionDB;
    SQL.Clear;
    SQL.Add('SELECT DISTINCT site_id_nr FROM ' + FilterName);
  end;
end;

procedure TDataModuleMain.ZQueryDefaultLookupAfterClose(DataSet: TDataSet);
begin
  ZConnectionDefaults.Disconnect;
end;

procedure TDataModuleMain.ZSQLProcessorDBError(Processor: TZSQLProcessor;
  StatementIndex: Integer; E: Exception;
  var ErrorHandleAction: TZErrorHandleAction);
begin
  ErrorHandleAction := eaSkip;
  MessageDlg(E.Message + ' - Could not perform statement ' + IntToStr(StatementIndex) + ' in update script ' + Processor.Name + '!', mtError, [mbOK], 0);
end;

procedure TDataModuleMain.ZQueryViewAfterOpen(DataSet: TDataSet);
begin
  NrRecords := ZQueryView.RecordCount;
  if (NrRecords = 0) and (BasicinfQuery.Active) and (BasicinfQuery.RecordCount > 0) then
  begin
    ShowMessage('The selected View returns no sites! Resetting View to "allsites".');
    ZQueryView.Close;
    FilterName := 'allsites';
    ZQueryView.Open;
  end;
end;

procedure TDataModuleMain.ZQueryViewAfterRefresh(DataSet: TDataSet);
begin
  NrRecords := ZQueryView.RecordCount;
end;

procedure TDataModuleMain.BasicinfQueryAfterCancel(DataSet: TDataSet);
begin
  CoordsEdited := False;
  if DataSet.RecordCount = 0 then
    CurrentSite := '';
end;

procedure TDataModuleMain.BasicinfQueryAfterDelete(DataSet: TDataSet);
begin
  with ZQueryView do
  begin
    Refresh;
  end;
  if Dataset.RecordCount = 0 then
  begin
    MessageDlg('The database now does not contain any records.', mtInformation, [mbOK], 0);
    CurrentSite := '';
  end;
end;

procedure TDataModuleMain.BasicinfQueryAfterOpen(DataSet: TDataSet);
begin
  //projRelease := GetRelease;
  NrRecords := ZQueryView.RecordCount;
  if NrRecords = 0 then
  begin
    if MessageDlg('There are no records in your database yet or no visible records in the current View! Do you want to open the Help system to read up on how to create your first site or View?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      OpenDialog1.HelpContext := 311; //temporarily
      OpenHelp(OpenDialog1);
      OpenDialog1.HelpContext := 12; //to select the SQLite database when opening workspace
    end;
  end
  else
  begin
    //check for NGDB_FLAG = 9 UpdtdByTrigger (geometry changed)
    with CheckQuery do
    begin
      Screen.Cursor := crSQLWait;
      Connection := ZConnectionDB;
      SQL.Clear;
      SQL.Add('SELECT SITE_ID_NR, LONGITUDE, LATITUDE, ALTITUDE, NGDB_FLAG FROM basicinf WHERE NGDB_FLAG = ' + IntToStr(UpdtdByTrigger));
      Open;
      Screen.Cursor := crDefault;
      if RecordCount > 0 then
      if MessageDlg('It seems that ' + IntToStr(RecordCount) + ' site geometries have changed in your Basic Information. Do you want to update the coordinates accordingly now?', mtConfirmation, [mbYes, mbNo], mrNo) = mrYes then
      begin
        Screen.Cursor := crSQLWait;
        First;
        while not EOF do
        begin
          UpdateCoordsWithCs2cs(FieldByName('LONGITUDE').AsString, FieldByName('LATITUDE').AsString, FieldByName('SITE_ID_NR').AsString);
          Next;
        end;
        BasicinfQuery.Refresh;
        Screen.Cursor := crDefault;
      end
      else
        MessageDlg('You have selected not to update the coordinates now. You will be asked again when you open this workspace again.', mtInformation, [mbOK], 0);
      Close;
    end;
    //Check if there are sites where Longitude/Latitude have not been updated - NGDB_FLAG
    with CheckQuery do
    begin
      Screen.Cursor := crSQLWait;
      Connection := ZConnectionDB;
      SQL.Clear;
      SQL.Add('SELECT SITE_ID_NR, NGDB_FLAG FROM basicinf WHERE NGDB_FLAG < ' + IntToStr(UpdtdFromLatLong));
      Open;
      Screen.Cursor := crDefault;
      if RecordCount > 0 then
        MessageDlg('It seems that ' + IntToStr(RecordCount) + ' sites have outdated Longitude/Latitude and Geometries in Basic Information. Please run "Tools|Apply Coordinate System" and choose WGS84.', mtInformation, [mbOK], 0);
      Close;
    end;
    //Check if there is a view for qgis_selection
    with CheckQuery do
    begin
      Screen.Cursor := crSQLWait;
      Connection := ZConnectionDB;
      SQL.Clear;
      SQL.Add('SELECT QUADRANT FROM basicinf WHERE QUADRANT = ' + QuotedStr('9'));
      Open;
      Screen.Cursor := crDefault;
      if RecordCount > 0 then
      begin
        with DBMetadata do
        begin
          Connection := ZConnectionDB;
          MetaDataType := mdTables;
          TableName := 'qgis_selection';
          Open;
        end;
        if DBMetaData.RecordCount = 0 then
        begin
          MessageDlg('It seems that there are sites that have been selected from Basic Information in QGIS. The "qgis_selection" view will therefore be created now. Use the view to see the selection!', mtInformation, [mbOK], 0);
          DataModulemain.ZConnectionDB.ExecuteDirect('CREATE VIEW qgis_selection AS SELECT SITE_ID_NR FROM basicinf WHERE QUADRANT = ''9''');
        end;
        DBMetaData.Close;
      end;
      Close;
    end;
  end;
end;

procedure TDataModuleMain.BasicinfQueryAfterPost(DataSet: TDataSet);
var
  SiteString: String;
const
  radius = 100;
begin
  if AddNewSite then
  begin
    ZQueryView.Refresh; //necessary to show new record when inserted
    ZQueryView.Locate('SITE_ID_NR', NewSiteID, []);
    CurrentSite := NewSiteID;
    NrRecords := ZQueryView.RecordCount;
    //check if new site is within radius of 100m of other sites with same site type
    with CheckQuery do
    begin
      SQL.Clear;
      if DataModuleMain.ZConnectionDB.Tag = 1 then //sqlite
      begin
        SQL.Add('SELECT ogr_fid, site_id_nr, nr_on_map, site_type, 1000 * ( 6371 * acos( cos( radians(' + BasicinfQueryLATITUDE.AsString + ') ) * cos( radians( latitude ) ) * cos( radians( longitude ) - radians(' + BasicinfQueryLONGITUDE.AsString + ') ) + sin( radians(' + BasicinfQueryLATITUDE.AsString + ') ) * sin(radians(latitude)) ) ) AS distance_m');
        SQL.Add('FROM basicinf');
        SQL.Add('WHERE distance_m <= ' + IntToStr(radius));
        SQL.Add('AND site_id_nr <> ' + QuotedStr(BasicinfQuerySITE_ID_NR.AsString));
        SQL.Add('AND site_type = ' + QuotedStr(BasicinfQuerySITE_TYPE.AsString));
        SQL.Add('ORDER BY distance_m');
        Open;
      end
      else
      if DataModuleMain.ZConnectionDB.Tag in [2, 3] then //mysql, mariadb
      begin
        SQL.Add('SELECT ogr_fid, site_id_nr, nr_on_map, site_type, 1000 * ( 6371 * acos( cos( radians(' + BasicinfQueryLATITUDE.AsString + ') ) * cos( radians( latitude ) ) * cos( radians( longitude ) - radians(' + BasicinfQueryLONGITUDE.AsString + ') ) + sin( radians(' + BasicinfQueryLATITUDE.AsString + ') ) * sin(radians(latitude)) ) ) AS distance_m');
        SQL.Add('FROM basicinf');
        SQL.Add('WHERE site_id_nr <> ' + QuotedStr(BasicinfQuerySITE_ID_NR.AsString));
        SQL.Add('AND site_type = ' + QuotedStr(BasicinfQuerySITE_TYPE.AsString));
        SQL.Add('HAVING distance_m <= ' + IntToStr(radius));
        SQL.Add('ORDER BY distance_m');
        Open;
      end
      else
      if DataModuleMain.ZConnectionDB.Tag = 4 then //postgresql
      begin
        SQL.Add('SELECT site_id_nr, nr_on_map, site_type, st_distancesphere(ST_Point(ST_X(ST_Centroid(GEOMETRY)), ST_Y(ST_Centroid(GEOMETRY))), (ST_MakePoint(' + BasicinfQueryLONGITUDE.AsString + ', ' + BasicinfQueryLATITUDE.AsString + '))) as distance_m FROM basicinf');
        SQL.Add('WHERE GeometryType(ST_Centroid(GEOMETRY)) = ''POINT'' AND st_distancesphere(ST_Point(ST_X(ST_Centroid(GEOMETRY)), ST_Y(ST_Centroid(GEOMETRY))), (ST_MakePoint(' + BasicinfQueryLONGITUDE.AsString + ', ' + BasicinfQueryLATITUDE.AsString + '))) <= ' + IntToStr(radius));
        SQL.Add('AND site_id_nr <> ' + QuotedStr(BasicinfQuerySITE_ID_NR.AsString));
        SQL.Add('AND site_type = ' + QuotedStr(BasicinfQuerySITE_TYPE.AsString));
        SQL.Add('ORDER BY distance_m');
        //SQL.SaveToFile(WSpaceDir + '/sqltest.sql');
        Open;
      end
      else
      if DataModuleMain.ZConnectionDB.Tag = 5 then //mssql
      begin
        //still need to do
      end;
      if Active and (RecordCount > 0) then
      begin
        if RecordCount = 1 then
          SiteString := 'The site with Site Identifier and (Number) '
        else
          SiteString := 'The site with Site Identifiers and (Numbers) ';
        while not EOF do
        begin
          SiteString := SiteString + FieldByName('SITE_ID_NR').AsString + ' (' + FieldByName('NR_ON_MAP').AsString + '), ';
          Next;
        end;
        System.Delete(SiteString, Length(SiteString) - 1, 2);
        if RecordCount = 1 then
          MessageDlg('Possible duplicate site', SiteString + ' is within ' + FloatToStrF(radius * LengthFactor, ffFixed, 15, 2) + LengthUnit + ' from the new site and may be the same site! Check your coordinates, or if they are in fact the same. If they are, you can just delete the new site again and edit one of the existing ones.', mtWarning, [mbOK], 0)
        else
          MessageDlg('Possible duplicate sites', SiteString + ' are within ' + FloatToStrF(radius * LengthFactor, ffFixed, 15, 2) + LengthUnit + ' from the new site (ordered by distance) and may be the same site! Check your coordinates, or if they are in fact the same. If they are, you can just delete the new site again and edit one of the existing ones.', mtWarning, [mbOK], 0)
      end;
      Close;
      SQL.Clear;
    end;
  end;
  AddNewSite := False;
  NewSiteID := '';
  CoordsEdited := False;
end;

procedure TDataModuleMain.BasicinfQueryAfterRefresh(DataSet: TDataSet);
begin
  NrRecords := ZQueryView.RecordCount;
end;

procedure TDataModuleMain.BasicinfQueryALTITUDEGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNULL then DisplayText := False
  else
  begin
    if Abs(Sender.AsFloat * LengthFactor) > 10000 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 1)
    else
    if (Abs(Sender.AsFloat * LengthFactor) < 0.01) and (Abs(Sender.AsFloat * LengthFactor) > 0) then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end;
end;

procedure TDataModuleMain.BasicinfQueryALTITUDESetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
    Sender.AsFloat := StrToFloat(aText)/LengthFactor;
end;

procedure TDataModuleMain.BasicinfQueryBeforeDelete(DataSet: TDataSet);
begin
  if MessageDlg('Are you sure you want to delete ' + CurrentSite + ' from all tables in this database?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    MessageDlg('Site ' + CurrentSite + ' deleted from database! This cannot be undone.', mtInformation, [mbOk], 0);
  end
  else
  begin
    Abort;
    MessageDlg('Delete operation aborted!', mtInformation, [mbOk], 0);
  end;
end;

procedure TDataModuleMain.BasicinfQueryBeforeInsert(DataSet: TDataSet);
var
  NewNumber: Integer;
  NumberStr, SiteIDCode, MapRef, XStr, YStr: ShortString;
  MapRefValid: Boolean;
  MidX_Coord, MidY_Coord: Double;
const
   MapChars = ['A', 'B', 'C', 'D'];
begin
  if UpperCase(FilterName) = 'ALLSITES' then
  begin
    with TNewSiteForm.Create(Application) do
    begin
      if CurrentSite <> '' then //there are sites
      begin
        //check if we are dealing with a proper map reference, if LO
        if InRange(AnsiIndexStr(Country, LO_Countries), 0, 5) then
        begin
          if (RadioGroup1.ItemIndex = 0) then
          begin
            try
              MapRef := (Copy(CurrentSite, 1, 6));
              //check if Latitude within LO countries
              MapRefValid := (StrToInt(Copy(MapRef, 1, 2)) >= 16) and (StrToInt(Copy(MapRef, 1, 2)) <= 34);
              //check if Longitude within LO countries
              MapRefValid := (StrToInt(Copy(MapRef, 3, 2)) >= 11) and (StrToInt(Copy(MapRef, 3, 2)) <= 32);
            except on EConvertError do
              MapRefValid := False;
            end;
            if MapRefValid and ((not(MapRef[5] in MapChars)) or (not(MapRef[6] in MapChars))) then
              MapRefValid := False;
            if MapRefValid then
            begin
              MapRefEdit.Text := MapRef;
              AddCodeEdit.Text := Copy(CurrentSite, 7, 1);
            end
            else
            begin
              //use default
              MapRefEdit.Text := LO_Country_Mid[AnsiIndexStr(Country, LO_Countries)];
              AddCodeEdit.Text := '0';
            end;
          end;
        end //LO Countries
        else //other countries
        begin
          RadioGroup1.ItemIndex := 1;
          GroupBox1.Visible := False;
          GroupBox2.Top := 90;
          Height := 190;
        end;
      end
      else //there are no sites yet
      if InRange(AnsiIndexStr(Country, LO_Countries), 0, 5) then
      begin
        MapRefEdit.Text := LO_Country_Mid[AnsiIndexStr(Country, LO_Countries)];
        AddCodeEdit.Text := '0';
      end
      else
      begin
        RadioGroup1.ItemIndex := 1;
        GroupBox1.Visible := False;
        GroupBox2.Top := 90;
        Height := 190;
        EditFreeForm.Text := '00000000001';
      end;
      ShowModal;
      if ModalResult = mrOK then
      begin
        AddNewSite := True;
        NewX_COORD := 0;
        NewY_COORD := 0;
        XStr := '';
        YStr := '';
        if RadioGroup1.ItemIndex = 0 then //use map reference
        begin
          MapRef := MapRefEdit.Text;
          if (MapRef <> '0000ZZ') and CheckBoxDefaultToCentre.Checked then //if it is a valid map reference
          try
            //calculate the centre of map
            if (MapRef[5] = 'A') or (MapRef[5] = 'C') then
              MidY_Coord := StrToInt(Copy(MapRef, 3, 2)) + 0.125 else
            if (MapRef[5] = 'B') or (MapRef[5] = 'D') then
              MidY_Coord := StrToInt(Copy(MapRef, 3, 2)) + 0.625;
            if (MapRef[6] = 'B') or (MapRef[6] = 'D') then
              MidY_Coord := MidY_Coord + 0.25;
            if (MapRef[5] = 'A') or (MapRef[5] = 'B') then
              MidX_Coord := StrToInt(Copy(MapRef, 1, 2)) + 0.125 else
            if (MapRef[5] = 'C') or (MapRef[5] = 'D') then
              MidX_Coord := StrToInt(Copy(MapRef, 1, 2)) + 0.625;
            if (MapRef[6] = 'C') or (MapRef[6] = 'D') then
              MidX_Coord := MidX_Coord + 0.25;
            if dstLO then //convert from Lat/Long to LO if necessary, assume Hartebeesthoek94 Lat/Long
            begin
              if not cs2cs(FloatToStr(MidY_Coord), FloatToStr(-MidX_Coord), MapRef, 4148, CoordSysNr, XStr, YStr) then
                ShowMessage(CoordMsg);
              NewX_Coord := StrToFloat(YStr);
              NewY_Coord := StrToFloat(XStr);
            end
            else
            if dstLatLong then
            begin
              NewX_COORD := -MidX_Coord;
              NewY_COORD := MidY_Coord;
            end
            else
            begin
              if not cs2cs(FloatToStr(MidY_Coord), FloatToStr(-MidX_Coord), MapRef, 4148, CoordSysNr, YStr, XStr) then
                ShowMessage(CoordMsg);
              NewX_Coord := StrToFloat(XStr);
              NewY_Coord := StrToFloat(YStr);
            end;
          except on EConvertError do
            MessageDlg('Coordinate calculation not possible with this map reference!', mtError, [mbOK], 0);
          end; //of try
          SiteIDCode := MapRef + AddCodeEdit.Text;
          with CheckQuery do
          begin
            Connection := ZConnectionDB;
            SQL.Clear;
            SQL.AddText('SELECT MAX(SITE_ID_NR) AS MaxID FROM basicinf WHERE SITE_ID_NR LIKE '''
              + SiteIDCode + '%''');
            Open;
            if FieldByName('MaxID').AsString = '' then
            begin
              if AutoNumber > 0 then
                NumberStr := Format('%4.4d', [AutoNumber])
              else
                NumberStr := '0000'
            end
            else
              NumberStr := Copy(FieldByName('MaxID').AsString, 8, 4);
            Close;
          end;
          if Copy(SiteIDCode, 1, 6) = '0000ZZ' then //the new number is always 1 as it is calculated again before post
            NewNumber := 1
          else
            NewNumber := StrToInt(NumberStr) + 1;
          NumberStr := Format('%4.4d', [NewNumber]);
          NewSiteID := SiteIDCode + NumberStr;
          CoordsEdited := True;
        end
        else //use site identifier from EditFreeForm edit control
        begin
          NewSiteID := EditFreeForm.Text;
          if dstLO then
            MessageDlg('Your currently set coordinate system does not allow the calculation of the coordinates from the Map Reference, which will therefore be incorrect. Please set your coordinates to a system not dependent on the Map Reference after posting and then enter the correct coordinates by editing the record again!', mtWarning, [mbOK], 0);
        end;
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
    MessageDlg('Please use the "allsites" view when adding new sites!', mtError, [mbOk], 0);
    AddNewSite := False;
    Abort;
  end;
end;

procedure TDataModuleMain.BasicinfQueryBeforePost(DataSet: TDataSet);
var
  NewNumber: Integer;
  NumberStr, XStr, YStr: ShortString;
begin
  if CoordsEdited then
  begin
    if Copy(NewSiteID, 1, 6) = '0000ZZ' then //try to get map reference spatially from maps50 for new SiteID
    begin
      with ZQueryMap do
      begin
        with SQL do
        begin
          Clear;
          Add('SELECT sheet50 FROM maps50 ');
          Add('WHERE ST_WITHIN(GeomFromText(''POINT(' + EditX + ' ' + EditY + ')'', ' + IntToStr(CoordSysNr) + '), maps50.GEOMETRY)');
        end;
        Open;
        if RecordCount > 0 then
          NewSiteID := StringReplace(NewSiteID, '0000ZZ', FieldByName('sheet50').AsString, [rfReplaceAll])
        else
        begin
          SQL.Clear;
          if MessageDlg('Your coordinates do not fall within the 1:50000 maps of ' + Country + ' and therefore the map reference could not be calculated! Do you want to correct the coordinates now or use the default map reference "1111EE" by selecting "No"?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
            Abort
          else
            NewSiteID := StringReplace(NewSiteID, '0000ZZ', '1111EE', [rfReplaceAll])
        end;
        Close;
      end;
      with CheckQuery do
      begin
        Connection := ZConnectionDB;
        SQL.Clear;
        SQL.AddText('SELECT MAX(SITE_ID_NR) AS MaxID FROM basicinf WHERE SITE_ID_NR like '''
          + Copy(NewSiteID, 1, 7) + '%''');
        Open;
        if FieldByName('MaxID').AsString = '' then
        begin
          if AutoNumber > 0 then
            NumberStr := Format('%4.4d', [AutoNumber])
          else
            NumberStr := '0000'
        end
        else
          NumberStr := Copy(FieldByName('MaxID').AsString, 8, 4);
        Close;
      end;
      NewNumber := StrToInt(NumberStr) + 1;
      NumberStr := Format('%4.4d', [NewNumber]);
      NewSiteID := StringReplace(NewSiteID, '0001', NumberStr, [rfReplaceAll]);
      CurrentSite := NewSiteID;
    end;
    //write coordinates
    if cs2cs(EditX, EditY, GetMapRef(CurrentSite), CoordSysNr, OrigCoordSysNr, XStr, YStr) then
    begin
      BasicinfQueryX_COORD.Value := StrToFloat(XStr);
      BasicinfQueryY_COORD.Value := StrToFloat(YStr);
    end
    else
      ShowMessage(CoordMsg);
    //Convert X_COORD and Y_COORD to Lat/Long and insert into LONGITUDE and LATITUDE
    if cs2cs(EditX, EditY, GetMapRef(CurrentSite), CoordSysNr, 4326, XStr, YStr) then
    begin
      BasicinfQueryLONGITUDE.Value := StrToFloat(XStr);
      BasicinfQueryLATITUDE.Value := StrToFloat(YStr);
      BasicinfQueryNGDB_FLAG.AsInteger := UpdtdFromXY; //coordinate has been updated
    end
    else
      ShowMessage(CoordMsg);
  end;
  //LO countries with catchments
  with DBMetadata do
  begin
    Connection := ZConnectionLanguage;
    MetaDataType := mdTables;
    TableName := 'catchments';
    Open;
    if (RecordCount > 0) and InRange(AnsiIndexStr(Country, LO_Countries), 0, 3) then
    begin
      //check the drainage region
      with ZQueryMapLookup do
      begin
        SQL.Clear;
        SQL.Add('SELECT quaternary FROM catchments ');
        SQL.Add('WHERE ST_WITHIN(GeomFromText(''POINT(' + BasicinfQueryLONGITUDE.AsString + ' ' + BasicinfQueryLATITUDE.AsString + ')'', 4326), GEOMETRY)');
        Open;
      end;
      if BasicinfQueryDRAINAGE_R.Value = ' AUTO' then
      begin
        with ZQueryMapLookup do
        begin
          if RecordCount > 0 then
          begin
            BasicinfQueryDRAINAGE_R.Value := FieldByName('quaternary').Value;
            Close;
            SQL.Clear;
          end
          else
          begin
            Close;
            SQL.Clear;
            if MessageDlg('Please confirm', 'Your coordinates do not fall within the drainage regions of ' + Country + '! Do you want to correct either the coordinates or the drainage region manually and try again?', mtWarning, [mbYes, mbNo], 0) = mrYes then
              Abort;
          end;
        end;
      end
      else
      begin
        with ZQueryMapLookup do
        begin
          if (RecordCount > 0) and (BasicinfQueryDRAINAGE_R.Value <> FieldByName('quaternary').Value) then
          begin
            if MessageDlg('The selected drainage region does not correspond with the coordinates. Do you want to correct the drainage region automatically?', mtConfirmation, [mbYES, mbNO],0) = mrYES then
              BasicinfQueryDRAINAGE_R.AsString := FieldByName('quaternary').AsString;
          end;
          Close;
          SQL.Clear;
        end;
      end;
    end;
    Close;
  end;
  //LO countries only for municipalities...for now
  with DBMetadata do
  begin
    TableName := 'municipalities';
    Open;
    if (RecordCount > 0) and InRange(AnsiIndexStr(Country, LO_Countries), 0, 5) then
    begin
      if BasicinfQueryREGN_TYPE.AsString = 'MUN' then //check the municipality
      begin
        with ZQueryMapLookup do
        begin
          SQL.Clear;
          SQL.Add('SELECT map_title FROM municipalities ');
          SQL.Add('WHERE ST_WITHIN(GeomFromText(''POINT(' + BasicinfQueryLONGITUDE.AsString + ' ' + BasicinfQueryLATITUDE.AsString + ')'', 4326), GEOMETRY)');
          Open;
        end;
        if BasicinfQueryREGN_DESCR.Value = '<AUTOMATIC>' then
        begin
          with ZQueryMapLookup do
          begin
            if RecordCount > 0 then
            begin
              BasicinfQueryREGN_DESCR.Value := UpperCase(FieldByName('map_title').AsString);
              Close;
              SQL.Clear;
            end
            else
            begin
              Close;
              SQL.Clear;
              if MessageDlg('Please confirm', 'Your coordinates do not fall within any of the South African municipalities! Do you want to correct the coordinates and try again?', mtWarning, [mbYes, mbNo], 0) = mrYes then
                Abort;
            end;
          end;
        end
        else
        begin
          with ZQueryMapLookup do
          begin
            if (RecordCount > 0) and (BasicinfQueryREGN_DESCR.Value <> UpperCase(FieldByName('map_title').AsString)) then
            begin
              if MessageDlg('The municipality name inserted does not correspond with the coordinates of the site. Do you want to correct the municipality name automatically?', mtConfirmation, [mbYes, mbNo],0) = mrYes then
                BasicinfQueryREGN_DESCR.AsString := UpperCase(FieldByName('map_title').AsString);
            end;
            Close;
            SQL.Clear;
          end;
        end;
      end;
    end;
    Close;
  end;
  //South African water management areas
  with DBMetadata do
  begin
    TableName := 'wmas';
    Open;
    if (RecordCount > 0) and (AnsiIndexStr(Country, LO_Countries) = 0) then
    begin
      Open;
      if BasicinfQueryREGN_TYPE.AsString = 'WMA' then //check the water management area
      begin
        with ZQueryMapLookup do
        begin
          SQL.Clear;
          SQL.Add('SELECT waterman_n FROM wmas ');
          SQL.Add('WHERE ST_WITHIN(GeomFromText(''POINT(' + BasicinfQueryLONGITUDE.AsString + ' ' + BasicinfQueryLATITUDE.AsString + ')'', 4326), wmas.GEOMETRY)');
          Open;
        end;
        if BasicinfQueryREGN_DESCR.Value = '<AUTOMATIC>' then
        begin
          with ZQueryMapLookup do
          begin
            if RecordCount > 0 then
            begin
              BasicinfQueryREGN_DESCR.Value := UpperCase(FieldByName('waterman_n').AsString);
              Close;
              SQL.Clear;
            end
            else
            begin
              Close;
              SQL.Clear;
              if MessageDlg('Please confirm', 'Your coordinates do not fall within any of the South African Water Management Areas! Do you want to correct the coordinates and try again?', mtWarning, [mbYes, mbNo], 0) = mrYes then
                Abort;
            end;
          end;
        end
        else
        begin
          with ZQueryMapLookup do
          begin
            if (RecordCount > 0) and (BasicinfQueryREGN_DESCR.Value <> UpperCase(FieldByName('waterman_n').AsString)) then
            begin
              if MessageDlg('The Water Management Area inserted does not correspond with the coordinates of the site. Do you want to correct the Water Management Area automatically?', mtConfirmation, [mbYes, mbNo],0) = mrYes then
                BasicinfQueryREGN_DESCR.AsString := UpperCase(FieldByName('waterman_n').AsString);
            end;
            Close;
            SQL.Clear;
          end;
        end;
      end;
    end;
    Close;
  end;
  //finally insert the site
  if DataSet.State = dsInsert then
    BasicinfQuerySITE_ID_NR.Value := NewSiteID;
  if BasicinfQueryNOTE_PAD.IsNull or (BasicinfQueryNOTE_PAD.Value = '') then
    BasicinfQueryNOTES_YN.AsString := 'N'
  else
    BasicinfQueryNOTES_YN.AsString := 'Y';
  if not BasicValidFound then
    Abort;
end;

procedure TDataModuleMain.BasicinfQueryBH_DIAMGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if BasicinfQueryBH_DIAM.IsNull then
    DisplayText := False
  else
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(BasicinfQueryBH_DIAM.Value * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(BasicinfQueryBH_DIAM.Value * DiamFactor, ffFixed, 15, 2);
  end;
end;

procedure TDataModuleMain.BasicinfQueryBH_DIAMSetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
    Sender.AsFloat := StrToFloat(aText)/DiamFactor;
end;

procedure TDataModuleMain.BasicinfQueryCOLLAR_HIGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if Abs(Sender.AsFloat * LengthFactor) > 100 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
    else
    if (Sender.AsFloat > 0) and (Abs(Sender.AsFloat * LengthFactor) < 0.01) then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end
end;

procedure TDataModuleMain.BasicinfQueryCOLLAR_HISetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
    Sender.AsFloat := StrToFloat(aText)/LengthFactor;
end;

procedure TDataModuleMain.BasicinfQueryDATE_COMPLValidate(Sender: TField);
begin
  if not Sender.IsNull and not ValidDate(Sender.Value) then
  begin
    MessageDlg('Invalid date entered!', mtError, [mbOK], 0);
    BasicValidFound := False;
    Sender.FocusControl;
  end
  else
    BasicValidFound := True;
end;

procedure TDataModuleMain.BasicinfQueryDEPTHGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if Sender.AsFloat * LengthFactor > 1000 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
    else
    if (Sender.AsFloat > 0) and (Sender.AsFloat * LengthFactor < 0.01) then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end;
end;

procedure TDataModuleMain.BasicinfQueryDEPTHSetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
  begin
    if StrToFloat(aText) = 0 then
    begin
      MessageDlg('A depth of 0.00 is invalid! If you do not have a depth then leave the field blank (NULL). It will be reset now.', mtError, [mbOK], 0);
      Sender.Clear;
      Sender.FocusControl;
    end
    else
      Sender.AsFloat := StrToFloat(aText)/LengthFactor;
  end;
end;

procedure TDataModuleMain.BasicinfQueryNewRecord(DataSet: TDataSet);
begin
  if AddNewSite then
  begin
    BasicinfQuerySITE_ID_NR.Value := NewSiteID;
    BasicinfQueryDRAINAGE_R.Value := ' AUTO'; //blank makes sure it is right at the top of the list
    //set new coordinates, which are already converted
    BasicinfQueryX_COORD.Value := NewY_COORD;
    BasicinfQueryY_COORD.Value := NewX_COORD;
    //update the coordinate editing variables if not DMS
    if ShowDMS then
    begin
      if not cs2cs(BasicinfQueryX_COORD.AsString, BasicinfQueryY_COORD.AsString, GetMapRef(BasicinfQuerySITE_ID_NR.Value), OrigCoordSysNr, CoordSysNr, EditX, EditY) then
        ShowMessage(CoordMsg);
    end
    else
    begin
      EditX := BasicinfQueryX_COORD.AsString;
      EditY := BasicinfQueryY_COORD.AsString;
    end;
    //Set other default field values
    BasicinfQueryCOORD_ACC.Value := '4';
    BasicinfQuerySITE_TYPE.Value := 'B';
    BasicinfQueryNR_ON_MAP.FocusControl;
    CurrentSite := NewSiteID;
  end
  else BasicinfQuery.Cancel;
end;

procedure TDataModuleMain.BasicinfQueryPostError(DataSet: TDataSet;
  E: EDatabaseError; var DataAction: TDataAction);
begin
  ShowMessage(E.Message + '. Record will not be posted!');
  DataAction := daAbort;
end;

procedure TDataModuleMain.BasicinfQueryREGN_TYPEValidate(Sender: TField);
begin
  if (Country = 'South Africa') and (Sender.DataSet.State IN [dsEdit, dsInsert]) then
  if ((Sender.AsString = 'MUN') or (Sender.AsString = 'WMA')) and (BasicinfQueryREGN_DESCR.IsNull or (BasicinfQueryREGN_DESCR.AsString = '')) then
    BasicinfQueryREGN_DESCR.AsString := '<AUTOMATIC>';
end;

procedure TDataModuleMain.BasicinfQueryX_COORDGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := EditX;
end;

procedure TDataModuleMain.BasicinfQueryX_COORDSetText(Sender: TField;
  const aText: string);
begin
  EditX := aText;
  CoordsEdited := True;
  if (CoordSysNr = OrigCoordSysNr) and not ShowDMS then
    Sender.Value := aText;
end;

procedure TDataModuleMain.BasicinfQueryY_COORDGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if not Sender.IsNull then
  begin
    //Update the global Edit variables with converted coordinates; make sure x and y coords have a value (no value on new site)
    if not (BasicinfQuery.State IN [dsInsert, dsEdit]) and not BasicinfQueryX_COORD.IsNull then
    begin
      if not cs2cs(BasicinfQueryX_COORD.AsString, BasicinfQueryY_COORD.AsString, GetMapRef(BasicinfQuerySITE_ID_NR.Value), OrigCoordSysNr, CoordSysNr, EditX, EditY) then
        ShowMessage(CoordMsg);
    end;
  end
  else
  begin
    EditY := '';
    EditX := '';
  end;
  aText := EditY;
end;

procedure TDataModuleMain.BasicinfQueryY_COORDSetText(Sender: TField;
  const aText: string);
begin
  EditY := aText;
  CoordsEdited := True;
  if (CoordSysNr = OrigCoordSysNr) and not ShowDMS then
    Sender.Value := aText
end;

procedure TDataModuleMain.ConvCoordsQueryBeforeOpen(DataSet: TDataSet);
begin
  ConvCoordsQuery.Connection := ZConnectionDB;
end;

function TDataModuleMain.GetMapRef(const SiteID: ShortString): ShortString;
var
  MapRef: ShortString;
  MapRefValid: Boolean;
const
   MapChars = ['A', 'B', 'C', 'D'];
begin
  MapRef := Copy(SiteID, 1, 6);
  //check if SiteID has valid map reference to convert to/from LO
  if InRange(AnsiIndexStr(Country, LO_Countries), 0, 3) and srcLatLong and InRange(CoordSysNr, 1, 7) then
  begin
    try
      //check if Latitude within RSA/Namibia
      MapRefValid := (StrToInt(Copy(MapRef, 1, 2)) >= 16) and (StrToInt(Copy(MapRef, 1, 2)) <= 34);
      //check if Longitude within RSA/Namibia
      MapRefValid := (StrToInt(Copy(MapRef, 3, 2)) >= 11) and (StrToInt(Copy(MapRef, 3, 2)) <= 32);
    except on EConvertError do
      MapRefValid := False;
    end;
    if MapRefValid and ((not(MapRef[5] in MapChars)) or (not(MapRef[6] in MapChars))) then
      MapRefValid := False;
    if MapRefValid then
       Result := MapRef
    else//try and get map reference from spatial table maps50
    with ZQueryMap do
    begin
      with SQL do
      begin
        Clear;
        Add('SELECT sheet50 FROM maps50 ');
        Add('WHERE ST_WITHIN(GeomFromText(''POINT(' + BasicinfQueryX_COORD.AsString + ' ' + BasicinfQueryY_COORD.AsString + ')'', 4326),maps50.GEOMETRY)');
      end;
      Open;
      if RecordCount > 0 then
        Result := FieldByName('sheet50').AsString
      else
        Result := '';
      Close;
    end;
  end
  else
    Result := MapRef;
end;

procedure TDataModuleMain.DataSourceViewDataChange(Sender: TObject;
  Field: TField);
begin
  CurrentSite := ZQueryViewSITE_ID_NR.Value;
  //check if current site's geometry has changed
  if (BasicinfQueryNGDB_FLAG.Value = 9) and //convert LONGITUDE/LATITUDE to X_COORD/Y_COORD
    (MessageDlg('The geometry of the current site has changed. Do you want to update the coordinates in the database accordingly?', mtInformation, [mbYes, mbNo], 0) = mrYes) then
  begin
    try
      Screen.Cursor := crSQLWait;
      UpdateCoordsWithCs2cs(BasicinfQueryLONGITUDE.AsString, BasicinfQueryLATITUDE.AsString, BasicinfQuerySITE_ID_NR.AsString);
      BasicinfQuery.Refresh;
    finally
      Screen.Cursor := crDefault;
      ShowMessage('Site coordinates were updated from a changed geometry!');
    end;
  end;
end;

procedure TDataModuleMain.IdleTimerSQLTimer(Sender: TObject);
begin
  ZConnectionDB.PingServer;
end;

procedure TDataModuleMain.LookupTableBeforeOpen(DataSet: TDataSet);
begin
  if SettingsDir <> ProgramDir then
  with CheckQuery do
  begin
    Connection := ZConnectionLanguage;
    SQL.Clear;
    SQL.Add('SELECT USED_FOR FROM Lookup WHERE 1 <> 1');
    Open;
    if FieldByName('USED_FOR') is TBlobField then
    begin
      Close;
      ZSQLProcessorLookup.Execute;
    end
    else
      Close;
    SQL.Clear;
    Connection := ZConnectionDB;
  end;
end;

procedure TDataModuleMain.LookupTablePostError(DataSet: TDataSet;
  E: EDatabaseError; var DataAction: TDataAction);
begin
  MessageDlg(E.Message + ' - Could not post current record!', mtError, [mbOK], 0);
  DataAction := daAbort;
end;

function TDataModuleMain.GetChemStdFileName: ShortString;
begin
  try
    StandDescrTable.Open;
    if StandDescrTable.Locate('ID', ChemStandard, []) then
      Result := StandDescrTable.FieldByName('TABLE_NAME').AsString;
    StandDescrTable.Close;
  except on E: Exception do
    begin
      MessageDlg(E.Message + ' - Could not open table for selected chemistry standard! Using first standard instead.', mtError, [mbOK], 0);
      ChemStandard := 0;
      StandDescrTable.First;
      Result := StandDescrTable.FieldByName('TABLE_NAME').AsString;
      StandDescrTable.Close;
    end;
  end;
end;

function TDataModuleMain.GetSymbol(const PValue: Real; Parameter: ShortString): ShortString;
begin
  {Determine Symbol}
  if StandardTable.Locate('PARAMETER', UpperCase(Parameter), []) then
  begin
  if (PValue > StandardTable.FieldByName('STDMAXHI').Value) and (StandardTable.FieldByName('STDMAXHI').Value > -1)
    then Result := '‡'
  else if (PValue > StandardTable.FieldByName('STDRECHI').Value) and (StandardTable.FieldByName('STDRECHI').Value > -1)
      then Result := '†'
  else if (PValue < StandardTable.FieldByName('STDMAXLO').Value) and (StandardTable.FieldByName('STDMAXLO').Value > -1)
      then Result := '¡'
  else if (PValue < StandardTable.FieldByName('STDRECLO').Value) and (StandardTable.FieldByName('STDRECLO').Value > -1)
      then Result := '!'
  else Result := '';
  end
  else Result := '';
end;

function TDataModuleMain.GetShortParam(const Parameter: ShortString): ShortString;
begin
  //function to determine short parameter description
  if StandardTable.Locate('PARAMETER', UpperCase(Parameter), []) then
    Result := StandardTable.FieldByName('PARA_SHORT').AsString
  else
    Result := Parameter;
  if (not AsN) and (Parameter = 'N') then Result := 'NO3';
  if (not AsN) and (Parameter = 'N_AMONIA') then Result := 'NH4';
end;

function TDataModuleMain.GetParamUnit(const Parameter: ShortString): ShortString;
begin
  //Determine parameter units
  if Parameter = 'EC' then
    Result := ECUnit
  else
  if StandardTable.Locate('PARAMETER', UpperCase(Parameter), []) then
  begin
    if Pos('mg/l', StandardTable.FieldByName('UNIT').AsString) > 0 then
      Result := ChemUnit
    else
      Result := StandardTable.FieldByName('UNIT').AsString;
  end
  else
    Result := StandardTable.FieldByName('UNIT').AsString;
end;

end.

