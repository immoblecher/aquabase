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
  Grids, ExtCtrls, Buttons, Spin, XMLPropStorage, ZDataset, DateTimePicker,
  fphttpclient, openssl, StrUtils, DB, DateUtils;

type

  { TFormSYNOP }

  TFormSYNOP = class(TForm)
    BitBtnRetrieve: TBitBtn;
    ButtonPanel1: TButtonPanel;
    CheckBoxNoReading: TCheckBox;
    CheckBoxDelete: TCheckBox;
    ComboBoxDataVar: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
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
    LabelStation: TLabel;
    LabeledEdit1: TLabeledEdit;
    SpinEdit1: TSpinEdit;
    StringGrid1: TStringGrid;
    XMLPropStorage1: TXMLPropStorage;
    procedure BitBtnRetrieveClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
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
  YY, MM, DD, NrDays: Word;
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, False);
  StringGrid1.RowHeights[0] := 30;
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
  DateStr, TableName, SiteID: ShortString;
  Y, M, D, r: Word;
  TheDay: Byte;
  CellValue: Double;
  IgnoreErrors: Boolean;
begin
  SiteID := CurrentSite;
  case ComboBoxDataVar.ItemIndex of
   0: TableName := 'rainfall';
   1: TableName := 'air_temp';
   2: TableName := 'pressure';
  end;
  //delete previous data if required
  if CheckBoxDelete.Checked and (MessageDlg('Are you sure you want to delete previously stored rainfall data within this date range?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    DataModuleMain.ZConnectionDB.ExecuteDirect('DELETE FROM ' + TableName + ' WHERE site_id_nr = '
      + QuotedStr(SiteID) + ' AND date_meas >= '
      + QuotedStr(FormatDateTime('YYYYMMDD', DateTimePicker1.Date))+ ' AND date_meas < '
      + QuotedStr(FormatDateTime('YYYYMMDD', IncMonth(DateTimePicker2.Date))))
  end;
  ProgressBoxForm := TProgressBoxForm.Create(Application);
  with ProgressBoxForm do
  begin
    Caption := 'Importing ' + ComboBoxDataVar.Text + ' Data';
    Label1.Caption := 'Initialising ' + ComboBoxDataVar.Text + ' import...';
    ProgressBar1.Max := StringGrid1.RowCount - 1;
    ProgressBar1.Position := 0;
    Show;
    Application.ProcessMessages;
  end;
  Sleep(100);
  Visible := False; //make the dialog invisible
  Application.ProcessMessages;
  ErrorLog := TStringList.Create;
  IgnoreErrors := False;
  for r := 1 to StringGrid1.RowCount - 1 do
  if not ProgressBoxForm.CancelPressed then
  begin
    ProgressBoxForm.Finished := False;
    ProgressBoxForm.ProgressBar1.Position := r;
    DateStr := StringGrid1.Cells[0, r];
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
    if StringGrid1.Cells[6, r] <> '-' then
      CellValue := StrToFloat(StringGrid1.Cells[6, r])
    else
    if (StringGrid1.Cells[6, r] = '-') and CheckBoxNoReading.Checked then
      CellValue := 0;
    if CellValue >= 0 then //store as there is a value
    with DataModuleMain.ZConnectionDB do
    begin
      try
      ExecuteDirect('INSERT INTO ' + TableName + ' (SITE_ID_NR, REP_INST, INFO_SOURC, DATE_MEAS, TIME_MEAS, READING, NGDB_FLAG) VALUES ('
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
  end;
  ErrorLog.Add('All other ' + ComboBoxDataVar.Text + ' values were saved to the rainfall table with ngdb_flag = 77.');
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
  Close;
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

procedure TFormSYNOP.ComboBox3Change(Sender: TObject);
begin
  if ComboBox3.ItemIndex = 0 then
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
  l, r, ValStart, TableStart: Word;
  ColNr: Byte;
  TheDate: TDate;
  InsertValues, ReadStation: Boolean;
begin
  Screen.Cursor := crHourGlass;
  if StringGrid1.RowCount > 1 then
  for r := StringGrid1.RowCount - 1 downto 1 do
    StringGrid1.DeleteRow(r);
  Memo1.Clear;
  StringGrid1.RowHeights[0] := 30;
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
          StringGrid1.RowCount := StringGrid1.RowCount + 1;
          StringGrid1.Cells[0, StringGrid1.RowCount - 1] := ColValue;
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
          StringGrid1.Cells[ColNr, StringGrid1.RowCount - 1] := ColValue;
          Inc(ColNr);
        end;
      end;
    end;
    ButtonPanel1.OKButton.Enabled := StringGrid1.RowCount > 1;
    Screen.Cursor := crDefault;
    if StringGrid1.RowCount = 1 then
      MessageDlg('No records found for the site in date range! Please try different dates or another site/number.', mtWarning, [mbOK], 0);
  except on E: Exception do
    MessageDlg(E.Message + ' - No data could be retrieved! Please try again.', mtError, [mbOK], 0);
  end;
end;

end.

