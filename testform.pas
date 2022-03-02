unit testform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DBGrids, DbCtrls, MaskEdit, Buttons, Menus, XMLPropStorage,
  rxlookup, ZDataset, ZConnection, MastDetl, db;

type

  { TTestMastDetlForm }

  TTestMastDetlForm = class(TMasterDetailForm)
    LinkedQueryAQUI_CODE: TStringField;
    LinkedQueryAQUI_TYPE: TMemoField;
    LinkedQueryCOMMENT: TStringField;
    LinkedQueryDATE_ENTRY: TStringField;
    LinkedQueryDEPTH_BOT: TFloatField;
    LinkedQueryDEPTH_TOP: TFloatField;
    LinkedQueryINFO_SOURC: TStringField;
    LinkedQueryMETH_MEAS: TMemoField;
    LinkedQueryREP_INST: TStringField;
    LinkedQueryYIELD: TFloatField;
    procedure LinkedQueryBeforeOpen(DataSet: TDataSet);
  private

  public

  end;

var
  TestMastDetlForm: TTestMastDetlForm;

implementation

{$R *.lfm}

uses varinit;

{ TTestMastDetlForm }

procedure TTestMastDetlForm.LinkedQueryBeforeOpen(DataSet: TDataSet);
begin
  LinkedQuery.SQL.Clear;
  LinkedQuery.SQL.Add('SELECT * FROM aquifer_ WHERE SITE_ID_NR = ' + QuotedStr(CurrentSite));
end;

end.

