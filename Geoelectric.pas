{ Copyright (C) 2018 Immo Blecher immo@blecher.co.za

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
unit Geoelectric;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLtype, TabDetl,
  Menus, Db, DBCtrls, StdCtrls, Buttons, ExtCtrls, MaskEdit, ComCtrls, DBGrids,
  ZDataset;

type

  { TGeoElectricForm }

  TGeoElectricForm = class(TTabbedMastDetailForm)
    GraphSpeedButton: TSpeedButton;
    AMSLCheckBox: TCheckBox;
    ZQuery1DATE_MEAS: TStringField;
    ZQuery1DEPTH: TFloatField;
    ZQuery1INFO_SOURC: TStringField;
    ZQuery1READING: TLargeintField;
    ZQuery1REP_INST: TStringField;
    ZQuery1SITE_ID_NR: TStringField;
    ZQuery2DATE_MEAS: TStringField;
    ZQuery2DEPTH: TFloatField;
    ZQuery2INFO_SOURC: TStringField;
    ZQuery2READING: TLargeintField;
    ZQuery2REP_INST: TStringField;
    ZQuery2SITE_ID_NR: TStringField;
    ZQuery3DATE_MEAS: TStringField;
    ZQuery3DEPTH: TFloatField;
    ZQuery3INFO_SOURC: TStringField;
    ZQuery3READING: TLargeintField;
    ZQuery3REP_INST: TStringField;
    ZQuery3SITE_ID_NR: TStringField;
    procedure FormActivate(Sender: TObject);
    procedure GraphSpeedButtonClick(Sender: TObject);
    procedure TableREP_INSTValidate(Sender: TField);
    procedure TableUpperSetText(Sender: TField; const aText: String);
    procedure TableINFO_SOURCValidate(Sender: TField);
    procedure TableDATE_MEASValidate(Sender: TField);
    procedure TableDEPTHSetText(Sender: TField; const aText: String);
    procedure TableDEPTHGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure AMSLCheckBoxClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure ZQueryBeforeInsert(DataSet: TDataSet);
    procedure ZQueryGeoElNewRecord(DataSet: TDataSet);
    procedure ZQueryBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    PrevDate, PrevInfoSource, PrevRepInst: String;
  public
    { Public declarations }
  end;

var
  GeoElectricForm: TGeoElectricForm;

implementation

{$R *.lfm}

uses varinit, Strdatetime, Deptset, MainDataModule, QuickDTHChart;

procedure TGeoElectricForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := 'Parameter - Depth [' + LengthUnit + ']';
end;

procedure TGeoElectricForm.GraphSpeedButtonClick(Sender: TObject);
begin
  inherited;
  with TDepthSetForm.Create(Application) do
  begin
    case PageControl.ActivePage.TabIndex of
      0: begin
          XCheckBox.Caption := 'Long Normal range automatic';
          XGroupBox.Caption := 'Long Normal range:';
         end;
      1: begin
          XCheckBox.Caption := 'Short Normal range automatic';
          XGroupBox.Caption := 'Short Normal conductivity:';
         end;
      2: begin
          XCheckBox.Caption := 'Self-Potential range automatic';
          XGroupBox.Caption := 'Self-Potential range:';
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
               Caption := 'Long Normal Resistivity Chart';
               Depth1TableName := 'longnorm';
               TopSeriesTitle := 'Long Normal - ' + CurrentSite;
               DTHChart.AxisList[3].Title.Caption := 'Long normal resistivity';
               TheFactor := 1;
             end;
          1: begin
               Caption := 'Short Normal Resistivity Chart';
               Depth1TableName := 'shornorm';
               TopSeriesTitle := 'Short Normal - ' + CurrentSite;
               DTHChart.AxisList[3].Title.Caption := 'Short normal resistivity';
               TheFactor := 1;
             end;
          2: begin
               Caption := 'Self-Potential Chart';
               Depth1TableName := 'selfpote';
               TopSeriesTitle := 'Self Potential - ' + CurrentSite;
               DTHChart.AxisList[3].Title.Caption := 'Self-potential';
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
          DTHChart.AxisList[2].Range.Min := FloatSpinEditMin.Value;
          DTHChart.AxisList[2].Range.Max := FloatSpinEditMax.Value;
          DTHChart.AxisList[2].Range.UseMin := True;
          DTHChart.AxisList[2].Range.UseMax := True;
        end;
        if ChartTypeRadioGroup.ItemIndex = 1 then IsBarChart := True;
        BarWidthPerc := BarWidthSpinEdit.Value;
        Show;
      end;
    end;
    Free;
  end;
end;

procedure TGeoElectricForm.TableREP_INSTValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('REP_INST', Sender.AsString);
end;

procedure TGeoElectricForm.TableUpperSetText(Sender: TField;
  const aText: String);
begin
  inherited;
  Sender.AsString := UpperCase(aText);
end;

procedure TGeoElectricForm.TableINFO_SOURCValidate(Sender: TField);
begin
  inherited;
  ValidFound := DataModuleMain.LookupValidFound('IS_GEOPH', Sender.AsString);
end;

procedure TGeoElectricForm.TableDATE_MEASValidate(Sender: TField);
begin
  inherited;
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TGeoElectricForm.TableDEPTHSetText(Sender: TField;
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

procedure TGeoElectricForm.TableDEPTHGetText(Sender: TField;
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

procedure TGeoElectricForm.AMSLCheckBoxClick(Sender: TObject);
begin
  inherited;
  ZQuery1.Refresh;
  ZQuery2.Refresh;
  ZQuery3.Refresh;
end;

procedure TGeoElectricForm.PageControlChange(Sender: TObject);
begin
  inherited;
  GraphSpeedButton.Hint := 'Depth dependent chart of ' + PageControl.ActivePage.Hint;  GraphSpeedButton.Hint := 'Depth dependent chart of ' + PageControl.ActivePage.Hint;
end;

procedure TGeoElectricForm.ZQueryBeforeInsert(DataSet: TDataSet);
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

procedure TGeoElectricForm.ZQueryGeoElNewRecord(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('REP_INST').Value := PrevRepInst;
  DataSet.FieldByName('INFO_SOURC').Value := PrevInfoSource;
  DataSet.FieldByName('DATE_MEAS').Value := PrevDate;
end;

procedure TGeoElectricForm.ZQueryBeforeOpen(DataSet: TDataSet);
begin
  TZQuery(DataSet).Params[0].AsString := CurrentSite;
end;

end.
