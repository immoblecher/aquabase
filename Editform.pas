{ Copyright (C) 2024 Immo Blecher immo@blecher.co.za

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
unit Editform;

{$mode objfpc}{$H+}
 
interface

uses
  SysUtils, Classes, Graphics, Controls, Dialogs, ZDataset, Forms,
  ZAbstractRODataset, DBCtrls, DB, DBGrids, ExtCtrls, Buttons, XMLPropStorage,
  LCLType, RxDBGridExportSpreadSheet, RxDBGridPrintGrid, fileutil, rxdbgrid,
  RxDBGridExportPdf, RxSortZeos;

type

  { TEditLookupForm }

  TEditLookupForm = class(TForm)
    Chem6DefQueryPARAMETER: TStringField;
    Chem6DefQueryPARAM_DESCR: TStringField;
    Chem6DefQueryPARAM_FLD: TStringField;
    Chem6DefQueryPARAM_UNIT: TStringField;
    Chem6DefQuerySHOW: TBooleanField;
    ClassQueryCLASS0: TFloatField;
    ClassQueryCLASS1: TFloatField;
    ClassQueryCLASS2: TFloatField;
    ClassQueryCLASS3: TFloatField;
    ClassQueryPARAMETER: TStringField;
    ClassQueryPARA_DESCR: TStringField;
    ClassQueryUNIT: TStringField;
    DBNavigator: TDBNavigator;
    LookupQueryADJECTIVE: TFloatField;
    LookupQueryDESCRIBE: TStringField;
    LookupQueryLEN_CODE: TLongintField;
    LookupQueryLEN_DESC: TLongintField;
    LookupQuerySEARCH: TStringField;
    LookupQueryUSED_FOR: TStringField;
    Panel1: TPanel;
    EditDataSource: TDataSource;
    Panel2: TPanel;
    CloseBitBtn: TBitBtn;
    HelpBitBtn: TBitBtn;
    RxDBGrid: TRxDBGrid;
    RxDBGridExportPDF1: TRxDBGridExportPDF;
    RxDBGridExportSpreadSheet1: TRxDBGridExportSpreadSheet;
    RxDBGridPrint1: TRxDBGridPrint;
    RxSortZeos1: TRxSortZeos;
    StandardQueryPARAMETER: TStringField;
    StandardQueryPARA_DESCR: TStringField;
    StandardQueryPARA_SHORT: TStringField;
    StandardQuerySTDMAXHI: TStringField;
    StandardQuerySTDMAXLO: TStringField;
    StandardQuerySTDRECHI: TStringField;
    StandardQuerySTDRECLO: TStringField;
    StandardQueryUNIT: TStringField;
    UnitQueryDESCRIPTIO: TStringField;
    UnitQueryFACTOR: TFloatField;
    UnitQueryUNIT: TStringField;
    XMLPropStorage1: TXMLPropStorage;
    LookupQuery: TZQuery;
    UnitQuery: TZQuery;
    StandardQuery: TZQuery;
    ClassQuery: TZQuery;
    Chem6DefQuery: TZQuery;
    ChemParamsQuery: TZQuery;
    procedure Chem6DefQueryBeforeDelete(DataSet: TDataSet);
    procedure Chem6DefQueryBeforeInsert(DataSet: TDataSet);
    procedure EditDataSourceDataChange(Sender: TObject; Field: TField);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure LookupQueryBeforeDelete(DataSet: TDataSet);
    procedure LookupQueryNewRecord(DataSet: TDataSet);
    procedure QueryPostError(DataSet: TDataSet; E: EDatabaseError;
      var DataAction: TDataAction);
    procedure LookupQuerySetText(Sender: TField;
      const aText: String);
    procedure LookupTablesearchSetText(Sender: TField; const aText: String);
    procedure FormShow(Sender: TObject);
    procedure RxDBGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure StandardQueryPARAMETERSetText(Sender: TField;
      const aText: String);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure HelpBitBtnClick(Sender: TObject);
    procedure CloseBitBtnClick(Sender: TObject);
  private
    { private declarations }
    CurrentCode: ShortString;
  public
    { public declarations }
    UnitTableName, StandardTableName: ShortString;
  end;

var
  EditLookupForm: TEditLookupForm;

implementation

{$R *.lfm}

uses MainDataModule, VARINIT;

procedure TEditLookupForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if ClassQuery.Active then
    ClassQuery.Close;
  if Chem6DefQuery.Active then
    Chem6DefQuery.Close;
  if UnitQuery.Active then
    UnitQuery.Close;
  if LookupQuery.Active then
    LookupQuery.Close;
  if StandardQuery.Active then
    StandardQuery.Close;
  if ChemParamsQuery.Active then
    ChemParamsQuery.Close;
  if DataModuleMain.LookupTable.Active then
    DataModuleMain.LookupTable.Refresh;
  CloseAction := caFree;
end;

procedure TEditLookupForm.EditDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  if LookupQuery.Active then
    CurrentCode := LookupQueryUSED_FOR.Value;
end;

procedure TEditLookupForm.Chem6DefQueryBeforeInsert(DataSet: TDataSet);
begin
  MessageDlg('You cannot add more than 21 other parameters!', mtError, [mbOK], 0);
  Abort;
end;

procedure TEditLookupForm.Chem6DefQueryBeforeDelete(DataSet: TDataSet);
begin
  MessageDlg('You cannot delete any parameters here! If you don''t want to see to see them just mark them as not showing.', mtError, [mbOK], 0);
  Abort;
end;

procedure TEditLookupForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, True);
end;

procedure TEditLookupForm.LookupQueryBeforeDelete(DataSet: TDataSet);
begin
  if MessageDlg('Are you really sure you want to delete this Lookup Code? This may lead to invalid codes in your database if you have used this code before!', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Abort;
end;

procedure TEditLookupForm.LookupQueryNewRecord(DataSet: TDataSet);
begin
  //LookupQueryUSED_FOR.ReadOnly := False;
  LookupQueryUSED_FOR.Value := CurrentCode;
  LookupQueryADJECTIVE.Value := 0;
  LookupQueryLEN_CODE.Value := 4;
  LookupQueryLEN_DESC.Value := 24;
  //LookupQueryUSED_FOR.ReadOnly := True;
end;

procedure TEditLookupForm.QueryPostError(DataSet: TDataSet;
  E: EDatabaseError; var DataAction: TDataAction);
begin
  ShowMessage(E.Message + ' - Record will not be posted! Make sure you have write-access to the table. You can achieve that by changing your Settings and Language files to a read-write location under the Aquabase Preferences.');
  DataAction := daAbort;
end;

procedure TEditLookupForm.LookupQuerySetText(Sender: TField;
  const aText: String);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TEditLookupForm.LookupTablesearchSetText(Sender: TField;
  const aText: String);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TEditLookupForm.FormShow(Sender: TObject);
var
  i: Byte;
begin
  if EditDatasource.Dataset = UnitQuery then
  begin
    with UnitQuery do
    begin
      SQL.Clear;
      SQL.Add('SELECT UNIT, DESCRIPTIO, FACTOR FROM ' + UnitTableName);
      SQL.Add('ORDER BY UNIT');
      Open;
    end;
  end
  else
  if EditDatasource.Dataset = StandardQuery then
  begin
    with StandardQuery do
    begin
      SQL.Clear;
      SQL.Add('SELECT * FROM ' + StandardTableName);
      SQL.Add('ORDER BY PARAMETER');
      Open;
    end;
  end
  else
  if EditDatasource.Dataset = ClassQuery then
    ClassQuery.Open
  else
  if EditDatasource.Dataset = DataModuleMain.StandDescrTable then
    DataModuleMain.StandDescrTable.Open
  else
  if EditDatasource.Dataset = LookupQuery then
    LookupQuery.Open
  else
  if EditDatasource.Dataset = Chem6DefQuery then
  begin
    try
      Chem6DefQuery.Open;
    except on E: Exception do
      begin
        Screen.Cursor := crDefault;
        MessageDlg('The "Other" chemistry parameter defininitons in your default Aquabase settings file have been updated while you are using settings from another folder location! This will be fixed now.', mtInformation, [mbOK], 0);
        //create the definition table
        Screen.Cursor := crSQLWait;
        with Chem6DefQuery do
        begin
          SQL.Clear;
          SQL.Add('CREATE TABLE Chem6Def');
          SQL.Add('(ID INTEGER PRIMARY KEY AUTOINCREMENT,');
          SQL.Add('PARAM_FLD   VARCHAR (7),');
          SQL.Add('PARAMETER   VARCHAR (8),');
          SQL.Add('PARAM_DESCR VARCHAR (12),');
          SQL.Add('PARAM_UNIT  VARCHAR (6),');
          SQL.Add('SHOW BOOLEAN DEFAULT (''N''));');
          ExecSQL;
          SQL.Clear;
          for i := 1 to 21 do //fill with default values
          begin
            SQL.Add('INSERT INTO Chem6Def (ID, PARAM_FLD, PARAMETER, PARAM_DESCR, PARAM_UNIT, SHOW)');
            SQL.Add('VALUES(NULL, ''PARAM' + IntToStr(i)+ ''', NULL, NULL, NULL, ''N'');');
            ExecSQL;
            SQL.Clear;
          end;
          SQL.Add('SELECT * FROM Chem6Def');
          Open;
          Screen.Cursor := crDefault;
        end;
      end;
    end;
  end
  else
  if EditDataSource.DataSet = ChemParamsQuery then
  begin
    ChemParamsQuery.Open;
  end;
end;

procedure TEditLookupForm.RxDBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (ssShift in Shift) then
    if RxDBGrid.DataSource.DataSet.State IN [dsInsert, dsEdit] then
      RxDBGrid.SelectedField.Clear;
end;

procedure TEditLookupForm.StandardQueryPARAMETERSetText(Sender: TField;
  const aText: String);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TEditLookupForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ssCtrl in Shift then
  begin
    case Key of
      78: RxDBGrid.DataSource.DataSet.Next;
      80: RxDBGrid.DataSource.DataSet.Prior;
      VK_F8: RxDBGrid.DataSource.DataSet.Edit;
    end {of case}
  end
  else
  begin
    case Key of
      VK_F5: RxDBGrid.DataSource.DataSet.Refresh;
      VK_F8: if RxDBGrid.DataSource.DataSet.State IN [dsInsert, dsEdit] then
               RxDBGrid.DataSource.DataSet.Post;
      27: if RxDBGrid.DataSource.DataSet.State IN [dsInsert, dsEdit] then
            RxDBGrid.DataSource.DataSet.Cancel;
    end; {of case}
  end;
end;

procedure TEditLookupForm.HelpBitBtnClick(Sender: TObject);
begin
  if Self.Caption = 'Edit Lookup Codes' then
    Application.HelpKeyword('EditLC')
  else Application.HelpKeyword('EditUnits');
end;

procedure TEditLookupForm.CloseBitBtnClick(Sender: TObject);
begin
  Close;
end;

end.
