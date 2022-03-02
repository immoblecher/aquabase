{ Copyright (C) 2019 Immo Blecher immo@blecher.co.za

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
unit SearchSites;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Buttons, DBCtrls;

type
  TSearchSitesForm = class(TForm)
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    HideBtn: TSpeedButton;
    DBNavigator1: TDBNavigator;
    CloseBitBtn: TBitBtn;
    HelpBtn: TBitBtn;
    StatusBar1: TStatusBar;
    ComboBox1: TComboBox;
    Label1: TLabel;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Edit1: TEdit;
    RadioGroup1: TRadioGroup;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    ComboBox6: TComboBox;
    Edit2: TEdit;
    procedure HelpBtnClick(Sender: TObject);
    procedure CloseBitBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SearchSitesForm: TSearchSitesForm;

implementation

{$R *.lfm}

procedure TSearchSitesForm.HelpBtnClick(Sender: TObject);
begin
   Application.HelpKeyword('SearchFunc');
end;

procedure TSearchSitesForm.CloseBitBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TSearchSitesForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

end.
