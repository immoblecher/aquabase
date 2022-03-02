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
unit RadioAct;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, TabDetl, Menus, Db,
  DBCtrls, StdCtrls, Buttons, ExtCtrls, MaskEdit, ComCtrls, DBGrids,
  ZDataset;

type

  { TRadioActiveForm }

  TRadioActiveForm = class(TTabbedMastDetailForm)
    AMSLCheckBox: TCheckBox;
    GraphSpeedButton: TSpeedButton;
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
    procedure AMSLCheckBoxClick(Sender: TObject);
    procedure GraphSpeedButtonClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure TableREP_INSTValidate(Sender: TField);
    procedure TableUpperSetText(Sender: TField; const aText: String);
    procedure TableINFO_SOURCValidate(Sender: TField);
    procedure TableDATE_MEASValidate(Sender: TField);
    procedure TableDEPTHSetText(Sender: TField; const aText: String);
    procedure TableDEPTHGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure ZQueryRadioNewRecord(DataSet: TDataSet);
    procedure ZQueryBeforeInsert(DataSet: TDataSet);
    procedure ZQueryBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    PrevDate, PrevInfoSource, PrevRepInst: String;
  public
    { Public declarations }
  end;

var
  RadioActiveForm: TRadioActiveForm;

implementation

{$R *.lfm}

uses varinit, Strdatetime, Deptset, MainDataModule, QuickDTHChart;

procedure TRadioActiveForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := 'Parameter - Depth [' + LengthUnit + ']';
end;

procedure TRadioActiveForm.AMSLCheckBoxClick(Sender: TObject);
begin
  inherited;
  ZQuery1.Refresh;
  ZQuery2.Refresh;
  ZQuery3.Refresh;
end;

procedure TRadioActiveForm.GraphSpeedButtonClick(Sender: TObject);
begin
  inherited;
  with TDepthSetForm.Create(Application) do
  begin
    case PageControl.ActivePage.TabIndex of
      0: begin
          XCheckBox.Caption := 'Gamma Total range automatic';
          XGroupBox.Caption := 'Gamma Total range:';
         end;
      1: begin
          XCheckBox.Caption := 'Gamma-Gamma range automatic';
          XGroupBox.Caption := 'Gamma-Gamma conductivity:';
         end;
      2: begin
          XCheckBox.Caption := 'Neutron range automatic';
          XGroupBox.Caption := 'Neutron range:';
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
               Caption := 'Gamma Total Chart';
               Depth1TableName := 'gammatot';
               TopSeriesTitle := 'Gamma Total - ' + CurrentSite;
               DTHChart.AxisList[3].Title.Caption := 'Gamma total';
               TheFactor := 1;
             end;
          1: begin
               Caption := 'Gamma-Gamma Chart';
               Depth1TableName := 'gammagam';
               TopSeriesTitle := 'Gamma-Gamma - ' + CurrentSite;
               DTHChart.AxisList[3].Title.Caption := 'Gamma-gamma';
               TheFactor := 1;
             end;
          2: begin
               Caption := 'Neutron Chart';
               Depth1TableName := 'neutron_';
               TopSeriesTitle := 'Neutron - ' + CurrentSite;
               DTHChart.AxisList[3].Title.Caption := 'Neutron';
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

procedure TRadioActiveForm.PageControlChange(Sender: TObject);
begin
  inherited;
  GraphSpeedButton.Hint := 'Depth dependent chart of ' + PageControl.ActivePage.Hint;
end;

procedure TRadioActiveForm.TableREP_INSTValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('REP_INST', Sender.AsString);
end;

procedure TRadioActiveForm.TableUpperSetText(Sender: TField;
  const aText: String);
begin
  inherited;
  Sender.AsString := UpperCase(aText);
end;

procedure TRadioActiveForm.TableINFO_SOURCValidate(Sender: TField);
begin
  inherited;
  ValidFound := DataModuleMain.LookupValidFound('IS_GEOPH', Sender.AsString);
end;

procedure TRadioActiveForm.TableDATE_MEASValidate(Sender: TField);
begin
  inherited;
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TRadioActiveForm.TableDEPTHSetText(Sender: TField;
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

procedure TRadioActiveForm.TableDEPTHGetText(Sender: TField;
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

procedure TRadioActiveForm.ZQueryRadioNewRecord(DataSet: TDataSet);
begin
  DataSet.FindField('REP_INST').AsString := PrevRepInst;
  DataSet.FindField('INFO_SOURC').AsString := PrevInfoSource;
  if PrevDate = '' then
    DataSet.FindField('DATE_MEAS').AsString := FormatDateTime('YYYYMMDD', Date)
  else
    DataSet.FindField('DATE_MEAS').AsString := PrevDate;
end;

procedure TRadioActiveForm.ZQueryBeforeInsert(DataSet: TDataSet);
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

procedure TRadioActiveForm.ZQueryBeforeOpen(DataSet: TDataSet);
begin
  TZQuery(DataSet).Params[0].AsString := CurrentSite;
end;

end.
