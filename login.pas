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
unit login;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, XMLPropStorage, LCLType, LCLIntf, ButtonPanel, ExtCtrls;

type

  { TLoginForm }

  TLoginForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    EditPassword: TEdit;
    EditUserName: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    XMLPropStorage1: TXMLPropStorage;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  LoginForm: TLoginForm;

implementation

{$R *.lfm}

uses varinit;

{ TLoginForm }

procedure TLoginForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TLoginForm.FormCreate(Sender: TObject);
var
  i: Word;
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  for i := 0 to ComponentCount-1 do
  begin
    if (Components[i] is TControl) then
    begin
      with (Components[i] as TControl) do
      begin
        with Font do
        begin
          Name := AppFont.Name;
          Size := AppFont.Size;
        end;//Done with Font
      end;//Done with TControl
    end;//End if TControl
  end;//End for-loop
end;

procedure TLoginForm.FormShow(Sender: TObject);
begin
  Screen.Cursor := crDefault;
  Label3.Enabled := True;
  EditUserName.Enabled := True;
  if EditUserName.Text > '' then EditPassword.SetFocus;
end;

end.

