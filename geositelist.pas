{ Copyright (C) 2022 Immo Blecher, immo@blecher.co.za

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
unit geositelist;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ButtonPanel, EditBtn,
  StdCtrls, ZDataset, DB;

type

  { TGeoSiteListForm }

  TGeoSiteListForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    DataOwnerEdit: TEdit;
    Label3: TLabel;
    ViewComboBox: TComboBox;
    FileNameEdit1: TFileNameEdit;
    Label1: TLabel;
    Label2: TLabel;
    SiteListQuery: TZReadOnlyQuery;
    procedure DataOwnerEditChange(Sender: TObject);
    procedure FileNameEdit1ButtonClick(Sender: TObject);
    procedure FileNameEdit1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure SiteListQueryBeforeOpen(DataSet: TDataSet);
  private

  public

  end;

var
  GeoSiteListForm: TGeoSiteListForm;

implementation

{$R *.lfm}

uses VARINIT, MainDataModule;

{ TGeoSiteListForm }

procedure TGeoSiteListForm.FileNameEdit1ButtonClick(Sender: TObject);
begin
  FileNameEdit1.InitialDir := WSpaceDir;
end;

procedure TGeoSiteListForm.DataOwnerEditChange(Sender: TObject);
begin
  ButtonPanel1.OKButton.Enabled := (FileNameEdit1.FileName > '') and (DataOwnerEdit.Text > '');
end;

procedure TGeoSiteListForm.FileNameEdit1Change(Sender: TObject);
begin
  ButtonPanel1.OKButton.Enabled := (FileNameEdit1.FileName > '') and (DataOwnerEdit.Text > '');
end;

procedure TGeoSiteListForm.FormActivate(Sender: TObject);
var
  TheViews: TStringList;
begin
  Screen.Cursor := crSQLWait;
  Application.ProcessMessages;
  Sleep(100);
  TheViews := TStringList.Create;
  DataModuleMain.GetAllViews(DataModuleMain.ZConnectionDB, TheViews);
  ViewComboBox.Items.Assign(TheViews);
  Application.ProcessMessages;
  TheViews.Free;
  ViewComboBox.ItemIndex := 0;
  Screen.Cursor := crDefault;
  Application.ProcessMessages;
end;

procedure TGeoSiteListForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TGeoSiteListForm.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
end;

procedure TGeoSiteListForm.OKButtonClick(Sender: TObject);
var
  SiteList: TStringList;
begin
  SiteList := TStringList.Create;
  with SiteList do
  begin
    Add('"DataOwner","Identifier"'); //header
    //all other records
    with SiteListQuery do
    begin
      Open;
      while not EOF do
      begin
        Add('"' + DataOwnerEdit.Text + '","' + Fields[0].AsString + '"');
        Next;
      end;
    end;
    SaveToFile(FileNameEdit1.FileName);
    Free;
  end;
  ShowMessage('Geosite List File successfully created!');
end;

procedure TGeoSiteListForm.SiteListQueryBeforeOpen(DataSet: TDataSet);
begin
  SiteListQuery.Connection := DataModuleMain.ZConnectionDB;
  SiteListQuery.SQL.Add('SELECT SITE_ID_NR FROM ' + ViewComboBox.Text);
end;

end.

