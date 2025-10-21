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
unit aboutbox;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, LazUTF8;

{ TAboutBoxForm }

type
  TAboutBoxForm = class(TForm)
    Image1: TImage;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    Memo5: TMemo;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  AboutBoxForm: TAboutBoxForm;

implementation

uses VARINIT, maindatamodule;

{$R *.lfm}

{ TAboutBoxForm }

procedure TAboutBoxForm.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
end;

procedure TAboutBoxForm.FormShow(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  Memo2.Lines.LoadFromFile(ProgramDir + DirectorySeparator + 'readme.txt');
  {$ENDIF}
  {$IFDEF UNIX}
  Memo2.Lines.Text := UTF8ToAnsi(ReadFileToString(ProgramDir + DirectorySeparator + 'readme.txt'));
  {$ENDIF}
  Image1.Picture.LoadFromFile(ProgramDir + DirectorySeparator + 'splash_logo.jpg');
end;

end.

