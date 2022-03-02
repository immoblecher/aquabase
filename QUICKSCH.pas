{ Copyright (C) 2019 Immo Blecher immo@blecher.co.za

  This source is free software; you can redistribute it and/or modify it under
  the terms of the GNU General Public License as published by the Free
  Software Foundation; either version 2 of the License, or (at your option)
  any later version.

  This code is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

  A copy of the GNU General Public License is available on the World Wide Web
  at http://www.gnu.org/copyleft/gpl.html. You can also obtain it by writing
  to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
  MA 02111-1307, USA.
}
unit QUICKSCH;

{$mode objfpc}{$H+}

interface

uses Classes, Graphics, Forms, Controls, Buttons, ZDataset, SysUtils,
  StdCtrls, ExtCtrls, DB, Dialogs, LCLType, ButtonPanel, XMLPropStorage;

type

  { TQuickSearchForm }

  TQuickSearchForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    ComboBoxSearch: TComboBox;
    SearchBtn: TBitBtn;
    Label1: TLabel;
    ComboBoxField: TComboBox;
    Label2: TLabel;
    SearchQuery: TZReadOnlyQuery;
    SpeedButton2: TSpeedButton;
    XMLPropStorage: TXMLPropStorage;
    procedure CloseButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure RadioGroupClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure SearchBtnClick(Sender: TObject);
    procedure ComboBoxFieldChange(Sender: TObject);
    procedure ComboBoxSearchChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  QuickSearchForm: TQuickSearchForm;

implementation

{$R *.lfm}

uses varinit, MainDataModule;

procedure TQuickSearchForm.FormActivate(Sender: TObject);
begin
  with ComboBoxSearch do
  begin
    SetFocus;
    SelectAll;
    SearchBtn.Enabled := Text > '';
    ButtonPanel1.OKButton.Enabled := Text > '';
  end;
  //SearchBtn.Caption := 'Search';
end;

procedure TQuickSearchForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TQuickSearchForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TQuickSearchForm.FormShow(Sender: TObject);
begin
  if ComboBoxField.Text = '' then
  begin
    ComboBoxField.Text := 'NR_ON_MAP';
    ComboBoxField.ItemIndex := 1;
  end;
end;

procedure TQuickSearchForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TQuickSearchForm.OKButtonClick(Sender: TObject);
var
  TheSearchText: ShortString;
begin
  Screen.Cursor := crSQLWait;
  TheSearchText := ComboBoxSearch.Text;
  if ComboBoxSearch.Items.IndexOf(TheSearchText) = -1 then //it doesn't exist yet
  begin
    if ComboBoxSearch.Items.Count = 10 then
      ComboBoxSearch.Items.Delete(9);
    ComboBoxSearch.Items.Insert(0, TheSearchText);
    ComboBoxSearch.ItemIndex := 0;
  end;
  with SearchQuery do
  begin
    Filtered := False;
    Locate(ComboBoxField.Text, ComboBoxSearch.Text, [loPartialKey]);
  end;
  if not SearchQuery.EOF then
  if Copy(SearchQuery.FieldByName(ComboBoxField.Text).AsString, 1, ComboBoxSearch.GetTextLen) = ComboBoxSearch.Text then
  begin
    case Self.Tag of
      0: CurrentSite := SearchQuery.FieldByName('SITE_ID_NR').AsString;
      1: CurrentProject := SearchQuery.FieldByName('PRO_REF_NR').AsString;
      2: CurrentTraverse := SearchQuery.FieldByName('TRAV_NR').AsString;
    end; //of case
  DataModuleMain.ZQueryView.Locate('SITE_ID_NR', CurrentSite, []);
  end
  else
  begin
    Screen.Cursor := crDefault;
    MessageDlg('No match found for search criterion!', mtError, [mbOK], 0);
  end;
  Screen.Cursor := crDefault;
  Close;
end;

procedure TQuickSearchForm.RadioGroupClick(Sender: TObject);
begin
  ComboBoxSearch.SetFocus;
end;

procedure TQuickSearchForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SearchQuery.Close;
  CloseAction := caFree;
end;

procedure TQuickSearchForm.SearchBtnClick(Sender: TObject);
var
  TheSearchText: ShortString;
begin
  Screen.Cursor := crSQLWait;
  TheSearchText := ComboBoxSearch.Text;
  if ComboBoxSearch.Items.IndexOf(TheSearchText) = -1 then
  begin
    if ComboBoxSearch.Items.Count = 10 then
      ComboBoxSearch.Items.Delete(9);
    ComboBoxSearch.Items.Insert(0, TheSearchText);
    ComboBoxSearch.ItemIndex := 0;
  end;
  with SearchQuery do
  begin
    if (SearchBtn.Caption = 'Find next') and (not EOF) then
    begin
      case Self.Tag of
        0: Filter := 'SITE_ID_NR > ' + QuotedStr(CurrentSite);
        1: Filter := 'PRO_REF_NR > ' + QuotedStr(CurrentProject);
        2: Filter := 'TRAV_NR > ' + QuotedStr(CurrentTraverse);
      end; //of case
      Filtered := True;
    end
    else
    begin
      Filter := '';
      Filtered := False;
    end;
    Locate(ComboBoxField.Text, ComboBoxSearch.Text, [loPartialKey]);
  end;
  if Copy(SearchQuery.FieldByName(ComboBoxField.Text).AsString, 1, ComboBoxSearch.GetTextLen) = ComboBoxSearch.Text then
  begin
    case Self.Tag of
      0: CurrentSite := SearchQuery.FieldByName('SITE_ID_NR').AsString;
      1: CurrentProject := SearchQuery.FieldByName('PRO_REF_NR').AsString;
      2: CurrentTraverse := SearchQuery.FieldByName('TRAV_NR').AsString;
    end; //of case
    DataModuleMain.ZQueryView.Locate('SITE_ID_NR', CurrentSite, []);
    SearchBtn.Caption := 'Find next';
  end
  else
  begin
    Screen.Cursor := crDefault;
    MessageDlg('No (further) match found for search criterion! Please make sure you are searching for information in the correct field and View', mtError, [mbOK], 0);
    SearchBtn.Caption := 'Search';
  end;
  Screen.Cursor := crDefault;
end;

procedure TQuickSearchForm.ComboBoxFieldChange(Sender: TObject);
begin
  SearchBtn.Caption := 'Search';
end;

procedure TQuickSearchForm.ComboBoxSearchChange(Sender: TObject);
begin
  SearchBtn.Caption := 'Search';
  SearchBtn.Enabled := ComboBoxSearch.Text > '';
  ButtonPanel1.OKButton.Enabled := ComboBoxSearch.Text > '';
end;

procedure TQuickSearchForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  SearchQuery.SQL.Clear;
  case Self.Tag of
   0: begin
        SearchQuery.SQL.Add('SELECT f.SITE_ID_NR SITE_ID_NR, b.NR_ON_MAP NR_ON_MAP, b.ALT_NO_1 ALT_NO_1, b.ALT_NO_2 ALT_NO_2, b.SITE_NAME SITE_NAME FROM ' + FilterName + ' f');
        SearchQuery.SQL.Add('JOIN basicinf b ON (f.SITE_ID_NR = b.SITE_ID_NR)');
        SearchQuery.SQL.Add('ORDER BY f.SITE_ID_NR');
      end;
   1: begin
        SearchQuery.SQL.Add('SELECT PRO_REF_NR, PROJ_NR, PROJ_NAME, CLIENT, JOB_NR FROM proj_man ORDER BY PRO_REF_NR');
        Caption := 'Quick Search Project Information';
      end;
   2: begin
        SearchQuery.SQL.Add('SELECT TRAV_NR, SITE_NAME, SITE_LEAD FROM profilng ORDER BY TRAV_NR');
        Caption := 'Quick Search Traverse Information';
      end;
  end; //of case
  Screen.Cursor := crSQLWait;
  SearchQuery.Open;
  SearchQuery.GetFieldNames(ComboBoxField.Items);
  Screen.Cursor := crDefault;
end;

procedure TQuickSearchForm.SpeedButton2Click(Sender: TObject);
var
  TheSearchText: ShortString;
begin
  with ComboBoxSearch do
  begin
    TheSearchText := Text;
    Clear;
    Text := TheSearchText;
    SetFocus;
  end;
end;

end.
