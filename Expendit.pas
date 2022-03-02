unit Expendit;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LCLtype, MastDetl, Db,
  Menus, DBCtrls, ExtCtrls, Buttons, StdCtrls;

type

  { TExpenditureForm }

  TExpenditureForm = class(TMasterDetailForm)
    LinkedQueryCOMMENT: TStringField;
    LinkedQueryCOSTCODE: TStringField;
    LinkedQueryDATE_COMPL: TStringField;
    LinkedQueryDATE_INV: TStringField;
    LinkedQueryINVOICE_NR: TStringField;
    LinkedQueryINV_AMOUNT: TFloatField;
    LinkedQueryI_CURRENCY: TStringField;
    LinkedQueryORDER_NR: TStringField;
    LinkedQueryPAID: TStringField;
    LinkedQuerySERV_PROV: TStringField;
    LinkedQueryTYPE_SERV: TStringField;
    procedure FormActivate(Sender: TObject);
    procedure LinkedQueryDATEValidate(Sender: TField);
    procedure LinkedQueryNewRecord(DataSet: TDataSet);
    procedure LinkedQueryPAIDValidate(Sender: TField);
    procedure LinkedQueryValidate(Sender: TField);
    procedure LinkedQueryUpperSetText(Sender: TField; const aText: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ExpenditureForm: TExpenditureForm;

implementation

uses strdatetime, VARINIT, MainDataModule;

{$R *.lfm}

procedure TExpenditureForm.FormActivate(Sender: TObject);
begin
  inherited;
  LinkedLabel.Caption := Caption;
end;

procedure TExpenditureForm.LinkedQueryDATEValidate(Sender: TField);
begin
  ValidFound := not Sender.IsNull and ValidDate(Sender.Value);
end;

procedure TExpenditureForm.LinkedQueryNewRecord(DataSet: TDataSet);
begin
  inherited;
  LinkedQueryDATE_COMPL.Value := FormatDateTime('YYYYMMDD', Date);
  LinkedQueryDATE_INV.Value := FormatDateTime('YYYYMMDD', Date);
end;

procedure TExpenditureForm.LinkedQueryPAIDValidate(Sender: TField);
begin
  if (Sender.AsString = 'T') or (Sender.AsString = 'F') then
    ValidFound := True
  else
    ValidFound := False;
end;

procedure TExpenditureForm.LinkedQueryValidate(Sender: TField);
begin
  ValidFound := DataModuleMain.LookupValidFound(Sender.LookupKeyFields, Sender.AsString);
end;

procedure TExpenditureForm.LinkedQueryUpperSetText(Sender: TField;
  const aText: string);
begin
  Sender.Value := UpperCase(aText);
end;

end.
