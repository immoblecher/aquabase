unit crsinfo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  XMLPropStorage, Buttons, StdCtrls, ComCtrls, rxdbgrid, ZDataset, Grids, DBGrids;

type

  { TCRSInfoForm }

  TCRSInfoForm = class(TForm)
    CloseBitBtn: TBitBtn;
    ComboBox1: TComboBox;
    DataSource1: TDataSource;
    DBNavigator1: TDBNavigator;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    RxDBGrid1: TRxDBGrid;
    StatusBar1: TStatusBar;
    XMLPropStorage1: TXMLPropStorage;
    ZReadOnlyQuery1: TZReadOnlyQuery;
    ZReadOnlyQuery1area_used: TStringField;
    ZReadOnlyQuery1crs: TStringField;
    ZReadOnlyQuery1description: TWideMemoField;
    ZReadOnlyQuery1SRID: TLargeintField;
    ZReadOnlyQuery1type: TStringField;
    procedure CloseBitBtnClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ZReadOnlyQuery1AfterOpen(DataSet: TDataSet);
    procedure ZReadOnlyQuery1descriptionGetText(Sender: TField;
      var aText: string; DisplayText: Boolean);
  private

  public

  end;

var
  CRSInfoForm: TCRSInfoForm;

implementation

{$R *.lfm}

uses MainDataModule, VARINIT;

{ TCRSInfoForm }

procedure TCRSInfoForm.FormShow(Sender: TObject);
begin
  ZReadOnlyQuery1.Open;
end;

procedure TCRSInfoForm.ZReadOnlyQuery1AfterOpen(DataSet: TDataSet);
begin
  StatusBar1.SimpleText := IntToStr(DataSet.RecordCount) + ' Records';
end;

procedure TCRSInfoForm.ZReadOnlyQuery1descriptionGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := Sender.AsString;
end;

procedure TCRSInfoForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  ZReadOnlyQuery1.Close;
  CloseAction := caFree;
end;

procedure TCRSInfoForm.CloseBitBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TCRSInfoForm.ComboBox1Change(Sender: TObject);
begin
  if (ComboBox1.ItemIndex > 0) and (Edit1.Text > '') then
  begin
    if ComboBox1.ItemIndex = 1 then
      ZReadOnlyQuery1.Filter := 'crs like ' + QuotedStr('*' + Edit1.Text + '*')
    else
    if ComboBox1.ItemIndex = 2 then
      ZReadOnlyQuery1.Filter := 'area_used like ' + QuotedStr('*' + Edit1.Text + '*')
    else
    if ComboBox1.ItemIndex = 3 then
      ZReadOnlyQuery1.Filter := 'description like ' + QuotedStr('*' + Edit1.Text + '*');
    ZReadOnlyQuery1.Filtered := True;
  end
  else
  begin
    ZReadOnlyQuery1.Filtered := False;
  end;
  StatusBar1.SimpleText := IntToStr(ZReadOnlyQuery1.RecordCount) + ' Records';
end;

procedure TCRSInfoForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, True);
end;

end.

