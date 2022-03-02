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
unit writemember;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ButtonPanel, DateTimePicker, ZDataset, LCLType;

type

  { TWriteMemberForm }

  TWriteMemberForm = class(TForm)
    Button1: TButton;
    ButtonPanel1: TButtonPanel;
    ViewComboBox: TComboBox;
    DefinitionQuery: TZReadOnlyQuery;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LabeledEditMemberDescr: TLabeledEdit;
    LabeledEditMemberID: TLabeledEdit;
    ViewQuery: TZReadOnlyQuery;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure LabeledEditMemberIDChange(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  WriteMemberForm: TWriteMemberForm;

implementation

{$R *.lfm}

{ TWriteMemberForm }

uses MainDataModule, Strdatetime, varinit;

procedure TWriteMemberForm.FormCreate(Sender: TObject);
var
  TheViews: TStringList;
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  TheViews := TStringList.Create;
  DataModuleMain.GetAllViews(DataModuleMain.ZConnectionDB, TheViews);
  ViewComboBox.Items.Assign(TheViews);
  TheViews.Free;
  ViewComboBox.ItemIndex := 0;
  DateTimePicker2.Date := Now;
end;

procedure TWriteMemberForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TWriteMemberForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TWriteMemberForm.LabeledEditMemberIDChange(Sender: TObject);
begin
  Buttonpanel1.OKButton.Enabled := LabeledEditMemberID.Text <> '';
end;

procedure TWriteMemberForm.OKButtonClick(Sender: TObject);
var
  Rows: Integer;
begin
  with DataModuleMain.ZConnectionDB do
  begin
    if Tag = 4 then //postgres
    begin
      if ExecuteDirect('INSERT INTO member__ (SITE_ID_NR, DATE_FROM, DATE_TO, MEMBER_ID, DESCRIPTN, COMMENT) SELECT SITE_ID_NR, '
      + QuotedStr(FormatDateTime('YYYYMMDD', DateTimePicker1.Date)) + ', ' + QuotedStr(FormatDateTime('YYYYMMDD', DateTimePicker2.Date)) + ', '
      + QuotedStr(LabeledEditMemberID.Text) + ', ' + QuotedStr(LabeledEditMemberDescr.Text)
      + ', ' + QuotedStr('FROM VIEW') + ' FROM ' + ViewComboBox.Text, Rows) then
      MessageDlg(IntToStr(Rows) + ' sites inserted into Member table from view ' + ViewComboBox.Text + '.', mtInformation, [mbOK], 0);
    end
    else
    begin
      if ExecuteDirect('INSERT INTO member__ SELECT NULL, SITE_ID_NR, '
      + QuotedStr(FormatDateTime('YYYYMMDD', DateTimePicker1.Date)) + ', ' + QuotedStr(FormatDateTime('YYYYMMDD', DateTimePicker2.Date)) + ', '
      + QuotedStr(LabeledEditMemberID.Text) + ', ' + QuotedStr(LabeledEditMemberDescr.Text)
      + ', ' + QuotedStr('FROM VIEW') + ' FROM ' + ViewComboBox.Text, Rows) then
      MessageDlg(IntToStr(Rows) + ' sites inserted into Member table from view ' + ViewComboBox.Text + '.', mtInformation, [mbOK], 0);
    end;
  end;
end;

procedure TWriteMemberForm.Button1Click(Sender: TObject);
begin
  DateTimePicker1.Date := Now;
end;

end.

