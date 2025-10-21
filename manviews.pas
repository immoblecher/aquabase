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
unit manviews;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, ZDataset, Forms, Controls, Graphics, Dialogs,
  PairSplitter, StdCtrls, DbCtrls, XMLPropStorage, ExtCtrls, LCLType,
  Buttons, ButtonPanel;

type

  { TManageViewsForm }

  TManageViewsForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    DataSource1: TDataSource;
    DBMemo: TDBMemo;
    DeleteButton: TBitBtn;
    ListBoxViews: TListBox;
    PairSplitter1: TPairSplitter;
    PairSplitterSide1: TPairSplitterSide;
    PairSplitterSide2: TPairSplitterSide;
    RenameButton: TBitBtn;
    XMLPropStorage1: TXMLPropStorage;
    ViewQuery: TZReadOnlyQuery;
    DefinitionQuery: TZReadOnlyQuery;
    procedure DeleteButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure ListBoxViewsClick(Sender: TObject);
    procedure RenameButtonClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  ManageViewsForm: TManageViewsForm;

implementation

{$R *.lfm}

uses
  MainDataModule, VARINIT, ProvideViewName;

{ TManageViewsForm }

procedure TManageViewsForm.FormCreate(Sender: TObject);
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

procedure TManageViewsForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TManageViewsForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TManageViewsForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TManageViewsForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TManageViewsForm.DeleteButtonClick(Sender: TObject);
begin
  if ListBoxViews.Items[ListBoxViews.ItemIndex] = 'allsites' then
  begin
    MessageDlg('The "allsites" view cannot be deleted because it is required for the application!',
      mtWarning, [mbOK], mrOK);
  end
  else
  if (ListBoxViews.Items[ListBoxViews.ItemIndex] = FilterName) or (ListBoxViews.Items[ListBoxViews.ItemIndex] = 'allsites') then
  begin
    MessageDlg('The "' + FilterName + '" view cannot be deleted because it is currently in use!',
      mtWarning, [mbOK], mrOK);
  end
  else
  begin
    if MessageDlg('Are you sure you want to delete the selected view?', mtConfirmation,
      [mbYes, mbNo], mrNo) = mrYes then
    try
      DataModuleMain.ZConnectionDB.ExecuteDirect('DROP VIEW ' + ListBoxViews.Items[ListBoxViews.ItemIndex]);
      ListBoxViews.Items.Delete(ListBoxViews.ItemIndex);
    except on E: Exception do
      MessageDlg(E.Message + ': View cannot be deleted as you do not have the appropriate permissions!', mtError, [mbOK], 0);
    end;
  end;
end;

procedure TManageViewsForm.ListBoxViewsClick(Sender: TObject);
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

procedure TManageViewsForm.RenameButtonClick(Sender: TObject);
var
  NewViewName, SQLiteText: String;
  WasRenamed: Boolean;
  TheViews: TStringList;
begin
  if ListBoxViews.Items[ListBoxViews.ItemIndex] = 'allsites' then
  begin
    MessageDlg('The "allsites" view cannot be renamed because it is required for the application!',
      mtWarning, [mbOK], mrOK);
  end
  else
  if (ListBoxViews.Items[ListBoxViews.ItemIndex] = FilterName) or (ListBoxViews.Items[ListBoxViews.ItemIndex] = 'allsites') then
  begin
    MessageDlg('The "' + FilterName + '" view cannot be renamed because it is currently in use!',
      mtWarning, [mbOK], mrOK);
  end
  else
  begin
    with TProvideViewNameForm.Create(Application) do
    begin
      Edit1.Text := ListBoxViews.Items[ListBoxViews.ItemIndex];
      if ShowModal = mrOK then
      begin
        NewViewName := ViewName;
        try
          case DataModuleMain.ZConnectionDB.Tag of
            1: begin //a bit more complicated: drop and create
                 SQLiteText := StringReplace(DBMemo.Text, ListBoxViews.Items[ListBoxViews.ItemIndex], NewViewName, [rfReplaceAll]);
                 DataModuleMain.ZConnectionDB.ExecuteDirect('DROP VIEW ' + ListBoxViews.Items[ListBoxViews.ItemIndex]);
                 DataModuleMain.ZConnectionDB.ExecuteDirect(SQLiteText);
               end;
          2,3: DataModuleMain.ZConnectionDB.ExecuteDirect('RENAME TABLE ' + ListBoxViews.Items[ListBoxViews.ItemIndex] + ' TO ' + NewViewName);
            4: DataModuleMain.ZConnectionDB.ExecuteDirect('ALTER VIEW ' + ListBoxViews.Items[ListBoxViews.ItemIndex] + ' RENAME TO ' + NewViewName);
            5: DataModuleMain.ZConnectionDB.ExecuteDirect('EXEC sp_rename dbo.' + ListBoxViews.Items[ListBoxViews.ItemIndex] + ', ' + NewViewName);
          end; //of case
          WasRenamed := True;
        except on E: Exception do
          MessageDlg(E.Message + ': View cannot be renamed as you do not have the appropriate permissions!', mtError, [mbOK], 0);
        end;
        Close;
        Free;
        if WasRenamed then
        begin
          ListBoxViews.Clear;
          DataModuleMain.GetAllViews(DataModuleMain.ZConnectionDB, TheViews);
          ListBoxViews.Items.Assign(TheViews);
          TheViews.Free;
          ListBoxViews.ItemIndex := 0;
          with DefinitionQuery do
          begin
            Close;
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
        end;
      end
      else
        MessageDlg('Renaming of View cancelled!', mtInformation, [mbOK], 0);
    end;
  end;
end;

end.

