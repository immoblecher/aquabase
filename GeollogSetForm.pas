{ Copyright (C) 2020 Immo Blecher immo@blecher.co.za

  This source is free software; you can redistribute it and/or modify it under
  the terms of the GNU General Public License as published by the Free
  Software Foundation; either version 2 of the License, or (at your option)
  any later version.

  This code is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

  A copy of the GNU General Public License is available on the World Wide Web
  at http://www.gnu.org/copyleft/gpl.html. You can also obtain it by writing
  to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
  MA 02111-1307, USA.
}
unit GeollogSetForm;

{$mode objfpc}{$H+}

interface                                  

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons,
  ExtCtrls, ComCtrls, Spin, ButtonPanel, EditBtn, XMLPropStorage, TASeries,
  TAGraph, ZDataset, Db, TATextElements, TACustomSeries, LCLType;

type

  { TGeollogSettingsForm }

  TGeollogSettingsForm = class(TForm)
    ButtonFont1: TButton;
    ButtonFont2: TButton;
    CapCheckBox: TCheckBox;
    CapColorButton: TColorButton;
    CasingCopperColorButton: TColorButton;
    CheckBox2Pages: TCheckBox;
    CheckBoxLabelPiez: TCheckBox;
    CheckBoxAbove: TCheckBox;
    CheckBoxOverlap: TCheckBox;
    CheckBoxShowStrikes: TCheckBox;
    CheckBoxUsePrim: TCheckBox;
    ComboBoxTopParamOpt: TComboBox;
    ComboBoxBotParamOpt: TComboBox;
    EditFontGeneral2: TEdit;
    HoleMarkerLabelColorButton: TColorButton;
    ComboBoxLabelPiez: TComboBox;
    ComboBoxStrikes: TComboBox;
    DepthQueryX_AXISTITLE_BOT: TStringField;
    EditFontGeneral1: TEdit;
    CasingMarkerLabelColorButton: TColorButton;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    LabelTopParamOpt: TLabel;
    LabelBotParamOpt: TLabel;
    LabelTopExt: TLabel;
    LegendFrameCheckBox: TCheckBox;
    ShowMemoCheckBox: TCheckBox;
    GroupBox7: TGroupBox;
    Label10: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MaxTopLabeledEdit: TLabeledEdit;
    MaxBotLabeledEdit: TLabeledEdit;
    FloatSpinEditBot: TFloatSpinEdit;
    SpinEditTopExt: TSpinEdit;
    SpinEditLith: TSpinEdit;
    SpinEditLblWidth: TSpinEdit;
    SpinEditVLight: TSpinEdit;
    SpinEditLighter: TSpinEdit;
    SpinEditDarker: TSpinEdit;
    SpinEditResFactor: TSpinEdit;
    SpinEditTransparency: TSpinEdit;
    StaticText3: TStaticText;
    TopLineComboBox: TComboBox;
    BottomLineComboBox: TComboBox;
    DepthQueryDESCRIPTION: TMemoField;
    DepthQueryFILE_NAME: TMemoField;
    DepthQueryUNITXVAL: TStringField;
    DepthQueryXVAL: TStringField;
    DepthQueryYVAL: TStringField;
    WLLabelRadioGroup: TRadioGroup;
    Label4: TLabel;
    Label5: TLabel;
    UnitLabel: TLabel;
    TopLabeledEdit: TLabeledEdit;
    ButtonPanel1: TButtonPanel;
    cbWLDate: TComboBox;
    BottomLabeledEdit: TLabeledEdit;
    FloatSpinEditTop: TFloatSpinEdit;
    Label1: TLabel;
    WaterColorButton: TColorButton;
    ShowWaterCheckBox: TCheckBox;
    LabelUnderLineCheckBox: TCheckBox;
    StaggerCheckBox: TCheckBox;
    ThicknCheckBox: TCheckBox;
    CheckBoxDefaultColor: TCheckBox;
    CheckBox3: TCheckBox;
    PiezomColorButton: TColorButton;
    WLColorButton: TColorButton;
    LithologyFontColorButton: TColorButton;
    BackColorButton: TColorButton;
    TopSeriesColorButton: TColorButton;
    BottomSeriesColorButton: TColorButton;
    HoleColorButton: TColorButton;
    CasingSolidColorButton: TColorButton;
    CasingSteelColorButton: TColorButton;
    CasingPVCColorButton: TColorButton;
    ColorDialog1: TColorDialog;
    FontDialog1: TFontDialog;
    Label6: TLabel;
    PageControl1: TPageControl;
    LogTab: TTabSheet;
    ChartTab: TTabSheet;
    GroupBox2: TGroupBox;
    GroupBox5: TGroupBox;
    Label3: TLabel;
    AutoIntervalCheckBox: TCheckBox;
    WLRadioGroup: TRadioGroup;
    LithologyFontSizeSpinEdit: TSpinEdit;
    PThicknCheckBox: TCheckBox;
    ThicknSpinEdit: TSpinEdit;
    WLSpinEdit: TSpinEdit;
    IntervalSpinEdit: TSpinEdit;
    StaticText2: TStaticText;
    TabSheetLith: TTabSheet;
    PThicknSpinEdit: TSpinEdit;
    PageControl2: TPageControl;
    CstrcLithTabSheet: TTabSheet;
    PageControl4: TPageControl;
    TabSheetHole: TTabSheet;
    CheckBox4: TCheckBox;
    TabSheet6: TTabSheet;
    CheckBox2: TCheckBox;
    GroupBox4: TGroupBox;
    TabSheet7: TTabSheet;
    CheckBox7: TCheckBox;
    TabSheetGeneral: TTabSheet;
    Penetration: TTabSheet;
    Waterlevel: TTabSheet;
    WLCheckBox: TCheckBox;
    GroupBox3: TGroupBox;
    Label33: TLabel;
    TopComboBox: TComboBox;
    GroupBox6: TGroupBox;
    Label13: TLabel;
    BottomComboBox: TComboBox;
    ShowDepthCheckBox: TCheckBox;
    DefaultFillColourCheckBox: TCheckBox;
    Label2: TLabel;
    TabSheet1: TTabSheet;
    CheckBox16: TCheckBox;
    wlQuery: TZReadOnlyQuery;
    XMLPropStorage: TXMLPropStorage;
    DepthQuery: TZReadOnlyQuery;
    procedure BottomComboBoxChange(Sender: TObject);
    procedure CheckBox2PagesChange(Sender: TObject);
    procedure CheckBoxLabelPiezClick(Sender: TObject);
    procedure ButtonFont1Click(Sender: TObject);
    procedure ComboBoxBotParamOptChange(Sender: TObject);
    procedure ComboBoxTopParamOptChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure AutoIntervalCheckBoxClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    procedure MaxLabeledEditKeyPress(Sender: TObject; var Key: char);
    procedure OKButtonClick(Sender: TObject);
    procedure ShowDepthCheckBoxChange(Sender: TObject);
    procedure SpinEditTopExtChange(Sender: TObject);
    procedure TopComboBoxChange(Sender: TObject);
    procedure WLSetting;
  private
    { Private declarations }
    TopTableName, BottomTableName, TopX_Field, TopY_Field, BotX_Field, BotY_Field: ShortString;
    TopUnit, BottomUnit, TopSeriesTitle, BottomSeriesTitle: ShortString;
    TopFactor, BotFactor: Double;
  public
    { Public declarations }
    IsReport: Boolean;
  end;

var
  GeollogSettingsForm: TGeollogSettingsForm;

implementation

uses VARINIT, MainDataModule, constrctlogform;

{$R *.lfm}

procedure TGeollogSettingsForm.FormCreate(Sender: TObject);
begin
  Screen.Cursor := crDefault;
  XMLPropStorage.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  DepthQuery.Open;
  while not DepthQuery.EOF do
  begin
    TopComboBox.Items.Add(DepthQueryDESCRIPTION.Value);
    BottomComboBox.Items.Add(DepthQueryDESCRIPTION.Value);
    DepthQuery.Next;
  end;
  TopComboBox.ItemIndex := 0;
  TopTableName := '<none>';
  Bottomtablename := '<none>';
  BottomComboBox.ItemIndex := 0;
  UnitLabel.Caption := LengthUnit;
  WLSetting;
end;

procedure TGeollogSettingsForm.ButtonFont1Click(Sender: TObject);
var
  TheTag: Byte;
begin
  TheTag := (Sender as TButton).Tag;
  FontDialog1.Font := (FindComponent('EditFontGeneral' + IntToStr(TheTag)) as TEdit).Font;
  if FontDialog1.Execute then
  begin
    (FindComponent('EditFontGeneral' + IntToStr(TheTag)) as TEdit).Font := FontDialog1.Font;
    (FindComponent('EditFontGeneral' + IntToStr(TheTag)) as TEdit).Text := FontDialog1.Font.Name;
  end;
end;

procedure TGeollogSettingsForm.ComboBoxBotParamOptChange(Sender: TObject);
begin
  if BottomTableName = 'penetrat' then
  begin
    case ComboBoxBotParamOpt.ItemIndex of
      0: BottomUnit := TimeUnit + '/' + LengthUnit;
      1: BottomUnit := 'min./' + LengthUnit;
      2: BottomUnit := LengthUnit + '/min.';
    end;
  end;
end;

procedure TGeollogSettingsForm.ComboBoxTopParamOptChange(Sender: TObject);
begin
  if TopTableName = 'penetrat' then
  begin
    case ComboBoxTopParamOpt.ItemIndex of
      0: TopUnit := TimeUnit + '/' + LengthUnit;
      1: TopUnit := 'min./' + LengthUnit;
      2: TopUnit := LengthUnit + '/min.';
    end;
  end;
end;

procedure TGeollogSettingsForm.BottomComboBoxChange(Sender: TObject);
begin
  if BottomComboBox.ItemIndex > 0 then
  begin
    ButtonPanel1.OKButton.Enabled := True;
    DepthQuery.Filter := 'DESCRIPTION = ' + QuotedStr(BottomComboBox.Text);
    DepthQuery.Filtered := True;
    BottomLabeledEdit.Text := DepthQueryX_AXISTITLE_BOT.Value;
    BottomTableName := LowerCase(DepthQueryFILE_NAME.Value);
    BotX_Field := DepthQueryXVAL.Value;
    BotY_Field := DepthQueryYVAL.Value;
    BottomUnit := DepthQueryUNITXVAL.Value;
    BottomSeriesTitle := DepthQueryDESCRIPTION.Value;
    //set units for axes
    if BottomTableName = 'penetrat' then
    begin
      LabelBotParamOpt.Enabled := True;
      LabelBotParamOpt.Caption := 'Penetration unit:';
      with ComboBoxBotParamOpt do
      begin
        Enabled := True;
        Items.Add('min./' + LengthUnit);
        Items.Add(LengthUnit + '/min.');
      end;
      BottomUnit := TimeUnit + '/' + LengthUnit;
    end
    else
    begin
      LabelBotParamOpt.Enabled := False;
      LabelBotParamOpt.Caption := 'Parameter options:';
      ComboBoxBotParamOpt.Enabled := False;
      if DepthQueryUNITXVAL.Value = 'DISUNIT' then
      begin
        BottomUnit := VolumeUnit + '/' + TimeUnit;
        BotFactor := VolumeFactor * TimeFactor;
      end
      else
      if DepthQueryUNITXVAL.Value = 'ECUNIT' then
      begin
        BottomUnit := ECUnit;
        BotFactor := ECFactor;
      end
      else
      begin
        BottomUnit := DepthQueryUNITXVAL.Value;
        BotFactor := 1;
      end;
    end;
    DepthQuery.Filtered := False;
  end
  else
  begin
    if TopComboBox.ItemIndex = 0 then
      ButtonPanel1.OKButton.Enabled := False;
    BottomLabeledEdit.Text := '';
    BottomTableName := '<none>';
    BotX_Field := '';
    BotY_Field := '';
  end;
end;

procedure TGeollogSettingsForm.CheckBox2PagesChange(Sender: TObject);
begin
  SpinEditTopExt.Enabled := CheckBox2Pages.Checked;
end;

procedure TGeollogSettingsForm.CheckBoxLabelPiezClick(Sender: TObject);
begin
  ComboBoxLabelPiez.Enabled := CheckBoxLabelPiez.Checked;
end;

procedure TGeollogSettingsForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  DepthQuery.Close;
  CloseAction := caFree;
end;

procedure TGeollogSettingsForm.AutoIntervalCheckBoxClick(Sender: TObject);
begin
   if AutoIntervalCheckBox.Checked then
   begin
      Label3.Enabled:= False;
      IntervalSpinEdit.Enabled:= False;
   end
   else
   begin
      Label3.Enabled:= True;
      IntervalSpinEdit.Enabled:= True;
   end;
end;

procedure TGeollogSettingsForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TGeollogSettingsForm.FormShow(Sender: TObject);
begin
  EditFontGeneral1.Text := EditFontGeneral1.Font.Name;
  EditFontGeneral2.Text := EditFontGeneral2.Font.Name;
  CheckBox2Pages.Enabled := IsReport;
end;

procedure TGeollogSettingsForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TGeollogSettingsForm.MaxLabeledEditKeyPress(Sender: TObject;
  var Key: char);
begin
  if not (Key in ['0'..'9', '.', #8, #9]) then Key := #0;
end;

procedure TGeollogSettingsForm.OKButtonClick(Sender: TObject);
begin
  with TLogForm.Create(Application) do
  begin
    TheLabelFont := TFont.Create;
    ShowLithology := CheckBox3.Checked;
    ShowHole := CheckBox4.Checked;
    ShowCap := CapCheckBox.Checked;
    ShowCasing := CheckBox2.Checked;
    ShowPiezometer := CheckBox16.Checked;
    ShowFill := CheckBox7.Checked;
    ShowWaterlevel := WLCheckBox.Checked;
    DTHChart.Visible := ShowDepthCheckBox.Checked;
    DefaultColour := CheckBoxDefaultColor.Checked;
    HoleColour := HoleColorButton.ButtonColor;
    HoleLabels.Marks.LabelBrush.Color := HoleMarkerLabelColorButton.ButtonColor;
    HoleLabels.Pointer.Brush.Color := HoleMarkerLabelColorButton.ButtonColor;
    HoleLabels.Marks.LabelFont := EditFontGeneral2.Font;
    LithLabelColour := LithologyFontColorButton.ButtonColor;
    LithLabelFontSize := LithologyFontSizeSpinEdit.Value;
    UsePrimFeat := CheckBoxUsePrim.Checked;
    ShowMemo := ShowMemoCheckBox.Checked;
    ShowStrikes := CheckBoxShowStrikes.Checked;
    CumulativeStrikes := ComboBoxStrikes.ItemIndex = 0;
    VeryLight := SpinEditVLight.Value;
    Lighter := SpinEditLighter.Value;
    Darker := SpinEditDarker.Value;
    TheLabelFont := EditFontGeneral1.Font;
    CasingCopperColour := CasingCopperColorButton.ButtonColor;
    CasingSteelColour := CasingSteelColorButton.ButtonColor;
    CasingPVCColour := CasingPVCColorButton.ButtonColor;
    CapColour := CapColorButton.ButtonColor;
    CasingLabels.Pointer.Brush.Color := CasingMarkerLabelColorButton.ButtonColor;
    CasingLabels.Marks.LabelBrush.Color := CasingMarkerLabelColorButton.ButtonColor;
    CasingLabels.Marks.LabelFont := EditFontGeneral2.Font;
    OverrideThickn := ThicknCheckbox.Checked;
    Thickness := ThicknSpinEdit.Value;
    if CheckBoxOverlap.Checked then
      CasingLabels.Marks.OverlapPolicy := opIgnore
    else
      CasingLabels.Marks.OverlapPolicy := opHideNeighbour;
    if CheckBoxAbove.Checked then //place labels above point
      CasingLabels.MarkPositions := lmpPositive;
    ShowPiezLabels := CheckBoxLabelPiez.Checked;
    PiezLabelsAbove := ComboBoxLabelPiez.ItemIndex = 1;
    StaggerLabels := StaggerCheckBox.Checked;
    LabelUnderLine := LabelUnderLineCheckBox.Checked;
    UseDefaultFillColour := DefaultFillColourCheckBox.Checked;
    POverrideThickn := PThicknCheckbox.Checked;
    PThickness := PThicknSpinEdit.Value;
    PiezomColour := PiezomColorButton.ButtonColor;
    WLColour := WLColorButton.ButtonColor;
    WaterColor := WaterColorButton.ButtonColor;
    FillTransparency := SpinEditTransparency.Value;
    WLThickness := WLSpinEdit.Value;
    ShowWater := ShowWaterCheckBox.Checked;
    AutoInterval := AutoIntervalCheckBox.Checked;
    DepthAxisInterval := IntervalSpinEdit.Value;
    LogChart.Color := BackColorButton.ButtonColor;
    DTHChart.Color := BackColorButton.ButtonColor;
    TopLineStyle := TopLineComboBox.ItemIndex;
    BottomLineStyle := BottomLineComboBox.ItemIndex;
    if WLRadioGroup.ItemIndex = 4 then
      WLDate := cbWLDate.Text
    else WLDate := '';
    WhichWL := WLRadioGroup.ItemIndex;
    WLLabelPos := WLLabelRadioGroup.ItemIndex;
    LogChart.LeftAxis.Range.Min := -FloatSpinEditTop.Value;
    DTHChart.LeftAxis.Range.Min := -FloatSpinEditTop.Value;
    LithWidth := SpinEditLith.Value;
    SpaceUnderHole := FloatSpinEditBot.Value;
    TopPenetrOpt := ComboBoxTopParamOpt.ItemIndex;
    BotPenetrOpt := ComboBoxBotParamOpt.ItemIndex;
    ShowLegendFrame := LegendFrameCheckBox.Checked;
    //for report
    Prep2Pages := CheckBox2Pages.Checked;
    TopExt := SpinEditTopExt.Value / 100;
    //Update variables for depth dependent charts
    DTHChart.Visible := ShowDepthCheckBox.Checked;
    //Series on top Axis
    Depth1TableName := TopTableName;
    TopX := TopX_Field;
    TopY := TopY_Field;
    DTHChart.AxisList[3].Title.Caption := TopLabeledEdit.Text + ' [' + TopUnit + ']';
    TopSeries.SeriesColor := TopSeriesColorButton.ButtonColor;
    TopSeries.Title := TopSeriesTitle;
    TheTopFactor := TopFactor;
    if MaxTopLabeledEdit.Text > '' then
      SetMaxTop := StrToFloat(MaxTopLabeledEdit.Text)
    else
      SetMaxTop := 0;
    //Series on bottom axis
    Depth2TableName := BottomTableName;
    BotX := BotX_Field;
    BotY := BotY_Field;
    DTHChart.AxisList[1].Title.Caption := BottomLabeledEdit.Text + ' [' + BottomUnit + ']';
    BottomSeries.SeriesColor := BottomSeriesColorButton.ButtonColor;
    BottomSeries.Title := BottomSeriesTitle;
    TheBotFactor := BotFactor;
    if MaxBotLabeledEdit.Text > '' then
      SetMaxBot := StrToFloat(MaxBotLabeledEdit.Text)
    else
      SetMaxBot := 0;
    //other general settings
    ResFactor := SpinEditResFactor.Value;
    MaxLblWidth := SpinEditLblWidth.Value;
    if IsReport then
    begin
      Buttonpanel1.DefaultButton := pbOK;
      ButtonPanel1.ShowButtons := [pbOK, pbClose, pbHelp];
    end;
    Show;
  end;
end;

procedure TGeollogSettingsForm.ShowDepthCheckBoxChange(Sender: TObject);
begin
  ButtonPanel1.OKButton.Enabled := (TopComboBox.ItemIndex > 0) or (BottomComboBox.ItemIndex > 0);
end;

procedure TGeollogSettingsForm.SpinEditTopExtChange(Sender: TObject);
begin
  LabelTopExt.Caption := '% of the log (top) and Page 2 displaying ' + IntToStr(100 - SpinEditTopExt.Value) + '% of the log (bottom)';
end;

procedure TGeollogSettingsForm.TopComboBoxChange(Sender: TObject);
begin
  if TopComboBox.ItemIndex > 0 then
  begin
    ButtonPanel1.OKButton.Enabled := True;
    DepthQuery.Filter := 'DESCRIPTION = ' + QuotedStr(TopComboBox.Text);
    DepthQuery.Filtered := True;
    TopLabeledEdit.Text := DepthQueryX_AXISTITLE_BOT.Value;
    TopTableName := LowerCase(DepthQueryFILE_NAME.Value);
    TopX_Field := DepthQueryXVAL.Value;
    TopY_Field := DepthQueryYVAL.Value;
    TopSeriesTitle := DepthQueryDESCRIPTION.Value;
    //set units for axes
    if TopTableName = 'penetrat' then
    begin
      LabelTopParamOpt.Enabled := True;
      LabelTopParamOpt.Caption := 'Penetration unit:';
      with ComboBoxTopParamOpt do
      begin
        Enabled := True;
        Items.Add('min./' + LengthUnit);
        Items.Add(LengthUnit + '/min.');
      end;
      TopUnit := TimeUnit + '/' + LengthUnit
    end
    else
    begin
      LabelTopParamOpt.Enabled := False;
      LabelTopParamOpt.Caption := 'Parameter options:';
      ComboBoxTopParamOpt.Enabled := False;
      if DepthQueryUNITXVAL.Value = 'DISUNIT' then
      begin
        TopUnit := VolumeUnit + '/' + TimeUnit;
        TopFactor := VolumeFactor * TimeFactor;
      end
      else
      if DepthQueryUNITXVAL.Value = 'ECUNIT' then
      begin
        TopUnit := ECUnit;
        TopFactor := ECFactor;
      end
      else
      begin
        TopUnit := DepthQueryUNITXVAL.Value;
        TopFactor := 1;
      end;
    end;
    DepthQuery.Filtered := False;
  end
  else
  begin
    if BottomComboBox.ItemIndex = 0 then
      ButtonPanel1.OKButton.Enabled := False;
    TopLabeledEdit.Text := '';
    TopTableName := '<none>';
    TopX_Field := '';
    TopY_Field := '';
  end;
end;

procedure TGeollogSettingsForm.WLSetting;
begin
  wlQuery.Connection := DataModuleMain.ZConnectionDB;
  wlQuery.Params[0].AsString := CurrentSite;
  wlQuery.Open;
  while not wlQuery.EOF do
  begin
    cbWLDate.Items.Add(wlQuery.FieldByName('DATE_MEAS').AsString);
    wlQuery.Next;
  end;
  cbWLDate.ItemIndex := 0;
  wlQuery.Close;
  if cbWLDate.Items.Count > 0 then
  begin
    cbWLDate.Enabled := True;
    WLCheckBox.Enabled := True;
  end;
end;

end.
