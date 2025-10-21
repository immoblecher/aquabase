{ Copyright (C) 2020 Immo Blecher, immo@blecher.co.za
  Adapted from MapViewer Example by "wp" (Werner Pamler) using lazMapViewerPkg:

  Component for viewing maps (Google, OpenStreetMap, etc).
  This is a fork of MapViewer by ti_dic
  (https://sourceforge.net/p/roadbook/code/ci/master/tree/mapviewer/)
  which itself is based on the MapViewer by Maciej Kaczkowski
  (https://github.com/maciejkaczkowski/mapviewer).
  License: modified LGPL with linking exception, like FreePascal RTL/FCL
  and Lazarus LCL.

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
unit mapview;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Types, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ComCtrls, Buttons, IntfGraphics, ColorBox, Spin, mvGeoNames,
  mvMapViewer, mvTypes, mvGpsObj, mvDrawingEngine, ZDataset,
  db, strutils, GraphUtil, LCLIntf;

type

  { TMapViewForm }

  TMapViewForm = class(TForm)
    Bevel1: TBevel;
    ButtonReloadView2: TButton;
    CheckBoxLabels: TCheckBox;
    CheckBoxLables: TCheckBox;
    HelpButton: TBitBtn;
    BtnGPSPoints: TButton;
    BtnLoadGPXFile: TButton;
    BtnSearch: TButton;
    BtnGoTo: TButton;
    BtnSaveToFile: TButton;
    BtnPOITextFont: TButton;
    ButtonZoomCurrent: TButton;
    ButtonShowLegend: TButton;
    ButtonZoomView: TButton;
    ButtonReloadView: TButton;
    ButtonReloadView1: TButton;
    CbDoubleBuffer: TCheckBox;
    CbFoundLocations: TComboBox;
    CbLocations: TComboBox;
    CbProviders: TComboBox;
    CbUseThreads: TCheckBox;
    CbMouseCoords: TGroupBox;
    CbDistanceUnits: TComboBox;
    CbDebugTiles: TCheckBox;
    CbShowPOIImage: TCheckBox;
    cbPOITextBgColor: TColorBox;
    CheckBoxCurrent: TCheckBox;
    ColorButtonPoints: TColorButton;
    ColorDialog1: TColorDialog;
    ComboBoxDMS: TComboBox;
    ComboBoxViews: TComboBox;
    FontDialog: TFontDialog;
    GbCenterCoords: TGroupBox;
    GbGPS: TGroupBox;
    GbScreenSize: TGroupBox;
    GbSearch: TGroupBox;
    GPSPointInfo: TLabel;
    InfoBtnGPSPoints: TLabel;
    InfoCenterLatitude: TLabel;
    InfoViewportHeight: TLabel;
    InfoCenterLongitude: TLabel;
    InfoViewportWidth: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    LblPOITextBgColor: TLabel;
    LblSelectLocation: TLabel;
    LblCenterLatitude: TLabel;
    LblViewportHeight: TLabel;
    LblViewportWidth: TLabel;
    LblPositionLongitude: TLabel;
    LblPositionLatitude: TLabel;
    InfoPositionLongitude: TLabel;
    InfoPositionLatitude: TLabel;
    LblCenterLongitude: TLabel;
    LblProviders: TLabel;
    LblZoom: TLabel;
    GeoNames: TMVGeoNames;
    BtnLoadMapProviders: TSpeedButton;
    BtnSaveMapProviders: TSpeedButton;
    MapView: TMapView;
    OpenDialog: TOpenDialog;
    PageControl: TPageControl;
    PgData: TTabSheet;
    PgConfig: TTabSheet;
    PgMapData: TTabSheet;
    SpeedButton1: TSpeedButton;
    SpinEditRadius: TSpinEdit;
    StatusBar1: TStatusBar;
    ZoomTrackBar: TTrackBar;
    ZQueryPoints: TZReadOnlyQuery;
    procedure BtnGoToClick(Sender: TObject);
    procedure BtnLoadGPXFileClick(Sender: TObject);
    procedure BtnSearchClick(Sender: TObject);
    procedure BtnGPSPointsClick(Sender: TObject);
    procedure BtnSaveToFileClick(Sender: TObject);
    procedure BtnPOITextFontClick(Sender: TObject);
    procedure ButtonShowLegendClick(Sender: TObject);
    procedure ButtonZoomCurrentClick(Sender: TObject);
    procedure ButtonZoomViewClick(Sender: TObject);
    procedure ButtonReloadViewClick(Sender: TObject);
    procedure CbDebugTilesChange(Sender: TObject);
    procedure CbDoubleBufferChange(Sender: TObject);
    procedure CbFoundLocationsDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure CbFoundLocationsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure cbPOITextBgColorChange(Sender: TObject);
    procedure CbProvidersChange(Sender: TObject);
    procedure CbShowPOIImageChange(Sender: TObject);
    procedure CbUseThreadsChange(Sender: TObject);
    procedure CbDistanceUnitsChange(Sender: TObject);
    procedure CheckBoxCurrentChange(Sender: TObject);
    procedure CheckBoxCurrentMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ColorButtonPointsColorChanged(Sender: TObject);
    procedure ComboBoxDMSChange(Sender: TObject);
    procedure ComboBoxViewsChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure GeoNamesNameFound(const AName: string; const ADescr: String;
      const ALoc: TRealPoint);
    procedure HelpButtonClick(Sender: TObject);
    procedure MapViewChange(Sender: TObject);
    procedure MapViewDrawGpsPoint(Sender: TObject;
      ADrawer: TMvCustomDrawingEngine; APoint: TGpsPoint);
    procedure MapViewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MapViewMouseLeave(Sender: TObject);
    procedure MapViewMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure MapViewMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MapViewZoomChange(Sender: TObject);
    procedure LoadMapProviders(Sender: TObject);
    procedure BtnSaveMapProvidersClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpinEditRadiusChange(Sender: TObject);
    procedure ZoomTrackBarChange(Sender: TObject);
    procedure ZQueryPointsAfterOpen(DataSet: TDataSet);
    procedure ZQueryPointsBeforeOpen(DataSet: TDataSet);

  private
    POIImage: TCustomBitmap;
    ViewArea: TRealArea;
    PrevPnt: TPoint;
    PrevPntClr: TColor;
    MaxValue, MinValue, LDiff: Double;
    procedure ClearFoundLocations;
    procedure UpdateCoords(X, Y: Integer);
    procedure UpdateDropdownWidth(ACombobox: TCombobox);
    procedure UpdateLocationHistory(ALocation: String);
    procedure UpdateViewportSize;

  public
    UseCurrent, CurrentFound, CurrentClicked, USE_DMS, IsThemed, ShowNoValue: Boolean;
    UseView: String;
    TheParam, TheUnit, TheChemTable: ShortString;
    TheFactor: Double;
    Category, Graduated, MaxLum: Byte; //the index of the dropbox from settings
    DT_From, DT_To: TDateTime;
    HiColor, MidColor, LoColor: TColor;
    procedure ReadFromIni;
    procedure WriteToIni;
  end;

var
  MapViewForm: TMapViewForm;

implementation

{$R *.lfm}

uses
  LCLType, IniFiles, Math, FPCanvas, FPImage, GraphType, mvEngine, mvGPX,
  mvExtraData, globals, gpslistform, VARINIT, maindatamodule, strdatetime,
  maplegend;

type
  TLocationParam = class
    Descr: String;
    Loc: TRealPoint;
  end;

const
  MAX_LOCATIONS_HISTORY = 50;
  MAP_PROVIDER_FILENAME = 'map-providers.xml';

var
  PointFormatSettings: TFormatsettings;
  ALegendForm: TLegendForm;

{ TMapViewForm }

function ScreenColor(aX, aY: integer):TColor;
var
  ScreenDC: HDC;
  SaveBitmap: TBitmap;
begin
  SaveBitmap := TBitmap.Create;
  try
    SaveBitmap.SetSize(Screen.Width, Screen.Height);
    ScreenDC := GetDC(0);
    try
      SaveBitmap.LoadFromDevice(ScreenDC);
    finally
      ReleaseDC(0, ScreenDC);
    end;
    Result := SaveBitmap.Canvas.Pixels[aX, aY];
  finally
    SaveBitmap.Free;
  end;
end;

procedure TMapViewForm.LoadMapProviders(Sender: TObject);
var
  fn: String;
  msg: String;
begin
  if Sender is TButton then
    fn := ProgramDir + DirectorySeparator + 'defaults' + DirectorySeparator + MAP_PROVIDER_FILENAME
  else
    fn := WSpaceDir + DirectorySeparator + MAP_PROVIDER_FILENAME;
  if not FileExists(fn) then
    fn := ProgramDir + DirectorySeparator + MAP_PROVIDER_FILENAME;
  if FileExists(fn) then begin
    if MapView.Engine.ReadProvidersFromXML(fn, msg) then begin
      MapView.GetMapProviders(CbProviders.Items);
      CbProviders.ItemIndex := 0;
      MapView.MapProvider := CbProviders.Text;
    end else
      ShowMessage(msg);
  end;
end;

procedure TMapViewForm.BtnSaveMapProvidersClick(Sender: TObject);
begin
  MapView.Engine.WriteProvidersToXML(WSpaceDir + DirectorySeparator + MAP_PROVIDER_FILENAME);
end;

procedure TMapViewForm.SpeedButton1Click(Sender: TObject);
var
  TheViews: TStringList;
begin
  Screen.Cursor := crSQLWait;
  with DataModuleMain do
  begin
    GetAllViews(ZConnectionDB, TheViews);
    ComboBoxViews.Items.Assign(TheViews);
    TheViews.Free;
  end;
  ComboBoxViews.ItemIndex := ComboBoxViews.Items.IndexOf(UseView);
  Screen.Cursor := crDefault;
end;

procedure TMapViewForm.SpinEditRadiusChange(Sender: TObject);
begin
  MapView.GPSItems.Clear(_VIEW_POINTS_);
  ZQueryPoints.Open;
end;

procedure TMapViewForm.BtnSearchClick(Sender: TObject);
begin
  Screen.Cursor := crHourglass;
  ClearFoundLocations;
  GeoNames.Search(CbLocations.Text, MapView.DownloadEngine);
  UpdateDropdownWidth(CbFoundLocations);
  UpdateLocationHistory(CbLocations.Text);
  if CbFoundLocations.Items.Count > 0 then CbFoundLocations.ItemIndex := 0;
  Screen.Cursor := crDefault;
end;

procedure TMapViewForm.BtnGPSPointsClick(Sender: TObject);
var
  F: TGpsListViewer;
begin
  F := TGpsListViewer.Create(nil);
  try
    F.MapViewer := MapView;
    F.USE_DMS_IN_GRID := USE_DMS;
    F.PNT_RADIUS := SpinEditRadius.Value;
    F.ShowModal;
  finally
    F.Free;
  end;
end;

procedure TMapViewForm.BtnGoToClick(Sender: TObject);
var
  s: String;
  P: TLocationParam;
begin
  if CbFoundLocations.ItemIndex = -1 then
    exit;

  // Extract parameters of found locations. We need that to get the coordinates.
  s := CbFoundLocations.Items.Strings[CbFoundLocations.ItemIndex];
  P := TLocationParam(CbFoundLocations.Items.Objects[CbFoundLocations.ItemIndex]);
  if P = nil then
    exit;
  CbFoundLocations.Text := s;

  // Show location in center of mapview
  MapView.Zoom := 12;
  MapView.Center := P.Loc;
  MapView.Invalidate;
end;

procedure TMapViewForm.BtnLoadGPXFileClick(Sender: TObject);
var
  reader: TGpxReader;
  b: TRealArea;
begin
  if OpenDialog.FileName <> '' then
    OpenDialog.InitialDir := ExtractFileDir(OpenDialog.Filename);
  if OpenDialog.Execute then begin
    reader := TGpxReader.Create;
    try
      reader.LoadFromFile(OpenDialog.FileName, MapView.GPSItems, b);
      MapView.Engine.ZoomOnArea(b);
      MapViewZoomChange(nil);
    finally
      reader.Free;
    end;
  end;
end;

procedure TMapViewForm.BtnSaveToFileClick(Sender: TObject);
begin
  MapView.SaveToFile(TPortableNetworkGraphic, WSpaceDir + DirectorySeparator + 'mapview.png');
  ShowMessage('Map saved to "mapview.png".');
end;

procedure TMapViewForm.BtnPOITextFontClick(Sender: TObject);
begin
  FontDialog.Font.Assign(MapView.Font);
  if FontDialog.Execute then
    MapView.Font.Assign(FontDialog.Font);
end;

procedure TMapViewForm.ButtonShowLegendClick(Sender: TObject);
var
  H, Hi_L, Lo_L, S: Byte;
  WasCreated: Boolean;
begin
  if (ALegendForm <> NIL) and not ALegendForm.Showing then
    ALegendForm := NIL;
  if ALegendForm = NIL then //create the form if it does not exist
  begin
    ALegendForm := TLegendForm.Create(Application);
    WasCreated := True;
  end;
  with ALegendForm do
  begin
    //set the legend
    if IsThemed then
    begin
      case Graduated of
        0: LabelTheme.Caption := 'Aquifer Yield [' + TheUnit + ']';
        1: LabelTheme.Caption := 'Hole Depth [' + TheUnit + ']';
        2: LabelTheme.Caption := 'Chemistry: ' + TheParam + ' [' + TheUnit + ']';
        3: LabelTheme.Caption := 'Field Measurement of ' + TheParam[7] + ' [' + TheUnit + ']';
        4: LabelTheme.Caption := 'Water Level [' + TheUnit + ']'
      end;
      if ShowNoValue then
      begin
        LabelOther.Visible := True;
        LabelOther.Caption := '"No Value" Points';
        ShapeOther.Visible := True;
        ShapeOther.Brush.Color := ColorButtonPoints.ButtonColor;
      end;
      //the lightest colour
      ShapeTop.Brush.Color := LoColor;
      LabelTop.Caption := FloatToStr(MinValue);
      //work out the middle Luminance
      ColorToHLS(HiColor, H, Hi_L, S);
      ColorToHLS(LoColor, H, Lo_L, S);
      ShapeMid.Brush.Color := HLSToColor(H, Round((Hi_L + Lo_L)/2), S);
      LabelMid.Caption := FloatToStr((MaxValue + MinValue)/2);
      //the darkest colour
      ShapeBot.Brush.Color := HiColor;
      LabelBot.Caption := FloatToStr(MaxValue);
    end
    else
    begin
      LabelTheme.Caption := 'Points on Map';
      ShapeTop.Brush.Color := ColorButtonPoints.ButtonColor;
      LabelTop.Caption := 'Points in View';
      ShapeMid.Brush.Color := clYellow;
      LabelMid.Caption := 'Current Site';
      ShapeBot.Brush.Color := clRed;
      LabelBot.Caption := 'Points added manually';
    end;
    if WasCreated then
      Show
    else
      BringToFront;
  end;
end;

procedure TMapViewForm.ButtonZoomCurrentClick(Sender: TObject);
var
  i: LongInt;
  gpsObj: TGPSObj;
  gpsPt: TGpsPoint;
  extra: TDrawingExtraData;
begin
  if UseCurrent then
  begin
    MapView.GPSItems.Clear(_VIEW_POINTS_);
    ZQueryPoints.Open;
  end;
  for i := 0 to MapView.GPSItems.Count - 1 do
  begin
    gpsObj := MapView.GPSItems[i];
    gpsPt := TGpsPoint(gpsObj);
    extra := TDrawingExtraData.Create(_VIEW_POINTS_);
    extra.Color := clYellow;
    gpsPt.ExtraData := extra;
    if ExtractWord(1, gpsPt.Name, [' ']) = CurrentSite then
    begin
      MapView.Center := gpsPt.RealPoint;
        if MapView.Zoom < 14 then
          MapView.Zoom := 14;
      Exit;
    end;
  end;
end;

procedure TMapViewForm.ButtonZoomViewClick(Sender: TObject);
begin
  MapView.ZoomOnArea(ViewArea);
  MapViewZoomChange(nil);
end;

procedure TMapViewForm.ButtonReloadViewClick(Sender: TObject);
var
  R: TRealArea;
begin
  R := MapView.GetVisibleArea;
  MapView.ZoomOnArea(R);
  MapViewZoomChange(nil);
end;

procedure TMapViewForm.CbDebugTilesChange(Sender: TObject);
begin
  MapView.DebugTiles := CbDebugTiles.Checked;
end;

procedure TMapViewForm.CbDoubleBufferChange(Sender: TObject);
begin
  MapView.DoubleBuffered := CbDoubleBuffer.Checked;
end;

procedure TMapViewForm.CbFoundLocationsDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var
  s: String;
  P: TLocationParam;
  combo: TCombobox;
  x, y: Integer;
begin
  combo := TCombobox(Control);
  if (State * [odSelected, odFocused] <> []) then begin
    combo.Canvas.Brush.Color := clHighlight;
    combo.Canvas.Font.Color := clHighlightText;
  end else begin
    combo.Canvas.Brush.Color := clWindow;
    combo.Canvas.Font.Color := clWindowText;
  end;
  combo.Canvas.FillRect(ARect);
  combo.Canvas.Brush.Style := bsClear;
  s := combo.Items.Strings[Index];
  P := TLocationParam(combo.Items.Objects[Index]);
  x := ARect.Left + 2;
  y := ARect.Top + 2;
  combo.Canvas.Font.Style := [fsBold];
  combo.Canvas.TextOut(x, y, s);
  inc(y, combo.Canvas.TextHeight('Tg'));
  combo.Canvas.Font.Style := [];
  combo.Canvas.TextOut(x, y, P.Descr);
end;

procedure TMapViewForm.CbFoundLocationsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  CbFoundLocations.Hint := CbFoundLocations.Text;
end;

procedure TMapViewForm.cbPOITextBgColorChange(Sender: TObject);
begin
  MapView.POITextBgColor := cbPOITextBgColor.Selected;
end;

procedure TMapViewForm.CbProvidersChange(Sender: TObject);
begin
  MapView.MapProvider := CbProviders.Text;
end;

procedure TMapViewForm.CbShowPOIImageChange(Sender: TObject);
begin
  if CbShowPOIImage.Checked then
    MapView.POIImage.Assign(POIImage)
  else
    MapView.POIImage.Clear;
end;

procedure TMapViewForm.CbUseThreadsChange(Sender: TObject);
begin
  MapView.UseThreads := CbUseThreads.Checked;
end;

procedure TMapViewForm.CbDistanceUnitsChange(Sender: TObject);
begin
  DistanceUnit := TDistanceUnits(CbDistanceUnits.ItemIndex);
  UpdateViewPortSize;
end;

procedure TMapViewForm.CheckBoxCurrentChange(Sender: TObject);
begin
  UseCurrent := CheckBoxCurrent.Checked;
  MapView.GPSItems.Clear(_VIEW_POINTS_);
  ZQueryPoints.Open;
end;

procedure TMapViewForm.CheckBoxCurrentMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  CheckBoxCurrent.Hint := CurrentSite;
end;

procedure TMapViewForm.ColorButtonPointsColorChanged(Sender: TObject);
begin
  MapView.GPSItems.Clear(_VIEW_POINTS_);
  ZQueryPoints.Open;
end;

procedure TMapViewForm.ComboBoxDMSChange(Sender: TObject);
begin
  USE_DMS := ComboBoxDMS.ItemIndex = 1;
end;

procedure TMapViewForm.ComboBoxViewsChange(Sender: TObject);
begin
  CheckBoxCurrent.Checked := False;
  UseView := ComboBoxViews.Text;
  MapView.GPSItems.Clear(_VIEW_POINTS_);
  ZQueryPoints.Open;
  if ALegendForm <> NIL then
    ButtonShowLegendClick(ButtonShowLegend);
end;

procedure TMapViewForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  WriteToIni;
  ClearFoundLocations;
  FreeAndNil(POIImage);
  MapView.UseThreads := False;
  MapView.Active := False;
  FreeAndNil(MapView);
  CloseAction := caFree;
end;

procedure TMapViewForm.ClearFoundLocations;
var
  i: Integer;
  P: TLocationParam;
begin
  for i:=0 to CbFoundLocations.Items.Count-1 do begin
    P := TLocationParam(CbFoundLocations.Items.Objects[i]);
    P.Free;
  end;
  CbFoundLocations.Items.Clear;
end;

procedure TMapViewForm.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  with InfoBtnGPSPoints do
  begin
    Width := 200;
    height := 22;
    AutoSize := True;
  end;
  //FMapMarker := CreateMapMarker(32, clRed, clBlack);
  POIImage := TPortableNetworkGraphic.Create;
  POIImage.PixelFormat := pf32bit;
  POIImage.LoadFromFile(ProgramDir + DirectorySeparator + 'mapmarker.png');

  MapView.CachePath := GetUserDir + DirectorySeparator + '.cache' + DirectorySeparator + 'mapview' + DirectorySeparator;
  //MapView.GetMapProviders(CbProviders.Items);
  LoadMapProviders(nil);
  CbProviders.ItemIndex := CbProviders.Items.Indexof(MapView.MapProvider);
  MapView.DoubleBuffered := true;
  MapView.Zoom := 1;
  CbUseThreads.Checked := MapView.UseThreads;
  CbDoubleBuffer.Checked := MapView.DoubleBuffered;
  CbPOITextBgColor.Selected := MapView.POITextBgColor;

  InfoPositionLongitude.Caption := '';
  InfoPositionLatitude.Caption := '';
  InfoCenterLongitude.Caption := '';
  InfoCenterLatitude.Caption := '';
  InfoViewportWidth.Caption := '';
  InfoViewportHeight.Caption := '';
  GPSPointInfo.Caption := '';

  ReadFromIni;
end;

procedure TMapViewForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    DataModuleMain.OpenHelp(Sender)
  else
  if Key = VK_F5 then
  begin
    if ssCtrl in Shift then
      ComboBoxViewsChange(MapView)
    else
      ButtonReloadViewClick(MapView);
  end;
end;

procedure TMapViewForm.FormShow(Sender: TObject);
var
  TheViews: TStringList;
begin
  Screen.Cursor := crSQLWait;
  if not IsThemed then //if it is then the combo is filled with views from settings before map
  begin
    with DataModuleMain do
    begin
      TheViews := TStringList.Create;
      GetAllViews(ZConnectionDB, TheViews);
      ComboBoxViews.Items.Assign(TheViews);
      TheViews.Free;
    end
  end;
  ComboBoxViews.ItemIndex := ComboBoxViews.Items.IndexOf(UseView);
  MapView.Active := True;
  if TheParam = '' then
    TheParam := 'altitude'; //in case the map is not themed
  ZQueryPoints.Open;
  CheckBoxCurrent.Checked := UseCurrent;
  {$IFDEF WINDOWS}
  CheckBoxLabels.Enabled := True;
  {$ENDIF}
  ALegendForm := NIL;
  Screen.Cursor := crDefault;
end;

procedure TMapViewForm.GeoNamesNameFound(const AName: string;
  const ADescr: String; const ALoc: TRealPoint);
var
  P: TLocationParam;
begin
  P := TLocationParam.Create;
  P.Descr := ADescr;
  P.Loc := ALoc;
  CbFoundLocations.Items.AddObject(AName, P);
end;

procedure TMapViewForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender)
end;

procedure TMapViewForm.MapViewChange(Sender: TObject);
begin
  UpdateViewportSize;
end;

procedure TMapViewForm.MapViewDrawGpsPoint(Sender: TObject;
  ADrawer: TMvCustomDrawingEngine; APoint: TGpsPoint);
var
  P: TPoint;
  R, H, L, S: Byte;
begin
  R := SpinEditRadius.Value;
  // Screen coordinates of the GPS point
  P := TMapView(Sender).LonLatToScreen(APoint.RealPoint);

  // Draw the GPS point for different scenarios
  if APoint.IdOwner = _CLICKED_POINTS_ then //added by alt-clicking on map
    ADrawer.BrushColor := clRed
  else
  if APoint.ExtraData <> NIL then //point selected to go to on gpslistform has ExtraData
  begin
    ADrawer.BrushColor := (APoint.ExtraData as TDrawingExtraData).Color;
    APoint.ExtraData := NIL; //clear ExtraData that was created when clicking Goto Point
  end
  else
  if IsThemed then //colour according to value from query = ELE
  begin
    if (APoint.Elevation = NO_ELE) and ShowNoValue then
        ADrawer.BrushColor := ColorButtonPoints.ButtonColor //also the default colour
    else
    begin
      ColorToHLS(HiColor, H, L, S);
      ADrawer.BrushColor := HLSToColor(H, Round((MaxValue - APoint.Elevation) * LDiff) + L, S);
    end;
  end
  else
  if ExtractWord(1, APoint.Name, [' ']) = CurrentSite then //make current site point yellow
  begin
    ADrawer.BrushColor := clYellow;
    PrevPnt := P; //set previous point to current site so that it is deselected when new point is ctrl-clicked
  end
  else
    ADrawer.BrushColor := ColorButtonPoints.ButtonColor; //make default colour from button
  ADrawer.BrushStyle := bsSolid;
  // Draw the GPS point as a circle
  ADrawer.Ellipse(P.X - R, P.Y - R, P.X + R, P.Y + R);
  {$IFDEF WINDOWS}
  if CheckBoxLabels.Checked then
  begin
    // Draw the point label
    ADrawer.BrushStyle := bsClear;
    ADrawer.FontName := AppFont.Name;
    ADrawer.FontSize := AppFont.Size - 1;
    ADrawer.FontStyle := [fsBold];
    ADrawer.TextOut(
      p.X - ADrawer.TextWidth(APoint.Name) div 2,
      p.Y + R + 4,
      APoint.Name);
  end;
  {$ENDIF}
end;

procedure TMapViewForm.MapViewMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
  DELTA = 3;
var
  rArea: TRealArea;
  gpsList: TGpsObjList;
  i: Integer;
  P: TPoint;
  R: Byte;
  ADrawer: TMvCustomDrawingEngine;
begin
  if Button = mbLeft then
  begin
    if ssCtrl in Shift then
    begin
      TMapView(Sender).Cursor := crHandPoint;
      R := SpinEditRadius.Value;
      ADrawer := TMapView(Sender).DrawingEngine;
      rArea.TopLeft := TMapView(Sender).ScreenToLonLat(Point(X-DELTA, Y-DELTA));
      rArea.BottomRight := TMapView(Sender).ScreenToLonLat(Point(X+DELTA, Y+DELTA));
      gpsList := TMapView(Sender).GpsItems.GetObjectsInArea(rArea);
      for i := 0 to gpsList.Count-1 do
      if gpsList[i] is TGpsPoint then
      begin
        if not PrevPnt.IsZero then //reset colour of previously clicked point
        begin
          ADrawer.BrushColor := PrevPntClr;
          ADrawer.BrushStyle := bsSolid;
          ADrawer.Ellipse(PrevPnt.X - R, PrevPnt.Y - R, PrevPnt.X + R, PrevPnt.Y + R);
        end;
        P := TMapView(Sender).LonLatToScreen(TGpsPoint(gpsList[i]).RealPoint);
        //get previous color from point under cursor
        if P <> PrevPnt then //if it is not already clicked
          PrevPntClr := ScreenColor(Mouse.CursorPos.X, Mouse.CursorPos.Y);
        //then make the point yellow
        ADrawer.BrushColor := clYellow;
        ADrawer.BrushStyle := bsSolid;
        ADrawer.Ellipse(P.X - R, P.Y - R, P.X + R, P.Y + R);
        //the next prepare for MouseUp
        PrevPnt := P;
        CurrentClicked := True;
        StatusBar1.SimpleText := 'Last Point clicked: ' + TGpsPoint(gpsList[i]).Name;
        CurrentFound := DataModuleMain.ZQueryView.Locate('SITE_ID_NR', Copy(TGpsPoint(gpsList[i]).Name, 1, Pos(' (', TGpsPoint(gpsList[i]).Name)-1), []);
      end
      else
        CurrentClicked := False; //no GPSPoint found
      TMapView(Sender).Refresh;
    end
    else
    if ssShift in Shift then
    begin

    end
    else
    if ssAlt in Shift then
      TMapView(Sender).Cursor := crHandPoint
    else //no shifts
    begin
      CurrentClicked := False;
      MapView.Cursor := crDrag;
    end;
  end;
end;

procedure TMapViewForm.MapViewMouseLeave(Sender: TObject);
begin
  UpdateCoords(MaxInt, MaxInt);
end;

procedure TMapViewForm.MapViewMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
const
  DELTA = 3;
var
  rArea: TRealArea;
  gpsList: TGpsObjList;
  L: TStringList;
  i: Integer;
begin
  UpdateCoords(X, Y);

  rArea.TopLeft := MapView.ScreenToLonLat(Point(X-DELTA, Y-DELTA));
  rArea.BottomRight := MapView.ScreenToLonLat(Point(X+DELTA, Y+DELTA));
  gpsList := MapView.GpsItems.GetObjectsInArea(rArea);
  try
    if gpsList.Count > 0 then begin
      L := TStringList.Create;
      L.Duplicates := dupIgnore;
      try
        for i:=0 to gpsList.Count-1 do
          if gpsList[i] is TGpsPoint then
            with TGpsPoint(gpsList[i]) do
              if Elevation > NO_ELE then //format according to value
              begin
                if Elevation >= 1000 then
                  L.Add(Format('%s: %s ' + TheUnit, [Name, FloatToStrF(Elevation, ffFixed, 15, 1)]))
                else if Elevation >= 10 then
                  L.Add(Format('%s: %s ' + TheUnit, [Name, FloatToStrF(Elevation, ffFixed, 15, 2)]))
                else if Elevation >= 1 then
                  L.Add(Format('%s: %s ' + TheUnit, [Name, FloatToStrF(Elevation, ffFixed, 15, 3)]))
                else
                  L.Add(Format('%s: %s ' + TheUnit, [Name, FloatToStrF(Elevation, ffFixed, 15, 5)]))
              end
              else
                L.Add(Format('%s: ' + 'no value', [Name]));
        GPSPointInfo.Caption := L.Text;
        MapView.Hint := L[0];
        MapView.ShowHint := True;
      finally
        L.Free;
      end;
    end
    else
    begin
      GPSPointInfo.Caption := '';
      MapView.Hint := '';
      MapView.ShowHint := False;
    end;
  finally
    gpsList.Free;
  end;
end;

procedure TMapViewForm.MapViewMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  rPt: TRealPoint;
  gpsPt: TGpsPoint;
  gpsName: String;
begin
  if Button = mbLeft then
  begin
    if ssAlt in Shift then
    begin
      MapView.Cursor := crDefault;
      if not InputQuery('Name of Point location', 'Please enter a name for the point:', gpsName) then
        exit;
      rPt := MapView.ScreenToLonLat(Point(X, Y));
      gpsPt := TGpsPoint.CreateFrom(rPt);
      gpsPt.Name := gpsName;
      MapView.GpsItems.Add(gpsPt, _CLICKED_POINTS_);
    end
    else
    begin
      MapView.Cursor := crDefault;
      if CurrentClicked and not CurrentFound then
        MessageDlg('The selected site is not in the current Aquabase View "' + FilterName + '", so the dataset could not be moved to the selected site!', mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TMapViewForm.MapViewZoomChange(Sender: TObject);
begin
  ZoomTrackbar.Position := MapView.Zoom;
end;

procedure TMapViewForm.ReadFromIni;
var
  ini: TCustomIniFile;
  List: TStringList;
  L, T, W, H: Integer;
  R: TRect;
  i: Integer;
  s: String;
  pt: TRealPoint;
  du: TDistanceUnits;
begin
  ini := TMemIniFile.Create(WSpaceDir + DirectorySeparator + 'mapview.ini');
  try
    HERE_AppID := ini.ReadString('HERE', 'APP_ID', '');
    HERE_AppCode := ini.ReadString('HERE', 'APP_CODE', '');
    OpenWeatherMap_ApiKey := ini.ReadString('OpenWeatherMap', 'API_Key', '');

    if ((HERE_AppID <> '') and (HERE_AppCode <> '')) or
       (OpenWeatherMap_ApiKey <> '') then
    begin
      MapView.Engine.ClearMapProviders;
      MapView.Engine.RegisterProviders;
      MapView.GetMapProviders(CbProviders.Items);
    end;

    R := Screen.DesktopRect;
    L := ini.ReadInteger('MainForm', 'Left', Left);
    T := ini.ReadInteger('MainForm', 'Top', Top);
    W := ini.ReadInteger('MainForm', 'Width', Width);
    H := ini.ReadInteger('MainForm', 'Height', Height);
    if L + W > R.Right then L := R.Right - W;
    if L < R.Left then L := R.Left;
    if T + H > R.Bottom then T := R.Bottom - H;
    if T < R.Top then T := R.Top;
    SetBounds(L, T, W, H);

    s := ini.ReadString('MapView', 'Provider', MapView.MapProvider);
    if CbProviders.Items.IndexOf(s) = -1 then begin
      MessageDlg('Map provider "' + s + '" not found.', mtError, [mbOK], 0);
      s := CbProviders.Items[0];
    end;
    MapView.MapProvider := s;
    CbProviders.Text := MapView.MapProvider;

    MapView.Zoom := ini.ReadInteger('MapView', 'Zoom', MapView.Zoom);
    pt.Lon := StrToFloatDef(ini.ReadString('MapView', 'Center.Longitude', ''), 0.0, PointFormatSettings);
    pt.Lat := StrToFloatDef(ini.ReadString('MapView', 'Center.Latitude', ''), 0.0, PointFormatSettings);
    MapView.Center := pt;

    s := ini.ReadString('MapView', 'DistanceUnits', '');
    if s <> '' then begin
      for du in TDistanceUnits do
        if DistanceUnit_Names[du] = s then begin
          DistanceUnit := du;
          CbDistanceUnits.ItemIndex := ord(du);
          break;
        end;
    end;

    USE_DMS := ini.ReadBool('MapView', 'UseDMS', True);
    if USE_DMS then
      ComboBoxDMS.ItemIndex := 1
    else
      ComboBoxDMS.ItemIndex := 0;

    try
      ColorButtonPoints.ButtonColor := ini.ReadInteger('MapView', 'PointColour', clGreen);
    except
      //do nothing but catch SQLite error. WEIRD!!!!!
    end;

    List := TStringList.Create;
    try
      ini.ReadSection('Locations', List);
      for i:=0 to List.Count-1 do begin
        s := ini.ReadString('Locations', List[i], '');
        if s <> '' then
          CbLocations.Items.Add(s);
      end;
    finally
      List.Free;
    end;

  finally
    ini.Free;
  end;
end;

procedure TMapViewForm.UpdateCoords(X, Y: Integer);
var
  rPt: TRealPoint;
begin
  rPt := MapView.Center;
  InfoCenterLongitude.Caption := LonToStr(rPt.Lon, USE_DMS);
  InfoCenterLatitude.Caption := LatToStr(rPt.Lat, USE_DMS);

  if (X <> MaxInt) and (Y <> MaxInt) then begin
    rPt := MapView.ScreenToLonLat(Point(X, Y));
    InfoPositionLongitude.Caption := LonToStr(rPt.Lon, USE_DMS);
    InfoPositionLatitude.Caption := LatToStr(rPt.Lat, USE_DMS);
  end else begin
    InfoPositionLongitude.Caption := '-';
    InfoPositionLatitude.Caption := '-';
  end;
end;

procedure TMapViewForm.UpdateDropdownWidth(ACombobox: TCombobox);
var
  cnv: TControlCanvas;
  i, w: Integer;
  s: String;
  P: TLocationParam;
begin
  w := 0;
  cnv := TControlCanvas.Create;
  try
    cnv.Control := ACombobox;
    cnv.Font.Assign(ACombobox.Font);
    for i:=0 to ACombobox.Items.Count-1 do begin
      cnv.Font.Style := [fsBold];
      s := ACombobox.Items.Strings[i];
      w := Max(w, cnv.TextWidth(s));
      P := TLocationParam(ACombobox.Items.Objects[i]);
      cnv.Font.Style := [];
      w := Max(w, cnv.TextWidth(P.Descr));
    end;
    ACombobox.ItemWidth := w + 16;
    ACombobox.ItemHeight := 2 * cnv.TextHeight('Tg') + 6;
  finally
    cnv.Free;
  end;
end;

procedure TMapViewForm.UpdateLocationHistory(ALocation: String);
var
  idx: Integer;
begin
  idx := CbLocations.Items.IndexOf(ALocation);
  if idx <> -1 then
    CbLocations.Items.Delete(idx);
  CbLocations.Items.Insert(0, ALocation);
  while CbLocations.Items.Count > MAX_LOCATIONS_HISTORY do
    CbLocations.Items.Delete(Cblocations.items.Count-1);
  CbLocations.Text := ALocation;
end;

procedure TMapViewForm.UpdateViewportSize;
begin
  InfoViewportWidth.Caption := Format('%.2n %s', [
    CalcGeoDistance(
      MapView.GetVisibleArea.TopLeft.Lat,
      MapView.GetVisibleArea.TopLeft.Lon,
      MapView.GetVisibleArea.TopLeft.Lat,
      MapView.GetVisibleArea.BottomRight.Lon,
      DistanceUnit
    ),
    DistanceUnit_Names[DistanceUnit]
  ]);
  InfoViewportHeight.Caption := Format('%.2n %s', [
    CalcGeoDistance(
      MapView.GetVisibleArea.TopLeft.Lat,
      MapView.GetVisibleArea.TopLeft.Lon,
      MapView.GetVisibleArea.BottomRight.Lat,
      MapView.GetVisibleArea.TopLeft.Lon,
      DistanceUnit
    ),
    DistanceUnit_Names[DistanceUnit]
  ]);
end;

procedure TMapViewForm.WriteToIni;
var
  ini: TCustomIniFile;
  i: Integer;
begin
  try
    ini := TMemIniFile.Create(WSpaceDir + DirectorySeparator + 'mapview.ini');
    ini.WriteInteger('MainForm', 'Left', Left);
    ini.WriteInteger('MainForm', 'Top', Top);
    ini.WriteInteger('MainForm', 'Width', Width);
    ini.WriteInteger('MainForm', 'Height', Height);

    ini.WriteString('MapView', 'Provider', MapView.MapProvider);
    ini.WriteInteger('MapView', 'Zoom', MapView.Zoom);
    ini.WriteString('MapView', 'Center.Longitude', FloatToStr(MapView.Center.Lon, PointFormatSettings));
    ini.WriteString('MapView', 'Center.Latitude', FloatToStr(MapView.Center.Lat, PointFormatSettings));

    ini.WriteString('MapView', 'DistanceUnits', DistanceUnit_Names[DistanceUnit]);

    if ComboBoxDMS.ItemIndex = 0 then
      ini.WriteBool('MapView', 'UseDMS', False)
    else
      ini.WriteBool('MapView', 'UseDMS', True);

    ini.WriteInteger('MapView', 'PointColour', ColorButtonPoints.ButtonColor);

    if HERE_AppID <> '' then
      ini.WriteString('HERE', 'APP_ID', HERE_AppID);
    if HERE_AppCode <> '' then
      ini.WriteString('HERE', 'APP_CODE', HERE_AppCode);

    if OpenWeatherMap_ApiKey <> '' then
      ini.WriteString('OpenWeatherMap', 'API_Key', OpenWeatherMap_ApiKey);

    ini.EraseSection('Locations');
    for i := 0 to CbLocations.Items.Count-1 do
      ini.WriteString('Locations', 'Item'+IntToStr(i), CbLocations.Items[i]);

    ini.Free;
  except on Exception do
    MessageDlg('Could not write current Map Viewer settings to INI file!', mtError, [mbOK], 0);
  end;
end;

procedure TMapViewForm.ZoomTrackBarChange(Sender: TObject);
begin
  MapView.Zoom := ZoomTrackBar.Position;
  LblZoom.Caption := Format('Zoom (%d):', [ZoomTrackbar.Position]);
end;

procedure TMapViewForm.ZQueryPointsAfterOpen(DataSet: TDataSet);
var
  gpsPt: TGPSPoint;
  Lon, Lat, TheValue: Double;
  TheDate: TDateTime;
  H, L, S: Byte;
begin
  if DataSet.RecordCount = 0 then
  begin
    if UseCurrent then
      MessageDlg('The current site is not in View "' + UseView + '". All points will be deleted from the map.', mtWarning, [mbOK], 0)
    else
      MessageDlg('The selected View "' + UseView + '" has no points!', mtWarning, [mbOK], 0)
  end
  else
  begin
    if IsThemed then
    begin
      //get max and min value
      MaxValue := -999999999;
      MinValue := 999999999;
      with DataSet do while not EOF do
      begin
        if not FieldByName(TheParam).IsNull and (FieldByName(TheParam).Value > -1) then
        begin
          if FieldByName(TheParam).Value > MaxValue then
            MaxValue := FieldByName(TheParam).Value;
          if FieldByName(TheParam).Value < MinValue then
            MinValue := FieldByName(TheParam).Value;
        end;
        Next;
      end;
      //work out luminance difference
      ColorToHLS(HiColor, H, L, S);
      LDiff := (MaxLum - L) / (MaxValue - MinValue);
      LoColor := HLSToColor(H, MaxLum, S);
      DataSet.First;
    end;
    //create the Points
    with DataSet do while not EOF do
    begin
      if FieldByName(TheParam).IsNull then
        TheValue := NO_ELE
      else
      if FieldByName(TheParam).Value = -1 then //for chemistry
        TheValue := NO_ELE
      else
      begin
        TheValue := FieldByName(TheParam).Value * TheFactor;
      end;
      try
        case Graduated of
          0: TheDate := NO_DATE;
          1: TheDate := StringToDate(FieldByName('date_compl').AsString);
          else TheDate := DT_To;
        end; //of case
      except on Exception do
        TheDate := NO_DATE
      end;
      Lon := FieldByName('longitude').AsFloat;
      Lat := FieldByName('latitude').AsFloat;
      gpsPt := TGpsPoint.Create(Lon, Lat, TheValue, TheDate);
      gpsPt.Name := FieldByName('site_id_nr').AsString + ' (' + FieldByName('nr_on_map').AsString + ')';
      MapView.GPSItems.Add(gpsPt, _VIEW_POINTS_);
      Next;
    end;
    MapView.GPSItems.GetArea(ViewArea);
    if UseCurrent then
    begin
      MapView.Zoom := 12;
      MapView.CenterOnObj(gpsPt);
    end
    else
    begin
      MapView.ZoomOnArea(ViewArea);
      MapViewZoomChange(nil);
    end;
  end;
  DataSet.Close;
end;

procedure TMapViewForm.ZQueryPointsBeforeOpen(DataSet: TDataSet);
begin
  ZQueryPoints.Connection := DataModuleMain.ZConnectionDB;
  if IsThemed then
  begin
    case Graduated of
      0: with ZQueryPoints do
      begin
        SQL.Clear;
        SQL.Add('select v.SITE_ID_NR, b.NR_ON_MAP, b.LONGITUDE, b.LATITUDE, MAX(a.DEPTH_TOP) as DEPTH, a.YIELD from ' + UseView + ' v');
        SQL.Add('join basicinf b on (v.site_id_nr = b.site_id_nr)');
        if ShowNoValue then
        begin
          SQL.Add('LEFT JOIN aquifer_ a ON (v.SITE_ID_NR = a.SITE_ID_NR)');
        end
        else
        begin
          SQL.Add('JOIN aquifer_ a ON (v.SITE_ID_NR = a.SITE_ID_NR)');
          SQL.Add('and a.YIELD > 0');
        end;
        SQL.Add('GROUP BY 1, 2, 3, 4, 6');
      end;
      1: with ZQueryPoints do
      begin
        SQL.Clear;
        SQL.Add('select v.site_id_nr, b.nr_on_map, b.longitude, b.latitude, b.depth, b.date_compl from ' + UseView + ' v');
        SQL.Add('join basicinf b on (v.site_id_nr = b.site_id_nr)');
        if not ShowNoValue then
          SQL.Add('and b.depth > 0');
      end;
      2: with ZQueryPoints do
      begin
        SQL.Clear;
        SQL.Add('select v.SITE_ID_NR, b.NR_ON_MAP, b.LONGITUDE, b.LATITUDE, AVG(cx.' + TheParam + ') as ' + TheParam + ' from ' + UseView + ' v');
        SQL.Add('join basicinf b on (v.site_id_nr = b.site_id_nr)');
        if ShowNoValue then //show all points
        begin
          SQL.Add('LEFT JOIN chem_000 c ON (v.SITE_ID_NR = c.SITE_ID_NR)');
          SQL.Add('LEFT JOIN ' + TheChemTable + ' cx ON (c.CHM_REF_NR = cx.CHM_REF_NR)');
        end
        else
        begin
          SQL.Add('JOIN chem_000 c ON (v.SITE_ID_NR = c.SITE_ID_NR)');
          SQL.Add('JOIN ' + TheChemTable + ' cx ON (c.CHM_REF_NR = cx.CHM_REF_NR)');
        end;
        if ZQueryPoints.Connection.Tag = 1 then //SQLite
        begin
          SQL.Add('AND c.DATE_SAMPL || c.TIME_SAMPL >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DT_From)));
          SQL.Add('AND c.DATE_SAMPL || c.TIME_SAMPL <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DT_To)));
        end
        else
        begin
          SQL.Add('AND CONCAT(c.DATE_SAMPL, c.TIME_SAMPL) >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DT_From)));
          SQL.Add('AND CONCAT(c.DATE_SAMPL, c.TIME_SAMPL) <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DT_To)));
        end;
        SQL.Add('AND cx.' + TheParam + ' > -1');
        SQL.Add('GROUP BY 1, 2, 3, 4');
      end;
      3: with ZQueryPoints do
      begin
        SQL.Clear;
        SQL.Add('select v.SITE_ID_NR, b.NR_ON_MAP, b.LONGITUDE, b.LATITUDE, AVG(f.READING) as ' + TheParam + ' from ' + UseView + ' v');
        SQL.Add('join basicinf b on (v.site_id_nr = b.site_id_nr)');
        if ShowNoValue then
          SQL.Add('LEFT JOIN fldmeas_ f ON (v.SITE_ID_NR = f.SITE_ID_NR)')
        else
          SQL.Add('JOIN fldmeas_ f ON (v.SITE_ID_NR = f.SITE_ID_NR)');
        SQL.Add('AND f.PARM_MEAS = ' + QuotedStr(TheParam[7])); //the 7th character of e.g. PARAM_C
        if ZQueryPoints.Connection.Tag = 1 then //SQLite
        begin
          SQL.Add('AND f.DATE_MEAS || f.TIME_MEAS >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DT_From)));
          SQL.Add('AND f.DATE_MEAS || f.TIME_MEAS <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DT_To)));
        end
        else
        begin
          SQL.Add('AND CONCAT(f.DATE_MEAS, f.TIME_MEAS) >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DT_From)));
          SQL.Add('AND CONCAT(f.DATE_MEAS, f.TIME_MEAS) <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DT_To)));
        end;
        SQL.Add('GROUP BY 1, 2, 3, 4');
      end;
      4: with ZQueryPoints do
      begin
        SQL.Clear;
        SQL.Add('select v.SITE_ID_NR, b.NR_ON_MAP, b.LONGITUDE, b.LATITUDE, AVG(w.WATER_LEV) as WATER_LEV from ' + UseView + ' v');
        SQL.Add('join basicinf b on (v.site_id_nr = b.site_id_nr)');
        if ShowNoValue then
          SQL.Add('LEFT JOIN waterlev w ON (v.SITE_ID_NR = w.SITE_ID_NR)')
        else
          SQL.Add('JOIN waterlev w ON (v.SITE_ID_NR = w.SITE_ID_NR)');
        SQL.Add('AND w.LEVEL_STAT = ' + QuotedStr('S'));
        if ZQueryPoints.Connection.Tag = 1 then //SQLite
        begin
          SQL.Add('AND w.DATE_MEAS || w.TIME_MEAS >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DT_From)));
          SQL.Add('AND w.DATE_MEAS || w.TIME_MEAS <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DT_To)));
        end
        else
        begin
          SQL.Add('AND CONCAT(w.DATE_MEAS, w.TIME_MEAS) >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DT_From)));
          SQL.Add('AND CONCAT(w.DATE_MEAS, w.TIME_MEAS) <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', DT_To)));
        end;
        SQL.Add('GROUP BY 1, 2, 3, 4');
      end;
    end; //of case
  end
  else
  with ZQueryPoints do
  begin
    Connection := DataModuleMain.ZConnectionDB;
    SQL.Clear;
    SQL.Add('select v.site_id_nr, b.nr_on_map, b.longitude, b.latitude, b.altitude, b.date_compl from ' + UseView + ' v');
    SQL.Add('join basicinf b on (v.site_id_nr = b.site_id_nr)');
    if UseCurrent then
      SQL.Add('and v.site_id_nr = ' + QuotedStr(CurrentSite));
  end;
end;


initialization
  PointFormatSettings.DecimalSeparator := '.';

end.

