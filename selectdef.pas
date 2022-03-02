unit selectdef;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ButtonPanel,
  StdCtrls, ZDataset;

type

  { TSelectDefForm }

  TSelectDefForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    ZReadOnlyQuery1: TZReadOnlyQuery;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  SelectDefForm: TSelectDefForm;

implementation

{$R *.lfm}

{ TSelectDefForm }

procedure TSelectDefForm.FormCreate(Sender: TObject);
begin
  with ZReadOnlyQuery1 do
  begin
    Open;
    while not EOF do
    begin
      ComboBox1.Items.Add(FieldByName('DESCRIPTION').AsString);
      Next;
    end;
    Close
  end;
  ComboBox1.ItemIndex := 0;
end;

procedure TSelectDefForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

end.

