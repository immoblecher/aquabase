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
  at http://www.gnu.org/copyleft/gpl.html. You can also obtain it by writing
  to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
  MA 02111-1307, USA.
}
unit PROJ_MAN;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Clipbrd, ZDataset,
  StdCtrls, Forms, DBCtrls, DB, DBGrids, ExtCtrls, LCLType,
  Buttons, Menus, Dialogs, ComCtrls, XMLPropStorage;

type

  { TProjManForm }

  TProjManForm = class(TForm)
    Panel1: TPanel;
    ProjManDataSource: TDataSource;
    Panel3: TPanel;
    LinkedDataSource: TDataSource;
    CloseBitBtn: TBitBtn;
    HelpBitBtn: TBitBtn;
    ProjManTable: TZTable;
    LinkedTable: TZTable;
    EditNavigator: TDBNavigator;
    PopupMenu1: TPopupMenu;
    GotoBookmark: TMenuItem;
    SetBookmark: TMenuItem;
    N16: TMenuItem;
    CutMenu: TMenuItem;
    CopyMenu: TMenuItem;
    PasteMenu: TMenuItem;
    LookupTable: TZTable;
    ProjManTablePRO_REF_NR: TStringField;
    ProjManTablePROJ_NR: TStringField;
    ProjManTablePROJ_NAME: TStringField;
    ProjManTableGEOHYD_CON: TStringField;
    ProjManTableJOB_NR: TStringField;
    ProjManTableENG_CON: TStringField;
    ProjManTableSOC_CON: TStringField;
    ProjManTableDATE_START: TStringField;
    ProjManTableDATE_END: TStringField;
    ProjManTableDATE_VERIF: TStringField;
    ProjManTableDATE_UPDTD: TStringField;
    ProjManTableDATE_ENTRY: TStringField;
    ProjNavigator: TDBNavigator;
    FindTable: TZTable;
    FindTablePRO_REF_NR: TStringField;
    FindTableSITE_ID_NR: TStringField;
    LinkedTablePRO_REF_NR: TStringField;
    LinkedTableSITE_ID_NR: TStringField;
    LinkedTableSITE_NAME: TStringField;
    LinkedTableSITE_REFER: TStringField;
    LinkedTableTRAV_NR: TStringField;
    LinkedTablePEG_NR: TStringField;
    LinkedTableALT_PEG_NR: TStringField;
    LinkedTablePRIORITY: TSmallintField;
    LinkedTableDATE_PLAN: TStringField;
    LinkedTableDATE_SITED: TStringField;
    LinkedTableMETH_SITE1: TStringField;
    LinkedTableMETH_SITE2: TStringField;
    LinkedTableMETH_SITE3: TStringField;
    LinkedTableMETH_SITE4: TStringField;
    LinkedTableMETH_SITE5: TStringField;
    LinkedTableREC_DEPTH: TFloatField;
    LinkedTableTARGET: TStringField;
    LinkedTableCOMMENT: TStringField;
    LinkedTableMARKED: TBooleanField;
    ProjManTableCLIENT: TStringField;
    CurrentComboBox: TComboBox;
    FindTableTRAV_NR: TStringField;
    PageControl1: TPageControl;
    SitingTabSheet: TTabSheet;
    DBGrid: TDBGrid;
    TaskTabSheet: TTabSheet;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    GroupBox1: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    Label3: TLabel;
    Label18: TLabel;
    LongitudeLabel: TLabel;
    EditPROJ_NR: TDBEdit;
    EditPROJ_NAME: TDBEdit;
    EditCLIENT: TDBEdit;
    EditGEOHYD_CON: TDBEdit;
    EditJOB_NR: TDBEdit;
    LatitudeLabel: TLabel;
    AltitudeLabel: TLabel;
    CollarLabel: TLabel;
    DepthLabel: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label26: TLabel;
    EditENG_CON: TDBEdit;
    EditSOC_CON: TDBEdit;
    EditDATE_START: TDBEdit;
    EditDATE_END: TDBEdit;
    EditDATE_VERIF: TDBEdit;
    EditDATE_ENTRY: TDBEdit;
    EditDATE_UPDTD: TDBEdit;
    SiteTable: TZTable;
    XMLPropStorage1: TXMLPropStorage;
    procedure DBGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure LinkedTableAfterOpen(DataSet: TDataSet);
    procedure LinkedTableCAPSSetText(Sender: TField; const aText: string);
    procedure ProjManDataSourceDataChange(Sender: TObject; Field: TField);
    procedure ProjManTableBeforePost(DataSet: TDataset);
    procedure LinkedTableNewRecord(DataSet: TDataset);
    procedure DBGridEnter(Sender: TObject);
    procedure SitingLabelClick(Sender: TObject);
    procedure Label27Click(Sender: TObject);
    procedure EditPROJ_NRClick(Sender: TObject);
    procedure GotoBookmarkClick(Sender: TObject);
    procedure SetBookmarkClick(Sender: TObject);
    procedure CutMenuClick(Sender: TObject);
    procedure CopyMenuClick(Sender: TObject);
    procedure PasteMenuClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure DBGridColEnter(Sender: TObject);
    procedure DBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ProjManTableNewRecord(DataSet: TDataset);
    procedure ProjManTableDATE_STARTValidate(Sender: TField);
    procedure ProjManTableDATE_ENDValidate(Sender: TField);
    procedure ProjManTableDATE_VERIFValidate(Sender: TField);
    procedure LinkedTableSetText(Sender: TField;
      const aText: String);
    procedure LinkedTableREC_DEPTHSetText(Sender: TField;
      const aText: String);
    procedure LinkedTableREC_DEPTHGetText(Sender: TField;
      var aText: String; DisplayText: Boolean);
    procedure LinkedDataSourceDataChange(Sender: TObject; Field: TField);
    procedure CurrentComboBoxChange(Sender: TObject);
    procedure GroupBox1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SiteTableBeforeOpen(DataSet: TDataSet);
    procedure LinkedTableSITE_ID_NRValidate(Sender: TField);
    procedure CloseBitBtnClick(Sender: TObject);
  private
    { private declarations }
    BookMark: TBookmark;
  public
    { public declarations }
  end;

var
  ProjManForm: TProjManForm;

implementation

uses VARINIT, Lookup, strdatetime, selectSiteID, MainDataModule;

{$R *.lfm}

procedure TProjManForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  ProjManTable.Open;
  LinkedTable.Connection := DataModuleMain.ZConnectionDB;
  LinkedTable.Open;
  LookupTable.Connection := DataModuleMain.ZConnectionLanguage;
  LookupTable.Open;
  CurrentComboBox.ItemIndex := 0;
end;

procedure TProjManForm.DBGridMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  TheCategory: ShortString;
begin {of procedure to open lookup tables}
  DBGridEnter(Sender);
  if Button = mbRight then
  begin
    if DBGrid.SelectedIndex <> 8 then
    begin
      case DBGrid.SelectedIndex of
      9..13: TheCategory := 'GEO_METH';
         15: TheCategory := 'TARGET';
      else exit;
      end; {of CASE}
      with TLookupForm.Create(Application) do
      begin
        LookupCategory := TheCategory;
        LookupValue := LinkedTable.FieldByName(DBGrid.SelectedField.FieldName).AsString;
        ShowModal;
        if ModalResult = mrOK then
          if LinkedTable.State IN [dsInsert, dsEdit] then
            LinkedTable.FieldByName(DBGrid.SelectedField.FieldName).AsString := LookupValue;
        Close;
      end;
    end
    else
    begin
      with TFormSelSiteID.Create(Application) do
      begin
        ShowModal;
        if ModalResult = mrOK then
        if LinkedTable.State IN [dsInsert, dsEdit] then
          LinkedTable.FieldByName(DBGrid.SelectedField.FieldName).AsString := SiteIDQuerySITE_ID_NR.Value;
        Close;
      end;
    end;
  end;
end;

procedure TProjManForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  ProjManTable.FreeBookmark(Bookmark);
  LinkedTable.Close;
  ProjManTable.Close;
  LookupTable.Close;
  Editing := 'Editing: <none>';
  CloseAction := caFree;
end;

procedure TProjManForm.FormActivate(Sender: TObject);
begin
  FindTable.Close;
  case CurrentComboBox.ItemIndex of
    0: begin
         FindTable.IndexFieldNames := 'SITE_ID_NR';
         FindTable.Open;
         if FindTable.Locate('SITE_ID_NR', CurrentSite, []) then
           ProjManTable.Locate('PRO_REF_NR', FindTablePRO_REF_NR.AsString, []);
       end;
    1: begin
         FindTable.IndexFieldNames := 'TRAV_NR';
         FindTable.Open;
         if FindTable.Locate('TRAV_NR', CurrentTraverse, []) then
           ProjManTable.Locate('PRO_REF_NR', FindTablePRO_REF_NR.AsString, []);
       end;
    2: begin
         ProjManTable.Locate('PRO_REF_NR', CurrentProject, []);
       end;
  end; //of case
  FindTable.Close;
  SitingTabSheet.Caption := 'Siting - Depth [' + LengthUnit + ']';
  if EditNavigator.DataSource = ProjManDataSource then
    Editing := 'Editing: Project management'
  else
    Editing := 'Editing: Siting information';
  if LinkedTable.Active then LinkedTable.Refresh;
end;

procedure TProjManForm.LinkedTableAfterOpen(DataSet: TDataSet);
begin
  LinkedDataSource.AutoEdit := AutoEditData;
end;

procedure TProjManForm.LinkedTableCAPSSetText(Sender: TField;
  const aText: string);
begin
  if AllowSmallChars then
    Sender.Value := aText
  else
    Sender.Value := UpperCase(aText);
end;

procedure TProjManForm.ProjManDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  Caption := 'Project Information - ' + ProjManTablePRO_REF_NR.AsString;
end;

procedure TProjManForm.ProjManTableBeforePost(DataSet: TDataset);

var
  NumberStr: String;
  NewNumber: Integer;

begin
  if ProjManTable.State = dsInsert then
  begin
    with DataModuleMain.CheckQuery do
    begin
      Connection := DataModuleMain.ZConnectionDB;
      SQL.Clear;
      SQL.Add('SELECT MAX(PRO_REF_NR) FROM proj_man WHERE PRO_REF_NR LIKE ' + QuotedStr(FormatDateTime('YYYY', Date) + '/%'));
      Open;
      if Fields[0].AsString > '' then
      begin
        NumberStr := Copy(Fields[0].AsString, 6, 3);
        NewNumber := StrToInt(NumberStr) + 1;
        NumberStr := Format('%3.3d', [NewNumber]);
      end
      else NumberStr := '001';
      Close;
    end;
    ProjManTablePRO_REF_NR.Value := FormatDateTime('YYYY', Date) + '/' + NumberStr;
  end;
end;

procedure TProjManForm.LinkedTableNewRecord(DataSet: TDataset);
begin
  LinkedTableDATE_SITED.Value := FormatDateTime('YYYYMMDD', Date)
end;

procedure TProjManForm.DBGridEnter(Sender: TObject);
begin
  if ProjManTable.RecordCount > 0 then
  begin
    EditNavigator.DataSource := LinkedDataSource;
    Editing := 'Editing: Siting information';
  end
  else
  EditNavigator.Enabled := False;
end;

procedure TProjManForm.SitingLabelClick(Sender: TObject);
begin
  if ProjManTable.RecordCount > 0 then
  begin
    EditNavigator.DataSource := LinkedDataSource;
    Editing := 'Editing: Siting information';
    DBGrid.SetFocus;
  end
  else
  EditNavigator.Enabled := False;
end;

procedure TProjManForm.Label27Click(Sender: TObject);
begin
  EditNavigator.Enabled := True;
  EditNavigator.DataSource := ProjManDataSource;
  Editing := 'Editing: Project management';
  ProjManTablePROJ_NR.FocusControl;
end;

procedure TProjManForm.EditPROJ_NRClick(Sender: TObject);
begin
  EditNavigator.Enabled := True;
  EditNavigator.DataSource := ProjManDataSource;
  Editing := 'Editing: Project management';
end;

procedure TProjManForm.GotoBookmarkClick(Sender: TObject);
begin
  ProjManTable.GotoBookmark(Bookmark);
end;

procedure TProjManForm.SetBookmarkClick(Sender: TObject);
begin
  ProjManTable.FreeBookmark(Bookmark);
  Bookmark := ProjManTable.GetBookmark;
end;

procedure TProjManForm.CutMenuClick(Sender: TObject);
begin
  if ActiveControl is TDBEdit then
    TDBEdit(ActiveControl).CutToClipboard
  else
  if ActiveControl is TDBGrid then
    {TDBGrid(ActiveControl).CutToClipboard;}
end;

procedure TProjManForm.CopyMenuClick(Sender: TObject);
begin
  if ActiveControl is TDBEdit then
    TDBEdit(ActiveControl).CopyToClipboard
  else
  if ActiveControl is TDBGrid then
    {TDBGrid(ActiveControl).CopyToClipboard;}
end;

procedure TProjManForm.PasteMenuClick(Sender: TObject);
begin
  if ActiveControl is TDBEdit then
    TDBEdit(ActiveControl).PasteFromClipboard
  else
  if ActiveControl is TDBGrid then
    {TDBGrid(ActiveControl).PasteFromClipboard;}
end;

procedure TProjManForm.PopupMenu1Popup(Sender: TObject);
var
  HasSelection: Boolean;
begin
  if Assigned(BookMark) then GotoBookmark.Enabled := True
  else GotoBookmark.Enabled := False;
  HasSelection := False;
  if ActiveControl is TDBEdit then
    HasSelection := TDBEdit(ActiveControl).SelLength <> 0
  else
  if ActiveControl is TDBGrid then
    HasSelection := False;
  CutMenu.Enabled := HasSelection;
  CopyMenu.Enabled := HasSelection;
  PasteMenu.Enabled := Clipboard.HasFormat(CF_TEXT);
end;

procedure TProjManForm.DBGridColEnter(Sender: TObject);
begin
end;

procedure TProjManForm.DBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) then
  begin
    if (Key = VK_F8) then LinkedTable.Edit;
  end
  else
  case Key of
    VK_F5: LinkedTable.Refresh;
    VK_F8: LinkedTable.Post;
  end; {of case}
end;

procedure TProjManForm.ProjManTableNewRecord(DataSet: TDataset);
begin
  ProjManTableDATE_START.Value := FormatDateTime('YYYYMMDD', Date);
  ProjManTableDATE_END.Value := FormatDateTime('YYYYMMDD', Date);
  ProjManTableDATE_ENTRY.Value := FormatDateTime('YYYYMMDD', Date);
  ProjManTablePROJ_NR.FocusControl;
end;

procedure TProjManForm.ProjManTableDATE_STARTValidate(Sender: TField);
begin
  if not ValidDate(ProjManTableDATE_START.Value) then
  begin
    MessageDlg('Invalid date entered!', mtError, [mbOK], 0);
    ProjManTableDATE_START.FocusControl;
  end;
  if (ProjManTableDATE_END.Value <> '') then
  if (ProjManTableDATE_START.Value > ProjManTableDATE_END.Value) then
  begin
    MessageDlg('Date started must be before date ended!', mtError, [mbOK], 0);
    ProjManTableDATE_START.FocusControl;
  end;
end;

procedure TProjManForm.ProjManTableDATE_ENDValidate(Sender: TField);
begin
  if not ValidDate(ProjManTableDATE_END.Value) then
  begin
    MessageDlg('Invalid date entered!', mtError, [mbOK], 0);
    ProjManTableDATE_END.FocusControl;
  end;
  if ProjManTableDATE_END.Value < ProjManTableDATE_START.Value then
  begin
    MessageDlg('Date ended must be after date started!', mtError, [mbOK], 0);
    ProjManTableDATE_END.FocusControl;
  end;
end;

procedure TProjManForm.ProjManTableDATE_VERIFValidate(Sender: TField);
begin
  if not ValidDate(ProjManTableDATE_VERIF.Value) then
  begin
    MessageDlg('Invalid date entered!', mtError, [mbOK], 0);
    ProjManTableDATE_VERIF.FocusControl;
  end;
  if (ProjManTableDATE_VERIF.Value < ProjManTableDATE_START.Value) or
    (ProjManTableDATE_VERIF.Value > ProjManTableDATE_END.Value) then
  begin
    MessageDlg('Date verified must be after date started and before date ended!',
      mtError, [mbOK], 0);
    ProjManTableDATE_VERIF.FocusControl;
  end;
end;

procedure TProjManForm.LinkedTableSetText(Sender: TField;
  const aText: String);
begin
  Sender.AsString := UpperCase(aText);
end;

procedure TProjManForm.LinkedTableREC_DEPTHSetText(Sender: TField;
  const aText: String);
begin
  if aText <> '' then
    LinkedTableREC_DEPTH.Value := StrToFloat(aText)/LengthFactor;
end;

procedure TProjManForm.LinkedTableREC_DEPTHGetText(Sender: TField;
  var aText: String; DisplayText: Boolean);
begin
  if LinkedTableREC_DEPTH.Value <> 0 then
  begin
    if LinkedTableREC_DEPTH.Value * LengthFactor > 100 then
      aText := FloatToStrF(LinkedTableREC_DEPTH.Value * LengthFactor, ffFixed, 15, 0)
    else
    if LinkedTableREC_DEPTH.Value * LengthFactor < 0.01 then
      aText := FloatToStrF(LinkedTableREC_DEPTH.Value * LengthFactor, ffFixed, 15, 5)
    else
      aText := FloatToStrF(LinkedTableREC_DEPTH.Value * LengthFactor, ffFixed, 15, 2);
  end;
end;

procedure TProjManForm.LinkedDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  if LinkedTableSITE_ID_NR.Value <> '' then
    CurrentSite := LinkedTableSITE_ID_NR.Value;
  if LinkedTableTRAV_NR.Value <> '' then
    CurrentTraverse := LinkedTableTRAV_NR.Value;
end;

procedure TProjManForm.CurrentComboBoxChange(Sender: TObject);
begin
  case CurrentComboBox.ItemIndex of
    0: begin
         FindTable.Close;
         FindTable.IndexFieldNames := 'SITE_ID_NR';
         FindTable.Open;
         if FindTable.Locate('SITE_ID_NR', CurrentSite, []) then
           ProjManTable.Locate('PRO_REF_NR', FindTablePRO_REF_NR.AsString, [])
         else MessageDlg('No project found for current site!', mtInformation, [mbOK], 0);
         FindTable.Close;
       end;
    1: begin
         FindTable.Close;
         FindTable.IndexFieldNames := 'TRAV_NR';
         FindTable.Open;
         if FindTable.Locate('TRAV_NR', CurrentTraverse, []) then
           ProjManTable.Locate('PRO_REF_NR', FindTablePRO_REF_NR.AsString, [])
         else MessageDlg('No project found for current traverse!', mtInformation, [mbOK], 0);
         FindTable.Close;
       end;
    2: begin
         FindTable.Close;
         if not ProjManTable.Locate('PRO_REF_NR', CurrentProject, []) then
           MessageDlg('No project found for current traverse!', mtInformation, [mbOK], 0);
       end;
  end; //of case
end;

procedure TProjManForm.GroupBox1Click(Sender: TObject);
begin
  EditNavigator.Enabled := True;
  EditNavigator.DataSource := ProjManDataSource;
  Editing := 'Editing: Project management';
  EditPROJ_NR.SetFocus;
end;

procedure TProjManForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ssCtrl in Shift then
  case Key of
    78: ProjManTable.Next;
    80: ProjManTable.Prior;
    VK_F8: ProjManTable.Edit;
  end {of case}
  else
  if not (ActiveControl is TDBGrid) then
  case Key of
    VK_F5: ProjManTable.Refresh;
    VK_F8: if ProjManTable.State IN [dsInsert, dsEdit] then
             ProjManTable.Post;
    27: if ProjManTable.State IN [dsInsert, dsEdit] then
          ProjManTable.Cancel;
  end; {of case}
end;

procedure TProjManForm.SiteTableBeforeOpen(DataSet: TDataSet);
begin
  SiteTable.Connection := DataModuleMain.ZConnectionDB;
end;

procedure TProjManForm.LinkedTableSITE_ID_NRValidate(Sender: TField);
begin
  if Sender.AsString <> '' then
  begin
    SiteTable.Open;
    if SiteTable.Locate('SITE_ID_NR', Sender.AsString, []) then
    else
    begin
      MessageDlg('Invalid site identifier entered!', mtError, [mbOK], 0);
    end;
    SiteTable.Close;
  end;  
end;

procedure TProjManForm.CloseBitBtnClick(Sender: TObject);
begin
  close;
end;

end.
