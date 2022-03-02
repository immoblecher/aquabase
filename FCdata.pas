unit FCdata;

{$MODE Delphi}

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, DB, SdfData, ComCtrls, ButtonPanel, ZDataset;

type

  { TfrmFCdata }

  TfrmFCdata = class(TForm)
    ButtonPanel1: TButtonPanel;
    FCDataSetCOMMENTS: TStringField;
    FCDataSetDATE_MEAS: TStringField;
    FCDataSetLEVEL_STAT: TStringField;
    FCDataSetPUMPTIME: TFloatField;
    FCDataSetPUMP_LEV: TFloatField;
    FCDataSetREC_LEV: TFloatField;
    FCDataSetREC_TIME: TFloatField;
    FCDataSetSITE_ID_NR: TStringField;
    FCDataSetSTATICWL: TFloatField;
    FCDataSetTIME_MEAS: TStringField;
    FCDataSetWATER_LEV: TFloatField;
    GroupBox2: TGroupBox;
    Edit1: TEdit;
    Button1: TButton;
    SaveDialog: TSaveDialog;
    FCDataSet: TSdfDataSet;
    tblBasicinf: TZTable;
    tblWLev: TZTable;
    tblDisch: TZTable;
    tblAquifer: TZTable;
    tblPumpt: TZTable;
    tblRecommend: TZTable;
    dtsBasic: TDataSource;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    StartDateComboBox: TComboBox;
    StartTimeComboBox: TComboBox;
    EndDateComboBox: TComboBox;
    EndTimeComboBox: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    cdStatic: TComboBox;
    Edit2: TEdit;
    lbTime: TLabel;
    ProgressBar1: TProgressBar;
    procedure Button1Click(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    function OpenTable(pTable:TZTable):Boolean;
    procedure FormActivate(Sender: TObject);
    procedure FindStatic;
    procedure cdStaticChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFCdata: TfrmFCdata;

implementation

uses VARINIT, MainDataModule;

{$R *.lfm}

function TfrmFCData.OpenTable(pTable:TZTable):Boolean;
begin
  with pTable do
  begin
    Connection := DataModuleMain.ZConnectionDB;
    Filter := 'SITE_ID_NR = ''' + CurrentSite + '''';
    Filtered := True;
    Open;
    Result := Active;
  end;
end;

procedure TfrmFCdata.Button1Click(Sender: TObject);
begin
  SaveDialog.Title := 'Save to Excel CSV';
  SaveDialog.InitialDir := WSpaceDir;
  if SaveDialog.Execute then
  begin
    edit1.Text := SaveDialog.FileName;
    ButtonPanel1.OKButton.Enabled := Edit1.Text > '';
    FCDataSet.FileName := Savedialog.FileName;
  end;
end;

procedure TfrmFCdata.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmFCdata.OKButtonClick(Sender: TObject);
var pQuery : TZQuery;
    firstrecovery : Boolean;
    firstrecdate, firstrectime : string;
begin
  pQuery := TZQuery.Create(nil);
  pQuery.Connection := DataModuleMain.ZConnectionDB;
  with pQuery do
  begin
    SQL.Clear;
    SQL.Add('Select DATE_MEAS, TIME_MEAS, WATER_LEV, LEVEL_STAT from waterlev');
    SQL.Add('WHERE (DATE_MEAS + TIME_MEAS >= ''' + StartDateComboBox.Text + StartTimeComboBox.Text + '''' + ')');
    SQL.Add('AND (DATE_MEAS + TIME_MEAS <= ''' + EndDateComboBox.Text + EndTimeComboBox.Text + '''' + ')');
    SQL.Add('AND SITE_ID_NR = ' + QuotedStr(CurrentSite));
    SQL.Add('ORDER BY DATE_MEAS, TIME_MEAS');
  end;
  pQuery.Open;
  ProgressBar1.Visible := True;
  firstrecovery := true;
  ProgressBar1.Position := 0;
  ProgressBar1.Max := pQuery.RecordCount;
  FCDataSet.SaveFileAs(SaveDialog.FileName);
  FCDataSet.Open;
  FCDataSet.Insert;
  FCDataSetSITE_ID_NR.Value := CurrentSite;
  FCDataSetDATE_MEAS.Value := cdStatic.Text;
  FCDataSetTIME_MEAS.Value := lbTime.Caption;
  FCDataSetWATER_LEV.Value := StrToFloat(Edit2.Text);
  FCDataSet.Post;
  pQuery.First;
  while not pQuery.Eof do
  begin
    ProgressBar1.Position := ProgressBar1.Position + 1;
    FCDataSet.Insert;
    FCDataSetSITE_ID_NR.Value := CurrentSite;
    FCDataSetDATE_MEAS.Value := pQuery.FieldByName('DATE_MEAS').Value;
    FCDataSetTIME_MEAS.Value := pQuery.FieldByName('TIME_MEAS').Value;
    FCDataSetWATER_LEV.AsFloat := pQuery.FieldByName('WATER_LEV').AsFloat;
    FCDataSetLEVEL_STAT.Value := pQuery.FieldByName('LEVEL_STAT').Value;
    FCDataSetCOMMENTS.Value := pQuery.FieldByName('COMMENT').Value;
    if pQuery.FieldByName('LEVEL_STAT').Value = 'S' then
      FCDataSetSTATICWL.Value := pQuery.FieldByName('WATER_LEV').Value;
    if pQuery.FieldByName('LEVEL_STAT').Value = 'P' then
    begin
      FCDataSetPUMP_LEV.AsFloat := pQuery.FieldByName('WATER_LEV').AsFloat - StrToFloat(Edit2.Text);
      if StartDateComboBox.Text <> pQuery.FieldByName('DATE_MEAS').Value then
      begin
        if pQuery.FieldByName('DATE_MEAS').AsInteger - StrToInt(StartDateCombobox.Text) = 1 then
          FCDataSetPUMPTIME.Value := (StrToFloat(pQuery.FieldByName('TIME_MEAS').Value) + 2400) - StrToFloat(StartDateCombobox.Text)
        else if pQuery.FieldByName('DATE_MEAS').AsInteger - StrToInt(StartDateCombobox.Text) = 2 then
          FCDataSetPUMPTIME.Value := (StrToFloat(pQuery.FieldByName('TIME_MEAS').Value) + 4800) - StrToFloat(StartDateCombobox.Text)
        else if pQuery.FieldByName('DATE_MEAS').AsInteger - StrToInt(StartDateCombobox.Text) = 3 then
          FCDataSetPUMPTIME.Value := (StrToFloat(pQuery.FieldByName('TIME_MEAS').Value) + 7200) - StrToFloat(StartDateCombobox.Text);
      end
      else
        FCDataSetPUMPTIME.Value := StrToFloat(pQuery.FieldByName('TIME_MEAS').Value) - StrToFloat(StartTimeComboBox.Text);
    end
    else if pQuery.FieldByName('LEVEL_STAT').Value = 'R' then
    begin
      if firstrecovery then
      begin
        firstrecdate := pQuery.FieldByName('DATE_MEAS').Value;
        firstrectime := pQuery.FieldByName('TIME_MEAS').Value;
        firstrecovery := false;
      end;
      FCDataSetREC_LEV.Value := pQuery.FieldByName('WATER_LEV').Value - StrToFloat(Edit2.Text);
      if firstrecdate <> pQuery.FieldByName('DATE_MEAS').Value then
      begin
        if pQuery.FieldByName('DATE_MEAS').AsInteger - StrToInt(firstrecdate) = 1 then
          FCDataSetREC_TIME.Value := (StrToFloat(pQuery.FieldByName('TIME_MEAS').Value) + 2400) - StrToFloat(firstrectime)
        else if pQuery.FieldByName('DATE_MEAS').AsInteger - StrToInt(firstrecdate) = 2 then
          FCDataSetREC_TIME.Value := (StrToFloat(pQuery.FieldByName('TIME_MEAS').Value) + 4800) - StrToFloat(firstrectime)
        else if pQuery.FieldByName('DATE_MEAS').AsInteger - StrToInt(firstrecdate) = 3 then
          FCDataSetREC_TIME.Value := (StrToFloat(pQuery.FieldByName('TIME_MEAS').Value) + 7200) - StrToFloat(firstrectime);
      end
      else
        FCDataSetREC_TIME.Value := StrToFloat(pQuery.FieldByName('TIME_MEAS').Value) - StrToFloat(firstrectime);
    end;
    FCDataSet.Post;
    pQuery.Next;
  end;
  pQuery.Close;
  if MessageDlg('Finished exporting data!', mtInformation, [mbOk], 0) = mrOk then
    Close;
end;

procedure TfrmFCdata.FormActivate(Sender: TObject);

var m: integer;

begin
  ReadINIFile;
  OpenTable(tblBasicinf);
  OpenTable(tblWLev);
  OpenTable(tblDisch);
  OpenTable(tblAquifer);
  OpenTable(tblPumpt);
  OpenTable(tblRecommend);
  if tblPumpT.RecordCount > 0 then
  begin
    StartDateComboBox.Items.Clear;
    StartTimeComboBox.Items.Clear;
    EndDateComboBox.Items.Clear;
    EndDateComboBox.Items.Clear;
  end;
  for m := 0 to tblPumpT.RecordCount - 1 do
  begin
    if StartDateComboBox.Items.IndexOf(tblPumpT.FieldByName('DATE_START').Value) = -1
      then StartDateComboBox.Items.Add(tblPumpT.FieldByName('DATE_START').Value);
    if StartTimeComboBox.Items.IndexOf(tblPumpT.FieldByName('TIME_START').Value) = -1
      then StartTimeComboBox.Items.Add(tblPumpT.FieldByName('TIME_START').Value);
    if EndDateComboBox.Items.IndexOf(tblPumpT.FieldByName('DATE_END').Value) = -1
      then EndDateComboBox.Items.Add(tblPumpT.FieldByName('DATE_END').Value);
    if EndTimeComboBox.Items.IndexOf(tblPumpT.FieldByName('TIME_END').Value) = -1
      then EndTimeComboBox.Items.Add(tblPumpT.FieldByName('TIME_END').Value);
    tblPumpT.Next;
  end;
  if StartDateComboBox.Items.Count > 0 then
  begin
    StartDateComboBox.Text := StartDateComboBox.Items[0];
    StartTimeComboBox.Text := StartTimeComboBox.Items[0];
    EndDateComboBox.Text := EndDateComboBox.Items[0];
    EndTimeComboBox.Text := EndTimeComboBox.Items[0];
    FindStatic;
  end
  else
    MessageDlg('Now data found!' ,MTError ,[MbOk],0);
end;

procedure TfrmFCData.FindStatic;

var m,n: integer;

begin
  n := 0;
  for m := 0 to tblWLev.RecordCount - 1 do
  begin
    if tblWLev.FieldByName('LEVEL_STAT').Value = 'S' then
    begin
      cdStatic.Items.Add(tblWLev.FieldByName('DATE_MEAS').AsString);
      if n = 0 then
      begin
        Edit2.Text := tblWLev.FieldByName('WATER_LEV').AsString;
        lbTime.Caption := tblWLev.FieldByName('TIME_MEAS').AsString;
        n := 1;
      end;
    end;    
    tblWLev.Next;
  end;
  if cdStatic.Items.Count > 0 then
    cdStatic.ItemIndex := 0
  else
    Edit2.Text := InputBox('Static Water Level',
    'No static water level available from database, Please enter:','0');
end;
procedure TfrmFCdata.cdStaticChange(Sender: TObject);

var m: integer;

begin
  tblWLev.First;
  for m := 0 to tblWLev.RecordCount - 1 do
  begin
    if (tblWLev.FieldByName('DATE_MEAS').AsString = cdStatic.Text) and
       (tblWLev.FieldByName('LEVEL_STAT').Value = 'S') then
    begin
       edit2.Text := tblWLev.FieldByName('WATER_LEV').AsString;
       lbTime.Caption := tblWLev.FieldByName('TIME_MEAS').AsString;
    end;
    tblWLev.Next;
  end;
end;

procedure TfrmFCdata.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
