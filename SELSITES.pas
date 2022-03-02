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
unit SELSITES;

{$mode objfpc}{$H+}

interface

uses Classes, Graphics, Forms, Controls, Buttons, ZDataset,
  StdCtrls, DB, VARINIT, Dialogs, SysUtils, ExtCtrls, ButtonPanel;

const
  LB_ERR = -1;

type
  { TSelectSitesDlg }
  TSelectSitesDlg = class(TForm)
    ButtonPanel1: TButtonPanel;
    SrcList: TListBox;
    DstList: TListBox;
    SrcLabel: TLabel;
    DstLabel: TLabel;
    IncludeBtn: TSpeedButton;
    IncAllBtn: TSpeedButton;
    ExcludeBtn: TSpeedButton;
    ExAllBtn: TSpeedButton;
    FilterTable: TZTable;
    FilterTableSITE_ID_NR: TStringField;
    ViewQuery: TZReadOnlyQuery;
    procedure DstListSelectionChange(Sender: TObject; User: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure IncludeBtnClick(Sender: TObject);
    procedure ExcludeBtnClick(Sender: TObject);
    procedure IncAllBtnClick(Sender: TObject);
    procedure ExcAllBtnClick(Sender: TObject);
    procedure MoveSelected(List: TCustomListBox; Items: TStrings);
    procedure OKButtonClick(Sender: TObject);
    procedure SetItem(List: TListBox; Index: Integer);
    function GetFirstSelection(List: TCustomListBox): Integer;
    procedure SetButtons;
    procedure SrcListSelectionChange(Sender: TObject; User: boolean);
    procedure ViewQueryAfterOpen(DataSet: TDataSet);
    procedure ViewQueryBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SelectSitesDlg: TSelectSitesDlg;

implementation

uses MainDataModule, provideviewname;

{$R *.lfm}

procedure TSelectSitesDlg.IncludeBtnClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := GetFirstSelection(SrcList);
  MoveSelected(SrcList, DstList.Items);
  if SrcList.Count > 0 then
    SetItem(SrcList, Index);
  IncludeBtn.Enabled := (SrcList.Count > 0) and (SrcList.SelCount > 0);
  IncAllBtn.Enabled := SrcList.Count > 0;
  ExcludeBtn.Enabled := (DstList.Count > 0) and (DstList.SelCount > 0);
  ExAllBtn.Enabled := DstList.Count > 0;
  ButtonPanel1.OKButton.Enabled := DstList.Count > 0;
  DstLabel.Caption := IntToStr(DstList.Count) + ' sites included in new View';
end;

procedure TSelectSitesDlg.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, False);
end;

procedure TSelectSitesDlg.DstListSelectionChange(Sender: TObject; User: boolean
  );
begin
  IncludeBtn.Enabled := (SrcList.Count > 0) and (SrcList.SelCount > 0);
  IncAllBtn.Enabled := SrcList.Count > 0;
  ExcludeBtn.Enabled := (DstList.Count > 0) and (DstList.SelCount > 0);
  ExAllBtn.Enabled := DstList.Count > 0;
end;

procedure TSelectSitesDlg.FormShow(Sender: TObject);
begin
  ViewQuery.Open;
end;

procedure TSelectSitesDlg.ExcludeBtnClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := GetFirstSelection(DstList);
  MoveSelected(DstList, SrcList.Items);
  if DstList.Count > 0 then
    SetItem(DstList, Index);
  IncludeBtn.Enabled := (SrcList.Count > 0) and (SrcList.SelCount > 0);
  IncAllBtn.Enabled := SrcList.Count > 0;
  ExcludeBtn.Enabled := (DstList.Count > 0) and (DstList.SelCount > 0);
  ExAllBtn.Enabled := DstList.Count > 0;
  ButtonPanel1.OKButton.Enabled := DstList.Count > 0;
  DstLabel.Caption := IntToStr(DstList.Count) + ' sites included in new View';
end;

procedure TSelectSitesDlg.IncAllBtnClick(Sender: TObject);
begin
  DstList.Items.AddStrings(SrcList.Items);
  SrcList.Clear;
  IncludeBtn.Enabled := (SrcList.Count > 0) and (SrcList.SelCount > 0);
  IncAllBtn.Enabled := SrcList.Count > 0;
  ExcludeBtn.Enabled := (DstList.Count > 0) and (DstList.SelCount > 0);
  ExAllBtn.Enabled := DstList.Count > 0;
  ButtonPanel1.OKButton.Enabled := DstList.Count > 0;
  DstLabel.Caption := IntToStr(DstList.Count) + ' sites included in new View';
end;

procedure TSelectSitesDlg.ExcAllBtnClick(Sender: TObject);
begin
  SrcList.Items.AddStrings(DstList.Items);
  DstList.Clear;
  IncludeBtn.Enabled := (SrcList.Count > 0) and (SrcList.SelCount > 0);
  IncAllBtn.Enabled := SrcList.Count > 0;
  ExcludeBtn.Enabled := (DstList.Count > 0) and (DstList.SelCount > 0);
  ExAllBtn.Enabled := DstList.Count > 0;
  ButtonPanel1.OKButton.Enabled := False;
  DstLabel.Caption := IntToStr(DstList.Count) + ' sites included in new View';
end;

procedure TSelectSitesDlg.MoveSelected(List: TCustomListBox; Items: TStrings);
var
  I: Integer;
begin
  for I := List.Items.Count - 1 downto 0 do
    if List.Selected[I] then
    begin
      Items.AddObject(List.Items[I], List.Items.Objects[I]);
      List.Items.Delete(I);
    end;
end;

procedure TSelectSitesDlg.OKButtonClick(Sender: TObject);
var
  InString: String;
  NewViewName: ShortString;
  s: Cardinal;
  BracketPos: Byte;
begin
  InString := '';
  with TProvideViewNameForm.Create(Application) do
  begin
    if ShowModal = mrOK then
    begin
      for s := 0 to DstList.Count - 1 do
      begin
        BracketPos := Pos(' (', DstList.Items[s]);
        InString := InString + QuotedStr(Copy(DstList.Items[s], 1, BracketPos - 1)) + ', ';
      end;
      //Delete last comma
      Delete(InString, Length(InString) - 1, 2);
      NewViewName := ViewName;
      Free;
      case DataModuleMain.ZConnectionDB.Tag of
        1: begin
             DataModuleMain.ZConnectionDB.ExecuteDirect('DROP VIEW IF EXISTS [' + NewViewName + '];');
             DataModuleMain.ZConnectionDB.ExecuteDirect('CREATE VIEW [' +
               NewViewName + '] AS SELECT SITE_ID_NR FROM basicinf WHERE SITE_ID_NR IN (' + InString + ')');
           end;
        5: begin
             DataModuleMain.ZConnectionDB.ExecuteDirect('IF OBJECT_ID('+ QuotedStr(NewViewName) + ', ''V'') IS NOT NULL DROP VIEW ' + NewViewName);
             DataModuleMain.ZConnectionDB.ExecuteDirect('CREATE VIEW ' +
               NewViewName + ' AS SELECT SITE_ID_NR FROM basicinf WHERE SITE_ID_NR IN (' + InString + ')');
           end;
           else
           begin
             DataModuleMain.ZConnectionDB.ExecuteDirect('CREATE OR REPLACE VIEW ' +
               NewViewName + ' AS SELECT SITE_ID_NR FROM basicinf WHERE SITE_ID_NR IN (' + InString + ')');
             if CheckBox1.Checked then
             try
               if DataModuleMain.ZConnectionDB.Tag = 4 then //postgresql
                 DataModuleMain.ZConnectionDB.ExecuteDirect('GRANT SELECT ON TABLE ' + NewViewName + ' TO public')
               else
                 DataModuleMain.ZConnectionDB.ExecuteDirect('GRANT SELECT ON TABLE `' + NewViewName + '` TO ''%''@''%''');
             except on E: Exception do
               MessageDlg(E.Message + ': Ask your database administrator for "GRANT" permissions.', mtError, [mbOK], 0);
             end;
           end;
      end; //of case
      if MessageDlg('Do you want to set the new View "' + NewViewName + '" as current View?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        with DataModuleMain.ZQueryView do
        begin
          Close;
          FilterName := NewViewName;
          Open;
        end;
      end;
    end
    else
      MessageDlg('Create View cancelled! No view will be created from the selected sites!', mtInformation, [mbOK],0);
  end;
end;

procedure TSelectSitesDlg.SetButtons;
var
  SrcEmpty, DstEmpty: Boolean;
begin
  SrcEmpty := SrcList.Items.Count = 0;
  DstEmpty := DstList.Items.Count = 0;
  IncludeBtn.Enabled := not SrcEmpty;
  IncAllBtn.Enabled := not SrcEmpty;
  ExcludeBtn.Enabled := not DstEmpty;
  ExAllBtn.Enabled := not DstEmpty;
end;

procedure TSelectSitesDlg.SrcListSelectionChange(Sender: TObject; User: boolean
  );
begin
  IncludeBtn.Enabled := (SrcList.Count > 0) and (SrcList.SelCount > 0);
  IncAllBtn.Enabled := SrcList.Count > 0;
  ExcludeBtn.Enabled := (DstList.Count > 0) and (DstList.SelCount > 0);
  ExAllBtn.Enabled := DstList.Count > 0;
end;

procedure TSelectSitesDlg.ViewQueryAfterOpen(DataSet: TDataSet);
begin
  with ViewQuery do
  begin
    while not EOF do
    begin
      SrcList.Items.Add(FieldByName('SITE_ID_NR').Value + ' (' + FieldByName('NR_ON_MAP').Value + ')');
      Next;
    end;
    SrcLabel.Caption := IntToStr(RecordCount) + ' sites in current View';
    Close;
  end;
  Caption := 'Select sites from ' + UpperCase(FilterName);
  Screen.Cursor := crDefault;
end;

procedure TSelectSitesDlg.ViewQueryBeforeOpen(DataSet: TDataSet);
begin
  Screen.Cursor := crHourGlass;
  ViewQuery.SQL.Add('SELECT v.SITE_ID_NR, b.NR_ON_MAP FROM ' + FilterName + ' v');
  ViewQuery.SQL.Add('JOIN basicinf b ON (v.SITE_ID_NR = b.SITE_ID_NR)');
end;

function TSelectSitesDlg.GetFirstSelection(List: TCustomListBox): Integer;
begin
  for Result := 0 to List.Items.Count - 1 do
    if List.Selected[Result] then Exit;
  Result := LB_ERR;
end;

procedure TSelectSitesDlg.SetItem(List: TListBox; Index: Integer);
var
  MaxIndex: Integer;
begin
  with List do
  begin
    SetFocus;
    MaxIndex := List.Items.Count - 1;
    if Index = LB_ERR then Index := 0
    else if Index > MaxIndex then Index := MaxIndex;
    Selected[Index] := True;
  end;
  SetButtons;
end;

end.
