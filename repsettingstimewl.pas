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
unit repsettingstimewl;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Menus, DateTimePicker, Repsettings, RLReport;

type

  { TTimeWLReportSettingsForm }

  TTimeWLReportSettingsForm = class(TReportSettingsForm)
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
  TimeWLReportSettingsForm: TTimeWLReportSettingsForm;

implementation

{$R *.lfm}

uses timedeptwlreport, VARINIT, Repprev;

{ TTimeWLReportSettingsForm }

procedure TTimeWLReportSettingsForm.OKButtonClick(Sender: TObject);
begin
  with TPortraitReportFormWL.Create(Application) do
  begin
    with ViewQuery.SQL do
    begin
      Clear;
      if RadioGroup1.ItemIndex = 0 then
        Add('SELECT DISTINCT v.site_id_nr FROM ' + FilterName + ' v')
      else
        Add('SELECT DISTINCT v.site_id_nr FROM ' + ViewComboBox.Text + ' v');
      Add('JOIN waterlev w on (v.site_id_nr = w.site_id_nr)');
      if RadioGroup1.ItemIndex = 0 then
        Add('WHERE v.site_id_nr = ' + QuotedStr(CurrentSite));
      if ViewQuery.Connection.Tag = 1 then
      begin
        Add('AND w.DATE_MEAS || w.TIME_MEAS >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker1.DateTime)));
        Add('AND w.DATE_MEAS || w.TIME_MEAS <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker2.DateTime)));
      end
      else
      begin
        Add('AND CONCAT(w.DATE_MEAS, w.TIME_MEAS) >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker1.DateTime)));
        Add('AND CONCAT(w.DATE_MEAS, w.TIME_MEAS) <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker2.DateTime)));
      end;
    end;
    //Set HeaderQuery (basicinf) filters
    if ConstrCheckBox.Checked and (UsedTablesList.IndexOf('basicinf') > -1) then
      HeaderQuery.SQL.Add('WHERE ' + Filterlist[UsedTablesList.IndexOf('basicinf')]);
    //Set current and Dates/Times and optional constraint
    with DetailQuery.SQL do
    begin
      Clear;
      Add('SELECT w.* FROM ' + ViewComboBox.Text + ' v');
      Add('JOIN waterlev w ON (v.SITE_ID_NR = w.SITE_ID_NR)');
      if RadioGroup1.ItemIndex = 0 then
      begin
        Add('AND w.site_id_nr = ' + QuotedStr(CurrentSite));
        Add('AND');
      end
      else
        Add('WHERE');
      if DetailQuery.Connection.Tag = 1 then
      begin
        Add('DATE_MEAS || TIME_MEAS >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker1.DateTime)));
        Add('AND DATE_MEAS || TIME_MEAS <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker2.DateTime)));
      end
      else
      begin
        Add('CONCAT(DATE_MEAS, TIME_MEAS) >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker1.DateTime)));
        Add('AND CONCAT(DATE_MEAS, TIME_MEAS) <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker2.DateTime)));
      end;
      if ConstrCheckBox.Checked and (UsedTablesList.IndexOf('waterlev') > -1) then
        Add('AND ' + Filterlist[UsedTablesList.IndexOf('waterlev')]);
      Add('ORDER BY w.SITE_ID_NR, w.DATE_MEAS, w.TIME_MEAS, w.TIME_SEC');
    end;
    if CheckBox2.Checked then //show summary
    begin
      RLBandSummary.Visible := True;
      with SummaryQuery.SQL do
      begin
        Add('SELECT v.site_id_nr, MIN(w.water_lev) MinWL, MAX(w.water_lev) MaxWL, AVG(w.water_lev) AvgWL FROM ' + ViewComboBox.Text + ' v');
        Add('JOIN waterlev w on (v.site_id_nr = w.site_id_nr)');
        if RadioGroup1.ItemIndex = 0 then
          Add('WHERE v.site_id_nr = ' + QuotedStr(CurrentSite));
        if ViewQuery.Connection.Tag = 1 then
        begin
          Add('AND w.DATE_MEAS || w.TIME_MEAS >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker1.DateTime)));
          Add('AND w.DATE_MEAS || w.TIME_MEAS <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker2.DateTime)));
        end
        else
        begin
          Add('AND CONCAT(w.DATE_MEAS, w.TIME_MEAS) >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker1.DateTime)));
          Add('AND CONCAT(w.DATE_MEAS, w.TIME_MEAS) <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker2.DateTime)));
        end;
        Add('GROUP BY 1');
      end;
    end;
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

procedure TTimeWLReportSettingsForm.FormCreate(Sender: TObject);
begin
  inherited;
  DateTimePicker2.DateTime := Now;
  with AvailableTablesList do
  begin
    Add('basicinf');
    Add('waterlev');
  end;
end;

end.

