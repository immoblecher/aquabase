{ Copyright (C) 2021 Immo Blecher, immo@blecher.co.za

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
unit chartproperties;

{$mode objfpc}{$H+}

interface

uses SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, Buttons, ComCtrls,
  ExtCtrls, Spin, Dialogs, ExtDlgs, maskedit, PrintersDlgs, TAGraph, TASeries,
  TACustomSeries, TALegend, TAChartAxis, TAChartAxisUtils, TAChartUtils, TACustomSource,
  TATypes, TATransformations, TAIntervalSources, OSPrinters, Printers, LCLType,
  XMLPropStorage, ButtonPanel, DateTimePicker, Types, Printer4Lazarus, TypInfo,
  TAMultiSeries;

type

  { TChartPropDlg }

  TChartPropDlg = class(TForm)
    BottomAxisPageControl: TPageControl;
    ButtonApplyFormat: TButton;
    ButtonApplySeriesTitle: TButton;
    ButtonLinePen: TButton;
    CheckBoxMarksVisible: TCheckBox;
    CheckBoxOnSidePanel: TCheckBox;
    CheckBoxShowLines: TCheckBox;
    CheckBoxShowSeries: TCheckBox;
    CheckBoxBATitleVisible: TCheckBox;
    CheckBoxRATitleVisible: TCheckBox;
    CheckBoxTATitleVisible: TCheckBox;
    CheckBoxArrowsVisible: TCheckBox;
    CheckBoxLATitleVisible: TCheckBox;
    ColorButtonBATitleFont: TColorButton;
    ColorButtonTATitleFont: TColorButton;
    ColorButtonRATitleFont: TColorButton;
    ColorButtonTitlesFont: TColorButton;
    ColorButtonTitleBkgrCol: TColorButton;
    ColorButtonPntsBrush: TColorButton;
    ColorButtonLATitleFont: TColorButton;
    ComboBoxTAValueFormat: TComboBox;
    ComboBoxLAValueFormat: TComboBox;
    ComboBoxBAValueFormat: TComboBox;
    ComboBoxRAValueFormat: TComboBox;
    EditLASteps: TEdit;
    EditBASteps: TEdit;
    EditTASteps: TEdit;
    EditRASteps: TEdit;
    EditDTFormatBot: TEdit;
    EditDTFormatTop: TEdit;
    EditFormatLegend: TEdit;
    EditSeriesTitle: TEdit;
    Label26: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    LabelSeriesTitle: TLabel;
    PointsBrushComboBox: TComboBox;
    CheckBoxShowPoints: TCheckBox;
    SpinEditColumns: TSpinEdit;
    SpinEditTADigits: TSpinEdit;
    SpinEditLADigits: TSpinEdit;
    SpinEditBADigits: TSpinEdit;
    SpinEditRADigits: TSpinEdit;
    TopAxisPageControl: TPageControl;
    ButtonTAFont: TButton;
    ButtonTAGridBorder: TButton;
    ButtonTAMarksFont: TButton;
    ButtonTARangesApply: TButton;
    ButtonTATicksMinors: TButton;
    ButtonTATitleApply: TButton;
    ButtonTATRangesApply: TButton;
    ButtonTopAxisPen: TButton;
    ButtonData: TButton;
    ButtonBATRangesApply: TButton;
    ButtonMarksBorder: TButton;
    ButtonMarksBorder1: TButton;
    ButtonMarksFont: TButton;
    ButtonPrint: TButton;
    ButtonLATicksGridBorder: TButton;
    ButtonRAApply: TButton;
    ButtonLATicksMinors: TButton;
    ButtonTitleFont: TButton;
    ButtonTitleBorder: TButton;
    ButtonLegendFont: TButton;
    ButtonBorderLegend: TButton;
    ButtonExport: TButton;
    ButtonRATitleFont: TButton;
    ButtonRAMarksFont: TButton;
    ButtonRATicksGridBorder: TButton;
    Button27: TButton;
    ButtonBARangesApply: TButton;
    ButtonBAFont: TButton;
    ButtonBATitleApply: TButton;
    ButtonBAMarksFont: TButton;
    ButtonLARangesApply: TButton;
    ButtonTitleApply: TButton;
    ButtonLATitleApply: TButton;
    ButtonBAGridBorder: TButton;
    ButtonRATitleApply: TButton;
    ButtonBATicksMinors: TButton;
    ButtonBarBorder: TButton;
    ButtonAxisTitleFont: TButton;
    ButtonAxisFont: TButton;
    ButtonBottomAxisPen: TButton;
    ButtonLeftAxisPen: TButton;
    ButtonRightAxisPen: TButton;
    ButtonPanel1: TButtonPanel;
    CheckBoxTAInverted: TCheckBox;
    CheckBoxTALog: TCheckBox;
    CheckBoxTAMarksClipped: TCheckBox;
    CheckBoxTAMarksAtData: TCheckBox;
    CheckBoxTAMarksVisible: TCheckBox;
    CheckBoxTAScalesAuto: TCheckBox;
    CheckBoxBATScalesAuto: TCheckBox;
    CheckBoxTATScalesAuto: TCheckBox;
    CheckBoxTopAxisVisible: TCheckBox;
    CheckBoxLAMarksClipped: TCheckBox;
    CheckBoxMarksClipped: TCheckBox;
    CheckBoxTitleVisible: TCheckBox;
    CheckBoxRAMarksClipped: TCheckBox;
    CheckBoxRALog: TCheckBox;
    CheckBoxLegendVisible: TCheckBox;
    CheckBoxRAInverted: TCheckBox;
    CheckBoxRAMarksVisible: TCheckBox;
    CheckBoxRAMarksAtData: TCheckBox;
    CheckBoxNoBackColour: TCheckBox;
    CheckBoxBAScalesAuto: TCheckBox;
    CheckBoxBALog: TCheckBox;
    CheckBoxBAInverted: TCheckBox;
    CheckBoxShowInLegend: TCheckBox;
    CheckBoxBAMarksClipped: TCheckBox;
    CheckBoxBAMarksVisible: TCheckBox;
    CheckBoxLAScalesAuto: TCheckBox;
    CheckBoxBAMarksAtData: TCheckBox;
    CheckBoxRAScalesAuto: TCheckBox;
    CheckBoxLALog: TCheckBox;
    CheckBoxLAInverted: TCheckBox;
    CheckBoxLAMarksVisible: TCheckBox;
    CheckBoxLAMarksAtData: TCheckBox;
    CheckBoxBottomAxisVisible: TCheckBox;
    CheckBoxLeftAxisVisible: TCheckBox;
    CheckBoxRightAxisVisible: TCheckBox;
    ColorButtonBarColour: TColorButton;
    ColorButtonTATicks: TColorButton;
    ColorButtonLegendBack: TColorButton;
    ColorButtonRATicks: TColorButton;
    ColorButtonBATicks: TColorButton;
    ColorButtonLATicks: TColorButton;
    ColorButtonMarksBackground: TColorButton;
    ColorButtonBack: TColorButton;
    ColorButtonPanel: TColorButton;
    ColorDialog1: TColorDialog;
    ComboBoxMarksStyle: TComboBox;
    ComboBoxTitles: TComboBox;
    ComboBoxSeries: TComboBox;
    EditTAMax: TEdit;
    EditTAMin: TEdit;
    EditTATitle: TEdit;
    EditLATitle: TEdit;
    EditRAMax: TEdit;
    EditRAMin: TEdit;
    EditRATitle: TEdit;
    EditLAMin: TEdit;
    EditLAMax: TEdit;
    EditBAMax: TEdit;
    EditBAMin: TEdit;
    EditBATitle: TEdit;
    TAEndDateTimePicker: TDateTimePicker;
    GroupBox17: TGroupBox;
    GroupBox9: TGroupBox;
    GroupBoxTAScales: TGroupBox;
    GroupBoxTATScales: TGroupBox;
    GroupBoxArrows: TGroupBox;
    GroupBoxBATScales: TGroupBox;
    GroupBoxLAScales: TGroupBox;
    GroupBox13: TGroupBox;
    GroupBoxBAScales: TGroupBox;
    GroupBox16: TGroupBox;
    GroupBoxRAScales: TGroupBox;
    GroupBox18: TGroupBox;
    GroupBoxMargins: TGroupBox;
    GroupBoxPoints: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label6: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label69: TLabel;
    Label7: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LALabelsTab: TTabSheet;
    RAMarksTab: TTabSheet;
    LAScalesTab: TTabSheet;
    RAScalesTab: TTabSheet;
    LATicksTab: TTabSheet;
    RATicksTab: TTabSheet;
    LATitleTab: TTabSheet;
    RATitleTab: TTabSheet;
    LeftAxisPageControl: TPageControl;
    PageControlSeries: TPageControl;
    ComboBoxTitleBrush: TComboBox;
    Memo1: TMemo;
    PageControl1: TPageControl;
    PageControlAxes: TPageControl;
    FontDialog: TFontDialog;
    OpenPictureDialog1: TOpenPictureDialog;
    PointsBorderButton: TButton;
    PointsHeightSpinEdit: TSpinEdit;
    PointsStyleComboBox: TComboBox;
    PointsWidthSpinEdit: TSpinEdit;
    PrintDialog1: TPrintDialog;
    RadioGroupTitles: TRadioGroup;
    RadioGroupLegendPos: TRadioGroup;
    RadioGroupHorAxis: TRadioGroup;
    RadioGroupVertAxis: TRadioGroup;
    RightAxisPageControl: TPageControl;
    SaveDialog1: TSaveDialog;
    SpinEditArrowWidth: TSpinEdit;
    SpinEditTAMarksAngle: TSpinEdit;
    SpinEditTAMarksSize: TSpinEdit;
    SpinEditTATicksInnerLength: TSpinEdit;
    SpinEditTATicksLength: TSpinEdit;
    SpinEditTATicksMinorsCount: TSpinEdit;
    SpinEditTATicksMinorsLength: TSpinEdit;
    SpinEditTATitleAngle: TSpinEdit;
    SpinEditTATitleSize: TSpinEdit;
    SpinEditMarksDistance: TSpinEdit;
    SpinEditLAMarksAngle: TSpinEdit;
    SpinEditLATicksLength: TSpinEdit;
    SpinEditLATicksInnerLength: TSpinEdit;
    SpinEditLATicksMinorsLength: TSpinEdit;
    SpinEditLATicksMinorsCount: TSpinEdit;
    SpinEditRATitleAngle: TSpinEdit;
    SpinEditLegendX: TSpinEdit;
    SpinEditLegendY: TSpinEdit;
    SpinEditRATitleSize: TSpinEdit;
    SpinEditMarginTop: TSpinEdit;
    SpinEditRAMarksSize: TSpinEdit;
    SpinEditRAMarksAngle: TSpinEdit;
    SpinEditRATicksLength: TSpinEdit;
    SpinEditBATitleAngle: TSpinEdit;
    SpinEditBATitleSize: TSpinEdit;
    SpinEditArrowLength: TSpinEdit;
    SpinEditMarginLeft: TSpinEdit;
    SpinEditBAMarksSize: TSpinEdit;
    SpinEditBAMarksAngle: TSpinEdit;
    SpinEditBATicksLength: TSpinEdit;
    SpinEditBATicksInnerLength: TSpinEdit;
    SpinEditMarginBottom: TSpinEdit;
    SpinEditBATicksMinorsLength: TSpinEdit;
    SpinEditBATicksMinorsCount: TSpinEdit;
    SpinEditBarOffset: TSpinEdit;
    SpinEditBarWidth: TSpinEdit;
    SpinEditRATicksInnerLength: TSpinEdit;
    SpinEditRATicksMinorsLength: TSpinEdit;
    SpinEditRATicksMinorsCount: TSpinEdit;
    SpinEditMarginRight: TSpinEdit;
    SpinEditLATitleAngle: TSpinEdit;
    SpinEditLATitleSize: TSpinEdit;
    SpinEditLAMarksSize: TSpinEdit;
    BAEndDateTimePicker: TDateTimePicker;
    TAStartDateTimePicker: TDateTimePicker;
    TabSheetTop: TTabSheet;
    TabSheetLabels1: TTabSheet;
    TabSheetTAScales: TTabSheet;
    TabSheetTicks1: TTabSheet;
    TabSheetBATimeScales: TTabSheet;
    TabSheetFormatBar: TTabSheet;
    TabSheetFormatLine: TTabSheet;
    TabSheetSeriesGeneral: TTabSheet;
    TabSheetMarks: TTabSheet;
    TabSheetAxes: TTabSheet;
    TabSheetBottom: TTabSheet;
    TabSheetGeneral: TTabSheet;
    TabSheetBALabels: TTabSheet;
    TabSheetLeft: TTabSheet;
    TabsheetLegend: TTabSheet;
    TabSheetRight: TTabSheet;
    TabSheetBAScales: TTabSheet;
    TabSheetSeries: TTabSheet;
    TabSheetBATicks: TTabSheet;
    TabSheetTATimeScales: TTabSheet;
    TabSheetBATitle: TTabSheet;
    TabSheetTATitle: TTabSheet;
    TabsheetTitles: TTabSheet;
    XMLPropStorage1: TXMLPropStorage;
    BAStartDateTimePicker: TDateTimePicker;
    procedure BottomAxisPageControlChange(Sender: TObject);
    procedure ButtonAxisFontClick(Sender: TObject);
    procedure ButtonApplyFormatClick(Sender: TObject);
    procedure ButtonApplySeriesTitleClick(Sender: TObject);
    procedure ButtonDataClick(Sender: TObject);
    procedure ButtonTATRangesApplyClick(Sender: TObject);
    procedure ButtonExportClick(Sender: TObject);
    procedure ButtonLATitleApplyClick(Sender: TObject);
    procedure ButtonLeftTimeAxisFrameClick(Sender: TObject);
    procedure ButtonTARangesApplyClick(Sender: TObject);
    procedure ButtonTATitleApplyClick(Sender: TObject);
    procedure CheckBoxArrowsVisibleChange(Sender: TObject);
    procedure CheckBoxAxisVisibleChange(Sender: TObject);
    procedure CheckBoxInvertedChange(Sender: TObject);
    procedure CheckBoxAxisTitleVisibleChange(Sender: TObject);
    procedure CheckBoxMarksAtDataChange(Sender: TObject);
    procedure CheckBoxLogChange(Sender: TObject);
    procedure CheckBoxBAScalesAutoChange(Sender: TObject);
    procedure CheckBoxBATScalesAutoChange(Sender: TObject);
    procedure CheckBoxMarksClippedChange(Sender: TObject);
    procedure CheckBoxMarksVisibleChange(Sender: TObject);
    procedure CheckBoxOnSidePanelChange(Sender: TObject);
    procedure CheckBoxRAScalesAutoChange(Sender: TObject);
    procedure CheckBoxShowInLegendChange(Sender: TObject);
    procedure CheckBoxShowLinesChange(Sender: TObject);
    procedure CheckBoxShowPointsChange(Sender: TObject);
    procedure CheckBoxShowSeriesChange(Sender: TObject);
    procedure CheckBoxTAMarksClippedChange(Sender: TObject);
    procedure CheckBoxTAScalesAutoChange(Sender: TObject);
    procedure CheckBoxTATScalesAutoChange(Sender: TObject);
    procedure CheckBoxTitleVisibleChange(Sender: TObject);
    procedure ColorButtonAxisTitleFontColorChanged(Sender: TObject);
    procedure ColorButtonTitlesFontClick(Sender: TObject);
    procedure ColorButtonBarColourClick(Sender: TObject);
    procedure ColorButtonClick(Sender: TObject);
    procedure ColorButtonPntsBrushColorChanged(Sender: TObject);
    procedure ColorButtonTitleBkgrColClick(Sender: TObject);
    procedure ColorButtonTitleBkgrColColorChanged(Sender: TObject);
    procedure ColorButtonTitlesFontColorChanged(Sender: TObject);
    procedure RAValueFormatChange(Sender: TObject);
    procedure LAValueFormatChange(Sender: TObject);
    procedure ComboBoxMarksStyleChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    procedure LinkPenBorderClick(Sender: TObject);
    procedure ButtonRAApplyClick(Sender: TObject);
    procedure ButtonRATitleApplyClick(Sender: TObject);
    procedure CheckBoxLAScalesAutoChange(Sender: TObject);
    procedure CheckBoxLegendVisibleChange(Sender: TObject);
    procedure ColorButtonBarColourColorChanged(Sender: TObject);
    procedure ColorButtonLegendBackChanged(Sender: TObject);
    procedure ColorButtonTicksColorChanged(Sender: TObject);
    procedure ColorButtonBackColorChanged(Sender: TObject);
    procedure ColorButtonMarksBackgroundColorChanged(Sender: TObject);
    procedure ColorButtonPanelColorChanged(Sender: TObject);
    procedure ComboBoxTitleBrushChange(Sender: TObject);
    procedure EditMarksValueFormatChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure LeftAxisPageControlChange(Sender: TObject);
    procedure PageControlAxesChange(Sender: TObject);
    procedure RadioGroupHorAxisClick(Sender: TObject);
    procedure RadioGroupVertAxisClick(Sender: TObject);
    procedure RightAxisPageControlChange(Sender: TObject);
    procedure SpinEditArrowWidthChange(Sender: TObject);
    procedure SpinEditColumnsChange(Sender: TObject);
    procedure SpinEditMarginTopChange(Sender: TObject);
    procedure SpinEditMarginLeftChange(Sender: TObject);
    procedure SpinEditMarginBottomChange(Sender: TObject);
    procedure SpinEditMarginRightChange(Sender: TObject);
    procedure CheckBox12Click(Sender: TObject);
    procedure CheckBoxNoBackColourClick(Sender: TObject);
    procedure ButtonTitleFontClick(Sender: TObject);
    procedure ComboBoxTitlesChange(Sender: TObject);
    procedure ButtonLinePenClick(Sender: TObject);
    procedure ButtonTitleBorderClick(Sender: TObject);
    procedure ButtonBorderLegendClick(Sender: TObject);
    procedure PointsStyleComboBoxChange(Sender: TObject);
    procedure PointsBorderButtonClick(Sender: TObject);
    procedure PointsWidthSpinEditChange(Sender: TObject);
    procedure PointsHeightSpinEditChange(Sender: TObject);
    procedure ButtonMarksFontClick(Sender: TObject);
    procedure ButtonMarksBorderClick(Sender: TObject);
    procedure SpinEditArrowLengthChange(Sender: TObject);
    procedure RadioGroupTitlesClick(Sender: TObject);
    procedure ButtonTitleApplyClick(Sender: TObject);
    procedure ButtonLARangesApplyClick(Sender: TObject);
    procedure ButtonBATRangesApplyClick(Sender: TObject);
    procedure PointsBrushComboBoxChange(Sender: TObject);
    procedure ButtonTicksGridBorderClick(Sender: TObject);
    procedure ButtonTicksMinorsClick(Sender: TObject);
    procedure ButtonAxisPenClick(Sender: TObject);
    procedure SpinEditMarksDistanceChange(Sender: TObject);
    procedure SpinEditTicksLengthChange(Sender: TObject);
    procedure SpinEditTicksInnerLengthChange(Sender: TObject);
    procedure SpinEditTicksMinorsLengthChange(Sender: TObject);
    procedure SpinEditTicksMinorsCountChange(Sender: TObject);
    procedure SpinEditTitleAngleChange(Sender: TObject);
    procedure ButtonAxisTitleFontClick(Sender: TObject);
    procedure SpinEditTitleSizeChange(Sender: TObject);
    procedure CheckBoxMarksVisibleClick(Sender: TObject);
    procedure Button42Click(Sender: TObject);
    procedure SpinEditMarksSizeChange(Sender: TObject);
    procedure SpinEditMarksAngleChange(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ButtonLegendFontClick(Sender: TObject);
    procedure RadioGroupLegendPosClick(Sender: TObject);
    procedure SpinEditLegendXChange(Sender: TObject);
    procedure SpinEditLegendYChange(Sender: TObject);
    procedure ButtonPrintClick(Sender: TObject);
    procedure ComboBoxSeriesChange(Sender: TObject);
    procedure SpinEditBarWidthChange(Sender: TObject);
    procedure SpinEditBarOffsetChange(Sender: TObject);
    procedure ButtonBARangesApplyClick(Sender: TObject);
    procedure ButtonBATitleApplyClick(Sender: TObject);
    procedure ButtonBABorderClick(Sender: TObject);
    procedure ButtonBarBorderClick(Sender: TObject);
  private
    { Private declarations }
    ClrBtnClkd: Boolean;
    LAMax, LAMin, RAMax, RAMin: Real;
  public
    { Public declarations }
    XisDateTime: Boolean;
    TempChart: TChart;
    TempLogAxis: Array[0..3] of TLogarithmAxisTransform;
  end;

implementation

uses Border, VARINIT, MainDataModule, editchartdata;

{$R *.lfm}

var FFormatSettings: TFormatSettings;

procedure TChartPropDlg.SpinEditMarginTopChange(Sender: TObject);
begin
  TempChart.Margins.Top := SpinEditMarginTop.Value;
end;

procedure TChartPropDlg.FormCreate(Sender: TObject);
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, True);
end;

procedure TChartPropDlg.LeftAxisPageControlChange(Sender: TObject);
begin
  if TPageControl(Sender).ActivePageIndex = 3 then //Ticks page
  begin
    SpinEditLATicksMinorsLength.Enabled := TempChart.LeftAxis.Minors.Count > 0;
    SpinEditLATicksMinorsCount.Enabled := TempChart.LeftAxis.Minors.Count > 0;
  end;
end;

procedure TChartPropDlg.PageControlAxesChange(Sender: TObject);
begin

end;

procedure TChartPropDlg.RadioGroupHorAxisClick(Sender: TObject);
begin
  if TempChart.Series[ComboBoxSeries.ItemIndex] is TLineSeries then
  begin
    if RadioGroupVertAxis.ItemIndex = 0 then
      (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineSeries).AxisIndexX := 3
    else
      (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineSeries).AxisIndexX := 1;
  end
  else
  if TempChart.Series[ComboBoxSeries.ItemIndex] is TBarSeries then
  begin
    if RadioGroupVertAxis.ItemIndex = 0 then
      (TempChart.Series[ComboBoxSeries.ItemIndex] as TBarSeries).AxisIndexX := 3
    else
      (TempChart.Series[ComboBoxSeries.ItemIndex] as TBarSeries).AxisIndexX := 1;
  end;
end;

procedure TChartPropDlg.RadioGroupVertAxisClick(Sender: TObject);
begin
  if TempChart.Series[ComboBoxSeries.ItemIndex] is TLineSeries then
  begin
    if RadioGroupVertAxis.ItemIndex = 0 then
      (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineSeries).AxisIndexY := 0
    else
      (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineSeries).AxisIndexY := 2;
  end
  else
  if TempChart.Series[ComboBoxSeries.ItemIndex] is TBarSeries then
  begin
    if RadioGroupVertAxis.ItemIndex = 0 then
      (TempChart.Series[ComboBoxSeries.ItemIndex] as TBarSeries).AxisIndexY := 0
    else
      (TempChart.Series[ComboBoxSeries.ItemIndex] as TBarSeries).AxisIndexY := 2;
  end;
end;

procedure TChartPropDlg.RightAxisPageControlChange(Sender: TObject);
begin
  if TPageControl(Sender).ActivePageIndex = 3 then //Ticks page
  begin
    SpinEditRATicksMinorsLength.Enabled := TempChart.AxisList[2].Minors.Count > 0;
    SpinEditRATicksMinorsCount.Enabled := TempChart.AxisList[2].Minors.Count > 0;
  end;
end;

procedure TChartPropDlg.SpinEditArrowWidthChange(Sender: TObject);
begin
  if (TempChart.Series[ComboBoxSeries.ItemIndex] is TLineSeries) then
    (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineSeries).Marks.Arrow.Width := (Sender as TSpinEdit).Value
  else
  if (TempChart.Series[ComboBoxSeries.ItemIndex] is TBarSeries) then
    (TempChart.Series[ComboBoxSeries.ItemIndex] as TBarSeries).Marks.Arrow.Width := (Sender as TSpinEdit).Value
end;

procedure TChartPropDlg.SpinEditColumnsChange(Sender: TObject);
begin
  TempChart.Legend.ColumnCount := SpinEditColumns.Value;
end;

procedure TChartPropDlg.ButtonExportClick(Sender: TObject);
begin
  SaveDialog1.InitialDir := WSpaceDir;
  if SaveDialog1.Execute then
    TempChart.SaveToBitmapFile(SaveDialog1.FileName);
end;

procedure TChartPropDlg.ButtonLATitleApplyClick(Sender: TObject);
begin
  TempChart.AxisList[0].Title.Caption := EditLATitle.Text;
  TempChart.Repaint;
end;

procedure TChartPropDlg.ButtonApplyFormatClick(Sender: TObject);
begin
  (TempChart.Series[ComboBoxSeries.ItemIndex] as TCustomChartSeries).Legend.Format := EditFormatLegend.Text;
end;

procedure TChartPropDlg.ButtonApplySeriesTitleClick(Sender: TObject);
var
  m, i: Word;
begin
  (TempChart.Series[ComboBoxSeries.ItemIndex] as TCustomChartSeries).Title := EditSeriesTitle.Text;
  {Change Series name also in ComboBox}
  i := ComboBoxSeries.ItemIndex;
  ComboBoxSeries.Items.Clear;
  for m := 0 to TempChart.SeriesCount - 1 do
    if TempChart.Series[m].Tag < 9999 then
      ComboBoxSeries.Items.Add((TempChart.Series[m] as TCustomChartSeries).Title);
  ComboBoxSeries.ItemIndex := i;
end;

procedure TChartPropDlg.ButtonDataClick(Sender: TObject);
var
  p, NrRows: LongWord;
  DateStr: String;
  Err: Boolean;
begin
  if TempChart.Series[ComboBoxSeries.ItemIndex] is TLineSeries then
    NrRows := (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineSeries).Count
  else
  if TempChart.Series[ComboBoxSeries.ItemIndex] is TBarSeries then
    NrRows := (TempChart.Series[ComboBoxSeries.ItemIndex] as TBarSeries).Count;
  XisDateTime := (TempChart.BottomAxis.Marks.Source <> Nil) or (TempChart.AxisList[3].Marks.Source <> Nil);
  with TEditChartDataForm.Create(Self) do
  begin
    StringGrid1.RowCount := NrRows + 1;
    if TempChart.Series[ComboBoxSeries.ItemIndex] is TLineSeries then
    with (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineSeries) do
    for p := 1 to NrRows do //fill StringGrid
    begin
      if XisDateTime then
      begin
        DateTimeToString(DateStr, 'YYYY/MM/DD hh:nn', FloatToDateTime(XValue[p - 1]));
        StringGrid1.Cells[1, p] := DateStr;
      end
      else
        StringGrid1.Cells[1, p] := FloatToStr(XValue[p - 1]);
      StringGrid1.Cells[2, p] := FloatToStr(YValue[p - 1]);
      StringGrid1.Cells[3, p] := '';
    end
    else
    if TempChart.Series[ComboBoxSeries.ItemIndex] is TBarSeries then
    with (TempChart.Series[ComboBoxSeries.ItemIndex] as TBarSeries) do
    for p := 0 to NrRows -1 do //fill StringGrid
    begin
      if XisDateTime then
      begin
        DateTimeToString(DateStr, 'YYYY/MM/DD hh:nn', FloatToDateTime(XValue[p]));
        StringGrid1.Cells[1, p] := DateStr;
      end
      else
        StringGrid1.Cells[1, p] := FloatToStr(XValue[p]);
      StringGrid1.Cells[2, p] := FloatToStr(YValue[p]);
      StringGrid1.Cells[3, p] := '';
    end;
    ShowModal;
    if ModalResult = mrOK then
    begin
      Err := False;
      if TempChart.Series[ComboBoxSeries.ItemIndex] is TLineSeries then
      with (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineSeries) do
      begin
        Clear;
        for p := 1 to StringGrid1.RowCount - 1  do
        try
          if XisDateTime then
            AddXY(StrToDateTime(StringGrid1.Cells[1, p], FFormatSettings), StrToFloat(StringGrid1.Cells[2, p]), StringGrid1.Cells[3, p])
          else
            AddXY(StrToFloat(StringGrid1.Cells[1, p]), StrToFloat(StringGrid1.Cells[2, p]), StringGrid1.Cells[3, p]);
        except on E: Exception do
          Err := True;
        end;
      end
      else
      if TempChart.Series[ComboBoxSeries.ItemIndex] is TBarSeries then
      with (TempChart.Series[ComboBoxSeries.ItemIndex] as TBarSeries) do
      begin
        Clear;
        for p := 1 to StringGrid1.RowCount - 1  do
        try
          if XisDateTime then
            AddXY(StrToDateTime(StringGrid1.Cells[1, p], FFormatSettings), StrToFloat(StringGrid1.Cells[2, p]), StringGrid1.Cells[3, p])
          else
            AddXY(StrToFloat(StringGrid1.Cells[1, p]), StrToFloat(StringGrid1.Cells[2, p]), StringGrid1.Cells[3, p]);
        except on E: Exception do
          Err := True;
        end;
      end;
    end;
    Close;
  end;
  if Err then
    MessageDlg('They were one or more errors in the edited data! These values were ignored in the series.', mtWarning, [mbOK], 0);
end;

procedure TChartPropDlg.ButtonTATRangesApplyClick(Sender: TObject);
begin
  with TempChart.AxisList[3] do
  begin
    Range.Min := BAStartDateTimePicker.DateTime;
    Range.Max := BAEndDateTimePicker.DateTime;
    Range.UseMin := True;
    Range.UseMax := True;
    if EditDTFormatTop.Text > '' then
      (Marks.Source as TDateTimeIntervalChartSource).DateTimeFormat := EditDTFormatTop.Text;
  end;
end;

procedure TChartPropDlg.BottomAxisPageControlChange(Sender: TObject);
begin
  if TPageControl(Sender).ActivePageIndex = 4 then //Ticks page
  begin
    SpinEditBATicksMinorsLength.Enabled := TempChart.BottomAxis.Minors.Count > 0;
    SpinEditBATicksMinorsCount.Enabled := TempChart.BottomAxis.Minors.Count > 0;
  end;
end;

procedure TChartPropDlg.ButtonAxisFontClick(Sender: TObject);
begin
  FontDialog.Font := TempChart.AxisList[(Sender as TButton).Tag].Marks.LabelFont;
  if FontDialog.Execute then
    TempChart.AxisList[(Sender as TButton).Tag].Marks.LabelFont := FontDialog.Font;
end;

procedure TChartPropDlg.ButtonLeftTimeAxisFrameClick(Sender: TObject);
begin
  with TBorderDlg.Create(Self), TempChart.BottomAxis do
  begin
    CheckBoxBorderVisible.Checked := Visible;
    SpinEditBorderWidth.Value := AxisPen.Width;
    ColorButtonBorder.ButtonColor := AxisPen.Color;
    RadioGroupBorderStyle.ItemIndex := Ord(AxisPen.Style);
    ShowModal;
    if ModalResult = mrOK then
    begin
      Visible := CheckBoxBorderVisible.Checked;
      AxisPen.Width := SpinEditBorderWidth.Value;
      AxisPen.Color := ColorDialogBorder.Color;
      AxisPen.Style := TPenStyle(RadioGroupBorderStyle.ItemIndex);
    end;
    Free;
  end;
end;

procedure TChartPropDlg.ButtonTARangesApplyClick(Sender: TObject);
begin
  TempChart.AxisList[3].Range.Max := StrToFloat(EditTAMax.Text);
  TempChart.AxisList[3].Range.Min := StrToFloat(EditTAMin.Text);
  TempChart.AxisList[3].Intervals.NiceSteps := EditTASteps.Text;
end;

procedure TChartPropDlg.ButtonTATitleApplyClick(Sender: TObject);
begin
  TempChart.AxisList[3].Title.Caption := EditTATitle.Text;
  TempChart.Repaint;
end;

procedure TChartPropDlg.CheckBoxArrowsVisibleChange(Sender: TObject);
begin
  if (TempChart.Series[ComboBoxSeries.ItemIndex] is TLineSeries) then
    (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineSeries).Marks.Arrow.Visible := (Sender as TCheckbox).Checked
  else
  if (TempChart.Series[ComboBoxSeries.ItemIndex] is TBarSeries) then
    (TempChart.Series[ComboBoxSeries.ItemIndex] as TBarSeries).Marks.Arrow.Visible := (Sender as TCheckbox).Checked
end;

procedure TChartPropDlg.CheckBoxAxisVisibleChange(Sender: TObject);
begin
  if Active then
    TempChart.AxisList[(Sender as TCheckbox).Tag].Visible := (Sender as TCheckbox).Checked;
end;

procedure TChartPropDlg.CheckBoxInvertedChange(Sender: TObject);
begin
  TempChart.AxisList[(Sender as TCheckBox).Tag].Inverted := (Sender as TCheckBox).Checked;
end;

procedure TChartPropDlg.CheckBoxAxisTitleVisibleChange(Sender: TObject);
begin
  TempChart.AxisList[(Sender as TCheckbox).Tag].Title.Visible := (Sender as TCheckbox).Checked;
end;

procedure TChartPropDlg.CheckBoxMarksAtDataChange(Sender: TObject);
begin
  TempChart.AxisList[(Sender as TCheckBox).Tag].Marks.AtDataOnly := (Sender as TCheckBox).Checked;
end;

procedure TChartPropDlg.CheckBoxLogChange(Sender: TObject);
begin
  if Active then
    if (TempChart.AxisList[(Sender as TCheckbox).Tag].Range.UseMax) or (TempChart.AxisList[(Sender as TCheckbox).Tag].Range.UseMin) then
    begin
      if (TempChart.AxisList[(Sender as TCheckbox).Tag].Range.Max <> 0) and (TempChart.AxisList[(Sender as TCheckbox).Tag].Range.Min <> 0 ) then
        TempLogAxis[(Sender as TCheckbox).Tag].Enabled := (Sender as TCheckbox).Checked;
    end
    else
    begin
      TempLogAxis[(Sender as TCheckbox).Tag].Enabled := (Sender as TCheckbox).Checked;
    end;
end;

procedure TChartPropDlg.CheckBoxBAScalesAutoChange(Sender: TObject);
begin
  if Active then
  begin
    if CheckBoxBAScalesAuto.Checked then
      GroupBoxBAScales.Enabled :=  CheckBoxBAScalesAuto.Checked
    else
    begin
      GroupBoxBAScales.Enabled := not CheckBoxBAScalesAuto.Checked;
      EditBAMax.Text:= FloatToStr(TempChart.BottomAxis.Range.Max);
      EditBAMin.Text:= FloatToStr(TempChart.BottomAxis.Range.Min);
    end;
  end;
end;

procedure TChartPropDlg.CheckBoxBATScalesAutoChange(Sender: TObject);
var
  ex: TDoubleRect;
begin
  if Active then
  begin
    if TCheckBox(Sender).Checked then
    with TempChart do
    begin
      GroupBoxBATScales.Enabled :=  False;
      BottomAxis.Range.UseMin := False;
      BottomAxis.Range.UseMax := False;
      ex := GetFullExtent;
      with BottomAxis do
      begin
        Range.Min := BottomAxis.GetTransform.GraphToAxis(ex.a.X);
        Range.Max := BottomAxis.GetTransform.GraphToAxis(ex.b.X);
        BAStartDateTimePicker.DateTime := GetTransform.GraphToAxis(ex.a.X);
        BAEndDateTimePicker.DateTime := GetTransform.GraphToAxis(ex.b.X);
        (Marks.Source as TDateTimeIntervalChartSource).DateTimeFormat := '';
      end;
    end
    else
    with TempChart do
    begin
      GroupBoxBATScales.Enabled := True;
      with BottomAxis do
      begin
        Range.Min := BAStartDateTimePicker.DateTime;
        Range.Max := BAEndDateTimePicker.DateTime;
        Range.UseMin := True;
        Range.UseMax := True;
        (Marks.Source as TDateTimeIntervalChartSource).DateTimeFormat := EditDTFormatBot.Text;
      end;
    end;
  end;
end;

procedure TChartPropDlg.CheckBoxMarksClippedChange(Sender: TObject);
begin
  if TempChart.Series[ComboBoxSeries.ItemIndex] is TLineSeries then
    (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineSeries).Marks.Clipped := CheckBoxMarksClipped.Checked
  else
  if TempChart.Series[ComboBoxSeries.ItemIndex] is TBarSeries then
    (TempChart.Series[ComboBoxSeries.ItemIndex] as TBarSeries).Marks.Clipped := CheckBoxMarksClipped.Checked
end;

procedure TChartPropDlg.CheckBoxMarksVisibleChange(Sender: TObject);
begin
  if TempChart.Series[ComboBoxSeries.ItemIndex] is TLineSeries then
    (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineSeries).Marks.Visible := CheckBoxMarksVisible.Checked
  else
  if TempChart.Series[ComboBoxSeries.ItemIndex] is TBarSeries then
    (TempChart.Series[ComboBoxSeries.ItemIndex] as TBarSeries).Marks.Visible := CheckBoxMarksVisible.Checked
end;

procedure TChartPropDlg.CheckBoxOnSidePanelChange(Sender: TObject);
begin
  TempChart.Legend.UseSideBar := CheckBoxOnSidePanel.Checked;
end;

procedure TChartPropDlg.CheckBoxRAScalesAutoChange(Sender: TObject);
begin
  if TCheckBox(Sender).Checked then
  begin
    GroupBoxRAScales.Enabled :=  False;
    TempChart.AxisList[2].Range.UseMin := False;
    TempChart.AxisList[2].Range.UseMax := False;
    {if TempAutoScaleAxis[2] <> NIL then
      TempAutoScaleAxis[2].Enabled := True;}
    TempChart.AxisList[2].Range.Min := RAMin;
    TempChart.AxisList[2].Range.Max := RAMax;
    EditRAMin.Text := FloatToStr(RAMin);
    EditRAMax.Text := FloatToStr(RAMax);
  end
  else
  begin
    GroupBoxRAScales.Enabled := True;
    TempChart.AxisList[2].Range.Min := StrToFloat(EditRAMin.Text);
    TempChart.AxisList[2].Range.Max := StrToFloat(EditRAMax.Text);
    TempChart.AxisList[2].Range.UseMin := True;
    TempChart.AxisList[2].Range.UseMax := True;
    {if TempAutoScaleAxis[2] <> NIL then
      TempAutoScaleAxis[2].Enabled := False;}
  end;
end;

procedure TChartPropDlg.CheckBoxShowInLegendChange(Sender: TObject);
begin
  (TempChart.Series[ComboBoxSeries.ItemIndex] as TCustomChartSeries).Legend.Visible := CheckBoxShowInLegend.Checked;
end;

procedure TChartPropDlg.CheckBoxShowLinesChange(Sender: TObject);
begin
  if TempChart.Series[ComboBoxSeries.ItemIndex] is TLineSeries then
   (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineseries).ShowLines := CheckBoxShowLines.Checked;
end;

procedure TChartPropDlg.CheckBoxShowPointsChange(Sender: TObject);
begin
  if TempChart.Series[ComboBoxSeries.ItemIndex] is TLineSeries then
    (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineSeries).ShowPoints := CheckBoxShowPoints.Checked;
end;

procedure TChartPropDlg.CheckBoxShowSeriesChange(Sender: TObject);
begin
  (TempChart.Series[ComboBoxSeries.ItemIndex] as TCustomChartSeries).Active := CheckBoxShowSeries.Checked;
end;

procedure TChartPropDlg.CheckBoxTAMarksClippedChange(Sender: TObject);
begin
  TempChart.AxisList[(Sender as TCheckBox).Tag].Marks.Clipped := (Sender as TCheckBox).Checked;
end;

procedure TChartPropDlg.CheckBoxTAScalesAutoChange(Sender: TObject);
begin
  if CheckBoxTAScalesAuto.Checked then
  begin
     GroupBoxTAScales.Enabled := CheckBoxTAScalesAuto.Checked;
  end
  else
  begin
     GroupBoxTAScales.Enabled := not CheckBoxTAScalesAuto.Checked;
     EditTAMax.Text:= FloatToStr(TempChart.AxisList[3].Range.Max);
     EditTAMin.Text:= FloatToStr(TempChart.AxisList[3].Range.Min);
  end;
end;

procedure TChartPropDlg.CheckBoxTATScalesAutoChange(Sender: TObject);
var
  ex: TDoubleRect;
begin
  if TCheckBox(Sender).Checked then
  with TempChart do
  begin
    GroupBoxTATScales.Enabled :=  False;
    AxisList[3].Range.UseMax := False;
    AxisList[3].Range.UseMin := False;
    ex := GetFullExtent;
    with AxisList[3] do
    begin
      Range.Min := GetTransform.GraphToAxis(ex.a.X);
      Range.Max := GetTransform.GraphToAxis(ex.b.X);
      TAStartDateTimePicker.DateTime := GetTransform.GraphToAxis(ex.a.X);
      TAEndDateTimePicker.DateTime := GetTransform.GraphToAxis(ex.b.X);
      (Marks.Source as TDateTimeIntervalChartSource).DateTimeFormat := '';
    end;
  end
  else
  with TempChart do
  begin
    GroupBoxTATScales.Enabled := True;
    with AxisList[3] do
    begin
      Range.Min := TAStartDateTimePicker.DateTime;
      Range.Max := TAEndDateTimePicker.DateTime;
      Range.UseMin := True;
      Range.UseMax := True;
      (Marks.Source as TDateTimeIntervalChartSource).DateTimeFormat := EditDTFormatTop.Text;
    end;
  end;
end;

procedure TChartPropDlg.CheckBoxTitleVisibleChange(Sender: TObject);
begin
  if ComboBoxTitles.ItemIndex = 0 then
    TempChart.Title.Visible := CheckBoxTitleVisible.Checked and (Memo1.Text > '')
  else
    TempChart.Foot.Visible := CheckBoxTitleVisible.Checked and (Memo1.Text > '');
end;

procedure TChartPropDlg.ColorButtonAxisTitleFontColorChanged(Sender: TObject);
begin
  if ClrBtnClkd then
    TempChart.AxisList[(Sender as TColorButton).Tag].Title.LabelFont.Color := (Sender as TColorButton).ButtonColor;
  ClrBtnClkd := False;
end;

procedure TChartPropDlg.ColorButtonTitlesFontClick(Sender: TObject);
begin
  ClrBtnClkd := True;
end;

procedure TChartPropDlg.ColorButtonBarColourClick(Sender: TObject);
begin
  ClrBtnClkd := True;
end;

procedure TChartPropDlg.ColorButtonClick(Sender: TObject);
begin
  ClrBtnClkd := True;
end;

procedure TChartPropDlg.ColorButtonPntsBrushColorChanged(Sender: TObject);
begin
  if ClrBtnClkd and (TempChart.Series[ComboBoxSeries.ItemIndex] is TLineSeries) then
    with (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineSeries) do
    begin
      SeriesColor := ColorButtonPntsBrush.ButtonColor;
      Pointer.Brush.Color := ColorButtonPntsBrush.ButtonColor;
    end;
  ClrBtnClkd := False;
end;

procedure TChartPropDlg.ColorButtonTitleBkgrColClick(Sender: TObject);
begin
  ClrBtnClkd := True;
end;

procedure TChartPropDlg.ColorButtonTitleBkgrColColorChanged(Sender: TObject);
begin
  if ClrBtnClkd then
  begin
    if ComboBoxTitles.ItemIndex = 0 then
      TempChart.Title.Brush.Color := ColorButtonTitleBkgrCol.ButtonColor
    else
      TempChart.Foot.Brush.Color := ColorButtonTitleBkgrCol.ButtonColor
  end;
  ClrBtnClkd := False;
end;

procedure TChartPropDlg.ColorButtonTitlesFontColorChanged(Sender: TObject);
begin
  if ClrBtnClkd then
  begin
    if ComboBoxTitles.ItemIndex = 0 then
      TempChart.Title.Font.Color := ColorButtonTitlesFont.ButtonColor
    else
      TempChart.Foot.Font.Color := ColorButtonTitlesFont.ButtonColor;
  end;
  ClrBtnClkd := False;
end;

procedure TChartPropDlg.RAValueFormatChange(Sender: TObject);
begin
  if Active then
  begin
    if Ord(TempChart.AxisList[2].Marks.Style) IN [0, 2] then //marks are values or custom
    begin
      if ComboBoxRAValueFormat.ItemIndex = 0 then
        TempChart.AxisList[2].Marks.Format := '%0:.' + IntToStr(SpinEditRADigits.Value) + 'g'
      else
        TempChart.AxisList[2].Marks.Format := '%0:.' + IntToStr(SpinEditRADigits.Value) + 'f';
    end
    else //marks are labels
    begin
      TempChart.AxisList[2].Marks.Format := '%2:s';
    end;
  end;
end;

procedure TChartPropDlg.LAValueFormatChange(Sender: TObject);
begin
  if Active then
  begin
    if Ord(TempChart.LeftAxis.Marks.Style) IN [0, 2] then //marks are values or custom
    begin
      if ComboBoxLAValueFormat.ItemIndex = 0 then
        TempChart.LeftAxis.Marks.Format := '%0:.' + IntToStr(SpinEditLADigits.Value) + 'g'
      else
        TempChart.LeftAxis.Marks.Format := '%0:.' + IntToStr(SpinEditLADigits.Value) + 'f';
    end
    else //marks are labels
    begin
      TempChart.LeftAxis.Marks.Format := '%2:s';
    end;
  end;
end;

procedure TChartPropDlg.ComboBoxMarksStyleChange(Sender: TObject);
begin
  if TempChart.Series[ComboBoxSeries.ItemIndex] is TLineSeries then
    (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineSeries).Marks.Style := TSeriesMarksStyle(ComboBoxMarksStyle.ItemIndex + 1)
  else
  if TempChart.Series[ComboBoxSeries.ItemIndex] is TBarSeries then
      (TempChart.Series[ComboBoxSeries.ItemIndex] as TBarSeries).Marks.Style := TSeriesMarksStyle(ComboBoxMarksStyle.ItemIndex + 1)
end;

procedure TChartPropDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TChartPropDlg.FormShow(Sender: TObject);
var m: Integer;
  ex: TDoubleRect;
begin
  with TempChart do
  begin
    {General Settings}
    SpinEditMarginTop.Value := Margins.Top;
    SpinEditMarginLeft.Value := Margins.Left;
    SpinEditMarginBottom.Value := Margins.Bottom;
    SpinEditMarginRight.Value := Margins.Right;
    ButtonExport.Enabled := False;
    {Add Series to ComboBox}
    ComboBoxSeries.Items.Clear;
    for m := 0 to Series.Count - 1 do
      if Series[m].Tag < 9999 then
        ComboBoxSeries.Items.Add((Series[m] as TCustomChartSeries).Title);
    ComboBoxSeries.ItemIndex := 0;
    ComboBoxSeriesChange(ComboBoxSeries); //trigger the event to update series dependent controls
    //Axes
    Prepare;
    ex := LogicalExtent;
    {Left Axis Settings}
    with LeftAxis do
    begin
      //store the axis max and mins
      LAMin := GetTransform.GraphToAxis(ex.a.Y);
      LAMax := GetTransform.GraphToAxis(ex.b.Y);
      CheckBoxLeftAxisVisible.Checked := LeftAxis.Visible;
      EditLAMin.Text := FloatToStr(LAMin);
      EditLAMax.Text := FloatToStr(LAMax);
      CheckBoxLAScalesAuto.Checked := not Range.UseMax and not Range.UseMin;
      GroupBoxLAScales.Enabled := not CheckBoxLAScalesAuto.Checked;
      EditLASteps.Text := Intervals.NiceSteps;
      CheckBoxLALog.Enabled := TempLogAxis[0] <> NIL;
      CheckBoxLALog.Checked := (TempLogAxis[0] <> NIL) and TempLogAxis[0].Enabled;
      CheckBoxLAInverted.Checked := Inverted;
      EditLATitle.Text := Title.Caption;
      CheckBoxLATitleVisible.Checked := Title.Visible;
      SpinEditLATitleAngle.Value := Title.LabelFont.Orientation/10;
      SpinEditLATitleSize.Value := Title.LabelFont.Size;
      CheckBoxLAMarksVisible.Checked := Marks.Visible;
      //update display format
      if Pos('g', Marks.Format) > 0 then //general
        ComboBoxLAValueFormat.ItemIndex := 0
      else //fixed
        ComboBoxLAValueFormat.ItemIndex := 1;
      SpinEditLADigits.Value := StrToInt(Copy(Marks.Format, Pos('.', Marks.Format) + 1, 1));
      SpinEditLAMarksSize.Value := Marks.LabelFont.Size;
      SpinEditLAMarksAngle.Value := Marks.LabelFont.Orientation/10;
      CheckBoxLAMarksClipped.Checked := Marks.Clipped;
      CheckBoxLAMarksAtData.Checked := Marks.AtDataOnly;
      SpinEditLATicksLength.Value := TickLength;
      SpinEditLATicksInnerLength.Value := TickInnerLength;
      ColorButtonLATicks.Color := TickColor;
      ColorButtonLATitleFont.ButtonColor := Title.LabelFont.Color;
      SpinEditLATicksMinorsCount.Value := Minors.Count;
      if Minors.Count > 0 then
        SpinEditLATicksMinorsLength.Value := Minors[0].TickLength;
    end;
    //Bottom axis settings
    with BottomAxis do
    begin
      CheckBoxBottomAxisVisible.Checked := Visible;
      if XisDateTime then //for time axes
      begin
        TabSheetBAScales.TabVisible := False;
        TabSheetBATimeScales.TabVisible := True;
        CheckBoxBATScalesAuto.Checked := not Range.UseMax and not Range.UseMin;
        GroupBoxBATScales.Enabled := not CheckBoxBATScalesAuto.Checked;
        BAStartDateTimePicker.DateTime := GetTransform.GraphToAxis(ex.a.X);
        BAEndDateTimePicker.DateTime := GetTransform.GraphToAxis(ex.b.X);
        TempChart.BottomAxis.Range.Min := GetTransform.GraphToAxis(ex.a.X);
        TempChart.BottomAxis.Range.Max := GetTransform.GraphToAxis(ex.b.X);
      end
      else
      begin
        TabSheetBAScales.TabVisible := True;
        TabSheetBATimeScales.TabVisible := False;
        CheckBoxBAScalesAuto.Checked := not Range.UseMax and not Range.UseMin;
        GroupBoxBAScales.Enabled := not CheckBoxBAScalesAuto.Checked;
        CheckBoxBALog.Enabled := TempLogAxis[1] <> NIL;
        CheckBoxBALog.Checked := (TempLogAxis[1] <> NIL) and TempLogAxis[1].Enabled;
        EditBASteps.Text := Intervals.NiceSteps;
        EditBAMin.Text := FloatToStr(Range.Min);
        EditBAMax.Text := FloatToStr(Range.Max);
        CheckBoxBAInverted.Checked := Inverted;
      end;
      EditBATitle.Text := Title.Caption;
      CheckBoxBATitleVisible.Checked := Title.Visible;
      SpinEditBATitleAngle.Value := Title.LabelFont.Orientation/10;
      SpinEditBATitleSize.Value := Title.LabelFont.Size;
      CheckBoxBAMarksVisible.Checked := Marks.Visible;
      //update display format
      if Marks.Style = smsLabel then
      begin
        ComboBoxBAValueFormat.Clear;
        ComboBoxBAValueFormat.Items.Add('Label');
        ComboBoxBAValueFormat.ItemIndex := 0;
        ComboBoxBAValueFormat.Enabled := False;
        SpinEditBADigits.Value := 0;
        SpinEditBADigits.Enabled := False;
      end
      else
      begin
        if Pos('g', Marks.Format) > 0 then //general
          ComboBoxBAValueFormat.ItemIndex := 0
        else //fixed
          ComboBoxBAValueFormat.ItemIndex := 1;
        SpinEditBADigits.Value := StrToInt(Copy(Marks.Format, Pos('.', Marks.Format) + 1, 1));
      end;
      SpinEditBAMarksSize.Value := Marks.LabelFont.Size;
      SpinEditBAMarksAngle.Value := Marks.LabelFont.Orientation/10;
      CheckBoxBAMarksAtData.Checked := Marks.AtDataOnly;
      CheckBoxBAMarksClipped.Checked := Marks.Clipped;
      SpinEditBATicksLength.Value := TickLength;
      SpinEditBATicksInnerLength.Value := TickInnerLength;
      ColorButtonBATicks.Color := TickColor;
      ColorButtonBATitleFont.ButtonColor := Title.LabelFont.Color;
      SpinEditBATicksMinorsCount.Value := Minors.Count;
      if Minors.Count > 0 then
        SpinEditBATicksMinorsLength.Value := Minors.Axes[0].TickLength;
    end;
    if XisDateTime and ((BottomAxis.Marks.Source as TDateTimeIntervalChartSource).DateTimeFormat <> '') then
      EditDTFormatBot.Text := (BottomAxis.Marks.Source as TDateTimeIntervalChartSource).DateTimeFormat;
    //Right axis settings
    if AxisList.Count > 2 then
    with AxisList[2] do
    begin
      //store the axis max and mins
      RAMin := GetTransform.GraphToAxis(ex.a.Y);
      RAMax := GetTransform.GraphToAxis(ex.b.Y);
      CheckBoxRightAxisVisible.Checked := AxisList[2].Visible;
      EditRAMin.Text := FloatToStr(RAMin);
      EditRAMax.Text := FloatToStr(RAMax);
      CheckBoxRAScalesAuto.Checked := not Range.UseMax and not Range.UseMin;
      SpinEditRADigits.Value := StrToInt(Copy(Marks.Format, Pos('.', Marks.Format) + 1, 1));
      GroupBoxRAScales.Enabled := not CheckBoxRAScalesAuto.Checked;
      EditRASteps.Text := Intervals.NiceSteps;
      CheckBoxRALog.Enabled := TempLogAxis[2] <> NIL;
      CheckBoxRALog.Checked := (TempLogAxis[2] <> NIL) and TempLogAxis[2].Enabled;
      CheckBoxRAInverted.Checked := Inverted;
      EditRATitle.Text := Title.Caption;
      CheckBoxRATitleVisible.Checked := Title.Visible;
      SpinEditRATitleAngle.Value := Title.LabelFont.Orientation/10;
      SpinEditRATitleSize.Value := Title.LabelFont.Size;
      CheckBoxRAMarksVisible.Checked := Marks.Visible;
      //update display format
      if Pos('g', Marks.Format) > 0 then //general
        ComboBoxRAValueFormat.ItemIndex := 0
      else //fixed
        ComboBoxRAValueFormat.ItemIndex := 1;
      CheckBoxRAMarksAtData.Checked := Marks.AtDataOnly;
      SpinEditRAMarksSize.Value := Marks.LabelFont.Size;
      SpinEditRAMarksAngle.Value := Marks.LabelFont.Orientation/10;
      CheckBoxRAMarksClipped.Checked := Marks.Clipped;
      SpinEditRATicksLength.Value := TickLength;
      SpinEditRATicksInnerLength.Value := TickInnerLength;
      ColorButtonRATicks.Color := TickColor;
      SpinEditLATicksMinorsCount.Value := Minors.Count;
      ColorButtonRATitleFont.ButtonColor := Title.LabelFont.Color;
      if Minors.Count > 0 then
        SpinEditRATicksMinorsLength.Value := Minors.Axes[0].TickLength;
    end;
    //Top axis settings
    if AxisList.Count > 3 then
    with AxisList[3] do
    begin
      CheckBoxTopAxisVisible.Checked := Visible;
      if XisDateTime then //for time axes
      begin
        TabSheetTAScales.TabVisible := False;
        TabSheetTATimeScales.TabVisible := True;
        TAStartDateTimePicker.DateTime := BAStartDateTimePicker.DateTime;
        TAEndDateTimePicker.DateTime := BAEndDateTimePicker.DateTime;
        Range.Min := TempChart.AxisList[1].Range.Min;
        Range.Max := TempChart.AxisList[1].Range.Max;
      end
      else
      begin
        TabSheetTAScales.TabVisible := True;
        TabSheetTATimeScales.TabVisible := False;
        CheckBoxTAScalesAuto.Checked := (Range.UseMax = False) and (Range.UseMin = False);
        CheckBoxTALog.Enabled := TempLogAxis[3] <> NIL;
        CheckBoxTALog.Checked := (TempLogAxis[3] <> NIL) and TempLogAxis[3].Enabled;
        EditTASteps.Text := Intervals.NiceSteps;
        EditTAMin.Text := FloatToStr(Range.Min);
        EditTAMax.Text := FloatToStr(Range.Max);
        CheckBoxTAInverted.Checked := Inverted;
      end;
      EditTATitle.Text := Title.Caption;
      CheckBoxTATitleVisible.Checked := Title.Visible;
      SpinEditTATitleAngle.Value := Title.LabelFont.Orientation/10;
      SpinEditTATitleSize.Value := Title.LabelFont.Size;
      CheckBoxTAMarksVisible.Checked := Marks.Visible;
      //update display format
      if Marks.Style = smsLabel then
      begin
        ComboBoxTAValueFormat.Clear;
        ComboBoxTAValueFormat.Items.Add('Label');
        ComboBoxTAValueFormat.ItemIndex := 0;
        ComboBoxTAValueFormat.Enabled := False;
        SpinEditTADigits.Value := 0;
        SpinEditTADigits.Enabled := False;
      end
      else
      begin
        if Pos('g', Marks.Format) > 0 then //general
          ComboBoxTAValueFormat.ItemIndex := 0
        else //fixed
          ComboBoxTAValueFormat.ItemIndex := 1;
        SpinEditTADigits.Value := StrToInt(Copy(Marks.Format, Pos('.', Marks.Format) + 1, 1));
      end;
      SpinEditTAMarksSize.Value := Marks.LabelFont.Size;
      SpinEditTAMarksAngle.Value := Marks.LabelFont.Orientation/10;
      CheckBoxTAMarksAtData.Checked := Marks.AtDataOnly;
      CheckBoxTAMarksClipped.Checked := Marks.Clipped;
      SpinEditTATicksLength.Value := TickLength;
      SpinEditTATicksInnerLength.Value := TickInnerLength;
      ColorButtonTATicks.Color := TickColor;
      ColorButtonTATitleFont.ButtonColor := Title.LabelFont.Color;
      SpinEditTATicksMinorsCount.Value := Minors.Count;
      if Minors.Count > 0 then
        SpinEditTATicksMinorsLength.Value := Minors.Axes[0].TickLength;
    end;
    if XisDateTime and ((AxisList[3].Marks.Source as TDateTimeIntervalChartSource).DateTimeFormat <> '') then
      EditDTFormatTop.Text := (AxisList[3].Marks.Source as TDateTimeIntervalChartSource).DateTimeFormat;
    {Title Settings}
    CheckBoxTitleVisible.Checked := Title.Visible;
    Memo1.Lines.Clear;
    Memo1.Lines := Title.Text;
    RadioGroupTitles.ItemIndex:= Ord(Title.Alignment);
    ColorButtonTitleBkgrCol.ButtonColor := TempChart.Title.Brush.Color;
    ColorButtonTitlesFont.ButtonColor := TempChart.Title.Font.Color;
    {Legend Settings}
    CheckBoxLegendVisible.Checked:= Legend.Visible;
    CheckBoxOnSidePanel.Checked := Legend.UseSidebar;
    SpinEditLegendY.Value:= Legend.MarginY;
    SpinEditLegendX.Value:= Legend.MarginX;
    ColorButtonLegendBack.ButtonColor := Legend.BackgroundBrush.Color;
    RadioGroupLegendPos.ItemIndex := Ord(Legend.Alignment);
    SpinEditColumns.Value := Legend.ColumnCount;
    {Panel and background Settings}
    CheckBoxNoBackColour.Enabled := (BackColor <> clNone);
    ColorButtonBack.ButtonColor := BackColor;
    ColorButtonPanel.ButtonColor := Color;
  end;
end;

procedure TChartPropDlg.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TChartPropDlg.LinkPenBorderClick(Sender: TObject);
begin
  with TBorderDlg.Create(Self) do
  begin
    if TempChart.Series[ComboBoxSeries.ItemIndex] is TLineSeries then
    with (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineSeries).Marks.LinkPen do
    begin
      CheckBoxBorderVisible.Checked := Visible;
      ColorButtonBorder.ButtonColor := Color;
      SpinEditBorderWidth.Value := Width;
      RadioGroupBorderStyle.ItemIndex := Ord(Style);
      ShowModal;
      if ModalResult = mrOK then
      begin
        Visible := CheckBoxBorderVisible.Checked;
        Width := SpinEditBorderWidth.Value;
        Color := ColorDialogBorder.Color;
        Style := TPenStyle(RadioGroupBorderStyle.ItemIndex);
      end;
    end
    else
    if TempChart.Series[ComboBoxSeries.ItemIndex] is TBarSeries then
    with (TempChart.Series[ComboBoxSeries.ItemIndex] as TBarSeries).Marks.LinkPen do
    begin
      CheckBoxBorderVisible.Checked := Visible;
      ColorButtonBorder.ButtonColor := Color;
      SpinEditBorderWidth.Value := Width;
      RadioGroupBorderStyle.ItemIndex := Ord(Style);
      ShowModal;
      if ModalResult = mrOK then
      begin
        Visible := CheckBoxBorderVisible.Checked;
        Width := SpinEditBorderWidth.Value;
        Color := ColorDialogBorder.Color;
        Style := TPenStyle(RadioGroupBorderStyle.ItemIndex);
      end;
    end;
    Free;
  end;
end;

procedure TChartPropDlg.ButtonRAApplyClick(Sender: TObject);
begin
  try
    TempChart.AxisList[2].Range.Max := StrToFloat(EditRAMax.Text);
    TempChart.AxisList[2].Range.Min := StrToFloat(EditRAMin.Text);
    TempChart.AxisList[2].Range.UseMax := True;
    TempChart.AxisList[2].Range.UseMin := True;
    TempChart.AxisList[2].Intervals.NiceSteps := EditRASteps.Text;
  except on EConvertError do
  begin
    MessageDlg('Invalid boundaries entered!', mtError, [mbOK], 0);
    EditRAMax.SetFocus;
  end;
  end; {of try}
end;

procedure TChartPropDlg.ButtonRATitleApplyClick(Sender: TObject);
begin
  TempChart.AxisList[2].Title.Caption := EditRATitle.Text;
  TempChart.Repaint;
end;

procedure TChartPropDlg.CheckBoxLAScalesAutoChange(Sender: TObject);
begin
  if Active then
  begin
    if TCheckBox(Sender).Checked then
    begin
      GroupBoxLAScales.Enabled :=  False;
      TempChart.LeftAxis.Range.UseMin := False;
      TempChart.LeftAxis.Range.UseMax := False;
      TempChart.LeftAxis.Range.Min := LAMin;
      TempChart.LeftAxis.Range.Max := LAMax;
      EditLAMin.Text := FloatToStr(LAMin);
      EditLAMax.Text := FloatToStr(LAMax);
    end
    else
    begin
      GroupBoxLAScales.Enabled := True;
      with TempChart.LeftAxis do
      begin
        Range.Min := StrToFloat(EditLAMin.Text);
        Range.Max := StrToFloat(EditLAMax.Text);
        Range.UseMin := True;
        Range.UseMax := True;
      end;
    end;
  end;
end;

procedure TChartPropDlg.CheckBoxLegendVisibleChange(Sender: TObject);
begin
  TempChart.Legend.Visible := TCheckBox(Sender).Checked;
end;

procedure TChartPropDlg.ColorButtonBarColourColorChanged(Sender: TObject);
begin
  if ClrBtnClkd then
    (TempChart.Series[ComboBoxSeries.ItemIndex] as TBarSeries).SeriesColor := ColorDialog1.Color;
  ClrBtnClkd := False;
end;

procedure TChartPropDlg.ColorButtonLegendBackChanged(Sender: TObject);
begin
  if ClrBtnClkd then
    TempChart.Legend.BackgroundBrush.Color := ColorDialog1.Color;
  ClrBtnClkd := False;
end;

procedure TChartPropDlg.ColorButtonTicksColorChanged(Sender: TObject);
begin
  if ClrBtnClkd then
    TempChart.AxisList[(Sender as TColorButton).Tag].TickColor := (Sender as TColorButton).ButtonColor;
  ClrBtnClkd := False;
end;

procedure TChartPropDlg.ColorButtonBackColorChanged(Sender: TObject);
begin
  if ClrBtnClkd then
  begin
    TempChart.BackColor := ColorButtonBack.ButtonColor;
    CheckBoxNoBackColour.State := CbUnchecked;
    CheckBoxNoBackColour.Enabled := True;
  end;
  ClrBtnClkd := False;
end;

procedure TChartPropDlg.ColorButtonMarksBackgroundColorChanged(Sender: TObject);
begin
  if ClrBtnClkd then
  begin
    if TempChart.Series[ComboBoxSeries.ItemIndex] is TBarSeries then
      (TempChart.Series[ComboBoxSeries.ItemIndex] as TBarSeries).Marks.LabelBrush.Color := ColorDialog1.Color
    else
    if TempChart.Series[ComboBoxSeries.ItemIndex] is TLineSeries then
      (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineSeries).Marks.LabelBrush.Color := ColorDialog1.Color
  end;
  ClrBtnClkd := False;
end;

procedure TChartPropDlg.ColorButtonPanelColorChanged(Sender: TObject);
begin
  if ClrBtnClkd then
    TempChart.Color := ColorDialog1.Color;
  ClrBtnClkd := False;
end;

procedure TChartPropDlg.ComboBoxTitleBrushChange(Sender: TObject);
begin
  if ComboBoxTitles.ItemIndex = 0 then
    TempChart.Title.Brush.Style := TBrushStyle(ComboBoxTitleBrush.ItemIndex)
  else
    TempChart.Foot.Brush.Style := TBrushStyle(ComboBoxTitleBrush.ItemIndex);
end;

procedure TChartPropDlg.EditMarksValueFormatChange(Sender: TObject);
begin
  if Sender is TEdit then
    TempChart.AxisList[(Sender as TEdit).Tag].Marks.Format := (Sender as TEdit).Text;
end;

procedure TChartPropDlg.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TChartPropDlg.SpinEditMarginLeftChange(Sender: TObject);
begin
  TempChart.Margins.Left := SpinEditMarginLeft.Value;
end;

procedure TChartPropDlg.SpinEditMarginBottomChange(Sender: TObject);
begin
  TempChart.Margins.Bottom := SpinEditMarginBottom.Value;
end;

procedure TChartPropDlg.SpinEditMarginRightChange(Sender: TObject);
begin
  TempChart.Margins.Right := SpinEditMarginRight.Value;
end;

procedure TChartPropDlg.CheckBox12Click(Sender: TObject);
begin
  TempChart.Legend.Visible := CheckBoxLegendVisible.Checked;
end;

procedure TChartPropDlg.CheckBoxNoBackColourClick(Sender: TObject);
begin
   if CheckBoxNoBackColour.Checked then
   begin
     TempChart.BackColor := clNone;
     ColorButtonBack.Enabled := False;
   end
   else
   begin
     TempChart.BackColor := clTAColor;
     ColorButtonBack.Enabled := True;
   end
end;

procedure TChartPropDlg.ButtonTitleFontClick(Sender: TObject);
begin
  if ComboBoxTitles.ItemIndex = 0 then
  begin
    FontDialog.Font := TempChart.Title.Font;
    if FontDialog.Execute then
      TempChart.Title.Font:= FontDialog.Font;
  end
  else
  begin
    FontDialog.Font := TempChart.Foot.Font;
    if FontDialog.Execute then
      TempChart.Foot.Font := FontDialog.Font;
  end;
end;

procedure TChartPropDlg.ComboBoxTitlesChange(Sender: TObject);
begin
  if ComboBoxTitles.ItemIndex = 0 then //Title
  begin
    Memo1.Lines.Clear;
    Memo1.Lines := TempChart.Title.Text;
    CheckBoxTitleVisible.Checked := TempChart.Title.Visible;
    ColorButtonTitleBkgrCol.ButtonColor := TempChart.Title.Brush.Color;
    ColorButtonTitlesFont.ButtonColor := TempChart.Title.Font.Color;
    RadioGroupTitles.ItemIndex := Ord(TempChart.Title.Alignment);
  end
  else //Footer
  begin
    Memo1.Lines.Clear;
    Memo1.Lines := TempChart.Foot.Text;
    CheckBoxTitleVisible.Checked := TempChart.Foot.Visible;
    ColorButtonTitleBkgrCol.ButtonColor := TempChart.Foot.Brush.Color;
    ColorButtonTitlesFont.ButtonColor := TempChart.Foot.Font.Color;
    RadioGroupTitles.ItemIndex := Ord(TempChart.Foot.Alignment);
  end;
end;

procedure TChartPropDlg.ButtonLinePenClick(Sender: TObject);
begin
  if (TempChart.Series[ComboBoxSeries.ItemIndex] is TLineSeries) then
  begin
    with (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineSeries) do
    begin
      with TBorderDlg.Create(Self) do
      begin
        SpinEditBorderWidth.Value := LinePen.Width;
        ColorButtonBorder.ButtonColor := LinePen.Color;
        RadioGroupBorderStyle.ItemIndex := Ord(LinePen.Style);
        ShowModal;
        if ModalResult = mrOK then
        begin
          (TempChart.series[ComboBoxSeries.ItemIndex] as TLineSeries).LinePen.Width := SpinEditBorderWidth.Value;
          (TempChart.series[ComboBoxSeries.ItemIndex] as TLineSeries).LinePen.Color := ColorDialogBorder.Color;
          (TempChart.series[ComboBoxSeries.ItemIndex] as TLineSeries).LinePen.Style := TPenStyle(RadioGroupBorderStyle.ItemIndex);
        end;
        Free;
      end;
    end;
  end;
end;

procedure TChartPropDlg.ButtonTitleBorderClick(Sender: TObject);
begin
  if  ComboBoxTitles.ItemIndex = 0 then
  begin
    with TBorderDlg.Create(Self) do
    begin
      with TempChart.Title.Frame do
      begin
        CheckBoxBorderVisible.Checked := Visible;
        SpinEditBorderWidth.Value := Width;
        ColorButtonBorder.ButtonColor := Color;
        RadioGroupBorderStyle.ItemIndex := Ord(Style);
        ShowModal;
        if ModalResult = mrOK then
        begin
          Visible := CheckBoxBorderVisible.Checked;
          Width := SpinEditBorderWidth.Value;
          Color := ColorDialogBorder.Color;
          Style := TPenStyle(RadioGroupBorderStyle.ItemIndex);
        end;
      end;
      Free;
    end;
  end
  else
  begin
    with TBorderDlg.Create(Self) do
    begin
      with TempChart.Foot.Frame do
      begin
        CheckBoxBorderVisible.Checked := Visible;
        SpinEditBorderWidth.Value := Width;
        ColorButtonBorder.ButtonColor := Color;
        RadioGroupBorderStyle.ItemIndex := Ord(Style);
        ShowModal;
        if ModalResult = mrOK then
        begin
          Visible := CheckBoxBorderVisible.Checked;
          Width := SpinEditBorderWidth.Value;
          Color := ColorDialogBorder.Color;
          Style := TPenStyle(RadioGroupBorderStyle.ItemIndex);
        end;
      end;
      Free;
    end;
  end;
end;

procedure TChartPropDlg.ButtonBorderLegendClick(Sender: TObject);
begin
  with TBorderDlg.Create(Self) do
  begin
    with TempChart.Legend.Frame do
    begin
      CheckBoxBorderVisible.Checked := Visible;
      SpinEditBorderWidth.Value := Width;
      ColorButtonBorder.ButtonColor := Color;
      RadioGroupBorderStyle.ItemIndex := Ord(Style);
      ShowModal;
      if ModalResult = mrOK then
      begin
        Visible := CheckBoxBorderVisible.Checked;
        Width := SpinEditBorderWidth.Value;
        Color := ColorDialogBorder.Color;
        Style := TPenStyle(RadioGroupBorderStyle.ItemIndex);
      end;
    end;
    Free;
  end;
end;

procedure TChartPropDlg.PointsStyleComboBoxChange(Sender: TObject);
begin
  (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineSeries).Pointer.Style :=
    TSeriesPointerStyle(PointsStyleComboBox.ItemIndex);
 end;

procedure TChartPropDlg.PointsBorderButtonClick(Sender: TObject);
begin
  with TBorderDlg.Create(Self) do
  begin
    with (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineseries).Pointer.Pen do
    begin
      CheckBoxBorderVisible.Checked := Visible;
      SpinEditBorderWidth.Value := Width;
      ColorButtonBorder.ButtonColor := Color;
      RadioGroupBorderStyle.ItemIndex := Ord(Style);
    end;
    ShowModal;
    if ModalResult = mrOK then
    with (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineSeries).Pointer.Pen do
    begin
      Width := SpinEditBorderWidth.Value;
      Color := ColorButtonBorder.ButtonColor;
      Visible := CheckBoxBorderVisible.Checked;
      Style := TPenStyle(RadioGroupBorderStyle.ItemIndex);
    end;
    Free;
  end;
end;

procedure TChartPropDlg.PointsWidthSpinEditChange(Sender: TObject);
begin
  (TempChart.series[ComboBoxSeries.ItemIndex]as TLineSeries).pointer.horizsize := PointsWidthSpinEdit.Value;
end;

procedure TChartPropDlg.PointsHeightSpinEditChange(Sender: TObject);
begin
  (TempChart.series[ComboBoxSeries.ItemIndex] as TLineSeries).pointer.VertSize := PointsHeightSpinEdit.Value;
end;

procedure TChartPropDlg.ButtonMarksFontClick(Sender: TObject);
begin
  if FontDialog.Execute then
  begin
    if (TempChart.series[ComboBoxSeries.ItemIndex] is TLineSeries) then
      (TempChart.series[ComboBoxSeries.ItemIndex] as TLineSeries).Marks.LabelFont := FontDialog.Font
    else
    if (TempChart.series[ComboBoxSeries.ItemIndex] is TBarSeries) then
      (TempChart.series[ComboBoxSeries.ItemIndex] as TBarSeries).Marks.LabelFont := FontDialog.Font;
  end;
end;

procedure TChartPropDlg.ButtonMarksBorderClick(Sender: TObject);
begin
  with TBorderDlg.Create(Self) do
  begin
    if TempChart.Series[ComboBoxSeries.ItemIndex] is TLineSeries then
    with (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineSeries).Marks.Frame do
    begin
      CheckBoxBorderVisible.Checked := Visible;
      ColorButtonBorder.ButtonColor := Color;
      SpinEditBorderWidth.Value := Width;
      RadioGroupBorderStyle.ItemIndex := Ord(Style);
      ShowModal;
      if ModalResult = mrOK then
      begin
        Visible := CheckBoxBorderVisible.Checked;
        Width := SpinEditBorderWidth.Value;
        Color := ColorDialogBorder.Color;
        Style := TPenStyle(RadioGroupBorderStyle.ItemIndex);
      end;
    end
    else
    if TempChart.Series[ComboBoxSeries.ItemIndex] is TBarSeries then
    with (TempChart.Series[ComboBoxSeries.ItemIndex] as TBarSeries).Marks.Frame do
    begin
      CheckBoxBorderVisible.Checked := Visible;
      ColorButtonBorder.ButtonColor := Color;
      SpinEditBorderWidth.Value := Width;
      RadioGroupBorderStyle.ItemIndex := Ord(Style);
      ShowModal;
      if ModalResult = mrOK then
      begin
        Visible := CheckBoxBorderVisible.Checked;
        Width := SpinEditBorderWidth.Value;
        Color := ColorDialogBorder.Color;
        Style := TPenStyle(RadioGroupBorderStyle.ItemIndex);
      end;
    end;
    Free;
  end;
end;

procedure TChartPropDlg.SpinEditArrowLengthChange(Sender: TObject);
begin
  if (TempChart.Series[ComboBoxSeries.ItemIndex] is TLineSeries) then
    (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineSeries).Marks.Arrow.Length := (Sender as TSpinEdit).Value
  else
  if (TempChart.Series[ComboBoxSeries.ItemIndex] is TBarSeries) then
    (TempChart.Series[ComboBoxSeries.ItemIndex] as TBarSeries).Marks.Arrow.Length := (Sender as TSpinEdit).Value
end;

procedure TChartPropDlg.RadioGroupTitlesClick(Sender: TObject);
begin
  if ComboBoxTitles.ItemIndex = 0 then
    TempChart.Title.Alignment := TAlignment(RadioGroupTitles.ItemIndex)
  else
    TempChart.Foot.Alignment := TAlignment(RadioGroupTitles.ItemIndex)
end;

procedure TChartPropDlg.ButtonTitleApplyClick(Sender: TObject);
begin
  if ComboBoxTitles.ItemIndex = 0 then
  begin
    TempChart.Title.Text.Clear;
    TempChart.Title.Text := Memo1.Lines;
  end
  else
  begin
    TempChart.Foot.Text.Clear;
    TempChart.Foot.Text := Memo1.Lines;
  end;
  TempChart.Repaint;
end;

procedure TChartPropDlg.ButtonLARangesApplyClick(Sender: TObject);
begin
  with TempChart.LeftAxis do
  begin
    Range.Max := StrToFloat(EditLAMax.Text);
    Range.Min := StrToFloat(EditLAMin.Text);
    Intervals.NiceSteps := EditLASteps.Text;
  end;
end;

procedure TChartPropDlg.ButtonBATRangesApplyClick(Sender: TObject);
begin
  with TempChart.BottomAxis do
  begin
    Range.Min := BAStartDateTimePicker.DateTime;
    Range.Max := BAEndDateTimePicker.DateTime;
    Range.UseMin := True;
    Range.UseMax := True;
    if EditDTFormatBot.Text > '' then
      (Marks.Source as TDateTimeIntervalChartSource).DateTimeFormat := EditDTFormatBot.Text;
  end;
end;

procedure TChartPropDlg.PointsBrushComboBoxChange(Sender: TObject);
begin
  (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineSeries).Pointer.Brush.Style := TBrushStyle(PointsBrushComboBox.ItemIndex);
end;

procedure TChartPropDlg.ButtonTicksGridBorderClick(Sender: TObject);
begin
  with TBorderDlg.Create(Self) do
  begin
    CheckBoxBorderVisible.Checked := TempChart.AxisList[(Sender as TButton).Tag].Grid.Visible;
    SpinEditBorderWidth.Value := TempChart.AxisList[(Sender as TButton).Tag].Grid.Width;
    ColorButtonBorder.ButtonColor := TempChart.AxisList[(Sender as TButton).Tag].Grid.Color;
    RadioGroupBorderStyle.ItemIndex := Ord(TempChart.AxisList[(Sender as TButton).Tag].Grid.Style);
    ShowModal;
    if ModalResult = mrOK then
    with TempChart.AxisList[(Sender as TButton).Tag].Grid do
    begin
      Visible := CheckBoxBorderVisible.Checked;
      Width := SpinEditBorderWidth.Value;
      Color := ColorDialogBorder.Color;
      Style := TPenStyle(RadioGroupBorderStyle.ItemIndex);
    end;
    Free;
  end;
end;

procedure TChartPropDlg.ButtonTicksMinorsClick(Sender: TObject);
var
  TheMinorAxis: TChartMinorAxis;
begin
  with TBorderDlg.Create(Self) do
  if TempChart.AxisList[(Sender as TButton).Tag].Minors.Count > 0 then
  begin
    CheckBoxBorderVisible.Checked := TempChart.AxisList[(Sender as TButton).Tag].Minors[0].Visible;
    SpinEditBorderWidth.Value := TempChart.AxisList[(Sender as TButton).Tag].Minors[0].Grid.Width;
    ColorButtonBorder.ButtonColor := TempChart.AxisList[(Sender as TButton).Tag].Minors[0].TickColor;
    RadioGroupBorderStyle.ItemIndex := Ord(TempChart.AxisList[(Sender as TButton).Tag].Minors[0].Grid.Style);
    ShowModal;
    if ModalResult = mrOK then
    with TempChart.AxisList[(Sender as TButton).Tag].Minors[0] do
    begin
      Visible := CheckBoxBorderVisible.Checked;
      TickColor := ColorDialogBorder.Color;
      Grid.Width := SpinEditBorderWidth.Value;
      Grid.Style := TPenStyle(RadioGroupBorderStyle.ItemIndex);
      Grid.Color := ColorDialogBorder.Color;
    end;
    Free;
  end
  else
  begin
    if MessageDlg('There are no axis minors yet. Do you want to create them?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    with TBorderDlg.Create(Self) do
    begin
      TheMinorAxis := TChartMinorAxis.Create(TempChart.AxisList[(Sender as TButton).Tag].Minors);
      CheckBoxBorderVisible.Checked := True;
      SpinEditBorderWidth.Value := TheMinorAxis.Grid.Width;
      ColorButtonBorder.ButtonColor := TheMinorAxis.TickColor;
      RadioGroupBorderStyle.ItemIndex := Ord(TheMinorAxis.Grid.Style);
      ShowModal;
      if ModalResult = mrOK then
      with TempChart.AxisList[(Sender as TButton).Tag] do
      begin
        Visible := CheckBoxBorderVisible.Checked;
        TheMinorAxis.TickColor := ColorDialogBorder.Color;
        TheMinorAxis.Grid.Width := SpinEditBorderWidth.Value;
        TheMinorAxis.Grid.Style := TPenStyle(RadioGroupBorderStyle.ItemIndex);
        TheMinorAxis.Grid.Color := ColorDialogBorder.Color;
      end;
      Free;
    end;
  end;
  SpinEditLATicksMinorsLength.Enabled := TempChart.AxisList[(Sender as TButton).Tag].Minors.Count > 0;
  SpinEditLATicksMinorsCount.Enabled := TempChart.AxisList[(Sender as TButton).Tag].Minors.Count > 0;
end;

procedure TChartPropDlg.ButtonAxisPenClick(Sender: TObject);
begin
  with TBorderDlg.Create(Self) do
  begin
    CheckBoxBorderVisible.Checked := TempChart.AxisList[(Sender as TButton).Tag].AxisPen.Visible;
    SpinEditBorderWidth.Value := TempChart.AxisList[(Sender as TButton).Tag].AxisPen.Width;
    ColorButtonBorder.ButtonColor := TempChart.AxisList[(Sender as TButton).Tag].AxisPen.Color;
    RadioGroupBorderStyle.ItemIndex := Ord(TempChart.AxisList[(Sender as TButton).Tag].AxisPen.Style);
    ShowModal;
    if ModalResult = mrOK then
    with TempChart.AxisList[(Sender as TButton).Tag] do
    begin
      AxisPen.Visible := CheckBoxBorderVisible.Checked;
      AxisPen.Width := SpinEditBorderWidth.Value;
      AxisPen.Color := ColorDialogBorder.Color;
      AxisPen.Style := TPenStyle(RadioGroupBorderStyle.ItemIndex);
    end;
    Free;
  end;
end;

procedure TChartPropDlg.SpinEditMarksDistanceChange(Sender: TObject);
begin
  if TempChart.Series[ComboBoxSeries.ItemIndex] is TLineSeries then
    (TempChart.Series[ComboBoxSeries.ItemIndex] as TLineSeries).Marks.Distance := SpinEditMarksDistance.Value
  else
  if TempChart.Series[ComboBoxSeries.ItemIndex] is TBarSeries then
    (TempChart.Series[ComboBoxSeries.ItemIndex] as TBarSeries).Marks.Distance := SpinEditMarksDistance.Value
end;

procedure TChartPropDlg.SpinEditTicksLengthChange(Sender: TObject);
begin
  TempChart.AxisList[(Sender as TSpinEdit).Tag].TickLength := (Sender as TSpinEdit).Value;
end;

procedure TChartPropDlg.SpinEditTicksInnerLengthChange(Sender: TObject);
begin
  TempChart.AxisList[(Sender as TSpinEdit).Tag].TickInnerLength := (Sender as TSpinEdit).Value;
end;

procedure TChartPropDlg.SpinEditTicksMinorsLengthChange(Sender: TObject);
begin
  if TempChart.AxisList[(Sender as TSpinEdit).Tag].Minors.Count > 0 then
    TempChart.AxisList[(Sender as TSpinEdit).Tag].Minors[0].TickLength := (Sender as TSpinEdit).Value;
end;

procedure TChartPropDlg.SpinEditTicksMinorsCountChange(Sender: TObject);
begin
  if TempChart.AxisList[(Sender as TSpinEdit).Tag].Minors.Count > 0 then
    TempChart.AxisList[(Sender as TSpinEdit).Tag].Minors[0].Intervals.Count := (Sender as TSpinEdit).Value;
end;

procedure TChartPropDlg.SpinEditTitleAngleChange(Sender: TObject);
begin
  if Active then
    TempChart.AxisList[(Sender as TSpinEdit).Tag].Title.LabelFont.Orientation := (Sender as TSpinEdit).Value * 10;
end;

procedure TChartPropDlg.ButtonAxisTitleFontClick(Sender: TObject);
begin
  FontDialog.Font := TempChart.AxisList[(Sender as TButton).Tag].Title.LabelFont;
  if FontDialog.Execute then
    TempChart.AxisList[(Sender as TButton).Tag].Title.LabelFont := FontDialog.Font;
end;

procedure TChartPropDlg.SpinEditTitleSizeChange(Sender: TObject);
begin
  if Active then
    TempChart.AxisList[(Sender as TSpinEdit).Tag].Title.LabelFont.Size := (Sender as TSpinEdit).Value;
end;

procedure TChartPropDlg.CheckBoxMarksVisibleClick(Sender: TObject);
begin
  TempChart.AxisList[(Sender as TCheckBox).Tag].Marks.Visible := (Sender as TCheckBox).Checked;
end;

procedure TChartPropDlg.Button42Click(Sender: TObject);
begin
  FontDialog.Font := TempChart.BottomAxis.Marks.LabelFont;;
  if FontDialog.Execute then
    TempChart.BottomAxis.Marks.LabelFont := FontDialog.Font;
end;

procedure TChartPropDlg.SpinEditMarksSizeChange(Sender: TObject);
begin
  if Active then
    TempChart.AxisList[(Sender as TSpinEdit).Tag].Marks.LabelFont.Size := (Sender as TSpinEdit).Value;
end;

procedure TChartPropDlg.SpinEditMarksAngleChange(Sender: TObject);
begin
  if Active then
    TempChart.AxisList[(Sender as TSpinEdit).Tag].Marks.LabelFont.Orientation := (Sender as TSpinEdit).Value * 10;
end;

procedure TChartPropDlg.Button6Click(Sender: TObject);
begin
  FontDialog.Font := TempChart.BottomAxis.Title.LabelFont;
  if FontDialog.Execute then
    TempChart.BottomAxis.Title.LabelFont := FontDialog.Font;
end;

procedure TChartPropDlg.ButtonLegendFontClick(Sender: TObject);
begin
  FontDialog.Font := TempChart.Legend.Font;
  if FontDialog.Execute then
    TempChart.Legend.Font := FontDialog.Font;
end;

procedure TChartPropDlg.RadioGroupLegendPosClick(Sender: TObject);
begin
  TempChart.Legend.Alignment := TLegendAlignment(RadioGroupLegendPos.ItemIndex);
end;

procedure TChartPropDlg.SpinEditLegendXChange(Sender: TObject);
begin
  TempChart.Legend.MarginX := SpinEditLegendX.Value;
end;

procedure TChartPropDlg.SpinEditLegendYChange(Sender: TObject);
begin
  TempChart.Legend.MarginY := SpinEditLegendY.Value;
end;

procedure TChartPropDlg.ButtonPrintClick(Sender: TObject);
const
  MARGIN = 10;
var
  r: TRect;
  d: Integer;
begin
  if PrintDialog1.Execute then
  begin
    Printer.BeginDoc;
    try
      r := Rect(0, 0, Printer.PageWidth, Printer.PageHeight div 2);
      d := r.Right - r.Left;
      r.Left += d div MARGIN;
      r.Right -= d div MARGIN;
      d := r.Bottom - r.Top;
      r.Top += d div MARGIN;
      r.Bottom -= d div MARGIN;
      TempChart.PaintOnCanvas(Printer.Canvas, r);
    finally
      Printer.EndDoc;
    end;
  end;
end;

procedure TChartPropDlg.ComboBoxSeriesChange(Sender: TObject);
begin
  with (Sender as TComboBox) do
  begin
    with (TempChart.Series[ItemIndex] as TCustomChartSeries) do
    begin
      CheckBoxShowSeries.Enabled := True;
      CheckBoxShowSeries.Checked := Active;
      CheckBoxShowInLegend.Checked := Legend.Visible;
      if AxisIndexY = 0 then
        RadioGroupVertAxis.ItemIndex := 0
      else
        RadioGroupVertAxis.ItemIndex := 1;
      if AxisIndexX = 1 then
        RadioGroupHorAxis.ItemIndex := 1
      else
        RadioGroupHorAxis.ItemIndex := 0;
    end;
    ButtonData.Enabled := (ButtonData.Tag = 0) and ((TempChart.Series[ItemIndex] is TLineSeries) or (TempChart.Series[ItemIndex] is TBarSeries));
    if (TempChart.Series[ItemIndex] is TBarSeries) then //Bar series
    begin
      TabSheetFormatBar.TabVisible:= True;
      TabSheetFormatLine.TabVisible:= False;
      TabSheetMarks.TabVisible :=  True;
      with (TempChart.Series[ItemIndex] as TBarSeries) do
      begin
        ColorButtonBarColour.ButtonColor := SeriesColor;
        ColorButtonBarColour.Refresh;
        SpinEditBarWidth.Value := BarWidthPercent;
        SpinEditBarOffset.Value := BarOffsetPercent;
        ComboBoxMarksStyle.ItemIndex := Ord(Marks.Style) - 1; //smsCustom not included
        CheckBoxMarksVisible.Checked := Marks.Visible;
        SpinEditMarksDistance.Value := Marks.Distance;
        CheckBoxMarksClipped.Checked := Marks.Clipped;
        CheckBoxArrowsVisible.Checked := Marks.Arrow.Visible;
        ColorButtonMarksBackground.ButtonColor := Marks.LabelBrush.Color;
        SpinEditArrowWidth.Value := Marks.Arrow.Width;
        SpinEditArrowLength.Value := Marks.Arrow.Length;
        EditFormatLegend.Text := Legend.Format;
        CheckBoxShowPoints.Checked := False;
        CheckBoxShowPoints.Enabled := False;
        CheckBoxShowLines.Checked := False;
        CheckBoxShowLines.Enabled := False;
      end;
    end
    else //LineSeries
    if (TempChart.Series[ItemIndex] is TLineSeries) then
    begin
      TabSheetFormatBar.TabVisible := False;
      TabSheetFormatLine.TabVisible := True;
      TabSheetMarks.TabVisible :=  True;
      with (TempChart.Series[ItemIndex] as TLineSeries) do
      begin
        CheckBoxShowPoints.Checked := ShowPoints and (Pointer.Visible = True);
        CheckBoxShowPoints.Enabled := True;
        CheckBoxShowLines.Checked := ShowLines;
        ColorButtonPntsBrush.ButtonColor := Pointer.Brush.Color;
        PointsWidthSpinEdit.Value := Pointer.HorizSize;
        PointsHeightSpinEdit.Value := Pointer.VertSize;
        PointsStyleComboBox.ItemIndex := Ord(Pointer.Style);
        PointsBrushComboBox.ItemIndex := Ord(Marks.LabelBrush.Style);
        ComboBoxMarksStyle.ItemIndex := Ord(Marks.Style) - 1; //smsCustom not included
        CheckBoxMarksVisible.Checked := Marks.Visible;
        SpinEditMarksDistance.Value := Marks.Distance;
        CheckBoxMarksClipped.Checked := Marks.Clipped;
        CheckBoxArrowsVisible.Checked := Marks.Arrow.Visible;
        ColorButtonMarksBackground.ButtonColor := Marks.LabelBrush.Color;
        SpinEditArrowWidth.Value := Marks.Arrow.Width;
        SpinEditArrowLength.Value := Marks.Arrow.Length;
        EditFormatLegend.Text := Legend.Format;
      end;
    end
    else //ConstantLine Series
    if (TempChart.Series[ItemIndex] is TConstantLine) then
    begin
      TabSheetFormatBar.TabVisible := False;
      TabSheetFormatLine.TabVisible := True;
      TabSheetMarks.TabVisible := False;
      with (TempChart.Series[ItemIndex] as TConstantLine) do
      begin
        GroupBoxPoints.Enabled := False;
        EditFormatLegend.Text := Legend.Format;
        CheckBoxShowPoints.Checked := False;
        CheckBoxShowPoints.Enabled := False;
      end;
    end
    else
    if (TempChart.Series[ItemIndex] is TFieldSeries) then //vectors
    begin
      TabSheetFormatLine.TabVisible := False;
      TabSheetMarks.TabVisible :=  False;
    end;
    if (TempChart.Series[ItemIndex] as TCustomChartSeries).AxisIndexX = 1 then
      RadioGroupHorAxis.ItemIndex := 1
    else
    if (TempChart.Series[ItemIndex] as TCustomChartSeries).AxisIndexX = 3 then
      RadioGroupHorAxis.ItemIndex := 0;
    if (TempChart.Series[ItemIndex] as TCustomChartSeries).AxisIndexY = 0 then
        RadioGroupVertAxis.ItemIndex := 0
    else
    if (TempChart.Series[ItemIndex] as TCustomChartSeries).AxisIndexY = 2 then
      RadioGroupVertAxis.ItemIndex := 1;
    PageControlSeries.TabIndex := 0;
    EditSeriesTitle.Text := (TempChart.Series[ItemIndex] as TCustomChartSeries).Title;
    EditSeriesTitle.Enabled := True;
    ButtonApplySeriesTitle.Enabled := True;
    ComboBoxMarksStyle.Enabled := True;
    if TempChart.Series[ItemIndex] is TLineSeries then
      ComboBoxMarksStyle.ItemIndex := Ord((TempChart.Series[ItemIndex] as TLineSeries).Marks.Style) - 1
    else
    if TempChart.Series[ItemIndex] is TBarSeries then
      ComboBoxMarksStyle.ItemIndex := Ord((TempChart.Series[ItemIndex] as TBarSeries).Marks.Style) - 1
    else
    if TempChart.Series[ItemIndex] is TConstantLine then
    begin
      ComboBoxMarksStyle.Enabled := False;
      ComboBoxMarksStyle.ItemIndex := 0;
    end;
  end;
end;

procedure TChartPropDlg.SpinEditBarWidthChange(Sender: TObject);
begin
 (TempChart.series[ComboBoxSeries.ItemIndex] as TBarSeries).BarWidthPercent := SpinEditBarWidth.Value;
end;

procedure TChartPropDlg.SpinEditBarOffsetChange(Sender: TObject);
begin
  (TempChart.series[ComboBoxSeries.ItemIndex] as TBarSeries).BarOffsetPercent := SpinEditBarOffset.Value;
end;

procedure TChartPropDlg.ButtonBARangesApplyClick(Sender: TObject);
begin
  TempChart.BottomAxis.Range.Max := StrToFloat(EditBAMax.Text);
  TempChart.BottomAxis.Range.Min := StrToFloat(EditBAMin.Text);
  TempChart.BottomAxis.Intervals.NiceSteps := EditBASteps.Text;
end;

procedure TChartPropDlg.ButtonBATitleApplyClick(Sender: TObject);
begin
  TempChart.AxisList[1].Title.Caption := EditBATitle.Text;
  TempChart.Repaint;
end;


procedure TChartPropDlg.ButtonBABorderClick(Sender: TObject);
begin
  with TBorderDlg.Create(Self), TempChart.BottomAxis do
  begin
    CheckBoxBorderVisible.Checked := Visible;
    SpinEditBorderWidth.Value := AxisPen.Width;
    ColorButtonBorder.ButtonColor := AxisPen.Color;
    RadioGroupBorderStyle.ItemIndex := Ord(AxisPen.Style);
    ShowModal;
    if ModalResult = mrOK then
    begin
      Visible := CheckBoxBorderVisible.Checked;
      AxisPen.Width := SpinEditBorderWidth.Value;
      AxisPen.Color := ColorDialogBorder.Color;
      AxisPen.Style := TPenStyle(RadioGroupBorderStyle.ItemIndex);
    end;
    Free;
  end;
end;

procedure TChartPropDlg.ButtonBarBorderClick(Sender: TObject);
begin
  if TempChart.Series[0] is TBarSeries then
  begin
    with TBorderDlg.Create(Self) do
    begin
      CheckBoxBorderVisible.Checked:=(TempChart.Series[ComboBoxSeries.ItemIndex] as TBarSeries).Active;
      SpinEditBorderWidth.Value :=(TempChart.Series[ComboBoxSeries.ItemIndex] as TBarSeries).BarPen.Width;
      ColorButtonBorder.ButtonColor :=(TempChart.Series[ComboBoxSeries.ItemIndex] as TBarSeries).BarPen.Color;
      RadioGroupBorderStyle.ItemIndex := Ord((TempChart.series[ComboBoxSeries.ItemIndex] as TBarSeries).BarPen.Style);
      ShowModal;
      if ModalResult = mrOK then
      with (TempChart.series[ComboBoxSeries.ItemIndex] as TBarSeries) do
      begin
        BarPen.Width := SpinEditBorderWidth.Value;
        BarPen.Color := ColorDialogBorder.Color;
        Active := CheckBoxBorderVisible.Checked;
        BarPen.Style := TPenStyle(RadioGroupBorderStyle.ItemIndex);
      end;
      Free
    end;
  end;
end;

initialization
  FFormatSettings.DateSeparator := '/';
  FFormatSettings.TimeSeparator := ':';
  FFormatSettings.ShortDateFormat := 'yyyy/mm/dd';
  FFormatSettings.ShortTimeFormat := 'hh:nn';

end.

