{ Copyright (C) 2021 Immo Blecher immo@blecher.co.za

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
unit DbStats;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, printers,
  StdCtrls, Buttons, ExtCtrls, ButtonPanel, Db, ZDataset, PrintersDlgs;

type

  { TdbStatForm }

  TdbStatForm = class(TForm)
    BitBtnPrint: TBitBtn;
    ButtonPanel1: TButtonPanel;
    Memo1: TMemo;
    Panel1: TPanel;
    PrintDialog: TPrintDialog;
    CountQuery: TZReadOnlyQuery;
    SiteQuery: TZReadOnlyQuery;
    CountChemQuery: TZReadOnlyQuery;
    procedure FormShow(Sender: TObject);
    procedure BitBtnPrintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    SiteStats: Boolean;
  end;

var
  dbStatForm: TdbStatForm;

implementation

{$R *.lfm}

uses VARINIT, MainDataModule;

procedure TdbStatForm.FormShow(Sender: TObject);
var t: Word;
    TableList: TStringList;
    HasSiteID, HasChemRef: Boolean;
begin
  Screen.Cursor := crSQLWait;
  Application.ProcessMessages;
  BitBtnPrint.Left := 220;
  CountQuery.Connection := DataModuleMain.ZConnectionDB;
  SiteQuery.Connection := DataModuleMain.ZConnectionDB;
  CountChemQuery.Connection := DataModuleMain.ZConnectionDB;
  TableList := TStringList.Create;
  TableList.Sorted := True;
  if SiteStats then
  begin
    Caption := 'Current Site Statistics';
    Memo1.Lines.Add('Current Site (' + CurrentSite + ') Statistics for Workspace:');
  end
  else
  begin
    Memo1.Lines.Add('Database Statistics Report for Workspace:');
  end;
  Memo1.Lines.Add('"' + WSpaceDir + '"' + #13);
  Memo1.Lines.Add('Generated on ' + DateToStr(Date) + ' '
    + TimeToStr(Time) + #13#13);
  Memo1.Lines.Add('TABLE:       NR OF RECORDS:     DESCRIPTION:');
  Memo1.Lines.Add('----------------------------------------------------------------');
  with DataModuleMain do
  begin
    ZConnectionDB.DbcConnection.GetMetadata.ClearCache;
    ZConnectionDB.GetTableNames('', TableList);
    with CheckQuery do
    begin
      Connection := ZConnectionSettings;
      SQL.Clear;
      SQL.Add('select FILE_NAME, DESCRIPTION from Aquasort');
      Open;
      for t := TableList.Count - 1 downto 0 do //check if tables are in Aquasort, otherwise delete from list
        if not Locate('FILE_NAME', TableList[t], [loCaseInsensitive]) then
          TableList.Delete(t);
    end;
  end;
  for t := 0 to TableList.Count - 1 do
  begin
    DataModuleMain.CheckQuery.Locate('FILE_NAME', TableList[t], [loCaseInsensitive]);
    with SiteQuery do
    begin
      SQL.Clear;
      SQL.Add('SELECT * FROM ' + TableList[t] + ' WHERE 1 <> 1'); //get structure
      Open;
      HasSiteID := FindField('site_id_nr') <> NIL;
      HasChemRef := (FindField('chm_ref_nr') <> NIL) and (FindField('site_id_nr') = NIL); //all chemistry tables
      Close;
    end;
    if HasChemRef and SiteStats then
    with CountChemQuery do
    begin
      SQL.Clear;
      SQL.Add('Select count(*) from ' + TableList[t] + ' c1');
      SQL.Add('join chem_000 c on (c.chm_ref_nr = c1.chm_ref_nr)');
      SQL.Add('and c.site_id_nr = ' + QuotedStr(CurrentSite));
      Open;
      Memo1.Lines.Add(TableList[t] + ':'
        + Format('%12d', [Fields[0].AsInteger]) + '           ' + DataModuleMain.CheckQuery.FieldByName('DESCRIPTION').AsString);
      Close;
    end
    else
    with CountQuery do
    begin
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) FROM ' + TableList[t]);
      if SiteStats and HasSiteID then
        SQL.Add('WHERE site_id_nr = ' + QuotedStr(CurrentSite));
      Open;
      if not SiteStats or HasSiteId then
      begin
        if LowerCase(TableList[t]) = 'pmpigen' then
          Memo1.Lines.Add(TableList[t] + ' :'
            + Format('%12d', [Fields[0].AsInteger]) + '           ' + DataModuleMain.CheckQuery.FieldByName('DESCRIPTION').AsString)
        else
          Memo1.Lines.Add(TableList[t] + ':'
            + Format('%12d', [Fields[0].AsInteger]) + '           ' + DataModuleMain.CheckQuery.FieldByName('DESCRIPTION').AsString);
      end;
      Close;
    end;
  end;
  with DataModuleMain do
  begin
    CheckQuery.Close;
    CheckQuery.SQL.Clear;
    CheckQuery.Connection := ZConnectionDB;
  end;
  TableList.Free;
  Screen.Cursor := crDefault;
end;

procedure TdbStatForm.BitBtnPrintClick(Sender: TObject);
var I, Line : Integer;
begin
  if PrintDialog.Execute = True then
  begin
    I := 0;
    Line := 0 ;
    Printer.BeginDoc;
    Printer.Canvas.Font.Name := 'Courier New';
    Printer.Canvas.Font.Size := 9;
    for I := 0 to Memo1.Lines.Count - 1 do
    begin
      Printer.Canvas.TextOut(0, Line, Memo1.Lines[I]);
      Line := Line + Abs(Printer.Canvas.TextHeight('I'));
      if (Line >= Printer.PageHeight) then
        Printer.NewPage;
    end;
    Printer.EndDoc;
  end;
end;

end.
