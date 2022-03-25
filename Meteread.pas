{ Copyright (C) 2022 Immo Blecher, immo@blecher.co.za

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
unit Meteread;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ZDataset,
  MastDetl, Menus, Db, DBCtrls, ExtCtrls, Buttons, LCLtype, StdCtrls,
  DBGrids, MaskEdit;

type

  { TMeterReadingForm }

  TMeterReadingForm = class(TMasterDetailForm)
    LinkedQueryCOMMENT: TStringField;
    LinkedQueryDATE_ENTRY: TStringField;
    LinkedQueryDATE_MEAS: TStringField;
    LinkedQueryREADING: TFloatField;
    LinkedQueryREP_INST: TStringField;
    LinkedQuerySOURCE: TStringField;
    LinkedQueryTIME_MEAS: TStringField;
    LinkedQueryTYPE_MEAS: TStringField;
    LinkedQueryUNIT_MEAS: TStringField;
    MeterQuery: TZReadOnlyQuery;
    MeterQueryREADING: TFloatField;
    MeterQuerySITE_ID_NR: TStringField;
    procedure ChartSpeedButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure LinkedQueryAfterPost(DataSet: TDataSet);
    procedure LinkedQueryBeforeInsert(DataSet: TDataSet);
    procedure LinkedQueryDATE_MEASSetText(Sender: TField; const aText: string);
    procedure LinkedQueryDATE_MEASValidate(Sender: TField);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQuerySetText(Sender: TField; const aText: string);
    procedure LinkedQuerySOURCEValidate(Sender: TField);
    procedure LinkedQueryTIME_MEASSetText(Sender: TField; const aText: string);
    procedure LinkedQueryTIME_MEASValidate(Sender: TField);
    procedure LinkedQueryTYPE_MEASValidate(Sender: TField);
    procedure LinkedQueryUNIT_MEASValidate(Sender: TField);
    procedure MeterQueryBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    PrevInfoSource, PrevRepInst, PrevDate, PrevTime: ShortString;
    PrevFlowReading, PrevTimeReading, NewFlowReading, NewTimeReading: Double;
    DischargeRate: Double;
    TimeEntered, FlowEntered, SaveAll: Boolean;
  public
    { Public declarations }
  end;

var
  MeterReadingForm: TMeterReadingForm;

implementation

uses varinit, strdatetime, Timedept, MainDataModule;

{$R *.lfm}

procedure TMeterReadingForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption;
end;

procedure TMeterReadingForm.ChartSpeedButtonClick(Sender: TObject);
begin
  inherited;
  with TTimeDeptForm.Create(Application) do
  begin
    StartDate := StringToDate(LinkedQueryDATE_MEAS.AsString);
    StartTime := StringToTime(LinkedQueryTIME_MEAS.AsString);
    TimeDeptTable[1] := 'MREADING';
    CheckBoxReset1.Checked := True;
    ShowModal;
  end;
end;

procedure TMeterReadingForm.LinkedQueryAfterPost(DataSet: TDataSet);
begin
  if DataSet.State = dsInsert then
  begin
    if LinkedQueryTYPE_MEAS.Value = 'M' then
    begin
      NewFlowReading := LinkedQueryREADING.Value;
      with MeterQuery do
      begin
        Filter := 'TYPE_MEAS = ''M''';
        Open;
        Last;
        Prior;
      end;
      PrevFlowReading := MeterQueryREADING.Value;
      MeterQuery.Close;
      FlowEntered := True;
    end
    else
    if LinkedQueryTYPE_MEAS.Value = 'T' then
    begin
      NewTimeReading := LinkedQueryREADING.Value;
      with MeterQuery do
      begin
        Open;
        Filter := 'TYPE_MEAS = ''T''';
        Refresh;
        Last;
        Prior;
      end;
      PrevTimeReading := MeterQueryREADING.Value;
      MeterQuery.Close;
      TimeEntered := True;
    end;
    if FlowEntered and TimeEntered then
    begin
      if NewTimeReading - PrevTimeReading <> 0 then
        DischargeRate := (NewFlowReading - PrevFlowReading) * 1000/((NewTimeReading - PrevTimeReading) * 3600)
      else
        DischargeRate := 0;
      if not SaveAll and (MessageDlg('Do you want to save the calculated discharge rate of '
        + FloatToStrF(DischargeRate, ffFixed, 15, 3) + ' l/s and all further calculated rates during this session to the discharge rate table?',
          mtConfirmation, [mbYes, mbNo], 0) = mrYes) then SaveAll := True;
      if SaveAll then
      begin
        DataModuleMain.ZConnectionDB.ExecuteDirect('INSERT INTO discharg (SITE_ID_NR, REP_INST, INFO_SOURC, DISCH_TYPE, METH_MEAS, DATE_MEAS, TIME_MEAS, DISCH_RATE) VALUES('
          + QuotedStr(LinkedQuerySITE_ID_NR.AsString) + ', ' + QuotedStr(LinkedQueryREP_INST.AsString) +  ', ' + QuotedStr(LinkedQuerySOURCE.AsString) + ', ' + QuotedStr('P') + ', '
            + QuotedStr('M') + ', ' + QuotedStr(LinkedQueryDATE_MEAS.AsString) + ', ' + QuotedStr(LinkedQueryTIME_MEAS.AsString) + ', ' + FloatToStr(DischargeRate) + ');');
      end;
      FlowEntered := False;
      TimeEntered := False;
    end;
  end
  else
  if (DataSet.State = dsEdit) and SaveAll then
    MessageDlg('The discharge table cannot be updated automatically with the edits! Change discharge rates manually.',
      mtWarning, [mbOK], 0);
end;

procedure TMeterReadingForm.LinkedQueryBeforeInsert(DataSet: TDataSet);
begin
  PrevRepInst := LinkedQueryREP_INST.Value;
  PrevInfoSource := LinkedQuerySOURCE.Value;
  PrevDate := LinkedQueryDATE_MEAS.Value;
  PrevTime := LinkedQueryTIME_MEAS.Value;
end;

procedure TMeterReadingForm.LinkedQueryDATE_MEASSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := aText;
end;

procedure TMeterReadingForm.LinkedQueryDATE_MEASValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TMeterReadingForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  LinkedQueryREP_INST.Value := PrevRepInst;
  LinkedQuerySOURCE.Value := PrevInfoSource;
  LinkedQueryDATE_ENTRY.ReadOnly := False;
  LinkedQueryDATE_ENTRY.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryDATE_ENTRY.ReadOnly := True;
  if PrevDate = '' then
    LinkedQueryDATE_MEAS.Value := FormatDateTime('YYYYMMDD', Date)
  else
    LinkedQueryDATE_MEAS.Value := PrevDate;
  if PrevTime = '' then
    LinkedQueryTIME_MEAS.Value := FormatDateTime('hhnn', Time)
  else
    LinkedQueryTIME_MEAS.Value := PrevTime;
end;

procedure TMeterReadingForm.LinkedQuerySetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TMeterReadingForm.LinkedQuerySOURCEValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('IS_BASIC', Sender.AsString);
end;

procedure TMeterReadingForm.LinkedQueryTIME_MEASSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := aText;
end;

procedure TMeterReadingForm.LinkedQueryTIME_MEASValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidTime(Sender.Value);
end;

procedure TMeterReadingForm.LinkedQueryTYPE_MEASValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('TYPEMEAS', Sender.AsString);
end;

procedure TMeterReadingForm.LinkedQueryUNIT_MEASValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('UNITMEAS', Sender.AsString);
end;

procedure TMeterReadingForm.MeterQueryBeforeOpen(DataSet: TDataSet);
begin
  LinkedQuery.Params[0].AsString := CurrentSite;
end;

end.
