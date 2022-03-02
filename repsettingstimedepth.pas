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
unit repsettingstimedepth;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Menus, DateTimePicker, Repsettings, RLReport;

type

  { TDepthReportSettingsForm }

  TDepthReportSettingsForm = class(TReportSettingsForm)
    CheckBoxLocale: TCheckBox;
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
  DepthReportSettingsForm: TDepthReportSettingsForm;

implementation

{$R *.lfm}

uses timedeptdepthreport, VARINIT, Repprev;

{ TDepthReportSettingsForm }

procedure TDepthReportSettingsForm.OKButtonClick(Sender: TObject);
begin
  with TPortraitReportFormDepth.Create(Application) do
  begin
    with ViewQuery.SQL do
    begin
      Clear;
      if RadioGroup1.ItemIndex = 0 then
        Add('SELECT DISTINCT v.site_id_nr from ' + FilterName + ' v')
      else
        Add('SELECT DISTINCT v.site_id_nr from ' + ViewComboBox.Text + ' v');
      Add('JOIN constrct c on (v.site_id_nr = c.site_id_nr)');
      if RadioGroup1.ItemIndex = 0 then
        Add('WHERE v.site_id_nr = ' + QuotedStr(CurrentSite));
      Add('AND c.DATE_CONST >= ' + QuotedStr(FormatDateTime('YYYYMMDD', DateTimePicker1.DateTime)));
      Add('AND c.DATE_CONST <= ' + QuotedStr(FormatDateTime('YYYYMMDD', DateTimePicker2.DateTime)));
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
      SQL.Add('DATE_CONST >= ' + QuotedStr(FormatDateTime('YYYYMMDD', DateTimePicker1.DateTime)));
      SQL.Add('AND DATE_CONST <= ' + QuotedStr(FormatDateTime('YYYYMMDD', DateTimePicker2.DateTime)));
      if ConstrCheckBox.Checked and (UsedTablesList.IndexOf('constrct') > -1) then
        SQL.Add('AND ' + Filterlist[UsedTablesList.IndexOf('constrct')]);
    end;
    if CheckBox2.Checked then //show summary
    begin
      RLBandSummary.Visible := True;
      with SummaryQuery.SQL do
      begin
        Add('SELECT v.site_id_nr, MIN(c.depth) MinDepth, MAX(c.depth) MaxDepth, AVG(c.depth) AvgDepth FROM ' + ViewComboBox.Text + ' v');
        Add('JOIN constrct c on (v.site_id_nr = c.site_id_nr)');
        if RadioGroup1.ItemIndex = 0 then
          Add('WHERE v.site_id_nr = ' + QuotedStr(CurrentSite));
        Add('AND c.DATE_CONST >= ' + QuotedStr(FormatDateTime('YYYYMMDD', DateTimePicker1.DateTime)));
        Add('AND c.DATE_CONST <= ' + QuotedStr(FormatDateTime('YYYYMMDD', DateTimePicker2.DateTime)));
        Add('GROUP BY 1');
      end;
    end;
    RLReportPortrait.Title := TitleEdit.Text;
    if CheckBox4.Checked then
      CommentRLMemo.Lines.Assign(CommentMemo.Lines);
    if cbPageBreak.Checked then
      HeaderBand1.PageBreaking := pbBeforePrint;
    DateLocale := CheckBoxLocale.Checked;
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

procedure TDepthReportSettingsForm.FormCreate(Sender: TObject);
begin
  inherited;
  DateTimePicker2.DateTime := Now;
    with AvailableTablesList do
    begin
      Add('basicinf');
      Add('constrct');
    end;  end;

end.

