unit Delsites;

{$mode objfpc}{$H+}

interface

uses
  LCLIntf, LCLType, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ButtonPanel, ZSqlProcessor, ZDataset;

type

  { TDelSitesDlg }

  TDelSitesDlg = class(TForm)
    ButtonPanel1: TButtonPanel;
    ViewComboBox: TComboBox;
    Label1: TLabel;
    RadioGroup: TRadioGroup;
    ZSQLProcessor1: TZSQLProcessor;
    procedure ViewComboBoxChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DelSitesDlg: TDelSitesDlg;

implementation

uses VARINIT, MainDataModule;

{$R *.lfm}
procedure TDelSitesDlg.ViewComboBoxChange(Sender: TObject);
begin
  ButtonPanel1.OKButton.Enabled := ViewComboBox.ItemIndex > -1;
end;

procedure TDelSitesDlg.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TDelSitesDlg.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
end;

procedure TDelSitesDlg.FormShow(Sender: TObject);
var
  TheViews: TStringList;
begin
  //Get the views
  TheViews := TStringList.Create;
  DataModuleMain.GetAllViews(DataModuleMain.ZConnectionDB, TheViews);
  ViewComboBox.Items.Assign(TheViews);
  TheViews.Free;
  ViewComboBox.Items.Delete(ViewComboBox.Items.IndexOf('allsites'));
  ViewComboBox.ItemIndex := 0;
  Application.ProcessMessages;
end;

procedure TDelSitesDlg.HelpBtnClick(Sender: TObject);
begin
   Application.HelpKeyword('DeleteSites');
end;

procedure TDelSitesDlg.OKButtonClick(Sender: TObject);
begin
  ZSQLProcessor1.Connection := DataModuleMain.ZConnectionDB;
  if RadioGroup.ItemIndex = 0 then
  begin
    if MessageDlg('Are you sure you want to delete ALL the sites which are IN view "' + ViewComboBox.Text + '"? This cannot be undone!', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      Screen.Cursor := crSQLWait;
      ZSQLProcessor1.Script.Add('DELETE FROM basicinf WHERE SITE_ID_NR IN (SELECT * FROM ' + ViewComboBox.Text + ')');
      ZSQLProcessor1.Execute;
      Screen.Cursor := crDefault;
      MessageDlg('Successfully deleted all sites in view "' + ViewComboBox.Text + '". This view therefore contains no sites and can be deleted.', mtInformation, [mbOK], 0);
    end;
  end
  else
  begin
    if MessageDlg('Are you sure you want to delete ALL the sites which are NOT IN view "' + ViewComboBox.Text + '"? This cannot be undone!', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      Screen.Cursor := crSQLWait;
      ZSQLProcessor1.Script.Add('DELETE FROM basicinf WHERE SITE_ID_NR NOT IN (SELECT * FROM ' + ViewComboBox.Text + ')');
      ZSQLProcessor1.Execute;
      Screen.Cursor := crDefault;
      MessageDlg('Successfully deleted all sites not in view "' + ViewComboBox.Text + '".', mtInformation, [mbOK], 0);
    end;
  end;
end;

end.
