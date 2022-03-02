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
unit strdatetime;

{$mode objfpc}{$H+}

interface

uses SysUtils;

  function ValidDate(S: String): Boolean;
  function StringToDate(S: String): TDateTime;
  function ValidTime(S: String): Boolean;
  function StringToTime(S: String): TDateTime;

implementation

function ValidDate(S: String): Boolean;

var
  Year, Month, Day: Word;

begin
  if Length(S) <> 8 then Result := False
  else
  begin
  try
    Year := StrToInt(Copy(S, 1, 4));
    Month := StrToInt(Copy(S, 5, 2));
    Day := StrToInt(Copy(S, 7, 2));
    EncodeDate(Year, Month, Day);
    Result := True
  except
    on EConvertError do Result := False
  end;
  end;
end;

function StringToDate(S: String): TDateTime;

var
  Year, Month, Day: Word;

begin
  Year := StrToInt(Copy(S, 1, 4));
  Month := StrToInt(Copy(S, 5, 2));
  Day := StrToInt(Copy(S, 7, 2));
  Result := EncodeDate(Year, Month, Day);
end;

function ValidTime(S: String): Boolean;

var
  Hour, Minute, Second, MSecond: Word;

begin
  if Length(S) <> 4 then Result := False
  else
  begin
    try
      Hour := StrToInt(Copy(S, 1, 2));
      Minute := StrToInt(Copy(S, 3, 2));
      Second := 0;
      MSecond := 0;
      EncodeTime(Hour, Minute, Second, MSecond);
      Result := True
    except
      on EConvertError do Result := False
    end;
  end;
end;

function StringToTime(S: String): TDateTime;

var
  Hour, Minute, Second, MSecond: Word;

begin
  Hour := StrToInt(Copy(S, 1, 2));
  Minute := StrToInt(Copy(S, 3, 2));
  Second := 0;
  MSecond := 0;
  Result := EncodeTime(Hour, Minute, Second, MSecond);
end;

end.
