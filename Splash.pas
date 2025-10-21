{ Copyright (C) 2024 Immo Blecher, immo@blecher.co.za

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
unit Splash;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type

  { TSplashForm }

  TSplashForm = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1PictureChanged(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Completed: Boolean;
  end;

var
  SplashForm: TSplashForm;

implementation

{$R *.lfm}

{ TSplashForm }

procedure TSplashForm.FormCreate(Sender: TObject);
begin
  {$IFDEF WINDOWS}
    Image1.Picture.LoadFromFile('splash_logo.jpg');
  {$ENDIF}
  {$IFDEF LINUX}
    Image1.Picture.LoadFromFile('/usr/share/aquabase/splash_logo.jpg');
  {$ENDIF}
  {$IFDEF DARWIN}
    Image1.Picture.LoadFromFile('/opt/local/share/aquabase/splash_logo.jpg');
  {$ENDIF}
end;

procedure TSplashForm.FormShow(Sender: TObject);
begin
  OnShow := nil;
  Completed := False;
  Timer1.Interval := 3000; // 3s minimum time to show splash screen
  Timer1.Enabled := True;
end;

procedure TSplashForm.Image1PictureChanged(Sender: TObject);
begin

end;

procedure TSplashForm.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  Completed := True;
end;

{ TSplashForm }

end.
