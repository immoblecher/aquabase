{ Copyright (C) 2019 Immo Blecher, immo@blecher.co.za

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
unit reconsileSites;

{$mode objfpc}{$H+}

interface

uses
  LCLIntf, LCLType, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, Db, StdCtrls, ExtCtrls, ButtonPanel, DbCtrls, ZDataset, ZSqlProcessor;

type

  { TFormReconcile }

  TFormReconcile = class(TForm)
    Button1: TButton;
    ButtonPanel1: TButtonPanel;
    LabeledEdit1: TLabeledEdit;
    ZSQLProcessor1: TZSQLProcessor;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure ZSQLProcessor1Error(Processor: TZSQLProcessor;
      StatementIndex: Integer; E: Exception;
      var ErrorHandleAction: TZErrorHandleAction);
  private
    { Private declarations }
    error: Boolean;
  public
    { Public declarations }
  end;

var
  FormReconcile: TFormReconcile;

implementation

uses VARINIT, MainDataModule, selectSiteID;

{$R *.lfm}

procedure TFormReconcile.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  Screen.Cursor := crDefault;
  CloseAction := caFree;
end;

procedure TFormReconcile.Button1Click(Sender: TObject);
begin
  with TFormSelSiteID.Create(Application) do
  begin
    SiteIDQuery.Locate('SITE_ID_NR', CurrentSite, []);
    if not SiteIDQuery.EOF then
      SiteIDQuery.Next
    else
      SiteIDQuery.Prior;
    ShowModal;
    if ModalResult = mrOK then
      LabeledEdit1.Text := SiteIDQuerySITE_ID_NR.Value;
    Close;
  end;
  if LabeledEdit1.Text = CurrentSite then
  begin
    MessageDlg('You cannot reconcile the current site with itself! Please chose another site.', mtError, [mbOK], 0);
    LabeledEdit1.Text := '<no site selected>';
    Buttonpanel1.OKButton.Enabled := False;
  end
  else
  Buttonpanel1.OKButton.Enabled := True;
end;

procedure TFormReconcile.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
end;

procedure TFormReconcile.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TFormReconcile.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TFormReconcile.OKButtonClick(Sender: TObject);
var TableList: TStringList;
    t: Integer;
begin
  error := False;
  TableList := TStringList.Create;
  with DataModuleMain do
  begin
    if not AquaSortTable.Active then
      AquaSortTable.Open;
    ZConnectionDB.GetTableNames('', TableList);
    for t := 0 to TableList.Count - 1 do
    begin
      if AquaSortTable.Locate('FILE_NAME', TableList.Strings[t], [loCaseInsensitive]) then
      begin
        if (TableList.Strings[t] <> 'basicinf') and (Pos('SITE_ID_NR', AquaSortTable.FieldByName('SORTORDER').Value) > 0) then
          ZSQLProcessor1.Script.Add('UPDATE ' + TableList.Strings[t] + ' SET SITE_ID_NR = ' + QuotedStr(CurrentSite) + ' WHERE SITE_ID_NR = ' + QuotedStr(LabeledEdit1.Text) + ';');
      end;
    end;
    AquaSortTable.Close;
    ZSQLProcessor1.Connection := ZConnectionDB;
  end;
  Screen.Cursor := crSQLWait;
  ZSQLProcessor1.Execute;
  Screen.Cursor := crDefault;
  if error then
    MessageDlg('Some errors were encountered during the reconciliation process, most of them probably due to key violations! The rest of the data was reconciled successfully. Please fix remaining data errors before attemting this routine again.', mtError, [mbOK], 0)
  else
  begin
    if MessageDlg('Sites successfully reconciled! Do you want to delete the site from which data was reconciled?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      DataModuleMain.ZConnectionDB.ExecuteDirect('DELETE FROM basicinf WHERE SITE_ID_NR = ' + QuotedStr(LabeledEdit1.Text));
      DataModuleMain.ZQueryView.Refresh;
    end;
  end;
end;

procedure TFormReconcile.ZSQLProcessor1Error(Processor: TZSQLProcessor;
  StatementIndex: Integer; E: Exception;
  var ErrorHandleAction: TZErrorHandleAction);
begin
  Screen.Cursor := crDefault;
  error := True;
  ErrorHandleAction := eaSkip;
  ShowMessage(E.Message + '. Reconcile script returned an error at line ' + IntToStr(StatementIndex) + ', reconciliation of data with the current site was skipped!');
  Screen.Cursor := crSQLWait;
end;

end.
