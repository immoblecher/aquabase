{ Copyright (C) 2025 Immo Blecher immo@blecher.co.za

  This source is free software; you can redistribute it and/or modify it under
  the terms of the GNU General Public License as published by the Free
  Software Foundation; either version 2 of the License, or (at your option)
  any later version.

  This code is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
  details.

  A copy of the GNU General Public License is available on the World Wide Web
  at <http://www.gnu.org/copyleft/gpl.html>. You can also obtain it by writing
  to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
  MA 02111-1307, USA.
}
unit crsinfo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, ComCtrls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  XMLPropStorage, Buttons, StdCtrls, Menus, rxdbgrid, ZDataset, Clipbrd, DBGrids;

type

  { TCRSInfoForm }

  TCRSInfoForm = class(TForm)
    CloseBitBtn: TBitBtn;
    ComboBox1: TComboBox;
    DataSource1: TDataSource;
    DBNavigator1: TDBNavigator;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    MenuItem1: TMenuItem;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    RxDBGrid1: TRxDBGrid;
    StatusBar1: TStatusBar;
    XMLPropStorage1: TXMLPropStorage;
    ZQuery1: TZQuery;
    ZReadOnlyQuery1: TZReadOnlyQuery;
    ZReadOnlyQuery1area_used: TStringField;
    ZReadOnlyQuery1crs: TStringField;
    ZReadOnlyQuery1description: TWideStringField;
    ZReadOnlyQuery1SRID: TLargeintField;
    ZReadOnlyQuery1type: TStringField;
    procedure ComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure RxDBGrid1CellClick(Column: TColumn);
    procedure ZQuery1AfterOpen(DataSet: TDataSet);
    procedure ZQuery1BeforeOpen(DataSet: TDataSet);
  private
    CellValue: String;
  public

  end;

var
  CRSInfoForm: TCRSInfoForm;

implementation

{$R *.lfm}

uses MainDataModule, VARINIT;

{ TCRSInfoForm }

procedure TCRSInfoForm.FormShow(Sender: TObject);
begin
  ZQuery1.Open;
end;

procedure TCRSInfoForm.MenuItem1Click(Sender: TObject);
begin
  ClipBoard.AsText := CellValue;
end;

procedure TCRSInfoForm.RxDBGrid1CellClick(Column: TColumn);
begin
  CellValue := Column.Field.Value;
end;

procedure TCRSInfoForm.ZQuery1AfterOpen(DataSet: TDataSet);
begin
  StatusBar1.SimpleText := IntToStr(DataSet.RecordCount) + ' CRS Records';
end;

procedure TCRSInfoForm.ZQuery1BeforeOpen(DataSet: TDataSet);
begin
  ZQuery1.SQL.Clear;
  if Proj_Version < '8.0.0' then
  with ZQuery1.SQL do
  begin
    Add('select cast(crs_view.code as Integer) as SRID, crs_view.type, crs_view.name || '' ('' || crs_view.type || '')'' as crs from area, area.name as area_used, area.description');
    Add('join crs_view on (crs_view.area_of_use_code = area.code)');
    Add('and SRID > 0 and SRID < 100000');
    Add('and (crs_view.type like ''geographic%'' or crs_view.type = ''projected'')');
    Add('and crs_view.deprecated = 0');
  end
  else
  with ZQuery1.SQL do
  begin
    Add('select cast(crs_view.code as Integer) as SRID, crs_view.type, crs_view.name || '' ('' || crs_view.type || '')'' as crs, extent.name as area_used, extent.description from usage');
    Add('join crs_view on (crs_view.code = usage.object_code)');
    Add('join extent on (extent.code = usage.extent_code)');
    Add('and SRID > 0 and SRID < 100000');
    Add('and (crs_view.type like ''geographic%'' or crs_view.type = ''projected'')');
    Add('and crs_view.deprecated = 0');
  end;
end;

procedure TCRSInfoForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  ZQuery1.Close;
  CloseAction := caFree;
end;

procedure TCRSInfoForm.ComboBox1Change(Sender: TObject);
begin
  if (ComboBox1.ItemIndex > 0) and (Edit1.Text > '') then
  begin
    if ComboBox1.ItemIndex = 1 then
      ZQuery1.Filter := 'crs like ' + QuotedStr('*' + Edit1.Text + '*')
    else
    if ComboBox1.ItemIndex = 2 then
      ZQuery1.Filter := 'area_used like ' + QuotedStr('*' + Edit1.Text + '*')
    else
    if ComboBox1.ItemIndex = 3 then
      ZQuery1.Filter := 'description like ' + QuotedStr('*' + Edit1.Text + '*');
    ZQuery1.Filtered := True;
  end
  else
  begin
    ZQuery1.Filtered := False;
  end;
  StatusBar1.SimpleText := IntToStr(ZQuery1.RecordCount) + ' CRS Records';
end;

procedure TCRSInfoForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, True);
end;

end.

