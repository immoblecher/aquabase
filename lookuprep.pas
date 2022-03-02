unit lookuprep;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, RLReport, db,
  ZDataset;

type

  { TLookupReportForm }

  TLookupReportForm = class(TForm)
    CommentMemo: TRLMemo;
    DataSource1: TDataSource;
    FooterBand: TRLBand;
    LookupCodesBand: TRLBand;
    SubDetail: TRLSubDetail;
    RLBand5: TRLBand;
    RLBandHeader: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLImageLogo: TRLImage;
    RLLabel3: TRLLabel;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLMemoUserDetails: TRLMemo;
    RLReport1: TRLReport;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfo3: TRLSystemInfo;
    ZReadOnlyQuery1: TZReadOnlyQuery;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure RLReport1AfterPrint(Sender: TObject);
    procedure RLReport1BeforePrint(Sender: TObject; var PrintIt: boolean);
    procedure ZReadOnlyQuery1BeforeOpen(DataSet: TDataSet);
  private
    { private declarations }
  public
    { public declarations }
    CategoryList: TStringList;
  end;

var
  LookupReportForm: TLookupReportForm;

implementation

{$R *.lfm}

uses varinit;

{ TLookupReportForm }

procedure TLookupReportForm.RLReport1BeforePrint(Sender: TObject;
  var PrintIt: boolean);
var i: Integer;
begin
  //set report fonts
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TRLLabel then
    begin
      with (Components[i] as TRLLabel).Font do
      begin
        Name := ReportFont.Name;
        Color := ReportFont.Color;
        if Components[i].Tag = 0 then
          Size := ReportFont.Size
        else Size := ReportFont.Size + 2;
      end;
    end
    else
    if Components[i] is TRLDBText then
    begin
      with (Components[i] as TRLDBText).Font do
      begin
        Name := ReportFont.Name;
        Color := ReportFont.Color;
        Size := ReportFont.Size;
        Style := ReportFont.Style;
      end;
    end
    else
    if Components[i] is TRLSystemInfo then
    begin
      with (Components[i] as TRLSystemInfo).Font do
      begin
        Name := ReportFont.Name;
        Color := ReportFont.Color;
        //Style := ReportFont.Style;
        if Components[i].Tag = 0 then
          Size := ReportFont.Size
        else Size := ReportFont.Size + 2;
      end;
    end
    else
    if Components[i] is TRLMemo then
    begin
      with (Components[i] as TRLMemo).Font do
      begin
        Name := ReportFont.Name;
        Color := ReportFont.Color;
        Size := ReportFont.Size;
        Style := ReportFont.Style;
      end;
    end
    else
    if Components[i] is TRLDBMemo then
    begin
      with (Components[i] as TRLDBMemo).Font do
      begin
        Name := ReportFont.Name;
        Color := ReportFont.Color;
        Size := ReportFont.Size;
        Style := ReportFont.Style;
      end;
    end;
  end;
  ZReadOnlyQuery1.Open;
  if RLImageLogo.Visible then
  begin
    if FileExistsExt('userinfo.txt', WSpaceDir) then
      RLMemoUserDetails.Lines.LoadFromFile(GetFileNameOnDisk('userinfo.txt', WSpaceDir));
    if FileExistsExt('userlogo.jpg', WSpaceDir) then
      RLImageLogo.Picture.LoadFromFile(GetFileNameOnDisk('userlogo.jpg', WSpaceDir))
    else
    if FileExistsExt('userlogo.bmp', WSpaceDir) then
      RLImageLogo.Picture.LoadFromFile(GetFileNameOnDisk('userlogo.bmp', WSpaceDir));
  end;
end;

procedure TLookupReportForm.ZReadOnlyQuery1BeforeOpen(DataSet: TDataSet);
var InString: String;
    m: Integer;
begin
  InString := '';
  for m := 0 to CategoryList.Count  - 1 do
    Instring := InString + QuotedStr(CategoryList[m]) + ',';
  Delete(InString, Length(InString), 1);
  ZReadOnlyQuery1.SQL.Add('WHERE USED_FOR IN (' + InString + ')');
  InString := ZReadOnlyQuery1.SQL.Text;
end;

procedure TLookupReportForm.RLReport1AfterPrint(Sender: TObject);
begin
  ZReadOnlyQuery1.Close;
  CategoryList.Free;
end;

procedure TLookupReportForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

end.

