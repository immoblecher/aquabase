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
unit repsettingstimechem;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Menus, XMLPropStorage, Buttons, ButtonPanel, Spin, DateTimePicker,
  Repsettings, RLReport;

type

  { TTimeChemReportSettingsForm }

  TTimeChemReportSettingsForm = class(TReportSettingsForm)
    Button1: TButton;
    Button2: TButton;
    ButtonSelParam: TButton;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ListBoxParams: TListBox;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    SpinEdit1: TSpinEdit;
    XMLPropStorage1: TXMLPropStorage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ButtonSelParamClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBoxParamsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListBoxParamsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListBoxParamsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OKButtonClick(Sender: TObject);
  private

  public

  end;

var
  TimeChemReportSettingsForm: TTimeChemReportSettingsForm;

implementation

{$R *.lfm}

uses Selparameter, TimeDeptChemReport, VARINIT, Repprev;

{ TTimeChemReportSettingsForm }

var // form level
    StartingPoint : TPoint;

procedure TTimeChemReportSettingsForm.ButtonSelParamClick(Sender: TObject);
begin
  with TParamSelectionForm.Create(Application) do
  begin
    if ListBoxParams.Items.Count > 0 then
      DstList.Items.Assign(ListBoxParams.Items); //create initial parameter list
    MaxParams := 14;
    ShowModal;
    if ModalResult = mrOK then
      ListBoxParams.Items.Assign(DstList.Items);
    Free;
  end;
end;

procedure TTimeChemReportSettingsForm.Button1Click(Sender: TObject);
begin
  SaveDialog1.InitialDir := WSpaceDir;
  if SaveDialog1.Execute then
    ListBoxParams.Items.SaveToFile(SaveDialog1.FileName);
end;

procedure TTimeChemReportSettingsForm.Button2Click(Sender: TObject);
begin
  OpenDialog1.InitialDir := WSpaceDir;
  if OpenDialog1.Execute then
    ListBoxParams.Items.LoadFromFile(OpenDialog1.FileName);
end;

procedure TTimeChemReportSettingsForm.FormCreate(Sender: TObject);
begin
  inherited;
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DateTimePicker2.DateTime := Now;
  with AvailableTablesList do
  begin
    Add('basicinf');
    Add('chem_000');
    Add('chem_001');
    Add('chem_002');
    Add('chem_003');
    Add('chem_004');
    Add('chem_005');
  end;
end;

procedure TTimeChemReportSettingsForm.FormShow(Sender: TObject);
begin
  if ListBoxParams.Items.Count = 0 then //fill with default
  with ListBoxParams.Items do
  begin
    Add('PH');
    Add('EC');
    Add('TDS');
    Add('CA');
    Add('MG');
    Add('NA');
    Add('K');
    Add('SI');
    Add('FE');
    Add('MN');
    Add('CL');
    Add('SO4');
    Add('N');
    Add('F');
  end;
end;

procedure TTimeChemReportSettingsForm.ListBoxParamsDragDrop(Sender,
  Source: TObject; X, Y: Integer);
var
  DropPosition, StartPosition: Integer;
  DropPoint: TPoint;
begin
  DropPoint.X := X;
  DropPoint.Y := Y;
  with Source as TListBox do
  begin
    StartPosition := ItemAtPos(StartingPoint,True) ;
    DropPosition := ItemAtPos(DropPoint,True) ;
    Items.Move(StartPosition, DropPosition) ;
  end;
end;

procedure TTimeChemReportSettingsForm.ListBoxParamsDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source = ListBoxParams;
end;

procedure TTimeChemReportSettingsForm.ListBoxParamsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  StartingPoint.X := X;
  StartingPoint.Y := Y;
end;

procedure TTimeChemReportSettingsForm.OKButtonClick(Sender: TObject);
var
  p: Byte;
  TheParam: ShortString;
begin
  with TLandscapeReportFormChem.Create(Application) do
  begin
    with ViewQuery.SQL do
    begin
      Clear;
      if RadioGroup1.ItemIndex = 0 then
      begin
        Add('SELECT DISTINCT v.site_id_nr from ' + FilterName + ' v');
        Add('JOIN chem_000 c on (v.site_id_nr = c.site_id_nr)');
        Add('WHERE v.site_id_nr = ' + QuotedStr(CurrentSite));
      end
      else
      begin
        Add('SELECT DISTINCT v.site_id_nr from ' + ViewComboBox.Text + ' v');
        Add('JOIN chem_000 c on (v.site_id_nr = c.site_id_nr)');
      end;
      if ViewQuery.Connection.Tag = 1 then
      begin
        Add('AND c.DATE_SAMPL || c.TIME_SAMPL >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker1.DateTime)));
        Add('AND c.DATE_SAMPL || c.TIME_SAMPL <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker2.DateTime)));
      end
      else
      begin
        Add('AND CONCAT(c.DATE_SAMPL, c.TIME_SAMPL) >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker1.DateTime)));
        Add('AND CONCAT(c.DATE_SAMPL, c.TIME_SAMPL) <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker2.DateTime)));
      end;
    end;
    //Set HeaderQuery (basicinf) filters
    if ConstrCheckBox.Checked and (UsedTablesList.IndexOf('basicinf') > -1) then
      HeaderQuery.SQL.Add('WHERE ' + Filterlist[UsedTablesList.IndexOf('basicinf')]);
    //Set current and Dates/Times and optional constraint
    with DetailQuery do
    begin
      if RadioGroup1.ItemIndex = 0 then
      begin
        SQL.Add('WHERE site_id_nr = ' + QuotedStr(CurrentSite));
        SQL.Add('AND');
      end
      else
        SQL.Add('WHERE');
      if Connection.Tag = 1 then
      begin
        SQL.Add('DATE_SAMPL || TIME_SAMPL >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker1.DateTime)));
        SQL.Add('AND DATE_SAMPL || TIME_SAMPL <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker2.DateTime)));
      end
      else
      begin
        SQL.Add('CONCAT(DATE_SAMPL, TIME_SAMPL) >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker1.DateTime)));
        SQL.Add('AND CONCAT(DATE_SAMPL, TIME_SAMPL) <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker2.DateTime)));
      end;
      if ConstrCheckBox.Checked and (UsedTablesList.IndexOf('chem_000') > -1) then
        SQL.Add('AND ' + Filterlist[UsedTablesList.IndexOf('chem_000')]);
    end;
    if ConstrCheckBox.Checked and (UsedTablesList.IndexOf('chem_001') > -1) then
      ChemQuery1.SQL.Add('WHERE ' + Filterlist[UsedTablesList.IndexOf('chem_001')]);
    if ConstrCheckBox.Checked and (UsedTablesList.IndexOf('chem_002') > -1) then
      ChemQuery2.SQL.Add('WHERE ' + Filterlist[UsedTablesList.IndexOf('chem_002')]);
    if ConstrCheckBox.Checked and (UsedTablesList.IndexOf('chem_003') > -1) then
      ChemQuery3.SQL.Add('WHERE ' + Filterlist[UsedTablesList.IndexOf('chem_003')]);
    if ConstrCheckBox.Checked and (UsedTablesList.IndexOf('chem_004') > -1) then
      ChemQuery4.SQL.Add('WHERE ' + Filterlist[UsedTablesList.IndexOf('chem_004')]);
    if ConstrCheckBox.Checked and (UsedTablesList.IndexOf('chem_005') > -1) then
      ChemQuery5.SQL.Add('WHERE ' + Filterlist[UsedTablesList.IndexOf('chem_005')]);
    if CheckBox2.Checked then //show summary
    begin
      RLBandSummary.Visible := True;
      with SummaryQuery.SQL do
      begin
        Add('SELECT c0.site_id_nr, ');
        for p := 0 to ListBoxParams.Count - 1 do
        begin
          TheParam := ListBoxParams.Items[p];
          if p = ListBoxParams.Count -1 then
            Add('MIN(CASE WHEN ' + TheParam + ' > -1 THEN ' + TheParam + ' ELSE NULL END) Min' + IntToStr(p) + ', MAX(' + TheParam + ') Max' + IntToStr(p) + ', AVG(CASE WHEN ' + TheParam + ' > -1 THEN ' + TheParam + ' ELSE NULL END) Avg' + IntToStr(p) + ' FROM chem_000 c0')
          else
            Add('MIN(CASE WHEN ' + TheParam + ' > -1 THEN ' + TheParam + ' ELSE NULL END) Min' + IntToStr(p) + ', MAX(' + TheParam + ') Max' + IntToStr(p) + ', AVG(CASE WHEN ' + TheParam + ' > -1 THEN ' + TheParam + ' ELSE NULL END) Avg' + IntToStr(p) + ', ');
        end;
        Add('LEFT JOIN chem_001 ON (c0.CHM_REF_NR = chem_001.CHM_REF_NR)');
        Add('LEFT JOIN chem_002 ON (c0.CHM_REF_NR = chem_002.CHM_REF_NR)');
        Add('LEFT JOIN chem_003 ON (c0.CHM_REF_NR = chem_003.CHM_REF_NR)');
        Add('LEFT JOIN chem_004 ON (c0.CHM_REF_NR = chem_004.CHM_REF_NR)');
        Add('LEFT JOIN chem_005 ON (c0.CHM_REF_NR = chem_005.CHM_REF_NR)');
        if RadioGroup1.ItemIndex = 0 then
        begin
          Add('WHERE c0.site_id_nr = ' + QuotedStr(CurrentSite));
          Add('AND');
        end
        else
          Add('WHERE');
        if SummaryQuery.Connection.Tag = 1 then
        begin
          Add('c0.DATE_SAMPL || c0.TIME_SAMPL >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker1.DateTime)));
          Add('AND c0.DATE_SAMPL || c0.TIME_SAMPL <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker2.DateTime)));
        end
        else
        begin
          Add('CONCAT(c0.DATE_SAMPL, c0.TIME_SAMPL) >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker1.DateTime)));
          Add('AND CONCAT(c0.DATE_SAMPL, c0.TIME_SAMPL) <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DateTimePicker2.DateTime)));
        end;
        Add('GROUP BY 1');
      end
    end
    else
      RLBandSummary.Visible := False;
    ColPercent := (100 - SpinEdit1.Value) / 100 ;
    ParamsList := TStringList.Create;
    ParamsList.Assign(ListBoxParams.Items);
    RLReportLandscape.Title := TitleEdit.Text;
    if CheckBox4.Checked then
      CommentRLMemo.Lines.Assign(CommentMemo.Lines);
    if cbPageBreak.Checked then
      HeaderBand1.PageBreaking := pbBeforePrint;
    try
      with TRepPrevForm.Create(Application) do
      begin
        RLReportLandscape.Preview(RLPreview1);
        Show;
      end;
    finally
      Screen.Cursor := crDefault;
      Close;
    end;
  end;
end;

end.

