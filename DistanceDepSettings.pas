unit DistanceDepSettings;

{$MODE Delphi}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Spin;

type
  TDistanceDepSettingsForm = class(TForm)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    CheckBox1: TCheckBox;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    procedure OKBtnClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MethIndex: Byte;
  end;

var
  DistanceDepSettingsForm: TDistanceDepSettingsForm;

implementation

uses varinit;

{$R *.lfm}

procedure TDistanceDepSettingsForm.OKBtnClick(Sender: TObject);
begin

end;

procedure TDistanceDepSettingsForm.CheckBox1Click(Sender: TObject);
begin
  SpinEdit1.Enabled := not CheckBox1.Checked;
  SpinEdit2.Enabled := not CheckBox1.Checked;
  Label2.Enabled := not CheckBox1.Checked;
  Label3.Enabled := not CheckBox1.Checked;
end;

end.
