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
unit chemreport;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, 
    reporttemplate, db, RLReport, ZDataset;

type

  { TChemReportForm }

  TChemReportForm = class(TReportTemplateForm)
    Chem0Query: TZReadOnlyQuery;
    Chem0DataSource: TDataSource;
    Chem0QueryALT_NR_1: TStringField;
    Chem0QueryALT_NR_2: TStringField;
    Chem0QueryALT_NR_3: TStringField;
    Chem0QueryALT_NR_4: TStringField;
    Chem0QueryCHM_REF_NR: TLargeintField;
    Chem0QueryCOMMENT: TStringField;
    Chem0QueryDATE_ANAL: TStringField;
    Chem0QueryDATE_SAMPL: TStringField;
    Chem0QueryDEPTH_SAMP: TFloatField;
    Chem0QueryLAB: TStringField;
    Chem0QueryMETH_SAMPL: TStringField;
    Chem0QuerySAMPLE_NR: TStringField;
    Chem0QuerySAMPL_TYPE: TStringField;
    Chem0QuerySITE_ID_NR: TStringField;
    Chem0QueryTIME_PUMP: TLargeintField;
    Chem0QueryTIME_SAMPL: TStringField;
    Chem1DataSource: TDataSource;
    Chem1QueryAL: TFloatField;
    Chem1QueryCA: TFloatField;
    Chem1QueryCHM_REF_NR: TLargeintField;
    Chem1QueryCL: TFloatField;
    Chem1QueryCO3: TFloatField;
    Chem1QueryEC: TFloatField;
    Chem1QueryF: TFloatField;
    Chem1QueryFE: TFloatField;
    Chem1QueryHCO3: TFloatField;
    Chem1QueryK: TFloatField;
    Chem1QueryMACID: TFloatField;
    Chem1QueryMALK: TFloatField;
    Chem1QueryMG: TFloatField;
    Chem1QueryMN: TFloatField;
    Chem1QueryN: TFloatField;
    Chem1QueryNA: TFloatField;
    Chem1QueryPACID: TFloatField;
    Chem1QueryPALK: TFloatField;
    Chem1QueryPH: TFloatField;
    Chem1QuerySI: TFloatField;
    Chem1QuerySO4: TFloatField;
    Chem1QueryTDS: TFloatField;
    Chem2DataSource: TDataSource;
    Chem3DataSource: TDataSource;
    Chem4DataSource: TDataSource;
    Chem3Query: TZReadOnlyQuery;
    Chem2QueryARSENIC: TFloatField;
    Chem2QueryB: TFloatField;
    Chem2QueryBA: TFloatField;
    Chem2QueryBI: TFloatField;
    Chem2QueryCD: TFloatField;
    Chem2QueryCHM_REF_NR: TLargeintField;
    Chem2QueryCN: TFloatField;
    Chem2QueryCO: TFloatField;
    Chem2QueryCR: TFloatField;
    Chem2QueryCU: TFloatField;
    Chem2QueryHG: TFloatField;
    Chem2QueryMO: TFloatField;
    Chem2QueryNI: TFloatField;
    Chem2QueryNO2: TFloatField;
    Chem2QueryN_AMONIA: TFloatField;
    Chem2QueryPB: TFloatField;
    Chem2QueryPO4: TFloatField;
    Chem2QuerySB: TFloatField;
    Chem2QuerySR: TFloatField;
    Chem2QuerySULF: TFloatField;
    Chem2QueryTI: TFloatField;
    Chem2QueryZN: TFloatField;
    Chem5DataSource: TDataSource;
    Chem4Query: TZReadOnlyQuery;
    Chem3QueryBOD: TFloatField;
    Chem3QueryCFR: TFloatField;
    Chem3QueryCHM_REF_NR: TLargeintField;
    Chem3QueryCOD: TFloatField;
    Chem3QueryDOC: TFloatField;
    Chem3QueryDOX: TFloatField;
    Chem3QueryECOL: TLargeintField;
    Chem3QueryENT_VIRUS: TLargeintField;
    Chem3QueryFAEC_ECOL: TLargeintField;
    Chem3QueryFAEC_STREP: TLargeintField;
    Chem3QueryH2S: TFloatField;
    Chem3QueryKJED: TFloatField;
    Chem3QueryOIL: TFloatField;
    Chem3QueryPHEN: TFloatField;
    Chem3QueryPROTO_PARA: TLargeintField;
    Chem3QuerySOAP: TFloatField;
    Chem3QuerySOM_COLI: TLargeintField;
    Chem3QuerySPC: TLargeintField;
    Chem3QueryTOC: TFloatField;
    Chem3QueryTOTAL_COL: TLargeintField;
    Chem3QueryTOT_THM: TFloatField;
    Chem3QueryTVO: TLargeintField;
    Chem5Query: TZReadOnlyQuery;
    Chem4QueryCHM_REF_NR: TLargeintField;
    Chem4QueryCOLR: TFloatField;
    Chem4QueryDEUTERIUM: TFloatField;
    Chem4QueryMBAS: TFloatField;
    Chem4QueryODR: TFloatField;
    Chem4QueryOXYGEN18: TFloatField;
    Chem4QueryRCARBON: TFloatField;
    Chem4QuerySPECGRAV: TFloatField;
    Chem4QuerySUSP_SOLID: TFloatField;
    Chem4QueryTEMP: TFloatField;
    Chem4QueryTRITIUM: TFloatField;
    Chem4QueryTST: TFloatField;
    Chem4QueryTUR: TFloatField;
    Chem5QueryAG: TFloatField;
    Chem5QueryAU: TFloatField;
    Chem5QueryBE: TFloatField;
    Chem5QueryBR: TFloatField;
    Chem5QueryCE: TFloatField;
    Chem5QueryCHM_REF_NR: TLargeintField;
    Chem5QueryI: TFloatField;
    Chem5QueryLA: TFloatField;
    Chem5QueryLI: TFloatField;
    Chem5QueryNB: TFloatField;
    Chem5QueryND: TFloatField;
    Chem5QueryPD: TFloatField;
    Chem5QueryPT: TFloatField;
    Chem5QuerySE: TFloatField;
    Chem5QuerySN: TFloatField;
    Chem5QueryTA: TFloatField;
    Chem5QueryTE: TFloatField;
    Chem5QueryTL: TFloatField;
    Chem5QueryU: TFloatField;
    Chem5QueryV: TFloatField;
    Chem5QueryW: TFloatField;
    Chem5QueryZR: TFloatField;
    LimitsQueryCHM_REF_NR: TLargeintField;
    LimitsQueryCPARAMETER: TStringField;
    LimitsQueryLIMITS: TStringField;
    RLBand10: TRLBand;
    RLBand11: TRLBand;
    RLBand12: TRLBand;
    RLBandCharts: TRLBand;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLBand4: TRLBand;
    RLBand5: TRLBand;
    RLBand6: TRLBand;
    RLBand7: TRLBand;
    RLBand8: TRLBand;
    RLBand9: TRLBand;
    RLDBText16: TRLDBText;
    RLDBText17: TRLDBText;
    RLDBText27: TRLDBText;
    RLDBText28: TRLDBText;
    RLDBText29: TRLDBText;
    RLDBText30: TRLDBText;
    RLDBText31: TRLDBText;
    RLDBText32: TRLDBText;
    RLDBText33: TRLDBText;
    RLDBText34: TRLDBText;
    RLDBText35: TRLDBText;
    RLDBText36: TRLDBText;
    RLDBText37: TRLDBText;
    RLDBText38: TRLDBText;
    RLDBText39: TRLDBText;
    RLDBText40: TRLDBText;
    RLDBText41: TRLDBText;
    RLDBText42: TRLDBText;
    RLDBText43: TRLDBText;
    RLDBText44: TRLDBText;
    RLDBText45: TRLDBText;
    RLDBText46: TRLDBText;
    RLDBText47: TRLDBText;
    RLDBText48: TRLDBText;
    RLDBText49: TRLDBText;
    RLDBText50: TRLDBText;
    RLDBTextAG: TRLDBText;
    RLDBTextPD: TRLDBText;
    RLDBTextPT: TRLDBText;
    RLDBTextSE: TRLDBText;
    RLDBTextSN: TRLDBText;
    RLDBTextCE: TRLDBText;
    RLDBTextBR: TRLDBText;
    RLDBTextTA: TRLDBText;
    RLDBTextI: TRLDBText;
    RLDBTextTE: TRLDBText;
    RLDBTextTL: TRLDBText;
    RLDBTextU: TRLDBText;
    RLDBTextNB: TRLDBText;
    RLDBTextBE: TRLDBText;
    RLDBTextV: TRLDBText;
    RLDBTextW: TRLDBText;
    RLDBTextOXYGEN18: TRLDBText;
    RLDBTextMBAS: TRLDBText;
    RLDBTextLI: TRLDBText;
    RLDBTextLA: TRLDBText;
    RLDBTextRCARBON: TRLDBText;
    RLDBTextND: TRLDBText;
    RLDBTextAU: TRLDBText;
    RLDBTextTEMP: TRLDBText;
    RLDBTextCOD: TRLDBText;
    RLDBTextDOC: TRLDBText;
    RLDBTextDEUTERIUM: TRLDBText;
    RLDBTextTST: TRLDBText;
    RLDBTextODR: TRLDBText;
    RLDBTextKJED: TRLDBText;
    RLDBTextSUSP_SOLID: TRLDBText;
    RLDBTextSPECGRAV: TRLDBText;
    RLDBTextCOLR: TRLDBText;
    RLDBTextTUR: TRLDBText;
    RLDBTextTOT_THM: TRLDBText;
    RLDBTextTOC: TRLDBText;
    RLDBTextFAEC_STREP: TRLDBText;
    RLDBTextENT_VIRUS: TRLDBText;
    RLDBTextFAEC_ECOL: TRLDBText;
    RLDBTextSOAP: TRLDBText;
    RLDBTextCFR: TRLDBText;
    RLDBTextPHEN: TRLDBText;
    RLDBTextOIL: TRLDBText;
    RLDBTextDOX: TRLDBText;
    RLDBTextTRITIUM: TRLDBText;
    RLDBTextTVO: TRLDBText;
    RLDBTextPROTO_PARA: TRLDBText;
    RLDBTextECOL: TRLDBText;
    RLDBTextBOD: TRLDBText;
    RLDBTextSOM_COLI: TRLDBText;
    RLDBTextTOTAL_COL: TRLDBText;
    RLDBTextSR: TRLDBText;
    RLDBTextSPC: TRLDBText;
    RLDBTextTI: TRLDBText;
    RLDBTextCU: TRLDBText;
    RLDBTextMO: TRLDBText;
    RLDBTextSB: TRLDBText;
    RLDBTextB: TRLDBText;
    RLDBTextBI: TRLDBText;
    RLDBTextPB: TRLDBText;
    RLDBTextAL2: TRLDBText;
    RLDBTextCN: TRLDBText;
    RLDBTextCA2: TRLDBText;
    RLDBTextCL: TRLDBText;
    RLDBTextCO3: TRLDBText;
    RLDBTextNO2: TRLDBText;
    RLDBTextEC2: TRLDBText;
    RLDBTextF: TRLDBText;
    RLDBTextCR: TRLDBText;
    RLDBTextFE2: TRLDBText;
    RLDBTextHCO3: TRLDBText;
    RLDBTextBA: TRLDBText;
    RLDBTextK2: TRLDBText;
    RLDBTextMACID: TRLDBText;
    RLDBTextCO: TRLDBText;
    RLDBTextNI: TRLDBText;
    RLDBTextCD: TRLDBText;
    RLDBTextMALK2: TRLDBText;
    RLDBTextSULF: TRLDBText;
    RLDBTextMG2: TRLDBText;
    RLDBTextHG: TRLDBText;
    RLDBTextMN2: TRLDBText;
    RLDBTextN: TRLDBText;
    RLDBTextARSENIC: TRLDBText;
    RLDBTextNA2: TRLDBText;
    RLDBTextPACID: TRLDBText;
    RLDBTextPALK: TRLDBText;
    RLDBTextN_AMONIA: TRLDBText;
    RLDBTextPH2: TRLDBText;
    RLDBTextPH: TRLDBText;
    RLDBTextEC: TRLDBText;
    RLDBTextSI: TRLDBText;
    RLDBTextSO4: TRLDBText;
    RLDBTextTDS: TRLDBText;
    RLDBTextCA: TRLDBText;
    RLDBTextMG: TRLDBText;
    RLDBTextNA: TRLDBText;
    RLDBTextK: TRLDBText;
    RLDBTextFE: TRLDBText;
    RLDBTextMN: TRLDBText;
    RLDBTextAL: TRLDBText;
    RLDBTextMALK: TRLDBText;
    RLDBTextPO4: TRLDBText;
    RLDBTextTDS2: TRLDBText;
    RLDBTextH2S: TRLDBText;
    RLDBTextZR: TRLDBText;
    RLDBTextZN: TRLDBText;
    RLImage1: TRLImage;
    RLImage2: TRLImage;
    RLLabel10: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel21: TRLLabel;
    RLLabel31: TRLLabel;
    RLLabel32: TRLLabel;
    RLLabel33: TRLLabel;
    RLLabel34: TRLLabel;
    RLLabel35: TRLLabel;
    RLLabel36: TRLLabel;
    RLLabel37: TRLLabel;
    RLLabel38: TRLLabel;
    RLLabel39: TRLLabel;
    RLLabel40: TRLLabel;
    RLLabel41: TRLLabel;
    RLLabel42: TRLLabel;
    RLLabel43: TRLLabel;
    RLLabel44: TRLLabel;
    RLLabel45: TRLLabel;
    RLLabel46: TRLLabel;
    RLLabel47: TRLLabel;
    RLLabel48: TRLLabel;
    RLLabel49: TRLLabel;
    RLLabel50: TRLLabel;
    RLLabel51: TRLLabel;
    RLLabel52: TRLLabel;
    RLLabel53: TRLLabel;
    RLLabel62: TRLLabel;
    RLLabel63: TRLLabel;
    RLLabel64: TRLLabel;
    RLLabel80: TRLLabel;
    RLLabel81: TRLLabel;
    RLLabel82: TRLLabel;
    RLLabel84: TRLLabel;
    RLLabelAG: TRLLabel;
    RLLabelPD: TRLLabel;
    RLLabelAU: TRLLabel;
    RLLabelPT: TRLLabel;
    RLLabelSE: TRLLabel;
    RLLabelSN: TRLLabel;
    RLLabelCE: TRLLabel;
    RLLabelTA: TRLLabel;
    RLLabelI: TRLLabel;
    RLLabelTE: TRLLabel;
    RLLabelLA: TRLLabel;
    RLLabelTL: TRLLabel;
    RLLabelLI: TRLLabel;
    RLLabelBR: TRLLabel;
    RLLabelU: TRLLabel;
    RLLabelV: TRLLabel;
    RLLabelND: TRLLabel;
    RLLabelBE: TRLLabel;
    RLLabelW: TRLLabel;
    RLLabelOXYGEN18: TRLLabel;
    RLLabelMBAS: TRLLabel;
    RLLabelMicroParam2: TRLLabel;
    RLLabelRCARBON: TRLLabel;
    RLLabelStandParam2: TRLLabel;
    RLLabelStandParam3: TRLLabel;
    RLLabelTEMP: TRLLabel;
    RLLabelDEUTERIUM: TRLLabel;
    RLLabelTST: TRLLabel;
    RLLabelODR: TRLLabel;
    RLLabelMicroParam1: TRLLabel;
    RLLabelOrgParam: TRLLabel;
    RLLabelCOD: TRLLabel;
    RLLabelDOC: TRLLabel;
    RLLabelKJED: TRLLabel;
    RLLabelFAEC_ECOL: TRLLabel;
    RLLabelSUSP_SOLID: TRLLabel;
    RLLabelSPECGRAV: TRLLabel;
    RLLabelCOLR: TRLLabel;
    RLLabelTUR: TRLLabel;
    RLLabelTOT_THM: TRLLabel;
    RLLabelTOC: TRLLabel;
    RLLabelSOAP: TRLLabel;
    RLLabelCFR: TRLLabel;
    RLLabelSOM_COLI1: TRLLabel;
    RLLabelSPC: TRLLabel;
    RLLabelAddParam1: TRLLabel;
    RLLabelMicroParam: TRLLabel;
    RLLabelN: TRLLabel;
    RLLabel54: TRLLabel;
    RLLabel55: TRLLabel;
    RLLabel56: TRLLabel;
    RLLabel57: TRLLabel;
    RLLabel58: TRLLabel;
    RLLabel59: TRLLabel;
    RLLabel60: TRLLabel;
    RLLabel61: TRLLabel;
    RLLabelNH4: TRLLabel;
    RLLabelNH5: TRLLabel;
    RLLabelBOD: TRLLabel;
    RLLabelNO2: TRLLabel;
    RLLabelNO3: TRLLabel;
    RLLabelECOL: TRLLabel;
    RLLabelPO4: TRLLabel;
    RLLabel65: TRLLabel;
    RLLabel66: TRLLabel;
    RLLabel67: TRLLabel;
    RLLabel68: TRLLabel;
    RLLabel69: TRLLabel;
    RLLabel70: TRLLabel;
    RLLabel71: TRLLabel;
    RLLabel72: TRLLabel;
    RLLabel73: TRLLabel;
    RLLabel74: TRLLabel;
    RLLabel75: TRLLabel;
    RLLabel76: TRLLabel;
    RLLabel77: TRLLabel;
    RLLabel79: TRLLabel;
    RLLabelPO5: TRLLabel;
    RLLabelOIL: TRLLabel;
    RLLabelTOTAL_COL: TRLLabel;
    RLLabelStandParam: TRLLabel;
    RLLabelStandParam1: TRLLabel;
    RLLabelAddParam: TRLLabel;
    RLLabel83: TRLLabel;
    RLLabelFAEC_STREP: TRLLabel;
    RLLabelENT_VIRUS: TRLLabel;
    RLLabelDOX: TRLLabel;
    RLLabelTRITIUM: TRLLabel;
    RLLabelTVO: TRLLabel;
    RLLabelPROTO_PARA: TRLLabel;
    RLLabelSOM_COLI: TRLLabel;
    RLLabelNB: TRLLabel;
    RLLabelH2S: TRLLabel;
    RLLabelZR: TRLLabel;
    SubDetail1_1: TRLSubDetail;
    SubDetail2a: TRLSubDetail;
    SubDetail2b: TRLSubDetail;
    SubDetail6a: TRLSubDetail;
    SubDetail3a: TRLSubDetail;
    SubDetail4a: TRLSubDetail;
    SubDetail3b: TRLSubDetail;
    SubDetail5a: TRLSubDetail;
    SubDetail4b: TRLSubDetail;
    SubDetail5: TRLSubDetail;
    SubDetail5b: TRLSubDetail;
    SubDetail6b: TRLSubDetail;
    SubHeaderBand1: TRLBand;
    SubHeaderBand2: TRLBand;
    SubHeaderBand2_1: TRLBand;
    SubHeaderBand2_2: TRLBand;
    SubHeaderBand2_3: TRLBand;
    SubHeaderBand3: TRLBand;
    SubHeaderBand4: TRLBand;
    SubHeaderBand5: TRLBand;
    SubHeaderBand6: TRLBand;
    SubHeaderBand7: TRLBand;
    SubHeaderBand8: TRLBand;
    Chem1Query: TZReadOnlyQuery;
    LimitsQuery: TZReadOnlyQuery;
    Chem2Query: TZReadOnlyQuery;
    procedure BasicinfQueryAfterOpen(DataSet: TDataSet);
    procedure Chem0DataSourceDataChange(Sender: TObject; Field: TField);
    procedure Chem0QueryBeforeOpen(DataSet: TDataSet);
    procedure ChemQueryBeforeOpen(DataSet: TDataSet);
    procedure Chem1QueryECGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure ChemQueryAsNGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure ChemNoFactorGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure ChemQueryGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure LimitsQueryBeforeOpen(DataSet: TDataSet);
    procedure TheReportAfterPrint(Sender: TObject);
    procedure TimeGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure DateGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure TheReportBeforePrint(Sender: TObject; var PrintIt: boolean);
    procedure ViewDataSourceDataChange(Sender: TObject; Field: TField);
  private

  public
    StartDateTime, EndDateTime: TDateTime;
    CommentMemoFromBasic: Boolean;
  end;

var
  ChemReportForm: TChemReportForm;

implementation

{$R *.lfm}

uses varinit, StrDateTime, maindatamodule;

{ TChemReportForm }

procedure TChemReportForm.TheReportBeforePrint(Sender: TObject;
  var PrintIt: boolean);
begin
  inherited;
  //open standards tables
  LimitsQuery.Open;
  //Labels
  RLLabel20.Caption := RLLabel20.Caption + ' [' + LengthUnit + ']';
  RLLabel40.Caption := RLLabel40.Caption + ' [' + ECUnit + ']';
  RLLabelStandParam.Caption := RLLabelStandParam.Caption + ' - in ' + ChemUnit + ', where applicable';
  RLLabelStandParam1.Caption := RLLabelStandParam1.Caption + ' - in ' + ChemUnit;
  RLLabelAddParam.Caption := RLLabelAddParam.Caption + ' - in ' + ChemUnit;
  RLLabelAddParam1.Caption := RLLabelAddParam1.Caption + ' - in ' + ChemUnit;
  RLLabelMicroParam.Caption := RLLabelMicroParam.Caption + ' - in counts/100ml, unless specified otherwise';
  RLLabelOrgParam.Caption := RLLabelOrgParam.Caption + ' - in ' + ChemUnit;
  if AsN then
  begin
    RLLabelN.Caption := 'NO3 as N';
    RLLabelNH4.Caption := 'NH4 as N';
    RLLabelNO2.Caption := 'NO2 as N';
    RLLabelPO4.Caption := 'PO4 as P';
  end
  else
  begin
    RLLabelN.Caption := 'NO3';
    RLLabelNH4.Caption := 'NH4';
    RLLabelNO2.Caption := 'NO2';
    RLLabelPO4.Caption := 'PO4';
  end;
  RLLabelBOD.Caption := RLLabelBOD.Caption + ' [' + ChemUnit + ']';
  RLLabelSUSP_SOLID.Caption := RLLabelSUSP_SOLID.Caption + ' [' + ChemUnit + ']';
  //charts
  RLBandCharts.Visible := (Cht1Tag > -1) or (Cht2Tag > -1);
  if RLBandCharts.Visible then
  begin
    if Cht1Tag > - 1 then //show left chart
      RLImage1.Picture.LoadFromFile(GetTempDir + DirectorySeparator + 'chemchart' + IntToStr(Cht1Tag) + '.jpg')
    else
    begin
      RLImage1.Visible := False;
      RLImage2.Borders.DrawRight := False;
      RLImage2.Align := faCenter;
    end;
    if Cht2Tag > - 1 then //show right chart
      RLImage2.Picture.LoadFromFile(GetTempDir + DirectorySeparator + 'chemchart' + IntToStr(Cht2Tag) + '.jpg')
    else
    begin
      RLImage2.Visible := False;
      RLImage1.Borders.DrawLeft := False;
      RLImage1.Align := faCenter;
    end;
  end;
end;

procedure TChemReportForm.ViewDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if (Field = NIL) and NewSite then
  begin
    Chem0Query.Close;
    Chem0Query.Open;
  end;
end;

procedure TChemReportForm.Chem0QueryBeforeOpen(DataSet: TDataSet);
begin
  with DataSet as TZReadOnlyQuery do
  begin
    Connection := DataModuleMain.ZConnectionDB;
    SQL.Clear;
    SQL.Add('SELECT * FROM chem_000 WHERE site_id_nr = ' + QuotedStr(BasicinfQuerySITE_ID_NR.Value));
    SQL.Add('AND');
    if Connection.Tag = 1 then
    begin
      SQL.Add('DATE_SAMPL || TIME_SAMPL >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', StartDateTime)));
      SQL.Add('AND DATE_SAMPL || TIME_SAMPL <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', EndDateTime)));
    end
    else
    begin
      SQL.Add('CONCAT(DATE_SAMPL, TIME_SAMPL) >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', StartDateTime)));
      SQL.Add('AND CONCAT(DATE_SAMPL, TIME_SAMPL) <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', EndDateTime)));
    end;
  end;
end;

procedure TChemReportForm.Chem0DataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  if Field = NIL then
  begin
    Chem1Query.Close;
    Chem1Query.Active := SubDetail2a.Visible;
    Chem2Query.Close;
    Chem2Query.Active := SubDetail3a.Visible;
    Chem3Query.Close;
    Chem3Query.Active := SubDetail4a.Visible;
    Chem4Query.Close;
    Chem4Query.Active := SubDetail5a.Visible;
    Chem5Query.Close;
    Chem5Query.Active := SubDetail6a.Visible;
  end;
end;

procedure TChemReportForm.BasicinfQueryAfterOpen(DataSet: TDataSet);
begin
  SiteID := BasicinfQuerySITE_ID_NR.Value;
end;

procedure TChemReportForm.ChemQueryBeforeOpen(DataSet: TDataSet);
begin
  with DataSet as TZReadOnlyQuery do
  begin
    Connection := DataModuleMain.ZConnectionDB;
    Params[0].Value := Chem0QueryCHM_REF_NR.Value;
  end;
end;

procedure TChemReportForm.Chem1QueryECGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
var
  Limit: ShortString;
begin
  if LimitsQuery.Locate('CPARAMETER', Sender.FieldName, []) then
    Limit := LimitsQueryLIMITS.AsString + ' '
  else
    Limit := '';
  if (Sender.Value <> -1) and (not Sender.IsNull) then
  begin
    aText := Limit + FloatToStrF(Sender.AsFloat * ECFactor, ffFixed, 15, 2);
    if DataModuleMain.ClassTable.Active then
    begin
      if DataModuleMain.ClassTable.Locate('PARAMETER', Sender.FieldName, []) then
        RLDBTextEC.Font := DataModuleMain.GetFont(Sender.Value)
      else RLDBTextEC.Font := AppFont;
    end
    else
    begin
      if DataModuleMain.StandardTable.Locate('PARAMETER', Sender.FieldName, []) then
        RLDBTextEC.Font := DataModuleMain.GetFont(Sender.Value)
      else RLDBTextEC.Font := AppFont;
    end;
  end
  else DisplayText := False;
end;

procedure TChemReportForm.ChemQueryAsNGetText(Sender: TField; var aText: string;
  DisplayText: Boolean);
var
  Limit: ShortString;
begin
  if (not Sender.IsNull) and (Sender.Value > -1) then
  begin
    if LimitsQuery.Locate('CPARAMETER', Sender.FieldName, []) then
      Limit := LimitsQueryLIMITS.AsString + ' '
    else
      Limit := '';
    if AsN then
      aText := Limit + DataModuleMain.FormatTheFloat(Sender.AsFloat * ChemFactor)
    else
      aText := Limit + DataModuleMain.FormatTheFloat(Sender.AsFloat * ParamFactor[Sender.Tag] * ChemFactor);
    if DataModuleMain.ClassTable.Active then
    begin
      if DataModuleMain.ClassTable.Locate('PARAMETER', Sender.FieldName, []) then
        TRLDBText(FindComponent('RLDBText' + Sender.FieldName)).Font := DataModuleMain.GetFont(Sender.Value)
      else TRLDBText(FindComponent('RLDBText' + Sender.FieldName)).Font := AppFont;
    end
    else
    begin
      if DataModuleMain.StandardTable.Locate('PARAMETER', Sender.FieldName, []) then
        TRLDBText(FindComponent('RLDBText' + Sender.FieldName)).Font := DataModuleMain.GetFont(Sender.Value)
      else TRLDBText(FindComponent('RLDBText' + Sender.FieldName)).Font := AppFont;
    end;
  end
  else DisplayText := False;
end;

procedure TChemReportForm.ChemNoFactorGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
var
  Limit: ShortString;
begin
  if (Sender.Value <> -1) and (not Sender.IsNull) then
  begin
    if LimitsQuery.Locate('CPARAMETER', Sender.FieldName, []) then
      Limit := LimitsQueryLIMITS.AsString + ' '
    else
      Limit := '';
    if Sender.FieldDef.DataType = ftLargeint then
      aText := Limit + FloatToStrF(Sender.AsFloat, ffFixed, 15, 0)
    else
      aText := Limit + DataModuleMain.FormatTheFloat(Sender.Value);
    if DataModuleMain.ClassTable.Active then
    begin
      if DataModuleMain.ClassTable.Locate('PARAMETER', Sender.FieldName, []) then
        (FindComponent('RLDBText' + Sender.FieldName) as TRLDBText).Font := DataModuleMain.GetFont(Sender.Value)
      else
      if Sender.FieldName = 'PH' then
      begin
        if Sender.Value >= 7 then
        begin
          DataModuleMain.ClassTable.Locate('PARAMETER', 'PHU', []);
          RLDBTextPH.Font := DataModuleMain.GetFont(Sender.Value);
        end
        else
        begin
          DataModuleMain.ClassTable.Locate('PARAMETER', 'PHL', []);
          RLDBTextPH.Font := DataModuleMain.GetFont(-Sender.Value);
        end;
      end
      else
        (FindComponent('RLDBText' + Sender.FieldName) as TRLDBText).Font := AppFont;
    end
    else
    begin
      if DataModuleMain.StandardTable.Locate('PARAMETER', Sender.FieldName, []) then
        (FindComponent('RLDBText' + Sender.FieldName) as TRLDBText).Font := DataModuleMain.GetFont(Sender.Value)
      else
        (FindComponent('RLDBText' + Sender.FieldName) as TRLDBText).Font := AppFont;
    end;
  end
  else DisplayText := False;
end;

procedure TChemReportForm.ChemQueryGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
var
  Limit: ShortString;
begin
  if (Sender.Value <> -1) and (not Sender.IsNull) then
  begin
    if LimitsQuery.Locate('CPARAMETER', Sender.FieldName, []) then
      Limit := LimitsQueryLIMITS.AsString + ' '
    else
      Limit := '';
    aText := Limit + DataModuleMain.FormatTheFloat(Sender.Value * ChemFactor);
    if DataModuleMain.ClassTable.Active then
    begin
      if DataModuleMain.ClassTable.Locate('PARAMETER', Sender.FieldName, []) then
        (FindComponent('RLDBText' + Sender.FieldName) as TRLDBText).Font := DataModuleMain.GetFont(Sender.Value)
      else
        (FindComponent('RLDBText' + Sender.FieldName) as TRLDBText).Font := AppFont;
    end
    else
    begin
      if DataModuleMain.StandardTable.Locate('PARAMETER', Sender.FieldName, []) then
        (FindComponent('RLDBText' + Sender.FieldName) as TRLDBText).Font := DataModuleMain.GetFont(Sender.Value)
      else
        (FindComponent('RLDBText' + Sender.FieldName) as TRLDBText).Font := AppFont;
    end;
  end
  else DisplayText := False;
end;

procedure TChemReportForm.LimitsQueryBeforeOpen(DataSet: TDataSet);
begin
  LimitsQuery.Connection := DataModuleMain.ZConnectionDB;
end;

procedure TChemReportForm.TheReportAfterPrint(Sender: TObject);
begin
  Chem5Query.Close;
  Chem4Query.Close;
  Chem3Query.Close;
  Chem2Query.Close;
  Chem1Query.Close;
  Chem0Query.Close;
  LimitsQuery.Close;
  BasicinfQuery.Close;
  ViewQuery.Close;
end;

procedure TChemReportForm.TimeGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull or (Sender.AsString = '') then
    DisplayText := False
  else
    aText := FormatDateTime('hh:nn', EncodeTime(StrToInt(Copy(Sender.AsString, 1, 2)), StrToInt(Copy(Sender.AsString, 3, 2)), 0, 0));
end;

procedure TChemReportForm.DateGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    DisplayText := False
  else
    aText := DateToStr(StringToDate(Sender.AsString));
end;

end.

