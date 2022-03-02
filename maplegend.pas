unit maplegend;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons;

type

  { TLegendForm }

  TLegendForm = class(TForm)
    BitBtn1: TBitBtn;
    LabelOther: TLabel;
    LabelTheme: TLabel;
    LabelTop: TLabel;
    LabelMid: TLabel;
    LabelBot: TLabel;
    ShapeOther: TShape;
    ShapeTop: TShape;
    ShapeMid: TShape;
    ShapeBot: TShape;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  LegendForm: TLegendForm;

implementation

{$R *.lfm}

uses VARINIT, MainDataModule;

{ TLegendForm }

procedure TLegendForm.FormCreate(Sender: TObject);
begin
  DataModuleMain.SetComponentFontAndSize(Sender, True);
end;

procedure TLegendForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

end.

