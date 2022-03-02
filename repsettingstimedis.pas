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
unit repsettingstimedis;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Menus, DateTimePicker, Repsettings, RLReport;

type

  { TTimeDisReportSettingsForm }

  TTimeDisReportSettingsForm = class(TReportSettingsForm)
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private

  public

  end;

var
  TimeDisReportSettingsForm: TTimeDisReportSettingsForm;

implementation

{$R *.lfm}

uses timedeptdisreport, VARINIT, Repprev;

{ TTimeDisReportSettingsForm }

procedure TTimeDisReportSettingsForm.OKButtonClick(Sender: TObject);
begin
  with TPortraitReportFormDis.Create(Application) do
  begin
    with ViewQuery.SQL do
    begin
      Clear;
      if RadioGroup1.ItemIndex = 0 then
        Add('SELECT DISTINCT v.site_id_nr from ' + FilterName + ' v')
      else
        Add('SELECT DISTINCT v.site_id_nr from ' + ViewComboBox.Text + ' v');
      Add('JOIN discharg d on (v.site_id_nr = d.site_id_nr)');
      if RadioGroup1.ItemIndex = 0 then
        Add('WHERE v.site_id_nr = ' + QuotedStr(CurrentSite));
      if ViewQuery.Connection.Tag = 1 then
      begin
        Add('AND d.DATE_MEAS || d.TIME_MEAS >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker1.DateTime)));
        Add('AND d.DATE_MEAS || d.TIME_MEAS <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker2.DateTime)));
      end
      else
      begin
        Add('AND CONCAT(d.DATE_MEAS, d.TIME_MEAS) >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker1.DateTime)));
        Add('AND CONCAT(d.DATE_MEAS, d.TIME_MEAS) <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker2.DateTime)));
      end;
    end;
    //Set HeaderQuery (basicinf) filters
    if ConstrCheckBox.Checked and (UsedTablesList.IndexOf('basicinf') > -1) then
      HeaderQuery.SQL.Add('WHERE ' + Filterlist[UsedTablesList.IndexOf('basicinf')]);
    //Set current and Dates/Times and optional constraint
    with DetailQuery do
    begin
      if RadioGroup1.ItemIndex = 0 then
      begin
        SQL.Add('WHERE site_id_nr = ' + QuotedStr(CurrentSite));
        SQL.Add('AND');
      end
      else
        SQL.Add('WHERE');
      if Connection.Tag = 1 then
      begin
        SQL.Add('DATE_MEAS || TIME_MEAS >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker1.DateTime)));
        SQL.Add('AND DATE_MEAS || TIME_MEAS <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker2.DateTime)));
      end
      else
      begin
        SQL.Add('CONCAT(DATE_MEAS, TIME_MEAS) >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker1.DateTime)));
        SQL.Add('AND CONCAT(DATE_MEAS, TIME_MEAS) <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker2.DateTime)));
      end;
      if ConstrCheckBox.Checked and (UsedTablesList.IndexOf('discharg') > -1) then
        SQL.Add('AND ' + Filterlist[UsedTablesList.IndexOf('discharg')]);
    end;
    if CheckBox2.Checked then //show summary
    begin
      RLBandSummary.Visible := True;
      with SummaryQuery.SQL do
      begin
        Add('SELECT v.site_id_nr, MIN(d.DISCH_RATE) MinDISCH, MAX(d.DISCH_RATE) MaxDISCH, AVG(d.DISCH_RATE) AvgDISCH FROM ' + ViewComboBox.Text + ' v');
        Add('JOIN discharg d on (v.site_id_nr = d.site_id_nr)');
        if RadioGroup1.ItemIndex = 0 then
          Add('WHERE v.site_id_nr = ' + QuotedStr(CurrentSite));
        if ViewQuery.Connection.Tag = 1 then
        begin
          Add('AND d.DATE_MEAS || d.TIME_MEAS >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker1.DateTime)));
          Add('AND d.DATE_MEAS || d.TIME_MEAS <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker2.DateTime)));
        end
        else
        begin
          Add('AND CONCAT(d.DATE_MEAS, d.TIME_MEAS) >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker1.DateTime)));
          Add('AND CONCAT(d.DATE_MEAS, d.TIME_MEAS) <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker2.DateTime)));
        end;
        Add('GROUP BY 1');
      end;
    end
    else
      RLBandSummary.Visible := False;
    RLReportPortrait.Title := TitleEdit.Text;
    if CheckBox4.Checked then
      CommentRLMemo.Lines.Assign(CommentMemo.Lines);
    if cbPageBreak.Checked then
      HeaderBand1.PageBreaking := pbBeforePrint;
    try
      with TRepPrevForm.Create(Application) do
      begin
        RLReportPortrait.Preview(RLPreview1);
        Show;
      end;
    finally
      Screen.Cursor := crDefault;
      Close;
    end;
  end;
end;

procedure TTimeDisReportSettingsForm.FormCreate(Sender: TObject);
begin
  inherited;
  DateTimePicker2.DateTime := Now;
  with AvailableTablesList do
  begin
    Add('basicinf');
    Add('discharg');
  end;
end;

end.

