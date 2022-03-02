{ Copyright (C) 2019 Immo Blecher, immo@blecher.co.za

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
unit boxwhisker;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TAMultiSeries, TASources,
  TATools, Forms, Controls, Graphics, Dialogs, XMLPropStorage, ComCtrls, Menus,
  ZDataset, db, TALegend, TAChartUtils;

type

  { TBoxWhiskerForm }

  TBoxWhiskerForm = class(TForm)
    Chart1: TChart;
    ChartToolset1: TChartToolset;
    ChartToolset1PanDragTool1: TPanDragTool;
    ChartToolset1ZoomMouseWheelTool1: TZoomMouseWheelTool;
    Copyasbitmap1: TMenuItem;
    HorizGrid1: TMenuItem;
    ListChartSourceX: TListChartSource;
    N2: TMenuItem;
    PopupMenuCharts: TPopupMenu;
    Properties1: TMenuItem;
    QuickFormat1: TMenuItem;
    Saveas1: TMenuItem;
    SaveDialog: TSaveDialog;
    StatusBar1: TStatusBar;
    VertGrid1: TMenuItem;
    XMLPropStorage: TXMLPropStorage;
    ZQueryBox: TZReadOnlyQuery;
    ZReadOnlyQuery1: TZReadOnlyQuery;
    procedure Chart1DblClick(Sender: TObject);
    procedure Copyasbitmap1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HorizGrid1Click(Sender: TObject);
    procedure Saveas1Click(Sender: TObject);
    procedure VertGrid1Click(Sender: TObject);
    procedure ZQueryBoxAfterOpen(DataSet: TDataSet);
    procedure ZQueryBoxBeforeOpen(DataSet: TDataSet);
  private
    TheChemTable: ShortString;
  public
    TheView: String;
    StartDateTime, EndDateTime: TDateTime;
    TheParam, XLabelField: ShortString;
    AllInOne, CurrentSiteOnly: Boolean;
    OrderNr: Byte;
  end;

var
  BoxWhiskerForm: TBoxWhiskerForm;

implementation

{$R *.lfm}

uses MainDataModule, VARINIT;

{ TBoxWhiskerForm }

procedure TBoxWhiskerForm.FormShow(Sender: TObject);
begin
  try
    ZQueryBox.Open;
  except on E: Exception do
    MessageDlg(E.Message + ' - OOPS, something went wrong! Cannot create chart.', mtError, [mbOK], 0);
  end;
  with Chart1 do
  begin
    LeftAxis.Title.Caption := UpperCase(TheParam);
    Axislist[2].Title.Caption := UpperCase(TheParam);
  end;
end;

procedure TBoxWhiskerForm.HorizGrid1Click(Sender: TObject);
begin
  HorizGrid1.Checked := not HorizGrid1.Checked;
  Chart1.LeftAxis.Grid.Visible := HorizGrid1.Checked;
end;

procedure TBoxWhiskerForm.Saveas1Click(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    if LowerCase(ExtractFileExt(SaveDialog.FileName)) = '.jpg' then
      Chart1.SaveToFile(TJPEGImage, SaveDialog.Filename)
    else
    if LowerCase(ExtractFileExt(SaveDialog.FileName)) = '.bmp' then
      Chart1.SaveToFile(TBitmap, SaveDialog.Filename)
    else
    if LowerCase(ExtractFileExt(SaveDialog.FileName)) = '.png' then
      Chart1.SaveToFile(TPortableNetworkGraphic, SaveDialog.Filename)
  end;
end;

procedure TBoxWhiskerForm.VertGrid1Click(Sender: TObject);
begin
  VertGrid1.Checked := not VertGrid1.Checked;
  Chart1.BottomAxis.Grid.Visible := VertGrid1.Checked;
end;

procedure TBoxWhiskerForm.ZQueryBoxAfterOpen(DataSet: TDataSet);
type
  lvalues = array of Double;
var
  TheBoxWhiskerSeries: TBoxAndWhiskerSeries;
  TheSeriesColour: TColor;
  SeriesCount: Word;
  min, q1, med, q3, max: Double;
  SiteID, PrevSiteID, SiteNr: ShortString;
  RecCount, r, m, q1Length, q3Length, oddPos: LongInt;
  ValueList, q1List, q3List: lvalues;
  NewSeries: Boolean;
begin
  if ZQueryBox.RecordCount > 0 then
  begin
    RecCount := 0;
    PrevSiteID := '';
    SeriesCount := 0;
    oddPos := 0;
    max := 0;
    min := 0;
    SiteID := '';
    NewSeries := True; //start with a new series
    ZQueryBox.First;
    if DataModuleMain.ZConnectionDB.Tag = 4 then //for postgres
    with ZQueryBox do
    while not EOF do
    begin
      TheSeriesColour := Random(256*256*256);
      TheBoxWhiskerSeries := TBoxAndWhiskerSeries.Create(Chart1);
      with TheBoxWhiskerSeries do
      begin
         MedianPen.Color := clGreen;
         MedianPen.Width := 2;
         WhiskersPen.Color := clBlue;
         AddXY(RecNo, FieldByName('minimum').Value, FieldByName('q1').Value, FieldByName('median').Value, FieldByName('q3').Value, FieldByName('maximum').Value, FieldByName(XLabelField).Value, TheSeriesColour);
      end;
      ListChartSourceX.Add(RecNo, 0, FieldByName(XLabelField).Value, clBlack);
      Chart1.AddSeries(TheBoxWhiskerSeries);
      Next;
    end
    else //do manual calculations per site_id_nr (series) for all other DBs
    with ZQueryBox do
    for r := 0 to RecordCount - 1 do
    begin
      if NewSeries then //create a new series
      begin
        TheSeriesColour := Random(256*256*256);
        TheBoxWhiskerSeries := TBoxAndWhiskerSeries.Create(Chart1);
        TheBoxWhiskerSeries.MedianPen.Color := clGreen;
        TheBoxWhiskerSeries.WhiskersPen.Color := clBlue;
        Inc(SeriesCount);
        RecCount := 1;
        min := FieldByName('value').Value; //because it's the first value of the ordered query
        q1 := FieldByName('value').Value; //for case where there is only one value
        med := FieldByName('value').Value; //for case where there is only one value
        q3 := FieldByName('value').Value; //for case where there is only one value
        max := FieldByName('value').Value; //for case where there is only one value
        //add first value to the ValueList);
        ValueList := lvalues.Create(FieldByName('value').Value);
        SiteNr := FieldByName(XLabelField).Value;
        NewSeries := False;
      end
      else //add values to ValueList
      begin
        max := FieldByName('value').Value;
        Inc(RecCount);
        SetLength(ValueList, RecCount);
        ValueList[RecCount-1] := FieldByName('value').Value; //add to the totals array
      end;
      PrevSiteID := FieldByName('series').Value; //the first site
      if not EOF then
      begin
        Next;
        SiteID := FieldByName('series').Value;
      end;
      if EOF or (SiteID <> PrevSiteID) then //calculate med, q1 and q 3 and add series to chart
      begin
        //calculate the median
        if odd(RecCount) then
        begin
          oddPos := Round(RecCount/2)-1;
          med := ValueList[oddPos];
        end
        else
          med := (ValueList[Round(RecCount/2)-1] + ValueList[Round(RecCount/2)])/2;
        //populate q1 and q3 lists for odd list
        if odd(RecCount) then
        for m := 0 to RecCount - 1 do
        begin
          if m < oddPos then
          begin
            if q1List = Nil then
              q1List := lvalues.Create(ValueList[m])
            else
            begin
              SetLength(q1List, m+1);
              q1List[m] := ValueList[m];
            end;
          end
          else
          if m > oddPos then
          begin
            if q3List = Nil then
              q3List := lvalues.Create(ValueList[m])
            else
            begin
              SetLength(q3List, m-oddPos);
              q3List[m-oddPos-1] := ValueList[m];
            end;
          end;
        end
        else
        begin //populate q1 and q3 lists for even list
          for m := 0 to Round(RecCount/2) - 1 do //q1 list
          begin
            if q1List = Nil then
              q1List := lvalues.Create(ValueList[m])
            else
            begin
              SetLength(q1List, m+1);
              q1List[m] := ValueList[m];
            end;
          end;
          for m := Round(RecCount/2) to RecCount - 1 do //q3 list
          begin
            if q3List = Nil then
              q3List := lvalues.Create(ValueList[m])
            else
            begin
              SetLength(q3List, Length(q3List) + 1);
              q3List[Length(q3List) - 1] := ValueList[m];
            end;
          end;
        end;
        //calculate q1 and q3 medians
        q1Length := Length(q1List);
        if q1Length < 2 then
          q1 := min
        else
        if odd(q1Length) then
          q1 := q1List[Round(q1Length/2)-1]
        else
          q1 := (q1List[Round(q1Length/2)-1] + q1List[Round(q1Length/2)])/2;
        q3Length := Length(q3List);
        if q3Length < 2 then
          q3 := max
        else
        if odd(q3Length) then
          q3 := q3List[Round(q3Length/2)-1]
        else
          q3 := (q3List[Round(q3Length/2)-1] + q3List[Round(q3Length/2)])/2;
        TheBoxWhiskerSeries.AddXY(SeriesCount, min, q1, med, q3, max, PrevSiteID, TheSeriesColour);
        if XLabelField = 'series' then
          ListChartSourceX.Add(SeriesCount, 0, PrevSiteID, clBlack)
        else
          ListChartSourceX.Add(SeriesCount, 0, SiteNr, clBlack);
        Chart1.AddSeries(TheBoxWhiskerSeries);
        ValueList := Nil;
        q1List := Nil;
        q3List := Nil;
        RecCount := 0;
        NewSeries := True;
      end;
    end;
  end
  else
  begin
    MessageDlg('There are not enough chemistry values for this site and View!. Box-and-Whisker chart not possible.', mtError, [mbOK], 0);
    Close;
  end;
  ZQueryBox.Close;
end;

procedure TBoxWhiskerForm.ZQueryBoxBeforeOpen(DataSet: TDataSet);
var
  t: Byte;
  FieldList: TStringList;
begin
  //get the chemistry table for the parameter
  FieldList := TStringList.Create;
  for t := 1 to 5 do
  begin
    with ZReadOnlyQuery1 do
    begin
      FieldList.Clear;
      SQL.Clear;
      if DataModuleMain.ZConnectionDB.Tag = 5 then //M$SQL
        SQL.Add('SELECT TOP 1 * FROM chem_00' + IntToStr(t))
      else
        SQL.Add('SELECT * FROM chem_00' + IntToStr(t) + ' LIMIT 1');
      Open;
      GetFieldNames(FieldList);
      Close;
      if FieldList.IndexOf(TheParam) > -1 then
        TheChemTable := 'chem_00' + IntToStr(t);
    end;
  end;
  FieldList.Free;
  //populate the query
  if DataModuleMain.ZConnectionDB.Tag = 4 then //PostgreSQL
  with ZQueryBox do
  begin
    Connection := DataModuleMain.ZConnectionDB;
    SQL.Clear;
    SQL.Add('WITH raw_data AS (SELECT v.SITE_ID_NR AS series, b.NR_ON_MAP AS site_nr, ' + TheParam + ' AS value FROM ' + TheView + ' v ');
    SQL.Add('JOIN basicinf b on (b.SITE_ID_NR = v.SITE_ID_NR) ');
    SQL.Add('JOIN chem_000 c0 on (c0.SITE_ID_NR = v.SITE_ID_NR) ');
    SQL.Add('AND CONCAT(c0.DATE_SAMPL, c0.TIME_SAMPL) >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', StartDateTime)));
    SQL.Add('AND CONCAT(c0.DATE_SAMPL, c0.TIME_SAMPL) <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', EndDateTime)));
    SQL.Add('JOIN ' + TheChemTable + ' c on (c.chm_ref_nr = c0.chm_ref_nr) ');
    if CurrentSiteOnly then
    begin
      SQL.Add('WHERE c.' + TheParam + ' > -1 ');
      SQL.Add('AND v.SITE_ID_NR = ' + QuotedStr(CurrentSite) + '), ');
    end
    else
      SQL.Add('WHERE c.' + TheParam + ' > -1), ');
    SQL.Add('details AS (SELECT series, site_nr, value, ROW_NUMBER() OVER ');
    if AllInOne then
      SQL.Add('(ORDER BY value) AS row_number, SUM(1) OVER () AS total ')
    else
      SQL.Add('(PARTITION BY series ORDER BY value) AS row_number, SUM(1) OVER (PARTITION BY series) AS total ');
    SQL.Add('FROM raw_data), ');
    SQL.Add('quartiles AS (SELECT series, site_nr, value, ');
    SQL.Add('AVG(CASE WHEN row_number >= (FLOOR(total/2.0)/2.0) AND row_number <= (FLOOR(total/2.0)/2.0) + 1 THEN value/1.0 ELSE NULL END) OVER ');
    if AllInOne then
    begin
      SQL.Add('() AS q1, AVG(CASE WHEN row_number >= (total/2.0) AND row_number <= (total/2.0) + 1 THEN value/1.0 ELSE NULL END) OVER ');
      SQL.Add('() AS median, AVG(CASE WHEN row_number >= (CEIL(total/2.0) + (FLOOR(total/2.0)/2.0)) AND row_number <= (CEIL(total/2.0) + (FLOOR(total/2.0)/2.0) + 1) THEN value/1.0 ELSE NULL END) OVER ');
      SQL.Add('() AS q3 ');
    end
    else
    begin
      SQL.Add('(PARTITION BY series) AS q1, AVG(CASE WHEN row_number >= (total/2.0) AND row_number <= (total/2.0) + 1 THEN value/1.0 ELSE NULL END) OVER ');
      SQL.Add('(PARTITION BY series) AS median, AVG(CASE WHEN row_number >= (CEIL(total/2.0) + (FLOOR(total/2.0)/2.0)) AND row_number <= (CEIL(total/2.0) + (FLOOR(total/2.0)/2.0) + 1) THEN value/1.0 ELSE NULL END) OVER ');
      SQL.Add('(PARTITION BY series) AS q3 ');
    end;
    SQL.Add('FROM details) ');
    SQL.Add('SELECT series, site_nr, MIN(value) AS minimum, AVG(q1) AS q1, AVG(median) AS median, AVG(q3) AS q3, MAX(value) AS maximum FROM quartiles ');
    SQL.Add('GROUP BY 1, 2 ');
    SQL.Add('ORDER BY ' + IntToStr(OrderNr));
  end
  else //setup easy query to extract ordered parameter
  with ZQueryBox do
  begin
    SQL.Add('SELECT v.SITE_ID_NR AS series, b.NR_ON_MAP AS site_nr, ' + TheParam + ' AS value FROM ' + TheView + ' v');
    SQL.Add('JOIN basicinf b on (b.SITE_ID_NR = v.SITE_ID_NR)');
    SQL.Add('JOIN chem_000 c0 on (c0.SITE_ID_NR = v.SITE_ID_NR)');
    if DataModuleMain.ZConnectionDB.Tag = 1 then
    begin
      SQL.Add('AND (c0.DATE_SAMPL || c0.TIME_SAMPL) >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', StartDateTime)));
      SQL.Add('AND (c0.DATE_SAMPL || c0.TIME_SAMPL) <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', EndDateTime)));
    end
    else
    begin
      SQL.Add('AND CONCAT(c0.DATE_SAMPL, c0.TIME_SAMPL) >= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', StartDateTime)));
      SQL.Add('AND CONCAT(c0.DATE_SAMPL, c0.TIME_SAMPL) <= ' + QuotedStr(FormatDateTime('YYYYMMDDhhnn', EndDateTime)));
    end;
    SQL.Add('JOIN ' + TheChemTable + ' c on (c.chm_ref_nr = c0.chm_ref_nr)');
    if CurrentSiteOnly then
    begin
      SQL.Add('WHERE c.' + TheParam + ' > -1 ');
      SQL.Add('AND v.SITE_ID_NR = ' + QuotedStr(CurrentSite));
    end
    else
      SQL.Add('WHERE c.' + TheParam + ' > -1');
    if OrderNr = 1 then
      SQL.Add('ORDER BY v.SITE_ID_NR, ' + TheParam)
    else
      SQL.Add('ORDER BY b.NR_ON_MAP, ' + TheParam)
  end;
end;

procedure TBoxWhiskerForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
end;

procedure TBoxWhiskerForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TBoxWhiskerForm.Copyasbitmap1Click(Sender: TObject);
begin
  Chart1.CopyToClipboardBitmap;
end;

procedure TBoxWhiskerForm.Chart1DblClick(Sender: TObject);
begin
  Chart1.ZoomFull;
  Screen.Cursor := crDefault;
end;

end.

