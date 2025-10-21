unit storedcoordsin;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ButtonPanel, StdCtrls,
  StrUtils, IniFiles, Math;

type

  { TFormStoredCoords }

  TFormStoredCoords = class(TForm)
    ButtonPanel1: TButtonPanel;
    ComboBoxCoordSys: TComboBox;
    CoordLabel: TLabel;
    Label1: TLabel;
    procedure ComboBoxCoordSysChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private

  public

  end;

var
  FormStoredCoords: TFormStoredCoords;

implementation

uses VARINIT, MainDataModule;

{$R *.lfm}

{ TFormStoredCoords }

procedure TFormStoredCoords.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  with Label1 do
  begin
    AutoSize := False;
    Width := 300;
    Height := 32;
    WordWrap := True;
  end;
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
  //for LO countries
  if AnsiIndexStr(Country, LO_Countries) >= 0 then
  begin
    if AnsiIndexStr(Country, LO_Countries) <= 3 then
    begin
      ComboBoxCoordSys.Items.Add('Cape (LO from Map Reference)');
      ComboBoxCoordSys.Items.Add('Hartebeesthoek94 (LO from Map Reference)');
    end
    else
      ComboBoxCoordSys.Items.Add('Schwarzeck (LO from Map Reference)');
  end;
  with DataModuleMain.ZQueryProj do
  begin
    Open;
    Locate('SRID', OrigCoordSysNr, []);
    ComboBoxCoordSys.ItemIndex := ComboBoxCoordSys.Items.IndexOf(FieldByName('crs').Value);
    Close;
  end;
end;

procedure TFormStoredCoords.ComboBoxCoordSysChange(Sender: TObject);
begin
  ButtonPanel1.OKButton.Enabled := ComboBoxCoordSys.Text <> CoordSysDescr;
end;

procedure TFormStoredCoords.OKButtonClick(Sender: TObject);
var
  WSpaceIniFile: TIniFile;
begin
  if MessageDlg('Are you sure you want to set the coordinate reference system of the stored coordinates to '
    + ComboBoxCoordSys.Text + '?' + LineEnding + LineEnding + 'This will immediately effect the coordinate conversions '
    + 'and is only necessary if you or someone else have changed the coordinates in the database to a different CRS.',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    WSpaceIniFile := TIniFile.Create(WSpaceDir + DirectorySeparator + 'workspace.ini');
    //check for LO from Map Ref first and set CoordSyNr
    if Pos('LO from Map', ComboBoxCoordSys.Text) >= 1 then
    begin
      if Country = 'South Africa' then
      begin
        if Pos('Cape', ComboBoxCoordSys.Text) = 1 then
          OrigCoordSysNr := 2
        else
          OrigCoordSysNr := 1;
      end
      else
      if Country = 'Lesotho' then
      begin
        if Pos('Cape', ComboBoxCoordSys.Text) = 1 then
          OrigCoordSysNr := 4
        else
          OrigCoordSysNr := 3;
      end
      else
      if (Country = 'eSwatini') or (Country = 'Swaziland') then
      begin
        if Pos('Cape', ComboBoxCoordSys.Text) = 1 then
          OrigCoordSysNr := 6
        else
          OrigCoordSysNr := 5;
      end
      else
      if Country = 'Namibia' then
      begin
        OrigCoordSysNr := 7;
      end;
    end
    else //for all non-LO
    with DataModuleMain.ZQueryProj do
    begin
      Open;
      Locate('crs', ComboBoxCoordSys.Text, []);
      OrigCoordSysNr := FieldByName('SRID').AsInteger;
      Close;
    end;
    //check if coordinates are LO
    srcLO := InRange(OrigCoordSysNr, 1, 7)
      or InRange(OrigCoordSysNr, 2046, 2055)
      or InRange(OrigCoordSysNr, 22275, 22293) //all RSA LOs
      or InRange(OrigCoordSysNr, 29371, 29385); //all Nam LOs
    WSpaceIniFile.WriteInteger('International', 'OrigCoordSysNr', OrigCoordSysNr);
    WSpaceIniFile.Free;
  end;
end;

end.

