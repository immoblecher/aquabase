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
unit Repprev;

{$mode objfpc}{$H+}

interface

uses
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLType,
  DBCtrls, ExtCtrls, StdCtrls, Buttons, ComCtrls, XMLPropStorage, PrintersDlgs,
  RLPreview, RLPreviewForm, RLHTMLFilter, RLPDFFilter, RLXLSFilter,
  RLRichFilter, RLSaveDialog, RLFilters, RLPrintDialog, Types;
type

  { TRepPrevForm }

  TRepPrevForm = class(TForm)
    BitBtnPrint: TBitBtn;
    PrintDialog1: TPrintDialog;
    RLHTMLFilter1: TRLHTMLFilter;
    RLPDFFilter1: TRLPDFFilter;
    RLPreview1: TRLPreview;
    Panel1: TPanel;
    RLRichFilter1: TRLRichFilter;
    RLXLSFilter1: TRLXLSFilter;
    SpeedButtonZoomOut: TSpeedButton;
    SpeedButtonZoomIn: TSpeedButton;
    SpeedButtonFirst: TSpeedButton;
    SpeedButtonPrevious: TSpeedButton;
    SpeedButtonNext: TSpeedButton;
    SpeedButtonEnd: TSpeedButton;
    CloseBtn: TBitBtn;
    Panel2: TPanel;
    LabelPages: TLabel;
    SpeedButtonSave: TSpeedButton;
    SpeedButtonZoomToFit: TSpeedButton;
    StaticText1: TStaticText;
    XMLPropStorage1: TXMLPropStorage;
    procedure BitBtnPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButtonZoomToFitClick(Sender: TObject);
    procedure SpeedButtonZoomInClick(Sender: TObject);
    procedure SpeedButtonZoomOutClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure SpeedButtonNextClick(Sender: TObject);
    procedure SpeedButtonPreviousClick(Sender: TObject);
    procedure SpeedButtonFirstClick(Sender: TObject);
    procedure SpeedButtonEndClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButtonSaveClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RepPrevForm: TRepPrevForm;

implementation

{$R *.lfm}

uses VARINIT, maindatamodule;

procedure TRepPrevForm.SpeedButtonZoomInClick(Sender: TObject);
begin
  RLPreview1.ZoomFactor := RLPreview1.ZoomFactor + 10;
  RLPreview1.ZoomIn();
end;

procedure TRepPrevForm.SpeedButtonZoomOutClick(Sender: TObject);
begin
  RLPreview1.ZoomFactor := RLPreview1.ZoomFactor-10;
  RLPreview1.ZoomOut();
end;

procedure TRepPrevForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TRepPrevForm.SpeedButtonNextClick(Sender: TObject);
begin
  RLPreview1.NextPage;
  LabelPages.Caption := 'Page ' + IntToStr(RLPreview1.PageNumber) + ' of ' + IntToStr(RLPreview1.Pages.LastPageNumber);
end;

procedure TRepPrevForm.SpeedButtonPreviousClick(Sender: TObject);
begin
  RLPreview1.PriorPage;
  LabelPages.Caption := 'Page ' + IntToStr(RLPreview1.PageNumber) + ' of ' + IntToStr(RLPreview1.Pages.LastPageNumber);
end;

procedure TRepPrevForm.SpeedButtonFirstClick(Sender: TObject);
begin
  RLPreview1.FirstPage;
  LabelPages.Caption := 'Page ' + IntToStr(RLPreview1.PageNumber) + ' of ' + IntToStr(RLPreview1.Pages.LastPageNumber);
end;

procedure TRepPrevForm.SpeedButtonEndClick(Sender: TObject);
begin
  RLPreview1.LastPage;
  LabelPages.Caption := 'Page ' + IntToStr(RLPreview1.PageNumber) + ' of ' + IntToStr(RLPreview1.Pages.LastPageNumber);
end;

procedure TRepPrevForm.FormShow(Sender: TObject);
begin
  LabelPages.Caption := 'Page ' + IntToStr(RLPreview1.PageIndex + 1) + ' of ' + IntToStr(RLPreview1.PageNumber);
  RLPreview1.ZoomFullWidth;
end;

procedure TRepPrevForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_END:   SpeedButtonEnd.Click;
    VK_HOME:  SpeedButtonFirst.Click;
    VK_PRIOR: SpeedButtonPrevious.Click;
    VK_NEXT:  SpeedButtonNext.Click;
  end; {of case} 
end;

procedure TRepPrevForm.SpeedButtonSaveClick(Sender: TObject);
var
  SaveDlg: TRLSaveDialog;
  SaveFilter: TRLCustomSaveFilter;
begin
  SaveDlg := TRLSaveDialog.CreateNew(Nil);
  SaveDlg.FromPage := RLPreview1.Pages.FirstPageNumber;
  SaveDlg.ToPage := RLPreview1.Pages.LastPageNumber;
  if SaveDlg.Execute then
  begin
    if SelectedFilter <> Nil then
      SaveFilter := TRLCustomSaveFilter(SelectedFilter)
    else
      SaveFilter := SaveFilterByFileName(SaveDlg.FileName);
    if SaveFilter <> Nil then
    begin
      SaveFilter.FileName := SaveDlg.FileName;
      SaveFilter.FilterPages(RLPreview1.Pages, SaveDlg.FromPage, SaveDlg.ToPage, '', 0);
    end
    else
      RLPreview1.Pages.SaveToFile(SaveDlg.FileName);
  end;
end;

procedure TRepPrevForm.CloseBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TRepPrevForm.SpeedButtonZoomToFitClick(Sender: TObject);
begin
  RLPreview1.ZoomFullPage;
end;

procedure TRepPrevForm.BitBtnPrintClick(Sender: TObject);
{$IFDEF WINDOWS}
var
  PrintDialog: TRLPrintDialog;
{$ENDIF}
begin
  {$IFDEF WINDOWS}
  PrintDialog := TRLPrintDialog.CreateNew(Nil);
  with PrintDialog do
  begin
    FromPage := RLPreview1.Pages.FirstPageNumber;
    ToPage := RLPreview1.Pages.LastPageNumber;
    if PrintDialog.Execute then
    begin
      FilterPages(RLPreview1.Pages, Nil, PrintDialog.FromPage, PrintDialog.ToPage, PrintDialog.PageRanges, 0);
    end;
  end;
  {$ENDIF}
  {$IFDEF UNIX}
  with PrintDialog1 do
  begin
    FromPage := RLPreview1.Pages.FirstPageNumber;
    ToPage := RLPreview1.Pages.LastPageNumber;
    if Execute then
    begin
      FilterPages(RLPreview1.Pages, Nil, FromPage, ToPage, '', 0);
    end;
  end;
  {$ENDIF}
end;

procedure TRepPrevForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, False);
end;

end.
