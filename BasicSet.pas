{ Copyright (C) 2024 Immo Blecher, immo@blecher.co.za

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
unit BasicSet;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Repsettings, StdCtrls, ExtCtrls, Buttons, Menus, RLReport;

type

  { TBasicReportSetForm }

  TBasicReportSetForm = class(TReportSettingsForm)
    GroupBox2: TGroupBox;
    ConstructionCheckBox: TCheckBox;
    AquiferCheckBox: TCheckBox;
    DischargeCheckBox: TCheckBox;
    WaterLevelCheckBox: TCheckBox;
    TestingCheckBox: TCheckBox;
    InstallationCheckBox: TCheckBox;
    ManagementCheckBox: TCheckBox;
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BasicReportSetForm: TBasicReportSetForm;

implementation

{$R *.lfm}

uses VARINIT, siteinfo, Repprev;

{ TBasicReportSetForm }

procedure TBasicReportSetForm.OKButtonClick(Sender: TObject);
begin
  with TSiteInfoReportForm.Create(Application) do
  begin
    Screen.Cursor := crSQLWait;
    SiteInfoReport.Title := TitleEdit.Text;
    if (Radiogroup1.ItemIndex = 1) then
      ViewName := ViewComboBox.Text
    else
    begin
      ViewName := FilterName;
      UseCurrentSite := True;
    end;
    RLSystemInfo1.Visible := CheckBox3.Checked;
    RLSystemInfo2.Visible := CheckBox1.Checked;
    if cbPageBreak.Checked then
      RLBand1.PageBreaking := pbBeforePrint
    else
      RLBand1.PageBreaking := pbNone;
    CommentMemo.Lines.Clear;
    CommentMemo.Lines.AddStrings(CommentMemo.Lines);
    CommentMemo.Visible := CheckBox4.Checked;
    if CheckBox3.Checked = False then RLSystemInfo1.Enabled := False;
    if FilterList.Count > 0 then
      TheFilterList.AddStrings(FilterList);
    if UsedTablesList.Count > 0 then
      TheUsedTablesList.AddStrings(UsedTablesList);
    UseConstr := ConstrCheckBox.Checked;
    ShowConstr := ConstructionCheckBox.Checked;
    ShowAquifer := AquiferCheckBox.Checked;
    ShowDischarge := DischargeCheckBox.Checked;
    ShowWL := WaterLevelCheckBox.Checked;
    ShowTesting := TestingCheckBox.Checked;
    ShowInstall := InstallationCheckBox.Checked;
    ShowSiteMan := ManagementCheckBox.Checked;
    try
      with TRepPrevForm.Create(Application) do
      begin
        SiteInfoReport.Preview(RLPreview1);
        Show;
      end;
    finally
      Screen.Cursor := crDefault;
      Close;
    end;
  end;
end;

end.
