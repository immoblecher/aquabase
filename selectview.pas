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
unit SelectView;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, ZDataset, Forms, Controls, Graphics, Dialogs,
  StdCtrls, XMLPropStorage, ExtCtrls, DbCtrls, PairSplitter, ButtonPanel, LCLType;

type

  { TSelectViewForm }

  TSelectViewForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    DataSource1: TDataSource;
    DBMemo: TDBMemo;
    ListBoxViews: TListBox;
    PairSplitter1: TPairSplitter;
    PairSplitterSide1: TPairSplitterSide;
    PairSplitterSide2: TPairSplitterSide;
    XMLPropStorage1: TXMLPropStorage;
    DefinitionQuery: TZReadOnlyQuery;
    ViewQuery: TZReadOnlyQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure ListBoxViewsClick(Sender: TObject);
    procedure ListBoxViewsDblClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  SelectViewForm: TSelectViewForm;

implementation

{$R *.lfm}

uses MainDataModule, VARINIT;

{ TSelectViewForm }

procedure TSelectViewForm.FormCreate(Sender: TObject);
var
  TheViews: TStringList;
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  TheViews := TStringList.Create;
  DataModuleMain.GetAllViews(DataModuleMain.ZConnectionDB, TheViews);
  ListBoxViews.Items.Assign(TheViews);
  TheViews.Free;
  if ListBoxViews.Count > 0 then
  begin
    ListBoxViews.ItemIndex := 0;
    with DefinitionQuery do
    begin
      SQL.Clear;
      case DataModuleMain.ZConnectionDB.Tag of
        1: begin
            SQL.AddText('SELECT sql FROM sqlite_master WHERE name = ' + QuotedStr(ListBoxViews.Items[ListBoxViews.ItemIndex]) + ';');
            DBMemo.DataField := 'sql';
           end;
      2,3: begin
             SQL.AddText('SHOW CREATE VIEW ' + ListBoxViews.Items[ListBoxViews.ItemIndex]);
             DBMemo.DataField := 'Create View';
           end;
        4: begin
             SQL.AddText('select pg_get_viewdef(' + QuotedStr(ListBoxViews.Items[ListBoxViews.ItemIndex]) + ', true)');
             DBMemo.DataField := 'pg_get_viewdef';
           end;
        5: begin
             SQL.AddText('SELECT VIEW_DEFINITION FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = ' + QuotedStr(ListBoxViews.Items[ListBoxViews.ItemIndex]));
             DBMemo.DataField := 'VIEW_DEFINITION';
           end;
      end; //of case
      Open;
    end;
  end
  else
    MessageDlg('There are no Views in the list! Please ask your database administrator to set up permissions to access the database Views.', mtWarning, [mbOK], 0);
end;

procedure TSelectViewForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TSelectViewForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TSelectViewForm.ListBoxViewsClick(Sender: TObject);
begin
  with DefinitionQuery do
  begin
    Close;
    SQL.Clear;
    case DataModuleMain.ZConnectionDB.Tag of
      1: SQL.AddText('SELECT sql FROM sqlite_master WHERE name = ' + QuotedStr(ListBoxViews.Items[ListBoxViews.ItemIndex]) + ';');
    2,3: SQL.AddText('SHOW CREATE VIEW ' + ListBoxViews.Items[ListBoxViews.ItemIndex]);
      4: SQL.AddText('select pg_get_viewdef(' + QuotedStr(ListBoxViews.Items[ListBoxViews.ItemIndex]) + ', true)');
      5: SQL.AddText('SELECT VIEW_DEFINITION FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = ' + QuotedStr(ListBoxViews.Items[ListBoxViews.ItemIndex]));
    end; //of case
    Open;
  end;
end;

procedure TSelectViewForm.ListBoxViewsDblClick(Sender: TObject);
var
  LastCurrentSite: ShortString;
begin
  LastCurrentSite := CurrentSite;
  with DataModuleMain.ZQueryView do
  begin
    Close;
    FilterName := ListBoxViews.Items[ListBoxViews.ItemIndex];
    Open;
    if not Locate('SITE_ID_NR', LastCurrentSite, []) then
      First;
  end;
  Close;
end;

procedure TSelectViewForm.OKButtonClick(Sender: TObject);
begin
  ListBoxViewsDblClick(Sender);
end;

end.

