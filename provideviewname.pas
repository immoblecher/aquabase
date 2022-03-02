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
unit ProvideViewName;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, ButtonPanel, LCLType;

type

  { TProvideViewNameForm }

  TProvideViewNameForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Label1: TLabel;
    StaticText1: TStaticText;
    procedure Edit1Change(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    ViewName: String;
  end;

var
  ProvideViewNameForm: TProvideViewNameForm;

implementation

uses VARINIT, MainDataModule;

{$R *.lfm}

{ TProvideViewNameForm }

procedure TProvideViewNameForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TProvideViewNameForm.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, False);
end;

procedure TProvideViewNameForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TProvideViewNameForm.FormShow(Sender: TObject);
begin
  CheckBox1.Enabled := DataModuleMain.ZConnectionDB.Tag > 1;
  CheckBox1.Checked := DataModuleMain.ZConnectionDB.Tag = 1;
end;

procedure TProvideViewNameForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TProvideViewNameForm.OKButtonClick(Sender: TObject);
begin
  ViewName := Edit1.Text;
  //add _ if viewname is the same as an Aquabase table
  with DataModuleMain.CheckQuery do
  begin
    Connection := DataModuleMain.ZConnectionSettings;
    SQL.Clear;
    SQL.Add('select FILE_NAME from Aquasort where FILE_NAME = ' + QuotedStr(UpperCase(ViewName)));
    Open;
    if RecordCount = 1 then
      ViewName := ViewName + '_';
    Close;
    SQL.Clear;
    Connection := DataModuleMain.ZConnectionDB;
  end;
  //make sure views do not start with numbers
  if ViewName[1] in ['1'..'9'] then
    ViewName := 'View_' + ViewName;
end;

procedure TProvideViewNameForm.Edit1Change(Sender: TObject);
begin
  if UpperCase(Edit1.Text) = 'ALLSITES' then
  begin
    MessageDlg('You cannot use "allsites" as name for the new view as it is a system view!', mtError, [mbOK], 0);
    Edit1.Clear;
  end;
  Buttonpanel1.OKButton.Enabled := Edit1.Text > '';
end;

procedure TProvideViewNameForm.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', '_', 'a'..'z', #8]) then
    Key := #0;
end;

end.

