{ Copyright (C) 2021 Immo Blecher immo@blecher.co.za

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
unit DeptSet;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Spin, ButtonPanel;

type

  { TDepthSetForm }

  TDepthSetForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    BarWidthLabel: TLabel;
    BarWidthSpinEdit: TSpinEdit;
    FloatSpinEditMax: TFloatSpinEdit;
    FloatSpinEditTop: TFloatSpinEdit;
    FloatSpinEditBot: TFloatSpinEdit;
    FloatSpinEditMin: TFloatSpinEdit;
    XCheckBox: TCheckBox;
    DepthGroupBox: TGroupBox;
    XGroupBox: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    ChartTypeRadioGroup: TRadioGroup;
    DepthCheckBox: TCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    procedure BarWidthSpinEditChange(Sender: TObject);
    procedure ChartTypeRadioGroupSelectionChanged(Sender: TObject);
    procedure DepthCheckBoxChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure XCheckBoxChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DepthSetForm: TDepthSetForm;

implementation

uses VARINIT, maindatamodule;

{$R *.lfm}

procedure TDepthSetForm.DepthCheckBoxChange(Sender: TObject);
begin
  DepthGroupBox.Enabled := not DepthCheckBox.Checked;
end;

procedure TDepthSetForm.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
end;

procedure TDepthSetForm.ChartTypeRadioGroupSelectionChanged(Sender: TObject);
begin
  BarWidthLabel.Enabled := ChartTypeRadioGroup.ItemIndex = 1;
  BarWidthSpinEdit.Enabled := ChartTypeRadioGroup.ItemIndex = 1;
end;

procedure TDepthSetForm.BarWidthSpinEditChange(Sender: TObject);
begin
  if BarWidthSpinEdit.Value > 100 then BarWidthSpinEdit.Value := 100;
end;

procedure TDepthSetForm.XCheckBoxChange(Sender: TObject);
begin
  XGroupBox.Enabled := not XCheckBox.Checked;
end;

end.
