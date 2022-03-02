{ Copyright (C) 2020 Immo Blecher immo@blecher.co.za

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
unit chemchartsettings;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLType, StdCtrls,
  Buttons, ExtCtrls, DBCtrls, ButtonPanel, ComCtrls, ZDataset, DateTimePicker, db;

type

  { TChemChartSettingsForm }

  TChemChartSettingsForm = class(TForm)
    Bevel1: TBevel;
    ButtonSelParam: TButton;
    ButtonPanel1: TButtonPanel;
    CheckBoxGroup: TCheckBox;
    CheckGroupLabels: TCheckGroup;
    CheckGroupDiagrams: TCheckGroup;
    CheckGroupLegend: TCheckGroup;
    ComboBoxAggregate: TComboBox;
    ComboBoxViews: TComboBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ListBoxMembers: TListBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DateTimePickerFrom: TDateTimePicker;
    DateTimePickerTo: TDateTimePicker;
    MemberQuery: TZReadOnlyQuery;
    procedure CheckBoxGroupChange(Sender: TObject);
    procedure CheckGroupDiagramsItemClick(Sender: TObject; Index: integer);
    procedure CheckGroupItemClick(Sender: TObject; Index: integer);
    procedure ComboBoxViewsChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ButtonSelParamClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure MemberQueryAfterOpen(DataSet: TDataSet);
    procedure OKButtonClick(Sender: TObject);
    procedure MemberQueryBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    ParameterList, FieldList: TStringList;
  public
    { Public declarations }
    FromMainMenu, ForReport: Boolean;
  end;

var
  ChemChartSettingsForm: TChemChartSettingsForm;

implementation

uses VARINIT, PieChem, SelParameter, chemcharts, ChemRadial, maindatamodule, stiffdiagram;

{$R *.lfm}

procedure TChemChartSettingsForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  FieldList.Free;
  CloseAction := caFree;
end;

procedure TChemChartSettingsForm.CheckGroupDiagramsItemClick(Sender: TObject;
  Index: integer);
var
  i, items_chckd: byte;
begin
  items_chckd := 0;
  for i := 0 to CheckGroupDiagrams.Items.Count - 1 do
    if CheckGroupDiagrams.Checked[i] then
      Inc(items_chckd);
  if ForReport and (items_chckd > 2) then
  begin
    ButtonPanel1.OKButton.Enabled := False;
    MessageDlg('You can only select two charts to display on the report!', mtWarning, [mbOK], 0);
  end
  else
    ButtonPanel1.OKButton.Enabled := items_chckd > 0;
  ButtonSelParam.Enabled := CheckGroupDiagrams.Checked[6];
  ComboBoxAggregate.Enabled := CheckGroupDiagrams.Checked[5] or CheckGroupDiagrams.Checked[6];
  if CheckGroupDiagrams.Checked[6] then
  begin
    ButtonSelParamClick(Sender);
    ButtonSelParam.Enabled := True;
  end
  else
    ButtonSelParam.Enabled := False;
  if CheckGroupDiagrams.Checked[5] then
  begin
    {$IFDEF WINDOWS}
    if VerDiff > 3 then
      MessageDlg(VersionMessage, mtError,[mbOK], 0)
    else
    {$ENDIF}
    if FromMainMenu then
    begin
      MessageDlg('The Stiff Diagram currently supports one diagram for the current site only!', mtWarning, [mbOK], 0);
      FromMainMenu := False; //to avoid repeating the message
    end;
  end;
end;

procedure TChemChartSettingsForm.CheckBoxGroupChange(Sender: TObject);
begin
  if CheckBoxGroup.Checked then
  begin
    MemberQuery.Open;
    Width := Width + 114;
    PageControl1.Align := alLeft;
    GroupBox1.Visible := True;
    ListBoxMembers.SetFocus;
  end
  else
  begin
    GroupBox1.Visible := False;
    PageControl1.Align := alClient;
    Width := Width - 114;
    MemberQuery.Close;
    ListBoxMembers.Clear;
    CheckBoxGroup.SetFocus;
  end;
end;

procedure TChemChartSettingsForm.CheckGroupItemClick(Sender: TObject;
  Index: integer);
var
  i, items_chckd: byte;
begin
  items_chckd := 0;
  for i := 0 to (Sender as TCheckGroup).Items.Count - 1 do
    if (Sender as TCheckGroup).Checked[i] then
      Inc(items_chckd);
  if items_chckd = 0 then
  begin
    MessageDlg('You must have at least one item checked!', mtWarning, [mbOK], 0);
    (Sender as TCheckGroup).Checked[1] := True;
  end;
end;

procedure TChemChartSettingsForm.ComboBoxViewsChange(Sender: TObject);
begin
  CheckBoxGroup.Enabled := ComboBoxViews.ItemIndex > 0;
  CheckBoxGroup.Checked := False;
end;

procedure TChemChartSettingsForm.FormCreate(Sender: TObject);
var
  TheViews: TStringList;
begin
  PageControl1.Align := alClient;
  ClientWidth := PageControl1.Width;
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  DateTimePickerTo.Date := Now;
  DateTimePickerTo.Time := Now;
  CheckGroupLabels.Checked[1] := True;
  CheckGroupLabels.Checked[5] := True;
  CheckGroupLegend.Checked[1] := True;
  CheckGroupLegend.Checked[5] := True;
  FieldList := TStringList.Create;
  FieldList.Add('SITE_ID_NR');
  FieldList.Add('NR_ON_MAP');
  FieldList.Add('REGION_BB');
  FieldList.Add('ALT_NR_1');
  FieldList.Add('ALT_NR_2');
  FieldList.Add('CHM_REF_NR');
  FieldList.Add('SAMPLE_NR');
  FieldList.Add('DATE_SAMPL');
  FieldList.Add('TIME_SAMPL');
  FieldList.Add('DEPTH_SAMP');
  TheViews := TStringList.Create;
  DataModuleMain.GetAllViews(DataModuleMain.ZConnectionDB, TheViews);
  with ComboBoxViews do
  begin
    Items.Assign(TheViews);
    Items.Add('Current Site');
    ItemIndex := Items.IndexOf('Current Site');
  end;
  TheViews.Free;
end;

procedure TChemChartSettingsForm.ButtonSelParamClick(Sender: TObject);
begin
  with TParamSelectionForm.Create(Application) do
  begin
    with DstList.Items do //create initial parameter list
    begin
      Add('CA');
      Add('MG');
      Add('NA');
      Add('K');
      Add('CL');
      Add('N');
      Add('MALK');
      Add('SO4');
    end;
    MaxParams := 100;
    ShowModal;
    ParameterList := TStringList.Create;
    ParameterList.AddStrings(DstList.Items);
    Free;
  end;
end;

procedure TChemChartSettingsForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TChemChartSettingsForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TChemChartSettingsForm.MemberQueryAfterOpen(DataSet: TDataSet);
begin
  with MemberQuery do
  while not EOF do
  begin
    if ListBoxMembers.Items.IndexOf(FieldByName('MEMBER_ID').Value) = -1 then
      ListBoxMembers.Items.Add(FieldByName('MEMBER_ID').Value);
    Next;
  end;
  if ListBoxMembers.Count > 0 then
  begin
    ListBoxMembers.ItemIndex := 0;
    ListBoxMembers.SelectAll;
  end;
end;

procedure TChemChartSettingsForm.OKButtonClick(Sender: TObject);
var
  m, c: Byte;
begin
  Screen.Cursor := crSQLWait;
  for c := 0 to 4 do
  begin
    if CheckGroupDiagrams.Checked[c] then
    begin
      with TChemChartsForm.Create(Application) do
      begin
        ChtType := c;
        MenuItemReport.Visible := ForReport;
        ClrByGrp := CheckBoxGroup.Checked;
        if CheckBoxGroup.Checked then
        begin
          if (ListBoxMembers.Count > 0) and (ListBoxMembers.SelCount > 0) then
          begin
            MemberList := TStringList.Create;
            for m := 0 to ListBoxMembers.Count - 1 do
            begin
              if ListBoxMembers.Selected[m] then
                MemberList.Add(ListBoxMembers.Items[m]);
            end;
            if MemberList.Count > 20 then
              MessageDlg('The View contains more than 20 different group members! Those will be all shown with the same colour.', mtWarning, [mbOK], 0);
          end
          else
          begin
            MessageDlg('There are no group members in the list or none are selected! Colouring by group membership not possible.', mtWarning, [mbOK], 0);
            ClrByGrp := False;
          end;
          MemberQuery.Close;
        end;
        MenuItemReport.Tag := c;
        if ComboBoxViews.Text = 'Current Site' then
        begin
          IsCurrentSite := True;
          FilterTableName := FilterName;
        end
        else
          FilterTableName := ComboBoxViews.Text;
        StartDate := FormatDateTime('YYYYMMDD', DateTimePickerFrom.Date);
        StartTime := FormatDateTime('hhnn', DateTimePickerFrom.Time);
        EndDate := FormatDateTime('YYYYMMDD', DateTimePickerTo.Date);
        EndTime := FormatDateTime('hhnn', DateTimePickerTo.Time);
        for m := 0 to 9 do
        begin
          if CheckGroupLabels.Checked[m] then
            LabelLst.Add(FieldList[m]);
          if CheckGroupLegend.Checked[m] then
            LegendLst.Add(FieldList[m]);
        end;
        Show;
      end;
    end;
  end;
  if CheckGroupDiagrams.Checked[7] then //Radial - needs work
  begin
    with TChemRadialForm.Create(Application) do
    begin
      MenuItemReport.Visible := ForReport;
      MenuItemReport.Tag := 7;
      StartDate := FormatDateTime('YYYYMMDD', DateTimePickerFrom.Date);
      StartTime := FormatDateTime('hhnn', DateTimePickerFrom.Time);
      EndDate := FormatDateTime('YYYYMMDD', DateTimePickerTo.Date);
      EndTime := FormatDateTime('hhnn', DateTimePickerTo.Time);
      ViewName := FilterName;
      Show;
    end;
  end;
  if CheckGroupDiagrams.Checked[6] then //Pie
  begin
     with TPieForm.Create(Application) do
     begin
       MenuItemReport.Visible := ForReport;
       MenuItemReport.Tag := 5;
       PieAggregate := ComboBoxAggregate.ItemIndex;
       ParamList := TStringList.Create;
       ParamList.AddStrings(ParameterList);
       for m := 0 to ParameterList.Count - 1 do
         ParamStr := ParamStr + ParameterList.Strings[m] + ', ';
       Delete(ParamStr, Length(ParamStr) -1, 2); //delete last ', '
       ParameterList.Free;
       if ComboBoxViews.Text = 'Current Site' then
         CurrentSiteOnly := True;
       StartDate := FormatDateTime('YYYYMMDD', DateTimePickerFrom.Date);
       StartTime := FormatDateTime('hhnn', DateTimePickerFrom.Time);
       EndDate := FormatDateTime('YYYYMMDD', DateTimePickerTo.Date);
       EndTime := FormatDateTime('hhnn', DateTimePickerTo.Time);
       ViewName := FilterName;
       Show;
     end;
  end;
  if CheckGroupDiagrams.Checked[5] then  //Stiff diagram
  begin
    with TStiffForm.Create(Application) do
    begin
      MenuItemReport.Visible := ForReport;
      MenuItemReport.Tag := 3;
      CurrentSiteOnly := True; //TEMPORARY - Views supported at later stage
      Aggregate := ComboBoxAggregate.ItemIndex;
      StartDate := FormatDateTime('YYYYMMDD', DateTimePickerFrom.Date);
      StartTime := FormatDateTime('hhnn', DateTimePickerFrom.Time);
      EndDate := FormatDateTime('YYYYMMDD', DateTimePickerTo.Date);
      EndTime := FormatDateTime('hhnn', DateTimePickerTo.Time);
      for m := 0 to 9 do
      begin
        if CheckGroupLabels.Checked[m] then
          LabelLst.Add(FieldList[m]);
        if CheckGroupLegend.Checked[m] then
          LegendLst.Add(FieldList[m]);
      end;
      ViewName := FilterName;
      Show;
    end;
  end;
  Screen.Cursor := CrDefault;
end;

procedure TChemChartSettingsForm.MemberQueryBeforeOpen(DataSet: TDataSet);
begin
  MemberQuery.Connection:= DataModuleMain.ZConnectionDB;
  with MemberQuery.SQL do
  begin
    Clear;
    Add('SELECT v.SITE_ID_NR, m.MEMBER_ID FROM ' + ComboBoxViews.Text + ' v');
    Add('JOIN member__ m ON (v.SITE_ID_NR = m.SITE_ID_NR)');
  end;
end;

end.
