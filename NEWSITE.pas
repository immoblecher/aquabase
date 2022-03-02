{ Copyright (C) 2021 Immo Blecher, immo@blecher.co.za

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
unit NEWSITE;

{$mode objfpc}{$H+}

interface

uses Classes, Graphics, Forms, Controls, Buttons, LCLType, Math,
  StdCtrls, ExtCtrls, SysUtils, Dialogs, ButtonPanel, XMLPropStorage;

type

  { TNewSiteForm }

  TNewSiteForm = class(TForm)
    AddCodeEdit: TEdit;
    ButtonPanel1: TButtonPanel;
    CheckBoxAutoLocation: TCheckBox;
    CheckBoxDefaultToCentre: TCheckBox;
    EditFreeForm: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MapRefEdit: TEdit;
    RadioGroup1: TRadioGroup;
    procedure CancelButtonClick(Sender: TObject);
    procedure CheckBoxAutoLocationChange(Sender: TObject);
    procedure EditFreeFormChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure EditChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
    { Private declarations }
    NewIDValid: Boolean;
  public
    { Public declarations }
  end;


implementation

uses VARINIT, maindatamodule;

{$R *.lfm}

procedure TNewSiteForm.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
end;

procedure TNewSiteForm.CheckBoxAutoLocationChange(Sender: TObject);
begin
  MapRefEdit.Enabled := not CheckBoxAutoLocation.Checked;
  CheckBoxDefaultToCentre.Enabled := not CheckBoxAutoLocation.Checked;
  CheckBoxDefaultToCentre.Checked := not CheckBoxAutoLocation.Checked;
end;

procedure TNewSiteForm.CancelButtonClick(Sender: TObject);
begin
  NewIDValid := True;
end;

procedure TNewSiteForm.EditFreeFormChange(Sender: TObject);
begin
  ButtonPanel1.OKButton.Enabled := (EditFreeForm.Text <> '');
end;

procedure TNewSiteForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose := NewIDValid;
end;

procedure TNewSiteForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TNewSiteForm.EditChange(Sender: TObject);
begin
  ButtonPanel1.OKButton.Enabled := (MapRefEdit.Text <> '') and (Length(MapRefEdit.Text) = 6) and (AddCodeEdit.Text <> '');
end;

procedure TNewSiteForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    DataModuleMain.OpenHelp(Sender);
end;

procedure TNewSiteForm.FormShow(Sender: TObject);
begin
  if Country = 'South Africa' then
  begin
    CheckBoxAutoLocation.Enabled := dstLatLong;
  end
  else
  begin
    CheckBoxDefaultToCentre.Enabled := False;
    CheckBoxDefaultToCentre.Checked := False;
  end;
  if RadioGroup1.ItemIndex = 0 then
  begin
    GroupBox1.Enabled := True;
    GroupBox2.Enabled := False;
    MapRefEdit.SetFocus;
  end
  else
  begin
    GroupBox1.Enabled := False;
    GroupBox2.Enabled := True;
    EditFreeForm.SetFocus;
  end;
end;

procedure TNewSiteForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TNewSiteForm.OKButtonClick(Sender: TObject);
var
  MapRef: ShortString;
const
   MapChars = ['A', 'B', 'C', 'D'];
begin
  if (Country = 'South Africa') and (RadioGroup1.ItemIndex = 0) then
  begin
    if CheckBoxAutoLocation.Checked then
    begin
      NewIDValid := True;
      if AddCodeEdit.Text = '' then
        AddCodeEdit.Text := '0';
      MapRefEdit.Text := '0000ZZ';
    end
    else //check for valid map reference
    begin
      MapRef := MapRefEdit.Text;
      try
        StrToInt(Copy(MapRef, 1, 4));
        //check if Latitude within RSA maps
        NewIDValid := (StrToInt(Copy(MapRef, 1, 2)) >= 22) and (StrToInt(Copy(MapRef, 1, 2)) <= 34);
        //check if Longitude within RSA maps
        NewIDValid := (StrToInt(Copy(MapRef, 3, 2)) >= 16) and (StrToInt(Copy(MapRef, 3, 2)) <= 32);
        if not NewIDValid then
        begin
          MessageDlg('Invalid map reference entered! First 2 digits must be >= 22 and <= 34 and 3rd and 4th digit >= 16 and <= 32.', mtError, [mbOK], 0);
          MapRefEdit.SetFocus;
        end;
      except on EConvertError do
        begin
          MessageDlg('Invalid map reference entered! First 2 digits must be >= 22 and <= 34 and 3rd and 4th digit >= 16 and <= 32.', mtError, [mbOK], 0);
          MapRefEdit.SetFocus;
          NewIDValid := False;
        end;
      end; {of try}
      if NewIDValid and ((not(MapRef[5] in MapChars)) or (not(MapRef[6] in MapChars))) then
      begin
        MessageDlg('Invalid map reference entered! 5th and 6th characters must be "A", "B", "C" or "D".', mtError, [mbOK], 0);
        MapRefEdit.SetFocus;
        NewIDValid := False;
        Abort;
      end;
      if AddCodeEdit.Text = '' then
        AddCodeEdit.Text := '0';
    end;
  end
  else
  begin
    with DataModuleMain.CheckQuery do
    begin
      SQL.Clear;
      SQL.Add('select site_id_nr from basicinf where site_id_nr = ' + QuotedStr(EditFreeForm.Text));
      Open;
      if RecordCount > 0 then
      begin
        MessageDlg('The Site Identifier "' + EditFreeForm.Text + '" exists already! Please choose a unique Site identifier.', mtError, [mbRetry], 0);
        NewIDValid := False;
        EditFreeForm.SetFocus;
      end
      else
        NewIDValid := True;
      Close;
      SQL.Clear;
    end;
  end;
end;

procedure TNewSiteForm.RadioGroup1Click(Sender: TObject);
begin
  if RadioGroup1.ItemIndex = 0 then
  begin
    if Country = 'South Africa' then
    begin
      GroupBox1.Enabled := True;
      GroupBox2.Enabled := False;
      if Showing then
        MapRefEdit.SetFocus;
      ButtonPanel1.OKButton.Enabled := (MapRefEdit.Text <> '') and (Length(MapRefEdit.Text) = 6) and (AddCodeEdit.Text <> '');
    end
    else
    begin
      MessageDlg('You cannot use "Map reference" outside South Africa yet!', mtError, [mbOK], 0);
      RadioGroup1.ItemIndex := 1;
    end;
  end
  else
  if RadioGroup1.ItemIndex = 1 then
  begin
    GroupBox1.Enabled := False;
    GroupBox2.Enabled := True;
    if Showing then
      EditFreeForm.SetFocus;
    ButtonPanel1.OKButton.Enabled := (EditFreeForm.Text <> '');
  end
  else
  if RadioGroup1.ItemIndex = 2 then
  begin
    GroupBox1.Enabled := False;
    with DataModuleMain.CheckQuery do
    begin
      SQL.Clear;
      SQL.Add('select max(ogr_fid) from basicinf');
      Open;
      if not Fields[0].IsNull then
        EditFreeForm.Text := Format('%.11d', [Fields[0].AsInteger + 1])
      else
        EditFreeForm.Text := '00000000001';
      Close;
      SQL.Clear;
      GroupBox2.Enabled := False;
    end;
  end;
end;

end.
