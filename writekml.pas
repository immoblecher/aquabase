{ Copyright (C) 2021 Immo Blecher, immo@blecher.co.za

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
unit writekml;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ButtonPanel, ExtCtrls, DbCtrls, ZDataset, laz2_DOM, laz2_XMLWrite, db, LCLType;

type

  { TWriteKMLForm }

  TWriteKMLForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ButtonPanel1: TButtonPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    ComboBoxType: TComboBox;
    ViewComboBox: TComboBox;
    DefinitionQuery: TZReadOnlyQuery;
    Label2: TLabel;
    LabeledEditSQLFile: TLabeledEdit;
    LabeledEditLayerName: TLabeledEdit;
    LabeledEditFile: TLabeledEdit;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ViewQuery: TZReadOnlyQuery;
    DataQuery: TZReadOnlyQuery;
    TypeQuery: TZReadOnlyQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure ComboBoxTypeChange(Sender: TObject);
    procedure DataQueryBeforeOpen(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure LabeledEditFileChange(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { private declarations }
    SiteType: ShortString;
  public
    { public declarations }
  end;

var
  WriteKMLForm: TWriteKMLForm;

implementation

{$R *.lfm}

uses MaindataModule, varinit;

{ TWriteKMLForm }

procedure TWriteKMLForm.FormCreate(Sender: TObject);
var
  TheViews: TStringList;
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
  //add all valid views to ComboBox
  TheViews := TStringList.Create;
  DataModuleMain.GetAllViews(DataModuleMain.ZConnectionDB, TheViews);
  ViewComboBox.Items.Assign(TheViews);
  TheViews.Free;
  ViewComboBox.ItemIndex := ViewComboBox.Items.IndexOf('allsites');
  //set site type to borehole as default
  TypeQuery.Open;
  while not TypeQuery.EOF do
  begin
    ComboBoxType.Items.Add(TypeQuery.FieldByName('DESCRIBE').AsString);
    TypeQuery.Next;
  end;
  ComboBoxType.ItemIndex := ComboBoxType.Items.IndexOf('Borehole');
  SiteType := 'B';
end;

procedure TWriteKMLForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    HelpButtonClick(ButtonPanel1.HelpButton);
end;

procedure TWriteKMLForm.HelpButtonClick(Sender: TObject);
begin
  DataModuleMain.OpenHelp(Sender);
end;

procedure TWriteKMLForm.LabeledEditFileChange(Sender: TObject);
begin
  ButtonPanel1.OKButton.Enabled := LabeledEditFile.Text > '';
end;

procedure TWriteKMLForm.OKButtonClick(Sender: TObject);
var
  Doc: TXMLDocument;                                  // variable to document
  RootNode, docNode, folderNode,
    {styleNode, iconstyleNode, iconNode,}
    placemarkNode, childNode, textNode, coordNode: TDOMNode;            // variable to nodes
  f: Integer;
  Description: String;
  WriteKMLFile: Boolean;
begin
  //check if sql file is used and it exists
  if CheckBox2.Checked then
  begin
    if FileExists(LabeledEditSQLFile.Caption) then
      WriteKMLFile := True
    else
    begin
      WriteKMLFile := False;
      MessageDlg('The SQL query file specified does not exist! Please try again.', mtError, [mbOK], 0);
    end;
  end
  else
    WriteKMLFile := True;
  if WriteKMLFile then
  begin
    Screen.Cursor := crSQLWait;
    DataQuery.Open;
    if DataQuery.RecordCount > 1000 then
    begin
      Screen.Cursor := crDefault;
      if MessageDlg('Your KML file would contain more than 1000 sites which might exceed the Google MyMaps limit (no problem for Google Earth)! Do you want to cancel and try again with a new selection?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        WriteKMLFile := False;
      end;
    end;
  end;
  if WriteKMLFile then
  begin
    try
      // Create a document
      Doc := TXMLDocument.Create;

      // Create a root node
      RootNode := Doc.CreateElement('kml');
      TDOMElement(RootNode).SetAttribute('xmlns', 'http://www.opengis.net/kml/2.2');       // create atributes to parent node
      Doc.Appendchild(RootNode);                        // save root node

      // Create a Document parent node
      RootNode := Doc.DocumentElement;
      docNode := Doc.CreateElement('Document');
      TDOMElement(docNode).SetAttribute('id',  'root_doc');  // create atributes to parent node
      RootNode.Appendchild(docNode);                         // save parent node

      {// Create a Style child node
      styleNode := Doc.CreateElement('Style');
      TDOMElement(styleNode).SetAttribute('id',  'icon_point');
      iconstyleNode := Doc.CreateElement('IconStyle');
      TDOMElement(iconstyleNode).SetAttribute('id',  'mystyle');
      iconNode := Doc.CreateElement('Icon');
      childNode := Doc.CreateElement('href');
      textNode := Doc.CreateTextNode('http://www.gstatic.com/mapspro/images/stock/503-wht-blank_maps.png');
      childNode.AppendChild(textNode);
      iconNode.AppendChild(childNode);
      childNode := Doc.CreateElement('Scale');
      textNode := Doc.CreateTextNode('1.0');
      childNode.AppendChild(textNode);
      iconNode.AppendChild(childNode);
      iconstyleNode.AppendChild(iconNode);
      styleNode.AppendChild(iconstyleNode);
      docNode.AppendChild(styleNode);}

      // Create a Folder child node
      folderNode := Doc.CreateElement('Folder');
      childNode := Doc.CreateElement('name');
      textNode := Doc.CreateTextNode(LabeledEditLayername.Text);
      childNode.AppendChild(textNode);
      folderNode.AppendChild(childNode);
      docNode.AppendChild(folderNode);

      // Create Placemarks child nodes
      with DataQuery do
      while not EOF do
      begin
        placemarkNode := Doc.CreateElement('Placemark');
        childNode := Doc.CreateElement('name');
        textNode := Doc.CreateTextNode(Fields[0].AsString);
        childNode.AppendChild(textNode);
        placemarkNode.AppendChild(childNode);

        Description := '';
        for f := 3 to FieldCount - 1 do
        begin
          if (not Fields[f].IsNull) and (Fields[f].AsString > '') then
          begin
            Description := Description + Fields[f].FieldName + ': ' + Fields[f].AsString;
            if f < FieldCount - 1 then Description := Description + '&#13;&#10;';
          end;
        end;
        childNode := Doc.CreateElement('description');
        textNode := Doc.CreateTextNode(Description);
        childNode.AppendChild(textNode);
        placemarkNode.AppendChild(childNode);

        childNode := Doc.CreateElement('styleUrl');
        textNode := Doc.CreateTextNode('#icon_point');
        childNode.AppendChild(textNode);
        placemarkNode.AppendChild(childNode);

        childNode := Doc.CreateElement('Point');
        coordNode := Doc.CreateElement('coordinates');
        textNode := Doc.CreateTextNode(Fields[1].AsString + ', ' + Fields[2].AsString);
        coordNode.AppendChild(textNode);
        childNode.AppendChild(coordNode);
        placemarkNode.AppendChild(childNode);

        folderNode.AppendChild(placemarkNode);
        Next;
      end;
      docNode.AppendChild(folderNode);

      WriteXMLFile(Doc, LabeledEditFile.Text);           // write to XML
    finally
      Screen.Cursor := crDefault;
      ShowMessage('Finished writing ' + IntToStr(DataQuery.RecordCount) + ' placemarks to ' +
        LabeledEditFile.Text + '.');
      DataQuery.Close;
      Doc.Free;                                          // free memory
    end;
  end;
end;

procedure TWriteKMLForm.Button1Click(Sender: TObject);
begin
  SaveDialog1.InitialDir := WSpaceDir;
  if SaveDialog1.Execute then
  begin
    LabeledEditFile.Text := SaveDialog1.FileName;
  end;
end;

procedure TWriteKMLForm.Button2Click(Sender: TObject);
begin
  OpenDialog1.InitialDir := WSpaceDir;
  if OpenDialog1.Execute then
  begin
    LabeledEditSQLFile.Text := OpenDialog1.FileName;
  end;
end;

procedure TWriteKMLForm.CheckBox1Click(Sender: TObject);
begin
  if TCheckBox(Sender).Checked then
  begin
    ViewComboBox.Enabled := True;
    ComboBoxType.Enabled := True;
    CheckBox2.Checked := False;
    Button2.Enabled := False;
    LabeledEditSQLFile.Enabled := False;
  end
  else
  begin
    ViewComboBox.Enabled := False;
    ComboBoxType.Enabled := False;
    CheckBox2.Checked := True;
    Button2.Enabled := True;
    LabeledEditSQLFile.Enabled := True;
  end;
end;

procedure TWriteKMLForm.CheckBox2Click(Sender: TObject);
begin
  if TCheckBox(Sender).Checked then
  begin
    ViewComboBox.Enabled := False;
    ComboBoxType.Enabled := False;
    CheckBox1.Checked := False;
    Button2.Enabled := True;
    LabeledEditSQLFile.Enabled := True;
  end
  else
  begin
    ViewComboBox.Enabled := True;
    ComboBoxType.Enabled := True;
    CheckBox1.Checked := True;
    Button2.Enabled := False;
    LabeledEditSQLFile.Enabled := False;
  end;
end;

procedure TWriteKMLForm.ComboBoxTypeChange(Sender: TObject);
begin
  LabeledEditLayerName.Text := ComboBoxType.Text;
  TypeQuery.Locate('DESCRIBE', ComboBoxType.Text, []);
  SiteType := TypeQuery.FieldByName('SEARCH').AsString;
end;

procedure TWriteKMLForm.DataQueryBeforeOpen(DataSet: TDataSet);
begin
  if CheckBox1.Checked then //use pre-filled query
  begin
    with DataQuery do
    begin
      SQL.Add('WHERE basicinf.SITE_ID_NR IN (SELECT SITE_ID_NR FROM ' + ViewComboBox.Text + ')');
      SQL.Add('AND basicinf.SITE_TYPE = ' + QuotedStr(SiteType));
      SQL.Add('GROUP BY basicinf.SITE_ID_NR');
    end;
  end
  else //use the sql file
  begin
    with DataQuery do
    begin
      SQL.Clear;
      SQL.LoadFromFile(LabeledEditSQLFile.Caption);
    end;
  end;
end;

procedure TWriteKMLForm.FormClose(Sender: TObject; var CloseAction: TCloseAction  );
begin
  TypeQuery.Close;
  CloseAction := caFree;
end;

end.

