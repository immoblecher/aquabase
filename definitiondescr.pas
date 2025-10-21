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
unit definitiondescr;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ButtonPanel,
  ExtCtrls, ZDataset, Db;

type

  { TDescrForm }

  TDescrForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    LabeledEdit1: TLabeledEdit;
    ZReadOnlyQuery1: TZReadOnlyQuery;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { private declarations }
    AbortOK: Boolean;
  public
    { public declarations }
  end;

var
  DescrForm: TDescrForm;

implementation

{$R *.lfm}

uses MainDataModule;

{ TDescrForm }

procedure TDescrForm.FormShow(Sender: TObject);
begin
  LabeledEdit1.SetFocus;
end;

procedure TDescrForm.OKButtonClick(Sender: TObject);
begin
  AbortOK := False;
  with ZReadOnlyQuery1 do
  begin
    Open;
    if Locate('DESCRIPTION', LabeledEdit1.Text, [loCaseInsensitive]) then
      if MessageDlg('This parameter description exists aready! Do you want to overwrite it?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        DataModuleMain.ZConnectionSettings.ExecuteDirect('DELETE FROM userentr WHERE DESCRIPTION = ' + QuotedStr(LabeledEdit1.Text))
      else
      begin
        Close;
        LabeledEdit1.SetFocus;
        LabeledEdit1.SelectAll;
        AbortOK := True;
      end;
    Close;
  end;
end;

procedure TDescrForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TDescrForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose := not AbortOK;
end;

end.

