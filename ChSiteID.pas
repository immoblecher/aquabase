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
unit ChSiteID;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ButtonPanel, ZDataset, Db;

type

  { TChangeSiteIDForm }

  TChangeSiteIDForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    tempQuery: TZReadOnlyQuery;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    function Findsite(SiteId: String): Boolean;
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChangeSiteIDForm: TChangeSiteIDForm;

implementation

uses MainDataModule, varinit;

{$R *.lfm}

function TChangeSiteIDForm.Findsite(SiteId: String): Boolean;
begin
 tempQuery.Connection := DataModuleMain.ZConnectionDB;
 with tempQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT SITE_ID_NR FROM allsites WHERE SITE_ID_NR = ' + QuotedStr(SiteId));
  end;
  tempQuery.Open;
  if tempQuery.RecordCount > 0 then
    result := true
  else
    result := false;
  tempQuery.Close;
  tempQuery.Free;
end;

procedure TChangeSiteIDForm.OKButtonClick(Sender: TObject);
begin
  if FindSite(Edit1.Text) then
  begin
    MessageDlg('Site identifier ' + Edit1.Text
      + ' already exists! Choose a different site identifier.', mtError, [mbOK], 0);
    Edit1.SetFocus;
  end
  else
  if MessageDlg('Are you sure you want to change the current site identifier to '
    + Edit1.Text + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  with DataModuleMain do
  begin
    BasicinfQuery.Edit;
    BasicinfQuerySITE_ID_NR.AsString := Edit1.Text;
    BasicinfQuery.Post;
    CurrentSite := Edit1.Text;
    MessageDlg('Site identifier was successfully changed to ' + CurrentSite + '.', mtInformation, [mbOK], 0);
  end;
end;

procedure TChangeSiteIDForm.FormActivate(Sender: TObject);
begin
  Label1.Caption := 'From: ' + CurrentSite;
  Edit1.Text := CurrentSite;
end;

procedure TChangeSiteIDForm.FormCreate(Sender: TObject);
begin
 DataModuleMain.SetComponentFontAndSize(Sender, True);
end;

procedure TChangeSiteIDForm.HelpButtonClick(Sender: TObject);
begin
  Application.HelpKeyword('ChangeSiteID');
end;

end.
