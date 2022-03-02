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
unit SelConstrDlg;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, ExtCtrls, Buttons, ButtonPanel, ZDataset, Db, dbf;

type

  { TSelConstrForm }

  TSelConstrForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    DefinitionTable: TDbf;
    DefinitionTableCONSTRAINT: TStringField;
    DefinitionTableTABLE: TStringField;
    FieldListBox: TListBox;
    LoadBitBtn: TBitBtn;
    SaveBitBtn: TBitBtn;
    StringGrid: TStringGrid;
    Label4: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    OperatorListBox: TListBox;
    SearchTable: TZTable;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    BitBtn2: TBitBtn;
    ClearButton: TBitBtn;
    TableListBox: TListBox;
    TestBitBtn: TBitBtn;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    TestQuery: TZReadOnlyQuery;
    procedure CancelButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure TableListBoxClick(Sender: TObject);
    procedure FieldListBoxDblClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure OperatorListBoxDblClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure TestBitBtnClick(Sender: TObject);
    procedure SaveBitBtnClick(Sender: TObject);
    procedure LoadBitBtnClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SelConstrForm: TSelConstrForm;

implementation

uses Varinit, MainDataModule;

{$R *.lfm}

procedure TSelConstrForm.FormActivate(Sender: TObject);
begin
  TableListBox.ItemIndex := 0;
  SearchTable.Connection := DataModulemain.ZConnectionDB;
  SearchTable.TableName := LowerCase(TableListBox.Items[TableListBox.ItemIndex]);
  SearchTable.Open;
  SearchTable.GetFieldNames(FieldListBox.Items);
  with FieldListBox.Items do
  begin
    if IndexOf('NGDB_REPEA') <> -1 then Delete(IndexOf('NGDB_REPEA'));
    if IndexOf('NGDB_HEADR') <> -1 then Delete(IndexOf('NGDB_HEADR'));
    if IndexOf('NOTE_PAD') <> -1 then Delete(IndexOf('NOTE_PAD'));
  end;
  StringGrid.Cells[0, 0] := 'Table:';
  StringGrid.Cells[1, 0] := 'Constraint:';
end;

procedure TSelConstrForm.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TSelConstrForm.TableListBoxClick(Sender: TObject);
begin
  FieldListBox.Clear;
  SearchTable.TableName := LowerCase(TableListBox.Items[TableListBox.ItemIndex]);
  SearchTable.Open;
  SearchTable.GetFieldNames(FieldListBox.Items);
  with FieldListBox.Items do
  begin
    if IndexOf('NGDB_REPEA') <> -1 then Delete(IndexOf('NGDB_REPEA'));
    if IndexOf('NGDB_HEADR') <> -1 then Delete(IndexOf('NGDB_HEADR'));
    if IndexOf('NOTE_PAD') <> -1 then Delete(IndexOf('NOTE_PAD'));
  end;
  SearchTable.Close;
end;

procedure TSelConstrForm.FieldListBoxDblClick(Sender: TObject);

var r: ShortInt;

begin
  with StringGrid do
  begin
    for r := 1 to RowCount -1 do
    if Cells[0, r] = LowerCase(TableListBox.Items[TableListBox.ItemIndex]) then
    begin
      Row := r;
      Break;
    end;
    Cells[0, Row] := LowerCase(TableListBox.Items[TableListBox.ItemIndex]);
    Cells[1, Row] := Cells[1, Row] + FieldListBox.Items[FieldListBox.ItemIndex]+ ' ';
    Col := 1;
  end;
  SaveBitBtn.Enabled := True;
  ButtonPanel1.OKButton.Enabled := True;
end;

procedure TSelConstrForm.ClearButtonClick(Sender: TObject);

var r: ShortInt;

begin
  if MessageDlg('Clear current constraint definitions?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    for r := 1 to StringGrid.RowCount - 1 do StringGrid.Rows[r].Clear;
    TestQuery.SQL.Clear;
  end;
  Buttonpanel1.OKButton.Enabled := False;
end;

procedure TSelConstrForm.OperatorListBoxDblClick(Sender: TObject);
begin
  with StringGrid do
  begin
    Cells[1, Row] := Cells[1, Row] + OperatorListBox.Items[OperatorListBox.ItemIndex];
    SetFocus;
  end;
end;

procedure TSelConstrForm.BitBtn2Click(Sender: TObject);

var r: ShortInt;

begin
  if MessageDlg('Clear current constraint?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    StringGrid.Rows[StringGrid.Row].Clear;
  for r := StringGrid.Row to 9 do
  begin
    StringGrid.Cells[0,r] := StringGrid.Cells[0,r+1];
    StringGrid.Cells[1,r] := StringGrid.Cells[1,r+1];
  end;
  if  StringGrid.Cells[0,1] = '' then ButtonPanel1.OKButton.Enabled := True;
end;

procedure TSelConstrForm.TestBitBtnClick(Sender: TObject);
var
  t, Count: ShortInt;
begin
  Screen.Cursor := crSQLWait;
  Count := 0;
  for t := 1 to StringGrid.RowCount - 1 do
    if StringGrid.Cells[0,t] > '' then
    begin
      TestQuery.Connection := DataModulemain.ZConnectionDB;
      TestQuery.SQL.Clear;
      TestQuery.SQL.Add('SELECT * FROM ' + StringGrid.Cells[0,t]);
      TestQuery.SQL.Add('WHERE ' + Stringgrid.Cells[1,t]);
      try
        TestQuery.Open;
        TestQuery.Close;
        Screen.Cursor := crSQLWait;
      except on E: Exception do
      begin
        Screen.Cursor := crDefault;
        Count := Count + 1;
        MessageDlg(E.Message + ' - Constraint for table "' + StringGrid.Cells[0,t] + '" is not a valid SQL expression: "' + TestQuery.SQL[1] +'"!',
          mtError, [mbOK], 0);
      end;
      end; {of try}
    end;
    Screen.Cursor := crDefault;
    MessageDlg('There were ' + IntToStr(Count) + ' errors in the constraint definitions.',
      mtInformation, [mbOK], 0);
end;

procedure TSelConstrForm.SaveBitBtnClick(Sender: TObject);

var r: ShortInt;

begin
  if SaveDialog.Execute then
  begin
    with DefinitionTable do
    begin
      FilePath := WSpaceDir;
      TableName := ExtractFileName(SaveDialog.FileName);
      CreateTable;
      Open;
      for r := 1 to StringGrid.RowCount do
        with StringGrid do
          if Cells[0,r] > '' then
            AppendRecord([Cells[0,r], Cells[1,r]]);
      Close;
    end; {of with DefinitionTable}
  end;
end;

procedure TSelConstrForm.LoadBitBtnClick(Sender: TObject);

var r: ShortInt;

begin
  if OpenDialog.Execute then
  begin
    with DefinitionTable do
    begin
      FilePath := ExtractFilePath(OpenDialog.FileName);
      TableName := ExtractFilename(OpenDialog.FileName);
      Open;
      r := 1;
      while not EOF do
      begin
        StringGrid.Cells[0,r] := DefinitionTableTABLE.Value;
        StringGrid.Cells[1,r] := DefinitionTableCONSTRAINT.Value;
        Next;
        Inc(r);
      end; {of EOF}
      Close;
    end;
    ButtonPanel1.OKButton.Enabled := True;
    SaveBitBtn.Enabled := True;
  end;
end;

procedure TSelConstrForm.BitBtn3Click(Sender: TObject);
begin
   Application.HelpKeyword('Constraints');
end;

end.
