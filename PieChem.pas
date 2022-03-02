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
unit PieChem;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Buttons, ExtCtrls,
  Menus, XMLPropStorage, ZDataset, TAGraph, TASeries, PrintersDlgs, Printers,
  TAPrint, db;

type

  { TPieForm }

  TPieForm = class(TForm)
    ChemPieQuery: TZQuery;
    MenuItem1: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem3D: TMenuItem;
    MenuItemFrame: TMenuItem;
    MenuItemPanel: TMenuItem;
    MenuItemBackground: TMenuItem;
    MenuItemPrint: TMenuItem;
    MenuItemReport: TMenuItem;
    PieChart: TChart;
    PieSeries: TPieSeries;
    PrintDialog1: TPrintDialog;
    SaveDialog: TSaveDialog;
    PopupMenu1: TPopupMenu;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    XMLPropStorage: TXMLPropStorage;
    //ChartPreviewer: TChartPreviewer;
    procedure ChemPieQueryBeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure DrawPieChart;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure CloseBtnClick(Sender: TObject);
    procedure Copyasbitmap1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem3DClick(Sender: TObject);
    procedure MenuItemBackgroundClick(Sender: TObject);
    procedure MenuItemFrameClick(Sender: TObject);
    procedure MenuItemPanelClick(Sender: TObject);
    procedure MenuItemPrintClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Saveas1Click(Sender: TObject);
  private
    { Private declarations }
  public
    PieAggregate: Byte;
    ViewName : ShortString;
    CurrentSiteOnly: Boolean;
    ParamList: TStringList;
    ParamStr, StartDate, StartTime, EndDate, EndTime : String;
  end;

var
  PieForm: TPieForm;

implementation

uses varinit, MainDataModule;

{$R *.lfm}

procedure TPieForm.DrawPieChart;
var
  ParamArray: array of Real;
  CountArray: array of Integer;
  p: Integer;
begin
  //initialise arrays
  SetLength(ParamArray, ParamList.Count);
  SetLength(CountArray, ParamList.Count);
  //set the arrays' values to defaults
  for p := 0 to ParamList.Count - 1 do
  begin
    if PieAggregate = 4 then //for calculation of min
      ParamArray[p] := 999999999
    else
      ParamArray[p] := - 1;
    CountArray[p] := 0;
  end;
  with ChemPieQuery do
  begin
    First;
    while not EOF do
    begin
      case PieAggregate of
        0: begin //average: add them all up first and divide by counts later
             for p := 0 to ParamList.Count - 1 do
               if FieldByName(ParamList.Strings[p]).Value > - 1 then
               begin
                 Inc(CountArray[p]);
                 if CountArray[p] = 1 then ParamArray[p] := 0; //for the first entry start with 0
                 ParamArray[p] := ParamArray[p] + FieldByName(ParamList.Strings[p]).Value;
               end;
           end;
        1: begin //first
             for p := 0 to ParamList.Count - 1 do
               if (FieldByName(ParamList.Strings[p]).Value > - 1) and (ParamArray[p] = - 1) then
                 ParamArray[p] := FieldByName(ParamList.Strings[p]).Value;
           end;
        2: begin //last
             for p := 0 to ParamList.Count - 1 do
               if FieldByName(ParamList.Strings[p]).Value > - 1 then
                 ParamArray[p] := FieldByName(ParamList.Strings[p]).Value;
           end;
        3: begin //max
             for p := 0 to ParamList.Count - 1 do
               if FieldByName(ParamList.Strings[p]).Value > ParamArray[p] then
                 ParamArray[p] := FieldByName(ParamList.Strings[p]).Value;
           end;
        4: begin //min
             for p := 0 to ParamList.Count - 1 do
               if (FieldByName(ParamList.Strings[p]).Value > - 1) and (FieldByName(ParamList.Strings[p]).Value < ParamArray[p]) then
                 ParamArray[p] := FieldByName(ParamList.Strings[p]).Value;
           end;
      end; //of case
      Next;
    end;
    if PieAggregate = 0 then //calculate averages
      for p := 0 to ParamList.Count - 1 do
        ParamArray[p] := ParamArray[p]/CountArray[p];
  end;
  for p := 0 to ParamList.Count - 1 do
    PieSeries.AddY(ParamArray[p], ParamList.Strings[p] , Random(256*256*256));
end;

procedure TPieForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
end;

procedure TPieForm.ChemPieQueryBeforeOpen(DataSet: TDataSet);
begin
  with ChemPieQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT v.SITE_ID_NR, b.NR_ON_MAP, b.REGION_BB, b.ALT_NO_1, b.ALT_NO_2, c0.CHM_REF_NR, c0.SAMPLE_NR, c0.DATE_SAMPL, c0.TIME_SAMPL, ' + ParamStr);
    SQL.Add('FROM ' + ViewName + ' v');
    SQL.Add('JOIN basicinf b ON (v.SITE_ID_NR = b.SITE_ID_NR)');
    SQL.Add('JOIN chem_000 c0 ON (b.SITE_ID_NR = c0.SITE_ID_NR)');
    if DataModuleMain.ZConnectionDB.Tag = 1 then //sqlite
      SQL.Add('AND c0.DATE_SAMPL || TIME_SAMPL >= ' + QuotedStr(StartDate+StartTime) + ' AND c0.DATE_SAMPL || TIME_SAMPL <= ' + QuotedStr(EndDate+EndTime))
    else
      SQL.Add('AND CONCAT(c0.DATE_SAMPL, TIME_SAMPL) >= ' + QuotedStr(StartDate+StartTime) + ' AND CONCAT(c0.DATE_SAMPL, TIME_SAMPL) <= ' + QuotedStr(EndDate+EndTime));
    SQL.Add('LEFT JOIN chem_001 ON (c0.CHM_REF_NR = chem_001.CHM_REF_NR)');
    SQL.Add('LEFT JOIN chem_002 ON (c0.CHM_REF_NR = chem_002.CHM_REF_NR)');
    SQL.Add('LEFT JOIN chem_003 ON (c0.CHM_REF_NR = chem_003.CHM_REF_NR)');
    SQL.Add('LEFT JOIN chem_004 ON (c0.CHM_REF_NR = chem_004.CHM_REF_NR)');
    SQL.Add('LEFT JOIN chem_005 ON (c0.CHM_REF_NR = chem_005.CHM_REF_NR)');
    if CurrentSiteOnly then
      SQL.Add('WHERE b.SITE_ID_NR = ' + QuotedStr(CurrentSite));
  end;
end;

procedure TPieForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
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

procedure TPieForm.CloseBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TPieForm.Copyasbitmap1Click(Sender: TObject);
begin
  PieChart.CopyToClipboardBitmap;
end;

procedure TPieForm.FormShow(Sender: TObject);
begin
  ChemPieQuery.Open;
  DrawPieChart;
end;

procedure TPieForm.MenuItem3DClick(Sender: TObject);
begin
  MenuItem3D.Checked := not MenuItem3D.Checked;
   if MenuItem3D.Checked then PieChart.Depth := 20;
end;

procedure TPieForm.MenuItemBackgroundClick(Sender: TObject);
begin
  MenuItemBackground.Checked := not MenuItemBackground.Checked;
  if MenuItemBackground.Checked then
    PieChart.BackColor := clWhite
  else
    PieChart.BackColor := clBtnFace;
end;

procedure TPieForm.MenuItemFrameClick(Sender: TObject);
begin
  MenuItemFrame.Checked := not MenuItemFrame.Checked;
  if MenuItemFrame.Checked then
    PieChart.Frame.Visible := True
  else
    PieChart.Frame.Visible := False;
end;

procedure TPieForm.MenuItemPanelClick(Sender: TObject);
begin
  MenuItemPanel.Checked := not MenuItemPanel.Checked;
  if MenuItemPanel.Checked then
    PieChart.Color := clWhite
  else
    PieChart.Color := clBtnFace;
end;

procedure TPieForm.MenuItemPrintClick(Sender: TObject);
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
      PieChart.Draw(TPrinterDrawer.Create(Printer), r);
    finally
      Printer.EndDoc;
    end;
  end;
end;

procedure TPieForm.PopupMenu1Popup(Sender: TObject);
begin
  MenuItemBackground.Checked := PieChart.BackColor = clWhite;
  MenuItemPanel.Checked := PieChart.Color = clWhite;
  MenuItemFrame.Checked := PieChart.Frame.Visible;
end;

procedure TPieForm.Saveas1Click(Sender: TObject);
begin
  if SaveDialog.Execute then
    PieChart.SaveToBitmapFile(SaveDialog.Filename);
end;

end.
