unit LOOKSITE;

{$MODE Delphi}

interface

uses
  SysUtils, Classes, Graphics, Controls, ZDataset, DBCtrls,
  Forms, Dialogs, DB, StdCtrls, DBGrids, Varinit, LCLType,
  Buttons, ExtCtrls, XMLPropStorage;

type

  { TLookupSiteForm }

  TLookupSiteForm = class(TForm)
    DBGrid1: TDBGrid;
    Label1: TLabel;
    BasicinfTable: TZTable;
    BasicinfDataSource: TDataSource;
    BasicinfTableSITE_ID_NR: TStringField;
    BasicinfTableNR_ON_MAP: TStringField;
    BasicinfTableSITE_NAME: TStringField;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    HelpBitBtn: TBitBtn;
    CloseBitBtn: TBitBtn;
    FindDialog: TFindDialog;
    XMLPropStorage: TXMLPropStorage;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBLookupListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBLookupListDblClick(Sender: TObject);
    procedure BasicinfTableBeforeOpen(DataSet: TDataSet);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FindDialogFind(Sender: TObject);
    procedure HelpBitBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LookupSiteForm: TLookupSiteForm;

implementation

{$R *.lfm}

uses MainDataModule;

procedure TLookupSiteForm.FormResize(Sender: TObject);
begin
  DBGrid1.Width := Width - 16;
  DBGrid1.Height := Height - 64;
end;

procedure TLookupSiteForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
end;

procedure TLookupSiteForm.FormActivate(Sender: TObject);
begin
  BasicinfTable.Connection := DataModuleMain.ZConnectionDB;
  BasicinfTable.Open;
  BasicinfTable.Locate('SITE_ID_NR', DataModuleMain.LookupValue, []);
end;

procedure TLookupSiteForm.DBLookupListKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then Close
    else if Key = VK_RETURN then DBLookupListDblClick(Sender);
end;

procedure TLookupSiteForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BasicinfTable.Close;
  Action := caFree;
end;

procedure TLookupSiteForm.DBLookupListDblClick(Sender: TObject);
begin
  DataModuleMain.LookupValue := BasicinfTableSITE_ID_NR.Value;
  Close;
end;

procedure TLookupSiteForm.BasicinfTableBeforeOpen(DataSet: TDataSet);
begin
  BasicinfTable.Connection := DataModuleMain.ZConnectionDB;
end;

procedure TLookupSiteForm.SpeedButton1Click(Sender: TObject);
begin
  FindDialog.Execute;
end;

procedure TLookupSiteForm.FindDialogFind(Sender: TObject);

var MyDataset: TDataset;
    c: ShortInt;
    FText: String;
    Found: Boolean;
    Label StartFromTop, StartFromBottom;

begin
  Found := False;
  MyDataset := DBGrid1.DataSource.DataSet;
  MyDataSet.DisableControls;
  if frDown in FindDialog.Options then
  begin
    StartFromTop:
    while not MyDataSet.Eof do
    begin
      for c := 0 to MyDataSet.Fields.Count -1 do
      begin
        FText := MyDataSet.Fields[c].AsString;
        if Pos(FindDialog.FindText, FText) > 0 then
        begin
          Found := True;
          Break;
        end
        else Found := False;
      end;
      if not Found then MyDataset.Next else Break;
    end;
    if MyDataSet.Eof and not Found then
    begin
      if MessageDlg('Nothing found matching "' + FindDialog.FindText + '"! Do you want to start from the top?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        MyDataset.First;
        Goto StartFromTop;
      end;
    end;
  end
  else
  begin
    StartFromBottom:
    while not MyDataSet.BOF do
    begin
      for c := 0 to MyDataSet.Fields.Count -1 do
      begin
        FText := MyDataSet.Fields[c].AsString;
        if Pos(FindDialog.FindText, FText) > 0 then
        begin
          Found := True;
          Break;
        end
        else Found := False;
      end;
      if not Found then MyDataset.Prior else Break;
    end;
    if MyDataSet.BOF and not Found then
    begin
      if MessageDlg('Nothing found matching "' + FindDialog.FindText + '"! Do you want to start from the bottom?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        MyDataset.Last;
        Goto StartFromBottom;
      end;
    end;
  end;
  MyDataSet.EnableControls;
end;

procedure TLookupSiteForm.HelpBitBtnClick(Sender: TObject);
begin
   Application.HelpKeyword('SearchFunc');
end;

end.
