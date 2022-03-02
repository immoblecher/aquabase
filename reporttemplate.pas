{ Copyright (C) 2022 Immo Blecher, immo@blecher.co.za

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
unit reporttemplate;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, RLReport, ZDataset, Forms,
  Controls, Graphics, Dialogs, DbCtrls;

type

  { TReportTemplateForm }

  TReportTemplateForm = class(TForm)
    BasicinfDataSource: TDataSource;
    BasicinfQueryALTITUDE: TFloatField;
    BasicinfQueryALT_NO_1: TStringField;
    BasicinfQueryALT_NO_2: TStringField;
    BasicinfQueryBH_DIAM: TFloatField;
    BasicinfQueryCOLLAR_HI: TFloatField;
    BasicinfQueryCOORD_ACC: TStringField;
    BasicinfQueryCOORD_METH: TStringField;
    BasicinfQueryDEPTH: TFloatField;
    BasicinfQueryDRAINAGE_R: TStringField;
    BasicinfQueryFARM_NR: TStringField;
    BasicinfQueryNR_ON_MAP: TStringField;
    BasicinfQueryREGION_BB: TStringField;
    BasicinfQueryREGN_DESCR: TStringField;
    BasicinfQueryREGN_TYPE: TStringField;
    BasicinfQueryREP_INST: TStringField;
    BasicinfQuerySITE_ID_NR: TStringField;
    BasicinfQuerySITE_NAME: TStringField;
    BasicinfQuerySITE_PURPS: TStringField;
    BasicinfQuerySITE_STATU: TStringField;
    BasicinfQuerySITE_TYPE: TStringField;
    BasicinfQuerySURV_METH: TStringField;
    BasicinfQueryTOPO_SETTG: TStringField;
    BasicinfQueryUSE_APPLIC: TStringField;
    BasicinfQueryUSE_CONSUM: TStringField;
    BasicinfQueryX_COORD: TFloatField;
    BasicinfQueryY_COORD: TFloatField;
    RLCommentMemo: TRLMemo;
    RLDBTextYCoord: TRLDBText;
    RLDBTextXCoord: TRLDBText;
    RLMemoUserDetails: TRLMemo;
    RLSystemInfoReportTitle: TRLSystemInfo;
    SubHeaderBand: TRLBand;
    SubDetail1: TRLSubDetail;
    CoordLabel: TRLLabel;
    ViewDataSource: TDataSource;
    FooterBand: TRLBand;
    RLDBText15: TRLDBText;
    RLDBText18: TRLDBText;
    RLDBText19: TRLDBText;
    RLDBText20: TRLDBText;
    RLDBText21: TRLDBText;
    RLDBText22: TRLDBText;
    RLDBText23: TRLDBText;
    RLDBText24: TRLDBText;
    RLDBText25: TRLDBText;
    RLDBText26: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDraw1: TRLDraw;
    RLDraw2: TRLDraw;
    RLDraw3: TRLDraw;
    RLDraw4: TRLDraw;
    RLLabel17: TRLLabel;
    RLLabel22: TRLLabel;
    RLLabel23: TRLLabel;
    RLLabel24: TRLLabel;
    RLLabel25: TRLLabel;
    RLLabel26: TRLLabel;
    RLLabel27: TRLLabel;
    RLLabel28: TRLLabel;
    RLLabel29: TRLLabel;
    RLLabel30: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    TheReport: TRLReport;
    RLBand1: TRLBand;
    RLBand: TRLBand;
    RLBandHeader: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    RLDBText12: TRLDBText;
    RLDBText13: TRLDBText;
    RLDBText14: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLImageLogo: TRLImage;
    RLLabelAltitude: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabelDiameter: TRLLabel;
    RLLabelDepth: TRLLabel;
    RLLabelCollar: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel78: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    X_CoordLabel: TRLLabel;
    Y_CoordLabel: TRLLabel;
    ViewQuery: TZReadOnlyQuery;
    BasicinfQuery: TZReadOnlyQuery;
    procedure BasicinfQueryALTITUDEGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryBeforeOpen(DataSet: TDataSet);
    procedure BasicinfQueryBH_DIAMGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryCOLLAR_HIGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryDEPTHGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQuerySITE_ID_NRGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryX_COORDGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure BasicinfQueryY_COORDGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure LookupsGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure TheReportBeforePrint(Sender: TObject; var PrintIt: boolean);
    procedure ViewDataSourceDataChange(Sender: TObject; Field: TField);
    procedure ViewQueryBeforeOpen(DataSet: TDataSet);
  private
    { private declarations }
    XCoord, YCoord: ShortString;
    PrevRepInst, PrevInfoSrc, PrevType, RepInstDescr, InfoSrcDescr, TypeDescr: ShortString;
    PrevMethMeas, PrevLvlStat, PrevParmMeas, MethMeasDescr, LvlStatDescr, ParmMeasDescr: ShortString;
    PrevMethSamp, PrevSampType, MethSampDescr, SampTypeDescr: ShortString;
  public
    { public declarations }
    TheUsedTablesList, TheFilterList: TStringList;
    UseConstr, NewSite: Boolean;
    SiteID: ShortString;
  end;

var
  ReportTemplateForm: TReportTemplateForm;

implementation

{$R *.lfm}

uses Varinit, MainDataModule;

{ TReportTemplateForm }

procedure TReportTemplateForm.TheReportBeforePrint(Sender: TObject;
  var PrintIt: boolean);
begin
  with TheReport do
  begin
    Margins.LeftMargin := LeftMargin;
    Margins.TopMargin := TopMargin;
    Margins.BottomMargin := BotMargin;
    Margins.RightMargin := 10 - LeftMargin + 10;
  end;
  RLBandHeader.Color := ReportHeaderBandColor;
  //Set Labels of coordinate edits
  Application.ProcessMessages;
  if dstLO then
  begin
    Y_CoordLabel.Caption := 'Y Coord. ' + '[' + LengthUnit + ']:';
    X_CoordLabel.Caption := 'X Coord. ' + '[' + LengthUnit + ']:';
  end
  else
  if dstLatLong then //is lat/long
  begin
    if ShowDMS then //show Degrees, minutes, seconds
    begin
      X_CoordLabel.Caption := 'Longitude [° '' "]:';
      Y_CoordLabel.Caption := 'Latitude [° '' "]:';
    end
    else
    begin
      X_CoordLabel.Caption := 'Longitude [°]:';
      Y_CoordLabel.Caption := 'Latitude [°]:';
    end;
  end
  else
  begin
    X_CoordLabel.Caption := 'Easting ' + '[' + LengthUnit + ']:';
    Y_CoordLabel.Caption := 'Northing ' + '[' + LengthUnit + ']:';
  end;
  CoordLabel.Caption := CoordLabel.Caption + CoordSysDescr;
  {Set Units in labels}
  RLLabelAltitude.Caption := RLLabelAltitude.Caption + ' [' + LengthUnit + ']:';
  RLLabelDiameter.Caption := RLLabelDiameter.Caption + ' [' + DiamUnit + ']:';
  RLLabelDepth.Caption := RLLabelDepth.Caption + ' [' + LengthUnit + ']:';
  RLLabelCollar.Caption := RLLabelCollar.Caption + ' [' + LengthUnit + ']:';
  if FileExists(WSpaceDir + DirectorySeparator + 'Userinfo.txt') then
    RLMemoUserDetails.Lines.LoadFromFile(WSpaceDir + DirectorySeparator + 'Userinfo.txt');
  if FileExists(WSpaceDir + DirectorySeparator +'userlogo.jpg') then
    RLImageLogo.Picture.LoadFromFile(WSpaceDir + DirectorySeparator + 'userlogo.jpg')
  else
  if FileExists(WSpaceDir + DirectorySeparator + 'userlogo.bmp') then
    RLImageLogo.Picture.LoadFromFile(WSpaceDir + DirectorySeparator + 'userlogo.bmp');
  Application.ProcessMessages;
  //Open the view which then opens basicinf
  Screen.Cursor := crSQLWait;
  ViewQuery.Open;
  Screen.Cursor := crDefault;
end;

procedure TReportTemplateForm.ViewDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  NewSite := (ViewQuery.Fields[0].Value <> SiteID);
  if (Field = NIL) and NewSite then
  begin
    BasicinfQuery.Close;
    BasicinfQuery.Open;
  end;
end;

procedure TReportTemplateForm.ViewQueryBeforeOpen(DataSet: TDataSet);
begin
  ViewQuery.Connection := DataModuleMain.ZConnectionDB;
end;

procedure TReportTemplateForm.FormCreate(Sender: TObject);
var c: Word;
begin
  for c := 0 to ComponentCount - 1 do
  if Components[c] is TControl then
  begin
    with (Components[c] as TControl).Font do
    begin
      Name := ReportFont.Name;
      Color := ReportFont.Color;
      if Components[c] is TRLLabel then
      begin
        Style := [fsBold];
        case Components[c].Tag of
          0: Size := ReportFont.Size;
          1: Size := ReportFont.Size + 2;
          2: Size := ReportFont.Size - 2;
        end;
      end
      else
      if Components[c] is TRLSystemInfo then
      begin
        Size := ReportFont.Size + Components[c].Tag;
        if Components[c].Tag = 2 then
          Style := [fsBold,fsItalic];
      end
      else
      begin
        Size := ReportFont.Size;
        Style := ReportFont.Style;
      end;
    end;
    if (Components[c] is TRLBand) and (TRLBand(Components[c]).GroupIndex >= 3)
      then TRLBand(Components[c]).Color := ColumnHeaderBandColor;
  end;
  CoordLabel.Font.Size := ReportFont.Size - 1;
  TheUsedTablesList := TStringList.Create;
  TheFilterList := TStringList.Create;
end;

procedure TReportTemplateForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TReportTemplateForm.BasicinfQueryBeforeOpen(DataSet: TDataSet);
begin
  BasicinfQuery.Connection := DataModuleMain.ZConnectionDB;
  BasicinfQuery.SQL.Clear;
  BasicinfQuery.SQL.Add('SELECT * FROM basicinf WHERE SITE_ID_NR = ' + QuotedStr(ViewQuery.Fields[0].AsString));
end;

procedure TReportTemplateForm.BasicinfQueryBH_DIAMGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
  begin
    if DiamFactor = 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 0)
    else
    if DiamFactor < 1 then
      aText := FloatToStrF(Sender.AsFloat * DiamFactor, ffFixed, 15, 2);
  end;
end;

procedure TReportTemplateForm.BasicinfQueryCOLLAR_HIGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.AsFloat > 0 then
  begin
    if Sender.AsFloat * LengthFactor > 100 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
    else
    if Sender.AsFloat * LengthFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end
  else
    aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
end;

procedure TReportTemplateForm.BasicinfQueryDEPTHGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.Value > 0 then
  begin
    if Sender.Value * LengthFactor > 1000 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
    else
    if Sender.Value * LengthFactor < 0.01 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end
  else DisplayText := False;
end;

procedure TReportTemplateForm.BasicinfQuerySITE_ID_NRGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := Sender.Value;
  with DataModuleMain do
    cs2cs(BasicinfQueryX_COORD.AsString, BasicinfQueryY_COORD.AsString, GetMapRef(BasicinfQuerySITE_ID_NR.AsString), OrigCoordSysNr, CoordSysNr, XCoord, YCoord);
end;

procedure TReportTemplateForm.BasicinfQueryALTITUDEGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then DisplayText := False
  else
  begin
    if Abs(Sender.AsFloat * LengthFactor) > 10000 then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 0)
    else
    if (Abs(Sender.AsFloat * LengthFactor) < 0.01) and (Abs(Sender.AsFloat * LengthFactor) > 0) then
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(Sender.AsFloat * LengthFactor, ffFixed, 15, 2);
  end;
end;

procedure TReportTemplateForm.BasicinfQueryX_COORDGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := XCoord;
end;

procedure TReportTemplateForm.BasicinfQueryY_COORDGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText := YCoord;
end;

procedure TReportTemplateForm.LookupsGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull and (not PrintNoInfo) then DisplayText := False
  else
  case Sender.Tag of
    1: begin
         if Sender.AsString <> PrevRepInst then
         begin
           RepInstDescr := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
           aText := RepInstDescr;
         end
         else
           aText := RepInstDescr;
         PrevRepInst := Sender.AsString;
       end;
    2: begin
         if Sender.AsString <> PrevInfoSrc then
         begin
           InfoSrcDescr := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
           aText := InfoSrcDescr;
         end
         else
           aText := InfoSrcDescr;
         PrevInfoSrc := Sender.AsString;
       end;
    3: begin
         if Sender.AsString <> PrevType then
         begin
           TypeDescr := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
           aText := TypeDescr;
         end
         else
           aText := TypeDescr;
         PrevType := Sender.AsString;
       end;
    4: begin
         if Sender.AsString <> PrevMethMeas then
         begin
           MethMeasDescr := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
           aText := MethMeasDescr;
         end
         else
           aText := MethMeasDescr;
         PrevMethMeas := Sender.AsString;
       end;
    5: begin
         if Sender.AsString <> PrevLvlStat then
         begin
           LvlStatDescr := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
           aText := LvlStatDescr;
         end
         else
           aText := LvlStatDescr;
         PrevLvlStat := Sender.AsString;
       end;
    6: begin
         if Sender.AsString <> PrevParmMeas then
         begin
           ParmMeasDescr := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
           aText := ParmMeasDescr;
         end
         else
           aText := ParmMeasDescr;
         PrevParmMeas := Sender.AsString;
       end;
    7: begin
         if Sender.AsString <> PrevSampType then
         begin
           SampTypeDescr := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
           aText := SampTypeDescr;
         end
         else
           aText := SampTypeDescr;
         PrevSampType := Sender.AsString;
       end;
    8: begin
         if Sender.AsString <> PrevMethSamp then
         begin
           MethSampDescr := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
           aText := MethSampDescr;
         end
         else
           aText := MethSampDescr;
         PrevMethSamp := Sender.AsString;
       end;
    else //for all others, e.g. not repeating in columns
      aText := DataModuleMain.TranslateCode(Sender.LookupKeyFields, Sender.AsString);
  end; //of case
end;

end.

