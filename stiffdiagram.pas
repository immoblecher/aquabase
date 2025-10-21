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
unit stiffdiagram;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, TASources, PrintersDlgs,
  Forms, Controls, Graphics, Dialogs, Menus, XMLPropStorage, ZDataset, db, math,
  OSPrinters, TAPrint, Printers, TADrawUtils, TADrawerSVG, TAChartAxisUtils,
  TALegend, TATools
  {$IFDEF WINDOWS}
  ,TADrawerWMF
  {$ENDIF};

type

  { TStiffForm }

  TStiffForm = class(TForm)
    ChartToolset1: TChartToolset;
    ChartToolset1DataPointHintTool1: TDataPointHintTool;
    ChartToolset1PanDragTool1: TPanDragTool;
    ChartToolset1UserDefinedTool1: TUserDefinedTool;
    ChartToolset1ZoomDragTool1: TZoomDragTool;
    ChartToolset1ZoomMouseWheelTool1: TZoomMouseWheelTool;
    HorizGrid1: TMenuItem;
    Legend1: TMenuItem;
    MenuItemFrame: TMenuItem;
    MenuItemPanel: TMenuItem;
    MenuItemBackground: TMenuItem;
    MenuItemReport: TMenuItem;
    MenuItemShowParam: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
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
    StiffChart: TChart;
    ListChartSourceTopBot: TListChartSource;
    ListChartSourceRight: TListChartSource;
    ListChartSourceLeft: TListChartSource;
    StiffSeries1: TAreaSeries;
    StiffQuery: TZReadOnlyQuery;
    VertGrid1: TMenuItem;
    XMLPropStorage1: TXMLPropStorage;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure HorizGrid1Click(Sender: TObject);
    procedure MenuItemFrameClick(Sender: TObject);
    procedure MenuItemPanelClick(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItemBackgroundClick(Sender: TObject);
    procedure MenuItemBiggerClick(Sender: TObject);
    procedure MenuItemBotCentreClick(Sender: TObject);
    procedure MenuItemBotLeftClick(Sender: TObject);
    procedure MenuItemBotRightClick(Sender: TObject);
    procedure MenuItemLegendEnabledClick(Sender: TObject);
    procedure MenuItemShowParamClick(Sender: TObject);
    procedure MenuItemSideBarClick(Sender: TObject);
    procedure MenuItemSmallerClick(Sender: TObject);
    procedure MenuItemTopLeftClick(Sender: TObject);
    procedure MenuItemTopRightClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure StiffQueryAfterOpen(DataSet: TDataSet);
    procedure StiffQueryBeforeOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure VertGrid1Click(Sender: TObject);
  private

  public
    StartDate, StartTime, EndDate, EndTime: ShortString;
    ViewName: ShortString;
    CurrentSiteOnly: Boolean;
    Aggregate: Byte;
    LabelLst, LegendLst: TStringList;
  end;

var
  StiffForm: TStiffForm;

implementation

{$R *.lfm}

uses VARINIT, maindatamodule;

{ TStiffForm }

procedure TStiffForm.StiffQueryBeforeOpen(DataSet: TDataSet);
begin
  with StiffQuery do
   begin
     Connection := DataModuleMain.ZConnectionDB;
     SQL.Clear;
     SQL.Add('SELECT v.SITE_ID_NR, b.NR_ON_MAP, c0.SAMPLE_NR, c0.DATE_SAMPL, c0.TIME_SAMPL, c0.CHM_REF_NR, c1.NA, c1.K, c1.CA, c1.MG, c1.CL, c1.MALK, c1.SO4 FROM ' + ViewName + ' v');
     SQL.Add('JOIN basicinf b ON (v.SITE_ID_NR = b.SITE_ID_NR)');
     SQL.Add('JOIN chem_000 c0 ON (v.SITE_ID_NR = c0.SITE_ID_NR)');
     if DataModuleMain.ZConnectionDB.Tag = 1 then
       SQL.Add('AND c0.DATE_SAMPL || c0.TIME_SAMPL >= ' + QuotedStr(StartDate + StartTime)
         + ' AND c0.DATE_SAMPL || c0.TIME_SAMPL <= ' + QuotedStr(EndDate + EndTime))
     else
       SQL.Add('AND CONCAT(c0.DATE_SAMPL, c0.TIME_SAMPL) >= ' + QuotedStr(StartDate + StartTime)
         + ' AND CONCAT(c0.DATE_SAMPL, c0.TIME_SAMPL) <= ' + QuotedStr(EndDate + EndTime));
     SQL.Add('JOIN chem_001 c1 ON (c0.CHM_REF_NR = c1.CHM_REF_NR)');
     if CurrentSiteOnly then
       SQL.Add('WHERE v.SITE_ID_NR = ' + QuotedStr(CurrentSite));
   end;
end;

procedure TStiffForm.FormShow(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  try
    StiffQuery.Open;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TStiffForm.VertGrid1Click(Sender: TObject);
var
  a: Byte;
begin
  VertGrid1.Checked := not VertGrid1.Checked;
  for a := 0 to StiffChart.AxisList.Count - 1 do
    if (StiffChart.AxisList[a].Alignment = calTop) or (StiffChart.AxisList[a].Alignment = calBottom) then
      StiffChart.AxisList[a].Grid.Visible := VertGrid1.Checked;
end;

procedure TStiffForm.StiffQueryAfterOpen(DataSet: TDataSet);
var
  NaK, Ca, Mg, Cl, HCO3, SO4: Real;
  AggNaK, AggCa, AggMg, AggCl, AggHCO3, AggSO4: Real;
  CntNaK, CntCa, CntMg, CntCl, CntHCO3, CntSO4: Integer;
  MaxCations, MaxAnions: Real;
  MaxCat, MaxAn, m: Integer;
  Increment: Word;
begin
  if Dataset.RecordCount = 0 then
  begin
    MessageDlg('There are no chemistry records available for the Stiff diagram! Please use a different View or move to another site.', mtError, [mbOK], 0);
    StiffQuery.Close;
  end
  else
  begin
    //initialise variables
    AggNaK := 0; AggCa := 0; AggMg := 0; AggCl := 0; AggHCO3 := 0; AggSO4 := 0;
    CntNaK := 0; CntCa := 0; CntMg := 0; CntCl := 0; CntHCO3 := 0; CntSO4 := 0;
    MaxCations := 0; MaxAnions := 0;
    Increment := 1;
    //calculate aggregates in meq/l (Average, First, Last, Max, Min) ignoring -1
    with StiffQuery do
    while not EOF do
    begin
      //Na + K
      if FieldByName('NA').Value > -1 then
        NaK := FieldByName('NA').Value * CParam[2]
      else
        NaK := 0;
      if FieldByName('K').Value > -1 then
        NaK := NaK + FieldByName('K').Value * CParam[3];
      //Ca
      if FieldByName('CA').Value > -1 then
        Ca := FieldByName('CA').Value * CParam[0]
      else
        Ca := 0;
      //Mg
      if FieldByName('MG').Value > -1 then
        Mg := FieldByName('MG').Value * CParam[1]
      else
        Mg := 0;
      //Cl
      if FieldByName('CL').Value > -1 then
        Cl := FieldByName('CL').Value * CParam[5]
      else
        Cl := 0;
      //HCO3
      if FieldByName('MALK').Value > -1 then
        HCO3 := FieldByName('MALK').Value * CParam[4]
      else
        HCO3 := 0;
      //SO4
      if FieldByName('SO4').Value > -1 then
        SO4 := FieldByName('SO4').Value * CParam[6]
      else
        SO4 := 0;
      case Aggregate of
        0: begin //average
             AggNaK := AggNaK + NaK;
             if NaK > 0 then Inc(CntNaK); //ignore the zeros in calculation
             AggCa := AggCa + Ca;
             if Ca > 0 then Inc(CntCa);
             AggMg := AggMg + Mg;
             if Mg > 0 then Inc(CntMg);
             AggCl := AggCl + Cl;
             if Cl > 0 then Inc(CntCl);
             AggHCO3  := AggHCO3 + HCO3;
             if HCO3 > 0 then Inc(CntHCO3);
             AggSO4 := AggSO4 + SO4;
             if SO4 > 0 then Inc(CntSO4);
             Next;
           end;
        1: Last; //first, so jump to EOF
        2: Next; //last, so just iterate to EOF
        3: begin //max
             if NaK > AggNaK then
               AggNaK := NaK;
             if Ca > AggCa then
               AggCa := Ca;
             if Mg > AggMg then
               AggMg := Mg;
             if Cl > AggCl then
               AggCl := Cl;
             if HCO3 > AggHCO3 then
               AggHCO3 := HCO3;
             if SO4 > AggSO4 then
               AggSO4 := SO4;
             Next;
           end ;
        4: begin //min
             AggNaK := 9999999; AggCa := 9999999; AggMg := 9999999;
             AggCl := 9999999; AggHCO3 := 9999999; AggSO4 := 9999999;
             if NaK < AggNaK then
               AggNaK := NaK;
             if Ca < AggCa then
               AggCa := Ca;
             if Mg < AggMg then
               AggMg := Mg;
             if Cl < AggCl then
               AggCl := Cl;
             if HCO3 < AggHCO3 then
               AggHCO3 := HCO3;
             if SO4 < AggSO4 then
               AggSO4 := SO4;
             Next;
           end;
      end; //of case
    end;
    //calculate averages, maximums and minimums
    case Aggregate of
      0: begin
           NaK := AggNaK / CntNaK;
           Ca := AggCa / CntCa;
           Mg := AggMg / CntMg;
           Cl := AggCl / CntCl;
           HCO3 := AggHCO3 / CntHCO3;
           SO4 := AggSO4 / CntSO4;
         end;
   3, 4: begin
           NaK := AggNaK;
           Ca := AggCa;
           Mg := AggMg;
           Cl := AggCl;
           HCO3 := AggHCO3;
           SO4 := AggSO4;
         end;
    end; //of case
    //calculate maximum cations/anions for axes
    MaxCations := NaK;
    if Ca > MaxCations then MaxCations := Ca;
    if Mg > MaxCations then MaxCations := Mg;
    if Cl > MaxAnions then MaxAnions := Cl;
    if HCO3 > MaxAnions then MaxAnions := HCO3;
    if SO4 > MaxAnions then MaxAnions := SO4;
    //Add points to area series
    with StiffSeries1 do
    begin
      Clear;
      AddXY(-NaK, 3, 'Na+K', clBlack);
      AddXY(-Ca, 2, 'Ca', clBlack);
      AddXY(-Mg, 1, 'Mg', clBlack);
      AddXY(SO4, 1, 'SO4', clBlack);
      AddXY(HCO3, 2, 'HCO3', clBlack);
      AddXY(Cl, 3, 'Cl', clBlack);
      ZeroLevel := 3; //highest Y value for start and end to close area
      for m := 0 to LegendLst.Count - 1 do
      begin
        if StiffQuery.FieldByName(LegendLst[m]).AsString <> '' then
          Title := Title + StiffQuery.FieldByName(LegendLst[m]).AsString
        else
          Title := Title + 'n/a';
        if m < LegendLst.Count - 1 then
          Title := Title + ' - ';
      end;
    end;
    StiffQuery.Close;
    //work out max of left and right top/bottom axes
    Math.SetRoundMode(rmUp);
    if (MaxCations > 15) or (MaxAnions > 15) then
    begin
      MaxCations := RoundTo(MaxCations, 1);
      MaxAnions := RoundTo(MaxAnions, 1);
    end
    else
    begin
      MaxCations := RoundTo(MaxCations, 0);
      MaxAnions := RoundTo(MaxAnions, 0);
    end;
    MaxCat := Round(MaxCations);
    MaxAn := Round(MaxAnions);
    //determine increment of axis marks for top/bottom depending on maximums
    if MaxCat > 20 then Increment := 2;
    if (MaxAn > MaxCat) and (MaxAn > 20) then Increment := 2;
    if MaxCat > 40 then Increment := 4;
    if (MaxAn > MaxCat) and (MaxAn > 40) then Increment := 4;
    if MaxCat > 50 then Increment := 4;
    if (MaxAn > MaxCat) and (MaxAn > 50) then Increment := 5;
    //set ListchartSourceTopBot points for maximums left and right
    with ListChartSourceTopBot do
    if MaxCat >= MaxAn then
    begin
      Clear;
      m := - MaxCat;
      repeat
        if m < 0 then
          Add(m, 0, IntToStr(-m), clBlack)
        else
          Add(m, 0, IntToStr(m), clBlack);
        Inc(m, Increment);
      until m > MaxCat;
    end
    else
    begin
      Clear;
      m := -MaxAn;
      repeat
        if m < 0 then
          Add(m, 0, IntToStr(-m), clBlack)
        else
          Add(m, 0, IntToStr(m), clBlack);
        Inc(m, Increment);
      until m > MaxAn;
    end;
    //set maximum of top and bottom axis
    with StiffChart.AxisList[1] do
    if MaxCat >= MaxAn then
    begin
      Range.Min := -MaxCat;
      Range.UseMin := True;
      Range.Max := MaxCat;
      Range.UseMax := True;
    end
    else
    begin
      Range.Min := -MaxAn;
      Range.UseMin := True;
      Range.Max := MaxAn;
      Range.UseMax := True;
    end;
    with StiffChart.AxisList[2] do
    begin
      Range.Min := StiffChart.AxisList[2].Range.Min;
      Range.UseMin := True;
      Range.Max := StiffChart.AxisList[2].Range.Max;
      Range.UseMax := True;
    end;
  end;
end;

procedure TStiffForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
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
  LabelLst.Free;
  LegendLst.Free;
  CloseAction := caFree;
end;

procedure TStiffForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  LabelLst := TStringList.Create;
  LegendLst := TStringList.Create;
end;

procedure TStiffForm.HorizGrid1Click(Sender: TObject);
var
  a: Byte;
begin
  HorizGrid1.Checked := not HorizGrid1.Checked;
  for a := 0 to StiffChart.AxisList.Count - 1 do
    if (StiffChart.AxisList[a].Alignment = calLeft) or (StiffChart.AxisList[a].Alignment = calRight) then
      StiffChart.AxisList[a].Grid.Visible := HorizGrid1.Checked;
end;

procedure TStiffForm.MenuItemFrameClick(Sender: TObject);
begin
  MenuItemFrame.Checked := not MenuItemFrame.Checked;
  if MenuItemFrame.Checked then
    StiffChart.Frame.Visible := True
  else
    StiffChart.Frame.Visible := False;
end;

procedure TStiffForm.MenuItemPanelClick(Sender: TObject);
begin
  MenuItemPanel.Checked := not MenuItemPanel.Checked;
  if MenuItemPanel.Checked then
    StiffChart.Color := clWhite
  else
    StiffChart.Color := clBtnFace;
end;

procedure TStiffForm.MenuItem2Click(Sender: TObject);
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
    StiffChart.Draw(TPrinterDrawer.Create(Printer), r);
  finally
    Printer.EndDoc;
  end;
end;

procedure TStiffForm.MenuItem3Click(Sender: TObject);
var
  fs: TFileStream;
  id: IChartDrawer;
begin
  if SaveDialog.Execute then
  if LowerCase(ExtractFileExt(SaveDialog.FileName)) = 'jpg' then
    StiffChart.SaveToFile(TJPEGImage, SaveDialog.Filename)
  else
  if LowerCase(ExtractFileExt(SaveDialog.Filename)) = 'bmp' then
    StiffChart.SaveToBitmapFile(SaveDialog.FileName)
  {$IFDEF WINDOWS}
  else
  if LowerCase(ExtractFileExt(SaveDialog.Filename)) = 'wmf' then
    StiffChart.SaveToWMF(SaveDialog.FileName)
  {$ENDIF}
  else
  if LowerCase(ExtractFileExt(SaveDialog.Filename)) = 'png' then
    StiffChart.SaveToFile(TPortableNetworkGraphic, SaveDialog.FileName)
  else
  if LowerCase(ExtractFileExt(SaveDialog.Filename)) = 'svg' then
  begin
    fs := TFileStream.Create(SaveDialog.FileName, fmCreate);
    try
      id := TSVGDrawer.Create(fs, true);
      with StiffChart do
        Draw(id, Rect(0, 0, Width, Height));
    finally
      fs.Free;
    end;
  end;
end;

procedure TStiffForm.MenuItem5Click(Sender: TObject);
begin
  StiffChart.CopyToClipboardBitmap;
end;

procedure TStiffForm.MenuItem6Click(Sender: TObject);
var
  g1, al: Byte;
begin
  with StiffChart do
  begin
     BackColor:= clWhite;
     for al := 0 to 3 do
     with AxisList[al] do
     begin
       AxisPen.Color:= clBlack;
       Grid.Color := clBlack;
       TickColor := clBlack;
       Title.LabelFont.color:=clBlack;
       Marks.LabelFont.Color:= clBlack;
     end;
     Color := clWhite;
     Frame.Color:= clBlack;
     Legend.Frame.Color:= clBlack;
     Legend.Font.Color:= clBlack;
     //Legend.Color:= clWhite;
     //Legend.Brush.Color:= clWhite;
     Title.Frame.Color:= clBlack;
     Title.Font.Color:= clBlack;
     Title.Brush.Color:= clWhite;
     Foot.Frame.Color:= clBlack;
     for g1 := 0 to SeriesCount - 1 do
     begin
      if  (series[g1] is TAreaSeries) then
      begin
         (series[g1] as TAreaSeries).SeriesColor := clBlack;
         (series[g1] as TAreaSeries).AreaBrush.Color := clGray;
         (series[g1] as TAreaSeries).Marks.Frame.Color := clBlack;
         (series[g1] as TAreaSeries).Marks.LabelBrush.Color := BackColor;
         (series[g1] as TAreaSeries).Marks.LabelFont.Color:= clBlack;
      end;
   end;
  end;
end;

procedure TStiffForm.MenuItemBackgroundClick(Sender: TObject);
begin
  MenuItemBackground.Checked := not MenuItemBackground.Checked;
  if MenuItemBackground.Checked then
    StiffChart.BackColor := clWhite
  else
    StiffChart.BackColor := clBtnFace;
end;

procedure TStiffForm.MenuItemBiggerClick(Sender: TObject);
var
  s, al: Byte;
begin
  for s := 0 to StiffChart.SeriesCount - 1 do
  with StiffChart do
  begin
    if Series[s] is TAreaSeries then
      TAreaSeries(Series[s]).Marks.LabelFont.Size := TAreaSeries(Series[s]).Marks.LabelFont.Size + 1;
    for al := 0 to 3 do
    begin
      AxisList[al].Marks.LabelFont.Size := AxisList[al].Marks.LabelFont.Size + 1;
      AxisList[al].Title.LabelFont.Size := AxisList[al].Title.LabelFont.Size + 1;
    end;
    Legend.Font.Size := Legend.Font.Size + 1;
  end;
end;

procedure TStiffForm.MenuItemBotCentreClick(Sender: TObject);
begin
  MenuItemBotCentre.Checked := not MenuItemBotCentre.Checked;
  StiffChart.Legend.Alignment := laBottomCenter;
end;

procedure TStiffForm.MenuItemBotLeftClick(Sender: TObject);
begin
  MenuItemBotLeft.Checked := not MenuItemBotLeft.Checked;
  StiffChart.Legend.Alignment := laBottomLeft;
end;

procedure TStiffForm.MenuItemBotRightClick(Sender: TObject);
begin
  MenuItemBotRight.Checked := not MenuItemBotRight.Checked;
  StiffChart.Legend.Alignment := laBottomRight;
end;

procedure TStiffForm.MenuItemLegendEnabledClick(Sender: TObject);
begin
  MenuItemLegendEnabled.Checked := not MenuItemLegendEnabled.Checked;
  StiffChart.Legend.Visible := MenuItemLegendEnabled.Checked;
end;

procedure TStiffForm.MenuItemShowParamClick(Sender: TObject);
var
  s: Word;
begin
  MenuItemShowParam.Checked := not MenuItemShowParam.Checked;
  if MenuItemShowParam.Checked then
  for s := 0 to StiffChart.SeriesCount - 1 do
    (StiffChart.Series[s] as TAreaSeries).Marks.Visible := True
  else
  for s := 0 to StiffChart.SeriesCount - 1 do
    (StiffChart.Series[s] as TAreaSeries).Marks.Visible := False;
end;

procedure TStiffForm.MenuItemSideBarClick(Sender: TObject);
begin
  MenuItemSideBar.Checked := not MenuItemSideBar.Checked;
  StiffChart.Legend.UseSidebar := MenuItemSideBar.Checked;
end;

procedure TStiffForm.MenuItemSmallerClick(Sender: TObject);
var
  s, al: Byte;
begin
  for s := 0 to StiffChart.SeriesCount - 1 do
  with StiffChart do
  begin
    if Series[s] is TAreaSeries then
      TAreaSeries(Series[s]).Marks.LabelFont.Size := TAreaSeries(Series[s]).Marks.LabelFont.Size + 1;
    for al := 0 to 3 do
    begin
      AxisList[al].Marks.LabelFont.Size := AxisList[al].Marks.LabelFont.Size - 1;
      AxisList[al].Title.LabelFont.Size := AxisList[al].Title.LabelFont.Size - 1;
    end;
    Legend.Font.Size := Legend.Font.Size - 1;
  end;
end;

procedure TStiffForm.MenuItemTopLeftClick(Sender: TObject);
begin
  MenuItemTopLeft.Checked := not MenuItemTopLeft.Checked;
  StiffChart.Legend.Alignment := laTopLeft;
end;

procedure TStiffForm.MenuItemTopRightClick(Sender: TObject);
begin
  MenuItemTopRight.Checked := not MenuItemTopRight.Checked;
  StiffChart.Legend.Alignment := laTopRight;
end;

procedure TStiffForm.PopupMenu1Popup(Sender: TObject);
begin
  MenuItemBackground.Checked := StiffChart.BackColor = clWhite;
  MenuItemPanel.Checked := StiffChart.Color = clWhite;
  MenuItemFrame.Checked := StiffChart.Frame.Visible;
end;

end.

