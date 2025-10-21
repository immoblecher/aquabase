{ Copyright (C) 2025 Immo Blecher, immo@blecher.co.za

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
unit Aquifer;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MastDetl, StdCtrls,
  Buttons, Menus, Db, DBCtrls, LCLtype, ExtCtrls, DBGrids, MaskEdit, ZDataSet;

type

  { TAquiferForm }

  TAquiferForm = class(TMasterDetailForm)
    AMSLCheckBox: TCheckBox;
    GraphSpeedButton: TSpeedButton;
    LinkedQueryAQUI_CODE: TStringField;
    LinkedQueryAQUI_TYPE: TStringField;
    LinkedQueryCOMMENT: TStringField;
    LinkedQueryDATE_ENTRY: TStringField;
    LinkedQueryDEPTH_BOT: TFloatField;
    LinkedQueryDEPTH_TOP: TFloatField;
    LinkedQueryINFO_SOURC: TStringField;
    LinkedQueryMETH_MEAS: TStringField;
    LinkedQueryREP_INST: TStringField;
    LinkedQueryYIELD: TFloatField;
    ValidateYieldQuery: TZReadOnlyQuery;
    procedure BasicinfDataSourceDataChange(Sender: TObject; Field: TField);
    procedure ChartSpeedButtonClick(Sender: TObject);
    procedure DBGridExit(Sender: TObject);
    procedure GraphSpeedButtonClick(Sender: TObject);
    procedure LinkedQueryBeforeInsert(DataSet: TDataSet);
    procedure LinkedQueryCOMMENTSetText(Sender: TField; const aText: string);
    procedure LinkedQueryDEPTHGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryDEPTHSetText(Sender: TField; const aText: string);
    procedure LinkedQueryDEPTH_BOTValidate(Sender: TField);
    procedure LinkedQueryDEPTH_TOPValidate(Sender: TField);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryValidate(Sender: TField);
    procedure LinkedQueryUpperSetText(Sender: TField; const aText: string);
    procedure LinkedQueryYIELDGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LinkedQueryYIELDSetText(Sender: TField; const aText: string);
    procedure AMSLCheckBoxClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure LinkedQueryYIELDValidate(Sender: TField);
  private
    { Private declarations }
    PrevInfoSource, PrevRepInst, PrevMeth: String;
    PrevDepth2Bot, PrevYield: Real;
  public
    { Public declarations }
  end;

var
  AquiferForm: TAquiferForm;

implementation

uses Varinit, MainDataModule, GeollogSetForm, DeptSet, QuickDTHChart;

{$R *.lfm}

procedure TAquiferForm.GraphSpeedButtonClick(Sender: TObject);
begin
  inherited;
  with TGeollogSettingsForm.Create(Application) do
  begin
    PageControl1.ActivePage := LogTab;
    ShowModal;
  end;
end;

procedure TAquiferForm.ChartSpeedButtonClick(Sender: TObject);
begin
  with TDepthSetForm.Create(Application) do
  begin
    XCheckBox.Caption := 'Aquifer yield range automatic';
    XGroupBox.Caption := 'Yield range:';
    ShowModal;
    if ModalResult = mrOK then
    begin
      with TQuickDTHChartForm.Create(Application) do
      begin
        Caption := 'Aquifer Progressive Yield';
        DTHChart.AxisList[3].Title.Caption := 'Yield [' + VolumeUnit + '/' + TimeUnit + ']';
        TheFactor := VolumeFactor * TimeFactor;
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
        TopSeriesTitle := 'Yield - ' + CurrentSite;
        TopYFieldName := 'DEPTH_TOP';
        Depth1TableName := 'aquifer_';
        TopXFieldName := 'YIELD';
        Show;
      end;
    end;
    Free;
  end;
end;

procedure TAquiferForm.BasicinfDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  DBGrid.Enabled := (DataModuleMain.BasicinfQuerySITE_TYPE.AsString = 'B')
    or (DataModuleMain.BasicinfQuerySITE_TYPE.AsString = 'D')
    or (DataModuleMain.BasicinfQuerySITE_TYPE.AsString = 'M')
    or (DataModuleMain.BasicinfQuerySITE_TYPE.AsString = 'W');
  LinkedLabel.Enabled := DBGrid.Enabled;
  DetailNavigator.Enabled := DBGrid.Enabled;
end;

procedure TAquiferForm.DBGridExit(Sender: TObject);
var
  TheBookMark: TBookMark;
  InvalidYields: Boolean;
begin
  InvalidYields := False;
  if LinkedQuery.RecordCount > 0 then
  begin
    TheBookmark := LinkedQuery.Bookmark;
    LinkedQuery.DisableControls;
    LinkedQuery.First;
    while not LinkedQuery.EOF do
    begin
      PrevYield := LinkedQueryYIELD.Value;
      LinkedQuery.Next;
      if InvalidYields = False then
        InvalidYields := LinkedQueryYIELD.Value < PrevYield;
    end;
    //LinkedQuery.Last;
    if LinkedQueryDEPTH_BOT.Value < DataModuleMain.BasicinfQueryDEPTH.Value then
      if MessageDlg('Data Integrity Warning', 'The last Depth-to-Bottom value must be >= to the depth of the borehole! Do you want to fix this now?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        LinkedQuery.Edit;
        LinkedQueryDEPTH_BOT.Value := DataModuleMain.BasicinfQueryDEPTH.Value;
        LinkedQuery.Post;
      end;
    LinkedQuery.GotoBookmark(TheBookMark);
    LinkedQuery.EnableControls;
    if InvalidYields then
      MessageDlg('The progressive yield is not consistently increasing with depth! If you are certain that this is correct you may leave it as is, otherwise fix it.', mtWarning, [mbOK], 0);
  end;
end;

procedure TAquiferForm.LinkedQueryBeforeInsert(DataSet: TDataSet);
begin
  PrevInfoSource := LinkedQueryINFO_SOURC.Value;
  PrevMeth := LinkedQueryMETH_MEAS.Value;
  PrevRepInst := LinkedQueryREP_INST.Value;
  PrevDepth2Bot := LinkedQueryDEPTH_BOT.Value;
  PrevYield := LinkedQueryYIELD.Value;
end;

procedure TAquiferForm.LinkedQueryCOMMENTSetText(Sender: TField;
  const aText: string);
begin
  if AllowSmallChars then
    Sender.Value := aText
  else
    Sender.Value := UpperCase(aText);
end;

procedure TAquiferForm.LinkedQueryDEPTHGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if AMSLCheckBox.Checked then
    Elevation := DataModuleMain.BasicinfQueryALTITUDE.Value
  else
    Elevation := 2 * Sender.AsFloat;
  if Sender.Value <> NULL then
    aText := FloatToStrF((Elevation - Sender.AsFloat) * LengthFactor, ffFixed, 15, 2)
  else
    DisplayText := False;
end;

procedure TAquiferForm.LinkedQueryDEPTHSetText(Sender: TField;
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

procedure TAquiferForm.LinkedQueryDEPTH_BOTValidate(Sender: TField);
begin
  if BasicinfDataSource.DataSet.FieldByName('DEPTH').IsNull then
    ValidFound := (Sender.Value >= LinkedQueryDEPTH_TOP.Value)
  else
    ValidFound := (Sender.Value >= LinkedQueryDEPTH_TOP.Value) and (Sender.Value <= BasicinfDataSource.DataSet.FieldByName('DEPTH').Value);
end;

procedure TAquiferForm.LinkedQueryDEPTH_TOPValidate(Sender: TField);
begin
  if LinkedQueryDEPTH_BOT.IsNULL then
    ValidFound := True
  else
    ValidFound := Sender.Value <= LinkedQueryDEPTH_BOT.Value;
end;

procedure TAquiferForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  if PrevRepInst = '' then
    LinkedQueryREP_INST.Value := DataModuleMain.BasicinfQueryREP_INST.Value
  else
    LinkedQueryREP_INST.Value := PrevRepInst;
  LinkedQueryDATE_ENTRY.ReadOnly := False;
  LinkedQueryDATE_ENTRY.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryDATE_ENTRY.ReadOnly := True;
  LinkedQueryDEPTH_TOP.Value := PrevDepth2Bot;
  if PrevDepth2Bot = 0 then
  begin
    if not DataModuleMain.BasicinfQueryDEPTH.IsNull then
      LinkedQueryDEPTH_BOT.Value := DataModuleMain.BasicinfQueryDEPTH.Value
  end
  else
    LinkedQueryDEPTH_BOT.Value := LinkedQueryDEPTH_TOP.Value + 1;
  LinkedQueryYIELD.Value := PrevYield;
  LinkedQueryMETH_MEAS.Value := PrevMeth;
  LinkedQueryINFO_SOURC.Value := PrevInfoSource;
end;

procedure TAquiferForm.LinkedQueryValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound(Sender.LookupKeyFields, Sender.AsString);
end;

procedure TAquiferForm.LinkedQueryUpperSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TAquiferForm.LinkedQueryYIELDGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value <> NULL then
  begin
    if Sender.AsFloat * VolumeFactor * TimeFactor > 100000 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 0)
    else
    if Sender.AsFloat * VolumeFactor * TimeFactor = 0 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 2)
    else
    if Sender.AsFloat * VolumeFactor * TimeFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * VolumeFactor * TimeFactor, ffFixed, 15, 2);
  end
  else
    DisplayText := False;
end;

procedure TAquiferForm.LinkedQueryYIELDSetText(Sender: TField;
  const aText: string);
begin
  if aText <> '' then
    Sender.AsFloat := StrToFloat(aText)/VolumeFactor/TimeFactor;
end;

procedure TAquiferForm.AMSLCheckBoxClick(Sender: TObject);
begin
  inherited;
  LinkedQuery.Refresh;
end;

procedure TAquiferForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption + ' - Depth [' + LengthUnit + '], progressive Yield ' + DisUnit;
end;

procedure TAquiferForm.LinkedQueryYIELDValidate(Sender: TField);
begin
  if (LinkedQuery.RecordCount > 1) and (LinkedQuery.RecNo > 1) then
  with ValidateYieldQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT YIELD FROM aquifer_ WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite) + ' AND DEPTH_BOT < ' + FloatToStr(LinkedQueryDEPTH_BOT.AsFloat));
    Open;
    Last;
    PrevYield := Fields[0].Value;
    Close;
  end;
  if LinkedQuery.RecNo > 1 then
    ValidFound := LinkedQueryYIELD.Value >= PrevYield;
end;

end.
