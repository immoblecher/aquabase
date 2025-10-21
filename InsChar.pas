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
unit InsChar;

{$mode objfpc}{$H+}

interface

uses
  LCLIntf, LCLType, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, ButtonPanel, ZDataset;

type

  { TInsCharForm }

  TInsCharForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    GroupBox1: TGroupBox;
    EditChar: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ComboBoxView: TComboBox;
    ViewQuery: TZReadOnlyQuery;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure ViewQueryBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InsCharForm: TInsCharForm;

implementation

uses varinit, MainDataModule;

{$R *.lfm}

procedure TInsCharForm.FormActivate(Sender: TObject);
var
  TheViews: TStringList;
begin
  TheViews := TStringList.Create;
  DataModuleMain.GetAllViews(DataModuleMain.ZConnectionDB, TheViews);
  ComboBoxView.Items.Assign(TheViews);
  TheViews.Free;
  ComboBoxView.ItemIndex := 0;
end;

procedure TInsCharForm.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
end;

procedure TInsCharForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TInsCharForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TInsCharForm.OKButtonClick(Sender: TObject);
var noError: Boolean;
begin
  noError := True;
  if MessageDlg('Are you sure you want to insert "' + EditChar.Text + '" into all sites in the "' + ComboBoxView.Text + '" View?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if DataModuleMain.ZConnectionDB.Protocol = 'sqlite-3' then
      noError := DataModuleMain.ZConnectionDB.ExecuteDirect('UPDATE basicinf SET SITE_ID_NR = (SUBSTR(SITE_ID_NR, 1, 6) || ' + QuotedStr(EditChar.Text) + ' || SUBSTR(SITE_ID_NR, 8, 4)) WHERE SITE_ID_NR IN (SELECT SITE_ID_NR FROM ' + ComboboxView.Text + ')')
    else
      noError := DataModuleMain.ZConnectionDB.ExecuteDirect('UPDATE basicinf SET SITE_ID_NR = CONCAT(SUBSTR(SITE_ID_NR, 1, 6), ' + QuotedStr(EditChar.Text) + ', SUBSTR(SITE_ID_NR, 8, 4)) WHERE SITE_ID_NR IN (SELECT SITE_ID_NR FROM ' + ComboboxView.Text + ')');
    if noError then
      MessageDlg('Character successfully inserted.', mtInformation, [mbOK], 0)
    else
      MessageDlg('One or more errors occured inserting the character, possibly due to foreign key constraints! Please check if the sites in the filter with the new character do not exist already.', mtError, [mbOK], 0);
    DataModuleMain.ZQueryView.Refresh;
  end
  else
    ShowMessage('Insertion of character aborted!');
end;

procedure TInsCharForm.ViewQueryBeforeOpen(DataSet: TDataSet);
begin
  ViewQuery.Connection := DataModuleMain.ZConnectionDB;
end;

end.
