{ Copyright (C) 2022 Immo Blecher immo@blecher.co.za

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
unit Meteor1;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, TabDetl, Menus, Db,
  DBCtrls, LCLtype, Buttons, ExtCtrls, StdCtrls, MaskEdit, ComCtrls, DBGrids,
  XMLPropStorage, ZDataset, rxlookup;

type

  { TMeteorologyForm1 }

  TMeteorologyForm1 = class(TTabbedMastDetailForm)
    GraphSpeedButton: TSpeedButton;
    ZQuery1DATE_MEAS: TStringField;
    ZQuery1INFO_SOURC: TStringField;
    ZQuery1READING: TFloatField;
    ZQuery1REP_INST: TStringField;
    ZQuery1SITE_ID_NR: TStringField;
    ZQuery1TIME_MEAS: TStringField;
    ZQuery2DATE_MEAS: TStringField;
    ZQuery2INFO_SOURC: TStringField;
    ZQuery2READING: TFloatField;
    ZQuery2REP_INST: TStringField;
    ZQuery2SITE_ID_NR: TStringField;
    ZQuery2TIME_MEAS: TStringField;
    ZQuery3CONDITIONS: TStringField;
    ZQuery3DATE_MEAS: TStringField;
    ZQuery3INFO_SOURC: TStringField;
    ZQuery3READING: TFloatField;
    ZQuery3REP_INST: TStringField;
    ZQuery3SITE_ID_NR: TStringField;
    ZQuery3TIME_MEAS: TStringField;
    procedure BasicinfDataSourceDataChange(Sender: TObject; Field: TField);
    procedure PageControlEnter(Sender: TObject);
    procedure TableREP_INSTValidate(Sender: TField);
    procedure TableINFO_SOURCValidate(Sender: TField);
    procedure TableUpperSetText(Sender: TField; const aText: String);
    procedure TableDATEValidate(Sender: TField);
    procedure TableTIMEValidate(Sender: TField);
    procedure TableNewRecord(DataSet: TDataSet);
    procedure TableREADINGSetText(Sender: TField; const aText: String);
    procedure TableREADINGGetText(Sender: TField; var aText: String;
      DisplayText: Boolean);
    procedure GraphSpeedButtonClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ZQuery1AfterPost(DataSet: TDataSet);
    procedure ZQuery2AfterPost(DataSet: TDataSet);
    procedure ZQuery3AfterPost(DataSet: TDataSet);
    procedure ZQueryAfterRefresh(DataSet: TDataSet);
    procedure ZQueryAfterInsert(DataSet: TDataSet);
    procedure ZQueryMeteoNewRecord(DataSet: TDataSet);
    procedure ZQueryMeteoBeforeInsert(DataSet: TDataSet);
    procedure ZQueryBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    PrevDate, PrevInfoSource, PrevRepInst: String;
  public
    { Public declarations }
  end;

var
  MeteorologyForm1: TMeteorologyForm1;

implementation

{$R *.lfm}

uses Strdatetime, varinit, Timedept, MainDataModule;

procedure TMeteorologyForm1.TableINFO_SOURCValidate(Sender: TField);
begin
  inherited;
  ValidFound := DataModuleMain.LookupValidFound('IS_METEO', Sender.AsString);
end;

procedure TMeteorologyForm1.TableREP_INSTValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('REP_INST', Sender.AsString);
end;

procedure TMeteorologyForm1.BasicinfDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  PageControl.Enabled := (DataModuleMain.BasicinfQuerySITE_TYPE.Value = 'N');
  LinkedLabel.Enabled := PageControl.Enabled;
  DetailNavigator.Enabled := PageControl.Enabled;
  if not DetailNavigator.Enabled then
    ShowMessage('This Site Type does not suggest Meteorology readings!');
end;

procedure TMeteorologyForm1.PageControlEnter(Sender: TObject);
begin
  inherited;
  case PageControl.ActivePageIndex of
    0: GraphSpeedButton.Enabled := ZQuery1.RecordCount > 1;
    1: GraphSpeedButton.Enabled := ZQuery2.RecordCount > 1;
    2: GraphSpeedButton.Enabled := ZQuery3.RecordCount > 1;
  end;
end;

procedure TMeteorologyForm1.TableUpperSetText(Sender: TField; const aText: String);
begin
  inherited;
  Sender.AsString := UpperCase(aText);
end;

procedure TMeteorologyForm1.TableDATEValidate(Sender: TField);
begin
  inherited;
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TMeteorologyForm1.TableTIMEValidate(Sender: TField);
begin
  inherited;
  ValidFound := not Sender.IsNull and ValidTime(Sender.Value);
end;

procedure TMeteorologyForm1.TableNewRecord(DataSet: TDataSet);
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

procedure TMeteorologyForm1.TableREADINGSetText(Sender: TField;
  const aText: String);
begin
  inherited;
  Sender.AsFloat := StrToFloat(aText)/DiamFactor;
end;

procedure TMeteorologyForm1.TableREADINGGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then
    DisplayText := False
  else
    aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffGeneral, 15, 2);
end;

procedure TMeteorologyForm1.GraphSpeedButtonClick(Sender: TObject);
begin
  inherited;
  with TTimeDeptForm.Create(Application) do
  begin
    case PageControl.ActivePageIndex of
      0: begin
           TimeDeptTable[1] := 'RAINFALL';
           StartDate := StringToDate(ZQuery1DATE_MEAS.AsString);
           StartTime := StringToTime(ZQuery1TIME_MEAS.AsString);
         end;
      1: begin
           TimeDeptTable[1] := 'PAN_EVAP';
           StartDate := StringToDate(ZQuery2DATE_MEAS.AsString);
           StartTime := StringToTime(ZQuery2TIME_MEAS.AsString);
         end;
      2: begin
           TimeDeptTable[1] := 'HUMIDITY';
           StartDate := StringToDate(ZQuery3DATE_MEAS.AsString);
           StartTime := StringToTime(ZQuery3TIME_MEAS.AsString);
         end;
    end; //of case
    ShowModal;
  end;
end;

procedure TMeteorologyForm1.PageControlChange(Sender: TObject);
begin
  inherited;
  case PageControl.ActivePageIndex of
    0: GraphSpeedButton.Enabled := ZQuery1.RecordCount > 1;
    1: GraphSpeedButton.Enabled := ZQuery2.RecordCount > 1;
    2: GraphSpeedButton.Enabled := ZQuery3.RecordCount > 1;
  end;
  GraphSpeedButton.Hint := 'Time dependent chart of ' + PageControl.ActivePage.Hint;
end;

procedure TMeteorologyForm1.FormActivate(Sender: TObject);
begin
  inherited;
  Tabsheet1.Caption := 'Rainfall [' + DiamUnit + ']';
  Tabsheet2.Caption := 'Pan Evaporation [' + DiamUnit + ']';
end;

procedure TMeteorologyForm1.ZQuery1AfterPost(DataSet: TDataSet);
begin
  inherited;
  GraphSpeedButton.Enabled := DataSet.RecordCount > 1;
end;

procedure TMeteorologyForm1.ZQuery2AfterPost(DataSet: TDataSet);
begin
  inherited;
  GraphSpeedButton.Enabled := DataSet.RecordCount > 1;
end;

procedure TMeteorologyForm1.ZQuery3AfterPost(DataSet: TDataSet);
begin
  inherited;
  GraphSpeedButton.Enabled := DataSet.RecordCount > 1;
end;

procedure TMeteorologyForm1.ZQueryAfterRefresh(DataSet: TDataSet);
begin
  GraphSpeedButton.Enabled := DataSet.RecordCount > 1;
end;

procedure TMeteorologyForm1.ZQueryAfterInsert(DataSet: TDataSet);
begin
  GraphSpeedButton.Enabled := DataSet.RecordCount > 1;
end;

procedure TMeteorologyForm1.ZQueryMeteoNewRecord(DataSet: TDataSet);
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

procedure TMeteorologyForm1.ZQueryMeteoBeforeInsert(DataSet: TDataSet);
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

procedure TMeteorologyForm1.ZQueryBeforeOpen(DataSet: TDataSet);
begin
  TZQuery(DataSet).Params[0].AsString := CurrentSite;
end;

end.
