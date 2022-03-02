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
unit BHProp;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLtype, TabDetl,
  Menus, Db, DBCtrls, StdCtrls, Buttons, ExtCtrls, DBGrids, MaskEdit, ComCtrls,
  ZDataset;

type

  { TBhPropertiesForm }

  TBhPropertiesForm = class(TTabbedMastDetailForm)
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
    AMSLCheckBox: TCheckBox;
    ZQuery1DATE_MEAS: TStringField;
    ZQuery1DEPTH: TFloatField;
    ZQuery1INFO_SOURC: TStringField;
    ZQuery1READING: TFloatField;
    ZQuery1REP_INST: TStringField;
    ZQuery1SITE_ID_NR: TStringField;
    ZQuery2DATE_MEAS: TStringField;
    ZQuery2DEPTH: TFloatField;
    ZQuery2INFO_SOURC: TStringField;
    ZQuery2READING: TFloatField;
    ZQuery2REP_INST: TStringField;
    ZQuery2SITE_ID_NR: TStringField;
    procedure BasicinfDataSourceDataChange(Sender: TObject; Field: TField);
    procedure FormActivate(Sender: TObject);
    procedure GraphSpeedButtonClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure AMSLCheckBoxClick(Sender: TObject);
    procedure TableREP_INSTValidate(Sender: TField);
    procedure ZQueryBeforeOpen(DataSet: TDataSet);
    procedure ZQuery1READINGGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure ZQuery1READINGSetText(Sender: TField; const aText: string);
    procedure ZQueryBHPropNewRecord(DataSet: TDataSet);
    procedure ZQueryBeforeInsert(DataSet: TDataSet);
    procedure TableNewRecord(DataSet: TDataSet);
    procedure TableUpperSetText(Sender: TField; const aText: String);
    procedure TableINFO_SOURCValidate(Sender: TField);
    procedure TableDATE_MEASValidate(Sender: TField);
    procedure TableDEPTHSetText(Sender: TField; const aText: String);
    procedure TableDEPTHGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
  private
    { Private declarations }
    PrevDate, PrevInfoSource, PrevRepInst: String;
  public
    { Public declarations }
  end;

var
  BhPropertiesForm: TBhPropertiesForm;

implementation

{$R *.lfm}

uses VARINIT, Strdatetime, Deptset, MainDataModule, QuickDTHChart;

procedure TBhPropertiesForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := 'Parameter - Depth [' + LengthUnit + ']';
  Tabsheet1.Caption := 'Caliper [' + DiamUnit + ']';
  Tabsheet2.Caption := 'Dip [°]';
end;

procedure TBhPropertiesForm.BasicinfDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  ZQuery1.Close;
  ZQuery1.Open;
  ZQuery2.Close;
  ZQuery2.Open;
end;

procedure TBhPropertiesForm.GraphSpeedButtonClick(Sender: TObject);
begin
  inherited;
  with TDepthSetForm.Create(Application) do
  begin
    case PageControl.ActivePage.TabIndex of
      0: begin
          XCheckBox.Caption := 'Caliper range automatic';
          XGroupBox.Caption := 'Caliper range:';
         end;
      1: begin
          XCheckBox.Caption := 'Borehole dip range automatic';
          XGroupBox.Caption := 'Borehole dip range:';
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
               Caption := 'Caliper Chart';
               Depth1TableName := 'caliper_';
               TopSeriesTitle := 'Caliper - ' + CurrentSite;
               DTHChart.AxisList[3].Title.Caption := 'Caliper [' + DiamUnit + ']';
               TheFactor := DiamFactor;
             end;
          1: begin
               Caption := 'Borehole Dip Chart';
               Depth1TableName := 'bhle_dip';
               TopSeriesTitle := 'Borehole Dip - ' + CurrentSite;
               DTHChart.AxisList[3].Title.Caption := 'Borehole dip [°]';
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

procedure TBhPropertiesForm.PageControlChange(Sender: TObject);
begin
  inherited;
  GraphSpeedButton.Hint := 'Depth dependent chart of ' + PageControl.ActivePage.Hint;  GraphSpeedButton.Hint := 'Depth dependent chart of ' + PageControl.ActivePage.Hint;
end;

procedure TBhPropertiesForm.AMSLCheckBoxClick(Sender: TObject);
begin
  inherited;
  ZQuery1.Refresh;
  ZQuery2.Refresh;
end;

procedure TBhPropertiesForm.TableREP_INSTValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('REP_INST', Sender.AsString);
end;

procedure TBhPropertiesForm.ZQueryBeforeOpen(DataSet: TDataSet);
begin
  TZQuery(DataSet).Params[0].AsString := CurrentSite;
end;

procedure TBhPropertiesForm.ZQuery1READINGGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 2);
  end;
end;

procedure TBhPropertiesForm.ZQuery1READINGSetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
    Sender.AsFloat := StrToFloat(aText)/DiamFactor
  else Sender.Value := Null;
end;

procedure TBhPropertiesForm.ZQueryBHPropNewRecord(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('REP_INST').Value := PrevRepInst;
  DataSet.FieldByName('INFO_SOURC').Value := PrevInfoSource;
  DataSet.FieldByName('DATE_MEAS').Value := PrevDate;
end;

procedure TBhPropertiesForm.ZQueryBeforeInsert(DataSet: TDataSet);
begin
  inherited;
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

procedure TBhPropertiesForm.TableNewRecord(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('REP_INST').AsString := PrevRepInst;
  DataSet.FieldByName('INFO_SOURC').AsString := PrevInfoSource;
  if PrevDate = '' then
    DataSet.FieldByName('DATE_MEAS').AsString := FormatDateTime('YYYYMMDD', Date)
  else
    DataSet.FieldByName('DATE_MEAS').AsString := PrevDate;
  if DataSet.FindField('NGDB_FLAG') <> nil then
    DataSet.FieldByName('NGDB_FLAG').Value := 0;
end;

procedure TBhPropertiesForm.TableUpperSetText(Sender: TField;
  const aText: String);
begin
  inherited;
  Sender.AsString := UpperCase(aText);
end;

procedure TBhPropertiesForm.TableINFO_SOURCValidate(Sender: TField);
begin
  inherited;
  ValidFound := DataModuleMain.LookupValidFound('IS_BASIC', Sender.AsString);
end;

procedure TBhPropertiesForm.TableDATE_MEASValidate(Sender: TField);
begin
  inherited;
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TBhPropertiesForm.TableDEPTHSetText(Sender: TField;
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

procedure TBhPropertiesForm.TableDEPTHGetText(Sender: TField;
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

end.
