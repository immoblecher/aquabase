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
unit TRepSet;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLType, StdCtrls,
  Buttons, Db, Spin, ExtCtrls, ButtonPanel, ComCtrls, XMLPropStorage, ZDataset;

type

  { TTestRepSetForm }

  TTestRepSetForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    CDisComboBox: TComboBox;
    CheckBox1: TCheckBox;
    CheckBoxSeriesShowPoints: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBoxHiRes: TCheckBox;
    CheckBoxPageNr: TCheckBox;
    CheckBoxStepsShowPoints: TCheckBox;
    CheckBoxDischShowPoints: TCheckBox;
    CheckBoxShowAll: TCheckBox;
    CheckBoxShowConst: TCheckBox;
    CheckBoxShowDis: TCheckBox;
    CheckBoxShowObsC: TCheckBox;
    CheckBoxShowObsM: TCheckBox;
    CheckBoxShowWL: TCheckBox;
    ColorButtonSeries: TColorButton;
    ColorButtonSteps: TColorButton;
    ColorButtonDisch: TColorButton;
    ComboBoxWL: TComboBox;
    CommentMemo: TMemo;
    ConstEndDateComboBox: TComboBox;
    ConstMaxSpinEdit: TSpinEdit;
    ConstMinSpinEdit: TSpinEdit;
    ConstStartDateComboBox: TComboBox;
    ConstTMaxSpinEdit: TSpinEdit;
    ConstTMinSpinEdit: TSpinEdit;
    CUseLeftCheckBox: TCheckBox;
    CUseTimeCheckBox: TCheckBox;
    DateCheckBox: TCheckBox;
    EndDateLabel: TLabel;
    Label1: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    MDisComboBox: TComboBox;
    MultiEndDateComboBox: TComboBox;
    MultiMaxSpinEdit: TSpinEdit;
    MultiMinSpinEdit: TSpinEdit;
    MultiStartDateComboBox: TComboBox;
    MultiTMaxSpinEdit: TSpinEdit;
    MultiTMinSpinEdit: TSpinEdit;
    MUseLeftCheckBox: TCheckBox;
    MUseTimeCheckBox: TCheckBox;
    ObsButton: TPanelBitBtn;
    PageControl1: TPageControl;
    PumpingTestQuery: TZReadOnlyQuery;
    RadioGroup1: TRadioGroup;
    SpinEditLineThick: TSpinEdit;
    SpinEditFactor: TSpinEdit;
    SpinEditChtHgt: TSpinEdit;
    SpinEditPiezC: TSpinEdit;
    SpinEditPiezM: TSpinEdit;
    SpinEditSteps: TSpinEdit;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TestingDetailsQuery: TZReadOnlyQuery;
    TitleEdit: TEdit;
    WLQuery: TZReadOnlyQuery;
    XMLPropStorage1: TXMLPropStorage;
    procedure CheckBoxHiResChange(Sender: TObject);
    procedure CheckBoxShowAllChange(Sender: TObject);
    procedure CheckBoxShowObsCChange(Sender: TObject);
    procedure CheckBoxShowObsMChange(Sender: TObject);
    procedure CheckBoxShowWLChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure MultiDateComboBoxChange(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure PumpingTestQueryAfterOpen(DataSet: TDataSet);
    procedure PumpingTestQueryBeforeOpen(DataSet: TDataSet);
    procedure TestingDetailsQueryAfterOpen(DataSet: TDataSet);
    procedure TestingDetailsQueryBeforeOpen(DataSet: TDataSet);
    procedure WLQueryAfterOpen(DataSet: TDataSet);
    procedure WLQueryBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TestRepSetForm: TTestRepSetForm;

implementation

{$R *.lfm}

uses VARINIT, MainDataModule, pumptestrep, Repprev;

procedure TTestRepSetForm.CheckBoxShowWLChange(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if (VerDiff > 3) and (Sender as TCheckBox).Checked then
  begin
    MessageDlg(VersionMessage, mtError,[mbOK], 0);
    (Sender as TCheckBox).Checked := False;
  end;
  {$ENDIF}
end;

procedure TTestRepSetForm.CheckBoxShowAllChange(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if (VerDiff > 3) and (Sender as TCheckBox).Checked then
  begin
    MessageDlg(VersionMessage, mtError,[mbOK], 0);
    (Sender as TCheckBox).Checked := False;
  end;
  {$ENDIF}
end;

procedure TTestRepSetForm.CheckBoxHiResChange(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if (VerDiff > 3) and (Sender as TCheckBox).Checked then
  begin
    MessageDlg(VersionMessage, mtError,[mbOK], 0);
    SpinEditFactor.Enabled := False;
  end
  else
  {$ENDIF}
  SpinEditFactor.Enabled := CheckBoxHiRes.Checked;
end;

procedure TTestRepSetForm.CheckBoxShowObsCChange(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if (VerDiff > 3) and (Sender as TCheckBox).Checked then
  begin
    MessageDlg(VersionMessage, mtError,[mbOK], 0);
    (Sender as TCheckBox).Checked := False;
  end;
  {$ENDIF}
end;

procedure TTestRepSetForm.CheckBoxShowObsMChange(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if (VerDiff > 3) and (Sender as TCheckBox).Checked then
  begin
    MessageDlg(VersionMessage, mtError,[mbOK], 0);
    (Sender as TCheckBox).Checked := False;
  end;
  {$ENDIF}
end;

procedure TTestRepSetForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage1.FileName := GetUserDir + '/.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  with RadioGroup1 do
  begin
    Items[0] := Items[0] + ' [' + LengthUnit + ']';
    Items[1] := Items[1] + ' [' + LengthUnit + ']';
    ItemIndex := 0;
  end;
  MultiStartDateComboBox.Items.Clear;
  MultiEndDateComboBox.Items.Clear;
  MultiEndDateComboBox.Items.Clear;
  ConstStartDateComboBox.Items.Clear;
  ConstEndDateComboBox.Items.Clear;
  ConstEndDateComboBox.Items.Clear;
  PumpingTestQuery.Open; //Fill the time dropdowns
  MultiStartDateComboBox.ItemIndex := 0;
  MultiEndDateComboBox.ItemIndex := 0;
  ConstStartDateComboBox.ItemIndex := 0;
  ConstEndDateComboBox.ItemIndex := 0;
  TestingDetailsQuery.Open;
  WLQuery.Open;
  {$IFDEF WINDOWS}
  if VerDiff > 3 then
  begin
    ColorButtonSeries.Enabled := False;
    ColorButtonSteps.Enabled := False;
    ColorButtonDisch.Enabled := False;
    CheckBoxSeriesShowPoints.Enabled := False;
    CheckBoxStepsShowPoints.Enabled := False;
    CheckBoxDischShowPoints.Enabled := False;
    SpinEditLineThick.Enabled := False;
    MessageDlg('Some settings for this report may only be available in newer Aquabase versions! Please contact Aquabase support for more information.', mtInformation, [mbOK], 0);
  end;
  {$ENDIF}
end;

procedure TTestRepSetForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TTestRepSetForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TTestRepSetForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  PumpingTestQuery.Close;
  CloseAction := caFree;
end;

procedure TTestRepSetForm.MultiDateComboBoxChange(Sender: TObject);
begin
  TestingDetailsQuery.Open; //to change number of available steps
end;

procedure TTestRepSetForm.OKButtonClick(Sender: TObject);
begin
  with TPumpTestRepForm.Create(Application) do
  begin
    LineWidth := SpinEditLineThick.Value;
    SerColr := ColorButtonSeries.ButtonColor;
    StepsColr := ColorButtonSteps.ButtonColor;
    DischColr := ColorButtonDisch.ButtonColor;
    ResFactor := SpinEditFactor.Value;
    SeriesShowPnts := CheckBoxSeriesShowPoints.Checked;
    StepsShowPnts := CheckBoxStepsShowPoints.Checked;
    DischShowPnts := CheckBoxDischShowPoints.Checked;
    MRateStartDate := Copy(MultiStartDateComboBox.Text, 1, 8);
    MRateStartTime := Copy(MultiStartDateComboBox.Text, 10, 4);
    MRateEnddate := Copy(MultiEndDateComboBox.Text, 1, 8);
    MRateEndTime := Copy(MultiEndDateComboBox.Text, 10, 4);
    ConstStartDate := Copy(ConstStartDateComboBox.Text, 1, 8);
    ConstStartTime := Copy(ConstStartDateComboBox.Text, 10, 4);
    ConstEndDate := Copy(ConstEndDateComboBox.Text, 1, 8);
    ConstEndTime := Copy(ConstEndDateComboBox.Text, 10, 4);
    //determine chart titles by using start/end date/times selected
    with PumpingTestQuery do
    begin
      //for multirate and step tests
      Filtered := False;
      Filter := '(METH_TESTD = ' + QuotedStr('M') + ' OR METH_TESTD = ' + QuotedStr('T') + ' OR METH_TESTD = ' + QuotedStr('R') + ' OR METH_TESTD = ' + QuotedStr('C')
          + ') AND (DATE_START+TIME_START >= ' + QuotedStr(MRateStartDate + MRateStartTime) +  ' AND DATE_END+TIME_END <= ' + QuotedStr(MRateEndDate + MRateEndTime) + ')';
      Filtered := True;
      First;
      while not EOF do
      begin
        //check which one to set chart title
        if FieldByName('METH_TESTD').AsString = 'M' then
          MultiTitle := 'Multirate Test'
        else
        if FieldByName('METH_TESTD').AsString = 'T' then
          MultiTitle := 'Step Test'
        else
        if FieldByName('METH_TESTD').AsString = 'C' then
          MultiTitle := 'Calibration Test'
        else
        if FieldByName('METH_TESTD').AsString = 'R' then
        begin
          if MultiTitle = '' then
            MultiTitle := 'Recovery Test'
          else
          MultiTitle := MultiTitle + ' and Recovery';
        end;
        Next;
      end;
      Filtered := False;
      Filter := '(METH_TESTD = ' + QuotedStr('P') + ' OR METH_TESTD = ' + QuotedStr('S') + ' OR METH_TESTD = ' + QuotedStr('R')
          + ') AND (DATE_START+TIME_START >= ' + QuotedStr(ConstStartDate + ConstStartTime) +  ' AND DATE_END+TIME_END <= ' + QuotedStr(ConstEndDate + ConstEndTime) + ')';
      Filtered := True;
      First;
      while not EOF do
      begin
        //check which one to set chart title
        if FieldByName('METH_TESTD').AsString = 'P' then
          ConstantTitle := 'Constant Rate Test'
        else
        if FieldByName('METH_TESTD').AsString = 'S' then
          ConstantTitle := 'Slug Test'
        else
        if FieldByName('METH_TESTD').AsString = 'R' then
        begin
          if ConstantTitle = '' then
            ConstantTitle := 'Recovery Test'
          else
            ConstantTitle := ConstantTitle + ' and Recovery';
        end;
        Next;
      end;
    end; //of PumpingTestQuery
    HiRes := CheckBoxHiRes.Checked;
    DDown := RadioGroup1.ItemIndex = 1;
    ShowMulti := CheckBox1.Checked;
    MultiPiezo := IntToStr(SpinEditPiezM.Value);
    MDischargeQuery.Tag := MDisComboBox.ItemIndex;
    ShowConstant := CheckBoxShowConst.Checked;
    CDischargeQuery.Tag := CDisComboBox.ItemIndex;
    CUseLeft := CUseLeftCheckBox.Checked;
    CUseTime := CUseTimeCheckBox.Checked;
    ChartBandHeight := SpinEditChtHgt.Value;
    ConstLMax := ConstMinSpinEdit.Value;
    ConstLMin := ConstMaxSpinEdit.Value;
    ConstTMax := ConstTMaxSpinEdit.Value;
    ConstTMin := ConstTMinSpinEdit.Value;
    ConstPiezo := IntToStr(SpinEditPiezC.Value);
    ShowAllTests := CheckBoxShowAll.Checked;
    PumpTestReport.Title := TitleEdit.Text;
    WLDateTime := ComboBoxWL.Text;
    RLSystemInfoDate.Visible := DateCheckBox.Checked;
    RLSystemInfoPageNr.Visible := CheckBoxPageNr.Checked;
    CommentMemo.Lines.Clear;
    CommentMemo.Lines.AddStrings(CommentMemo.Lines);
    CommentMemo.Visible := CheckBox4.Checked;
    MLeftAxisTitle := RadioGroup1.Items[RadioGroup1.ItemIndex];
    MUseLeft := MUseLeftCheckBox.Checked;
    MLeftAxisRangeMax := MultiMaxSpinEdit.Value;
    MLeftAxisRangeMin := MultiMinSpinEdit.Value;
    MUseTime := MUseTimeCheckBox.Checked;
    MBottomAxisRangeMax := MultiTMaxSpinEdit.Value;
    MBottomAxisRangeMin := MultiTMinSpinEdit.Value;
    NrSteps := SpinEditSteps.Value;
    WaterlevSubDetail.Visible := CheckBoxShowWL.Checked;
    DischargeSubDetail.Visible := CheckBoxShowDis.Checked;
    try
      Screen.Cursor := crHourGlass;
      with TRepPrevForm.Create(Application) do
      begin
        PumpTestReport.Preview(RLPreview1);
        Show;
      end;
    finally
      Screen.Cursor := crDefault;
      Close;
    end;
  end;
  Close;
end;

procedure TTestRepSetForm.PumpingTestQueryAfterOpen(DataSet: TDataSet);
begin
  with DataSet do
  begin
    //for multirate and step tests
    Filter := 'METH_TESTD = ' + QuotedStr('M') + ' OR METH_TESTD = ' + QuotedStr('T') + ' OR METH_TESTD = ' + QuotedStr('R') + ' OR METH_TESTD = ' + QuotedStr('C');
    Filtered := True;
    First;
    if RecordCount > 0 then
    begin
      while not EOF do
      begin
        if Fields[5].AsString = 'R' then //recovery test
        begin
          if MultiEndDateComboBox.Items.IndexOf(Fields[1].Value + ' ' + Fields[2].Value) > -1 then //if start date/time is in EndDateTime Combobox
          begin
            MultiStartDateComboBox.Items.Add(Fields[1].Value + ' ' + Fields[2].Value);
            MultiEndDateComboBox.Items.Add(Fields[3].Value + ' ' + Fields[4].Value);
          end;
        end
        else
        begin
          MultiStartDateComboBox.Items.Add(Fields[1].Value + ' ' + Fields[2].Value);
          MultiEndDateComboBox.Items.Add(Fields[3].Value + ' ' + Fields[4].Value);
        end;
        Next;
      end;
    end
    else
    begin
      MessageDlg('This site has no multirate, step or calibration test information! Chart not possible.', mtInformation, [mbOK], 0);
      CheckBox1.Checked := False;
      CheckBox1.Enabled := False;
    end;
    Filtered := False;
    Filter := 'METH_TESTD = ' + QuotedStr('P') + ' OR METH_TESTD = ' + QuotedStr('S') + ' OR METH_TESTD = ' + QuotedStr('R');
    Filtered := True;
    First;
    if RecordCount > 0 then
    begin
      while not EOF do
      begin
        if Fields[5].AsString = 'R' then //recovery test
        begin
          if ConstEndDateComboBox.Items.IndexOf(Fields[1].Value + ' ' + Fields[2].Value) > -1 then //if start date/time is in EndDateTime Combobox
          begin
            ConstStartDateComboBox.Items.Add(Fields[1].Value + ' ' + Fields[2].Value);
            ConstEndDateComboBox.Items.Add(Fields[3].Value + ' ' + Fields[4].Value);
          end;
        end
        else
        begin
          ConstStartDateComboBox.Items.Add(Fields[1].Value + ' ' + Fields[2].Value);
          ConstEndDateComboBox.Items.Add(Fields[3].Value + ' ' + Fields[4].Value);
        end;
        Next;
      end;
    end
    else
    begin
      MessageDlg('This site has no constant rate test information! Chart not possible.', mtInformation, [mbOK], 0);
      CheckBoxShowConst.Checked := False;
      CheckBoxShowConst.Enabled := False;
    end;
  end;
end;

procedure TTestRepSetForm.PumpingTestQueryBeforeOpen(DataSet: TDataSet);
begin
  with PumpingTestQuery do
  begin
    Connection := DataModuleMain.ZConnectionDB;
    Params[0].Value := CurrentSite;
  end;
end;

procedure TTestRepSetForm.TestingDetailsQueryAfterOpen(DataSet: TDataSet);
begin
  SpinEditSteps.MaxValue := 0;
  with DataSet do
  begin
    while not EOF do
    begin
      if (Fields[1].AsString + ' ' + Fields[2].AsString > MultiStartDateComboBox.Text)
        and (Fields[1].AsString + ' ' + Fields[2].AsString < MultiEndDateComboBox.Text) then
          SpinEditSteps.MaxValue := SpinEditSteps.MaxValue + 1;
      Next;
    end;
    Close;
  end;
end;

procedure TTestRepSetForm.TestingDetailsQueryBeforeOpen(DataSet: TDataSet);
begin
  with TestingDetailsQuery do
  begin
    Connection := DataModuleMain.ZConnectionDB;
    Params[0].Value := CurrentSite;
  end;
end;

procedure TTestRepSetForm.WLQueryAfterOpen(DataSet: TDataSet);
begin
  with ComboBoxWL do
  begin
    Clear;
    while not WLQuery.EOF do
    begin
      Items.Add(WLQuery.FieldByName('DATE_MEAS').AsString + ' ' + WLQuery.FieldByName('TIME_MEAS').AsString);
      WLQuery.Next;
    end;
    ItemIndex := Items.Count - 1;
  end;
  WLQuery.Close;
end;

procedure TTestRepSetForm.WLQueryBeforeOpen(DataSet: TDataSet);
begin
  WLQuery.Connection := DataModuleMain.ZConnectionDB;
  WLQuery.Params[0].Value := CurrentSite;
end;

end.
