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
unit importSYNOP;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ButtonPanel, StdCtrls,
  Grids, ExtCtrls, Buttons, Spin, XMLPropStorage, uPascalTZ, DateTimePicker,
  fphttpclient, openssl, StrUtils, DB, DateUtils;

type

  { TFormSYNOP }

  TFormSYNOP = class(TForm)
    BitBtnRetrieve: TBitBtn;
    ButtonPanel1: TButtonPanel;
    CheckBoxNoReading: TCheckBox;
    CheckBoxDelete: TCheckBox;
    ComboBoxTZ: TComboBox;
    ComboBoxDataVar: TComboBox;
    ComboBoxScope: TComboBox;
    ComboBoxNumber: TComboBox;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    LabelStation: TLabel;
    LabeledEdit1: TLabeledEdit;
    PascalTZ1: TPascalTZ;
    SpinEdit1: TSpinEdit;
    StringGridRainfall: TStringGrid;
    StringGridMeteo: TStringGrid;
    XMLPropStorage1: TXMLPropStorage;
    procedure BitBtnRetrieveClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure ComboBoxDataVarChange(Sender: TObject);
    procedure ComboBoxScopeChange(Sender: TObject);
    procedure ComboBoxNumberChange(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    Months: TStringList;
    Memo1: TMemo;
  public

  end;

var
  FormSYNOP: TFormSYNOP;

implementation

{$R *.lfm}

uses MainDataModule, VARINIT, progressbox;

{ TFormSYNOP }

procedure TFormSYNOP.FormCreate(Sender: TObject);
var
  YY, MM, DD, NrDays, l: Word;
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, False);
  StringGridRainfall.RowHeights[0] := 30;
  StringGridRainfall.Align := alBottom;
  StringGridMeteo.RowHeights[0] := 30;
  //set end date to last day of month for previous month from now
  DateTimePicker2.DateTime := IncMonth(Now, - 1);
  DecodeDate(DateTimePicker2.Date, YY, MM, DD);
  NrDays := DaysInAMonth(YY, MM);
  DateTimePicker2.Date := EncodeDate(YY, MM, NrDays);
  DateTimePicker2.MaxDate := DateTimePicker2.Date;
  DateTimePicker1.MaxDate := EncodeDate(YY, MM, 1);
  LabeledEdit1.Text := DataModuleMain.BasicinfQueryNR_ON_MAP.Value;
  Memo1 := TMemo.Create(Self);
  with Memo1 do
  begin
    Visible := False;
    WordWrap := False;
    if DirectoryExists(ProgramDir + DirectorySeparator + 'TimeZones') then
    begin
      Lines.LoadFromFile(ProgramDir + DirectorySeparator + 'TimeZones' + DirectorySeparator + 'zone1970.tab');
      for l := 35 to Lines.Count - 1 do
        ComboBoxTZ.Items.Add(ExtractWord(3, Lines[l], [#9]));
    end
    else
    begin
      ComboBoxTZ.Items.Add('Africa/Johannesburg');
    end;
    ComboBoxTZ.ItemIndex := ComboBoxTZ.Items.IndexOf('Africa/Johannesburg');
    Clear;
  end;
  //init months stringlist
  Months := TStringList.Create;
  Months.Add('January');
  Months.Add('February');
  Months.Add('March');
  Months.Add('April');
  Months.Add('May');
  Months.Add('June');
  Months.Add('July');
  Months.Add('August');
  Months.Add('September');
  Months.Add('October');
  Months.Add('November');
  Months.Add('December');
end;

procedure TFormSYNOP.OKButtonClick(Sender: TObject);
var
  ErrorLog: TStringList;
  TheDate: TDate;
  TheTime, UTCTime: TTime;
  DateStr, TimeStr, SiteID: ShortString;
  Y, M, D, r: Word;
  TheDay: Byte;
  CellValue: Double;
  IgnoreErrors: Boolean;
begin
  SiteID := CurrentSite;
  ErrorLog := TStringList.Create;
  IgnoreErrors := False;
  //import rainfall
  if ComboBoxDataVar.ItemIndex = 0 then
  begin
    //delete previous data if required
    if CheckBoxDelete.Checked and (MessageDlg('Are you sure you want to delete previously stored rainfall data within this date range?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    begin
      DataModuleMain.ZConnectionDB.ExecuteDirect('DELETE FROM rainfall WHERE site_id_nr = '
        + QuotedStr(SiteID) + ' AND date_meas >= '
        + QuotedStr(FormatDateTime('YYYYMMDD', DateTimePicker1.Date))+ ' AND date_meas < '
        + QuotedStr(FormatDateTime('YYYYMMDD', IncMonth(DateTimePicker2.Date))))
    end;
    ProgressBoxForm := TProgressBoxForm.Create(Application);
    with ProgressBoxForm do
    begin
      Caption := 'Importing ' + ComboBoxDataVar.Text + ' Data';
      Label1.Caption := 'Initialising ' + ComboBoxDataVar.Text + ' import...';
      ProgressBar1.Max := StringGridRainfall.RowCount - 1;
      ProgressBar1.Position := 0;
      Show;
      Application.ProcessMessages;
    end;
    Sleep(100);
    Visible := False; //make the dialog invisible
    Application.ProcessMessages;
    for r := 1 to StringGridRainfall.RowCount - 1 do
    if not ProgressBoxForm.CancelPressed then
    begin
      ProgressBoxForm.Finished := False;
      ProgressBoxForm.ProgressBar1.Position := r;
      DateStr := StringGridRainfall.Cells[0, r];
      ProgressBoxForm.Label1.Caption := 'Importing ' + ComboBoxDataVar.Text + ' for ' + DateStr;
      Application.ProcessMessages;
      TheDate := EncodeDate(StrToInt(RightStr(DateStr, 4)), Months.IndexOf(ExtractWord(1, DateStr, [' '])) + 1, 1);
      DecodeDate(TheDate, Y, M, D);
      TheDay := SpinEdit1.Value;
      if TheDay > 28 then //check for last day
        TheDay := DaysInAMonth(Y, M);
      TheDate := EncodeDate(Y, M, TheDay);
      //get the value for the reading
      CellValue := -1;
      if StringGridRainfall.Cells[6, r] <> '-' then
        CellValue := StrToFloat(StringGridRainfall.Cells[6, r])
      else
      if (StringGridRainfall.Cells[6, r] = '-') and CheckBoxNoReading.Checked then
        CellValue := 0;
      if CellValue >= 0 then //store as there is a value
      with DataModuleMain.ZConnectionDB do
      begin
        try
        ExecuteDirect('INSERT INTO rainfall (SITE_ID_NR, REP_INST, INFO_SOURC, DATE_MEAS, TIME_MEAS, READING, NGDB_FLAG) VALUES ('
          + QuotedStr(SiteID) + ', ' + QuotedStr('METM') + ', ' + QuotedStr('I') + ', ' + QuotedStr(FormatDateTime('YYYYMMDD', TheDate)) + ', '
          + QuotedStr('1200') + ', ' + FloatToStr(CellValue) + ', ' + IntToStr(77) + ');');
        except on E: Exception do
          begin
            ErrorLog.Add(E.Message + ' - Could not insert ' + ComboBoxDataVar.Text + ' record for ' + DateToStr(TheDate) + '!');
            if not IgnoreErrors and (MessageDlg(E.Message + ' - Could not insert ' + ComboBoxDataVar.Text + ' record for ' + DateToStr(TheDate) + '!', mtError, [mbIgnore, mbOK], 0) = mrIgnore) then
              IgnoreErrors := True;
          end;
        end;
      end;
      ProgressBoxForm.Finished := True;
    end
  end
  else //other meteorology
  begin
    PascalTZ1.DatabasePath := ProgramDir + DirectorySeparator + 'TimeZones';
    //delete previous data if required
    if CheckBoxDelete.Checked and (MessageDlg('Are you sure you want to delete previously stored data from the meteorology tables within this date range?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    begin
      if ComboBoxDataVar.ItemIndex IN [1, 5] then
        DataModuleMain.ZConnectionDB.ExecuteDirect('DELETE FROM air_temp WHERE site_id_nr = '
        + QuotedStr(SiteID) + ' AND date_meas >= '
        + QuotedStr(FormatDateTime('YYYYMMDD', DateTimePicker1.Date))+ ' AND date_meas < '
        + QuotedStr(FormatDateTime('YYYYMMDD', IncMonth(DateTimePicker2.Date))));
      if ComboBoxDataVar.ItemIndex IN [2, 5] then
        DataModuleMain.ZConnectionDB.ExecuteDirect('DELETE FROM humidity WHERE site_id_nr = '
        + QuotedStr(SiteID) + ' AND date_meas >= '
        + QuotedStr(FormatDateTime('YYYYMMDD', DateTimePicker1.Date))+ ' AND date_meas < '
        + QuotedStr(FormatDateTime('YYYYMMDD', IncMonth(DateTimePicker2.Date))));
      if ComboBoxDataVar.ItemIndex IN [3, 5] then
        DataModuleMain.ZConnectionDB.ExecuteDirect('DELETE FROM pressure WHERE site_id_nr = '
        + QuotedStr(SiteID) + ' AND date_meas >= '
        + QuotedStr(FormatDateTime('YYYYMMDD', DateTimePicker1.Date))+ ' AND date_meas < '
        + QuotedStr(FormatDateTime('YYYYMMDD', IncMonth(DateTimePicker2.Date))));
      if ComboBoxDataVar.ItemIndex >= 4 then
        DataModuleMain.ZConnectionDB.ExecuteDirect('DELETE FROM windvdir WHERE site_id_nr = '
        + QuotedStr(SiteID) + ' AND date_meas >= '
        + QuotedStr(FormatDateTime('YYYYMMDD', DateTimePicker1.Date))+ ' AND date_meas < '
        + QuotedStr(FormatDateTime('YYYYMMDD', IncMonth(DateTimePicker2.Date))));
    end;
    ProgressBoxForm := TProgressBoxForm.Create(Application);
    with ProgressBoxForm do
    begin
      Caption := 'Importing ' + ComboBoxDataVar.Text + ' Data';
      Label1.Caption := 'Initialising ' + ComboBoxDataVar.Text + ' import...';
      ProgressBar1.Max := StringGridRainfall.RowCount - 1;
      ProgressBar1.Position := 0;
      Show;
      Application.ProcessMessages;
    end;
    Sleep(100);
    Visible := False; //make the dialog invisible
    Application.ProcessMessages;
    ProgressBoxForm.ProgressBar1.Max := StringGridMeteo.RowCount - 1;
    for r := 1 to StringGridMeteo.RowCount - 1 do
    if not ProgressBoxForm.CancelPressed then
    begin
      ProgressBoxForm.Finished := False;
      ProgressBoxForm.ProgressBar1.Position := r;
      DateStr := ExtractWord(1, StringGridMeteo.Cells[0, r], [' ']);
      DateStr := RightStr(DateStr, 4) + MidStr(DateStr, 4, 2) + LeftStr(DateStr, 2);
      TheDate := EncodeDate(StrToInt(LeftStr(DateStr, 4)), StrToInt(MidStr(DateStr, 5, 2)), StrToInt(RightStr(DateStr, 2)));
      TimeStr := ExtractWord(2, StringGridMeteo.Cells[0, r], [' ']);
      UTCTime := EncodeTime(StrToInt(LeftStr(TimeStr, 2)), StrToInt(RightStr(TimeStr, 2)), 0, 0);
      TheTime := PascalTZ1.GMTToLocalTime(UTCTime, ComboBoxTZ.Text);
      TimeStr := FormatDateTime('hhnn', TheTime);
      ProgressBoxForm.Label1.Caption := 'Importing ' + ComboBoxDataVar.Text + ' for ' + DateToStr(TheDate) + ' ' + TimeToStr(TheTime);
      Application.ProcessMessages;
      //get the value for the readings
      if ComboBoxDataVar.ItemIndex IN [1, 5] then //temperature
      begin
        CellValue := -999;
        try
          if (StringGridMeteo.Cells[1, r] > '') and (StringGridMeteo.Cells[1, r] <> '-') then
            CellValue := StrToFloat(StringGridMeteo.Cells[1, r]);
          if CellValue > -999 then //store as there is a value
          with DataModuleMain.ZConnectionDB do
            ExecuteDirect('INSERT INTO air_temp (SITE_ID_NR, REP_INST, INFO_SOURC, DATE_MEAS, TIME_MEAS, READING, READ_TYPE, NGDB_FLAG) VALUES ('
              + QuotedStr(SiteID) + ', ' + QuotedStr('METM') + ', ' + QuotedStr('I') + ', ' + QuotedStr(DateStr) + ', '
              + QuotedStr(TimeStr) + ', ' + FloatToStr(CellValue) + ', ' + QuotedStr('N') + ', ' + IntToStr(77) + ');');
        except on E: Exception do
          begin
            ErrorLog.Add(E.Message + ' - Could not insert ' + ComboBoxDataVar.Text + ' record for ' + DateToStr(TheDate) + '!');
            if not IgnoreErrors and (MessageDlg(E.Message + ' - Could not insert ' + ComboBoxDataVar.Text + ' record for ' + DateToStr(TheDate) + '!', mtError, [mbIgnore, mbOK], 0) = mrIgnore) then
              IgnoreErrors := True;
          end;
        end;
      end;
      if ComboBoxDataVar.ItemIndex IN [2, 5] then //humidty
      begin
        CellValue := 0;
        try
          if (StringGridMeteo.Cells[2, r] > '') and (StringGridMeteo.Cells[2, r] <> '-') then
            CellValue := StrToFloat(StringGridMeteo.Cells[2, r]);
          with DataModuleMain.ZConnectionDB do
            if (CellValue > 0) and (StringGridMeteo.Cells[6, r] > '-') then
              ExecuteDirect('INSERT INTO humidity (SITE_ID_NR, REP_INST, INFO_SOURC, DATE_MEAS, TIME_MEAS, READING, CONDITIONS, NGDB_FLAG) VALUES ('
                + QuotedStr(SiteID) + ', ' + QuotedStr('METM') + ', ' + QuotedStr('I') + ', ' + QuotedStr(DateStr) + ', '
                + QuotedStr(TimeStr) + ', ' + FloatToStr(CellValue) + ', ' + QuotedStr(StringGridMeteo.Cells[6, r]) + ', ' + IntToStr(77) + ');')
            else
            if StringGridMeteo.Cells[6, r] > '-' then
              ExecuteDirect('INSERT INTO humidity (SITE_ID_NR, REP_INST, INFO_SOURC, DATE_MEAS, TIME_MEAS, READING, CONDITIONS, NGDB_FLAG) VALUES ('
                + QuotedStr(SiteID) + ', ' + QuotedStr('METM') + ', ' + QuotedStr('I') + ', ' + QuotedStr(DateStr) + ', '
                + QuotedStr(TimeStr) + ', NULL' + ', ' + QuotedStr(StringGridMeteo.Cells[6, r]) + ', ' + IntToStr(77) + ');')
        except on E: Exception do
          begin
            ErrorLog.Add(E.Message + ' - Could not insert ' + ComboBoxDataVar.Text + ' record for ' + DateToStr(TheDate) + '!');
            if not IgnoreErrors and (MessageDlg(E.Message + ' - Could not insert ' + ComboBoxDataVar.Text + ' record for ' + DateToStr(TheDate) + '!', mtError, [mbIgnore, mbOK], 0) = mrIgnore) then
              IgnoreErrors := True;
          end;
        end;
      end;
      if ComboBoxDataVar.ItemIndex IN [3, 5] then //pressure
      begin
        CellValue := 0;
        try
          if (StringGridMeteo.Cells[3, r] > '') and (StringGridMeteo.Cells[3, r] <> '-') then
          begin
            if Pos('m', StringGridMeteo.Cells[3, r]) > 0 then //is in geopotential meters, sodo not import
              CellValue := 0
            else
              CellValue := StrToFloat(StringGridMeteo.Cells[3, r]) * 100;
          end;
          if CellValue > 0 then //store as there is a value
          with DataModuleMain.ZConnectionDB do
            ExecuteDirect('INSERT INTO pressure (SITE_ID_NR, REP_INST, INFO_SOURC, DATE_MEAS, TIME_MEAS, READING, NGDB_FLAG) VALUES ('
              + QuotedStr(SiteID) + ', ' + QuotedStr('METM') + ', ' + QuotedStr('I') + ', ' + QuotedStr(DateStr) + ', '
              + QuotedStr(TimeStr) + ', ' + FloatToStr(CellValue) + ', ' + IntToStr(77) + ');');
        except on E: Exception do
          begin
            ErrorLog.Add(E.Message + ' - Could not insert ' + ComboBoxDataVar.Text + ' record for ' + DateToStr(TheDate) + '!');
            if not IgnoreErrors and (MessageDlg(E.Message + ' - Could not insert ' + ComboBoxDataVar.Text + ' record for ' + DateToStr(TheDate) + '!', mtError, [mbIgnore, mbOK], 0) = mrIgnore) then
              IgnoreErrors := True;
          end;
        end;
      end;
      if ComboBoxDataVar.ItemIndex >= 4 then //wind direction and speed
      begin
        try
          if StringGridMeteo.Cells[4, r] = 'calm.' then
            CellValue := 0
          else
          if (StringGridMeteo.Cells[5, r] > '') and (StringGridMeteo.Cells[5, r] <> '-') then
            CellValue := StrToFloat(StringGridMeteo.Cells[5, r]) / 3.6;
          with DataModuleMain.ZConnectionDB do
            if CellValue = 0 then
              ExecuteDirect('INSERT INTO windvdir (SITE_ID_NR, REP_INST, INFO_SOURC, DATE_MEAS, TIME_MEAS, READING, DIRECTION, NGDB_FLAG) VALUES ('
                + QuotedStr(SiteID) + ', ' + QuotedStr('METM') + ', ' + QuotedStr('I') + ', ' + QuotedStr(DateStr) + ', '
                + QuotedStr(TimeStr) + ', ' + FloatToStr(CellValue) + ', NULL, ' + IntToStr(77) + ');')
            else
              ExecuteDirect('INSERT INTO windvdir (SITE_ID_NR, REP_INST, INFO_SOURC, DATE_MEAS, TIME_MEAS, READING, DIRECTION, NGDB_FLAG) VALUES ('
                + QuotedStr(SiteID) + ', ' + QuotedStr('METM') + ', ' + QuotedStr('I') + ', ' + QuotedStr(DateStr) + ', '
                + QuotedStr(TimeStr) + ', ' + FloatToStr(CellValue) + ', ' + StringGridMeteo.Cells[4, r] + ', ' + IntToStr(77) + ');')
        except on E: Exception do
          begin
            ErrorLog.Add(E.Message + ' - Could not insert ' + ComboBoxDataVar.Text + ' record for ' + DateToStr(TheDate) + '!');
            if not IgnoreErrors and (MessageDlg(E.Message + ' - Could not insert ' + ComboBoxDataVar.Text + ' record for ' + DateToStr(TheDate) + '!', mtError, [mbIgnore, mbOK], 0) = mrIgnore) then
              IgnoreErrors := True;
          end;
        end;
      end;
      ProgressBoxForm.Finished := True;
    end
  end;
  ErrorLog.Add('All other ' + ComboBoxDataVar.Text + ' values were saved to the import table(s) with ngdb_flag = 77.');
  ErrorLog.SaveToFile(WSpaceDir + DirectorySeparator + 'synop_import.log');
  ErrorLog.Free;
  if ProgressBoxForm.CancelPressed then
  begin
    Application.ProcessMessages;
    MessageDlg('Import process aborted! Your ' + ComboBoxDataVar.Text + ' data may not be completely imported.', mtWarning, [mbOK], 0);
  end
  else
    MessageDlg('Finished importing ' + ComboBoxDataVar.Text + ' data. The "ngdb_flag" for imported records was set to 77. Please see synop_import.log for failed error messages.', mtInformation, [mbOK], 0);
  ProgressBoxForm.Close;
end;

procedure TFormSYNOP.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Months.Free;
  Memo1.Free;
  CloseAction := caFree;
end;

procedure TFormSYNOP.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TFormSYNOP.ComboBoxDataVarChange(Sender: TObject);
begin
  if ComboBoxDataVar.ItemIndex = 0 then
  begin
    MessageDlg('3-hourly Rainfall not available! Please select another parameter.', mtWarning, [mbOK], 0);
    ComboBoxDataVar.ItemIndex := 1;
  end;
end;

procedure TFormSYNOP.ComboBoxScopeChange(Sender: TObject);
begin
  if ComboBoxScope.ItemIndex = 1 then
  begin
    ComboBoxDataVar.ItemIndex := 1;
    ComboBoxDataVar.Enabled := True;
    SpinEdit1.Enabled := False;
    StringGridRainfall.Visible := False;
    StringGridRainfall.Align := alNone;
    StringGridMeteo.Align := alBottom;
    StringGridMeteo.Visible := True;
    CheckBoxNoReading.Enabled := False;
  end
  else
  begin
    ComboBoxDataVar.ItemIndex := 0;
    ComboBoxDataVar.Enabled := False;
    SpinEdit1.Enabled := True;
    StringGridMeteo.Visible := False;
    StringGridMeteo.Align := alNone;
    StringGridRainfall.Align := alBottom;
    StringGridRainfall.Visible := True;
    CheckBoxNoReading.Enabled := True;
  end;
end;

procedure TFormSYNOP.ComboBoxNumberChange(Sender: TObject);
begin
  if ComboBoxNumber.ItemIndex = 0 then
    LabeledEdit1.Text := DataModuleMain.BasicinfQueryNR_ON_MAP.Value
  else
    LabeledEdit1.Text := DataModuleMain.BasicinfQueryALT_NO_2.Value;
  BitBtnRetrieve.Enabled := LabeledEdit1.Text > '';
end;

procedure TFormSYNOP.DateTimePicker1Change(Sender: TObject);
begin
  DateTimePicker2.MinDate := DateTimePicker1.Date;
end;

procedure TFormSYNOP.BitBtnRetrieveClick(Sender: TObject);
var
  URLString: String;
  ColValue: ShortString;
  l, m, r, ValStart, TableStart, NrOfMonths: Word;
  ColNr: Byte;
  TheDate, URLDate: TDate;
  TheTime: TTime;
  InsertValues, ReadStation, DoDownload: Boolean;
  YYYY, MM, DD: Word;
begin
  if ComboBoxScope.ItemIndex = 1 then //import meteorology
  begin
    DoDownload := True;
    NrOfMonths := MonthsBetween(DateTimePicker2.Date, DateTimePicker1.Date) + 1;
    if (NrOfMonths > 3) and (MessageDlg('The import period is more than 3 months, which could result in long downloads! Are you sure you want to download the data?', mtConfirmation, [mbYes, mbNo], 0) = mrNo) then
      DoDownload := False;
    if DoDownload then
    begin
      Screen.Cursor := crHourGlass;
      //clear the grid
      if StringGridMeteo.RowCount > 1 then
      for r := StringGridMeteo.RowCount - 1 downto 1 do
        StringGridMeteo.DeleteRow(r);
      Memo1.Clear;
      StringGridMeteo.RowHeights[0] := 30;
      DecodeDate(DateTimePicker1.Date, YYYY, MM, DD);
      //start download
      for m := 0 to NrOfMonths - 1 do
      begin
        URLDate := EncodeDate(YYYY, MM, DD);
        //make month URL
        URLString := 'http://www.meteomanz.com/sy1?cou=0&ind=' + LabeledEdit1.Text
          + '&d1=01&m1=' + FormatDateTime('MM', URLDate) + '&y1=' + FormatDateTime('YYYY', URLDate)
            + '&h1=00Z&d2=31&m2=' + FormatDateTime('MM', URLDate) + '&y2=' + FormatDateTime('YYYY', URLDate)
              + '&h2=23Z&l=1&so=002';
        Memo1.Clear;
        Memo1.Lines.AddStrings(TFPHttpClient.SimpleGet(URLString));
        //get station name and table start
        ReadStation := False;
        for l := 0 to 150 do
        try //to find a valid station
          if m = 0 then //first month so get Station Name
          begin
            if LeftStr(Memo1.Lines[l], 17) = '<li><i><b>Station' then //station name in next line
              ReadStation := True
            else
            if ReadStation then
            begin
              LabelStation.Caption := Copy(Memo1.Lines[l], 1, Length(Memo1.Lines[l]) - 5) ;
              BitBtnRetrieve.Caption := 'Retrieve data again';
              ReadStation := False;
            end
            else
            if LeftStr(Memo1.Lines[l], 13) = '<td><a title=' then //table start
            begin
              TableStart := l;
              Break;
            end;
          end
          else //all other months just get table start
          if LeftStr(Memo1.Lines[l], 13) = '<td><a title=' then //table start
          begin
            TableStart := l;
            Break;
          end;
          InsertValues := True;
        except on Exception do
          begin
            Screen.Cursor := crDefault;
            MessageDlg('The site with this site number does not return any data. Please try another site/number.', mtError, [mbOK], 0);
            InsertValues := False;
            Break;
          end;
        end;
        //load monthly tables into the grid
        if InsertValues then
        begin
          for l := TableStart to Memo1.Lines.Count - 1 do
          begin
            if ContainsText(Memo1.Lines[l], '<td><a') then //is month/year title
            begin
              TheDate := EncodeDate(StrToInt(Copy(Memo1.Lines[l-1], 11, 4)), StrToInt(Copy(Memo1.Lines[l-1], 8, 2)), StrToInt(Copy(Memo1.Lines[l-1], 5, 2))); //from previous line
              TheTime := EncodeTime(StrToInt(Copy(Memo1.Lines[l], Pos('&h1=', Memo1.Lines[l])+4, 2)), 0, 0, 0);
              ColValue := DateToStr(TheDate) + ' ' + Copy(TimeToStr(TheTime), 1, 5);
              StringGridMeteo.RowCount := StringGridMeteo.RowCount + 1;
              StringGridMeteo.Cells[0, StringGridMeteo.RowCount - 1] := ColValue;
              ColNr := 1; //first column to fill with data after date
            end
            else //is column data
            if ContainsText(Memo1.Lines[l], '<td>') then //is a value
            begin
              ColValue := StringReplace(Memo1.Lines[l], '<td>', '', []);
              ColValue := StringReplace(ColValue, '</td>', '', []);
              case ColNr of
                1: StringGridMeteo.Cells[ColNr, StringGridMeteo.RowCount - 1] := ColValue; //temperature
                2: begin  //humidity
                    ColValue := StringReplace(ColValue, '%', '', []);
                    StringGridMeteo.Cells[ColNr, StringGridMeteo.RowCount - 1] := ColValue;
                   end;
                3: begin //pressure
                    ColValue := StringReplace(ColValue, ' Hpa', '', []);
                    StringGridMeteo.Cells[ColNr, StringGridMeteo.RowCount - 1] := ColValue;
                   end;
                4: begin //wind direction
                     ColValue := StringReplace(ColValue, 'º (', '', []);
                     ColValue := StringReplace(ColValue, ')', '', []);
                     ColValue := StringReplace(ColValue, 'N', '', [rfReplaceAll]);
                     ColValue := StringReplace(ColValue, 'S', '', [rfReplaceAll]);
                     ColValue := StringReplace(ColValue, 'E', '', [rfReplaceAll]);
                     ColValue := StringReplace(ColValue, 'W', '', [rfReplaceAll]);
                     StringGridMeteo.Cells[ColNr, StringGridMeteo.RowCount - 1] := ColValue;
                   end;
                5: begin //wind speed
                     StringGridMeteo.Cells[ColNr, StringGridMeteo.RowCount - 1] := ColValue;
                   end;
               13: begin //conditions
                     StringGridMeteo.Cells[6, StringGridMeteo.RowCount - 1] := ColValue;
                   end;
              end; //of case
              Inc(ColNr);
            end;
          end;
          ButtonPanel1.OKButton.Enabled := StringGridMeteo.RowCount > 1;
        end
        else
          Break; //nothing will be inserted in grid
        Inc(MM); //go to next month
      end;
      Screen.Cursor := crDefault;
    end;
  end
  else //import monthly rainfall
  begin
    Screen.Cursor := crHourGlass;
    if StringGridRainfall.RowCount > 1 then
    for r := StringGridRainfall.RowCount - 1 downto 1 do
      StringGridRainfall.DeleteRow(r);
    Memo1.Clear;
    StringGridRainfall.RowHeights[0] := 30;
    URLString := 'http://www.meteomanz.com/sy3?l=1&cou=1480&ind=' + LabeledEdit1.Text
      + '&m1=' + FormatDateTime('MM', DateTimePicker1.Date) + '&y1=' + FormatDateTime('YYYY', DateTimePicker1.Date)
        + '&m2=' + FormatDateTime('MM', DateTimePicker2.Date) + '&y2=' + FormatDateTime('YYYY', DateTimePicker2.Date);
    try
      Memo1.Lines.AddStrings(TFPHttpClient.SimpleGet(URLString));
      //get station name and table start
      ReadStation := False;
      for l := 0 to Memo1.Lines.Count - 1 do
      begin
        if LeftStr(Memo1.Lines[l], 17) = '<li><i><b>Station' then //station name in next line
          ReadStation := True
        else
        if ReadStation then
        begin
          LabelStation.Caption := Copy(Memo1.Lines[l], 1, Length(Memo1.Lines[l]) - 5) ;
          BitBtnRetrieve.Caption := 'Retrieve data again';
          ReadStation := False;
        end
        else
        if LeftStr(Memo1.Lines[l], 13) = '<td><a title=' then //table start
        begin
          TableStart := l;
          Break;
        end;
      end;
      for l := TableStart to Memo1.Lines.Count - 1 do
      begin
        if ContainsText(Memo1.Lines[l], '<td><a') then //is month/year title
        begin
          ValStart := Pos('">', Memo1.Lines[l]) + 2;
          ColValue := Copy(Memo1.Lines[l], ValStart, 100);
          ColValue := StringReplace(ColValue, '</a></td>', '', []);
          ColValue := ColValue[1] + LowerCase(Copy(ColValue, 2, Length(ColValue)-1));
          TheDate := EncodeDate(StrToInt(RightStr(ColValue, 4)), Months.IndexOf(ExtractWord(1, ColValue, [' '])) + 1, 1);
          //check if dates are in range, then insert, because the URL sometimes ignores dates and loads all
          if (TheDate >= DateTimePicker1.Date) and (TheDate <= DateTimePicker2.Date) then
          begin
            InsertValues := True; //can insert the column values
            StringGridRainfall.RowCount := StringGridRainfall.RowCount + 1;
            StringGridRainfall.Cells[0, StringGridRainfall.RowCount - 1] := ColValue;
            ColNr := 1; //first column to fill with data after date
          end
          else
            InsertValues := False;
        end
        else //is the column data
        if ContainsText(Memo1.Lines[l], '<td>') and InsertValues then //is a value
        begin
          if ContainsText(Memo1.Lines[l], '<td>PERIOD SUMMARY</td>') then
            break //it is the end
          else
          begin
            ColValue := StringReplace(Memo1.Lines[l], '<td>', '', []);
            ColValue := StringReplace(Colvalue, '</td>', '', []);
            StringGridRainfall.Cells[ColNr, StringGridRainfall.RowCount - 1] := ColValue;
            Inc(ColNr);
          end;
        end;
      end;
      ButtonPanel1.OKButton.Enabled := StringGridRainfall.RowCount > 1;
      Screen.Cursor := crDefault;
      if StringGridRainfall.RowCount = 1 then
        MessageDlg('No records found for the site in date range! Please try different dates or another site/number.', mtWarning, [mbOK], 0);
    except on E: Exception do
      MessageDlg(E.Message + ' - No data could be retrieved! Please try again.', mtError, [mbOK], 0);
    end;
  end;
end;

end.

