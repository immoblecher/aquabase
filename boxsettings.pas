{ Copyright (C) 2024 Immo Blecher, immo@blecher.co.za

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
unit boxsettings;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, ButtonPanel, StdCtrls, ExtCtrls, ZDataset, LCLType;

type

  { TBoxSettingsForm }

  TBoxSettingsForm = class(TForm)
    Bevel1: TBevel;
    ButtonPanel1: TButtonPanel;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    ComboBoxSort: TComboBox;
    ComboBox3: TComboBox;
    ComboBoxParams: TComboBox;
    ComboBoxViews: TComboBox;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    LabeledEdit1: TLabeledEdit;
    ZReadOnlyQuery1: TZReadOnlyQuery;
    procedure CancelButtonClick(Sender: TObject);
    procedure ComboBoxViewsChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private

  public

  end;

var
  BoxSettingsForm: TBoxSettingsForm;

implementation

{$R *.lfm}

uses MainDataModule, VARINIT, boxwhisker;

{ TBoxSettingsForm }

procedure TBoxSettingsForm.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TBoxSettingsForm.ComboBoxViewsChange(Sender: TObject);
begin
  CheckBox1.Enabled := ComboBoxViews.ItemIndex > 0;
end;

procedure TBoxSettingsForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TBoxSettingsForm.FormCreate(Sender: TObject);
var
  i: ShortInt;
  ParamList, TheViews: TStringList;
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  with LabeledEdit1.EditLabel.Font do
  begin
    Name := AppFont.Name;
    Size := AppFont.Size;
  end;//Done with Font
  with LabeledEdit1.Font do
  begin
    Name := AppFont.Name;
    Size := AppFont.Size;
  end;//Done with Font
  with ComboBoxViews do
  begin
    TheViews := TStringList.Create;
    DataModuleMain.GetAllViews(DataModuleMain.ZConnectionDB, TheViews);
    Items.Assign(TheViews);
    TheViews.Free;
    Items.Add('Current Site');
    Items.Move(Items.Count-1, 0);
    ComboBoxViews.ItemIndex := 0;
  end;
  if DataModuleMain.ZConnectionDB.Tag <> 4 then
  begin
    for i:= ComboBoxSort.Items.Count - 1 downto 2 do
      ComboBoxSort.Items.Delete(i);
  end;
  DateTimePicker2.DateTime := Now;
  ParamList := TStringList.Create;
  for i := 1 to 5 do
  begin
    with ZReadOnlyQuery1 do
    begin
      SQL.Clear;
      SQL.Add('SELECT * FROM chem_00' + IntToStr(i) + ' LIMIT 1');
      Open;
      GetFieldNames(ParamList);
      Close;
      ComboBoxParams.Items.AddStrings(ParamList);
    end;
  end;
  ParamList.Free;
  while ComboBoxParams.Items.IndexOf('CHM_REF_NR') > -1 do
    ComboBoxParams.Items.Delete(ComboBoxParams.Items.IndexOf('CHM_REF_NR'));
  ComboBoxParams.ItemIndex := ComboBoxParams.Items.IndexOf('EC');
end;

procedure TBoxSettingsForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TBoxSettingsForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TBoxSettingsForm.OKButtonClick(Sender: TObject);
begin
  with TBoxWhiskerForm.Create(Application) do
  begin
    if ComboBoxViews.ItemIndex = 0 then
    begin
      CurrentSiteOnly := True;
      TheView := FilterName;
    end
    else
    begin
      CurrentSiteOnly := False;
      TheView := ComboBoxViews.Text;
    end;
    StartDateTime := DateTimePicker1.DateTime;
    EndDateTime := DateTimePicker2.DateTime;
    TheParam := ComboBoxParams.Text;
    AllInOne := CheckBox1.Checked;
    OrderNr := ComboBoxSort.ItemIndex + 1;
    if ComboBox3.ItemIndex = 0 then
      XLabelField := 'series'
    else
      XLabelField := 'site_nr';
    Chart1.Title.Text.Clear;
    Chart1.Title.Text.Add(LabeledEdit1.Text);
    Show;
  end;
  Close;
end;

end.

