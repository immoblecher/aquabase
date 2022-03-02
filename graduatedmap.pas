{ Copyright (C) 2020 Immo Blecher, immo@blecher.co.za

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
unit graduatedmap;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ButtonPanel, StdCtrls,
  XMLPropStorage, Spin, DateTimePicker, ZDataset;

type

  { TFormGraduatedPnts }

  TFormGraduatedPnts = class(TForm)
    ButtonPanel1: TButtonPanel;
    CheckBox1: TCheckBox;
    ColorButtonHiValue: TColorButton;
    ColorButtonNoValue: TColorButton;
    ColorDialog1: TColorDialog;
    ComboBoxPntInfo: TComboBox;
    ComboBoxParam: TComboBox;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ComboBoxAllViews: TComboBox;
    FieldsQuery: TZReadOnlyQuery;
    Label6: TLabel;
    SpinEditMaxLum: TSpinEdit;
    XMLPropStorage1: TXMLPropStorage;
    procedure CancelButtonClick(Sender: TObject);
    procedure ComboBoxParamChange(Sender: TObject);
    procedure ComboBoxPntInfoChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    ChemTable: ShortString;
  public

  end;

var
  FormGraduatedPnts: TFormGraduatedPnts;

implementation

{$R *.lfm}

uses VARINIT, maindatamodule, mapview;

{ TFormGraduatedPnts }

procedure TFormGraduatedPnts.FormCreate(Sender: TObject);
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, False);
  FieldsQuery.Connection := DataModuleMain.ZConnectionDB;
  DateTimePicker2.DateTime := Now;
end;

procedure TFormGraduatedPnts.ComboBoxPntInfoChange(Sender: TObject);
var
  c: Byte;
  FieldList: TStringList;
begin
  ComboBoxParam.Enabled := ComboBoxPntInfo.ItemIndex IN [2, 3];
  DateTimePicker1.Enabled := ComboBoxPntInfo.ItemIndex >=2;
  DateTimePicker2.Enabled := ComboBoxPntInfo.ItemIndex >=2;
  FieldList := TStringList.Create;
  ComboBoxParam.Clear;
  case ComboBoxPntInfo.ItemIndex of
    2: for c := 1 to 6 do
       with FieldsQuery do
       begin
         SQL.Clear;
         SQL.Add('SELECT * FROM chem_00' + IntToStr(c) + ' WHERE 1 <> 1');
         Open;
         GetFieldNames(FieldList);
         ComboBoxParam.Items.AddStrings(FieldList);
         Close;
         ChemTable := 'chem_005' //first chem param is AG which is in chem_005
       end;
    3: with FieldsQuery do
       begin
         SQL.Clear;
         SQL.Add('SELECT DISTINCT PARM_MEAS FROM fldmeas_');
         SQL.Add('ORDER BY PARM_MEAS');
         Open;
         while not EOF do
         begin
           ComboBoxParam.Items.Add(FieldByName('PARM_MEAS').AsString);
           Next;
         end;
         Close
       end;
  end; //of case
  FieldList.Free;
  if ComboBoxParam.Items.Count > 0 then
  begin
    //clear non-parameters
    while ComboBoxParam.Items.IndexOf('CHM_REF_NR') > 0 do
      ComboBoxParam.Items.Delete(ComboBoxParam.Items.IndexOf('CHM_REF_NR'));
    ComboBoxParam.ItemIndex := 0;
  end;
end;

procedure TFormGraduatedPnts.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TFormGraduatedPnts.ComboBoxParamChange(Sender: TObject);
var
  c: Byte;
  FieldList: TStringList;
begin
  FieldList := TStringList.Create;
  if ComboBoxPntInfo.ItemIndex = 2 then
    for c := 1 to 6 do
    with FieldsQuery do
    begin
      SQL.Clear;
      SQL.Add('SELECT * FROM chem_00' + IntToStr(c) + ' WHERE 1 <> 1');
      Open;
      GetFieldNames(FieldList);
      Close;
      if FieldList.IndexOf(ComboBoxParam.Text) > -1 then
        ChemTable := 'chem_00' + IntToStr(c);
    end;
  FieldList.Free;
end;

procedure TFormGraduatedPnts.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TFormGraduatedPnts.FormShow(Sender: TObject);
var
  TheViews: TStringList;
begin
  with DataModuleMain do
  begin
    TheViews := TStringList.Create;
    GetAllViews(ZConnectionDB, TheViews);
    ComboBoxAllViews.Items.Assign(TheViews);
    TheViews.Free;
  end;
  ComboBoxAllViews.ItemIndex := ComboBoxAllViews.Items.IndexOf(FilterName);
  ComboBoxPntInfoChange(ComboBoxPntInfo);
end;

procedure TFormGraduatedPnts.OKButtonClick(Sender: TObject);
begin
  with TMapViewForm.Create(Application) do
  begin
    IsThemed := True;
    UseView := ComboBoxAllViews.Text;
    Graduated := ComboBoxPntInfo.ItemIndex;
    ComboBoxViews.Items.Assign(ComboBoxAllViews.Items);
    case ComboBoxPntInfo.ItemIndex of
      0: begin
           TheParam := 'yield';
           TheFactor := VolumeFactor/TimeFactor;
           TheUnit := DisUnit;
         end;
      1: begin
           TheParam := 'depth';
           TheFactor := LengthFactor;
           TheUnit := LengthUnit;
         end;
      2: begin
           TheParam := ComboBoxParam.Text;
           case TheParam of
             'EC':
             begin
               TheFactor := ECFactor;
               TheUnit := ECUnit;
             end;
             'PH':
             begin
               TheFactor := 1;
               TheUnit := '(@ 25°C)';
             end;
             'COLR':
             begin
               TheFactor := 1;
               TheUnit := 'mg/l Pt';
             end;
             'TEMP':
             begin
               TheFactor := 1;
               TheUnit := '°C';
             end;
             'TUR':
             begin
               TheFactor := 1;
               TheUnit := 'NTU';
             end;
             'TVO', 'SPC':
             begin
               TheFactor := 1;
               TheUnit := '/ml';
             end;
             'ECOL', 'FAEC_ECOL', 'FAEC_STREP', 'PROTO_PARA', 'ENT_VIRUS':
             begin
               TheFactor := 1;
               TheUnit := '/100ml';
             end;
             else
             begin
               TheFactor := ChemFactor;
               TheUnit := ChemUnit;
             end;

           end;
           TheChemTable := ChemTable;
         end;
      3: begin
           TheParam := 'PARAM_' + ComboBoxParam.Text;
           case TheParam of
             'PARAM_C':
             begin
               TheFactor := ECFactor;
               TheUnit := ECUnit;
             end;
             'PARAM_P':
             begin
               TheFactor := 1;
               TheUnit := '(@ 25°C)';
             end;
             'PARAM_T':
             begin
               TheFactor := 1;
               TheUnit := '°C';
             end;
             'PARAM_O':
             begin
               TheFactor := 1;
               TheUnit := 'mV';
             end;
             'PARAM_L':
             begin
               TheFactor := 1;
               TheUnit := 'ppt';
             end;
             'PARAM_B':
             begin
               TheFactor := PressureFactor;
               TheUnit := PressureUnit;
             end;
             else
             begin
               TheFactor := ChemFactor;
               TheUnit := ChemUnit;
             end;
           end;//of case
         end;
      4: begin
           TheParam := 'water_lev';
           TheFactor := LengthFactor;
           TheUnit := LengthUnit;
         end;
    end; //of case
    DT_From := DateTimePicker1.DateTime;
    DT_To := DateTimePicker2.DateTime;
    CheckBoxCurrent.Enabled := False;
    MaxLum := SpinEditMaxLum.Value;
    HiColor := ColorButtonHiValue.ButtonColor;
    if CheckBox1.Checked then
      ColorButtonPoints.ButtonColor := ColorButtonNoValue.ButtonColor;
    ShowNoValue := CheckBox1.Checked;
    Show;
  end;
  Close;
end;

end.

