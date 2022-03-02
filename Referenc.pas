unit Referenc;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLtype, MastDetl,
  DBCtrls, Db, Menus, ExtCtrls, Buttons, StdCtrls, DBGrids, MaskEdit;

type

  { TReferencesForm }

  TReferencesForm = class(TMasterDetailForm)
    DBMemo: TDBMemo;
    DBMemo1: TDBMemo;
    LinkedQueryNOTE_PAD: TBlobField;
    LinkedQueryREP_INST: TStringField;
    LinkedTableNOTE_PAD: TMemoField;
    LinkedTableREP_INST: TStringField;
    procedure LinkedQueryREP_INSTSetText(Sender: TField; const aText: string);
    procedure LinkedQueryREP_INSTValidate(Sender: TField);
    procedure DBMemoEnter(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReferencesForm: TReferencesForm;

implementation

uses Varinit, MainDataModule;

{$R *.lfm}


procedure TReferencesForm.LinkedQueryREP_INSTSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

procedure TReferencesForm.LinkedQueryREP_INSTValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound('REP_INST', Sender.AsString);
end;

procedure TReferencesForm.DBMemoEnter(Sender: TObject);
begin
  inherited;
  Editing := 'Editing: References';
end;

procedure TReferencesForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption;
end;

end.
