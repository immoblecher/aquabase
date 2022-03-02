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
unit loggerimport;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ButtonPanel,
  StdCtrls, ExtCtrls, LCLType, EditBtn, StrUtils, ZDataset, laz2_DOM,
  laz2_XMLRead, DateTimePicker, DB;

type

  { TLoggerImportForm }

  TLoggerImportForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    ComboBox1: TComboBox;
    ComboBoxFreq: TComboBox;
    ComboBoxDate: TComboBox;
    ComboBoxTime: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    ComboBox6: TComboBox;
    ComboBoxCh1: TComboBox;
    ComboBoxCh2: TComboBox;
    ComboBox9: TComboBox;
    DateTimePicker1: TDateTimePicker;
    EditDepth: TEdit;
    FileNameEdit1: TFileNameEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    CodesQuery: TZReadOnlyQuery;
    Memo1: TMemo;
    DepthQuery: TZReadOnlyQuery;
    procedure CancelButtonClick(Sender: TObject);
    procedure ComboBoxFreqChange(Sender: TObject);
    procedure ComboBox6Change(Sender: TObject);
    procedure ComboBoxCh1Change(Sender: TObject);
    procedure ComboBoxCh2Change(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure DepthQueryAfterOpen(DataSet: TDataSet);
    procedure DepthQueryBeforeOpen(DataSet: TDataSet);
    procedure FileNameEdit1AcceptFileName(Sender: TObject; var Value: String);
    procedure FileNameEdit1ButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: char);
    procedure OKButtonClick(Sender: TObject);
    procedure ImportLev;
    procedure ImportXle;
  private
    Table1, Table2, RepInst: ShortString;
    FirstDateTime: TDateTime;
  public

  end;

var
  LoggerImportForm: TLoggerImportForm;

implementation

{$R *.lfm}

uses MainDataModule, VARINIT, ProgressBox;

{ TLoggerImportForm }

procedure TLoggerImportForm.ImportLev;
var
  m, DataStart: Word;
  NrRecs: LongWord;
  TheDate, TheTime, StartMin, ThirtyMin: ShortString;
  Minutes: Byte;
  TimeSecs, wl, fm: Real;
  DoImport: Boolean;
begin
  StartMin := FormatDateTime('nn', FirstDateTime);
  Minutes := StrToInt(StartMin) + 30;
  if Minutes > 60 then
    Minutes := Minutes - 60;
  ThirtyMin := Format('%2.2d', [Minutes]);
  //Determine line where data starts
  for m := 0 to 100 do //should be within the first 100 lines
    if Memo1.Lines[m].StartsWith('[Data]') then
    begin
      DataStart := m + 2;
      Break;
    end;
  NrRecs := StrToInt(Memo1.Lines[m + 1]); //the next line
  ProgressBoxForm := TProgressBoxForm.Create(Application);
  with ProgressBoxForm do
  begin
    Caption := 'Importing logger data...';
    Label1.Caption := 'Importing data into relevant tables...';
    ProgressBar1.Max := NrRecs;
    ProgressBar1.Position := 0;
    Show;
    Application.ProcessMessages;
    Sleep(100);
  end;
  Visible := False; //make the dialog invisible
  for m := DataStart to NrRecs + DataStart - 1 do
  if not ProgressBoxForm.CancelPressed then
  begin
    DoImport := False;
    ProgressBoxForm.Label1.Caption := 'Processing record ' + IntToStr(m - DataStart + 1) + ' out of ' + IntToStr(NrRecs) + '...';
    ProgressBoxForm.ProgressBar1.Position := ProgressBoxForm.ProgressBar1.Position + 1;
    Application.ProcessMessages;
    TheDate := FormatDateTime('YYYYMMDD', StrToDate(ExtractWord(1, Memo1.Lines[m], [' ']), ComboBoxDate.Text));
    TheTime := FormatDateTime('hhnn', StrToTime(ExtractWord(2, Memo1.Lines[m], [' '])));
    TimeSecs := StrToFloat(Copy(Memo1.Lines[m], Pos('.', Memo1.Lines[m]) - 2, 4));
    if TheDate + TheTime < FormatDateTime('YYYYMMDDhhnn', FirstDateTime) then
      DoImport := False
    else //the date/time is on or after the start date/time, so check frequencies
    begin
      case ComboBoxFreq.ItemIndex of
        0: DoImport := True; //import all
        1: if RightStr(TheTime, 2) = '00' then DoImport := True; //import on the hour
        2: if RightStr(TheTime, 2) = StartMin then DoImport := True; //import hourly
        3: if (RightStr(TheTime, 2) = StartMin) or (RightStr(TheTime, 2) = ThirtyMin) then DoImport := True; //import half-hourly
      end;
    end;
    if DoImport then with DataModuleMain.ZConnectionDB do
    try
      if Table1 = 'waterlev' then
      begin
        wl := StrToFloat(EditDepth.Text) - StrToFloat(ExtractWord(3, Memo1.Lines[m], [' ']));
        ExecuteDirect('INSERT INTO ' + Table1 + ' (site_id_nr, meth_meas, level_stat, piezom_nr, info_sourc, date_meas, time_meas, time_sec, water_lev, comment, ngdb_flag) VALUES (' + QuotedStr(CurrentSite) + ', '
          + QuotedStr('D') + ', ' + QuotedStr(ComboBox9.Text) + ', ' + QuotedStr(ComboBox4.Text) + ', '
          + QuotedStr(ComboBox5.Text) + ', ' + QuotedStr(TheDate) + ', ' + QuotedStr(TheTime) + ', '
          + FloatToStr(TimeSecs) + ', ' + FloatToStr(wl) + ', NULL, 1);')
      end
      else
      if (Table1 = 'fldmeas_') and (ComboBoxCh2.Text = 'TEMPERATURE') then
      begin
        fm := StrToFloat(ExtractWord(3, Memo1.Lines[m], [' ']));
        ExecuteDirect('INSERT INTO ' + Table1 + ' (site_id_nr, rep_inst, info_sourc, date_entry, date_meas, time_meas, parm_meas, reading, depth_meas, comment, ngdb_flag) VALUES (' + QuotedStr(CurrentSite) + ', '
          + QuotedStr(RepInst) + ', ' + QuotedStr(ComboBox5.Text) + ', ' + QuotedStr(FormatDateTime('YYYYMMDD', Date)) + ', '
          + QuotedStr(TheDate) + ', ' + QuotedStr(TheTime) + ', ' + QuotedStr('T') + ', '
          + FloatToStr(fm) + ', ' + EditDepth.Text + ', NULL, 1);');
      end;
      if Table2 = 'waterlev' then
      begin
        wl := StrToFloat(EditDepth.Text) - StrToFloat(ExtractWord(4, Memo1.Lines[m], [' ']));
        ExecuteDirect('INSERT INTO ' + Table2 + ' (site_id_nr, meth_meas, level_stat, piezom_nr, info_sourc, date_meas, time_meas, time_sec, water_lev, comment, ngdb_flag) VALUES (' + QuotedStr(CurrentSite) + ', '
          + QuotedStr('D') + ', ' + QuotedStr(ComboBox9.Text) + ', ' + QuotedStr(ComboBox4.Text) + ', '
          + QuotedStr(ComboBox5.Text) + ', ' + QuotedStr(TheDate) + ', ' + QuotedStr(TheTime) + ', '
          + FloatToStr(TimeSecs) + ', ' + FloatToStr(wl) + ', NULL, 1);')
      end
      else
      if (Table2 = 'fldmeas_') and (ComboBoxCh2.Text = 'TEMPERATURE') then
      begin
        fm := StrToFloat(ExtractWord(4, Memo1.Lines[m], [' ']));
        ExecuteDirect('INSERT INTO ' + Table2 + ' (site_id_nr, rep_inst, info_sourc, date_entry, date_meas, time_meas, parm_meas, reading, depth_meas, comment, ngdb_flag) VALUES (' + QuotedStr(CurrentSite) + ', '
          + QuotedStr(RepInst) + ', ' + QuotedStr(ComboBox5.Text) + ', ' + QuotedStr(FormatDateTime('YYYYMMDD', Date)) + ', '
          + QuotedStr(TheDate) + ', ' + QuotedStr(TheTime) + ', ' + QuotedStr('T') + ', '
          + FloatToStr(fm) + ', ' + EditDepth.Text + ', NULL, 1);');
      end;
    except on E: Exception do
      if MessageDlg(E.Message + ' - Could not import record for this date/time! "Cancel" will stop the import.', mtError, [mbCancel, mbOK], 0) = mrCancel then
        ProgressBoxForm.CancelPressed := True;
    end;
  end
  else
  begin
    ProgressBoxForm.Close;
    ProgressBoxForm := Nil;
    ShowMessage('Import was cancelled. Your logger import may not be complete.');
    Break;
  end;
  if ProgressBoxForm <> NIL then
  with ProgressBoxForm do
  begin
    Finished := True;
    Close;
    ShowMessage('Successfully imported logger data from file "' + ExtractFileName(FileNameEdit1.Text) + '".')
  end;
end;

procedure TLoggerImportForm.ImportXle;
var
  m, NrRecs: LongWord;
  TheDate, TheTime, StartMin, ThirtyMin: ShortString;
  Minutes: Byte;
  TimeSecs, wl, fm: Real;
  dom: TXMLDocument;
  data, log_id: TDOMNode;
  DoImport: Boolean;
begin
  StartMin := FormatDateTime('nn', FirstDateTime);
  Minutes := StrToInt(StartMin) + 30;
  if Minutes > 60 then
    Minutes := Minutes - 60;
  ThirtyMin := Format('%2.2d', [Minutes]);
  // Load XML
  ReadXMLFile(dom, FileNameEdit1.Text);
  try
    //start process
    data := dom.DocumentElement.FindNode('Data');
    //get the number of records
    if Assigned(data) then
      NrRecs := data.ChildNodes.Count;
    ProgressBoxForm := TProgressBoxForm.Create(Application);
    with ProgressBoxForm do
    begin
      Caption := 'Importing logger data...';
      Label1.Caption := 'Importing data into relevant tables...';
      ProgressBar1.Max := NrRecs;
      ProgressBar1.Position := 0;
      Show;
      Application.ProcessMessages;
    end;
    Visible := False; //make the import dialog invisible
    if Assigned(data) then
    for m := 0 to NrRecs - 1 do
    if not ProgressBoxForm.CancelPressed then
    begin
      DoImport := False;
      ProgressBoxForm.Label1.Caption := 'Processing record ' + IntToStr(m + 1) + ' out of ' + IntToStr(NrRecs) + '...';
      ProgressBoxForm.ProgressBar1.Position := m + 1;
      Application.ProcessMessages;
      log_id := data.ChildNodes[m];
      TheDate := FormatDateTime('YYYYMMDD', StrToDate(log_id.FirstChild.TextContent, ComboBoxDate.Text));
      TheTime := FormatDateTime('hhnn', StrToTime(log_id.ChildNodes[1].TextContent));
      TimeSecs := StrToFloat(log_id.ChildNodes[2].TextContent);
      //check date/time and frequencies
      if TheDate + TheTime < FormatDateTime('YYYYMMDDhhnn', FirstDateTime) then
        DoImport := False
      else //the date/time is on or after the start date/time, so check frequencies
      begin
        case ComboBoxFreq.ItemIndex of
          0: DoImport := True; //import all
          1: if RightStr(TheTime, 2) = '00' then DoImport := True; //import on the hour
          2: if RightStr(TheTime, 2) = StartMin then DoImport := True; //import hourly
          3: if (RightStr(TheTime, 2) = StartMin) or (RightStr(TheTime, 2) = ThirtyMin) then DoImport := True; //import half-hourly
        end;
      end;
      if DoImport then with DataModuleMain.ZConnectionDB do
      try
        if Table1 = 'waterlev' then
        begin
          wl := StrToFloat(EditDepth.Text) - StrToFloat(log_id.ChildNodes[3].TextContent);
          ExecuteDirect('INSERT INTO ' + Table1 + ' (site_id_nr, meth_meas, level_stat, piezom_nr, info_sourc, date_meas, time_meas, time_sec, water_lev, comment, ngdb_flag) VALUES (' + QuotedStr(CurrentSite) + ', '
            + QuotedStr('D') + ', ' + QuotedStr(ComboBox9.Text) + ', ' + QuotedStr(ComboBox4.Text) + ', '
            + QuotedStr(ComboBox5.Text) + ', ' + QuotedStr(TheDate) + ', ' + QuotedStr(TheTime) + ', '
            + FloatToStr(TimeSecs) + ', ' + FloatToStr(wl) + ', NULL, 1);')
        end
        else
        if (Table1 = 'fldmeas_') and (ComboBoxCh2.Text = 'TEMPERATURE') then
        begin
          fm := StrToFloat(log_id.ChildNodes[3].TextContent);
          ExecuteDirect('INSERT INTO ' + Table1 + ' (site_id_nr, rep_inst, info_sourc, date_entry, date_meas, time_meas, parm_meas, reading, depth_meas, comment, ngdb_flag) VALUES (' + QuotedStr(CurrentSite) + ', '
            + QuotedStr(RepInst) + ', ' + QuotedStr(ComboBox5.Text) + ', ' + QuotedStr(FormatDateTime('YYYYMMDD', Date)) + ', '
            + QuotedStr(TheDate) + ', ' + QuotedStr(TheTime) + ', ' + QuotedStr('T') + ', '
            + FloatToStr(fm) + ', ' + EditDepth.Text + ', NULL, 1);');
        end;
        if Table2 = 'waterlev' then
        begin
          wl := StrToFloat(EditDepth.Text) - StrToFloat(log_id.ChildNodes[4].TextContent);
          ExecuteDirect('INSERT INTO ' + Table2 + ' (site_id_nr, meth_meas, level_stat, piezom_nr, info_sourc, date_meas, time_meas, time_sec, water_lev, comment, ngdb_flag) VALUES (' + QuotedStr(CurrentSite) + ', '
            + QuotedStr('D') + ', ' + QuotedStr(ComboBox9.Text) + ', ' + QuotedStr(ComboBox4.Text) + ', '
            + QuotedStr(ComboBox5.Text) + ', ' + QuotedStr(TheDate) + ', ' + QuotedStr(TheTime) + ', '
            + FloatToStr(TimeSecs) + ', ' + FloatToStr(wl) + ', NULL, 1);')
        end
        else
        if (Table2 = 'fldmeas_') and (ComboBoxCh2.Text = 'TEMPERATURE') then
        begin
          fm := StrToFloat(log_id.ChildNodes[4].TextContent);
          ExecuteDirect('INSERT INTO ' + Table2 + ' (site_id_nr, rep_inst, info_sourc, date_entry, date_meas, time_meas, parm_meas, reading, depth_meas, comment, ngdb_flag) VALUES (' + QuotedStr(CurrentSite) + ', '
            + QuotedStr(RepInst) + ', ' + QuotedStr(ComboBox5.Text) + ', ' + QuotedStr(FormatDateTime('YYYYMMDD', Date)) + ', '
            + QuotedStr(TheDate) + ', ' + QuotedStr(TheTime) + ', ' + QuotedStr('T') + ', '
            + FloatToStr(fm) + ', ' + EditDepth.Text + ', NULL, 1);');
        end;
      except on E: Exception do
        if MessageDlg(E.Message + ' - Could not import record for this date/time! "Cancel" will stop the import.', mtError, [mbCancel, mbOK], 0) = mrCancel then
          ProgressBoxForm.CancelPressed := True;
      end;
    end
    else
    begin
      ProgressBoxForm.Close;
      ProgressBoxForm := Nil;
      ShowMessage('Import was cancelled. Your logger import may not be complete.');
      Break;
    end;
  finally
    dom.Free;
    if ProgressBoxForm <> NIL then
    with ProgressBoxForm do
    begin
      Finished := True;
      Close;
      ShowMessage('Successfully imported logger data from file "' + ExtractFileName(FileNameEdit1.Text) + '".')
    end;
  end;
end;

procedure TLoggerImportForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TLoggerImportForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TLoggerImportForm.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, False);
  with CodesQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT SEARCH FROM Lookup WHERE USED_FOR = ' + QuotedStr('IS_BASIC'));
    Open;
    while not EOF do
    begin
      ComboBox5.Items.Add(Fields[0].AsString);
      Next;
    end;
    Close;
  end;
  ComboBox5.ItemIndex := 0;
  with CodesQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT SEARCH, DESCRIBE FROM Lookup WHERE USED_FOR = ' + QuotedStr('REP_INST'));
    Open;
    while not EOF do
    begin
      ComboBox6.Items.Add(Fields[1].AsString); //the name, not the code
      Next;
    end;
    RepInst := DataModuleMain.BasicinfQueryREP_INST.AsString;
    Locate('SEARCH', RepInst, []);
    ComboBox6.ItemIndex := ComboBox6.Items.IndexOf(Fields[1].Value);
    Close;
  end;
  with CodesQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT SEARCH FROM Lookup WHERE USED_FOR = ' + QuotedStr('WLV_STAT'));
    Open;
    while not EOF do
    begin
      ComboBox9.Items.Add(Fields[0].AsString);
      Next;
    end;
    Close;
  end;
  ComboBox9.ItemIndex := 0;
  Label2.Caption := Label2.Caption + ' [' + LengthUnit + ']:';
  //get the latest depth installed
  with DepthQuery do
  begin
    Open;
    Close;
  end;
  DateTimePicker1.DateTime := Now;
end;

procedure TLoggerImportForm.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TLoggerImportForm.ComboBoxFreqChange(Sender: TObject);
begin
  if ComboBoxFreq.ItemIndex > 1 then
    ShowMessage('Please make sure the start time does actually exist, otherwise nothing will be imported!')
  else
  if ComboBoxFreq.ItemIndex = 1 then
    ShowMessage('Please make sure data on the hour does actually exist, otherwise nothing will be imported!')
end;

procedure TLoggerImportForm.ComboBox6Change(Sender: TObject);
begin
  with CodesQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT SEARCH, DESCRIBE FROM Lookup WHERE USED_FOR = ' + QuotedStr('REP_INST'));
    Open;
    Locate('DESCRIBE', ComboBox6.Text, []);
    RepInst := Fields[0].AsString;
    Close;
  end;
end;

procedure TLoggerImportForm.ComboBoxCh1Change(Sender: TObject);
begin
  ButtonPanel1.OKButton.Enabled := (ComboBoxCh1.ItemIndex > 0) or (ComboBoxCh2.ItemIndex > 0);
end;

procedure TLoggerImportForm.ComboBoxCh2Change(Sender: TObject);
begin
  ButtonPanel1.OKButton.Enabled := (ComboBoxCh1.ItemIndex > 0) or (ComboBoxCh2.ItemIndex > 0);
end;

procedure TLoggerImportForm.DateTimePicker1Change(Sender: TObject);
begin
  FirstDateTime := DateTimePicker1.DateTime;
end;

procedure TLoggerImportForm.DepthQueryAfterOpen(DataSet: TDataSet);
begin
  if DataSet.RecordCount = 0 then
  begin
    MessageDlg('This sites does not seem to have a logger installed! If you choose to continue please also enter logger information on the "Installation" entry form.', mtWarning, [mbOK], 0);
    EditDepth.Text := '0.00';
  end
  else
  begin
    DataSet.Last;
    EditDepth.Text := DataSet.FieldByName('depth_inst').AsString;
  end;
end;

procedure TLoggerImportForm.DepthQueryBeforeOpen(DataSet: TDataSet);
begin
  DepthQuery.Params[0].Value := CurrentSite;
end;

procedure TLoggerImportForm.FileNameEdit1AcceptFileName(Sender: TObject;
  var Value: String);
var
  m, EqualPos: Word;
  FirstDate: TDate;
  FirstTime: TTime;
  dom: TXMLDocument;
  ch, data, log_id: TDOMNode;
  ValidFile: Boolean;
begin
  if Lowercase(ExtractFileExt(Value)) = '.lev' then //text file
  begin
    Memo1.Lines.LoadFromFile(Value);
    //Determine line where data starts
    if ComboBox1.ItemIndex = 0 then //Solinst Logger
    begin
      //1st Channel/Column
      if ComboBoxCh1.Items.Count > 1 then //delete the last item
        ComboBoxCh1.Items.Delete(1);
      for m := 0 to Memo1.Lines.Count - 1 do //should be within the first 100 lines
      begin
        if Memo1.Lines[m].StartsWith('[CHANNEL 1 from data header]') then
        begin
          EqualPos := Pos('=', Memo1.Lines[m+1]);
          ComboBoxCh1.Items.Add(Copy(Memo1.Lines[m+1], EqualPos + 1, Length(Memo1.Lines[m+1]) - EqualPos));
          Break;
        end;
      end;
      if ComboBoxCh1.Items.Count = 0 then //nothing found
        ValidFile := False
      else
      begin
        ValidFile := True;
        ComboBoxCh1.ItemIndex := 1;
      end;
      //2nd Channel/Column
      if ComboBoxCh2.Items.Count > 1 then //delete the last item
        ComboBoxCh2.Items.Delete(1);
      for m := 0 to Memo1.Lines.Count - 1 do //should be within the first 100 lines
      begin
        if Memo1.Lines[m].StartsWith('[CHANNEL 2 from data header]') then
        begin
          EqualPos := Pos('=', Memo1.Lines[m+1]);
          ComboBoxCh2.Items.Add(Copy(Memo1.Lines[m+1], EqualPos + 1, Length(Memo1.Lines[m+1]) - EqualPos));
          Break;
        end;
        if not ValidFile then
        begin
          ValidFile := ComboBoxCh2.Items.Count > 0; //nothing found
          ComboBoxCh2.ItemIndex := 1;
        end;
      end;
      //get first date and time
      if ValidFile then
      begin
        for m := 0 to 100 do
        if Memo1.Lines[m].StartsWith('[Data]') then
        begin
          FirstDate := StrToDate(ExtractWord(1, Memo1.Lines[m + 2], [' ']), ComboBoxDate.Text);
          FirstTime := StrToTime(ExtractWord(2, Memo1.Lines[m + 2], [' ']));
          FirstDateTime := FirstDate + FirstTime;
          Break;
        end;
        ButtonPanel1.OKButton.Enabled := (ComboBoxCh1.ItemIndex > 0) or (ComboBoxCh2.ItemIndex > 0);
        with DateTimePicker1 do
        begin
          DateTime := FirstDateTime;
          MinDate := FirstDateTime;
          MaxDate := Now;
          Enabled := True;
        end;
      end
      else
        Value := '';;
    end; //of Solinst Logger
  end
  else
  begin //XML file
    // Load XML
    try
      ReadXMLFile(dom, Value);
      ValidFile:= True;
    except on E: Exception do
      begin
        ValidFile := False;
        MessageDlg(E.Message + ' - XLE file could not be loaded! Please select a valid .xle file.', mtError, [mbOK], 0);
      end;
    end;
    //clear combos
    if ComboBoxCh1.Items.Count > 1 then //delete the last item
      ComboBoxCh1.Items.Delete(1);
    if ComboBoxCh2.Items.Count > 1 then //delete the last item
      ComboBoxCh2.Items.Delete(1);
    //get the channels and first date/time
    if ValidFile then
    try
      ch := dom.DocumentElement.FindNode('Ch1_data_header');
      if Assigned(ch) then
      begin
        if ch.FirstChild.TextContent > '' then
          ComboBoxCh1.Items.Add(ch.FirstChild.TextContent)
        else
          MessageDlg('Your logger file does not have valid "Ch1_data_header" information! Please make sure to select a valid logger file or edit your file with the correct information for the channels.', mtError, [mbOK], 0);
      end;
      if ComboBoxCh1.Items.Count > 1 then
      begin
        ComboBoxCh1.ItemIndex := 1;
        ButtonPanel1.OKButton.Enabled := True;
      end;
      ch := dom.DocumentElement.FindNode('Ch2_data_header');
      if Assigned(ch) then
      begin
        if ch.FirstChild.TextContent > '' then
          ComboBoxCh2.Items.Add(ch.FirstChild.TextContent)
        else
          MessageDlg('Your logger file does not have valid "Ch2_data_header" information! Please make sure to select a valid logger file or edit your file with the correct information for the channels.', mtError, [mbOK], 0);
      end;
      data := dom.DocumentElement.FindNode('Data');
      if Assigned(data) then
      begin
        log_id := data.FirstChild;
        if Assigned(log_id) then
        begin
          FirstDate := StrToDate(log_id.FirstChild.TextContent, ComboBoxDate.Text);
          FirstTime := StrToTime(log_id.ChildNodes[1].TextContent);
          FirstDateTime := FirstDate + FirstTime;
        end;
      end;
    finally
      dom.Free;
    end
    else
      Value := '';
    if ValidFile then
    with DateTimePicker1 do
    begin
      DateTime := FirstDateTime;
      MinDate := FirstDateTime;
      MaxDate := Now;
      Enabled := True;
    end;
  end;
end;

procedure TLoggerImportForm.FileNameEdit1ButtonClick(Sender: TObject);
begin
  FileNameEdit1.InitialDir := WSpaceDir;
end;

procedure TLoggerImportForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TLoggerImportForm.LabeledEdit1KeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', '.', #8, #9]) then
    Key := #0;
end;

procedure TLoggerImportForm.OKButtonClick(Sender: TObject);
var
  CanImport: Boolean;
begin
  CanImport := False;
  if StrToFloat(EditDepth.Text) = 0 then
  begin
    if MessageDlg('The depth installed is specified as 0.00! Are you sure this is correct?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      Abort
    else
      CanImport := True;
  end
  else
    CanImport := True;
  //set relevant tables
  if ComboBoxCh1.Text = 'LEVEL' then
    Table1 := 'waterlev'
  else
  if ComboBoxCh1.Text = 'TEMPERATURE' then
    Table1 := 'fldmeas_'
  else
    Table1 := '';
  if ComboBoxCh2.Text = 'LEVEL' then
    Table2 := 'waterlev'
  else
  if ComboBoxCh2.Text = 'TEMPERATURE' then
    Table2 := 'fldmeas_'
  else
    Table2 := '';
  //start import
  if CanImport and (Lowercase(ExtractFileExt(FileNameEdit1.Text)) = '.lev') then //do the import
  begin
    ImportLev;
  end
  else
  if CanImport then //for .xle
  begin
    ImportXle;
  end;
  Close;
end;

end.

