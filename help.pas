{ Copyright (C) 2020 Immo Blecher, immo@blecher.co.za

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
unit help;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, PrintersDlgs, Forms,
  LCLIntf, Controls, Graphics, Dialogs, ButtonPanel, ComCtrls, DbCtrls,
  ExtCtrls, XMLPropStorage, ZDataset, ZSqlProcessor, ZConnection, Printers,
  StdCtrls, LCLType, Clipbrd;

type

  { THelpForm }

  THelpForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    DataSource1: TDataSource;
    DBMemo1: TDBMemo;
    DBNavigator1: TDBNavigator;
    DBText1: TDBText;
    Edit1: TEdit;
    ImageList1: TImageList;
    Label1: TLabel;
    Panel1: TPanel;
    PrintDialog: TPrintDialog;
    Splitter1: TSplitter;
    ToolBar1: TToolBar;
    ToolButtonPrev: TToolButton;
    ToolButtonCollapse: TToolButton;
    ToolButtonNext: TToolButton;
    ToolButton3: TToolButton;
    ToolButtonHome: TToolButton;
    ToolButton6: TToolButton;
    ToolButtonPrint: TToolButton;
    TreeView1: TTreeView;
    XMLPropStorage: TXMLPropStorage;
    ZConnection1: TZConnection;
    ZQueryHelp: TZQuery;
    ZQueryHelpHELP_DESCR: TBlobField;
    ZQueryHelpHTTP_LINK: TMemoField;
    ZQueryHelpID: TLargeintField;
    ZQueryHelpNODE_ID: TLargeintField;
    ZSQLProcessor1: TZSQLProcessor;
    procedure DBText1Click(Sender: TObject);
    procedure Edit1EditingDone(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure ToolButtonCollapseClick(Sender: TObject);
    procedure ToolButtonPrintClick(Sender: TObject);
    procedure ToolButtonPrevNextClick(Sender: TObject);
    procedure ToolButtonHomeClick(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure ZConnection1BeforeConnect(Sender: TObject);
    procedure ZQueryHelpBeforeRefresh(DataSet: TDataSet);
    procedure ZQueryHelpPostError(DataSet: TDataSet; E: EDatabaseError;
      var DataAction: TDataAction);
    procedure ZQueryHelpHTTP_LINKGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure ZSQLProcessor1BeforeExecute(Processor: TZSQLProcessor;
      StatementIndex: Integer);
  private
    PrevNodeIdx: Word;
    MyClipBoard: TClipBoard;
  public

  end;

var
  HelpForm: THelpForm;

implementation

{$R *.lfm}

uses MainDataModule, VARINIT;

const SiteURL = 'https://aquabase.blecher.co.za/wp';

{ THelpForm }

procedure THelpForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  MyClipBoard.Free;
  ZQueryHelp.Close;
  CloseAction := caFree;
  DataModuleMain.SpecHelpForm := NIL;
end;

procedure THelpForm.Edit1EditingDone(Sender: TObject);
var
  n: Integer;
  NodesFound: Boolean;
  Node: TTreeNode;
begin
  if Edit1.Text > '' then
  begin;
    for n := 0 to TreeView1.Items.Count - 1 do //makes all nodes visible first
      TreeView1.Items[n].Visible := True;
    NodesFound := False;
    for n := TreeView1.Items.Count - 1 downto 0 do //then make nodes not found invisible from bottom
    begin
      Node := TreeView1.Items[n];
      if Pos(UpperCase(Edit1.Text), UpperCase(Node.Text)) > 0 then
      begin
       NodesFound := True;
       TreeView1.Selected := Node;
      end
      else
      if (Node.GetFirstVisibleChild = nil) then
        Node.Visible := False;
    end;
    if not NodesFound then
    begin
      for n := 0 to TreeView1.Items.Count - 1 do
        TreeView1.Items[n].Visible := True;
      ShowMessage('Search text not found in Help items!');
    end;
  end;
end;

procedure THelpForm.FormActivate(Sender: TObject);
begin
  if WSpaceDir = '' then
  begin //the workspace was closed
    if (ZQueryHelp.Connection = DataModuleMain.ZConnectionLanguage) then
    begin
      ZConnection1.Connect;
      ZQueryHelp.Connection.Disconnect;
      ZQueryHelp.Connection := ZConnection1;
      DBNavigator1.Enabled := False;
      TreeView1.Selected := TreeView1.Items[0];
    end;
  end
  else
  if DataModuleMain.ZConnectionLanguage.Connected and (ZQueryHelp.Connection = ZConnection1) then
  begin //the workspace was openend
    ZQueryHelp.Connection.Disconnect;
    ZQueryHelp.Connection := DataModuleMain.ZConnectionLanguage;
    TreeView1.Selected := TreeView1.Items[0];
  end;
end;

procedure THelpForm.DBText1Click(Sender: TObject);
begin
  OpenURL(SiteURL + ZQueryHelpHTTP_LINK.AsString);
end;

procedure THelpForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  DBNavigator1.Images := DataModuleMain.ImageListNavs;
  MyClipBoard := TClipboard.Create;
  if WSpaceDir = '' then
    ZQueryHelp.Connection := ZConnection1
  else
    ZQueryHelp.Connection := DataModuleMain.ZConnectionLanguage;
end;

procedure THelpForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) then
  begin
    if Key IN [90, 122] then //ctrl-z
      DBMemo1.Undo
    else
    if (DBMemo1.SelText > '') and (Key IN [67, 99]) then //ctrl-c
      MyClipBoard.AsText := DBMemo1.SelText
    else
    if (DBMemo1.SelText > '') and (Key IN [88, 120]) then //ctrl-x
    begin
      MyClipBoard.AsText := DBMemo1.SelText;
      DBMemo1.ClearSelection;
    end
    else
    if Key IN [65, 97] then //ctrl-a
    begin
      DBMemo1.SelectAll;
    end;
    DBMemo1.SetFocus;
  end
  else if Key = VK_F8 then
    ZQueryHelp.Post
  else if Key = VK_F12 then
    if not ZQueryHelp.Connection.ReadOnly then
      DBNavigator1.Enabled := True;
end;

procedure THelpForm.HelpButtonClick(Sender: TObject);
begin
  TreeView1.Selected := TreeView1.Items[0];
end;

procedure THelpForm.ToolButtonCollapseClick(Sender: TObject);
begin
  if (Sender as TToolButton).Tag = 1 then //is down
  begin
    TreeView1.FullExpand;
    (Sender as TToolButton).Down := False;
    (Sender as TToolButton).Tag := 0;
  end
  else //is not down
  begin
    TreeView1.FullCollapse;
    (Sender as TToolButton).Down := True;
    (Sender as TToolButton).Tag := 1;
  end;
end;

procedure THelpForm.ToolButtonPrintClick(Sender: TObject);
var
 i: Integer;
begin
  if PrintDialog.Execute then
  begin
   Printer.BeginDoc;
   Printer.Title := 'Aquabase Help';
   for i := 0 to DBMemo1.Lines.Count -1 do
     Printer.Canvas.TextOut(10, i * 100, DBMemo1.Lines[I]);
   Printer.EndDoc;
  end;
end;

procedure THelpForm.ToolButtonPrevNextClick(Sender: TObject);
var
  n: Integer;
begin
  for n := 0 to TreeView1.Items.Count - 1 do
    if TreeView1.Items[n].SelectedIndex = PrevNodeIdx then
      TreeView1.Selected := TreeView1.Items[n];
end;

procedure THelpForm.ToolButtonHomeClick(Sender: TObject);
var
  n: Integer;
begin
  for n := 0 to TreeView1.Items.Count - 1 do
    TreeView1.Items[n].Visible := True;
  if Edit1.Text > '' then
  begin
    Edit1.Clear;
    if MessageDlg('The search has been cleared! Do you want to stay at the last found item (or go HOME (top))?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      TreeView1.Selected := TreeView1.Items[0];
  end;
end;

procedure THelpForm.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  ZQueryHelp.Close;
  PrevNodeIdx := ZQueryHelp.Params[0].AsInteger;
  ZQueryHelp.Params[0].Value := Node.SelectedIndex;
  try
    ZQueryHelp.Open;
  except on E: Exception do
    begin
      MessageDlg('Your Help database in your non-default settings location has not been set up yet! It will be created now.', mtWarning, [mbOK], 0);
      Screen.Cursor := crSQLWait;
      ZSQLProcessor1.Script.LoadFromFile(ProgramDir + DirectorySeparator + 'Databases' + DirectorySeparator + 'SQLite'  + DirectorySeparator + 'create_help.sql');
      ZSQLProcessor1.Execute;
      ZQueryHelp.Open;
      Screen.Cursor := crDefault;
      ShowMessage('Help database created/updated successfully.');
    end;
  end;
end;

procedure THelpForm.ZConnection1BeforeConnect(Sender: TObject);
begin
  with DataModuleMain.ZConnectionCountries do
  begin
    Connect;
    Disconnect;
  end;
  with ZConnection1 do
  begin
    LibraryLocation := SQLiteLib;
    Database := ProgramDir + DirectorySeparator + DataModuleMain.CountryDB + '.sqlite'
  end;
end;

procedure THelpForm.ZQueryHelpBeforeRefresh(DataSet: TDataSet);
begin
  if MessageDlg('Are you sure you want to refresh your Help database with the default Help items? This will remove/overwrite any changes you have made.', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  with ZQueryHelp do
  begin
    Screen.Cursor := crSQLWait;
    Close;
    PrevNodeIdx := Params[0].AsInteger;
    ZSQLProcessor1.Execute;
    Params[0].Value := PrevNodeIdx;
    Open;
    Screen.Cursor := crDefault;
    ShowMessage('Help database refreshed successfully with default Help items.');
  end;
end;

procedure THelpForm.ZQueryHelpPostError(DataSet: TDataSet; E: EDatabaseError;
  var DataAction: TDataAction);
begin
  ShowMessage(E.Message + '. Record will not be posted to the Help database!');
  DataAction := daAbort;
end;

procedure THelpForm.ZQueryHelpHTTP_LINKGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := SiteURL + Sender.AsString;
end;

procedure THelpForm.ZSQLProcessor1BeforeExecute(Processor: TZSQLProcessor;
  StatementIndex: Integer);
begin
  Processor.Script.LoadFromFile(ProgramDir + DirectorySeparator + 'Databases' + DirectorySeparator + 'SQLite'  + DirectorySeparator + 'create_help.sql');
end;

end.

