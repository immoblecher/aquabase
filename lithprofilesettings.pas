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
unit lithprofilesettings;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ButtonPanel,
  StdCtrls, XMLPropStorage, ExtCtrls, Spin, TALegend, TATextElements, LCLType;

type

  { TLithProfileSettingsForm }

  TLithProfileSettingsForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    CheckBox1: TCheckBox;
    CheckBoxLegend: TCheckBox;
    CheckBoxMarks: TCheckBox;
    ColorButtonMarks: TColorButton;
    ColorDialog1: TColorDialog;
    ComboBoxLegAlignm: TComboBox;
    ComboBoxBotAxis: TComboBox;
    ComboBoxColour: TComboBox;
    ComboBoxViews: TComboBox;
    EditTitle: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    SpinEdit1: TSpinEdit;
    SpinEditNumberAngle: TSpinEdit;
    SpinEditLegFSize: TSpinEdit;
    SpinEditMarksFSize: TSpinEdit;
    XMLPropStorage1: TXMLPropStorage;
    procedure CancelButtonClick(Sender: TObject);
    procedure ComboBoxColourChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private

  public

  end;

var
  LithProfileSettingsForm: TLithProfileSettingsForm;

implementation

{$R *.lfm}

uses MainDataModule, VARINIT, lithprofile;

{ TLithProfileSettingsForm }

procedure TLithProfileSettingsForm.FormCreate(Sender: TObject);
var
  TheViews: TStringList;
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  Screen.Cursor := crSQLWait;
  with DataModuleMain do
  begin
    TheViews := TStringList.Create;
    GetAllViews(ZConnectionDB, TheViews);
    ComboBoxViews.Items.Assign(TheViews);
    TheViews.Free;
  end;
  ComboBoxViews.ItemIndex := ComboBoxViews.Items.IndexOf(FilterName);
  Screen.Cursor := crDefault;
end;

procedure TLithProfileSettingsForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TLithProfileSettingsForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TLithProfileSettingsForm.OKButtonClick(Sender: TObject);
begin
  with TLithProfileForm.Create(Application) do
begin
    PenWidth := SpinEdit1.Value;
    with Chart1 do
    begin
      BottomAxis.Title.Caption := ComboBoxBotAxis.Text;
      Title.Text.Clear;
      Title.Text.Add(EditTitle.Text);
      Legend.Visible := CheckBoxLegend.Checked;
      Legend.Font.Size := SpinEditLegFSize.Value;
      Legend.Alignment := TLegendAlignment(ComboBoxLegAlignm.ItemIndex);
      Margins.Left := 2 * PenWidth;
      Margins.Right := 2 * PenWidth;
      Margins.Top := 5;
      Margins.Bottom := 5;
      Tag := ComboBoxColour.ItemIndex;
      AxisList[2].Marks.LabelFont.Orientation := SpinEditNumberAngle.Value * 10;
      if SpinEditNumberAngle.Value > 0 then
      AxisList[2].Marks.RotationCenter := rcLeft;
    end;
    LithQuery.SQL.Insert(1, 'FROM ' + ComboBoxViews.Text + ' v');
    MarksVisible := CheckBoxMarks.Checked;
    MarksBgColour := ColorButtonMarks.ButtonColor;
    MarksFontSize := SpinEditMarksFSize.Value;
    Show;
  end;
  Close;
end;

procedure TLithProfileSettingsForm.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TLithProfileSettingsForm.ComboBoxColourChange(Sender: TObject);
begin
  CheckBox1.Enabled := ComboBoxColour.ItemIndex > 0;
end;

procedure TLithProfileSettingsForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

end.

