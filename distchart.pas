{ Copyright (C) 2025 Immo Blecher, immo@blecher.co.za

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
unit distchart;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, TAGraph, TAChartExtentLink, TAChartUtils,
  TASeries, TALegend, TATransformations, TATools, LCLType,
  TAMultiSeries, Forms, Controls, Graphics, Dialogs, ExtCtrls, XMLPropStorage,
  Menus, ComCtrls, ZDataset, dateutils, Types, typinfo, TADrawUtils,
  TADrawerSVG, TATextElements, TAFuncSeries, TAFitUtils, TASources,
  TACustomSeries
  {$IFDEF WINDOWS}
  , TADrawerWMF
  {$ENDIF};

type

  { TDistChartForm }

  TDistChartForm = class(TForm)
    ChartBotFitSeries1: TFitSeries;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItemTrendLine: TMenuItem;
    MenuItemSave: TMenuItem;
    MenuItemOpen: TMenuItem;
    OpenDialogTemplate: TOpenDialog;
    SaveDialogTemplate: TSaveDialog;
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
    HorizGrid1: TMenuItem;
    Legend1: TMenuItem;
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
  private
    { private declarations }
    cht: TChart;
  public
    { public declarations }
    TimeStep: Array[1..4] of Byte;
    SeriesType: Array[1..4] of Byte;
    Aggregate: Array[1..4] of Byte;
    TheFactor: Array[1..4] of Real;
    SeriesTitle, FilterValue: Array[1..4] of ShortString;
    Spacing1, Spacing2: Byte;
    Value1, Value2, Value3: ShortString;
  end;

var
  DistChartForm: TDistChartForm;

implementation

{$R *.lfm}

uses MainDataModule, VARINIT, chartproperties, addrefline, addtrendline;

{ TDistChartForm }

procedure TDistChartForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TDistChartForm.ChartTopDblClick(Sender: TObject);
begin
  ChartTop.ZoomFull;
  Screen.Cursor := crDefault;
end;

procedure TDistChartForm.Copyasbitmap1Click(Sender: TObject);
begin
  cht.CopyToClipboardBitmap;
end;

procedure TDistChartForm.ChartBotDblClick(Sender: TObject);
begin
  ChartBot.ZoomFull;
  Screen.Cursor := crDefault;
end;

procedure TDistChartForm.ChartBotClick(Sender: TObject);
begin
  ChartBot.SetFocus;
  cht := ChartBot;
end;

procedure TDistChartForm.ChartToolset1DataPointClickTool1PointClick(
  ATool: TChartTool; APoint: TPoint);
var
  x, y: Double;
begin
  with ATool as TDatapointClickTool do
    if (Series is TLineSeries) then
      with TLineSeries(Series) do
      begin
        x := GetXValue(PointIndex);
        y := GetYValue(PointIndex);
        Statusbar1.SimpleText := 'Point clicked: ' + Title + ': Distance/Station = ' + FloatToStr(x) + ', Y = ' + FloatToStr(y);
      end
    else
      Statusbar1.SimpleText := 'Mouse wheel zooms, Ctrl pans, ESC cancels pan, points click shows values, double-click zooms to full';
end;

procedure TDistChartForm.ChartTopClick(Sender: TObject);
begin
  ChartTop.SetFocus;
  cht := ChartTop;
end;

procedure TDistChartForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
end;

procedure TDistChartForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F1) and (not (ssCtrl in Shift)) and (not (ssShift in Shift)) then
    DataModuleMain.OpenHelp(Sender);
end;

procedure TDistChartForm.FormShow(Sender: TObject);
var
  exT, exB: TDoubleRect;
  DistAxisMax, DistAxisMin: Double;
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
    for a := 0 to 2 do
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
        //make sure bottom axes have the same extent
        ChartTop.Prepare;
        exT := ChartTop.GetFullExtent;
        DistAxisMin := ChartTop.BottomAxis.GetTransform.GraphToAxis(exT.a.X);
        DistAxisMax := ChartTop.BottomAxis.GetTransform.GraphToAxis(exT.b.X);
        ChartBot.Prepare;
        exB := ChartBot.GetFullExtent;
        if DistAxisMin > ChartBot.BottomAxis.GetTransform.GraphToAxis(exB.a.X) then
          DistAxisMin := ChartBot.BottomAxis.GetTransform.GraphToAxis(exB.a.X);
        if DistAxisMax < ChartBot.BottomAxis.GetTransform.GraphToAxis(exB.b.X) then
          DistAxisMax := ChartBot.BottomAxis.GetTransform.GraphToAxis(exB.b.X);
        with ChartTop.BottomAxis.Range do
        begin
          Min := DistAxisMin;
          Max := DistAxisMax;
          UseMin := True;
          UseMax := True;
        end;
        with ChartBot.BottomAxis.Range do
        begin
          Min := DistAxisMin;
          Max := DistAxisMax;
          UseMin := True;
          UseMax := True;
        end;
        exT.a.X := DistAxisMin;
        exT.b.X := DistAxisMax;
        ChartTop.Extent.FixTo(exT);
        exB.a.X := DistAxisMin;
        exB.b.X := DistAxisMax;
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
      MessageDlg(E.Message + ' - Oops, this didn''t work out... distance-dependent charts could not be generated!', mtError, [mbOK], 0);
      Close;
    end;
  end;
  if Self.Height >= Screen.Height then //avoid forms bigger than screen
    Self.Height := Screen.Height - 20;
  Randomize;
end;

procedure TDistChartForm.HorizGrid1Click(Sender: TObject);
begin
  HorizGrid1.Checked := not HorizGrid1.Checked;
  cht.LeftAxis.Grid.Visible := HorizGrid1.Checked;
end;

procedure TDistChartForm.MenuItemBiggerClick(Sender: TObject);
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

procedure TDistChartForm.MenuItemFontBiggerClick(Sender: TObject);
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

procedure TDistChartForm.MenuItemFontSmallerClick(Sender: TObject);
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

procedure TDistChartForm.MenuItemLegendRightClick(Sender: TObject);
begin
  cht.Legend.Visible := True;
  cht.Legend.Alignment := laTopRight;
end;

procedure TDistChartForm.MenuItemLegendLeftClick(Sender: TObject);
begin
  cht.Legend.Visible := True;
  cht.Legend.Alignment := laTopLeft;
end;

procedure TDistChartForm.MenuItemLegendBottomClick(Sender: TObject);
begin
  cht.Legend.Visible := True;
  cht.Legend.Alignment := laBottomCenter;
end;

procedure TDistChartForm.MenuItemLegendOffClick(Sender: TObject);
begin
  cht.Legend.Visible := False;
end;

procedure TDistChartForm.MenuItemHelpClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TDistChartForm.MenuItemLinkClick(Sender: TObject);
begin
  (Sender as TMenuItem).Checked := not (Sender as TMenuItem).Checked;
  ChartExtentLink1.Enabled := (Sender as TMenuItem).Checked; //link the 2 bottom axes
end;

procedure TDistChartForm.MenuItemOpenClick(Sender: TObject);
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

procedure TDistChartForm.MenuItemPointsVisibleClick(Sender: TObject);
var
  s: Word;
begin
  for s := 0 to cht.SeriesCount - 1 do
    if cht.Series[s] is TLineSeries then
      (cht.Series[s] as TLineSeries).ShowPoints := MenuItemPointsVisible.Checked;
end;

procedure TDistChartForm.MenuItemRefLineClick(Sender: TObject);
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

procedure TDistChartForm.MenuItemSaveClick(Sender: TObject);
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

procedure TDistChartForm.MenuItemShowMarksClick(Sender: TObject);
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

procedure TDistChartForm.MenuItemSmallerClick(Sender: TObject);
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

procedure TDistChartForm.MenuItemThickerClick(Sender: TObject);
var
  s: Word;
begin
  for s := 0 to cht.SeriesCount - 1 do
    if cht.Series[s] is TLineSeries then
      (cht.Series[s] as TLineSeries).LinePen.Width := (cht.Series[s] as TLineSeries).LinePen.Width + 1;
end;

procedure TDistChartForm.MenuItemThinnerClick(Sender: TObject);
var
  s: Word;
begin
  for s := 0 to cht.SeriesCount - 1 do
    if (cht.Series[s] is TLineSeries) and ((cht.Series[s] as TLineSeries).LinePen.Width > 1) then
      (cht.Series[s] as TLineSeries).LinePen.Width := (cht.Series[s] as TLineSeries).LinePen.Width - 1;
end;

procedure TDistChartForm.MenuItemTrendLineClick(Sender: TObject);
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

procedure TDistChartForm.PopupMenuChartsPopup(Sender: TObject);
var
  s: Word;
begin
  MenuItemLegendOff.Checked := cht.Legend.Visible;
  MenuItemLegendRight.Checked := cht.Legend.Visible and (cht.Legend.Alignment = laTopRight);
  MenuItemLegendLeft.Checked := cht.Legend.Visible and (cht.Legend.Alignment = laTopLeft);
  MenuItemLegendBottom.Checked := cht.Legend.Visible and (cht.Legend.Alignment = laBottomCenter);
  for s := 0 to cht.SeriesCount - 1 do
  begin
    if (cht.Series[s] as TLineSeries).ShowPoints and not MenuItemPointsVisible.Checked then
      MenuItemPointsVisible.Checked := True;
    if ((cht.Series[s] as TLineSeries).Marks.Style <> smsNone) and not MenuItemShowMarks.Checked then
      MenuItemShowMarks.Checked := True
  end;
end;

procedure TDistChartForm.Properties1Click(Sender: TObject);
begin
  with TChartPropDlg.Create(Self) do
  begin
    TempChart := cht;
    TempLogAxis[0] := LLogAxisTransform;
    TempLogAxis[2] := RLogAxisTransform;
    Show;
  end;
end;

procedure TDistChartForm.QueryXYAfterOpen(DataSet: TDataSet);
var
  TheLineSeries: TLineSeries;
  TheListChartSource: TListChartSource;
  TheSeriesColour: TColor;
  TheLineSeries2: TLineSeries;
  TheListChartSource2: TListChartSource;
  TheSeriesColour2: TColor;
  TheLineSeries3: TLineSeries;
  TheListChartSource3: TListChartSource;
  TheSeriesColour3: TColor;
  TheLineSeries4: TLineSeries;
  TheListChartSource4: TListChartSource;
  TheSeriesColour4: TColor;
  TheLineSeries5: TLineSeries;
  TheListChartSource5: TListChartSource;
  TheSeriesColour5: TColor;
  RecCount: Word;
begin
  RecCount := DataSet.RecordCount;
  if DataSet.Tag <= 2 then
    cht := ChartTop
  else
    cht := ChartBot;
  //create ListChartSource
  TheListChartSource := TListChartSource.Create(cht);
  //create the series
  TheSeriesColour := Random(256*256*256);
  TheLineSeries := TLineSeries.Create(cht);
  with TheLineSeries do
  begin
    Source := TheListChartSource;
    if DataSet.FindField('SPACING') <> NIL then //for tables with SPACING
      Title := Value1 + ': ' + IntToStr(Spacing1)
    else
    if Value1 = 'In Phase' then
      Title := Value1
    else
      Title := 'Series1';
    AxisIndexX := 1;
    case DataSet.Tag of
      1, 3: AxisIndexY := 0;
      2, 4: AxisIndexY := 2;
    end;
    ZPosition := 1;
    SeriesColor := TheSeriesColour;
    Pointer.Brush.Color := TheSeriesColour;
    Marks.LabelFont := AppFont;
  end;
  cht.AddSeries(TheLineSeries);
  if DataSet.FindField('THEVALUE2') <> NIL then
  begin
    //create ListChartSource2
    TheListChartSource2 := TListChartSource.Create(cht);
    //create the series
    TheSeriesColour2 := Random(256*256*256);
    TheLineSeries2 := TLineSeries.Create(cht);
    with TheLineSeries2 do
    begin
      Source := TheListChartSource2;
      if DataSet.FindField('SPACING') <> NIL then //for tables with SPACING
      begin
        if Value1 = 'Vert.' then
          Title := Value2 + ': ' + IntToStr(Spacing1)
        else
          Title := Value2 + ': ' + IntToStr(Spacing2)
      end
      else
        Title := Value2;
      AxisIndexX := 1;
      case DataSet.Tag of
        1, 3: AxisIndexY := 0;
        2, 4: AxisIndexY := 2;
      end;
      ZPosition := 2;
      SeriesColor := TheSeriesColour2;
      Pointer.Brush.Color := TheSeriesColour2;
      Marks.LabelFont := AppFont;
    end;
    cht.AddSeries(TheLineSeries2);
  end;
  if DataSet.FindField('THEVALUE3') <> NIL then
  begin
    //create ListChartSource5
    TheListChartSource5 := TListChartSource.Create(cht);
    //create the series
    TheSeriesColour5 := Random(256*256*256);
    TheLineSeries5 := TLineSeries.Create(cht);
    with TheLineSeries5 do
    begin
      Source := TheListChartSource5;
      Title :=  'Unfiltered';
      AxisIndexX := 1;
      case DataSet.Tag of
        1, 3: AxisIndexY := 0;
        2, 4: AxisIndexY := 2;
      end;
      ZPosition := 5;
      SeriesColor := TheSeriesColour5;
      Pointer.Brush.Color := TheSeriesColour5;
      Marks.LabelFont := AppFont;
    end;
    cht.AddSeries(TheLineSeries5);
  end;
  if DataSet.FindField('SPACING') <> NIL then //for tables with SPACING
  begin
    //create ListChartSource3
    TheListChartSource3 := TListChartSource.Create(cht);
    //create the series
    TheSeriesColour3 := Random(256*256*256);
    TheLineSeries3 := TLineSeries.Create(cht);
    with TheLineSeries3 do
    begin
      Source := TheListChartSource3;
      if Value1 = 'Vert.' then
        Title := Value1 + ': ' + IntToStr(Spacing2)
      else
        Title := Value2 + ': ' + IntToStr(Spacing2);
      AxisIndexX := 1;
      case DataSet.Tag of
        1, 3: AxisIndexY := 0;
        2, 4: AxisIndexY := 2;
      end;
      ZPosition := 3;
      SeriesColor := TheSeriesColour3;
      Pointer.Brush.Color := TheSeriesColour3;
      Marks.LabelFont := AppFont;
    end;
    cht.AddSeries(TheLineSeries3);
    if DataSet.FindField('THEVALUE2') <> NIL then
    begin
      //create ListChartSource4
      TheListChartSource4 := TListChartSource.Create(cht);
      //create the series
      TheSeriesColour4 := Random(256*256*256);
      TheLineSeries4 := TLineSeries.Create(cht);
      with TheLineSeries4 do
      begin
        Source := TheListChartSource4;
        Title := Value2 + ': ' + IntToStr(Spacing2);
        AxisIndexX := 1;
        case DataSet.Tag of
          1, 3: AxisIndexY := 0;
          2, 4: AxisIndexY := 2;
        end;
        ZPosition := 4;
        SeriesColor := TheSeriesColour4;
        Pointer.Brush.Color := TheSeriesColour4;
        Marks.LabelFont := AppFont;
      end;
      cht.AddSeries(TheLineSeries4);
    end;
  end;
  //add data to series chart source
  while not DataSet.EOF do
  begin
    //populate list with query values
    if (DataSet.FindField('SPACING') <> NIL) then //for tables with 2 SPACINGs
    begin
      if (not DataSet.FieldByName('THEVALUE').IsNull) and (DataSet.FieldByName('SPACING').Value = Spacing1) then
        TheListChartSource.Add(DataSet.FieldByName('STATION').Value, DataSet.FieldByName('THEVALUE').Value, DataSet.FieldByName('THEVALUE').AsString);
      if DataSet.FindField('THEVALUE2') <> NIL then
        if (not DataSet.FieldByName('THEVALUE2').IsNull) and (DataSet.FieldByName('SPACING').Value = Spacing1) then
          TheListChartSource2.Add(DataSet.FieldByName('STATION').Value, DataSet.FieldByName('THEVALUE2').Value, DataSet.FieldByName('THEVALUE2').AsString);
      if Spacing2 > 0 then
      begin
        if (not DataSet.FieldByName('THEVALUE').IsNull) and (DataSet.FieldByName('SPACING').Value = Spacing2) then
          TheListChartSource3.Add(DataSet.FieldByName('STATION').Value, DataSet.FieldByName('THEVALUE').Value, DataSet.FieldByName('THEVALUE').AsString);
        if DataSet.FindField('THEVALUE2') <> NIL then
          if (not DataSet.FieldByName('THEVALUE2').IsNull) and (DataSet.FieldByName('SPACING').Value = Spacing2) then
            TheListChartSource4.Add(DataSet.FieldByName('STATION').Value, DataSet.FieldByName('THEVALUE2').Value, DataSet.FieldByName('THEVALUE2').AsString);
      end;
    end
    else
    begin
      if (not DataSet.FieldByName('THEVALUE').IsNull) then
        TheListChartSource.Add(DataSet.FieldByName('STATION').Value, DataSet.FieldByName('THEVALUE').Value, DataSet.FieldByName('THEVALUE').AsString);
      if DataSet.FindField('THEVALUE2') <> NIL then
        if (not DataSet.FieldByName('THEVALUE2').IsNull) then
          TheListChartSource2.Add(DataSet.FieldByName('STATION').Value, DataSet.FieldByName('THEVALUE2').Value, DataSet.FieldByName('THEVALUE2').AsString);
      if DataSet.FindField('THEVALUE3') <> NIL then
        if (not DataSet.FieldByName('THEVALUE3').IsNull) then
          TheListChartSource5.Add(DataSet.FieldByName('STATION').Value, DataSet.FieldByName('THEVALUE3').Value, DataSet.FieldByName('THEVALUE3').AsString);
    end;
    DataSet.Next;
  end;
  //check if there is enough data for chart and provide message in title, if not
  if (DataSet.Tag <= 2) and (RecCount <= 1) then
  begin
    ChartTop.Title.Text.Clear;
    ChartTop.Title.Text.Add('Not enough data for this distance-dependent parameter in selected time range available!');
  end
  else
  if (DataSet.Tag >= 3) and (RecCount <= 1) then
  begin
    ChartBot.Title.Text.Clear;
    ChartBot.Title.Text.Add('Not enough data for this distance-dependent parameter in selected time range available!');
  end;
  DataSet.Close;
end;

procedure TDistChartForm.Saveas1Click(Sender: TObject);
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

procedure TDistChartForm.VertGrid1Click(Sender: TObject);
begin
  VertGrid1.Checked := not VertGrid1.Checked;
  cht.BottomAxis.Grid.Visible := VertGrid1.Checked;
end;

end.

