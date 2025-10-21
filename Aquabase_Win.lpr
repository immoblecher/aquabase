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
program Aquabase_Win;

{$mode objfpc}{$H+}

uses
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, controls, main, Splash, FileInfo, SysUtils,
  uDarkStyleParams,
  uDarkStyleSchemes,
  uMetaDarkStyle,
  VARINIT;

{$R *.res}

var
  Info:TVersionInfo;
begin
  Application.Scaled:=True;
  if DarkTheme then
  begin
    PreferredAppMode := pamForceDark;
    uMetaDarkStyle.ApplyMetaDarkStyle(DefaultDark);
  end;
  RequireDerivedFormResource := True;
  Application.Initialize;
  Screen.Cursor := crAppStart;
  Info := TVersionInfo.Create;
  Info.Load(HINSTANCE);
  // grab just the Build Number
  with TSplashForm.Create(Application) do
  try
    Label1.Caption := 'Build: '
      + IntToStr(Info.FixedInfo.FileVersion[0]) + '.'
      + IntToStr(Info.FixedInfo.FileVersion[1]) + '.'
      + IntToStr(Info.FixedInfo.FileVersion[2]) + '.'
      + IntToStr(Info.FixedInfo.FileVersion[3]);
    Info.Free;
    Show;
    while not Completed do
      Application.ProcessMessages;
    Hide;
  finally
    Free;
  end;
  Screen.Cursor := crDefault;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.

