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
unit chemcharts;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, db, ExtCtrls,
  PrintersDlgs, TAGraph, TASeries, TATransformations, TASources, TATypes,
  TAChartAxisUtils, TATools, TAChartUtils, TALegend, math, StdCtrls, Buttons,
  Printers, Menus, XMLPropStorage, variants, ZDataset, Types, TADrawUtils,
  OSPrinters, TAPrint, TADrawerSVG, TAMultiSeries
  {$IFDEF WINDOWS}
  , TADrawerWMF
  {$ENDIF}
  ;

type

  { TChemChartsForm }

  TChemChartsForm = class(TForm)
    ListChartSourceSARTop: TListChartSource;
    ListChartSourceSARRight: TListChartSource;
    MaxQuery: TZReadOnlyQuery;
    ArrowSeries: TFieldSeries;
    SchoellerChartAxisTransformations: TChartAxisTransformations;
    SchoellerLeftAxisTransform: TLogarithmAxisTransform;
    SARChartAxisTransformations: TChartAxisTransformations;
    SARBottomAxisTransform: TLogarithmAxisTransform;
    ChartToolset1: TChartToolset;
    ChartToolset1DataPointHintTool1: TDataPointHintTool;
    ChartToolset1PanDragTool1: TPanDragTool;
    ChartToolset1UserDefinedTool1: TUserDefinedTool;
    ChartToolset1ZoomDragTool1: TZoomDragTool;
    ChartToolset1ZoomMouseWheelTool1: TZoomMouseWheelTool;
    GlobalDataSource: TDataSource;
    DurovLabelSeriesBot: TLineSeries;
    DurovRectangles: TAreaSeries;
    DurovTopTriangle: TAreaSeries;
    DurovLeftTriangle: TAreaSeries;
    AvgQuery: TZReadOnlyQuery;
    ListChartSourceSARx: TListChartSource;
    ListChartSourceLeft: TListChartSource;
    ListChartSourceBottom: TListChartSource;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItemShowHazards: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MinQuery: TZReadOnlyQuery;
    MenuItem1: TMenuItem;
    MenuItem7: TMenuItem;
    N1: TMenuItem;
    MenuItemFrame: TMenuItem;
    MenuItemPanel: TMenuItem;
    MenuItemBackground: TMenuItem;
    MenuItemReport: TMenuItem;
    MenuItemBotCentre: TMenuItem;
    MenuItemFonts: TMenuItem;
    MenuItemBigger: TMenuItem;
    MenuItemSmaller: TMenuItem;
    MenuItemBotLeft: TMenuItem;
    MenuItemBotRight: TMenuItem;
    MenuItemTopLeft: TMenuItem;
    MenuItemTopRight: TMenuItem;
    MenuItemAlignment: TMenuItem;
    MenuItemSideBar: TMenuItem;
    MenuItemLegendEnabled: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem5: TMenuItem;
    PiperDiamond: TAreaSeries;
    PiperRightTriangle: TAreaSeries;
    PiperLeftTriangle: TAreaSeries;
    PiperLabels: TLineSeries;
    PrintDialog1: TPrintDialog;
    S2Series: TLineSeries;
    S1Series: TLineSeries;
    S3Series: TLineSeries;
    S4Series: TLineSeries;
    C1Series: TLineSeries;
    C2Series: TLineSeries;
    C3Series: TLineSeries;
    C4Series: TLineSeries;
    SaveDialog: TSaveDialog;
    PiperChart: TChart;
    PiperLines: TLineSeries;
    SchoellerChart: TChart;
    SARChart: TChart;
    SARDiagonals: TLineSeries;
    DurovChart: TChart;
    DurovGridlines: TLineSeries;
    DurovLabelSeriesTop: TLineSeries;
    DurovBorderlines: TLineSeries;
    PopupMenu1: TPopupMenu;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem6: TMenuItem;
    QuickFormat1: TMenuItem;
    HorizGrid1: TMenuItem;
    VertGrid1: TMenuItem;
    Legend1: TMenuItem;
    EDurovChart: TChart;
    BorderSeries: TLineSeries;
    ExpGridLines: TLineSeries;
    ExpDurovLabels: TLineSeries;
    GlobalQuery: TZReadOnlyQuery;
    XMLPropStorage1: TXMLPropStorage;
    procedure AggrQueryBeforeOpen(DataSet: TDataSet);
    procedure ChartToolset1DataPointHintTool1Hint(ATool: TDataPointHintTool;
      const APoint: TPoint; var AHint: String);
    procedure ChartToolset1UserDefinedTool1AfterMouseUp(ATool: TChartTool;
      APoint: TPoint);
    procedure ChartDblClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GlobalQueryBeforeOpen(DataSet: TDataSet);
    procedure AggrMenuItemClick(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItemBackgroundClick(Sender: TObject);
    procedure MenuItemBiggerClick(Sender: TObject);
    procedure MenuItemBotCentreClick(Sender: TObject);
    procedure MenuItemBotLeftClick(Sender: TObject);
    procedure MenuItemBotRightClick(Sender: TObject);
    procedure MenuItemFrameClick(Sender: TObject);
    procedure MenuItemLegendEnabledClick(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItemPanelClick(Sender: TObject);
    procedure MenuItemReportClick(Sender: TObject);
    procedure MenuItemShowHazardsClick(Sender: TObject);
    procedure MenuItemSideBarClick(Sender: TObject);
    procedure MenuItemSmallerClick(Sender: TObject);
    procedure MenuItemTopLeftClick(Sender: TObject);
    procedure MenuItemTopRightClick(Sender: TObject);
    procedure PiperAddPoints;
    procedure DurovAddPoints;
    procedure SchoelAddPoints;
    procedure SARAddPoints;
    procedure ExpDurovAddPoints;
    function FindChemValues(TheQuery: TDataSet; Param: ShortString): Double;
    procedure FindPercent(TheQuery: TDataSet; var Ca,Mg,Na,HCO3,SO4,Cl: Double);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure HorizGrid1Click(Sender: TObject);
    procedure VertGrid1Click(Sender: TObject);
    procedure Monochrome1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PiperCreateSeries;
    procedure DurovCreateSeries;
    procedure ExDurovCreateSeries;
    procedure DrawTriangle(x1,y1,x2,y2,x3,y3 : real);
    procedure SARCreateSeries;
    procedure CreateGraphs(DiagramType: Byte;var g:TChart);
    procedure GraphDurovSettings(g:TChart);
    procedure GraphPiperSettings(g:TChart);
    procedure GraphSchoellerSettings(g:TChart);
    procedure GraphSARSettings(g:TChart);
    procedure ChartRightBottomExit(Sender: TObject);
    procedure Saveas1Click(Sender: TObject);
    procedure DrawDurovGridlines;
    procedure DrawExDurovGridLines(x1,y1,x2,y2 : real);
    procedure createGridLines(x1,y1,x2,y2,x3,y3 : double; desc : string);
    procedure calculateDistance(x1,y1,x2,y2,x3,y3 : double; var dist : double;
                          var distDiagonal : double;
                          var beginInc : double; var endInc : double;
                          var inc : string;
                          var xBB : double; var yBB : double;
                          var lineHVcord : double);
    procedure calcPlotExDurovGridlines(angle, distance, distDiag, beginIncr,
                   endIncr, lineHVcoordinate : double; incr, descr : string);
    procedure drawExpDurovGridlines;
    function GetSeriesTitle(TheQuery: TDataSet): ShortString;
    function GetLabelText(TheQuery: TDataSet): ShortString;
    procedure SetHintToolSeries(const TheChart: TChart);
  private
    { Private declarations }
    chartxo,chartyo,baselength,squarephw,squaretdsw,tdsmin,tdsmax,newphx,newphy:real;
    TriangleBaseLength,LeftDiamondXorigin,LeftDiamondYorigin: Double;
    gc: TChart;
    MemberStr: String;
    OrigWidth: Word;
  public
    { Public declarations }
    ChtType: Byte;
    LabelTxt, LegendTxt: ShortString;
    StartDate, StartTime, EndDate, EndTime: String;
    IsCurrentSite, ClrByGrp: Boolean;
    FilterTableName: String;
    LabelLst, LegendLst: TStringList;
    MemberList: TStringList;
  end;

var
  ChemChartsForm: TChemChartsForm;

const
  MyColors :  array[0..19] of TColor = (
                clBlack,
		clMaroon,
		clGreen,
		clOlive,
		clNavy,
		clPurple,
		clTeal,
		clGray,
		clSilver,
		clRed,
		clLime,
		clYellow,
		clBlue,
		clFuchsia,
		clAqua,
		clLtGray,
		clDkGray,
		clMedGray,
                clMoneyGreen,
                clSkyBlue
		);

implementation

uses
  VARINIT, MainDataModule, chartproperties;

{$R *.lfm}

procedure TChemChartsForm.SetHintToolSeries(const TheChart: TChart);
var
  m: Integer;
  AffectedSeriesStr: String;
begin
  AffectedSeriesStr := '';
  for m := 0 to TheChart.SeriesCount -1 do
  if (TheChart.Series[m].Tag >= 1000) and TheChart.Series[m].Active then
  begin
     if AffectedSeriesStr = '' then
       AffectedSeriesStr := IntToStr(TheChart.Series[m].Index)
     else
       AffectedSeriesStr := AffectedSeriesStr + ', ' + IntToStr(TheChart.Series[m].Index);
  end;
  ChartToolset1DataPointHintTool1.AffectedSeries := AffectedSeriesStr;
end;

function TChemChartsForm.GetSeriesTitle(TheQuery: TDataSet): ShortString;
var
  m: Byte;
  QType: ShortString;
begin
  //check which query and change the description for legend
  if TheQuery.Name = 'AvgQuery' then
    QType := 'Average'
  else
  if TheQuery.Name = 'MinQuery' then
    QType := 'Minimum'
  else
  if TheQuery.Name = 'MaxQuery' then
    QType := 'Maximum'
  else QType := 'n/a';
  //Concatenate Series title (legend text)
  for m := 0 to LegendLst.Count - 1 do
  begin
    if m = 0 then //the first entry in list
    begin
      if TheQuery.FieldByName(LegendLst[m]).AsString <> '' then
        Result := TheQuery.FieldByName(LegendLst[m]).AsString
      else
        Result := Result + 'n/a'
    end
    else //all other entries in list
    begin
      if (TheQuery.FindField(LegendLst[m]) <> NIL) and (TheQuery.FieldByName(LegendLst[m]).AsString <> '') then
        Result := Result + ' - ' + TheQuery.FieldByName(LegendLst[m]).AsString
      else
        Result := Result + ' - ' + QType;
    end;
  end; //of for
end;

function TChemChartsForm.GetLabelText(TheQuery: TDataSet): ShortString;
var
  m: Byte;
  QType: ShortString;
begin
  //check which query and change the description for legend
  if TheQuery.Name = 'AvgQuery' then
    QType := 'Average'
  else
  if TheQuery.Name = 'MinQuery' then
    QType := 'Minimum'
  else
  if TheQuery.Name = 'MaxQuery' then
    QType := 'Maximum'
  else QType := 'n/a';
  //Concatenate hint and label text
  for m := 0 to LabelLst.Count - 1 do
  begin
    if m = 0 then //the first entry in list
    begin
      if (TheQuery.FieldByName(LabelLst.Strings[m]).AsString <> '') then
        Result := TheQuery.FieldByName(LabelLst.Strings[m]).AsString
      else
        Result := 'n/a';
    end
    else //all other entries in list
    begin
      if (TheQuery.FindField(LabelLst.Strings[m]) <> NIL) and (TheQuery.FieldByName(LabelLst.Strings[m]).AsString <> '') then
        Result := Result + ' - ' + TheQuery.FieldByName(LabelLst.Strings[m]).AsString
      else
        Result := Result + ' - ' + QType;
    end;
  end; //of for
end;

procedure TChemChartsForm.calcPlotExDurovGridlines(angle, distance, distDiag, beginIncr, endIncr, lineHVcoordinate : double; incr, descr : string);
var incDist, incDistDiag, Vx, Vy, pointX, pointY : double;
    count, i : integer;
begin
   //Calculate and plot gridlines and labels
   ExpDurovLabels.Marks.LabelFont.Size := 7;
   //calculate distance between grids
   incDist := distance / 5;
   //calculate distance between grids on the diagonals
   incDistDiag := distDiag /5;
   //Count are used to calculate the distance of the gridline
   //calcultate points
   if incr = 'y' then
     begin
      //the Beginpoint of triangle
      pointX := beginIncr;
      pointY := lineHVcoordinate;
      count := 4;
      //Count are used to calculate the distance of the gridline.
      for i := 1 to 4 do
      begin
       //calculate the end coordinates of the 1st vector
       Vx := (count * incDistDiag) * cos(angle);
       Vy := (count * incDistDiag) * sin(angle);
     //plot the begin point of the 1st vector
       //Move Beginpoint one increment per time to right
       pointX := beginIncr + (incDist * (i));
       //plot the end point of the vector
       ExpGridLines.AddXY(pointX + Vx, pointY + Vy,'',clGray);
       //plot the begin point of the vector
       ExpGridLines.AddXY(pointX, pointY,'',clGray);
       //If it is a diamond draw gridline to bottom
       if descr = 'top diamond'
         then ExpGridLines.AddXY(pointX + Vx, pointY - Vy,'',clGray);
       //end vector
       ExpGridLines.AddXY(pointX + Vx, NaN ,' ');
     //plot the begin point of the second vector
       //Move Beginpoint one increment per time to left
       pointX := beginIncr + (incDist * (count));
       //plot the end point of the vector
       ExpGridLines.AddXY((pointX - Vx), (pointY + Vy),'',clGray);
       //plot the begin point of the vector
       ExpGridLines.AddXY(pointX, pointY,'',clGray);
       //If it is a diamond draw gridline to bottom
       if descr = 'top diamond'
         then ExpGridLines.AddXY(pointX - Vx, pointY - Vy,'',clGray);
       //end vector
       ExpGridLines.AddXY(pointX + Vx, NaN,' ');
     //Add horizontal PiperLines
       ExpGridLines.AddXY(pointX - Vx, pointY + Vy,'',clGray);
       //Print exp. durov line label
       if descr = 'Top left triangle'
         then ExpDurovLabels.AddXY(pointX - Vx - 2, pointY + Vy - 1, inttostr(count * 10), clBlack)
       else if descr = 'top diamond'
         then ExpDurovLabels.AddXY(pointX - Vx - 2, pointY + Vy - 1, inttostr(100 - (i * 10)), clBlack);
       pointX := beginIncr + (incDist * (i));
       ExpGridLines.AddXY(pointX + Vx, pointY + Vy,'',clGray);
       //Print exp. durov line label
       if descr = 'Top right triangle'
         then ExpDurovLabels.AddXY(pointX + Vx + 2, pointY + Vy - 1, inttostr(100 - (count * 10)), clBlack)
       else if descr = 'top diamond'
         then ExpDurovLabels.AddXY(pointX + Vx + 2, pointY + Vy - 1, inttostr(i * 10), clBlack);
       ExpGridLines.AddXY(pointX + Vx, NaN,'');
     //Add horizontal PiperLines for diamond to the bottom
       if descr = 'top diamond' then
         begin
           ExpGridLines.AddXY(pointX + Vx, pointY - Vy,'',clGray);
           pointX := beginIncr + (incDist * (count));
           ExpGridLines.AddXY(pointX - Vx, pointY - Vy,'',clGray);
           ExpGridLines.AddXY(pointX - Vx, NaN,'');
         end;
       count := count - 1;
      end //end-for
     end //end-if
   else
     begin
      //the Beginpoint of triangle
      pointX := lineHVcoordinate;
      pointY := beginIncr;
      count := 4;
      //Count are used to calculate te distance of the gridline.
      for i := 1 to 4 do
      begin
       //calculate the end coordinates of the 1st vector
       Vx := (count * incDistDiag) * cos(angle);
       Vy := (count * incDistDiag) * sin(angle);
     //plot the begin point of the 1st vector
       //Move Beginpoint one increment per time to right
       pointY := beginIncr + (incDist * (count));
       //plot the end point of the vector
       ExpGridLines.AddXY(pointX - Vx, pointY + Vy,'',clGray);
       //plot the begin point of the vector
       ExpGridLines.AddXY(pointX, pointY,'',clGray);
       //If it is a diamond draw gridline to right
       if descr = 'bottom diamond'
         then ExpGridLines.AddXY(pointX + Vx, pointY + Vy,'',clGray);
       //end vector
       ExpGridLines.AddXY(pointX, NaN,' ');
     //plot the begin point of the second vector
       //Move Beginpoint one increment per time to left
       pointY := beginIncr + (incDist * (i));
       //plot the end point of the vector
       ExpGridLines.AddXY((pointX - Vx), (pointY - Vy),'',clGray);
       //plot the begin point of the vector
       ExpGridLines.AddXY(pointX, pointY,'',clGray);
       //If it is a diamond draw gridline to right
       if descr = 'bottom diamond'
         then ExpGridLines.AddXY(pointX + Vx, pointY - Vy,'',clGray);
       //end vector
       ExpGridLines.AddXY(pointX, NaN,' ');
     //Add horizontal PiperLines
       ExpGridLines.AddXY(pointX - Vx, pointY - Vy,'',clGray);
        //Print exp. durov line label
       if descr = 'Left top triangle'
         then ExpDurovLabels.AddXY(pointX - Vx, pointY - Vy + 1, inttostr(100 - (count * 10)), clBlack)
       else if descr = 'bottom diamond'
         then ExpDurovLabels.AddXY(pointX - Vx, pointY - Vy + 3, inttostr(i * 10), clBlack);
       pointY := beginIncr + (incDist * (count));
       ExpGridLines.AddXY(pointX - Vx, pointY + Vy,'',clGray);
       //Print exp. durov line label
       if descr = 'Left bottom triangle'
         then ExpDurovLabels.AddXY(pointX - Vx, pointY + Vy - 1, inttostr(count * 10), clBlack)
       else if descr = 'bottom diamond'
         then ExpDurovLabels.AddXY(pointX - Vx, pointY + Vy - 1, inttostr(100 - (i * 10)), clBlack);
       ExpGridLines.AddXY(pointX - Vx, NaN,'');
     //Add horizontal PiperLines for diamond to the right
       if descr = 'bottom diamond' then
         begin
           ExpGridLines.AddXY(pointX + Vx, pointY + Vy,'',clGray);
           pointY := beginIncr + (incDist * (i));
           ExpGridLines.AddXY(pointX + Vx, pointY - Vy,'',clGray);
           ExpGridLines.AddXY(pointX + Vx, NaN,'');
         end;
       count := count - 1;
      end //end-for
     end; //end-else
end;

//calculate distance and increment of coordinates
procedure TChemChartsForm.calculateDistance(x1, y1, x2, y2, x3, y3 : double;
                          var dist : double; var distDiagonal : double;
                          var beginInc : double; var endInc : double;
                          var inc : string;
                          var xBB : double; var yBB : double;
                          var lineHVcord : double);
{Comments: dist is the distance of the line that is horizontal or vertical with
                   the x or y
           distDiagonal is the distance of the diagonal line.
           beginInc is used for the begin coordinate of the line that is
                   horizontal or vertical with the x or y
           endInc is used for the end coordinate of the line that is
                   horizontal or vertical with the x or y
           inc is used to know if the line is horizontal or vertical with the
                   x or y axes of the graph
           xBB, yBB is used to calculate the incline and constant of
                  the line used in the calculateMandC procedure
           lineHVcord is used by beginInc and endInc because it is the x or y
                   coordinate that is horizontal or vertical with the x or y
                   axes}
var tempBegin, tempEnd : double;
begin
   //test to see which x-coordinates is the same
   if (x1 - x2) = 0 then //x1 = x2
     begin
       tempBegin := y1;
       tempEnd := y2;
       lineHVcord := x1;
       xBB := x3;
       yBB := y3;
       inc := 'x';
       dist := sqrt(power((y2 - y1), 2));
       distDiagonal := sqrt(power((x3 - x1), 2) + power((y3 - y1), 2));
     end //end-if
   else
     if (x1 - x3) = 0 then  //x1 = x3
       begin
         tempBegin := y1;
         tempEnd := y3;
         lineHVcord := x1;
         xBB := x2;
         yBB := y2;
         inc := 'x';
         dist := sqrt(power((y3 - y1), 2));
         distDiagonal := sqrt(power((x2 - x1), 2) + power((y2 - y1), 2));
       end //end-else-if
     else  //x2 = x3
       if (x2 - x3) = 0 then
         begin
           tempBegin := y2;
           tempEnd := y3;
           inc := 'x';
           lineHVcord := x2;
           xBB := x1;
           yBB := y1;
           dist := sqrt(power((y3 - y2), 2));
           distDiagonal := sqrt(power((x2 - x1), 2) + power((y2 - y1), 2));
       end;
   //test to see which y-coordinates is the same
   if (y1 - y2) = 0 then //y1 = y2
     begin
       tempBegin := x1;
       tempEnd := x2;
       lineHVcord := y1;
       xBB := x3;
       yBB := y3;
       inc := 'y';
       dist := sqrt(power((x2 - x1), 2));
       distDiagonal := sqrt(power((x3 - x1), 2) + power((y3 - y1), 2));
     end //end-if
   else
     if (y1 - y3) = 0 then  //y1 = y3
       begin
         tempBegin := x1;
         tempEnd := x3;
         lineHVcord := y1;
         xBB := x2;
         yBB := y2;
         inc := 'y';
         dist := sqrt(power((x3 - x1), 2));
         distDiagonal := sqrt(power((x2 - x1), 2) + power((y2 - y1), 2));
       end //end-else-if
     else  //y2 = y3
       if (y2 - y3) = 0 then
         begin
           tempBegin := x2;
           tempEnd := x3;
           inc := 'y';
           lineHVcord := y2;
           xBB := x1;
           yBB := y1;
           dist := sqrt(power((x3 - x2), 2));
           distDiagonal := sqrt(power((x2 - x1), 2) + power((y2 - y1), 2));
         end;
   //test to see which value to use for begin and end. Smallest for beginInc and
   //biggest for endInc
   if tempBegin < tempEnd then
     begin
       beginInc := tempBegin;
       endInc := tempEnd;
     end
   else
   begin
     beginInc := tempEnd;
     endInc := tempBegin;
   end;
end;

procedure TChemChartsForm.createGridLines(x1,y1,x2,y2,x3,y3 : double; desc : string);
var distance, distDiag, beginIncr, endIncr, lineHVcoordinate: double;
    xB2, yB2, angle : double;
    incr : string;
begin
   //Calculate distance and increment of coordinates
   calculateDistance(x1, y1, x2, y2, x3, y3, distance, distDiag, beginIncr, endIncr, incr, xB2, yB2, lineHVcoordinate);
   //Calculate angle
   if incr = 'y' then
     angle := arctan((yB2 - lineHVcoordinate)/(xB2 - beginIncr))
   else
     angle := arctan((yB2 - beginIncr)/(xB2 - lineHVcoordinate));
   //Calculate and plot gridlines
   calcPlotExDurovGridlines(angle, distance, distDiag, beginIncr, endIncr, lineHVcoordinate, incr, desc);
end;

//Draw expanded durov gridlines
procedure TChemChartsForm.drawExpDurovGridlines;
begin
   //LeftDiamondXorigin := 6;
   //LeftDiamondYorigin := 35;
   //TriangleBaseLength := 18;
   //Top left triangle
   createGridLines(LeftDiamondXorigin + 2 * TriangleBaseLength * 0.8660254,
                LeftDiamondYorigin + 0.5 * TriangleBaseLength + TriangleBaseLength,
                LeftDiamondXorigin + 2 * TriangleBaseLength * 0.8660254 + 0.5 * TriangleBaseLength,
                LeftDiamondYorigin + 0.5 * TriangleBaseLength + TriangleBaseLength + TriangleBaseLength * 0.8660254,
                LeftDiamondXorigin + 2 * TriangleBaseLength * 0.8660254 + TriangleBaseLength,
                LeftDiamondYorigin + 0.5 * TriangleBaseLength + TriangleBaseLength, 'Top left triangle');
   //Top Diamond
   createGridLines(LeftDiamondXorigin + 2 * TriangleBaseLength * 0.8660254 + TriangleBaseLength,
                LeftDiamondYorigin + 0.5 * TriangleBaseLength + TriangleBaseLength + TriangleBaseLength * 0.8660254,
                LeftDiamondXorigin + 2 * TriangleBaseLength * 0.8660254 + TriangleBaseLength + 0.5 * TriangleBaseLength,
                LeftDiamondYorigin + 0.5 * TriangleBaseLength + TriangleBaseLength + 2 * TriangleBaseLength * 0.8660254,
                LeftDiamondXorigin + 2 * TriangleBaseLength * 0.8660254 + 2 * TriangleBaseLength,
                LeftDiamondYorigin + 0.5 * TriangleBaseLength + TriangleBaseLength + TriangleBaseLength * 0.8660254, 'top diamond');
   //Top right triangle
   createGridLines(LeftDiamondXorigin + 2 * TriangleBaseLength * 0.8660254 + 2 * TriangleBaseLength,
                LeftDiamondYorigin + 0.5 * TriangleBaseLength + TriangleBaseLength,
                LeftDiamondXorigin + 2 * TriangleBaseLength * 0.8660254 + 2 * TriangleBaseLength + 0.5 * TriangleBaseLength,
                LeftDiamondYorigin + 0.5 * TriangleBaseLength + TriangleBaseLength + TriangleBaseLength * 0.8660254,
                LeftDiamondXorigin + 2 * TriangleBaseLength * 0.8660254 + 3 * TriangleBaseLength,
                LeftDiamondYorigin + 0.5 * TriangleBaseLength + TriangleBaseLength, 'Top right triangle');

   //Left bottom triangle
   createGridLines(LeftDiamondXorigin + TriangleBaseLength * 0.8660254,
                LeftDiamondYorigin - TriangleBaseLength,
                LeftDiamondXorigin + 2 * TriangleBaseLength * 0.8660254,
                LeftDiamondYorigin - 0.5 * TriangleBaseLength,
                LeftDiamondXorigin + 2 * TriangleBaseLength * 0.8660254,
                LeftDiamondYorigin - 1.5 * TriangleBaseLength, 'Left bottom triangle');
   //Left Diamond
   createGridLines(LeftDiamondXorigin,
                LeftDiamondYorigin,
                LeftDiamondXorigin + TriangleBaseLength * 0.8660254,
                LeftDiamondYorigin + 0.5 * TriangleBaseLength,
                LeftDiamondXorigin + TriangleBaseLength * 0.8660254,
                LeftDiamondYorigin - 0.5 * TriangleBaseLength, 'bottom diamond');
   //Left top triangle
   createGridLines(LeftDiamondXorigin + TriangleBaseLength * 0.8660254,
                LeftDiamondYorigin + TriangleBaseLength,
                LeftDiamondXorigin + 2 * TriangleBaseLength * 0.8660254,
                LeftDiamondYorigin + 0.5 * TriangleBaseLength,
                LeftDiamondXorigin + 2 * TriangleBaseLength * 0.8660254,
                LeftDiamondYorigin + 1.5 * TriangleBaseLength, 'Left top triangle');
end;

procedure TChemChartsForm.DrawTriangle(x1,y1,x2,y2,x3,y3 : real);
begin
   with BorderSeries do
   begin
      AddXY(x1,y1,'',clBlack);
      AddXY(x2,y2,'',clBlack);
      AddXY(x3,y3,'',clBlack);
      AddXY(x1,y1,'',clBlack);
      AddXY(x1,NaN,' ');
   end;
end;

procedure TChemChartsForm.DrawExDurovGridLines(x1,y1,x2,y2 : real);
begin
  with ExpGridLines do
  begin
    AddXY(x1,y1,'',clGray);
    AddXY(x2,y2,'',clGray);
    AddXY(x1,y1,'', clGray);
    AddXY(x1,NaN,' ');
  end;
end;

procedure TChemChartsForm.ExpDurovAddPoints;
var Ca,Mg,Na,HCO3,SO4,Cl,topx,topy,sidey,sidex: Double;
    TheColour : TColor;
    ExpDurovSeries, AvgSeries, MaxSeries, MinSeries: TLineSeries;
    LabelText, PrevSiteID: ShortString;
    Idx: Word; //to count the series
begin
  PrevSiteID := '';
  Idx := 0;
  Randomize;
  with EDurovChart do
  begin
    GlobalQuery.First;
    while not GlobalQuery.EOF do
    begin
     if GlobalQuery.FieldByName('SITE_ID_NR').Value <> PrevSiteID then //create a new series
     begin
       ExpDurovSeries := TLineSeries.Create(EDurovChart);
       EDurovChart.AddSeries(ExpDurovSeries);
       with ExpDurovSeries do
       begin
         Index := Idx;
         Inc(Idx);
         if ClrByGrp then
         begin
           if MemberList.IndexOf(GlobalQuery.FieldByName('MEMBER_ID').Value) > 19 then
             TheColour := clActiveCaption
           else
             TheColour := MyColors[MemberList.IndexOf(GlobalQuery.FieldByName('MEMBER_ID').Value)];
           Legend.GroupIndex := MemberList.IndexOf(GlobalQuery.FieldByName('MEMBER_ID').Value);
         end
         else
           TheColour := MyColors[Random(19)];
       end;
     end;
     with ExpDurovSeries do
     begin
       ShowPoints := True;
       ShowLines := False;
       LineType := ltNone;
       Pointer.horizsize:=2;
       Pointer.vertsize:=2;
       SeriesColor := TheColour;
       Pointer.Pen.Color := SeriesColor;
       Pointer.Brush.Color := SeriesColor;
       Pointer.OverrideColor := [];
       Tag := 1000;
       ZPosition := Tag;
       Marks.LabelFont := AppFont ;
       Marks.Visible := True;
       Marks.Frame.Visible := False;
       Marks.LinkPen.Color := clBlack;
       FindPercent(GlobalQuery,Ca,Mg,Na,HCO3,SO4,Cl);
       Title := GetSeriesTitle(GlobalQuery);
       LabelText := GetLabelText(GlobalQuery);
       Ca:=Ca/2;
       MG:=MG/2;
       NA:=NA/2;
       CL:=CL/2;
       SO4:=SO4/2;
       HCO3:=HCO3/2;
       topx:=0;
       sidey:=0;
       if Ca > 25 then
       begin
         topx:= LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+NA/25*TriangleBaseLength+MG/25*TriangleBaseLength*0.5;
         topy:=LeftDiamondYorigin +1.5*TriangleBaseLength+MG/25*TriangleBaseLength*0.8660254;
         addxy(topx,topy,LabelText,SeriesColor);
       end;
       if NA > 25 then
       begin
         topx:=LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+2*TriangleBaseLength+((NA-25)/25+0.5*MG/25)*TriangleBaseLength;
         topy:=LeftDiamondYorigin +1.5*TriangleBaseLength+MG/25*TriangleBaseLength*0.8660254;
         addxy(topx,topy,LabelText,SeriesColor);
       end;
       if  (Ca <= 25) and (NA<= 25) then
       begin
         topx:=LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+TriangleBaseLength
             +0.5*TriangleBaseLength*NA/25+0.5*TriangleBaseLength*((25-CA)/25);
         topy:=leftDiamondYorigin +1.5*TriangleBaseLength+MG/50*2*TriangleBaseLength*0.8660254;
         addxy(topx,topy,LabelText,SeriesColor);
       end;
       if HCO3 > 25 then
       begin
         sidex:=LeftDiamondXorigin+2*TriangleBaseLength*0.8660254-SO4/25*TriangleBaseLength*0.8660254;
         sidey:=LeftDiamondYorigin +1.5*TriangleBaseLength-CL/25*TriangleBaseLength-0.5*SO4/25
         *TriangleBaseLength ;
         addxy(sidex,sidey,LabelText,SeriesColor);
       end;
       if CL > 25 then
       begin
         sidex:=LeftDiamondXorigin+2*TriangleBaseLength*0.8660254-SO4/25*TriangleBaseLength*0.8660254;
         sidey:=LeftDiamondYorigin +1.5*TriangleBaseLength-2*TriangleBaseLength-((CL-25)/25+0.5*SO4/25)
               *TriangleBaseLength;
         addxy(sidex,sidey,LabelText,SeriesColor);
       end;
       if (HCO3 <= 25) and (CL<= 25) then
       begin
         sidex:=LeftDiamondXorigin+2*TriangleBaseLength*0.8660254-SO4/50*2*TriangleBaseLength*0.8660254;
         sidey:=LeftDiamondYorigin +1.5*TriangleBaseLength-TriangleBaseLength
          -0.5* TriangleBaseLength*CL/25
          -0.5* TriangleBaseLength*((25-HCO3)/25);
         addxy(sidex,sidey,LabelText,SeriesColor);
       end;
       { Classification square}
       AddXY(topx,sidey,LabelText,SeriesColor);
     end;
     PrevSiteID := GlobalQuery.FieldByName('SITE_ID_NR').Value;
     GlobalQuery.Next;
    end;
    //Average series
    AvgQuery.First;
    while not AvgQuery.EOF do
    begin
       AvgSeries := TLineSeries.Create(EDurovChart);
       EDurovChart.AddSeries(AvgSeries);
       with AvgSeries do
       begin
         Index := Idx;
         Inc(Idx);
         if ClrByGrp then
         begin
           if MemberList.IndexOf(AvgQuery.FieldByName('MEMBER_ID').Value) > 19 then
             TheColour := clActiveCaption
           else
             TheColour := MyColors[MemberList.IndexOf(AvgQuery.FieldByName('MEMBER_ID').Value)];
           Legend.GroupIndex := MemberList.IndexOf(AvgQuery.FieldByName('MEMBER_ID').Value);
         end
         else
           TheColour := MyColors[Random(19)];
       Active := False;
       ShowPoints := True;
       ShowLines := False;
       LineType := ltNone;
       Pointer.horizsize:=2;
       Pointer.vertsize:=2;
       SeriesColor := TheColour;
       Pointer.Pen.Color := SeriesColor;
       Pointer.Brush.Color := SeriesColor;
       Pointer.OverrideColor := [];
       Tag := 1001;
       ZPosition := Tag;
       Marks.LabelFont := AppFont ;
       Marks.Visible := True;
       Marks.Frame.Visible := False;
       Marks.LinkPen.Color := clBlack;
       FindPercent(AvgQuery,Ca,Mg,Na,HCO3,SO4,Cl);
       Title := GetSeriesTitle(AvgQuery);
       LabelText := GetLabelText(AvgQuery);
       Ca:=Ca/2;
       MG:=MG/2;
       NA:=NA/2;
       CL:=CL/2;
       SO4:=SO4/2;
       HCO3:=HCO3/2;
       topx:=0;
       sidey:=0;
       if Ca > 25 then
       begin
         topx:= LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+NA/25*TriangleBaseLength+MG/25*TriangleBaseLength*0.5;
         topy:=LeftDiamondYorigin +1.5*TriangleBaseLength+MG/25*TriangleBaseLength*0.8660254;
         addxy(topx,topy,LabelText,SeriesColor);
       end;
       if NA > 25 then
       begin
         topx:=LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+2*TriangleBaseLength+((NA-25)/25+0.5*MG/25)*TriangleBaseLength;
         topy:=LeftDiamondYorigin +1.5*TriangleBaseLength+MG/25*TriangleBaseLength*0.8660254;
         addxy(topx,topy,LabelText,SeriesColor);
       end;
       if  (Ca <= 25) and (NA<= 25) then
       begin
         topx:=LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+TriangleBaseLength
             +0.5*TriangleBaseLength*NA/25+0.5*TriangleBaseLength*((25-CA)/25);
         topy:=leftDiamondYorigin +1.5*TriangleBaseLength+MG/50*2*TriangleBaseLength*0.8660254;
         addxy(topx,topy,LabelText,SeriesColor);
       end;
       if HCO3 > 25 then
       begin
         sidex:=LeftDiamondXorigin+2*TriangleBaseLength*0.8660254-SO4/25*TriangleBaseLength*0.8660254;
         sidey:=LeftDiamondYorigin +1.5*TriangleBaseLength-CL/25*TriangleBaseLength-0.5*SO4/25
         *TriangleBaseLength ;
         addxy(sidex,sidey,LabelText,SeriesColor);
       end;
       if CL > 25 then
       begin
         sidex:=LeftDiamondXorigin+2*TriangleBaseLength*0.8660254-SO4/25*TriangleBaseLength*0.8660254;
         sidey:=LeftDiamondYorigin +1.5*TriangleBaseLength-2*TriangleBaseLength-((CL-25)/25+0.5*SO4/25)
               *TriangleBaseLength;
         addxy(sidex,sidey,LabelText,SeriesColor);
       end;
       if (HCO3 <= 25) and (CL<= 25) then
       begin
         sidex:=LeftDiamondXorigin+2*TriangleBaseLength*0.8660254-SO4/50*2*TriangleBaseLength*0.8660254;
         sidey:=LeftDiamondYorigin +1.5*TriangleBaseLength-TriangleBaseLength
          -0.5* TriangleBaseLength*CL/25
          -0.5* TriangleBaseLength*((25-HCO3)/25);
         addxy(sidex,sidey,LabelText,SeriesColor);
       end;
       { Classification square}
       AddXY(topx,sidey,LabelText,SeriesColor);
     end;
     AvgQuery.Next;
    end;
    //Minimum series
    MinQuery.First;
    while not MinQuery.EOF do
    begin
      MinSeries := TLineSeries.Create(EDurovChart);
      EDurovChart.AddSeries(MinSeries);
      with MinSeries do
      begin
        Index := Idx;
        Inc(Idx);
        if ClrByGrp then
        begin
          if MemberList.IndexOf(MinQuery.FieldByName('MEMBER_ID').Value) > 19 then
            TheColour := clActiveCaption
          else
            TheColour := MyColors[MemberList.IndexOf(MinQuery.FieldByName('MEMBER_ID').Value)];
          Legend.GroupIndex := MemberList.IndexOf(MinQuery.FieldByName('MEMBER_ID').Value);
        end
        else
          TheColour := MyColors[Random(19)];
        Active := False;
        ShowPoints := True;
        ShowLines := False;
        LineType := ltNone;
        Pointer.horizsize:=2;
        Pointer.vertsize:=2;
        SeriesColor := TheColour;
        Pointer.Pen.Color := SeriesColor;
        Pointer.Brush.Color := SeriesColor;
        Pointer.OverrideColor := [];
        Tag := 1002;
        ZPosition := Tag;
        Marks.LabelFont := AppFont ;
        Marks.Visible := True;
        Marks.Frame.Visible := False;
        Marks.LinkPen.Color := clBlack;
        FindPercent(MinQuery,Ca,Mg,Na,HCO3,SO4,Cl);
        Title := GetSeriesTitle(MinQuery);
        LabelText := GetLabelText(MinQuery);
        Ca:=Ca/2;
        MG:=MG/2;
        NA:=NA/2;
        CL:=CL/2;
        SO4:=SO4/2;
        HCO3:=HCO3/2;
        topx:=0;
        sidey:=0;
        if Ca > 25 then
        begin
          topx:= LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+NA/25*TriangleBaseLength+MG/25*TriangleBaseLength*0.5;
          topy:=LeftDiamondYorigin +1.5*TriangleBaseLength+MG/25*TriangleBaseLength*0.8660254;
          addxy(topx,topy,LabelText,SeriesColor);
        end;
        if NA > 25 then
        begin
          topx:=LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+2*TriangleBaseLength+((NA-25)/25+0.5*MG/25)*TriangleBaseLength;
          topy:=LeftDiamondYorigin +1.5*TriangleBaseLength+MG/25*TriangleBaseLength*0.8660254;
          addxy(topx,topy,LabelText,SeriesColor);
        end;
        if  (Ca <= 25) and (NA<= 25) then
        begin
          topx:=LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+TriangleBaseLength
              +0.5*TriangleBaseLength*NA/25+0.5*TriangleBaseLength*((25-CA)/25);
          topy:=leftDiamondYorigin +1.5*TriangleBaseLength+MG/50*2*TriangleBaseLength*0.8660254;
          addxy(topx,topy,LabelText,SeriesColor);
        end;
        if HCO3 > 25 then
       begin
          sidex:=LeftDiamondXorigin+2*TriangleBaseLength*0.8660254-SO4/25*TriangleBaseLength*0.8660254;
          sidey:=LeftDiamondYorigin +1.5*TriangleBaseLength-CL/25*TriangleBaseLength-0.5*SO4/25
         *TriangleBaseLength ;
          addxy(sidex,sidey,LabelText,SeriesColor);
        end;
        if CL > 25 then
        begin
          sidex:=LeftDiamondXorigin+2*TriangleBaseLength*0.8660254-SO4/25*TriangleBaseLength*0.8660254;
          sidey:=LeftDiamondYorigin +1.5*TriangleBaseLength-2*TriangleBaseLength-((CL-25)/25+0.5*SO4/25)
                *TriangleBaseLength;
          addxy(sidex,sidey,LabelText,SeriesColor);
        end;
        if (HCO3 <= 25) and (CL<= 25) then
        begin
          sidex:=LeftDiamondXorigin+2*TriangleBaseLength*0.8660254-SO4/50*2*TriangleBaseLength*0.8660254;
          sidey:=LeftDiamondYorigin +1.5*TriangleBaseLength-TriangleBaseLength
           -0.5* TriangleBaseLength*CL/25
           -0.5* TriangleBaseLength*((25-HCO3)/25);
          addxy(sidex,sidey,LabelText,SeriesColor);
        end;
        { Classification square}
        AddXY(topx,sidey,LabelText,SeriesColor);
      end;
      MinQuery.Next;
     end;
    //Maximum series
    MaxQuery.First;
    while not MaxQuery.EOF do
    begin
      MaxSeries := TLineSeries.Create(EDurovChart);
      EDurovChart.AddSeries(MaxSeries);
      with MaxSeries do
      begin
        Index := Idx;
        Inc(Idx);
        if ClrByGrp then
        begin
          if MemberList.IndexOf(MaxQuery.FieldByName('MEMBER_ID').Value) > 19 then
            TheColour := clActiveCaption
          else
            TheColour := MyColors[MemberList.IndexOf(MaxQuery.FieldByName('MEMBER_ID').Value)];
          Legend.GroupIndex := MemberList.IndexOf(MaxQuery.FieldByName('MEMBER_ID').Value);
        end
        else
          TheColour := MyColors[Random(19)];
        Active := False;
        ShowPoints := True;
        ShowLines := False;
        LineType := ltNone;
        Pointer.horizsize:=2;
        Pointer.vertsize:=2;
        SeriesColor := TheColour;
        Pointer.Pen.Color := SeriesColor;
        Pointer.Brush.Color := SeriesColor;
        Pointer.OverrideColor := [];
        Tag := 1003;
        ZPosition := Tag;
        Marks.LabelFont := AppFont ;
        Marks.Visible := True;
        Marks.Frame.Visible := False;
        Marks.LinkPen.Color := clBlack;
        FindPercent(MaxQuery,Ca,Mg,Na,HCO3,SO4,Cl);
        Title := GetSeriesTitle(MaxQuery);
        LabelText := GetLabelText(MaxQuery);
        Ca:=Ca/2;
        MG:=MG/2;
        NA:=NA/2;
        CL:=CL/2;
        SO4:=SO4/2;
        HCO3:=HCO3/2;
        topx:=0;
        sidey:=0;
        if Ca > 25 then
        begin
          topx:= LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+NA/25*TriangleBaseLength+MG/25*TriangleBaseLength*0.5;
          topy:=LeftDiamondYorigin +1.5*TriangleBaseLength+MG/25*TriangleBaseLength*0.8660254;
          addxy(topx,topy,LabelText,SeriesColor);
        end;
        if NA > 25 then
        begin
          topx:=LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+2*TriangleBaseLength+((NA-25)/25+0.5*MG/25)*TriangleBaseLength;
          topy:=LeftDiamondYorigin +1.5*TriangleBaseLength+MG/25*TriangleBaseLength*0.8660254;
          addxy(topx,topy,LabelText,SeriesColor);
        end;
        if  (Ca <= 25) and (NA<= 25) then
        begin
          topx:=LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+TriangleBaseLength
              +0.5*TriangleBaseLength*NA/25+0.5*TriangleBaseLength*((25-CA)/25);
          topy:=leftDiamondYorigin +1.5*TriangleBaseLength+MG/50*2*TriangleBaseLength*0.8660254;
          addxy(topx,topy,LabelText,SeriesColor);
        end;
        if HCO3 > 25 then
       begin
          sidex:=LeftDiamondXorigin+2*TriangleBaseLength*0.8660254-SO4/25*TriangleBaseLength*0.8660254;
          sidey:=LeftDiamondYorigin +1.5*TriangleBaseLength-CL/25*TriangleBaseLength-0.5*SO4/25
         *TriangleBaseLength ;
          addxy(sidex,sidey,LabelText,SeriesColor);
        end;
        if CL > 25 then
        begin
          sidex:=LeftDiamondXorigin+2*TriangleBaseLength*0.8660254-SO4/25*TriangleBaseLength*0.8660254;
          sidey:=LeftDiamondYorigin +1.5*TriangleBaseLength-2*TriangleBaseLength-((CL-25)/25+0.5*SO4/25)
                *TriangleBaseLength;
          addxy(sidex,sidey,LabelText,SeriesColor);
        end;
        if (HCO3 <= 25) and (CL<= 25) then
        begin
          sidex:=LeftDiamondXorigin+2*TriangleBaseLength*0.8660254-SO4/50*2*TriangleBaseLength*0.8660254;
          sidey:=LeftDiamondYorigin +1.5*TriangleBaseLength-TriangleBaseLength
           -0.5* TriangleBaseLength*CL/25
           -0.5* TriangleBaseLength*((25-HCO3)/25);
          addxy(sidex,sidey,LabelText,SeriesColor);
        end;
        { Classification square}
        AddXY(topx,sidey,LabelText,SeriesColor);
      end;
      MaxQuery.Next;
     end;
  end;
end;

procedure TChemChartsForm.ExDurovCreateSeries;
begin
   {Chartdimensions}
   LeftDiamondXorigin:=6;
   LeftDiamondYorigin:=35;
   TriangleBaseLength:=18;
   {Figures}
   {Square figure}
   BorderSeries.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254,
              LeftDiamondYorigin+0.5*TriangleBaseLength+TriangleBaseLength,
                   '',clBlack);
   BorderSeries.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+3*TriangleBaseLength,
              LeftDiamondYorigin+0.5*TriangleBaseLength+TriangleBaseLength,'',clBlack);
   BorderSeries.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+3*TriangleBaseLength,     //3
              LeftDiamondYorigin-0.5*TriangleBaseLength-TriangleBaseLength,'',clBlack);
   BorderSeries.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254,
              LeftDiamondYorigin-0.5*TriangleBaseLength-TriangleBaseLength,'',clBlack);

   BorderSeries.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254,
              LeftDiamondYorigin+0.5*TriangleBaseLength+TriangleBaseLength,
                   '',clBlack);
   BorderSeries.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254, NaN,' ');
   {Top Diamond figure}
   BorderSeries.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+TriangleBaseLength,
              LeftDiamondYorigin+0.5*TriangleBaseLength+TriangleBaseLength+TriangleBaseLength*0.8660254,
                   '',clBlack);
   BorderSeries.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+TriangleBaseLength+0.5*TriangleBaseLength,
              LeftDiamondYorigin+0.5*TriangleBaseLength+TriangleBaseLength+2*TriangleBaseLength*0.8660254,'',clBlack);
   BorderSeries.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+2*TriangleBaseLength,     //3
              LeftDiamondYorigin+0.5*TriangleBaseLength+TriangleBaseLength+TriangleBaseLength*0.8660254,'',clBlack);
   BorderSeries.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+TriangleBaseLength+0.5*TriangleBaseLength,
              LeftDiamondYorigin+0.5*TriangleBaseLength+TriangleBaseLength,'',clBlack);
   BorderSeries.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+TriangleBaseLength,
              LeftDiamondYorigin+0.5*TriangleBaseLength+TriangleBaseLength+TriangleBaseLength*0.8660254,
                   '',clBlack);
   BorderSeries.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+TriangleBaseLength, NaN,' ');
   BorderSeries.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+TriangleBaseLength+0.5*TriangleBaseLength, LeftDiamondYorigin+0.5*TriangleBaseLength+TriangleBaseLength+2*TriangleBaseLength*0.8660254, '',clBlack);
   BorderSeries.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+TriangleBaseLength+0.5*TriangleBaseLength, LeftDiamondYorigin+0.5*TriangleBaseLength+TriangleBaseLength+2*TriangleBaseLength*0.8660254, '',clBlack);
   BorderSeries.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+TriangleBaseLength+0.5*TriangleBaseLength, NaN,' ');
   ExpGridLines.AddXY(LeftDiamondXorigin + 2 * TriangleBaseLength * 0.8660254 + TriangleBaseLength,
                      LeftDiamondYorigin + 0.5 * TriangleBaseLength + TriangleBaseLength + TriangleBaseLength * 0.8660254, '',clBlack);
   ExpGridLines.AddXY(LeftDiamondXorigin + 2 * TriangleBaseLength * 0.8660254 + 2 * TriangleBaseLength,
                      LeftDiamondYorigin + 0.5 * TriangleBaseLength + TriangleBaseLength + TriangleBaseLength * 0.8660254, '',clBlack);
   ExpGridLines.AddXY(LeftDiamondXorigin + 2 * TriangleBaseLength * 0.8660254 + 2 * TriangleBaseLength, NaN, '');

   {Left Diamond figure}
   BorderSeries.AddXY(LeftDiamondXorigin, LeftDiamondYorigin,'',clBlack); //1
   BorderSeries.AddXY(LeftDiamondXorigin+TriangleBaseLength*0.8660254,       //2
              LeftDiamondYorigin+0.5*TriangleBaseLength,'',clBlack);
   BorderSeries.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254,     //3
              LeftDiamondYorigin,'',clBlack);
   BorderSeries.AddXY(LeftDiamondXorigin+TriangleBaseLength*0.8660254,       //4
              LeftDiamondYorigin-0.5*TriangleBaseLength,'',clBlack);
   BorderSeries.AddXY(LeftDiamondXorigin, LeftDiamondYorigin,'',clBlack); //1
   BorderSeries.AddXY(LeftDiamondXorigin+TriangleBaseLength*0.8660254, NaN,' ');
   ExpGridLines.AddXY(LeftDiamondXorigin+TriangleBaseLength*0.8660254,       //4
           LeftDiamondYorigin-0.5*TriangleBaseLength,'',clBlack);
   ExpGridLines.AddXY(LeftDiamondXorigin+TriangleBaseLength*0.8660254,       //2
           LeftDiamondYorigin+0.5*TriangleBaseLength,'',clBlack);
   ExpGridLines.AddXY(LeftDiamondXorigin+TriangleBaseLength*0.8660254, NaN,' ');

   {Left bottom triangle}
   DrawTriangle(LeftDiamondXorigin+TriangleBaseLength*0.8660254,
              LeftDiamondYorigin-TriangleBaseLength,
              LeftDiamondXorigin+2*TriangleBaseLength*0.8660254,
              LeftDiamondYorigin-0.5*TriangleBaseLength,
              LeftDiamondXorigin+2*TriangleBaseLength*0.8660254,
              LeftDiamondYorigin-1.5*TriangleBaseLength);

   DrawTriangle(LeftDiamondXorigin+TriangleBaseLength*0.8660254,
              LeftDiamondYorigin+TriangleBaseLength,
              LeftDiamondXorigin+2*TriangleBaseLength*0.8660254,
              LeftDiamondYorigin+0.5*TriangleBaseLength,
              LeftDiamondXorigin+2*TriangleBaseLength*0.8660254,
              LeftDiamondYorigin+1.5*TriangleBaseLength);
    {Top left triangle}
   DrawTriangle(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254,
              LeftDiamondYorigin+0.5*TriangleBaseLength+TriangleBaseLength,
              LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+0.5*TriangleBaseLength,
              LeftDiamondYorigin+0.5*TriangleBaseLength+TriangleBaseLength+TriangleBaseLength*0.8660254,
              LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+TriangleBaseLength,
              LeftDiamondYorigin+0.5*TriangleBaseLength+TriangleBaseLength);
   {Top right triangle}
   DrawTriangle(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+2*TriangleBaseLength,
              LeftDiamondYorigin+0.5*TriangleBaseLength+TriangleBaseLength,
              LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+2*TriangleBaseLength+0.5*TriangleBaseLength,
              LeftDiamondYorigin+0.5*TriangleBaseLength+TriangleBaseLength+TriangleBaseLength*0.8660254,
              LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+3*TriangleBaseLength,
              LeftDiamondYorigin+0.5*TriangleBaseLength+TriangleBaseLength);
   {GridLines}
   ExpGridLines.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+TriangleBaseLength,
             LeftDiamondYorigin+0.5*TriangleBaseLength+TriangleBaseLength,'',clBlack);
   ExpGridLines.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+TriangleBaseLength,
             LeftDiamondYorigin-0.5*TriangleBaseLength-TriangleBaseLength,'',clBlack);
   ExpGridLines.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+TriangleBaseLength, NaN,'');

   ExpGridLines.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+2*TriangleBaseLength,
             LeftDiamondYorigin+0.5*TriangleBaseLength+TriangleBaseLength,'',clBlack);
   ExpGridLines.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+2*TriangleBaseLength,
             LeftDiamondYorigin-0.5*TriangleBaseLength-TriangleBaseLength,'',clBlack);
   ExpGridLines.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+TriangleBaseLength, NaN,'');

   ExpGridLines.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254,
             LeftDiamondYorigin+0.5*TriangleBaseLength,'',clBlack);
   ExpGridLines.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+3*TriangleBaseLength,
             LeftDiamondYorigin+0.5*TriangleBaseLength,'',clBlack);
   ExpGridLines.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+3*TriangleBaseLength, NaN,'');

   ExpGridLines.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254,
             LeftDiamondYorigin-0.5*TriangleBaseLength,'',clBlack);
   ExpGridLines.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+3*TriangleBaseLength,
             LeftDiamondYorigin-0.5*TriangleBaseLength,'',clBlack);
   ExpGridLines.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+3*TriangleBaseLength, NaN,'');

   {labels}
   ExpDurovLabels.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254,
           LeftDiamondYorigin+1.5*TriangleBaseLength + 9,'Ca',clBlack);
   ExpDurovLabels.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254-15,
           LeftDiamondYorigin+1.5*TriangleBaseLength - 3,'CO3+HCO3',clBlack);
   ExpDurovLabels.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+1.5*TriangleBaseLength,
           LeftDiamondYorigin+1.5*TriangleBaseLength + 31,'Mg',clBlack);
   ExpDurovLabels.AddXY(LeftDiamondXorigin+2*TriangleBaseLength*0.8660254+3*TriangleBaseLength,
           LeftDiamondYorigin+1.5*TriangleBaseLength + 9,'Na+K',clBlack);
   ExpDurovLabels.AddXY(LeftDiamondXorigin - 2, LeftDiamondYorigin + 1,'SO4',clBlack);
   ExpDurovLabels.AddXY(LeftDiamondXorigin+TriangleBaseLength*0.8660254 + 3,
           LeftDiamondYorigin-1.5*TriangleBaseLength + 3,'Cl',clBlack);
   //Draw expanded durov gridlines
   drawExpDurovGridlines;
end;

procedure TChemChartsForm.CreateGraphs(DiagramType: Byte; var g: TChart);
begin
   case DiagramType of
     0: begin
          g:= PiperChart;
          PiperCreateSeries;
          PiperAddPoints;
          g.Visible:= true;
          g.Align := alClient;
          GraphPiperSettings(g);
        end;
     1: begin
          g:= SchoellerChart;
          SchoelAddPoints;
          GraphSchoellerSettings(g);
          g.Visible:= True;
        end;
     2: begin
          g:= DurovChart;
          DurovCreateSeries;
          DurovAddPoints;
          GraphDurovSettings(g);
          g.Visible:= True;
        end;
     3: begin
          g:= SARChart;
          SARCreateSeries;
          SARAddPoints;
          GraphSARSettings(g);
          g.Visible:= True;
        end;
     4: begin
          g:= EDurovChart;
          ExDurovCreateSeries;
          ExpDurovAddPoints;
          g.Visible:= True;
        end;
   end; //of case
end;

procedure TChemChartsForm.GraphSchoellerSettings(g:TChart);
var g1: Word;
begin
  g.Title.Font := AppFont;
  for g1 := 0 to g.SeriesCount -1 do
  begin
    (g.series[g1] as TLineSeries).Marks.Visible:= False;
    (g.series[g1] as TLineSeries).Marks.Frame.Visible := False;
    (g.series[g1] as TLineSeries).Marks.Arrow.Visible:= False;
    (g.series[g1] as TLineSeries).LinePen.Width:= 0;
  end;
  g.BackColor:= clWhite;
  g.Legend.Font := AppFont;
  with g.LeftAxis do
  begin
    Title.LabelFont.Orientation := 900;
    Marks.LabelFont := AppFont;
    Visible:= True;
    Grid.Width:= 0;
    Grid.Style:= psDot;
  end;
  g.AxisVisible:= True;
  with g.BottomAxis do
  begin
    Grid.Visible:= False;
    Grid.Style:= psDot;
    Marks.LabelFont := AppFont;
  end;
  g.Margins.Left:= 2;
  g.Margins.Right:= 5;
  g.Margins.Top:= 5;
  g.Margins.Bottom:= 5;
  g.Repaint;
  g.Refresh;
  g.Invalidate;
end;

procedure TChemChartsForm.GraphDurovSettings(g:TChart);
begin
  g.Title.Font := AppFont;
  g.LeftAxis.Visible:= False;
  g.AxisVisible:= False;
  g.Legend.Font := AppFont;
  g.BottomAxis.Marks.Visible:= False;
  g.LeftAxis.Marks.Visible:= False;
  g.BottomAxis.Grid.Visible:= False;
  g.leftAxis.Grid.Visible:= False;
  g.Margins.Left:= 5;
  g.Margins.Right:= 5;
  g.Margins.Bottom:= 5;
  g.Margins.Top:= 5;
  g.Legend.Visible:= False;
  g.Repaint;
end;

procedure TChemChartsForm.GraphPiperSettings(g:TChart);
begin
   g.Title.Text.Clear;
   g.Title.Text.Add('Piper Diagram ');
   g.Title.Font := AppFont;
   g.AxisVisible:= False;
   g.Legend.Font := AppFont;
   g.BottomAxis.Marks.Visible:= False;
   g.LeftAxis.Marks.Visible:= False;
   g.BottomAxis.Grid.Visible:= False;
   g.LeftAxis.Grid.Visible:= False;
   g.Margins.Left:= 5;
   g.Margins.Bottom:= 5;
   g.Margins.Top:= 5;
   g.Margins.Right:= 5;
   g.Legend.Visible:= False;
   g.Repaint;
end;

procedure TChemChartsForm.GraphSARSettings(g:TChart);
var
  a: Byte;
begin
  g.Title.Font := AppFont;
  g.Legend.Font := AppFont;
  g.Legend.Visible:= False;
  for a := 0 to 3 do
  begin
   g.AxisList[a].Marks.LabelFont := AppFont;
   g.AxisList[a].Title.LabelFont := AppFont;
  end;
  g.LeftAxis.Title.LabelFont.Orientation := 900;
end;

procedure TChemChartsForm.SARCreateSeries;
var
  MinX, MaxX: Real;
begin
  MinX := 10 * ECFactor;
  MaxX := 500 * ECFactor;
  //Chart diagonals
  SARDiagonals.AddXY(MaxX, NaN, '', clBlack);
  SARDiagonals.AddXY(MaxX, 2.5, '', clBlack);
  SARDiagonals.AddXY(MinX, 10, '', clBlack);
  SARDiagonals.AddXY(MaxX, NaN, '', clBlack);
  SARDiagonals.AddXY(MaxX, 6.75, '', clBlack);
  SARDiagonals.AddXY(MinX, 18, '', clBlack);
  SARDiagonals.AddXY(MaxX, NaN, '', clBlack);
  SARDiagonals.AddXY(MaxX, 11, '', clBlack);
  SARDiagonals.AddXY(MinX, 26.5, '', clBlack);
  //S Series for Right Axis
  S1Series.AddXY(10, 2, 'S1: Low', clBlack);
  S2Series.AddXY(10, 5, 'S2: Medium', clBlack);
  S3Series.AddXY(10, 9, 'S3: High', clBlack);
  S4Series.AddXY(10, 21, 'S4: Very high', clBlack);
  //C Series for Top Axis
  C1Series.AddXY(15, 5, 'C1: Low', clBlack);
  C2Series.AddXY(45, 5, 'C2: Medium', clBlack);
  C3Series.AddXY(125, 5, 'C3: High', clBlack);
  C4Series.AddXY(355, 5, 'C4: Very high', clBlack);
  //create the first 2 groups
  SARChart.Legend.GroupTitles.Add('Sodium (Alkalinity) hazard');
  SARChart.Legend.GroupTitles.Add('Salinity hazard');
  //Bottom Axis Settings
  SARChart.BottomAxis.Range.Min := MinX;
  SARChart.BottomAxis.Range.Max := MaxX;
  SARChart.BottomAxis.Title.Caption := 'Salinity Hazard (Electrical Conductivity [' + ECUnit + '])';
  //Fill ListChartSource for the X axis
  with ListChartSourceSARx do
  begin
    Clear;
    Add(MinX, 0, FloatToStrF(MinX, ffFixed, 15, 0), clBlack);
    Add(25 * ECFactor, 0, FloatToStrF(25 * ECFactor, ffFixed, 15, 0), clBlack);
    Add(75 * ECFactor, 0, FloatToStrF(75 * ECFactor, ffFixed, 15, 0), clBlack);
    Add(225 * ECFactor, 0, FloatToStrF(225 * ECFactor, ffFixed, 15, 0), clBlack);
  end;
end;

procedure TChemChartsForm.PiperCreateSeries;
  const Xdisplacement = 60;
begin
  //Draw Piper shapes
  with PiperLeftTriangle do
  begin
    AddXY(0, 0, '', clWhite);
    AddXY(40, 0, '', clWhite);
    AddXY(20, 40, '', clWhite);
    AddXY(0, 0, '', clWhite);
  end;
  with PiperRightTriangle do
  begin
    AddXY(60, 0, '', clWhite);
    AddXY(100, 0, '', clWhite);
    AddXY(80, 40, '', clWhite);
    AddXY(60, 0, '', clWhite);
  end;
  with PiperDiamond do
  begin
    AddXY(50, 20, '', clWhite);
    AddXY(30, 60, '', clWhite);
    AddXY(50, 100, '', clWhite);
    AddXY(70, 60, '', clWhite);
    AddXY(50, 20, '', clWhite);
  end;
  {Arrow PiperLines}
  with ArrowSeries do
  begin
    AddVector(32, 35, 8, -15, 'Left Arrow', clBlack);
    AddVector(68, 35, -8, -15, 'Right Arrow', clBlack);
    NormalizeVectors(30);
  end;
  with PiperLines do
  begin
    {Left Triangle}
    {Diagonal PiperLines left right}
    AddXY(32,0,' ',clBlack);  AddXY(36,8,' ',clBlack);
    AddXY(36, NaN,' ');
    AddXY(32,16,' ',clBlack);  AddXY(24,0,' ',clBlack);
    AddXY(24, NaN,' ');
    AddXY(16,0,' ',clBlack);   AddXY(28,24,' ',clBlack);
    AddXY(28, NaN,' ');
    AddXY(24,32,' ',clBlack);   AddXY(8,0,' ',clBlack);
    AddXY(28, NaN,' ');
    {Horizontal PiperLines}
    AddXY(4,8,' ',clBlack);   AddXY(36,8,' ',clBlack);
    AddXY(36, NaN,' ');
    AddXY(8,16,' ',clBlack);   AddXY(32,16,' ',clBlack);
    AddXY(32, NaN,' ');
    AddXY(12,24,' ',clBlack);   AddXY(28,24,' ',clBlack);
    AddXY(28, NaN,' ');
    AddXY(16,32,' ',clBlack);   AddXY(24,32,' ',clBlack);
    AddXY(24,NaN,' ');
    {Diagonal PiperLines right/left}
    AddXY(16,32,' ',clBlack);   AddXY(32,0,' ',clBlack);
    AddXY(32, NaN,' ');
    AddXY(24,0,' ',clBlack);   AddXY(12,24,' ',clBlack);
    AddXY(12, NaN,' ') ;
    AddXY(16,0,' ',clBlack);   AddXY(8,16,' ',clBlack);
    AddXY(8, NaN,' ');
    AddXY(8,0,' ',clBlack);   AddXY(4,8,' ',clBlack);
    AddXY(4, NaN,' ');
    {Right Triangle}
    {Diagonal PiperLines left right}
    AddXY(Xdisplacement +  32,0,' ',clBlack);  AddXY(Xdisplacement +  36,8,' ',clBlack);
    AddXY(Xdisplacement +  36, NaN,' ');
    AddXY(Xdisplacement +  32,16,' ',clBlack);  AddXY(Xdisplacement +  24,0,' ',clBlack);
    AddXY(Xdisplacement +  24, NaN,' ');
    AddXY(Xdisplacement +  16,0,' ',clBlack);   AddXY(Xdisplacement +  28,24,' ',clBlack);
    AddXY(Xdisplacement +  28, NaN,' ') ;
    AddXY(Xdisplacement +  24,32,' ',clBlack);   AddXY(Xdisplacement +  8,0,' ',clBlack);
    AddXY(Xdisplacement +  28, NaN,' ') ;
    {Horizontal PiperLines}
    AddXY(Xdisplacement +  4,8,' ',clBlack);   AddXY(Xdisplacement +  36,8,' ',clBlack);
    AddXY(Xdisplacement +  36, NaN,' ');
    AddXY(Xdisplacement +  8,16,' ',clBlack);   AddXY(Xdisplacement +  32,16,' ',clBlack);
    AddXY(Xdisplacement +  32, NaN,' ');
    AddXY(Xdisplacement +  12,24,' ',clBlack);   AddXY(Xdisplacement +  28,24,' ',clBlack);
    AddXY(Xdisplacement +  28, NaN,' ');
    AddXY(Xdisplacement +  16,32,' ',clBlack);   AddXY(Xdisplacement +  24,32,' ',clBlack);
    AddXY(Xdisplacement +  24, NaN,' ');
    {Diagonal PiperLines right/left}
    AddXY(Xdisplacement +  16,32,' ',clBlack);   AddXY(Xdisplacement +  32,0,' ',clBlack);
    AddXY(Xdisplacement +  20, NaN,' ');
    AddXY(Xdisplacement +  24,0,' ',clBlack);   AddXY(Xdisplacement +  12,24,' ',clBlack);
    AddXY(Xdisplacement +  12, NaN,' ');
    AddXY(Xdisplacement +  16,0,' ',clBlack);   AddXY(Xdisplacement +  8,16,' ',clBlack);
    AddXY(Xdisplacement +  8, NaN,' ');
    AddXY(Xdisplacement +  8,0,' ',clBlack);   AddXY(Xdisplacement +  4,8,' ',clBlack);
    AddXY(Xdisplacement +  4, NaN,' ');
    {Diamond}
    {Diagonal PiperLines left right}
    AddXY(34,52,' ',clBlack);   AddXY(54,92,' ',clBlack);
    AddXY(54, NaN,' ');
    AddXY(38,44,' ',clBlack);   AddXY(58,84,' ',clBlack);
    AddXY(58,NaN,' ');
    AddXY(42,36,' ',clBlack);   AddXY(62,76,' ',clBlack);
    AddXY(62,NaN,' ');
    AddXY(46,28,' ',clBlack);   AddXY(66,68,' ',clBlack);
    AddXY(66, NaN,' ');
    {Diagonal PiperLines right left}
    AddXY(54,28,' ',clBlack);   AddXY(34,68,' ',clBlack);
    AddXY(34, NaN,' ');
    AddXY(58,36,' ',clBlack);   AddXY(38,76,' ',clBlack);
    AddXY(38, NaN,' ');
    AddXY(62,44,' ',clBlack);   AddXY(42,84,' ',clBlack);
    AddXY(42, NaN,' ');
    AddXY(66,52,' ',clBlack);
    AddXY(46,92,' ',clBlack);
    AddXY(46, NaN,' ');
  end;
  {Label Dimensions}
  with PiperLabels do
  begin
    AddXY(8, -2, '80', clBlack);
    AddXY(16, -2, '60', clBlack);
    AddXY(24, -2, '40', clBlack);
    AddXY(32, -2, '20', clBlack);
    AddXY(20, -6, 'Ca', clBlack);
    AddXY(2, 10, '20', clBlack);
    AddXY(6, 18, '40', clBlack);
    AddXY(10, 26, '60', clBlack);
    AddXY(14, 34, '80', clBlack);
    AddXY(2, 24, 'Mg', clBlack);
    AddXY(26, 34, '20', clBlack);
    AddXY(30, 26, '40', clBlack);
    AddXY(34, 18, '60', clBlack);
    AddXY(38, 10, '80', clBlack);
    AddXY(20, 50, 'Na+K', clBlack);
    AddXY(68, -2, '20', clBlack);
    AddXY(76, -2, '40', clBlack);
    AddXY(84, -2, '60', clBlack);
    AddXY(92, -2, '80', clBlack);
    AddXY(80, -6, 'Cl + NO3', clBlack);
    AddXY(62, 10, '80', clBlack);
    AddXY(66, 18, '60', clBlack);
    AddXY(70, 26, '40', clBlack);
    AddXY(74, 34, '20', clBlack);
    AddXY(80, 52, 'CO3 +', clBlack);
    AddXY(82, 48, 'HCO3', clBlack);
    AddXY(87, 34, '80', clBlack);
    AddXY(91, 26, '60', clBlack);
    AddXY(95, 18, '40', clBlack);
    AddXY(99, 10, '20', clBlack);
    AddXY(98, 24, 'SO4', clBlack);
    AddXY(32, 70, '20', clBlack);
    AddXY(36, 78, '40', clBlack);
    AddXY(40, 86, '60', clBlack);
    AddXY(44, 94, '80', clBlack);
    AddXY(26, 80, 'SO4 + Cl', clBlack);
    AddXY(26, 76, '+ NO3', clBlue);
    AddXY(69, 70, '20', clBlack);
    AddXY(65, 78, '40', clBlack);
    AddXY(61, 86, '60', clBlack);
    AddXY(57, 94, '80', clBlack);
    AddXY(74, 80, 'Ca + Mg', clBlack);
    AddXY(32, 48, '20', clBlack);
    AddXY(36, 40, '40', clBlack);
    AddXY(40, 32, '60', clBlack);
    AddXY(44, 24, '80', clBlack);
    AddXY(68, 48, '20', clBlack);
    AddXY(64, 40, '40', clBlack);
    AddXY(60, 32, '60', clBlack);
    AddXY(56, 24, '80', clBlack);
  end;
end;

procedure TChemChartsForm.DrawDurovGridlines;
var m: integer;
begin
   with DurovGridlines do
   begin
      for m := 1 to 4 do
      begin
         {Left Triangles}
         AddXY(chartxo + baselength*0.8660254*m/5,chartyo-(0.5*baselength*m/5),' ',clBlack);
         AddXY(chartxo + baselength*0.8660254,chartyo+baselength*0.5-(baselength)*m/5,' ',clBlack);
         AddXY(chartxo + baselength*0.8660254, NaN,' ');
         AddXY(chartxo + baselength*0.8660254*m/5,chartyo-(0.5*baselength*m/5),' ',clBlack);
         AddXY(chartxo + baselength*0.8660254*m/5,chartyo+(0.5*baselength*m/5),' ',clBlack);
         AddXY(chartxo + baselength*0.8660254*m/5, NaN,' ');
         AddXY(chartxo + baselength*0.8660254*m/5,chartyo+(0.5*baselength*m/5),' ',clBlack);
         AddXY(chartxo + baselength*0.8660254,chartyo-baselength*0.5+(baselength)*m/5,' ',clBlack);
         AddXY(chartxo + baselength*0.8660254, NaN, ' ');
         {Top Triangles}
         AddXY(chartxo + 0.8660254*baselength + 0.5*baselength*m/5,
         chartyo + 0.5*baselength+ baselength*0.8660254*m/5,' ',clBlack);
         AddXY(chartxo + 0.8660254*baselength + baselength - 0.5*baselength*m/5,
         chartyo + 0.5*baselength+ baselength*0.8660254*m/5,' ',clBlack);
         AddXY(chartxo + 0.8660254*baselength + baselength - 0.5*baselength*m/5, NaN,' ');
         AddXY(chartxo + 0.8660254*baselength + 0.5*baselength*m/5,
         chartyo + 0.5*baselength + baselength*0.8660254*m/5,' ',clBlack);
         AddXY(chartxo + baselength*0.8660254 + baselength*m/5,
         chartyo+0.5*baselength,' ',clBlack);
         AddXY(chartxo + baselength*0.8660254 + baselength*m/5, NaN,' ');
         AddXY(chartxo + baselength*0.8660254 + baselength*m/5,
         chartyo + 0.5*baselength ,' ',clBlack);
         AddXY(chartxo + baselength*0.8660254 + 0.5*baselength+0.5*baselength*m/5,
         chartyo+0.5*baselength + baselength*0.8660254 - baselength*0.8660254*m/5 ,' ',clBlack);
         AddXY(chartxo + baselength*0.8660254 + 0.5*baselength+0.5*baselength*m/5, NaN,' ');
      end;
   end;
end;

procedure TChemChartsForm.DurovCreateSeries;
var x01,x11,y01,y11,y12,x04,x14,y04,y14,x03,x13,y03,x09,x19,y09,y19,x,y,a,b: extended;
begin
   {Chart dimensions and constants}
   chartxo:=7;        {x origin of left triangle}
   chartyo:=50;       {y origin of left triangle}
   baselength:=37;    {triangle baselength}
   squarephw:=20;
   squaretdsw:=40;
   tdsmin:=10;
   tdsmax:=10000;
   DrawDurovGridlines;
   {Left triangle}
   DurovGridlines.LinePen.Width:= 0;
   x01:=Chartxo;  {triangle diagonal up line}
   x11:=Chartxo+baselength*0.866025;
   y01:=chartyo;
   y11:=chartyo+0.5*baselength;
   y12:=chartyo-0.5*baselength;
   DurovLeftTriangle.AddXY(x01, y01, '', clBlack);
   DurovLeftTriangle.AddXY(x11, y11, '', clBlack);
   DurovLeftTriangle.AddXY(x11, y12, '', clBlack);
   DurovLeftTriangle.AddXY(x01, y01, '', clBlack);
   //Build Dseries for left triangle labels
   x:=baselength/10*0.866025;
   y:=baselength/10*0.5;
   //Labels under point
   DurovLabelSeriesBot.addxy(x01+2*x,y01-2*y - 1,'20',clred);
   DurovLabelSeriesBot.addxy(x01+4*x,y01-4*y - 1,'40',clred);
   DurovLabelSeriesBot.addxy(x01+6*x,y01-6*y - 1,'60',clred);
   DurovLabelSeriesBot.addxy(x01+8*x,y01-8*y - 1,'80',clred);
   //Labels above point
   DurovLabelSeriesTop.addxy(x01+6*x-5,y01-6*y-10,'Na + K',clred);
   DurovLabelSeriesTop.addxy(x01+2*x,y01+2*y + 1,'20',clred);
   DurovLabelSeriesTop.addxy(x01+4*x,y01+4*y + 1,'40',clred);
   DurovLabelSeriesTop.addxy(x01+6*x,y01+6*y + 1,'60',clred);
   DurovLabelSeriesTop.addxy(x01+8*x,y01+8*y + 1,'80',clred);
   DurovLabelSeriesTop.addxy(x01+4*x+2,y01+4*y+13,'Ca',clred);
   DurovLabelSeriesTop.addxy(Chartxo-4,chartyo - 1,'Mg',clred);
   {Top Triangle}
   x04:=x11;
   x14:=x04+baselength;
   y04:=y11;
   y14:=y11+baselength*0.866025;
   DurovTopTriangle.AddXY(x04, y04, '', clBlack);
   DurovTopTriangle.AddXY(x04 + (x14-x04)/2, y14, '', clBlack);
   DurovTopTriangle.AddXY(x14, y04, '', clBlack);
   DurovTopTriangle.AddXY(x04, y04, '', clBlack);
  {Labels}
   DurovLabelSeriesTop.addxy(x04+2*y-3,y04+2*x-1,'80',clred);
   DurovLabelSeriesTop.addxy(x04+4*y-3,y04+4*x-1,'60',clred);
   DurovLabelSeriesTop.addxy(x04+6*y-3,y04+6*x-1,'40',clred);
   DurovLabelSeriesTop.addxy(x04+8*y-3,y04+8*x-1,'20',clred);
   DurovLabelSeriesTop.addxy(x04+10*y,y04+10*x,'SO4',clred);
   DurovLabelSeriesTop.addxy(x14-2*y+3,y04+2*x-1,'80',clred);
   DurovLabelSeriesTop.addxy(x14-4*y+3,y04+4*x-1,'60',clred);
   DurovLabelSeriesTop.addxy(x14-6*y+3,y04+6*x-1,'40',clred);
   DurovLabelSeriesTop.addxy(x14-8*y+3,y04+8*x-1,'20',clred);
   DurovLabelSeriesTop.addxy(x04+0.125*baselength-5,y04+0.5*baselength+3,'Cl + NO3  ',clred);
   DurovLabelSeriesTop.addxy(x14+0.125*baselength,y04+0.5*baselength+3,'CO3 + HCO3',clred);
  {Squareph}
   x03:=x04;
   x13:=x14;
   y03:=y12-squarephw;
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025,chartyo - 0.5*baselength,' ',clBlack);
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025+baselength+squaretdsw,chartyo - 0.5*baselength,' ',clBlack);
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025+baselength+squaretdsw, NaN,' ');
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025,chartyo + 0.5*baselength,' ',clBlack);
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025+baselength+squaretdsw,chartyo + 0.5*baselength,' ',clBlack);
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025+baselength+squaretdsw, NaN,' ');
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025+baselength+squaretdsw,chartyo + 0.5*baselength,' ',clBlack);
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025+baselength+squaretdsw,chartyo - 0.5*baselength,' ',clBlack);
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025+baselength+squaretdsw, NaN,' ');
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025+baselength,chartyo + 0.5*baselength,' ',clBlack);
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025+baselength,chartyo - 0.5*baselength-squarephw,' ',clBlack);
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025+baselength+squaretdsw, NaN,' ');
   //bottom left vert line of  square
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025,chartyo + 0.5*baselength,' ',clBlack);
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025,chartyo - 0.5*baselength-squarephw,' ',clBlack);
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025, NaN,' ');
   //bottom line ph square
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025,chartyo - 0.5*baselength-squarephw,' ',clBlack);
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025+baselength,chartyo - 0.5*baselength-squarephw,' ',clBlack);
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025+baselength, NaN,' ');
   // top triangle
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025,chartyo + 0.5*baselength,' ',clBlack);
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025+0.5*baselength,chartyo + 0.5*baselength+0.866025*baselength,' ',clBlack);
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025+0.5*baselength, NaN,' ');
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025+0.5*baselength,chartyo + 0.5*baselength+0.866025*baselength,' ',clBlack);
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025+baselength,chartyo + 0.5*baselength,' ',clBlack);
   DurovBorderlines.AddXY(Chartxo+baselength*0.866025+baselength, NaN,' ');
   // left triangle
   DurovBorderlines.AddXY(Chartxo,Chartyo,' ',clblack);
   DurovBorderlines.AddXY(Chartxo + 0.866025*baselength,Chartyo-0.5*baselength,' ',clblack);
   DurovBorderlines.AddXY(Chartxo + 0.866025*baselength, NaN,' ');
   DurovBorderlines.AddXY(Chartxo,Chartyo,' ',clblack);
   DurovBorderlines.AddXY(Chartxo + 0.866025*baselength,Chartyo+0.5*baselength,' ',clblack);
   DurovBorderlines.AddXY(Chartxo + 0.866025*baselength, NaN,' ');
   {SquareTDS}
   x09:=x14;
   x19:=x14+squaretdsw;
   y09:=y12;
   y19:=y04;
   //One rectangle for ph and TDS field
   DurovRectangles.ZeroLevel := y03;
   DurovRectangles.AddXY(x03, y03, '', clBlack);
   DurovRectangles.AddXY(x13, y03, '', clBlack);
   DurovRectangles.AddXY(x13, y09, '', clBlack);
   DurovRectangles.AddXY(x19, y09, '', clBlack);
   DurovRectangles.AddXY(x19, y19, '', clBlack);
   DurovRectangles.AddXY(x03, y04, '', clBlack);
   DurovRectangles.AddXY(x03, y03, '', clBlack);
   {constants}
   a:= ((x09 + x19)/2);
   b:=y09-5 ;
   DurovLabelSeriesTop.addxy(a,b,'TDS (mg/l)',clGreen);
   a:=log10(tdsmin);
   b:=log10(tdsmax);
   DurovGridlines.AddXY((log10(100)-a)/(b-a)*squaretdsw+x09,y09,' ',clBlack);
   DurovGridlines.AddXY((log10(100)-a)/(b-a)*squaretdsw+x09,y19+3,' ',clBlack);
   DurovGridlines.AddXY((log10(100)-a)/(b-a)*squaretdsw+x09, NaN,' ');
   DurovGridlines.AddXY((log10(1000)-a)/(b-a)*squaretdsw+x09,y09,' ',clBlack);
   DurovGridlines.AddXY((log10(1000)-a)/(b-a)*squaretdsw+x09,y19+3,' ',clBlack);
   DurovGridlines.AddXY((log10(1000)-a)/(b-a)*squaretdsw+x09, NaN,' ');
   DurovLabelSeriesTop.addxy((log10(100)-a)/(b-a)*squaretdsw+x09,y19+3,'100',clGreen);
   DurovLabelSeriesTop.addxy((log10(1000)-a)/(b-a)*squaretdsw+x09,y19+3,'1000',clGreen);
   DurovLabelSeriesTop.addxy((log10(10000)-a)/(b-a)*squaretdsw+x09-1,y19+3,'10000',clGreen);
   DurovLabelSeriesTop.addxy(x13+4,(6/8*squarephw+y03-2),'5',clred);
   DurovLabelSeriesTop.addxy(x13+4,(4/8*squarephw+y03-2),'7',clred);
   DurovLabelSeriesTop.addxy(x13+4,(2/8*squarephw+y03-2),'9',clred);
   DurovLabelSeriesTop.addxy(x13+4 + 5,(4/8*squarephw+y03),'pH',clred);
   DurovGridlines.AddXY(x03,6/8*squarephw+y03,' ',clBlack);
   DurovGridlines.AddXY(x13,6/8*squarephw+y03,' ',clBlack);
   DurovGridlines.AddXY(x13, NaN,' ');
   DurovGridlines.AddXY(x03,4/8*squarephw+y03,' ',clBlack);
   DurovGridlines.AddXY(x13,4/8*squarephw+y03,' ',clBlack);
   DurovGridlines.AddXY(x13, NaN,' ');
   DurovGridlines.AddXY(x03,2/8*squarephw+y03,' ',clBlack);
   DurovGridlines.AddXY(x13,2/8*squarephw+y03,' ',clBlack);
   DurovGridlines.AddXY(x13, NaN,' ');
   DurovLabelSeriesTop.Marks.LabelFont := AppFont;
   DurovLabelSeriesBot.Marks.LabelFont := AppFont;
end;

procedure TChemChartsForm.PiperAddPoints;
var
  Ca,Mg,Na,HCO3,SO4,Cl,Triangle1x,Triangle2X,DiamondX,DiamondY: Double;
  PiperSeries, AvgSeries, MaxSeries, MinSeries: TLineSeries;
  LabelText, PrevSiteID: ShortString;
  TheColour: TColor;
  Idx: Word;
begin
  Randomize;
  PrevSiteID := '';
  Idx := 0;
  PiperChart.Legend.Font := AppFont;
  //normal points without aggregates
  GlobalQuery.First;
  while not GlobalQuery.EOF do
  begin
    if GlobalQuery.FieldByName('SITE_ID_NR').Value <> PrevSiteID then //create a new series
    begin
      PiperSeries := TLineSeries.Create(PiperChart);
      PiperChart.AddSeries(PiperSeries);
      with PiperSeries do
      begin
        Index := Idx;
        Inc(Idx);
        if ClrByGrp then
        begin
          if MemberList.IndexOf(GlobalQuery.FieldByName('MEMBER_ID').Value) > 19 then
            TheColour := clActiveCaption
          else
            TheColour := MyColors[MemberList.IndexOf(GlobalQuery.FieldByName('MEMBER_ID').Value)];
          Legend.GroupIndex := MemberList.IndexOf(GlobalQuery.FieldByName('MEMBER_ID').Value);
        end
        else
        begin
          TheColour := MyColors[Random(19)];
        end;
      end;
    end;
    with PiperSeries do //add to the existing series
    begin
      Tag := 1000;
      SeriesColor := TheColour;
      ShowLines := False;
      ZPosition := Tag;
      Pointer.horizsize := 2;
      Pointer.vertsize := 2;
      Pointer.Pen.Color:= TheColour;
      Pointer.Brush.Color:= TheColour;
      Pointer.OverrideColor := [];
      Pointer.Visible := True;
      ShowPoints := True;
      Marks.Style := smsLabel;
      Marks.LabelFont := AppFont;
      Marks.Visible := False;
      Marks.Frame.Visible := False;
      Marks.Arrow.Visible:= False;
      Marks.LinkPen.Color := clBlack;
      FindPercent(GlobalQuery,Ca,Mg,Na,HCO3,SO4,Cl);
      Title := GetSeriesTitle(GlobalQuery);
      LabelText := GetLabelText(GlobalQuery);
      if ClrByGrp then
        LabelText := GlobalQuery.FieldByName('MEMBER_ID').Value + ': ' + LabelText;
      Ca:= Ca*40/100;
      Mg:= Mg*40/100;
      Triangle1X := (Mg-(2*(40-Ca)))/-2;
      AddXY(Triangle1X, Mg, LabelText, TheColour);
      SO4:= SO4*40/100;
      Cl:= Cl*40/100;
      Triangle2X := SO4-((SO4-2*(60+CL))/2);
      AddXY(Triangle2X, SO4, LabelText, TheColour);
      DiamondX := ((Mg-2*Triangle1X)-(SO4+2*Triangle2X))/-4;
      DiamondY := 2*DiamondX + (Mg - 2*Triangle1X);
      AddXY(DiamondX, DiamondY, LabelText, TheColour);
    end;
    PrevSiteID := GlobalQuery.FieldByName('SITE_ID_NR').Value;
    GlobalQuery.Next;
  end;
  //average aggregate
  AvgQuery.First;
  while not AvgQuery.EOF do
  begin
    AvgSeries := TLineSeries.Create(PiperChart);
    PiperChart.AddSeries(AvgSeries);
    with AvgSeries do
    begin
      Index := Idx;
      Inc(Idx);
      Active := False;
      if ClrByGrp then
      begin
        if MemberList.IndexOf(AvgQuery.FieldByName('MEMBER_ID').Value) > 19 then
          TheColour := clActiveCaption
        else
          TheColour := MyColors[MemberList.IndexOf(AvgQuery.FieldByName('MEMBER_ID').Value)];
        Legend.GroupIndex := MemberList.IndexOf(AvgQuery.FieldByName('MEMBER_ID').Value);
      end
      else
        TheColour := MyColors[Random(19)];
      Tag := 1001;
      SeriesColor := TheColour;
      ShowLines := False;
      ZPosition := Tag;
      Pointer.horizsize := 2;
      Pointer.vertsize := 2;
      Pointer.Pen.Color:= TheColour;
      Pointer.Brush.Color:= TheColour;
      Pointer.OverrideColor := [];
      Pointer.Visible := True;
      ShowPoints := True;
      Marks.Style := smsLabel;
      Marks.LabelFont := AppFont;
      Marks.Visible := False;
      Marks.Frame.Visible := False;
      Marks.Arrow.Visible:= False;
      Marks.LinkPen.Color := clBlack;
      FindPercent(AvgQuery,Ca,Mg,Na,HCO3,SO4,Cl);
      Title := GetSeriesTitle(AvgQuery);
      LabelText := GetLabelText(AvgQuery);
      if ClrByGrp then
        LabelText := AvgQuery.FieldByName('MEMBER_ID').Value + ': ' + LabelText;
      Ca:= Ca*40/100;
      Mg:= Mg*40/100;
      Triangle1X := (Mg-(2*(40-Ca)))/-2;
      AddXY(Triangle1X, Mg, LabelText, TheColour);
      SO4:= SO4*40/100;
      Cl:= Cl*40/100;
      Triangle2X := SO4-((SO4-2*(60+CL))/2);
      AddXY(Triangle2X, SO4, LabelText, TheColour);
      DiamondX := ((Mg-2*Triangle1X)-(SO4+2*Triangle2X))/-4;
      DiamondY := 2*DiamondX + (Mg - 2*Triangle1X);
      AddXY(DiamondX, DiamondY, LabelText, TheColour);
    end;
    AvgQuery.Next;
  end;
  //minimum aggregate
  MinQuery.First;
  while not MinQuery.EOF do
  begin
    MinSeries := TLineSeries.Create(PiperChart);
    PiperChart.AddSeries(MinSeries);
    with MinSeries do
    begin
      Index := Idx;
      Inc(Idx);
      Active := False;
      if ClrByGrp then
      begin
        if MemberList.IndexOf(MinQuery.FieldByName('MEMBER_ID').Value) > 19 then
          TheColour := clActiveCaption
        else
          TheColour := MyColors[MemberList.IndexOf(MinQuery.FieldByName('MEMBER_ID').Value)];
        Legend.GroupIndex := MemberList.IndexOf(MinQuery.FieldByName('MEMBER_ID').Value);
      end
      else
        TheColour := MyColors[Random(19)];
      Tag := 1002;
      SeriesColor := TheColour;
      ShowLines := False;
      ZPosition := Tag;
      Pointer.horizsize := 2;
      Pointer.vertsize := 2;
      Pointer.Pen.Color:= TheColour;
      Pointer.Brush.Color:= TheColour;
      Pointer.OverrideColor := [];
      Pointer.Visible := True;
      ShowPoints := True;
      Marks.Style := smsLabel;
      Marks.LabelFont := AppFont;
      Marks.Visible := False;
      Marks.Frame.Visible := False;
      Marks.Arrow.Visible:= False;
      Marks.LinkPen.Color := clBlack;
      FindPercent(MinQuery,Ca,Mg,Na,HCO3,SO4,Cl);
      Title := GetSeriesTitle(MinQuery);
      LabelText := GetLabelText(MinQuery);
      if ClrByGrp then
        LabelText := MinQuery.FieldByName('MEMBER_ID').Value + ': ' + LabelText;
      Ca:= Ca*40/100;
      Mg:= Mg*40/100;
      Triangle1X := (Mg-(2*(40-Ca)))/-2;
      AddXY(Triangle1X, Mg, LabelText, TheColour);
      SO4:= SO4*40/100;
      Cl:= Cl*40/100;
      Triangle2X := SO4-((SO4-2*(60+CL))/2);
      AddXY(Triangle2X, SO4, LabelText, TheColour);
      DiamondX := ((Mg-2*Triangle1X)-(SO4+2*Triangle2X))/-4;
      DiamondY := 2*DiamondX + (Mg - 2*Triangle1X);
      AddXY(DiamondX, DiamondY, LabelText, TheColour);
    end;
    MinQuery.Next;
  end;
  //maximum aggregate
  MaxQuery.First;
  while not MaxQuery.EOF do
  begin
    MaxSeries := TLineSeries.Create(PiperChart);
    PiperChart.AddSeries(MaxSeries);
    with MaxSeries do
    begin
      Index := Idx;
      Inc(Idx);
      Active := False;
      if ClrByGrp then
      begin
        if MemberList.IndexOf(MaxQuery.FieldByName('MEMBER_ID').Value) > 19 then
          TheColour := clActiveCaption
        else
          TheColour := MyColors[MemberList.IndexOf(MaxQuery.FieldByName('MEMBER_ID').Value)];
        Legend.GroupIndex := MemberList.IndexOf(MaxQuery.FieldByName('MEMBER_ID').Value);
      end
      else
        TheColour := MyColors[Random(19)];
      Tag := 1003;
      SeriesColor := TheColour;
      ShowLines := False;
      ZPosition := Tag;
      Pointer.horizsize := 2;
      Pointer.vertsize := 2;
      Pointer.Pen.Color:= TheColour;
      Pointer.Brush.Color:= TheColour;
      Pointer.OverrideColor := [];
      Pointer.Visible := True;
      ShowPoints := True;
      Marks.Style := smsLabel;
      Marks.LabelFont := AppFont;
      Marks.Visible := False;
      Marks.Frame.Visible := False;
      Marks.Arrow.Visible:= False;
      Marks.LinkPen.Color := clBlack;
      FindPercent(MaxQuery,Ca,Mg,Na,HCO3,SO4,Cl);
      Title := GetSeriesTitle(MaxQuery);
      LabelText := GetLabelText(MaxQuery);
      if ClrByGrp then
        LabelText := MaxQuery.FieldByName('MEMBER_ID').Value + ': ' + LabelText;
      Ca:= Ca*40/100;
      Mg:= Mg*40/100;
      Triangle1X := (Mg-(2*(40-Ca)))/-2;
      AddXY(Triangle1X, Mg, LabelText, TheColour);
      SO4:= SO4*40/100;
      Cl:= Cl*40/100;
      Triangle2X := SO4-((SO4-2*(60+CL))/2);
      AddXY(Triangle2X, SO4, LabelText, TheColour);
      DiamondX := ((Mg-2*Triangle1X)-(SO4+2*Triangle2X))/-4;
      DiamondY := 2*DiamondX + (Mg - 2*Triangle1X);
      AddXY(DiamondX, DiamondY, LabelText, TheColour);
    end;
    MaxQuery.Next;
  end;
  //set index of arrow series to the nr of series
  ArrowSeries.Index := Idx;
end;

procedure TChemChartsForm.MenuItem2Click(Sender: TObject);
const
  MARGIN = 10;
var
  r: TRect;
  d: Integer;
begin
  if PrintDialog1.Execute then
  begin
    Printer.BeginDoc;
    Printer.Title := gc.Title.Text[0];
    try
      r := Rect(0, 0, Printer.PageWidth, Printer.PageHeight div 2);
      d := r.Right - r.Left;
      r.Left += d div MARGIN;
      r.Right -= d div MARGIN;
      d := r.Bottom - r.Top;
      r.Top += d div MARGIN;
      r.Bottom -= d div MARGIN;
      gc.Draw(TPrinterDrawer.Create(Printer), r);
    finally
      Printer.EndDoc;
    end;
  end;
end;

procedure TChemChartsForm.MenuItem5Click(Sender: TObject);
begin
  gc.CopyToClipboardBitmap;
end;

procedure TChemChartsForm.MenuItemPanelClick(Sender: TObject);
begin
  MenuItempanel.Checked := not MenuItemPanel.Checked;
  if MenuItemPanel.Checked then
    gc.Color := clWhite
  else
    gc.Color := clBtnFace;
end;

procedure TChemChartsForm.MenuItemReportClick(Sender: TObject);
begin
  gc.SaveToFile(TJPEGImage, GetTempDir + DirectorySeparator + 'chemchart' + IntToStr(MenuItemReport.Tag) + '.jpg');
end;

procedure TChemChartsForm.MenuItemShowHazardsClick(Sender: TObject);
var
  s: Word;
begin
  //hazard series on or off in legend
  for s := 0 to gc.SeriesCount - 1 do
    if gc.Series[s].Tag = 10000 then //only the ones for the hazard series
      (gc.Series[s] as TLineSeries).ShowInLegend := MenuItemShowHazards.Checked;
end;

procedure TChemChartsForm.MenuItemSideBarClick(Sender: TObject);
begin
  MenuItemSideBar.Checked := not MenuItemSideBar.Checked;
  gc.Legend.UseSidebar := MenuItemSideBar.Checked;
end;

procedure TChemChartsForm.MenuItemSmallerClick(Sender: TObject);
var
  s: Word;
begin
  for s := 0 to gc.SeriesCount - 1 do
  with gc do
  begin
    if Series[s] is TLineSeries then
    begin
      TLineSeries(Series[s]).Marks.LabelFont.Size := TLineSeries(Series[s]).Marks.LabelFont.Size - 1;
      if TLineSeries(Series[s]).Pointer.Visible then
      begin
        TLineSeries(Series[s]).Pointer.HorizSize := TLineSeries(Series[s]).Pointer.HorizSize - 1;
        TLineSeries(Series[s]).Pointer.VertSize := TLineSeries(Series[s]).Pointer.VertSize - 1;
      end;
    end
    else
    if Series[s] is TAreaSeries then
    begin
      TAreaSeries(Series[s]).Marks.LabelFont.Size := TAreaSeries(Series[s]).Marks.LabelFont.Size - 1;
    end;
  end;
  with gc do
  begin
    if LeftAxis.Visible then
    begin
     LeftAxis.Marks.LabelFont.Size := LeftAxis.Marks.LabelFont.Size - 1;
     LeftAxis.Title.LabelFont.Size := LeftAxis.Title.LabelFont.Size - 1;
    end;
    if BottomAxis.Visible then
    begin
     BottomAxis.Marks.LabelFont.Size := BottomAxis.Marks.LabelFont.Size - 1;
     BottomAxis.Title.LabelFont.Size := BottomAxis.Title.LabelFont.Size - 1;
    end;
    Legend.Font.Size := Legend.Font.Size - 1;
    Legend.GroupFont.Size := Legend.GroupFont.Size - 1;
  end;
end;

procedure TChemChartsForm.MenuItemTopLeftClick(Sender: TObject);
begin
  MenuItemTopLeft.Checked := not MenuItemTopLeft.Checked;
  gc.Legend.Alignment := laTopLeft;
end;

procedure TChemChartsForm.MenuItemTopRightClick(Sender: TObject);
begin
  MenuItemTopRight.Checked := not MenuItemTopRight.Checked;
  gc.Legend.Alignment := laTopRight;
end;

procedure TChemChartsForm.FormShow(Sender: TObject);
var
  m: Word;
begin
  GlobalQuery.Open;
  AvgQuery.Open;
  MaxQuery.Open;
  MinQuery.Open;
  CreateGraphs(ChtType, gc);
  ActiveControl := gc; //make the chart active
  gc.SetFocus;
  SetHintToolSeries(gc);
  if ClrByGrp then
    for m := 0 to MemberList.Count - 1 do
      gc.Legend.GroupTitles.Add(MemberList[m]);
  gc.Legend.Font := AppFont;
  gc.Legend.GroupFont := AppFont;
  gc.Align := alClient;
  Caption := gc.Title.Text[0];
  case gc.Tag of
    1,3: ClientWidth := 500;
    2: ClientWidth := 450;
    4: begin
         ClientWidth := 500;
         ClientHeight := 500;
       end
  else ClientWidth := 350;
  end; //of case
  OrigWidth := Width;
  //if for showing on report then
  if MenuItemReport.Visible then
  begin
    gc.SaveToFile(TJPEGImage, GetTempDir + DirectorySeparator + 'chemchart' + IntToStr(MenuItemReport.Tag) + '.jpg');
    if Cht1Tag = -1 then
      Cht1Tag := MenuItemReport.Tag
    else
    if Cht2Tag = -1 then
      Cht2Tag := MenuItemReport.Tag;
  end;
end;

procedure TChemChartsForm.GlobalQueryBeforeOpen(DataSet: TDataSet);
var
  m: Word;
begin
  with GlobalQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT f.SITE_ID_NR, b.NR_ON_MAP, b.REGION_BB, b.ALT_NO_1, b.ALT_NO_2, c0.SAMPLE_NR, c0.CHM_REF_NR, c0.DATE_SAMPL, c0.TIME_SAMPL, c0.DEPTH_SAMP, c1.PH, c1.EC, c1.TDS, c1.CA, c1.MG, c1.Na, c1.MALK, c1.HCO3, c1.CO3, c1.SO4, c1.CL, c1.K, c1.F, c1.N');
    if ClrByGrp then
      SQL.Add(', m.MEMBER_ID');
    SQL.Add('FROM ' + FilterTableName + ' f');
    SQL.Add('JOIN basicinf b ON (f.SITE_ID_NR = b.SITE_ID_NR)');
    SQL.Add('JOIN chem_000 c0 ON (f.SITE_ID_NR = c0.SITE_ID_NR)');
    if DataModuleMain.ZConnectionDB.Tag = 1 then //sqlite
      SQL.Add('AND c0.DATE_SAMPL || c0.TIME_SAMPL >= ' + QuotedStr(StartDate + StartTime)
        + ' AND c0.DATE_SAMPL || c0.TIME_SAMPL <= ' + QuotedStr(EndDate + EndTime))
    else
      SQL.Add('AND CONCAT(c0.DATE_SAMPL, c0.TIME_SAMPL) >= ' + QuotedStr(StartDate + StartTime)
        + ' AND CONCAT(c0.DATE_SAMPL, c0.TIME_SAMPL) <= ' + QuotedStr(EndDate + EndTime));
    SQL.Add('JOIN chem_001 c1 ON (c0.CHM_REF_NR = c1.CHM_REF_NR)');
    if IsCurrentSite then
      SQL.Add('WHERE f.SITE_ID_NR = ' + QuotedStr(CurrentSite))
    else //check for colouring by group membership
    if ClrByGrp then
    begin
      for m := 0 to MemberList.Count - 1 do
      begin
        if m < MemberList.Count - 1 then
          MemberStr := MemberStr + QuotedStr(MemberList[m]) + ', '
        else
          MemberStr := MemberStr + QuotedStr(MemberList[m]);
      end;
      SQL.Add('JOIN member__ m ON (f.SITE_ID_NR = m.SITE_ID_NR)');
      SQL.Add('AND m.MEMBER_ID IN (' + MemberStr + ')');
    end;
    SQL.Add('ORDER BY f.SITE_ID_NR, c0.DATE_SAMPL, c0.TIME_SAMPL');
  end;
end;

procedure TChemChartsForm.AggrMenuItemClick(Sender: TObject);
var
  c: Word;
begin
  //first set all >= 1000 inactive
  for c := 0 to gc.SeriesCount - 1 do
    if (gc.Series[c].Tag >= 1000) and (gc.Series[c].Tag <= 1003) then //the normal and aggregates
      gc.Series[c].Active := False;
  //then activate series according to menu item tag
  for c := 0 to gc.SeriesCount - 1 do
    if gc.Series[c].Tag = (Sender as TMenuItem).Tag then
      gc.Series[c].Active := True;
end;

procedure TChemChartsForm.MenuItem14Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if VerDiff > 3 then
    MessageDlg(VersionMessage, mtError,[mbOK], 0)
  else
  {$ENDIF}
  with TChartPropDlg.Create(Self) do
  begin
    TempChart := gc;
    if not (gc.Name = 'SARChart') then
      ButtonData.Tag := 1; //for preventing enabled with SeriesChange
    RadioGroupHorAxis.Enabled := False;
    RadioGroupVertAxis.Enabled := False;
    ButtonLinePen.Enabled := gc.Name = 'SchoellerChart';
    CheckBoxShowLines.Enabled := (gc.Name = 'SchoellerChart');
    TabSheetAxes.TabVisible := (gc.Name = 'SARChart') or (gc.Name = 'SchoellerChart');
    TabSheetRight.TabVisible := (gc.Name = 'SARChart');
    TabSheetTop.TabVisible := (gc.Name = 'SARChart');
    if gc.Name = 'SARChart' then
      TempLogAxis[1] := SARBottomAxisTransform
    else
    if gc.Name = 'SchoellerChart' then
      TempLogAxis[0] := SchoellerLeftAxisTransform;
    Show;
  end;
end;

procedure TChemChartsForm.MenuItem1Click(Sender: TObject);
begin
  gc.LeftAxis.Title.LabelFont.Orientation := gc.LeftAxis.Title.LabelFont.Orientation + 900;
end;

procedure TChemChartsForm.MenuItem7Click(Sender: TObject);
begin
  gc.BottomAxis.Title.LabelFont.Orientation := gc.BottomAxis.Title.LabelFont.Orientation + 450;
end;

procedure TChemChartsForm.MenuItemBackgroundClick(Sender: TObject);
begin
  MenuItemBackground.Checked := not MenuItemBackground.Checked;
  if MenuItemBackground.Checked then
    gc.BackColor := clWhite
  else
    gc.BackColor := clBtnFace;
end;

procedure TChemChartsForm.MenuItemBiggerClick(Sender: TObject);
var
  s: Word;
begin
  for s := 0 to gc.SeriesCount - 1 do
  with gc do
  begin
    if Series[s] is TLineSeries then
    begin
      TLineSeries(Series[s]).Marks.LabelFont.Size := TLineSeries(Series[s]).Marks.LabelFont.Size + 1;
      if TLineSeries(Series[s]).Pointer.Visible then
      begin
        TLineSeries(Series[s]).Pointer.HorizSize := TLineSeries(Series[s]).Pointer.HorizSize + 1;
        TLineSeries(Series[s]).Pointer.VertSize := TLineSeries(Series[s]).Pointer.VertSize + 1;
      end;
    end
    else
    if Series[s] is TAreaSeries then
    begin
      TAreaSeries(Series[s]).Marks.LabelFont.Size := TAreaSeries(Series[s]).Marks.LabelFont.Size + 1;
    end;
  end;
  with gc do
  begin
    if LeftAxis.Visible then
    begin
      LeftAxis.Marks.LabelFont.Size := LeftAxis.Marks.LabelFont.Size + 1;
      LeftAxis.Title.LabelFont.Size := LeftAxis.Title.LabelFont.Size + 1;
    end;
    if BottomAxis.Visible then
    begin
      BottomAxis.Marks.LabelFont.Size := BottomAxis.Marks.LabelFont.Size + 1;
      BottomAxis.Title.LabelFont.Size := BottomAxis.Title.LabelFont.Size + 1;
    end;
    Legend.Font.Size := Legend.Font.Size + 1;
    Legend.GroupFont.Size := Legend.GroupFont.Size + 1;
  end;
end;

procedure TChemChartsForm.MenuItemBotCentreClick(Sender: TObject);
begin
  MenuItemBotCentre.Checked := not MenuItemBotCentre.Checked;
  gc.Legend.Alignment := laBottomCenter;
end;

procedure TChemChartsForm.MenuItemBotLeftClick(Sender: TObject);
begin
  MenuItemBotLeft.Checked := not MenuItemBotLeft.Checked;
  gc.Legend.Alignment := laBottomLeft;
end;

procedure TChemChartsForm.MenuItemBotRightClick(Sender: TObject);
begin
  MenuItemBotRight.Checked := not MenuItemBotRight.Checked;
  gc.Legend.Alignment := laBottomRight;
end;

procedure TChemChartsForm.MenuItemFrameClick(Sender: TObject);
begin
  MenuItemFrame.Checked := not MenuItemFrame.Checked;
  if MenuItemFrame.Checked then
    gc.Frame.Visible := True
  else
    gc.Frame.Visible := False;
end;

procedure TChemChartsForm.MenuItemLegendEnabledClick(Sender: TObject);
begin
  MenuItemLegendEnabled.Checked := not MenuItemLegendEnabled.Checked;
  gc.Legend.Visible := MenuItemLegendEnabled.Checked;
  if gc.Legend.Visible and gc.Legend.UseSidebar and (gc.Legend.Alignment <> laBottomCenter) then
  begin
    OrigWidth := Width;
    Width := Round(Width * 1.3)
  end
  else
    Width := OrigWidth;
end;

procedure TChemChartsForm.ChartToolset1UserDefinedTool1AfterMouseUp(
  ATool: TChartTool; APoint: TPoint);
begin
  with gc.ClientToScreen(APoint) do
    PopupMenu1.PopUp(X, Y);
end;

procedure TChemChartsForm.AggrQueryBeforeOpen(DataSet: TDataSet);
var
  m: Word;
begin
  with (DataSet as TZReadOnlyQuery) do
  begin
    SQL.Clear;
    if (DataSet as TZReadOnlyQuery).Name = 'AvgQuery' then
      SQL.Add('SELECT f.SITE_ID_NR, b.NR_ON_MAP, b.REGION_BB, b.ALT_NO_1, b.ALT_NO_2, AVG(CASE WHEN c1.PH > 1 THEN c1.PH ELSE 0 END) PH, AVG(CASE WHEN c1.EC > 1 THEN c1.EC ELSE 0 END) EC, AVG(CASE WHEN c1.TDS > 1 THEN c1.TDS ELSE 0 END) TDS, AVG(CASE WHEN c1.CA > -1 THEN c1.CA ELSE 0 END) CA, AVG(CASE WHEN c1.MG > -1 THEN c1.MG ELSE 0 END) MG, AVG(CASE WHEN c1.NA > -1 THEN c1.NA ELSE 0 END) NA, AVG(CASE WHEN c1.MALK > 1 THEN c1.MALK ELSE 0 END) MALK, AVG(CASE WHEN c1.HCO3 > -1 THEN c1.HCO3 ELSE 0 END) HCO3, AVG(CASE WHEN c1.CO3 > -1 THEN c1.CO3 ELSE 0 END) CO3, AVG(CASE WHEN c1.SO4 > -1 THEN c1.SO4 ELSE 0 END) SO4, AVG(CASE WHEN c1.CL > -1 THEN c1.CL ELSE 0 END) CL, AVG(CASE WHEN c1.K > -1 THEN c1.K ELSE 0 END) K, AVG(CASE WHEN c1.F > -1 THEN c1.F ELSE 0 END) F, AVG(CASE WHEN c1.N > -1 THEN c1.n ELSE 0 END) N')
    else
    if (DataSet as TZReadOnlyQuery).Name = 'MaxQuery' then
      SQL.Add('SELECT f.SITE_ID_NR, b.NR_ON_MAP, b.REGION_BB, b.ALT_NO_1, b.ALT_NO_2, MAX(CASE WHEN c1.PH > 1 THEN c1.PH ELSE 0 END) PH, MAX(CASE WHEN c1.EC > 1 THEN c1.EC ELSE 0 END) EC, MAX(CASE WHEN c1.TDS > 1 THEN c1.TDS ELSE 0 END) TDS, MAX(CASE WHEN c1.CA > -1 THEN c1.CA ELSE 0 END) CA, MAX(CASE WHEN c1.MG > -1 THEN c1.MG ELSE 0 END) MG, MAX(CASE WHEN c1.NA > -1 THEN c1.NA ELSE 0 END) NA, MAX(CASE WHEN c1.MALK > 1 THEN c1.MALK ELSE 0 END) MALK, MAX(CASE WHEN c1.HCO3 > -1 THEN c1.HCO3 ELSE 0 END) HCO3, MAX(CASE WHEN c1.CO3 > -1 THEN c1.CO3 ELSE 0 END) CO3, MAX(CASE WHEN c1.SO4 > -1 THEN c1.SO4 ELSE 0 END) SO4, MAX(CASE WHEN c1.CL > -1 THEN c1.CL ELSE 0 END) CL, MAX(CASE WHEN c1.K > -1 THEN c1.K ELSE 0 END) K, MAX(CASE WHEN c1.F > -1 THEN c1.F ELSE 0 END) F, MAX(CASE WHEN c1.N > -1 THEN c1.n ELSE 0 END) N')
    else //MinQuery
      SQL.Add('SELECT f.SITE_ID_NR, b.NR_ON_MAP, b.REGION_BB, b.ALT_NO_1, b.ALT_NO_2, MIN(CASE WHEN c1.PH > 1 THEN c1.PH ELSE 0 END) PH, MIN(CASE WHEN c1.EC > 1 THEN c1.EC ELSE 0 END) EC, MIN(CASE WHEN c1.TDS > 1 THEN c1.TDS ELSE 0 END) TDS, MIN(CASE WHEN c1.CA > -1 THEN c1.CA ELSE 0 END) CA, MIN(CASE WHEN c1.MG > -1 THEN c1.MG ELSE 0 END) MG, MIN(CASE WHEN c1.NA > -1 THEN c1.NA ELSE 0 END) NA, MIN(CASE WHEN c1.MALK > 1 THEN c1.MALK ELSE 0 END) MALK, MIN(CASE WHEN c1.HCO3 > -1 THEN c1.HCO3 ELSE 0 END) HCO3, MIN(CASE WHEN c1.CO3 > -1 THEN c1.CO3 ELSE 0 END) CO3, MIN(CASE WHEN c1.SO4 > -1 THEN c1.SO4 ELSE 0 END) SO4, MIN(CASE WHEN c1.CL > -1 THEN c1.CL ELSE 0 END) CL, MIN(CASE WHEN c1.K > -1 THEN c1.K ELSE 0 END) K, MIN(CASE WHEN c1.F > -1 THEN c1.F ELSE 0 END) F, MIN(CASE WHEN c1.N > -1 THEN c1.n ELSE 0 END) N');
    if ClrByGrp then
      SQL.Add(', m.MEMBER_ID');
    SQL.Add('FROM ' + FilterTableName + ' f');
    SQL.Add('JOIN basicinf b ON (f.SITE_ID_NR = b.SITE_ID_NR)');
    SQL.Add('JOIN chem_000 c0 ON (f.SITE_ID_NR = c0.SITE_ID_NR)');
    if DataModuleMain.ZConnectionDB.Tag = 1 then //sqlite
      SQL.Add('AND c0.DATE_SAMPL || c0.TIME_SAMPL >= ' + QuotedStr(StartDate + StartTime)
        + ' AND c0.DATE_SAMPL || c0.TIME_SAMPL <= ' + QuotedStr(EndDate + EndTime))
    else
      SQL.Add('AND CONCAT(c0.DATE_SAMPL, c0.TIME_SAMPL) >= ' + QuotedStr(StartDate + StartTime)
        + ' AND CONCAT(c0.DATE_SAMPL, c0.TIME_SAMPL) <= ' + QuotedStr(EndDate + EndTime));
    SQL.Add('JOIN chem_001 c1 ON (c0.CHM_REF_NR = c1.CHM_REF_NR)');
    if IsCurrentSite then
      SQL.Add('WHERE f.SITE_ID_NR = ' + QuotedStr(CurrentSite))
    else //check for colouring by group membership
    if ClrByGrp then
    begin
      for m := 0 to MemberList.Count - 1 do
      begin
        if m < MemberList.Count - 1 then
          MemberStr := MemberStr + QuotedStr(MemberList[m]) + ', '
        else
          MemberStr := MemberStr + QuotedStr(MemberList[m]);
      end;
      SQL.Add('JOIN member__ m ON (f.SITE_ID_NR = m.SITE_ID_NR)');
      SQL.Add('AND m.MEMBER_ID IN (' + MemberStr + ')');
    end;
    SQL.Add('GROUP BY f.SITE_ID_NR, b.NR_ON_MAP, b.REGION_BB, b.ALT_NO_1, b.ALT_NO_2');
    SQL.Add('ORDER BY f.SITE_ID_NR');
  end;
end;

procedure TChemChartsForm.ChartToolset1DataPointHintTool1Hint(
  ATool: TDataPointHintTool; const APoint: TPoint; var AHint: String);
begin
  gc.ShowHint := False;
end;

procedure TChemChartsForm.ChartDblClick(Sender: TObject);
begin
  gc.ZoomFull(False);
end;

procedure TChemChartsForm.FormDeactivate(Sender: TObject);
begin
  if (ActiveControl is TChart) then
    (ActiveControl as TChart).BorderStyle := bsNone;
end;

procedure TChemChartsForm.DurovAddPoints;
var x: TField;
    Ca,Mg,Na,HCO3,SO4,Cl,NX,NY,NEWyu,NEWxu,xu,yu,a,b,newtdsx,newtdsy,tds,ph,yo: Double;
    DurovSeries, AvgSeries, MaxSeries, MinSeries: TLineSeries;
    LabelText, PrevSiteID: ShortString;
    TheColour: TColor;
    Idx: Word; //to count the series
begin
  PrevSiteID := '';
  Idx := 0;
  Randomize;
  //normal points without aggregates
  GlobalQuery.First;
  while not GlobalQuery.EOF do
  begin
    if GlobalQuery.FieldByName('SITE_ID_NR').Value <> PrevSiteID then //create a new series
    begin
      DurovSeries := TLineSeries.Create(DurovChart);
      DurovChart.AddSeries(DurovSeries);
      with DurovSeries do
      begin
        Index := Idx;
        Inc(Idx);
        if ClrByGrp then
        begin
          if MemberList.IndexOf(GlobalQuery.FieldByName('MEMBER_ID').Value) > 19 then
            TheColour := clActiveCaption
          else
            TheColour := MyColors[MemberList.IndexOf(GlobalQuery.FieldByName('MEMBER_ID').Value)];
          Legend.GroupIndex := MemberList.IndexOf(GlobalQuery.FieldByName('MEMBER_ID').Value);
        end
        else
        begin
          TheColour := MyColors[Random(19)];
        end;
      end;
    end;
    with DurovSeries do
    begin
      Tag := 1000;
      LineType:= ltNone;
      ShowLines := False;
      ShowPoints := True;
      SeriesColor := TheColour;
      ZPosition := Tag;
      LabelText := GetLabelText(GlobalQuery);
      FindPercent(GlobalQuery,Ca,Mg,Na,HCO3,SO4,Cl);
      x := GlobalQuery.FindField('PH');
      if x.IsNull then PH:= 3
      else PH := x.Value;
       x:= GlobalQuery.FindField('TDS');
      if x.IsNull then TDS:= 100
      else TDS := x.Value;
      if TDS < 10 then tds := 10;
      if TDS > 10000 then tds := 10000;
      if PH < 3 then PH := 3;
      if PH > 11 then PH := 11;
      {Labelling text}
      yo:=chartyo-0.5*baselength;
      NX:=Chartxo+(100-Mg)/100*(baselength*0.866025);
      NY:=yo+Ca/100*baselength+Mg/100*baselength*0.5;
      AddXY(NX, NY, LabelText, SeriesColor);
      xu:=Chartxo+baselength*0.866025403;
      yu:=chartyo+0.5*baselength;
      NEWyu:=yu+SO4/100*baselength*0.866;
      newxu:=xu+(100-(SO4+Cl))/100*baselength+SO4/100*baselength*0.5;
      addxy(NEWXu,NEWYu,LabelText, SeriesColor);
      addxy(newxu,ny,LabelText, SeriesColor);
      a:=log10(tdsmin);
      b:=log10(tdsmax);
      newtdsx :=(log10(tds)-a)/(b-a)*squaretdsw+Chartxo+baselength+0.866*baselength;
      newtdsy:=ny;
      addxy(newtdsx,newtdsy,LabelText, SeriesColor);
      newphx := newxu;
      newphy := ((11-PH)/8)*squarephw+chartyo-0.5*baselength-squarephw;
      AddXY(newphx, newphy, LabelText, SeriesColor);
      Pointer.HorizSize:=3;
      Pointer.VertSize:=3;
      Pointer.Style := TSeriesPointerStyle(Random(20));
      if Pointer.Style = psNone then Pointer.Style := psRectangle
      else if Pointer.Style = psPoint then Pointer.Style := psCircle;
      Pointer.Brush.Color:= SeriesColor;
      Pointer.Pen.Color := clBlack;
      Pointer.OverrideColor := [];
      Marks.LabelFont := AppFont;
      Marks.Style := smsLabel;
      Marks.Visible := False;
      Marks.LinkPen.Color := clBlack;
      Title := GetSeriesTitle(GlobalQuery);
    end;
    PrevSiteID := GlobalQuery.FieldByName('SITE_ID_NR').Value;
    GlobalQuery.Next;
  end;
  //normal points with average aggregates
  AvgQuery.First;
  while not AvgQuery.EOF do
  begin
    AvgSeries := TLineSeries.Create(DurovChart);
    DurovChart.AddSeries(AvgSeries);
    with AvgSeries do
    begin
      Index := Idx;
      Inc(Idx);
      Active := False;
      if ClrByGrp then
      begin
        if MemberList.IndexOf(AvgQuery.FieldByName('MEMBER_ID').Value) > 19 then
          TheColour := clActiveCaption
        else
          TheColour := MyColors[MemberList.IndexOf(AvgQuery.FieldByName('MEMBER_ID').Value)];
        Legend.GroupIndex := MemberList.IndexOf(AvgQuery.FieldByName('MEMBER_ID').Value);
      end
      else
      begin
        TheColour := MyColors[Random(19)];
      end;
      Tag := 1001;
      LineType:= ltNone;
      ShowLines := False;
      ShowPoints := True;
      SeriesColor := TheColour;
      ZPosition := Tag;
      LabelText := GetLabelText(AvgQuery);
      FindPercent(AvgQuery,Ca,Mg,Na,HCO3,SO4,Cl);
      x := AvgQuery.FindField('PH');
      if x.IsNull then PH:= 3
      else PH := x.Value;
       x:= AvgQuery.FindField('TDS');
      if x.IsNull then TDS:= 100
      else TDS := x.Value;
      if TDS < 10 then tds := 10;
      if TDS > 10000 then tds := 10000;
      if PH < 3 then PH := 3;
      if PH > 11 then PH := 11;
      {Labelling text}
      yo:=chartyo-0.5*baselength;
      NX:=Chartxo+(100-Mg)/100*(baselength*0.866025);
      NY:=yo+Ca/100*baselength+Mg/100*baselength*0.5;
      AddXY(NX, NY, LabelText, SeriesColor);
      xu:=Chartxo+baselength*0.866025403;
      yu:=chartyo+0.5*baselength;
      NEWyu:=yu+SO4/100*baselength*0.866;
      newxu:=xu+(100-(SO4+Cl))/100*baselength+SO4/100*baselength*0.5;
      addxy(NEWXu,NEWYu,LabelText, SeriesColor);
      addxy(newxu,ny,LabelText, SeriesColor);
      a:=log10(tdsmin);
      b:=log10(tdsmax);
      newtdsx :=(log10(tds)-a)/(b-a)*squaretdsw+Chartxo+baselength+0.866*baselength;
      newtdsy:=ny;
      addxy(newtdsx,newtdsy,LabelText, SeriesColor);
      newphx := newxu;
      newphy := ((11-PH)/8)*squarephw+chartyo-0.5*baselength-squarephw;
      AddXY(newphx, newphy, LabelText, SeriesColor);
      Pointer.HorizSize:=3;
      Pointer.VertSize:=3;
      Pointer.Style := TSeriesPointerStyle(Random(20));
      if Pointer.Style = psNone then Pointer.Style := psRectangle
      else if Pointer.Style = psPoint then Pointer.Style := psCircle;
      Pointer.Brush.Color:= SeriesColor;
      Pointer.Pen.Color := clBlack;
      Pointer.OverrideColor := [];
      Marks.LabelFont := AppFont;
      Marks.Style := smsLabel;
      Marks.Visible := False;
      Marks.LinkPen.Color := clBlack;
      Title := GetSeriesTitle(AvgQuery);
    end;
    AvgQuery.Next;
  end;
  //points with minimum aggregates
  MinQuery.First;
  while not MinQuery.EOF do
  begin
    MinSeries := TLineSeries.Create(DurovChart);
    DurovChart.AddSeries(MinSeries);
    with MinSeries do
    begin
      Index := Idx;
      Inc(Idx);
      Active := False;
      if ClrByGrp then
      begin
        if MemberList.IndexOf(MinQuery.FieldByName('MEMBER_ID').Value) > 19 then
          TheColour := clActiveCaption
        else
          TheColour := MyColors[MemberList.IndexOf(MinQuery.FieldByName('MEMBER_ID').Value)];
        Legend.GroupIndex := MemberList.IndexOf(MinQuery.FieldByName('MEMBER_ID').Value);
      end
      else
      begin
        TheColour := MyColors[Random(19)];
      end;
      Tag := 1002;
      LineType:= ltNone;
      ShowLines := False;
      ShowPoints := True;
      SeriesColor := TheColour;
      ZPosition := 999;
      LabelText := GetLabelText(MinQuery);
      FindPercent(MinQuery,Ca,Mg,Na,HCO3,SO4,Cl);
      x := MinQuery.FindField('PH');
      if x.IsNull then PH:= 3
      else PH := x.Value;
       x:= MinQuery.FindField('TDS');
      if x.IsNull then TDS:= 100
      else TDS := x.Value;
      if TDS < 10 then tds := 10;
      if TDS > 10000 then tds := 10000;
      if PH < 3 then PH := 3;
      if PH > 11 then PH := 11;
      {Labelling text}
      yo:=chartyo-0.5*baselength;
      NX:=Chartxo+(100-Mg)/100*(baselength*0.866025);
      NY:=yo+Ca/100*baselength+Mg/100*baselength*0.5;
      AddXY(NX, NY, LabelText, SeriesColor);
      xu:=Chartxo+baselength*0.866025403;
      yu:=chartyo+0.5*baselength;
      NEWyu:=yu+SO4/100*baselength*0.866;
      newxu:=xu+(100-(SO4+Cl))/100*baselength+SO4/100*baselength*0.5;
      addxy(NEWXu,NEWYu,LabelText, SeriesColor);
      addxy(newxu,ny,LabelText, SeriesColor);
      a:=log10(tdsmin);
      b:=log10(tdsmax);
      newtdsx :=(log10(tds)-a)/(b-a)*squaretdsw+Chartxo+baselength+0.866*baselength;
      newtdsy:=ny;
      addxy(newtdsx,newtdsy,LabelText, SeriesColor);
      newphx := newxu;
      newphy := ((11-PH)/8)*squarephw+chartyo-0.5*baselength-squarephw;
      AddXY(newphx, newphy, LabelText, SeriesColor);
      Pointer.HorizSize:=3;
      Pointer.VertSize:=3;
      Pointer.Style := TSeriesPointerStyle(Random(20));
      if Pointer.Style = psNone then Pointer.Style := psRectangle
      else if Pointer.Style = psPoint then Pointer.Style := psCircle;
      Pointer.Brush.Color:= SeriesColor;
      Pointer.Pen.Color := clBlack;
      Pointer.OverrideColor := [];
      Marks.LabelFont := AppFont;
      Marks.Style := smsLabel;
      Marks.Visible := False;
      Marks.LinkPen.Color := clBlack;
      Title := GetSeriesTitle(MinQuery);
    end;
    MinQuery.Next;
  end;
  //points with maximum aggregates
  MaxQuery.First;
  while not MaxQuery.EOF do
  begin
    MaxSeries := TLineSeries.Create(DurovChart);
    DurovChart.AddSeries(MaxSeries);
    with MaxSeries do
    begin
      Index := Idx;
      Inc(Idx);
      Active := False;
      if ClrByGrp then
      begin
        if MemberList.IndexOf(MaxQuery.FieldByName('MEMBER_ID').Value) > 19 then
          TheColour := clActiveCaption
        else
          TheColour := MyColors[MemberList.IndexOf(MaxQuery.FieldByName('MEMBER_ID').Value)];
        Legend.GroupIndex := MemberList.IndexOf(MaxQuery.FieldByName('MEMBER_ID').Value);
      end
      else
      begin
        TheColour := MyColors[Random(19)];
      end;
      Tag := 1003;
      LineType:= ltNone;
      ShowLines := False;
      ShowPoints := True;
      SeriesColor := TheColour;
      ZPosition := 999;
      LabelText := GetLabelText(MaxQuery);
      FindPercent(MaxQuery,Ca,Mg,Na,HCO3,SO4,Cl);
      x := MaxQuery.FindField('PH');
      if x.IsNull then PH:= 3
      else PH := x.Value;
       x:= MaxQuery.FindField('TDS');
      if x.IsNull then TDS:= 100
      else TDS := x.Value;
      if TDS < 10 then tds := 10;
      if TDS > 10000 then tds := 10000;
      if PH < 3 then PH := 3;
      if PH > 11 then PH := 11;
      {Labelling text}
      yo:=chartyo-0.5*baselength;
      NX:=Chartxo+(100-Mg)/100*(baselength*0.866025);
      NY:=yo+Ca/100*baselength+Mg/100*baselength*0.5;
      AddXY(NX, NY, LabelText, SeriesColor);
      xu:=Chartxo+baselength*0.866025403;
      yu:=chartyo+0.5*baselength;
      NEWyu:=yu+SO4/100*baselength*0.866;
      newxu:=xu+(100-(SO4+Cl))/100*baselength+SO4/100*baselength*0.5;
      addxy(NEWXu,NEWYu,LabelText, SeriesColor);
      addxy(newxu,ny,LabelText, SeriesColor);
      a:=log10(tdsmin);
      b:=log10(tdsmax);
      newtdsx :=(log10(tds)-a)/(b-a)*squaretdsw+Chartxo+baselength+0.866*baselength;
      newtdsy:=ny;
      addxy(newtdsx,newtdsy,LabelText, SeriesColor);
      newphx := newxu;
      newphy := ((11-PH)/8)*squarephw+chartyo-0.5*baselength-squarephw;
      AddXY(newphx, newphy, LabelText, SeriesColor);
      Pointer.HorizSize:=3;
      Pointer.VertSize:=3;
      Pointer.Style := TSeriesPointerStyle(Random(20));
      if Pointer.Style = psNone then Pointer.Style := psRectangle
      else if Pointer.Style = psPoint then Pointer.Style := psCircle;
      Pointer.Brush.Color:= SeriesColor;
      Pointer.Pen.Color := clBlack;
      Pointer.OverrideColor := [];
      Marks.LabelFont := AppFont;
      Marks.Style := smsLabel;
      Marks.Visible := False;
      Marks.LinkPen.Color := clBlack;
      Title := GetSeriesTitle(MaxQuery);
    end;
    MaxQuery.Next;
  end;
end;

procedure TChemChartsForm.SARAddPoints;
var Ca,Mg,Na,value,EC,sarvalue: Double;
    SARSeries, AvgSeries, MinSeries, MaxSeries: TLineSeries;
    LabelText, PrevSiteID: ShortString;
    Idx: Word;
    TheColour: TColor;
begin
  Randomize;
  Idx := 0;
  PrevSiteID := '';
  if ECFactor >= 1 then
    SARChart.BottomAxis.Marks.Format := '%4:.0f'
  else
    SARChart.BottomAxis.Marks.Format := '%4:.2f';
  GlobalQuery.First;
  while not GlobalQuery.EOF do
  begin
    if GlobalQuery.FieldByName('SITE_ID_NR').Value <> PrevSiteID then //create a new series
    begin
      SARSeries := TLineSeries.Create(SARChart);
      SARChart.AddSeries(SARSeries);
      with SARSeries do
      begin
        Index := Idx;
        Inc(Idx);
        if ClrByGrp then
        begin
          if MemberList.IndexOf(GlobalQuery.FieldByName('MEMBER_ID').Value) > 19 then
            TheColour := clActiveCaption
          else
            TheColour := MyColors[MemberList.IndexOf(GlobalQuery.FieldByName('MEMBER_ID').Value)];
          Legend.GroupIndex := 2 + MemberList.IndexOf(GlobalQuery.FieldByName('MEMBER_ID').Value);
        end
        else
          TheColour := MyColors[Random(19)];
      end;
    end;
    with SARSeries do
    begin
      Tag := 1000;
      LineType:= ltNone;
      ShowLines := False;
      ZPosition := Tag;
      AxisIndexX := 1;
      AxisIndexY := 0;
      SeriesColor := TheColour;
      {Build Legend for Series}
      Title := GetSeriesTitle(GlobalQuery);
      LabelText := GetLabelText(GlobalQuery);
      Marks.Style := smsLabel;
      Marks.LabelFont := AppFont;
      Marks.Visible := False;
      Marks.Frame.Visible := False;
      Marks.Arrow.Visible:= False;
      Marks.LinkPen.Color := clBlack;
      Marks.AutoMargins := False;
      Pointer.HorizSize := 3;
      Pointer.VertSize := 3;
      Pointer.Pen.Color := SeriesColor;
      Pointer.Brush.Color := SeriesColor;
      Pointer.Style := TSeriesPointerStyle(Random(20));
      if Pointer.Style = psNone then Pointer.Style := psRectangle
      else if Pointer.Style = psPoint then Pointer.Style := psCircle;
      Pointer.OverrideColor := [];
      Pointer.Visible := True;
      ShowPoints := True;
      {Data Input}
      Value := FindChemValues(GlobalQuery, 'Ca');
      Ca := Value*CParam[0];
      Value := FindChemValues(GlobalQuery, 'Mg');
      Mg := Value*CParam[1];
      Value := FindChemValues(GlobalQuery, 'Na');
      Na := Value*CParam[2];
      Value := FindChemValues(GlobalQuery, 'EC');
      EC := Value * ECFactor;
      if CA + Mg > 0 then
        sarvalue := Na/(sqrt((CA+Mg)/2))
      else
        sarvalue := 0;
      AddXY(EC, sarvalue, LabelText, SeriesColor);
    end; {with}
    PrevSiteID := GlobalQuery.FieldByName('SITE_ID_NR').Value;
    GlobalQuery.Next;
  end;
  AvgQuery.First;
  while not AvgQuery.EOF do
  begin
    AvgSeries := TLineSeries.Create(SARChart);
    SARChart.AddSeries(AvgSeries);
    with AvgSeries do
    begin
      Index := Idx;
      Inc(Idx);
      if ClrByGrp then
      begin
        if MemberList.IndexOf(AvgQuery.FieldByName('MEMBER_ID').Value) > 19 then
          TheColour := clActiveCaption
        else
          TheColour := MyColors[MemberList.IndexOf(AvgQuery.FieldByName('MEMBER_ID').Value)];
        Legend.GroupIndex := 2 + MemberList.IndexOf(AvgQuery.FieldByName('MEMBER_ID').Value);
      end
      else
        TheColour := MyColors[Random(19)];
      Active := False;
      Tag := 1001;
      LineType:= ltNone;
      ShowLines := False;
      ZPosition := Tag;
      AxisIndexX := 1;
      AxisIndexY := 0;
      SeriesColor := TheColour;
      {Build Legend for Series}
      Title := GetSeriesTitle(AvgQuery);
      LabelText := GetLabelText(AvgQuery);
      Marks.Style := smsLabel;
      Marks.LabelFont := AppFont;
      Marks.Visible := False;
      Marks.Frame.Visible := False;
      Marks.Arrow.Visible:= False;
      Marks.LinkPen.Color := clBlack;
      Marks.AutoMargins := False;
      Pointer.HorizSize := 3;
      Pointer.VertSize := 3;
      Pointer.Pen.Color := SeriesColor;
      Pointer.Brush.Color := SeriesColor;
      Pointer.Style := TSeriesPointerStyle(Random(20));
      if Pointer.Style = psNone then Pointer.Style := psRectangle
      else if Pointer.Style = psPoint then Pointer.Style := psCircle;
      Pointer.OverrideColor := [];
      Pointer.Visible := True;
      ShowPoints := True;
      {Data Input}
      Value := FindChemValues(AvgQuery, 'Ca');
      Ca := Value*CParam[0];
      Value := FindChemValues(AvgQuery, 'Mg');
      Mg := Value*CParam[1];
      Value := FindChemValues(AvgQuery, 'Na');
      Na := Value*CParam[2];
      Value := FindChemValues(AvgQuery, 'EC');
      EC := Value * ECFactor;
      if CA + Mg > 0 then
        sarvalue := Na/(sqrt((CA+Mg)/2))
      else
        sarvalue := 0;
      addxy(EC, sarvalue, LabelText, SeriesColor);
    end;
    PrevSiteID := AvgQuery.FieldByName('SITE_ID_NR').Value;
    AvgQuery.Next;
  end;
  MinQuery.First;
  while not MinQuery.EOF do
  begin
    MinSeries := TLineSeries.Create(SARChart);
    SARChart.AddSeries(MinSeries);
    with MinSeries do
    begin
      Index := Idx;
      Inc(Idx);
      if ClrByGrp then
      begin
        if MemberList.IndexOf(MinQuery.FieldByName('MEMBER_ID').Value) > 19 then
          TheColour := clActiveCaption
        else
          TheColour := MyColors[MemberList.IndexOf(MinQuery.FieldByName('MEMBER_ID').Value)];
        Legend.GroupIndex := 2 + MemberList.IndexOf(MinQuery.FieldByName('MEMBER_ID').Value);
      end
      else
        TheColour := MyColors[Random(19)];
      Active := False;
      Tag := 1002;
      LineType:= ltNone;
      ShowLines := False;
      ZPosition := Tag;
      AxisIndexX := 1;
      AxisIndexY := 0;
      SeriesColor := TheColour;
      {Build Legend for Series}
      Title := GetSeriesTitle(MinQuery);
      LabelText := GetLabelText(MinQuery);
      Marks.Style := smsLabel;
      Marks.LabelFont := AppFont;
      Marks.Visible := False;
      Marks.Frame.Visible := False;
      Marks.Arrow.Visible:= False;
      Marks.LinkPen.Color := clBlack;
      Marks.AutoMargins := False;
      Pointer.HorizSize := 3;
      Pointer.VertSize := 3;
      Pointer.Pen.Color := SeriesColor;
      Pointer.Brush.Color := SeriesColor;
      Pointer.Style := TSeriesPointerStyle(Random(20));
      if Pointer.Style = psNone then Pointer.Style := psRectangle
      else if Pointer.Style = psPoint then Pointer.Style := psCircle;
      Pointer.OverrideColor := [];
      Pointer.Visible := True;
      ShowPoints := True;
      {Data Input}
      Value := FindChemValues(MinQuery, 'Ca');
      Ca := Value*CParam[0];
      Value := FindChemValues(MinQuery, 'Mg');
      Mg := Value*CParam[1];
      Value := FindChemValues(MinQuery, 'Na');
      Na := Value*CParam[2];
      Value := FindChemValues(MinQuery, 'EC');
      EC := Value * ECFactor;
      if CA + Mg > 0 then
        sarvalue := Na/(sqrt((CA+Mg)/2))
      else
        sarvalue := 0;
      addxy(EC, sarvalue, LabelText, SeriesColor);
    end;
    PrevSiteID := MinQuery.FieldByName('SITE_ID_NR').Value;
    MinQuery.Next;
  end;
  MaxQuery.First;
  while not MaxQuery.EOF do
  begin
    MaxSeries := TLineSeries.Create(SARChart);
    SARChart.AddSeries(MaxSeries);
    with MaxSeries do
    begin
      Index := Idx;
      Inc(Idx);
      if ClrByGrp then
      begin
        if MemberList.IndexOf(MaxQuery.FieldByName('MEMBER_ID').Value) > 19 then
          TheColour := clActiveCaption
        else
          TheColour := MyColors[MemberList.IndexOf(MaxQuery.FieldByName('MEMBER_ID').Value)];
        Legend.GroupIndex := 2 + MemberList.IndexOf(MaxQuery.FieldByName('MEMBER_ID').Value);
      end
      else
        TheColour := MyColors[Random(19)];
      Active := False;
      Tag := 1003;
      LineType:= ltNone;
      ShowLines := False;
      ZPosition := Tag;
      AxisIndexX := 1;
      AxisIndexY := 0;
      SeriesColor := TheColour;
      {Build Legend for Series}
      Title := GetSeriesTitle(MaxQuery);
      LabelText := GetLabelText(MaxQuery);
      Marks.Style := smsLabel;
      Marks.LabelFont := AppFont;
      Marks.Visible := False;
      Marks.Frame.Visible := False;
      Marks.Arrow.Visible:= False;
      Marks.LinkPen.Color := clBlack;
      Marks.AutoMargins := False;
      Pointer.HorizSize := 3;
      Pointer.VertSize := 3;
      Pointer.Pen.Color := SeriesColor;
      Pointer.Brush.Color := SeriesColor;
      Pointer.Style := TSeriesPointerStyle(Random(20));
      if Pointer.Style = psNone then Pointer.Style := psRectangle
      else if Pointer.Style = psPoint then Pointer.Style := psCircle;
      Pointer.OverrideColor := [];
      Pointer.Visible := True;
      ShowPoints := True;
      {Data Input}
      Value := FindChemValues(MaxQuery, 'Ca');
      Ca := Value*CParam[0];
      Value := FindChemValues(MaxQuery, 'Mg');
      Mg := Value*CParam[1];
      Value := FindChemValues(MaxQuery, 'Na');
      Na := Value*CParam[2];
      Value := FindChemValues(MaxQuery, 'EC');
      EC := Value * ECFactor;
      if CA + Mg > 0 then
        sarvalue := Na/(sqrt((CA+Mg)/2))
      else
        sarvalue := 0;
      addxy(EC, sarvalue, LabelText, SeriesColor);
    end;
    PrevSiteID := MaxQuery.FieldByName('SITE_ID_NR').Value;
    MaxQuery.Next;
  end;
end;

procedure TChemChartsForm.SchoelAddPoints;
var Ca, Mg, Na ,HCO3, SO4, Cl, K, F, NO3, value, maxY, minY: Real;
    SchoellerSeries, AvgSeries, MaxSeries, MinSeries: TLineSeries;
    LabelText, PrevSiteID: ShortString;
    TheColour: TColor;
    Idx:Word;
begin
  maxY := 0;
  minY := 1000000000;
  PrevSiteID := '';
  Idx := 0;
  Randomize;
  //normal points and lines without aggregates
  GlobalQuery.First;
  while not GlobalQuery.EOF do
  begin
    SchoellerSeries := TLineSeries.Create(SchoellerChart);
    SchoellerChart.AddSeries(SchoellerSeries);
    if GlobalQuery.FieldByName('SITE_ID_NR').Value <> PrevSiteID then //create a new series
    begin
      with SchoellerSeries do
      begin
        if ClrByGrp then
        begin
          if MemberList.IndexOf(GlobalQuery.FieldByName('MEMBER_ID').Value) > 19 then
            TheColour := clActiveCaption
          else
            TheColour := MyColors[MemberList.IndexOf(GlobalQuery.FieldByName('MEMBER_ID').Value)];
          Legend.GroupIndex := MemberList.IndexOf(GlobalQuery.FieldByName('MEMBER_ID').Value);
        end
        else
        begin
          TheColour := MyColors[Random(19)];
        end;
      end;
    end;
    with SchoellerSeries do
    begin
      Index := Idx;
      Inc(Idx);
      Tag := 1000;
      ShowPoints := True;
      AxisIndexX := 1;
      AxisIndexY := 0;
      SeriesColor := TheColour;
      Title := GetSeriesTitle(GlobalQuery);
      Value := FindChemValues(GlobalQuery, 'Ca');
      Ca := Value*CParam[0];
      if Ca > maxY then maxY := Ca;
      if Ca < minY then minY := Ca;
      Value := FindChemValues(GlobalQuery, 'Mg');
      Mg := Value*CParam[1];
      if Mg > maxY then maxY := Mg;
      if Mg < minY then minY := Mg;
      Value := FindChemValues(GlobalQuery, 'Na');
      Na := Value*CParam[2];
      if Na > maxY then maxY := Na;
      if Na < minY then minY := Na;
      Value := FindChemValues(GlobalQuery, 'K');
      K := Value*CParam[3];
      if K > maxY then maxY := K;
      if K < minY then minY := K;
      Value := FindChemValues(GlobalQuery, 'Cl');
      Cl := Value*CParam[5];
      if Cl > maxY then maxY := Cl;
      if Cl < minY then minY := Cl;
      Value := FindChemValues(GlobalQuery, 'F');
      F := Value*CParam[8];
      if F > maxY then maxY := F;
      if F < minY then minY := F;
      Value := FindChemValues(GlobalQuery, 'SO4');
      SO4 := Value*CParam[6];
      if SO4 > maxY then maxY := SO4;
      if SO4 < minY then minY := SO4;
      Value := FindChemValues(GlobalQuery, 'N');
      NO3 := Value*CParam[11]*4.4263724;
      if NO3 > maxY then maxY := NO3;
      if NO3 < minY then minY := NO3;
      Value := FindChemValues(GlobalQuery, 'MALK');
      HCO3 := Value*CParam[4]/0.8202;
      if HCO3 > maxY then maxY := HCO3;
      if HCO3 < minY then minY := HCO3;
      LabelText := GetLabelText(GlobalQuery);
      //add the values
      AddY(Ca, LabelText, SeriesColor);
      AddY(Mg, LabelText, SeriesColor);
      AddY(Na, LabelText, SeriesColor);
      AddY(K, LabelText, SeriesColor);
      AddY(Cl, LabelText, SeriesColor);
      AddY(F, LabelText, SeriesColor);
      AddY(SO4, LabelText, SeriesColor);
      AddY(NO3, LabelText, SeriesColor);
      AddY(HCO3, LabelText, SeriesColor);
      Pointer.horizsize := 3;
      Pointer.vertsize := 3;
      Pointer.Brush.Color := SeriesColor;
      Pointer.Style := TSeriesPointerStyle(Random(20));
      if Pointer.Style = psNone then Pointer.Style := psRectangle
      else if Pointer.Style = psPoint then Pointer.Style := psCircle;
      Pointer.OverrideColor := [];
      Pointer.Visible := True;
      Marks.LabelFont := AppFont;
      Marks.LabelFont.Size := 7;
      Marks.Style := smsLabel;
      Marks.Visible := False;
      Marks.LinkPen.Color := clBlack;
    end; //with SchoellerSeries..
    PrevSiteID := GlobalQuery.FieldByName('SITE_ID_NR').Value;
    GlobalQuery.Next;
  end; //of while
  //points and lines with average aggregate
  AvgQuery.First;
  while not AvgQuery.EOF do
  begin
    AvgSeries := TLineSeries.Create(SchoellerChart);
    SchoellerChart.AddSeries(AvgSeries);
    with AvgSeries do
    begin
      Index := Idx;
      Inc(Idx);
      Active := False;
      if ClrByGrp then
      begin
        if MemberList.IndexOf(AvgQuery.FieldByName('MEMBER_ID').Value) > 19 then
          TheColour := clActiveCaption
        else
          TheColour := MyColors[MemberList.IndexOf(AvgQuery.FieldByName('MEMBER_ID').Value)];
        Legend.GroupIndex := MemberList.IndexOf(AvgQuery.FieldByName('MEMBER_ID').Value);
      end
      else
        TheColour := MyColors[Random(19)];
      Tag := 1001;
      ShowPoints := True;
      AxisIndexX := 1;
      AxisIndexY := 0;
      SeriesColor := TheColour;
      Title := GetSeriesTitle(AvgQuery);
      Value := FindChemValues(AvgQuery, 'Ca');
      Ca := Value*CParam[0];
      if Ca > maxY then maxY := Ca;
      if Ca < minY then minY := Ca;
      Value := FindChemValues(AvgQuery, 'Mg');
      Mg := Value*CParam[1];
      if Mg > maxY then maxY := Mg;
      if Mg < minY then minY := Mg;
      Value := FindChemValues(AvgQuery, 'Na');
      Na := Value*CParam[2];
      if Na > maxY then maxY := Na;
      if Na < minY then minY := Na;
      Value := FindChemValues(AvgQuery, 'K');
      K := Value*CParam[3];
      if K > maxY then maxY := K;
      if K < minY then minY := K;
      Value := FindChemValues(AvgQuery, 'Cl');
      Cl := Value*CParam[5];
      if Cl > maxY then maxY := Cl;
      if Cl < minY then minY := Cl;
      Value := FindChemValues(AvgQuery, 'F');
      F := Value*CParam[8];
      if F > maxY then maxY := F;
      if F < minY then minY := F;
      Value := FindChemValues(AvgQuery, 'SO4');
      SO4 := Value*CParam[6];
      if SO4 > maxY then maxY := SO4;
      if SO4 < minY then minY := SO4;
      Value := FindChemValues(AvgQuery, 'N');
      NO3 := Value*CParam[11]*4.4263724;
      if NO3 > maxY then maxY := NO3;
      if NO3 < minY then minY := NO3;
      Value := FindChemValues(AvgQuery, 'MALK');
      HCO3 := Value*CParam[4]/0.8202;
      if HCO3 > maxY then maxY := HCO3;
      if HCO3 < minY then minY := HCO3;
      LabelText := GetLabelText(AvgQuery);
      //add the values
      AddY(Ca, LabelText, SeriesColor);
      AddY(Mg, LabelText, SeriesColor);
      AddY(Na, LabelText, SeriesColor);
      AddY(K, LabelText, SeriesColor);
      AddY(Cl, LabelText, SeriesColor);
      AddY(F, LabelText, SeriesColor);
      AddY(SO4, LabelText, SeriesColor);
      AddY(NO3, LabelText, SeriesColor);
      AddY(HCO3, LabelText, SeriesColor);
      Pointer.horizsize := 3;
      Pointer.vertsize := 3;
      Pointer.Brush.Color := SeriesColor;
      Pointer.Style := TSeriesPointerStyle(Random(20));
      if Pointer.Style = psNone then Pointer.Style := psRectangle
      else if Pointer.Style = psPoint then Pointer.Style := psCircle;
      Pointer.OverrideColor := [];
      Pointer.Visible := True;
      Marks.LabelFont := AppFont;
      Marks.LabelFont.Size := 7;
      Marks.Style := smsLabel;
      Marks.Visible := False;
      Marks.LinkPen.Color := clBlack;
    end;
    AvgQuery.Next;
  end; //of while
  //points and lines with minimum aggregate
  MinQuery.First;
  while not MinQuery.EOF do
  begin
    MinSeries := TLineSeries.Create(SchoellerChart);
    SchoellerChart.AddSeries(MinSeries);
    with MinSeries do
    begin
      Index := Idx;
      Inc(Idx);
      Active := False;
      if ClrByGrp then
      begin
        if MemberList.IndexOf(MinQuery.FieldByName('MEMBER_ID').Value) > 19 then
          TheColour := clActiveCaption
        else
          TheColour := MyColors[MemberList.IndexOf(MinQuery.FieldByName('MEMBER_ID').Value)];
        Legend.GroupIndex := MemberList.IndexOf(MinQuery.FieldByName('MEMBER_ID').Value);
      end
      else
        TheColour := MyColors[Random(19)];
      Tag := 1002;
      ShowPoints := True;
      AxisIndexX := 1;
      AxisIndexY := 0;
      SeriesColor := TheColour;
      Title := GetSeriesTitle(MinQuery);
      Value := FindChemValues(MinQuery, 'Ca');
      Ca := Value*CParam[0];
      if Ca > maxY then maxY := Ca;
      if Ca < minY then minY := Ca;
      Value := FindChemValues(MinQuery, 'Mg');
      Mg := Value*CParam[1];
      if Mg > maxY then maxY := Mg;
      if Mg < minY then minY := Mg;
      Value := FindChemValues(MinQuery, 'Na');
      Na := Value*CParam[2];
      if Na > maxY then maxY := Na;
      if Na < minY then minY := Na;
      Value := FindChemValues(MinQuery, 'K');
      K := Value*CParam[3];
      if K > maxY then maxY := K;
      if K < minY then minY := K;
      Value := FindChemValues(MinQuery, 'Cl');
      Cl := Value*CParam[5];
      if Cl > maxY then maxY := Cl;
      if Cl < minY then minY := Cl;
      Value := FindChemValues(MinQuery, 'F');
      F := Value*CParam[8];
      if F > maxY then maxY := F;
      if F < minY then minY := F;
      Value := FindChemValues(MinQuery, 'SO4');
      SO4 := Value*CParam[6];
      if SO4 > maxY then maxY := SO4;
      if SO4 < minY then minY := SO4;
      Value := FindChemValues(MinQuery, 'N');
      NO3 := Value*CParam[11]*4.4263724;
      if NO3 > maxY then maxY := NO3;
      if NO3 < minY then minY := NO3;
      Value := FindChemValues(MinQuery, 'MALK');
      HCO3 := Value*CParam[4]/0.8202;
      if HCO3 > maxY then maxY := HCO3;
      if HCO3 < minY then minY := HCO3;
      LabelText := GetLabelText(MinQuery);
      //add the values
      AddY(Ca, LabelText, SeriesColor);
      AddY(Mg, LabelText, SeriesColor);
      AddY(Na, LabelText, SeriesColor);
      AddY(K, LabelText, SeriesColor);
      AddY(Cl, LabelText, SeriesColor);
      AddY(F, LabelText, SeriesColor);
      AddY(SO4, LabelText, SeriesColor);
      AddY(NO3, LabelText, SeriesColor);
      AddY(HCO3, LabelText, SeriesColor);
      Pointer.horizsize := 3;
      Pointer.vertsize := 3;
      Pointer.Brush.Color := SeriesColor;
      Pointer.Style := TSeriesPointerStyle(Random(20));
      if Pointer.Style = psNone then Pointer.Style := psRectangle
      else if Pointer.Style = psPoint then Pointer.Style := psCircle;
      Pointer.OverrideColor := [];
      Pointer.Visible := True;
      Marks.LabelFont := AppFont;
      Marks.LabelFont.Size := 7;
      Marks.Style := smsLabel;
      Marks.Visible := False;
      Marks.LinkPen.Color := clBlack;
    end;
    MinQuery.Next;
  end; //of while
  //points and lines with maximum aggregate
  MaxQuery.First;
  while not MaxQuery.EOF do
  begin
    MaxSeries := TLineSeries.Create(SchoellerChart);
    SchoellerChart.AddSeries(MaxSeries);
    with MaxSeries do
    begin
      Index := Idx;
      Inc(Idx);
      Active := False;
      if ClrByGrp then
      begin
        if MemberList.IndexOf(MaxQuery.FieldByName('MEMBER_ID').Value) > 19 then
          TheColour := clActiveCaption
        else
          TheColour := MyColors[MemberList.IndexOf(MaxQuery.FieldByName('MEMBER_ID').Value)];
        Legend.GroupIndex := MemberList.IndexOf(MaxQuery.FieldByName('MEMBER_ID').Value);
      end
      else
        TheColour := MyColors[Random(19)];
      Tag := 1003;
      ShowPoints := True;
      AxisIndexX := 1;
      AxisIndexY := 0;
      SeriesColor := TheColour;
      Title := GetSeriesTitle(MaxQuery);
      Value := FindChemValues(MaxQuery, 'Ca');
      Ca := Value*CParam[0];
      if Ca > maxY then maxY := Ca;
      if Ca < minY then minY := Ca;
      Value := FindChemValues(MaxQuery, 'Mg');
      Mg := Value*CParam[1];
      if Mg > maxY then maxY := Mg;
      if Mg < minY then minY := Mg;
      Value := FindChemValues(MaxQuery, 'Na');
      Na := Value*CParam[2];
      if Na > maxY then maxY := Na;
      if Na < minY then minY := Na;
      Value := FindChemValues(MaxQuery, 'K');
      K := Value*CParam[3];
      if K > maxY then maxY := K;
      if K < minY then minY := K;
      Value := FindChemValues(MaxQuery, 'Cl');
      Cl := Value*CParam[5];
      if Cl > maxY then maxY := Cl;
      if Cl < minY then minY := Cl;
      Value := FindChemValues(MaxQuery, 'F');
      F := Value*CParam[8];
      if F > maxY then maxY := F;
      if F < minY then minY := F;
      Value := FindChemValues(MaxQuery, 'SO4');
      SO4 := Value*CParam[6];
      if SO4 > maxY then maxY := SO4;
      if SO4 < minY then minY := SO4;
      Value := FindChemValues(MaxQuery, 'N');
      NO3 := Value*CParam[11]*4.4263724;
      if NO3 > maxY then maxY := NO3;
      if NO3 < minY then minY := NO3;
      Value := FindChemValues(MaxQuery, 'MALK');
      HCO3 := Value*CParam[4]/0.8202;
      if HCO3 > maxY then maxY := HCO3;
      if HCO3 < minY then minY := HCO3;
      LabelText := GetLabelText(MaxQuery);
      //add the values
      AddY(Ca, LabelText, SeriesColor);
      AddY(Mg, LabelText, SeriesColor);
      AddY(Na, LabelText, SeriesColor);
      AddY(K, LabelText, SeriesColor);
      AddY(Cl, LabelText, SeriesColor);
      AddY(F, LabelText, SeriesColor);
      AddY(SO4, LabelText, SeriesColor);
      AddY(NO3, LabelText, SeriesColor);
      AddY(HCO3, LabelText, SeriesColor);
      Pointer.horizsize := 3;
      Pointer.vertsize := 3;
      Pointer.Brush.Color := SeriesColor;
      Pointer.Style := TSeriesPointerStyle(Random(20));
      if Pointer.Style = psNone then Pointer.Style := psRectangle
      else if Pointer.Style = psPoint then Pointer.Style := psCircle;
      Pointer.OverrideColor := [];
      Pointer.Visible := True;
      Marks.LabelFont := AppFont;
      Marks.LabelFont.Size := 7;
      Marks.Style := smsLabel;
      Marks.Visible := False;
      Marks.LinkPen.Color := clBlack;
    end;
    MaxQuery.Next;
  end; //of while
  //set left axis max and min
  with SchoellerChart do
  begin
    LeftAxis.Range.Max := Round(maxY + 0.5);
    LeftAxis.Range.UseMax := True;
    if minY = 0 then
      minY := 0.001;
    LeftAxis.Range.Min := minY;
    LeftAxis.Range.UseMin := True;

    LeftAxis.Marks.Range.Max := Round(maxY + 0.5);
    LeftAxis.Marks.Range.UseMax := True;
    LeftAxis.Marks.Range.Min := minY;
    LeftAxis.Marks.Range.UseMin := True;

    LeftAxis.Title.LabelFont := AppFont;
    LeftAxis.Title.LabelFont.Orientation := 900;
    LeftAxis.Marks.LabelFont := AppFont;

    BottomAxis.Title.LabelFont := AppFont;
    BottomAxis.Marks.LabelFont := AppFont;
    Title.Font := AppFont;
  end;
end;

function TChemChartsForm.FindChemValues(TheQuery: TDataSet; Param: ShortString): Double;

var x: TField;

begin
  x := TheQuery.FindField(Param);
  if x.IsNull then Result := 0
  else
  begin
     Result := x.Value;
     if Result < 0 then Result := 0;
  end;
end;

procedure TChemChartsForm.FindPercent(TheQuery: TDataSet; var Ca,Mg,Na,HCO3,SO4,Cl: Double);

var pH, K, NO3, CatTotal, AnTotal, Carbonates: Real;

begin
   Ca:= 0; Mg:= 0; Na:= 0; HCO3:= 0; SO4:= 0; Cl:= 0;
   Ca := FindChemValues(TheQuery, 'Ca') * CParam[0];
   Mg := FindChemValues(TheQuery, 'Mg') * CParam[1];
   Na := FindChemValues(TheQuery, 'Na') * CParam[2];
   K := FindChemValues(TheQuery, 'K') * CParam[3];
   Na := Na+K;
   CatTotal:= ca+mg+na;
   if CatTotal > 0 then
   begin
      Ca := (ca/CatTotal*100);
      Mg := (mg/CatTotal*100);
      Na := (na/CatTotal*100);
   end
   else
   begin
      ca:= 0;
      mg:= 0;
      na:= 0;
   end;
   pH := FindChemValues(TheQuery, 'PH');
   if pH < 9 then
   begin
    if FindChemValues(TheQuery, 'HCO3') > 0 then
      Carbonates := FindChemValues(TheQuery, 'HCO3') * CParam[4]
    else
      Carbonates := FindChemValues(TheQuery, 'MALK') / 0.8202 * CParam[4];
   end
   else
   begin
     if FindChemValues(TheQuery, 'HCO3') + FindChemValues(TheQuery, 'CO3') > 0 then
       Carbonates := FindChemValues(TheQuery, 'HCO3') * CParam[4] + FindChemValues(TheQuery, 'CO3') * CParam[9]
     else
       Carbonates := FindChemValues(TheQuery, 'MALK') / 0.8202 * CParam[4] * CParam[9];
   end;
   HCO3 := Carbonates;
   SO4 := FindChemValues(TheQuery, 'SO4') * CParam[6];
   Cl := FindChemValues(TheQuery, 'Cl') * CParam[5];
   NO3 := FindChemValues(TheQuery, 'N') * CParam[7];
   Cl := NO3 + Cl;
   AnTotal := SO4 + Cl + HCO3;
   if AnTotal > 0 then
   begin
     HCO3 := (HCO3/AnTotal*100);
     SO4 := (SO4/AnTotal*100);
     Cl := (Cl/AnTotal*100);
   end
   else
   begin
     HCO3 := 0;
     SO4 := 0;
     Cl := 0;
   end;
end;

procedure TChemChartsForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   GlobalQuery.Close;
   AvgQuery.Close;
   MaxQuery.Close;
   MinQuery.Close;
   if MenuItemReport.Visible then //cleanup temp files and reset tags
  begin
    if FileExists(GetTempDir + DirectorySeparator + 'chemchart' + IntToStr(MenuItemReport.Tag) + '.jpg') then
      DeleteFile(GetTempDir + DirectorySeparator + 'chemchart' + IntToStr(MenuItemReport.Tag) + '.jpg');
    if Cht1Tag = MenuItemReport.Tag then
      Cht1Tag := -1;
    if Cht2Tag = MenuItemReport.Tag then
      Cht2Tag := -1;
  end;
  if ClrByGrp then
    MemberList.Free;
  LabelLst.Free;
  LegendLst.Free;
  CloseAction := caFree;
end;

procedure TChemChartsForm.PopupMenu1Popup(Sender: TObject);
begin
  HorizGrid1.Visible := gc = SchoellerChart;
  VertGrid1.Visible := gc = SchoellerChart;
  HorizGrid1.Checked := gc.LeftAxis.Grid.Visible;
  VertGrid1.Checked := gc.BottomAxis.Grid.Visible;
  Legend1.Checked := gc.Legend.Visible;
  MenuItemBackground.Checked := gc.BackColor = clWhite;
  MenuItemPanel.Checked := gc.Color = clWhite;
  MenuItemFrame.Checked := gc.Frame.Visible;
  MenuItemShowHazards.Visible := gc = SARChart;
end;

procedure TChemChartsForm.HorizGrid1Click(Sender: TObject);
var
  a: Byte;
begin
  HorizGrid1.Checked := not HorizGrid1.Checked;
  for a := 0 to gc.AxisList.Count - 1 do
    if (gc.AxisList[a].Alignment = calLeft) or (gc.AxisList[a].Alignment = calRight) then
      gc.AxisList[a].Grid.Visible := HorizGrid1.Checked;
end;

procedure TChemChartsForm.VertGrid1Click(Sender: TObject);
var
  a: Byte;
begin
  VertGrid1.Checked := not VertGrid1.Checked;
  for a := 0 to gc.AxisList.Count - 1 do
    if (gc.AxisList[a].Alignment = calTop) or (gc.AxisList[a].Alignment = calBottom) then
      gc.AxisList[a].Grid.Visible := VertGrid1.Checked;
end;

procedure TChemChartsForm.Monochrome1Click(Sender: TObject);
var g1: integer;
begin
  with gc do
  begin
     BackColor:= clWhite;
     with BottomAxis do
     begin
       AxisPen.Color:= clBlack;
       Grid.Color := clBlack;
       TickColor := clBlack;
       Title.LabelFont.color:=clBlack;
       Marks.LabelFont.Color:= clBlack;
     end;
     Color := clWhite;
     Frame.Color:= clBlack;
     with LeftAxis do
     begin
       AxisPen.Color:= clBlack;
       Grid.Color := clBlack;
       TickColor := clBlack;
       Title.LabelFont.color:= clBlack;
       Marks.LabelFont.color:= clBlack;
     end;
     Legend.Frame.Color:= clBlack;
     Legend.Font.Color:= clBlack;
     //Legend.Color:= clWhite;
     //Legend.Brush.Color:= clWhite;
     Title.Frame.Color:= clBlack;
     Title.Font.Color:= clBlack;
     Title.Font.Color:= clWhite;
     Title.Brush.Color:= clWhite;
     Foot.Frame.Color:= clBlack;
     for g1 := 0 to gc.SeriesCount - 1 do
     begin
      if  (series[g1] is TLineSeries) then
      begin
         (series[g1] as TLineSeries).SeriesColor := clBlack;
         (series[g1] as TLineSeries).Pointer.Pen.Color := clBlack;
         (series[g1] as TLineSeries).Marks.Frame.Color := clBlack;
         (series[g1] as TLineSeries).Marks.LabelBrush.Color := gc.BackColor;
         (series[g1] as TLineSeries).Marks.LabelFont.Color:= clBlack;
      end;
   end;
  end;
end;

procedure TChemChartsForm.FormCreate(Sender: TObject);
begin
   XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
   LabelLst := TStringList.Create;
   LegendLst := TStringList.Create;
end;

procedure TChemChartsForm.ChartRightBottomExit(Sender: TObject);
begin
   gc.BorderStyle := bsNone;
end;

procedure TChemChartsForm.Saveas1Click(Sender: TObject);
var
  fs: TFileStream;
  id: IChartDrawer;
begin
  if SaveDialog.Execute then
  if LowerCase(ExtractFileExt(SaveDialog.FileName)) = '.jpg' then
    gc.SaveToFile(TJPEGImage, SaveDialog.Filename)
  else
  if LowerCase(ExtractFileExt(SaveDialog.Filename)) = '.bmp' then
    gc.SaveToBitmapFile(SaveDialog.FileName)
  {$IFDEF WINDOWS}
  else
  if LowerCase(ExtractFileExt(SaveDialog.Filename)) = '.wmf' then
    gc.SaveToWMF(SaveDialog.FileName)
  {$ENDIF}
  else
  if LowerCase(ExtractFileExt(SaveDialog.Filename)) = '.png' then
    gc.SaveToFile(TPortableNetworkGraphic, SaveDialog.FileName)
  else
  if LowerCase(ExtractFileExt(SaveDialog.Filename)) = '.svg' then
  begin
    fs := TFileStream.Create(SaveDialog.FileName, fmCreate);
    try
      id := TSVGDrawer.Create(fs, true);
      with gc do
        Draw(id, Rect(0, 0, Width, Height));
    finally
      fs.Free;
    end;
  end;
end;

end.
