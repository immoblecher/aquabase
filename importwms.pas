{ Copyright (C) 2021 Immo Blecher, immo@blecher.co.za

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
unit importwms;

{$mode objfpc}{$H+}

interface


uses
  Classes, SysUtils, SdfData, FileUtil, Forms, Controls, Graphics, Dialogs,
  ButtonPanel, ExtCtrls, StdCtrls, Spin, LCLType, ZDataset, db, strutils;

type

  { TImportWMSForm }

  TImportWMSForm = class(TForm)
    Button1: TButton;
    ButtonPanel1: TButtonPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBoxSampleNr: TCheckBox;
    Label1: TLabel;
    LabeledEdit1: TLabeledEdit;
    MaxQueryMAX_CHM_REF: TLongintField;
    OpenDialog: TOpenDialog;
    SdfDataSet: TSdfDataSet;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    MaxQuery: TZReadOnlyQuery;
    BasicinfQuery: TZReadOnlyQuery;
    SpatialQuery: TZReadOnlyQuery;
    QuerySampleNr: TZReadOnlyQuery;
    ZTable0: TZTable;
    ZTable1: TZTable;
    ZTable2: TZTable;
    ZTable5: TZTable;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    procedure Label1Resize(Sender: TObject);
    procedure MaxQueryAfterOpen(DataSet: TDataSet);
    procedure OKButtonClick(Sender: TObject);
    procedure MaxQueryBeforeOpen(DataSet: TDataSet);
    procedure SpatialQueryBeforeOpen(DataSet: TDataSet);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure ZTable0BeforeOpen(DataSet: TDataSet);
    procedure ZTable0PostError(DataSet: TDataSet; E: EDatabaseError;
      var DataAction: TDataAction);
    procedure ZTable1BeforeOpen(DataSet: TDataSet);
    procedure ZTable1PostError(DataSet: TDataSet; E: EDatabaseError;
      var DataAction: TDataAction);
    function CheckSiteNrs(TheWord: String): ShortString;
    procedure ZTable2PostError(DataSet: TDataSet; E: EDatabaseError;
      var DataAction: TDataAction);
    procedure ZTable5PostError(DataSet: TDataSet; E: EDatabaseError;
      var DataAction: TDataAction);
  private
     PrevDupName: Boolean;
  public

  end;

var
  ImportWMSForm: TImportWMSForm;

implementation

{$R *.lfm}

uses VARINIT, MainDataModule, progressbox;

{ TImportWMSForm }

function TImportWMSForm.CheckSiteNrs(TheWord: String): ShortString;
var
  CheckWord: ShortString;
  CheckG: Boolean;
begin
  CheckG := False;
  if Length(TheWord) > 1 then //there should be no SiteIDs with only one character
  begin
    CheckWord := TheWord;
    //check if the word is only numbers
    try
      if StrToInt(CheckWord) > 0 then //it might be a G-Number
      begin
        if (PrevDupName = False) and (Length(CheckWord) = 5) then
        begin
          CheckWord := '0' + CheckWord;
          CheckG := True;
        end;
      end;
    except
      //do nothing
    end;
    if CheckWord[1] = 'G' then //it might be a G-Number
    begin
      try
        if StrToInt(Copy(CheckWord, 2, 5)) > 0 then //is numeric so it might be a G-Number
        begin
          if StrToInt(CheckWord[2]) > 0 then //the first number is not a 0
            CheckWord := '0' + Copy(CheckWord, 2, Length(CheckWord) - 1)
          else
            CheckWord := Copy(CheckWord, 2, Length(CheckWord) - 1);
          CheckG := True;
        end;
      except
        //do nothing
      end;
    end; //of G-Number checking
    if Length(CheckWord) <= 12 then //max size of these fields
    with BasicinfQuery do
    begin
      if Locate('SITE_ID_NR', CheckWord, []) then
        Result := FieldByName('SITE_ID_NR').AsString
      else
      if Locate('NR_ON_MAP', CheckWord, []) then
        Result := FieldByName('SITE_ID_NR').AsString
      else
        Result := '';
      if CheckG then
      begin
        if Locate('SITE_ID_NR', 'G' + CheckWord, []) then
          Result := FieldByName('SITE_ID_NR').AsString
        else
        if Locate('SITE_ID_NR', 'G' + Copy(CheckWord, 2, Length(CheckWord)-1), []) then //G-Number without 0
          Result := FieldByName('SITE_ID_NR').AsString
        else
        if Locate('NR_ON_MAP', 'G' + CheckWord, []) then
          Result := FieldByName('SITE_ID_NR').AsString
        else
        if Locate('NR_ON_MAP', 'G' + Copy(CheckWord, 2, Length(CheckWord)-1), []) then
          Result := FieldByName('SITE_ID_NR').AsString
        else
        if Locate('ALT_NO_1', CheckWord, []) then
          Result := FieldByName('SITE_ID_NR').AsString
        else
        if Locate('ALT_NO_1', Copy(CheckWord, 2, Length(CheckWord)-1), []) then
          Result := FieldByName('SITE_ID_NR').AsString
        else
          Result := '';
      end;
    end;
    if CheckWord = 'NAME' then
      PrevDupName := True
    else
      PrevDupName := False;
  end;
end;

procedure TImportWMSForm.ZTable2PostError(DataSet: TDataSet; E: EDatabaseError;
  var DataAction: TDataAction);
begin
  DataAction := daAbort;
  MessageDlg(E.Message + ' - Additional Parameters chemistry result could not be posted.', mtError, [mbOK], 0);
end;

procedure TImportWMSForm.ZTable5PostError(DataSet: TDataSet; E: EDatabaseError;
  var DataAction: TDataAction);
begin
  DataAction := daAbort;
  MessageDlg(E.Message + ' - Rare Parameters chemistry result could not be posted.', mtError, [mbOK], 0);
end;

procedure TImportWMSForm.Button1Click(Sender: TObject);
begin
  with OpenDialog do
  begin
    InitialDir := WSpaceDir;
    Title := 'Select CSV file to import';
    if Execute and (Filename <> '') then
    begin
      SdfDataSet.Close;
      LabeledEdit1.Text := Filename;
      if LowerCase(ExtractFileExt(Filename)) = '.csv' then
      begin
        Buttonpanel1.OKButton.Enabled := True;
        SDFDataSet.FileName := FileName;
        try
          SDFDataSet.Open;
        except
          MessageDlg('The CSV file does not seem to be in a valid format! Please try another file.', mtError, [mbOK], 0);
        end;
      end;
    end;
  end;
end;

procedure TImportWMSForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TImportWMSForm.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
end;

procedure TImportWMSForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TImportWMSForm.FormShow(Sender: TObject);
begin
  MaxQuery.Open;
end;

procedure TImportWMSForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TImportWMSForm.Label1Resize(Sender: TObject);
begin
  Width := Round(Label1.Width * 1.4);
end;

procedure TImportWMSForm.MaxQueryAfterOpen(DataSet: TDataSet);
begin
  SpinEdit1.MinValue := MaxQuery.Fields[0].AsInteger + 1;
  SpinEdit1.Value := SpinEdit1.MinValue;
  MaxQuery.Close;
end;

procedure TImportWMSForm.OKButtonClick(Sender: TObject);
var
  NrRecs, PointID, PrevPointID, ChmRefNr: LongWord;
  Flag, w, NrWords: Byte;
  ErrorLog, SitesNotFound, ResultsNotLoaded: TStringList;
  CSVFile: TextFile;
  SaveSite: Boolean;
  SearchStr, ResultStr: String;
  ExistingSiteID: ShortString;
  Long, Lat: Double;
begin
  ChmRefNr := SpinEdit1.Value;
  PrevPointID := 0;
  Flag := 0;
  SaveSite := False;
  NrRecs := SdfDataSet.RecordCount;
  ErrorLog := TStringList.Create;
  SitesNotFound := TStringList.Create;
  ResultsNotLoaded:= TStringList.Create;
  SitesNotFound.Add('"Monitoring Point ID","Monitoring Point Name",Latitude,Longitude,"Located on Feature Name","Located on Type","Drainage Region Name"');
  //create the headers in results file, which will have all the results that could not be allocated
  ResultsNotLoaded:= TStringList.Create;
  AssignFile(CSVFile, LabeledEdit1.Text);
  Reset(CSVFile);
  ReadLn(CSVFile, ResultStr); //this is the first line
  ResultsNotLoaded.Add(ResultStr);
  //start import
  ProgressBoxForm := TProgressBoxForm.Create(Application);
  ProgressBoxForm.Caption := 'Importing table(s)...';
  ProgressBoxForm.ProgressBar1.Max := NrRecs;
  ProgressBoxForm.Show;
  Application.ProcessMessages;
  Visible := False; //make the import dialog invisible
  Screen.Cursor := crSQLWait;
  ProgressBoxForm.Label1.Caption := 'Opening Site and Chemistry tables...';
  Sleep(100);
  Application.ProcessMessages;
  BasicinfQuery.Open;
  ZTable0.Open;
  ZTable1.Open;
  ZTable2.Open;
  ZTable5.Open;
  Screen.Cursor := crDefault;
  ProgressBoxForm.ProgressBar1.Position := 1;
  Application.ProcessMessages;
  while (not ProgressBoxForm.CancelPressed) and (not SdfDataSet.EOF) do
  begin
    ReadLn(CSVFile, ResultStr);
    PointID := SdfDataSet.FieldByName('Monitoring Point ID').AsInteger;
    ProgressBoxForm.ProgressBar1.Position := ProgressBoxForm.ProgressBar1.Position + 1;
    Application.ProcessMessages;
    if CheckBox2.Checked then
      ProgressBoxForm.Label1.Caption := 'Busy checking Point ID ' + IntToStr(PointID) + ' of the ' + IntToStr(NrRecs) + ' records...'
    else
      ProgressBoxForm.Label1.Caption := 'Busy importing Point ID ' + IntToStr(PointID) + ' of the ' + IntToStr(NrRecs) + ' records...';
    Application.ProcessMessages;
    //do the real work to find matching sites
    if PointID <> PrevPointID then //site has changed therefore search for SITE_ID_NR
    begin
      ExistingSiteID := '';
      SaveSite := True;
      //check for existing Sample Nr. first
      if CheckBoxSampleNr.Checked then
      with QuerySampleNr do
      begin
        SQL.Clear;
        SQL.Add('SELECT DISTINCT SITE_ID_NR, SAMPLE_NR FROM chem_000');
        SQL.Add('WHERE SAMPLE_NR = ' + QuotedStr(IntToStr(PointID)));
        Open;
        if RecordCount > 0 then //found existing match between Point ID and sample number
          ExistingSiteID := FieldByName('SITE_ID_NR').AsString;
        Close;
      end;
      if ExistingSiteID = '' then //use "Monitoring Point Name" field
      begin
        SearchStr := SdfDataSet.FieldByName('Monitoring Point Name').AsString;
        NrWords := WordCount(SearchStr, StdWordDelims);
        for w := 1 to NrWords do
        begin
          ExistingSiteID := CheckSiteNrs(ExtractWord(w, SearchStr, StdWordDelims));
          Flag := w;
          if ExistingSiteID > '' then
            Break;
        end;
      end;
      if ExistingSiteID = '' then //also check in "Located on Feature Name" field
      begin
        SearchStr := SdfDataSet.FieldByName('Located on Feature Name').AsString;
        NrWords := WordCount(SearchStr, StdWordDelims);
        for w := 1 to NrWords do
        begin
          ExistingSiteID := CheckSiteNrs(ExtractWord(w, SearchStr, StdWordDelims));
          Flag := w;
          if ExistingSiteID > '' then
            Break;
        end;
      end;
      //if nothing is found with numbers then
      if (ExistingSiteID = '') and CheckBox1.Checked then //do spatial search
      begin
        Flag := 84;
        with SpatialQuery do
        begin
          //convert coordinates from Cape datum to WGS84
          Long := SdfDataSet.FieldByName('Longitude').Value;
          Lat := SdfDataSet.FieldByName('Latitude').Value;

          //if not Errors then
            //Errors := err > 0;
          //set up query for different databases
          case DataModuleMain.ZConnectionDB.Tag of
            1: begin
                 SQL.Clear;
                 SQL.Add('SELECT SITE_ID_NR, st_distance(MakePoint(' + FloatToStr(Long) + ', ' + FloatToStr(Lat)+ '), GEOMETRY) AS M_APART FROM basicinf');
                 SQL.Add('WHERE st_distance(MakePoint(' + FloatToStr(Long) + ', ' + FloatToStr(Lat)+ '), GEOMETRY) <= ' + IntToStr(SpinEdit2.Value));
                 SQL.Add('ORDER BY M_APART');
                 SQL.Add('LIMIT 1');
                 Open;
                 if RecordCount > 0 then
                   ExistingSiteID := FieldByName('SITE_ID_NR').AsString;
                 Close;
               end;
          2,3: begin
                 SQL.Clear;
                 SQL.Add('SELECT SITE_ID_NR, st_distance(ST_GeomFromText(' + QuotedStr('POINT(' + FloatToStr(Long) + ' ' + FloatToStr(Lat) + ')') + ', GEOMETRY) * 111325 AS M_APART FROM basicinf');
                 SQL.Add('WHERE st_distance(ST_GeomFromText(' + QuotedStr('POINT(' + FloatToStr(Long) + ' ' + FloatToStr(Lat) + ')') + ', GEOMETRY) * 111325 <= ' + IntToStr(SpinEdit2.Value));
                 SQL.Add('ORDER BY M_APART');
                 SQL.Add('LIMIT 1');
                 Open;
                 if RecordCount > 0 then
                   ExistingSiteID := FieldByName('SITE_ID_NR').AsString;
                 Close;
               end;
            4: begin
                 SQL.Clear;
                 SQL.Add('SELECT SITE_ID_NR, (st_distance(' + QuotedStr('SRID=4326;POINT(' + FloatToStr(Long) + ' ' + FloatToStr(Lat)+ ')') + '::::geometry, GEOMETRY) * 111325) AS M_APART FROM basicinf');
                 SQL.Add('WHERE (st_distance(' + QuotedStr('SRID=4326;POINT(' + FloatToStr(Long) + ' ' + FloatToStr(Lat)+ ')') + '::::geometry, GEOMETRY) * 111325) <= ' + IntToStr(SpinEdit2.Value));
                 SQL.Add('ORDER BY M_APART');
                 SQL.Add('LIMIT 1');
                 Open;
                 if RecordCount > 0 then
                   ExistingSiteID := FieldByName('SITE_ID_NR').AsString;
                 Close;
               end;
          end; //of case
        end;
      end;
    end;
    if ExistingSiteID > '' then  //insert the chemistry
    begin
      SaveSite := False;
      if not CheckBox2.Checked then
      begin
        with ZTable0 do
        begin
          Append;
          FieldByName('SITE_ID_NR').Value := ExistingSiteID;
          FieldByName('CHM_REF_NR').Value := ChmRefNr;
          FieldByName('SAMPLE_NR').Value := PointID;
          if (SdfDataSet.FieldByName('Located on Type').Value = 'Borehole') or (SdfDataSet.FieldByName('Located on Type').Value = 'Spring/Eye') then
            FieldByName('SAMPL_TYPE').Value := 'G'
          else
            FieldByName('SAMPL_TYPE').Value := 'X';
          if not SdfDataSet.FieldByName('Sample Start Date').IsNull then
            FieldByName('DATE_SAMPL').Value := Copy(SdfDataSet.FieldByName('Sample Start Date').AsString, 1, 4)
              + Copy(SdfDataSet.FieldByName('Sample Start Date').AsString, 6, 2)
              + Copy(SdfDataSet.FieldByName('Sample Start Date').AsString, 9, 2)
          else
            FieldByName('DATE_SAMPL').Value := '19000101';
          if not SdfDataSet.FieldByName('Sample Start Time').IsNull then
            FieldByName('TIME_SAMPL').Value := Copy(SdfDataSet.FieldByName('Sample Start Time').AsString, 1, 2)
              + Copy(SdfDataSet.FieldByName('Sample Start Time').AsString, 4, 2)
          else
            FieldByName('TIME_SAMPL').Value := '0000';
          FieldByName('ALT_NR_1').Value := BasicinfQuery.FieldByName('NR_ON_MAP').Value; //basicinf should still be located where site id was found
          if (not SdfDataSet.FieldByName('Sample Start Depth').IsNull) and (SdfDataSet.FieldByName('Sample Start Depth').Value > 0) then
            FieldByName('DEPTH_SAMP').Value := SdfDataSet.FieldByName('Sample Start Depth').AsFloat;
          if not SdfDataSet.FieldByName('Preservative').IsNull then
            FieldByName('COMMENT').Value := 'PRESERVATIVE: '+ SdfDataSet.FieldByName('Preservative').AsString;
          FieldByName('NGDB_FLAG').Value := Flag;
          Post;
        end;
        with ZTable1 do
        begin
          Append;
          FieldByName('CHM_REF_NR').Value := ChmRefNr;
          FieldByName('CA').Value := SdfDataSet.FieldByName('Ca-Diss-Water (CALCIUM) (mg/L) Result').Value;
          FieldByName('CL').Value := SdfDataSet.FieldByName('Cl-Diss-Water (CHLORIDE) (mg/L) Result').Value;
          FieldByName('TDS').Value := SdfDataSet.FieldByName('DMS-Tot-Water (DISSOLVED MAJOR SALTS) (mg/L) Result').Value;
          FieldByName('EC').Value := SdfDataSet.FieldByName('EC-Phys-Water (ELECTRICAL CONDUCTIVITY) (mS/m) Result').Value;
          FieldByName('F').Value := SdfDataSet.FieldByName('F-Diss-Water (FLUORIDE) (mg/L) Result').Value;
          FieldByName('K').Value := SdfDataSet.FieldByName('K-Diss-Water (POTASSIUM) (mg/L) Result').Value;
          FieldByName('MG').Value := SdfDataSet.FieldByName('Mg-Diss-Water (MAGNESIUM) (mg/L) Result').Value;
          FieldByName('NA').Value := SdfDataSet.FieldByName('Na-Diss-Water (SODIUM) (mg/L) Result').Value;
          FieldByName('SO4').Value := SdfDataSet.FieldByName('SO4-Diss-Water (SULPHATE) (mg/L) Result').Value;
          FieldByName('SI').Value := SdfDataSet.FieldByName('Si-Diss-Water (SILICON) (mg/L) Result').Value;
          FieldByName('MALK').Value := SdfDataSet.FieldByName('TAL-Diss-Water (TOTAL ALKALINITY AS CALCIUM CARBONATE) (mg/L) Result').Value;
          FieldByName('PH').Value := SdfDataSet.FieldByName('pH-Diss-Water (PH) (pH units) Result').Value;
          FieldByName('AL').Value := SdfDataSet.FieldByName('Al-Diss-Water (ALUMINIUM) (mg/L) Result').Value;
          FieldByName('FE').Value := SdfDataSet.FieldByName('Fe-Diss-Water (IRON) (mg/L) Result').Value;
          FieldByName('MN').Value := SdfDataSet.FieldByName('Mn-Diss-Water (MANGANESE) (mg/L) Result').Value;
          Post;
        end;
        with ZTable2 do
        begin
          Append;
          FieldByName('CHM_REF_NR').Value := ChmRefNr;
          FieldByName('ARSENIC').Value := SdfDataSet.FieldByName('As-Diss-Water (ARSENIC) (mg/L) Result').Value;
          FieldByName('B').Value := SdfDataSet.FieldByName('B-Diss-Water (BORON) (mg/L) Result').Value;
          FieldByName('BA').Value := SdfDataSet.FieldByName('Ba-Diss-Water (BARIUM) (mg/L) Result').Value;
          FieldByName('CD').Value := SdfDataSet.FieldByName('Cd-Diss-Water (CADMIUM) (mg/L) Result').Value;
          FieldByName('CO').Value := SdfDataSet.FieldByName('Co-Diss-Water (COBALT) (mg/L) Result').Value;
          FieldByName('CR').Value := SdfDataSet.FieldByName('Cr-Diss-Water (CHROMIUM) (mg/L) Result').Value;
          FieldByName('CU').Value := SdfDataSet.FieldByName('Cu-Diss-Water (COPPER) (mg/L) Result').Value;
          FieldByName('HG').Value := SdfDataSet.FieldByName('Hg-Diss-Water (MERCURY) (mg/L) Result').Value;
          FieldByName('MO').Value := SdfDataSet.FieldByName('Mo-Diss-Water (MOLYBDENUM) (mg/L) Result').Value;
          FieldByName('NI').Value := SdfDataSet.FieldByName('Ni-Diss-Water (NICKEL) (mg/L) Result').Value;
          FieldByName('PB').Value := SdfDataSet.FieldByName('Pb-Diss-Water (LEAD) (mg/L) Result').Value;
          FieldByName('SR').Value := SdfDataSet.FieldByName('Sr-Diss-Water (STRONTIUM) (mg/L) Result').Value;
          FieldByName('TI').Value := SdfDataSet.FieldByName('Ti-Diss-Water (TITANIUM) (mg/L) Result').Value;
          FieldByName('ZN').Value := SdfDataSet.FieldByName('Zn-Diss-Water (ZINC) (mg/L) Result').Value;
          Post;
        end;
        with ZTable5 do
        begin
          Append;
          FieldByName('CHM_REF_NR').Value := ChmRefNr;
          FieldByName('BE').Value := SdfDataSet.FieldByName('Be-Diss-Water (BERYLLIUM) (mg/L) Result').Value;
          FieldByName('V').Value := SdfDataSet.FieldByName('V-Diss-Water (VANADIUM) (mg/L) Result').Value;
          Post;
        end;
        Inc(ChmRefNr);
      end;
    end
    else //write site and results to stringlists to save to csv file at the end
    begin
      if SaveSite then
      begin
        SitesNotFound.Add('"' + SdfDataSet.FieldByName('Monitoring Point ID').Value
          + '","' + SdfDataSet.FieldByName('Monitoring Point Name').Value
          + '",' + SdfDataSet.FieldByName('Latitude').Value
          + ',' + SdfDataSet.FieldByName('Longitude').Value
          + ',"' + SdfDataSet.FieldByName('Located on Feature Name').Value
          + '","' + SdfDataSet.FieldByName('Located on Type').Value
          + '","' + SdfDataSet.FieldByName('Drainage Region Name').Value + '"');
        SaveSite := False;
      end;
      ResultsNotLoaded.Add(ResultStr);
    end;
    PrevPointID := PointID;
    SdfDataSet.Next;
  end;
  SDFDataSet.Close;
  BasicinfQuery.Close;
  ZTable0.Close;
  ZTable1.Close;
  ZTable2.Close;
  ZTable5.Close;
  CloseFile(CSVFile);
  if not CheckBox2.Checked then
  begin
    //clean up empty records (those that only have chm_ref_nr)
    ProgressBoxForm.ProgressBar1.Max := 3;
    ProgressBoxForm.ProgressBar1.Position := 0;
    ProgressBoxForm.Label1.Caption := 'Cleaning up chemistry tables with empty records...';
    Application.ProcessMessages;
    Screen.Cursor := crSQLWait;
    with DataModuleMain.ZConnectionDB do
    begin
      ExecuteDirect('DELETE FROM chem_001 WHERE CHM_REF_NR >= '
        + IntToStr(SpinEdit1.Value)
        + ' AND PH = -1 AND EC = -1 AND TDS = -1 AND CA = -1 AND MG = -1 AND NA = -1 AND K = -1 AND SI = -1 AND MALK = -1 AND CL = -1 AND SO4 = -1 AND F = -1 AND AL = -1 AND FE = -1 AND MN = -1');
      ProgressBoxForm.ProgressBar1.Position := 1;
      Sleep(100);
      Application.ProcessMessages;
      ExecuteDirect('DELETE FROM chem_002 WHERE CHM_REF_NR >= '
        + IntToStr(SpinEdit1.Value)
        + ' AND ARSENIC = -1 AND B = -1 AND BA = -1 AND CD = -1 AND CO = -1 AND CR = -1 AND CU = -1 AND HG = -1 AND MO = -1 AND NI = -1 AND PB = -1 AND SR = -1 AND TI = -1 AND ZN = -1');
      ProgressBoxForm.ProgressBar1.Position := 2;
      Sleep(100);
      Application.ProcessMessages;
      ExecuteDirect('DELETE FROM chem_005 WHERE CHM_REF_NR >= '
        + IntToStr(SpinEdit1.Value) + ' AND BE = -1 AND V = -1');
      ProgressBoxForm.ProgressBar1.Position := 3;
      Sleep(100);
      Application.ProcessMessages;
    end;
    if DataModuleMain.ZConnectionDB.Tag = 4 then //reset the autoincement
      DataModuleMain.ZConnectionDB.ExecuteDirect('SELECT setval(''chem_000_chm_ref_nr_seq'', (SELECT MAX(chm_ref_nr) from chem_000));');
  end;
  Screen.Cursor := crDefault;
  ProgressBoxForm.Finished := True;
  if ProgressBoxForm.CancelPressed then
  begin
    ProgressBoxForm.Close;
    Application.ProcessMessages;
    MessageDlg('Import process aborted! Your chemistry may not be completely imported.', mtWarning, [mbOK], 0);
  end
  else
  begin
    ProgressBoxForm.Close;
    Application.ProcessMessages;
    ErrorLog.SaveToFile(WSpaceDir + DirectorySeparator + 'WMSImport.log');
    ErrorLog.Free;
    SitesNotFound.SaveToFile(WSpaceDir + DirectorySeparator + 'WMSSitesNotFound.csv');
    SitesNotFound.Free;
    ResultsNotLoaded.SaveToFile(WSpaceDir + DirectorySeparator + 'WMSResultsNotLoaded.csv');
    ResultsNotLoaded.Free;
    if CheckBox2.Checked then
      MessageDlg('Checking of chemistry completed successfully! Check out your log "WMSImport.log" for error messages and files "WMSSitesNotFound.csv" and "WMSResultsNotLoaded.csv" for records that would not be imported.', mtInformation, [mbOk], 0)
    else
      MessageDlg('Import of chemistry completed successfully! Check out your log "WMSImport.log" for error messages and files "WMSSitesNotFound.csv" and "WMSResultsNotLoaded.csv" for records that could not be imported.', mtInformation, [mbOk], 0);
  end;
  Close; //close the import dialog
end;

procedure TImportWMSForm.MaxQueryBeforeOpen(DataSet: TDataSet);
begin
  MaxQuery.Connection := DataModuleMain.ZConnectionDB;
end;

procedure TImportWMSForm.SpatialQueryBeforeOpen(DataSet: TDataSet);
begin
  SpatialQuery.Connection := DataModuleMain.ZConnectionDB;
end;

procedure TImportWMSForm.SpinEdit1Change(Sender: TObject);
begin
  if SpinEdit1.Value >= 1000 then SpinEdit1.Increment := 100
  else
    if SpinEdit1.Value >= 10000 then SpinEdit1.Increment := 1000;
end;

procedure TImportWMSForm.SpinEdit2Change(Sender: TObject);
begin
  if SpinEdit2.Value < 25 then
    SpinEdit2.Increment := 1
  else
  if SpinEdit2.Value < 100 then
    SpinEdit2.Increment := 5
  else
  if SpinEdit2.Value >= 100 then
    SpinEdit2.Increment := 10;
end;

procedure TImportWMSForm.ZTable0BeforeOpen(DataSet: TDataSet);
begin
  ZTable0.Connection := DataModuleMain.ZConnectionDB;
end;

procedure TImportWMSForm.ZTable0PostError(DataSet: TDataSet; E: EDatabaseError;
  var DataAction: TDataAction);
begin
  DataAction := daAbort;
  MessageDlg(E.Message + ' - Chemistry Sample could not be posted.', mtError, [mbOK], 0);
end;

procedure TImportWMSForm.ZTable1BeforeOpen(DataSet: TDataSet);
begin
  ZTable1.Connection := DataModuleMain.ZConnectionDB;
end;

procedure TImportWMSForm.ZTable1PostError(DataSet: TDataSet; E: EDatabaseError;
  var DataAction: TDataAction);
begin
  DataAction := daAbort;
  MessageDlg(E.Message + ' - Main Parameters chemistry result could not be posted.', mtError, [mbOK], 0);
end;

end.

