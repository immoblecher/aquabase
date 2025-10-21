{ Copyright (C) 2025 Immo Blecher, immo@blecher.co.za

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
unit qfieldimport;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ButtonPanel,
  ComCtrls, StdCtrls, Buttons, ZConnection, ZDataset, ZAbstractRODataset,
  ZDbcSqLite, StrUtils;

type

  { TFormQFieldImport }

  TFormQFieldImport = class(TForm)
    BitBtn1: TBitBtn;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    TableListBox: TListBox;
    ZConnectionQField: TZConnection;
    ZReadOnlyQueryIn: TZReadOnlyQuery;
    ZTableOut: TZTable;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ZConnectionQFieldAfterConnect(Sender: TObject);
    procedure ZConnectionQFieldBeforeConnect(Sender: TObject);
  private
    ErrorLog: TStringList;
    Cancelled, Finished: Boolean;
  public

  end;

var
  FormQFieldImport: TFormQFieldImport;

implementation

{$R *.lfm}

uses MainDataModule, VARINIT;

{ TFormQFieldImport }

procedure TFormQFieldImport.FormActivate(Sender: TObject);
var
  t, i, FldCount: Word;
begin
  if not Finished then
  try
    ErrorLog := TStringList.Create;
    ZConnectionQField.Connect;
    Cancelled := False;
    for t := 0 to TableListBox.Count -1 do
    if not Cancelled then
    begin
      ProgressBar1.Position := 0;
      ProgressBar1.Max := 0;
      ZTableOut.TableName := TableListBox.Items[t];
      Label2.Caption := 'Transferring records to table "' + TableListBox.Items[t] + '"...';
      Application.ProcessMessages;
      ZTableOut.Open;
      with ZReadOnlyQueryIn do
      begin
        Screen.Cursor := crSQLWait;
        SQL.Clear;
        SQL.Add('SELECT t.* FROM ' + TableListBox.Items[t] + ' t');
        with ZTableOut do
        begin
          if FindField('SITE_ID_NR') <> NIL then
          begin
            //bhsiting
            if LowerCase(TableListBox.Items[t]) = 'bhsiting' then
            begin
              SQL.Add('JOIN PROJ_MAN p ON p.PRO_REF_NR = t.PRO_REF_NR');
              SQL.Add('WHERE t.SITE_ID_NR IS NULL OR t.SITE_ID_NR IN (SELECT SITE_ID_NR FROM ' + Filtername + ')');
            end
            else
            //all other layers with site_id_nr
            begin
              SQL.Add('JOIN ' + FilterName + ' v ON v.SITE_ID_NR = t.SITE_ID_NR');
              SQL.Add('WHERE t.SITE_ID_NR IS NOT NULL');
            end;
          end
          else
          //chemistry layers
          if FindField('CHM_REF_NR') <> NIL then
          begin
            SQL.Add('JOIN CHEM_000 c ON c.CHM_REF_NR = t.CHM_REF_NR');
            SQL.Add('JOIN ' + FilterName + ' v ON v.SITE_ID_NR = c.SITE_ID_NR');
            SQL.Add('WHERE c.SITE_ID_NR IS NOT NULL');
          end
          else
          //geophysics
          if (LowerCase(LeftStr(TableListBox.Items[t], 5)) = 'grnd_') or (LowerCase(TableListBox.Items[t]) = 'profilng') then
          begin
            //no joins, just transfer
          end;
        end;
        Open;
        FldCount := Fields.Count;
        Screen.Cursor := crDefault;
        ProgressBar1.Max := RecordCount;
        ProgressBar1.Position := 1;
        Application.ProcessMessages;
        First;
        while not EOF do
        begin
          try
            ZTableOut.Append;
            for i := 0 to FldCount - 1 do
            begin
              if not AnsiMatchStr(Fields[i].FieldName, ['ID', 'FID', 'OGR_FID', 'id', 'fid', 'ogr_fid', 'geometry', 'FILE_PATH', 'NGDB_FLAG']) then
                ZTableOut.FieldByName(Fields[i].FieldName).Value := Fields[i].Value
              else
                if Fields[i].FieldName = 'NGDB_FLAG' then
                  ZTableOut.FieldByName('NGDB_FLAG').AsInteger := 99999; //flag as exported for QField
            end;
            ZTableOut.Post;
            Next;
            ProgressBar1.Position := ProgressBar1.Position + 1;
            Application.ProcessMessages;
          except on E: Exception do
            begin
              Cursor := crDefault;
              ZTableOut.Cancel;
              ProgressBar1.Position := ProgressBar1.Position + 1;
              Application.ProcessMessages;
              ErrorLog.Add(E.Message + ' - Data could not be transferred to table "' + TableListBox.Items[t] + '"!');
              Next;
            end;
          end;
        end;
        Close;
      end;
      ZTableOut.Close;
    end;
    ZConnectionQField.Disconnect;
    if not Cancelled then
    begin
      Finished := True;
      MessageDlg('Finished preparing workspace for QField use!' +
        ' Any errors during the transfer of data were written to "QFieldProjectError.log" in your workspace.' +
        ' You should now open the workspace in QGIS, keep unavailable layers and set the datasource of the top layer to the QField geopackage datasource (will automatically adjust all layers).', mtInformation, [mbOK], 0)
    end
    else
    begin
      MessageDlg('Transfer of data for QField use cancelled!' +
        ' Not all data has been transferred and the QField project may therefore be incomplete.' +
        ' Any errors during the transfer of data were written to "QFieldProjectError.log" in your workspace.', mtInformation, [mbOK], 0);
    end;
  except
    //this happens at the end of the data transfer, not sure why
    begin
      Finished := True;
      Close;
    end;
  end;
end;

procedure TFormQFieldImport.BitBtn1Click(Sender: TObject);
begin
  Cancelled := True
end;

procedure TFormQFieldImport.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ErrorLog.Count > 0 then
    ErrorLog.SaveToFile(WSpaceDir + '/QFieldProjectError.log');
  CanClose := Finished or Cancelled;
end;

procedure TFormQFieldImport.ZConnectionQFieldAfterConnect(Sender: TObject);
var
  sc: IZSQLiteConnection;
  loadResult: Word;
  ErrMsg: String;
  TableList: TStringList;
begin
  with ZConnectionQField do
  begin
    ExecuteDirect('PRAGMA foreign_keys = ON;'); //Enable foreign keys on sqlite
    //Spatially enable other database
    sc := DbcConnection as TZSQLiteConnection;
    sc.enable_load_extension(True);
    {$IFDEF DARWIN}
    loadResult := sc.load_extension('mod_spatialite.dylib', '', ErrMsg);
    {$ELSE}
    loadResult := sc.load_extension('mod_spatialite', '', ErrMsg);
    {$ENDIF}
    if loadResult > 0 then
      {$IFDEF WINDOWS}
      MessageDlg('Could not load "mod_spatialite" library! ' + ErrMsg + 'Please make sure it is installed (should be with Aquabase).', mtError, [mbOK], 0);
      {$ENDIF}
      {$IFDEF UNIX}
      MessageDlg('Could not load "mod_spatialite" library! ' + ErrMsg + 'Please make sure it is installed and (on Linux) possibly sym-linked to "mod_spatialite" without the ".so".', mtError, [mbOK], 0);
      {$ENDIF}
  end;
  with ZReadOnlyQueryIn do
    Connection := DataModuleMain.ZConnectionDB;
  with ZTableOut do
    Connection := ZConnectionQField;
  TableList := TStringList.Create;
  with DataModuleMain.ZConnectionDB do
  begin
    DbcConnection.GetMetadata.ClearCache;
    GetTableNames('', TableList); //get all tables
    TableList.Sort;
    TableList.Move(TableList.IndexOf('profilng'), 0);
    TableList.Move(TableList.IndexOf('proj_man'), 0);
    TableList.Move(TableList.IndexOf('basicinf'), 0);
    TableListBox.Items.Assign(DataModuleMain.GetValidATables(TableList));
    DataModuleMain.GetValidATables(TableList).Free;
  end;
end;

procedure TFormQFieldImport.ZConnectionQFieldBeforeConnect(Sender: TObject);
begin
  with ZConnectionQField do
  begin
    Database := WSpaceDir + '/QFieldProject.gpkg';
    LibraryLocation := SQLiteLib;
  end;
end;

end.

