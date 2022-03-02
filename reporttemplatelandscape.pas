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
unit reporttemplatelandscape;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, RLReport, ZDataset;

type

  { TLandscapeReportForm }

  TLandscapeReportForm = class(TForm)
    CommentRLMemo: TRLMemo;
    HeaderBand1: TRLBand;
    RLBandSummary: TRLBand;
    RLDBText3: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabelHeader1: TRLLabel;
    RLLabelHeader2: TRLLabel;
    RLLabelHeader3: TRLLabel;
    SummaryDataSource: TDataSource;
    DetailDataSource: TDataSource;
    HeaderDataSource: TDataSource;
    RLDBText4: TRLDBText;
    ViewDataSource: TDataSource;
    FooterBand: TRLBand;
    RLBandHeader: TRLBand;
    RLDBText2: TRLDBText;
    RLDBText1: TRLDBText;
    RLImageLogo: TRLImage;
    RLMemoUserDetails: TRLMemo;
    RLReportLandscape: TRLReport;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfoReportTitle: TRLSystemInfo;
    DetailBand1: TRLBand;
    SubDetail1: TRLSubDetail;
    HeaderQuery: TZReadOnlyQuery;
    DetailQuery: TZReadOnlyQuery;
    ViewQuery: TZReadOnlyQuery;
    SummaryQuery: TZReadOnlyQuery;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure HeaderBand1AfterPrint(Sender: TObject);
    procedure HeaderDataSourceDataChange(Sender: TObject; Field: TField);
    procedure RLReportLandscapeAfterPrint(Sender: TObject);
    procedure RLReportLandscapeBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLReportLandscapePageStarting(Sender: TObject);
  private
    DataHasChanged: Boolean;
  public

  end;

var
  LandscapeReportForm: TLandscapeReportForm;

implementation

{$R *.lfm}

uses VARINIT, MainDataModule;

{ TLandscapeReportForm }

procedure TLandscapeReportForm.RLReportLandscapeBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  Screen.Cursor := crSQLWait;
  with RLReportLandscape do
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

procedure TLandscapeReportForm.RLReportLandscapePageStarting(Sender: TObject);
begin
  if (RLReportLandscape.PageNumber > 1) and (not DataHasChanged) then //print header only from page 2 and when not on a new site
    HeaderBand1.Print;
end;

procedure TLandscapeReportForm.RLReportLandscapeAfterPrint(Sender: TObject);
begin
  DetailQuery.Close;
  HeaderQuery.Close;
  ViewQuery.Close;
end;

procedure TLandscapeReportForm.FormCreate(Sender: TObject);
var
  c: Word;
begin
  for c := 0 to ComponentCount - 1 do
  if Components[c] is TControl then
  begin
    with (Components[c] as TControl).Font do
    begin
      Name := ReportFont.Name;
      Color := ReportFont.Color;
      if Components[c] is TRLLabel then
      begin
        Style := [fsBold];
        case Components[c].Tag of
          0: Size := ReportFont.Size;
          1: Size := ReportFont.Size + 2;
          2: Size := ReportFont.Size - 2;
        end;
      end
      else
      if Components[c] is TRLSystemInfo then
      begin
        Size := ReportFont.Size + Components[c].Tag;
        if Components[c].Tag = 2 then
          Style := [fsBold,fsItalic];
      end
      else
      begin
        Size := ReportFont.Size;
        Style := ReportFont.Style;
      end;
    end;
    if (Components[c] is TRLBand) and (TRLBand(Components[c]).GroupIndex >= 3)
      then TRLBand(Components[c]).Color := ColumnHeaderBandColor;
  end;
  HeaderBand1.Color := ColumnHeaderBandColor;
  //set Header labels and DBText
  RLDBText3.Left := RLLabel1.Left + RLLabel1.Width + 2;
  RLLabel2.Left := RLDBText3.Left + RLDBText3.Width + 2;
  RLDBText5.Left := RLLabel2.Left + RLLabel2.Width + 2;
  RLLabel3.Left := RLDBText5.Left + RLDBText5.Width + 2;
  RLDBText6.Left := RLLabel3.Left + RLLabel3.Width + 2;
  RLDBText6.Width := HeaderBand1.Width - RLDBText6.Left - 2;
  //set connections
  ViewQuery.Connection := DataModuleMain.ZConnectionDB;
  HeaderQuery.Connection := DataModuleMain.ZConnectionDB;
  DetailQuery.Connection := DataModuleMain.ZConnectionDB;
  SummaryQuery.Connection := DataModuleMain.ZConnectionDB;
end;

procedure TLandscapeReportForm.HeaderBand1AfterPrint(Sender: TObject);
begin
  DataHasChanged := False;
end;

procedure TLandscapeReportForm.HeaderDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  DataHasChanged := True; //to prepare next page so that header is not printed twice
end;

procedure TLandscapeReportForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

end.

