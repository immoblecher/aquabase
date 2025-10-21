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
unit flagrecords;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ButtonPanel, StdCtrls,
  Spin, Buttons, XMLPropStorage, SynCompletion, SynEdit, SynHighlighterSQL,
  ZDataset, DB, SynEditTypes, Types, LCLType, Menus, StrUtils, Clipbrd, SynEditKeyCmds;

type

  { TFlagForm }

  TFlagForm = class(TForm)
    BitBtnCheck: TBitBtn;
    ButtonPanel1: TButtonPanel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MenuItemCopy: TMenuItem;
    MenuItemCut: TMenuItem;
    MenuItemPaste: TMenuItem;
    MenuItemSelectAll: TMenuItem;
    N1: TMenuItem;
    OpenQueryDialog: TOpenDialog;
    OpenSpeedButton: TSpeedButton;
    PopupMenu1: TPopupMenu;
    SaveQueryDialog: TSaveDialog;
    SaveSpeedButton: TSpeedButton;
    SpinEdit1: TSpinEdit;
    FlagQuery: TZReadOnlyQuery;
    SynCompletion1: TSynCompletion;
    SynCompletion2: TSynCompletion;
    SynEdit1: TSynEdit;
    SynSQLSyn1: TSynSQLSyn;
    TableQuery: TZReadOnlyQuery;
    XMLPropStorage1: TXMLPropStorage;
    OtherTablesQuery: TZReadOnlyQuery;
    procedure BitBtnCheckClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox1DropDown(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure MenuItemCopyClick(Sender: TObject);
    procedure MenuItemCutClick(Sender: TObject);
    procedure MenuItemPasteClick(Sender: TObject);
    procedure MenuItemSelectAllClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure OpenSpeedButtonClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure SaveSpeedButtonClick(Sender: TObject);
    procedure SynCompletion2CodeCompletion(var Value: string;
      SourceValue: string; var SourceStart, SourceEnd: TPoint;
      KeyChar: TUTF8Char; Shift: TShiftState);
    procedure SynEdit1Change(Sender: TObject);
    procedure SynEdit1Enter(Sender: TObject);
    procedure SynEdit1KeyPress(Sender: TObject; var Key: char);
    procedure TableQueryAfterOpen(DataSet: TDataSet);
    procedure TableQueryBeforeOpen(DataSet: TDataSet);
  private
    UpdateError: Boolean;
    NrRecords: LongInt;
    CurItemIdx: Word;
  public

  end;

var
  FlagForm: TFlagForm;

implementation

{$R *.lfm}

uses MainDataModule, VARINIT;

{ TFlagForm }

procedure TFlagForm.OKButtonClick(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  try
   DataModuleMain.ZConnectionDB.ExecuteDirect('UPDATE ' + ComboBox1.Text + ' SET NGDB_FLAG = ' + IntToStr(SpinEdit1.Value) + ' WHERE ' + SynEdit1.Text + ';');
   Screen.Cursor := crDefault;
   MessageDlg('Flag was updated successfully! ' + IntToStr(NrRecords) + ' records were flagged/affected.' , mtInformation, [mbOK], 0);
   UpdateError := False;
  except on E: Exception do
    begin
      Screen.Cursor := crDefault;
      MessageDlg(E.Message + ' - Something went wrong setting the flag. Please try again.', mtError, [mbOK], 0);
      UpdateError := True;
      ButtonPanel1.OKButton.Enabled := False;
    end;
  end;
end;

procedure TFlagForm.OpenSpeedButtonClick(Sender: TObject);
var
  QueryList: TStringList;
  CheckPos: Integer;
begin
  OpenQueryDialog.InitialDir := WSpaceDir;
  if OpenQueryDialog.Execute then
  begin
    SaveQueryDialog.Filename := OpenQueryDialog.FileName;
    SynEdit1.Clear;
    QueryList := TStringList.Create;
    QueryList.LoadFromFile(OpenQueryDialog.FileName);
    //split query into ComboBox for tables and where condition in SynEdit1
    CheckPos := Pos('UPDATE', QueryList.Text);
    if CheckPos = 0 then
      MessageDlg('This does not seem to be a valid UPDATE query! Please select another SQL file or type the where condition in the box above.', mtError, [mbOK], 0)
    else
    begin
      ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(ExtractWord(2, QueryList[0], [' ']));
      CheckPos := Pos('SET ngdb_flag', QueryList.Text);
      if CheckPos = 0 then
        MessageDlg('This does not seem to be a valid UPDATE query! Please select another SQL file or type the where condition in the box above.', mtError, [mbOK], 0)
      else
      begin
        SpinEdit1.Value := StrToInt(ExtractWord(6, QueryList[0], [' ']));
        CheckPos := Pos('WHERE', QueryList.Text);
        if CheckPos = 0 then
          MessageDlg('This does not seem to be a valid UPDATE query! Please select another SQL file or type the where condition in the box above.', mtError, [mbOK], 0)
        else
        begin
          SynEdit1.Text := Copy(QueryList.Text, CheckPos + 6, Length(QueryList.Text));
          QueryList.Free;
          BitBtnCheck.Enabled := SynEdit1.Text > '';
          SaveSpeedButton.Enabled := SynEdit1.Text > '';
        end;
      end;
    end;
  end;
end;

procedure TFlagForm.PopupMenu1Popup(Sender: TObject);
begin
  MenuItemSelectAll.Enabled := SynEdit1.Text > '';
  MenuItemCopy.Enabled := SynEdit1.SelText > '';
  MenuItemCut.Enabled := SynEdit1.SelText > '';
  MenuItemPaste.Enabled := Clipboard.HasFormat(CF_TEXT);
end;

procedure TFlagForm.SaveSpeedButtonClick(Sender: TObject);
var
  SaveList: TStringList;
begin
  SaveQueryDialog.InitialDir := WSpaceDir;
  if SaveQueryDialog.Execute then
  begin
    SaveList := TStringList.Create;
    SaveList.Add('UPDATE ' + ComboBox1.Text + ' SET ngdb_flag = ' + IntToStr(SpinEdit1.Value));
    SaveList.Add('WHERE ' + SynEdit1.Text);
    SaveList.SaveToFile(SaveQueryDialog.FileName);
    OpenQueryDialog.Filename := SaveQueryDialog.FileName;
  end;
end;

procedure TFlagForm.SynCompletion2CodeCompletion(var Value: string;
  SourceValue: string; var SourceStart, SourceEnd: TPoint; KeyChar: TUTF8Char;
  Shift: TShiftState);
var
  f: Word;
begin
  with OtherTablesQuery do
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

procedure TFlagForm.SynEdit1Change(Sender: TObject);
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
    for f := 0 to SynCompletion1.ItemList.Count - 1 do
    if (Pos(w, SynCompletion1.ItemList[f]) = 1) or (Pos(UpperCase(w), SynCompletion1.ItemList[f]) = 1) then
    begin
      Found := True;
      Break
    end;
    if Found then
      SynCompletion1.Execute(w, cPos)
    else
    begin
      for f := 0 to SynCompletion2.ItemList.Count - 1 do
      if (Pos(w, SynCompletion2.ItemList[f]) = 1) or (Pos(UpperCase(w), SynCompletion2.ItemList[f]) = 1) then
      begin
        Found := True;
        Break
      end;
      if Found then
        SynCompletion2.Execute(w, cPos);
    end;
  end;
end;

procedure TFlagForm.SynEdit1Enter(Sender: TObject);
begin
  if SynEdit1.Lines[0] = '<enter a condition to restrict records>' then
    SynEdit1.Clear;
end;

procedure TFlagForm.SynEdit1KeyPress(Sender: TObject; var Key: char);
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

procedure TFlagForm.TableQueryAfterOpen(DataSet: TDataSet);
var
  f: Word;
begin
  SynCompletion1.ItemList.Clear;
  for f := 0 to TableQuery.FieldDefs.Count - 1 do
    SynCompletion1.ItemList.Add(TableQuery.FieldDefs.Items[f].Name);
end;

procedure TFlagForm.TableQueryBeforeOpen(DataSet: TDataSet);
begin
  TableQuery.SQL.Clear;
  TableQuery.SQL.Add('SELECT * FROM ' + ComboBox1.Text + ' WHERE 1<>1'); //GET STRUCTURE
end;

procedure TFlagForm.FormCreate(Sender: TObject);
var
  TempList: TStringList;
  t: Byte;
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  TempList := TStringList.Create;
  with DataModuleMain do
  begin
    SetComponentFontAndSize(Sender, True);
    ZConnectionDB.DbcConnection.GetMetadata.ClearCache;
    ZConnectionDB.GetTableNames('', TempList); //get all tables
    ComboBox1.Items.Assign(GetValidATables(TempList));
    GetValidATables(TempList).Free;
    FlagQuery.Connection := ZConnectionDB;
  end;
  with SynEdit1.Font do
  begin
    Name := 'Courier New';
    Pitch := fpFixed;
    Size := 9;
    Quality := fqNonAntialiased;
  end;
  TempList.Free;
  for t := ComboBox1.Items.Count- 1 downto 0 do
  with FlagQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM ' + ComboBox1.Items[t] + ' WHERE 1 <> 1'); //for getting all fields
    Open;
    if FindField('NGDB_FLAG') = NIL then
      ComboBox1.Items.Delete(t);
    Close;
  end;
  SynSQLSyn1.TableNames.Assign(ComboBox1.Items);
  SynCompletion2.ItemList.Assign(ComboBox1.Items);
  ComboBox1.Items.Delete(ComboBox1.Items.IndexOf('basicinf')); //cannot change flags in basicinf
  ComboBox1.Items.Delete(ComboBox1.Items.IndexOf('rprtdocs')); //no flags
  ComboBox1.ItemIndex := 0;
  TableQuery.Open;
  TableQuery.Close;
end;

procedure TFlagForm.MenuItemCopyClick(Sender: TObject);
begin
  SynEdit1.CommandProcessor(TSynEditorCommand(ecCopy), ' ', nil);
end;

procedure TFlagForm.MenuItemCutClick(Sender: TObject);
begin
  SynEdit1.CommandProcessor(TSynEditorCommand(ecCut), ' ', nil);
end;

procedure TFlagForm.MenuItemPasteClick(Sender: TObject);
begin
  SynEdit1.CommandProcessor(TSynEditorCommand(ecPaste), ' ', nil);
end;

procedure TFlagForm.MenuItemSelectAllClick(Sender: TObject);
begin
  SynEdit1.SelectAll;
end;

procedure TFlagForm.BitBtnCheckClick(Sender: TObject);
begin
  with FlagQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM ' + ComboBox1.Text + ' WHERE ' + SynEdit1.Text); //for checking if condition works
    try
      Open;
      NrRecords := RecordCount;
      MessageDlg('Condition is valid! ' + IntToStr(NrRecords) + ' records will be affected. You may execute the flagging process.', mtInformation, [mbOK], 0);
      SaveSpeedButton.Enabled := True;
      ButtonPanel1.OKButton.Enabled := True;
      ButtonPanel1.OKButton.SetFocus;
    except on E: Exception do
      begin
        MessageDlg(E.Message + ' - Condition is invalid! Please try again with at least one field condition in WHERE clause.', mtError, [mbOK], 0);
        SaveSpeedButton.Enabled := False;
        ButtonPanel1.OKButton.Enabled := False;
        SynEdit1.SetFocus;
      end;
    end;
    Close;
  end;
  UpdateError := False;
  SynEdit1.SetFocus;
end;

procedure TFlagForm.ComboBox1Change(Sender: TObject);
begin
  if (SynEdit1.Text > '') and (SynEdit1.Lines[0] <> '<enter a condition to restrict records>') then
  begin
    if MessageDlg('Are you sure you want to change the table to flag? This will clear the WHERE condition!', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    with TableQuery do
    begin
      Close;
      Open;
      SynEdit1.Clear;
    end
    else
      ComboBox1.ItemIndex := CurItemIdx;
  end
  else
  with TableQuery do
  begin
    Close;
    Open;
  end
end;

procedure TFlagForm.ComboBox1DropDown(Sender: TObject);
begin
  CurItemIdx := ComboBox1.ItemIndex;
end;

procedure TFlagForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  TableQuery.Close;
  CloseAction := caFree;
end;

procedure TFlagForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose := not UpdateError;
  UpdateError := False; //if form could not close due to error
end;

end.

