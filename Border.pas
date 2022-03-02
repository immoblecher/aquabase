{ Copyright (C) 2017 Immo Blecher, immo@blecher.co.za

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
unit Border;

{$mode objfpc}{$H+}

interface

uses SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Spin, Dialogs, ButtonPanel;

type

  { TBorderDlg }

  TBorderDlg = class(TForm)
    ButtonPanel1: TButtonPanel;
    ColorButtonBorder: TColorButton;
    ColorDialogBorder: TColorDialog;
    RadioGroupBorderStyle: TRadioGroup;
    CheckBoxBorderVisible: TCheckBox;
    Label1: TLabel;
    SpinEditBorderWidth: TSpinEdit;
    procedure ColorButtonBorderColorChanged(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BorderDlg: TBorderDlg;

implementation

{$R *.lfm}

{ TBorderDlg }

procedure TBorderDlg.ColorButtonBorderColorChanged(Sender: TObject);
begin
  ColorDialogBorder.Color := ColorButtonBorder.ButtonColor;
end;

end.
