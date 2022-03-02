{ Copyright (C) 2020 Immo Blecher immo@blecher.co.za

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
unit editchartdata;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, LCLType,
  ButtonPanel, ExtCtrls, Grids, XMLPropStorage, Menus;

type

  { TEditChartDataForm }

  TEditChartDataForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    PopupMenu1: TPopupMenu;
    StringGrid1: TStringGrid;
    XMLPropStorage1: TXMLPropStorage;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure StringGrid1BeforeSelection(Sender: TObject; aCol, aRow: Integer);
    procedure StringGrid1DblClick(Sender: TObject);
  private
    RowIdx: Integer;
  public

  end;

var
  EditChartDataForm: TEditChartDataForm;

implementation

{$R *.lfm}

uses MainDataModule;

{ TEditChartDataForm }

procedure TEditChartDataForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, True);
end;

procedure TEditChartDataForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TEditChartDataForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton)
  else
  if Key = VK_F2 then
    StringGrid1.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goDrawFocusSelected,goColSizing,goEditing,goTabs,goDblClickAutoSize,goSmoothScroll,goFixedRowNumbering,goFixedColSizing];
end;

procedure TEditChartDataForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = VK_DELETE) then
    MenuItem1Click(Sender);
end;

procedure TEditChartDataForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TEditChartDataForm.MenuItem1Click(Sender: TObject);
begin
  if StringGrid1.SelectedRangeCount > 0 then
    if MessageDlg('Are you sure you want to delete the current row?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      StringGrid1.DeleteRow(RowIdx);
    end;
end;

procedure TEditChartDataForm.MenuItem2Click(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TEditChartDataForm.StringGrid1BeforeSelection(Sender: TObject; aCol,
  aRow: Integer);
begin
  if aRow <> RowIdx then //a new row selected
    StringGrid1.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goDrawFocusSelected,goColSizing,goTabs,goDblClickAutoSize,goSmoothScroll,goFixedRowNumbering,goFixedColSizing];
  RowIdx := aRow;
end;

procedure TEditChartDataForm.StringGrid1DblClick(Sender: TObject);
begin
  StringGrid1.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goDrawFocusSelected,goColSizing,goEditing,goTabs,goDblClickAutoSize,goSmoothScroll,goFixedRowNumbering,goFixedColSizing];
end;

end.

