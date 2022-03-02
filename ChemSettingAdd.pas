unit ChemSettingAdd;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms, ZDataset,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, DB, Buttons;

type
  TSetAddChem = class(TForm)
    dtsConfig: TDataSource;
    tblConfig: TZTable;
    Panel1: TPanel;
    PageControl: TPageControl;
    TSChm6: TTabSheet;
    LT6P1: TLabel;
    LT6P8: TLabel;
    LT6P15: TLabel;
    LT6P16: TLabel;
    LT6P9: TLabel;
    LT6P2: TLabel;
    LT6P3: TLabel;
    LT6P10: TLabel;
    LT6P17: TLabel;
    LT6P18: TLabel;
    LT6P11: TLabel;
    LT6P4: TLabel;
    LT6P5: TLabel;
    LT6P12: TLabel;
    LT6P19: TLabel;
    LT6P20: TLabel;
    LT6P13: TLabel;
    LT6P6: TLabel;
    LT6P7: TLabel;
    LT6P14: TLabel;
    LT6P21: TLabel;
    TSChm7: TTabSheet;
    LT7P20: TLabel;
    LT7P21: TLabel;
    LT7P14: TLabel;
    LT7P7: TLabel;
    LT7P1: TLabel;
    LT7P2: TLabel;
    LT7P3: TLabel;
    LT7P4: TLabel;
    LT7P5: TLabel;
    LT7P6: TLabel;
    LT7P13: TLabel;
    LT7P12: TLabel;
    LT7P11: TLabel;
    LT7P10: TLabel;
    LT7P9: TLabel;
    LT7P8: TLabel;
    LT7P15: TLabel;
    LT7P16: TLabel;
    LT7P17: TLabel;
    LT7P18: TLabel;
    LT7P19: TLabel;
    TSChm8: TTabSheet;
    LT8P20: TLabel;
    LT8P21: TLabel;
    LT8P14: TLabel;
    LT8P7: TLabel;
    LT8P1: TLabel;
    LT8P2: TLabel;
    LT8P3: TLabel;
    LT8P4: TLabel;
    LT8P5: TLabel;
    LT8P6: TLabel;
    LT8P13: TLabel;
    LT8P12: TLabel;
    LT8P11: TLabel;
    LT8P10: TLabel;
    LT8P9: TLabel;
    LT8P8: TLabel;
    LT8P15: TLabel;
    LT8P16: TLabel;
    LT8P17: TLabel;
    LT8P18: TLabel;
    LT8P19: TLabel;
    C8P1: TEdit;
    C8P2: TEdit;
    C8P15: TEdit;
    C8P8: TEdit;
    C8P7: TEdit;
    C8P6: TEdit;
    C8P5: TEdit;
    C8P4: TEdit;
    C8P3: TEdit;
    C8P9: TEdit;
    C8P11: TEdit;
    C8P12: TEdit;
    C8P13: TEdit;
    C8P21: TEdit;
    C8P14: TEdit;
    C8P16: TEdit;
    C8P10: TEdit;
    C8P18: TEdit;
    C8P17: TEdit;
    C8P20: TEdit;
    C8P19: TEdit;
    C7P1: TEdit;
    C7P2: TEdit;
    C7P3: TEdit;
    C7P4: TEdit;
    C7P5: TEdit;
    C7P6: TEdit;
    C7P7: TEdit;
    C7P14: TEdit;
    C7P13: TEdit;
    C7P20: TEdit;
    C7P21: TEdit;
    C7P19: TEdit;
    C7P12: TEdit;
    C7P11: TEdit;
    C7P18: TEdit;
    C7P17: TEdit;
    C7P10: TEdit;
    C7P9: TEdit;
    C7P16: TEdit;
    C7P15: TEdit;
    C7P8: TEdit;
    C6P1: TEdit;
    C6P2: TEdit;
    C6P3: TEdit;
    C6P4: TEdit;
    C6P5: TEdit;
    C6P6: TEdit;
    C6P7: TEdit;
    C6P14: TEdit;
    C6P13: TEdit;
    C6P20: TEdit;
    C6P21: TEdit;
    C6P19: TEdit;
    C6P12: TEdit;
    C6P11: TEdit;
    C6P18: TEdit;
    C6P17: TEdit;
    C6P10: TEdit;
    C6P9: TEdit;
    C6P16: TEdit;
    C6P15: TEdit;
    C6P8: TEdit;
    Button1: TButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    function CheckChem(ChemInd: ShortInt):Boolean;
    procedure FormCreate(Sender: TObject);
    procedure LoadChemMnu(ChemInd: String);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure ApplyChanges;
    procedure BitBtn2Click(Sender: TObject);
    procedure tblConfigBeforeOpen(DataSet: TDataSet);
    function CheckEnable(pId: ShortInt):Boolean;
    procedure ClearForm(pId: ShortInt);
    procedure SaveDefs(pFileName: String);
    procedure OpenDefs(pFileName: String);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SetAddChem: TSetAddChem;

implementation

uses varinit, datetime, MainDataModule;

{$R *.lfm}

function TSetAddChem.checkchem(ChemInd: ShortInt):Boolean;

var tempQuery: TZQuery;

begin
  tempQuery := TZQuery.Create(self);
  tempQuery.Connection := DataModuleMain.ZConnectionDB;
  tempQuery.Close;
  with tempQuery do
  begin
    SQL.Clear;
    SQL.Add('Select CHEMTABLE, TABLENAME, VISIBLE');
    SQL.Add('From CHEM_CFG_DTL');
    SQL.Add('Where (CHEMTABLE = ''' + 'CHEM_00' + IntToStr(ChemInd) + '''');
    SQL.Add('And VISIBLE = 1)');
  end;
  tempQuery.Open;
  if tempQuery.RecordCount > 0 then
  begin
    if ChemInd = 6 then
      tsChm6.Caption := tempQuery.FieldByName('TABLENAME').AsString
    else if ChemInd = 7 then
      tsChm7.Caption := tempQuery.FieldByName('TABLENAME').AsString
    else if ChemInd = 8 then
      tsChm8.Caption := tempQuery.FieldByName('TABLENAME').AsString;
    Result := true;
  end
  else
    Result := false;
  tempQuery.Close;
end;

function TSetAddChem.CheckEnable(pId: ShortInt):Boolean;
begin
  case pId of
    6: Result := CheckBox1.Checked;
    7: Result := CheckBox2.Checked;
    8: Result := CheckBox3.Checked;
  end;//case
end;

procedure TSetAddChem.OpenDefs(pFileName: String);

var pStrings : TStringList;

begin
  pStrings := TStringList.Create;
  pStrings.Clear;
  pStrings.LoadFromFile(pFileName);
 {*****Chem_006*****}
  tsChm6.Caption := pStrings[0];
  C6P1.Text := pStrings[1];
  C6P2.Text := pStrings[2];
  C6P3.Text := pStrings[3];
  C6P4.Text := pStrings[4];
  C6P5.Text := pStrings[5];
  C6P6.Text := pStrings[6];
  C6P7.Text := pStrings[7];
  C6P8.Text := pStrings[8];
  C6P9.Text := pStrings[9];
  C6P10.Text := pStrings[10];
  C6P11.Text := pStrings[11];
  C6P12.Text := pStrings[12];
  C6P13.Text := pStrings[13];
  C6P14.Text := pStrings[14];
  C6P15.Text := pStrings[15];
  C6P16.Text := pStrings[16];
  C6P17.Text := pStrings[17];
  C6P18.Text := pStrings[18];
  C6P19.Text := pStrings[19];
  C6P20.Text := pStrings[20];
  C6P21.Text := pStrings[21];
 {*****Chem_007*****}
  tsChm7.Caption := pStrings[22];
  C7P1.Text := pStrings[23];
  C7P2.Text := pStrings[24];
  C7P3.Text := pStrings[25];
  C7P4.Text := pStrings[26];
  C7P5.Text := pStrings[27];
  C7P6.Text := pStrings[28];
  C7P7.Text := pStrings[29];
  C7P8.Text := pStrings[30];
  C7P9.Text := pStrings[31];
  C7P10.Text := pStrings[32];
  C7P11.Text := pStrings[33];
  C7P12.Text := pStrings[34];
  C7P13.Text := pStrings[35];
  C7P14.Text := pStrings[36];
  C7P15.Text := pStrings[37];
  C7P16.Text := pStrings[38];
  C7P17.Text := pStrings[39];
  C7P18.Text := pStrings[40];
  C7P19.Text := pStrings[41];
  C7P20.Text := pStrings[42];
  C7P21.Text := pStrings[43];
  {*****Chem_008*****}
  tsChm8.Caption := pStrings[44];
  C8P1.Text := pStrings[45];
  C8P2.Text := pStrings[46];
  C8P3.Text := pStrings[47];
  C8P4.Text := pStrings[48];
  C8P5.Text := pStrings[49];
  C8P6.Text := pStrings[50];
  C8P7.Text := pStrings[51];
  C8P8.Text := pStrings[52];
  C8P9.Text := pStrings[53];
  C8P10.Text := pStrings[54];
  C8P11.Text := pStrings[55];
  C8P12.Text := pStrings[56];
  C8P13.Text := pStrings[57];
  C8P14.Text := pStrings[58];
  C8P15.Text := pStrings[59];
  C8P16.Text := pStrings[60];
  C8P17.Text := pStrings[61];
  C8P18.Text := pStrings[62];
  C8P19.Text := pStrings[63];
  C8P20.Text := pStrings[64];
  C8P21.Text := pStrings[65];
end;

procedure TSetAddChem.SaveDefs(pFileName: String);

var pStrings : TStringList;

begin
  pStrings := TStringList.Create;
 {*****Chem_006*****}
  pStrings.Add('Chem_006');
  pStrings.Add(C6P1.Text);
  pStrings.Add(C6P2.Text);
  pStrings.Add(C6P3.Text);
  pStrings.Add(C6P4.Text);
  pStrings.Add(C6P5.Text);
  pStrings.Add(C6P6.Text);
  pStrings.Add(C6P7.Text);
  pStrings.Add(C6P8.Text);
  pStrings.Add(C6P9.Text);
  pStrings.Add(C6P10.Text);
  pStrings.Add(C6P11.Text);
  pStrings.Add(C6P12.Text);
  pStrings.Add(C6P13.Text);
  pStrings.Add(C6P14.Text);
  pStrings.Add(C6P15.Text);
  pStrings.Add(C6P16.Text);
  pStrings.Add(C6P17.Text);
  pStrings.Add(C6P18.Text);
  pStrings.Add(C6P19.Text);
  pStrings.Add(C6P20.Text);
  pStrings.Add(C6P21.Text);
 {*****Chem_007*****}
  pStrings.Add('Chem_007');
  pStrings.Add(C7P1.Text);
  pStrings.Add(C7P2.Text);
  pStrings.Add(C7P3.Text);
  pStrings.Add(C7P4.Text);
  pStrings.Add(C7P5.Text);
  pStrings.Add(C7P6.Text);
  pStrings.Add(C7P7.Text);
  pStrings.Add(C7P8.Text);
  pStrings.Add(C7P9.Text);
  pStrings.Add(C7P10.Text);
  pStrings.Add(C7P11.Text);
  pStrings.Add(C7P12.Text);
  pStrings.Add(C7P13.Text);
  pStrings.Add(C7P14.Text);
  pStrings.Add(C7P15.Text);
  pStrings.Add(C7P16.Text);
  pStrings.Add(C7P17.Text);
  pStrings.Add(C7P18.Text);
  pStrings.Add(C7P19.Text);
  pStrings.Add(C7P20.Text);
  pStrings.Add(C7P21.Text);
  {*****Chem_008*****}
  pStrings.Add('Chem_008');
  pStrings.Add(C8P1.Text);
  pStrings.Add(C8P2.Text);
  pStrings.Add(C8P3.Text);
  pStrings.Add(C8P4.Text);
  pStrings.Add(C8P5.Text);
  pStrings.Add(C8P6.Text);
  pStrings.Add(C8P7.Text);
  pStrings.Add(C8P8.Text);
  pStrings.Add(C8P9.Text);
  pStrings.Add(C8P10.Text);
  pStrings.Add(C8P11.Text);
  pStrings.Add(C8P12.Text);
  pStrings.Add(C8P13.Text);
  pStrings.Add(C8P14.Text);
  pStrings.Add(C8P15.Text);
  pStrings.Add(C8P16.Text);
  pStrings.Add(C8P17.Text);
  pStrings.Add(C8P18.Text);
  pStrings.Add(C8P19.Text);
  pStrings.Add(C8P20.Text);
  pStrings.Add(C8P21.Text);
  pStrings.SaveToFile(WSpaceDir + '\' + pFileName);
end;

procedure TSetAddChem.ClearForm(pId: ShortInt);

begin
  if pId = 6 then
  begin
    C6P1.Text := '';
    C6P2.Text := '';
    C6P3.Text := '';
    C6P4.Text := '';
    C6P5.Text := '';
    C6P6.Text := '';
    C6P7.Text := '';
    C6P8.Text := '';
    C6P9.Text := '';
    C6P10.Text := '';
    C6P11.Text := '';
    C6P12.Text := '';
    C6P13.Text := '';
    C6P14.Text := '';
    C6P15.Text := '';
    C6P16.Text := '';
    C6P17.Text := '';
    C6P18.Text := '';
    C6P19.Text := '';
    C6P20.Text := '';
    C6P21.Text := '';
  end
  else if pId = 7 then
  begin
    C7P1.Text := '';
    C7P2.Text := '';
    C7P3.Text := '';
    C7P4.Text := '';
    C7P5.Text := '';
    C7P6.Text := '';
    C7P7.Text := '';
    C7P8.Text := '';
    C7P9.Text := '';
    C7P10.Text := '';
    C7P11.Text := '';
    C7P12.Text := '';
    C7P13.Text := '';
    C7P14.Text := '';
    C7P15.Text := '';
    C7P16.Text := '';
    C7P17.Text := '';
    C7P18.Text := '';
    C7P19.Text := '';
    C7P20.Text := '';
    C7P21.Text := '';
  end
  else if pId = 8 then
  begin
    C8P1.Text := '';
    C8P2.Text := '';
    C8P3.Text := '';
    C8P4.Text := '';
    C8P5.Text := '';
    C8P6.Text := '';
    C8P7.Text := '';
    C8P8.Text := '';
    C8P9.Text := '';
    C8P10.Text := '';
    C8P11.Text := '';
    C8P12.Text := '';
    C8P13.Text := '';
    C8P14.Text := '';
    C8P15.Text := '';
    C8P16.Text := '';
    C8P17.Text := '';
    C8P18.Text := '';
    C8P19.Text := '';
    C8P20.Text := '';
    C8P21.Text := '';
  end;
end;

procedure TSetAddChem.Button1Click(Sender: TObject);
begin
  if PageControl.TabIndex = 0 then
    tsChm6.Caption := InputBox('Add/Edit Table Name','Enter the appropriate Table name:',tsChm6.Caption)
  else if (PageControl.TabIndex = 1) and (tsChm6.Caption <> 'Add1') then
    tsChm7.Caption := InputBox('Add/Edit Table Name','Enter the appropriate Table name:',tsChm7.Caption)
  else if (PageControl.TabIndex = 2) and (tsChm7.Caption <> 'Add2') then
    tsChm8.Caption := InputBox('Add/Edit Table Name','Enter the appropriate Table name:',tsChm8.Caption);
end;

procedure TSetAddChem.FormCreate(Sender: TObject);

begin
  Checkbox1.Checked := CheckChem(6);
  tsChm6.TabVisible := CheckBox1.Checked;
  Checkbox1.Caption := 'Use: ' + tsChm6.Caption;
  LoadChemMnu('6');
  CheckBox2.Checked := CheckChem(7);
  tsChm7.TabVisible := CheckBox2.Checked;
  Checkbox2.Caption := 'Use: ' + tsChm7.Caption;
  LoadChemMnu('7');
  CheckBox3.Checked := CheckChem(8);
  tsChm8.TabVisible := CheckBox3.Checked;
  Checkbox3.Caption := 'Use: ' + tsChm8.Caption;
  LoadChemMnu('8');
  if CheckBox1.Checked then
    PageControl.ActivePageIndex := 0
  else if CheckBox2.Checked then
    PageControl.ActivePageIndex := 1
  else if CheckBox3.Checked then
    PageControl.ActivePageIndex := 2;
end;

procedure TSetAddChem.LoadChemMnu(ChemInd: String);

var tempTable: TZTable;
    tempCount: Integer;
    pTst: String;

begin
  pTst := 'tsChm' + ChemInd;
  tempTable := TZTable.Create(self);
  tempTable.Connection := DataModuleMain.ZConnectionDB;
  tempTable.TableName := 'CHEM_CFG_DTL';
  tempTable.Filter := 'CHEMTABLE = ''' + 'Chem_00' + ChemInd + '''';
  tempTable.Filtered := true;
  tempTable.Open;
  tempTable.First;
  for tempCount := 1 to 21 do
  begin
    if pTst = 'tsChm6' then
        begin
          case tempCount of
            1: C6P1.Text := tempTable.FieldByName('PARAMETER').AsString;
            2: C6P2.Text := tempTable.FieldByName('PARAMETER').AsString;
            3: C6P3.text := tempTable.FieldByName('PARAMETER').AsString;
            4: C6P4.Text := tempTable.FieldByName('PARAMETER').AsString;
            5: C6P5.Text := tempTable.FieldByName('PARAMETER').AsString;
            6: C6P6.Text := tempTable.FieldByName('PARAMETER').AsString;
            7: C6P7.Text := tempTable.FieldByName('PARAMETER').AsString;
            8: C6P8.Text := tempTable.FieldByName('PARAMETER').AsString;
            9: C6P9.Text := tempTable.FieldByName('PARAMETER').AsString;
            10: C6P10.Text := tempTable.FieldByName('PARAMETER').AsString;
            11: C6P11.Text := tempTable.FieldByName('PARAMETER').AsString;
            12: C6P12.Text := tempTable.FieldByName('PARAMETER').AsString;
            13: C6P13.Text := tempTable.FieldByName('PARAMETER').AsString;
            14: C6P14.Text := tempTable.FieldByName('PARAMETER').AsString;
            15: C6P15.Text := tempTable.FieldByName('PARAMETER').AsString;
            16: C6P16.Text := tempTable.FieldByName('PARAMETER').AsString;
            17: C6P17.Text := tempTable.FieldByName('PARAMETER').AsString;
            18: C6P18.Text := tempTable.FieldByName('PARAMETER').AsString;
            19: C6P19.Text := tempTable.FieldByName('PARAMETER').AsString;
            20: C6P20.Text := tempTable.FieldByName('PARAMETER').AsString;
            21: C6P21.Text := tempTable.FieldByName('PARAMETER').AsString;
          end;//case6
        end;
        if pTst = 'tsChm7' then
        begin
          case tempCount of
            1: C7P1.Text := tempTable.FieldByName('PARAMETER').AsString;
            2: C7P2.Text := tempTable.FieldByName('PARAMETER').AsString;
            3: C7P3.text := tempTable.FieldByName('PARAMETER').AsString;
            4: C7P4.Text := tempTable.FieldByName('PARAMETER').AsString;
            5: C7P5.Text := tempTable.FieldByName('PARAMETER').AsString;
            6: C7P6.Text := tempTable.FieldByName('PARAMETER').AsString;
            7: C7P7.Text := tempTable.FieldByName('PARAMETER').AsString;
            8: C7P8.Text := tempTable.FieldByName('PARAMETER').AsString;
            9: C7P9.Text := tempTable.FieldByName('PARAMETER').AsString;
            10: C7P10.Text := tempTable.FieldByName('PARAMETER').AsString;
            11: C7P11.Text := tempTable.FieldByName('PARAMETER').AsString;
            12: C7P12.Text := tempTable.FieldByName('PARAMETER').AsString;
            13: C7P13.Text := tempTable.FieldByName('PARAMETER').AsString;
            14: C7P14.Text := tempTable.FieldByName('PARAMETER').AsString;
            15: C7P15.Text := tempTable.FieldByName('PARAMETER').AsString;
            16: C7P16.Text := tempTable.FieldByName('PARAMETER').AsString;
            17: C7P17.Text := tempTable.FieldByName('PARAMETER').AsString;
            18: C7P18.Text := tempTable.FieldByName('PARAMETER').AsString;
            19: C7P19.Text := tempTable.FieldByName('PARAMETER').AsString;
            20: C7P20.Text := tempTable.FieldByName('PARAMETER').AsString;
            21: C7P21.Text := tempTable.FieldByName('PARAMETER').AsString;
          end;//case7
        end;
        if pTst = 'tsChm8' then
        begin
          case tempCount of
            1: C8P1.Text := tempTable.FieldByName('PARAMETER').AsString;
            2: C8P2.Text := tempTable.FieldByName('PARAMETER').AsString;
            3: C8P3.text := tempTable.FieldByName('PARAMETER').AsString;
            4: C8P4.Text := tempTable.FieldByName('PARAMETER').AsString;
            5: C8P5.Text := tempTable.FieldByName('PARAMETER').AsString;
            6: C8P6.Text := tempTable.FieldByName('PARAMETER').AsString;
            7: C8P7.Text := tempTable.FieldByName('PARAMETER').AsString;
            8: C8P8.Text := tempTable.FieldByName('PARAMETER').AsString;
            9: C8P9.Text := tempTable.FieldByName('PARAMETER').AsString;
            10: C8P10.Text := tempTable.FieldByName('PARAMETER').AsString;
            11: C8P11.Text := tempTable.FieldByName('PARAMETER').AsString;
            12: C8P12.Text := tempTable.FieldByName('PARAMETER').AsString;
            13: C8P13.Text := tempTable.FieldByName('PARAMETER').AsString;
            14: C8P14.Text := tempTable.FieldByName('PARAMETER').AsString;
            15: C8P15.Text := tempTable.FieldByName('PARAMETER').AsString;
            16: C8P16.Text := tempTable.FieldByName('PARAMETER').AsString;
            17: C8P17.Text := tempTable.FieldByName('PARAMETER').AsString;
            18: C8P18.Text := tempTable.FieldByName('PARAMETER').AsString;
            19: C8P19.Text := tempTable.FieldByName('PARAMETER').AsString;
            20: C8P20.Text := tempTable.FieldByName('PARAMETER').AsString;
            21: C8P21.Text := tempTable.FieldByName('PARAMETER').AsString;
          end;//case8
        end;
    tempTable.Next;
  end;//for
  tempTable.Close;
end;

procedure TSetAddChem.CheckBox1Click(Sender: TObject);
begin
  PageControl.ActivePageIndex := 0;
  if not CheckBox1.Checked then
    MessageDlg('NOTE: This Option will remove the current definition'
           + #13' for this table form the database!', mtWarning,[mbOK],0);
  tsChm6.TabVisible := CheckBox1.Checked;
end;

procedure TSetAddChem.CheckBox2Click(Sender: TObject);
begin
  PageControl.ActivePageIndex := 1;
  if not CheckBox2.Checked then
    MessageDlg('NOTE: This Option will remove the current definition'
           + #13' for this table form the database!', mtWarning,[mbOK],0);
  tsChm7.TabVisible := CheckBox2.Checked;
end;

procedure TSetAddChem.CheckBox3Click(Sender: TObject);
begin
  PageControl.ActivePageIndex := 2;
  if not CheckBox3.Checked then
    MessageDlg('NOTE: This Option will remove the current definition'
           + #13' for this table form the database!', mtWarning,[mbOK],0);
  tsChm8.TabVisible := CheckBox3.Checked;
end;

procedure TSetAddChem.ApplyChanges;
begin
  tblConfig.Filter := 'CHEMTABLE = ''' + 'CHEM_006' + '''';
  tblConfig.Filtered := true;
  tblConfig.Open;
  tblConfig.First;
  tblConfig.Edit;
  //Edit Chem_006 Parameters
  tblConfig.FieldByName('TABLENAME').Value := tsChm6.Caption;
  tblConfig.FieldByName('PARAMETER').Value := C6P1.Text;
  if C6P1.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C6P2.Text;
  if C6P2.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C6P3.Text;
  if C6P3.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C6P4.Text;
  if C6P4.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C6P5.Text;
  if C6P5.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C6P6.Text;
  if C6P6.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C6P7.Text;
  if C6P7.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C6P8.Text;
  if C6P8.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C6P9.Text;
  if C6P9.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C6P10.Text;
  if C6P10.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C6P11.Text;
  if C6P11.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C6P12.Text;
  if C6P12.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C6P13.Text;
  if C6P13.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C6P14.Text;
  if C6P14.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C6P15.Text;
  if C6P15.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C6P16.Text;
  if C6P16.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C6P17.Text;
  if C6P17.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C6P18.Text;
  if C6P18.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C6P19.Text;
  if C6P19.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C6P20.Text;
  if C6P20.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C6P21.Text;
  if C6P21.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Close;

  {******Edit Chem_007 Parameters******}
  tblConfig.Filter := 'CHEMTABLE = ''' + 'CHEM_007' + '''';
  tblConfig.Filtered := true;
  tblConfig.Open;
  tblConfig.First;
  tblConfig.Edit;
  tblConfig.FieldByName('TABLENAME').Value := tsChm7.Caption;
  tblConfig.FieldByName('PARAMETER').Value := C7P1.Text;
  if C7P1.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C7P2.Text;
  if C7P2.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C7P3.Text;
  if C7P3.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C7P4.Text;
  if C7P4.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C7P5.Text;
  if C7P5.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C7P6.Text;
  if C7P6.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C7P7.Text;
  if C7P7.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C7P8.Text;
  if C7P8.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C7P9.Text;
  if C7P9.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C7P10.Text;
  if C7P10.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C7P11.Text;
  if C7P11.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C7P12.Text;
  if C7P12.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C7P13.Text;
  if C7P13.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C7P14.Text;
  if C7P14.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C7P15.Text;
  if C7P15.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C7P16.Text;
  if C7P16.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C7P17.Text;
  if C7P17.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C7P18.Text;
  if C7P18.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C7P19.Text;
  if C7P19.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C7P20.Text;
  if C7P20.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C7P21.Text;
  if C7P21.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Close;

  {******Edit Chem_008 Parameters******}
  tblConfig.Filter := 'CHEMTABLE = ''' + 'CHEM_008' + '''';
  tblConfig.Filtered := true;
  tblConfig.Open;
  tblConfig.First;
  tblConfig.Edit;
  tblConfig.FieldByName('TABLENAME').Value := tsChm8.Caption;
  tblConfig.FieldByName('PARAMETER').Value := C8P1.Text;
  if C8P1.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C8P2.Text;
  if C8P2.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C8P3.Text;
  if C8P3.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C8P4.Text;
  if C8P4.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C8P5.Text;
  if C8P5.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C8P6.Text;
  if C8P6.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C8P7.Text;
  if C8P7.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C8P8.Text;
  if C8P8.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C8P9.Text;
  if C8P9.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C8P10.Text;
  if C8P10.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C8P11.Text;
  if C8P11.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C8P12.Text;
  if C8P12.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C8P13.Text;
  if C8P13.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C8P14.Text;
  if C8P14.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C8P15.Text;
  if C8P15.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C8P16.Text;
  if C8P16.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C8P17.Text;
  if C8P17.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C8P18.Text;
  if C8P18.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C8P19.Text;
  if C8P19.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C8P20.Text;
  if C8P20.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Next;
  tblConfig.Edit;
  tblConfig.FieldByName('PARAMETER').Value := C8P21.Text;
  if C8P21.Text <> '' then
    tblConfig.FieldByName('VISIBLE').Value := 1
  else
    tblConfig.FieldByName('VISIBLE').Value := 0;
  tblConfig.Post;
  tblConfig.Close;
end;

procedure TSetAddChem.BitBtn2Click(Sender: TObject);
begin
  SaveDefs('Chem_Cfg_Dtl.def');
  if not CheckEnable(6) then
    ClearForm(6);
  if not CheckEnable(7) then
    ClearForm(7);
  if not CheckEnable(8) then
    ClearForm(8);
  ApplyChanges;
  ShowMessage('A file named "Chem_Cfg_Dtl.def" has been saved in the current'
            + '#13 WorkSpace Directory, it contains the current Chemistry definitions.');
  Close;
end;

procedure TSetAddChem.tblConfigBeforeOpen(DataSet: TDataSet);
begin
  tblConfig.Connection := DataModuleMain.ZConnectionDB;
end;

procedure TSetAddChem.BitBtn4Click(Sender: TObject);
begin
  OpenDialog.InitialDir := WSpaceDir;
  if OpenDialog.Execute then
    OpenDefs(OpenDialog.FileName);
end;

procedure TSetAddChem.BitBtn5Click(Sender: TObject);
begin
  SaveDialog.InitialDir := WSpaceDir;
  if SaveDialog.Execute then
    SaveDefs(SaveDialog.FileName);
end;

end.
