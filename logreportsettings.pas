{ Copyright (C) 2022 Immo Blecher immo@blecher.co.za

  This source is free software; you can redistribute it and/or modify it under
  the terms of the GNU General Public License as published by the Free
  Software Foundation; either version 2 of the License, or (at your option)
  any later version.

  This code is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

  A copy of the GNU General Public License is available on the World Wide Web
  at http://www.gnu.org/copyleft/gpl.html. You can also obtain it by writing
  to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
  MA 02111-1307, USA.
}
unit logreportsettings;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLType,
  Repsettings, StdCtrls, ExtCtrls, Buttons, Menus, ButtonPanel;

type

  { TLogReportSetForm }

  TLogReportSetForm = class(TReportSettingsForm)
    CheckBoxSave: TCheckBox;
    CheckBoxBasicInfo: TCheckBox;
    CheckBoxSplitCharts: TCheckBox;
    GroupBox2: TGroupBox;
    ConstructionCheckBox: TCheckBox;
    AquiferCheckBox: TCheckBox;
    Geology1CheckBox: TCheckBox;
    SortingCheckBox: TCheckBox;
    GrainCheckBox: TCheckBox;
    FillCheckBox: TCheckBox;
    PiezomCheckBox: TCheckBox;
    procedure CheckBoxSaveClick(Sender: TObject);
    procedure CheckBoxSplitChartsClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    bmp1, bmp2, bmp1Top, bmp1Bot, bmp2Top, bmp2Bot: TBitmap;
    LogChartWidth, DTHChartWidth: Integer;
    DTHChartVisibleOnReport: Boolean;
  end;

var
  LogReportSetForm: TLogReportSetForm;

implementation

{$R *.lfm}

uses VARINIT, logreport, MainDataModule, RLReport, Repprev;

{ TLogReportSetForm }

procedure TLogReportSetForm.OKButtonClick(Sender: TObject);
begin
  with TLogReportForm.Create(Application) do
  begin
    Screen.Cursor := crHourglass;
    if not CheckBoxBasicInfo.Checked then
    begin
      RLBandBasicinf.BandType := btDetail;
      ChartRLBand2.PageBreaking := pbNone;
    end;
    ConstructionSubDetail.Visible := ConstructionCheckBox.Checked;
    ConstructionSubDetail1.Visible := ConstructionCheckBox.Checked;
    HoleSubDetail.Visible := ConstructionCheckBox.Checked;
    CasingSubDetail.Visible := ConstructionCheckBox.Checked;
    PiezomSubDetail.Visible := PiezomCheckBox.Checked;
    HoleFillSubDetail.Visible := FillCheckBox.Checked;
    GeologySubDetail.Visible := Geology1CheckBox.Checked;
    GeologySubDetail1.Visible := GrainCheckBox.Checked;
    GeologySubDetail2.Visible := SortingCheckBox.Checked;
    ChartRLBand1.Height := FooterBand.Top - ChartRLBand1.Top;
    if CheckBoxSplitCharts.Checked then
    begin
      ChartRLBand2.Visible := True;
      ChartRLBand2.Height := ChartRLBand1.Height;
      LogChartRLImage1.Picture.Bitmap.Assign(bmp1Top);
      LogChartRLImage1.Height := ChartRLBand1.Height;
      LogChartRLImage1.Width := Round(LogChartWidth / Width * ChartRLBand1.Width);
      LogChartRLImage2.Picture.Bitmap.Assign(bmp1Bot);
      LogChartRLImage2.Height := ChartRLBand2.Height;
      LogChartRLImage2.Width := Round(LogChartWidth / Width * ChartRLBand2.Width);
      if CheckBoxSave.Checked then
      begin
        bmp1Top.SaveToFile(WSpaceDir + DirectorySeparator + 'ChartLogTop.bmp');
        bmp1Bot.SaveToFile(WSpaceDir + DirectorySeparator + 'ChartLogBot.bmp');
      end;
      if DTHChartVisibleOnReport then
      begin
        DTHChartRLImage1.Visible := True;
        DTHChartRLImage1.Picture.Bitmap.Assign(bmp2Top);
        //DTHChartRLImage1.Height := ChartRLBand1.Height;
        DTHChartRLImage1.Width := Round(DTHChartWidth / Width * ChartRLBand1.Width);
        DTHChartRLImage2.Visible := True;
        DTHChartRLImage2.Picture.Bitmap.Assign(bmp2Bot);
        //DTHChartRLImage2.Height := ChartRLBand2.Height;
        DTHChartRLImage2.Width := Round(DTHChartWidth / Width * ChartRLBand2.Width);
        if CheckBoxSave.Checked then
        begin
          bmp2Top.SaveToFile(WSpaceDir + DirectorySeparator + 'ChartDTHTop.bmp');
          bmp2Bot.SaveToFile(WSpaceDir + DirectorySeparator + 'ChartDTHBot.bmp');
        end;
      end
    end
    else
    begin
      LogChartRLImage1.Picture.Bitmap.Assign(bmp1);
      //LogChartRLImage1.Height := ChartRLBand1.Height;
      LogChartRLImage1.Width := Round(LogChartWidth / Width * ChartRLBand1.Width);
      if CheckBoxSave.Checked then
        bmp1.SaveToFile(WSpaceDir + DirectorySeparator + 'ChartLog.bmp');
      if DTHChartVisibleOnReport then
      begin
        DTHChartRLImage1.Visible := True;
        DTHChartRLImage1.Picture.Bitmap.Assign(bmp2);
        //DTHChartRLImage1.Height := ChartRLBand1.Height;
        DTHChartRLImage1.Width := Round(DTHChartWidth / Width * ChartRLBand1.Width);
        if CheckBoxSave.Checked then
          bmp2.SaveToFile(WSpaceDir + DirectorySeparator + 'ChartDTH.bmp');
      end;
    end;
    GeolLogReport.Title := TitleEdit.Text;
    RLSystemInfo1.Visible := CheckBox3.Checked;
    RLSystemInfo2.Visible := CheckBox1.Checked;
    if cbPageBreak.Checked then
      RLBandBasicinf.PageBreaking := pbBeforePrint
    else
      RLBandBasicinf.PageBreaking := pbNone;
    RepCommentMemo.Lines.Clear;
    RepCommentMemo.Lines.AddStrings(CommentMemo.Lines);
    RepCommentMemo.Visible := CheckBox4.Checked;
    RLSystemInfo1.Visible := CheckBox3.Checked;
    DataModuleMain.LookupTable.Filtered := True;
    TableList := TStringList.Create;
    TableList.AddStrings(UsedTablesList);
    RepFilterList := TStringList.Create;
    RepFilterList.AddStrings(FilterList);
    try
      with TRepPrevForm.Create(Application) do
      begin
        GeolLogReport.Preview(RLPreview1);
        Show;
      end;
    finally
      Screen.Cursor := crDefault;
      Close;
    end;
  end;
end;

procedure TLogReportSetForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TLogReportSetForm.CheckBoxSplitChartsClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 3 then
  begin
    MessageDlg(VersionMessage, mtError,[mbOK], 0);
    CheckBoxSplitCharts.Checked := False;
  end;
  {$ENDIF}
end;

procedure TLogReportSetForm.CheckBoxSaveClick(Sender: TObject);
begin
    {$IFDEF WINDOWS}
  if VerDiff > 3 then
  begin
    MessageDlg(VersionMessage, mtError,[mbOK], 0);
    CheckBoxSave.Checked := False;
  end;
  {$ENDIF}
end;

procedure TLogReportSetForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TLogReportSetForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  inherited;
  bmp1.Free;
  bmp2.Free;
  if CheckBoxSplitCharts.Enabled then
  begin
    bmp1Top.Free;
    bmp2Top.Free;
    bmp1Bot.Free;
    bmp2Bot.Free;
  end;
  CloseAction := caFree;
end;

end.
