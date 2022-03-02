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
unit repsettingschem;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ButtonPanel, Menus, Buttons, DateTimePicker, Repsettings, LCLType,
  RLReport;

type

  { TChemReportSettingsForm }

  TChemReportSettingsForm = class(TReportSettingsForm)
    BitBtn1: TBitBtn;
    BitBtnCharts: TBitBtn;
    CheckGroup1: TCheckGroup;
    Label3: TLabel;
    Label4: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtnChartsClick(Sender: TObject);
    procedure CheckGroup1ItemClick(Sender: TObject; Index: integer);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    TheSampleStr: String;
  public

  end;

var
  ChemReportSettingsForm: TChemReportSettingsForm;

implementation

{$R *.lfm}

uses selectsamples, chemreport, VARINIT, Repprev, chemchartsettings,
     maindatamodule;

{ TChemReportSettingsForm }

procedure TChemReportSettingsForm.FormCreate(Sender: TObject);
begin
  inherited;
  DateTimePicker1.Date := EncodeDate(2000, 01, 01);
  DateTimePicker1.Time := EncodeTime(0, 0, 0, 0);
  DateTimePicker2.DateTime := Now;
  with AvailableTablesList do
  begin
    Add('chem_000');
    Add('chem_001');
    Add('chem_002');
    Add('chem_003');
    Add('chem_004');
    Add('chem_005');
    Add('chem_006');
    Add('userchem');
  end;
end;

procedure TChemReportSettingsForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TChemReportSettingsForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TChemReportSettingsForm.OKButtonClick(Sender: TObject);
begin
  with TChemReportForm.Create(Application) do
  begin
    //set report title and other
    TheReport.Title := TitleEdit.Caption;
    RLSystemInfo1.Visible := CheckBox3.Checked;
    RLSystemInfo2.Visible := CheckBox1.Checked;
    if cbPageBreak.Checked then
      RLBand1.PageBreaking := pbBeforePrint
    else
      RLBand1.PageBreaking := pbNone;
    //check for comments
    CommentMemoFromBasic := CheckBox4.Checked and CheckBoxFromBasic.Checked;
    if CheckBox4.Checked and not CheckBoxFromBasic.Checked then
      RLCommentMemo.Lines.Assign(CommentMemo.Lines);
    //if only the current site
    if RadioGroup1.ItemIndex = 0 then
    begin
      //set view
      ViewQuery.SQL.Add('SELECT DISTINCT v.SITE_ID_NR FROM ' + FilterName + ' v');
      ViewQuery.SQL.Add('JOIN chem_000 c ON (v.SITE_ID_NR = c.SITE_ID_NR)'); //make sure there's actually chemistry
      ViewQuery.SQL.Add('WHERE v.SITE_ID_NR = ' + QuotedStr(CurrentSite));
    end
    else
    begin
      //set view
      ViewQuery.SQL.Add('SELECT DISTINCT v.SITE_ID_NR FROM ' + ViewComboBox.Text + ' v');
      ViewQuery.SQL.Add('JOIN chem_000 c ON (v.SITE_ID_NR = c.SITE_ID_NR)'); //make sure there's actually chemistry
    end;
    //if samples selected
    if TheSampleStr > '' then
      ViewQuery.SQL.Add('AND c.CHM_REF_NR IN (' + TheSampleStr + ')');
    //set dates
    StartDateTime := DateTimePicker1.DateTime;
    EndDateTime := DateTimePicker2.DateTime;
    //set visible subdetails
    SubDetail2a.Visible := CheckGroup1.Checked[0];
    SubDetail2b.Visible := CheckGroup1.Checked[0];
    SubDetail3a.Visible := CheckGroup1.Checked[1];
    SubDetail3b.Visible := CheckGroup1.Checked[1];
    SubDetail4a.Visible := CheckGroup1.Checked[2];
    SubDetail4b.Visible := CheckGroup1.Checked[2];
    SubDetail5a.Visible := CheckGroup1.Checked[3];
    SubDetail5b.Visible := CheckGroup1.Checked[3];
    SubDetail6a.Visible := CheckGroup1.Checked[4];
    SubDetail6b.Visible := CheckGroup1.Checked[4];
    //show the report
    try
      Screen.Cursor := crHourglass;
      with TRepPrevForm.Create(Application) do
      begin
        TheReport.Preview(RLPreview1);
        Show;
      end;
    finally
      Screen.Cursor := crDefault;
      Close;
    end;
  end;
end;

procedure TChemReportSettingsForm.BitBtn1Click(Sender: TObject);
begin
  with TSelectSamplesForm.Create(Application) do
  begin
    ViewName := ViewComboBox.Text;
    StartDate := FormatDateTime('YYYYMMDD', DateTimePicker1.Date);
    StartTime := FormatDateTime('hhnn', DateTimePicker1.Time);
    EndDate := FormatDateTime('YYYYMMDD', DateTimePicker2.Date);
    EndTime := FormatDateTime('hhnn', DateTimePicker2.Time);
    TheSampleStr := '';
    CurrentSiteOnly := RadioGroup1.ItemIndex = 0;
    ShowModal;
    if ModalResult = mrOK then
      TheSampleStr := SampleStr;
    Close;
    Free;
  end;
end;

procedure TChemReportSettingsForm.BitBtnChartsClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 5 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  if (Cht1Tag > -1) or (Cht2Tag > -1) then
    MessageDlg('You have selected one or two charts for the report already! You need to close these before you can select new chart(s)?', mtWarning, [mbOK], 0)
  else
  with TChemChartSettingsForm.Create(Application) do
  begin
    FromMainMenu := True;
    ForReport := True;
    DateTimePickerFrom.DateTime := DateTimePicker1.DateTime;
    DateTimePickerTo.DateTime := DateTimePicker2.DateTime;
    if RadioGroup1.ItemIndex = 0 then
      ComboBoxViews.ItemIndex := ComboBoxViews.Items.IndexOf('Current Site')
    else
      ComboBoxViews.ItemIndex := ComboBoxViews.Items.IndexOf(ViewComboBox.Text);
    ShowModal;
    if Cht1Tag > -1 then
      ShowMessage('You have successfully created one or two charts for the report! You can adjust sizes and modify some parameters by accessing the popup menu (right-click), after which you need to "Update chart for report" in the menu. If you close one or both charts before creating the report then those will not be shown!');
  end;
end;

procedure TChemReportSettingsForm.CheckGroup1ItemClick(Sender: TObject;
  Index: integer);
var
  i: Byte;
  SomethingChecked: Boolean;
begin
  SomethingChecked := CheckGroup1.Checked[Index];//to initialise
  if SomethingChecked = False then //check if any other is checked
  for i := 0 to CheckGroup1.Items.Count - 1 do
    if CheckGroup1.Checked[i] then SomethingChecked := True;
  ButtonPanel1.OKButton.Enabled := SomethingChecked;
end;

end.

