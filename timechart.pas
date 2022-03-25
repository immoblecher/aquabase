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
unit timechart;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, TAGraph, TAChartExtentLink, TAChartUtils,
  TAIntervalSources, TASeries, TALegend, TATransformations, TATools, LCLType,
  TAMultiSeries, Forms, Controls, Graphics, Dialogs, ExtCtrls, XMLPropStorage,
  Menus, ComCtrls, ZDataset, dateutils, Types, typinfo, TADrawUtils,
  TADrawerSVG, TATextElements, TAFuncSeries, TAFitUtils, TASources,
  TACustomSeries
  {$IFDEF WINDOWS}
  , TADrawerWMF
  {$ENDIF};

type

  { TTimeChartForm }

  TTimeChartForm = class(TForm)
    ChartBotFitSeries1: TFitSeries;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItemTrendLine: TMenuItem;
    MenuItemSave: TMenuItem;
    MenuItemOpen: TMenuItem;
    OpenDialogTemplate: TOpenDialog;
    SaveDialogTemplate: TSaveDialog;
    TADateTimeIntervalChartSource: TDateTimeIntervalChartSource;
    MenuItem5: TMenuItem;
    MenuItemPointsVisible: TMenuItem;
    MenuItemFontSmaller: TMenuItem;
    MenuItemFontBigger: TMenuItem;
    MenuItemShowMarks: TMenuItem;
    MenuItemMarks: TMenuItem;
    MenuItemSmaller: TMenuItem;
    MenuItemBigger: TMenuItem;
    MenuItemPoints: TMenuItem;
    MenuItemThinner: TMenuItem;
    MenuItemThicker: TMenuItem;
    MenuItemLines: TMenuItem;
    MenuItemRefLine: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItemHelp: TMenuItem;
    TimeAutoScaleAxisTransform: TAutoScaleAxisTransform;
    TimeLogAxisTransform: TLogarithmAxisTransform;
    ChartToolset1: TChartToolset;
    ChartToolset1DataPointClickTool1: TDataPointClickTool;
    ChartToolset1PanDragTool1: TPanDragTool;
    ChartToolset1ZoomMouseWheelTool1: TZoomMouseWheelTool;
    RAutoScaleAxisTransform: TAutoScaleAxisTransform;
    RLogAxisTransform: TLogarithmAxisTransform;
    LAxisTransformations: TChartAxisTransformations;
    LAutoScaleAxisTransform: TAutoScaleAxisTransform;
    LLogAxisTransform: TLogarithmAxisTransform;
    ChartTop: TChart;
    ChartBot: TChart;
    ChartExtentLink1: TChartExtentLink;
    Copyasbitmap1: TMenuItem;
    BADateTimeIntervalChartSource: TDateTimeIntervalChartSource;
    HorizGrid1: TMenuItem;
    Legend1: TMenuItem;
    TimeAxisTransformations: TChartAxisTransformations;
    RAxisTransformations: TChartAxisTransformations;
    MenuItemLegendRight: TMenuItem;
    MenuItemLegendLeft: TMenuItem;
    MenuItemLegendBottom: TMenuItem;
    MenuItemLegendOff: TMenuItem;
    MenuItemLink: TMenuItem;
    N2: TMenuItem;
    PopupMenuCharts: TPopupMenu;
    Properties1: TMenuItem;
    QueryXY2: TZReadOnlyQuery;
    QueryXY3: TZReadOnlyQuery;
    QueryXY4: TZReadOnlyQuery;
    QuickFormat1: TMenuItem;
    Saveas1: TMenuItem;
    SaveDialogImage: TSaveDialog;
    Splitter1: TSplitter;
    QueryXY1: TZReadOnlyQuery;
    StatusBar1: TStatusBar;
    VertGrid1: TMenuItem;
    XMLPropStorage1: TXMLPropStorage;
    XMLPropStorage2: TXMLPropStorage;
    procedure ChartBotClick(Sender: TObject);
    procedure ChartBotDblClick(Sender: TObject);
    procedure ChartToolset1DataPointClickTool1PointClick(ATool: TChartTool;
      APoint: TPoint);
    procedure ChartTopClick(Sender: TObject);
    procedure ChartTopDblClick(Sender: TObject);
    procedure Copyasbitmap1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure HorizGrid1Click(Sender: TObject);
    procedure MenuItemBiggerClick(Sender: TObject);
    procedure MenuItemFontBiggerClick(Sender: TObject);
    procedure MenuItemFontSmallerClick(Sender: TObject);
    procedure MenuItemLegendRightClick(Sender: TObject);
    procedure MenuItemLegendLeftClick(Sender: TObject);
    procedure MenuItemLegendBottomClick(Sender: TObject);
    procedure MenuItemLegendOffClick(Sender: TObject);
    procedure MenuItemHelpClick(Sender: TObject);
    procedure MenuItemLinkClick(Sender: TObject);
    procedure MenuItemOpenClick(Sender: TObject);
    procedure MenuItemPointsVisibleClick(Sender: TObject);
    procedure MenuItemRefLineClick(Sender: TObject);
    procedure MenuItemSaveClick(Sender: TObject);
    procedure MenuItemShowMarksClick(Sender: TObject);
    procedure MenuItemSmallerClick(Sender: TObject);
    procedure MenuItemThickerClick(Sender: TObject);
    procedure MenuItemThinnerClick(Sender: TObject);
    procedure MenuItemTrendLineClick(Sender: TObject);
    procedure PopupMenuChartsPopup(Sender: TObject);
    procedure Properties1Click(Sender: TObject);
    procedure QueryXYAfterOpen(DataSet: TDataSet);
    procedure Saveas1Click(Sender: TObject);
    procedure VertGrid1Click(Sender: TObject);
    procedure CreateChemLimitLines(const TheTag: Byte);
  private
    { private declarations }
    cht: TChart;
  public
    { public declarations }
    TimeStep: Array[1..4] of Byte;
    SeriesType: Array[1..4] of Byte;
    Aggregate: Array[1..4] of Byte;
    TheFactor: Array[1..4] of Real;
    ShowLimits: Array[1..4] of Boolean;
    ChemParam, SeriesTitle, FilterValue: Array[1..4] of ShortString;
  end;

var
  TimeChartForm: TTimeChartForm;

implementation

{$R *.lfm}

uses MainDataModule, VARINIT, chartproperties, addrefline, addtrendline;

{ TTimeChartForm }

procedure TTimeChartForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TTimeChartForm.ChartTopDblClick(Sender: TObject);
begin
  ChartTop.ZoomFull;
  Screen.Cursor := crDefault;
end;

procedure TTimeChartForm.Copyasbitmap1Click(Sender: TObject);
begin
  cht.CopyToClipboardBitmap;
end;

procedure TTimeChartForm.ChartBotDblClick(Sender: TObject);
begin
  ChartBot.ZoomFull;
  Screen.Cursor := crDefault;
end;

procedure TTimeChartForm.ChartBotClick(Sender: TObject);
begin
  ChartBot.SetFocus;
  cht := ChartBot;
end;

procedure TTimeChartForm.ChartToolset1DataPointClickTool1PointClick(
  ATool: TChartTool; APoint: TPoint);
var
  x, y: Double;
begin
  with ATool as TDatapointClickTool do
    if (Series is TLineSeries) then
      with TLineSeries(Series) do
      begin
        x := FloatToDateTime(GetXValue(PointIndex));
        y := GetYValue(PointIndex);
        Statusbar1.SimpleText := 'Point clicked: ' + Title + ': Date/Time = ' + DateTimeToStr(x) + ', Y = ' + FloatToStr(y);
      end
    else
      Statusbar1.SimpleText := 'Mouse wheel zooms, Ctrl pans, ESC cancels pan, points click shows values, double-click zooms to full';
end;

procedure TTimeChartForm.ChartTopClick(Sender: TObject);
begin
  ChartTop.SetFocus;
  cht := ChartTop;
end;

procedure TTimeChartForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
end;

procedure TTimeChartForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F1) and (not (ssCtrl in Shift)) and (not (ssShift in Shift)) then
    DataModuleMain.OpenHelp(Sender);
end;

procedure TTimeChartForm.FormShow(Sender: TObject);
var
  exT, exB: TDoubleRect;
  TimeAxisMax, TimeAxisMin: Double;
  a: Byte;
begin
  try
    if QueryXY1.SQL.Text > '' then
    begin
      try
        Screen.Cursor := crSQLWait;
        QueryXY1.Open;
      finally
        Screen.Cursor := crDefault;
      end;
      ChartTop.Visible := True;
      Splitter1.Visible := ChartBot.Visible;
      ChartTop.LeftAxis.Visible := True;
      cht := ChartTop;
    end;
    if QueryXY2.SQL.Text > '' then
    begin
      try
        Screen.Cursor := crSQLWait;
        QueryXY2.Open;
      finally
        Screen.Cursor := crDefault;
      end;
      ChartTop.Visible := True;
      ChartTop.AxisList[2].Visible := True;
      ChartTop.AxisList[2].Marks.Visible := True;
      ChartTop.AxisList[2].Title.Visible := True;
      Splitter1.Visible := ChartBot.Visible;
      cht := ChartTop;
    end;
    if QueryXY3.SQL.Text > '' then
    begin
      try
        Screen.Cursor := crSQLWait;
        QueryXY3.Open;
      finally
        Screen.Cursor := crDefault;
      end;
      ChartBot.Visible := True;
      Splitter1.Visible := ChartTop.Visible;
      ChartBot.LeftAxis.Visible := True;
      if not ChartTop.Visible then
        cht := ChartBot;
    end;
    if QueryXY4.SQL.Text > '' then
    begin
      try
        Screen.Cursor := crSQLWait;
        QueryXY4.Open;
      finally
        Screen.Cursor := crDefault;
      end;
      ChartBot.Visible := True;
      ChartBot.AxisList[2].Visible := True;
      ChartBot.AxisList[2].Marks.Visible := True;
      ChartBot.AxisList[2].Title.Visible := True;
      Splitter1.Visible := ChartTop.Visible;
      if not ChartTop.Visible then
        cht := ChartBot;
    end;
    //set fonts of all axes
    for a := 0 to 3 do
    begin
      with ChartTop.AxisList[a] do
      begin
        Marks.LabelFont := AppFont;
        Marks.LabelFont.Size := AppFont.Size;
        Title.LabelFont := AppFont;
        Title.LabelFont.Size := AppFont.Size;
      end;
      with ChartBot.AxisList[a] do
      begin
        Marks.LabelFont := AppFont;
        Marks.LabelFont.Size := AppFont.Size;
        Title.LabelFont := AppFont;
        Title.LabelFont.Size := AppFont.Size;
      end;
    end;
    //set transformations to be the same for left and right axis if there is only one of them
    if (QueryXY1.SQL.Text > '') and (QueryXY2.SQL.Text = '') then
      ChartTop.AxisList[2].Transformations := LAxisTransformations;
    if (QueryXY2.SQL.Text > '') and (QueryXY1.SQL.Text = '') then
      ChartTop.AxisList[0].Transformations := RAxisTransformations;
    if (QueryXY3.SQL.Text > '') and (QueryXY4.SQL.Text = '') then
      ChartBot.AxisList[2].Transformations := LAxisTransformations;
    if (QueryXY4.SQL.Text > '') and (QueryXY3.SQL.Text = '') then
      ChartBot.AxisList[0].Transformations := RAxisTransformations;
    //set left and right axes orientation
    ChartTop.LeftAxis.Title.LabelFont.Orientation := 900;
    ChartTop.AxisList[2].Title.LabelFont.Orientation := 2700;
    ChartBot.LeftAxis.Title.LabelFont.Orientation := 900;
    ChartBot.AxisList[2].Title.LabelFont.Orientation := 2700;
    //set fonts of chart titles
    ChartTop.Title.Font := AppFont;
    ChartTop.Title.Font.Size := AppFont.Size;
    ChartTop.Foot.Font := AppFont;
    ChartTop.Foot.Font.Size := AppFont.Size - 1;
    ChartBot.Title.Font := AppFont;
    ChartBot.Title.Font.Size := AppFont.Size;
    ChartBot.Foot.Font := AppFont;
    ChartBot.Foot.Font.Size := AppFont.Size - 1;
    if not ChartBot.Visible then
    begin
      ChartTop.Align := alClient;
      ChartTop.SetFocus;
    end
    else
    begin
      if ChartTop.Visible then
      begin
        ChartBot.Align := alClient;
        Splitter1.Top := Round(ClientHeight / 2) - 2; //set to middle
        //make sure time axes have the same extent
        ChartTop.Prepare;
        exT := ChartTop.GetFullExtent;
        TimeAxisMin := ChartTop.BottomAxis.GetTransform.GraphToAxis(exT.a.X);
        TimeAxisMax := ChartTop.BottomAxis.GetTransform.GraphToAxis(exT.b.X);
        ChartBot.Prepare;
        exB := ChartBot.GetFullExtent;
        if TimeAxisMin > ChartBot.BottomAxis.GetTransform.GraphToAxis(exB.a.X) then
          TimeAxisMin := ChartBot.BottomAxis.GetTransform.GraphToAxis(exB.a.X);
        if TimeAxisMax < ChartBot.BottomAxis.GetTransform.GraphToAxis(exB.b.X) then
          TimeAxisMax := ChartBot.BottomAxis.GetTransform.GraphToAxis(exB.b.X);
        TimeAutoScaleAxisTransform.Enabled := False; //switch off autoscale
        with ChartTop.BottomAxis.Range do
        begin
          Min := TimeAxisMin;
          Max := TimeAxisMax;
          UseMin := True;
          UseMax := True;
        end;
        with ChartBot.BottomAxis.Range do
        begin
          Min := TimeAxisMin;
          Max := TimeAxisMax;
          UseMin := True;
          UseMax := True;
        end;
        with ChartTop.AxisList[3].Range do
        begin
          Min := TimeAxisMin;
          Max := TimeAxisMax;
          UseMin := True;
          UseMax := True;
        end;
        with ChartBot.AxisList[3].Range do
        begin
          Min := TimeAxisMin;
          Max := TimeAxisMax;
          UseMin := True;
          UseMax := True;
        end;
        exT.a.X := TimeAxisMin;
        exT.b.X := TimeAxisMax;
        ChartTop.Extent.FixTo(exT);
        exB.a.X := TimeAxisMin;
        exB.b.X := TimeAxisMax;
        ChartBot.Extent.FixTo(exB);
        MenuItemLink.Enabled := True;
        ChartTop.LeftAxis.Marks.LabelFont.Orientation := 900;
        ChartBot.LeftAxis.Marks.LabelFont.Orientation := 900;
        ChartTop.AxisList[2].Marks.LabelFont.Orientation := -900;
        ChartBot.AxisList[2].Marks.LabelFont.Orientation := -900;
        ChartTop.SetFocus;
      end
      else
        ChartBot.Align := alClient;
    end;
  except on E: Exception do
    begin
      MessageDlg(E.Message + ' - Oops, this didn''t work out... time-dependent charts could not be generated!', mtError, [mbOK], 0);
      Close;
    end;
  end;
  if Self.Height >= Screen.Height then //avoid forms bigger than screen
    Self.Height := Screen.Height - 20;
  Randomize;
end;

procedure TTimeChartForm.HorizGrid1Click(Sender: TObject);
begin
  HorizGrid1.Checked := not HorizGrid1.Checked;
  cht.LeftAxis.Grid.Visible := HorizGrid1.Checked;
end;

procedure TTimeChartForm.MenuItemBiggerClick(Sender: TObject);
var
  s: Word;
begin
  for s := 0 to cht.SeriesCount - 1 do
    if cht.Series[s] is TLineSeries then
    begin
      (cht.Series[s] as TLineSeries).Pointer.HorizSize := (cht.Series[s] as TLineSeries).Pointer.HorizSize + 1;
      (cht.Series[s] as TLineSeries).Pointer.VertSize := (cht.Series[s] as TLineSeries).Pointer.VertSize + 1;
    end;
end;

procedure TTimeChartForm.MenuItemFontBiggerClick(Sender: TObject);
var
  s: Word;
begin
  for s := 0 to cht.SeriesCount - 1 do
  begin
    if cht.Series[s] is TLineSeries then
      (cht.Series[s] as TLineSeries).Marks.LabelFont.Size := (cht.Series[s] as TLineSeries).Marks.LabelFont.Size + 1
    else
    if cht.Series[s] is TBarSeries then
      (cht.Series[s] as TBarSeries).Marks.LabelFont.Size := (cht.Series[s] as TBarSeries).Marks.LabelFont.Size + 1;
  end;
end;

procedure TTimeChartForm.MenuItemFontSmallerClick(Sender: TObject);
var
  s: Word;
begin
  for s := 0 to cht.SeriesCount - 1 do
  begin
    if cht.Series[s] is TLineSeries and ((cht.Series[s] as TLineSeries).Marks.LabelFont.Size > 1) then
      (cht.Series[s] as TLineSeries).Marks.LabelFont.Size := (cht.Series[s] as TLineSeries).Marks.LabelFont.Size - 1
    else
    if cht.Series[s] is TBarSeries and ((cht.Series[s] as TBarSeries).Marks.LabelFont.Size > 1) then
      (cht.Series[s] as TBarSeries).Marks.LabelFont.Size := (cht.Series[s] as TBarSeries).Marks.LabelFont.Size - 1;
  end;
end;

procedure TTimeChartForm.MenuItemLegendRightClick(Sender: TObject);
begin
  cht.Legend.Visible := True;
  cht.Legend.Alignment := laTopRight;
end;

procedure TTimeChartForm.MenuItemLegendLeftClick(Sender: TObject);
begin
  cht.Legend.Visible := True;
  cht.Legend.Alignment := laTopLeft;
end;

procedure TTimeChartForm.MenuItemLegendBottomClick(Sender: TObject);
begin
  cht.Legend.Visible := True;
  cht.Legend.Alignment := laBottomCenter;
end;

procedure TTimeChartForm.MenuItemLegendOffClick(Sender: TObject);
begin
  cht.Legend.Visible := False;
end;

procedure TTimeChartForm.MenuItemHelpClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TTimeChartForm.MenuItemLinkClick(Sender: TObject);
begin
  (Sender as TMenuItem).Checked := not (Sender as TMenuItem).Checked;
  ChartExtentLink1.Enabled := (Sender as TMenuItem).Checked; //link the 2 bottom axes
end;

procedure TTimeChartForm.MenuItemOpenClick(Sender: TObject);
begin
  OpenDialogTemplate.InitialDir := WSpaceDir;
  OpenDialogTemplate.FileName := '';
  SessionProperties := 'ChartTop.AxisList;ChartTop.Title;ChartTop.Foot;ChartTop.Color;ChartTop.BackColor;ChartTop.Legend;ChartTop.Margins;ChartTop.MarginsExternal;ChartBot.AxisList;ChartBot.Title;ChartTop.Foot;ChartBot.Color;ChartBot.BackColor;ChartBot.Legend;ChartBot.Margins;ChartBot.MarginsExternal';
  if OpenDialogTemplate.Execute then
  begin
    if ExtractFilename(OpenDialogTemplate.FileName) = 'map-providers.xml' then
    begin
      MessageDlg('This is not a valid time-dependent chart template!', mtError, [mbOK], 0);
      OpenDialogTemplate.FileName := '';
    end
    else
    with XMLPropStorage2 do
    begin
      FileName := OpenDialogTemplate.FileName;
      Active := True;
      Restore;
      Active := False;
    end;
  end;
  SessionProperties := 'Height;Left;Top;Width'
end;

procedure TTimeChartForm.MenuItemPointsVisibleClick(Sender: TObject);
var
  s: Word;
begin
  for s := 0 to cht.SeriesCount - 1 do
    if cht.Series[s] is TLineSeries then
      (cht.Series[s] as TLineSeries).ShowPoints := MenuItemPointsVisible.Checked;
end;

procedure TTimeChartForm.MenuItemRefLineClick(Sender: TObject);
var
  ex: TDoubleRect;
  RefLine: TLineSeries;
  TAxisMin, TAxisMax, TAxisMid: Double;
  TheName: ShortString;
begin
  {$IFDEF WINDOWS}
  if VerDiff > 3 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  begin
    ex := cht.LogicalExtent;
    with TAddLineForm.Create(Application) do
    begin
      LabeledEditY.Text := FloatToStrF(cht.LeftAxis.GetTransform.GraphToAxis(ex.b.Y), ffFixed, 15, 2);
      ShowModal;
      if ModalResult = mrOK then
      begin
        if LabeledEditName.Text = '' then
          TheName := 'Reference Line'
        else
          TheName := LabeledEditName.Text;
        RefLine := TLineSeries.Create(cht);
        with cht do
        begin
          TAxisMin := BottomAxis.GetTransform.GraphToAxis(ex.a.X);
          TAxisMax := BottomAxis.GetTransform.GraphToAxis(ex.b.X);
          TAxisMid := TAxisMin + (TAxisMax - TAxisMin)/2;
          with RefLine do
          begin
            case ComboBoxPos.ItemIndex of
              0: begin
                   AddXY(TAxisMin, StrToFloat(LabeledEditY.Text), TheName, ColorButton1.ButtonColor);
                   AddXY(TAxisMid, StrToFloat(LabeledEditY.Text), '', ColorButton1.ButtonColor);
                   AddXY(TAxisMax, StrToFloat(LabeledEditY.Text), '', ColorButton1.ButtonColor);
                   Marks.RotationCenter := rcLeft;
                 end;
              1: begin
                   AddXY(TAxisMin, StrToFloat(LabeledEditY.Text), '', ColorButton1.ButtonColor);
                   AddXY(TAxisMid, StrToFloat(LabeledEditY.Text), TheName, ColorButton1.ButtonColor);
                   AddXY(TAxisMax, StrToFloat(LabeledEditY.Text), '', ColorButton1.ButtonColor);
                 end;
              2: begin
                   AddXY(TAxisMin, StrToFloat(LabeledEditY.Text), '', ColorButton1.ButtonColor);
                   AddXY(TAxisMid, StrToFloat(LabeledEditY.Text), '', ColorButton1.ButtonColor);
                   AddXY(TAxisMax, StrToFloat(LabeledEditY.Text), TheName, ColorButton1.ButtonColor);
                   Marks.RotationCenter := rcRight;
                 end;
            end;
            SeriesColor := ColorButton1.ButtonColor;
            LinePen.Width := SpinEdit1.Value;
            LinePen.Style := TPenStyle(ComboBoxStyle.ItemIndex);
            ShowPoints := True;
            Pointer.HorizSize := 0;
            Pointer.VertSize := 0;
            AxisIndexX := 1;
            case ComboBoxAxis.ItemIndex of
              0: AxisIndexY := 0;
              1: AxisIndexY := 2;
            end;
            ZPosition := SeriesCount + 1; //on top of all other
            Title := TheName;
            if CheckBox1.Checked then
            with Marks do
            begin
              Style := smsLabel;
              AutoMargins := False;
              Distance := 10;
              Visible := True;
            end;
          end;
          AddSeries(RefLine);
        end;
      end;
      Close;
    end;
  end;
end;

procedure TTimeChartForm.MenuItemSaveClick(Sender: TObject);
begin
  SaveDialogTemplate.InitialDir := WSpaceDir;
  SaveDialogTemplate.FileName := '';
  SessionProperties := 'ChartTop.AxisList;ChartTop.Title;ChartTop.Foot;ChartTop.Color;ChartTop.BackColor;ChartTop.Legend;ChartTop.Margins;ChartTop.MarginsExternal;ChartBot.AxisList;ChartBot.Title;ChartTop.Foot;ChartBot.Color;ChartBot.BackColor;ChartBot.Legend;ChartBot.Margins;ChartBot.MarginsExternal';
  if SaveDialogTemplate.Execute then
  begin
    if ExtractFilename(SaveDialogTemplate.FileName) = 'map-providers.xml' then
        MessageDlg('You cannot save the settings to this file as it is not a valid chart template!', mtError, [mbOK], 0)
    else
    with XMLPropStorage2 do
    begin
      FileName := SaveDialogTemplate.FileName;
      Active := True;
      Save;
      Active := False;
    end;
  end;
  SessionProperties := 'Height;Left;Top;Width'
end;

procedure TTimeChartForm.MenuItemShowMarksClick(Sender: TObject);
var
  s: Word;
begin
  for s := 0 to cht.SeriesCount - 1 do
  begin
    if cht.Series[s] is TLineSeries then
    begin
      if MenuItemShowMarks.Checked then
        (cht.Series[s] as TLineSeries).Marks.Style := smsValue
      else
        (cht.Series[s] as TLineSeries).Marks.Style := smsNone;
    end
    else
    if cht.Series[s] is TBarSeries then
    begin
      if MenuItemShowMarks.Checked then
      (cht.Series[s] as TBarSeries).Marks.Style := smsValue
    else
      (cht.Series[s] as TBarSeries).Marks.Style := smsNone;
    end;
  end;
end;

procedure TTimeChartForm.MenuItemSmallerClick(Sender: TObject);
var
  s: Word;
begin
  for s := 0 to cht.SeriesCount - 1 do
    if (cht.Series[s] is TLineSeries) and ((cht.Series[s] as TLineSeries).Pointer.HorizSize > 1) then
    begin
      (cht.Series[s] as TLineSeries).Pointer.HorizSize := (cht.Series[s] as TLineSeries).Pointer.HorizSize - 1;
      (cht.Series[s] as TLineSeries).Pointer.VertSize := (cht.Series[s] as TLineSeries).Pointer.VertSize - 1;
    end;
end;

procedure TTimeChartForm.MenuItemThickerClick(Sender: TObject);
var
  s: Word;
begin
  for s := 0 to cht.SeriesCount - 1 do
    if cht.Series[s] is TLineSeries then
      (cht.Series[s] as TLineSeries).LinePen.Width := (cht.Series[s] as TLineSeries).LinePen.Width + 1;
end;

procedure TTimeChartForm.MenuItemThinnerClick(Sender: TObject);
var
  s: Word;
begin
  for s := 0 to cht.SeriesCount - 1 do
    if (cht.Series[s] is TLineSeries) and ((cht.Series[s] as TLineSeries).LinePen.Width > 1) then
      (cht.Series[s] as TLineSeries).LinePen.Width := (cht.Series[s] as TLineSeries).LinePen.Width - 1;
end;

procedure TTimeChartForm.MenuItemTrendLineClick(Sender: TObject);
var
  TrendLine: TFitSeries;
  FitSource: TListChartSource;
  TheName: ShortString;
  m: Word;
begin
  {$IFDEF WINDOWS}
  if VerDiff > 3 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  begin
    with TAddTrendLineForm.Create(Application) do
    begin
      {Add Series to ComboBox}
      ComboBoxSeries.Items.Clear;
      for m := 0 to cht.Series.Count - 1 do
        if cht.Series[m].Tag < 9999 then
          ComboBoxSeries.Items.Add((cht.Series[m] as TCustomChartSeries).Title);
      ComboBoxSeries.ItemIndex := 0;
      ShowModal;
      if ModalResult = mrOK then
      begin
        if LabeledEditName.Text = '' then
          TheName := 'Trendline'
        else
          TheName := LabeledEditName.Text;
        TrendLine := TFitSeries.Create(cht);
        with cht do
        begin
          with TrendLine do
          begin
            if Series[ComboBoxSeries.ItemIndex] is TLineSeries then
              FitSource := (Series[ComboBoxSeries.ItemIndex] as TLineSeries).ListSource
            else
              FitSource := (Series[ComboBoxSeries.ItemIndex] as TBarSeries).ListSource;
            Source := FitSource;
            FitEquation := TFitEquation(ComboBoxFit.ItemIndex);
            Pen.Color := ColorButton1.ButtonColor;
            Pen.Width := SpinEdit1.Value;
            Pen.Style := TPenStyle(ComboBoxStyle.ItemIndex);
            Pointer.HorizSize := 0;
            Pointer.VertSize := 0;
            Pointer.Visible := False;
            AxisIndexX := 1;
            case ComboBoxAxis.ItemIndex of
              0: AxisIndexY := 0;
              1: AxisIndexY := 2;
            end;
            ZPosition := SeriesCount + 1; //on top of all other
            Title := TheName;
          end;
          AddSeries(TrendLine);
        end;
      end;
      Close;
    end;
  end;
end;

procedure TTimeChartForm.PopupMenuChartsPopup(Sender: TObject);
var
  s: Word;
begin
  MenuItemLegendOff.Checked := cht.Legend.Visible;
  MenuItemLegendRight.Checked := cht.Legend.Visible and (cht.Legend.Alignment = laTopRight);
  MenuItemLegendLeft.Checked := cht.Legend.Visible and (cht.Legend.Alignment = laTopLeft);
  MenuItemLegendBottom.Checked := cht.Legend.Visible and (cht.Legend.Alignment = laBottomCenter);
  for s := 0 to cht.SeriesCount - 1 do
    if cht.Series[s] is TLineSeries and (cht.Series[s] as TLineSeries).ShowPoints and not MenuItemPointsVisible.Checked then
      MenuItemPointsVisible.Checked := True;
  for s := 0 to cht.SeriesCount - 1 do
  begin
    if cht.Series[s] is TLineSeries and ((cht.Series[s] as TLineSeries).Marks.Style <> smsNone) and not MenuItemShowMarks.Checked then
      MenuItemShowMarks.Checked := True
    else
    if cht.Series[s] is TBarSeries and ((cht.Series[s] as TBarSeries).Marks.Style <> smsNone) and not MenuItemShowMarks.Checked then
      MenuItemShowMarks.Checked := True;
  end;
end;

procedure TTimeChartForm.Properties1Click(Sender: TObject);
begin
  with TChartPropDlg.Create(Self) do
  begin
    TempChart := cht;
    TempLogAxis[0] := LLogAxisTransform;
    TempLogAxis[1] := TimeLogAxisTransform;
    TempLogAxis[2] := RLogAxisTransform;
    TempLogAxis[3] := TimeLogAxisTransform;
    TempChart.AxisList[1].Marks.Source := BADateTimeIntervalChartSource;
    TempChart.AxisList[3].Marks.Source := TADateTimeIntervalChartSource;
    XisDateTime := True;
    Show;
  end;
end;

procedure TTimeChartForm.QueryXYAfterOpen(DataSet: TDataSet);
var
  TheDateTime: TDateTime;
  Y, M, D, H, N: Word;
  SiteID, TheFilter: ShortString;
  TheLineSeries: TLineSeries;
  TheBarSeries: TBarSeries;
  TheListChartSource: TListChartSource;
  TheSeriesColour: TColor;
  RecCount: Integer;
begin
  SiteID := '';
  TheFilter := '';
  RecCount := DataSet.RecordCount;
  if DataSet.Tag <= 2 then //for the top chart
    cht := ChartTop
  else //for the bottom chart
    cht := ChartBot;
  while not DataSet.EOF do
  begin
    if (SiteID <> DataSet.Fields[0].AsString) //check whether SiteID or Filter has changed
      or (TheFilter <> DataSet.FieldByName('THEFILTER').AsString) then
    begin
      //create ListChartSource
      TheListChartSource := TListChartSource.Create(cht);
      //create the series
      TheSeriesColour := Random(256*256*256);
      if SeriesType[DataSet.Tag] = 1 then //bar series
      begin
        TheBarSeries := TBarSeries.Create(cht);
        TheBarSeries.Source := TheListChartSource;
        TheBarSeries.Title := SeriesTitle[DataSet.Tag] + FilterValue[DataSet.Tag] + ': ' + DataSet.Fields[0].AsString;
        if not DataSet.Fields[1].IsNull then
          TheBarSeries.Title := TheBarSeries.Title + ' - ' + DataSet.Fields[1].AsString;
        if DataSet.FindField('CHEMREF') <> NIL then
          TheBarSeries.Title := TheBarSeries.Title + ' - ' + DataSet.Fields[2].AsString;
        TheBarSeries.AxisIndexX := 1;
        case DataSet.Tag of
          1, 3: TheBarSeries.AxisIndexY := 0;
          2, 4: TheBarSeries.AxisIndexY := 2;
        end;
        TheBarSeries.SeriesColor := TheSeriesColour;
        TheBarSeries.Marks.LabelFont := AppFont;
        cht.AddSeries(TheBarSeries);
      end
      else //line series
      begin
        TheLineSeries := TLineSeries.Create(cht);
        TheLineSeries.Source := TheListChartSource;
        TheLineSeries.Title := SeriesTitle[DataSet.Tag] + FilterValue[DataSet.Tag] + ': ' + DataSet.Fields[0].AsString;
        if not DataSet.Fields[1].IsNull then
          TheLineSeries.Title := TheLineSeries.Title + ' - ' + DataSet.Fields[1].AsString;
        if DataSet.FindField('CHEMREF') <> NIL then
          TheLineSeries.Title := TheLineSeries.Title + ' - ' + DataSet.Fields[2].AsString;
        TheLineSeries.AxisIndexX := 1;
        case DataSet.Tag of
          1, 3: TheLineSeries.AxisIndexY := 0;
          2, 4: TheLineSeries.AxisIndexY := 2;
        end;
        TheLineSeries.ZPosition := 1; //make sure they are over bars, if any
        TheLineSeries.SeriesColor := TheSeriesColour;
        TheLineSeries.Pointer.Brush.Color := TheSeriesColour;
        TheLineSeries.Marks.LabelFont := AppFont;
        cht.AddSeries(TheLineSeries);
      end;
    end;
    SiteID := DataSet.Fields[0].AsString;
    TheFilter := DataSet.Fields[3].AsString;
    //convert date to DateTime
    Y := StrToInt(Copy(DataSet.FieldByName('THEDATE').AsString, 1, 4));
    if Length(DataSet.FieldByName('THEDATE').AsString) > 4 then
      M := StrToInt(Copy(DataSet.FieldByName('THEDATE').AsString, 5, 2));
    if Length(DataSet.FieldByName('THEDATE').AsString) > 6 then
      D := StrToInt(Copy(DataSet.FieldByName('THEDATE').AsString, 7, 2));
    if DataSet.FindField('THETIME') <> NIL then
    begin
      H := StrToInt(Copy(DataSet.FieldByName('THETIME').AsString, 1, 2));
      N := StrToInt(Copy(DataSet.FieldByName('THETIME').AsString, 3, 2));
    end;
    //for aggregates to plot in the middle of year/month/day
    case TimeStep[DataSet.Tag] of
      3: begin //annually
           M := 6;
           D := 15;
           H := 12;
           N := 0;
         end;
      2: begin //monthly
           D := 15;
           H := 12;
           N := 0;
         end;
      1: begin //daily
           H := 12;
           N := 0;
         end;
    end; //of case
    TheDateTime := EncodeDateTime(Y, M, D, H, N, 0, 0);
    //populate list with query values
    with TheListChartSource do
    begin
      if DataSet.FindField('THEVALUE') <> NIL then //exact time steps
      begin
        if (not DataSet.FieldByName('THEVALUE').IsNull) then
          Add(TheDateTime, DataSet.FieldByName('THEVALUE').Value * TheFactor[DataSet.Tag], DataSet.FieldByName('THEVALUE').AsString)
      end
      else //Aggregates
      case Aggregate[DataSet.Tag] of
        0: if not DataSet.FieldByName('AVERAGE').IsNull then
               Add(TheDateTime, DataSet.FieldByName('AVERAGE').Value * TheFactor[DataSet.Tag], DataSet.FieldByName('AVERAGE').AsString);
        1: if not DataSet.FieldByName('MINIMUM').IsNull then
               Add(TheDateTime, DataSet.FieldByName('MINIMUM').Value * TheFactor[DataSet.Tag], DataSet.FieldByName('MINIMUM').AsString);
        2: if not DataSet.FieldByName('MAXIMUM').IsNull then
               Add(TheDateTime, DataSet.FieldByName('MAXIMUM').Value * TheFactor[DataSet.Tag], DataSet.FieldByName('MAXIMUM').AsString);
        3: if not DataSet.FieldByName('SUMMED').IsNull then
               Add(TheDateTime, DataSet.FieldByName('SUMMED').Value * TheFactor[DataSet.Tag], DataSet.FieldByName('SUMMED').AsString);
      end; //of case
    end;
    DataSet.Next;
  end;
  //check if there is enough data for chart and provide message in title, if not
  if (DataSet.Tag <= 2) and (RecCount <= 1) then
  begin
    ChartTop.Title.Text.Clear;
    ChartTop.Title.Text.Add('Not enough data for this time dependent parameter in selected time range available!');
  end
  else
  if (DataSet.Tag >= 3) and (RecCount <= 1) then
  begin
    ChartBot.Title.Text.Clear;
    ChartBot.Title.Text.Add('Not enough data for this time dependent parameter in selected time range available!');
  end;
  //constant lines for limits
  if (DataSet.FindField('CHEMREF') <> NIL) and ShowLimits[DataSet.Tag] then //add the chemistry limits, if selected
    CreateChemLimitLines(DataSet.Tag)
  else //dynamic and critical water levels
  begin

  end;
  DataSet.Close;
end;

procedure TTimeChartForm.CreateChemLimitLines(const TheTag: Byte);
var
  TheConstantLine: TConstantLine;
  c: Byte;
  IsClasses: Boolean;
begin
  with DataModuleMain.StandDescrTable do
  begin
    Open;
    Locate('ID', ChemStandard, []);
    Close;
  end;
  IsClasses := DataModuleMain.ClassTable.Active;
  if IsClasses then
  begin
    if DataModuleMain.ClassTable.Locate('PARAMETER', ChemParam[TheTag], []) then
    for c := 0 to 3 do
    begin
      TheConstantLine := TConstantLine.Create(cht);
      cht.AddSeries(TheConstantLine);
      TheConstantLine.SeriesColor := ClassColor[c];
      TheConstantLine.Pen.Style := psDash;
      TheConstantLine.Pen.Width := 2;
      TheConstantLine.AxisIndex := TheTag - 1; //0-based axes
      TheConstantLine.UseBounds := True;
      TheConstantLine.ZPosition := 2;
      TheConstantLine.Title := ChemParam[TheTag] + ' - Class ' + IntToStr(c);
      TheConstantLine.Position := DataModuleMain.ClassTable.FieldByName('Class' + IntToStr(c)).Value * TheFactor[TheTag];
    end;
  end
  else //all other standards
  begin
    if DataModuleMain.StandardTable.Locate('PARAMETER', ChemParam[TheTag], []) then
    for c := 4 to 7 do
    if DataModuleMain.StandardTable.Fields[c].Value >= 0 then
    begin
      TheConstantLine := TConstantLine.Create(cht);
      cht.AddSeries(TheConstantLine);
      TheConstantLine.SeriesColor := ClassColor[c-4];
      TheConstantLine.Pen.Style := psDash;
      TheConstantLine.Pen.Width := 2;
      TheConstantLine.AxisIndex := TheTag - 1; //0-based axes
      TheConstantLine.UseBounds := True;
      TheConstantLine.ZPosition := 2;
      TheConstantLine.Title := ChemParam[TheTag] + ' - ' + DataModuleMain.StandardTable.Fields[c].FieldName;
      TheConstantLine.Position := DataModuleMain.StandardTable.Fields[c].Value * TheFactor[TheTag];
    end;
  end;
end;

procedure TTimeChartForm.Saveas1Click(Sender: TObject);
var
  fs: TFileStream;
  id: IChartDrawer;
begin
  if SaveDialogImage.Execute then
  begin
    if LowerCase(ExtractFileExt(SaveDialogImage.FileName)) = '.jpg' then
      cht.SaveToFile(TJPEGImage, SaveDialogImage.Filename)
    else
    if LowerCase(ExtractFileExt(SaveDialogImage.FileName)) = '.bmp' then
      cht.SaveToFile(TBitmap, SaveDialogImage.Filename)
    {$IFDEF WINDOWS}
    else
    if LowerCase(ExtractFileExt(SaveDialogImage.Filename)) = '.wmf' then
      cht.SaveToWMF(SaveDialogImage.FileName)
    {$ENDIF}
    else
    if LowerCase(ExtractFileExt(SaveDialogImage.FileName)) = '.png' then
      cht.SaveToFile(TPortableNetworkGraphic, SaveDialogImage.Filename)
    else
    if LowerCase(ExtractFileExt(SaveDialogImage.Filename)) = '.svg' then
    begin
      fs := TFileStream.Create(SaveDialogImage.FileName, fmCreate);
      try
        id := TSVGDrawer.Create(fs, true);
        with cht do
          Draw(id, Rect(0, 0, Width, Height));
      finally
        fs.Free;
      end;
    end;
  end;
end;

procedure TTimeChartForm.VertGrid1Click(Sender: TObject);
begin
  VertGrid1.Checked := not VertGrid1.Checked;
  cht.BottomAxis.Grid.Visible := VertGrid1.Checked;
end;

end.

