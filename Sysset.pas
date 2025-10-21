{ Copyright (C) 2025 Immo Blecher immo@blecher.co.za

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
unit Sysset;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StrUtils,
  Db, Buttons, StdCtrls, ExtCtrls, ComCtrls, ZDataset, Registry,
  IniFiles, Spin, DBCtrls, ButtonPanel, FileUtil, Math;

type

  { TSysSetDlgForm }

  TSysSetDlgForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    CheckBoxSmallChars: TCheckBox;
    CheckBoxWSpace: TCheckBox;
    CheckBoxUpdates: TCheckBox;
    FontBtn: TBitBtn;
    CheckBoxAutoEdit: TCheckBox;
    CheckBoxDMS: TCheckBox;
    CheckBoxShowNoInfo: TCheckBox;
    ColorButtonPColumnHeader: TColorButton;
    ColorButtonPReportHeader: TColorButton;
    ComboBoxCoordSys: TComboBox;
    ComboBoxCountry: TComboBox;
    CoordLabel: TLabel;
    EditSettingsDir: TEdit;
    Label16: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    PageControl1: TPageControl;
    SelectDirectoryDialog: TSelectDirectoryDialog;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    SpinEdit6: TSpinEdit;
    SystemTabSheet: TTabSheet;
    UnitsTabSheet: TTabSheet;
    Label2: TLabel;
    LengthCombo: TComboBox;
    Label3: TLabel;
    VolumeCombo: TComboBox;
    Label4: TLabel;
    TimeCombo: TComboBox;
    DiamLabel: TLabel;
    DiamCombo: TComboBox;
    Label8: TLabel;
    ChemCombo: TComboBox;
    Label7: TLabel;
    ECCombo: TComboBox;
    ChemTabSheet: TTabSheet;
    Label10: TLabel;
    StandardComboBox: TComboBox;
    LimitBox: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    UnitTable: TZTable;
    FontDialog: TFontDialog;
    OpenDialog: TOpenDialog;
    UserTabSheet: TTabSheet;
    Label1: TLabel;
    Memo1: TMemo;
    Button8: TButton;
    Button9: TButton;
    Label5: TLabel;
    Label18: TLabel;
    NComboBox: TComboBox;
    ReportsTabSheet: TTabSheet;
    PageControl2: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    GroupBox2: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    GroupBox3: TGroupBox;
    Label23: TLabel;
    Label24: TLabel;
    Label27: TLabel;
    Label25: TLabel;
    PressureComboBox: TComboBox;
    WorkspaceTabSheet: TTabSheet;
    Label15: TLabel;
    Label17: TLabel;
    NewNrSpinEdit: TSpinEdit;
    Label28: TLabel;
    LangComboBox: TComboBox;
    GroupBox4: TGroupBox;
    EditQGISExe: TEdit;
    SysBackClr: TPanel;
    ColorDialog1: TColorDialog;
    Bevel2: TBevel;
    Button7: TButton;
    Image2: TImage;
    SpeedButton2: TSpeedButton;
    Bevel3: TBevel;
    ZQueryCountries: TZReadOnlyQuery;
    procedure CheckBoxUpdatesChange(Sender: TObject);
    procedure ComboBoxCountryChange(Sender: TObject);
    procedure CountryTableAfterClose(DataSet: TDataSet);
    procedure CountryTableBeforeOpen(DataSet: TDataSet);
    procedure Edit1Click(Sender: TObject);
    procedure Edit2Click(Sender: TObject);
    procedure Edit3Click(Sender: TObject);
    procedure Edit4Click(Sender: TObject);
    procedure FontBtnClick(Sender: TObject);
    procedure ComboBoxCoordSysChange(Sender: TObject);
    procedure ComboBoxCountrySelect(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure Button9Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure StandardComboBoxChange(Sender: TObject);
    procedure SystemTabSheetEnter(Sender: TObject);
    procedure SystemTabSheetExit(Sender: TObject);
    procedure SysBackClrClick(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure ZQueryCountriesAfterOpen(DataSet: TDataSet);
    procedure ZQueryCountriesBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    UpdateMessage, MoveSettings, DeleteSettings: Boolean;
  public
    { Public declarations }
  end;

var
  SysSetDlgForm: TSysSetDlgForm;

implementation

{$R *.lfm}

uses varinit, MainDataModule;

procedure TSysSetDlgForm.ComboBoxCountrySelect(Sender: TObject);
begin
  CheckboxDMS.Enabled := dstLatLong;
  CheckBoxDMS.Checked := False;
end;

procedure TSysSetDlgForm.ComboBoxCoordSysChange(Sender: TObject);
begin
  CheckboxDMS.Enabled := Pos('geographic', ComboBoxCoordSys.Text) > 0;
  CheckBoxDMS.Checked := False;
  Buttonpanel1.OKButton.Enabled := ComboBoxCoordSys.Text <> '<CRS not found or deprecated, please select>';
end;

procedure TSysSetDlgForm.FontBtnClick(Sender: TObject);
begin
  FontDialog.Font.Name := FontBtn.Font.Name;
  FontDialog.Font.Color := FontBtn.Font.Color;
  FontDialog.Font.Size := FontBtn.Font.Size;
  FontDialog.Font.Style := FontBtn.Font.Style;
  if FontDialog.Execute then
  begin
    FontBtn.Font.Name := FontDialog.Font.Name;
    FontBtn.Font.Color := FontDialog.Font.Color;
    FontBtn.Font.Size := FontDialog.Font.Size;
    FontBtn.Font.Style := FontDialog.Font.Style;
  end;
end;

procedure TSysSetDlgForm.ComboBoxCountryChange(Sender: TObject);
var
  CurrentCountry: String;
begin
  CurrentCountry := Country; //remember current country of workspace
  Country := ComboBoxCountry.Text;
  ComboBoxCoordSys.Clear;
  with DataModuleMain.ZQueryProj do
  begin
    Open;
    //Fill coordinate systems combobox
    while not EOF do
    begin
      ComboBoxCoordSys.Items.Add(Fields[1].Value);
      Next;
    end;
    Close
  end;
  Country := CurrentCountry;
  //for LO countries
  if AnsiIndexStr(ComboBoxCountry.Text, LO_Countries) >= 0 then
  begin
    if AnsiIndexStr(ComboBoxCountry.Text, LO_Countries) <= 3 then
    begin
      ComboBoxCoordSys.Items.Add('Cape (LO from Map Reference)');
      ComboBoxCoordSys.Items.Add('Hartebeesthoek94 (LO from Map Reference)');
    end
    else
      ComboBoxCoordSys.Items.Add('Schwarzeck (LO from Map Reference)');
  end;
  if ComboBoxCoordSys.Items.IndexOf('WGS 84 (geographic 3D)') > -1 then
    ComboBoxCoordSys.ItemIndex := ComboBoxCoordSys.Items.IndexOf('WGS 84 (geographic 3D)')
  else
    ComboBoxCoordSys.ItemIndex := 0;
  MessageDlg('You have changed to a country which might have a different coordinate system for the stored coordinates. This can lead to unexpected coordinate conversion results. You should only do this if you have used Longitude/Latitude (e.g. WGS 84) or same CRSs for both countries for the stored coordinates!', mtWarning, [mbOK], 0);
end;

procedure TSysSetDlgForm.CountryTableAfterClose(DataSet: TDataSet);
begin

end;

procedure TSysSetDlgForm.CountryTableBeforeOpen(DataSet: TDataSet);
begin

end;

procedure TSysSetDlgForm.Edit1Click(Sender: TObject);
begin
  if ColorDialog1.Execute then
    Edit1.Font.Color := ColorDialog1.Color;
end;

procedure TSysSetDlgForm.Edit2Click(Sender: TObject);
begin
  if ColorDialog1.Execute then
    Edit2.Font.Color := ColorDialog1.Color;
end;

procedure TSysSetDlgForm.Edit3Click(Sender: TObject);
begin
  if ColorDialog1.Execute then
    Edit3.Font.Color := ColorDialog1.Color;
end;

procedure TSysSetDlgForm.Edit4Click(Sender: TObject);
begin
  if ColorDialog1.Execute then
    Edit4.Font.Color := ColorDialog1.Color;
end;

procedure TSysSetDlgForm.CheckBoxUpdatesChange(Sender: TObject);
begin
  if UpdateMessage then
  begin
    if CheckBoxUpdates.Checked then
      ShowMessage('Aquabase will look for updates on startup (default).')
    else
      ShowMessage('Aquabase will not look for updates on startup. You will not be notified if new updates are available.');
  end;
end;

procedure TSysSetDlgForm.Button1Click(Sender: TObject);
begin
  FontDialog.Font.Name := Edit1.Font.Name;
  FontDialog.Font.Color := Edit1.Font.Color;
  FontDialog.Font.Size := Edit1.Font.Size;
  FontDialog.Font.Style := Edit1.Font.Style;
  if FontDialog.Execute then
    Edit1.Font := FontDialog.Font;
end;

procedure TSysSetDlgForm.Button2Click(Sender: TObject);
begin
  FontDialog.Font.Name := Edit2.Font.Name;
  FontDialog.Font.Color := Edit2.Font.Color;
  FontDialog.Font.Size := Edit2.Font.Size;
  FontDialog.Font.Style := Edit2.Font.Style;
  if FontDialog.Execute then
    Edit2.Font := FontDialog.Font;
end;

procedure TSysSetDlgForm.Button3Click(Sender: TObject);
begin
  FontDialog.Font.Name := Edit3.Font.Name;
  FontDialog.Font.Color := Edit3.Font.Color;
  FontDialog.Font.Size := Edit3.Font.Size;
  FontDialog.Font.Style := Edit3.Font.Style;
  if FontDialog.Execute then
    Edit3.Font := FontDialog.Font;
end;

procedure TSysSetDlgForm.Button4Click(Sender: TObject);
begin
  FontDialog.Font.Name := Edit4.Font.Name;
  FontDialog.Font.Color := Edit4.Font.Color;
  FontDialog.Font.Size := Edit4.Font.Size;
  FontDialog.Font.Style := Edit4.Font.Style;
  if FontDialog.Execute then
    Edit4.Font := FontDialog.Font;
end;

procedure TSysSetDlgForm.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
end;

procedure TSysSetDlgForm.FormShow(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;
  LangComboBox.ItemIndex := LangComboBox.Items.IndexOf(Language);
  CheckBoxAutoEdit.Checked := AutoEditData;
  {$IFDEF WINDOWS}
    CheckBoxUpdates.Checked := LookForUpdate;
  {$ENDIF}
  {$IFDEF LINUX}
    CheckBoxUpdates.Enabled := False;
    CheckBoxUpdates.Checked := False;
  {$ENDIF}
  ZQueryCountries.Open;
  ComboBoxCountry.ItemIndex := ComboBoxCountry.Items.IndexOf(Country);
  with DataModuleMain.ZQueryProj do
  begin
    Open;
    //Fill coordinate systems combobox
    while not EOF do
    begin
      ComboBoxCoordSys.Items.Add(Fields[1].Value);
      Next;
    end;
    Close;
  end;
  if AnsiIndexStr(ComboBoxCountry.Text, LO_Countries) >= 0 then
  begin
    if AnsiIndexStr(ComboBoxCountry.Text, LO_Countries) <= 3 then
    begin
      ComboBoxCoordSys.Items.Add('Cape (LO from Map Reference)');
      ComboBoxCoordSys.Items.Add('Hartebeesthoek94 (LO from Map Reference)');
    end
    else
      ComboBoxCoordSys.Items.Add('Schwarzeck (LO from Map Reference)');
  end;
  if ComboBoxCoordSys.Items.IndexOf(CoordSysDescr) > -1 then
    ComboBoxCoordSys.ItemIndex := ComboBoxCoordSys.Items.IndexOf(CoordSysDescr)
  else
  begin
    ComboBoxCoordSys.Items.Add('<CRS not found or deprecated, please select>');
    ComboBoxCoordSys.ItemIndex := ComboBoxCoordSys.Items.IndexOf('<CRS not found or deprecated, please select>');
    ButtonPanel1.OKButton.Enabled := False;
  end;
  CheckboxDMS.Enabled := Pos('geographic', ComboBoxCoordSys.Text) > 0;
  CheckBoxDMS.Checked := (ShowDMS) and (CheckBoxDMS.Enabled);
  NewNrSpinEdit.Value := AutoNumber;
  EditQGISExe.Text := QGISExe;
  EditSettingsDir.Text := SettingsDir;
  CheckBoxSmallChars.Enabled := AllowSmallChars;
  if FileExistsExt('userinfo.txt', WSpaceDir) then
    Memo1.Lines.LoadFromFile(GetFileNameOnDisk('userinfo.txt', WSpaceDir ));
  if FileExistsExt('userlogo.jpg', WSpaceDir) then
    Image2.Picture.LoadFromFile(GetFileNameOnDisk('userlogo.jpg', WSpaceDir))
  else
  if FileExistsExt('userlogo.bmp', WSpaceDir) then
    Image2.Picture.LoadFromFile(GetFileNameOnDisk('userlogo.bmp', WSpaceDir));
  with UnitTable do
  begin
    Connection := DataModuleMain.ZConnectionLanguage;
    TableName := 'Lengunit';
    Open;
    LengthCombo.Items.Clear;
    while not EOF do
    begin
      LengthCombo.Items.Add(UnitTable.FieldByName('DESCRIPTIO').Value);
      Next;
    end;
    Locate('UNIT', LengthUnit, []);
    LengthCombo.ItemIndex := LengthCombo.Items.IndexOf(UnitTable.FieldByName('DESCRIPTIO').Value);
    Close;
    TableName := 'Volmunit';
    Open;
    VolumeCombo.Items.Clear;
    while not EOF do
    begin
      VolumeCombo.Items.Add(UnitTable.FieldByName('DESCRIPTIO').Value);
      Next;
    end;
    Locate('UNIT', VolumeUnit, []);
    VolumeCombo.ItemIndex := VolumeCombo.Items.IndexOf(UnitTable.FieldByName('DESCRIPTIO').Value);
    Close;
    TableName := 'Timeunit';
    Open;
    TimeCombo.Items.Clear;
    while not EOF do
    begin
      TimeCombo.Items.Add(UnitTable.FieldByName('DESCRIPTIO').Value);
      Next;
    end;
    Locate('UNIT', TimeUnit, []);
    TimeCombo.ItemIndex := TimeCombo.Items.IndexOf(UnitTable.FieldByName('DESCRIPTIO').Value);
    Close;
    TableName := 'Diamunit';
    Open;
    DiamCombo.Items.Clear;
    while not EOF do
    begin
      DiamCombo.Items.Add(UnitTable.FieldByName('DESCRIPTIO').Value);
      Next;
    end;
    Locate('UNIT', DiamUnit, []);
    DiamCombo.ItemIndex := DiamCombo.Items.IndexOf(UnitTable.FieldByName('DESCRIPTIO').Value);
    Close;
    TableName := 'Chemunit';
    Open;
    ChemCombo.Items.Clear;
    while not EOF do
    begin
      ChemCombo.Items.Add(UnitTable.FieldByName('DESCRIPTIO').Value);
      Next;
    end;
    Locate('UNIT', ChemUnit, []);
    ChemCombo.ItemIndex := ChemCombo.Items.IndexOf(UnitTable.FieldByName('DESCRIPTIO').Value);
    Close;
    TableName := 'Elecunit';
    Open;
    ECCombo.Items.Clear;
    while not EOF do
    begin
      ECCombo.Items.Add(UnitTable.FieldByName('DESCRIPTIO').Value);
      Next;
    end;
    Locate('UNIT', ECUnit, []);
    ECCombo.ItemIndex := ECCombo.Items.IndexOf(UnitTable.FieldByName('DESCRIPTIO').Value);
    Close;
    TableName := 'Presunit';
    Open;
    PressureComboBox.Items.Clear;
    while not EOF do
    begin
      PressureComboBox.Items.Add(UnitTable.FieldByName('DESCRIPTIO').Value);
      Next;
    end;
    Locate('UNIT', PressureUnit, []);
    PressureComboBox.ItemIndex := PressureComboBox.Items.IndexOf(UnitTable.FieldByName('DESCRIPTIO').Value);
    Close;
  end;
  if AsN then NComboBox.ItemIndex := 0
    else NComboBox.ItemIndex := 1;
  {Chemistry Standards}
  with DataModuleMain do
  begin
    StandDescrTable.Open;
    while not StandDescrTable.EOF do
    begin
      StandardComboBox.Items.Add(StandDescrTableSTAND_DESCR.Value);
      StandDescrTable.Next;
    end;
    StandardComboBox.ItemIndex := ChemStandard;
    StandDescrTable.Locate('ID', ChemStandard, []);
    LimitBox.Enabled := StandDescrTable.FieldByName('TABLE_NAME').AsString <> 'chmclass';
    StandDescrTable.Close;
  end;
  Edit1.Font := MaxRecFont;
  Edit2.Font := MaxAllFont;
  Edit3.Font := MinRecFont;
  Edit4.Font := MinAllFont;
  {Report Settings}
  ColorButtonPColumnHeader.ButtonColor := ColumnHeaderBandColor;
  ColorButtonPReportHeader.ButtonColor := ReportHeaderBandColor;
  FontBtn.Font := ReportFont;
  SpinEdit1.Value := LeftMargin;
  SpinEdit2.Value := TopMargin;
  SpinEdit3.Value := BotMargin;
  SpinEdit4.Value := LLeftMargin;
  SpinEdit5.Value := LTopMargin;
  SpinEdit6.Value := LRightMargin;
  CheckBoxShowNoInfo.Checked := PrintNoInfo;
  CheckBoxWSpace.Checked := UseWSpaceRepSet;
  Screen.Cursor := crDefault;
end;

procedure TSysSetDlgForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SysSetDlgForm := Nil;
  CloseAction := caFree;
end;

procedure TSysSetDlgForm.Button9Click(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TSysSetDlgForm.Button8Click(Sender: TObject);
begin
  Memo1.Lines.SaveToFile(WSpaceDir + DirectorySeparator + 'Userinfo.txt');
end;

procedure TSysSetDlgForm.HelpButtonClick(Sender: TObject);
begin
  Application.HelpKeyword('Preferences');
end;

procedure TSysSetDlgForm.OKButtonClick(Sender: TObject);
var
  WSpaceIniFile: TIniFile;
begin
  Screen.Cursor := crHourGlass;
  //System
  Language := LangComboBox.Text;
  AutoEditData := CheckBoxAutoEdit.Checked;
  QGISExe := EditQGISExe.Text;
  {$IFDEF Windows}
  LookForUpdate := CheckBoxUpdates.Checked;
  with TRegistry.Create do
  begin
    Openkey('\Software\Lazarus Projects\Aquabase', True);
    WriteBool('LookForUpdate', LookForUpdate);
    Free;
  end;
  {$ENDIF}
  if SettingsDir <> EditSettingsDir.Text then //if it has changed
  begin
    SettingsDir := EditSettingsDir.Text;
    with DataModuleMain do
    begin
      with ZConnectionCountries do
      begin
        Database := ProgramDir + DirectorySeparator + 'international.gpkg';
        LibraryLocation := SQLiteLib;
        Connect;
        with CheckQuery do
        begin
          Connection := ZConnectionCountries;
          SQL.Clear;
          SQL.Add('SELECT * FROM Countries WHERE name_en = ' + QuotedStr(Country));
          Open;
          CountryDB := FieldByName('LANG_1').AsString;
          Close;
          SQL.Clear;
        end;
        Disconnect;
      end;
      ZConnectionLanguage.Connected := False;
      ZConnectionSettings.Connected := False;
      if MoveSettings then
      begin
        CopyFile(WSpaceDir + DirectorySeparator + CountryDB + '.sqlite', SelectDirectoryDialog.FileName + DirectorySeparator + CountryDB + '.sqlite');
        CopyFile(WSpaceDir + DirectorySeparator + 'settings.sqlite', SelectDirectoryDialog.FileName + DirectorySeparator + 'settings.sqlite');
      end;
      if DeleteSettings then
      begin
        DeleteFile(WSpaceDir + DirectorySeparator + CountryDB + '.sqlite');
        DeleteFile(WSpaceDir + DirectorySeparator + 'settings.sqlite');
      end;
      ZConnectionLanguage.Database := SettingsDir + DirectorySeparator + CountryDB + '.sqlite';
      ZConnectionLanguage.Connect;
      ZConnectionSettings.Database := SettingsDir + DirectorySeparator + 'settings.sqlite';
      ZConnectionSettings.Connect;
      if SettingsDir = ProgramDir then
        LookupTable.ReadOnly := True
      else
        LookupTable.ReadOnly := False;
    end;
  end;
  //Report
  UseWSpaceRepSet := CheckBoxWSpace.Checked;
  PrintNoInfo := CheckBoxShowNoInfo.Checked;
  LeftMargin := SpinEdit1.Value;
  TopMargin := SpinEdit2.Value;
  BotMargin := SpinEdit3.Value;
  LLeftMargin := SpinEdit4.Value;
  LTopMargin := SpinEdit5.Value;
  LRightMargin := SpinEdit6.Value;
  ColumnHeaderBandColor := ColorButtonPColumnHeader.ButtonColor;
  ReportHeaderBandColor := ColorButtonPReportHeader.ButtonColor;
  //Report Fonts
  with ReportFont do
  begin
    Name := FontBtn.Font.Name;
    Color := FontBtn.Font.Color;
    Size := FontBtn.Font.Size;
    Style := FontBtn.Font.Style;
  end;
  //Other Fonts
  with MaxRecFont do
  begin
    Name := Edit1.Font.Name;
    Color := Edit1.Font.Color;
    Size := Edit1.Font.Size;
    Style := Edit1.Font.Style;
  end;
  with MaxAllFont do
  begin
    Name := Edit2.Font.Name;
    Color := Edit2.Font.Color;
    Size := Edit2.Font.Size;
    Style := Edit2.Font.Style;
  end;
  with MinRecFont do
  begin
    Name := Edit3.Font.Name;
    Color := Edit3.Font.Color;
    Size := Edit3.Font.Size;
    Style := Edit3.Font.Style;
  end;
  with MinAllFont do
  begin
    Name := Edit4.Font.Name;
    Color := Edit4.Font.Color;
    Size := Edit4.Font.Size;
    Style := Edit4.Font.Style;
  end;
  //Units
  with UnitTable do
  begin
    TableName := 'Lengunit';
    Open;
    MoveBy(LengthCombo.Items.IndexOf(LengthCombo.Text));
    LengthUnit := UnitTable.FieldByName('UNIT').Value;
    LengthFactor := UnitTable.FieldByName('FACTOR').Value;
    Close;
    TableName := 'Volmunit';
    Open;
    MoveBy(VolumeCombo.Items.IndexOf(VolumeCombo.Text));
    VolumeUnit := UnitTable.FieldByName('UNIT').Value;
    VolumeFactor := UnitTable.FieldByName('FACTOR').Value;
    Close;
    TableName := 'Timeunit';
    Open;
    MoveBy(TimeCombo.Items.IndexOf(TimeCombo.Text));
    TimeUnit := UnitTable.FieldByName('UNIT').Value;
    TimeFactor := UnitTable.FieldByName('FACTOR').Value;
    DisUnit := VolumeUnit + '/' + TimeUnit;
    Close;
    TableName := 'Diamunit';
    Open;
    MoveBy(DiamCombo.Items.IndexOf(DiamCombo.Text));
    DiamUnit := UnitTable.FieldByName('UNIT').Value;
    DiamFactor := UnitTable.FieldByName('FACTOR').Value;
    Close;
    TableName := 'Elecunit';
    Open;
    MoveBy(ECCombo.Items.IndexOf(ECCombo.Text));
    ECUnit := UnitTable.FieldByName('UNIT').Value;
    ECFactor := UnitTable.FieldByName('FACTOR').Value;
    Close;
    TableName := 'Chemunit';
    Open;
    MoveBy(ChemCombo.Items.IndexOf(ChemCombo.Text));
    ChemUnit := UnitTable.FieldByName('UNIT').Value;
    ChemFactor := UnitTable.FieldByName('FACTOR').Value;
    Close;
    TableName := 'Presunit';
    Open;
    MoveBy(PressureComboBox.Items.IndexOf(PressureComboBox.Text));
    PressureUnit := UnitTable.FieldByName('UNIT').Value;
    PressureFactor := UnitTable.FieldByName('FACTOR').Value;
    Close;
  end;
  AsN := NComboBox.ItemIndex = 0;
  //Chemistry
  ChemStandard := StandardComboBox.ItemIndex;
  //open the chemistry standards table
  with DataModuleMain do
  begin
    StandDescrTable.Open;
    if StandDescrTable.Locate('ID', ChemStandard, []) then
      ChemStandardDescr := StandDescrTable.FieldByName('STAND_DESCR').AsString
    else
      ChemStandardDescr := 'No valid standard selected!';
    if StandDescrTable.FieldByName('TABLE_NAME').AsString = 'chmclass' then //for SA domestic classes
    begin
      StandardTable.Close;
      ClassTable.Open;
    end
    else
    begin
      ClassTable.Close;
      StandardTable.Open;
    end;
    StandDescrTable.Close;
  end;
  //Workspace
  WSpaceIniFile := TIniFile.Create(WSpaceDir + DirectorySeparator + 'workspace.ini');
  Country := ComboBoxCountry.Text;
  WSpaceIniFile.WriteString('International', 'Country', Country);
  CoordSysDescr := ComboBoxCoordSys.Text;
  WSpaceIniFile.WriteString('International', 'CoordSys', CoordSysDescr);
  //check for LO from Map Ref first and set CoordSyNr
  if Pos('LO from Map', ComboBoxCoordSys.Text) >= 1 then
  begin
    if Country = 'South Africa' then
    begin
      if Pos('Cape', ComboBoxCoordSys.Text) = 1 then
        CoordSysNr := 2
      else
        CoordSysNr := 1;
    end
    else
    if Country = 'Lesotho' then
    begin
      if Pos('Cape', ComboBoxCoordSys.Text) = 1 then
        CoordSysNr := 4
      else
        CoordSysNr := 3;
    end
    else
    if (Country = 'eSwatini') or (Country = 'Swaziland') then
    begin
      if Pos('Cape', ComboBoxCoordSys.Text) = 1 then
        CoordSysNr := 6
      else
        CoordSysNr := 5;
    end
    else
    if Country = 'Namibia' then
    begin
      CoordSysNr := 7;
    end;
  end
  else //for all non-LO from map ref.
  with DataModuleMain.ZQueryProj do
  begin
    Open;
    Locate('crs', ComboBoxCoordSys.Text, []);
    CoordSysNr := FieldByName('SRID').AsInteger;
    Close;
  end;
  with DataModuleMain.CheckQuery do //to determine if dst crs is LatLong
  begin
    Connection := DataModuleMain.ZConnectionProj;
    SQL.Clear;
    SQL.Add('select code, type from crs_view');
    SQL.Add('where type like ' + QuotedStr('geographic%'));
    SQL.Add('and code = ' + QuotedStr(IntToStr(CoordSysNr)));
    Open;
    dstLatLong := RecordCount > 0;
    Close;
    Connection := DataModuleMain.ZConnectionDB; //reset to default
  end;
  WSpaceIniFile.WriteInteger('International', 'CoordSysNr', CoordSysNr);
  //check if viewed coordinates are LO
  dstLO := InRange(CoordSysNr, 1, 7)
    or InRange(CoordSysNr, 2046, 2055)
    or InRange(CoordSysNr, 22275, 22293) //all RSA LOs
    or InRange(CoordSysNr, 29371, 29385); //all Nam LOs
  ShowDMS := CheckBoxDMS.Checked;
  WSpaceIniFile.WriteBool('International', 'DMS', ShowDMS);
  AutoNumber := NewNrSpinEdit.Value;
  WSpaceIniFile.WriteInteger('System', 'AutoNumber', NewNrSpinEdit.Value);
  if CheckBoxWSpace.Checked then
  begin
    WSpaceIniFile.WriteBool('Reports', 'UseSettings', True);
    WSpaceIniFile.WriteBool('Reports', 'PrintNoInfo', PrintNoInfo);
    WSpaceIniFile.WriteInteger('Reports', 'LeftMargin', LeftMargin);
    WSpaceIniFile.WriteInteger('Reports', 'TopMargin', TopMargin);
    WSpaceIniFile.WriteInteger('Reports', 'BottomMargin', BotMargin);
    WSpaceIniFile.WriteInteger('Reports', 'LandscapeLeftMargin', LLeftMargin);
    WSpaceIniFile.WriteInteger('Reports', 'LandscapeTopMargin', LTopMargin);
    WSpaceIniFile.WriteInteger('Reports', 'LandscapeRightMargin', LRightMargin);
    WSpaceIniFile.WriteInteger('Reports', 'ColumnHeaderBandColour', ColumnHeaderBandColor);
    WSpaceIniFile.WriteInteger('Reports', 'ReportHeaderBandColour', ReportHeaderBandColor);
    WSpaceIniFile.WriteString('Reports', 'FontName', ReportFont.Name);
    WSpaceIniFile.WriteInteger('Reports', 'FontSize', ReportFont.Size);
    WSpaceIniFile.WriteInteger('Reports', 'FontColour', ReportFont.Color);
    WSpaceIniFile.WriteString('Reports', 'FontStyle', ConvertFromStyle(ReportFont.Style));
  end
  else
    WSpaceIniFile.WriteBool('Reports', 'UseSettings', False);
  AllowSmallChars := CheckBoxSmallChars.Checked;
  WSpaceIniFile.WriteBool('System', 'AllowSmallChars', AllowSmallChars);
  WSpaceIniFile.Free;
  Application.ProcessMessages;
  SaveSettings := True;
  if DataModuleMain.ZQueryView.RecordCount > 0 then
    DataModuleMain.ZQueryView.Refresh;
  Screen.Cursor := crDefault;
end;

procedure TSysSetDlgForm.SpeedButton3Click(Sender: TObject);
var
  CurrentSettingsDir: String;
begin
  CurrentSettingsDir := EditSettingsDir.Text;
  SelectDirectoryDialog.InitialDir := EditSettingsDir.Text;
  if SelectDirectoryDialog.Execute then
  with DataModuleMain do
  begin
    with ZConnectionCountries do
    begin
      Connect;
      Disconnect;
    end;
    if not FileExists(SelectDirectoryDialog.FileName + DirectorySeparator + 'settings.sqlite') then
    begin
      if MessageDlg('The selected folder does not seem to contain the necessary settings data. Do you want to create the default settings data?',
        mtWarning, [mbYes, mbNo], mrNo) = mrYes then
      if SettingsDir = WSpaceDir then
      begin
        if MessageDlg('Do you want to move this workspace''s settings data to the new location? Otherwise the default settings data will be used.',
          mtConfirmation, [mbYes, mbNo], mrYes) = mrYes then
        begin
          MoveSettings := True;
          DeleteSettings := True;
        end
        else
        begin
          CopyFile(ProgramDir + DirectorySeparator + 'defaults' + DirectorySeparator + CountryDB + '.sqlite', SelectDirectoryDialog.FileName + DirectorySeparator + CountryDB + '.sqlite');
          CopyFile(ProgramDir + DirectorySeparator + 'defaults' + DirectorySeparator + 'settings.sqlite', SelectDirectoryDialog.FileName + DirectorySeparator + 'settings.sqlite');
        end;
      end
      else
      begin
        CopyFile(ProgramDir + DirectorySeparator + 'defaults' + DirectorySeparator + CountryDB + '.sqlite', SelectDirectoryDialog.FileName + DirectorySeparator + CountryDB + '.sqlite');
        CopyFile(ProgramDir + DirectorySeparator + 'defaults' + DirectorySeparator + 'settings.sqlite', SelectDirectoryDialog.FileName + DirectorySeparator + 'settings.sqlite');
      end;
    end
    else
    begin
      if CurrentSettingsDir = WSpaceDir then
      begin
        case MessageDlg('This folder has existing settings data! Do you want to move the workspace''s settings data to the new location and overwrite the settings, then delete the settings data from the workspace? "YES" will move but not delete the settings data from the workspace.',
          mtConfirmation, [mbYesToAll, mbYes, mbNo], mrNo) of
        mrYesToAll: begin
                      MoveSettings := True;
                      DeleteSettings := True;
                    end;
             mrYes: begin
                      MoveSettings := True;
                      DeleteSettings := False;
                    end;
              mrNo: begin
                      MoveSettings := False;
                      DeleteSettings := False;
                    end;
        end; //of case
      end;
    end;
    EditSettingsDir.Text := SelectDirectoryDialog.FileName;
  end;
end;

procedure TSysSetDlgForm.SpeedButton4Click(Sender: TObject);
begin
  with OpenDialog do
  begin
    InitialDir := GetUserDir;
    Title := 'Select QGIS Executable';
    {$IFDEF WINDOWS}
    FileName := 'qgis.bat';
    Filter := 'QGIS executable File (*.bat)|*.bat';
    {$ENDIF}
    {$IFDEF UNIX}
    FileName := 'qgis';
    Filter := 'QGIS executable File (*.*)|*.*';
    {$ENDIF}
    if Execute then
    begin
      EditQGISExe.Text := FileName;
    end;
  end;
end;

procedure TSysSetDlgForm.StandardComboBoxChange(Sender: TObject);
begin
  LimitBox.Enabled := StandardComboBox.ItemIndex <> 2;
end;

procedure TSysSetDlgForm.SystemTabSheetEnter(Sender: TObject);
begin
  UpdateMessage := True;
end;

procedure TSysSetDlgForm.SystemTabSheetExit(Sender: TObject);
begin
  UpdateMessage := False;
end;

procedure TSysSetDlgForm.SysBackClrClick(Sender: TObject);
begin
  if ColorDialog1.Execute then
    SysBackClr.Color := ColorDialog1.Color;
end;

procedure TSysSetDlgForm.Button7Click(Sender: TObject);
begin
  try
    Opendialog.Filter := 'User info file (*.txt)|*.txt';
    if OpenDialog.Execute then
      Memo1.Lines.LoadFromFile(OpenDialog.FileName);
  except
    MessageDlg('This is not a valid info file!', mtError, [mbOk], 0);
  end;
end;

procedure TSysSetDlgForm.SpeedButton2Click(Sender: TObject);
begin
  try
    Opendialog.Filter := 'JPEG File (*.jpg)|*.jpg|Bitmap File (*.bmp)|*.bmp';
    if OpenDialog.Execute then
      if FileExists(WSpaceDir + DirectorySeparator + 'userlogo.bmp') or FileExists(WSpaceDir + DirectorySeparator + 'userlogo.jpg')then
        if MessageDlg('User Logo already exists in this workspace! Overwrite? Yes = Replace, No = Keep existing', mtConfirmation, [mbYes, mbNo],0) = mrYes then
        begin
          if ExtractFileExt(OpenDialog.FileName) = '.bmp' then
          begin
            CopyFile(OpenDialog.FileName, WSpaceDir + DirectorySeparator + 'userlogo.bmp');
            image2.Picture.LoadFromFile(WSpaceDir + DirectorySeparator + 'userlogo.bmp'); // load new logo
          end
          else
          if ExtractFileExt(OpenDialog.FileName) = '.jpg' then
          begin
            CopyFile(OpenDialog.FileName, WSpaceDir + DirectorySeparator + 'userlogo.jpg');
            image2.Picture.LoadFromFile(WSpaceDir + DirectorySeparator + 'userlogo.jpg'); // load new logo
          end
          else
            MessageDlg('Only JPG or BMP logos are supported at this stage!', mtError, [mbOK], 0);
        end
        else
        begin
          if ExtractFileExt(OpenDialog.FileName) = '.bmp' then
            image2.Picture.LoadFromFile(WSpaceDir + DirectorySeparator + 'userlogo.bmp') // load logo
          else
          if ExtractFileExt(OpenDialog.FileName) = '.jpg' then
            image2.Picture.LoadFromFile(WSpaceDir + DirectorySeparator + 'userlogo.jpg'); // load logo
        end;
  except
    MessageDlg('File format is invalid or file is corrupt!', mtError, [mbOk], 0);
  end;
end;

procedure TSysSetDlgForm.ZQueryCountriesAfterOpen(DataSet: TDataSet);
var
  lang: String;
begin
  lang := DataModuleMain.GetOSLanguage;
  with ZQueryCountries do
  begin
    Open;
    //Fill Country combobox
    if FindField('name_' + lang) <> NIL then
    while not EOF do
    begin
      if not FieldByName('name_' + lang).IsNULL then
        ComboBoxCountry.Items.Add(FieldByName('name_' + lang).AsString)
      else
        ComboBoxCountry.Items.Add(FindField('name_en').AsString);
      Next;
    end
    else
    while not EOF do
    begin
      ComboBoxCountry.Items.Add(FindField('name_en').AsString);
      Next;
    end;
    Close;
  end;
end;

procedure TSysSetDlgForm.ZQueryCountriesBeforeOpen(DataSet: TDataSet);
begin
  with ZQueryCountries do
  begin
    SQL.Clear;
    SQL.Add('select * from countries');
  end;
end;

end.
