unit Userep;

{$MODE Delphi}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, RLReport, Db, ZDataset, Fileutil, MainDataModule;

type
  TUserReportForm = class(TForm)
    UserReport: TRLReport;
    Shape1: TRLDraw;
    PageHeaderBand1: TRLBand;
    ColumnHeaderBand1: TRLBand;
    PageFooterBand1: TRLBand;
    SysData2: TRLSystemInfo;
    Memo1: TRLMemo;
    CommentMemo: TRLMemo;
    Image1: TRLImage;
    SysData3: TRLSystemInfo;
    Label5: TRLLabel;
    Label6: TRLLabel;
    Label7: TRLLabel;
    Label8: TRLLabel;
    Label9: TRLLabel;
    Label10: TRLLabel;
    Label11: TRLLabel;
    Label12: TRLLabel;
    Label13: TRLLabel;
    Label14: TRLLabel;
    Label15: TRLLabel;
    Band1: TRLBand;
    DBText1: TRLDBText;
    DBText2: TRLDBText;
    DBText3: TRLDBText;
    DBText4: TRLDBText;
    DBText5: TRLDBText;
    DBText6: TRLDBText;
    DBText7: TRLDBText;
    DBText8: TRLDBText;
    DBText9: TRLDBText;
    DBText10: TRLDBText;
    DBText11: TRLDBText;
    DBText12: TRLDBText;
    DBText13: TRLDBText;
    DBText14: TRLDBText;
    DBText15: TRLDBText;
    SysData1: TRLSystemInfo;
    Label1: TRLLabel;
    Label2: TRLLabel;
    Label3: TRLLabel;
    Label4: TRLLabel;
    Band2: TRLBand;
    ReportQuery: TZQuery;
    ReportQuerySITE_ID_NR: TStringField;
    ReportQueryCOLUMN_1: TStringField;
    ReportQueryCOLUMN_2: TStringField;
    ReportQueryCOLUMN_3: TStringField;
    ReportQueryCOLUMN_4: TStringField;
    ReportQueryCOLUMN_5: TStringField;
    ReportQueryCOLUMN_6: TStringField;
    ReportQueryCOLUMN_7: TStringField;
    ReportQueryCOLUMN_8: TStringField;
    ReportQueryCOLUMN_9: TStringField;
    ReportQueryCOLUMN_10: TStringField;
    ReportQueryCOLUMN_11: TStringField;
    ReportQueryCOLUMN_12: TStringField;
    ReportQueryCOLUMN_13: TStringField;
    ReportQueryCOLUMN_14: TStringField;
    ReportQueryCOLUMN_15: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure UserReportPreview(Sender: TObject);
    procedure UserReportAfterPreview(Sender: TObject);
    procedure QRDBText1Print(sender: TObject; var Value: String);
    function GetValue(const ValueS: ShortString; ValueF: Real): ShortString;
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure QRDBText3Print(sender: TObject; var Value: String);
    procedure QRDBText4Print(sender: TObject; var Value: String);
    procedure QRDBText5Print(sender: TObject; var Value: String);
    procedure QRDBText6Print(sender: TObject; var Value: String);
    procedure QRDBText7Print(sender: TObject; var Value: String);
    procedure QRDBText8Print(sender: TObject; var Value: String);
    procedure QRDBText9Print(sender: TObject; var Value: String);
    procedure QRDBText10Print(sender: TObject; var Value: String);
    procedure QRDBText11Print(sender: TObject; var Value: String);
    procedure QRDBText12Print(sender: TObject; var Value: String);
    procedure QRDBText13Print(sender: TObject; var Value: String);
    procedure QRDBText14Print(sender: TObject; var Value: String);
    procedure QRDBText15Print(sender: TObject; var Value: String);
  private
    { Private declarations }
  public
    { Public declarations }
    Factor: array[1..15] of Real;
    SortColumn: ShortString;
  end;

var
  UserReportForm: TUserReportForm;

implementation

uses varinit;

{$R *.lfm}

procedure TUserReportForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ReportQuery.Close;
  DeleteFileUTF8(GetTempDir(False) + '\Ureport.dbf'); { *Converted from DeleteFile* }
  DeleteFileUTF8(GetTempDir(False) + '\Ureport.mdx'); { *Converted from DeleteFile* }
  Action := caFree;
end;

procedure TUserReportForm.UserReportPreview(Sender: TObject);
begin
  with ReportQuery do
  begin
    Connection := DataModuleMain.ZConnectionDB;
    SQL.Add('Select * From Ureport');
    SQL.Add('Order by ' + SortColumn);
    Open;
  end;
  //
  with UserReport do
  begin
    Margins.LeftMargin := LLeftMargin;
    Margins.TopMargin := LTopMargin;
    Margins.RightMargin := LRightMargin;
    Margins.BottomMargin := Height - TopMargin - 180;
    with Shape1 do
    begin
      Left := LLeftMargin - 2;
      Top := LTopMargin - 2;
      Height := UserReport.Height - LTopMargin - Trunc(UserReport.Margins.BottomMargin) + 4;
      Width := UserReport.Width - LLeftMargin - LRightMargin + 4;
    end;
  end;
  SysData1.Left := PageheaderBand1.Width - 132;
  Image1.Left := PageFooterBand1.Width - 272;
  Memo1.Left := PageFooterBand1.Width - 167;
  CommentMemo.Width := Image1.Left - 12;
  //
  {UserPreviewForm := TRepPrevForm.Create(Application);
  UserPreviewForm.Caption := UserReport.Title;
  UserPreviewForm.Tag := Tag;
  UserPreviewForm.RLPreview.SetActive(True);
  UserPreviewForm.Height := 480;
  UserPreviewForm.Width := 600;
  UserPreviewForm.RLPreview.ZoomFullPage;
  //UserReport.Preview;}
end;

procedure TUserReportForm.UserReportAfterPreview(Sender: TObject);
begin
  UserReport.Free;
  UserReport := nil;
  Close;
end;

function TUserReportForm.GetValue(const ValueS: ShortString; ValueF: Real): ShortString;

var RealValue: Real;

begin
  {function to calculate and format numeric outputs}
  try
    if ValueF = 999999 then
    begin
      RealValue := StrToFloat(ValueS);
      Result := FloatToStrF(RealValue, ffFixed, 15, 2);
    end
    else
    begin
      RealValue := StrToFloat(ValueS) * ValueF;
      if RealValue <= 0.001 then Result := FloatToStrF(RealValue, ffFixed, 15, 5) else
      if RealValue <= 0.1 then Result := FloatToStrF(RealValue, ffFixed, 15, 3) else
      if RealValue <= 0 then Result := FloatToStrF(RealValue, ffFixed, 15, 2) else
      if RealValue < 1000 then Result := FloatToStrF(RealValue, ffFixed, 15, 3) else
      if RealValue < 10000 then Result :=  FloatToStrF(RealValue, ffFixed, 15, 1) else
        Result := FloatToStrF(RealValue, ffFixed, 15, 0);
    end;
  except on EConvertError do
    Result := ValueS;
  end;
end;

procedure TUserReportForm.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value := GetValue(ReportQueryCOLUMN_1.Value, Factor[1]);
end;

procedure TUserReportForm.QRDBText2Print(sender: TObject;
  var Value: String);
begin
   Value := GetValue(ReportQueryCOLUMN_2.Value, Factor[2]);
end;

procedure TUserReportForm.QRDBText3Print(sender: TObject;
  var Value: String);
begin
  Value := GetValue(ReportQueryCOLUMN_3.Value, Factor[3]);
end;

procedure TUserReportForm.QRDBText4Print(sender: TObject;
  var Value: String);
begin
  Value := GetValue(ReportQueryCOLUMN_4.Value, Factor[4]);
end;

procedure TUserReportForm.QRDBText5Print(sender: TObject;
  var Value: String);
begin
  Value := GetValue(ReportQueryCOLUMN_5.Value, Factor[5]);
end;

procedure TUserReportForm.QRDBText6Print(sender: TObject;
  var Value: String);
begin
  Value := GetValue(ReportQueryCOLUMN_6.Value, Factor[6]);
end;

procedure TUserReportForm.QRDBText7Print(sender: TObject;
  var Value: String);
begin
  Value := GetValue(ReportQueryCOLUMN_7.Value, Factor[7]);
end;

procedure TUserReportForm.QRDBText8Print(sender: TObject;
  var Value: String);
begin
  Value := GetValue(ReportQueryCOLUMN_8.Value, Factor[8]);
end;

procedure TUserReportForm.QRDBText9Print(sender: TObject;
  var Value: String);
begin
  Value := GetValue(ReportQueryCOLUMN_9.Value, Factor[9]);
end;

procedure TUserReportForm.QRDBText10Print(sender: TObject;
  var Value: String);
begin
  Value := GetValue(ReportQueryCOLUMN_10.Value, Factor[10]);
end;

procedure TUserReportForm.QRDBText11Print(sender: TObject;
  var Value: String);
begin
  Value := GetValue(ReportQueryCOLUMN_11.Value, Factor[11]);
end;

procedure TUserReportForm.QRDBText12Print(sender: TObject;
  var Value: String);
begin
  Value := GetValue(ReportQueryCOLUMN_12.Value, Factor[12]);
end;

procedure TUserReportForm.QRDBText13Print(sender: TObject;
  var Value: String);
begin
  Value := GetValue(ReportQueryCOLUMN_13.Value, Factor[13]);
end;

procedure TUserReportForm.QRDBText14Print(sender: TObject;
  var Value: String);
begin
  Value := GetValue(ReportQueryCOLUMN_14.Value, Factor[14]);
end;

procedure TUserReportForm.QRDBText15Print(sender: TObject;
  var Value: String);
begin
  Value := GetValue(ReportQueryCOLUMN_15.Value, Factor[15]);
end;


end.
