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
unit Appendprog;

{$mode objfpc}{$H+}

interface

uses
  LCLIntf, LCLType, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  StdCtrls, Buttons, ComCtrls, ExtCtrls, FileUtil, ZDataset,
  ZConnection, ZDbcSqLite;

type

  { TAppendProgForm }

  TAppendProgForm = class(TForm)
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    ChemQuery: TZReadOnlyQuery;
    ProjectTablePRO_REF_NR: TStringField;
    ProfilingTableTRAV_NR: TStringField;
    ZConnectionOther: TZConnection;
    SelectQuery: TZReadOnlyQuery;
    ProjectTable: TZTable;
    AppendTable: TZTable;
    ProfilingTable: TZTable;
    procedure BitBtn1Click(Sender: TObject);
    procedure GetHiChemRef;
    procedure AdjustProjects;
    procedure AdjustGeophysics;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    ProgCount: Integer;
    IsRunning: Boolean;
    Cancelled: Boolean;
  public
    { Public declarations }
    KeepChmRef, UseView: Boolean;
    HiRefNr: Integer;
    ViewToUse: ShortString;
  end;

var
  AppendProgForm: TAppendProgForm;
  TableList: TStringList;

implementation

{$R *.lfm}

uses VARINIT, MainDataModule;

procedure TAppendProgForm.GetHiChemRef;
begin
  ChemQuery.Connection := DataModuleMain.ZConnectionDB;
  ChemQuery.Open; //determine the highest CHM_REF_NR
  if not ChemQuery.Fields[0].IsNull then
    HiRefNr := ChemQuery.Fields[0].AsInteger
  else
    HiRefNr := 0;
  ChemQuery.Close;
end;

procedure TAppendProgForm.BitBtn1Click(Sender: TObject);
begin
  if MessageDlg('Are you sure you want to cancel the import of the Aquabase workspace? This process will only be stopped after the current table has been imported.', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Cancelled := True
  else
    Cancelled := False;
end;

procedure TAppendProgForm.AdjustProjects;
var HiProjNr: Integer;
begin
  Screen.Cursor := crHourGlass;
  try
    ProjectTable.Connection := DataModuleMain.ZConnectionDB;
    ProjectTable.Open;
    ProjectTable.Locate('PRO_REF_NR', FormatDateTime('YYYY', Date) + '/999', [loPartialKey]);
    try
      HiProjNr := StrToInt(Copy(ProjectTablePRO_REF_NR.Value, 6, 3));
    except on EConvertError do
      HiProjNr := 0;
    end;
    ProjectTable.Close;
  except on EDatabaseError do
    HiProjNr := 0;
  end; //of try
  ProjectTable.Connection := ZConnectionOther;
  if HiProjNr > 0 then
  begin
    ProgressBar1.Position := 0;
    Application.ProcessMessages;
    try
      Label1.Caption := 'Adjusting PRO_REF_NR in Projects and Borehole Siting';
      Application.ProcessMessages;
      ProjectTable.Open;
      ProjectTable.Last;
      if ProjectTable.RecordCount > 0 then
      while not ProjectTable.BOF do
      begin
        ProjectTable.Edit;
        ProjectTablePRO_REF_NR.Value := FormatDateTime('YYYY', Date) + '/'
          + IntToStr(StrToInt(Copy(ProjectTablePRO_REF_NR.Value, 6, 3)) + HiProjNr);
        ProjectTable.Post;
        ProjectTable.Prior;
      end;
      ProjectTable.Close;
      ProgressBar1.Position := Round(1/ProgCount * 100);
      Application.ProcessMessages;
    except on EDatabaseError do
      begin
        Screen.Cursor := crDefault;
        MessageDlg('Could not adjust project number for table "proj_man" or "bhsiting"!',
          mtError, [mbOK], 0);
      end;
    end; //of try
  end;
end;

procedure TAppendProgForm.AdjustGeophysics;
var HiTravNr: Integer;
    NumberStr: ShortString;
begin
  Screen.Cursor := crHourGlass;
  HiTravNr := 0;
  ProfilingTable.Connection := DataModuleMain.ZConnectionDB;
  ProfilingTable.Open;
  if ProfilingTable.RecordCount > 0 then
  begin
    ProfilingTable.Locate('TRAV_NR', FormatDateTime('YYYYMMDD', Date) + 'TRAV9999', [loPartialKey]);
    HiTravNr := StrToInt(Copy(ProfilingTableTRAV_NR.Value, 13, 4));
  end
  else
    HiTravNr := 0;
  ProfilingTable.Close;
  ProfilingTable.Connection := ZConnectionOther;
  if HiTravNr > 0 then
  begin
    ProgressBar1.Position := 0;
    Application.ProcessMessages;
    ProgCount := 7;
    try
      Label1.Caption := 'Adjusting Trav. Nr. in Profiling';
      Application.ProcessMessages;
      ProfilingTable.Open;
      ProfilingTable.Last;
      if ProfilingTable.RecordCount > 0 then
      while not ProfilingTable.BOF do
      begin
        ProfilingTable.Edit;
        NumberStr := Format('%4.4d', [HiTravNr]);
        ProfilingTableTRAV_NR.Value := FormatDateTime('YYYYMMDD', Date) + 'TRAV'
          + Copy(ProfilingTableTRAV_NR.Value, 6, 3) + NumberStr;
        ProfilingTable.Post;
        ProfilingTable.Prior;
      end;
      ProfilingTable.Close;
      ProgressBar1.Position := Round(1/ProgCount * 100);
      Application.ProcessMessages;
    except on EDatabaseError do
      begin
        Screen.Cursor := crDefault;
        MessageDlg('Could not adjust traverse number for table "profilng"!',
          mtError, [mbOK], 0);
        Screen.Cursor := crHourGlass;
      end;
    end; //of try
  end;
end;

procedure TAppendProgForm.FormActivate(Sender: TObject);
var t, i, FldCount, NewHiRefNr: Integer;
    sc: IZSQLiteConnection;
    KeyFieldVal, FName: ShortString;
    ValueStr: String;
    SkipThisTable: Boolean;
    ErrMsg: String;
    loadResult: Word;
begin
  SkipThisTable := False;
  if not IsRunning then
  begin
    IsRunning := True;
    Cursor := crSQLWait;
    with ZConnectionOther do
    if Tag = 1 then
    begin
      ExecuteDirect('PRAGMA foreign_keys = ON;'); //Enable foreign keys on sqlite
      //Spatially enable other database
      sc := DbcConnection as TZSQLiteConnection;
      sc.enable_load_extension(True);
      {$IFDEF DARWIN}
      loadResult := sc.load_extension('mod_spatialite.dylib', '', ErrMsg);
      {$ELSE}
      loadResult := sc.load_extension('mod_spatialite', '', ErrMsg);
      {$ENDIF}
      if loadResult > 0 then
        {$IFDEF WINDOWS}
        MessageDlg('Could not load "mod_spatialite" library! ' + ErrMsg + 'Please make sure it is installed (should be with Aquabase).', mtError, [mbOK], 0);
        {$ENDIF}
        {$IFDEF UNIX}
        MessageDlg('Could not load "mod_spatialite" library! ' + ErrMsg + 'Please make sure it is installed and (on Linux) possibly sym-linked to "mod_spatialite" without the ".so".', mtError, [mbOK], 0);
        {$ENDIF}
    end
    else
    if Tag = 4 then
      ExecuteDirect('SET search_path to "$user", ' + Catalog + ', public;');
    //Get highest CHM_REF_NR if selected
    if HiRefNr = 0 then GetHiChemRef;
    //Adjust project numbers
    if TableList.IndexOf('proj_man') >= 0 then
      AdjustProjects;
    //Adjust Traverse Numbers
    if TableList.IndexOf('profilng') >= 0 then
      AdjustGeophysics;
    //Append all tables
    Application.ProcessMessages;
    Cursor := crDefault;
    for t := 0 to TableList.Count -1 do
    if not Cancelled then
    begin
      ProgressBar1.Position := 0;
      ProgressBar1.Max := 0;
      Label1.Caption := 'Calculating records to append to table "' + TableList[t] + '", please wait...';
      Application.ProcessMessages;
      AppendTable.TableName := TableList[t];
      AppendTable.Open;
      NewHiRefNr := 0;
      //for M$ SQLServer
      if (AppendTable.TableName = 'chem_000') and (DataModuleMain.ZConnectionDB.Tag = 5) then
        DataModuleMain.ZConnectionDB.ExecuteDirect('SET IDENTITY_INSERT chem_000 ON;');
      with SelectQuery do
      begin
        SQL.Clear;
        SQL.Add('SELECT * FROM ' + TableList[t]);
        Screen.Cursor := crSQLWait;
        //check if the table has a SITE_ID_NR then change query
        FieldDefs.Update;
        if UseView and (FieldDefs.IndexOf('SITE_ID_NR') > -1) then
        begin
          SQL.Clear;
          SQL.Add('SELECT * FROM ' + TableList[t] + ' WHERE SITE_ID_NR IN (SELECT SITE_ID_NR FROM ' + ViewToUse + ')');
        end;
        Open;
        Screen.Cursor := crDefault;
        ProgressBar1.Max := RecordCount;
        ProgressBar1.Position := 1;
        FldCount := FieldDefs.Count;
        for i := 0 to FldCount - 1 do
        begin
          FName := Fields[i].FieldName;
          if AppendTable.FieldDefs.IndexOf(FName) = -1 then
            FieldDefs.Delete(FieldDefs.IndexOf(FName)); //ignore because it is deprecated
        end;
        FldCount := FieldDefs.Count;
        AppendTable.FieldDefs.Update;
        while (not EOF) and (not SkipThisTable) do
        begin
          try
            Label1.Caption := 'Appending record ' + IntToStr(ProgressBar1.Position) + ' of ' +
              IntToStr(ProgressBar1.Max) + ' records to table "' + TableList[t] + '"...';
            Application.ProcessMessages;
            if (AppendTable.TableName = 'chem_000') and (DataModuleMain.ZConnectionDB.Tag = 5) then //to cater for new CHM_REF_NRs
            begin
              ValueStr := '';
              NewHiRefNr := FieldByName('CHM_REF_NR').Value;
              for i := 0 to FldCount - 1 do
              begin
                if Fields[i].IsNull then
                  ValueStr := ValueStr + 'NULL, '
                else
                if Fields[i].DataType = ftString then
                  ValueStr := ValueStr + QuotedStr(Fields[i].Value) + ','
                else ValueStr := ValueStr + Fields[i].AsString + ',';
              end;
              SetLength(ValueStr, Length(ValueStr) - 1); //delete last comma
              DataModuleMain.ZConnectionDB.ExecuteDirect('INSERT INTO chem_000 (SITE_ID_NR, SAMPLE_NR, SAMPL_TYPE, DATE_SAMPL, TIME_SAMPL, METH_SAMPL, ALT_NR_1, ALT_NR_2, ALT_NR_3, ALT_NR_4, TIME_PUMP, DEPTH_SAMP, DATE_ANAL, LAB, COMMENT, DATE_ENTRY, DATE_UPDTD, CHM_REF_NR) VALUES (' + ValueStr + ')')
            end
            else
            begin
              AppendTable.Append;
              if (UpperCase(Fields[0].FieldName) = 'ID') or (UpperCase(Fields[0].FieldName) = 'OGR_FID') or (UpperCase(Fields[0].FieldName) = 'FID') then
              begin
                if not AppendTable.Fields[0].ReadOnly then //for M$ SQLServer
                  AppendTable.Fields[0].Value := NULL;
                KeyFieldVal := Fields[1].Value;
                for i := 1 to FldCount - 1 do
                begin
                  FName := Fields[i].FieldName;
                  if (UpperCase(FName) <> 'GEOMETRY') and (AppendTable.FieldDefs.IndexOf(FName) > -1) then
                    AppendTable.FieldByName(FName).Value := FieldByName(FName).Value
                  else
                    AppendTable.Fields[i].Value := NULL;
                end;
              end
              else
              begin
                KeyFieldVal := Fields[0].Value;
                for i := 0 to FldCount - 1 do
                begin
                  FName := Fields[i].FieldName;
                  if FName = 'CHM_REF_NR' then
                  begin
                    if KeepChmRef then
                      AppendTable.Fields[i].AsInteger := FieldByName('CHM_REF_NR').AsInteger
                    else
                      AppendTable.Fields[i].AsInteger := FieldByName('CHM_REF_NR').AsInteger + HiRefNr;
                  end
                  else //all other fields
                  begin
                    if FindField(AppendTable.Fields[i].FieldName) <> NIL then
                      AppendTable.Fields[i].Value := FieldByName(AppendTable.Fields[i].FieldName).Value
                    else
                      AppendTable.Fields[i].Value := Null;
                  end;
                end;
              end;
              AppendTable.Post;
            end;
            Next;
            ProgressBar1.Position := ProgressBar1.Position + 1;
            Application.ProcessMessages;
          except on E: Exception do
            begin
              Cursor := crDefault;
              AppendTable.Cancel;
              ProgressBar1.Position := ProgressBar1.Position + 1;
              Application.ProcessMessages;
              if MessageDlg('Database Error', E.Message + ' - Data for key field value "' + KeyFieldVal + '" could not be imported into table "' + TableList[t] + '"! IGNORE will skip further imports into this table.', mtError, [mbIgnore, mbOK], 0) = mrIgnore then
              begin
                SkipThisTable := True;
                ProgressBar1.Position := ProgressBar1.Max; //so that form canclose if last table
              end
              else
                Next;
            end;
          end;
        end;
      end;
      AppendTable.Close;
      SkipThisTable := False;
      //for M$ SQLServer
      if AppendTable.TableName = 'chem_000' then
      begin
        if DataModuleMain.ZConnectionDB.Tag = 5 then
        begin
          DataModuleMain.ZConnectionDB.ExecuteDirect('SET IDENTITY_INSERT chem_000 OFF;');
          DataModuleMain.ZConnectionDB.ExecuteDirect('DBCC CHECKIDENT (chem_000, RESEED, ' + IntToStr(NewHiRefNr) + ');');
        end
        else
        if DataModuleMain.ZConnectionDB.Tag = 4 then //reset the autoincement
          DataModuleMain.ZConnectionDB.ExecuteDirect('SELECT setval(''chem_000_chm_ref_nr_seq'', (SELECT MAX(chm_ref_nr) from chem_000));');
      end;
      SelectQuery.Close;
      Application.ProcessMessages;
      Cursor := crDefault;
    end;
    if Cancelled then
    begin
      Label1.Caption := 'Finished appending some of the selected table(s)!';
      Application.ProcessMessages;
      Screen.Cursor := crDefault;
      MessageDlg('Import cancelled! Some tables of the Aquabase workspace were successfully imported! You may have to refresh your Basic Information and current View to see the imported records. You may also have to run the "Apply Coordinate System" tool to update your site geometries if "basicinf" was also appended.', mtInformation, [mbOK], 0);
    end
    else
    begin
      Label1.Caption := 'Finished appending the selected table(s)!';
      Application.ProcessMessages;
      Screen.Cursor := crDefault;
      MessageDlg('Finished importing Aquabase workspace (selected tables only)! You may have to refresh your Basic Information and current View to see the imported records.  You may also have to run the "Apply Coordinate System" tool to update your site geometries if "basicinf" was also appended.', mtInformation, [mbOK], 0);
    end;
    Close;
  end;
end;

procedure TAppendProgForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  TableList.Free;
  CloseAction := caFree;
end;

procedure TAppendProgForm.FormCloseQuery(Sender: TObject; var CanClose: boolean
  );
begin
  if ProgressBar1.Position < ProgressBar1.Max then
  begin
    CanClose := False;
    MessageDlg('You cannot interrupt this process now as it will lead to data corruption!', mtWarning, [mbOK], 0);
  end
  else
    CanClose := True;
end;

procedure TAppendProgForm.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  IsRunning := False;
end;

end.
