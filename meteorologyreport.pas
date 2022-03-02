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
unit meteorologyreport;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, RLReport, ZDataset,
  reporttemplate, db;

type

  { TMeteorologyReportForm }

  TMeteorologyReportForm = class(TReportTemplateForm)
    windvdir: TZReadOnlyQuery;
    solaradiREADING: TFloatField;
    windvdirREADING: TFloatField;
    solaradiREP_INST: TStringField;
    windvdirREP_INST: TStringField;
    pressure: TZReadOnlyQuery;
    pressureREADING: TFloatField;
    pressureREP_INST: TStringField;
    humidityINFO_SOURC: TStringField;
    humidityREADING: TFloatField;
    pan_evapREADING: TFloatField;
    pan_evapREP_INST: TStringField;
    pan_evapTIME_MEAS: TStringField;
    solaradi: TZReadOnlyQuery;
    SolarDataSource: TDataSource;
    rainfallREADING: TFloatField;
    rainfallREP_INST: TStringField;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLBand4: TRLBand;
    RLBand5: TRLBand;
    RLBand6: TRLBand;
    RLBand7: TRLBand;
    RLDBText131: TRLDBText;
    RLDBText132: TRLDBText;
    RLDBText133: TRLDBText;
    RLDBText134: TRLDBText;
    RLDBText135: TRLDBText;
    RLDBText136: TRLDBText;
    RLDBText137: TRLDBText;
    RLDBText138: TRLDBText;
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
    RLDBText67: TRLDBText;
    RLDBText68: TRLDBText;
    RLDBText69: TRLDBText;
    RLDBText70: TRLDBText;
    RLDBText80: TRLDBText;
    RLDBText81: TRLDBText;
    RLDBText82: TRLDBText;
    RLDBText83: TRLDBText;
    RLDBText84: TRLDBText;
    RLDBText85: TRLDBText;
    RLDBText86: TRLDBText;
    RLDBText87: TRLDBText;
    RLDBText88: TRLDBText;
    RLDBText89: TRLDBText;
    RLDBText90: TRLDBText;
    RLDBText91: TRLDBText;
    RLLabel197: TRLLabel;
    RLLabel199: TRLLabel;
    RLLabel200: TRLLabel;
    RLLabel201: TRLLabel;
    RLLabel202: TRLLabel;
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
    RLLabel220: TRLLabel;
    RLLabel79: TRLLabel;
    RLLabel80: TRLLabel;
    RLLabel81: TRLLabel;
    RLLabel82: TRLLabel;
    RLLabel83: TRLLabel;
    RLLabel85: TRLLabel;
    RLLabel86: TRLLabel;
    RLLabel87: TRLLabel;
    RLLabelDir: TRLLabel;
    RLLabel93: TRLLabel;
    RLLabel94: TRLLabel;
    RLLabel95: TRLLabel;
    RLLabel96: TRLLabel;
    RLLabel97: TRLLabel;
    RLLabel98: TRLLabel;
    RLLabelRad: TRLLabel;
    RLLabelPres: TRLLabel;
    RLLabelRain: TRLLabel;
    RLLabel209: TRLLabel;
    RLLabel84: TRLLabel;
    RLLabel92: TRLLabel;
    RLLabelTemp: TRLLabel;
    RLLabelHum: TRLLabel;
    RLLabelEvap: TRLLabel;
    RainfallDataSource: TDataSource;
    PanEvapDataSource: TDataSource;
    RLLabelSpeed: TRLLabel;
    air_tempDATE_MEAS: TStringField;
    pressureDATE_MEAS: TStringField;
    solaradiDATE_MEAS: TStringField;
    windvdirDATE_MEAS: TStringField;
    air_tempINFO_SOURC: TStringField;
    pressureINFO_SOURC: TStringField;
    solaradiINFO_SOURC: TStringField;
    windvdirINFO_SOURC: TStringField;
    StageHeightQuerySITE_ID_NR3: TStringField;
    pressureSITE_ID_NR: TStringField;
    solaradiSITE_ID_NR: TStringField;
    windvdirSITE_ID_NR: TStringField;
    air_tempTIME_MEAS: TStringField;
    HumidityDataSource: TDataSource;
    rainfall: TZReadOnlyQuery;
    pan_evap: TZReadOnlyQuery;
    pressureTIME_MEAS: TStringField;
    solaradiTIME_MEAS: TStringField;
    windvdirTIME_MEAS: TStringField;
    SubDetail5: TRLSubDetail;
    SubDetail6: TRLSubDetail;
    SubDetail7: TRLSubDetail;
    SubHeaderBand4: TRLBand;
    SubHeaderBand5: TRLBand;
    SubHeaderBand6: TRLBand;
    TempDataSource: TDataSource;
    humidity: TZReadOnlyQuery;
    rainfallDATE_MEAS: TStringField;
    pan_evapDATE_MEAS: TStringField;
    humidityDATE_MEAS: TStringField;
    rainfallINFO_SOURC: TStringField;
    pan_evapINFO_SOURC: TStringField;
    rainfallSITE_ID_NR: TStringField;
    pan_evapSITE_ID_NR: TStringField;
    humiditySITE_ID_NR: TStringField;
    rainfallTIME_MEAS: TStringField;
    humidityTIME_MEAS: TStringField;
    air_temp: TZReadOnlyQuery;
    humidityREP_INST: TStringField;
    SubDetail4: TRLSubDetail;
    SubDetail3: TRLSubDetail;
    SubDetail2: TRLSubDetail;
    SubHeaderBand1: TRLBand;
    SubHeaderBand2: TRLBand;
    SubHeaderBand3: TRLBand;
    air_tempREADING: TFloatField;
    air_tempREAD_TYPE: TStringField;
    air_tempREP_INST: TStringField;
    PressureDataSource: TDataSource;
    WindDataSource: TDataSource;
    windvdirDIRECTION: TFloatField;
    procedure BasicinfQueryAfterOpen(DataSet: TDataSet);
    procedure DateGetText(Sender: TField; var aText: string; DisplayText: Boolean);
    procedure pressureREADINGGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure RainEvapQueryREADINGGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure QueryBeforeOpen(DataSet: TDataSet);
    procedure TheReportAfterPrint(Sender: TObject);
    procedure TimeGetText(Sender: TField; var aText: string; DisplayText: Boolean);
    procedure TheReportBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure ViewDataSourceDataChange(Sender: TObject; Field: TField);
    procedure windvdirREADINGGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
  private

  public
    StartDateTime, EndDateTime: TDateTime;
    CommentMemoFromBasic: Boolean;
  end;

var
  MeteorologyReportForm: TMeteorologyReportForm;

implementation

{$R *.lfm}

uses VARINIT, strdatetime;

{ TMeteorologyReportForm }

procedure TMeteorologyReportForm.TheReportAfterPrint(Sender: TObject);
begin
  rainfall.Close;
  pan_evap.Close;
  humidity.Close;
  air_temp.Close;
end;

procedure TMeteorologyReportForm.TimeGetText(
  Sender: TField; var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := FormatDateTime('hh:nn', EncodeTime(StrToInt(Copy(Sender.AsString, 1, 2)), StrToInt(Copy(Sender.AsString, 3, 2)), 0, 0));
end;

procedure TMeteorologyReportForm.DateGetText(
  Sender: TField; var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    aText := DateToStr(StringToDate(Sender.AsString));
  end;
end;

procedure TMeteorologyReportForm.BasicinfQueryAfterOpen(DataSet: TDataSet);
begin
  SiteID := BasicinfQuerySITE_ID_NR.Value;
end;

procedure TMeteorologyReportForm.pressureREADINGGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then
    DisplayText := False
  else
    aText := FloatToStrF(Sender.AsFloat * PressureFactor, ffGeneral, 15, 2);
end;

procedure TMeteorologyReportForm.RainEvapQueryREADINGGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then
    DisplayText := False
  else
    aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffGeneral, 15, 2);
end;

procedure TMeteorologyReportForm.QueryBeforeOpen(DataSet: TDataSet);
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

procedure TMeteorologyReportForm.TheReportBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  RLLabelRain.Caption := RLLabelRain.Caption + ' [' + DiamUnit + ']';
  RLLabelEvap.Caption := RLLabelEvap.Caption + ' [' + DiamUnit + ']';
  RLLabelPres.Caption := RLLabelPres.Caption + ' [' + PressureUnit + ']';
  RLLabelSpeed.Caption := RLLabelSpeed.Caption + ' [' + LengthUnit+ '/' + TimeUnit + ']';
end;

procedure TMeteorologyReportForm.ViewDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if (Field = NIL) and NewSite then
  begin
    if CommentMemoFromBasic then
    begin
      RLCommentMemo.Lines.Clear;
      RLCommentMemo.Lines.Add('NOTES:');
      RLCommentMemo.Lines.Add(BasicinfQuery.FieldByname('NOTE_PAD').Value);
    end;
    rainfall.Close;
    rainfall.Active := SubDetail1.Visible;
    pan_evap.Close;
    pan_evap.Active := SubDetail2.Visible;
    humidity.Close;
    humidity.Active := SubDetail3.Visible;
    air_temp.Close;
    air_temp.Active := SubDetail4.Visible;
    pressure.Close;
    pressure.Active := SubDetail6.Visible;
    solaradi.Close;
    solaradi.Active := SubDetail5.Visible;
    windvdir.Close;
    windvdir.Active := SubDetail7.Visible;
  end;
end;

procedure TMeteorologyReportForm.windvdirREADINGGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then
    DisplayText := False
  else
    aText := FloatToStrF(Sender.AsFloat * LengthFactor * TimeFactor, ffFixed, 15, 2);
end;

end.

