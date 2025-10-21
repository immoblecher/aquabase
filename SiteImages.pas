{ Copyright (C) 2025 Immo Blecher immo@blecher.co.za

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
unit SiteImages;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, DBCtrls, DBGrids,
  Buttons, ExtCtrls, ExtDlgs, XMLPropStorage, Db, ZDataset, LCLType, Types;

type

  { TSiteImageForm }

  TSiteImageForm = class(TForm)
    DataSourceBasicinf: TDataSource;
    DBFilterNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    DBImage1: TDBImage;
    Panel1: TPanel;
    DBFilterNavigator: TDBNavigator;
    CloseBitBtn: TBitBtn;
    HelpButton: TBitBtn;
    DataSource1: TDataSource;
    OpenPictureDialog1: TOpenPictureDialog;
    Panel2: TPanel;
    SavePictureDialog1: TSavePictureDialog;
    SpeedButtonLoad: TSpeedButton;
    SpeedButtonSave: TSpeedButton;
    Splitter1: TSplitter;
    XMLPropStorage1: TXMLPropStorage;
    ZQuery1: TZQuery;
    ZQuery1DATE_CREAT: TStringField;
    ZQuery1IMG_DESCRI: TStringField;
    ZQuery1SITE_ID_NR: TStringField;
    ZQuery1SITE_IMAGE: TBlobField;
    ZQuery1TIME_CREAT: TStringField;
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure DataSourceBasicinfDataChange(Sender: TObject; Field: TField);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBGridColExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButtonLoadClick(Sender: TObject);
    procedure SpeedButtonSaveClick(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    procedure SiteImageTableNewRecord(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure ZQuery1AfterPost(DataSet: TDataSet);
    procedure ZQuery1DATE_CREATValidate(Sender: TField);
    procedure ZQuery1TIME_CREATValidate(Sender: TField);
    procedure ZQuery1IMG_DESCRISetText(Sender: TField; const aText: String);
    procedure CloseBitBtnClick(Sender: TObject);
    procedure ZQuery1BeforeOpen(DataSet: TDataSet);
    procedure ZQuery1NewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    ValidFound: Boolean;
    CamMake, CamModel: ShortString;
  public
    { Public declarations }
  end;

var
  SiteImageForm: TSiteImageForm;

implementation

{$R *.lfm}

uses VARINIT, strdatetime, dGlobal, dMetadata, maindatamodule;

procedure TSiteImageForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  ZQuery1.Close;
  CloseAction := caFree;
end;

procedure TSiteImageForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(HelpButton);
end;

procedure TSiteImageForm.DataSourceBasicinfDataChange(Sender: TObject; Field: TField);
begin
  CurrentSite := DataModuleMain.BasicinfQuerySITE_ID_NR.Value;
  if Showing then
  try
    Screen.Cursor := crSQLWait;
    ZQuery1.Close;
    ZQuery1.Open;
    Screen.Cursor := crDefault;
  except on E: Exception do
    begin
      Screen.Cursor := crDefault;
      MessageDlg(E.Message + ' - Could not open linked table! Maybe close and open the form again.', mtError, [mbOK], 0);
    end;
  end
end;

procedure TSiteImageForm.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_DELETE: if ZQuery1.State IN [dsInsert, dsEdit] then
                  if ssShift in Shift then
                    DBGrid1.SelectedField.Clear;
    VK_F5: ZQuery1.Refresh;
    VK_F8: if (ssCtrl in Shift) then
             ZQuery1.Edit
           else
           if ZQuery1.State IN [dsInsert, dsEdit] then
             ZQuery1.Post;
    end; {of CASE}
end;

procedure TSiteImageForm.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  DataSource1.AutoEdit := AutoEditData and (ZQuery1.RecordCount > 0);
end;

procedure TSiteImageForm.DBGridColExit(Sender: TObject);
begin
  if DBGrid1.Focused and (not ValidFound) then
  begin
    if Pos('DATE', DBGrid1.SelectedField.FieldName) > 0 then
      MessageDlg('Invalid date entered!', mtError, [mbOK], 0)
    else
    if Pos('TIME', DBGrid1.SelectedField.FieldName) > 0 then
      MessageDlg('Invalid time entered!', mtError, [mbOK], 0);
    ValidFound := True;
    Abort;
  end;
end;

procedure TSiteImageForm.SpeedButtonLoadClick(Sender: TObject);
var
  ImgData: TImgData;
  PicDateTime, PicDate, PicTime: ShortString;
begin
  PicDateTime := '';
  PicDate := '';
  PicTime := '';
  CamMake := '';
  CamModel := '';
  with OpenPictureDialog1 do
  begin
    InitialDir := WSpaceDir;
    Filter :=
    'All image files (*.bmp,*.jpg,*.png,*.gif,*.tiff,*.tif)|*.bmp;*.jpg;*.jpeg;*.png;*.gif;*.tiff;*.tif;*.BMP;*.JPG;*.JPEG;*.PNG;*.GIF;*.TIFF;*>TIF|' +
    'BMP files (*.bmp)|*.bmp;*.BMP|' +
    'JPEG files (*.jpg)|*.jpg;*.jpeg;*.JPG;*.JPEG|' +
    'PNG files (*.png)|*.png;*.PNG|' +
    'GIF files (*.gif)|*.gif;*.GIF' +
    'TIFF files (*.tiff)|*.tiff;*.tif;*.TIFF;*.TIF';
    if Execute then
    begin
      if ZQuery1.State IN [dsInsert, dsEdit] then
      begin
        DbImage1.WriteHeader := False;
        DbImage1.Picture.LoadFromFile(FileName);
        ImgData:= TImgData.Create();
        try
          if ImgData.ProcessFile(FileName) then
          begin
            if ImgData.HasEXIF then
            begin
              CamMake := ImgData.ExifObj.CameraMake;
              CamModel := ImgData.ExifObj.CameraModel;
              PicDateTime := FormatDateTime(ISO_DATETIME_FORMAT, ImgData.ExifObj.GetImgDateTime);
              if PicDateTime > '' then
              begin
                PicDate := Copy(PicDateTime, 1, 4) + Copy(PicDateTime, 6, 2) + Copy(PicDateTime, 9, 2);
                PicTime :=  Copy(PicDateTime, 12, 2) + Copy(PicDateTime, 15, 2);
                if ValidDate(Picdate) and ValidTime(PicTime) then
                if MessageDlg('The image you are inserting has valid EXIF Camera and Date/Time information. Do you want to use it for Date and Time created and part of the Description?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
                begin
                  ZQuery1DATE_CREAT.Value := PicDate;
                  ZQuery1TIME_CREAT.Value := PicTime;
                end;
              end;
            end
            else
            begin
              CamMake := '';
              CamModel := '';
              PicDateTime := '';
              PicDate := '';
              PicTime := '';
            end;
          end;
        finally
          ImgData.Free;
        end;
      end
      else
        MessageDlg('Images can only be inserted in edit or insert mode!', mtError, [mbOK], 0)
    end;
  end;
end;

procedure TSiteImageForm.SpeedButtonSaveClick(Sender: TObject);
begin
  SavePictureDialog1.Filter :=
    'All image files (*.bmp,*.jpg,*.png,*.gif,*.tiff,*.tif)|*.bmp;*.jpg;*.jpeg;*.png;*.gif;*.tiff;*.tif;*.BMP;*.JPG;*.JPEG;*.PNG;*.GIF;*.TIFF;*>TIF|' +
    'BMP files (*.bmp)|*.bmp;*.BMP|' +
    'JPEG files (*.jpg)|*.jpg;*.jpeg;*.JPG;*.JPEG|' +
    'PNG files (*.png)|*.png;*.PNG|' +
    'GIF files (*.gif)|*.gif;*.GIF' +
    'TIFF files (*.tiff)|*.tiff;*.tif;*.TIFF;*.TIF';
  if SavePictureDialog1.Execute then
    DBImage1.Picture.SaveToFile(SavePictureDialog1.FileName);
end;

procedure TSiteImageForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TSiteImageForm.SiteImageTableNewRecord(DataSet: TDataSet);
begin
  ZQuery1DATE_CREAT.AsString := FormatDateTime('YYYYMMDD', Date);
  ZQuery1TIME_CREAT.AsString := FormatDateTime('hhnn', Time);
end;

procedure TSiteImageForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage1.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
  DataModuleMain.SetComponentFontAndSize(Sender, False);
  ValidFound := True;
  ZQuery1.Open;
  DataSource1.AutoEdit := AutoEditData;
  DoubleBuffered := True;
end;

procedure TSiteImageForm.ZQuery1AfterPost(DataSet: TDataSet);
begin
  CamMake := '';
  CamModel := '';
end;

procedure TSiteImageForm.ZQuery1DATE_CREATValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TSiteImageForm.ZQuery1TIME_CREATValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidTime(Sender.Value);
end;

procedure TSiteImageForm.ZQuery1IMG_DESCRISetText(Sender: TField;
  const aText: String);
var
  Camera: ShortString;
begin
 Camera := '';
 if CamMake > '' then
    Camera := CamMake;
  if CamModel > '' then
    Camera := Camera + ' ' + CamModel;
  if Camera > '' then
    Sender.AsString := UpperCase(aText + ' (Taken with ' + Camera + ')')
  else
    Sender.AsString := UpperCase(aText);
end;

procedure TSiteImageForm.CloseBitBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TSiteImageForm.ZQuery1BeforeOpen(DataSet: TDataSet);
begin
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('SELECT * FROM basicimg WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
end;

procedure TSiteImageForm.ZQuery1NewRecord(DataSet: TDataSet);
begin
  ZQuery1SITE_ID_NR.Value := CurrentSite;
  ZQuery1DATE_CREAT.Value := FormatDateTime('YYYYMMDD', Date);
  ZQuery1TIME_CREAT.Value := FormatDateTime('hhnn', Time);
  ZQuery1DATE_CREAT.FocusControl;
end;

end.
