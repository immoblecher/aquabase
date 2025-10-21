{ Copyright (C) 2025 Immo Blecher immo@blecher.co.za

  This source is free software; you can redistribute it and/or modify it under
  the terms of the GNU General Public License as published by the Free
  Software Foundation; either version 2 of the License, or (at your option)
  any later version.

  This code is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

  A copy of the GNU General Public License is available on the World Wide Web
  at http://www.gnu.org/copyleft/gpl.html. You can also obtain it by writing
  to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
  MA 02111-1307, USA.
}
unit Stream;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLtype, TabDetl,
  Menus, Db, DBCtrls, Buttons, ExtCtrls, DBGrids, StdCtrls, MaskEdit, ComCtrls;

type

  { TStreamForm }

  TStreamForm = class(TTabbedMastDetailForm)
    ChartSpeedButton: TSpeedButton;
    ZQuery1COMMENTS: TStringField;
    ZQuery1DATE_MEAS: TStringField;
    ZQuery1DIS_FLOW: TFloatField;
    ZQuery1INFO_SOURC: TStringField;
    ZQuery1SITE_ID_NR: TStringField;
    ZQuery1TIME_MEAS: TStringField;
    ZQuery2COMMENT: TStringField;
    ZQuery2DATE_MEAS: TStringField;
    ZQuery2READING: TFloatField;
    ZQuery2REP_INST: TStringField;
    ZQuery2SITE_ID_NR: TStringField;
    ZQuery2TIME_MEAS: TStringField;
    ZQuery3COMMENTS: TStringField;
    ZQuery3DATE_MEAS: TStringField;
    ZQuery3INFO_SOURC: TStringField;
    ZQuery3INTAK_FLOW: TFloatField;
    ZQuery3SITE_ID_NR: TStringField;
    ZQuery3TIME_MEAS: TStringField;
    procedure BasicinfDataSourceDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure QueryCOMMENTSSetText(Sender: TField; const aText: string);
    procedure ZQuerysAfterPost(DataSet: TDataSet);
    procedure ZQueryAfterRefresh(DataSet: TDataSet);
    procedure ZQueryAfterDelete(DataSet: TDataSet);
    procedure ZQueryBeforeInsert(DataSet: TDataSet);
    procedure ZQuery2REP_INSTValidate(Sender: TField);
    procedure QueryUpperSetText(Sender: TField; const aText: string);
    procedure TableINFO_SOURCValidate(Sender: TField);
    procedure TableDATEValidate(Sender: TField);
    procedure TableTIMEValidate(Sender: TField);
    procedure ZQuery1DIS_FLOWGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure ZQuery1DIS_FLOWSetText(Sender: TField; const aText: String);
    procedure ChartSpeedButtonClick(Sender: TObject);
    procedure ZQuery2BeforeInsert(DataSet: TDataSet);
    procedure ZQuery2READINGGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure ZQuery2READINGSetText(Sender: TField; const aText: String);
    procedure PageControlChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ZQuery3INTAK_FLOWGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure ZQuery3INTAK_FLOWSetText(Sender: TField; const aText: String);
    procedure ZQueryNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StreamForm: TStreamForm;

implementation

uses Strdatetime, Varinit, Timedept, MainDataModule;

{$R *.lfm}

var
  PrevDate, PrevInfoSource, PrevRepInst: ShortString;

procedure TStreamForm.ZQueryBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  if DataSet.FieldByName('DATE_MEAS').IsNull then
    PrevDate := FormatDateTime('YYYYMMDD', Date)
  else
    PrevDate := DataSet.FieldByName('DATE_MEAS').Value;
  if DataSet.FieldByName('INFO_SOURC').IsNull then
    PrevInfoSource := ''
  else
    PrevInfoSource := DataSet.FieldByName('INFO_SOURC').Value;
end;

procedure TStreamForm.BasicinfDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if not (DataModuleMain.BasicinfQuery.State IN [dsInsert, dsEdit]) then
  begin
    if not DataModuleMain.BasicinfQuerySITE_TYPE.IsNULL then
      PageControl.Enabled := (DataModuleMain.BasicinfQuerySITE_TYPE.AsString[1] IN ['R', 'C', 'G']);
    if PageControl.Enabled = True then
    begin
      LinkedLabel.Enabled := True;
      DetailNavigator.Enabled := True;
    end
    else if Showing then
      MessageDlg('This site type does not seem to allow stream discharge/flow readings!', mtWarning, [mbOK], 0);
  end;
end;

procedure TStreamForm.FormCreate(Sender: TObject);
begin
  inherited;
  if not DataModuleMain.BasicinfQuerySITE_TYPE.IsNULL then
    PageControl.Enabled := (DataModuleMain.BasicinfQuerySITE_TYPE.AsString[1] IN ['R', 'C', 'G']);
  if PageControl.Enabled = True then
  begin
    LinkedLabel.Enabled := True;
    DetailNavigator.Enabled := True;
  end
  else
    MessageDlg('This site type does not seem to allow stream discharge/flow readings!', mtWarning, [mbOK], 0);
end;

procedure TStreamForm.QueryCOMMENTSSetText(Sender: TField; const aText: string
  );
begin
  if AllowSmallChars then
    Sender.Value := aText
  else
    Sender.Value := UpperCase(aText);
end;

procedure TStreamForm.ZQuerysAfterPost(DataSet: TDataSet);
begin
  inherited;
  ChartSpeedButton.Enabled := DataSet.RecordCount > 0;
end;

procedure TStreamForm.ZQueryAfterRefresh(DataSet: TDataSet);
begin
  ChartSpeedButton.Enabled := DataSet.RecordCount > 0;
end;

procedure TStreamForm.ZQueryAfterDelete(DataSet: TDataSet);
begin
  ChartSpeedButton.Enabled := DataSet.RecordCount > 0;
end;

procedure TStreamForm.ZQuery2REP_INSTValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('REP_INST', Sender.AsString);
end;

procedure TStreamForm.QueryUpperSetText(Sender: TField;
  const aText: string);
begin
  Sender.AsString := UpperCase(aText);
end;

procedure TStreamForm.TableINFO_SOURCValidate(Sender: TField);
begin
  inherited;
  ValidFound := DataModuleMain.LookupValidFound('IS_SURHY', Sender.AsString);
end;

procedure TStreamForm.TableDATEValidate(Sender: TField);
begin
  inherited;
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TStreamForm.TableTIMEValidate(Sender: TField);
begin
  inherited;
  ValidFound := not Sender.IsNull and ValidTime(Sender.Value);
end;

procedure TStreamForm.ZQuery1DIS_FLOWGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  inherited;
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

procedure TStreamForm.ZQuery1DIS_FLOWSetText(Sender: TField;
  const aText: String);
begin
  inherited;
  if aText <> '' then
    ZQuery1DIS_FLOW.Value := StrToFloat(aText)/VolumeFactor/TimeFactor;
end;

procedure TStreamForm.ChartSpeedButtonClick(Sender: TObject);
begin
  inherited;
  with TTimeDeptForm.Create(Application) do
  begin
    YComboBox1.Items.Clear;
    case PageControl.ActivePage.TabIndex of
      0: begin
           TimeDeptTable[1] := 'FLOW_DIS';
           StartDate := StringToDate(ZQuery1DATE_MEAS.AsString);
           StartTime := StringToTime(ZQuery1TIME_MEAS.AsString);
         end;
      1: begin
           TimeDeptTable[1] := 'STRMVELO';
           StartDate := StringToDate(ZQuery2DATE_MEAS.AsString);
           StartTime := StringToTime(ZQuery2TIME_MEAS.AsString);
         end;
      2: begin
           TimeDeptTable[1] := 'INTAKE__';
           StartDate := StringToDate(ZQuery3DATE_MEAS.AsString);
           StartTime := StringToTime(ZQuery3TIME_MEAS.AsString);
         end;
    end; //of case
    ShowModal;
  end;
end;

procedure TStreamForm.ZQuery2BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  if DataSet.FieldByName('DATE_MEAS').IsNull then
    PrevDate := FormatDateTime('YYYYMMDD', Date)
  else
    PrevDate := DataSet.FieldByName('DATE_MEAS').Value;
  if ZQuery2REP_INST.IsNull then
    PrevRepInst := ''
  else
    PrevRepInst := ZQuery2REP_INST.Value;
end;

procedure TStreamForm.ZQuery2READINGGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then
    DisplayText := False
  else
    aText := FloatToStrF(Sender.AsFloat * LengthFactor * TimeFactor, ffFixed, 15, 2);
end;

procedure TStreamForm.ZQuery2READINGSetText(Sender: TField;
  const aText: String);
begin
  inherited;
  ZQuery2READING.Value := StrToFloat(aText) * LengthFactor / TimeFactor;
end;

procedure TStreamForm.PageControlChange(Sender: TObject);
begin
  inherited;
  ChartSpeedButton.Hint := 'Time dependent chart of ' + PageControl.ActivePage.Hint;
end;

procedure TStreamForm.FormActivate(Sender: TObject);
begin
  inherited;
  TabSheet1.Caption := 'Discharge rate [' + DisUnit + ']';
  TabSheet2.Caption := 'Flow velocity [' + LengthUnit + '/' + TimeUnit + ']';
  Tabsheet3.Caption := 'Intake rate [' + DisUnit + ']';
  case PageControl.ActivePage.TabIndex of
    0: begin
        ChartSpeedButton.Enabled := ZQuery1.RecordCount > 0;
       end;
    1: begin
        ChartSpeedButton.Enabled := ZQuery2.RecordCount > 0;
       end;
    2: begin
        ChartSpeedButton.Enabled := ZQuery3.RecordCount > 0;
       end;
  end; //of case
end;

procedure TStreamForm.ZQuery3INTAK_FLOWGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  inherited;
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

procedure TStreamForm.ZQuery3INTAK_FLOWSetText(Sender: TField;
  const aText: String);
begin
  inherited;
  if Text <> '' then
    Sender.Value := StrToFloat(aText)/VolumeFactor/TimeFactor;
end;

procedure TStreamForm.ZQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  if DataSet.FindField('INFO_SOURC') <> NIL then
    DataSet.FieldByName('INFO_SOURC').Value := PrevInfoSource;
  if DataSet.FindField('REP_INST') <> NIL then
  begin
    if (PrevRepInst = '') then
       if DataModuleMain.BasicinfQueryREP_INST.Value <> '' then
         Dataset.FieldByName('REP_INST').Value := DataModuleMain.BasicinfQueryREP_INST.Value
       else
         Dataset.FieldByName('REP_INST').Value := PrevRepInst;
  end;
  if PrevDate = '' then
    DataSet.FieldByName('DATE_MEAS').Value := FormatDateTime('YYYYMMDD', Date)
  else
    DataSet.FieldByName('DATE_MEAS').Value := PrevDate;
  DataSet.FieldByName('TIME_MEAS').Value := FormatDateTime('hhnn', Time);
end;

end.
