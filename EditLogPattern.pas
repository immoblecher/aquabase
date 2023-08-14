unit EditLogPattern;

{$MODE Delphi}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, ExtCtrls,
  DBGrids, DBCtrls, StdCtrls, Buttons, ExtDlgs, XMLPropStorage, ZDataset;

type

  { TEditLogPatternForm }

  TEditLogPatternForm = class(TForm)
    DataSourceLookup: TDataSource;
    DBGrid1: TDBGrid;
    Image1: TImage;
    ImageListNavs: TImageList;
    Panel3: TPanel;
    DBNavigator1: TDBNavigator;
    CloseBtn: TBitBtn;
    HelpBtn: TBitBtn;
    OpenPictureDialog: TOpenPictureDialog;
    ColorDialog1: TColorDialog;
    GroupBox1: TGroupBox;
    ColorPanel: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    XMLPropStorage: TXMLPropStorage;
    ZTableLookup: TZTable;
    ZTableLookupADJECTIVE: TStringField;
    ZTableLookupDEFAULT_CO: TLargeintField;
    ZTableLookupDESCRIBE: TStringField;
    ZTableLookupLOGS_BMP: TStringField;
    ZTableLookupSEARCH: TStringField;
    ZTableLookupUSED_FOR: TStringField;
    procedure CloseBtnClick(Sender: TObject);
    procedure DataSourceLookupDataChange(Sender: TObject; Field: TField);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure ColorPanelClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure ZTableLookupBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EditLogPatternForm: TEditLogPatternForm;

implementation

uses VARINIT, MainDataModule;

{$R *.lfm}

procedure TEditLogPatternForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage.FileName := GetUserDir + '/.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  DataSourceLookup.AutoEdit := AutoEditData;
  DBNavigator1.Images := DataModuleMain.ImageListNavs;
  ZTableLookup.Open;
end;

procedure TEditLogPatternForm.DataSourceLookupDataChange(Sender: TObject;
  Field: TField);
begin
  //Color
  if not ZTableLookupDEFAULT_CO.IsNull then
  begin
    ColorPanel.Color := TColor(ZTableLookupDEFAULT_CO.Value);
    ColorPanel.Caption := '';
  end
  else
  begin
    ColorPanel.Color := clBtnFace;
    ColorPanel.Caption := '<none>';
  end;
  //Bitmaps
  if not ZTableLookupLOGS_BMP.IsNull then
  begin
    if FileExists(ProgramDir + DirectorySeparator + 'Bitmaps' + DirectorySeparator + ZTableLookupLOGS_BMP.AsString) then
      Image1.Picture.LoadFromFile(ProgramDir + DirectorySeparator + 'Bitmaps' + DirectorySeparator + ZTableLookupLOGS_BMP.AsString)
    else
      Image1.Picture.LoadFromFile(ProgramDir + DirectorySeparator + 'Bitmaps' + DirectorySeparator + 'BLANK.BMP');
  end
  else
    Image1.Picture.LoadFromFile(ProgramDir + DirectorySeparator + 'Bitmaps' + DirectorySeparator + 'BLANK.BMP');
end;

procedure TEditLogPatternForm.CloseBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TEditLogPatternForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  ZTableLookup.Close;
  if DataModuleMain.LookupTable.Active then
    DataModuleMain.LookupTable.Refresh;
  CloseAction := caFree;
end;

procedure TEditLogPatternForm.HelpBtnClick(Sender: TObject);
begin
   Application.HelpKeyword('EnterEditData');
end;

procedure TEditLogPatternForm.ColorPanelClick(Sender: TObject);
begin
  ColorDialog1.Color := ZTableLookupDEFAULT_CO.Value;
  if ZTableLookup.State = dsEdit then
  begin
    if ColorDialog1.Execute then
      ZTableLookupDEFAULT_CO.Value := ColorDialog1.Color;
  end
  else
    MessageDlg('Lithology table not in edit state! Make the table editable first.', mtWarning, [mbOK], 0);
end;

procedure TEditLogPatternForm.Image1Click(Sender: TObject);
begin
  if ZTableLookup.State = dsEdit then
  begin
    OpenPictureDialog.InitialDir := ProgramDir + DirectorySeparator + 'Bitmaps';
    if OpenPictureDialog.Execute  then
    begin
      Image1.Picture.LoadFromFile(OpenPictureDialog.FileName);
      ZTableLookupLOGS_BMP.AsString := ExtractFileName(OpenPictureDialog.FileName);
    end;
  end
  else
    MessageDlg('Lithology table not in edit state! Make the table editable first.', mtWarning, [mbOK], 0);
end;

procedure TEditLogPatternForm.ZTableLookupBeforeOpen(DataSet: TDataSet);
begin
  ZTableLookup.Connection := DataModuleMain.ZConnectionLanguage;
end;

end.
