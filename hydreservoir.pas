{ Copyright (C) 2019 Immo Blecher, immo@blecher.co.za

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
unit hydreservoir;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ButtonPanel, Buttons, DateTimePicker, XMLPropStorage, httpsend;

type

  { THydResForm }

  THydResForm = class(TForm)
    BitBtn1: TBitBtn;
    ButtonPanel1: TButtonPanel;
    ComboBox1: TComboBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LabeledEdit1: TLabeledEdit;
    Memo1: TMemo;
    RadioGroup1: TRadioGroup;
    XMLPropStorage: TXMLPropStorage;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    procedure BitBtn1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure RadioGroup1SelectionChanged(Sender: TObject);
  private
    TheSiteID: ShortString;
    IsMeteo: Boolean;
  public

  end;

var
  HydResForm: THydResForm;

implementation

{$R *.lfm}

{ THydResForm }

uses maindatamodule, VARINIT, ProgressBox, StrDateTime;

procedure THydResForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure THydResForm.BitBtn1Click(Sender: TObject);
var
  HTTP: THTTPSend;
  Result: boolean;
  URLString, S: String;
  StartDate, EndDate, SiteType, DataType, Variable: ShortString;
  YY, MM, DD, m: Word;
begin
  Screen.Cursor := crHourGlass;
  Memo1.Lines.Clear;
  Memo1.Lines.Add('Searching for data...please wait');
  Application.ProcessMessages;
  DecodeDate(DateTimePicker1.Date, YY, MM, DD);
  StartDate := Format('%4d-%2.2d-%2.2d',[YY,MM,DD]);
  DecodeDate(DateTimePicker2.Date, YY, MM, DD);
  EndDate := Format('%4d-%2.2d-%2.2d',[YY,MM,DD]);
  Variable := '100.00'; //default
  case RadioGroup1.ItemIndex of //default
    0: DataType := 'Point';
    1: DataType := 'Daily';
    2: DataType := 'Monthly'
  end;//of case
  case DataModuleMain.BasicinfQuerySITE_TYPE.AsString of
    'R': SiteType := 'RIV';
    'P': SiteType := 'RES';
    'N': begin
           SiteType := 'MET';
           case ComboBox1.ItemIndex of
             0: Variable := '10.0';
             1: Variable := '710.50';
             2: Variable := '711.50';
           end; //of case
           case RadioGroup1.ItemIndex of
             0: DataType := 'Daily';
             1: DataType := 'Monthly'
           end;//of case
         end;
  end; //of case
  URLString := 'http://www.dwa.gov.za/Hydrology/Verified/HyData.aspx?Station=' + LabeledEdit1.Text + Variable + '&DataType=' + DataType + '&StartDT=' + StartDate + '&EndDT=' + EndDate + '&SiteType=' + SiteType;
  if DataType = 'Monthly' then
    URLString := URLString + '&Format=New'; //for columnar data (not matrix)
  try
    Memo1.Lines.Clear;
    HTTP := THTTPSend.Create;
    Result := HTTP.HTTPMethod('GET', URLString);
    if Result then
      Memo1.Lines.LoadFromStream(HTTP.Document);
  finally
    HTTP.Free;
  end;
  if Memo1.Lines[0].StartsWith('<p>') then
  begin
    S := Memo1.Lines[0];
    Delete(S, 1,8);
    Memo1.Lines.Delete(0);
    Memo1.Lines.Insert(0, S);
  end;
  for m := Memo1.Lines.Count - 1 downto 1 do //make sure it shows if there is data or not
  begin
    if Memo1.Lines[m].StartsWith('</pre>') then //the end of the data, wipe till end
    begin
      Memo1.Lines.Delete(m);
      Break;
    end
    else
      Memo1.Lines.Delete(m);
  end;
  if Memo1.Lines[m-1].StartsWith('ZZZ') then //delete the last line
    Memo1.Lines.Delete(m-1);
  if Memo1.Lines.Count > 1 then
    ButtonPanel1.OKButton.Enabled := True;
  Screen.Cursor := crDefault;
end;

procedure THydResForm.ComboBox1Change(Sender: TObject);
begin
  RadioGroup1.Enabled := (not IsMeteo) and (ComboBox1.ItemIndex > 0);
end;

procedure THydResForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  Memo1.Font.Name := 'Courier New';
end;

procedure THydResForm.FormShow(Sender: TObject);
begin
  LabeledEdit1.Text := DataModuleMain.BasicinfQueryNR_ON_MAP.AsString;
  TheSiteID := DataModuleMain.BasicinfQuerySITE_ID_NR.AsString;
  if DataModuleMain.BasicinfQueryDATE_COMPL.AsString > '' then
    DateTimePicker1.Date := StringToDate(DataModuleMain.BasicinfQueryDATE_COMPL.Value);
  DateTimePicker2.Date := Date;
  DateTimePicker2.Time := Time;
  if DataModuleMain.BasicinfQuerySITE_TYPE.AsString = 'N' then
  begin
    ComboBox1.Items.Add('Rainfall [mm]');
    ComboBox1.Items.Add('Evaporation from A Class Pan [mm]');
    ComboBox1.Items.Add('Evaporation from S Class Pan [mm]');
    RadioGroup1.Items.Delete(0);
    RadioGroup1.ItemIndex := 1;
    RadioGroup1.Enabled := True;
    IsMeteo := True;
  end
  else
  if (DataModuleMain.BasicinfQuerySITE_TYPE.AsString = 'R')
    or (DataModuleMain.BasicinfQuerySITE_TYPE.AsString = 'P') then
  begin
    ComboBox1.Items.Add('Surface Water Level [m]');
    ComboBox1.Items.Add('Flow Discharge [m3/s]');
  end
  else
  begin
    BitBtn1.Enabled := False;
    MessageDlg('This site does not seem to be a Hydrology monitoring station! Make sure your Site Type is set to a dam, river or meteorological station in your Basic Information and that your site number corresponds to the DWS Hydrology number.', mtWarning, [mbOK], 0)
  end;
  ComboBox1.ItemIndex := 0;
end;

procedure THydResForm.OKButtonClick(Sender: TObject);
var
  m: Word; //there is at most just over 7000 lines in memo
  Nr_Columns, MinusPos, DataStart: Byte;
  TheColFrom: Array[0..9] of Word;
  TheColTo: Array[0..9] of Word;
  TheColumns: Array[0..9] of ShortString; //there are less than 10 columns
  S, TheTable: ShortString;
  ErrorLog: TStringList;
  IgnoreErrors: Boolean;
begin
  ButtonPanel1.OKButton.Enabled := False;
  ErrorLog := TStringList.Create;
  IgnoreErrors := False;
  Nr_Columns := 0;
  for m := 0 to 9 do //initialise arrays
  begin
    TheColFrom[m] := 0;
    TheColTo[m] := 0;
    TheColumns[m] := '';
  end;
  if IsMeteo then
  begin
    if (ComboBox1.ItemIndex = 0) then
      TheTable := 'rainfall'
    else
      TheTable := 'pan_evap';
  end
  else
  begin
    if (ComboBox1.ItemIndex = 0) then
      TheTable := 'stage_hi'
    else
      TheTable := 'flow_dis';
  end;
  //Determine line where data starts
  for m := 0 to 20 do //should be within the first 20 lines
    if Memo1.Lines[m].StartsWith('DATE') then
    begin
      DataStart := m;
      Break;
    end;
  ProgressBoxForm := TProgressBoxForm.Create(Application);
  with ProgressBoxForm do
  begin
    Caption := 'Importing online data...';
    Label1.Caption := 'Importing data for ' + LabeledEdit1.Text + ' into "' + TheTable + '"...';
    ProgressBar1.Max := Memo1.Lines.Count - DataStart;
    ProgressBar1.Position := 0;
    Show;
    Application.ProcessMessages;
  end;
  Visible := False; //make the DWS dialog invisible
  for m := 0 to Memo1.Lines.Count -1 do
  begin
    if Memo1.Lines[m].StartsWith('POS.') then //determine the column widths
    begin
      S := Copy(Memo1.Lines[m], 5, 7);
      S := TrimLeft(S);
      S := TrimRight(S);
      MinusPos := Pos('-', S);
      TheColFrom[Nr_Columns] := StrToInt(Copy(S, 1, MinusPos-1));
      TheColTo[Nr_Columns] := StrToInt(Copy(S, MinusPos+1, Length(S)-MinusPos));
      Inc(Nr_Columns);
    end
    else
    //if (Copy(Memo1.Lines[m], 1, 2) >= '18') and (Copy(Memo1.Lines[m], 1, 2) < '99') then //from years 1800 to 9900
    if (m > DataStart) and (not ProgressBoxForm.CancelPressed) then
    begin
     ProgressBoxForm.ProgressBar1.Position := ProgressBoxForm.ProgressBar1.Position + 1;
     Application.ProcessMessages;
     //fill in the columns
      TheColumns[0] := TheSiteID;
      if IsMeteo then //meteorological station
      begin
        TheColumns[1] := 'DWA';
        TheColumns[2] := 'I';
        if (RadioGroup1.ItemIndex = 0) then //daily
          TheColumns[3] := Copy(Memo1.Lines[m], TheColFrom[0], 8) //Date
        else //monthly
          TheColumns[3] := Copy(Memo1.Lines[m], TheColFrom[0], 6) + '15'; //Date in the middle of the month
        TheColumns[4] := '1200'; //time in the middle of the day
        TheColumns[5] := TrimLeft(Copy(Memo1.Lines[m], TheColFrom[1], TheColTo[1] + 1 - TheColFrom[1])); //the reading
        //insert the data
        if TheColumns[5] <> '' then //check if there is actually data
        try
          DataModuleMain.ZConnectionDB.ExecuteDirect('INSERT INTO ' + TheTable + ' (SITE_ID_NR, REP_INST, INFO_SOURC, DATE_MEAS, TIME_MEAS, READING) VALUES ('
            + QuotedStr(TheColumns[0]) + ', ' + QuotedStr(TheColumns[1]) + ', ' + QuotedStr(TheColumns[2]) + ', ' + QuotedStr(TheColumns[3]) + ', ' + QuotedStr(TheColumns[4]) + ', ' + TheColumns[5] + ');');
          Screen.Cursor := crDefault;
        except on E: Exception do
          begin
            ErrorLog.Add(E.Message + '. The line "' + Memo1.Lines[m] + ' was not inserted into the table "' + TheTable + '"');
            Screen.Cursor := crDefault;
            if not IgnoreErrors then
              if  MessageDlg(E.Message + '. The line "' + Memo1.Lines[m] + ' was not inserted into the table "' + TheTable + '"! This may be due to foreign or unique key violations or online data errors. "Ignore" prevents further error messages for this table.', mtWarning, [mbOK, mbIgnore], 0) = mrIgnore then
                IgnoreErrors := True;
          end;
        end; //of try
      end
      else //Rivers and reservoirs
      begin
        TheColumns[1] := 'I';
        if RadioGroup1.ItemIndex <= 1 then //primary and daily data
          TheColumns[2] := Copy(Memo1.Lines[m], TheColFrom[0], 8) //Date
        else //monthly
          TheColumns[2] := Copy(Memo1.Lines[m], TheColFrom[0], 6) + '15'; //Date in the middle of the month
        if ComboBox1.ItemIndex = 0 then //surface WL, so get the time
          TheColumns[3] := Copy(Memo1.Lines[m], TheColFrom[1], 4) //time without secs
        else
          TheColumns[3] := '1200'; //time in the middle of the day
        case ComboBox1.ItemIndex of
          0: TheColumns[4] := TrimLeft(Copy(Memo1.Lines[m], TheColFrom[2], TheColTo[2] + 1 - TheColFrom[2])); //the WL
          1: case RadioGroup1.ItemIndex of
               0: TheColumns[4] := TrimLeft(Copy(Memo1.Lines[m], TheColFrom[4], TheColTo[4] + 1 - TheColFrom[4])); //the primary flow
               1: TheColumns[4] := TrimLeft(Copy(Memo1.Lines[m], TheColFrom[1], TheColTo[1] + 1 - TheColFrom[1])); //the daily flow
               2: TheColumns[4] := TrimLeft(Copy(Memo1.Lines[m], TheColFrom[1], TheColTo[1] + 1 - TheColFrom[1])); //the monthly flow
             end; //of inner case
        end; //of case
        //insert the data
        if TheColumns[4] <> '' then //check if there is actually data
        try
          if ComboBox1.ItemIndex = 0 then
            DataModuleMain.ZConnectionDB.ExecuteDirect('INSERT INTO ' + TheTable + ' (SITE_ID_NR, INFO_SOURC, DATE_MEAS, TIME_MEAS, STAGE_HIGH) VALUES ('
              + QuotedStr(TheColumns[0]) + ', ' + QuotedStr(TheColumns[1]) + ', ' + QuotedStr(TheColumns[2]) + ', ' + QuotedStr(TheColumns[3]) + ', ' + TheColumns[4] + ');')
          else
          begin
            if RadioGroup1.ItemIndex <= 1 then
              DataModuleMain.ZConnectionDB.ExecuteDirect('INSERT INTO ' + TheTable + ' (SITE_ID_NR, INFO_SOURC, DATE_MEAS, TIME_MEAS, DIS_FLOW) VALUES ('
                + QuotedStr(TheColumns[0]) + ', ' + QuotedStr(TheColumns[1]) + ', ' + QuotedStr(TheColumns[2]) + ', ' + QuotedStr(TheColumns[3]) + ', ' + FloatToStr(StrToFloat(TheColumns[4]) * 1000) + ');') //data to convert from m3/s to l/sec
            else
              DataModuleMain.ZConnectionDB.ExecuteDirect('INSERT INTO ' + TheTable + ' (SITE_ID_NR, INFO_SOURC, DATE_MEAS, TIME_MEAS, DIS_FLOW) VALUES ('
                + QuotedStr(TheColumns[0]) + ', ' + QuotedStr(TheColumns[1]) + ', ' + QuotedStr(TheColumns[2]) + ', ' + QuotedStr(TheColumns[3]) + ', ' + FloatToStr(StrToFloat(TheColumns[4]) * 1000000 * 1000 / 365 * 12 / 24 / 3600) + ');') //data to convert from Mm3/m to l/sec
          end;                                                                                                                                                                  // Million m3              in l    /day      /h   /s
          Screen.Cursor := crDefault;
        except on E: Exception do
          begin
            ErrorLog.Add(E.Message + '. The line "' + Memo1.Lines[m] + ' was not inserted into the table "' + TheTable + '"');
            Screen.Cursor := crDefault;
            if not IgnoreErrors then
              if  MessageDlg(E.Message + '. The line "' + Memo1.Lines[m] + ' was not inserted into the table "' + TheTable + '"! This may be due to foreign or unique key violations or online data errors. "Ignore" prevents further error messages for this table.', mtWarning, [mbOK, mbIgnore], 0) = mrIgnore then
                IgnoreErrors := True;
          end;
        end; //of try
      end;
    end;
    ProgressBoxForm.Finished := True;
  end;
  if ProgressBoxForm.CancelPressed then
  begin
    ProgressBoxForm.Close;
    Application.ProcessMessages;
    MessageDlg('Import process aborted! Your data may not be completely imported.', mtWarning, [mbOK], 0);
  end
  else
  begin
    ProgressBoxForm.Close;
    Application.ProcessMessages;
    MessageDlg('Import of online data completed successfully! Check out your log file "OnlineImport.log" for error messages.', mtInformation, [mbOk], 0);
  end;
  if ErrorLog.Count > 0 then
    ErrorLog.SaveToFile(WSpaceDir + DirectorySeparator + 'OnlineImport.log');
  ErrorLog.Free;
  Close;
end;

procedure THydResForm.RadioGroup1SelectionChanged(Sender: TObject);
begin
  if Showing then
  begin
    if IsMeteo and (RadioGroup1.ItemIndex = 0) then
      MessageDlg('Daily station data is sometimes the same for the whole month; eg. just calculated daily from the monthly reading! While this is not a problem, it leads to the import of unnecessary repeats of the same data.', mtInformation, [mbOK], 0);
    //clear the memo
    Memo1.Clear;
    Memo1.Lines.Add('Nothing found yet. Retrieve data with button above');
    ButtonPanel1.OKButton.Enabled := False;
  end;
end;

end.

