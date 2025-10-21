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
unit QuickDTHChart;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, TASources, ZDataset, Forms,
  Controls, Graphics, Dialogs, XMLPropStorage, ButtonPanel, Menus, ComCtrls,
  TAChartUtils, TATools, TALegend, TATransformations, Types;

type

  { TQuickDTHChartForm }

  TQuickDTHChartForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    ChartToolset1: TChartToolset;
    ChartToolset1DataPointClickTool1: TDataPointClickTool;
    ChartToolset1PanDragTool1: TPanDragTool;
    ChartToolset1ZoomMouseWheelTool1: TZoomMouseWheelTool;
    Copyasbitmap1: TMenuItem;
    DTHChart: TChart;
    HorizGrid1: TMenuItem;
    Legend1: TMenuItem;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItemPoints: TMenuItem;
    N2: TMenuItem;
    PopupMenuCharts: TPopupMenu;
    Properties1: TMenuItem;
    QuickFormat1: TMenuItem;
    Saveas1: TMenuItem;
    SaveDialog: TSaveDialog;
    StatusBar1: TStatusBar;
    GetDataQuery: TZReadOnlyQuery;
    ListChartSourceBottom: TListChartSource;
    ListChartSourceDepth: TListChartSource;
    ListChartSourceTop: TListChartSource;
    VertGrid1: TMenuItem;
    XMLPropStorage1: TXMLPropStorage;
    procedure ChartToolset1DataPointClickTool1PointClick(ATool: TChartTool;
      APoint: TPoint);
    procedure CloseButtonClick(Sender: TObject);
    procedure Copyasbitmap1Click(Sender: TObject);
    procedure DTHChartClick(Sender: TObject);
    procedure DTHChartDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HorizGrid1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItemPointsClick(Sender: TObject);
    procedure Properties1Click(Sender: TObject);
    procedure Saveas1Click(Sender: TObject);
    procedure VertGrid1Click(Sender: TObject);
  private
    { private declarations }
    cht: TChart;
    TopLineSeries, BottomLineSeries: TLineSeries;
    TopBarSeries, BottomBarSeries: TBarSeries;
  public
    { public declarations }
    Depth1TableName, Depth2TableName, TopXFieldName, TopYFieldName, BotXFieldName, BotYFieldName: ShortString;
    TopSeriesTitle, BotSeriesTitle: ShortString;
    TheFactor: Double;
    BarWidthPerc: Word;
    IsBarChart: Boolean;
  end;

var
  QuickDTHChartForm: TQuickDTHChartForm;

implementation

{$R *.lfm}

uses varinit, chartproperties;

{ TQuickDTHChartForm }

procedure TQuickDTHChartForm.FormShow(Sender: TObject);
var m, DepthAxisInterval: Integer;
    TopAxisInterval, BottomAxisInterval, TopMax, TopMin, BottomMax, BottomMin, DepthMax, DepthMin, ai: Double;
    ext: TDoubleRect;
    TheSeriesColour: TColor;
begin
  //initialise some stuff
  cht := DTHChart;
  TopMax := 0;
  BottomMax := 0;
  DepthMax := 0;
  DepthMin := DTHChart.LeftAxis.Range.Min;
  Randomize;
  TheSeriesColour := Random(256*256*256);
  with DTHChart.LeftAxis do
  begin
    Title.Caption := 'Depth [' + LengthUnit + ']';
    Marks.Source := ListChartSourceDepth;
  end;
  with DTHChart.BottomAxis do //bottom axis
  begin
    Marks.Source := ListChartSourceBottom;
  end;
  with DTHChart.AxisList[2] do //right axis
  begin
    Marks.Source := ListChartSourceDepth;
    Title.Caption := 'Depth [' + LengthUnit + ']';
  end;
  with DTHChart.AxisList[3] do //top axis
  begin
    Marks.Source := ListChartSourceTop;
  end;
  //plot the series
  if Depth1TableName <> '<none>' then
  begin
    if IsBarChart then
    begin
      TopBarSeries := TBarSeries.Create(DTHChart);
      TopBarSeries.BarWidthPercent := BarWidthPerc;
      TopBarSeries.Title := TopSeriesTitle;
      TopBarSeries.BarBrush.Color := TheSeriesColour;
      DTHChart.AddSeries(TopBarSeries);
    end
    else
    begin
      TopLineSeries := TLineSeries.Create(DTHChart);
      TopLineSeries.Title := TopSeriesTitle;
      TopLineSeries.SeriesColor := TheSeriesColour;
      TopLineSeries.AxisIndexX := 3;
      TopLineSeries.AxisIndexY := 0;
      DTHChart.AddSeries(TopLineSeries);
    end;
    GetDataQuery.SQL.Clear;
    if TopYFieldName = 'DEPTH' then
    begin
      GetDataQuery.SQL.Add('SELECT SITE_ID_NR, DEPTH, ' + TopXFieldName + ' FROM ' + Depth1TableName);
      GetDataQuery.SQL.Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
      GetDataQuery.SQL.Add('ORDER BY DEPTH');
      GetDataQuery.Open;
      while not GetDataQuery.EOF do
      begin
        if IsBarChart then
          TopBarSeries.AddXY(GetDataQuery.FieldByName('DEPTH').Value, GetDataQuery.FieldByName(TopXFieldName).Value)
        else
          TopLineSeries.AddXY(GetDataQuery.FieldByName(TopXFieldName).Value, GetDataQuery.FieldByName('DEPTH').Value);
        if GetDataQuery.FieldByName(TopXFieldName).Value > TopMax then
          TopMax := GetDataQuery.FieldByName(TopXFieldName).Value;
        DepthMax := GetDataQuery.FieldByName('DEPTH').Value;
        GetDataQuery.Next;
      end;
      GetDataQuery.Close;
    end
    else
    if TopYFieldName = 'DEPTH_TOP' then
    begin
      GetDataQuery.SQL.Add('SELECT SITE_ID_NR, DEPTH_TOP, DEPTH_BOT, ' + TopXFieldName + ' FROM ' + Depth1TableName);
      GetDataQuery.SQL.Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
      GetDataQuery.SQL.Add('ORDER BY DEPTH_TOP');
      GetDataQuery.Open;
      if not IsBarChart then //Add the first zero value
        TopLineSeries.AddXY(0, GetDataQuery.FieldByName('DEPTH_TOP').Value);
      while not GetDataQuery.EOF do
      begin
        if Depth1TableName = 'penetrat' then //convert from saved m/min to current units
        begin
          if IsBarChart then
            TopBarSeries.AddXY(GetDataQuery.FieldByName('DEPTH_TOP').Value, 60/TimeFactor/GetDataQuery.FieldByName(TopXFieldName).AsFloat)
          else
          begin
            TopLineSeries.AddXY(60/TimeFactor/GetDataQuery.FieldByName(TopXFieldName).AsFloat, GetDataQuery.FieldByName('DEPTH_TOP').Value);
            TopLineSeries.AddXY(60/TimeFactor/GetDataQuery.FieldByName(TopXFieldName).AsFloat, GetDataQuery.FieldByName('DEPTH_BOT').Value);
          end;
          if 60/TimeFactor/GetDataQuery.FieldByName(TopXFieldName).AsFloat > TopMax then
            TopMax := 60/TimeFactor/GetDataQuery.FieldByName(TopXFieldName).AsFloat;
        end
        else
        begin
          if IsBarChart then
            TopBarSeries.AddXY(GetDataQuery.FieldByName('DEPTH_TOP').Value, GetDataQuery.FieldByName(TopXFieldName).Value)
          else
          begin
            TopLineSeries.AddXY(GetDataQuery.FieldByName(TopXFieldName).Value * TheFactor, GetDataQuery.FieldByName('DEPTH_TOP').Value);
            TopLineSeries.AddXY(GetDataQuery.FieldByName(TopXFieldName).Value * TheFactor, GetDataQuery.FieldByName('DEPTH_BOT').Value);
          end;
          if GetDataQuery.FieldByName(TopXFieldName).Value * TheFactor > TopMax then
            TopMax := GetDataQuery.FieldByName(TopXFieldName).Value * TheFactor;
        end;
        DepthMax := GetDataQuery.FieldByName('DEPTH_BOT').Value;
        GetDataQuery.Next;
      end;
      GetDataQuery.Close;
    end;
  end;
  if (Depth2TableName <> '') and (Depth2TableName <> '<none>') then
  begin
    if IsBarChart then
    begin
      BottomBarSeries := TBarSeries.Create(DTHChart);
      BottomBarSeries.BarWidthPercent := BarWidthPerc;
      BottomBarSeries.Title := BotSeriesTitle;
      DTHChart.AddSeries(TopBarSeries);
    end
    else
    begin
      BottomLineSeries := TLineSeries.Create(DTHChart);
      BottomLineSeries.Title := BotSeriesTitle;
      DTHChart.AddSeries(TopLineSeries);
    end;
    DTHChart.BottomAxis.Visible := True;
    DTHChart.BottomAxis.Marks.Visible := True;
    if Depth1TableName = '<none>' then
    begin
      DTHChart.BottomAxis.Transformations := NIL;
    end;
    GetDataQuery.SQL.Clear;
    if BotYFieldName = 'DEPTH' then
    begin
      GetDataQuery.SQL.Add('SELECT SITE_ID_NR, DEPTH, ' + BotXFieldName + ' FROM ' + Depth2TableName);
      GetDataQuery.SQL.Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
      GetDataQuery.SQL.Add('ORDER BY DEPTH');
      GetDataQuery.Open;
      while not GetDataQuery.EOF do
      begin
        if IsBarChart then
          BottomBarSeries.AddXY(GetDataQuery.FieldByName('DEPTH').Value, GetDataQuery.FieldByName(BotXFieldName).Value)
        else
          BottomLineSeries.AddXY(GetDataQuery.FieldByName(BotXFieldName).Value, GetDataQuery.FieldByName('DEPTH').Value);
        if GetDataQuery.FieldByName(BotXFieldName).Value > BottomMax then
          BottomMax := GetDataQuery.FieldByName(BotXFieldname).Value;
        DepthMax := GetDataQuery.FieldByName('DEPTH').Value;
        GetDataQuery.Next;
      end;
      GetDataQuery.Close;
    end
    else
    if BotYFieldName = 'DEPTH_TOP' then
    begin
      GetDataQuery.SQL.Add('SELECT SITE_ID_NR, DEPTH_TOP, DEPTH_BOT, ' + BotXFieldName + ' FROM ' + Depth2TableName);
      GetDataQuery.SQL.Add('WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
      GetDataQuery.SQL.Add('ORDER BY DEPTH_TOP');
      GetDataQuery.Open;
      if not IsBarChart then //Add the first zero value
        BottomLineSeries.AddXY(0, GetDataQuery.FieldByName('DEPTH_TOP').Value);
      while not GetDataQuery.EOF do
      begin
        if Depth2TableName = 'penetrat' then //convert from saved m/min to current units
        begin
          if IsBarChart then
            BottomBarSeries.AddXY(GetDataQuery.FieldByName('DEPTH_TOP').Value, 60/TimeFactor/GetDataQuery.FieldByName(BotXFieldName).AsFloat)
          else
          begin
            BottomLineSeries.AddXY(60/TimeFactor/GetDataQuery.FieldByName(BotXFieldName).AsFloat, GetDataQuery.FieldByName('DEPTH_TOP').Value);
            BottomLineSeries.AddXY(60/TimeFactor/GetDataQuery.FieldByName(BotXFieldName).AsFloat, GetDataQuery.FieldByName('DEPTH_BOT').Value);
          end;
          if 60/TimeFactor/(GetDataQuery.FieldByName(BotXFieldName).Value * LengthFactor) > BottomMax then
            BottomMax := 60/TimeFactor/(GetDataQuery.FieldByName(BotXFieldName).Value * LengthFactor);
        end
        else
        begin
          if IsBarChart then
            BottomBarSeries.AddXY(GetDataQuery.FieldByName('DEPTH_TOP').Value, GetDataQuery.FieldByName(BotXFieldName).Value)
          else
          begin
            BottomLineSeries.AddXY(GetDataQuery.FieldByName(BotXFieldName).Value * TheFactor, GetDataQuery.FieldByName('DEPTH_TOP').Value);
            BottomLineSeries.AddXY(GetDataQuery.FieldByName(BotXFieldName).Value * TheFactor, GetDataQuery.FieldByName('DEPTH_BOT').Value);
          end;
          if GetDataQuery.FieldByName(BotXFieldName).Value * TheFactor > BottomMax then
            BottomMax := GetDataQuery.FieldByName(BotXFieldName).Value * TheFactor;
        end;
        DepthMax := GetDataQuery.FieldByName('DEPTH_BOT').Value;
        GetDataQuery.Next;
      end;
      GetDataQuery.Close;
    end;
  end
  else
  begin
    DTHChart.BottomAxis.Title.Visible := False;
  end;
  //set depth axis intervals
  if DepthMax - DepthMin <= 10 then DepthAxisInterval := 1
  else if DepthMax - DepthMin <= 20 then DepthAxisInterval := 2
  else if DepthMax - DepthMin <= 100 then DepthAxisInterval := 5
  else if DepthMax - DepthMin <= 200 then DepthAxisInterval := 10
  else if DepthMax - DepthMin <= 500 then DepthAxisInterval := 25
  else DepthAxisInterval := 50;
  //populate the ListChartSourceDepth
  m := 0;
  while m < DepthMax do
  begin
    ListChartSourceDepth.Add(m, m);
    Inc(m, DepthAxisInterval);
  end;
  ListChartSourceDepth.Add(m, m);
  ext := DTHChart.GetFullExtent;
  //Set top axis maximum and minimum
  TopMin := DTHChart.AxisList[3].GetTransform.GraphToAxis(ext.a.X);
  if DTHChart.AxisList[3].Range.UseMax then
    TopMax := DTHChart.AxisList[3].Range.Max
  else
    TopMax := DTHChart.AxisList[3].GetTransform.GraphToAxis(ext.b.X);
  //set top and bottom axis intervals
  if TopMax - TopMin <= 1 then TopAxisInterval := 0.1
  else if TopMax - TopMin <= 5 then TopAxisInterval := 0.5
  else if TopMax - TopMin <= 10 then TopAxisInterval := 1
  else if TopMax - TopMin <= 20 then TopAxisInterval := 2
  else if TopMax - TopMin<= 100 then TopAxisInterval := 10
  else if TopMax - TopMin <= 200 then TopAxisInterval := 25
  else if TopMax - TopMin <= 500 then TopAxisInterval := 100
  else if TopMax - TopMin <= 1000 then TopAxisInterval := 200
  else if TopMax - TopMin <= 1500 then TopAxisInterval := 250
  else if TopMax - TopMin <= 2000 then TopAxisInterval := 500
  else if TopMax - TopMin <= 5000 then TopAxisInterval := 1000
  else if TopMax - TopMin <= 10000 then TopAxisInterval := 2500
  else if TopMax - TopMin <= 25000 then TopAxisInterval := 5000
  else if TopMax - TopMin <= 50000 then TopAxisInterval := 10000
  else TopAxisInterval := 25000;
  ai := 0;
  while ai < TopMax do
  begin
    ListChartSourceTop.Add(ai, ai);
    ai := ai + TopAxisInterval;
  end;
  ListChartSourceTop.Add(ai, ai);
  //Set bottom axis maximum and minimum
  if (Depth2TableName = '<none>') or (Depth2TableName = '') then
    DTHChart.BottomAxis.Marks.Source := ListChartSourceTop;
  BottomMin := DTHChart.BottomAxis.GetTransform.GraphToAxis(ext.a.X);
  if DTHChart.BottomAxis.Range.UseMax then
    BottomMax := DTHChart.BottomAxis.Range.Max
  else
    BottomMax := DTHChart.BottomAxis.GetTransform.GraphToAxis(ext.b.X);
  if BottomMax - BottomMin <= 1 then BottomAxisInterval := 0.1
  else if BottomMax - BottomMin <= 5 then BottomAxisInterval := 0.5
  else if BottomMax - BottomMin <= 10 then BottomAxisInterval := 1
  else if BottomMax - BottomMin <= 20 then BottomAxisInterval := 2
  else if BottomMax - BottomMin <= 100 then BottomAxisInterval := 10
  else if BottomMax - BottomMin <= 200 then BottomAxisInterval := 25
  else if BottomMax - BottomMin <= 500 then BottomAxisInterval := 100
  else if BottomMax - BottomMin <= 1000 then BottomAxisInterval := 200
  else if BottomMax - BottomMin <= 1500 then BottomAxisInterval := 250
  else if BottomMax - BottomMin <= 2000 then BottomAxisInterval := 500
  else if BottomMax - BottomMin <= 5000 then BottomAxisInterval := 1000
  else if BottomMax - BottomMin <= 10000 then BottomAxisInterval := 2500
  else if BottomMax - BottomMin <= 25000 then BottomAxisInterval := 5000
  else if BottomMax - BottomMin <= 50000 then BottomAxisInterval := 10000
  else BottomAxisInterval := 25000;
  ai := 0;
  while ai < BottomMax do
  begin
    ListChartSourceBottom.Add(ai, ai);
    ai := ai + BottomAxisInterval;
  end;
  ListChartSourceBottom.Add(ai, ai);
end;

procedure TQuickDTHChartForm.HorizGrid1Click(Sender: TObject);
begin
  HorizGrid1.Checked := not HorizGrid1.Checked;
  cht.LeftAxis.Grid.Visible := HorizGrid1.Checked;
end;

procedure TQuickDTHChartForm.MenuItem1Click(Sender: TObject);
begin
  cht.Legend.Visible := True;
  cht.Legend.Alignment := laTopRight;
end;

procedure TQuickDTHChartForm.MenuItem2Click(Sender: TObject);
begin
  cht.Legend.Visible := True;
  cht.Legend.Alignment := laTopLeft;
end;

procedure TQuickDTHChartForm.MenuItem3Click(Sender: TObject);
begin
  cht.Legend.Visible := True;
  cht.Legend.Alignment := laBottomCenter;
end;

procedure TQuickDTHChartForm.MenuItem4Click(Sender: TObject);
begin
  cht.Legend.Visible := False;
end;

procedure TQuickDTHChartForm.MenuItemPointsClick(Sender: TObject);
var
  s: Word;
begin
  with cht do
  begin
    for s := 0 to SeriesCount -1 do
      if Series[s] is TLineSeries then
        (Series[s] as TLineSeries).ShowPoints := (Sender as TMenuItem).Checked;
  end;
end;

procedure TQuickDTHChartForm.Properties1Click(Sender: TObject);
begin
  with TChartPropDlg.Create(Application) do
  begin
    TempChart := cht;
    Show;
  end;
end;

procedure TQuickDTHChartForm.Saveas1Click(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    if LowerCase(ExtractFileExt(SaveDialog.FileName)) = '.jpg' then
      cht.SaveToFile(TJPEGImage, SaveDialog.Filename)
    else
    if LowerCase(ExtractFileExt(SaveDialog.FileName)) = '.bmp' then
      cht.SaveToFile(TBitmap, SaveDialog.Filename)
    else
    if LowerCase(ExtractFileExt(SaveDialog.FileName)) = '.png' then
      cht.SaveToFile(TPortableNetworkGraphic, SaveDialog.Filename)
  end;
end;

procedure TQuickDTHChartForm.VertGrid1Click(Sender: TObject);
begin
  VertGrid1.Checked := not VertGrid1.Checked;
  cht.BottomAxis.Grid.Visible := VertGrid1.Checked;
end;

procedure TQuickDTHChartForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
end;

procedure TQuickDTHChartForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TQuickDTHChartForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TQuickDTHChartForm.ChartToolset1DataPointClickTool1PointClick(
  ATool: TChartTool; APoint: TPoint);
var
  x, y: Double;
begin
  with ATool as TDatapointClickTool do
    if (Series is TLineSeries) then
      with TLineSeries(Series) do begin
        x := GetXValue(PointIndex);
        y := GetYValue(PointIndex);
        Statusbar1.SimpleText := 'Point clicked: ' + cht.AxisList[3].Title.Caption + ' = ' + FloatToStr(x) + ', ' + cht.LeftAxis.Title.Caption + ' = ' + FloatToStr(y);
      end
    else
      Statusbar1.SimpleText := 'Mouse wheel zooms, Ctrl pans, ESC cancels pan, points click shows values, double-click zooms to full';
end;

procedure TQuickDTHChartForm.Copyasbitmap1Click(Sender: TObject);
begin
  cht.CopyToClipboardBitmap;
end;

procedure TQuickDTHChartForm.DTHChartClick(Sender: TObject);
begin
  (Sender as TChart).SetFocus;
  cht := (Sender as TChart);
end;

procedure TQuickDTHChartForm.DTHChartDblClick(Sender: TObject);
begin
  cht.ZoomFull;
  Screen.Cursor := crDefault;
end;

{ TQuickDTHChartForm }

end.

