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
unit LookupRepSet;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  ButtonPanel, StdCtrls, DbCtrls, ZDataset, LCLType;

type

  { TLookupRepSetForm }

  TLookupRepSetForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Label1: TLabel;
    ListBox1: TListBox;
    Memo1: TMemo;
    ZReadOnlyQuery1: TZReadOnlyQuery;
    ZReadOnlyQuery1USED_FOR: TStringField;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure ListBox1SelectionChange(Sender: TObject; User: boolean);
    procedure OKButtonClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  LookupRepSetForm: TLookupRepSetForm;

implementation

{$R *.lfm}

uses VARINIT, lookuprep, Repprev, MainDataModule;

{ TLookupRepSetForm }

procedure TLookupRepSetForm.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  with ZReadOnlyQuery1 do
  begin
    Open;
    while not EOF do
    begin
      ListBox1.Items.Add(ZReadOnlyQuery1USED_FOR.Value);
      Next
    end;
    Close;
  end;
  //ListBox1.ItemIndex := 0;
end;

procedure TLookupRepSetForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TLookupRepSetForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TLookupRepSetForm.ListBox1SelectionChange(Sender: TObject;
  User: boolean);
begin
   ButtonPanel1.OKButton.Enabled := ListBox1.SelCount > 0;
end;

procedure TLookupRepSetForm.OKButtonClick(Sender: TObject);
var m: Integer;
begin
  with TLookupReportForm.Create(Application) do
  begin
    RLSystemInfo1.Visible := CheckBox1.Checked;
    FooterBand.Visible := CheckBox2.Checked or CheckBox3.Checked or CheckBox4.Checked;
    RLSystemInfo2.Visible := CheckBox2.Checked;
    RLMemoUserDetails.Visible := CheckBox3.Checked;
    RLImageLogo.Visible := CheckBox3.Checked;
    CommentMemo.Visible := CheckBox4.Checked;
    CommentMemo.Lines.Clear;
    CommentMemo.Lines.AddStrings(Memo1.Lines);
    if (not CommentMemo.Visible) and (not RLImageLogo.Visible) and (not RLMemoUserDetails.Visible) and RLSystemInfo2.Visible then
    begin
      FooterBand.Height := 16;
      RLSystemInfo2.Top := 2;
    end;
    CategoryList := TStringList.Create;
    for m := 0 to ListBox1.Count - 1 do
    begin
      if ListBox1.Selected[m] then CategoryList.Add(ListBox1.Items[m]);
    end;
    try
      Screen.Cursor := crHourglass;
      with TRepPrevForm.Create(Application) do
      begin
        RLReport1.Preview(RLPreview1);
        Show;
      end;
    finally
      Screen.Cursor := crDefault;
      Close;
    end;
  end;
end;

procedure TLookupRepSetForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

end.

