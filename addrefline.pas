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
unit addrefline;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ButtonPanel, ExtCtrls,
  LCLType, StdCtrls, Spin, XMLPropStorage;

type

  { TAddLineForm }

  TAddLineForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    CheckBox1: TCheckBox;
    ColorButton1: TColorButton;
    ColorDialog1: TColorDialog;
    ComboBoxPos: TComboBox;
    ComboBoxAxis: TComboBox;
    ComboBoxStyle: TComboBox;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label3: TLabel;
    LabeledEditName: TLabeledEdit;
    LabeledEditY: TLabeledEdit;
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
  AddLineForm: TAddLineForm;

implementation

{$R *.lfm}

uses MainDataModule;

{ TAddLineForm }

procedure TAddLineForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TAddLineForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, True);
end;

procedure TAddLineForm.LabeledEditYKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key IN ['0'..'9', '-', '.', #8]) then
    Key := #0;
end;

end.

