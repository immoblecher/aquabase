{ Copyright (C) 2024 Immo Blecher immo@blecher.co.za

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
unit Meteor2;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, TabDetl, Menus, Db,
  DBCtrls, ZDataset, Buttons, ExtCtrls, StdCtrls, MaskEdit, ComCtrls,
  DBGrids;

type

  { TMeteorologyForm2 }

  TMeteorologyForm2 = class(TTabbedMastDetailForm)
    GraphSpeedButton: TSpeedButton;
    ZQuery1SITE_ID_NR: TStringField;
    ZQuery1INFO_SOURC: TStringField;
    ZQuery1DATE_MEAS: TStringField;
    ZQuery1TIME_MEAS: TStringField;
    ZQuery1READING: TFloatField;
    ZQuery1REP_INST: TStringField;
    ZQuery1READ_TYPE: TStringField;
    ZQuery2SITE_ID_NR: TStringField;
    ZQuery2REP_INST: TStringField;
    ZQuery2INFO_SOURC: TStringField;
    ZQuery2DATE_MEAS: TStringField;
    ZQuery2TIME_MEAS: TStringField;
    ZQuery2READING: TFloatField;
    ZQuery3DATE_MEAS: TStringField;
    ZQuery3INFO_SOURC: TStringField;
    ZQuery3READING: TFloatField;
    ZQuery3REP_INST: TStringField;
    ZQuery3SITE_ID_NR: TStringField;
    ZQuery3SITE_ID_NR2: TStringField;
    ZQuery3REP_INST2: TStringField;
    ZQuery3INFO_SOURC2: TStringField;
    ZQuery3DATE_MEAS2: TStringField;
    ZQuery3TIME_MEAS: TStringField;
    ZQuery3TIME_MEAS2: TStringField;
    ZQuery3READING2: TFloatField;
    ZQuery4SITE_ID_NR: TStringField;
    ZQuery4REP_INST: TStringField;
    ZQuery4INFO_SOURC: TStringField;
    ZQuery4DATE_MEAS: TStringField;
    ZQuery4TIME_MEAS: TStringField;
    ZQuery4READING: TFloatField;
    ZQuery4DIRECTION: TFloatField;
    ChangeQuery: TZQuery;
    LookupTableused_for: TStringField;
    LookupTablesearch: TStringField;
    SpeedButtonWind: TSpeedButton;
    procedure BasicinfDataSourceDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure PageControlEnter(Sender: TObject);
    procedure ZQueryAfterRefresh(DataSet: TDataSet);
    procedure ZQueryAfterInsert(DataSet: TDataSet);
    procedure ZQueryBeforeOpen(DataSet: TDataSet);
    procedure ZQueryMeteoNewRecord(DataSet: TDataSet);
    procedure ZQuery4DIRECTIONValidate(Sender: TField);
    procedure TableDATEValidate(Sender: TField);
    procedure TableTIMEValidate(Sender: TField);
    procedure TableINFO_SOURCValidate(Sender: TField);
    procedure TableREP_INSTValidate(Sender: TField);
    procedure TableUpperSetText(Sender: TField; const aText: string);
    procedure ZQueryMeteoBeforeInsert(DataSet: TDataSet);
    procedure ZQuery4READINGSetText(Sender: TField; const aText: String);
    procedure ZQuery4READINGGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure ZQuery1READ_TYPEValidate(Sender: TField);
    procedure PageControlChange(Sender: TObject);
    procedure GraphSpeedButtonClick(Sender: TObject);
    procedure ZQuery2READINGGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure ZQuery2READINGSetText(Sender: TField; const aText: String);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    PrevDate, PrevInfoSource, PrevRepInst: String;
  public
    { Public declarations }
  end;

var
  MeteorologyForm2: TMeteorologyForm2;

implementation

{$R *.lfm}

uses Strdatetime, Varinit, Timedept, MainDataModule;

procedure TMeteorologyForm2.ZQuery4DIRECTIONValidate(Sender: TField);
begin
  ValidFound := (Sender.AsFloat >= 0) and (Sender.AsFloat <= 360);
end;

procedure TMeteorologyForm2.ZQueryMeteoNewRecord(DataSet: TDataSet);
begin
  inherited;
  DataSet.FindField('REP_INST').AsString := PrevRepInst;
  DataSet.FindField('INFO_SOURC').AsString := PrevInfoSource;
  if PrevDate = '' then
    DataSet.FindField('DATE_MEAS').AsString := FormatDateTime('YYYYMMDD', Date)
  else
    DataSet.FindField('DATE_MEAS').AsString := PrevDate;
  DataSet.FindField('TIME_MEAS').AsString := FormatDateTime('hhnn', Time);
end;

procedure TMeteorologyForm2.ZQueryBeforeOpen(DataSet: TDataSet);
begin
  TZQuery(DataSet).Params[0].AsString := CurrentSite;
end;

procedure TMeteorologyForm2.BasicinfDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if not (DataModuleMain.BasicinfQuery.State IN [dsInsert, dsEdit]) then
  begin
    if not DataModuleMain.BasicinfQuerySITE_TYPE.IsNULL then
    PageControl.Enabled := (DataModuleMain.BasicinfQuerySITE_TYPE.Value = 'N');
    if PageControl.Enabled = True then
    begin
      LinkedLabel.Enabled := True;
      DetailNavigator.Enabled := True;
    end
    else if Showing then
      ShowMessage('This site type does not seem to allow meteorology readings!');
  end;
end;

procedure TMeteorologyForm2.FormCreate(Sender: TObject);
begin
  inherited;
  if not (DataModuleMain.BasicinfQuery.State IN [dsInsert, dsEdit]) then
  begin
    if not DataModuleMain.BasicinfQuerySITE_TYPE.IsNULL then
    PageControl.Enabled := (DataModuleMain.BasicinfQuerySITE_TYPE.Value = 'N');
    if PageControl.Enabled = True then
    begin
      LinkedLabel.Enabled := True;
      DetailNavigator.Enabled := True;
    end
    else
      ShowMessage('This site type does not seem to allow meteorology readings!');
  end;
end;

procedure TMeteorologyForm2.PageControlEnter(Sender: TObject);
begin
  inherited;
  case PageControl.ActivePageIndex of
    0: GraphSpeedButton.Enabled := ZQuery1.RecordCount > 1;
    1: GraphSpeedButton.Enabled := ZQuery2.RecordCount > 1;
    2: GraphSpeedButton.Enabled := ZQuery3.RecordCount > 1;
    3: GraphSpeedButton.Enabled := ZQuery4.RecordCount > 1;
  end;
end;

procedure TMeteorologyForm2.ZQueryAfterRefresh(DataSet: TDataSet);
begin
  GraphSpeedButton.Enabled := DataSet.RecordCount > 1;
end;

procedure TMeteorologyForm2.ZQueryAfterInsert(DataSet: TDataSet);
begin
  GraphSpeedButton.Enabled := DataSet.RecordCount > 1;
end;

procedure TMeteorologyForm2.TableDATEValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TMeteorologyForm2.TableTIMEValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidTime(Sender.Value);
end;

procedure TMeteorologyForm2.TableINFO_SOURCValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('IS_METEO', Sender.AsString);
end;

procedure TMeteorologyForm2.TableREP_INSTValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('REP_INST', Sender.AsString);
end;

procedure TMeteorologyForm2.TableUpperSetText(Sender: TField;
  const aText: string);
begin
  Sender.AsString := UpperCase(aText);
end;

procedure TMeteorologyForm2.ZQueryMeteoBeforeInsert(DataSet: TDataSet);
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

procedure TMeteorologyForm2.ZQuery4READINGSetText(Sender: TField;
  const aText: String);
begin
  inherited;
  ZQuery4READING.AsFloat := StrToFloat(aText)/(LengthFactor/TimeFactor);
end;

procedure TMeteorologyForm2.ZQuery4READINGGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then
    DisplayText := False
  else
    aText := FloatToStrF(Sender.AsFloat * LengthFactor * TimeFactor, ffFixed, 15, 2);
end;

procedure TMeteorologyForm2.ZQuery1READ_TYPEValidate(Sender: TField);
begin
  inherited;
  ValidFound := DataModuleMain.LookupValidFound('READTYPE', Sender.AsString);
end;

procedure TMeteorologyForm2.PageControlChange(Sender: TObject);
begin
  inherited;
  case PageControl.ActivePageIndex of
    0: GraphSpeedButton.Enabled := ZQuery1.RecordCount > 1;
    1: GraphSpeedButton.Enabled := ZQuery2.RecordCount > 1;
    2: GraphSpeedButton.Enabled := ZQuery3.RecordCount > 1;
    3: begin
         GraphSpeedButton.Enabled := ZQuery4.RecordCount > 1;
         SpeedButtonWind.Enabled := ZQuery4.RecordCount > 0;
       end;
  end;
  GraphSpeedButton.Hint := 'Time dependent chart of ' + PageControl.ActivePage.Hint;
end;

procedure TMeteorologyForm2.GraphSpeedButtonClick(Sender: TObject);
begin
  inherited;
  with TTimeDeptForm.Create(Application) do
  begin
    case PageControl.ActivePage.TabIndex of
      0: begin
           StartDate := StringToDate(ZQuery1DATE_MEAS.AsString);
           StartTime := StringToTime(ZQuery1TIME_MEAS.AsString);
           TimeDeptTable[1] := 'AIR_TEMP';
         end;
      1: begin
           StartDate := StringToDate(ZQuery2DATE_MEAS.AsString);
           StartTime := StringToTime(ZQuery2TIME_MEAS.AsString);
           TimeDeptTable[1] := 'PRESSURE';
         end;
      2: begin
           StartDate := StringToDate(ZQuery3DATE_MEAS.AsString);
           StartTime := StringToTime(ZQuery3TIME_MEAS.AsString);
           TimeDeptTable[1] := 'SOLARADI';
         end;
      3: begin
           StartDate := StringToDate(ZQuery4DATE_MEAS.AsString);
           StartTime := StringToTime(ZQuery4TIME_MEAS.AsString);
           TimeDeptTable[1] := 'WINDVDIR';
         end;
    end; //of case
    ShowModal;
  end;
end;

procedure TMeteorologyForm2.ZQuery2READINGGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if PressureFactor <= 0.0001 then
      aText := FloatToStrF(Sender.AsFloat * PressureFactor, ffFixed, 15, 3)
    else
      aText := FloatToStrF(Sender.AsFloat * PressureFactor, ffFixed, 15, 2);
  end;
end;

procedure TMeteorologyForm2.ZQuery2READINGSetText(Sender: TField; const aText: String);
begin
  inherited;
  Sender.AsFloat := StrToFloat(aText)/PressureFactor;
end;

procedure TMeteorologyForm2.FormActivate(Sender: TObject);
begin
  inherited;
  Tabsheet2.Caption := 'Atmospheric Pressure [' + PressureUnit + ']';
  Tabsheet4.Caption := 'Wind Velocity [' + LengthUnit + '/' + TimeUnit + ']/Direction [°]';
end;

end.
