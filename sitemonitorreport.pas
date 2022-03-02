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
unit sitemonitorreport;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBCtrls, TAGraph,
  TAIntervalSources, TATransformations, RLReport, ZDataset,
  reporttemplate, db, TASeries, TATypes;

type

  { TSiteMonitoringReportForm }

  TSiteMonitoringReportForm = class(TReportTemplateForm)
    BasicImgQueryDATE_CREAT: TStringField;
    BasicImgQuerySITE_ID_NR: TStringField;
    BasicImgQuerySITE_IMAGE: TBlobField;
    BasicImgQueryTIME_CREAT: TStringField;
    BasicinfQueryNOTE_PAD: TBlobField;
    Chart1: TChart;
    Chart2: TChart;
    ChemQuery: TZReadOnlyQuery;
    BasicImgDataSource: TDataSource;
    ChemQueryCHM_REF_NR: TLargeintField;
    ChemQueryCOMMENT: TStringField;
    ChemQueryDATE_SAMPL: TStringField;
    ChemQueryDEPTH_SAMP: TFloatField;
    ChemQueryMETH_SAMPL: TStringField;
    ChemQueryPARAM1: TFloatField;
    ChemQueryPARAM2: TFloatField;
    ChemQuerySAMPLE_NR: TStringField;
    ChemQuerySITE_ID_NR: TStringField;
    ChemQueryTIME_SAMPL: TStringField;
    CommentsDataSource: TDataSource;
    CommentsQueryDATE_ENTRY: TStringField;
    CommentsQueryNOTE_PAD: TBlobField;
    CommentsQueryREP_INST: TStringField;
    CommentsQuerySITE_ID_NR: TStringField;
    ChemDataSource: TDataSource;
    FldMeasBand1: TRLBand;
    FldMeasDataSource: TDataSource;
    FldMeasQueryCOMMENT: TStringField;
    FldMeasQueryDATE_MEAS: TStringField;
    FldMeasQueryDEPTH_MEAS: TFloatField;
    FldMeasQueryINFO_SOURC: TStringField;
    FldMeasQueryPARM_MEAS: TStringField;
    FldMeasQueryREADING: TFloatField;
    FldMeasQuerySITE_ID_NR: TStringField;
    FldMeasQueryTIME_MEAS: TStringField;
    FldMeasRLBand1: TRLBand;
    ChemSubDetail: TRLSubDetail;
    LAutoScaleAxisTransform: TAutoScaleAxisTransform;
    LAutoScaleAxisTransform1: TAutoScaleAxisTransform;
    LAxisTransformations: TChartAxisTransformations;
    RAxisTransformations: TChartAxisTransformations;
    OwnerDataSource: TDataSource;
    InstallaDataSource: TDataSource;
    InstallaQueryDATE_INSTL: TStringField;
    InstallaQueryDEPTH_INTK: TFloatField;
    InstallaQuerySITE_ID_NR: TStringField;
    OwnerQueryADDRESS_1: TStringField;
    OwnerQueryADDRESS_2: TStringField;
    OwnerQueryADDRESS_3: TStringField;
    OwnerQueryADDRESS_4: TStringField;
    OwnerQueryDATE_FROM: TStringField;
    OwnerQueryDATE_TO: TStringField;
    OwnerQueryNAME_OWNER: TStringField;
    OwnerQuerySITE_ID_NR: TStringField;
    OwnerQueryTELEPHONE: TStringField;
    QueryLimitsCHM_REF_NR: TLongintField;
    QueryLimitsCPARAMETER: TStringField;
    QueryLimitsLIMITS: TStringField;
    RLBand2: TRLBand;
    BasicImgQuery: TZReadOnlyQuery;
    RLBandCharts: TRLBand;
    RLDBMemo1: TRLDBMemo;
    RLDBMemo2: TRLDBMemo;
    RLDBMemo3: TRLDBMemo;
    RLDBMemo4: TRLDBMemo;
    RLDBMemo5: TRLDBMemo;
    RLDBText139: TRLDBText;
    RLDBText140: TRLDBText;
    RLDBText141: TRLDBText;
    RLDBText142: TRLDBText;
    RLDBText143: TRLDBText;
    RLDBText144: TRLDBText;
    RLDBText145: TRLDBText;
    RLDBText146: TRLDBText;
    RLDBText147: TRLDBText;
    RLDBText148: TRLDBText;
    RLDBText149: TRLDBText;
    RLDBText150: TRLDBText;
    RLDBText151: TRLDBText;
    RLDBText152: TRLDBText;
    RLDBText153: TRLDBText;
    RLDBText154: TRLDBText;
    RLDBText155: TRLDBText;
    RLDBTextParam1: TRLDBText;
    RLDBText157: TRLDBText;
    RLDBText158: TRLDBText;
    RLDBText159: TRLDBText;
    RLDBText160: TRLDBText;
    RLDBTextParam2: TRLDBText;
    RLDBText17: TRLDBText;
    RLDBText27: TRLDBText;
    RLDBText28: TRLDBText;
    RLDBText29: TRLDBText;
    RLDBText34: TRLDBText;
    RLDBText35: TRLDBText;
    RLImage1: TRLImage;
    RLImageChem: TRLImage;
    RLImageWL: TRLImage;
    RLLabel1: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel201: TRLLabel;
    RLLabel202: TRLLabel;
    RLLabel203: TRLLabel;
    RLLabel204: TRLLabel;
    RLLabel205: TRLLabel;
    RLLabel206: TRLLabel;
    RLLabel207: TRLLabel;
    RLLabel208: TRLLabel;
    RLLabel209: TRLLabel;
    RLLabel21: TRLLabel;
    RLLabel210: TRLLabel;
    RLLabel211: TRLLabel;
    RLLabel212: TRLLabel;
    RLLabel213: TRLLabel;
    RLLabel214: TRLLabel;
    RLLabel215: TRLLabel;
    RLLabel216: TRLLabel;
    RLLabel217: TRLLabel;
    RLLabel218: TRLLabel;
    RLLabel219: TRLLabel;
    RLLabelParam1: TRLLabel;
    RLLabel221: TRLLabel;
    RLLabel222: TRLLabel;
    RLLabel223: TRLLabel;
    RLLabel224: TRLLabel;
    RLLabelParam2: TRLLabel;
    RLLabel31: TRLLabel;
    RLLabel32: TRLLabel;
    RLLabel33: TRLLabel;
    RLLabel79: TRLLabel;
    RLLabelNoPhoto: TRLLabel;
    InstallaQuery: TZReadOnlyQuery;
    CommentsQuery: TZReadOnlyQuery;
    RLSubDetailCharts: TRLSubDetail;
    SubDetail2: TRLSubDetail;
    SubHeaderBand1: TRLBand;
    OwnerQuery: TZReadOnlyQuery;
    BADateTimeIntervalChartSource: TDateTimeIntervalChartSource;
    TimeAutoScaleAxisTransform: TAutoScaleAxisTransform;
    TimeAxisTransformations: TChartAxisTransformations;
    ViewQuerySITE_ID_NR: TStringField;
    WaterlevBand: TRLBand;
    FldMeasBand: TRLBand;
    WaterlevDataSource: TDataSource;
    WaterlevQuery: TZReadOnlyQuery;
    WaterlevQueryCOMMENT: TStringField;
    WaterlevQueryDATE_MEAS: TStringField;
    WaterlevQueryINFO_SOURC: TStringField;
    WaterlevQueryLEVEL_STAT: TStringField;
    WaterlevQueryMETH_MEAS: TStringField;
    WaterlevQueryPIEZOM_NR: TStringField;
    WaterlevQuerySITE_ID_NR: TStringField;
    WaterlevQueryTIME_MEAS: TStringField;
    WaterlevQueryTIME_SEC: TFloatField;
    WaterlevQueryWATER_LEV: TFloatField;
    WaterlevRLBand: TRLBand;
    FldMeasRLBand: TRLBand;
    WaterlevSubDetail: TRLSubDetail;
    FldMeasSubDetail: TRLSubDetail;
    FldMeasQuery: TZReadOnlyQuery;
    ZReadOnlyQuery1: TZReadOnlyQuery;
    QueryLimits: TZReadOnlyQuery;
    procedure BasicImgQueryAfterOpen(DataSet: TDataSet);
    procedure BasicImgQueryBeforeOpen(DataSet: TDataSet);
    procedure BasicinfQueryAfterOpen(DataSet: TDataSet);
    procedure ChemQueryAfterOpen(DataSet: TDataSet);
    procedure ChemQueryBeforeOpen(DataSet: TDataSet);
    procedure ChemQueryGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure CommentsQueryBeforeOpen(DataSet: TDataSet);
    procedure FldMeasQueryAfterOpen(DataSet: TDataSet);
    procedure FldMeasQueryBeforeOpen(DataSet: TDataSet);
    procedure DEPTHGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure FldMeasQueryREADINGGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure FldMeasRLBand1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure InstallaQueryBeforeOpen(DataSet: TDataSet);
    procedure InstallaQueryDEPTH_INTKGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure OwnerQueryADDRESS_4GetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure OwnerQueryBeforeOpen(DataSet: TDataSet);
    procedure OwnerQueryDATE_FROMGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure DATEGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure RLBand1AfterPrint(Sender: TObject);
    procedure RLSubDetailChartsAfterPrint(Sender: TObject);
    procedure RLSubDetailChartsBeforePrint(Sender: TObject; var PrintIt: Boolean
      );
    procedure TheReportBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure ViewDataSourceDataChange(Sender: TObject; Field: TField);
    procedure WaterlevQueryAfterOpen(DataSet: TDataSet);
    procedure WaterlevQueryBeforeOpen(DataSet: TDataSet);
    procedure TIMEGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure WaterlevQueryWATER_LEVGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    function FormatTheFloat(const TheFloat: Double): ShortString;
    function GetSymbol(const ChemValue: Variant): ShortString;
    procedure FormatChart(var TheChart: TChart);
  private
    FontSize: Byte;
  public
    ImgDescr, Param1, Param2: ShortString;
    ShowPhoto, CommentMemoFromBasic, ShowWLChart, RandomClrs: Boolean;
    WLTitle, ChemTitle, ShowWLPoints, ShowChemPoints, SwopCharts: Boolean;
    DateTimeFrom, DateTimeTo: TDateTime;
    ChemChtType: Byte;
    WatrLvlClr, FldParam1Clr, FldParam2Clr, LabParam1Clr, LabParam2Clr: TColor;
  end;

var
  SiteMonitoringReportForm: TSiteMonitoringReportForm;

implementation

{$R *.lfm}

uses VARINIT, StrDateTime, MainDataModule;

const ResFactor = 3;

{ TSiteMonitoringReportForm }

procedure TSiteMonitoringReportForm.FormatChart(var TheChart: TChart);
begin
  with TheChart do
  begin
    Title.Font := ReportFont;
    Title.Font.Size := FontSize;
    Title.Font.Style := [fsbold];
    Legend.Font := ReportFont;
    Legend.Font.Size := FontSize;
    if not Title.Visible then
      MarginsExternal.Top := 8;
    with LeftAxis do
    begin
      Title.LabelFont := ReportFont;
      Title.LabelFont.Size := FontSize;
      Title.LabelFont.Orientation := 900;
      Title.LabelFont.Style := [fsBold];
      Marks.LabelFont := ReportFont;
      Marks.LabelFont.Size := FontSize;
      Title.Caption := 'Water Level [' + LengthUnit + 'bgl]';
    end;
    with BottomAxis do
    begin
      Title.LabelFont := ReportFont;
      Title.LabelFont.Size := FontSize;
      Title.LabelFont.Style := [fsBold];
      Marks.LabelFont := ReportFont;
      Marks.LabelFont.Size := FontSize;
    end;
    if AxisList.Count = 3 then
    with AxisList[2] do
    begin
      Title.LabelFont := ReportFont;
      Title.LabelFont.Size := FontSize;
      Title.LabelFont.Orientation := -900;
      Title.LabelFont.Style := [fsBold];
      Marks.LabelFont := ReportFont;
      Marks.LabelFont.Size := FontSize;
    end;
  end;
end;

function TSiteMonitoringReportForm.GetSymbol(const ChemValue: Variant): ShortString;
begin
  Result := '';
  with DataModuleMain do
  if ClassTable.Active then
  begin
    if ChemValue > ClassTableCLASS3.Value then
      Result := ' ‡'
    else if ChemValue > ClassTableCLASS2.Value then
      Result := ' †'
    else if ChemValue > ClassTableCLASS1.Value then
      Result := ' #'
    else if ChemValue > ClassTableCLASS0.Value then
      Result := ' !';
  end
  else
  begin
    if (ChemValue > StandardTableSTDMAXHI.Value) and (StandardTableSTDMAXHI.Value > -1) then
      Result := ' ‡'
    else if (ChemValue > StandardTableSTDRECHI.Value) and (StandardTableSTDRECHI.Value > -1) then
      Result := ' †'
    else if (ChemValue < StandardTableSTDMAXLO.Value) and (StandardTableSTDMAXLO.Value > -1)  then
      Result := ' #'
    else if (ChemValue < StandardTableSTDRECLO.Value) and (StandardTableSTDRECLO.Value > -1)  then
      Result := ' !';
  end;
end;

function TSiteMonitoringReportForm.FormatTheFloat(const TheFloat: Double): ShortString;
begin
  if TheFloat = 0 then
    Result := '0.00'
  else
  if Abs(TheFloat) < 0.001 then
    Result := FloatToStrF(TheFloat, ffFixed, 15, 5)
  else
  if Abs(TheFloat) < 0.01 then
    Result := FloatToStrF(TheFloat, ffFixed, 15, 4)
  else
  if Abs(TheFloat) < 0.1 then
    Result := FloatToStrF(TheFloat, ffFixed, 15, 3)
  else
  if Abs(TheFloat) < 1000 then
    Result := FloatToStrF(TheFloat, ffFixed, 15, 2)
  else
  if Abs(TheFloat) < 100000 then
    Result := FloatToStrF(TheFloat, ffFixed, 15, 1)
  else
    Result := FloatToStrF(TheFloat, ffFixed, 15, 0);
end;

procedure TSiteMonitoringReportForm.ViewDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if (Field = NIL) and NewSite then
  begin
    if CommentMemoFromBasic then
    begin
      RLCommentMemo.Lines.Clear;
      RLCommentMemo.Lines.Add('NOTES:');
      RLCommentMemo.Lines.Add(BasicinfQueryNOTE_PAD.Value);
    end;
    with BasicImgQuery do
    begin
      Close;
      Open;
    end;
    with InstallaQuery do
    begin
      Close;
      Open;
    end;
    with OwnerQuery do
    begin
      Close;
      Open;
    end;
    with CommentsQuery do
    begin
      Close;
      Open;
    end;
    with WaterlevQuery do
    begin
      Close;
      Open;
    end;
    with FldMeasQuery do
    begin
      Close;
      Open;
    end;
    //check if at least one parameter is selected, otherwise don't open chemistry
    if (Param1 <> '<none>') or (Param2 <> '<none>') then
    begin
      with ChemQuery do
      begin
        Close;
        Open;
      end;
      with QueryLimits do
      begin
        Close;
        Open;
      end;
    end;
    Randomize;
  end;
end;

procedure TSiteMonitoringReportForm.WaterlevQueryAfterOpen(DataSet: TDataSet);
var
  TheDateTime: TDateTime;
  TheLineSeries: TLineSeries;
  TheSeriesColour: TColor;
  Piez: ShortString;
begin
  if ShowWLChart and (DataSet.RecordCount > 1) then
  begin
    Chart1.ClearSeries;
    Piez := '';
    while not DataSet.EOF do
    begin
      //check whether Piezometer has changed
      if (Piez <> DataSet.FieldByName('PIEZOM_NR').AsString) then
      begin
        //create the series
        if RandomClrs then
          TheSeriesColour := Random(256*256*256)
        else
          TheSeriesColour := WatrLvlClr;
        //TheSeriesColour := clBlack;
        TheLineSeries := TLineSeries.Create(Chart1);
        with TheLineSeries do
        begin
          Title := 'Piezometer ' + DataSet.FieldByName('PIEZOM_NR').AsString;
          AxisIndexX := 1;
          AxisIndexY := 0;
          SeriesColor := TheSeriesColour;
          if ShowWLPoints then
          begin
            Pointer.Brush.Color := TheSeriesColour;
            Pointer.Style := TSeriesPointerStyle(Random(20));
            if Pointer.Style = psNone then
              Pointer.Style := psRectangle;
            Pointer.HorizSize := ResFactor * Pointer.HorizSize;
            Pointer.VertSize := ResFactor * Pointer.VertSize;
            ShowPoints := True;
          end;
          Marks.LabelFont := AppFont;
          Marks.LabelFont.Size := FontSize;
          LinePen.Style := TPenStyle(Random(5)); //start with 0 =  solid
          LinePen.Width := ResFactor * LinePen.Width;
        end;
        Chart1.AddSeries(TheLineSeries);
      end;
      Piez := DataSet.FieldByName('PIEZOM_NR').AsString;
      //convert date and time fields to DateTime
      TheDateTime := StringToDate(WaterlevQueryDATE_MEAS.Value) + StringToTime(WaterlevQueryTIME_MEAS.Value);
      //populate list with query values
      if (not DataSet.FieldByName('WATER_LEV').IsNull) then
        TheLineSeries.AddXY(TheDateTime, DataSet.FieldByName('WATER_LEV').Value * LengthFactor, '', TheSeriesColour);
      DataSet.Next;
    end;
    if Chart1.SeriesCount > 0 then
    with Chart1 do
    begin
      Title.Text.Clear;
      Title.Text.Add('Water Levels over time at site ' + BasicinfQuerySITE_ID_NR.AsString + ' (' + BasicinfQueryNR_ON_MAP.AsString + ')' );
      if SeriesCount > 1 then
        Legend.Visible := True;
      Width := RLImageWL.Width * ResFactor;
      Height := RLImageWL.height * ResFactor;
      RLImageWL.Picture.Bitmap.Assign(Chart1.SaveToImage(TBitmap));
    end;
  end;
end;

procedure TSiteMonitoringReportForm.WaterlevQueryBeforeOpen(DataSet: TDataSet);
begin
  with WaterlevQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM waterlev WHERE site_id_nr = ' + QuotedStr(ViewQuerySITE_ID_NR.Value));
    //set dates
    if Connection.Tag = 1 then
    begin
      SQL.Add('AND DATE_MEAS || TIME_MEAS >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimeFrom)));
      SQL.Add('AND DATE_MEAS || TIME_MEAS <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimeTo)));
    end
    else
    begin
      SQL.Add('AND CONCAT(DATE_MEAS, TIME_MEAS) >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimeFrom)));
      SQL.Add('AND CONCAT(DATE_MEAS, TIME_MEAS) <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimeTo)));
    end;
  end;
end;

procedure TSiteMonitoringReportForm.TIMEGetText(
  Sender: TField; var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := FormatDateTime('hh:nn', StringToTime(Sender.AsString));
end;

procedure TSiteMonitoringReportForm.WaterlevQueryWATER_LEVGetText(
  Sender: TField; var aText: string; DisplayText: Boolean);
begin
  if not Sender.IsNull then
  begin
    if Abs(Sender.AsFloat * LengthFactor) > 10000 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end
  else
    DisplayText := False;
end;

procedure TSiteMonitoringReportForm.TheReportBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  RLLabel17.Caption := RLLabel17.Caption + ' [' + LengthUnit + ']';
  RLLabel210.Caption := '[' + LengthUnit + ']';
  RLLabel216.Caption := RLLabel216.Caption + ' [' + LengthUnit + ']';
  RLLabel213.Caption := '(EC in [' + ECUnit + '], all others in [' + ChemUnit + '], where applic.)';
  RLLabel213.Font.Size := RLLabel213.Font.Size - 1;
  RLLabel223.Caption := RLLabel223.Caption + ' [' + LengthUnit + ']';
  if SwopCharts then
  begin
    RLImageWL.Align := faRight;
    RLImageChem.Align := faLeft;
  end;
  //set tags to format output and labels with units
  if UpperCase(Param1) = 'EC' then
  begin
    ChemQueryPARAM1.Tag := 6;
    RLLabelParam1.Caption := 'EC [' + ECUnit + ']';
  end
  else if Param1 = 'N_AMONIA' then
  begin
    ChemQueryPARAM1.Tag := 5;
    if AsN then
      RLLabelParam1.Caption := 'NH4 as N [' + ChemUnit + ']'
    else RLLabelParam1.Caption := 'NH4 [' + ChemUnit + ']';
  end
  else if Param1 = 'N' then
  begin
    ChemQueryPARAM1.Tag := 4;
    if AsN then
      RLLabelParam1.Caption := 'NO3 as N [' + ChemUnit + ']'
    else RLLabelParam1.Caption := 'N [' + ChemUnit + ']';
  end
  else if Param1 = 'PO4' then
  begin
    ChemQueryPARAM1.Tag := 3;
    if AsN then
      RLLabelParam1.Caption := 'PO4 as P [' + ChemUnit + ']'
    else RLLabelParam1.Caption := 'PO4 [' + ChemUnit + ']';
  end
  else if Param1 = 'NO2' then
  begin
    ChemQueryPARAM1.Tag := 2;
    if AsN then
      RLLabelParam1.Caption := 'NO2 as N [' + ChemUnit + ']'
    else RLLabelParam1.Caption := 'NO2 [' + ChemUnit + ']';
  end
  else
  if (Param1 <> '<none>') and (ChemQuery.FindField('PARAM1') <> NIL) then
  begin
    ChemQueryPARAM1.Tag := 1;
    RLLabelParam1.Caption := UpperCase(Param1) + ' [' + ChemUnit + ']';
  end
  else
    RLLabelParam1.Visible := False;
  if UpperCase(Param2) = 'EC' then
  begin
    ChemQueryPARAM2.Tag := 6;
    RLLabelParam2.Caption := 'EC [' + ECUnit + ']';
  end
  else if Param2 = 'N_AMONIA' then
  begin
    ChemQueryPARAM2.Tag := 5;
    if AsN then
      RLLabelParam2.Caption := 'NH4 as N [' + ChemUnit + ']'
    else RLLabelParam2.Caption := 'NH4 [' + ChemUnit + ']';
  end
  else if Param2 = 'N' then
  begin
    ChemQueryPARAM2.Tag := 4;
    if AsN then
      RLLabelParam2.Caption := 'NO3 as N [' + ChemUnit + ']'
    else RLLabelParam2.Caption := 'N [' + ChemUnit + ']';
  end
  else if Param2 = 'PO4' then
  begin
    ChemQueryPARAM2.Tag := 3;
    if AsN then
      RLLabelParam2.Caption := 'PO4 as P [' + ChemUnit + ']'
    else RLLabelParam2.Caption := 'PO4 [' + ChemUnit + ']';
  end
  else if Param2 = 'NO2' then
  begin
    ChemQueryPARAM2.Tag := 2;
    if AsN then
      RLLabelParam2.Caption := 'NO2 as N [' + ChemUnit + ']'
    else RLLabelParam2.Caption := 'NO2 [' + ChemUnit + ']';
  end
  else
  if (Param2 <> '<none>') and (ChemQuery.FindField('PARAM2') <> NIL) then
  begin
    ChemQueryPARAM2.Tag := 1;
    RLLabelParam2.Caption := UpperCase(Param2) + ' [' + ChemUnit + ']';
  end
  else
    RLLabelParam2.Visible := False;
end;

procedure TSiteMonitoringReportForm.InstallaQueryDEPTH_INTKGetText(
  Sender: TField; var aText: string; DisplayText: Boolean);
begin
  if Sender.Value > 0 then
  begin
    if Sender.Value * LengthFactor > 1000 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
    else
    if Sender.Value * LengthFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TSiteMonitoringReportForm.BasicImgQueryAfterOpen(DataSet: TDataSet);
var
  Stream: TStream;
begin
  if ShowPhoto then
  begin
    if not BasicImgQuerySITE_IMAGE.IsNull then
    begin
      RLLabelNoPhoto.Visible := False;
      RLImage1.Borders.Sides := sdNone;
      try
        Stream := BasicImgQuery.CreateBlobStream(BasicImgQuerySITE_IMAGE, bmRead);
        Stream.Position := 0;
        RLImage1.Picture.LoadFromStream(Stream);
      finally
        Stream.Free;
      end
    end
    else
    begin
      RLLabelNoPhoto.Visible := True;
      RLImage1.Borders.Sides := sdAll;
    end;
  end
  else
  begin
    RLLabelNoPhoto.Visible := True;
    RLImage1.Borders.Sides := sdAll;
  end;
end;

procedure TSiteMonitoringReportForm.BasicImgQueryBeforeOpen(DataSet: TDataSet);
begin
  BasicImgQuery.Params[0].Value := ViewQuerySITE_ID_NR.Value;
  BasicImgQuery.Params[1].Value := ImgDescr;
end;

procedure TSiteMonitoringReportForm.BasicinfQueryAfterOpen(DataSet: TDataSet);
begin
  SiteID := BasicinfQuerySITE_ID_NR.Value;
end;

procedure TSiteMonitoringReportForm.ChemQueryAfterOpen(DataSet: TDataSet);
var
  TheDateTime: TDateTime;
  LineSeries1, LineSeries2: TLineSeries;
  SeriesColour1, SeriesColour2: TColor;
begin
  if (DataSet.RecordCount > 1) and (ChemChtType IN [1,3]) then //chemistry only or chemistry and field measurements
  begin
    //if field for Param 1 exists then create series for it
    if ChemQuery.FindField('PARAM1') <> NIL then
    begin
      //create the series
      if RandomClrs then
        SeriesColour1 := Random(256*256*256)
      else
        SeriesColour1 := LabParam1Clr;
      LineSeries1 := TLineSeries.Create(Chart2);
      with LineSeries1 do
      begin
        Title := 'Lab. ' + Param1;
        AxisIndexX := 1;
        AxisIndexY := 0;
        SeriesColor := SeriesColour1;
        if ShowChemPoints then
        begin
          Pointer.Brush.Color := SeriesColour1;
          Pointer.Style := TSeriesPointerStyle(Random(20));
          if Pointer.Style = psNone then
            Pointer.Style := psRectangle;
          Pointer.HorizSize := ResFactor * Pointer.HorizSize;
          Pointer.VertSize := ResFactor * Pointer.VertSize;
          ShowPoints := True;
        end;
        Marks.LabelFont := AppFont;
        Marks.LabelFont.Size := FontSize;
        LinePen.Style := TPenStyle(Random(5)); //start with 0 = solid
        LinePen.Width := ResFactor * LinePen.Width;
      end;
      Chart2.AddSeries(LineSeries1);
      DataSet.First;
      while not DataSet.EOF do
      begin
        //convert date and time fields to DateTime
        TheDateTime := StringToDate(ChemQueryDATE_SAMPL.Value) + StringToTime(ChemQueryTIME_SAMPL.Value);
        //populate list with query values
        if (not DataSet.FieldByName('PARAM1').IsNull) and (DataSet.FieldByName('PARAM1').Value > -1) then
          LineSeries1.AddXY(TheDateTime, DataSet.FieldByName('PARAM1').Value , '', SeriesColour1);
        DataSet.Next;
      end;
      if not Chart2.LeftAxis.Visible then //turned off as there were not enough field measurements
        Chart2.LeftAxis.Visible := LineSeries1.Count > 1;
      if LineSeries1.Count < 2 then
        LineSeries1.Destroy;
      if Chart2.LeftAxis.Visible and (Chart2.LeftAxis.Title.Caption = 'Parameter1') then
      begin
        if Param1 = 'EC' then
          Chart2.LeftAxis.Title.Caption := 'EC [' + ECUnit + ']'
        else if Param1 = 'N_AMONIA' then
        begin
          if AsN then
            Chart2.LeftAxis.Title.Caption := 'NH4 as N [' + ChemUnit + ']'
          else Chart2.LeftAxis.Title.Caption := 'NH4 [' + ChemUnit + ']';
        end
        else if Param1 = 'N' then
        begin
          if AsN then
            Chart2.LeftAxis.Title.Caption := 'NO3 as N [' + ChemUnit + ']'
          else Chart2.LeftAxis.Title.Caption := 'N [' + ChemUnit + ']';
        end
        else if Param1 = 'PO4' then
        begin
          if AsN then
            Chart2.LeftAxis.Title.Caption := 'PO4 as P [' + ChemUnit + ']'
          else Chart2.LeftAxis.Title.Caption := 'PO4 [' + ChemUnit + ']';
        end
        else if Param1 = 'NO2' then
        begin
          if AsN then
            Chart2.LeftAxis.Title.Caption := 'NO2 as N [' + ChemUnit + ']'
          else Chart2.LeftAxis.Title.Caption := 'NO2 [' + ChemUnit + ']';
        end
        else
          Chart2.LeftAxis.Title.Caption := UpperCase(Param1) + ' [' + ChemUnit + ']';
      end;
    end;
    //if field for Param 2 exists then create series for it
    if ChemQuery.FindField('PARAM2') <> NIL then
    begin
      //create the series
      if RandomClrs then
        SeriesColour2 := Random(256*256*256)
      else
        SeriesColour2 := LabParam2Clr;
      LineSeries2 := TLineSeries.Create(Chart2);
      with LineSeries2 do
      begin
        Title := 'Lab. ' + Param2;
        AxisIndexX := 1;
        AxisIndexY := 2;
        SeriesColor := SeriesColour2;
        if ShowChemPoints then
        begin
          Pointer.Brush.Color := SeriesColour2;
          Pointer.Style := TSeriesPointerStyle(Random(20));
          if Pointer.Style = psNone then
            Pointer.Style := psRectangle;
          Pointer.HorizSize := ResFactor * Pointer.HorizSize;
          Pointer.VertSize := ResFactor * Pointer.VertSize;
          ShowPoints := True;
        end;
        Marks.LabelFont := AppFont;
        Marks.LabelFont.Size := FontSize;
        LinePen.Style := TPenStyle(Random(5)); //start with 0 = solid
        LinePen.Width := ResFactor * LinePen.Width;
      end;
      Chart2.AddSeries(LineSeries2);
      DataSet.First;
      while not DataSet.EOF do
      begin
        //convert date and time fields to DateTime
        TheDateTime := StringToDate(ChemQueryDATE_SAMPL.Value) + StringToTime(ChemQueryTIME_SAMPL.Value);
        //populate list with query values
        if (not DataSet.FieldByName('PARAM2').IsNull) and (DataSet.FieldByName('PARAM2').Value > -1) then
          LineSeries2.AddXY(TheDateTime, DataSet.FieldByName('PARAM2').Value , '', SeriesColour2);
        DataSet.Next;
      end;
      if not Chart2.AxisList[2].Visible then //turned off, as there were not enough field measurements
        Chart2.AxisList[2].Visible := LineSeries2.Count > 1; //turn back on, if more than 1 point
      if LineSeries2.Count < 2 then
        LineSeries2.Destroy;
      if Chart2.AxisList[2].Visible and (Chart2.AxisList[2].Title.Caption = 'Parameter2') then
      begin
        if Param2 = 'EC' then
          Chart2.AxisList[2].Title.Caption := 'EC [' + ECUnit + ']'
        else if Param2 = 'N_AMONIA' then
        begin
          if AsN then
            Chart2.AxisList[2].Title.Caption := 'NH4 as N [' + ChemUnit + ']'
          else Chart2.AxisList[2].Title.Caption := 'NH4 [' + ChemUnit + ']';
        end
        else if Param2 = 'N' then
        begin
          if AsN then
            Chart2.AxisList[2].Title.Caption := 'NO3 as N [' + ChemUnit + ']'
          else Chart2.AxisList[2].Title.Caption := 'N [' + ChemUnit + ']';
        end
        else if Param2 = 'PO4' then
        begin
          if AsN then
            Chart2.AxisList[2].Title.Caption := 'PO4 as P [' + ChemUnit + ']'
          else Chart2.AxisList[2].Title.Caption := 'PO4 [' + ChemUnit + ']';
        end
        else if Param2 = 'NO2' then
        begin
          if AsN then
            Chart2.AxisList[2].Title.Caption := 'NO2 as N [' + ChemUnit + ']'
          else Chart2.AxisList[2].Title.Caption := 'NO2 [' + ChemUnit + ']';
        end
        else
          Chart2.AxisList[2].Title.Caption := UpperCase(Param2) + ' [' + ChemUnit + ']';
      end;
    end;
    //general chart settings to produce bitmap
    if Chart2.SeriesCount > 0 then
    with Chart2 do
    begin
      Title.Text.Clear;
      Title.Text.Add('Chemistry over time at site ' + BasicinfQuerySITE_ID_NR.AsString + ' (' + BasicinfQueryNR_ON_MAP.AsString + ')' );
      Width := RLImageChem.Width * ResFactor;
      Height := RLImageChem.Height * ResFactor;
      RLImageChem.Picture.Bitmap.Assign(SaveToImage(TBitmap));
    end;
  end;
end;

procedure TSiteMonitoringReportForm.ChemQueryBeforeOpen(DataSet: TDataSet);
var
  ParamList: TStringList;
  i, ct1, ct2: Byte;
  c1, c2, Param1Str, Param2Str: ShortString;
begin
  //check in which table the params are
  ParamList := TStringList.Create;
  c1 := '';
  c2 := '';
  ct1 := 0;
  ct2 := 0;
  for i := 1 to 5 do
  begin
    with ZReadOnlyQuery1 do
    begin
      SQL.Clear;
      //get the fields
      SQL.Add('SELECT * FROM chem_00' + IntToStr(i) + ' WHERE 1 <> 1');
      Open;
      GetFieldNames(ParamList);
      Close;
      if ParamList.IndexOf(Param1) > -1 then //it was found
      begin
        c1 := 'c' + IntToStr(i);
        ct1 := i;
      end;
      if ParamList.IndexOf(Param2) > -1 then //it was found
      begin
        c2 := 'c' + IntToStr(i);
        ct2 := i;
      end;
    end;
  end;
  ParamList.Free;
  //if the parameters were not found then they must be field measurements or <none>
  if c1 = '' then
  begin
    ChemQueryPARAM1.Free;
    Param1Str := '';
  end
  else
    Param1Str := ', ' + c1 + '.' + Param1 + ' AS PARAM1';
  if c2 = '' then
  begin
    ChemQueryPARAM2.Free;
    Param2Str := '';
  end
  else
    Param2Str := ', ' + c2 + '.' + Param2 + ' AS PARAM2';
  with ChemQuery.SQL do
  begin
    Clear;
    Add('SELECT c0.SITE_ID_NR, c0.SAMPLE_NR, c0.METH_SAMPL, c0.DATE_SAMPL, c0.TIME_SAMPL, c0.DEPTH_SAMP, c0.COMMENT, c0.CHM_REF_NR' + Param1Str + Param2Str + ' FROM chem_000 c0');
    if c1 <> '' then
      Add('LEFT JOIN chem_00' + IntToStr(ct1) + ' ' + c1 + ' ON (c0.CHM_REF_NR = ' + c1 + '.CHM_REF_NR)')
    else
    if c2 <> '' then
      Add('LEFT JOIN chem_00' + IntToStr(ct2) + ' ' + c2 + ' ON (c0.CHM_REF_NR = ' + c2 + '.CHM_REF_NR)');
    if (c2 <> c1) and ((c1 <> '') and (c2 <> '')) then
      Add('LEFT JOIN chem_00' + IntToStr(ct2) + ' ' + c2 + ' ON (c0.CHM_REF_NR = ' + c2 + '.CHM_REF_NR)');
    Add('WHERE c0.SITE_ID_NR = ' + QuotedStr(ViewQuerySITE_ID_NR.Value));
    //set dates
    if ChemQuery.Connection.Tag = 1 then
    begin
      Add('AND c0.DATE_SAMPL || c0.TIME_SAMPL >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimeFrom)));
      Add('AND c0.DATE_SAMPL || c0.TIME_SAMPL <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimeTo)));
    end
    else
    begin
      Add('AND CONCAT(c0.DATE_SAMPL, c0.TIME_SAMPL) >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimeFrom)));
      Add('AND CONCAT(c0.DATE_SAMPL, c0.TIME_SAMPL) <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimeTo)));
    end;
    SaveToFile(WSpaceDir + '/chemsql.sql');
  end;
end;

procedure TSiteMonitoringReportForm.ChemQueryGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
var
  Limit: ShortString;
begin
  if Sender.IsNull or (Sender.Value = -1) then
    DisplayText := False
  else
  begin
    if QueryLimits.Locate('CPARAMETER', Sender.FieldName, []) then
      Limit := QueryLimitsLIMITS.AsString + ' '
    else
      Limit := '';
    if Sender.Tag <= 3 then //the mg/l
    begin
      if AsN then
      begin
        if Sender.Tag = 2 then
          aText := Limit + FormatTheFloat(Sender.Value * ParamFactor[1] * ChemFactor)
        else
        if Sender.Tag = 3 then
          aText := Limit + FormatTheFloat(Sender.Value * ParamFactor[3] * ChemFactor)
        else
          aText := Limit + FormatTheFloat(Sender.Value * ChemFactor)
      end
      else
      begin
        if Sender.Tag = 4 then
          aText := Limit + FormatTheFloat(Sender.Value * ParamFactor[0] * ChemFactor)
        else
        if Sender.Tag = 5 then
          aText := Limit + FormatTheFloat(Sender.Value * ParamFactor[2] * ChemFactor)
        else
          aText := Limit + FormatTheFloat(Sender.Value * ChemFactor)
      end;
    end
    else
    if Sender.Tag = 6 then
      aText := Limit + FormatTheFloat(Sender.Value * ECFactor)
    else //for all others (without units/dimensions)
    if Sender.FieldDef.DataType = ftFloat then
      aText := Limit + FormatTheFloat(Sender.Value)
    else
      aText := Limit + Sender.AsString;
    if DataModuleMain.ClassTable.Active then
    begin
      if DataModuleMain.ClassTable.Locate('PARAMETER', Sender.FieldName, []) then
        aText := aText + GetSymbol(Sender.AsFloat);
    end
    else
    begin
      if DataModuleMain.StandardTable.Locate('PARAMETER', Sender.FieldName, []) then
        aText := aText + GetSymbol(Sender.AsFloat);
    end;
  end;
end;

procedure TSiteMonitoringReportForm.CommentsQueryBeforeOpen(DataSet: TDataSet);
begin
  CommentsQuery.Params[0].Value := ViewQuerySITE_ID_NR.Value;
end;

procedure TSiteMonitoringReportForm.FldMeasQueryAfterOpen(DataSet: TDataSet);
var
  ThisParam1, ThisParam2: Char;
  LineSeries1, LineSeries2: TLineSeries;
  SeriesColour1, SeriesColour2: TColor;
  TheDateTime: TDateTime;
begin
  Chart2.ClearSeries; //because we have new site
  //map chemistry parameters to field measurement parameters
  Param1 := UpperCase(Param1);
  Param2 := UpperCase(Param2);
  if Param1 = 'EC' then ThisParam1 := 'C'
  else
  if Param1 = 'PH' then ThisParam1 := 'P'
  else
  if Param1 = 'DOX' then ThisParam1 := 'D'
  else
  if Param1 = 'TDS' then ThisParam1:= 'S'
  else
  if Param1 = 'TEMP' then ThisParam1 := 'T'
  else
  if Param1 = 'ORP' then ThisParam1 := 'O'
  else
  if Param1 = 'SAL' then ThisParam1 := 'L'
  else
    ThisParam1 := '0';
  if Param2 = 'EC' then ThisParam2 := 'C'
  else
  if Param2 = 'PH' then ThisParam2 := 'P'
  else
  if Param2 = 'DOX' then ThisParam2 := 'D'
  else
  if Param2 = 'TDS' then ThisParam2 := 'S'
  else
  if Param2 = 'TEMP' then ThisParam2 := 'T'
  else
  if Param2 = 'ORP' then ThisParam2 := 'O'
  else
  if Param2 = 'SAL' then ThisParam2 := 'L'
  else
    ThisParam2 := '0';
  //set the filter for the parameter
  DataSet.Filter := 'PARM_MEAS = ' + QuotedStr(ThisParam1);
  DataSet.Filtered := True;
  DataSet.First;
  if (DataSet.RecordCount > 1) and (ChemChtType IN [2,3]) then //field meas. only or field meas. and chemistry
  begin
    if ThisParam1 IN ['C', 'P', 'D', 'S', 'T', 'O', 'L'] THEN
    begin
      //create the series
      if RandomClrs then
        SeriesColour1 := Random(256*256*256)
      else
        SeriesColour1 := FldParam1Clr;
      //TheSeriesColour := clBlack;
      LineSeries1 := TLineSeries.Create(Chart2);
      with LineSeries1 do
      begin
        Title := 'Field ' + Param1;
        AxisIndexX := 1;
        AxisIndexY := 0;
        SeriesColor := SeriesColour1;
        if ShowChemPoints then
        begin
          Pointer.Brush.Color := SeriesColour1;
          Pointer.Style := TSeriesPointerStyle(Random(20));
          if Pointer.Style = psNone then
            Pointer.Style := psRectangle;
          Pointer.HorizSize := ResFactor * Pointer.HorizSize;
          Pointer.VertSize := ResFactor * Pointer.VertSize;
          ShowPoints := True;
        end;
        Marks.LabelFont := AppFont;
        Marks.LabelFont.Size := FontSize;
        LinePen.Style := TPenStyle(Random(5)); //start with 0 = solid
        LinePen.Width := ResFactor * LinePen.Width;
      end;
      Chart2.AddSeries(LineSeries1);
      while not DataSet.EOF do
      begin
        //convert date and time fields to DateTime
        TheDateTime := StringToDate(FldMeasQueryDATE_MEAS.Value) + StringToTime(FldMeasQueryTIME_MEAS.Value);
        //populate list with query values
        if not DataSet.FieldByName('READING').IsNull then
          LineSeries1.AddXY(TheDateTime, DataSet.FieldByName('READING').Value , '', SeriesColour1);
        DataSet.Next;
      end;
      if Param1 = 'EC' then
        Chart2.LeftAxis.Title.Caption := 'EC [' + ECUnit + ']'
      else if Param1 = 'N_AMONIA' then
      begin
        if AsN then
          Chart2.LeftAxis.Title.Caption := 'NH4 as N [' + ChemUnit + ']'
        else Chart2.LeftAxis.Title.Caption := 'NH4 [' + ChemUnit + ']';
      end
      else if Param1 = 'N' then
      begin
        if AsN then
          Chart2.LeftAxis.Title.Caption := 'NO3 as N [' + ChemUnit + ']'
        else Chart2.LeftAxis.Title.Caption := 'N [' + ChemUnit + ']';
      end
      else if Param1 = 'PO4' then
      begin
        if AsN then
          Chart2.LeftAxis.Title.Caption := 'PO4 as P [' + ChemUnit + ']'
        else Chart2.LeftAxis.Title.Caption := 'PO4 [' + ChemUnit + ']';
      end
      else if Param1 = 'NO2' then
      begin
        if AsN then
          Chart2.LeftAxis.Title.Caption := 'NO2 as N [' + ChemUnit + ']'
        else Chart2.LeftAxis.Title.Caption := 'NO2 [' + ChemUnit + ']';
      end
      else
        Chart2.LeftAxis.Title.Caption := UpperCase(Param1) + ' [' + ChemUnit + ']';
      DataSet.Filtered := False;
    end;
  end
  else
    Chart2.LeftAxis.Visible := False;
  //set the filter for the parameter
  DataSet.Filtered := False;
  DataSet.Filter := 'PARM_MEAS = ' + QuotedStr(ThisParam2);
  DataSet.Filtered := True;
  DataSet.First;
  if (DataSet.RecordCount > 1) and (ChemChtType IN [2,3]) then //field meas. only or field meas. and chemistry
  begin
    if ThisParam2 IN ['C', 'P', 'D', 'S', 'T', 'O', 'L'] THEN
    begin
      //create the series
      if RandomClrs then
        SeriesColour2 := Random(256*256*256)
      else
        SeriesColour2 := FldParam2Clr;
      //TheSeriesColour := clBlack;
      LineSeries2 := TLineSeries.Create(Chart2);
      with LineSeries2 do
      begin
        Title := 'Field ' + Param2;
        AxisIndexX := 1;
        AxisIndexY := 2;
        SeriesColor := SeriesColour2;
        if ShowChemPoints then
        begin
          Pointer.Brush.Color := SeriesColour2;
          Pointer.Style := TSeriesPointerStyle(Random(20));
          if Pointer.Style = psNone then
            Pointer.Style := psRectangle;
          Pointer.HorizSize := ResFactor * Pointer.HorizSize;
          Pointer.VertSize := ResFactor * Pointer.VertSize;
          ShowPoints := True;
        end;
        Marks.LabelFont := AppFont;
        Marks.LabelFont.Size := Marks.LabelFont.Size;
        LinePen.Style := TPenStyle(Random(5)); //start with 0 = solid
        LinePen.Width := ResFactor * LinePen.Width;
      end;
      Chart2.AddSeries(LineSeries2);
      while not DataSet.EOF do
      begin
        //convert date and time fields to DateTime
        TheDateTime := StringToDate(FldMeasQueryDATE_MEAS.Value) + StringToTime(FldMeasQueryTIME_MEAS.Value);
        //populate list with query values
        if not DataSet.FieldByName('READING').IsNull then
          LineSeries2.AddXY(TheDateTime, DataSet.FieldByName('READING').Value , '', SeriesColour2);
        DataSet.Next;
      end;
      Chart2.AxisList[2].Title.Caption := RLLabelParam2.Caption;
      if Param2 = 'EC' then
        Chart2.AxisList[2].Title.Caption := 'EC [' + ECUnit + ']'
      else if Param2 = 'N_AMONIA' then
      begin
        if AsN then
          Chart2.AxisList[2].Title.Caption := 'NH4 as N [' + ChemUnit + ']'
        else Chart2.AxisList[2].Title.Caption := 'NH4 [' + ChemUnit + ']';
      end
      else if Param2 = 'N' then
      begin
        if AsN then
          Chart2.AxisList[2].Title.Caption := 'NO3 as N [' + ChemUnit + ']'
        else Chart2.AxisList[2].Title.Caption := 'N [' + ChemUnit + ']';
      end
      else if Param2 = 'PO4' then
      begin
        if AsN then
          Chart2.AxisList[2].Title.Caption := 'PO4 as P [' + ChemUnit + ']'
        else Chart2.AxisList[2].Title.Caption := 'PO4 [' + ChemUnit + ']';
      end
      else if Param2 = 'NO2' then
      begin
        if AsN then
          Chart2.AxisList[2].Title.Caption := 'NO2 as N [' + ChemUnit + ']'
        else Chart2.AxisList[2].Title.Caption := 'NO2 [' + ChemUnit + ']';
      end
      else
        Chart2.AxisList[2].Title.Caption := UpperCase(Param2) + ' [' + ChemUnit + ']';
      DataSet.Filtered := False;
    end;
  end
  else
    Chart2.AxisList[2].Visible := False;
  DataSet.Filtered := False;
  //general chart settings to produce bitmap
  if Chart2.SeriesCount > 0 then
  with Chart2 do
  begin
    Title.Text.Clear;
    Title.Text.Add('Chemistry over time at site ' + BasicinfQuerySITE_ID_NR.AsString + ' (' + BasicinfQueryNR_ON_MAP.AsString + ')' );
    Width := RLImageChem.Width * ResFactor;
    Height := RLImageChem.Height * ResFactor;
    RLImageChem.Picture.Bitmap.Assign(SaveToImage(TBitmap));
  end;
end;

procedure TSiteMonitoringReportForm.FldMeasQueryBeforeOpen(DataSet: TDataSet);
begin
  with FldMeasQuery.SQL do
  begin
    Clear;
    Add('SELECT * FROM fldmeas_ WHERE site_id_nr = ' + QuotedStr(ViewQuerySITE_ID_NR.Value));
    //set dates
    if FldMeasQuery.Connection.Tag = 1 then
    begin
      Add('AND DATE_MEAS || TIME_MEAS >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimeFrom)));
      Add('AND DATE_MEAS || TIME_MEAS <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimeTo)));
    end
    else
    begin
      Add('AND CONCAT(DATE_MEAS, TIME_MEAS) >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimeFrom)));
      Add('AND CONCAT(DATE_MEAS, TIME_MEAS) <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimeTo)));
    end;
  end;
end;

procedure TSiteMonitoringReportForm.DEPTHGetText(
  Sender: TField; var aText: string; DisplayText: Boolean);
begin
  if not Sender.IsNull then
  begin
    if Abs(Sender.AsFloat * LengthFactor) > 1000 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 1)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end
  else
    DisplayText := False;
end;

procedure TSiteMonitoringReportForm.FldMeasQueryREADINGGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
var
  TheFactor: Real;
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if FldMeasQueryPARM_MEAS.Value = 'C' then
        TheFactor := ECFactor
    else
    if (FldMeasQueryPARM_MEAS.Value = 'P') or (FldMeasQueryPARM_MEAS.Value = 'T') then
      TheFactor := 1
    else
      TheFactor := ChemFactor;
    if Abs(Sender.Value * TheFactor) < 0.001 then
      aText := FloatToStrF(Sender.AsFloat * TheFactor, ffFixed, 15, 5)
    else
    if Abs(Sender.Value * TheFactor) < 0.1 then
      aText := FloatToStrF(Sender.AsFloat * TheFactor, ffFixed, 15, 3)
    else
    if Abs(Sender.Value * TheFactor) < 100 then
      aText := FloatToStrF(Sender.AsFloat * TheFactor, ffFixed, 15, 2)
    else
    if Abs(Sender.Value * TheFactor) < 1000 then
      aText := FloatToStrF(Sender.AsFloat * TheFactor, ffFixed, 15, 1)
    else
      aText := FloatToStrF(Sender.AsFloat * TheFactor, ffFixed, 15, 0);
  end;
end;

procedure TSiteMonitoringReportForm.FldMeasRLBand1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  PrintIt := (RLDBTextParam1.DataSet.FieldByName('PARAM1').Value > -1) or (RLDBTextParam2.DataSet.FieldByName('PARAM2').Value > -1);
end;

procedure TSiteMonitoringReportForm.FormCreate(Sender: TObject);
begin
  inherited;
  FontSize := ResFactor * 7;
  FormatChart(Chart1);
  FormatChart(Chart2);
end;

procedure TSiteMonitoringReportForm.InstallaQueryBeforeOpen(DataSet: TDataSet);
begin
  InstallaQuery.Params[0].Value := ViewQuerySITE_ID_NR.Value;
end;

procedure TSiteMonitoringReportForm.OwnerQueryADDRESS_4GetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := false
  else
  if Pos('@', Sender.Value) > 0 then //it is an email address
    aText := LowerCase(Sender.AsString)
  else
    aText := Sender.AsString;
end;

procedure TSiteMonitoringReportForm.OwnerQueryBeforeOpen(DataSet: TDataSet);
begin
  OwnerQuery.Params[0].Value := ViewQuerySITE_ID_NR.Value;
end;

procedure TSiteMonitoringReportForm.OwnerQueryDATE_FROMGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := DateToStr(StringToDate(Sender.AsString));
end;

procedure TSiteMonitoringReportForm.DATEGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  if StringToDate(Sender.AsString) > Now then
    aText := DateToStr(Now)
  else
    aText := DateToStr(StringToDate(Sender.AsString));
end;

procedure TSiteMonitoringReportForm.RLBand1AfterPrint(Sender: TObject);
begin
  RLImage1.Picture.Clear;
end;

procedure TSiteMonitoringReportForm.RLSubDetailChartsAfterPrint(Sender: TObject);
begin
  RLImageWL.Picture.Clear;
  RLImageChem.Picture.Clear;
  if SwopCharts then
  begin
    RLImageWL.Left := RLBandCharts.Width - RLImageWL.Width - 2;
    RLImageChem.Left := 2;
  end
  else
  begin
    RLImageWL.Left := 2;
    RLImageChem.Left := RLBandCharts.Width - RLImageChem.Width - 2;
  end;
end;

procedure TSiteMonitoringReportForm.RLSubDetailChartsBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
begin
  PrintIt := (not RLImageWL.Picture.BitMap.Empty) or (not RLImageChem.Picture.BitMap.Empty);
  if PrintIt then
  begin
    if RLImageChem.Picture.BitMap.Empty and not RLImageWL.Picture.BitMap.Empty then
    begin
      if SwopCharts then
        RLImageWL.Left := RLImageWL.Left - Round(RLImageWL.Width / 2)
      else
        RLImageWL.Left := RLImageWL.Left + Round(RLImageWL.Width / 2);
    end
    else
    if RLImageWL.Picture.BitMap.Empty and not RLImageChem.Picture.BitMap.Empty then
    begin
      if SwopCharts then
        RLImageChem.Left := RLImageChem.Left + Round(RLImageChem.Width / 2)
      else
        RLImageChem.Left := RLImageChem.Left - Round(RLImageChem.Width / 2);
    end;
  end;
end;

end.

