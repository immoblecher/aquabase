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
unit reporttemplateportrait;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, RLReport, ZDataset;

type

  { TPortraitReportForm }

  TPortraitReportForm = class(TForm)
    CommentRLMemo: TRLMemo;
    DetailDataSource: TDataSource;
    HeaderBand1: TRLBand;
    HeaderDataSource: TDataSource;
    RLBandSummary: TRLBand;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabelHeader1: TRLLabel;
    RLLabelHeader2: TRLLabel;
    RLLabelHeader3: TRLLabel;
    RLMemoLookups: TRLMemo;
    SummaryDataSource: TDataSource;
    SummaryQuery: TZReadOnlyQuery;
    ViewDataSource: TDataSource;
    FooterBand: TRLBand;
    RLBandHeader: TRLBand;
    RLDBText2: TRLDBText;
    RLDBText1: TRLDBText;
    RLImageLogo: TRLImage;
    RLMemoUserDetails: TRLMemo;
    RLReportPortrait: TRLReport;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfoReportTitle: TRLSystemInfo;
    DetailBand1: TRLBand;
    SubDetail1: TRLSubDetail;
    HeaderQuery: TZReadOnlyQuery;
    DetailQuery: TZReadOnlyQuery;
    ViewQuery: TZReadOnlyQuery;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure HeaderBand1AfterPrint(Sender: TObject);
    procedure HeaderDataSourceDataChange(Sender: TObject; Field: TField);
    procedure RLReportPortraitAfterPrint(Sender: TObject);
    procedure RLReportPortraitBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLReportPortraitPageStarting(Sender: TObject);
  private
    DataHasChanged: Boolean;
  public

  end;

var
  PortraitReportForm: TPortraitReportForm;

implementation

{$R *.lfm}

uses VARINIT, MainDataModule;

{ TPortraitReportForm }

procedure TPortraitReportForm.RLReportPortraitBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  Screen.Cursor := crSQLWait;
  with RLReportPortrait do
  begin
    Margins.LeftMargin := LLeftMargin;
    Margins.TopMargin := LTopMargin;
    Margins.BottomMargin := 10 - LTopMargin + 10;
    Margins.RightMargin := LRightMargin;
  end;
  RLBandHeader.Color := ReportHeaderBandColor;
  ViewQuery.Open;
  HeaderQuery.Open;
  DetailQuery.Open;
  if RLBandSummary.Visible then
    SummaryQuery.Open;
  if FileExists(WSpaceDir + DirectorySeparator + 'Userinfo.txt') then
    RLMemoUserDetails.Lines.LoadFromFile(WSpaceDir + DirectorySeparator + 'Userinfo.txt');
  if FileExists(WSpaceDir + DirectorySeparator + 'userlogo.jpg') then
    RLImageLogo.Picture.LoadFromFile(WSpaceDir + DirectorySeparator + 'userlogo.jpg')
  else
  if FileExists(WSpaceDir + DirectorySeparator + 'userlogo.bmp') then
    RLImageLogo.Picture.LoadFromFile(WSpaceDir + DirectorySeparator + 'userlogo.bmp');
  Screen.Cursor := crDefault;
  Application.ProcessMessages;
end;

procedure TPortraitReportForm.RLReportPortraitPageStarting(Sender: TObject);
begin
  if (RLReportPortrait.PageNumber > 1) and (not DataHasChanged) then
    HeaderBand1.Print;
end;

procedure TPortraitReportForm.RLReportPortraitAfterPrint(Sender: TObject);
begin
  DetailQuery.Close;
  HeaderQuery.Close;
  ViewQuery.Close;
  SummaryQuery.Close;
end;

procedure TPortraitReportForm.FormCreate(Sender: TObject);
var
  i: Word;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TRLLabel then
    begin
      with (Components[i] as TRLLabel).Font do
      begin
        Name := ReportFont.Name;
        Color := ReportFont.Color;
        if Components[i].Tag = 0 then
          Size := ReportFont.Size
        else Size := ReportFont.Size + 1;
      end;
      (Components[i] as TRLLabel).Layout := tlBottom;
    end
    else
    if Components[i] is TRLDBText then
    begin
      with (Components[i] as TRLDBText).Font do
      begin
        Name := ReportFont.Name;
        Color := ReportFont.Color;
        Style := ReportFont.Style;
        if Components[i].Tag = 0 then
          Size := ReportFont.Size
        else Size := ReportFont.Size + 1;
      end;
      (Components[i] as TRLDBText).Layout := tlBottom;
    end
    else
    if Components[i] is TRLSystemInfo then
    begin
      with (Components[i] as TRLSystemInfo).Font do
      begin
        Name := ReportFont.Name;
        Color := ReportFont.Color;
        Style := ReportFont.Style;
        if Components[i].Tag = 0 then
          Size := ReportFont.Size
        else Size := ReportFont.Size + 2;
        if Components[i].Tag = 2 then
          Style := [fsBold,fsItalic];
      end;
    end
    else
    if Components[i] is TRLMemo then
    begin
      with (Components[i] as TRLMemo).Font do
      begin
        Name := ReportFont.Name;
        Color := ReportFont.Color;
        Size := ReportFont.Size;
        Style := ReportFont.Style;
      end;
    end
    else
    if Components[i] is TRLDBMemo then
    begin
      with (Components[i] as TRLDBMemo).Font do
      begin
        Name := ReportFont.Name;
        Color := ReportFont.Color;
        Size := ReportFont.Size;
        Style := ReportFont.Style;
      end;
    end;
  end;
  HeaderBand1.Color := ColumnHeaderBandColor;
  //set Header labels and DBText
  RLDBText3.Left := RLLabel1.Left + RLLabel1.Width + 2;
  RLLabel2.Left := RLDBText3.Left + RLDBText3.Width + 2;
  RLDBText5.Left := RLLabel2.Left + RLLabel2.Width + 2;
  RLLabel3.Left := RLDBText5.Left + RLDBText5.Width + 2;
  RLDBText6.Left := RLLabel3.Left + RLLabel3.Width + 2;
  RLDBText6.Width := HeaderBand1.Width - RLDBText6.Left - 2;
  //set data connections
  ViewQuery.Connection := DataModuleMain.ZConnectionDB;
  HeaderQuery.Connection := DataModuleMain.ZConnectionDB;
  DetailQuery.Connection := DataModuleMain.ZConnectionDB;
  SummaryQuery.Connection := DataModuleMain.ZConnectionDB;
end;

procedure TPortraitReportForm.HeaderBand1AfterPrint(Sender: TObject);
begin
  DataHasChanged := False;
end;

procedure TPortraitReportForm.HeaderDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  DataHasChanged := True;
end;

procedure TPortraitReportForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

end.

