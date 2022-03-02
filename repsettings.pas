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
unit Repsettings;

{$mode objfpc}{$H+}

interface

uses
  LCLIntf, LCLType, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Menus, ButtonPanel, FileUtil;

type

  { TReportSettingsForm }

  TReportSettingsForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    CheckBoxFromBasic: TCheckBox;
    MenuItem1: TMenuItem;
    RadioGroup1: TRadioGroup;
    Label1: TLabel;
    ViewComboBox: TComboBox;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    TitleEdit: TEdit;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CommentMemo: TMemo;
    ConstrGroupBox: TGroupBox;
    RecordsButton: TButton;
    ConstrCheckBox: TCheckBox;
    CheckBox4: TCheckBox;
    cbPageBreak: TCheckBox;
    PopupMenu1: TPopupMenu;
    Wordwrap1: TMenuItem;
    procedure CancelButtonClick(Sender: TObject);
    procedure cbPageBreakChange(Sender: TObject);
    procedure CheckBoxFromBasicChange(Sender: TObject);
    procedure CheckBoxFromBasicClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ConstrCheckBoxClick(Sender: TObject);
    procedure RecordsButtonClick(Sender: TObject);
    procedure Wordwrap1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    AvailableTablesList, UsedTablesList, FilterList: TStringList;
  end;

var
  ReportSettingsForm: TReportSettingsForm;

implementation

uses VARINIT, SelConstrDlg, MainDataModule;

{$R *.lfm}

procedure TReportSettingsForm.RadioGroup1Click(Sender: TObject);
var
  TheViews: TStringList;
begin
  case Radiogroup1.ItemIndex of
  0: begin
       Label1.Enabled := False;
       ViewComboBox.Enabled := False;
       cbPageBreak.Enabled := False;
       CheckBoxFromBasic.Enabled := True;
     end;
  1: begin
       Label1.Enabled := True;
       cbPageBreak.Enabled := true;
       CheckBoxFromBasic.Enabled := cbPageBreak.Checked;
       if ViewComboBox.Text = '<No View>' then
       begin
         ViewComboBox.Clear;
         ViewComboBox.Items.Add('<Updating Views, please wait...>');
         ViewComboBox.ItemIndex := 0;
         Application.ProcessMessages;
         TheViews := TStringList.Create;
         DataModuleMain.GetAllViews(DataModuleMain.ZConnectionDB, TheViews);
         ViewComboBox.Items.Assign(TheViews);
         ViewComboBox.ItemIndex := ViewComboBox.Items.IndexOf(FilterName);
         TheViews.Free;
       end;
       ViewComboBox.Enabled := True;
     end;
   end; {of case}
end;

procedure TReportSettingsForm.CheckBoxFromBasicChange(Sender: TObject);
begin
  CommentMemo.Enabled := not CheckBoxFromBasic.Checked;
end;

procedure TReportSettingsForm.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TReportSettingsForm.cbPageBreakChange(Sender: TObject);
begin
  CheckBoxFromBasic.Enabled := cbPageBreak.Checked;
  CheckBoxFromBasic.Checked := cbPageBreak.Checked;
end;

procedure TReportSettingsForm.CheckBoxFromBasicClick(Sender: TObject);
begin
  CommentMemo.Enabled := not CheckBoxFromBasic.Checked;
end;

procedure TReportSettingsForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TReportSettingsForm.MenuItem1Click(Sender: TObject);
begin
  CommentMemo.Clear;
end;

procedure TReportSettingsForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  UsedTablesList.Free;
  FilterList.Free;
  CloseAction := caFree;
end;

procedure TReportSettingsForm.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  AvailableTablesList := TStringList.Create;
  UsedTablesList := TStringList.Create;
  FilterList := TStringList.Create;
  Screen.Cursor := crDefault;
end;

procedure TReportSettingsForm.ConstrCheckBoxClick(Sender: TObject);
begin
  RecordsButton.Enabled := ConstrCheckBox.Checked;
end;

procedure TReportSettingsForm.RecordsButtonClick(Sender: TObject);
var
  s: Byte;
begin
  with TSelConstrForm.Create(Application) do
  begin
    TableListBox.Clear;
    TableListBox.Items.AddStrings(AvailableTablesList);
    ShowModal;
    if ModalResult = mrOK then
    begin
      for s := 1 to 10 do
      if StringGrid.Cells[0,s] > '' then
      begin
        UsedTablesList.Add(StringGrid.Cells[0,s]);
        FilterList.Add(StringGrid.Cells[1,s]);
      end;
    end
    else
      ConstrCheckBox.Checked := False;
  end;
end;

procedure TReportSettingsForm.Wordwrap1Click(Sender: TObject);
begin
  CommentMemo.WordWrap := popupmenu1.Items[0].Checked;
end;

end.
