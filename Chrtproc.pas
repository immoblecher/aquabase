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
unit Chrtproc;

{$mode objfpc}{$H+}

interface

uses
  TAGraph, TASeries, DB, Graphics, SysUtils, variants, ZDataset;

  procedure CloneChart(DestChart, SourceChart: TChart);
  procedure SetResolution(AChart: TChart);
  procedure FindChemValues(aChemQuery: TZQuery;Param: string;var value:real);
  procedure FindPerCent(aChemQuery : TZQuery;var Site,SamNr,ChemRefNr: String; var Ca,Mg,Na,HCO3,So4,Cl: Real);
  procedure FindChemMekwValues(aChemQuery: TZQuery;Param: string;var value:real);
  procedure Monochrome(var gc : TChart);
  procedure GetDateTime(GlobalQuery:TZQuery; var DateString, TimeString: String);

implementation

uses varinit, MainDataModule;

procedure CloneChart(DestChart, SourceChart: TChart);

var t: Longint;

begin
    DestChart.Series.Free;
    DestChart.Assign(SourceChart);
    for t := 0 to SourceChart.SeriesCount-1 do
    begin
      //CloneChartSeries(SourceChart[t]).ParentChart := DestChart;
      if  (DestChart.Series[t] is TLineSeries) then
      begin
         (DestChart.Series[t] as TLineSeries).Pointer.Pen.Color:=
            (SourceChart.Series[t] as TLineSeries).Pointer.Pen.Color;
         (DestChart.Series[t] as TLineSeries).Pointer.Brush.Color:=
            (SourceChart.Series[t] as TLineSeries).Pointer.Brush.Color;
         (DestChart.Series[t] as TLineSeries).Pointer.Visible:=
            (SourceChart.Series[t] as TLineSeries).Pointer.Visible;
      end;
      {if  (DestChart.Series[t] is TPolarSeries) then
      begin
          //Rotation of windrose axes
         (DestChart.Series[t] as TPolarSeries).RotationAngle := 90;
      end;}
     end;
end;

procedure SetResolution(AChart: TChart);

var s: Integer;

begin
  AChart.LeftAxis.Grid.Width := AChart.LeftAxis.Grid.Width - 1;
  //AChart.RightAxis.Grid.Width := AChart.RightAxis.Grid.Width - 1;
  AChart.BottomAxis.Grid.Width := AChart.BottomAxis.Grid.Width - 1;
  //AChart.TopAxis.Grid.Width := AChart.TopAxis.Grid.Width - 1;
  for s := 0 to AChart.SeriesCount - 1 do
    if AChart.Series[s] is TLineSeries then
      (AChart.Series[s] as TLineSeries).LinePen.Width := (AChart.Series[s] as TLineSeries).LinePen.Width - 1;
end;

procedure FindChemValues(aChemQuery: TZQuery;Param: string; var value: real);
begin
  if aChemQuery.FindField(Param).IsNull or (aChemQuery.FindField(Param).Value = - 1) then value := 0
  else
    value := aChemQuery.FindField(Param).Value;
end;

procedure GetDateTime(GlobalQuery:TZQuery; var  DateString, TimeString: String);
begin
  if GlobalQuery.FindField('DATE_SAMPL') <> nil then
    DateString := GlobalQuery.FindField('DATE_SAMPL').Value
  else
  if GlobalQuery.FindField('DATE_MEAS') <> nil then
    DateString:= GlobalQuery.FindField('DATE_MEAS').Value;
  if GlobalQuery.FindField('TIME_SAMPL') <> nil then
    TimeString := GlobalQuery.FindField('TIME_SAMPL').Value
  else
  if GlobalQuery.FindField('TIME_MEAS') <> nil then
    TimeString := GlobalQuery.FindField('TIME_MEAS').Value;
end;

procedure FindChemMekwValues(aChemQuery: TZQuery; Param: string; var value:real);
begin
  if Param = 'HCO3' then
  begin
    FindChemValues(aChemQuery, 'MALK', Value);
    Value := Value * CParam[4] / 0.8202;
  end
  else
  begin
    FindChemValues(aChemQuery, Param, Value);
    Value := Value * CParam[0];
  end;
end;

procedure FindPerCent(aChemQuery : TZQuery; var Site,SamNr,ChemRefNr: String; var Ca,Mg,Na,HCO3,So4,Cl: Real);

var sitefield: TField;
    K,NO3,CatTotal,AnTotal,value: Real;

begin
   Ca:= 0; Mg:= 0; Na:= 0; HCO3:= 0; So4:= 0; Cl:= 0;

   sitefield:= aChemQuery.FindField('SITE_ID_NR');
   Site:= sitefield.Value;

   sitefield:= aChemQuery.FindField('CHM_REF_NR');
   ChemRefNr:= sitefield.Value;

   sitefield:= aChemQuery.FindField('SAMPLE_NR');
   SamNr:= ' ';

   if  sitefield.Value <> null then
   begin
      SamNr:= sitefield.Value;
   end;
   FindChemValues(aChemQuery,'Ca',Value);
   Ca:= Value*CParam[0];

   FindChemValues(aChemQuery,'Mg',Value);
   Mg:= Value*CParam[1];

   FindChemValues(aChemQuery,'Na',Value);
   Na:= Value*CParam[2];

   FindChemValues(aChemQuery,'K',Value);
   K:= Value*CParam[3];

   Na:= Na+K;

   CatTotal:= ca+mg+na;
   if CatTotal > 0 then
   begin
      Ca:= (ca/CatTotal*100);
      Mg:= (mg/CatTotal*100);
      Na:= (na/CatTotal*100);
   end
   else
   begin
      ca:= 0;
      mg:= 0;
      na:= 0;
   end;

   FindChemValues(aChemQuery,'MALK',Value);
   HCO3:= Value*CParam[4];
   HCO3:= HCO3/0.8202;

   FindChemValues(aChemQuery,'SO4',Value);
   So4:= Value*CParam[6];

   FindChemValues(aChemQuery,'Cl',Value);
   Cl:= Value*CParam[5];

   FindChemValues(aChemQuery,'N',Value);
   NO3:= Value*CParam[7];

   Cl:= NO3+Cl;

   AnTotal:= So4+Cl+HCO3;
   if AnTotal > 0 then
   begin
       HCO3:= (HCO3/AnTotal*100);
       So4:= (So4/AnTotal*100);
       Cl:= (Cl/AnTotal*100);
   end
   else
   begin
      HCO3:= 0;
      SO4:= 0;
      Cl:= 0;
   end;
end;

procedure  Monochrome(var gc : TChart);
var g1: integer;
begin
    with gc do
    begin
       BackColor:= clWhite;
       {BevelInner := bvNone;
       BevelOuter := bvNone;}
       {TopAxis.Axis.Color:= clBlack;
       TopAxis.Grid.Color := clBlack;
       TopAxis.Ticks.Color := clBlack;
       TopAxis.MinorTicks.Color := clBlack;
       TopAxis.TicksInner.Color := clBlack;
       TopAxis.Title.Font.color:=clBlack;
       TopAxis.LabelsFont.Color:= clBlack;

       RightAxis.Axis.Color:= clBlack;
       RightAxis.Grid.Color := clBlack;
       RightAxis.Ticks.Color := clBlack;
       RightAxis.MinorTicks.Color := clBlack;
       RightAxis.TicksInner.Color := clBlack;
       RightAxis.Title.Font.color:=clBlack;
       RightAxis.LabelsFont.Color:= clBlack;}

       BottomAxis.AxisPen.Color:= clBlack;
       BottomAxis.Grid.Color := clBlack;
       BottomAxis.TickColor := clBlack;
       {BottomAxis.Minors[0].TickColor := clBlack;
       BottomAxis.TicksInner.Color := clBlack;}
       BottomAxis.Title.LabelFont.Color:= clBlack;

       {BottomWall.Brush.Color:= clBlack;
       BottomWall.Color:= clWhite;
       BottomWall.Pen.Color:= clWhite;}

       Color := clWhite;
       Frame.Color:= clBlack;

       LeftAxis.AxisPen.Color:= clBlack;
       LeftAxis.Grid.Color := clBlack;
       LeftAxis.TickColor := clBlack;
       {LeftAxis.MinorTicks.Color := clBlack;
       LeftAxis.TicksInner.Color := clBlack;}
       LeftAxis.Title.LabelFont.Color:= clBlack;

       {LeftWall.Brush.Color:= clBlack;
       LeftWall.Color:= clWhite;
       LeftWall.Pen.Color:= clBlack;}

       Legend.Frame.Color:= clBlack;
       Legend.Font.Color:= clBlack;
       //Legend.Color:= clWhite;
       Legend.BackgroundBrush.Color:= clWhite;

       Title.Frame.Color:= clBlack;
       Title.Font.Color:= clBlack;
       //Title.Color:= clWhite;
       Title.Brush.Color:= clWhite;

       Foot.Frame.Color:= clBlack;

       //Gradient.StartColor:= clWhite;
       //Gradient.EndColor:= clWhite;
       for g1 := 0 to gc.SeriesCount -1 do
       begin
         {series[g1].Marks.BackColor:= clWhite;
         series[g1].Marks.Frame.Color:= clBlack;
         series[g1].Marks.Arrow.Color := clBlack;
         series[g1].Marks.Frame.Color:= clBlack;
         series[g1].Marks.Font.color:= clBlack;}
       end;
       for g1 := 0 to gc.SeriesCount - 1 do
       begin
         if  (series[g1] is TLineSeries) then
         begin
            (series[g1] as TLineSeries).SeriesColor := clBlack;
            (series[g1] as TLineSeries).Pointer.Pen.Color:= clBlack;
            (series[g1] as TLineSeries).SeriesColor:= clBlack;
         end;
         {if  (series[g1] is TRadarSeries) then
         begin
            series[g1].SeriesColor := clBlack;
           (series[g1] as TRadarSeries).Pointer.Pen.Color:= clBlack;
         end;
         if  (series[g1] is TArrowSeries) then
         begin
            series[g1].SeriesColor := clBlack;
           (series[g1] as TArrowSeries).Pointer.Pen.Color:= clBlack;
         end;
         if (Series[g1] is TCandleSeries) then
         begin
           (Series[g1] as TCandleSeries).DownCloseColor:= clWhite;
           (Series[g1] as TCandleSeries).UpCloseColor:= clWhite;
         end;
         if (Series[g1] is TPolarSeries) then
         begin
           (series[g1] as TPolarSeries).Pointer.Pen.Color := clBlack;
           (series[g1] as TPolarSeries).Pointer.Pen.width := 2;
           (series[g1] as TPolarSeries).Pointer.Brush.Color := clBlack;
           (series[g1] as TPolarSeries).Pointer.Brush.Color := clBlack;
           (series[g1] as TPolarSeries).brush.Color := clSilver;
         end;}
       end;
    end;
end;

end.
