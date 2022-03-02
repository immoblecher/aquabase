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
unit surfacewaterreport;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, RLReport, ZDataset,
  reporttemplate, db;

type

  { TSurfaceWaterReportForm }

  TSurfaceWaterReportForm = class(TReportTemplateForm)
    flow_disDIS_FLOW: TFloatField;
    intake__INTAK_FLOW: TFloatField;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLBand4: TRLBand;
    RLDBText131: TRLDBText;
    RLDBText132: TRLDBText;
    RLDBText133: TRLDBText;
    RLDBText134: TRLDBText;
    RLDBText135: TRLDBText;
    RLDBText136: TRLDBText;
    RLDBText137: TRLDBText;
    RLDBText138: TRLDBText;
    RLDBText141: TRLDBText;
    RLDBText142: TRLDBText;
    RLDBText143: TRLDBText;
    RLDBText144: TRLDBText;
    RLDBText67: TRLDBText;
    RLDBText68: TRLDBText;
    RLDBText69: TRLDBText;
    RLDBText70: TRLDBText;
    RLDBText80: TRLDBText;
    RLDBText81: TRLDBText;
    RLDBText82: TRLDBText;
    RLDBText83: TRLDBText;
    RLLabel197: TRLLabel;
    RLLabel198: TRLLabel;
    RLLabel199: TRLLabel;
    RLLabel200: TRLLabel;
    RLLabel210: TRLLabel;
    RLLabel211: TRLLabel;
    RLLabel212: TRLLabel;
    RLLabel79: TRLLabel;
    RLLabel80: TRLLabel;
    RLLabel81: TRLLabel;
    RLLabel85: TRLLabel;
    RLLabel86: TRLLabel;
    RLLabel87: TRLLabel;
    RLLabel93: TRLLabel;
    RLLabel94: TRLLabel;
    RLLabel95: TRLLabel;
    RLLabelStageHi: TRLLabel;
    RLLabel209: TRLLabel;
    RLLabel84: TRLLabel;
    RLLabel92: TRLLabel;
    RLLabelIntake: TRLLabel;
    RLLabelFlowVelo: TRLLabel;
    RLLabelFlowDis: TRLLabel;
    StageHeightDataSource: TDataSource;
    FlowDisDataSource: TDataSource;
    StageHeightQueryCOMMENTS3: TStringField;
    StageHeightQueryDATE_MEAS3: TStringField;
    StageHeightQueryID3: TLargeintField;
    StageHeightQueryINFO_SOURC3: TStringField;
    StageHeightQuerySITE_ID_NR3: TStringField;
    StageHeightQueryTIME_MEAS3: TStringField;
    StrmVeloDataSource: TDataSource;
    stage_hi: TZReadOnlyQuery;
    flow_dis: TZReadOnlyQuery;
    IntakeDataSource: TDataSource;
    strmvelo: TZReadOnlyQuery;
    stage_hiCOMMENTS: TStringField;
    StageHeightQueryCOMMENTS1: TStringField;
    stage_hiDATE_MEAS: TStringField;
    StageHeightQueryDATE_MEAS1: TStringField;
    StageHeightQueryDATE_MEAS2: TStringField;
    stage_hiID: TLargeintField;
    StageHeightQueryID1: TLargeintField;
    StageHeightQueryID2: TLargeintField;
    stage_hiINFO_SOURC: TStringField;
    StageHeightQueryINFO_SOURC1: TStringField;
    stage_hiSITE_ID_NR: TStringField;
    StageHeightQuerySITE_ID_NR1: TStringField;
    StageHeightQuerySITE_ID_NR2: TStringField;
    stage_hiSTAGE_HIGH: TFloatField;
    stage_hiTIME_MEAS: TStringField;
    StageHeightQueryTIME_MEAS1: TStringField;
    StageHeightQueryTIME_MEAS2: TStringField;
    intake__: TZReadOnlyQuery;
    strmveloCOMMENT: TStringField;
    strmveloREADING: TFloatField;
    strmveloREP_INST: TStringField;
    SubDetail4: TRLSubDetail;
    SubDetail3: TRLSubDetail;
    SubDetail2: TRLSubDetail;
    SubHeaderBand1: TRLBand;
    SubHeaderBand2: TRLBand;
    SubHeaderBand3: TRLBand;
    procedure BasicinfQueryAfterOpen(DataSet: TDataSet);
    procedure DateGetText(Sender: TField;
      var aText: string; DisplayText: Boolean);
    procedure flow_disDIS_FLOWGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure intake__INTAK_FLOWGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure QueryBeforeOpen(DataSet: TDataSet);
    procedure stage_hiSTAGE_HIGHGetText(Sender: TField;
      var aText: string; DisplayText: Boolean);
    procedure strmveloREADINGGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure TheReportAfterPrint(Sender: TObject);
    procedure TimeGetText(Sender: TField;
      var aText: string; DisplayText: Boolean);
    procedure TheReportBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure ViewDataSourceDataChange(Sender: TObject; Field: TField);
  private
    amsl: Boolean;
  public
    StartDateTime, EndDateTime: TDateTime;
    CommentMemoFromBasic: Boolean;
  end;

var
  SurfaceWaterReportForm: TSurfaceWaterReportForm;

implementation

{$R *.lfm}

uses VARINIT, strdatetime;

{ TSurfaceWaterReportForm }

procedure TSurfaceWaterReportForm.stage_hiSTAGE_HIGHGetText(
  Sender: TField; var aText: string; DisplayText: Boolean);
var
  Elevation: Double;
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if amsl then
      Elevation := BasicinfQueryALTITUDE.Value + BasicinfQueryCOLLAR_HI.Value
    else
      Elevation := 2 * Sender.AsFloat;
    aText := FloatToStrF((Elevation - Sender.AsFloat) * LengthFactor, ffFixed, 15, 3);
  end
end;

procedure TSurfaceWaterReportForm.strmveloREADINGGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := FloatToStrF(Sender.AsFloat * LengthFactor * TimeFactor, ffFixed, 15, 2);
end;

procedure TSurfaceWaterReportForm.TheReportAfterPrint(Sender: TObject);
begin
  stage_hi.Close;
  flow_dis.Close;
  strmvelo.Close;
  intake__.Close;
end;

procedure TSurfaceWaterReportForm.TimeGetText(
  Sender: TField; var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := FormatDateTime('hh:nn', EncodeTime(StrToInt(Copy(Sender.AsString, 1, 2)), StrToInt(Copy(Sender.AsString, 3, 2)), 0, 0));
end;

procedure TSurfaceWaterReportForm.DateGetText(
  Sender: TField; var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    aText := DateToStr(StringToDate(Sender.AsString));
  end;
end;

procedure TSurfaceWaterReportForm.BasicinfQueryAfterOpen(DataSet: TDataSet);
begin
  SiteID := BasicinfQuerySITE_ID_NR.Value;
end;

procedure TSurfaceWaterReportForm.flow_disDIS_FLOWGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if Sender.Value * VolumeFactor * TimeFactor > 100000 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 0)
    else
    if Sender.Value * VolumeFactor * TimeFactor = 0 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 2)
    else
    if Sender.Value * VolumeFactor * TimeFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 2);
  end;
end;

procedure TSurfaceWaterReportForm.intake__INTAK_FLOWGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if Sender.Value * VolumeFactor * TimeFactor > 100000 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 0)
    else
    if Sender.Value * VolumeFactor * TimeFactor = 0 then
      Text := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 2)
    else
    if Sender.Value * VolumeFactor * TimeFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 2);
    end;
end;

procedure TSurfaceWaterReportForm.QueryBeforeOpen(DataSet: TDataSet);
begin
  with DataSet as TZReadOnlyQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM ' + Name);
    SQL.Add('WHERE site_id_nr = ' + QuotedStr(ViewQuery.FieldByname('site_id_nr').Value));
    if Connection.Tag = 1 then
    begin
      SQL.Add('AND DATE_MEAS || TIME_MEAS >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', StartDateTime)));
      SQL.Add('AND DATE_MEAS || TIME_MEAS <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', EndDateTime)));
    end
    else
    begin
      SQL.Add('AND CONCAT(DATE_MEAS, TIME_MEAS) >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', StartDateTime)));
      SQL.Add('AND CONCAT(DATE_MEAS, TIME_MEAS) <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', EndDateTime)));
    end;
  end;
end;

procedure TSurfaceWaterReportForm.TheReportBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  RLLabelStageHi.Caption := RLLabelStageHi.Caption + ' [' + LengthUnit + ']';
  RLLabelFlowDis.Caption := RLLabelFlowDis.Caption + ' [' + DisUnit + ']';
  RLLabelFlowVelo.Caption := RLLabelFlowVelo.Caption + ' [' + LengthUnit + '/' + TimeUnit + ']';
  RLLabelIntake.Caption := RLLabelIntake.Caption + ' [' + DisUnit + ']';
end;

procedure TSurfaceWaterReportForm.ViewDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if (Field = NIL) and NewSite then
  begin
    if CommentMemoFromBasic then
    begin
      RLCommentMemo.Lines.Clear;
      RLCommentMemo.Lines.Add('NOTES:');
      RLCommentMemo.Lines.Add(BasicinfQuery.FieldByName('NOTE_PAD').Value);
    end;
    stage_hi.Close;
    stage_hi.Active := SubDetail1.Visible;
    flow_dis.Close;
    flow_dis.Active := SubDetail2.Visible;
    strmvelo.Close;
    strmvelo.Active := SubDetail3.Visible;
    intake__.Close;
    intake__.Active := SubDetail4.Visible;
  end;
end;

end.

