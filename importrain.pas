unit importrain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ButtonPanel, Spin, DateTimePicker, ZDataset, DB, fphttpclient, fpopenssl,
  openssl, StrUtils, DateUtils;

type

  { TImportRainForm }

  TImportRainForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    CheckBoxDelete: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    RadioGroup1: TRadioGroup;
    SpinEdit1: TSpinEdit;
    ViewComboBox: TComboBox;
    SiteNameQuery: TZReadOnlyQuery;
    ZTable1: TZTable;
    procedure CheckBox3Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure SiteNameQueryAfterOpen(DataSet: TDataSet);
    procedure SiteNameQueryBeforeOpen(DataSet: TDataSet);
    procedure ViewComboBoxChange(Sender: TObject);
    procedure ZTable1BeforeOpen(DataSet: TDataSet);
  private

  public

  end;

var
  ImportRainForm: TImportRainForm;

implementation

{$R *.lfm}

uses MainDataModule, VARINIT, ProgressBox;

{ TImportRainForm }

procedure TImportRainForm.RadioGroup1Click(Sender: TObject);
var
  TheViews: TStringList;
begin
  case Radiogroup1.ItemIndex of
  0: begin
       Label1.Enabled := False;
       ViewComboBox.Enabled := False;
     end;
  1: begin
       Label1.Enabled := True;
       if ViewComboBox.Text = '<No View>' then
       begin
         ViewComboBox.Clear;
         ViewComboBox.Items.Add('<Updating Views, please wait...>');
         ViewComboBox.ItemIndex := 0;
         Application.ProcessMessages;
         TheViews := TStringList.Create;
         DataModuleMain.GetAllViews(DataModuleMain.ZConnectionDB, TheViews);
         ViewComboBox.Items.Assign(TheViews);
         TheViews.Free;
         ViewComboBox.ItemIndex := ViewComboBox.Items.IndexOf(FilterName);
       end;
       ViewComboBox.Enabled := True;
     end;
   end; {of case}
  SiteNameQuery.Close;
  SiteNameQuery.Open;
end;

procedure TImportRainForm.SiteNameQueryAfterOpen(DataSet: TDataSet);
begin
  if SiteNameQuery.RecordCount = 0 then
  begin
    if RadioGroup1.ItemIndex = 0 then
      MessageDlg('The current site is not a meteorological station! Please move to a meteorological station before opening this form or select a View below.', mtError, [mbOK], 0)
    else
      MessageDlg('The selected View does not have any meteorological stations! Please select a View with at least one meteorological station.', mtError, [mbOK], 0);
    ButtonPanel1.OKButton.Enabled := False;
  end
  else
    ButtonPanel1.OKButton.Enabled := True;
end;

procedure TImportRainForm.SiteNameQueryBeforeOpen(DataSet: TDataSet);
begin
  with SiteNameQuery do
  begin
    Connection := DataModuleMain.ZConnectionDB;
    SQL.Clear;
    if RadioGroup1.ItemIndex = 0 then
      SQL.Add('SELECT v.site_id_nr, b.site_name FROM ' + FilterName + ' v')
    else
      SQL.Add('SELECT v.site_id_nr, b.site_name FROM ' + ViewComboBox.Text + ' v');
    SQL.Add('JOIN basicinf b ON (b.site_id_nr = v.site_id_nr)');
    if RadioGroup1.ItemIndex = 0 then
      SQL.Add('AND v.site_id_nr = ' + QuotedStr(CurrentSite));
    SQL.Add('AND b.site_type = ' + QuotedStr('N'));
  end;
end;

procedure TImportRainForm.ViewComboBoxChange(Sender: TObject);
begin
  SiteNameQuery.Close;
  SiteNameQuery.Open;
end;

procedure TImportRainForm.ZTable1BeforeOpen(DataSet: TDataSet);
begin
  ZTable1.Connection := DataModuleMain.ZConnectionDB;
  ZTable1.TableName := 'rainfall';
end;

procedure TImportRainForm.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  DateTimePicker1.MaxDate := Date;
  DateTimePicker2.Date := Date;
  DateTimePicker2.MaxDate := Date;
  SiteNameQuery.Open;
end;

procedure TImportRainForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  SiteNameQuery.Close;
  ZTable1.Close;
  CloseAction := caFree;
end;

procedure TImportRainForm.CheckBox3Change(Sender: TObject);
begin
  MessageDlg('Make sure to select full months in your date ranges above! Otherwise an incorrect monthly rainfall will be stored.', mtWarning, [mbOK], 0);
  SpinEdit1.Enabled := CheckBox3.Checked;
  CheckBox4.Enabled := CheckBox3.Checked;
end;

procedure TImportRainForm.OKButtonClick(Sender: TObject);
var
  URLString, DateStr, rfString: String;
  TheDate: TDate;
  l, Y, M, D, r, NextM: Word;
  rf: Double;
  rfMonthly: array [1..256] of Double;
  SkipNextRow, InsertValue, IgnoreErrors: Boolean;
  ErrorLog: TStringList;
begin
  //delete previous data if required
  if CheckBoxDelete.Checked and (MessageDlg('Are you sure you want to delete previously stored rainfall data within this date range?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    if RadioGroup1.ItemIndex = 0 then
      DataModuleMain.ZConnectionDB.ExecuteDirect('DELETE FROM rainfall WHERE site_id_nr = '
        + QuotedStr(CurrentSite) + ' AND date_meas >= '
        + QuotedStr(FormatDateTime('YYYYMMDD', DateTimePicker1.Date))+ ' AND date_meas <= '
        + QuotedStr(FormatDateTime('YYYYMMDD', DateTimePicker2.Date)))
    else
      DataModuleMain.ZConnectionDB.ExecuteDirect('DELETE FROM rainfall WHERE site_id_nr IN '
        + '(SELECT site_id_nr FROM ' + ViewComboBox.Text + ') AND date_meas >= '
        + QuotedStr(FormatDateTime('YYYYMMDD', DateTimePicker1.Date))+ ' AND date_meas <= '
        + QuotedStr(FormatDateTime('YYYYMMDD', DateTimePicker2.Date)))
  end;
  ProgressBoxForm := TProgressBoxForm.Create(Application);
  with ProgressBoxForm do
  begin
    Caption := 'Importing Rainfall Data';
    Label1.Caption := 'Opening Rainfall table...';
    ProgressBar1.Max := DaysBetween(DateTimePicker1.Date, DateTimePicker2.Date);
    ProgressBar1.Position := 0;
    Show;
    Application.ProcessMessages;
  end;
  Sleep(100);
  Visible := False; //make the dialog invisible
  Application.ProcessMessages;
  for r := 1 to 256 do
    rfMonthly[r] := 0;
  rf := 0;
  ZTable1.Open;
  ErrorLog := TStringList.Create;
  IgnoreErrors := False;
  TheDate := DateTimePicker1.Date; //start date
  //init
  DecodeDate(TheDate, Y, M, D);
  NextM := M;
  while TheDate <= DateTimePicker2.Date do //run through all days between start and end date
  begin
    DecodeDate(TheDate, Y, M, D);
    DateStr := FormatDateTime('YYYY-MM-DD', TheDate);
    ProgressBoxForm.Finished := False;
    ProgressBoxForm.ProgressBar1.Position := ProgressBoxForm.ProgressBar1.Position + 1;
    ProgressBoxForm.Label1.Caption := 'Importing Rainfall for ' + DateStr;
    Application.ProcessMessages;
    Memo1.Lines.Clear;
    if not FileExists(GetTempDir + DateStr + '-daily-rainfall-recorded-figures-south-africa.txt') then //download the file
    begin
      URLString := 'https://sawx.co.za/rainfall-reenval/historical/daily/' + DateStr + '-daily-rainfall-recorded-figures-south-africa.txt';
      try
        Memo1.Lines.AddStrings(TFPHttpClient.SimpleGet(URLString));
        Memo1.Lines.SaveToFile(GetTempDir + DateStr + '-daily-rainfall-recorded-figures-south-africa.txt');
      except on E: Exception do
        begin
          Application.ProcessMessages;
          if not IgnoreErrors and (MessageDlg(E.Message + ' - Could not download temporary weather data file for date ' + DateStr + '! <Ignore> will prevent further download failure messages.', mtError, [mbIgnore, mbOK], 0) = mrIgnore) then
            IgnoreErrors := True;
          ErrorLog.Add('Could not download ' + DateStr + '-daily-rainfall-recorded-figures-south-africa.txt');
          Application.ProcessMessages;
        end;
      end;
    end
    else //the temporary download file exists
    begin
      Memo1.Lines.LoadFromFile(GetTempDir + DateStr + '-daily-rainfall-recorded-figures-south-africa.txt');
    end;
    //run through the memo, if loaded, and store values in rainfall table
    if Memo1.Lines.Count > 0 then
    begin
      SiteNameQuery.First;
      while not SiteNameQuery.EOF do //run through all site names in memo to check if they are there
      begin
        for l := 0 to Memo1.Lines.Count - 1 do //run through all the lines in check if the site name is found
        begin
          InsertValue := False;
          if SkipNextRow then //the value was in next line after the name
          begin
            rfString := Memo1.Lines[l]; //read and clean the value line from characters
            if ContainsText(rfString, 'ARS') then StringReplace(rfString, 'ARS', '', [rfReplaceAll]);
            if ContainsText(rfString, 'WO') then StringReplace(rfString, 'WO', '', [rfReplaceAll]);
            try
              rf := StrToFloat(rfString);
              rfMonthly[SiteNameQuery.RecNo] := rfMonthly[SiteNameQuery.RecNo] + rf;
              InsertValue := True;
            except on E: EConvertError do //make sure to check in next line for value
              //do nothing, just capture exception
            end;
            SkipNextRow := False;
          end
          else //normal row with a value
          if ContainsText(Memo1.Lines[l], SiteNameQuery.Fields[1].AsString) then //site name is found, so get the rainfall in mm for that day
          begin
            rfString := Copy(Memo1.Lines[l], Pos(SiteNameQuery.Fields[1].AsString, Memo1.Lines[l]) + Length(SiteNameQuery.Fields[1].AsString), 100);
            if RightStr(rfString, 3) = 'ARS' then StringReplace(rfString, 'ARS', '', [rfReplaceAll]);
            try
              rf := StrToFloat(rfString);
              rfMonthly[SiteNameQuery.RecNo] := rfMonthly[SiteNameQuery.RecNo] + rf;
              InsertValue := True;
            except on E: EConvertError do //then make sure to check in next line for value
              SkipNextRow := True;
            end;
          end;
          //write daily into rainfall table
          if InsertValue and not CheckBox3.Checked then
          begin
            with ZTable1 do
            begin
              Insert;
              Fields[1].AsString := SiteNameQuery.Fields[0].AsString;
              Fields[2].AsString := 'SAWS';
              Fields[3].AsString := 'I';
              Fields[4].AsString := FormatDateTime('YYYYMMDD', TheDate);
              Fields[5].AsString := '0800';
              Fields[6].AsFloat := rf;
              Fields[7].AsInteger := 88;
              try
                Post;
              except on E: EDatabaseError do
                MessageDlg(E.Message + ' - Could not post rainfall record for this date!', mtError, [mbOK], 0);
              end;
            end;
            Break;
          end;
          //write monthly into rainfall table
          DecodeDate(TheDate + 1, Y, NextM, D); //check if next day is in new month
          if (NextM > M) and CheckBox3.Checked then //the month will change, so store monthly value
          begin
            if (rfMonthly[SiteNameQuery.RecNo] > 0)
              or ((rfMonthly[SiteNameQuery.RecNo] = 0) and CheckBox4.Checked) then
            with ZTable1 do
            begin
              Insert;
              Fields[1].AsString := SiteNameQuery.Fields[0].AsString;
              Fields[2].AsString := 'SAWS';
              Fields[3].AsString := 'I';
              Fields[4].AsString := FormatDateTime('YYYYMM', TheDate) + IntToStr(SpinEdit1.Value);
              Fields[5].AsString := '1200';
              Fields[6].AsFloat := rfMonthly[SiteNameQuery.RecNo];
              Fields[7].AsInteger := 88;
              Post;
            end;
            rfMonthly[SiteNameQuery.RecNo] := 0;
            rf := 0;
            Break;
          end;
        end;
        SiteNameQuery.Next;
      end;
    end;
    //delete the temporary file
    if CheckBox2.Checked then
      DeleteFile(GetTempDir + DateStr + '-daily-rainfall-recorded-figures-south-africa.txt');
    //increase the date by 1 day
    TheDate := TheDate + 1;
    ProgressBoxForm.Finished := True;
  end;
  //sort out days with 0 rainfall, if required
  if CheckBox3.Checked and CheckBox4.Checked then
  begin
    with ProgressBoxForm do
    begin
      Finished := False;
      ProgressBar1.Position := 1;
      ProgressBar1.Max := SiteNameQuery.RecordCount;
      Label1.Caption := 'Setting "0" rainfall months for date range...';
    end;
    Application.ProcessMessages;
    SiteNameQuery.First;
    while not SiteNameQuery.EOF do //run through all sites and check for non existing dates in date range, then insert with zero
    begin
      TheDate := DateTimePicker1.Date; //start date
      with ZTable1 do
      begin
        Filter := 'SITE_ID_NR = ' + QuotedStr(SiteNameQuery.Fields[0].AsString);
        Filtered := True;
        while TheDate <= DateTimePicker2.Date do //run through all days between start and end date and insert if not there
        begin
          DateStr := FormatDateTime('YYYYMMDD', TheDate);
          if (Copy(DateStr, 7, 2) = IntToStr(SpinEdit1.Value)) and (not Locate('date_meas', DateStr, [])) then //insert a zero rainfall record
          begin
            Insert;
            Fields[1].AsString := SiteNameQuery.Fields[0].AsString;
            Fields[2].AsString := 'SAWS';
            Fields[3].AsString := 'I';
            Fields[4].AsString := FormatDateTime('YYYYMM', TheDate) + IntToStr(SpinEdit1.Value);
            Fields[5].AsString := '1200';
            Fields[6].AsFloat := 0;
            Fields[7].AsInteger := 89;
            try
              Post;
            except on E: EDatabaseError do
              MessageDlg(E.Message + ' - Could not post "0" rainfall record for this date!', mtError, [mbOK], 0);
            end;
          end;
          TheDate := TheDate + 1;
        end;
      end;
      SiteNameQuery.Next;
      ProgressBoxForm.ProgressBar1.Position := ProgressBoxForm.ProgressBar1.Position + 1;
      Application.ProcessMessages;
    end;
    ProgressBoxForm.Finished := True;
  end;
  ErrorLog.Add('All other rainfall values were saved to the rainfall table with ngdb_flag = 88.');
  ErrorLog.Add('Failed date downloads may cause incomplete rainfall data and possibly also incorrect monthly calculated rainfall!');
  ErrorLog.SaveToFile(WSpaceDir + DirectorySeparator + 'rainfall_import.log');
  ErrorLog.Free;
  if ProgressBoxForm.CancelPressed then
  begin
    ProgressBoxForm.Close;
    Application.ProcessMessages;
    MessageDlg('Import process aborted! Your rainfall data may not be completely imported.', mtWarning, [mbOK], 0);
  end
  else
  begin
    MessageDlg('Finished importing rainfall data. The "ngdb_flag" for imported records was set to 88. Please see rainfall_import.log for failed download dates.', mtInformation, [mbOK], 0);
    ProgressBoxForm.Close;
  end;
  Close;
end;

end.

