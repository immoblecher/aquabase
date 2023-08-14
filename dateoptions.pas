{ Copyright (C) 2022 Immo Blecher immo@blecher.co.za

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
unit dateoptions;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ButtonPanel,
  XMLPropStorage, DateTimePicker;

type

  { TDateOptionsForm }

  TDateOptionsForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    XMLPropStorage1: TXMLPropStorage;
    procedure ComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  DateOptionsForm: TDateOptionsForm;

implementation

uses MainDataModule;

{$R *.lfm}

{ TDateOptionsForm }

procedure TDateOptionsForm.ComboBox1Change(Sender: TObject);
begin
  Label3.Enabled := ComboBox1.ItemIndex = 1;
  Label4.Enabled := ComboBox1.ItemIndex = 1;
  DateTimePicker1.Enabled := ComboBox1.ItemIndex = 1;
  DateTimePicker2.Enabled := ComboBox1.ItemIndex = 1;
end;

procedure TDateOptionsForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TDateOptionsForm.FormCreate(Sender: TObject);
begin
  DateTimePicker2.DateTime := Now;
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, True);
end;

end.

