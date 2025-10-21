{ Copyright (C) 2025 Immo Blecher, immo@blecher.co.za

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
unit runsqlscript;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SynHighlighterSQL, SynCompletion, SynEdit,
  ZSqlProcessor, ZDataset, Forms, Controls, LCLType, Graphics, Dialogs,
  StdCtrls, ButtonPanel, Buttons, ExtCtrls, XMLPropStorage, Clipbrd, Menus,
  Types, SynEditKeyCmds;

type

  { TSQLScriptForm }

  TSQLScriptForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    MenuItemCopy: TMenuItem;
    MenuItemPaste: TMenuItem;
    MenuItemCut: TMenuItem;
    MenuItemSelectAll: TMenuItem;
    N1: TMenuItem;
    OpenQueryDialog: TOpenDialog;
    OpenSpeedButton: TSpeedButton;
    PopupMenu1: TPopupMenu;
    TablesQuery: TZReadOnlyQuery;
    Panel1: TPanel;
    SaveQueryDialog: TSaveDialog;
    SaveSpeedButton: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SynCompletion1: TSynCompletion;
    SynCompletion2: TSynCompletion;
    SynEdit1: TSynEdit;
    SynSQLSyn1: TSynSQLSyn;
    XMLPropStorage1: TXMLPropStorage;
    ZSQLProcessor1: TZSQLProcessor;
    procedure CloseButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure MenuItemCopyClick(Sender: TObject);
    procedure MenuItemPasteClick(Sender: TObject);
    procedure MenuItemCutClick(Sender: TObject);
    procedure MenuItemSelectAllClick(Sender: TObject);
    procedure OpenSpeedButtonClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure SaveSpeedButtonClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SynCompletion2CodeCompletion(var Value: string;
      SourceValue: string; var SourceStart, SourceEnd: TPoint;
      KeyChar: TUTF8Char; Shift: TShiftState);
    procedure SynEdit1Change(Sender: TObject);
    procedure SynEdit1Enter(Sender: TObject);
    procedure SynEdit1KeyPress(Sender: TObject; var Key: char);
    procedure ZSQLProcessor1Error(Processor: TZSQLProcessor;
      StatementIndex: Integer; E: Exception;
      var ErrorHandleAction: TZErrorHandleAction);
  private
    { private declarations }
    error: Boolean;
  public
    { public declarations }
  end;

var
  SQLScriptForm: TSQLScriptForm;

implementation

{$R *.lfm}

uses VARINIT, maindatamodule;

{ TSQLScriptForm }

procedure TSQLScriptForm.OpenSpeedButtonClick(Sender: TObject);
begin
  if OpenQueryDialog.Execute then
  begin
    SaveQueryDialog.Filename := OpenQueryDialog.FileName;
    SynEdit1.Clear;
    SynEdit1.Lines.LoadFromFile(OpenQueryDialog.FileName);
    SpeedButton1.Enabled := SynEdit1.Text > '';
    SaveSpeedButton.Enabled := SynEdit1.Text > '';
  end;
end;

procedure TSQLScriptForm.PopupMenu1Popup(Sender: TObject);
begin
  MenuItemSelectAll.Enabled := SynEdit1.Text > '';
  MenuItemCopy.Enabled := SynEdit1.SelText > '';
  MenuItemCut.Enabled := SynEdit1.SelText > '';
  MenuItemPaste.Enabled := Clipboard.HasFormat(CF_TEXT);
end;

procedure TSQLScriptForm.FormCreate(Sender: TObject);
var
  TempList: TStringList;
  t: Word;
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  TempList := TStringList.Create;
  with DataModuleMain do
  begin
    SetComponentFontAndSize(Sender, True);
    ZConnectionDB.DbcConnection.GetMetadata.ClearCache;
    ZConnectionDB.GetTableNames('', TempList); //get all tables
    TempList := GetValidATables(TempList);
    for t := 0 to TempList.Count - 1 do
    begin
      SynSQLSyn1.TableNames.Add(TempList[t]);
      SynCompletion2.ItemList.Add(TempList[t]);
    end;
    GetValidATables(TempList).Free;
  end;
  with SynEdit1.Font do
  begin
    Name := 'Courier New';
    Pitch := fpFixed;
    Size := 9;
    Quality := fqNonAntialiased;
  end;
end;

procedure TSQLScriptForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TSQLScriptForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TSQLScriptForm.MenuItemCopyClick(Sender: TObject);
begin
  SynEdit1.CommandProcessor(TSynEditorCommand(ecCopy), ' ', nil);
end;

procedure TSQLScriptForm.MenuItemPasteClick(Sender: TObject);
begin
  SynEdit1.CommandProcessor(TSynEditorCommand(ecPaste), ' ', nil);
end;

procedure TSQLScriptForm.MenuItemCutClick(Sender: TObject);
begin
  SynEdit1.CommandProcessor(TSynEditorCommand(ecCut), ' ', nil);
end;

procedure TSQLScriptForm.MenuItemSelectAllClick(Sender: TObject);
begin
  SynEdit1.SelectAll;
end;

procedure TSQLScriptForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TSQLScriptForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TSQLScriptForm.SaveSpeedButtonClick(Sender: TObject);
begin
  if SaveQueryDialog.Execute then
  begin
    SynEdit1.Lines.SaveToFile(SaveQueryDialog.FileName);
    OpenQueryDialog.Filename := SaveQueryDialog.FileName;
  end;
end;

procedure TSQLScriptForm.SpeedButton1Click(Sender: TObject);
var warn: Boolean;
begin
  //check for delete and update with where clause and warn user
  warn := ((Pos('UPDATE', UpperCase(SynEdit1.Text)) > 0) or (Pos('DELETE', UpperCase(SynEdit1.Text)) > 0)) and (Pos('WHERE', UpperCase(SynEdit1.Text)) = 0);
  if warn then
  begin
    if MessageDlg('Please confirm before running the script', 'The script contains UPDATE and/or DELETE clauses without WHERE clause, which may change/delete a whole dataset! Are you sure you want to continue?', mtWarning, [mbYes, mbNo], 0) = mrYes then
      warn := False;
  end;
  if not warn then
  begin
    if MessageDlg('Please confirm before running the script', 'Are you sure you want to run this script?', mtWarning, [mbYes, mbNo], 0) = mrYes then
    begin
      Screen.Cursor := crSQLWait;
      Sleep(100);
      Application.ProcessMessages;
      error := False;
      with ZSQLProcessor1 do
      begin
        Delimiter := ComboBox1.Text;
        Script.Clear;
        Script.AddStrings(SynEdit1.Lines);
        Execute;
        Screen.Cursor := crDefault;
        Application.ProcessMessages;
      end;
      if error then
      begin
        Screen.Cursor := crDefault;
        MessageDlg('The execution of the script encountered some errors! Please fix the relevant lines and try again.', mtError, [mbOK], 0)
      end
      else
      begin
        Screen.Cursor := crDefault;
        MessageDlg('Script successfully executed! No records will be shown here, even if selected.', mtInformation, [mbOK], 0);
      end;
    end;
  end;
end;

procedure TSQLScriptForm.SpeedButton2Click(Sender: TObject);
begin
  SynEdit1.Clear;
  SpeedButton1.Enabled := False;
  SaveSpeedButton.Enabled := False;
end;

procedure TSQLScriptForm.SynCompletion2CodeCompletion(var Value: string;
  SourceValue: string; var SourceStart, SourceEnd: TPoint; KeyChar: TUTF8Char;
  Shift: TShiftState);
var
  f: Word;
begin
  with TablesQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM ' + Value + ' WHERE 1<>1'); //GET STRUCTURE
    Open;
    SynCompletion1.ItemList.Clear;
    for f := 0 to FieldDefs.Count - 1 do
      SynCompletion1.ItemList.Add(FieldDefs.Items[f].Name);
    Close;
  end;
end;

procedure TSQLScriptForm.SynEdit1Change(Sender: TObject);
var
  w: String;
  cPos: TPoint;
  f: Word;
  Found: Boolean;
begin
  ButtonPanel1.OKButton.Enabled := False;
  //remember where cursor is for popup
  cPos.X := SynEdit1.CaretXPix + 15;
  cPos.Y := SynEdit1.CaretYPix + SynEdit1.Top + 16;
  cPos := ClientToScreen(cPos);
  w := SynEdit1.GetWordAtRowCol(SynEdit1.CaretXY);
  Found := False;
  //popup help with fields or table while typing
  if Length(w) > 3 then
  begin
    for f := 0 to SynCompletion2.ItemList.Count - 1 do
    if (Pos(w, SynCompletion2.ItemList[f]) = 1) or (Pos(UpperCase(w), SynCompletion2.ItemList[f]) = 1) then
    begin
      Found := True;
      Break
    end;
    if Found then
      SynCompletion2.Execute(w, cPos)
    else
    if SynCompletion1.ItemList.Count > 0 then
    begin
      for f := 0 to SynCompletion1.ItemList.Count - 1 do
      if (Pos(w, SynCompletion1.ItemList[f]) = 1) or (Pos(UpperCase(w), SynCompletion1.ItemList[f]) = 1) then
      begin
        Found := True;
        Break
      end;
      if Found then
        SynCompletion1.Execute(w, cPos);
    end;
  end;
  SpeedButton1.Enabled := Length(SynEdit1.Text) > 0;
  SaveSpeedButton.Enabled := Length(SynEdit1.Text) > 0;
end;

procedure TSQLScriptForm.SynEdit1Enter(Sender: TObject);
begin
  with SynEdit1 do
  begin
    if Lines[0] = 'Load or type a SQL script to execute...' then
      Clear;
  end;
end;

procedure TSQLScriptForm.SynEdit1KeyPress(Sender: TObject; var Key: char);
begin
  if Key = '(' then
    SynEdit1.InsertTextAtCaret(')', scamBegin)
  else
  if Key = '''' then
    SynEdit1.InsertTextAtCaret('''', scamBegin)
  else
  if Key = '"' then
    SynEdit1.InsertTextAtCaret('"', scamBegin)
end;

procedure TSQLScriptForm.ZSQLProcessor1Error(Processor: TZSQLProcessor;
  StatementIndex: Integer; E: Exception;
  var ErrorHandleAction: TZErrorHandleAction);
begin
  error := True;
  ErrorHandleAction := eaSkip;
  Screen.Cursor := crDefault;
  ShowMessage(E.Message + '. The script has therefore skipped executing line ' + IntToStr(StatementIndex) + ', but will try and execute the remaining script lines!');
  Screen.Cursor := crSQLWait;
end;

end.

