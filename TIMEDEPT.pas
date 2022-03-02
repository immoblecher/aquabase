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
unit TIMEDEPT;

{$mode objfpc}{$H+}

interface

uses Classes, Graphics, Forms, Controls, Buttons, DateTimePicker, ZDataset,
  StdCtrls, ExtCtrls, ButtonPanel, SysUtils, Dialogs, ComCtrls, math, db,
  LCLType;

type

  { TTimeDeptForm }

  TTimeDeptForm = class(TForm)
    AggregateRadioGroup1: TRadioGroup;
    AggregateRadioGroup2: TRadioGroup;
    AggregateRadioGroup3: TRadioGroup;
    AggregateRadioGroup4: TRadioGroup;
    ButtonPanel1: TButtonPanel;
    CheckBoxLimits1: TCheckBox;
    CheckBoxLimits2: TCheckBox;
    CheckBoxLimits3: TCheckBox;
    CheckBoxLimits4: TCheckBox;
    CheckBoxUseElev1: TCheckBox;
    CheckBoxCum1: TCheckBox;
    CheckBoxCum2: TCheckBox;
    CheckBoxCum3: TCheckBox;
    CheckBoxCum4: TCheckBox;
    CheckBoxReset1: TCheckBox;
    CheckBoxReset2: TCheckBox;
    CheckBoxReset3: TCheckBox;
    CheckBoxReset4: TCheckBox;
    CheckBoxUseElev2: TCheckBox;
    CheckBoxUseElev3: TCheckBox;
    CheckBoxUseElev4: TCheckBox;
    ComboBoxData2: TComboBox;
    ComboBoxData3: TComboBox;
    ComboBoxData4: TComboBox;
    ComboBoxView1: TComboBox;
    ComboBoxData1: TComboBox;
    ComboBoxView2: TComboBox;
    ComboBoxView3: TComboBox;
    ComboBoxView4: TComboBox;
    DefinitionQuery: TZReadOnlyQuery;
    EditUnit1: TEdit;
    EditUnit2: TEdit;
    EditUnit3: TEdit;
    EditUnit4: TEdit;
    EndDateTimePicker1: TDateTimePicker;
    EndDateTimePicker2: TDateTimePicker;
    EndDateTimePicker3: TDateTimePicker;
    EndDateTimePicker4: TDateTimePicker;
    FilterFieldComboBox1: TComboBox;
    FilterFieldComboBox2: TComboBox;
    FilterFieldComboBox3: TComboBox;
    FilterFieldComboBox4: TComboBox;
    FilterValueComboBox1: TComboBox;
    FilterValueComboBox2: TComboBox;
    FilterValueComboBox3: TComboBox;
    FilterValueComboBox4: TComboBox;
    GroupBox1: TGroupBox;
    GroupBox10: TGroupBox;
    GroupBox11: TGroupBox;
    GroupBox12: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    PageControl3: TPageControl;
    StartDateTimePicker1: TDateTimePicker;
    StartDateTimePicker2: TDateTimePicker;
    StartDateTimePicker3: TDateTimePicker;
    StartDateTimePicker4: TDateTimePicker;
    TabSheetBotRight: TTabSheet;
    TabSheetBotLeft: TTabSheet;
    TabSheetTopRightAxis: TTabSheet;
    TabSheetTopChart: TTabSheet;
    TabSheetTopLeftAxis: TTabSheet;
    TabSheetBotChart: TTabSheet;
    TimeStepRadioGroup1: TRadioGroup;
    TimeStepRadioGroup2: TRadioGroup;
    TimeStepRadioGroup3: TRadioGroup;
    TimeStepRadioGroup4: TRadioGroup;
    TypeRadioGroup1: TRadioGroup;
    TypeRadioGroup2: TRadioGroup;
    TypeRadioGroup3: TRadioGroup;
    TypeRadioGroup4: TRadioGroup;
    ViewQuery: TZReadOnlyQuery;
    YComboBox1: TComboBox;
    YComboBox2: TComboBox;
    YComboBox3: TComboBox;
    YComboBox4: TComboBox;
    LookupQuery: TZReadOnlyQuery;
    AquasortQuery: TZReadOnlyQuery;
    procedure ComboBoxDataChange(Sender: TObject);
    procedure ComboBoxViewDropDown(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure TimeStepRadioGroupClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FilterFieldComboBoxChange(Sender: TObject);
    procedure FilterValueComboBoxChange(Sender: TObject);
    procedure YComboBoxChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    StartDate, StartTime: TDateTime;
    TimeDeptTable: Array[1..4] of ShortString;
  end;

var
  TimeDeptForm: TTimeDeptForm;

implementation

uses VARINIT, MainDataModule, timechart;

{$R *.lfm}

procedure TTimeDeptForm.TimeStepRadioGroupClick(Sender: TObject);
begin
  if (Sender as TRadioGroup).ItemIndex > 0 then
  begin
    (FindComponent('TypeRadioGroup' + IntToStr((Sender as TRadioGroup).Tag)) as TRadioGroup).Enabled := True;
    (FindComponent('AggregateRadioGroup' + IntToStr((Sender as TRadioGroup).Tag)) as TRadioGroup).Enabled := True;
  end
  else
  begin
    (FindComponent('TypeRadioGroup' + IntToStr((Sender as TRadioGroup).Tag)) as TRadioGroup).Enabled := False;
    (FindComponent('AggregateRadioGroup' + IntToStr((Sender as TRadioGroup).Tag)) as TRadioGroup).Enabled := False;
  end;
end;

procedure TTimeDeptForm.OKButtonClick(Sender: TObject);
var
  TheView, FilterField, DateField, TimeField, ChemTable: ShortString;
  LeftAxisTitle, RightAxisTitle, UnitMultiplier: ShortString;
  TheTitle: String;
  UseCurrent: Array[1..4] of Boolean;
  IsChem: Boolean;
  c, DateLength: Byte;
  SpecTimeChartForm: TTimeChartForm;
begin
  SpecTimeChartForm := TTimeChartForm.Create(Application);
  for c := 1 to 4 do //for the 4 axes
  if (FindComponent('ComboBoxData' + IntToStr(c)) as TComboBox).ItemIndex > 0 then
  begin //create a chart from the time dept. data
    if (c = 1) or (c = 3) then //reset the title
      TheTitle := '';
    //check view or current site
    if (FindComponent('ComboBoxView' + IntToStr(c)) as TComboBox).ItemIndex = 0 then
    begin
      TheView := 'allsites';
      UseCurrent[c] := True;
    end
    else
    begin
      TheView := (FindComponent('ComboBoxView' + IntToStr(c)) as TComboBox).Text;
      UseCurrent[c] := False;
    end;
    //check if time dept is chemistry and set date/time fields
    IsChem := InRange((FindComponent('ComboBoxData' + IntToStr(c)) as TComboBox).ItemIndex, 3, 8) or
      ((FindComponent('ComboBoxData' + IntToStr(c)) as TComboBox).ItemIndex = 23);
    AquaSortQuery.Locate('TIME_ID', (FindComponent('ComboBoxData' + IntToStr(c)) as TComboBox).ItemIndex, []);
    DateField := AquaSortQuery.FieldByName('DATE').AsString;
    TimeField := AquaSortQuery.FieldByName('TIME').AsString;
    with SpecTimeChartForm.FindComponent('QueryXY' + IntToStr(c)) as TZReadOnlyQuery do
    begin
      FilterField := (Self.FindComponent('FilterFieldComboBox' + IntToStr(c)) as TComboBox).Text;
      if (FilterField = '') or (FilterField = '<none>') then
      begin
        FilterField := 'NULL';
        Filter := '';
        Filtered := False;
      end
      else
      if (FilterField = 'DEPTH') then
      begin
        FilterField := 'd.DEPTH'; //to prevent ambigeous field in basicinf
        Filter := 'THEFILTER = ' + (Self.FindComponent('FilterValueComboBox' + IntToStr(c)) as TComboBox).Text;
        Filtered := True;
      end
      else
      if (FilterField = 'PIEZOM_NR') and ((Self.FindComponent('FilterValueComboBox' + IntToStr(c)) as TComboBox).Text = '<All>') then
      begin
        Filter := 'THEFILTER >= ' + QuotedStr('0');
        Filtered := True;
      end
      else
      begin
        Filter := 'THEFILTER = ' + QuotedStr((Self.FindComponent('FilterValueComboBox' + IntToStr(c)) as TComboBox).Text);
        Filtered := True;
      end;
      with SQL do //set up the query
      begin
        if (Self.FindComponent('TimeStepRadioGroup' + IntToStr(c)) as TRadioGroup).ItemIndex = 0 then //exact
        begin
          if (Self.FindComponent('CheckBoxUseElev' + IntToStr(c)) as TCheckBox).Checked then
            Add('SELECT v.SITE_ID_NR, b.NR_ON_MAP, b.ALTITUDE, ' + FilterField + ' THEFILTER, ' + DateField + ' THEDATE, ' + TimeField + ' THETIME, ALTITUDE-' + (Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text + ' THEVALUE FROM ' + TheView + ' v')
          else
          if IsChem then
          begin
            if (Self.FindComponent('ComboBoxData' + IntToStr(c)) as TComboBox).ItemIndex = 23 then
              Add('SELECT v.SITE_ID_NR, b.NR_ON_MAP, d.CHM_REF_NR CHEMREF, ' + FilterField + ' THEFILTER, ' + DateField + ' THEDATE, ' + TimeField + ' THETIME, READING THEVALUE FROM ' + TheView + ' v')
            else
              Add('SELECT v.SITE_ID_NR, b.NR_ON_MAP, d.CHM_REF_NR CHEMREF, ' + FilterField + ' THEFILTER, ' + DateField + ' THEDATE, ' + TimeField + ' THETIME, ' + (Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text + ' THEVALUE FROM ' + TheView + ' v');
          end
          else
            Add('SELECT v.SITE_ID_NR, b.NR_ON_MAP, b.ALTITUDE, ' + FilterField + ' THEFILTER, ' + DateField + ' THEDATE, ' + TimeField + ' THETIME, ' + (Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text + ' THEVALUE FROM ' + TheView + ' v')
        end
        else //Aggregates
        begin
          DateLength := 8;
          case (Self.FindComponent('TimeStepRadioGroup' + IntToStr(c)) as TRadioGroup).ItemIndex of
            1: DateLength := 8; //daily
            2: DateLength := 6; //monthly
            3: DateLength := 4; //annually
          end; //of case
          if (Self.FindComponent('CheckBoxUseElev' + IntToStr(c)) as TCheckBox).Checked then
            Add('SELECT v.SITE_ID_NR, b.NR_ON_MAP, b.ALTITUDE, ' + FilterField + '  THEFILTER, ' + DateField + ' THEDATE, ' + TimeField + ' THETIME, MIN(ALTITUDE-' + (Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text + ') MINIMUM, MAX(ALTITUDE-' + (Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text + ') MAXIMUM, AVG(ALTITUDE-' + (Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text + ') AVERAGE, SUM(ALTITUDE-' + (Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text + ') SUMMED FROM '+ TheView + ' v')
          else
          if IsChem then
          begin
            if (Self.FindComponent('ComboBoxData' + IntToStr(c)) as TComboBox).ItemIndex = 23 then
              Add('SELECT v.SITE_ID_NR, b.NR_ON_MAP, d.CHM_REF_NR CHEMREF, ' + FilterField + '  THEFILTER, d.' + DateField + ' THEDATE, d.' + TimeField + ' THETIME, MIN(READING) MINIMUM, MAX(READING) MAXIMUM, AVG(READING) AVERAGE, SUM(READING) SUMMED FROM '+ TheView + ' v')
            else
              Add('SELECT v.SITE_ID_NR, b.NR_ON_MAP, d.CHM_REF_NR CHEMREF, ' + FilterField + '  THEFILTER, d.' + DateField + ' THEDATE, d.' + TimeField + ' THETIME, MIN(' + (Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text + ') MINIMUM, MAX(' + (Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text + ') MAXIMUM, AVG(' + (Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text + ') AVERAGE, SUM(' + (Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text + ') SUMMED FROM '+ TheView + ' v');
          end
          else
            Add('SELECT v.SITE_ID_NR, b.NR_ON_MAP, b.ALTITUDE, ' + FilterField + ' THEFILTER, SUBSTR(d.' + DateField + ', 1, ' + IntToStr(DateLength) + ') THEDATE, MIN(' + (Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text + ') MINIMUM, MAX(' + (Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text + ') MAXIMUM, AVG(' + (Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text + ') AVERAGE, SUM(' + (Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text + ') SUMMED FROM '+ TheView + ' v');
        end;
        Add('JOIN basicinf b ON (b.SITE_ID_NR = v.SITE_ID_NR)');
        if UseCurrent[c] then
          Add('AND b.SITE_ID_NR = ' + QuotedStr(CurrentSite));
        Add('JOIN ' + TimeDeptTable[c]  + ' d ON (d.SITE_ID_NR = v.SITE_ID_NR)');
        //check for chemistry and add relevant table
        if TimeDeptTable[c] = 'chem_000' then
        begin
          if (Self.FindComponent('ComboBoxData' + IntToStr(c)) as TComboBox).ItemIndex = 23 then
            ChemTable := 'userchem'
          else
            ChemTable := 'chem_00' + IntToStr((Self.FindComponent('ComboBoxData' + IntToStr(c)) as TComboBox).ItemIndex - 2);
          Add('JOIN ' + ChemTable + ' d1 ON (d1.CHM_REF_NR = d.CHM_REF_NR)');
          //make sure only value > -1 extracted
          if (Self.FindComponent('ComboBoxData' + IntToStr(c)) as TComboBox).ItemIndex = 23 then
          begin
            Add('AND d1.READING > -1');
            Add('AND CPARAMETER = ' + QuotedStr((Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text));
          end
          else
            Add('AND d1.' + (Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text + ' > -1');
        end;
        if DataModuleMain.ZConnectionDB.Tag = 1 then
        begin
          Add('AND d.' + DateField + ' || d.' + TimeField + ' >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', (Self.FindComponent('StartDateTimePicker' + IntToStr(c)) as TDateTimePicker).DateTime)));
          Add('AND d.' + DateField + ' || d.' + TimeField + ' <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', (Self.FindComponent('EndDateTimePicker' + IntToStr(c)) as TDateTimePicker).DateTime)));
        end
        else
        begin
          Add('AND CONCAT(d.' + DateField + ', d.' + TimeField + ') >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', (Self.FindComponent('StartDateTimePicker' + IntToStr(c)) as TDateTimePicker).DateTime)));
          Add('AND CONCAT(d.' + DateField + ', d.' + TimeField + ') <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', (Self.FindComponent('EndDateTimePicker' + IntToStr(c)) as TDateTimePicker).DateTime)));
        end;
        if (Self.FindComponent('TimeStepRadioGroup' + IntToStr(c)) as TRadioGroup).ItemIndex > 0 then
        begin
          Add('GROUP BY v.SITE_ID_NR, b.NR_ON_MAP, b.ALTITUDE, THEFILTER, THEDATE');
          Add('ORDER BY v.SITE_ID_NR, THEFILTER, THEDATE');
        end
        else
        begin
          if FilterField = 'NULL' then
            Add('ORDER BY v.SITE_ID_NR, THEDATE, THETIME')
          else
            Add('ORDER BY v.SITE_ID_NR, THEFILTER, THEDATE, THETIME');
        end;
      end;
    end;
    with SpecTimeChartForm do
    begin
      TimeStep[c] := (Self.FindComponent('TimeStepRadioGroup' + IntToStr(c)) as TRadioGroup).ItemIndex;
      SeriesType[c] := (Self.FindComponent('TypeRadioGroup' + IntToStr(c)) as TRadioGroup).ItemIndex;
      Aggregate[c] := (Self.FindComponent('AggregateRadioGroup' + IntToStr(c)) as TRadioGroup).ItemIndex;
      //for chemistry
      if (TimeDeptTable[c] = 'chem_000') then
      begin
        ShowLimits[c] := (Self.FindComponent('CheckBoxLimits' + IntToStr(c)) as TCheckBox).Checked;
        ChemParam[c] := (Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text;
      end;
      //chart and axis titles and units
      if TheTitle = '' then
      begin
        TheTitle := 'Time dependent chart of ' + (Self.FindComponent('ComboBoxData' + IntToStr(c)) as TComboBox).Text;
        if IsChem then
          TheTitle := TheTitle + ': ' + (Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text;
      end
      else
      begin
        TheTitle := TheTitle + ' and ' + (Self.FindComponent('ComboBoxData' + IntToStr(c)) as TComboBox).Text;
        if IsChem then
          TheTitle := TheTitle + ': ' + (Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text;
      end;
      with AquaSortQuery do
      begin
        if IsChem then
        case c of
          1, 3: LeftAxisTitle := (Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text;
          2, 4: RightAxisTitle := (Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text;
        end //of case
        else
        begin
          Locate('FILE_NAME', UpperCase(TimeDeptTable[c]), []);
          case c of
            1, 3: LeftAxisTitle := FieldByName('Y_AXISTITLE_TIME').Value;
            2, 4: RightAxisTitle := FieldByName('Y_AXISTITLE_TIME').Value;
          end; //of case
        end;
        UnitMultiplier := FieldByName('UNITYVAL_TIME').AsString;
      end;
      //sort out the units
      if UnitMultiplier = 'LENGTHUNIT' then
      begin
        if (TimeDeptTable[c] = 'waterlev') and (not (Self.FindComponent('CheckBoxUseElev' + IntToStr(c)) as TCheckbox).Checked) then
          TheFactor[c] := -LengthFactor //negative water levels
        else
          TheFactor[c] := LengthFactor;
      end
      else
      if UnitMultiplier = 'DISUNIT' then
      begin
        TheFactor[c] := VolumeFactor * TimeFactor;
      end
      else
      if UnitMultiplier = 'DIAMUNIT' then
      begin
        TheFactor[c] := DiamFactor;
      end
      else
      if UnitMultiplier = 'PRESSUREUNIT' then
      begin
        TheFactor[c] := PressureFactor;
      end
      else
      if UnitMultiplier = 'SPEEDUNIT' then
      begin
        TheFactor[c] := LengthFactor * TimeFactor;
      end
      else
      if UnitMultiplier = 'CHEMUNIT' then
      begin
        //sort out chemistry units
        if (Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text = 'PH' then
          TheFactor[c] := 1
        else
        if (Self.FindComponent('YComboBox' + IntToStr(c)) as TComboBox).Text = 'EC' then
        begin
          TheFactor[c] := ECFactor;
        end
        else
        begin
          TheFactor[c] := ChemFactor;
        end;
      end
      else
      if UnitMultiplier = '<various>' then
      begin
        //sort out chemistry units in field measurements
        if (Self.FindComponent('FilterValueComboBox' + IntToStr(c)) as TComboBox).Text = 'P' then
          TheFactor[c] := 1
        else
        if (Self.FindComponent('FilterValueComboBox' + IntToStr(c)) as TComboBox).Text = 'T' then
          TheFactor[c] := 1
        else
        if (Self.FindComponent('FilterValueComboBox' + IntToStr(c)) as TComboBox).Text = 'C' then
        begin
          TheFactor[c] := ECFactor;
        end
        else
        begin
          TheFactor[c] := ChemFactor;
        end;
      end
      else
        TheFactor[c] := 1;
      //left and right axis unit labels
      case c of
        1, 3: LeftAxisTitle := LeftAxisTitle + ' [' + (Self.FindComponent('EditUnit' + IntToStr(c)) as TEdit).Caption + ']';
        2, 4: RightAxisTitle := RightAxisTitle + ' [' + (Self.FindComponent('EditUnit' + IntToStr(c)) as TEdit).Caption + ']';
      end;
      if (Self.FindComponent('ComboBoxData' + IntToStr(c)) as TComboBox).Tag < 3 then
      begin //top chart
        ChartTop.Title.Text.Clear;
        ChartTop.Title.Text.Add(TheTitle);
        ChartTop.LeftAxis.Title.Caption := LeftAxisTitle;
        ChartTop.AxisList[2].Title.Caption := RightAxisTitle;
      end
      else
      begin //bottom chart
        ChartBot.Title.Text.Clear;
        ChartBot.Title.Text.Add(TheTitle);
        ChartBot.LeftAxis.Title.Caption := LeftAxisTitle;
        ChartBot.AxisList[2].Title.Caption := RightAxisTitle;
      end;
    end;
  end;
  SpecTimeChartForm.Show;
end;

procedure TTimeDeptForm.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  with AquaSortQuery do
  begin
    SortedFields := 'TIME_ID';
    Filter := 'TIME_ID > 0';
    Filtered := True;
    Open;
  end;
  LookupQuery.Open;
end;

procedure TTimeDeptForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TTimeDeptForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TTimeDeptForm.ComboBoxDataChange(Sender: TObject);
var
  m: Integer;
begin
  ButtonPanel1.OKButton.Enabled := (ComboBoxData1.Text <> '<none>')
    or (ComboBoxData2.Text <> '<none>')
    or (ComboBoxData3.Text <> '<none>')
    or (ComboBoxData4.Text <> '<none>');
  case (Sender as TComboBox).ItemIndex of
    0: begin
         //no time dept table selected
       end;
    1: begin //Air temperature
         TimeDeptTable[(Sender as TComboBox).Tag] := 'air_temp';
         with (FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('READING');
           ItemIndex := 0;
         end;
         with (FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('<none>');
           Items.Add('READ_TYPE');
           ItemIndex := 0;
           Enabled := True;
         end;
         (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := 'ºC';
       end;
    2: begin //GW temperature
         TimeDeptTable[(Sender as TComboBox).Tag] := 'bhg_temp';
         with (FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('READING');
           ItemIndex := 0;
         end;
         with (FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('<none>');
           Items.Add('DEPTH');
           ItemIndex := 0;
           Enabled := True;
         end;
         (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := 'ºC';
       end;
 3..8: begin //chemistry
         TimeDeptTable[(Sender as TComboBox).Tag] := 'chem_000';
         (FindComponent('CheckBoxLimits' + IntToStr((Sender as TComboBox).Tag)) as TCheckbox).Enabled := True;         (FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox).Items.Clear;
         with DataModuleMain.CheckQuery do
         begin
           SQL.Clear;
           SQL.Add('SELECT * FROM chem_00' + IntToStr((Sender as TComboBox).ItemIndex - 2) + ' LIMIT 1');
           Open;
         end;
         with (FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           for m := 1 to DataModuleMain.CheckQuery.FieldDefs.Count - 1 do
             Items.Add(DataModuleMain.CheckQuery.Fields[m].FieldName);
           ItemIndex := 0;
         end;
         DataModuleMain.CheckQuery.Close;
         with (FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Enabled := False;
         end;
         YComboBoxChange(FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox);
       end;
    9: begin //Discharge rate
         TimeDeptTable[(Sender as TComboBox).Tag] := 'discharg';
         with (FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('DISCH_RATE');
           ItemIndex := 0;
         end;
         with (FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('<none>');
           Items.Add('DISCH_TYPE');
           ItemIndex := 0;
           Enabled := True;
         end;
         (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := Disunit;
       end;
   10: begin //GW EC
         TimeDeptTable[(Sender as TComboBox).Tag] := 'eleccond';
         with (FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('<none>');
           Items.Add('DEPTH');
           ItemIndex := 0;
           Enabled := True;
         end;
         with (FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('<none>');
           Items.Add('DEPTH');
           ItemIndex := 0;
           Enabled := True;
         end;
         (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := ECUnit;
       end;
   11: begin //Field measurements
         TimeDeptTable[(Sender as TComboBox).Tag] := 'fldmeas_';
         with (FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('READING');
           ItemIndex := 0;
         end;
         with (FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('PARM_MEAS');
           ItemIndex := 0;
           Enabled := True;
         end;
         (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := 'ºC';
       end;
   12: begin //GW Flow Velocity
         TimeDeptTable[(Sender as TComboBox).Tag] := 'flowvelo';
         with (FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('READING');
           ItemIndex := 0;
         end;
         with (FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('<none>');
           Items.Add('DEPTH');
           ItemIndex := 0;
           Enabled := True;
         end;
         (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := LengthUnit + '/' + TimeUnit;
       end;
   13: begin //Stream/river flow discharge
         TimeDeptTable[(Sender as TComboBox).Tag] := 'flow_dis';
         with (FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('DIS_FLOW');
           ItemIndex := 0;
         end;
         with (FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Enabled := False;
         end;
         (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := Disunit;
       end;
   14: begin //Humidity
         TimeDeptTable[(Sender as TComboBox).Tag] := 'humidity';
         with (FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('READING');
           ItemIndex := 0;
         end;
         with (FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Enabled := False;
         end;
         (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := DiamUnit;
       end;
   15: begin //Intake
         TimeDeptTable[(Sender as TComboBox).Tag] := 'intake__';
         with (FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('INTAK_FLOW');
           ItemIndex := 0;
         end;
         with (FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Enabled := False;
         end;
         (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := Disunit;
       end;
   17: begin //Pan Evaporation
         TimeDeptTable[(Sender as TComboBox).Tag] := 'pan_evap';
         with (FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('READING');
           ItemIndex := 0;
         end;
         with (FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Enabled := False;
         end;
         (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := DiamUnit;
       end;
   18: begin //Atm. pressure
         TimeDeptTable[(Sender as TComboBox).Tag] := 'pressure';
         with (FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('READING');
           ItemIndex := 0;
         end;
         with (FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Enabled := False;
         end;
         (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := PressureUnit;
       end;
   19: begin //Rainfall
         TimeDeptTable[(Sender as TComboBox).Tag] := 'rainfall';
         with (FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('READING');
           ItemIndex := 0;
         end;
         with (FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Enabled := False;
         end;
         (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := DiamUnit;
       end;
   20: begin //Solar radiation
         TimeDeptTable[(Sender as TComboBox).Tag] := 'solaradi';
         with (FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('READING');
           ItemIndex := 0;
         end;
         with (FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Enabled := False;
         end;
         (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := 'W/m²';
       end;
   21: begin //Stage height
         TimeDeptTable[(Sender as TComboBox).Tag] := 'stage_hi';
         with (FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('STAGE_HIGH');
           ItemIndex := 0;
         end;
         with (FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Enabled := False;
         end;
         (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := LengthUnit;
       end;
   22: begin //Stream flow velocity
         TimeDeptTable[(Sender as TComboBox).Tag] := 'strmvelo';
         with (FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('READING');
           ItemIndex := 0;
         end;
         with (FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Enabled := False;
         end;
         (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := LengthUnit + '/' + TimeUnit;
       end;
   23: begin //user chemistry
         TimeDeptTable[(Sender as TComboBox).Tag] := 'chem_000';
         (FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox).Items.Clear;
         with DataModuleMain.CheckQuery do
         begin
           SQL.Clear;
           SQL.Add('SELECT DISTINCT CPARAMETER FROM userchem');
           Open;
         end;
         with (FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Sorted := True;
           while not DataModuleMain.CheckQuery.EOF do
           begin
             Items.Add(DataModuleMain.CheckQuery.Fields[0].AsString);
             DataModuleMain.CheckQuery.Next;
           end;
           ItemIndex := 0;
         end;
         DataModuleMain.CheckQuery.Close;
         with (FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Enabled := False;
         end;
         YComboBoxChange(FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox);
       end;
   24: begin //user-def DTH and time
         TimeDeptTable[(Sender as TComboBox).Tag] := 'usr_dthp';
         (FindComponent('CheckBoxUseElev' + IntToStr((Sender as TComboBox).Tag)) as TCheckbox).Enabled := True;
         with (FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('READING');
           ItemIndex := 0;
         end;
         with (FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('DEPTH');
           Items.Add('PARM_MEAS');
           ItemIndex := 0;
           Enabled := True;
         end;
         (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := LengthUnit;
       end;
   25: begin //Water level
         TimeDeptTable[(Sender as TComboBox).Tag] := 'waterlev';
         (FindComponent('CheckBoxUseElev' + IntToStr((Sender as TComboBox).Tag)) as TCheckbox).Enabled := True;
         with (FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('WATER_LEV');
           ItemIndex := 0;
         end;
         with (FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('PIEZOM_NR');
           Items.Add('LEVEL_STAT');
           Items.Add('METH_MEAS');
           ItemIndex := 0;
           Enabled := True;
         end;
         (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := LengthUnit;
       end;
   26: begin //wind speed and direction
         TimeDeptTable[(Sender as TComboBox).Tag] := 'windvdir';
         with (FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Items.Add('READING');
           ItemIndex := 0;
         end;
         with (FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
         begin
           Items.Clear;
           Enabled := False;
         end;
         (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := LengthUnit + '/' + TimeUnit;
       end;
  end; //of case
  FilterFieldComboBoxChange(FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox);
end;

procedure TTimeDeptForm.ComboBoxViewDropDown(Sender: TObject);
var
  TheViews: TStringList;
begin
  if (Sender as TComboBox).Items.Count = 1 then //only <Current Site>
  begin
    //Fill the view dropdowns
    (Sender as TComboBox).Items.Clear;
    (Sender as TComboBox).Items.Add('<getting Views...>');
    Application.ProcessMessages;
    TheViews := TStringList.Create;
    if ComboBoxView1.Enabled then
    begin
      DataModuleMain.GetAllViews(DataModuleMain.ZConnectionDB, TheViews);
      ComboBoxView1.Items.Assign(TheViews);
    end;
    if ComboBoxView2.Enabled then
      ComboBoxView2.Items.Assign(TheViews);
    if ComboBoxView3.Enabled then
      ComboBoxView3.Items.Assign(TheViews);
    if ComboBoxView4.Enabled then
      ComboBoxView4.Items.Assign(TheViews);
    TheViews.Free;
    ComboBoxView1.Items.Insert(0, '<Current Site>');
    ComboBoxView2.Items.Insert(0, '<Current Site>');
    ComboBoxView3.Items.Insert(0, '<Current Site>');
    ComboBoxView4.Items.Insert(0, '<Current Site>');
    ComboBoxView1.ItemIndex := 0;
    ComboBoxView2.ItemIndex := 0;
    ComboBoxView3.ItemIndex := 0;
    ComboBoxView4.ItemIndex := 0;
  end;
end;

procedure TTimeDeptForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  with AquaSortQuery do
  begin
    Close;
    SortedFields := 'FILE_NAME';
    Filtered := False;
    Filter := '';
  end;
  LookupQuery.Close;
  CloseAction := caFree;
end;

procedure TTimeDeptForm.FormShow(Sender: TObject);
begin
  with AquaSortQuery do
  begin
    while not EOF do //fill the available time-dependent parameters
    begin
      ComboBoxData1.Items.Add(FieldByName('DESCRIPTION').AsString);
      ComboBoxData1.ItemIndex := 0;
      ComboBoxData2.Items.Add(FieldByName('DESCRIPTION').AsString);
      ComboBoxData2.ItemIndex := 0;
      ComboBoxData3.Items.Add(FieldByName('DESCRIPTION').AsString);
      ComboBoxData3.ItemIndex := 0;
      ComboBoxData4.Items.Add(FieldByName('DESCRIPTION').AsString);
      ComboBoxData4.ItemIndex := 0;
      Next;
    end;
    if TimeDeptTable[1] <> '' then //if table name has been sent from forms with quick chart button
    begin
      if Locate('FILE_NAME', TimeDeptTable[1], [loCaseInsensitive]) then
        ComboBoxData1.ItemIndex := FieldByName('TIME_ID').AsInteger;
      ComboBoxDataChange(ComboBoxData1); //trigger event to update comboboxes
    end;
  end;
  if StartDate > 0 then
  begin
    StartDateTimePicker1.Date := StartDate;
    StartDateTimePicker1.Time := StartTime;
    StartDateTimePicker2.Date := StartDate;
    StartDateTimePicker2.Time := StartTime;
    StartDateTimePicker3.Date := StartDate;
    StartDateTimePicker3.Time := StartTime;
    StartDateTimePicker4.Date := StartDate;
    StartDateTimePicker4.Time := StartTime;
  end;
  EndDateTimePicker1.DateTime := Now;
  EndDateTimePicker2.DateTime := Now;
  EndDateTimePicker3.DateTime := Now;
  EndDateTimePicker4.DateTime := Now;
end;

procedure TTimeDeptForm.FilterFieldComboBoxChange(Sender: TObject);
var
  m: Integer;
begin
  //Fill the filter value combobox depending on table
  case (FindComponent('ComboBoxData' + IntToStr((Sender as TComboBox).Tag)) as TComboBox).ItemIndex of
     1: begin //Air temperature
          LookupQuery.Filter := 'USED_FOR = ' + QuotedStr('READTYPE');
          LookupQuery.Filtered := True;
        end;
     9: begin //Discharge rate
          with LookupQuery do
          begin
            Filter := 'USED_FOR = ' + QuotedStr('DISCTYPE');
            Filtered := True;
          end;
        end;
    11: begin //Field measurement
          with LookupQuery do
          begin
            Filter := 'USED_FOR = ' + QuotedStr('PARAMEAS');
            Filtered := True;
          end;
        end;
13..15: with (FindComponent('FilterValueComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
        begin
          Enabled := True;
          Items.Add('0');
          ItemIndex := 0;
        end;
    16: begin //Meter readings
          if (Sender as TComboBox).ItemIndex = 0 then
            LookupQuery.Filter := 'USED_FOR = ' + QuotedStr('TYPEMEAS')
          else
            LookupQuery.Filter := 'USED_FOR = ' + QuotedStr('UNITMEAS');
          LookupQuery.Filtered := True;
        end;
    24: begin //user-def DTH and time
          with LookupQuery do
          begin
            Filter := 'USED_FOR = ' + QuotedStr('PARAMEAS');
            Filtered := True;
          end;
        end;
    25: begin //Water levels
          case (Sender as TComboBox).ItemIndex of
            0: begin
                 LookupQuery.Filtered := False;
                 with (FindComponent('FilterValueComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
                 begin
                   Items.Clear;
                   Items.Add('<All>');
                   for m := 0 to 9 do
                     Items.Add(IntToStr(m));
                   ItemIndex := 0;
                   Enabled := True;
                 end;
               end;
            1: begin
                 LookupQuery.Filter := 'USED_FOR = ' + QuotedStr('WLV_STAT');
                 LookupQuery.Filtered := True;
               end;
            2: begin
                 LookupQuery.Filter := 'USED_FOR = ' + QuotedStr('OTHRMEAS');
                 LookupQuery.Filtered := True;
               end;
          end; //of wl case
        end;
  end; //of case
  if LookupQuery.Filtered then
  begin
    if ((FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox).Text <> '<none>')
      and ((FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox).Text <> 'DEPTH') then
    with (FindComponent('FilterValueComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
    begin
      Items.Clear;
      Text := '';
      LookupQuery.First;
      while not LookupQuery.EOF do
      begin
        Items.Add(LookupQuery.FieldByName('SEARCH').AsString);
        LookupQuery.Next;
      end;
      ItemIndex := 0;
      Enabled := True;
    end
    else
    with (FindComponent('FilterValueComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox) do
    begin
      Items.Clear;
      Text := '';
      Enabled := False;
    end;
  end;
  LookupQuery.Filtered := False;
  LookupQuery.Filter := '';
  FilterValueComboBoxChange(Sender);
end;

procedure TTimeDeptForm.FilterValueComboBoxChange(Sender: TObject);
begin
  if TimeDeptTable[(Sender as TComboBox).Tag] = 'mreading' then
  begin
    if ((FindComponent('FilterFieldComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox).Text = 'TYPEMEAS') and (FilterValueComboBox1.Text = '') then
    begin
      (FindComponent('CheckBoxCum' + IntToStr((Sender as TComboBox).Tag)) as TCheckBox).Checked := True;
      (FindComponent('CheckBoxReset' + IntToStr((Sender as TComboBox).Tag)) as TCheckBox).Checked := True;
    end
    else
    begin
      (FindComponent('CheckBoxCum' + IntToStr((Sender as TComboBox).Tag)) as TCheckBox).Checked := False;
      (FindComponent('CheckBoxReset' + IntToStr((Sender as TComboBox).Tag)) as TCheckBox).Checked := False;
    end;
  end
  else
  if TimeDeptTable[(Sender as TComboBox).Tag] = 'fldmeas_' then
  begin
    if (FindComponent('FilterValueComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox).Text = 'C' then
      (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := ECUnit
    else
    if (FindComponent('FilterValueComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox).Text = 'T' then
      (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := 'ºC'
    else
    if (FindComponent('FilterValueComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox).Text = 'P' then
      (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := ''
    else
      (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := ChemUnit;
  end
  else
  if TimeDeptTable[(Sender as TComboBox).Tag] = 'usr_dthp' then
  begin
    if (FindComponent('FilterValueComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox).Text = 'C' then
      (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := ECUnit
    else
    if (FindComponent('FilterValueComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox).Text = 'T' then
      (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := 'ºC'
    else
    if (FindComponent('FilterValueComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox).Text = 'P' then
      (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := ''
    else
      (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := ChemUnit;
  end;
end;

procedure TTimeDeptForm.YComboBoxChange(Sender: TObject);
begin
  if (FindComponent('ComboBoxData' + IntToStr((Sender as TComboBox).Tag)) as TComboBox).ItemIndex = 3 then
  begin
    if UpperCase((FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox).Text) = 'PH' then
      (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := ''
    else
    if UpperCase((FindComponent('YComboBox' + IntToStr((Sender as TComboBox).Tag)) as TComboBox).Text) = 'EC' then
      (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := ECUnit
    else
      (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := ChemUnit;
  end
  else
  if ((FindComponent('ComboBoxData' + IntToStr((Sender as TComboBox).Tag)) as TComboBox).ItemIndex >= 4)
    and ((FindComponent('ComboBoxData' + IntToStr((Sender as TComboBox).Tag)) as TComboBox).ItemIndex <= 8) then
  begin
    (FindComponent('EditUnit' + IntToStr((Sender as TComboBox).Tag)) as TEdit).Caption := ChemUnit;
  end;
end;

end.
