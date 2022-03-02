{ Copyright (C) 2020 Immo Blecher, immo@blecher.co.za

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
unit lithprofile;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, TAMultiSeries,
  TADbSource, Forms, Controls, Graphics, Dialogs, XMLPropStorage, ZDataset, db,
  TAChartUtils, TALegend, TASources, PrintersDlgs, GraphUtil, Menus, math,
  Printers, TAPrint, OSPrinters, TADrawerSVG, TATools, TADrawUtils
  {$IFDEF WINDOWS}
  , TADrawerWMF
  {$ENDIF}
  ;

type

  { TLithProfileForm }

  TLithProfileForm = class(TForm)
    Chart1: TChart;
    ChartToolset1: TChartToolset;
    ChartToolset1PanDragTool1: TPanDragTool;
    ChartToolset1ZoomMouseWheelTool1: TZoomMouseWheelTool;
    HorizGrid1: TMenuItem;
    Legend1: TMenuItem;
    ListChartSource1: TListChartSource;
    LithQuery: TZReadOnlyQuery;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItemAlignment: TMenuItem;
    MenuItemBigger: TMenuItem;
    MenuItemBotCentre: TMenuItem;
    MenuItemBotLeft: TMenuItem;
    MenuItemBotRight: TMenuItem;
    MenuItemFonts: TMenuItem;
    MenuItemLegendEnabled: TMenuItem;
    MenuItemSideBar: TMenuItem;
    MenuItemSmaller: TMenuItem;
    MenuItemTopLeft: TMenuItem;
    MenuItemTopRight: TMenuItem;
    PopupMenu1: TPopupMenu;
    PrintDialog1: TPrintDialog;
    QuickFormat1: TMenuItem;
    SaveDialog: TSaveDialog;
    VertGrid1: TMenuItem;
    XMLPropStorage1: TXMLPropStorage;
    LookupQuery: TZReadOnlyQuery;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HorizGrid1Click(Sender: TObject);
    procedure LithQueryAfterOpen(DataSet: TDataSet);
    procedure LithQueryBeforeOpen(DataSet: TDataSet);
    procedure LookupQueryBeforeOpen(DataSet: TDataSet);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItemBiggerClick(Sender: TObject);
    procedure MenuItemBotCentreClick(Sender: TObject);
    procedure MenuItemBotLeftClick(Sender: TObject);
    procedure MenuItemBotRightClick(Sender: TObject);
    procedure MenuItemLegendEnabledClick(Sender: TObject);
    procedure MenuItemSideBarClick(Sender: TObject);
    procedure MenuItemSmallerClick(Sender: TObject);
    procedure MenuItemTopLeftClick(Sender: TObject);
    procedure MenuItemTopRightClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure VertGrid1Click(Sender: TObject);
  private

  public
    UseDefaultCol, MarksVisible: Boolean;
    PenWidth, MarksFontSize: Byte;
    MarksBgColour: TColor;

  end;

var
  LithProfileForm: TLithProfileForm;

implementation

{$R *.lfm}

uses MainDataModule;

{ TLithProfileForm }

procedure TLithProfileForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TLithProfileForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
end;

procedure TLithProfileForm.FormShow(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  //remove all design series
  Chart1.ClearSeries;
  LithQuery.Open;
  Screen.Cursor := crDefault;
end;

procedure TLithProfileForm.HorizGrid1Click(Sender: TObject);
begin
  HorizGrid1.Checked := not HorizGrid1.Checked;
  Chart1.LeftAxis.Grid.Visible := HorizGrid1.Checked;
end;

procedure TLithProfileForm.LithQueryAfterOpen(DataSet: TDataSet);
var
  LithColour, PrevLithColour, PrimCol, SecoCol, LithCode: ShortString;
  LithDescr, PrimDescr, SecoDescr, PrevSite: ShortString;
  LithSeries: TLineSeries;
  H, L, S: Word;
  XField: TField;
begin
  LookupQuery.Open;
  //initialise variables
  PrevLithColour := '';
  PrevSite := '';
  if Chart1.BottomAxis.Title.Caption = 'Longitude' then
    XField := Dataset.FieldByName('Longitude')
  else
    XField := Dataset.FieldByName('Latitude');
  //run through the data and create the series
  with Dataset do
  begin
    if RecordCount > 0 then //make sure there is actually something to plot
    while not EOF do
    begin
      if (not FieldByName('PRIM_COLOR').IsNull) and (FieldByName('PRIM_COLOR').AsString >= 'A') then
        PrimCol := FieldByName('PRIM_COLOR').AsString
      else PrimCol := '';
      if (not FieldByName('SECO_COLOR').IsNull) and (FieldByName('SECO_COLOR').AsString >= 'A') then
        SecoCol := FieldByName('SECO_COLOR').AsString
      else SecoCol := '';
      if not FieldByName('LITH_CODE').IsNull then
        LithCode := FieldByName('LITH_CODE').AsString
      else LithCode := 'N.S.'; //make it "not sampled" if there is no code
      case Chart1.Tag of
        0: LithColour := StringReplace(LithCode, '.', '_', [rfReplaceAll]);
        1: LithColour := PrimCol + StringReplace(LithCode, '.', '_', [rfReplaceAll]);
        2: LithColour := SecoCol + StringReplace(LithCode, '.', '_', [rfReplaceAll]);
        3: LithColour := PrimCol + SecoCol + StringReplace(LithCode, '.', '_', [rfReplaceAll]);
      end;
      //if colour changes and the colour/lith combination is not yet in the list (no series created yet) then create a new series
      if (LithColour <> PrevLithColour) and (Chart1.FindComponent(LithColour) = NIL) then
      begin
        LithSeries := TLineSeries.Create(Chart1);
        //name the series according to colour and lith code
        LithSeries.Name := LithColour;
        //get series title from lookups
        with LookupQuery do
        begin
          Filter := 'USED_FOR = ' + QuotedStr('LITHCODE');
          Filtered := True;
          if Locate('SEARCH', LithCode, [])then //not really necessary but better to check
            LithDescr := FieldByName('DESCRIBE').AsString;
          Filter := 'USED_FOR = ' + QuotedStr('PRIMCOLR');
          if (PrimCol <> '') and Locate('SEARCH', PrimCol, []) then
            PrimDescr := FieldByName('DESCRIBE').AsString + ' '
          else
            PrimDescr := '';
          Filter := 'USED_FOR = ' + QuotedStr('SECOCOLR');
          if (SecoCol <> '') and Locate('SEARCH', SecoCol, []) then
            SecoDescr := FieldByName('DESCRIBE').AsString + ' '
          else
            SecoDescr := '';
          Filtered := False;
        end;
        //set series title
        case Chart1.Tag of
          0: LithSeries.Title := LithDescr;
          1: if PrimDescr <> '' then
               LithSeries.Title := PrimDescr + LowerCase(LithDescr)
             else
               LithSeries.Title := LithDescr;
          2: if SecoDescr <> '' then
               LithSeries.Title := SecoDescr + LowerCase(LithDescr)
             else
               LithSeries.Title := LithDescr;
          3: if SecoDescr <> '' then
               LithSeries.Title := SecoDescr + Lowercase(PrimDescr) + LowerCase(LithDescr)
             else
             if PrimDescr <> '' then
               LithSeries.Title := PrimDescr + LowerCase(LithDescr)
             else
               LithSeries.Title := LithDescr;
        end;
        //set lineseries settings
        with LithSeries do
        begin
          LinePen.EndCap := pecFlat;
          LinePen.Width := PenWidth;
          Marks.Visible := MarksVisible;
          Marks.Distance := 10;
          Marks.Style := smsLabel;
          Marks.LabelBrush.Color := clSilver;
          Marks.LabelFont.Size := MarksFontSize;
          Marks.LinkPen.Style := psClear;
        end;
        //set series colour from primary colour
        if (PrimCol > '') and (not UseDefaultCol) then
        begin
          LookupQuery.Filter := 'USED_FOR = ' + QuotedStr('PRIMCOLR');
          LookupQuery.Filtered := True;
          if LookupQuery.Locate('SEARCH', PrimCol, []) then
            if LookupQuery.FieldByName('DEFAULT_CO').Value >= 0 then //use colour
              LithSeries.SeriesColor := TColor(LookupQuery.FieldByName('DEFAULT_CO').Value)
            else LithSeries.SeriesColor := clSilver; //if there is no color in lookups
          if (FieldByName('SECO_COLOR').Value = 'D') then //make darker
          begin
            ColorRGBToHLS(LithSeries.SeriesColor, H, L, S);
            LithSeries.SeriesColor := ColorHLSToRGB(H, 64, S);
          end
          else if (FieldByName('SECO_COLOR').Value = 'L') then //make lighter
          begin
            ColorRGBToHLS(LithSeries.SeriesColor, H, L, S);
            LithSeries.SeriesColor := ColorHLSToRGB(H, 192, S);
          end;
        end
        else //try to get secondary colour, otherwise try to set default colour
        begin
          if (SecoCol > '') and (not UseDefaultCol) then
          begin
            LookupQuery.Filter := 'USED_FOR = ' + QuotedStr('SECOCOLR');
            LookupQuery.Filtered := True;
            if LookupQuery.Locate('SEARCH', SecoCol, []) then
              if LookupQuery.FieldByName('DEFAULT_CO').Value >= 0 then //use colour
                LithSeries.SeriesColor := TColor(LookupQuery.FieldByName('DEFAULT_CO').Value)
              else LithSeries.SeriesColor := clSilver; //if there is no color in lookups
          end
          else //use default colour
          begin
            LookupQuery.Filter := 'USED_FOR = ' + QuotedStr('LITHCODE');
            LookupQuery.Filtered := True;
            LookupQuery.Locate('SEARCH', FieldByName('LITH_CODE').Value, []);
            if LookupQuery.FieldByName('DEFAULT_CO').Value > 0 then //use default colour
              LithSeries.SeriesColor := TColor(LookupQuery.FieldByName('DEFAULT_CO').Value)
            else LithSeries.SeriesColor := clSilver; //if there is no default color in lookups
          end;
        end;
        Chart1.AddSeries(LithSeries);
        PrevLithColour := LithColour;
        if BOF then
          ListChartSource1.Add(XField.Value, 0, FieldByName('NR_ON_MAP').AsString)
        else
        if FieldByName('SITE_ID_NR').AsString <> PrevSite then //add it to the site string
          ListChartSource1.Add(XField.Value, 0, FieldByName('NR_ON_MAP').AsString);
        PrevSite := FieldByName('SITE_ID_NR').AsString;
      end
      else //use existing series
        LithSeries := Chart1.FindComponent(LithColour) as TLineSeries;
      //add data to series
      with LithSeries do
      try
        if not BOF then //make sure the sites are not connected
          AddXY(XField.Value, NAN, FieldByName('LITH_CODE').Value);
        //then add from and to and add label the bottom of each section
        AddXY(XField.Value, FieldByName('FROM_ALT').Value, FieldByName('LITH_CODE').Value);
        AddXY(XField.Value, FieldByName('TO_ALT').Value);
      except on E: Exception do
        MessageDlg('Altitudes for lithology ' + FieldByName('LITH_CODE').Value + ' at ' + FieldByName('NR_ON_MAP').AsString + ' could not be calculated due to errors in the data. Please make sure you have "Altitude", "Depth to Top" and "Depth to Bottom" values for this site.', mtError, [mbOK], 0);
      end;
      Next;
    end
    else
      Chart1.Title.Text.Add('No sites in the View seem to have lithology data! Chart not possible.');
    Close;
  end;
  LookupQuery.Close;
  with Chart1 do
  begin
    if SeriesCount > 50 then
      Legend.ColumnCount := 3
    else
    if SeriesCount > 25 then
      Legend.ColumnCount := 2;
    Margins.Left := 2 * PenWidth;
    Margins.Right := 2 * PenWidth;
    Margins.Top := 5;
    Margins.Bottom := 5;
  end;
end;

procedure TLithProfileForm.LithQueryBeforeOpen(DataSet: TDataSet);
begin
  LithQuery.Connection := DataModuleMain.ZConnectionDB;
end;

procedure TLithProfileForm.LookupQueryBeforeOpen(DataSet: TDataSet);
begin
  LookupQuery.Connection := DataModuleMain.ZConnectionLanguage;
end;

procedure TLithProfileForm.MenuItem2Click(Sender: TObject);
const
  MARGIN = 10;
var
  r: TRect;
  d: Integer;
begin
  if not PrintDialog1.Execute then exit;
  Printer.BeginDoc;
  try
    r := Rect(0, 0, Printer.PageWidth, Printer.PageHeight div 2);
    d := r.Right - r.Left;
    r.Left += d div MARGIN;
    r.Right -= d div MARGIN;
    d := r.Bottom - r.Top;
    r.Top += d div MARGIN;
    r.Bottom -= d div MARGIN;
    Chart1.Draw(TPrinterDrawer.Create(Printer), r);
  finally
    Printer.EndDoc;
  end;
end;

procedure TLithProfileForm.MenuItem3Click(Sender: TObject);
var
  fs: TFileStream;
  id: IChartDrawer;
begin
  if SaveDialog.Execute then
  if LowerCase(ExtractFileExt(SaveDialog.FileName)) = '.jpg' then
    Chart1.SaveToFile(TJPEGImage, SaveDialog.Filename)
  else
  if LowerCase(ExtractFileExt(SaveDialog.Filename)) = '.bmp' then
    Chart1.SaveToBitmapFile(SaveDialog.FileName)
  {$IFDEF WINDOWS}
  else
  if LowerCase(ExtractFileExt(SaveDialog.Filename)) = '.wmf' then
    Chart1.SaveToWMF(SaveDialog.FileName)
  {$ENDIF}
  else
  if LowerCase(ExtractFileExt(SaveDialog.Filename)) = '.png' then
    Chart1.SaveToFile(TPortableNetworkGraphic, SaveDialog.FileName)
  else
  if LowerCase(ExtractFileExt(SaveDialog.Filename)) = '.svg' then
  begin
    fs := TFileStream.Create(SaveDialog.FileName, fmCreate);
    try
      id := TSVGDrawer.Create(fs, true);
      with Chart1 do
        Draw(id, Rect(0, 0, Width, Height));
    finally
      fs.Free;
    end;
  end;
end;

procedure TLithProfileForm.MenuItem5Click(Sender: TObject);
begin
  Chart1.CopyToClipboardBitmap;
end;

procedure TLithProfileForm.MenuItemBiggerClick(Sender: TObject);
var
  s: Word;
begin
  with Chart1 do
  begin
    for s := 0 to SeriesCount - 1 do
      TLineSeries(Series[s]).Marks.LabelFont.Size := TLineSeries(Series[s]).Marks.LabelFont.Size + 1;
    LeftAxis.Marks.LabelFont.Size := LeftAxis.Marks.LabelFont.Size + 1;
    LeftAxis.Title.LabelFont.Size := LeftAxis.Title.LabelFont.Size + 1;
    BottomAxis.Marks.LabelFont.Size := BottomAxis.Marks.LabelFont.Size + 1;
    BottomAxis.Title.LabelFont.Size := BottomAxis.Title.LabelFont.Size + 1;
    AxisList[2].Marks.LabelFont.Size := AxisList[2].Marks.LabelFont.Size + 1;
    Legend.Font.Size := Legend.Font.Size + 1;
  end;
end;

procedure TLithProfileForm.MenuItemBotCentreClick(Sender: TObject);
begin
  MenuItemBotCentre.Checked := not MenuItemBotCentre.Checked;
  Chart1.Legend.Alignment := laBottomCenter;
end;

procedure TLithProfileForm.MenuItemBotLeftClick(Sender: TObject);
begin
  MenuItemBotLeft.Checked := not MenuItemBotLeft.Checked;
  Chart1.Legend.Alignment := laBottomLeft;
end;

procedure TLithProfileForm.MenuItemBotRightClick(Sender: TObject);
begin
  MenuItemBotRight.Checked := not MenuItemBotRight.Checked;
  Chart1.Legend.Alignment := laBottomRight;
end;

procedure TLithProfileForm.MenuItemLegendEnabledClick(Sender: TObject);
begin
  MenuItemLegendEnabled.Checked := not MenuItemLegendEnabled.Checked;
  Chart1.Legend.Visible := MenuItemLegendEnabled.Checked;
end;

procedure TLithProfileForm.MenuItemSideBarClick(Sender: TObject);
begin
  MenuItemSideBar.Checked := not MenuItemSideBar.Checked;
  Chart1.Legend.UseSidebar := MenuItemSideBar.Checked;
end;

procedure TLithProfileForm.MenuItemSmallerClick(Sender: TObject);
  var
  s: Word;
begin
  with Chart1 do
  begin
    for s := 0 to SeriesCount - 1 do
      TLineSeries(Series[s]).Marks.LabelFont.Size := TLineSeries(Series[s]).Marks.LabelFont.Size - 1;
    LeftAxis.Marks.LabelFont.Size := LeftAxis.Marks.LabelFont.Size - 1;
    LeftAxis.Title.LabelFont.Size := LeftAxis.Title.LabelFont.Size - 1;
    BottomAxis.Marks.LabelFont.Size := BottomAxis.Marks.LabelFont.Size - 1;
    BottomAxis.Title.LabelFont.Size := BottomAxis.Title.LabelFont.Size - 1;
    AxisList[2].Marks.LabelFont.Size := AxisList[2].Marks.LabelFont.Size + 1;
    if Legend.Visible then
      Legend.Font.Size := Legend.Font.Size - 1;
  end;
end;

procedure TLithProfileForm.MenuItemTopLeftClick(Sender: TObject);
begin
  MenuItemTopLeft.Checked := not MenuItemTopLeft.Checked;
  Chart1.Legend.Alignment := laTopLeft;
end;

procedure TLithProfileForm.MenuItemTopRightClick(Sender: TObject);
begin
  MenuItemTopRight.Checked := not MenuItemTopRight.Checked;
  Chart1.Legend.Alignment := laTopRight;
end;

procedure TLithProfileForm.PopupMenu1Popup(Sender: TObject);
begin
  HorizGrid1.Checked := Chart1.LeftAxis.Grid.Visible;
  VertGrid1.Checked := Chart1.BottomAxis.Grid.Visible;
  Legend1.Checked := Chart1.Legend.Visible;
  MenuItemSideBar.Checked := Chart1.Legend.UseSideBar;
  MenuItemTopRight.Checked := Chart1.Legend.Alignment = laTopRight;
  MenuItemTopLeft.Checked := Chart1.Legend.Alignment = laTopLeft;
  MenuItemBotRight.Checked := Chart1.Legend.Alignment = laBottomRight;
  MenuItemBotLeft.Checked := Chart1.Legend.Alignment = laBottomLeft;
  MenuItemBotCentre.Checked := Chart1.Legend.Alignment = laBottomCenter;
end;

procedure TLithProfileForm.VertGrid1Click(Sender: TObject);
begin
  VertGrid1.Checked := not VertGrid1.Checked;
  Chart1.BottomAxis.Grid.Visible := VertGrid1.Checked;
end;

end.

