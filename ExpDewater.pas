{ Copyright (C) 2019 Immo Blecher immo@blecher.co.za

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
unit ExpDewater;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ZDataset,
  Buttons, StdCtrls, Db, dbf, ExtCtrls, FileUtil;

type

  { TExpDewaterForm }

  TExpDewaterForm = class(TForm)
    ExportTable: TDbf;
    ExportTableAB_PERC: TFloatField;
    ExportTableAB_PUMP: TFloatField;
    ExportTableAB_TGT: TFloatField;
    ExportTableAV_HRS: TFloatField;
    ExportTableAV_PERC: TFloatField;
    ExportTableAV_TGT: TFloatField;
    ExportTableDRAW_DOWN: TFloatField;
    ExportTableNR_ON_MAP: TStringField;
    ExportTablePR_CALC: TFloatField;
    ExportTablePR_TGT: TFloatField;
    ExportTablePR_VAR: TFloatField;
    ExportTableUT_HRS: TFloatField;
    ExportTableUT_PERC: TFloatField;
    ExportTableUT_TGT: TFloatField;
    ExportTableWATER_DEPTH: TFloatField;
    ExportTableWATER_TABL: TFloatField;
    SaveDewExDialog: TSaveDialog;
    GroupBox2: TGroupBox;
    Edit1: TEdit;
    Button1: TButton;
    OkBtn: TBitBtn;
    BitBtn2: TBitBtn;
    ExportQuery: TZQuery;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    Label9: TLabel;
    StartDateComboBox: TComboBox;
    EndDateComboBox: TComboBox;
    OpenFilterDialog: TOpenDialog;
    BasicinfTable: TZTable;
    BasicinfTableSITE_ID_NR: TStringField;
    BasicinfTableNR_ON_MAP: TStringField;
    BasicinfTableFARM_NR: TStringField;
    BasicinfTableSITE_NAME: TStringField;
    BasicinfTableY_COORD: TFloatField;
    BasicinfTableX_COORD: TFloatField;
    BasicinfTableCOORD_ACC: TStringField;
    BasicinfTableALTITUDE: TFloatField;
    BasicinfTableSITE_TYPE: TStringField;
    BasicinfTableCOLLAR_HI: TFloatField;
    BasicinfTableDEPTH: TFloatField;
    BasicinfTableDATE_UPDTD: TStringField;
    BasicinfTableNGDB_FLAG: TSmallintField;
    BasicinfDataSource: TDataSource;
    FilterTable: TZTable;
    FilterDataSource: TDataSource;
    LinkedDataSource: TDataSource;
    LinkedTable: TZTable;
    LinkedTableTARG_TYPE: TStringField;
    LinkedTableSITE_ID_NR: TStringField;
    LinkedTableREADING: TFloatField;
    dtsMread: TDataSource;
    tblMread: TZTable;
    tblMreadSITE_ID_NR: TStringField;
    tblMreadREP_INST: TStringField;
    tblMreadSOURCE: TStringField;
    tblMreadDATE_ENTRY: TStringField;
    tblMreadTYPE_MEAS: TStringField;
    tblMreadUNIT_MEAS: TStringField;
    tblMreadDATE_MEAS: TStringField;
    tblMreadTIME_MEAS: TStringField;
    tblMreadREADING: TFloatField;
    tblMreadCOMMENT: TStringField;
    tblMreadNGDB_HEADR: TSmallintField;
    tblMreadNGDB_REPEA: TSmallintField;
    tblMreadNGDB_FLAG: TSmallintField;
    qryValidCheck: TZQuery;
    LinkedTableV_DATE_F: TStringField;
    Panel1: TPanel;
    FilterName: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    ComboBox1: TComboBox;
    SpeedButton1: TSpeedButton;
    BitBtn1: TBitBtn;
    procedure StartDateComboBoxExit(Sender: TObject);
    procedure EndDateComboBoxExit(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    ExportFileDir : String;
    ExportFileName : String;
    ExcelFle : Boolean;
    totDays : Real;
  public
    { Public declarations }
  end;

var
  ExpDewaterForm: TExpDewaterForm;

implementation

{$R *.lfm}
uses Strdatetime, varinit, MainDataModule;

procedure TExpDewaterForm.StartDateComboBoxExit(Sender: TObject);
begin
  if not ValidDate(StartDateComboBox.Text) then
  begin
    MessageDlg('Invalid date entered!', mtError, [mbOK], 0);
    StartDateComboBox.SetFocus;
  end;
end;

procedure TExpDewaterForm.EndDateComboBoxExit(Sender: TObject);
begin
  if not ValidDate(EndDateComboBox.Text) then
  begin
    MessageDlg('Invalid date entered!', mtError, [mbOK], 0);
    EndDateComboBox.SetFocus;
  end;
end;

procedure TExpDewaterForm.SpeedButton1Click(Sender: TObject);
begin
  if OpenFilterDialog.Execute then
  begin
    FilterTable.Connection := DataModuleMain.ZConnectionDB;
    FilterTable.TableName := OpenFilterDialog.FileName;
    FilterName.Caption := ExtractFileName(OpenFilterDialog.FileName);
  end;
end;

procedure TExpDewaterForm.ComboBox1Change(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
  0 : begin
        FilterName.Caption := CurrentSite;
        SpeedButton1.Visible := False;
      end;
  1 : begin
        FilterName.Caption := '';
        SpeedButton1.Visible := true;
       if FilterName.Caption = '' then
       begin
        FilterTable.Connection := DataModuleMain.ZConnectionDB;
        FilterTable.TableName := 'allsites';
        FilterName.Caption := 'allsites';
       end;
      end;
  end; //case
end;

procedure TExpDewaterForm.Button1Click(Sender: TObject);

var ExportFileExt : String;

begin
  ExcelFle := false;
  if SaveDewExDialog.Execute then
  begin
   with ExportTable do
   begin
    ExportFileDir := ExtractFileDir(SaveDewExDialog.FileName);
    ExportFileName := ExtractFileName(SaveDewExDialog.FileName);
    ExportFileExt := ExtractFileExt(SaveDewExDialog.FileName);
    if Uppercase(ExportFileExt) = '.DBF' then
    begin
      FilePath := ExportFileDir;
      TableName := ExportFileName;
      Edit1.Text := ExportFileDir + '\' + ExportFileName;
    end; //else
    CreateTable;
   end; //with
  end; //if
  Okbtn.Enabled := Edit1.Text <> '';
end;

procedure TExpDewaterForm.OkBtnClick(Sender: TObject);

var CurrentSiteExp : String;
    HrsFirst, HrsLast, M3First, M3Last, DivValue1, DivValue2 : Real;

begin
try
  totDays := StringToDate(EndDateComboBox.text) - StringToDate(StartDateComboBox.text);
  BasicinfTable.Open;
  LinkedTable.Open;
  tblMRead.Open;
  ExportTable.FilePath := ExportFileDir;
  ExportTable.Open;
  if ComboBox1.ItemIndex = 0 then
  begin
    BasicInftable.Filter := 'SITE_ID_NR = ' + '''' + CurrentSite + '''';
    BasicInfTable.Filtered := true;
    ExportQuery.Close;
    ExportQuery.Sql.Clear;
    ExportQuery.SQL.Add('SELECT DISTINCT SITE_ID_NR, DATE_MEAS, TIME_MEAS, TYPE_MEAS, READING ');
    ExportQuery.SQL.Add('FROM mreading WHERE (SITE_ID_NR = ' + QuotedStr(CurrentSite) + ') ');
    ExportQuery.SQL.Add('AND (DATE_MEAS >= ' + QuotedStr(StartDateComboBox.Text) + ')');
    ExportQuery.SQL.Add('AND (DATE_MEAS <= ' + QuotedStr(EndDateComboBox.Text) + ')');
    ExportQuery.SQL.Add('AND (TYPE_MEAS = ' + QuotedStr('T') + ')');
    ExportQuery.SQL.Add('ORDER BY DATE_MEAS, TIME_MEAS');
    ExportQuery.Open;
    ExportTable.Insert;
    ExportTableNR_ON_MAP.Value := BasicInfTableNR_ON_MAP.Value;
    //ExportTablePriority
    ExportTableWATER_DEPTH.Value := BasicInfTableDEPTH.Value;
    ExportTableWATER_TABL.Value := BasicInfTableALTITUDE.Value - BasicInfTableDEPTH.Value;
    //ExportTableDRAW_DOWN
    //ExportTableRUN
    ExportQuery.First;
    HrsFirst := ExportQuery.FieldByName('READING').AsFloat;
    ExportQuery.Last;
    HrsLast := ExportQuery.FieldByName('READING').AsFloat;
    ExportTableUT_HRS.Value := HrsLast - HrsFirst;
    ExportTableAV_HRS.Value := HrsLast - HrsFirst;
    qryValidCheck.Close;
    qryValidCheck.Sql.Clear;
    qryValidCheck.SQL.Add('SELECT DISTINCT SITE_ID_NR, V_DATE_F, TARG_TYPE, READING ');
    qryValidCheck.SQL.Add('FROM targets_ WHERE (SITE_ID_NR = ' + QuotedStr(CurrentSite) + ') ');
    qryValidCheck.SQL.Add('AND (V_DATE_F <= ' +  QuotedStr(StartDateComboBox.Text) + ') ');
    qryValidCheck.SQL.Add('AND (TARG_TYPE = ' + QuotedStr('UT') + ') ');
    qryValidCheck.SQL.Add('ORDER BY V_DATE_F');
    qryValidCheck.Open;
    qryValidCheck.Last;
    if qryValidCheck.RecordCount > 0 then
       ExportTableUT_TGT.Value := qryValidCheck.FieldByName('READING').Value*totDays;
    qryValidCheck.Close;
    qryValidCheck.Sql.Clear;
    qryValidCheck.SQL.Add('SELECT DISTINCT SITE_ID_NR, V_DATE_F, TARG_TYPE, READING ');
    qryValidCheck.SQL.Add('FROM targets_ WHERE (SITE_ID_NR = ' + QuotedStr(CurrentSite) + ') ');
    qryValidCheck.SQL.Add('AND (V_DATE_F <= ' +  QuotedStr(StartDateComboBox.Text) + ') ');
    qryValidCheck.SQL.Add('AND (TARG_TYPE = ' + QuotedStr('AV') + ') ');
    qryValidCheck.SQL.Add('ORDER BY V_DATE_F');
    qryValidCheck.Open;
    qryValidCheck.Last;
    if qryValidCheck.RecordCount > 0 then
       ExportTableAV_TGT.Value := qryValidCheck.FieldByName('READING').Value*totDays;
    qryValidCheck.Close;
    qryValidCheck.Sql.Clear;
    qryValidCheck.SQL.Add('SELECT DISTINCT SITE_ID_NR, V_DATE_F, TARG_TYPE, READING ');
    qryValidCheck.SQL.Add('FROM targets_ WHERE (SITE_ID_NR = ' + QuotedStr(CurrentSite) + ') ');
    qryValidCheck.SQL.Add('AND (V_DATE_F <= ' +  QuotedStr(StartDateComboBox.Text) + ') ');
    qryValidCheck.SQL.Add('AND (TARG_TYPE = ' + QuotedStr('AB') + ') ');
    qryValidCheck.SQL.Add('ORDER BY V_DATE_F');
    qryValidCheck.Open;
    qryValidCheck.Last;
    if qryValidCheck.RecordCount > 0 then
       ExportTableAB_TGT.Value := qryValidCheck.FieldByName('READING').Value*VolumeFactor*TimeFactor*(24*totDays);
    qryValidCheck.Close;
    qryValidCheck.Sql.Clear;
    qryValidCheck.SQL.Add('SELECT DISTINCT SITE_ID_NR, V_DATE_F, TARG_TYPE, READING ');
    qryValidCheck.SQL.Add('FROM targets_ WHERE (SITE_ID_NR = ' + QuotedStr(CurrentSite) + ') ');
    qryValidCheck.SQL.Add('AND (V_DATE_F <= ' + QuotedStr(StartDateComboBox.Text) + ') ');
    qryValidCheck.SQL.Add('AND (TARG_TYPE = ' + QuotedStr('DD') + ') ');
    qryValidCheck.SQL.Add('ORDER BY V_DATE_F');
    qryValidCheck.Open;
    qryValidCheck.Last;
    if qryValidCheck.RecordCount > 0 then
      ExportTableDRAW_DOWN.Value := qryValidCheck.FieldByName('READING').Value-BasicInfTableDEPTH.Value;

    if ExportTableUT_TGT.AsFloat <> 0 then
      ExportTablePR_TGT.Value := ExportTableAB_TGT.AsFloat/ExportTableUT_TGT.AsFloat;

    ExportQuery.Close;
    ExportQuery.Sql.Clear;
    ExportQuery.SQL.Add('SELECT DISTINCT SITE_ID_NR, DATE_MEAS, TIME_MEAS, TYPE_MEAS, READING ');
    ExportQuery.SQL.Add('FROM mreading WHERE (SITE_ID_NR = ' + QuotedStr(CurrentSite) + ') ');
    ExportQuery.SQL.Add('AND (DATE_MEAS >= ' + QuotedStr(StartDateComboBox.Text) + ')');
    ExportQuery.SQL.Add('AND (DATE_MEAS <= ' + QuotedStr(EndDateComboBox.Text) + ')');
    ExportQuery.SQL.Add('AND (TYPE_MEAS = ' + QuotedStr('M') + ')');
    ExportQuery.SQL.Add('ORDER BY DATE_MEAS, TIME_MEAS');
    ExportQuery.Open;
    ExportQuery.First;
    M3First := ExportQuery.FieldByName('READING').AsFloat;
    ExportQuery.Last;
    M3Last := ExportQuery.FieldByName('READING').AsFloat;
    ExportTableAB_PUMP.Value := M3Last - M3First;
    DivValue1 := ExportTableAB_PUMP.AsFloat;
    DivValue2 := ExportTableAV_HRS.AsFloat;
    if DivValue2 > 0 then
    ExportTablePR_CALC.Value := DivValue1/DivValue2;
    DivValue1 := ExportTableUT_HRS.AsFloat;
    DivValue2 := ExportTableUT_TGT.AsFloat;
    if DivValue2 > 0 then
    ExportTableUT_PERC.Value := round(DivValue1/DivValue2*100);
    DivValue1 := ExportTableAV_HRS.AsFloat;
    DivValue2 := ExportTableAV_TGT.AsFloat;
    if DivValue2 > 0 then
    ExportTableAV_PERC.Value := round(DivValue1/DivValue2*100);
    DivValue1 := ExportTableAB_PUMP.AsFloat;
    DivValue2 := ExportTableAB_TGT.AsFloat;
    if DivValue2 > 0 then
    ExportTableAB_PERC.Value := round(DivValue1/DivValue2*100);
    ExportTablePR_VAR.Value := ExportTablePR_CALC.AsFloat-ExportTablePR_TGT.AsFloat;
    ExportTable.Post;
  end
  else
  begin
    FilterTable.Open;
    FilterTable.First;
    while not FilterTable.Eof do
    begin
      CurrentSiteExp := FilterTable.FieldByName('SITE_ID_NR').AsString;
      ExportQuery.Close;
      ExportQuery.Sql.Clear;
      ExportQuery.SQL.Add('SELECT DISTINCT SITE_ID_NR, DATE_MEAS, TIME_MEAS, TYPE_MEAS, READING ');
      ExportQuery.SQL.Add('FROM mreading WHERE (SITE_ID_NR = ' + QuotedStr(CurrentSiteExp) + ') ');
      ExportQuery.SQL.Add('AND (DATE_MEAS >= ' + QuotedStr(StartDateComboBox.Text) + ')');
      ExportQuery.SQL.Add('AND (DATE_MEAS <= ' + QuotedStr(EndDateComboBox.Text) + ')');
      ExportQuery.SQL.Add('AND (TYPE_MEAS = ' + QuotedStr('T') + ')');
      ExportQuery.SQL.Add('ORDER BY DATE_MEAS, TIME_MEAS');
      ExportQuery.Open;
      ExportTable.Insert;
      ExportTableNR_ON_MAP.Value := BasicInfTableNR_ON_MAP.Value;
      //ExportTablePriority
      ExportTableWATER_DEPTH.Value := BasicInfTableDEPTH.Value;
      ExportTableWATER_TABL.Value := BasicInfTableALTITUDE.Value - BasicInfTableDEPTH.Value;
      //ExportTableDRAW_DOWN
      //ExportTableRUN
      ExportQuery.First;
      HrsFirst := 0;
      HrsLast := 0;
      ExportQuery.FieldByName('SITE_ID_NR').Value;
      HrsFirst := ExportQuery.FieldByName('READING').AsFloat;
      ExportQuery.Last;
      HrsLast := ExportQuery.FieldByName('READING').AsFloat;
      ExportTableUT_HRS.Value := HrsLast - HrsFirst;
      ExportTableAV_HRS.Value := HrsLast - HrsFirst;
      qryValidCheck.Close;
      qryValidCheck.Sql.Clear;
      qryValidCheck.SQL.Add('SELECT DISTINCT SITE_ID_NR, V_DATE_F, TARG_TYPE, READING ');
      qryValidCheck.SQL.Add('FROM targets_ WHERE (SITE_ID_NR = ' + '''' + CurrentSiteExp + '''' + ') ');
      qryValidCheck.SQL.Add('AND (V_DATE_F <= ' +  '''' + StartDateComboBox.Text + ''''+ ') ');
      qryValidCheck.SQL.Add('AND (TARG_TYPE = ' + '''' + 'UT' + '''' + ') ');
      qryValidCheck.SQL.Add('ORDER BY V_DATE_F');
      qryValidCheck.Open;
      qryValidCheck.Last;
      if qryValidCheck.RecordCount > 0 then
         ExportTableUT_TGT.Value := qryValidCheck.FieldByName('READING').Value*totDays;
      qryValidCheck.Close;
      qryValidCheck.Sql.Clear;
      qryValidCheck.SQL.Add('SELECT DISTINCT SITE_ID_NR, V_DATE_F, TARG_TYPE, READING ');
      qryValidCheck.SQL.Add('FROM targets_ WHERE (SITE_ID_NR = ' + '''' + CurrentSiteExp + '''' + ') ');
      qryValidCheck.SQL.Add('AND (V_DATE_F <= ' +  '''' + StartDateComboBox.Text + ''''+ ') ');
      qryValidCheck.SQL.Add('AND (TARG_TYPE = ' + '''' + 'AV' + '''' + ') ');
      qryValidCheck.SQL.Add('ORDER BY V_DATE_F');
      qryValidCheck.Open;
      qryValidCheck.Last;
      if qryValidCheck.RecordCount > 0 then
         ExportTableAV_TGT.Value := qryValidCheck.FieldByName('READING').Value*totDays;
      qryValidCheck.Close;
      qryValidCheck.Sql.Clear;
      qryValidCheck.SQL.Add('SELECT DISTINCT SITE_ID_NR, V_DATE_F, TARG_TYPE, READING ');
      qryValidCheck.SQL.Add('FROM targets_ WHERE (SITE_ID_NR = ' + '''' + CurrentSiteExp + '''' + ') ');
      qryValidCheck.SQL.Add('AND (V_DATE_F <= ' +  '''' + StartDateComboBox.Text + ''''+ ') ');
      qryValidCheck.SQL.Add('AND (TARG_TYPE = ' + '''' + 'AB' + '''' + ') ');
      qryValidCheck.SQL.Add('ORDER BY V_DATE_F');
      qryValidCheck.Open;
      qryValidCheck.Last;
      if qryValidCheck.RecordCount > 0 then
         ExportTableAB_TGT.Value := qryValidCheck.FieldByName('READING').Value*VolumeFactor*TimeFactor*(24*totDays);
      qryValidCheck.Close;
      qryValidCheck.Sql.Clear;
      qryValidCheck.SQL.Add('SELECT DISTINCT SITE_ID_NR, V_DATE_F, TARG_TYPE, READING ');
      qryValidCheck.SQL.Add('FROM targets_ WHERE (SITE_ID_NR = ' + '''' + CurrentSiteExp + '''' + ') ');
      qryValidCheck.SQL.Add('AND (V_DATE_F <= ' +  '''' + StartDateComboBox.Text + ''''+ ') ');
      qryValidCheck.SQL.Add('AND (TARG_TYPE = ' + '''' + 'DD' + '''' + ') ');
      qryValidCheck.SQL.Add('ORDER BY V_DATE_F');
      qryValidCheck.Open;
      qryValidCheck.Last;
      if qryValidCheck.RecordCount > 0 then
        ExportTableDRAW_DOWN.Value := qryValidCheck.FieldByName('READING').Value-BasicInfTableDEPTH.Value;

      if ExportTableUT_TGT.AsFloat <> 0 then
        ExportTablePR_TGT.Value := ExportTableAB_TGT.AsFloat/ExportTableUT_TGT.AsFloat;

      ExportQuery.Close;
      ExportQuery.Sql.Clear;
      ExportQuery.SQL.Add('SELECT DISTINCT SITE_ID_NR, DATE_MEAS, TIME_MEAS, TYPE_MEAS, READING ');
      ExportQuery.SQL.Add('FROM mreading WHERE (SITE_ID_NR = ' + '''' + CurrentSiteExp + '''' + ') ');
      ExportQuery.SQL.Add('AND (DATE_MEAS >= ' + '''' + StartDateComboBox.Text + '''' + ')');
      ExportQuery.SQL.Add('AND (DATE_MEAS <= ' + '''' + EndDateComboBox.Text + '''' + ')');
      ExportQuery.SQL.Add('AND (TYPE_MEAS = ' + '''' + 'M' + '''' + ')');
      ExportQuery.SQL.Add('ORDER BY DATE_MEAS, TIME_MEAS');
      ExportQuery.Open;
      ExportQuery.First;
      M3First := ExportQuery.FieldByName('READING').AsFloat;
      ExportQuery.Last;
      M3Last := ExportQuery.FieldByName('READING').AsFloat;
      ExportTableAB_PUMP.Value := M3Last - M3First;
      DivValue1 := 0;
      DivValue2 := 0;
      DivValue1 := ExportTableAB_PUMP.AsFloat;
      DivValue2 := ExportTableAV_HRS.AsFloat;
      if DivValue2 <> 0 then
       ExportTablePR_CALC.Value := DivValue1/DivValue2;
      DivValue1 := 0;
      DivValue2 := 0;
      DivValue1 := ExportTableUT_HRS.AsFloat;
      DivValue2 := ExportTableUT_TGT.AsFloat;
      if DivValue2 <> 0 then
       ExportTableUT_PERC.Value := round(DivValue1/DivValue2*100);
      DivValue1 := 0;
      DivValue2 := 0;
      DivValue1 := ExportTableAV_HRS.AsFloat;
      DivValue2 := ExportTableAV_TGT.AsFloat;
      if DivValue2 <> 0 then
       ExportTableAV_PERC.Value := round(DivValue1/DivValue2*100);
      DivValue1 := 0;
      DivValue2 := 0;
      DivValue1 := ExportTableAB_PUMP.AsFloat;
      DivValue2 := ExportTableAB_TGT.AsFloat;
      if DivValue2 <> 0 then
       ExportTableAB_PERC.Value := round(DivValue1/DivValue2*100);
      ExportTablePR_VAR.Value := ExportTablePR_CALC.AsFloat-ExportTablePR_TGT.AsFloat;
      ExportTable.Post;
      FilterTable.Next;
    end;//while - FilterTable
  end;//else
  if MessageDlg('Data was successfully exported to: ' + ExportFileName , mtInformation, [mbOK],-1) = mrOk then
    close;
except
  if MessageDlg('There were errors exporting the data!' , mtError, [mbOK],-1) = mrOk then
    close;
end;
end;

procedure TExpDewaterForm.BitBtn2Click(Sender: TObject);

begin
  if Edit1.Text <> '' then
  begin
    DeleteFile(ExportFileDir + DirectorySeparator + ExportFileName);
  end;
  ExportQuery.Close;
  qryValidCheck.Close;
  LinkedTable.Close;
  tblMRead.Close;
  ExportTable.close;
  BasicinfTable.Close;
  FilterTable.Close;
  close;
end;

procedure TExpDewaterForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TExpDewaterForm.FormActivate(Sender: TObject);
begin
 if ComboBox1.Text = 'Current Site' then
  FilterName.Caption := CurrentSite;
end;

procedure TExpDewaterForm.FormCreate(Sender: TObject);
begin
  BasicInfTable.Connection := DataModuleMain.ZConnectionDB;
  LinkedTable.Connection := DataModuleMain.ZConnectionDB;
  tblMread.Connection := DataModuleMain.ZConnectionDB;
  ExportQuery.Connection := DataModuleMain.ZConnectionDB;
  qryValidCheck.Connection := DataModuleMain.ZConnectionDB;
  EndDateComboBox.Text := FormatDateTime('YYYYMMDD', Date);
  ComboBox1.ItemIndex := 0;
end;

procedure TExpDewaterForm.Edit1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  Edit1.Hint := Edit1.Text;
end;

procedure TExpDewaterForm.BitBtn1Click(Sender: TObject);
begin
  Application.HelpKeyword('Export');
end;

end.
