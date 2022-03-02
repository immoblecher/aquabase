{ Copyright (C) 2020 Immo Blecher, immo@blecher.co.za

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
unit addtrendline;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ButtonPanel, ExtCtrls,
  LCLType, StdCtrls, Spin, XMLPropStorage;

type

  { TAddTrendLineForm }

  TAddTrendLineForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    ColorButton1: TColorButton;
    ColorDialog1: TColorDialog;
    ComboBoxSeries: TComboBox;
    ComboBoxFit: TComboBox;
    ComboBoxAxis: TComboBox;
    ComboBoxStyle: TComboBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LabeledEditName: TLabeledEdit;
    LabelStyle: TLabel;
    LabelThick: TLabel;
    SpinEdit1: TSpinEdit;
    XMLPropStorage1: TXMLPropStorage;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure LabeledEditYKeyPress(Sender: TObject; var Key: char);
  private

  public

  end;

var
  AddTrendLineForm: TAddTrendLineForm;

implementation

{$R *.lfm}

uses MainDataModule;

{ TAddTrendLineForm }

procedure TAddTrendLineForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TAddTrendLineForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, True);
end;

procedure TAddTrendLineForm.LabeledEditYKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key IN ['0'..'9', '-', '.', #8]) then
    Key := #0;
end;

end.

