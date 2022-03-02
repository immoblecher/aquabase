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
unit ProgressBox;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, ExtCtrls, Buttons;

{ TProgressBoxForm }

type
  TProgressBoxForm = class(TForm)
    CancelBitBtn: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    procedure CancelBitBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    CancelPressed, Finished: Boolean;
  end;

var
  ProgressBoxForm: TProgressBoxForm;

implementation

uses VARINIT, maindatamodule;

{$R *.lfm}

{ TProgressBoxForm }

procedure TProgressBoxForm.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, False);
  CancelPressed := False;
  Finished := False;
end;

procedure TProgressBoxForm.FormShow(Sender: TObject);
begin
  Application.ProcessMessages;
end;

procedure TProgressBoxForm.CancelBitBtnClick(Sender: TObject);
begin
  if MessageDlg('Are you sure you want to cancel the process now? This may lead to data corruption, which may only be corrected with a backup.', mtConfirmation, [mbYes, mbNo], mrNo) = mrYes then
    CancelPressed := True
  else
    CancelPressed := False;
end;

procedure TProgressBoxForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TProgressBoxForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if CancelPressed or Finished then //cancelled or finished
    CanClose := True
  else
  begin
    CanClose := False;
    ShowMessage('You cannot stop this process by closing the form. Please click the "Cancel" button below.');
  end;
end;

end.

