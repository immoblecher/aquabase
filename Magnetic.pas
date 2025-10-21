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
unit Magnetic;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MastDetl, Menus, Db,
  DBCtrls, StdCtrls, Buttons, ExtCtrls, DBGrids, MaskEdit;

type

  { TMagneticSusForm }

  TMagneticSusForm = class(TMasterDetailForm)
    LinkedQueryDATE_MEAS: TStringField;
    LinkedQueryDEPTH: TFloatField;
    LinkedQueryINFO_SOURC: TStringField;
    LinkedQueryREADING: TLongintField;
    LinkedQueryREP_INST: TStringField;
    AMSLCheckBox: TCheckBox;
    procedure ChartSpeedButtonClick(Sender: TObject);
    procedure LinkedQueryBeforeInsert(DataSet: TDataSet);
    procedure LinkedQueryDATE_MEASValidate(Sender: TField);
    procedure LinkedQueryDEPTHGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryDEPTHSetText(Sender: TField; const aText: string);
    procedure LinkedQueryINFO_SOURCValidate(Sender: TField);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryREP_INSTValidate(Sender: TField);
    procedure LinkedQueryUpperSetText(Sender: TField; const aText: string);
    procedure FormActivate(Sender: TObject);
    procedure AMSLCheckBoxClick(Sender: TObject);
  private
    { Private declarations }
    PrevDate, PrevInfoSource, PrevRepInst: String;
  public
    { Public declarations }
  end;

var
  MagneticSusForm: TMagneticSusForm;

implementation

{$R *.lfm}

uses varinit, strdatetime, Deptset, MainDataModule, QuickDTHChart;

procedure TMagneticSusForm.LinkedQueryBeforeInsert(DataSet: TDataSet);
begin
  PrevDate := LinkedQueryDATE_MEAS.Value;
  PrevInfoSource := LinkedQueryINFO_SOURC.Value;
  PrevRepInst := LinkedQueryREP_INST.Value;
end;

procedure TMagneticSusForm.ChartSpeedButtonClick(Sender: TObject);
begin
  with TDepthSetForm.Create(Application) do
  begin
    XCheckBox.Caption := 'Magnetic susceptibility range automatic';
    XGroupBox.Caption := 'Magnetic susceptibility range:';
    ShowModal;
    if ModalResult = mrOK then
    begin
      with TQuickDTHChartForm.Create(Application) do
      begin
        Caption := 'Magnetic Susceptibility Chart';
        DTHChart.AxisList[3].Title.Caption := 'Magnetic Susceptibility';
        TheFactor := 1;
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
        TopSeriesTitle := 'Magn. Suscept. - ' + CurrentSite;
        TopYFieldName := 'DEPTH';
        Depth1TableName := 'magnetic';
        TopXFieldName := 'READING';
        Show;
      end;
    end;
    Free;
  end;
end;

procedure TMagneticSusForm.LinkedQueryDATE_MEASValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TMagneticSusForm.LinkedQueryDEPTHGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if AMSLCheckBox.Checked then
    Elevation := DataModuleMain.BasicinfQueryALTITUDE.Value
  else
    Elevation := 2 * Sender.AsFloat;
  if Sender.IsNull then
    DisplayText := False
  else
    aText := FloatToStrF((Elevation - Sender.AsFloat) * LengthFactor, ffFixed, 15, 2);
end;

procedure TMagneticSusForm.LinkedQueryDEPTHSetText(Sender: TField;
  const aText: string);
begin
  if AMSLCheckBox.Checked then
    Elevation := DataModuleMain.BasicinfQueryALTITUDE.Value
  else
  if aText <> '' then
    Elevation := 2 * StrToFloat(aText);
  if aText <> '' then
    Sender.AsFloat := (Elevation - StrToFloat(aText))/LengthFactor;
end;

procedure TMagneticSusForm.LinkedQueryINFO_SOURCValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('IS_GEOPH', Sender.AsString);
end;

procedure TMagneticSusForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  LinkedQueryREP_INST.Value := PrevRepInst;
  LinkedQueryINFO_SOURC.Value := PrevInfoSource;
  if PrevDate = '' then
    LinkedQueryDATE_MEAS.Value := FormatDateTime('YYYYMMDD', Date)
  else
    LinkedQueryDATE_MEAS.Value := PrevDate;
end;

procedure TMagneticSusForm.LinkedQueryREP_INSTValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('REP_INST', Sender.AsString);
end;

procedure TMagneticSusForm.LinkedQueryUpperSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TMagneticSusForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption + ' - Depth [' + LengthUnit + ']';
end;

procedure TMagneticSusForm.AMSLCheckBoxClick(Sender: TObject);
begin
  inherited;
  LinkedQuery.Refresh;
end;

end.
