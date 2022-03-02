{ Copyright (C) 2018 Immo Blecher, immo@blecher.co.za

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
unit GWProp;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLtype, TabDetl,
  Menus, Db, DBCtrls, StdCtrls, Buttons, ExtCtrls, DBGrids, ComCtrls, MaskEdit,
  ZDataset;

type

  { TGWPropertiesForm }

  TGWPropertiesForm = class(TTabbedMastDetailForm)
    AMSLCheckBox: TCheckBox;
    Table1SITE_ID_NR: TStringField;
    Table1INFO_SOURC: TStringField;
    Table1DATE_MEAS: TStringField;
    Table1DEPTH: TFloatField;
    Table1READING: TFloatField;
    Table1REP_INST: TStringField;
    Table2SITE_ID_NR: TStringField;
    Table2INFO_SOURC: TStringField;
    Table2DATE_MEAS: TStringField;
    Table2DEPTH: TFloatField;
    Table2READING: TFloatField;
    Table2REP_INST: TStringField;
    GraphSpeedButton: TSpeedButton;
    ZQuery1DATE_MEAS: TStringField;
    ZQuery1DEPTH: TFloatField;
    ZQuery1INFO_SOURC: TStringField;
    ZQuery1READING: TFloatField;
    ZQuery1REP_INST: TStringField;
    ZQuery1SITE_ID_NR: TStringField;
    ZQuery1TIME_MEAS: TStringField;
    ZQuery2DATE_MEAS: TStringField;
    ZQuery2DEPTH: TFloatField;
    ZQuery2INFO_SOURC: TStringField;
    ZQuery2READING: TFloatField;
    ZQuery2REP_INST: TStringField;
    ZQuery2SITE_ID_NR: TStringField;
    ZQuery2TIME_MEAS: TStringField;
    ZQuery3DATE_MEAS: TStringField;
    ZQuery3DEPTH: TFloatField;
    ZQuery3INFO_SOURC: TStringField;
    ZQuery3READING: TFloatField;
    ZQuery3REP_INST: TStringField;
    ZQuery3SITE_ID_NR: TStringField;
    ZQuery3TIME_MEAS: TStringField;
    ZQuery4DATE_MEAS: TStringField;
    ZQuery4DEPTH: TFloatField;
    ZQuery4INFO_SOURC: TStringField;
    ZQuery4PARM_MEAS: TStringField;
    ZQuery4READING: TFloatField;
    ZQuery4REP_INST: TStringField;
    ZQuery4SITE_ID_NR: TStringField;
    ZQuery4TIME_MEAS: TStringField;
    ZQuery4UNIT_MEAS: TStringField;
    procedure BasicinfDataSourceDataChange(Sender: TObject; Field: TField);
    procedure QueryLookupValidate(Sender: TField);
    procedure QueryDATEValidate(Sender: TField);
    procedure QueryUpperSetText(Sender: TField; const aText: string);
    procedure QueryDEPTHGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure AMSLCheckBoxClick(Sender: TObject);
    procedure QueryDEPTHSetText(Sender: TField; const aText: String);
    procedure PageControlChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ZQueryGWPropNewRecord(DataSet: TDataSet);
    procedure ZQuery3READINGSetText(Sender: TField; const aText: String);
    procedure ZQuery3READINGGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure GraphSpeedButtonClick(Sender: TObject);
    procedure ZQuery2READINGGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure ZQuery2READINGSetText(Sender: TField; const aText: string);
    procedure ZQueryBeforeInsert(DataSet: TDataSet);
    procedure ZQueryBeforeOpen(DataSet: TDataSet);
    procedure QueryTimeValidate(Sender: TField);
  private
    { Private declarations }
    PrevDate, PrevInfoSource, PrevRepInst: String;
  public
    { Public declarations }
  end;

var
  GWPropertiesForm: TGWPropertiesForm;

implementation

{$R *.lfm}

uses varinit, Strdatetime, Deptset, MainDataModule, QuickDTHChart;

procedure TGWPropertiesForm.QueryLookupValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound(Sender.LookupKeyFields, Sender.AsString);
end;

procedure TGWPropertiesForm.BasicinfDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  PageControl.Enabled := (DataModuleMain.BasicinfQuerySITE_TYPE.AsString = 'B')
    or (DataModuleMain.BasicinfQuerySITE_TYPE.AsString = 'D')
    or (DataModuleMain.BasicinfQuerySITE_TYPE.AsString = 'H')
    or (DataModuleMain.BasicinfQuerySITE_TYPE.AsString = 'I')
    or (DataModuleMain.BasicinfQuerySITE_TYPE.AsString = 'W');
  LinkedLabel.Enabled := PageControl.Enabled;
  DetailNavigator.Enabled := PageControl.Enabled;
end;

procedure TGWPropertiesForm.QueryDATEValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TGWPropertiesForm.QueryUpperSetText(Sender: TField;
  const aText: string);
begin
  Sender.AsString := UpperCase(aText);
end;

procedure TGWPropertiesForm.QueryDEPTHGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if AMSLCheckBox.Checked then
      aText := FloatToStrF(DataModuleMain.BasicinfQueryALTITUDE.Value - Sender.AsFloat * LengthFactor, ffFixed, 15, 2)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end;
end;

procedure TGWPropertiesForm.AMSLCheckBoxClick(Sender: TObject);
begin
  inherited;
  ZQuery1.Refresh;
  ZQuery2.Refresh;
  ZQuery3.Refresh;
  ZQuery4.Refresh;
end;

procedure TGWPropertiesForm.QueryDEPTHSetText(Sender: TField;
  const aText: String);
begin
  inherited;
  if aText <> '' then
  begin
    if AMSLCheckBox.Checked then
      Sender.AsFloat := -StrToFloat(aText)/LengthFactor + DataModuleMain.BasicinfQueryALTITUDE.Value
    else
      Sender.AsFloat := StrToFloat(aText)/LengthFactor;
  end;
end;

procedure TGWPropertiesForm.PageControlChange(Sender: TObject);
begin
  inherited;
  GraphSpeedButton.Hint := 'Depth dependent chart of ' + PageControl.ActivePage.Hint;
end;

procedure TGWPropertiesForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := 'Parameter - Depth [' + LengthUnit + ']';
  Tabsheet2.Caption := 'Electrical Conductivity [' + ECUnit + ']';
  Tabsheet3.Caption := 'Flow Velocity [' + LengthUnit + '/' + TimeUnit + ']';
end;

procedure TGWPropertiesForm.ZQueryGWPropNewRecord(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('REP_INST').AsString := PrevRepInst;
  DataSet.FieldByName('INFO_SOURC').AsString := PrevInfoSource;
  if PrevDate = '' then
    DataSet.FieldByName('DATE_MEAS').AsString := FormatDateTime('YYYYMMDD', Date)
  else
    DataSet.FieldByName('DATE_MEAS').AsString := PrevDate;
  DataSet.FieldByName('TIME_MEAS').AsString := FormatDateTime('hhnn', Time);
end;

procedure TGWPropertiesForm.ZQuery3READINGSetText(Sender: TField;
  const aText: String);
begin
  inherited;
  Sender.AsFloat := StrToFloat(aText) * LengthFactor / TimeFactor;
end;

procedure TGWPropertiesForm.ZQuery3READINGGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then
    DisplayText := False
  else
    aText := FloatToStr(Sender.AsFloat * LengthFactor * TimeFactor);
end;

procedure TGWPropertiesForm.GraphSpeedButtonClick(Sender: TObject);
begin
  inherited;
  with TDepthSetForm.Create(Application) do
  begin
    case PageControl.ActivePage.TabIndex of
      0: begin
          XCheckBox.Caption := 'Temperature range automatic';
          XGroupBox.Caption := 'Temperature range:';
         end;
      1: begin
          XCheckBox.Caption := 'Electrical conductivity range automatic';
          XGroupBox.Caption := 'Electrical conductivity:';
         end;
      2: begin
          XCheckBox.Caption := 'Flow velocity range automatic';
          XGroupBox.Caption := 'Flow velocity range:';
         end;
      3: begin
          XCheckBox.Caption := 'User-defined parameter range automatic';
          XGroupBox.Caption := 'User-defined parameter range:';
         end;
    end;
    ShowModal;
    if ModalResult = mrOK then
    begin
      with TQuickDTHChartForm.Create(Application) do
      begin
        TopYFieldName := 'DEPTH';
        TopXFieldName := 'READING';
        case PageControl.ActivePage.TabIndex of
          0: begin
               Caption := 'Temperature Chart';
               Depth1TableName := 'bhg_temp';
               TopSeriesTitle := 'Temperature - ' + CurrentSite;
               DTHChart.AxisList[3].Title.Caption := 'Temperature [°C]';
               TheFactor := 1;
             end;
          1: begin
               Caption := 'Electrical Conductivity Chart';
               Depth1TableName := 'eleccond';
               TopSeriesTitle := 'Elec. Conductivity - ' + CurrentSite;
               DTHChart.AxisList[3].Title.Caption := 'Elec. Conductivity [' + ECUnit + ']';
               TheFactor := ECFactor;
             end;
          2: begin
               Caption := 'Flow Velocity Chart';
               Depth1TableName := 'flowvelo';
               TopSeriesTitle := 'Flow Velocity - ' + CurrentSite;
               DTHChart.AxisList[3].Title.Caption := 'Flow Velocity [' + LengthUnit + '/' + TimeUnit + ']';
               TheFactor := LengthFactor * TimeFactor;
             end;
          3: begin
               Caption := 'User-defined Parameter Chart';
               Depth1TableName := 'usr_dthp';
               TopSeriesTitle := 'User def. Param. - ' + CurrentSite;
               DTHChart.AxisList[3].Title.Caption := 'User-defined Parameter';
               TheFactor := 1;
             end;
        end; //of case
        if not DepthCheckBox.Checked then
        begin
          DTHChart.LeftAxis.Range.Min := FloatSpinEditTop.Value;
          DTHChart.LeftAxis.Range.Max := FloatSpinEditBot.Value;
          DTHChart.LeftAxis.Range.UseMin := True;
          DTHChart.LeftAxis.Range.UseMax := True;
        end;
        if not XCheckBox.Checked then
        begin
          DTHChart.AxisList[3].Range.Min := FloatSpinEditMin.Value;
          DTHChart.AxisList[3].Range.Max := FloatSpinEditMax.Value;
          DTHChart.AxisList[3].Range.UseMin := True;
          DTHChart.AxisList[3].Range.UseMax := True;
        end;
        if ChartTypeRadioGroup.ItemIndex = 1 then IsBarChart := True;
        BarWidthPerc := BarWidthSpinEdit.Value;
        Show;
      end;
    end;
    Free;
  end;
end;

procedure TGWPropertiesForm.ZQuery2READINGGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if (Sender.AsFloat > 0) and (Sender.AsFloat < 10) then
      aText := FloatToStrF(Sender.AsFloat * ECFactor, ffFixed, 15, 3)
    else
      aText := FloatToStrF(Sender.AsFloat * ECFactor, ffFixed, 15, 2);
  end;
end;

procedure TGWPropertiesForm.ZQuery2READINGSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := StrToFloat(aText) / ECFactor;
end;

procedure TGWPropertiesForm.ZQueryBeforeInsert(DataSet: TDataSet);
begin
  if DataSet.FieldByName('DATE_MEAS').IsNull then
    PrevDate := FormatDateTime('YYYYMMDD', Date)
  else
    PrevDate := DataSet.FieldByName('DATE_MEAS').Value;
  if DataSet.FieldByName('REP_INST').IsNull then
    PrevRepInst := DataModuleMain.BasicinfQueryREP_INST.Value
  else
    PrevRepInst := DataSet.FieldByName('REP_INST').Value;
  if DataSet.FieldByName('INFO_SOURC').IsNull then
    PrevInfoSource := ''
  else
    PrevInfoSource := DataSet.FieldByName('INFO_SOURC').Value;
end;

procedure TGWPropertiesForm.ZQueryBeforeOpen(DataSet: TDataSet);
begin
  TZQuery(DataSet).Params[0].AsString := CurrentSite;
end;

procedure TGWPropertiesForm.QueryTimeValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidTime(Sender.Value);
end;

end.

