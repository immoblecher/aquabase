{ Copyright (C) 2022 Immo Blecher, immo@blecher.co.za

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
unit constrctlogform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, TACustomSeries,
  TAChartExtentLink, TATransformations, TATextElements, ZDataset, Forms,
  GraphUtil, Controls, Graphics, Dialogs, ButtonPanel, ExtCtrls, XMLPropStorage,
  DbCtrls, math, TALegend, TAChartUtils, TASources, TATools, FPImage,
  FPCanvas, StrUtils, IntfGraphics, LCLType, LCLProc, LCLIntf, Menus;

type

  { TLogForm }

  TLogForm = class(TForm)
    BottomAutoScaleTransform: TAutoScaleAxisTransform;
    BottomSeries: TLineSeries;
    ButtonPanel1: TButtonPanel;
    BottomAxisTransformations: TChartAxisTransformations;
    CapSeries: TLineSeries;
    CasingLabels: TLineSeries;
    ChartToolset1: TChartToolset;
    ChartToolset1DataPointClickTool1: TDataPointClickTool;
    ChartToolset1PanDragTool1: TPanDragTool;
    ChartToolset1ZoomMouseWheelTool1: TZoomMouseWheelTool;
    DTHChart: TChart;
    HoleLabels: TLineSeries;
    ListChartSourceTopBot: TListChartSource;
    ListChartSourceDepth: TListChartSource;
    LithLabels: TBarSeries;
    LogChart: TChart;
    LogLabelLines: TLineSeries;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItemTopExtent: TMenuItem;
    MenuItemBotExtent: TMenuItem;
    MenuItemFullExtent: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItemFontSmaller: TMenuItem;
    MenuItemFontLarger: TMenuItem;
    MenuItemBotDown: TMenuItem;
    MenuItemTopDown: TMenuItem;
    MenuItemTopUp: TMenuItem;
    MenuItemTopAxis: TMenuItem;
    MenuItemBotUp: TMenuItem;
    MenuItemBotAxis: TMenuItem;
    MenuItemCopyClip: TMenuItem;
    MenuItemJpeg: TMenuItem;
    MenuItemBitmap: TMenuItem;
    MenuItemSave: TMenuItem;
    PopupMenu1: TPopupMenu;
    SaveDialog1: TSaveDialog;
    Splitter1: TSplitter;
    StrikeLabels: TLineSeries;
    TopAxisTransformations: TChartAxisTransformations;
    TopAutoScaleTransform: TAutoScaleAxisTransform;
    ChartExtentLink1: TChartExtentLink;
    GetDataQuery: TZReadOnlyQuery;
    TopSeries: TLineSeries;
    WaterlevelLine: TLineSeries;
    XMLPropStorage: TXMLPropStorage;
    LookupQuery: TZReadOnlyQuery;
    procedure CancelButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure DTHChartDblClick(Sender: TObject);
    procedure DTHChartMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    procedure LogChartDblClick(Sender: TObject);
    procedure LogChartMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItemTopExtentClick(Sender: TObject);
    procedure MenuItemBotExtentClick(Sender: TObject);
    procedure MenuItemFullExtentClick(Sender: TObject);
    procedure MenuItemFontSmallerClick(Sender: TObject);
    procedure MenuItemFontLargerClick(Sender: TObject);
    procedure MenuItemBotDownClick(Sender: TObject);
    procedure MenuItemBotUpClick(Sender: TObject);
    procedure MenuItemBitmapClick(Sender: TObject);
    procedure MenuItemCopyClipClick(Sender: TObject);
    procedure MenuItemJpegClick(Sender: TObject);
    procedure MenuItemTopDownClick(Sender: TObject);
    procedure MenuItemTopUpClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure CreateLithologies;
    procedure CreateStrikes;
    procedure CreateHole;
    procedure CreateCasings;
    procedure CreateFillMaterial;
    procedure CreatePiezometers;
    procedure CreateWaterLevel;
    procedure CreateDepthDependentChart;
  private
    { private declarations }
    LithBmp: Array[0..199] of TBitmap;
    FillBmp: Array[0..29] of TBitmap;
    LithXExtent, DepthMax: Real;
    LegendEntries: TStringList; //keep record of legend entries to avoid duplicates
    cht: TChart;
  public
    { public declarations }
    ShowLithology, ShowHole, ShowCasing, ShowPiezometer, ShowFill, ShowWaterlevel: Boolean;
    ShowWater, AutoInterval, ShowCap, UsePrimFeat, ShowMemo, ShowPiezLabels: Boolean;
    CumulativeStrikes, ShowStrikes, PiezLabelsAbove, UseDepthLineStyles: Boolean;
    DefaultColour, OverrideThickn, POverrideThickn, StaggerLabels, LabelUnderLine: Boolean;
    UseDefaultFillColour, ShowLegendFrame, Prep2Pages: Boolean;
    Depth1TableName, Depth2TableName, TopX, TopY, BotX, BotY, WLDate: ShortString;
    CasingCopperColour, CasingSteelColour, CasingPVCColour, PiezomColour, HoleColour,
    LithLabelColour, WLColour, CapColour, WaterColor: TColor;
    LithLabelFontSize, Thickness, PThickness, WLThickness, WhichWL, WLLabelPos, TopLineStyle, BottomLineStyle: Byte;
    DepthAxisInterval, VeryLight, Lighter, Darker, FillTransparency, LithWidth: Word;
    SetMaxTop, SetMaxBot, SpaceUnderHole, TopExt: Double;
    ResFactor, MaxLblWidth: Word;
    TopPenetrOpt, BotPenetrOpt: Byte;
    TheTopFactor, TheBotFactor: Double;
    TheLabelFont: TFont;
    DepthFromDateTime, DepthToDateTime: TDateTime;
  end;

var
  LogForm: TLogForm;

implementation

uses VARINIT, MainDataModule, logreportsettings, strdatetime;

{$R *.lfm}

{ TLogForm }

procedure TLogForm.CreateLithologies;
var
  LabelLengthConstr, NrThinLithBot, PrevNrLabelLinesLeft, PrevNrLabelLinesRight: Byte;
  LithDescrList: TStringList;
  StaggerPos, LithLabelPosLeft, PrevLabelPosLeft, VertexPosLeft: Real;
  LithLabelPosRight, PrevLabelPosRight, VertexPosRight: Real;
  BMPw, BMPh, m, n: Word;
  H, S, L, PixH, PixS, PixL: Byte;
  LithSeries: Array[0..199] of TAreaSeries;
  NewColor: TColor;
  CurColor: TFPColor;
begin
  Screen.Cursor := crSQLWait;
  PrevNrLabelLinesLeft := 0;
  PrevNrLabelLinesRight := 0;
  PrevLabelPosLeft := 0;
  PrevLabelPosRight := 0;
  VertexPosLeft := 0;
  VertexPosRight := 0;
  LithDescrList := TStringList.Create;
  if StaggerLabels then //labels on both sides of lithology column
  begin
    LogChart.BottomAxis.Range.Min := -750;
    LogChart.BottomAxis.Range.Max := 750;
  end;
  LogChart.Legend.Frame.Visible := ShowLegendFrame;
  LogLabelLines.Active := True;
  LithLabels.Active := True;
  LogChart.AxisList[2].Title.Caption := 'Hole Construction and Lithology - '
    + DataModuleMain.BasicinfQueryNR_ON_MAP.AsString + ' (' + CurrentSite + ')';
  if DepthMax = 0 then //get the depth from the lithology
  begin
    GetDataQuery.SQL.Clear;
    GetDataQuery.SQL.Add('SELECT MAX(DEPTH_BOT) FROM geology_ WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
    GetDataQuery.Open;
    if (not GetDataQuery.Fields[0].IsNull) and (GetDataQuery.Fields[0].Value > 0) then
      DepthMax := GetDataQuery.Fields[0].Value * LengthFactor //get depth of the lithlogy
    else DepthMax := 0;
    GetDataQuery.Close;
  end;
  GetDataQuery.SQL.Clear;
  GetDataQuery.SQL.Add('SELECT SITE_ID_NR, DEPTH_TOP, DEPTH_BOT, LITH_CODE, UNIT_NAME, PRIM_COLOR, SECO_COLOR, TEXTURE, PRIM_FEATR, SECO_FEATR, FEATR_ATTR, NOTE_PAD FROM geology_ ');
  GetDataQuery.SQL.Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
  GetDataQuery.SQL.Add('ORDER BY DEPTH_TOP');
  GetDataQuery.Open;
  if GetDataQuery.RecordCount > 0 then
  begin
    //determine Nr of layers in bottom 10% of log
    NrThinLithBot := 0;
    while not GetDataQuery.EOF do
    begin
      if GetDataQuery.FieldByName('DEPTH_TOP').Value > (DepthMax - DepthMax/10) then
        if GetDataQuery.FieldByName('DEPTH_BOT').Value - GetDataQuery.FieldByName('DEPTH_TOP').Value < 5 then
          Inc(NrThinLithBot);
      GetDataQuery.Next;
    end;
    //create the area series
    GetDataQuery.First;
    for m := 0 to GetDataQuery.RecordCount - 1 do
    begin
      LithSeries[m] := TAreaSeries.Create(LogChart);
      with LithSeries[m] do
      begin
        ZPosition := m + 1; //Lithologies are right at the bottom, everything else abbove it, but above the LithLabels, which are horiz. bars
        ZeroLevel := GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor;
        UseZeroLevel := True;
        Title := GetDataQuery.FieldByName('LITH_CODE').Value;
        //set colour from primary colour
        if (GetDataQuery.FieldByName('PRIM_COLOR').Value > '') and (DefaultColour = False) then
        begin
          LookupQuery.Filter := 'USED_FOR = ' + QuotedStr('PRIMCOLR');
          LookupQuery.Filtered := True;
          if LookupQuery.Locate('SEARCH', GetDataQuery.FieldByName('PRIM_COLOR').Value, []) then
            if LookupQuery.FieldByName('DEFAULT_CO').Value >= 0 then //use colour
              SeriesColor := TColor(LookupQuery.FieldByName('DEFAULT_CO').Value)
            else SeriesColor := clGray; //if there is no color in lookups
          if (GetDataQuery.FieldByName('SECO_COLOR').Value = 'D') then //make darker
          begin
            ColorToHLS(SeriesColor, H, L, S);
            SeriesColor := HLSToColor(H, 64, S);
          end
          else if (GetDataQuery.FieldByName('SECO_COLOR').Value = 'L') then //make lighter
          begin
            ColorToHLS(SeriesColor, H, L, S);
            SeriesColor := HLSToColor(H, 192, S);
          end;
        end
        else //try to get secondary colour, otherwise try to set default colour
        begin
          if (GetDataQuery.FieldByName('SECO_COLOR').Value > '') and (DefaultColour = False) then
          begin
            LookupQuery.Filter := 'USED_FOR = ' + QuotedStr('SECOCOLR');
            LookupQuery.Filtered := True;
            if LookupQuery.Locate('SEARCH', GetDataQuery.FieldByName('SECO_COLOR').Value, []) then
              if LookupQuery.FieldByName('DEFAULT_CO').Value >= 0 then //use colour
                SeriesColor := TColor(LookupQuery.FieldByName('DEFAULT_CO').Value)
              else SeriesColor := clGray; //if there is no color in lookups
          end
          else //use default colour
          begin
            LookupQuery.Filter := 'USED_FOR = ' + QuotedStr('LITHCODE');
            LookupQuery.Filtered := True;
            LookupQuery.Locate('SEARCH', GetDataQuery.FieldByName('LITH_CODE').Value, []);
            if LookupQuery.FieldByName('DEFAULT_CO').Value >= 0 then //use default colour
              SeriesColor := TColor(LookupQuery.FieldByName('DEFAULT_CO').Value)
            else SeriesColor := clGray; //if there is no default color in lookups
          end;
        end;
        //Adapt SeriesColor with features: very light, lighter, darker
        if UsePrimFeat then
        begin
          if (GetDataQuery.FieldByName('PRIM_FEATR').Value = 'WT') or
             (GetDataQuery.FieldByName('PRIM_FEATR').Value = 'LS') or
             (GetDataQuery.FieldByName('PRIM_FEATR').Value = 'SF') or
             (GetDataQuery.FieldByName('PRIM_FEATR').Value = 'UC') then //Color very light
             begin
               ColorToHLS(SeriesColor, H, L, S);
               SeriesColor := HLSToColor(H, VeryLight, S);
             end;
          if (GetDataQuery.FieldByName('PRIM_FEATR').Value = 'BR') or
             (GetDataQuery.FieldByName('PRIM_FEATR').Value = 'FC') or
             (GetDataQuery.FieldByName('PRIM_FEATR').Value = 'LT') then //Color lighter
             begin
               ColorToHLS(SeriesColor, H, L, S);
               SeriesColor := HLSToColor(H, Lighter, S);
             end;
          if (GetDataQuery.FieldByName('PRIM_FEATR').Value = 'SD') or
             (GetDataQuery.FieldByName('PRIM_FEATR').Value = 'CS') or
             (GetDataQuery.FieldByName('PRIM_FEATR').Value = 'DK') or
             (GetDataQuery.FieldByName('PRIM_FEATR').Value = 'FR') or
             (GetDataQuery.FieldByName('PRIM_FEATR').Value = 'HD') then //Color darker
              begin
                ColorToHLS(SeriesColor, H, L, S);
                SeriesColor := HLSToColor(H, Darker, S);
              end;
        end;
        AddXY(-LithXExtent, GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor);
        AddXY(-LithXExtent, GetDataQuery.FieldByName('DEPTH_BOT').Value * LengthFactor);
        AddXY(LithXExtent, GetDataQuery.FieldByName('DEPTH_BOT').Value * LengthFactor);
        AddXY(LithXExtent, GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor);
        Marks.Visible := False;
        Legend.Visible := False;
        AreaLinesPen.Style := psClear;
        LookupQuery.Filter := 'USED_FOR = ' + QuotedStr('LITHCODE');
        LookupQuery.Filtered := True;
        LookupQuery.Locate('SEARCH', GetDataQuery.FieldByName('LITH_CODE').Value, []);
        if not LookupQuery.FieldByName('LOGS_BMP').IsNull then
        begin
          //set AreaBrush from the LOGS_BMP
          if FileExists(ProgramDir + DirectorySeparator + 'Bitmaps' + DirectorySeparator + LookupQuery.FieldByName('LOGS_BMP').AsString) then
          begin
            LithBmp[m] := TBitmap.Create;
            LithBmp[m].LoadFromFile(ProgramDir + DirectorySeparator + 'Bitmaps' + DirectorySeparator + LookupQuery.FieldByName('LOGS_BMP').AsString);
            for BMPh := 0 to LithBmp[m].Height - 1 do
            begin
              for BMPw := 0 to LithBmp[m].Width - 1 do
                if FPColorToTColor(LithBmp[m].Canvas.Colors[BMPw, BMPh]) <> $FFFFFF then
                begin
                  CurColor := LithBmp[m].Canvas.Colors[BMPw, BMPh];
                  if FPColorToTColor(CurColor) = clBlack then
                  begin
                    NewColor := SeriesColor;
                  end
                  else
                  begin
                    //get luminance of CurColor = PixL
                    ColorToHLS(FPColorToTColor(CurColor), PixH, PixL, PixS);
                    //get HLS of SeriesColor
                    ColorToHLS(SeriesColor, H, L, S);
                    //set the new pixel color to seriescolor with pixel luminance unless it is black
                    if SeriesColor = clBlack then
                      NewColor := SeriesColor
                    else
                      NewColor := HLSToColor(H, PixL, S);
                  end;
                  LithBmp[m].Canvas.Colors[BMPw, BMPh] := TColorToFPColor(NewColor);
                end;
            end;
            AreaBrush.Style := bsImage;
            AreaBrush.Bitmap := LithBmp[m];
          end
          else
            AreaBrush.Style := bsSolid;
        end
        else
        //set AreaBrush from the adjective
        if (not LookupQuery.FieldByName('ADJECTIVE').IsNull) then
        case LookupQuery.FieldByName('ADJECTIVE').AsInteger of
          0: AreaBrush.Style := bsClear;
          1: AreaBrush.Style := bsCross;
          2: AreaBrush.Style := bsDiagCross;
          3: AreaBrush.Style := bsFDiagonal;
          4: AreaBrush.Style := bsHorizontal;
          5: AreaBrush.Style := bsSolid;
          6: AreaBrush.Style := bsVertical;
          7: AreaBrush.Style := bsBDiagonal;
          else AreaBrush.Style := bsClear;
        end
        else AreaBrush.Style := bsClear;
        LogChart.AddSeries(LithSeries[m]);
      end;
      //Add lithology description to LithLabels series - start with unit name and lithology
      if LookupQuery.Locate('SEARCH', GetDataQuery.FieldByName('LITH_CODE').Value, []) then
      begin
        if GetDataQuery.FieldByName('UNIT_NAME').Value > '' then
          LithDescrList.Add(AnsiProperCase(GetDataQuery.FieldByName('UNIT_NAME').Value, StdWordDelims) + ' - ' + LookupQuery.FieldByName('DESCRIBE').AsString + ': ')
        else
          LithDescrList.Add(LookupQuery.FieldByName('DESCRIBE').AsString + ': ')
      end
      else
      begin
        if GetDataQuery.FieldByName('UNIT_NAME').Value > '' then
          LithDescrList.Add(AnsiProperCase(GetDataQuery.FieldByName('UNIT_NAME').Value, StdWordDelims) + ': ')
      end;
      //Check if there is any descriptive data after the lithology and add
      if GetDataQuery.FieldByName('SECO_COLOR').Value > '' then
      begin
        LookupQuery.Filter := 'USED_FOR = ' + QuotedStr('SECOCOLR');
        LookupQuery.Locate('SEARCH', GetDataQuery.FieldByName('SECO_COLOR').Value, []);
        LithDescrList[0] := LithDescrList[0] + LookupQuery.FieldByName('DESCRIBE').Value + ' ';
        if GetDataQuery.FieldByName('PRIM_COLOR').IsNull then
          LithDescrList[0] := LithDescrList[0] + '; ';
      end;
      if GetDataQuery.FieldByName('PRIM_COLOR').Value > '' then
      begin
        LookupQuery.Filter := 'USED_FOR = ' + QuotedStr('PRIMCOLR');
        LookupQuery.Locate('SEARCH', GetDataQuery.FieldByName('PRIM_COLOR').Value, []);
        LithDescrList[0] := LithDescrList[0] + LookupQuery.FieldByName('DESCRIBE').Value + '; ';
      end;
      LithDescrList.Add(''); //add empty line 2
      if GetDataQuery.FieldByName('TEXTURE').Value > '' then
      begin
        LookupQuery.Filter := 'USED_FOR = ' + QuotedStr('TEXTURE');
        LookupQuery.Locate('SEARCH', GetDataQuery.FieldByName('TEXTURE').Value, []);
        LithDescrList[1] := LithDescrList [1] + LookupQuery.FieldByName('DESCRIBE').Value + '; ';
      end;
      if GetDataQuery.FieldByName('FEATR_ATTR').Value > '' then
      begin
        LookupQuery.Filter := 'USED_FOR = ' + QuotedStr('ATTRIBUT');
        LookupQuery.Locate('SEARCH', GetDataQuery.FieldByName('FEATR_ATTR').Value, []);
        LithDescrList[1] := LithDescrList[1] + LookupQuery.FieldByName('DESCRIBE').Value + ' ';
      end;
      if GetDataQuery.FieldByName('SECO_FEATR').Value > '' then
      begin
        LookupQuery.Filter := 'USED_FOR = ' + QuotedStr('FEATURE');
        LookupQuery.Locate('SEARCH', GetDataQuery.FieldByName('SECO_FEATR').Value, []);
        if GetDataQuery.FieldByName('PRIM_FEATR').IsNull then
          LithDescrList[1] := LithDescrList[1] + LookupQuery.FieldByName('DESCRIBE').Value + '; '
        else
          LithDescrList[1] := LithDescrList[1] + LookupQuery.FieldByName('DESCRIBE').Value + ', ';
      end;
      if GetDataQuery.FieldByName('PRIM_FEATR').Value > '' then
      begin
        LookupQuery.Filter := 'USED_FOR = ' + QuotedStr('FEATURE');
        LookupQuery.Locate('SEARCH', GetDataQuery.FieldByName('PRIM_FEATR').Value, []);
        LithDescrList[1] := LithDescrList[1] + LookupQuery.FieldByName('DESCRIBE').Value + '; ';
      end;
      if ShowMemo and (not GetDataQuery.FieldByName('NOTE_PAD').IsNull) then
        LithDescrList.Add(GetDataQuery.FieldByName('NOTE_PAD').AsString);
      //tidy-up the lithology description and add it to LithLabels series
      for n := 0 to LithDescrList.Count - 1 do
      begin
        if Copy(LithDescrList[n], Length(LithDescrList[n]) - 1, 2) = '; ' then
          LithDescrList[n] := Copy(LithDescrList[n], 1, Length(LithDescrList[n]) - 2);
      end;
      StaggerPos := LithXExtent + 50;
      //determine width of lithology labels according to font size
      if StaggerLabels then //labels on both sides of lithology column --> less space
      begin
        LabelLengthConstr := Round(1/LithLabelFontSize * (MaxLblWidth/2));
        if m and 1 <> 1 then //check if m is even or odd
          StaggerPos := -StaggerPos;
      end
      else
        LabelLengthConstr := Round(1/LithLabelFontSize * MaxLblWidth);
      //shorten description to a minimum of lines
      if LithDescrList.Count = 3 then
      begin
        if Length(LithDescrList[0]) + Length(LithDescrList[1]) < LabelLengthConstr then //Reformat mark into 1 line
        begin
          if LithDescrList[1] > '' then
            LithDescrList[0] := LithDescrList[0] + '; ' + LithDescrList[1];
          LithDescrList.Delete(1);
          if Pos(' ;', LithDescrList[0]) > -1 then
            LithDescrList[0] := StringReplace(LithDescrList[0], ' ;', '', [rfReplaceAll]);
          if Length(LithDescrList[0]) + Length(LithDescrList[1]) < LabelLengthConstr then //Reformat mark into 1 line
          begin
            if LithDescrList[1] > '' then
              LithDescrList[0] := LithDescrList[0] + '; ' + LithDescrList[1];
            LithDescrList.Delete(1);
            if Pos(' ;', LithDescrList[0]) > -1 then
              LithDescrList[0] := StringReplace(LithDescrList[0], ' ;', '', [rfReplaceAll]);
          end;
        end;
      end
      else if LithDescrList.Count = 2 then
      begin
        if Length(LithDescrList[0]) + Length(LithDescrList[1]) < LabelLengthConstr then //Reformat mark into 1 line
        begin
          if LithDescrList[1] > '' then
            LithDescrList[0] := LithDescrList[0] + '; ' + LithDescrList[1];
          LithDescrList.Delete(1);
          if Pos(' ;', LithDescrList[0]) > -1 then
            LithDescrList[0] := StringReplace(LithDescrList[0], ' ;', '', [rfReplaceAll]);
        end;
      end;
      //clear the colon if there is no other info
      if Copy(LithDescrList[0], Length(LithDescrList[0]) - 1, 2) = ': ' then
        LithDescrList[0] := Copy(LithDescrList[0], 1, Pos(':', LithDescrList[0]) - 1);
      if LabelUnderLine then //draw lines to the right (and left) of lithology column and set label position
      begin
        LogLabelLines.LinePen.Style := psSolid;
        //add the line for this depth to top to LogLabelLines series
        if StaggerPos < 0 then //left of lithology
        begin
          LogLabelLines.AddXY(-LithXExtent -10, GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor);
          VertexPosLeft := PrevLabelPosLeft + PrevNrLabelLinesLeft/150*DepthMax;
          if VertexPosLeft < GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor then //make sure the line does not go up
            VertexPosLeft := GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor;
          LogLabelLines.AddXY(StaggerPos, VertexPosLeft);
          LogLabelLines.AddXY(LogChart.BottomAxis.Range.Min + 10, VertexPosLeft);
          LithLabelPosLeft := VertexPosLeft + LithLabelFontSize * LithDescrList.Count/500 * DepthMax * LengthFactor;
          LogLabelLines.AddXY(LogChart.BottomAxis.Range.Min + 10, NAN);
        end
        else //right of lithology
        begin
          LogLabelLines.AddXY(LithXExtent + 10, GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor);
          VertexPosRight := PrevLabelPosRight + PrevNrLabelLinesRight/150*DepthMax;
          if VertexPosRight < GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor then //make sure the line does not go up
              VertexPosRight := GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor;
          LogLabelLines.AddXY(StaggerPos, VertexPosRight);
          LogLabelLines.AddXY(LogChart.BottomAxis.Range.Max - 10, VertexPosRight);
          LithLabelPosRight := VertexPosRight + LithLabelFontSize * LithDescrList.Count/500 * DepthMax * LengthFactor;
          LogLabelLines.AddXY(LogChart.BottomAxis.Range.Max - 10, NAN);
        end;
      end
      else //no lines and place lith description in middle between top and bottom
      begin
        LithLabelPosLeft := GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor
            + ((GetDataQuery.FieldByName('DEPTH_BOT').Value * LengthFactor - GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor)/2);
        LithLabelPosRight := GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor
            + ((GetDataQuery.FieldByName('DEPTH_BOT').Value * LengthFactor - GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor)/2);
      end;
      //draw invisible horizontal bar and label it with lithology description
      if StaggerPos < 0 then //left of lithology
      begin
        if LithDescrList.Count = 3 then
          LithLabels.AddXY(LithLabelPosLeft, StaggerPos,
            Format('%S'#13#10'%S'#13#10'%S', [LithDescrList[0], LithDescrList[1], LithDescrList[2]]))
        else if LithDescrList.Count = 2 then
          LithLabels.AddXY(LithLabelPosLeft, StaggerPos,
            Format('%S'#13#10'%S', [LithDescrList[0], LithDescrList[1]]))
        else
          LithLabels.AddXY(LithLabelPosLeft, StaggerPos, LithDescrList[0]);
      end
      else //right of lithology
      begin
        if LithDescrList.Count = 3 then
          LithLabels.AddXY(LithLabelPosRight, StaggerPos,
            Format('%S'#13#10'%S'#13#10'%S', [LithDescrList[0], LithDescrList[1], LithDescrList[2]]))
        else if LithDescrList.Count = 2 then
          LithLabels.AddXY(LithLabelPosRight, StaggerPos,
            Format('%S'#13#10'%S', [LithDescrList[0], LithDescrList[1]]))
        else
          LithLabels.AddXY(LithLabelPosRight, StaggerPos, LithDescrList[0]);
      end;
      PrevNrLabelLinesLeft := LithDescrList.Count * 3;
      PrevNrLabelLinesRight := LithDescrList.Count * 3;
      PrevLabelPosLeft := LithLabelPosLeft;
      PrevLabelPosRight := LithLabelPosRight;
      LithDescrList.Clear;
      GetDataQuery.Next;
    end;
  end
  else
  begin
    Screen.Cursor := crDefault;
    MessageDlg('No lithology data available! Lithology will not be shown.', mtWarning, [mbOK], 0);
  end;
  GetDataQuery.Close;
  LithLabels.Marks.LabelFont := TheLabelFont;
  LithLabels.Marks.LabelFont.Size := LithLabelFontSize;
  LithLabels.Marks.LabelFont.Color:= LithLabelColour;
  LithDescrList.Free;
  Screen.Cursor := crDefault;
end;

procedure TLogForm.CreateStrikes;
var
  Yield, PrevYield: Real;
begin
  PrevYield := 0;
  with GetDataQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT SITE_ID_NR, DEPTH_TOP, YIELD FROM aquifer_ ');
    SQL.Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
    SQL.Add('AND YIELD > 0');
    SQL.Add('ORDER BY DEPTH_TOP');
    Open;
    if RecordCount > 0 then
    begin
      StrikeLabels.Active := True;
      StrikeLabels.Marks.LabelFont := TheLabelFont;
      LegendEntries.Add('Water Strike');
      while not EOF do //left side of hole
      begin
        Yield := FieldByName('YIELD').AsFloat * VolumeFactor * TimeFactor;
        if CumulativeStrikes then //add them as in aquifer_ table
          StrikeLabels.AddXY(0, FieldByName('DEPTH_TOP').Value * LengthFactor, FloatToStrF(Yield, ffFixed, 15, 2) + ' ' + DisUnit, clGreen)
        else //work out individual yields
        begin
          StrikeLabels.AddXY(0, FieldByName('DEPTH_TOP').Value * LengthFactor, FloatToStrF(Yield - PrevYield, ffFixed, 15, 2) + ' ' + DisUnit, clGreen);
          PrevYield := Yield;
        end;
        Next;
      end;
    end;
    Close;
  end;
end;

procedure TLogForm.CreateHole;
var
  HoleAreaSeries: TAreaSeries;
  HoleLineSeries: TLineSeries;
  PrevHoleDiam: Real;
begin
  Screen.Cursor := crSQLWait;
  PrevHoleDiam := 0;
  HoleLabels.Active := True;
  HoleLabels.Title := 'Hole diameter [' + DiamUnit + ']';
  LegendEntries.Add(HoleLabels.Title);
  HoleAreaSeries := TAreaSeries.Create(LogChart);
  with HoleAreaSeries do
  begin
    ZPosition := 200; //to make sure it is above the lithologies
    ZeroLevel := 0; //hole can only begin at 0.00
    UseZeroLevel := True;
    Title := 'Hole area';
    SeriesColor := clWhite;
    Marks.Visible := False;
    AreaLinesPen.Style := psClear;
    AreaContourPen.Style := psClear;
    Legend.Visible := False;
  end;
  HoleLineSeries := TLineSeries.Create(LogChart);
  with HoleLineSeries do
  begin
    Title := 'Hole';
    LegendEntries.Add(Title);
    LinePen.Color := HoleColour;
    Marks.LabelFont := TheLabelFont;
    ZPosition := 299; //to be above hole area, under casing, but above fill material
  end;
  GetDataQuery.SQL.Clear;
  GetDataQuery.SQL.Add('SELECT SITE_ID_NR, DEPTH_TOP, DEPTH_BOT, DIAMETER FROM holediam ');
  GetDataQuery.SQL.Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
  GetDataQuery.SQL.Add('AND DIAMETER > 0');
  GetDataQuery.SQL.Add('ORDER BY DEPTH_TOP');
  GetDataQuery.Open;
  while not GetDataQuery.EOF do //left side of hole
  begin
    HoleAreaSeries.AddXY(-GetDataQuery.FieldByName('DIAMETER').Value/2, GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor);
    HoleAreaSeries.AddXY(-GetDataQuery.FieldByName('DIAMETER').Value/2, GetDataQuery.FieldByName('DEPTH_BOT').Value * LengthFactor);
    HoleLineSeries.AddXY(-GetDataQuery.FieldByName('DIAMETER').Value/2, GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor);
    HoleLineSeries.AddXY(-GetDataQuery.FieldByName('DIAMETER').Value/2, GetDataQuery.FieldByName('DEPTH_BOT').Value * LengthFactor);
    if GetDataQuery.FieldByName('DIAMETER').Value <> PrevHoleDiam then
    begin
      if DiamFactor < 1 then
        HoleLabels.AddXY(-GetDataQuery.FieldByName('DIAMETER').Value/2, GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor
          + ((GetDataQuery.FieldByName('DEPTH_BOT').Value * LengthFactor - GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor)/2), FloatToStrF(GetDataQuery.FieldByName('DIAMETER').AsFloat * DiamFactor, ffFixed, 15, 2))
      else
        HoleLabels.AddXY(-GetDataQuery.FieldByName('DIAMETER').Value/2, GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor
          + ((GetDataQuery.FieldByName('DEPTH_BOT').Value * LengthFactor - GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor)/2), FloatToStrF(GetDataQuery.FieldByName('DIAMETER').AsFloat * DiamFactor, ffFixed, 15, 0));
    end;
    PrevHoleDiam := GetDataQuery.FieldByName('DIAMETER').Value;
    GetDataQuery.Next;
  end;
  GetDataQuery.Last;
  while not GetDataQuery.BOF do //right side of hole
  begin
    HoleAreaSeries.AddXY(GetDataQuery.FieldByName('DIAMETER').Value/2, GetDataQuery.FieldByName('DEPTH_BOT').Value * LengthFactor);
    HoleAreaSeries.AddXY(GetDataQuery.FieldByName('DIAMETER').Value/2, GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor);
    HoleLineSeries.AddXY(GetDataQuery.FieldByName('DIAMETER').Value/2, GetDataQuery.FieldByName('DEPTH_BOT').Value * LengthFactor);
    HoleLineSeries.AddXY(GetDataQuery.FieldByName('DIAMETER').Value/2, GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor);
    GetDataQuery.Prior;
  end;
  GetDataQuery.Close;
  LogChart.AddSeries(HoleAreaSeries);
  LogChart.AddSeries(HoleLineSeries);
  Screen.Cursor := crDefault;
end;

procedure TLogForm.CreateCasings;
var
  m: Integer;
  CapTop, CapLeftRight, PrevCasingDiam, LabelDepth, PrevLabelDepth: Real;
  CasingSeries: Array[0..49] of TLineSeries;
begin
  Screen.Cursor := crSQLWait;
  PrevCasingDiam := 0;
  PrevLabelDepth := 0;
  LookupQuery.Filter := 'USED_FOR = ' + QuotedStr('OPENTYPE');
  LookupQuery.Filtered := True;
  GetDataQuery.Close;
  GetDataQuery.SQL.Clear;
  GetDataQuery.SQL.Add('SELECT SITE_ID_NR, DEPTH_TOP, DEPTH_BOT, DIAMETER, MATERIAL, THICKNESS, OPEN_TYPE FROM casing__ ');
  GetDataQuery.SQL.Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
  GetDataQuery.SQL.Add('AND DIAMETER > 0');
  GetDataQuery.SQL.Add('ORDER BY DIAMETER DESC, DEPTH_TOP ASC, DEPTH_BOT ASC');
  GetDataQuery.Open;
  if GetDataQuery.RecordCount > 0 then
  begin
    CasingLabels.Active := True;
    CasingLabels.Title := 'Casing diameter [' + DiamUnit + ']';
    LegendEntries.Add(CasingLabels.Title);
    CapTop := GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor;
    CapLeftRight := (GetDataQuery.FieldByName('DIAMETER').Value/2) + 5;
    for m := 0 to GetDataQuery.RecordCount - 1 do
    begin
      CasingSeries[m] := TLineSeries.Create(LogChart);
      with CasingSeries[m] do
      begin
        ZPosition := 400 + m; //to make sure it is above the lithologies, fill and hole
        if LookupQuery.Locate('SEARCH', GetDataQuery.FieldByName('OPEN_TYPE').Value, []) then
          Title := LookupQuery.FieldByName('DESCRIBE').Value
        else Title := 'Casing';
        if Title = 'No information' then Title := 'Casing';
        if not GetDataQuery.FieldByName('THICKNESS').IsNull then
          Title := Title + ': ' + FloatToStrF(GetDataQuery.FieldByName('THICKNESS').AsFloat, ffFixed, 15, 1) + ' ' + DiamUnit;
        if LegendEntries.IndexOf(Title) > 0 then
          Legend.Visible := False
        else
          LegendEntries.Add(Title);
        Marks.Visible := False;
        if LookupQuery.Locate('SEARCH', GetDataQuery.FieldByName('MATERIAL').Value, []) then
        begin
          case LookupQuery.FieldByName('SEARCH').AsString of
                 'B', 'D': LinePen.Color := CasingCopperColour; //brass, copper
            'G', 'S', 'X': LinePen.Color := CasingSteelColour; //galv. iron, steels
                 'O', 'P': LinePen.Color := CasingPVCColour; //Plastic, PVC
            else //all others
              LinePen.Color := clBlack;
          end; //of case
        end
        else //CODE NOT FOUND
          LinePen.Color := clNone;
        if LookupQuery.Locate('SEARCH', GetDataQuery.FieldByName('OPEN_TYPE').Value, []) then
        begin
          case LookupQuery.FieldByName('ADJECTIVE').AsInteger of
            0: LinePen.Style := psClear; //no openings, wellpoint, open hole or other
            1: LinePen.Style := psDashDot; //all perforated
            2: LinePen.Style := psDot; //screens
            3: LinePen.Style := psSolid; //plain casings
          end; //of case
        end
        else //no valid code found --> assume plain casing
          LinePen.Style := psSolid;
        if GetDataQuery.FieldByName('THICKNESS').Value > 0 then
          LinePen.Width := Round(GetDataQuery.FieldByName('THICKNESS').AsFloat)
        else LinePen.Width := 1;
        if OverrideThickn then LinePen.Width := Thickness;
        LinePen.EndCap := pecFlat;
        if GetDataQuery.BOF then //get the left axis minimum
        begin
          LogChart.LeftAxis.Range.Min := GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor;
          DTHChart.LeftAxis.Range.Min := LogChart.LeftAxis.Range.Min;
        end;
        AddXY(-GetDataQuery.FieldByName('DIAMETER').Value/2, GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor);
        AddXY(-GetDataQuery.FieldByName('DIAMETER').Value/2, GetDataQuery.FieldByName('DEPTH_BOT').Value * LengthFactor);
        AddXY(GetDataQuery.FieldByName('DIAMETER').Value/2, NAN);
        AddXY(GetDataQuery.FieldByName('DIAMETER').Value/2, GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor);
        AddXY(GetDataQuery.FieldByName('DIAMETER').Value/2, GetDataQuery.FieldByName('DEPTH_BOT').Value * LengthFactor);
        LogChart.AddSeries(CasingSeries[m]);
        //Casing Labels
        if GetDataQuery.FieldByName('DIAMETER').Value <> PrevCasingDiam then
        begin
          LabelDepth := GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor
              + ((GetDataQuery.FieldByName('DEPTH_BOT').Value * LengthFactor - GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor)/2);
          //check if labels are not too close, otherwise adjust to 5% of depth-of-hole down
          if (PrevLabelDepth > 0) and (LabelDepth <= PrevLabelDepth + (DepthMax * 0.05)) then
            LabelDepth := PrevLabelDepth + (DepthMax * 0.05);
          //Place the label
          if DiamFactor < 1 then
            CasingLabels.AddXY(GetDataQuery.FieldByName('DIAMETER').Value/2, LabelDepth, FloatToStrF(GetDataQuery.FieldByName('DIAMETER').AsFloat * DiamFactor, ffFixed, 15, 2))
          else
            CasingLabels.AddXY(GetDataQuery.FieldByName('DIAMETER').Value/2, LabelDepth, FloatToStrF(GetDataQuery.FieldByName('DIAMETER').AsFloat * DiamFactor, ffFixed, 15, 0));
        end;
        PrevLabelDepth := LabelDepth;
        PrevCasingDiam := GetDataQuery.FieldByName('DIAMETER').Value;
        GetDataQuery.Next;
      end;
    end;
  end
  else
  begin
    Screen.Cursor := crDefault;
    MessageDlg('No valid casing/screen data available! Casings/screens will not be shown.', mtWarning, [mbOK], 0);
  end;
  if ShowCap then
  begin
    CapSeries.AddXY(-CapLeftRight, CapTop);
    CapSeries.AddXY(CapLeftRight, CapTop);
    CapSeries.Active := True;
    CapSeries.LinePen.Color := CapColour;
    LegendEntries.Add('Cap');
  end;
  Screen.Cursor := crDefault;
end;

procedure TLogForm.CreateFillMaterial;
var
  m: Integer;
  FillSeries: Array[0..19] of TAreaSeries;
  t: TLazIntfImage;
  BMPw, BMPh: Integer;
begin
  Screen.Cursor := crSQLWait;
  LookupQuery.Filter := 'USED_FOR = ' + QuotedStr('FILLTYPE');
  LookupQuery.Filtered := True;
  GetDataQuery.SQL.Clear;
  GetDataQuery.SQL.Add('SELECT SITE_ID_NR, DEPTH_TOP, DEPTH_BOT, FILL_TYPE, OUTDIAM, INDIAM FROM holefill ');
  GetDataQuery.SQL.Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
  GetDataQuery.SQL.Add('ORDER BY DEPTH_TOP');
  GetDataQuery.Open;
  if GetDataQuery.RecordCount > 0 then
  begin
    for m := 0 to GetDataQuery.RecordCount - 1 do
    begin
      FillSeries[m] := TAreaSeries.Create(LogChart);
      with FillSeries[m] do
      begin
        ZPosition := 300 + m; //fill material above hole, but under casing
        ZeroLevel := GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor;
        UseZeroLevel := True;
        AreaContourPen.Style := psClear;
        AreaLinesPen.Style := psClear;
        LookupQuery.Locate('SEARCH', GetDataQuery.FieldByName('FILL_TYPE').Value, []);
        Title := LookupQuery.FieldByName('DESCRIBE').Value;
        if LegendEntries.IndexOf(Title) > 0 then
          Legend.Visible := False
        else
          LegendEntries.Add(Title);
        if GetDataQuery.FieldByName('OUTDIAM').IsNull or GetDataQuery.FieldByName('INDIAM').IsNull or GetDataQuery.FieldByName('DEPTH_TOP').IsNull or GetDataQuery.FieldByName('DEPTH_BOT').IsNull then
          MessageDlg('Hole fill data invalid! Fill material will be incomplete or not shown.', mtWarning, [mbOK], 0)
        else
        begin
          AddXY(-GetDataQuery.FieldByName('OUTDIAM').Value/2, GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor);
          AddXY(-GetDataQuery.FieldByName('OUTDIAM').Value/2, GetDataQuery.FieldByName('DEPTH_BOT').Value * LengthFactor);
          AddXY(-GetDataQuery.FieldByName('INDIAM').Value/2, GetDataQuery.FieldByName('DEPTH_BOT').Value * LengthFactor);
          AddXY(-GetDataQuery.FieldByName('INDIAM').Value/2, GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor);
          AddXY(GetDataQuery.FieldByName('INDIAM').Value/2, NAN); //jump to the other side of fill
          AddXY(GetDataQuery.FieldByName('INDIAM').Value/2, GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor);
          AddXY(GetDataQuery.FieldByName('INDIAM').Value/2, GetDataQuery.FieldByName('DEPTH_BOT').Value * LengthFactor);
          AddXY(GetDataQuery.FieldByName('OUTDIAM').Value/2, GetDataQuery.FieldByName('DEPTH_BOT').Value * LengthFactor);
          AddXY(GetDataQuery.FieldByName('OUTDIAM').Value/2, GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor);
        end;
        if UseDefaultFillColour then
          if LookupQuery.FieldByName('DEFAULT_CO').Value >= 0 then //use default colour
            SeriesColor := TColor(LookupQuery.FieldByName('DEFAULT_CO').Value)
          else SeriesColor := Random(256*256*256)
        else SeriesColor := Random(256*256*256);
        if not LookupQuery.FieldByName('LOGS_BMP').IsNull then
        begin
          //set AreaBrush from the LOGS_BMP
          if FileExists(ProgramDir + DirectorySeparator + 'Bitmaps' + DirectorySeparator + LookupQuery.FieldByName('LOGS_BMP').AsString) then
          begin
            FillBmp[m] := TBitmap.Create;
            FillBmp[m].LoadFromFile(ProgramDir + DirectorySeparator + 'Bitmaps' + DirectorySeparator + LookupQuery.FieldByName('LOGS_BMP').AsString);
            try
              t := FillBmp[m].CreateIntfImage;
              for BMPh := 0 to t.Height - 1 do
              begin
                for BMPw := 0 to t.Width - 1 do
                  if FPColorToTColor(t.Colors[BMPw, BMPh]) = clBlack then
                    t.Colors[BMPw, BMPh] := TColorToFPColor(SeriesColor);
              end;
              FillBmp[m].LoadFromIntfImage(t);
            finally
              t.Free
            end;
            AreaBrush.Style := bsImage;
            AreaBrush.Bitmap := FillBmp[m];
          end
          else
            AreaBrush.Style := bsSolid;
        end
        else
        //set AreaBrush from the adjective
        case LookupQuery.FieldByName('ADJECTIVE').AsInteger of
          0: AreaBrush.Style := bsClear;
          1: AreaBrush.Style := bsCross;
          2: AreaBrush.Style := bsDiagCross;
          3: AreaBrush.Style := bsFDiagonal;
          4: AreaBrush.Style := bsHorizontal;
          5: AreaBrush.Style := bsSolid;
          6: AreaBrush.Style := bsVertical;
          7: AreaBrush.Style := bsBDiagonal;
          else AreaBrush.Style := bsClear;
        end;
        if (GetDataQuery.FieldByName('FILL_TYPE').Value = 'D') or
           (GetDataQuery.FieldByName('FILL_TYPE').Value = 'G') or
           (GetDataQuery.FieldByName('FILL_TYPE').Value = 'S') then
          FillSeries[m].Transparency := FillTransparency;
        LogChart.AddSeries(FillSeries[m]);
      end;
      Randomize;
      GetDataQuery.Next;
    end;
  end
  else
  begin
    Screen.Cursor := crDefault;
    MessageDlg('No hole fill data available! Hole fill will not be shown.', mtWarning, [mbOK], 0);
  end;
  Screen.Cursor := crDefault;
end;

procedure TLogForm.CreatePiezometers;
var
  m: Integer;
  PiezomSeries: Array[0..9] of TLineSeries;
begin
  Screen.Cursor := crSQLWait;
  LookupQuery.Filter := 'USED_FOR = ' + QuotedStr('OPENTYPE');
  LookupQuery.Filtered := True;
  GetDataQuery.Close;
  GetDataQuery.SQL.Clear;
  GetDataQuery.SQL.Add('SELECT SITE_ID_NR, PIEZO_NR, DEPTH_TOP, DEPTH_BOT, DIAMETER, OPEN_TYPE FROM piezomet ');
  GetDataQuery.SQL.Add('WHERE SITE_ID_NR = ''' + CurrentSite + '''');
  GetDataQuery.SQL.Add('ORDER BY DEPTH_TOP, DEPTH_BOT');
  GetDataQuery.Open;
  if GetDataQuery.RecordCount > 0 then
  begin
    for m := 0 to GetDataQuery.RecordCount - 1 do
    begin
      PiezomSeries[m] := TLineSeries.Create(LogChart);
      with PiezomSeries[m] do
      begin
        ZPosition := 500 + m; //to make sure it is above the lithologies, fill and hole
        Title := 'Piezometer ' + GetDataQuery.FieldByName('PIEZO_NR').AsString;
        LegendEntries.Add(Title);
        if PiezLabelsAbove then
          MarkPositions := lmpPositive
        else
          MarkPositions := lmpNegative;
        Marks.Visible := ShowPiezLabels;
        Marks.Distance := 5;
        Marks.LabelFont := TheLabelFont;
        Marks.LinkPen.Visible := False;
        Marks.AutoMargins := False;
        Marks.Style := smsLabel;
        Marks.Margins.Bottom := 1;
        Marks.Margins.Left := 2;
        Marks.Margins.Right := 2;
        Marks.Margins.Top := 1;
        if LookupQuery.Locate('SEARCH', GetDataQuery.FieldByName('OPEN_TYPE').Value, []) then
        begin
          case LookupQuery.FieldByName('ADJECTIVE').AsInteger of
            0: begin
                 LinePen.Style := psClear; //no openings, wellpoint, open hole or other
                 LinePen.Color := clWhite;
               end;
            1: begin
                 LinePen.Style := psDash; //all perforated
                 LinePen.Color := PiezomColour;
               end;
            2: begin
                 LinePen.Style := psDot; //screens
                 LinePen.Color := PiezomColour;
               end;
            3: begin
                 LinePen.Style := psSolid; //plain casings
                 LinePen.Color := PiezomColour;
               end;
          end; //of case
        end
        else //no valid code found or empty --> assume plain casing
        begin
          LinePen.Style := psSolid;
          LinePen.Color := PiezomColour;
        end;
        if GetDataQuery.FieldByName('DIAMETER').Value > 0 then
          LinePen.Width := Round(GetDataQuery.FieldByName('DIAMETER').AsFloat/20)
        else LinePen.Width := 2;
        if POverrideThickn then
          LinePen.Width := PThickness;
        LinePen.EndCap := pecFlat;
        //change left axis minimum if piezometer tops are above casing tops
        if GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor < LogChart.LeftAxis.Range.Min then
        begin
          LogChart.LeftAxis.Range.Min := GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor;
          DTHChart.LeftAxis.Range.Min := LogChart.LeftAxis.Range.Min;
        end;
        if PiezLabelsAbove then
        begin
          AddXY(GetDataQuery.FieldByName('PIEZO_NR').Value * 20, GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor, GetDataQuery.FieldByName('PIEZO_NR').AsString);
          AddXY(GetDataQuery.FieldByName('PIEZO_NR').Value * 20, GetDataQuery.FieldByName('DEPTH_BOT').Value * LengthFactor);
        end
        else
        begin
          AddXY(GetDataQuery.FieldByName('PIEZO_NR').Value * 20, GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor);
          AddXY(GetDataQuery.FieldByName('PIEZO_NR').Value * 20, GetDataQuery.FieldByName('DEPTH_BOT').Value * LengthFactor, GetDataQuery.FieldByName('PIEZO_NR').AsString);
        end;
        LogChart.AddSeries(PiezomSeries[m]);
        GetDataQuery.Next;
      end;
    end;
  end
  else
  begin
    Screen.Cursor := crDefault;
    MessageDlg('No piezometer data available! Piezometers will not be shown.', mtWarning, [mbOK], 0);
  end;
  Screen.Cursor := crDefault;
end;

procedure TLogForm.CreateWaterlevel;
var
  WaterSeries: TAreaSeries;
  Waterlev: Real;
  CanShowWater: Boolean;
begin
  Screen.Cursor := crSQLWait;
  Waterlev := 0;
  CanShowWater := False;
  GetDataQuery.Close;
  GetDataQuery.SQL.Clear;
  GetDataQuery.SQL.Add('SELECT SITE_ID_NR, LEVEL_STAT, DATE_MEAS, TIME_MEAS, WATER_LEV FROM waterlev ');
  GetDataQuery.SQL.Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
  case WhichWL of
    1, 3: GetDataQuery.SQL.Add('AND LEVEL_STAT = ' + QuotedStr('S')); //static WL
       4: GetDataQuery.SQL.Add('AND DATE_MEAS = ' + QuotedStr(WLDate));
  end; //of case
  GetDataQuery.SQL.Add('ORDER BY DATE_MEAS, TIME_MEAS');
  GetDataQuery.Open;
  if GetDataQuery.RecordCount > 0 then
  begin
    CanShowWater := True;
    if WhichWL <= 1 then GetDataQuery.First
    else GetDataQuery.Last;
    WaterlevelLine.AddXY(-LithXExtent, GetDataQuery.FieldByName('WATER_LEV').Value * LengthFactor);
    WaterlevelLine.AddXY(0, GetDataQuery.FieldByName('WATER_LEV').Value * LengthFactor, FloatToStrF(GetDataQuery.FieldByName('WATER_LEV').AsFloat * LengthFactor, ffFixed, 15, 2) + LengthUnit);
    WaterlevelLine.AddXY(LithXExtent, GetDataQuery.FieldByName('WATER_LEV').Value * LengthFactor);
    WaterlevelLine.SeriesColor := WLColour;
    WaterlevelLine.LinePen.Width := WLThickness;
    WaterlevelLine.Active := True;
    WaterlevelLine.Title := 'Water level (' + DateToStr(StringToDate(GetDataQuery.FieldByName('DATE_MEAS').AsString)) + ')';
    LegendEntries.Add(WaterlevelLine.Title);
    WaterlevelLine.Marks.LabelFont := TheLabelFont;
    case WLLabelPos of
      2: begin
           WaterLevelLine.MarkPositions := lmpPositive;
           WaterlevelLine.Marks.Visible := True;
         end;
      1: begin
           WaterLevelLine.MarkPositions := lmpNegative;
           WaterlevelLine.Marks.Visible := True;
         end;
      0: WaterlevelLine.Marks.Visible := False;
    end;
    Waterlev := GetDataQuery.FieldByName('WATER_LEV').Value;
  end
  else
  begin
    ShowWater := False;
    Screen.Cursor := crDefault;
    MessageDlg('No water level data available! Water level will not be shown.', mtWarning, [mbOK], 0);
  end;
  if ShowWater and CanShowWater then //fill the hole under water level with blue transparent shade
  begin
    Screen.Cursor := crSQLWait;
    WaterSeries := TAreaSeries.Create(LogChart);
    with WaterSeries do
    begin
      ZPosition := 201; //to make sure it is above the lithologies and above hole
      ZeroLevel := Waterlev; //at the water level
      UseZeroLevel := True;
      Title := 'Water';
      SeriesColor := WaterColor;
      Marks.Visible := False;
      AreaLinesPen.Style := psClear;
      AreaContourPen.Style := psClear;
      Legend.Visible := False;
    end;
    GetDataQuery.SQL.Clear;
    GetDataQuery.SQL.Add('SELECT SITE_ID_NR, DEPTH_TOP, DEPTH_BOT, DIAMETER FROM holediam ');
    GetDataQuery.SQL.Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
    GetDataQuery.SQL.Add('ORDER BY DEPTH_TOP');
    GetDataQuery.Open;
    while not GetDataQuery.EOF do //left side of hole
    begin
      //get the starting point at the water level
      if (GetDataQuery.FieldByName('DEPTH_TOP').Value < Waterlev) and (GetDataQuery.FieldByName('DEPTH_BOT').Value > Waterlev) then
      begin
        WaterSeries.AddXY(-GetDataQuery.FieldByName('DIAMETER').Value/2, Waterlev * LengthFactor);
        WaterSeries.AddXY(-GetDataQuery.FieldByName('DIAMETER').Value/2, GetDataQuery.FieldByName('DEPTH_BOT').Value * LengthFactor);
      end
      else
      if GetDataQuery.FieldByName('DEPTH_TOP').Value > Waterlev then //under the water level
      begin
        WaterSeries.AddXY(-GetDataQuery.FieldByName('DIAMETER').Value/2, GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor);
        WaterSeries.AddXY(-GetDataQuery.FieldByName('DIAMETER').Value/2, GetDataQuery.FieldByName('DEPTH_BOT').Value * LengthFactor);
      end;
      GetDataQuery.Next;
    end;
    GetDataQuery.Last;
    while not GetDataQuery.BOF do //right side of hole
    begin
      if (GetDataQuery.FieldByName('DEPTH_TOP').Value < Waterlev) and (GetDataQuery.FieldByName('DEPTH_BOT').Value > Waterlev) then
      begin
        WaterSeries.AddXY(GetDataQuery.FieldByName('DIAMETER').Value/2, GetDataQuery.FieldByName('DEPTH_BOT').Value * LengthFactor);
        WaterSeries.AddXY(GetDataQuery.FieldByName('DIAMETER').Value/2, Waterlev * LengthFactor);
      end
      else
      if GetDataQuery.FieldByName('DEPTH_TOP').Value > Waterlev then //under the water level
      begin
        WaterSeries.AddXY(GetDataQuery.FieldByName('DIAMETER').Value/2, GetDataQuery.FieldByName('DEPTH_BOT').Value * LengthFactor);
        WaterSeries.AddXY(GetDataQuery.FieldByName('DIAMETER').Value/2, GetDataQuery.FieldByName('DEPTH_TOP').Value * LengthFactor);
      end;
      GetDataQuery.Prior;
    end;
    GetDataQuery.Close;
    LogChart.AddSeries(WaterSeries);
  end;
  Screen.Cursor := crDefault;
end;

procedure TLogForm.CreateDepthDependentChart;
var
  TopMax, BottomMax: Real;
  NrSeriesToAddLog, NrSeriesToAddDTH, s: Word;
  DummySeries, AddTopSeries, AddBotSeries: TLineSeries;
  SeriesAdded: Boolean;
  PrevDateTime: TDateTime;
begin
  SeriesAdded := False;
  TopMax := 0;
  BottomMax := 0;
  DTHChart.Legend.Frame.Visible := ShowLegendFrame;
  if Depth1TableName <> '<none>' then
  begin
    TopSeries.Active := True;
    case TopLineStyle of
      0: TopSeries.LinePen.Style := psDash;
      1: TopSeries.LinePen.Style := psDashDot;
      2: TopSeries.LinePen.Style := psDashDotDot;
      3: TopSeries.LinePen.Style := psDot;
      4: TopSeries.LinePen.Style := psSolid;
    end;
    TopSeries.Legend.Visible := True;
    DTHChart.AxisList[3].Visible := True;
    DTHChart.AxisList[3].Marks.Visible := True;
    DTHChart.AxisList[3].Marks.LabelFont := TheLabelFont;
    if Depth2TableName = '<none>' then
    begin
      DTHChart.AxisList[1].Transformations := NIL;
      DTHChart.AxisList[3].Transformations := NIL;
      DTHChart.AxisList[1].Title.Caption := DTHChart.AxisList[3].Title.Caption;
    end;
    GetDataQuery.SQL.Clear;
    if TopY = 'DEPTH' then
    with GetDataQuery do
    begin
      SQL.Add('SELECT SITE_ID_NR, DATE_MEAS, TIME_MEAS, DEPTH, ' + TopX + ' FROM ' + Depth1TableName);
      SQL.Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
      if DataModuleMain.ZConnectionDB.Tag = 1 then
      begin
        SQL.Add('AND DATE_MEAS || TIME_MEAS >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DepthFromDateTime)));
        SQL.Add('AND DATE_MEAS || TIME_MEAS <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DepthToDateTime)));
      end
      else
      begin
        SQL.Add('AND CONCAT(DATE_MEAS, TIME_MEAS) >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DepthFromDateTime)));
        SQL.Add('AND CONCAT(DATE_MEAS, TIME_MEAS) <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DepthToDateTime)));
      end;
      SQL.Add('ORDER BY DATE_MEAS, TIME_MEAS, DEPTH');
      Open;
      if RecordCount > 0 then
      begin
        while not EOF do
        begin
          if SeriesAdded then
            AddTopSeries.AddXY(FieldByName(TopX).Value, FieldByName('DEPTH').Value)
          else
            TopSeries.AddXY(FieldByName(TopX).Value, FieldByName('DEPTH').Value);
          if FieldByName(TopX).Value > TopMax then
            TopMax := FieldByName(TopX).Value;
          PrevDateTime := StringToDate(FieldByName('DATE_MEAS').AsString) + StringToTime(FieldByName('TIME_MEAS').AsString);
          Next;
          //check if new series needs to be created --> if new date is at least 1 day apart
          if (StringToDate(FieldByName('DATE_MEAS').AsString) + StringToTime(FieldByName('TIME_MEAS').AsString)) - PrevDateTime >= 1 then
          begin
            AddTopSeries := TLineSeries.Create(DTHChart);
            with AddTopSeries do
            begin
              SeriesColor := TopSeries.SeriesColor;
              Legend.Visible := False;
              AxisIndexX := TopSeries.AxisIndexX;
              AxisIndexY := TopSeries.AxisIndexY;
            end;
            DTHChart.AddSeries(AddTopSeries);
            SeriesAdded := True;
            if UseDepthLineStyles then
            begin
              with AddTopSeries do
              begin
                LinePen.Style := TFPPenStyle(Random(5));
                if LinePen.Style = psClear then LinePen.Style := TFPPenStyle(1);
              end;
            end;
          end;
        end
      end
      else
        MessageDlg('No data for top axis series of depth-dependent chart!', mtError, [mbOK], 0);
      Close;
    end
    else
    if TopY = 'DEPTH_TOP' then
    with GetDataQuery do
    begin
      SQL.Add('SELECT SITE_ID_NR, DEPTH_TOP, DEPTH_BOT, ' + TopX + ' FROM ' + Depth1TableName);
      SQL.Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
      SQL.Add('ORDER BY DEPTH_TOP');
      Open;
      if RecordCount > 0 then
      begin
        //Add the first zero value
        TopSeries.AddXY(0, FieldByName('DEPTH_TOP').Value);
        while not EOF do
        begin
          if Depth1TableName = 'penetrat' then //covert from saved m/min to current units
          begin
            case TopPenetrOpt of
              0: begin
                  TopSeries.AddXY(60/TimeFactor/(FieldByName(TopX).Value * LengthFactor), FieldByName('DEPTH_TOP').Value);
                  TopSeries.AddXY(60/TimeFactor/(FieldByName(TopX).Value * LengthFactor), FieldByName('DEPTH_BOT').Value);
                  if 60/TimeFactor/(FieldByName(TopX).Value * LengthFactor) > TopMax then
                    TopMax := 60/TimeFactor/(FieldByName(TopX).Value * LengthFactor);
                 end;
              1: begin
                  TopSeries.AddXY(1/(FieldByName(TopX).Value * LengthFactor), FieldByName('DEPTH_TOP').Value);
                  TopSeries.AddXY(1/(FieldByName(TopX).Value * LengthFactor), FieldByName('DEPTH_BOT').Value);
                  if 1/(FieldByName(TopX).Value * LengthFactor) > TopMax then
                    TopMax := 1/(FieldByName(TopX).Value * LengthFactor);
                 end;
              2: begin
                  TopSeries.AddXY(FieldByName(TopX).Value * LengthFactor, FieldByName('DEPTH_TOP').Value);
                  TopSeries.AddXY(FieldByName(TopX).Value * LengthFactor, FieldByName('DEPTH_BOT').Value);
                  if FieldByName(TopX).Value * LengthFactor > TopMax then
                    TopMax := FieldByName(TopX).Value * LengthFactor;
                 end;
            end; //of case
          end
          else
          begin
            TopSeries.AddXY(FieldByName(TopX).Value * TheTopFactor, FieldByName('DEPTH_TOP').Value);
            TopSeries.AddXY(FieldByName(TopX).Value * TheTopFactor, FieldByName('DEPTH_BOT').Value);
            if FieldByName(TopX).Value * TheTopFactor > TopMax then
              TopMax := FieldByName(TopX).Value * TheTopFactor;
          end;
          Next;
        end;
      end
      else
        MessageDlg('There is no data for top axis series of depth-dependent chart!', mtWarning, [mbOK], 0);
      GetDataQuery.Close;
    end;
  end;
  if Depth2TableName <> '<none>' then
  begin
    BottomSeries.Active := True;
    case BottomLineStyle of
      0: BottomSeries.LinePen.Style := psDash;
      1: BottomSeries.LinePen.Style := psDashDot;
      2: BottomSeries.LinePen.Style := psDashDotDot;
      3: BottomSeries.LinePen.Style := psDot;
      4: BottomSeries.LinePen.Style := psSolid;
    end;
    BottomSeries.Legend.Visible := True;
    DTHChart.AxisList[1].Visible := True;
    DTHChart.AxisList[1].Marks.Visible := True;
    DTHChart.AxisList[1].Marks.LabelFont := TheLabelFont;
    if Depth1TableName = '<none>' then
    begin
      DTHChart.AxisList[3].Transformations := NIL;
      DTHChart.AxisList[1].Transformations := NIL;
      DTHChart.AxisList[3].Title.Caption := DTHChart.AxisList[1].Title.Caption;
    end;
    GetDataQuery.SQL.Clear;
    SeriesAdded := False;
    if BotY = 'DEPTH' then
    with GetDataQuery do
    begin
      SQL.Add('SELECT SITE_ID_NR, DATE_MEAS, TIME_MEAS, DEPTH, ' + BotX + ' FROM ' + Depth2TableName);
      SQL.Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
      if DataModuleMain.ZConnectionDB.Tag = 1 then
      begin
        SQL.Add('AND DATE_MEAS || TIME_MEAS >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DepthFromDateTime)));
        SQL.Add('AND DATE_MEAS || TIME_MEAS <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DepthToDateTime)));
      end
      else
      begin
        SQL.Add('AND CONCAT(DATE_MEAS, TIME_MEAS) >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DepthFromDateTime)));
        SQL.Add('AND CONCAT(DATE_MEAS, TIME_MEAS) <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DepthToDateTime)));
      end;
      SQL.Add('ORDER BY DATE_MEAS, TIME_MEAS, DEPTH');
      Open;
      if RecordCount > 0 then
      begin
        while not EOF do
        begin
          if SeriesAdded then
            AddBotSeries.AddXY(FieldByName(BotX).Value, FieldByName('DEPTH').Value)
          else
            BottomSeries.AddXY(FieldByName(BotX).Value, FieldByName('DEPTH').Value);
          if FieldByName(BotX).Value > BottomMax then
            BottomMax := FieldByName(BotX).Value;
          PrevDateTime := StringToDate(FieldByName('DATE_MEAS').AsString) + StringToTime(FieldByName('TIME_MEAS').AsString);
          Next;
          //check if new series needs to be created --> if new date is at least 1 day apart
          if (StringToDate(FieldByName('DATE_MEAS').AsString) + StringToTime(FieldByName('TIME_MEAS').AsString)) - PrevDateTime >= 1 then
          begin
            AddBotSeries := TLineSeries.Create(DTHChart);
            with AddBotSeries do
            begin
              SeriesColor := BottomSeries.SeriesColor;
              Legend.Visible := False;
              AxisIndexX := BottomSeries.AxisIndexX;
              AxisIndexY := BottomSeries.AxisIndexY;
            end;
            DTHChart.AddSeries(AddBotSeries);
            SeriesAdded := True;
            if UseDepthLineStyles then
            begin
              with AddBotSeries do
              begin
                LinePen.Style := TFPPenStyle(Random(5));
                if LinePen.Style = psClear then LinePen.Style := TFPPenStyle(1);
              end;
            end;
          end;
        end
      end
      else
        MessageDlg('There is no data for bottom axis series of depth-dependent chart!', mtWarning, [mbOK], 0);
      Close;
    end
    else
    if BotY = 'DEPTH_TOP' then
    with GetDataQuery do
    begin
      SQL.Add('SELECT SITE_ID_NR, DEPTH_TOP, DEPTH_BOT, ' + BotX + ' FROM ' + Depth2TableName);
      SQL.Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
      SQL.Add('ORDER BY DEPTH_TOP');
      Open;
      if RecordCount > 0 then
      begin
        //Add the first zero value
        BottomSeries.AddXY(0, FieldByName('DEPTH_TOP').Value);
        while not EOF do
        begin
          if Depth2TableName = 'penetrat' then //covert from saved m/min to current units
          begin
            case BotPenetrOpt of
              0: begin
                  BottomSeries.AddXY(60/TimeFactor/(FieldByName(BotX).Value * LengthFactor), FieldByName('DEPTH_TOP').Value);
                  BottomSeries.AddXY(60/TimeFactor/(FieldByName(BotX).Value * LengthFactor), FieldByName('DEPTH_BOT').Value);
                  if 60/TimeFactor/(FieldByName(BotX).Value * LengthFactor) > BottomMax then
                    BottomMax := 60/TimeFactor/(FieldByName(BotX).Value * LengthFactor);
                 end;
              1: begin
                  BottomSeries.AddXY(1/(FieldByName(BotX).Value * LengthFactor), FieldByName('DEPTH_TOP').Value);
                  BottomSeries.AddXY(1/(FieldByName(BotX).Value * LengthFactor), FieldByName('DEPTH_BOT').Value);
                  if 1/(FieldByName(BotX).Value * LengthFactor) > BottomMax then
                    BottomMax := 1/(FieldByName(BotX).Value * LengthFactor);
                 end;
              2: begin
                  BottomSeries.AddXY(FieldByName(BotX).Value * LengthFactor, FieldByName('DEPTH_TOP').Value);
                  BottomSeries.AddXY(FieldByName(BotX).Value * LengthFactor, FieldByName('DEPTH_BOT').Value);
                  if FieldByName(BotX).Value * LengthFactor > BottomMax then
                    BottomMax := FieldByName(BotX).Value * LengthFactor;
                 end;
            end; //of case
          end
          else
          begin
            BottomSeries.AddXY(FieldByName(BotX).Value * TheBotFactor, FieldByName('DEPTH_TOP').Value);
            BottomSeries.AddXY(FieldByName(BotX).Value * TheBotFactor, FieldByName('DEPTH_BOT').Value);
            if FieldByName(BotX).Value * TheBotFactor > BottomMax then
              BottomMax := FieldByName(BotX).Value * TheBotFactor;
          end;
          Next;
        end;
      end
      else
        MessageDlg('There is no data for bottom axis series of depth-dependent chart!', mtError, [mbOK], 0);
      GetDataQuery.Close;
    end;
  end;
  //check if there are values in series in the DTH chart, otherwise switch off
  if (TopSeries.Count = 0) and (BottomSeries.Count = 0) then
  begin
    DTHChart.Free;
    Splitter1.Free;
    MessageDlg('There is no data for the top and bottom series in the depth-dependent chart! It will therefore not be shown.', mtWarning, [mbOK], 0);
  end
  else
  begin
    if Splitter1.Left + 5 = Self.Width then //it is on the right hand side of the form
      Splitter1.Left := Round(Self.Width * 0.75);
    ChartExtentLink1.Enabled := True;
    //Set top and bottom axis maximum on DTH chart
    if SetMaxTop > 0 then
    begin
      DTHChart.AxisList[3].Range.Max := SetMaxTop;
      DTHChart.AxisList[3].Range.UseMax := True;
      TopMax := SetMaxTop;
    end;
    //Set axis maximum
    if SetMaxBot > 0 then
    begin
      DTHChart.AxisList[1].Range.Max := SetMaxBot;
      DTHChart.AxisList[1].Range.UseMax := True;
      BottomMax := SetMaxBot;
    end;
    //Adjust bottom axes of the charts by adding invisible series depending on nr of lines in legends
    NrSeriesToAddLog := 0;
    NrSeriesToAddDTH := 0;
    if TopSeries.Active and BottomSeries.Active then //2 items in DTH Legend
    begin
      if LegendEntries.Count <= 3 then //add one line to the log legend
        NrSeriesToAddLog := 3
      else
      if LegendEntries.Count <= 6 then //don't add anything
        NrSeriesToAddLog := 0
      else
      if LegendEntries.Count <= 9 then //add a line to the DTH legend etc.
        NrSeriesToAddDTH := 1
      else
      if LegendEntries.Count <= 12 then
        NrSeriesToAddDTH := 2
      else
      if LegendEntries.Count <= 15 then
        NrSeriesToAddDTH := 3
      else
      if LegendEntries.Count <= 18 then
        NrSeriesToAddDTH := 4
    end
    else
    if BottomSeries.Active or TopSeries.Active then //only one series: one line in legend
    begin
      if LegendEntries.Count <= 3 then //do nothing...there is one line on each chart legend
        NrSeriesToAddDTH := 0
      else
      if LegendEntries.Count <= 6 then
        NrSeriesToAddDTH := 1
      else
      if LegendEntries.Count <= 9 then
        NrSeriesToAddDTH := 2
      else
      if LegendEntries.Count <= 12 then
        NrSeriesToAddDTH := 3
      else
      if LegendEntries.Count <= 15 then
        NrSeriesToAddDTH := 4
      else
      if LegendEntries.Count <= 18 then
        NrSeriesToAddDTH := 5
    end;
    //Add the invisible series so that the legends have the same number of rows
    if NrSeriesToAddLog > 0 then
    for s := 1 to NrSeriesToAddLog do
    begin
      DummySeries := TLineSeries.Create(LogChart);
      DummySeries.LineType := ltNone;
      DummySeries.AddXY(0,0, ' ', clNone);
      LogChart.AddSeries(DummySeries);
    end;
    if NrSeriesToAddDTH > 0 then
    for s := 1 to NrSeriesToAddDTH do
    begin
      DummySeries := TLineSeries.Create(DTHChart);
      DummySeries.LineType := ltNone;
      DummySeries.AddXY(0,0, ' ', clNone);
      DTHChart.AddSeries(DummySeries);
    end;
  end;
end;

procedure TLogForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  with ButtonPanel1 do
  begin
    OKButton.Font.Name := AppFont.Name;
    OKButton.Font.Size := AppFont.Size;
    CloseButton.Font.Name := AppFont.Name;
    CloseButton.Font.Size := AppFont.Size;
    HelpButton.Font.Name := AppFont.Name;
    HelpButton.Font.Size := AppFont.Size;
  end;
  GetDataQuery.Connection := DatamoduleMain.ZConnectionDB;
end;

procedure TLogForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TLogForm.FormShow(Sender: TObject);
var
  m: Integer;
begin
  LegendEntries := TStringList.Create;
  with LogChart do
  begin
    LeftAxis.Marks.LabelFont := TheLabelFont;
    LeftAxis.Title.LabelFont := TheLabelFont;
    LeftAxis.Title.LabelFont.Orientation := 900;
    LeftAxis.Title.Caption := 'Depth [' + LengthUnit + ']';
    AxisList[2].Marks.LabelFont := TheLabelFont;
    AxisList[2].Title.LabelFont := TheLabelFont;
    BottomAxis.Marks.LabelFont := TheLabelFont;
    BottomAxis.Title.LabelFont := TheLabelFont;
    Legend.Font := TheLabelFont;
  end;
  with DTHChart do
  begin
    AxisList[1].Marks.LabelFont := TheLabelFont;
    AxisList[1].Title.LabelFont := TheLabelFont;
    AxisList[2].Marks.LabelFont := TheLabelFont;
    AxisList[3].Marks.LabelFont := TheLabelFont;
    AxisList[3].Title.LabelFont := TheLabelFont;
    Title.Font := TheLabelFont;
    Legend.Font := TheLabelFont;
  end;
  LookupQuery.Open;
  DepthMax := 0;
  if ShowHole then //determine biggest HOLE diameter to set width of Lithology and get depth
  begin
    Screen.Cursor := crSQLWait;
    GetDataQuery.SQL.Clear;
    GetDataQuery.SQL.Add('SELECT MAX(DIAMETER) FROM holediam WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
    GetDataQuery.Open;
    if (not GetDataQuery.Fields[0].IsNull) and (GetDataQuery.Fields[0].Value > 0) then
    begin
      LithXExtent := GetDataQuery.Fields[0].Value / 2 + LithWidth; //set left and right for lithology areas
      GetDataQuery.Close;
      GetDataQuery.SQL.Clear;
      GetDataQuery.SQL.Add('SELECT MAX(DEPTH_BOT) FROM holediam WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
      GetDataQuery.Open;
      if (not GetDataQuery.Fields[0].IsNull) and (GetDataQuery.Fields[0].Value > 0) then
        DepthMax := GetDataQuery.Fields[0].Value * LengthFactor //get depth of the hole
      else DepthMax := 0;
      GetDataQuery.Close;
      Screen.Cursor := crDefault;
    end
    else
    begin
      Screen.Cursor := crDefault;
      ShowHole := False;
      LithXExtent := 200;
      MessageDlg('No hole diameter and/or depth data available! Hole will not be shown.', mtWarning, [mbOK], 0);
    end;
  end
  else
    LithXExtent := 200; //some arbitrary default: 200*2 = 400 wide
  LogChart.BottomAxis.Range.Min := -LithXExtent - 100;
  Application.ProcessMessages;
  if ShowLithology then //Create lithology area series and lithology labels (LogLabelLines series)
    CreateLithologies
  else
    LogChart.BottomAxis.Range.Max := -LogChart.BottomAxis.Range.Min;//of Show Lithology
  Application.ProcessMessages;
  if ShowStrikes then //draw water strikes on lithology
    CreateStrikes;
  if ShowHole then //draw the hole area and hole line
    CreateHole;
  Application.ProcessMessages;
  if ShowCasing then //draw the casings and screens - own AreaSeries per casing type and diameter
    CreateCasings;
  Application.ProcessMessages;
  if ShowFill then //draw fill materials
    CreateFillMaterial;
  Application.ProcessMessages;
  if ShowPiezometer then //draw piezometers
    CreatePiezometers;
  Application.ProcessMessages;
  if ShowWaterlevel then //draw WaterlevelLine
    CreateWaterlevel;
  LookupQuery.Filtered := False;
  LookupQuery.Filter := '';
  if SpaceUnderHole > 0 then //leave space under hole to allow for lith description with very thin last lithology
  begin
    LogChart.LeftAxis.Range.Max := DepthMax + SpaceUnderHole;
    LogChart.LeftAxis.Range.UseMax := True;
    DTHChart.LeftAxis.Range.Max := DepthMax + SpaceUnderHole;
    DTHChart.LeftAxis.Range.UseMax := True;
  end;
  Application.ProcessMessages;
  //Now: The depth dependent chart
  if DTHChart.Visible then
    CreateDepthDependentChart
  else
  begin
    DTHChart.Free;
    Splitter1.Free;
  end;
  //set depth axis intervals
  if DepthMax = 0 then DepthMax := 3000;
  if AutoInterval then
  begin
    if DepthMax <= 10 then DepthAxisInterval := 1
    else if DepthMax <= 20 then DepthAxisInterval := 2
    else if DepthMax <= 100 then DepthAxisInterval := 5
    else if DepthMax <= 200 then DepthAxisInterval := 10
    else if DepthMax <= 500 then DepthAxisInterval := 25
    else DepthAxisInterval := 50;
  end;
  //populate the ListChartSourceDepth
  m := 0;
  while m <= DepthMax do
  begin
    ListChartSourceDepth.Add(m, m);
    Inc(m, DepthAxisInterval);
  end;
  LogChart.LeftAxis.Marks.Source := ListChartSourceDepth;
  if DTHChart <> nil then
    DTHChart.AxisList[2].Marks.Source := ListChartSourceDepth;
  LegendEntries.Free;
  LogChart.SetFocus;
  cht := LogChart;
  LookupQuery.Close;
  Screen.Cursor := crDefault;
  Application.ProcessMessages;
end;

procedure TLogForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TLogForm.LogChartDblClick(Sender: TObject);
begin
  LogChart.ZoomFull;
  Screen.Cursor := crDefault;
end;

procedure TLogForm.LogChartMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  LogChart.SetFocus;
  cht := LogChart;
end;

procedure TLogForm.MenuItem4Click(Sender: TObject);
begin
  LogChart.LeftAxis.Title.LabelFont.Orientation := LogChart.LeftAxis.Title.LabelFont.Orientation + 900;
end;

procedure TLogForm.MenuItemTopExtentClick(Sender: TObject);
begin
  with LogChart do
  begin
    Extent.YMax := DepthMax * TopExt;
    Extent.UseYMax := True;
    Extent.UseYMin := False;
  end;
end;

procedure TLogForm.MenuItemBotExtentClick(Sender: TObject);
begin
  with LogChart do
  begin
    Extent.YMin := DepthMax * TopExt;
    Extent.UseYMin := True;
    Extent.YMax := DepthMax;
    Extent.UseYMax := True;
  end;
end;

procedure TLogForm.MenuItemFullExtentClick(Sender: TObject);
begin
  with LogChart do
  begin
    Extent.UseYMin := False;
    Extent.UseYMax := False;
  end;
end;

procedure TLogForm.MenuItemFontSmallerClick(Sender: TObject);
begin
  LithLabels.Marks.LabelFont.Size := LithLabels.Marks.LabelFont.Size - 1;
end;

procedure TLogForm.MenuItemFontLargerClick(Sender: TObject);
begin
  LithLabels.Marks.LabelFont.Size := LithLabels.Marks.LabelFont.Size + 1
end;

procedure TLogForm.MenuItemBotDownClick(Sender: TObject);
begin
  if cht.MarginsExternal.Bottom > 0 then
    cht.MarginsExternal.Bottom := cht.MarginsExternal.Bottom - 1;
end;

procedure TLogForm.MenuItemBotUpClick(Sender: TObject);
begin
  cht.MarginsExternal.Bottom := cht.MarginsExternal.Bottom + 1;
end;

procedure TLogForm.MenuItemBitmapClick(Sender: TObject);
var
  bmp: TBitMap;
  i: Integer;
const
  ThisResFactor = 3;
begin
  with SaveDialog1 do
  begin
    InitialDir := WSpaceDir;
    DefaultExt := '.bmp';
    Filter := 'Bitmap File (*.bmp)|*.bmp; *.BMP; *.Bmp|All Files (*.*)|*'
  end;
  if SaveDialog1.Execute then
  begin
    //create the bitmaps
    bmp := TBitmap.Create;
    bmp.SetSize(ThisResFactor * cht.Width, ThisResFactor * cht.Height);
    if cht = LogChart then
    begin
      with cht do
      begin
        Color := clWhite;
        with LeftAxis do
        begin
          Marks.LabelFont.Height := ThisResFactor * Marks.LabelFont.Height;
          Title.LabelFont.Height := ThisResFactor * Title.LabelFont.Height;
          Grid.Width := 2;
        end;
        with AxisList[2] do //top axis
        begin
          Marks.LabelFont.Height := ThisResFactor * Marks.LabelFont.Height;
          Marks.Distance := Marks.Distance * ThisResFactor;
          Title.LabelFont.Height := ThisResFactor * Title.LabelFont.Height;
          Title.Distance := Title.Distance * ThisResFactor;
          TickLength := ThisResFactor * TickLength;
        end;
        with BottomAxis do //bottom axis
        begin
          Marks.LabelFont.Height := ThisResFactor * Marks.LabelFont.Height;
          Marks.Distance := Marks.Distance * ThisResFactor;
          Title.LabelFont.Height := ThisResFactor * Title.LabelFont.Height;
          Title.Distance := Title.Distance * ThisResFactor;
          TickLength := ThisResFactor * TickLength;
        end;
        Legend.Font.Height := ThisResFactor* Legend.Font.Height;
        Legend.FixedItemHeight := ThisResFactor * Legend.FixedItemHeight;
        Legend.Spacing := ThisResFactor * Legend.Spacing;
        Legend.SymbolWidth := ThisResFactor * Legend.SymbolWidth;
        Legend.Frame.Visible := ShowLegendFrame;
        Margins.Top := Margins.Top * ThisResFactor;
        Margins.Bottom := Margins.Bottom * ThisResFactor;
        MarginsExternal.Top := MarginsExternal.Top * ThisResFactor;
        MarginsExternal.Bottom := MarginsExternal.Bottom * ThisResFactor;
        for i := 0 to SeriesCount -1 do
        begin
          if Series[i] is TLineSeries then
          with (Series[i] as TLineSeries) do
          begin
            Pointer.HorizSize := Pointer.HorizSize * ThisResFactor;
            Pointer.VertSize := Pointer.VertSize * ThisResFactor;
            Marks.Distance := Marks.Distance * ThisResFactor;
            Marks.Margins.Left := Marks.Margins.Left * ThisResFactor;
            Marks.Margins.Right := Marks.Margins.Right * ThisResFactor;
            Marks.Margins.Top := Marks.Margins.Top * ThisResFactor;
            Marks.Margins.Bottom := Marks.Margins.Bottom * ThisResFactor;
            Marks.LabelFont.Height := Marks.LabelFont.Height * ThisResFactor;
            LinePen.Width := LinePen.Width * 2;
          end;
        end;
        LithLabels.Marks.LabelFont.Height := LithLabels.Marks.LabelFont.Height * ThisResFactor;
        PaintOnCanvas(bmp.Canvas, Rect(0, 0, bmp.Width, bmp.Height));
        //reset resolution back to previous values
        with LeftAxis do
        begin
          Marks.LabelFont.Height := Round(Marks.LabelFont.Height / ThisResFactor);
          Title.LabelFont.Height := Round(Title.LabelFont.Height / ThisResFactor);
          Grid.Width := 1;
        end;
        with AxisList[2] do //top axis
        begin
          Marks.LabelFont.Height := Round(Marks.LabelFont.Height / ThisResFactor);
          Marks.Distance := Round(Marks.Distance / ThisResFactor);
          Title.LabelFont.Height := Round(Title.LabelFont.Height / ThisResFactor);
          Title.Distance := Round(Title.Distance / ThisResFactor);
          TickLength := Round(TickLength / ThisResFactor);
        end;
        with BottomAxis do //bottom axis
        begin
          Marks.LabelFont.Height := Round(Marks.LabelFont.Height / ThisResFactor);
          Marks.Distance := Round(Marks.Distance / ThisResFactor);
          Title.LabelFont.Height := Round(Title.LabelFont.Height / ThisResFactor);
          Title.Distance := Round(Title.Distance / ThisResFactor);
          TickLength := Round(TickLength / ThisResFactor);
        end;
        for i := 0 to SeriesCount -1 do
        begin
          if Series[i] is TLineSeries then
          with (Series[i] as TLineSeries) do
          begin
            Pointer.HorizSize := Round(Pointer.HorizSize / ThisResFactor);
            Pointer.VertSize := Round(Pointer.VertSize / ThisResFactor);
            Marks.Distance := Round(Marks.Distance / ThisResFactor);
            Marks.Margins.Left := Round(Marks.Margins.Left / ThisResFactor);
            Marks.Margins.Right := Round(Marks.Margins.Right / ThisResFactor);
            Marks.Margins.Top := Round(Marks.Margins.Top / ThisResFactor);
            Marks.Margins.Bottom := Round(Marks.Margins.Bottom / ThisResFactor);
            Marks.LabelFont.Height := Round(Marks.LabelFont.Height / ThisResFactor);
            LinePen.Width := Round(LinePen.Width / 2);
          end;
        end;
        LithLabels.Marks.LabelFont.Height := Round(LithLabels.Marks.LabelFont.Height / ThisResFactor);
        Legend.Font.Height := Round(Legend.Font.Height / ThisResFactor);
        Legend.FixedItemHeight := Round(Legend.FixedItemHeight / ThisResFactor);
        Legend.Spacing := Round(Legend.Spacing / ThisResFactor);
        Legend.SymbolWidth := Round(Legend.SymbolWidth / ThisResFactor);
        Margins.Top := 4;
        Margins.Bottom := 4;
        MarginsExternal.Top := Round(MarginsExternal.Top / ThisResFactor);
        MarginsExternal.Bottom := Round(MarginsExternal.Bottom / ThisResFactor);
        Color := clBtnFace;
      end;
    end
    else
    if cht = DTHChart then
    begin
      with cht do
      begin
        Color := clWhite;
        with AxisList[1] do
        begin
          Marks.LabelFont.Height := ThisResFactor * Marks.LabelFont.Height;
          Marks.Distance := ThisResFactor * Marks.Distance;
          Grid.Width := 2;
          Title.LabelFont.Height := ThisResFactor * Title.LabelFont.Height;
          Intervals.MaxLength := Intervals.MaxLength * ThisResFactor;
          Intervals.MinLength := Intervals.MinLength * ThisResFactor;
          Title.Distance := Title.Distance * ThisResFactor;
          TickLength := TickLength * ThisResFactor;
        end;
        with AxisList[3] do
        begin
          Marks.LabelFont.Height := ThisResFactor * Marks.LabelFont.Height;
          Marks.Distance := ThisResFactor * Marks.Distance;
          Grid.Width := 2;
          Title.LabelFont.Height := ThisResFactor * Title.LabelFont.Height;
          Intervals.MaxLength := Intervals.MaxLength * ThisResFactor;
          Intervals.MinLength := Intervals.MinLength * ThisResFactor;
          Title.Distance := Title.Distance * ThisResFactor;
          TickLength := TickLength * ThisResFactor;
        end;
        with AxisList[2] do
        begin
          Marks.LabelFont.Height := ThisResFactor * Marks.LabelFont.Height;
          Grid.Width := 2;
        end;
        Legend.Font.Height := ThisResFactor * Legend.Font.Height;
        Legend.FixedItemHeight := ThisResFactor * Legend.FixedItemHeight;
        Legend.Spacing := ThisResFactor * Legend.Spacing;
        Legend.SymbolWidth := ThisResFactor * Legend.SymbolWidth;
        Legend.Frame.Visible := ShowLegendFrame;
        Margins.Top := Margins.Top * ThisResFactor;
        Margins.Bottom := Margins.Bottom * ThisResFactor;
        MarginsExternal.Top := MarginsExternal.Top * ThisResFactor;
        MarginsExternal.Bottom := MarginsExternal.Bottom * ThisResFactor;
        for i := 0 to SeriesCount -1 do
          (Series[i] as TLineSeries).LinePen.Width := (Series[i] as TLineSeries).LinePen.Width * 2;
        PaintOnCanvas(bmp.Canvas, Rect(0, 0, bmp.Width, bmp.Height));
        //Reset resolution
        with AxisList[1] do
        begin
          Marks.LabelFont.Height := Round(Marks.LabelFont.Height / ThisResFactor);
          Marks.Distance := Round(Marks.Distance / ThisResFactor);
          Title.LabelFont.Height := Round(Title.LabelFont.Height / ThisResFactor);
          Grid.Width := 1;
          Intervals.MaxLength := Round(Intervals.MaxLength / ThisResFactor);
          Intervals.MinLength := Round(Intervals.MinLength / ThisResFactor);
          Title.Distance := Round(Title.Distance / ThisResFactor);
          TickLength := Round(TickLength / ThisResFactor);
        end;
        with AxisList[3] do
        begin
          Marks.LabelFont.Height := Round(Marks.LabelFont.Height / ThisResFactor);
          Marks.Distance := Round(Marks.Distance / ThisResFactor);
          Title.LabelFont.Height := Round(Title.LabelFont.Height / ThisResFactor);
          Grid.Width := 1;
          Intervals.MaxLength := Round(Intervals.MaxLength / ThisResFactor);
          Intervals.MinLength := Round(Intervals.MinLength / ThisResFactor);
          Title.Distance := Round(Title.Distance / ThisResFactor);
          TickLength := Round(TickLength / ThisResFactor);
        end;
        with AxisList[2] do
        begin
          Grid.Width := 1;
          Marks.LabelFont.Height := Round(Marks.LabelFont.Height / ThisResFactor);
        end;
        Legend.Font.Height := Round(Legend.Font.Height / ThisResFactor);
        Legend.FixedItemHeight := Round(Legend.FixedItemHeight / ThisResFactor);
        Legend.Spacing := Round(Legend.Spacing / ThisResFactor);
        Legend.SymbolWidth := Round(Legend.SymbolWidth / ThisResFactor);
        Margins.Top := 4;
        Margins.Bottom := 4;
        MarginsExternal.Top := Round(MarginsExternal.Top / ThisResFactor);
        MarginsExternal.Bottom := Round(MarginsExternal.Bottom / ThisResFactor);
        for i := 0 to SeriesCount -1 do
          (Series[i] as TLineSeries).LinePen.Width := Round((Series[i] as TLineSeries).LinePen.Width / 2);
        Color := clBtnFace;
      end;
    end;
    bmp.SaveToFile(SaveDialog1.FileName);
    bmp.Free;
  end;
end;

procedure TLogForm.MenuItemCopyClipClick(Sender: TObject);
begin
  cht.CopyToClipboardBitmap;
end;

procedure TLogForm.MenuItemJpegClick(Sender: TObject);
var
  jpg: TJPEGImage;
  i: Integer;
const
  ThisResFactor = 3;
begin
  with SaveDialog1 do
  begin
    InitialDir := WSpaceDir;
    DefaultExt := '.jpg';
    Filter := 'JPEG Image File (*.jpg)|*.jpg; *.JPG; *.Jpg; *.jpeg; *.JPEG; *.Jpeg|All Files (*.*)|*'
  end;
  if SaveDialog1.Execute then
  begin
    //create the jpeg
    jpg := TJPEGImage.Create;
    jpg.SetSize(ThisResFactor * cht.Width, ThisResFactor * cht.Height);
    if cht = LogChart then
    begin
      with cht do
      begin
        Color := clWhite;
        with LeftAxis do
        begin
          Marks.LabelFont.Height := ThisResFactor * Marks.LabelFont.Height;
          Title.LabelFont.Height := ThisResFactor * Title.LabelFont.Height;
          Grid.Width := 2;
        end;
        with AxisList[2] do //top axis
        begin
          Marks.LabelFont.Height := ThisResFactor * Marks.LabelFont.Height;
          Marks.Distance := Marks.Distance * ThisResFactor;
          Title.LabelFont.Height := ThisResFactor * Title.LabelFont.Height;
          Title.Distance := Title.Distance * ThisResFactor;
          TickLength := ThisResFactor * TickLength;
        end;
        with BottomAxis do //bottom axis
        begin
          Marks.LabelFont.Height := ThisResFactor * Marks.LabelFont.Height;
          Marks.Distance := Marks.Distance * ThisResFactor;
          Title.LabelFont.Height := ThisResFactor * Title.LabelFont.Height;
          Title.Distance := Title.Distance * ThisResFactor;
          TickLength := ThisResFactor * TickLength;
        end;
        Legend.Font.Height := ThisResFactor* Legend.Font.Height;
        Legend.FixedItemHeight := ThisResFactor * Legend.FixedItemHeight;
        Legend.Spacing := ThisResFactor * Legend.Spacing;
        Legend.SymbolWidth := ThisResFactor * Legend.SymbolWidth;
        Legend.Frame.Visible := ShowLegendFrame;
        Margins.Top := Margins.Top * ThisResFactor;
        Margins.Bottom := Margins.Bottom * ThisResFactor;
        MarginsExternal.Top := MarginsExternal.Top * ThisResFactor;
        MarginsExternal.Bottom := MarginsExternal.Bottom * ThisResFactor;
        for i := 0 to SeriesCount -1 do
        begin
          if Series[i] is TLineSeries then
          with (Series[i] as TLineSeries) do
          begin
            Pointer.HorizSize := Pointer.HorizSize * ThisResFactor;
            Pointer.VertSize := Pointer.VertSize * ThisResFactor;
            Marks.Distance := Marks.Distance * ThisResFactor;
            Marks.Margins.Left := Marks.Margins.Left * ThisResFactor;
            Marks.Margins.Right := Marks.Margins.Right * ThisResFactor;
            Marks.Margins.Top := Marks.Margins.Top * ThisResFactor;
            Marks.Margins.Bottom := Marks.Margins.Bottom * ThisResFactor;
            Marks.LabelFont.Height := Marks.LabelFont.Height * ThisResFactor;
            LinePen.Width := LinePen.Width * 2;
          end;
        end;
        LithLabels.Marks.LabelFont.Height := LithLabels.Marks.LabelFont.Height * ThisResFactor;
        PaintOnCanvas(jpg.Canvas, Rect(0, 0, jpg.Width, jpg.Height));
        //reset resolution back to previous values
        with LeftAxis do
        begin
          Marks.LabelFont.Height := Round(Marks.LabelFont.Height / ThisResFactor);
          Title.LabelFont.Height := Round(Title.LabelFont.Height / ThisResFactor);
          Grid.Width := 1;
        end;
        with AxisList[2] do //top axis
        begin
          Marks.LabelFont.Height := Round(Marks.LabelFont.Height / ThisResFactor);
          Marks.Distance := Round(Marks.Distance / ThisResFactor);
          Title.LabelFont.Height := Round(Title.LabelFont.Height / ThisResFactor);
          Title.Distance := Round(Title.Distance / ThisResFactor);
          TickLength := Round(TickLength / ThisResFactor);
        end;
        with BottomAxis do //bottom axis
        begin
          Marks.LabelFont.Height := Round(Marks.LabelFont.Height / ThisResFactor);
          Marks.Distance := Round(Marks.Distance / ThisResFactor);
          Title.LabelFont.Height := Round(Title.LabelFont.Height / ThisResFactor);
          Title.Distance := Round(Title.Distance / ThisResFactor);
          TickLength := Round(TickLength / ThisResFactor);
        end;
        for i := 0 to SeriesCount -1 do
        begin
          if Series[i] is TLineSeries then
          with (Series[i] as TLineSeries) do
          begin
            Pointer.HorizSize := Round(Pointer.HorizSize / ThisResFactor);
            Pointer.VertSize := Round(Pointer.VertSize / ThisResFactor);
            Marks.Distance := Round(Marks.Distance / ThisResFactor);
            Marks.Margins.Left := Round(Marks.Margins.Left / ThisResFactor);
            Marks.Margins.Right := Round(Marks.Margins.Right / ThisResFactor);
            Marks.Margins.Top := Round(Marks.Margins.Top / ThisResFactor);
            Marks.Margins.Bottom := Round(Marks.Margins.Bottom / ThisResFactor);
            Marks.LabelFont.Height := Round(Marks.LabelFont.Height / ThisResFactor);
            LinePen.Width := Round(LinePen.Width / 2);
          end;
        end;
        LithLabels.Marks.LabelFont.Height := Round(LithLabels.Marks.LabelFont.Height / ThisResFactor);
        Legend.Font.Height := Round(Legend.Font.Height / ThisResFactor);
        Legend.FixedItemHeight := Round(Legend.FixedItemHeight / ThisResFactor);
        Legend.Spacing := Round(Legend.Spacing / ThisResFactor);
        Legend.SymbolWidth := Round(Legend.SymbolWidth / ThisResFactor);
        Margins.Top := 4;
        Margins.Bottom := 4;
        MarginsExternal.Top := Round(MarginsExternal.Top / ThisResFactor);
        MarginsExternal.Bottom := Round(MarginsExternal.Bottom / ThisResFactor);
        Color := clBtnFace;
      end;
    end
    else
    if cht = DTHChart then
    begin
      with cht do
      begin
        Color := clWhite;
        with AxisList[1] do
        begin
          Marks.LabelFont.Height := ThisResFactor * Marks.LabelFont.Height;
          Marks.Distance := ThisResFactor * Marks.Distance;
          Grid.Width := 2;
          Title.LabelFont.Height := ThisResFactor * Title.LabelFont.Height;
          Intervals.MaxLength := Intervals.MaxLength * ThisResFactor;
          Intervals.MinLength := Intervals.MinLength * ThisResFactor;
          Title.Distance := Title.Distance * ThisResFactor;
          TickLength := TickLength * ThisResFactor;
        end;
        with AxisList[3] do
        begin
          Marks.LabelFont.Height := ThisResFactor * Marks.LabelFont.Height;
          Marks.Distance := ThisResFactor * Marks.Distance;
          Grid.Width := 2;
          Title.LabelFont.Height := ThisResFactor * Title.LabelFont.Height;
          Intervals.MaxLength := Intervals.MaxLength * ThisResFactor;
          Intervals.MinLength := Intervals.MinLength * ThisResFactor;
          Title.Distance := Title.Distance * ThisResFactor;
          TickLength := TickLength * ThisResFactor;
        end;
        with AxisList[2] do
        begin
          Marks.LabelFont.Height := ThisResFactor * Marks.LabelFont.Height;
          Grid.Width := 2;
        end;
        Legend.Font.Height := ThisResFactor * Legend.Font.Height;
        Legend.FixedItemHeight := ThisResFactor * Legend.FixedItemHeight;
        Legend.Spacing := ThisResFactor * Legend.Spacing;
        Legend.SymbolWidth := ThisResFactor * Legend.SymbolWidth;
        Legend.Frame.Visible := ShowLegendFrame;
        Margins.Top := Margins.Top * ThisResFactor;
        Margins.Bottom := Margins.Bottom * ThisResFactor;
        MarginsExternal.Top := MarginsExternal.Top * ThisResFactor;
        MarginsExternal.Bottom := MarginsExternal.Bottom * ThisResFactor;
        for i := 0 to SeriesCount -1 do
          (Series[i] as TLineSeries).LinePen.Width := (Series[i] as TLineSeries).LinePen.Width * 2;
        PaintOnCanvas(jpg.Canvas, Rect(0, 0, jpg.Width, jpg.Height));
        //Reset resolution
        with AxisList[1] do
        begin
          Marks.LabelFont.Height := Round(Marks.LabelFont.Height / ThisResFactor);
          Marks.Distance := Round(Marks.Distance / ThisResFactor);
          Title.LabelFont.Height := Round(Title.LabelFont.Height / ThisResFactor);
          Grid.Width := 1;
          Intervals.MaxLength := Round(Intervals.MaxLength / ThisResFactor);
          Intervals.MinLength := Round(Intervals.MinLength / ThisResFactor);
          Title.Distance := Round(Title.Distance / ThisResFactor);
          TickLength := Round(TickLength / ThisResFactor);
        end;
        with AxisList[3] do
        begin
          Marks.LabelFont.Height := Round(Marks.LabelFont.Height / ThisResFactor);
          Marks.Distance := Round(Marks.Distance / ThisResFactor);
          Title.LabelFont.Height := Round(Title.LabelFont.Height / ThisResFactor);
          Grid.Width := 1;
          Intervals.MaxLength := Round(Intervals.MaxLength / ThisResFactor);
          Intervals.MinLength := Round(Intervals.MinLength / ThisResFactor);
          Title.Distance := Round(Title.Distance / ThisResFactor);
          TickLength := Round(TickLength / ThisResFactor);
        end;
        with AxisList[2] do
        begin
          Grid.Width := 1;
          Marks.LabelFont.Height := Round(Marks.LabelFont.Height / ThisResFactor);
        end;
        Legend.Font.Height := Round(Legend.Font.Height / ThisResFactor);
        Legend.FixedItemHeight := Round(Legend.FixedItemHeight / ThisResFactor);
        Legend.Spacing := Round(Legend.Spacing / ThisResFactor);
        Legend.SymbolWidth := Round(Legend.SymbolWidth / ThisResFactor);
        Margins.Top := 4;
        Margins.Bottom := 4;
        MarginsExternal.Top := Round(MarginsExternal.Top / ThisResFactor);
        MarginsExternal.Bottom := Round(MarginsExternal.Bottom / ThisResFactor);
        for i := 0 to SeriesCount -1 do
          (Series[i] as TLineSeries).LinePen.Width := Round((Series[i] as TLineSeries).LinePen.Width / 2);
        Color := clBtnFace;
      end;
    end;
    jpg.SaveToFile(SaveDialog1.FileName);
    jpg.Free;
  end;
end;

procedure TLogForm.MenuItemTopDownClick(Sender: TObject);
begin
  cht.MarginsExternal.Top := cht.MarginsExternal.Top + 1;
end;

procedure TLogForm.MenuItemTopUpClick(Sender: TObject);
begin
  if cht.MarginsExternal.Top > 0 then
    cht.MarginsExternal.Top := cht.MarginsExternal.Top - 1;
end;

procedure TLogForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var i: Integer;
begin
  //free all the lithology bitmaps created during FormShow
  for i := 0 to 199 do
    if LithBmp[i] <> Nil then LithBmp[i].Free;
  for i := 0 to 29 do
    if FillBmp[i] <> Nil then FillBmp[i].Free;
  CloseAction := caFree;
end;

procedure TLogForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TLogForm.DTHChartDblClick(Sender: TObject);
begin
  DTHChart.ZoomFull;
  Screen.Cursor := crDefault;
end;

procedure TLogForm.DTHChartMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  DTHChart.SetFocus;
  cht := DTHChart;
end;

procedure TLogForm.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TLogForm.OKButtonClick(Sender: TObject);
var i: Word;
  ShowMyReport: Boolean;
begin
  ShowMyReport := True;
  //Check if width of form is smaller than 1.2 * height, otherwise will not fit on report
  if Width > Height * 1.2 then
    if MessageDlg('Your log form is out of proportion and may not fit onto the report! Do you want to continue anyway?', mtWarning, [mbYes, mbNo], 0) = mrNo then
      ShowMyReport := False;
  if ShowMyReport then
  with TLogReportSetForm.Create(Application) do
  begin
    with AvailableTablesList do
    begin
      Add('basicinf');
      Add('holediam');
      Add('constrct');
      Add('casing__');
      Add('aquifer_');
      Add('geology_');
      Add('holefill');
      Add('piezomet');
    end;
    LogChartWidth := LogChart.Width;
    //create the bitmaps
    bmp1 := TBitmap.Create;
    bmp1.SetSize(ResFactor * LogChart.Width, ResFactor * LogChart.Height);
    if Prep2Pages then
    begin
      CheckBoxSplitCharts.Enabled := True;
      bmp1Top := TBitmap.Create;
      bmp1Top.SetSize(ResFactor * LogChart.Width, ResFactor * LogChart.Height);
      bmp1Bot := TBitmap.Create;
      bmp1Bot.SetSize(ResFactor * LogChart.Width, ResFactor * LogChart.Height);
    end;
    if (DTHChart <> NIL) and Prep2Pages then
    begin
      bmp2Top := TBitmap.Create;
      bmp2Top.SetSize(ResFactor * DTHChart.Width, ResFactor * DTHChart.Height);
      bmp2Bot := TBitmap.Create;
      bmp2Bot.SetSize(ResFactor * DTHChart.Width, ResFactor * DTHChart.Height);
    end;
    with LogChart do
    begin
      Color := clWhite;
      with LeftAxis do
      begin
        Marks.LabelFont.Height := ResFactor * Marks.LabelFont.Height;
        Title.LabelFont.Height := ResFactor * Title.LabelFont.Height;
        Grid.Width := 2;
      end;
      with AxisList[2] do //top axis
      begin
        Marks.LabelFont.Height := ResFactor * Marks.LabelFont.Height;
        Marks.Distance := Marks.Distance * ResFactor;
        Title.LabelFont.Height := ResFactor * Title.LabelFont.Height;
        Title.Distance := Title.Distance * ResFactor;
        TickLength := ResFactor * TickLength;
      end;
      with BottomAxis do //bottom axis
      begin
        Marks.LabelFont.Height := ResFactor * Marks.LabelFont.Height;
        Marks.Distance := Marks.Distance * ResFactor;
        Title.LabelFont.Height := ResFactor * Title.LabelFont.Height;
        Title.Distance := Title.Distance * ResFactor;
        TickLength := ResFactor * TickLength;
      end;
      Legend.Font.Height := ResFactor* Legend.Font.Height;
      Legend.FixedItemHeight := ResFactor * Legend.FixedItemHeight;
      Legend.Spacing := ResFactor * Legend.Spacing;
      Legend.SymbolWidth := ResFactor * Legend.SymbolWidth;
      Legend.Frame.Visible := ShowLegendFrame;
      Margins.Top := Margins.Top * ResFactor;
      Margins.Bottom := Margins.Bottom * ResFactor;
      MarginsExternal.Top := MarginsExternal.Top * ResFactor;
      MarginsExternal.Bottom := MarginsExternal.Bottom * ResFactor;
      for i := 0 to SeriesCount -1 do
      begin
        if Series[i] is TLineSeries then
        with (Series[i] as TLineSeries) do
        begin
          Pointer.HorizSize := Pointer.HorizSize * ResFactor;
          Pointer.VertSize := Pointer.VertSize * ResFactor;
          Marks.Distance := Marks.Distance * ResFactor;
          Marks.Margins.Left := Marks.Margins.Left * ResFactor;
          Marks.Margins.Right := Marks.Margins.Right * ResFactor;
          Marks.Margins.Top := Marks.Margins.Top * ResFactor;
          Marks.Margins.Bottom := Marks.Margins.Bottom * ResFactor;
          Marks.LabelFont.Height := Marks.LabelFont.Height * ResFactor;
          LinePen.Width := LinePen.Width * 2;
        end;
      end;
      LithLabels.Marks.LabelFont.Height := LithLabels.Marks.LabelFont.Height * ResFactor;
      PaintOnCanvas(bmp1.Canvas, Rect(0, 0, bmp1.Width, bmp1.Height));
      //for 2 pages display of log
      if Prep2Pages then
      begin
        //Top extent
        Extent.YMax := DepthMax * TopExt; //half of depth
        Extent.UseYMax := True;
        PaintOnCanvas(bmp1Top.Canvas, Rect(0, 0, bmp1Top.Width, bmp1Top.Height));
        //Bottom extent
        Extent.YMin := DepthMax * TopExt;
        Extent.UseYMin := True;
        Extent.YMax := DepthMax;
        Extent.UseYMax := True;
        PaintOnCanvas(bmp1Bot.Canvas, Rect(0, 0, bmp1Bot.Width, bmp1Bot.Height));
        Extent.UseYMin := False;
        Extent.UseYMax := False;
      end;
      //reset resolution back to previous values
      with LeftAxis do
      begin
        Marks.LabelFont.Height := Round(Marks.LabelFont.Height / ResFactor);
        Title.LabelFont.Height := Round(Title.LabelFont.Height / ResFactor);
        Grid.Width := 1;
      end;
      with AxisList[2] do //top axis
      begin
        Marks.LabelFont.Height := Round(Marks.LabelFont.Height / ResFactor);
        Marks.Distance := Round(Marks.Distance / ResFactor);
        Title.LabelFont.Height := Round(Title.LabelFont.Height / ResFactor);
        Title.Distance := Round(Title.Distance / ResFactor);
        TickLength := Round(TickLength / ResFactor);
      end;
      with BottomAxis do //bottom axis
      begin
        Marks.LabelFont.Height := Round(Marks.LabelFont.Height / ResFactor);
        Marks.Distance := Round(Marks.Distance / ResFactor);
        Title.LabelFont.Height := Round(Title.LabelFont.Height / ResFactor);
        Title.Distance := Round(Title.Distance / ResFactor);
        TickLength := Round(TickLength / ResFactor);
      end;
      for i := 0 to SeriesCount -1 do
      begin
        if Series[i] is TLineSeries then
        with (Series[i] as TLineSeries) do
        begin
          Pointer.HorizSize := Round(Pointer.HorizSize / ResFactor);
          Pointer.VertSize := Round(Pointer.VertSize / ResFactor);
          Marks.Distance := Round(Marks.Distance / ResFactor);
          Marks.Margins.Left := Round(Marks.Margins.Left / ResFactor);
          Marks.Margins.Right := Round(Marks.Margins.Right / ResFactor);
          Marks.Margins.Top := Round(Marks.Margins.Top / ResFactor);
          Marks.Margins.Bottom := Round(Marks.Margins.Bottom / ResFactor);
          Marks.LabelFont.Height := Round(Marks.LabelFont.Height / ResFactor);
          LinePen.Width := Round(LinePen.Width / 2);
        end;
      end;
      LithLabels.Marks.LabelFont.Height := Round(LithLabels.Marks.LabelFont.Height / ResFactor);
      Legend.Font.Height := Round(Legend.Font.Height / ResFactor);
      Legend.FixedItemHeight := Round(Legend.FixedItemHeight / ResFactor);
      Legend.Spacing := Round(Legend.Spacing / ResFactor);
      Legend.SymbolWidth := Round(Legend.SymbolWidth / ResFactor);
      Margins.Top := 4;
      Margins.Bottom := 4;
      MarginsExternal.Top := Round(MarginsExternal.Top / ResFactor);
      MarginsExternal.Bottom := Round(MarginsExternal.Bottom / ResFactor);
      Color := clBtnFace;
    end;
    if DTHChart <> NIL then
    begin
      DTHChartVisibleOnReport := True;
      DTHChartWidth := DTHChart.Width;
      bmp2 := TBitmap.Create;
      bmp2.SetSize(ResFactor * DTHChartWidth, ResFactor * DTHChart.Height);
      with DTHChart do
      begin
        Color := clWhite;
        with AxisList[1] do
        begin
          Marks.LabelFont.Height := ResFactor * Marks.LabelFont.Height;
          Marks.Distance := ResFactor * Marks.Distance;
          Grid.Width := 2;
          Title.LabelFont.Height := ResFactor * Title.LabelFont.Height;
          Intervals.MaxLength := Intervals.MaxLength * ResFactor;
          Intervals.MinLength := Intervals.MinLength * ResFactor;
          Title.Distance := Title.Distance * ResFactor;
          TickLength := TickLength * ResFactor;
        end;
        with AxisList[3] do
        begin
          Marks.LabelFont.Height := ResFactor * Marks.LabelFont.Height;
          Marks.Distance := ResFactor * Marks.Distance;
          Grid.Width := 2;
          Title.LabelFont.Height := ResFactor * Title.LabelFont.Height;
          Intervals.MaxLength := Intervals.MaxLength * ResFactor;
          Intervals.MinLength := Intervals.MinLength * ResFactor;
          Title.Distance := Title.Distance * ResFactor;
          TickLength := TickLength * ResFactor;
        end;
        with AxisList[2] do
        begin
          Marks.LabelFont.Height := ResFactor * Marks.LabelFont.Height;
          Grid.Width := 2;
        end;
        Legend.Font.Height := ResFactor * Legend.Font.Height;
        Legend.FixedItemHeight := ResFactor * Legend.FixedItemHeight;
        Legend.Spacing := ResFactor * Legend.Spacing;
        Legend.SymbolWidth := ResFactor * Legend.SymbolWidth;
        Legend.Frame.Visible := ShowLegendFrame;
        Margins.Top := Margins.Top * ResFactor;
        Margins.Bottom := Margins.Bottom * ResFactor;
        MarginsExternal.Top := MarginsExternal.Top * ResFactor;
        MarginsExternal.Bottom := MarginsExternal.Bottom * ResFactor;
        for i := 0 to SeriesCount -1 do
          (Series[i] as TLineSeries).LinePen.Width := (Series[i] as TLineSeries).LinePen.Width * 2;
        PaintOnCanvas(bmp2.Canvas, Rect(0, 0, bmp2.Width, bmp2.Height));
        //for 2 pages display of log
        if Prep2Pages then
        begin
          //Top Extent
          Extent.YMax := DepthMax * TopExt;
          Extent.UseYMax := True;
          PaintOnCanvas(bmp2Top.Canvas, Rect(0, 0, bmp2Top.Width, bmp2Top.Height));
          //Bottom Extent
          Extent.YMin := DepthMax * TopExt;
          Extent.UseYMin := True;
          Extent.YMax := DepthMax;
          Extent.UseYMax := True;
          PaintOnCanvas(bmp2Bot.Canvas, Rect(0, 0, bmp2Bot.Width, bmp2Bot.Height));
          Extent.UseYMin := False;
          Extent.UseYMax := False;
        end;
        //Reset resolution
        with AxisList[1] do
        begin
          Marks.LabelFont.Height := Round(Marks.LabelFont.Height / ResFactor);
          Marks.Distance := Round(Marks.Distance / ResFactor);
          Title.LabelFont.Height := Round(Title.LabelFont.Height / ResFactor);
          Grid.Width := 1;
          Intervals.MaxLength := Round(Intervals.MaxLength / ResFactor);
          Intervals.MinLength := Round(Intervals.MinLength / ResFactor);
          Title.Distance := Round(Title.Distance / ResFactor);
          TickLength := Round(TickLength / ResFactor);
        end;
        with AxisList[3] do
        begin
          Marks.LabelFont.Height := Round(Marks.LabelFont.Height / ResFactor);
          Marks.Distance := Round(Marks.Distance / ResFactor);
          Title.LabelFont.Height := Round(Title.LabelFont.Height / ResFactor);
          Grid.Width := 1;
          Intervals.MaxLength := Round(Intervals.MaxLength / ResFactor);
          Intervals.MinLength := Round(Intervals.MinLength / ResFactor);
          Title.Distance := Round(Title.Distance / ResFactor);
          TickLength := Round(TickLength / ResFactor);
        end;
        with AxisList[2] do
        begin
          Grid.Width := 1;
          Marks.LabelFont.Height := Round(Marks.LabelFont.Height / ResFactor);
        end;
        Legend.Font.Height := Round(Legend.Font.Height / ResFactor);
        Legend.FixedItemHeight := Round(Legend.FixedItemHeight / ResFactor);
        Legend.Spacing := Round(Legend.Spacing / ResFactor);
        Legend.SymbolWidth := Round(Legend.SymbolWidth / ResFactor);
        Margins.Top := 4;
        Margins.Bottom := 4;
        MarginsExternal.Top := Round(MarginsExternal.Top / ResFactor);
        MarginsExternal.Bottom := Round(MarginsExternal.Bottom / ResFactor);
        for i := 0 to SeriesCount -1 do
          (Series[i] as TLineSeries).LinePen.Width := Round((Series[i] as TLineSeries).LinePen.Width / 2);
        Color := clBtnFace;
      end;
    end;
    ShowModal;
  end;
end;

end.

