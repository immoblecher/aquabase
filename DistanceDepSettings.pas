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
  at <http://www.gnu.org/copyleft/gpl.html>. You can also obtain it by writing
  to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
  MA 02111-1307, USA.
}
unit DistanceDepSettings;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Spin, ButtonPanel, ZDataset;

type

  { TDistanceDepSettingsForm }

  TDistanceDepSettingsForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpacingQuery: TZReadOnlyQuery;
    procedure CheckBox1Click(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MethIndex: Byte;
    TravNr: ShortString;
  end;

var
  DistanceDepSettingsForm: TDistanceDepSettingsForm;

implementation

uses VARINIT, distchart, MainDataModule;

{$R *.lfm}

procedure TDistanceDepSettingsForm.CheckBox1Click(Sender: TObject);
begin
  SpinEdit1.Enabled := not CheckBox1.Checked;
  SpinEdit2.Enabled := not CheckBox1.Checked;
  Label2.Enabled := not CheckBox1.Checked;
  Label3.Enabled := not CheckBox1.Checked;
end;

procedure TDistanceDepSettingsForm.OKButtonClick(Sender: TObject);
begin
  with TDistChartForm.Create(Application) do
  begin
    with QueryXY1.SQL do
    begin
      Clear;
      case MethIndex of
        0: begin
             Add('SELECT TRAV_NR, STATION, READING as THEVALUE FROM grndmagn WHERE TRAV_NR = ' + QuotedStr(TravNr));
             ChartTop.Title.Text.Clear;
             ChartTop.Title.Text.Add('Magnetics profile');
             ChartTop.LeftAxis.Title.Caption := 'Magnetics [nT]';
           end;
        1: begin
             Add('SELECT TRAV_NR, STATION, VERT_READ as THEVALUE, HOR_READ as THEVALUE2, SPACING FROM grndem34 WHERE TRAV_NR = ' + QuotedStr(TravNr));
             ChartTop.Title.Text.Clear;
             ChartTop.Title.Text.Add('EM34 Conductivity profile');
             ChartTop.LeftAxis.Title.Caption := 'Conductivity [mS/m]';
             Spacing1 := 0;
             Spacing2 := 0;
             Value1 := 'Vert.';
             Value2 := 'Horiz.';
             with SpacingQuery do
             begin
               Connection := DataModuleMain.ZConnectionDB;
               SQL.Clear;
               SQL.Add('SELECT DISTINCT SPACING FROM grndem34 WHERE TRAV_NR = ' + QuotedStr(TravNr) + ' LIMIT 2');
               Open;
               Spacing1 := FieldByName('SPACING').Value;
               if RecordCount = 2 then
               begin
                 Next;
                 Spacing2 := FieldByName('SPACING').Value;
               end;
             end;
           end;
        2: begin
             Add('SELECT TRAV_NR, STATION, READING as THEVALUE, SPACING FROM grndgeni WHERE TRAV_NR = ' + QuotedStr(TravNr));
             ChartTop.Title.Text.Clear;
             ChartTop.Title.Text.Add('Genie EM profile');
             ChartTop.LeftAxis.Title.Caption := 'EM';
             Spacing1 := 0;
             Spacing2 := 0;
             Value1 := 'Spacing 1';
             Value2 := 'Spacing 2';
             with SpacingQuery do
             begin
               Connection := DataModuleMain.ZConnectionDB;
               SQL.Clear;
               SQL.Add('SELECT DISTINCT SPACING FROM grndgeni WHERE TRAV_NR = ' + QuotedStr(TravNr) + ' LIMIT 2');
               Open;
               Spacing1 := FieldByName('SPACING').Value;
               if RecordCount = 2 then
               begin
                 Next;
                 Spacing2 := FieldByName('SPACING').Value;
               end;
             end;
           end;
        3: begin
             Add('SELECT TRAV_NR, STATION, READING as THEVALUE FROM grndresi WHERE TRAV_NR = ' + QuotedStr(TravNr));
             ChartTop.Title.Text.Clear;
             ChartTop.Title.Text.Add('Resistivity profile');
             ChartTop.LeftAxis.Title.Caption := 'Apparent res. [Ohm-m]';
           end;
        4: begin
             Add('SELECT TRAV_NR, STATION, IN_PHASE as THEVALUE, OUT_PHASE as THEVALUE2, UNFILTERED as THEVALUE3 FROM grndvlfr WHERE TRAV_NR = ' + QuotedStr(TravNr));
             ChartTop.Title.Text.Clear;
             ChartTop.Title.Text.Add('Very-Low-Frequency Electromagnetic profile');
             ChartTop.LeftAxis.Title.Caption := 'VLF-EM [%]';
             Value1 := 'In Phase';
             Value2 := 'Out Phase';
             Value3 := 'Unfiltered';
           end;
        5: begin
             Add('SELECT TRAV_NR, STATION, READING as THEVALUE FROM grndgrav WHERE TRAV_NR = ' + QuotedStr(TravNr));
             ChartTop.Title.Text.Clear;
             ChartTop.Title.Text.Add('Gravity profile');
             ChartTop.LeftAxis.Title.Caption := 'Gravity [m/s²]';
           end;
        end; //of case
      if not CheckBox1.Checked then
        Add('AND STATION >= ' + IntToStr(SpinEdit1.Value) + ' AND STATION <= ' + IntToStr(SpinEdit2.Value));
      end;
    Show;
  end;
end;

end.
