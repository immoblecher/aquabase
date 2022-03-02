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
unit Penetrat;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLtype, MastDetl,
  Menus, Db, StdCtrls, DBCtrls, ExtCtrls, Buttons, Spin, DBGrids, MaskEdit;

type

  { TPenetrationForm }

  TPenetrationForm = class(TMasterDetailForm)
    FloatSpinEdit1: TFloatSpinEdit;
    lblRate: TLabel;
    LinkedQueryCOMMENT: TStringField;
    LinkedQueryDATE_ENTRY: TStringField;
    LinkedQueryDEPTH_BOT: TFloatField;
    LinkedQueryDEPTH_TOP: TFloatField;
    LinkedQueryDIAMETER: TFloatField;
    LinkedQueryINFO_SOURC: TStringField;
    LinkedQueryPENET_RATE: TFloatField;
    LinkedQueryREP_INST: TStringField;
    AMSLCheckBox: TCheckBox;
    procedure BasicinfDataSourceDataChange(Sender: TObject; Field: TField);
    procedure ChartSpeedButtonClick(Sender: TObject);
    procedure LinkedQueryBeforeInsert(DataSet: TDataSet);
    procedure LinkedQueryDEPTH_TOPValidate(Sender: TField);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryREP_INSTSetText(Sender: TField;
      const aText: String);
    procedure LinkedQueryValidate(Sender: TField);
    procedure LinkedQueryDEPTH_TOPGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure LinkedQueryDEPTH_TOPSetText(Sender: TField;
      const aText: String);
    procedure LinkedQueryDEPTH_BOTGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure LinkedQueryDEPTH_BOTSetText(Sender: TField;
      const aText: String);
    procedure LinkedQueryDEPTH_BOTValidate(Sender: TField);
    procedure LinkedQueryDIAMETERGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure LinkedQueryDIAMETERSetText(Sender: TField;
      const aText: String);
    procedure LinkedQueryPENET_RATEGetText(Sender: TField;
      var aText: String; DisplayText: Boolean);
    procedure LinkedQueryPENET_RATESetText(Sender: TField;
      const aText: String);
    procedure LinkedQueryINFO_SOURCSetText(Sender: TField;
      const aText: String);
    procedure LinkedQueryCOMMENTSetText(Sender: TField;
      const aText: String);
    procedure FormActivate(Sender: TObject);
    procedure AMSLCheckBoxClick(Sender: TObject);
  private
    { Private declarations }
    PrevInfoSource, PrevRepInst: ShortString;
    PrevDepthBot, PrevDiameter : Real;
  public
    { Public declarations }
  end;

var
  PenetrationForm: TPenetrationForm;

implementation

uses varinit, MainDataModule, DeptSet, QuickDTHChart;

{$R *.lfm}

procedure TPenetrationForm.LinkedQueryREP_INSTSetText(Sender: TField;
  const aText: String);
begin
  inherited;
  Sender.Value := UpperCase(aText);
end;

procedure TPenetrationForm.LinkedQueryValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound(Sender.LookupKeyFields, Sender.AsString);
end;

procedure TPenetrationForm.LinkedQueryDEPTH_TOPValidate(Sender: TField);
begin
  if not Sender.Dataset.FieldByName('DEPTH_BOT').IsNull then
    ValidFound := Sender.Value <= Sender.Dataset.FieldByName('DEPTH_BOT').Value;
end;

procedure TPenetrationForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  LinkedQueryDATE_ENTRY.ReadOnly := False;
  LinkedQueryDATE_ENTRY.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryDATE_ENTRY.ReadOnly := True;
  LinkedQueryREP_INST.Value := PrevRepInst;
  LinkedQueryINFO_SOURC.Value := PrevInfoSource;
  LinkedQueryDEPTH_TOP.Value := PrevDepthBot;
  LinkedQueryDEPTH_BOT.Value := PrevDepthBot + FloatSpinEdit1.Value;
  LinkedQueryDIAMETER.Value := PrevDiameter;
  if PrevDepthBot > 0 then //there are previous penetrations added
    DBGrid.SelectedField := LinkedQuery.Fields.Fields[7] //goto the rate field
  else
    DBGrid.SelectedField := LinkedQuery.Fields.Fields[2] //goto the rep. inst. field
end;

procedure TPenetrationForm.LinkedQueryBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  PrevRepInst := LinkedQueryREP_INST.Value;
  PrevDepthBot := LinkedQueryDEPTH_BOT.Value;
  PrevDiameter := LinkedQueryDIAMETER.Value;
  PrevInfoSource := LinkedQueryINFO_SOURC.Value;
end;

procedure TPenetrationForm.ChartSpeedButtonClick(Sender: TObject);
begin
  with TDepthSetForm.Create(Application) do
  begin
    XCheckBox.Caption := 'Penetration rate range automatic';
    XGroupBox.Caption := 'Penetration rate range:';
    ShowModal;
    if ModalResult = mrOK then
    begin
      with TQuickDTHChartForm.Create(Application) do
      begin
        Caption := 'Penetration Rate Chart';
        DTHChart.AxisList[3].Title.Caption := 'Penetration Rate [' + TimeUnit + '/' + LengthUnit + ']';
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
        TopSeriesTitle := 'Penetraton Rate - ' + CurrentSite;
        TopYFieldName := 'DEPTH_TOP';
        Depth1TableName := 'penetrat';
        TopXFieldName := 'PENET_RATE';
        Show;
      end;
    end;
    Free;
  end;
end;

procedure TPenetrationForm.BasicinfDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  DBGrid.Enabled := (DataModuleMain.BasicinfQuerySITE_TYPE.AsString = 'B')
    or (DataModuleMain.BasicinfQuerySITE_TYPE.AsString = 'D')
    or (DataModuleMain.BasicinfQuerySITE_TYPE.AsString = 'W');
  LinkedLabel.Enabled := DBGrid.Enabled;
  DetailNavigator.Enabled := DBGrid.Enabled;
end;

procedure TPenetrationForm.LinkedQueryDEPTH_TOPGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  inherited;
  if AMSLCheckBox.Checked then
    Elevation := DataModuleMain.BasicinfQueryALTITUDE.Value
  else
    Elevation := 2 * Sender.AsFloat;
  if Sender.IsNull then
    DisplayText := False
  else
    aText := FloatToStrF((Elevation - Sender.AsFloat) * LengthFactor, ffFixed, 15, 2);
end;

procedure TPenetrationForm.LinkedQueryDEPTH_TOPSetText(Sender: TField;
  const aText: String);
begin
  inherited;
  if AMSLCheckBox.Checked then
    Elevation := DataModuleMain.BasicinfQueryALTITUDE.Value + DataModuleMain.BasicinfQueryCOLLAR_HI.Value
  else
  if aText <> '' then
  begin
    Elevation := 2 * StrToFloat(aText);
    Sender.Value := (Elevation - StrToFloat(aText))/LengthFactor;
  end;
end;

procedure TPenetrationForm.LinkedQueryDEPTH_BOTGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  inherited;
  if AMSLCheckBox.Checked then
    Elevation := DataModuleMain.BasicinfQueryALTITUDE.Value
  else
    Elevation := 2 * Sender.AsFloat;
  if Sender.IsNull then
    DisplayText := False
  else
    aText := FloatToStrF((Elevation - Sender.AsFloat) * LengthFactor, ffFixed, 15, 2);
end;

procedure TPenetrationForm.LinkedQueryDEPTH_BOTSetText(Sender: TField;
  const aText: String);
begin
  inherited;
  if AMSLCheckBox.Checked then
    Elevation := DataModuleMain.BasicinfQueryALTITUDE.Value + DataModuleMain.BasicinfQueryCOLLAR_HI.Value
  else
  if aText <> '' then
  begin
    Elevation := 2 * StrToFloat(aText);
    Sender.Value := (Elevation - StrToFloat(aText))/LengthFactor;
  end;
end;

procedure TPenetrationForm.LinkedQueryDEPTH_BOTValidate(Sender: TField);
begin
  inherited;
  if Sender.Value <= LinkedQueryDEPTH_TOP.Value then ValidFound := False
  else ValidFound := True;
end;

procedure TPenetrationForm.LinkedQueryDIAMETERGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  inherited;
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

procedure TPenetrationForm.LinkedQueryDIAMETERSetText(Sender: TField;
  const aText: String);
begin
  inherited;
  if aText <> '' then
    Sender.Value := StrToFloat(aText)/DiamFactor;
end;

procedure TPenetrationForm.LinkedQueryPENET_RATEGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  inherited;
  if (not Sender.IsNull) and (Sender.Value > 0) then
  begin
    if (60/TimeFactor)/(Sender.AsFloat * LengthFactor) > 100000 then
      aText := FloatToStrF((60/TimeFactor)/(Sender.AsFloat * LengthFactor), ffFixed, 15, 0)
    else
    if (60/TimeFactor)/(Sender.AsFloat * LengthFactor) < 0.01 then
      aText := FloatToStrF((60/TimeFactor)/(Sender.AsFloat * LengthFactor), ffFixed, 15, 5)
    else
      aText := FloatToStrF((60/TimeFactor)/(Sender.AsFloat * LengthFactor), ffFixed, 15, 2);
  end
  else
    DisplayText := False;
end;

procedure TPenetrationForm.LinkedQueryPENET_RATESetText(Sender: TField;
  const aText: String);
begin
  inherited;
  if aText <> '' then
    Sender.Value := LengthFactor * 60/(TimeFactor*StrToFloat(aText));
end;

procedure TPenetrationForm.LinkedQueryINFO_SOURCSetText(Sender: TField;
  const aText: String);
begin
  inherited;
  Sender.Value := UpperCase(aText);
end;

procedure TPenetrationForm.LinkedQueryCOMMENTSetText(Sender: TField;
  const aText: String);
begin
  inherited;
  Sender.Value := UpperCase(aText);
end;

procedure TPenetrationForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption +
    ' - Rate [' + TimeUnit + '/' + LengthUnit + '], Depth [' + LengthUnit + ']';
  lblRate.Caption := 'Default depth interval [' + LengthUnit + ']:';
  lblRate.Width := lblRate.Canvas.TextWidth(lblRate.Caption);
  lblRate.Height := lblrate.Canvas.TextHeight(lblRate.Caption);
end;

procedure TPenetrationForm.AMSLCheckBoxClick(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crSQLWait;
  LinkedQuery.Refresh;
  Application.ProcessMessages;
  Screen.Cursor := crDefault;
end;

end.
