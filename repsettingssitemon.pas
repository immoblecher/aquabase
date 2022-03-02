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
unit repsettingssitemon;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Menus, XMLPropStorage, ZDataset, DateTimePicker, Repsettings,
  RLReport;

type

  { TSiteMonRepSetForm }

  TSiteMonRepSetForm = class(TReportSettingsForm)
    CheckBoxAutoColours: TCheckBox;
    CheckBoxCenterPhoto: TCheckBox;
    CheckBoxSwop: TCheckBox;
    CheckBoxShowPhoto: TCheckBox;
    CheckGroupWLChart: TCheckGroup;
    CheckGroupChemChart: TCheckGroup;
    ColorButton1: TColorButton;
    ColorButton2: TColorButton;
    ColorButton3: TColorButton;
    ColorButton4: TColorButton;
    ColorButton5: TColorButton;
    ComboBoxLeft: TComboBox;
    ComboBoxRight: TComboBox;
    ComboBoxType: TComboBox;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    EditPhotoDescr: TEdit;
    GroupBox2: TGroupBox;
    GroupBoxColours: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    XMLPropStorage1: TXMLPropStorage;
    ZReadOnlyQuery1: TZReadOnlyQuery;
    procedure CheckBoxAutoColoursChange(Sender: TObject);
    procedure CheckBoxShowPhotoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private

  public

  end;

var
  SiteMonRepSetForm: TSiteMonRepSetForm;

implementation

{$R *.lfm}

uses sitemonitorreport, VARINIT, repprev;

{ TSiteMonRepSetForm }

procedure TSiteMonRepSetForm.FormCreate(Sender: TObject);
var
  ParamList: TStringList;
  i: Byte;
begin
  inherited;
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DateTimePicker2.DateTime := Now;
  with AvailableTablesList do
  begin
    Add('basicinf');
    Add('aquifer_');
    Add('waterlev');
    Add('fldmeas_');
    Add('chem_000');
    Add('chem_001');
    Add('chem_002');
    Add('chem_003');
    Add('chem_004');
    Add('chem_005');
  end;
  ParamList := TStringList.Create;
  for i := 1 to 5 do
  begin
    with ZReadOnlyQuery1 do
    begin
      SQL.Clear;
      SQL.Add('SELECT * FROM chem_00' + IntToStr(i) + ' WHERE 1 <> 1');
      Open;
      GetFieldNames(ParamList);
      Close;
      ComboBoxLeft.Items.AddStrings(ParamList);
    end;
  end;
  ParamList.Free;
  with ComboBoxLeft.Items do
  while IndexOf('CHM_REF_NR') > -1 do
    Delete(IndexOf('CHM_REF_NR'));
  //add field measurements which are not in chemistry also
  ComboBoxLeft.Items.Add('SAL');
  ComboBoxLeft.Items.Add('ORP');
  ComboBoxLeft.Items.Add('<none>');
  ComboBoxRight.Items.AddStrings(ComboBoxLeft.Items);
  ComboBoxLeft.ItemIndex := ComboBoxLeft.Items.IndexOf('EC');
  ComboBoxRight.ItemIndex := ComboBoxRight.Items.IndexOf('<none>');
  CheckGroupWLChart.Checked[0] := True;
end;

procedure TSiteMonRepSetForm.CheckBoxShowPhotoChange(Sender: TObject);
begin
  EditPhotoDescr.Enabled := CheckBoxShowPhoto.Checked;
end;

procedure TSiteMonRepSetForm.CheckBoxAutoColoursChange(Sender: TObject);
begin
  GroupBoxColours.Enabled := not CheckBoxAutoColours.Checked;
end;

procedure TSiteMonRepSetForm.OKButtonClick(Sender: TObject);
begin
  with TSiteMonitoringReportForm.Create(Nil) do
  begin
    //set report title and other
    TheReport.Title := TitleEdit.Caption;
    RLSystemInfo1.Visible := CheckBox3.Checked;
    RLSystemInfo2.Visible := CheckBox1.Checked;
    if cbPageBreak.Checked then
      RLBand1.PageBreaking := pbBeforePrint
    else
      RLBand1.PageBreaking := pbNone;
    //if only the current site
    if RadioGroup1.ItemIndex = 0 then
    begin
      //set view
      ViewQuery.SQL.Add('SELECT DISTINCT v.SITE_ID_NR FROM ' + FilterName + ' v');
      ViewQuery.SQL.Add('WHERE v.SITE_ID_NR = ' + QuotedStr(CurrentSite));
    end
    else
    begin
      //set view
      ViewQuery.SQL.Add('SELECT DISTINCT v.SITE_ID_NR FROM ' + ViewComboBox.Text + ' v');

    end;
    DateTimeFrom := DateTimePicker1.DateTime;
    DateTimeTo := DateTimePicker2.DateTime;
    ImgDescr := EditPhotoDescr.Text;
    ShowPhoto := CheckBoxShowPhoto.Checked;
    Param1 := ComboBoxLeft.Text;
    Param2 := ComboBoxRight.Text;
    //check for comments
    CommentMemoFromBasic := CheckBox4.Checked and CheckBoxFromBasic.Checked;
    if CheckBox4.Checked and not CheckBoxFromBasic.Checked then
      RLCommentMemo.Lines.Assign(CommentMemo.Lines);
    //ChemChart?
    ChemChtType := ComboBoxType.ItemIndex;
    //WL chart?
    ShowWLChart := CheckGroupWLChart.Checked[0];
    SwopCharts := CheckBoxSwop.Checked;
    //points with lines
    ShowWLPoints := CheckGroupWLChart.Checked[2];
    ShowChemPoints := CheckGroupChemChart.Checked[1];
    //series colours
    RandomClrs := CheckBoxAutoColours.Checked;
    WatrLvlClr := ColorButton1.ButtonColor;
    FldParam1Clr := ColorButton2.ButtonColor;
    FldParam2Clr := ColorButton3.ButtonColor;
    LabParam1Clr := ColorButton4.ButtonColor;
    LabParam2Clr := ColorButton5.ButtonColor;
    //water level axis minimum at 0
    Chart1.LeftAxis.Range.UseMin := CheckgroupWLChart.Checked[3];
    //Chart titles?
    Chart1.Title.Visible := CheckGroupWLChart.Checked[1];
    Chart2.Title.Visible := CheckGroupChemChart.Checked[0];
    //Photo settings
    RLImage1.Center := CheckBoxCenterPhoto.Checked;
    //show the report
    try
      Screen.Cursor := crHourglass;
      with TRepPrevForm.Create(Application) do
      begin
        TheReport.Preview(RLPreview1);
        Show;
      end;
    finally
      Screen.Cursor := crDefault;
      Close;
    end;
  end;
end;

end.

