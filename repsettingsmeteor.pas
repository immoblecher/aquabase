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
unit repsettingsmeteor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ButtonPanel, Menus, DateTimePicker, Repsettings, RLReport;

type

  { TMeteoReportSettingsForm }

  TMeteoReportSettingsForm = class(TReportSettingsForm)
    CheckGroup1: TCheckGroup;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    procedure CheckGroup1ItemClick(Sender: TObject; Index: integer);
    procedure FormShow(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private

  public

  end;

var
  MeteoReportSettingsForm: TMeteoReportSettingsForm;

implementation

{$R *.lfm}

uses meteorologyreport, VARINIT, Repprev;

{ TMeteoReportSettingsForm }

procedure TMeteoReportSettingsForm.CheckGroup1ItemClick(Sender: TObject;
  Index: integer);
var
  i: Byte;
  SomethingChecked: Boolean;
begin
  SomethingChecked := CheckGroup1.Checked[Index]; //to initialise
  if SomethingChecked = False then //check if any other is checked
  for i := 0 to CheckGroup1.Items.Count - 1 do
    if CheckGroup1.Checked[i] then SomethingChecked := True;
  ButtonPanel1.OKButton.Enabled := SomethingChecked;
end;

procedure TMeteoReportSettingsForm.FormShow(Sender: TObject);
begin
  DateTimePicker2.DateTime := now;
end;

procedure TMeteoReportSettingsForm.OKButtonClick(Sender: TObject);
begin
  with TMeteorologyReportForm.Create(NIL) do
  begin
    //set report title and other
    TheReport.Title := TitleEdit.Caption;
    RLSystemInfo1.Visible := CheckBox3.Checked;
    RLSystemInfo2.Visible := CheckBox1.Checked;
    if cbPageBreak.Checked then
      RLBand1.PageBreaking := pbBeforePrint
    else
      RLBand1.PageBreaking := pbNone;
    //if only the current site
    if RadioGroup1.ItemIndex = 0 then
    begin
      //set view
      ViewQuery.SQL.Add('SELECT DISTINCT v.SITE_ID_NR FROM ' + FilterName + ' v');
      ViewQuery.SQL.Add('WHERE v.SITE_ID_NR = ' + QuotedStr(CurrentSite));
    end
    else
    begin
      //set view
      ViewQuery.SQL.Add('SELECT DISTINCT v.SITE_ID_NR FROM ' + ViewComboBox.Text + ' v');
    end;
    //check for comments
    CommentMemoFromBasic := CheckBox4.Checked and CheckBoxFromBasic.Checked;
    if CheckBox4.Checked and not CheckBoxFromBasic.Checked then
      RLCommentMemo.Lines.Assign(CommentMemo.Lines);
    //set dates
    StartDateTime := DateTimePicker1.DateTime;
    EndDateTime := DateTimePicker2.DateTime;
    //set visible subdetails
    SubDetail1.Visible := CheckGroup1.Checked[0];
    SubDetail2.Visible := CheckGroup1.Checked[1];
    SubDetail3.Visible := CheckGroup1.Checked[2];
    SubDetail4.Visible := CheckGroup1.Checked[3];
    SubDetail6.Visible := CheckGroup1.Checked[4];
    SubDetail5.Visible := CheckGroup1.Checked[5];
    SubDetail7.Visible := CheckGroup1.Checked[6];
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

end.

