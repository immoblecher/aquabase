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
unit importdwsaudited;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SdfData, DB, Forms, Controls, Graphics, Dialogs,
  ButtonPanel, EditBtn, StdCtrls, ZDataset, DateTimePicker;

type

  { TFormDWSAudited }

  TFormDWSAudited = class(TForm)
    ButtonPanel1: TButtonPanel;
    CheckBoxDelete: TCheckBox;
    ComboBoxInfo: TComboBox;
    ComboBoxMeth: TComboBox;
    ComboBoxLvl: TComboBox;
    DataSource1: TDataSource;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    FileNameEdit1: TFileNameEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    SdfDataSet1: TSdfDataSet;
    ZQueryLookups: TZReadOnlyQuery;
    procedure CancelButtonClick(Sender: TObject);
    procedure FileNameEdit1AcceptFileName(Sender: TObject; var Value: String);
    procedure FileNameEdit1ButtonClick(Sender: TObject);
    procedure FileNameEdit1Exit(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    Memo1: TMemo;
    SiteID: ShortString;
  public
    SingleSite: Boolean;
  end;

var
  FormDWSAudited: TFormDWSAudited;

implementation

{$R *.lfm}

uses VARINIT, MainDataModule, progressbox;

{ TFormDWSAudited }

procedure TFormDWSAudited.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TFormDWSAudited.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  DateTimePicker1.MaxDate := Date;
  DateTimePicker2.Date := Date;
  DateTimePicker2.MaxDate := Date;
  with ZQueryLookups do
  begin
    Params[0].AsString := 'IS_BASIC';
    Open;
    while not EOF do
    begin
      ComboBoxInfo.Items.Add(Fields[0].AsString);
      Next;
    end;
    Close;
    Params[0].AsString := 'OTHRMEAS';
    Open;
    while not EOF do
    begin
      ComboBoxMeth.Items.Add(Fields[0].AsString);
      Next;
    end;
    Close;
    Params[0].AsString := 'WLV_STAT';
    Open;
    while not EOF do
    begin
      ComboBoxLvl.Items.Add(Fields[0].AsString);
      Next;
    end;
    Close;
  end;
end;

procedure TFormDWSAudited.OKButtonClick(Sender: TObject);
var
  IgnoreErrors: Boolean;
  ErrorLog: TStringList;
  PrevSiteID, TheDate, TheTime: ShortString;
  m: LongWord;
begin
  ErrorLog := TStringList.Create;
  IgnoreErrors := False;
  ProgressBoxForm := TProgressBoxForm.Create(Application);
  if SingleSite then
  begin
    with ProgressBoxForm do
    begin
      Caption := 'Importing Water Level Data';
      //delete if required
      if CheckBoxDelete.Checked then
      begin
        Label1.Caption := 'Deleting previous water levels for site ' + SiteID;
        Application.ProcessMessages;
        DataModuleMain.ZConnectionDB.ExecuteDirect('DELETE FROM waterlev WHERE site_id_nr = '
          + QuotedStr(SiteID) + ' AND date_meas >= '
          + QuotedStr(FormatDateTime('YYYYMMDD', DateTimePicker1.Date))+ ' AND date_meas < '
          + QuotedStr(FormatDateTime('YYYYMMDD', IncMonth(DateTimePicker2.Date))))
      end;
      Label1.Caption := 'Initialising water level import...';
      ProgressBar1.Max := Memo1.Lines.Count - 17;
      ProgressBar1.Position := 0;
      Show;
      Application.ProcessMessages;
    end;
    Sleep(100);
    Visible := False; //make the dialog invisible
    Application.ProcessMessages;
    IgnoreErrors := False;
    for m := 14 to Memo1.Lines.Count - 4 do
    if not ProgressBoxForm.CancelPressed then
    begin
      ProgressBoxForm.Finished := False;
      ProgressBoxForm.ProgressBar1.Position := ProgressBoxForm.ProgressBar1.Position + 1;
      TheDate := StringReplace(Copy(Memo1.Lines[m], 6, 10), '-', '',[rfReplaceAll]);
      TheTime := StringReplace(Copy(Memo1.Lines[m], 17, 5), ':', '',[rfReplaceAll]);
      if (TheDate >= FormatDateTime('YYYYMMDD', DateTimePicker1.Date)) and
        (TheDate <= FormatDateTime('YYYYMMDD', DateTimePicker2.Date)) then
      begin
        //insert water levels as between dates
        ProgressBoxForm.Label1.Caption := 'Importing water level for site ' + SiteID;
        Application.ProcessMessages;
        try
          DataModuleMain.ZConnectionDB.ExecuteDirect('INSERT INTO waterlev (SITE_ID_NR, METH_MEAS, LEVEL_STAT, PIEZOM_NR, INFO_SOURC, DATE_MEAS, TIME_MEAS, WATER_LEV) VALUES ('
            + QuotedStr(SiteID) + ', ' + QuotedStr(ComboBoxMeth.Text) + ', ' + QuotedStr(ComboBoxLvl.Text) + ', ' + QuotedStr(Copy(Memo1.Lines[m], 2, 1)) + ', '
            + QuotedStr(ComboBoxInfo.Text) + ', ' + QuotedStr(TheDate) + ', ' + QuotedStr(TheTime) + ', '  + FloatToStr(StrToFloat(Copy(Memo1.Lines[m], 28, Length(Memo1.Lines[m]) - 28)) * -1) + ');');
        except on E: Exception do
          begin
            ErrorLog.Add(E.Message + ' - Could not insert water level for ' + SiteID + ' on ' + TheDate + ' and ' + TheTime +  '!');
            if not IgnoreErrors and (MessageDlg(E.Message + ' - Could not insert water level for ' + SiteID + ' on ' + TheDate + ' and ' + TheTime +  '! "Ignore" will skip errors for this site.', mtError, [mbIgnore, mbOK], 0) = mrIgnore) then
              IgnoreErrors := True;
          end;
        end;
      end
      else
      begin
        //do not import as not in date range
        ProgressBoxForm.Label1.Caption := 'Skipping water level for date ' + TheDate;
        Application.ProcessMessages;
      end;
    end;
    ProgressBoxForm.Finished := True;
    Memo1.Free;
  end
  else
  begin
    PrevSiteID := '';
    with ProgressBoxForm do
    begin
      Caption := 'Importing Water Level Data';
      Label1.Caption := 'Initialising water level import...';
      ProgressBar1.Max := SdfDataSet1.RecordCount - 1;
      ProgressBar1.Position := 0;
      Show;
      Application.ProcessMessages;
    end;
    Sleep(100);
    Visible := False; //make the dialog invisible
    Application.ProcessMessages;
    while not SdfDataSet1.EOF do
    if not ProgressBoxForm.CancelPressed then
    begin
      SiteID := SdfDataSet1.Fields[1].AsString;
      ProgressBoxForm.Finished := False;
      ProgressBoxForm.ProgressBar1.Position := ProgressBoxForm.ProgressBar1.Position + 1;
      //delete if required and not done already for this site
      if CheckBoxDelete.Checked and (SiteID <> PrevSiteID) then
      begin
        ProgressBoxForm.Label1.Caption := 'Deleting previous water levels for site ' + SiteID;
        Application.ProcessMessages;
        DataModuleMain.ZConnectionDB.ExecuteDirect('DELETE FROM waterlev WHERE site_id_nr = '
          + QuotedStr(SiteID) + ' AND date_meas >= '
          + QuotedStr(FormatDateTime('YYYYMMDD', DateTimePicker1.Date))+ ' AND date_meas < '
          + QuotedStr(FormatDateTime('YYYYMMDD', IncMonth(DateTimePicker2.Date))))
      end;
      if IgnoreErrors and (SiteID <> PrevSiteID) then
        IgnoreErrors := False; //make sure errors will be shown when site changes
      TheDate := StringReplace(LeftStr(SdfDataSet1.Fields[6].AsString, 10), '-', '',[rfReplaceAll]);
      TheTime := StringReplace(RightStr(SdfDataSet1.Fields[6].AsString, 5), ':', '',[rfReplaceAll]);
      if (TheDate >= FormatDateTime('YYYYMMDD', DateTimePicker1.Date)) and
        (TheDate <= FormatDateTime('YYYYMMDD', DateTimePicker2.Date)) then
      begin
        //insert water levels as between dates
        ProgressBoxForm.Label1.Caption := 'Importing water level for site ' + SiteID;
        Application.ProcessMessages;
        try
          DataModuleMain.ZConnectionDB.ExecuteDirect('INSERT INTO waterlev (SITE_ID_NR, METH_MEAS, LEVEL_STAT, PIEZOM_NR, INFO_SOURC, DATE_MEAS, TIME_MEAS, WATER_LEV) VALUES ('
            + QuotedStr(SiteID) + ', ' + QuotedStr(ComboBoxMeth.Text) + ', ' + QuotedStr(ComboBoxLvl.Text) + ', ' + QuotedStr(SdfDataSet1.Fields[5].AsString) + ', '
            + QuotedStr(ComboBoxInfo.Text) + ', ' + QuotedStr(TheDate) + ', ' + QuotedStr(TheTime) + ', '  + FloatToStr(SdfDataSet1.Fields[7].AsFloat * -1) + ');');
        except on E: Exception do
          begin
            ErrorLog.Add(E.Message + ' - Could not insert water level for ' + SiteID + ' on ' + TheDate + ' and ' + TheTime +  '!');
            if not IgnoreErrors and (MessageDlg(E.Message + ' - Could not insert water level for ' + SiteID + ' on ' + TheDate + ' and ' + TheTime +  '! "Ignore" will skip errors for this site.', mtError, [mbIgnore, mbOK], 0) = mrIgnore) then
              IgnoreErrors := True;
          end;
        end;
      end
      else
      begin
        //do not import as not in date range
        ProgressBoxForm.Label1.Caption := 'Skipping water level for date ' + TheDate;
        Application.ProcessMessages;
      end;
      PrevSiteID := SiteID;
      ProgressBoxForm.Finished := True;
      SdfDataSet1.Next;
    end
    else
    begin
      SdfDataSet1.Last;
      ProgressBoxForm.Finished := True;
    end;
    SdfDataSet1.Close;
  end;
  ErrorLog.Add('All (other) water levels were saved to the "waterlev" table.');
  ErrorLog.SaveToFile(WSpaceDir + DirectorySeparator + 'dws_audited_import.log');
  ErrorLog.Free;
  ProgressBoxForm.Close;
  if ProgressBoxForm.CancelPressed then
  begin
    Application.ProcessMessages;
    MessageDlg('Import process aborted! Your water level data may not be completely imported.', mtWarning, [mbOK], 0);
  end
  else
    MessageDlg('Finished importing water level audited data. Please see file "dws_audited_import.log" in the Workspace for error messages.', mtInformation, [mbOK], 0);
  Close;
end;

procedure TFormDWSAudited.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TFormDWSAudited.FileNameEdit1AcceptFileName(Sender: TObject;
  var Value: String);
var
  m: Byte;
begin
  SiteID := '';
  if SingleSite then
  begin
    if Memo1 = NIL then
      Memo1 := TMemo.Create(Self);
    with Memo1 do
    begin
      Lines.LoadFromFile(Value);
      for m := 0 to 12 do
      if Copy(Lines[m], 1, 11) = '"Identifier' then
      begin
        SiteID := Copy(Lines[m], 15, Pos('",', Lines[m]) - 15);
        //check if SiteID exists in database
        with DataModuleMain.CheckQuery do
        begin
          Connection := DataModuleMain.ZConnectionDB;
          SQL.Clear;
          SQL.Add('SELECT site_id_nr from basicinf where site_id_nr = ' + QuotedStr(SiteID));
          Open;
          if RecordCount = 0 then //does not exist
          begin
            Buttonpanel1.OKButton.Enabled := False;
            Value := '';
            MessageDlg('The Site Identifier "' + SiteID + '" does not exist in the database and can therefore not be imported!', mtError, [mbOK], 0);
          end
          else
            Buttonpanel1.OKButton.Enabled := True; //seems to be a valid fileand SiteID
          Close;
          SQL.Clear;
        end;
      end;
    end;
    if SiteID = '' then //not a valid
    begin
      Buttonpanel1.OKButton.Enabled := False; //seems to be an invalid file
      MessageDlg('The CSV import file is not valid! Please select a valid DWS Audited Water Level CSV import file.', mtError, [mbOK], 0);
      Value := '';
    end;
  end
  else
  with SdfDataSet1 do
  begin
    FileName := Value;
    Open;
    if (Fields.Count = 8) and (Fields[0].FieldName = 'DataOwner') and (Fields[1].FieldName = 'Identifier') and (Fields[5].FieldName = 'PiezometerNumber') then
      Buttonpanel1.OKButton.Enabled := True //seems to be a valid file
    else
    begin
      Close;
      Buttonpanel1.OKButton.Enabled := False; //seems to be an invalid file
      MessageDlg('The CSV import file is not valid! Please select a valid DWS Audited Water Level CSV import file.', mtError, [mbOK], 0);
      Value := '';
    end;
  end;
end;

procedure TFormDWSAudited.FileNameEdit1ButtonClick(Sender: TObject);
begin
  SdfDataSet1.Close;
  FileNameEdit1.InitialDir := WSpaceDir;
end;

procedure TFormDWSAudited.FileNameEdit1Exit(Sender: TObject);
begin
  if FileNameEdit1.Text > '' then
  begin
    if not FileExists(FilenameEdit1.Text) then
    begin
      MessageDlg('The CSV import file does not exist! Please select a valid CSV import file.', mtError, [mbOK], 0);
      FileNameEdit1.Text := '';
      FileNameEdit1.SetFocus;
      ButtonPanel1.OKButton.Enabled := False;
    end
    else
    if SingleSite then
    begin

    end
    else //csv report file, so check if the file is valid
    begin
      with SdfDataSet1 do
      begin
        if not Active then
        begin
          FileName := FileNameEdit1.Text;
          Open;
        end;
        if (Fields.Count = 8) and (Fields[0].FieldName = 'DataOwner') and (Fields[1].FieldName = 'Identifier') and (Fields[5].FieldName = 'PiezometerNumber') then
          Buttonpanel1.OKButton.Enabled := True //seems to be a valid file
        else
        begin
          Close;
          Buttonpanel1.OKButton.Enabled := False; //seems to be an invalid file
          MessageDlg('The CSV import file is not valid! Please select a valid DWS Audited Water Level CSV import file.', mtError, [mbOK], 0);
          FileNameEdit1.Text := '';
          FileNameEdit1.SetFocus;
        end;
      end;
    end;
  end;
end;

end.

