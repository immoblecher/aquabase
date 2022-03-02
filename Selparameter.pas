{ Copyright (C) 2021 Immo Blecher immo@blecher.co.za

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
unit Selparameter;

{$mode objfpc}{$H+}

interface

uses SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, LCLType,
  Buttons, Db, ExtCtrls, Dialogs, ButtonPanel, ZDataset;

type

  { TParamSelectionForm }

  TParamSelectionForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    GroupBox1: TGroupBox;
    SrcLabel: TLabel;
    SrcList: TListBox;
    IncludeBtn: TSpeedButton;
    ExcludeBtn: TSpeedButton;
    ExAllBtn: TSpeedButton;
    DstLabel: TLabel;
    DstList: TListBox;
    IncAllButton: TSpeedButton;
    ZReadOnlyQuery1: TZReadOnlyQuery;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    procedure IncludeBtnClick(Sender: TObject);
    procedure ExcludeBtnClick(Sender: TObject);
    procedure ExcAllBtnClick(Sender: TObject);
    procedure MoveSelected(List: TCustomListBox; Items: TStrings);
    procedure SetItem(List: TListBox; Index: Integer);
    function GetFirstSelection(List: TCustomListBox): Integer;
    procedure SetButtons;
    procedure FormCreate(Sender: TObject);
    procedure DstListClick(Sender: TObject);
    procedure SrcListClick(Sender: TObject);
    procedure IncAllButtonClick(Sender: TObject);
  private
    { Private declarations }
    DstIndex: Integer;
  public
    { Public declarations }
    MaxParams: Integer;
  end;

var
  ParamSelectionForm: TParamSelectionForm;

implementation

{$R *.lfm}

uses VARINIT, MainDataModule;

procedure TParamSelectionForm.IncludeBtnClick(Sender: TObject);
var
  SrcIndex: Integer;
begin
  SrcIndex := GetFirstSelection(SrcList);
  if (DstList.Items.Count + SrcList.SelCount) <= MaxParams then
  begin
    MoveSelected(SrcList, DstList.Items);
    SetItem(DstList, DstIndex);
  end
  else
    MessageDlg('You cannot select more than ' + IntToStr(MaxParams) + ' parameters!', mtError, [mbOK], 0);
  SetItem(SrcList, SrcIndex);
  IncAllButton.Enabled := SrcList.Items.Count > 0;
  Buttonpanel1.OKButton.Enabled := DstList.Count > 0;
end;

procedure TParamSelectionForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TParamSelectionForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TParamSelectionForm.FormShow(Sender: TObject);
var
  i: Word;
begin
  //Clear in SourceList the Items in DestList
  for i := 0 to DstList.Items.Count - 1 do
    SrcList.Items.Delete(SrcList.Items.IndexOf(DstList.Items[i]));
  //clear CL2 if it still exists from older db versions
  if SrcList.Items.IndexOf('CL2') > -1 then
    SrcList.Items.Delete(SrcList.Items.IndexOf('CL2'));
end;

procedure TParamSelectionForm.ExcludeBtnClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := GetFirstSelection(DstList);
  MoveSelected(DstList, SrcList.Items);
  if Index > 0 then
  begin
    SetItem(DstList, Index - 1);
    DstIndex := Index - 1;
  end
  else
    DstIndex := 0;
  IncAllButton.Enabled := SrcList.Items.Count > 0;
  Buttonpanel1.OKButton.Enabled := DstList.Count > 0;
end;

procedure TParamSelectionForm.ExcAllBtnClick(Sender: TObject);
var
  i: Word;
begin
  for i := 0 to DstList.Items.Count - 1 do
    SrcList.Items.AddObject(DstList.Items[I], DstList.Items.Objects[I]);
  DstList.Items.Clear;
  DstIndex := 0;
  IncAllButton.Enabled := SrcList.Items.Count > 0;
  Buttonpanel1.OKButton.Enabled := DstList.Count > 0;
end;

procedure TParamSelectionForm.MoveSelected(List: TCustomListBox; Items: TStrings);
var
  i: Word;
begin
  for i := List.Items.Count - 1 downto 0 do
    if List.Selected[i] then
    begin
      if List.Sorted then //other (dst)list is not, so insert
      begin
        if DstList.Count > 0 then
          Inc(DstIndex);
        Items.InsertObject(DstIndex, List.Items[i], List.Items.Objects[i])
      end
      else
        Items.AddObject(List.Items[i], List.Items.Objects[i]);
      List.Items.Delete(i);
    end;
end;

procedure TParamSelectionForm.SetButtons;
var
  SrcEmpty, DstEmpty: Boolean;
begin
  SrcEmpty := SrcList.Items.Count = 0;
  DstEmpty := DstList.Items.Count = 0;
  IncludeBtn.Enabled := not SrcEmpty;
  ExcludeBtn.Enabled := not DstEmpty;
  ExAllBtn.Enabled := not DstEmpty;
end;

function TParamSelectionForm.GetFirstSelection(List: TCustomListBox): Integer;
begin
  for Result := 0 to List.Items.Count - 1 do
    if List.Selected[Result] then Exit;
end;

procedure TParamSelectionForm.SetItem(List: TListBox; Index: Integer);
begin
  with List do
  begin
    SetFocus;
    Selected[Index] := True;
    if Name = 'DstList' then
    begin
      DstIndex := Index;
      ItemIndex := Index;
    end;
  end;
  SetButtons;
end;

procedure TParamSelectionForm.FormCreate(Sender: TObject);
var
  ParamList: TStringList;
  i: Byte;
begin
  ParamList := TStringList.Create;
  for i := 1 to 5 do
  begin
    with ZReadOnlyQuery1 do
    begin
      SQL.Clear;
      SQL.Add('SELECT * FROM chem_00' + IntToStr(i) + ' WHERE 1 <> 1');
      Open;
      GetFieldNames(ParamList);
      Close;
      SrcList.Items.AddStrings(ParamList);
    end;
  end;
  ParamList.Free;
  while SrcList.Items.IndexOf('CHM_REF_NR') > -1 do
    SrcList.Items.Delete(SrcList.Items.IndexOf('CHM_REF_NR'));
  DataModuleMain.SetComponentFontAndSize(Sender, False);
end;

procedure TParamSelectionForm.DstListClick(Sender: TObject);
begin
  DstIndex := DstList.ItemIndex;
  if DstIndex < 0 then Exit;
  ExcludeBtn.Enabled := DstList.SelCount > 0;
  ExAllBtn.Enabled := DstList.SelCount > 0;
end;

procedure TParamSelectionForm.SrcListClick(Sender: TObject);
begin
  IncludeBtn.Enabled := SrcList.SelCount > 0;
end;

procedure TParamSelectionForm.IncAllButtonClick(Sender: TObject);
var
  I: Integer;
begin
  if (DstList.Items.Count + SrcList.Items.Count) <= MaxParams then
  begin
    for I := 0 to SrcList.Items.Count - 1 do
      DstList.Items.AddObject(SrcList.Items[I], SrcList.Items.Objects[I]);
    SrcList.Items.Clear;
  end
  else
    MessageDlg('You cannot select more than ' + IntToStr(MaxParams) + ' samples!',
      mtError, [mbOK], 0);
  IncAllButton.Enabled := SrcList.Items.Count > 0;
  Buttonpanel1.OKButton.Enabled := DstList.Count > 0;
end;

end.
