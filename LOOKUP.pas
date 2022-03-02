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
unit LOOKUP;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, LCLType, Forms, Dialogs, DB, ExtCtrls,
  StdCtrls, DBCtrls, XMLPropStorage, rxdbgrid, ZDataset;

type

  { TLookupForm }

  TLookupForm = class(TForm)
  DataSourceLookup: TDataSource;
  Label1: TLabel;
  LookupQueryDESCRIBE: TStringField;
  LookupQuerySEARCH: TStringField;
  LookupQueryUSED_FOR: TStringField;
  RxDBGrid: TRxDBGrid;
  LookupQuery: TZReadOnlyQuery;
  XMLPropStorage: TXMLPropStorage;
  procedure RxDBGridDblClick(Sender: TObject);
  procedure FormActivate(Sender: TObject);
  procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  procedure FormCreate(Sender: TObject);
  procedure RxDBGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    LookupCategory, LookupValue: ShortString;
  end;

var
  LookupForm: TLookupForm;

implementation

{$R *.lfm}

uses VARINIT, maindatamodule;

procedure TLookupForm.FormActivate(Sender: TObject);
begin
  LookupQuery.Filter := 'USED_FOR = ' + QuotedStr(LookupCategory);
  LookupQuery.Filtered := True;
  LookupQuery.Open;
  LookupQuery.Locate('SEARCH', LookupValue, []);
end;

procedure TLookupForm.RxDBGridDblClick(Sender: TObject);
begin
  LookupValue := LookupQuerySEARCH.Value;
end;

procedure TLookupForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  LookupQuery.Close;
  CloseAction := caFree;
end;

procedure TLookupForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, True);
end;

procedure TLookupForm.RxDBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: ModalResult := mrCancel;
    VK_RETURN: begin
                 LookupValue := LookupQuerySEARCH.Value;
                 ModalResult := mrOK;
               end;
  end; //of case
end;

end.
