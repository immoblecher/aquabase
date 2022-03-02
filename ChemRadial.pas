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
unit ChemRadial;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ZDataset, ExtCtrls,
  TAGraph, TARadialSeries, PrintersDlgs, Menus, Buttons, XMLPropStorage, Printers,
  TAPrint;

type

  { TChemRadialForm }

  TChemRadialForm = class(TForm)
    MenuItem5: TMenuItem;
    MenuItemFrame: TMenuItem;
    MenuItemPanel: TMenuItem;
    MenuItemBackground: TMenuItem;
    MenuItemReport: TMenuItem;
    PolarChart: TChart;
    aChemRadialQuery: TZQuery;
    PrintDialog1: TPrintDialog;
    SaveDialog: TSaveDialog;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem6: TMenuItem;
    QuickFormat1: TMenuItem;
    N3D1: TMenuItem;
    Legend1: TMenuItem;
    Grid1: TMenuItem;
    XMLPropStorage: TXMLPropStorage;
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItemBackgroundClick(Sender: TObject);
    procedure MenuItemFrameClick(Sender: TObject);
    procedure MenuItemPanelClick(Sender: TObject);
    procedure MenuItemReportClick(Sender: TObject);
    procedure PolarChartClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OpenQuery;
    procedure DrawRadialChart;
    procedure ChartSettings;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure Monochrome1Click(Sender: TObject);
    procedure Copyasbitmap1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Saveas1Click(Sender: TObject);
    procedure Grid1Click(Sender: TObject);
    procedure N3D1Click(Sender: TObject);
    procedure Legend1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    StartDate, StartTime, EndDate, EndTime : String;
    CurrentSiteOnly: Boolean;
    ViewName: ShortString;
  end;

var
  ChemRadialForm: TChemRadialForm;

implementation

uses varinit, Chrtproc, MainDataModule;

{$R *.lfm}

procedure  TChemRadialForm.ChartSettings;
begin
  with PolarChart do
  begin
    Frame.Visible:= false;
    Title.Text.Clear;
    Title.Text.Add('Radial Diagram: meq/l');
  end;
end;

procedure TChemRadialForm.OpenQuery;
begin
  with aChemRadialQuery do
  begin
    SQL.Add('SELECT * FROM ' + ViewName + ' f');
    SQL.Add('JOIN basicinf b ON (f.SITE_ID_NR = b.SITE_ID_NR)');
    SQL.Add('JOIN chem_000 c0 ON (f.SITE_ID_NR = c0.SITE_ID_NR)');
    if DataModuleMain.ZConnectionDB.Tag = 1 then
      SQL.Add('AND c0.DATE_SAMPL || c0.TIME_SAMPL >= ' + QuotedStr(StartDate + StartTime)
        + ' AND c0.DATE_SAMPL || c0.TIME_SAMPL <= ' + QuotedStr(EndDate + EndTime))
    else
      SQL.Add('AND CONCAT(c0.DATE_SAMPL, c0.TIME_SAMPL) >= ' + QuotedStr(StartDate + StartTime)
        + ' AND CONCAT(c0.DATE_SAMPL, c0.TIME_SAMPL) <= ' + QuotedStr(EndDate + EndTime));
    SQL.Add('JOIN chem_001 c1 ON (c0.CHM_REF_NR = c1.CHM_REF_NR)');
    if CurrentSiteOnly then
      SQL.Add('WHERE f.SITE_ID_NR = ' + QuotedStr(CurrentSite));
    SQL.Add('ORDER BY f.SITE_ID_NR, c0.DATE_SAMPL, c0.TIME_SAMPL');
    Open;
  end;
end;

procedure TChemRadialForm.DrawRadialChart;
var
  Ca,Mg,Na,K,SO4,HCO3,Cl : real;
  RadialSeries: TPolarSeries;
begin
   aChemRadialQuery.First;
   with aChemRadialQuery,PolarChart do
   begin
     while not EOF do
     begin
       RadialSeries := TPolarSeries.Create(PolarChart);
       with RadialSeries do
       begin
         CloseCircle := True;
         LinePen.Color := Random(255*255*255);
         FindChemMekwValues(aChemRadialQuery,'Ca',Ca);
         AddY(Ca,'Ca ',LinePen.Color);
         FindChemMekwValues(aChemRadialQuery,'Mg',Mg);
         AddY(Mg,'Mg ',LinePen.Color);
         FindChemMekwValues(aChemRadialQuery,'Na',Na);
         FindChemMekwValues(aChemRadialQuery,'K',K);
         AddY(Na + K,'Na + K ',LinePen.Color);
         FindChemMekwValues(aChemRadialQuery,'Cl',Cl);
         AddY(Cl,'Cl ',LinePen.Color);
         FindChemMekwValues(aChemRadialQuery,'SO4',SO4);
         AddY(SO4,'SO4 ',LinePen.Color);
         FindChemMekwValues(aChemRadialQuery,'HCO3',HCO3);
         AddY(HCO3,'HCO3 + CO3 ',LinePen.Color);
         AddSeries(RadialSeries);
         Next;
       end;
     end;
   end;
end;

procedure TChemRadialForm.PolarChartClick(Sender: TObject);
begin
  ActiveControl := PolarChart;
  PolarChart.BorderStyle := bsSingle;
end;

procedure TChemRadialForm.MenuItemReportClick(Sender: TObject);
begin
  PolarChart.SaveToFile(TJPEGImage, GetTempDir + DirectorySeparator + 'chemchart' + IntToStr(MenuItemReport.Tag) + '.jpg');
end;

procedure TChemRadialForm.MenuItemBackgroundClick(Sender: TObject);
begin
  MenuItemBackground.Checked := not MenuItemBackground.Checked;
  if MenuItemBackground.Checked then
    PolarChart.BackColor := clWhite
  else
    PolarChart.BackColor := clBtnFace;
end;

procedure TChemRadialForm.MenuItem5Click(Sender: TObject);
const
  MARGIN = 10;
var
  r: TRect;
  d: Integer;
begin
  if PrintDialog1.Execute then
  begin
    Printer.BeginDoc;
    try
      r := Rect(0, 0, Printer.PageWidth, Printer.PageHeight div 2);
      d := r.Right - r.Left;
      r.Left += d div MARGIN;
      r.Right -= d div MARGIN;
      d := r.Bottom - r.Top;
      r.Top += d div MARGIN;
      r.Bottom -= d div MARGIN;
      PolarChart.Draw(TPrinterDrawer.Create(Printer), r);
    finally
      Printer.EndDoc;
    end;
  end;
end;

procedure TChemRadialForm.MenuItemFrameClick(Sender: TObject);
begin
  MenuItemFrame.Checked := not MenuItemFrame.Checked;
  if MenuItemFrame.Checked then
    PolarChart.Frame.Visible := True
  else
    PolarChart.Frame.Visible := False;
end;

procedure TChemRadialForm.MenuItemPanelClick(Sender: TObject);
begin
  MenuItemPanel.Checked := not MenuItemPanel.Checked;
  if MenuItemPanel.Checked then
    PolarChart.Color := clWhite
  else
    PolarChart.Color := clBtnFace;
end;

procedure TChemRadialForm.CloseBtnClick(Sender: TObject);
begin
   Close;
end;

procedure TChemRadialForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
end;

procedure TChemRadialForm.FormShow(Sender: TObject);
begin
  OpenQuery;
  ChartSettings;
  DrawRadialChart;
end;

procedure TChemRadialForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if MenuItemReport.Visible then //cleanup temp files and reset tags
  begin
    if FileExists(GetTempDir + DirectorySeparator + 'chemchart' + IntToStr(MenuItemReport.Tag) + '.jpg') then
      DeleteFile(GetTempDir + DirectorySeparator + 'chemchart' + IntToStr(MenuItemReport.Tag) + '.jpg');
    if Cht1Tag = MenuItemReport.Tag then
      Cht1Tag := -1;
    if Cht2Tag = MenuItemReport.Tag then
      Cht2Tag := -1;
  end;
  CloseAction := caFree;
end;

procedure TChemRadialForm.Monochrome1Click(Sender: TObject);
begin
  Monochrome(PolarChart);
end;

procedure TChemRadialForm.Copyasbitmap1Click(Sender: TObject);
begin
  PolarChart.CopyToClipboardBitmap;
end;

procedure TChemRadialForm.PopupMenu1Popup(Sender: TObject);
begin
  MenuItemBackground.Checked := PolarChart.BackColor = clWhite;
  MenuItemPanel.Checked := PolarChart.Color = clWhite;
  MenuItemFrame.Checked := PolarChart.Frame.Visible;
end;

procedure TChemRadialForm.Saveas1Click(Sender: TObject);
begin
   if SaveDialog.Execute then
    PolarChart.SaveToFile(TJPEGImage, SaveDialog.Filename);
end;

procedure TChemRadialForm.Grid1Click(Sender: TObject);
begin
   Grid1.Checked := not Grid1.Checked;
   PolarChart.BottomAxis.Grid.Visible := Grid1.Checked;
   PolarChart.BottomAxis.Grid.Visible := Grid1.Checked;
end;

procedure TChemRadialForm.N3D1Click(Sender: TObject);
begin
   N3D1.Checked := not N3D1.Checked;
   if N3D1.Checked then PolarChart.Depth := 20;
end;

procedure TChemRadialForm.Legend1Click(Sender: TObject);
begin
   Legend1.Checked := not Legend1.Checked;
   PolarChart.Legend.Visible := Legend1.Checked;
end;

end.
