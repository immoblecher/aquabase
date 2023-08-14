{ Copyright (C) 2020 Immo Blecher immo@blecher.co.za

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
unit editcolours;

{$MODE objfpc} {$H+}

interface

uses
  LCLIntf, LCLType, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, DBGrids, DBCtrls, StdCtrls, Buttons, ExtDlgs, XMLPropStorage,
  ZDataset;

type

  { TEditColoursForm }

  TEditColoursForm = class(TForm)
    ColorPanel: TPanel;
    DataSource1: TDataSource;
    ImageListNavs: TImageList;
    Label2: TLabel;
    OpenPictureDialog: TOpenPictureDialog;
    XMLPropStorage: TXMLPropStorage;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    DBNavigator1: TDBNavigator;
    CloseBtn: TBitBtn;
    HelpBtn: TBitBtn;
    ColorDialog1: TColorDialog;
    ZTableLookup: TZTable;
    ZTableLookupADJECTIVE: TStringField;
    ZTableLookupDEFAULT_CO: TLargeintField;
    ZTableLookupDESCRIBE: TStringField;
    ZTableLookupLOGS_BMP: TStringField;
    ZTableLookupSEARCH: TStringField;
    ZTableLookupUSED_FOR: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure HelpBtnClick(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure ColorPanelClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure ZTableLookupBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EditColoursForm: TEditColoursForm;

implementation

uses VARINIT, MainDataModule;

{$R *.lfm}

procedure TEditColoursForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage.FileName := GetUserDir + '/.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  DataSource1.AutoEdit := AutoEditData;
  DBNavigator1.Images := DataModuleMain.ImageListNavs;
  ZTableLookup.Open;
end;

procedure TEditColoursForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  ZTableLookup.Close;
  if DataModuleMain.LookupTable.Active then
      DataModuleMain.LookupTable.Refresh;
  CloseAction:= caFree;
end;

procedure TEditColoursForm.HelpBtnClick(Sender: TObject);
begin
   Application.HelpKeyword('EnterEditData');
end;

procedure TEditColoursForm.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
  //Colour
  if not ZTableLookupDEFAULT_CO.IsNull then
  begin
    ColorPanel.Color := TColor(ZTableLookupDEFAULT_CO.Value);
    ColorPanel.Caption := '';
  end
  else
  begin
    ColorPanel.Color := clBtnFace;
    ColorPanel.Caption := '<none>';
  end;
end;

procedure TEditColoursForm.ColorPanelClick(Sender: TObject);
begin
  ColorDialog1.Color := ZTableLookupDEFAULT_CO.Value;
  if ZTableLookup.State = dsEdit then
  begin
    if (ColorDialog1.Execute) and (ZTableLookup.State = dsEdit) then
      ZTableLookupDEFAULT_CO.Value := ColorDialog1.Color;
  end
  else
    MessageDlg('Lithology table not in edit state! Make the table editable first.', mtWarning, [mbOK], 0);
end;

procedure TEditColoursForm.CloseBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TEditColoursForm.ZTableLookupBeforeOpen(DataSet: TDataSet);
begin
  ZTableLookup.Connection := DataModuleMain.ZConnectionLanguage;
end;

end.
