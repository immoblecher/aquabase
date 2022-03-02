{ Copyright (C) 2016 Immo Blecher, immo@blecher.co.za

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
unit Otherid;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, DbCtrls, Buttons, Menus, StdCtrls, DBGrids, MastDetl, db;

type

  { TOtherIdForm }

  TOtherIdForm = class(TMasterDetailForm)
    LinkedQueryASSIGNOR: TStringField;
    LinkedQueryOTHER_ID: TStringField;
    procedure FormActivate(Sender: TObject);
    procedure LinkedQueryOTHER_IDSetText(Sender: TField; const aText: string);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  OtherIdForm: TOtherIdForm;

implementation

{$R *.lfm}

uses varinit;

{ TOtherIdForm }

procedure TOtherIdForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption;
end;

procedure TOtherIdForm.LinkedQueryOTHER_IDSetText(Sender: TField;
  const aText: string);
begin
  Sender.AsString := UpperCase(aText);
end;

end.

