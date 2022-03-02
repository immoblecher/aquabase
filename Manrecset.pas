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
unit Manrecset;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Repsettings, ExtCtrls,
  Buttons, Menus, StdCtrls, DbCtrls, ZDataset;

type

  { TManRecSetForm }

  TManRecSetForm = class(TReportSettingsForm)
    CheckBoxResDD: TCheckBox;
    CheckBoxStandard: TCheckBox;
    CheckBoxLab: TCheckBox;
    CheckBoxParam: TCheckBox;
    ComboBoxParam: TComboBox;
    GroupBox2: TGroupBox;
    ChemQuery: TZReadOnlyQuery;
    procedure CancelBitBtnClick(Sender: TObject);
    procedure CheckBoxParamChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ManRecSetForm: TManRecSetForm;

implementation

{$R *.lfm}

{ TManRecSetForm }

uses man_rep, Repprev, VARINIT;

procedure TManRecSetForm.CancelBitBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TManRecSetForm.CheckBoxParamChange(Sender: TObject);
begin
  ComboBoxParam.Enabled := CheckBoxParam.Checked;
end;

procedure TManRecSetForm.FormActivate(Sender: TObject);
var n: Byte;
    p: Integer;
begin
  with AvailableTablesList do
  begin
    Add('aquifer_');
    Add('casing__');
    Add('chem_000');
    Add('chem_001');
    Add('chem_003');
    Add('installa');
    Add('instdetl');
    Add('recommnd');
    Add('testdetl');
    Add('waterlev');
  end;
  //Add all parameters form chem_001 to 5
  ComboBoxParam.Items.Clear;
  for n := 1 to 5 do
  with ChemQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM chem_00' + IntToStr(n));
    Open;
    for p := 1 to FieldDefs.Count - 1 do
      ComboBoxParam.Items.Add(FieldDefs.Items[p].Name);
    Close;
  end;
  ComboBoxParam.ItemIndex := 0;
end;

procedure TManRecSetForm.OKButtonClick(Sender: TObject);
begin
  with TManRecForm.Create(Application) do
  begin
    TheUsedTablesList := TStringList.Create;
    TheUsedTablesList.AddStrings(UsedTablesList);
    TheFilterList := TStringList.Create;
    TheFilterList.AddStrings(FilterList);
    UseConstraints := ConstrCheckBox.Checked;
    AddParam := ComboBoxParam.Text;
    ShowLab := CheckBoxLab.Checked;
    ShowStandard := CheckBoxStandard.Checked;
    ShowAddParam := CheckBoxParam.Checked;
    UseResDD := CheckBoxResDD.Checked;
    ManRecReport.Title := TitleEdit.Text;
    UseView := RadioGroup1.ItemIndex = 1;
    if RadioGroup1.ItemIndex = 0 then
      ViewName := FilterName
    else
      ViewName := ViewComboBox.Text;
    RLSystemInfo1.Visible := CheckBox3.Checked;
    RLSystemInfo2.Visible := CheckBox1.Checked;
    DoPageBreak := cbPageBreak.Checked;
    CommentMemo.Lines.Clear;
    CommentMemo.Lines.AddStrings(CommentMemo.Lines);
    CommentMemo.Visible := CheckBox4.Checked;
    try
      with TRepPrevForm.Create(Application) do
      begin
        ManRecReport.Preview(RLPreview1);
        Show;
      end;
    finally
      Screen.Cursor := crDefault;
      Close;
    end;
  end;
end;

end.
