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
unit selectSiteID;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  ButtonPanel, StdCtrls, DBGrids, XMLPropStorage, ZDataset, LCLType, rxdbgrid,
  RxSortZeos;

type

  { TFormSelSiteID }

  TFormSelSiteID = class(TForm)
    DataSource1: TDataSource;
    RxDBGrid: TRxDBGrid;
    RxSortZeos1: TRxSortZeos;
    SiteIDQuery: TZReadOnlyQuery;
    SiteIDQueryNR_ON_MAP: TStringField;
    SiteIDQuerySITE_ID_NR: TStringField;
    XMLPropStorage: TXMLPropStorage;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure RxDBGridDblClick(Sender: TObject);
    procedure RxDBGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
  private

  public
    LookupSite: ShortString;
  end;

var
  FormSelSiteID: TFormSelSiteID;

implementation

{$R *.lfm}

uses VARINIT, maindatamodule;

{ TFormSelSiteID }

procedure TFormSelSiteID.FormCreate(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  XMLPropStorage.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  SiteIDQuery.Open;
  Screen.Cursor := crDefault;
end;

procedure TFormSelSiteID.RxDBGridDblClick(Sender: TObject);
begin
  LookupSite := SiteIDQuerySITE_ID_NR.Value;
end;

procedure TFormSelSiteID.RxDBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: ModalResult := mrCancel;
    VK_RETURN: begin
                 LookupSite := SiteIDQuerySITE_ID_NR.Value;
                 ModalResult := mrOK;
               end;
  end; //of case
end;

procedure TFormSelSiteID.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  SiteIDQuery.Close;
  CloseAction := caFree;
end;

procedure TFormSelSiteID.FormActivate(Sender: TObject);
begin
  SiteIDQuery.Locate('SITE_ID_NR', LookupSite, []);
end;

end.

