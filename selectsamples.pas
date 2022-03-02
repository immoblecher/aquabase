{ Copyright (C) 2018 Immo Blecher, immo@blecher.co.za

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
unit selectsamples;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  ButtonPanel, StdCtrls, ComCtrls, ZDataset;

type

  { TSelectSamplesForm }

  TSelectSamplesForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    Label1: TLabel;
    ListBox1: TListBox;
    SampleQuery: TZReadOnlyQuery;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure SampleQueryAfterOpen(DataSet: TDataSet);
    procedure SampleQueryBeforeOpen(DataSet: TDataSet);
  private

  public
    SampleStr, ViewName: String;
    StartDate, StartTime, EndDate, EndTime: ShortString;
    CurrentSiteOnly: Boolean;
  end;

var
  SelectSamplesForm: TSelectSamplesForm;

implementation

{$R *.lfm}

uses MainDataModule, VARINIT;

{ TSelectSamplesForm }

procedure TSelectSamplesForm.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
end;

procedure TSelectSamplesForm.FormShow(Sender: TObject);
begin
  SampleQuery.Open;
end;

procedure TSelectSamplesForm.ListBox1Click(Sender: TObject);
begin
  StatusBar1.SimpleText := IntToStr(ListBox1.SelCount) + ' out of ' + IntToStr(SampleQuery.RecordCount) + ' samples selected';
end;

procedure TSelectSamplesForm.OKButtonClick(Sender: TObject);
var
  c: Integer;
begin
  SampleQuery.Close;
  SampleStr := '';
  if ListBox1.SelCount > 0 then
  begin
    for c := 0 to ListBox1.Count - 1 do
      if ListBox1.Selected[c] then
        SampleStr := SampleStr + ListBox1.Items[c] + ', ';
    Delete(SampleStr, Length(SampleStr) - 1, 2);
  end;
end;

procedure TSelectSamplesForm.SampleQueryAfterOpen(DataSet: TDataSet);
begin
  while not SampleQuery.EOF do
  begin
    ListBox1.Items.Add(SampleQuery.Fields[0].AsString);
    SampleQuery.Next;
  end;
  StatusBar1.SimpleText := '0 out of ' + IntToStr(SampleQuery.RecordCount) + ' samples selected';
end;

procedure TSelectSamplesForm.SampleQueryBeforeOpen(DataSet: TDataSet);
begin
  with SampleQuery do
  begin
    Connection := DataModuleMain.ZConnectionDB;
    SQL.Clear;
    SQL.Add('SELECT c.CHM_REF_NR FROM chem_000 c');
    SQL.Add('JOIN ' + ViewName + ' v ON (v.SITE_ID_NR = c.SITE_ID_NR)');
    if CurrentSiteOnly then
      SQL.Add('AND v.SITE_ID_NR = ' + QuotedStr(CurrentSite));
    if DataModuleMain.ZConnectionDB.Tag = 1 then
    begin
      SQL.Add('AND c.DATE_SAMPL || c.TIME_SAMPL >= ' + QuotedStr(StartDate + StartTime));
      SQL.Add('AND c.DATE_SAMPL || c.TIME_SAMPL <= ' + QuotedStr(EndDate + EndTime));
    end
    else
    begin
      SQL.Add('AND CONCAT(c.DATE_SAMPL, c.TIME_SAMPL) >= ' + QuotedStr(StartDate + StartTime));
      SQL.Add('AND CONCAT(c.DATE_SAMPL, c.TIME_SAMPL) <= ' + QuotedStr(EndDate + EndTime));
    end;
    SQL.Add('ORDER BY c.CHM_REF_NR');
  end;
end;

end.

