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
unit reportdocuments;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  DbCtrls, ExtCtrls, Buttons, DBGrids, XMLPropStorage, ZDataset, LCLType,
  rxdbgrid, RxSortZeos;

type

  { TReportDocsForm }

  TReportDocsForm = class(TForm)
    BitBtn1: TBitBtn;
    HelpButton: TBitBtn;
    BitBtnSave: TBitBtn;
    BitBtnLoad: TBitBtn;
    DataSource1: TDataSource;
    DBNavigator1: TDBNavigator;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    ReportQueryFILENAME: TStringField;
    ReportQueryREPORT_LOADED: TBooleanField;
    RxDBGrid: TRxDBGrid;
    RxSortZeos1: TRxSortZeos;
    SaveDialog1: TSaveDialog;
    XMLPropStorage1: TXMLPropStorage;
    ReportQuery: TZQuery;
    ReportQueryID: TLargeintField;
    ReportQueryPRIM_AUTH: TStringField;
    ReportQueryREPORT_NR: TStringField;
    ReportQueryREP_INST: TStringField;
    ReportQueryREP_TITLE: TStringField;
    ReportQuerySEC_AUTH: TStringField;
    SaveQuery: TZQuery;
    LoadQuery: TZQuery;
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure HelpButtonClick(Sender: TObject);
    procedure BitBtnLoadClick(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure ReportQueryAfterCancel(DataSet: TDataSet);
    procedure ReportQueryAfterPost(DataSet: TDataSet);
    procedure ReportQueryBeforeEdit(DataSet: TDataSet);
    procedure ReportQueryBeforeOpen(DataSet: TDataSet);
    procedure ReportQueryBeforePost(DataSet: TDataSet);
    procedure ReportQueryCalcFields(DataSet: TDataSet);
    procedure ReportQueryNewRecord(DataSet: TDataSet);
    procedure ReportQueryREPORT_NRSetText(Sender: TField; const aText: string);
    procedure ReportQueryREP_INSTValidate(Sender: TField);
    procedure ReportQueryUpperSetText(Sender: TField; const aText: string);
    procedure RxDBGridColEnter(Sender: TObject);
    procedure RxDBGridColExit(Sender: TObject);
    procedure RxDBGridGetCellHint(Sender: TObject; Column: TColumn;
      var AText: String);
    procedure RxDBGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure RxDBGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RxDBGridMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    ValidFound, ColExitAborted: Boolean;
    SelFieldName, OldReportNr, NewReportNr: ShortString;
    row, col: LongInt;
  public

  end;

var
  ReportDocsForm: TReportDocsForm;

implementation

{$R *.lfm}

uses VARINIT, maindatamodule, lookup;

{ TReportDocsForm }

procedure TReportDocsForm.BitBtnLoadClick(Sender: TObject);
var
  CanLoad: Boolean;
  TheReportNr: ShortString;
begin
  CanLoad := True;
  if ReportQuery.State IN [dsInsert, dsEdit] then
  begin
    if MessageDlg('Current report record must be posted before report file can be attached! Do you want to post it now?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      ReportQuery.Post;
      CanLoad := True;
    end
    else
      CanLoad := False;
  end;
  if CanLoad then
  begin
    TheReportNr := ReportQuery.FieldByName('REPORT_NR').Value;
    if OpenDialog1.Execute then
    begin
      LoadQuery.ParamByName('FName').AsString := ExtractFileName(OpenDialog1.FileName);
      LoadQuery.ParamByName('Doc').LoadFromFile(OpenDialog1.FileName, ftBlob);
      LoadQuery.ParamByName('TheID').AsInteger := ReportQueryID.AsInteger;
      if MessageDlg('Are you sure you want to attach report file "' + OpenDialog1.FileName + '" to the current record? This will take a moment or two depending on its size. Wait until the "Successful" message appears.', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        Screen.Cursor := crSQLWait;
        try
          LoadQuery.ExecSQL;
          Screen.Cursor := crDefault;
          ShowMessage('Report file "' + OpenDialog1.FileName + '" successfully attached to current record.');
        except on E: Exception do
          begin
            Screen.Cursor := crDefault;
            MessageDlg(E.Message, mtError, [mbOK], 0);
          end;
        end;
        ReportQuery.Refresh;
        ReportQuery.Locate('REPORT_NR', TheReportNr, []);
      end;
    end;
  end;
end;

procedure TReportDocsForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TReportDocsForm.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  BitBtnSave.Enabled := ReportQueryREPORT_LOADED.Value = True;
end;

procedure TReportDocsForm.BitBtnSaveClick(Sender: TObject);
var
  BlobStream : TStream;
  M: TFileStream;
begin
  with SaveQuery do
  begin
    ParamByName('TheID').AsInteger := ReportQueryID.AsInteger;
    Open;
    SaveDialog1.FileName := SaveQuery.FieldByName('FILENAME').AsString;
    if SaveDialog1.Execute then
    begin
      BlobStream := CreateBlobStream(FieldByName('REP_DOC'), bmread);
      M := TFileStream.Create(SaveDialog1.FileName, fmCreate);
      BlobStream.Position := 0;
      M.CopyFrom(BlobStream, BlobStream.Size);
      M.Free;
      BlobStream.Free;
      ShowMessage('Report file successfully saved to disk.');
    end;
    Close;
  end;
end;

procedure TReportDocsForm.FormActivate(Sender: TObject);
begin
  ReportQuery.Locate('REPORT_NR', CurrentRepNr, []);
end;

procedure TReportDocsForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TReportDocsForm.FormCreate(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  ValidFound := True;
  Screen.Cursor := crDefault;
end;

procedure TReportDocsForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(HelpButton);
end;

procedure TReportDocsForm.FormShow(Sender: TObject);
begin
  ReportQuery.Open;
end;

procedure TReportDocsForm.ReportQueryAfterCancel(DataSet: TDataSet);
begin
  ValidFound := True;
end;

procedure TReportDocsForm.ReportQueryAfterPost(DataSet: TDataSet);
begin
  ValidFound := True;
  if (OldReportNr > '') and (NewReportNr <> OldReportNr) then
  begin
    if MessageDlg('You have changed the Report Number which is now different to the number linked to the sites! Do you want to change the numbers for your sites linked to this report too?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      DataModuleMain.ZConnectionDB.ExecuteDirect('UPDATE siterpts SET REPORT_NR = ' + QuotedStr(ReportQueryREPORT_NR.Value) + ' WHERE REPORT_NR = ' + QuotedStr(OldReportNr));
  end;
  OldReportNr := '';
end;

procedure TReportDocsForm.ReportQueryBeforeEdit(DataSet: TDataSet);
begin
  OldReportNr := ReportQueryREPORT_NR.Value;
end;

procedure TReportDocsForm.ReportQueryBeforeOpen(DataSet: TDataSet);
begin
  ReportQuery.Connection := DataModuleMain.ZConnectionDB;
end;

procedure TReportDocsForm.ReportQueryBeforePost(DataSet: TDataSet);
begin
  if not ValidFound then
  begin
    MessageDlg('You are trying to post a record with invalid values in the current field! Please TAB left or right to obtain reason for this error.', mtError, [mbOK], 0);
    RxDBGrid.SetFocus;
    Abort;
  end;
end;

procedure TReportDocsForm.ReportQueryCalcFields(DataSet: TDataSet);
begin
  if ReportQueryFILENAME.IsNull then
    ReportQueryREPORT_LOADED.Value := False
  else
    ReportQueryREPORT_LOADED.Value := True;
end;

procedure TReportDocsForm.ReportQueryNewRecord(DataSet: TDataSet);
begin
  ReportQueryREP_INST.Value := DataModuleMain.BasicinfQueryREP_INST.Value;
end;

procedure TReportDocsForm.ReportQueryREPORT_NRSetText(Sender: TField;
  const aText: string);
begin
  NewReportNr := UpperCase(aText);
  Sender.AsString := UpperCase(aText);
end;

procedure TReportDocsForm.ReportQueryREP_INSTValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound(Sender.LookupKeyFields, Sender.AsString);
end;

procedure TReportDocsForm.ReportQueryUpperSetText(Sender: TField; const aText: string);
begin
  Sender.AsString := UpperCase(aText);
end;

procedure TReportDocsForm.RxDBGridColEnter(Sender: TObject);
begin
  if ColExitAborted then
  begin
    RxDBGrid.SelectedField := RxDBGrid.DataSource.DataSet.FieldByName(SelFieldName);
    ColExitAborted := False;
  end;
  ValidFound := True;
end;

procedure TReportDocsForm.RxDBGridColExit(Sender: TObject);
begin
  if RxDBGrid.Focused and (not ValidFound) then
  begin
    MessageDlg('"' + RxDBGrid.SelectedField.AsString + '" is an invalid code for "' + RxDBGrid.SelectedColumn.Title.Caption + '"!', mtError, [mbOK], 0);
    if RxDBGrid.SelectedField.LookupKeyFields > '' then
      RxDBGrid.SelectedField.Clear;
    ValidFound := True;
    SelFieldName := RxDBGrid.SelectedField.FieldName;
    ColExitAborted := True;
  end;
end;

procedure TReportDocsForm.RxDBGridGetCellHint(Sender: TObject; Column: TColumn;
  var AText: String);
begin
  //use the LookupKeyFields property for the code translation, which is not used otherwise
  if (col > 0) and (Column.Field.LookupKeyFields > '') then
    AText := DataModuleMain.TranslateCode(Column.Field.LookupKeyFields, Column.Field.AsString)
  else
    AText := 'Report documents';
end;

procedure TReportDocsForm.RxDBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_DELETE: if (ssShift in Shift) and (ReportQuery.State IN [dsInsert, dsEdit]) then
                 RxDBGrid.SelectedField.Clear;
    VK_F5: ReportQuery.Refresh;
    VK_F8: if (ssCtrl in Shift) then
             ReportQuery.Edit
           else
           if ReportQuery.State IN [dsInsert, dsEdit] then
             ReportQuery.Post;
    VK_F9: begin
            if RxDBGrid.SelectedField.FieldName = 'REP_INST' then
            begin
              with TLookupForm.Create(Application) do
              begin
               LookupCategory := 'REP_INST';
               LookupValue := ReportQuery.FieldByName(RxDBGrid.SelectedField.FieldName).AsString;
               ShowModal;
               if ModalResult = mrOK then
                 if ReportQuery.State IN [dsInsert, dsEdit] then
                   ReportQuery.FieldByName(RxDBGrid.SelectedField.FieldName).AsString := LookupValue;
              end;
            end;
          end;
  end; //of case
end;

procedure TReportDocsForm.RxDBGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
  begin
    if RxDBGrid.SelectedField.FieldName = 'REP_INST' then
    begin
      with TLookupForm.Create(Application) do
      begin
       LookupCategory := 'REP_INST';
       LookupValue := ReportQuery.FieldByName(RxDBGrid.SelectedField.FieldName).AsString;
       ShowModal;
       if ModalResult = mrOK then
         if ReportQuery.State IN [dsInsert, dsEdit] then
           ReportQuery.FieldByName(RxDBGrid.SelectedField.FieldName).AsString := LookupValue;
      end;
    end;
  end;
end;

procedure TReportDocsForm.RxDBGridMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  TDBGrid(Sender).MouseToCell(X, Y, col, row);
end;

end.

