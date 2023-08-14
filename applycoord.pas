{ Copyright (C) 2023 Immo Blecher, immo@blecher.co.za

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
unit applycoord;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, ZDataset, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ButtonPanel, LCLType, IniFiles, StrUtils;

type

  { TApplyCoordForm }

  TApplyCoordForm = class(TForm)
    BasicinfQuery: TZQuery;
    BasicinfQueryALTITUDE: TFloatField;
    BasicinfQueryLATITUDE: TFloatField;
    BasicinfQueryLONGITUDE: TFloatField;
    BasicinfQueryNGDB_FLAG: TLargeintField;
    BasicinfQueryOGR_FID: TLargeintField;
    BasicinfQuerySITE_ID_NR: TStringField;
    BasicinfQueryX_COORD: TFloatField;
    BasicinfQueryY_COORD: TFloatField;
    ButtonPanel1: TButtonPanel;
    ComboBox1: TComboBox;
    ComboBoxCoordSys: TComboBox;
    CoordLabel: TLabel;
    CountryTable: TZTable;
    CountryTableCOUNTRY_ID: TLargeintField;
    CountryTableC_NAME: TStringField;
    Label1: TLabel;
    procedure BasicinfQueryBeforeOpen(DataSet: TDataSet);
    procedure ComboBox1Change(Sender: TObject);
    procedure CountryTableBeforeOpen(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  ApplyCoordForm: TApplyCoordForm;

implementation

{$R *.lfm}

uses VARINIT, MainDataModule, progressbox;

const
  CoordMsg = 'Oops, something went wrong with a coordinate conversion! Your selected coordinate system may not be available in your database! Please upgrade your database or select a different coordinate system.';

{ TApplyCoordForm }

//Convert from Degree, minute, second to decimal degrees
function DMSToDeg(coord: String): Real;
var D, M, S: ShortString;
    DecD, DecM, DecS: Double;
begin
  D := Copy(coord, 1, Pos('°', coord) - 1);
  DecD := StrToFloat(D);
  M := Copy(coord, Pos('°', coord) + 2, 2);
  DecM := StrToFloat(M)/60;
  S := Copy(coord, Pos('°', coord) + 5, 5);
  DecS := StrToFloat(S)/3600;
  if (Pos('W', coord) > 0) or (Pos('S', coord) > 0) then
    Result := -DecD - DecM - DecS
  else
    Result := DecD + DecM + DecS;
end;

procedure TApplyCoordForm.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
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
  ComboBoxCoordSys.ItemIndex := 0;
end;

procedure TApplyCoordForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TApplyCoordForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TApplyCoordForm.OKButtonClick(Sender: TObject);
var
  NrRecs: LongInt;
  OutX, OutY: ShortString;
  newProj: Word;
  Latlong: Boolean;
begin
  newProj := 0;
  Latlong := False;
  //Pre-processing
  if ComboBox1.ItemIndex > 0 then
  begin
    if MessageDlg('Are you sure you want to apply coordinate system "' +
    ComboBoxCoordSys.Items[ApplyCoordForm.ComboBoxCoordSys.ItemIndex] +
      '" to the "basicinf" table?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      //Change basicinf X_Coord and Y_Coord coordinates with newProj
      //check for LO from Map Ref first and set CoordSyNr
      if Pos('LO from Map', ComboBoxCoordSys.Text) >= 1 then
      begin
        if Country = 'South Africa' then
        begin
          if Pos('Cape', ComboBoxCoordSys.Text) = 1 then
            newProj := 2
          else
            newProj := 1;
        end
        else
        if Country = 'Lesotho' then
        begin
          if Pos('Cape', ComboBoxCoordSys.Text) = 1 then
            newProj := 4
          else
            newProj := 3;
        end
        else
        if (Country = 'eSwatini') or (Country = 'Swaziland') then
        begin
          if Pos('Cape', ComboBoxCoordSys.Text) = 1 then
            newProj := 6
          else
            newProj := 5;
        end
        else
        if Country = 'Namibia' then
        begin
          newProj := 7;
        end;
      end
      else //for all non-LO
      with DataModuleMain.ZQueryProj do
      begin
        Open;
        Locate('crs', ComboBoxCoordSys.Text, []);
        newProj := FieldByName('SRID').AsInteger;
        Close;
      end;
    end;
  end
  else
  begin
    //write WGS84 to Longitude/Latitude
    Latlong := True
  end;
  Screen.Cursor := crSQLWait;
  BasicinfQuery.Open;
  NrRecs := BasicinfQuery.RecordCount;
  Screen.Cursor := crDefault;
  Application.ProcessMessages;
  ProgressBoxForm := TProgressBoxForm.Create(Application);
  ProgressBoxForm.Caption := 'Progress on Applying Coordinates...';
  ProgressBoxForm.ProgressBar1.Max := NrRecs;
  ProgressBoxForm.Show;
  Application.ProcessMessages;
  Visible := False; //make the dialog invisible
  Application.ProcessMessages;
  while (not ProgressBoxForm.CancelPressed) and (not BasicinfQuery.EOF) do
  begin
    ProgressBoxForm.ProgressBar1.Position := ProgressBoxForm.ProgressBar1.Position + 1;
    ProgressBoxForm.Label1.Caption := 'Applying coordinates at site ' + BasicinfQuerySITE_ID_NR.Value + '...';
    Application.ProcessMessages;
    //Convert coordinates to Lat/Long or new projection in basicinf
    BasicinfQuery.Edit;
    if Latlong then //update the Longitude/Latitude fields
    begin
      //reset Longitude to 0 to trigger the trigger (longitude changed)
      BasicinfQueryLONGITUDE.Value := 0;
      BasicinfQuery.Post;
      BasicinfQuery.Edit;
      //then calculate new Longitude/Latitude
      if OrigCoordSysNr = 4326 then //don't convert, just copy
      begin
        BasicinfQueryLONGITUDE.Value := BasicinfQueryX_COORD.Value;
        BasicinfQueryLATITUDE.Value := BasicinfQueryY_COORD.Value;;
      end
      else
      if DataModuleMain.cs2cs(BasicinfQueryX_COORD.AsString, BasicinfQueryY_COORD.AsString, DataModuleMain.GetMapRef(BasicinfQuerySITE_ID_NR.Value), OrigCoordSysNr, 4326, OutX, OutY) then
      begin
        if ShowDMS then //convert to Degrees
        begin
          BasicinfQueryLONGITUDE.Value := DMSToDeg(OutX);
          BasicinfQueryLATITUDE.Value := DMSToDeg(OutY);
        end
        else
        begin
          BasicinfQueryLONGITUDE.Value := StrToFloat(OutX);
          BasicinfQueryLATITUDE.Value := StrToFloat(OutY);
        end;
        BasicinfQueryNGDB_FLAG.Value := UpdtdInBatch;
      end
      else
        ShowMessage(CoordMsg);
    end
    else //update the X_COORD and Y_COORD fields
    begin
      //then calculate new X_COORD, Y_COORD
      if DataModuleMain.cs2cs(BasicinfQueryX_COORD.AsString, BasicinfQueryY_COORD.AsString, DataModuleMain.GetMapRef(BasicinfQuerySITE_ID_NR.Value), OrigCoordSysNr, newProj, OutX, OutY) then
      begin
        BasicinfQueryX_COORD.Value := StrToFloat(OutX);
        BasicinfQueryY_COORD.Value := StrToFloat(OutY);
        BasicinfQueryNGDB_FLAG.Value := UpdtdInBatch;
      end
      else
        ShowMessage(CoordMsg);
    end;
    try
      BasicinfQuery.Post;
    except on E: Exception do
      MessageDlg(E.Message + ': Cannot convert coordinates due to errors in your X_COORD or Y_COORD coordinate values! Please check these fields for values not possible for the stored coordinate system.', mtError, [mbOK], 0);
    end;
    BasicinfQuery.Next;
  end;
  BasicinfQuery.Close;
  if Latlong then
  with DataModuleMain.ZConnectionDB do
  begin
    if Tag = 1 then
      ExecuteDirect('update basicinf set geometry = SetSrid(MakePoint(longitude, latitude), 4326);')
    else
      ExecuteDirect('update basicinf set geometry = ST_SetSrid(ST_MakePoint(longitude, latitude), 4326);');
  end;
  ProgressBoxForm.Finished := True;
  if ProgressBoxForm.CancelPressed then
  begin
    ProgressBoxForm.Close;
    Application.ProcessMessages;
    MessageDlg('Process aborted! Your coordinates may not be completely applied. You may now have a mess!!!', mtWarning, [mbOK], 0);
  end
  else
  begin
    if not LatLong then
    begin
      //set the OrigCoordSysNr and also in workspace.ini
      OrigCoordSysNr := newProj;
      with TIniFile.Create(WSpaceDir + DirectorySeparator + 'workspace.ini') do
      begin
        WriteInteger('International', 'OrigCoordSysNr', OrigCoordSysNr);
        Free;
      end;
      DataModuleMain.BasicinfQuery.Refresh;
    end;
    ProgressBoxForm.Close;
    Application.ProcessMessages;
    MessageDlg('Coordinates applied successfully!', mtInformation, [mbOk], 0)
  end;
  Close; //close the dialog
end;

procedure TApplyCoordForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CountryTable.Close;
  CloseAction := caFree;
end;

procedure TApplyCoordForm.ComboBox1Change(Sender: TObject);
begin
  ComboBoxCoordSys.Enabled := ComboBox1.ItemIndex > 0;
  if ComboBox1.ItemIndex = 0 then
    ComboBoxCoordSys.ItemIndex := ComboBoxCoordSys.Items.IndexOf('WGS 84 / Lat/Long');;
end;

procedure TApplyCoordForm.BasicinfQueryBeforeOpen(DataSet: TDataSet);
begin
  BasicinfQuery.Connection := DataModuleMain.ZConnectionDB;
end;

procedure TApplyCoordForm.CountryTableBeforeOpen(DataSet: TDataSet);
begin
  CountryTable.Connection := DataModuleMain.ZConnectionLanguage;
end;

end.

