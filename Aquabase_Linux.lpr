program Aquabase_Linux;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  { you can add units after this }
  clocale,
  controls, FrameViewer09, sdflaz, memdslaz,
  Filter in 'Filter.pas' {FilterForm},
  chemchartsettings {ChemSettingsForm},
  Sysset in 'Sysset.pas' {SysSetDlgForm},
  Instrmnt in 'Instrmnt.pas' {InstrumentForm},
  MastDetl in 'MastDetl.pas' {MasterDetailForm},
  Aquifer in 'Aquifer.pas' {AquiferForm},
  Comments in 'Comments.pas' {CommentsForm},
  Referenc in 'Referenc.pas' {ReferencesForm},
  Discharg in 'Discharg.pas' {DischargeForm},
  Expendit in 'Expendit.pas' {ExpenditureForm},
  Fldmeas in 'Fldmeas.pas' {FldMeasForm},
  Meteread in 'Meteread.pas' {MeterReadingForm},
  Othrhole in 'Othrhole.pas' {OtherHoleForm},
  Otherdat in 'Otherdat.pas' {OtherDataForm},
  Searchst in 'Searchst.pas' {SearchStatusForm},
  Specases in 'Specases.pas' {SpecCasesForm},
  Geology in 'Geology.pas' {GeologyForm},
  Notepad in 'Notepad.pas' {NotepadForm},
  holefinish in 'holefinish.pas' {HoleConstForm},
  Profilng in 'Profilng.pas' {ProfilingForm},
  GeollogSetForm in 'GeollogSetForm.pas' {GeollogSettings},
  Penetrat in 'Penetrat.pas' {PenetrationForm},
  Waterlev in 'Waterlev.pas' {WaterlevelForm},
  Pumptest in 'Pumptest.pas' {PumpTestForm},
  Sitesele in 'Sitesele.pas' {SiteSelectionForm},
  Nameownr in 'Nameownr.pas' {NameOwnerForm},
  Sitevisi in 'Sitevisi.pas' {SiteVisitorForm},
  Otherid in 'Otherid.pas' {OtherIDForm},
  Watersam in 'Watersam.pas' {WaterSampleForm},
  Instdetl in 'Instdetl.pas' {AddinstallForm},
  Maintain in 'Maintain.pas' {MaintainForm},
  Member in 'Member.pas' {MemberForm},
  Testdetl in 'Testdetl.pas' {TestDetlForm},
  Recommnd in 'Recommnd.pas' {RecommendForm},
  ChemRadial in 'ChemRadial.pas' {ChemRadialForm},
  PieChem in 'PieChem.pas' {PieForm},
  Stagehi in 'Stagehi.pas' {StageHiForm},
  TabDetl in 'TabDetl.pas' {TabbedMastDetailForm},
  BHConstr in 'BHConstr.pas' {BHConstrForm},
  Stream in 'Stream.pas' {StreamForm},
  NewWSpace in 'NewWSpace.pas' {NewWSpaceForm},
  Main in 'Main.pas' {te},
  Chemistry in 'Chemistry.pas' {ChemistryForm},
  Userchem in 'Userchem.pas' {UserChemistryForm},
  DeptSet in 'DeptSet.pas' {DeptSetForm},
  Meteor1 in 'Meteor1.pas' {MeteorologyForm1},
  Meteor2 in 'Meteor2.pas' {MeteorologyForm2},
  GWProp in 'GWProp.pas' {GWPropertiesForm},
  Selparameter in 'Selparameter.pas' {ParamSelectionForm},
  SQLForm in 'SQLForm.pas' {SQLQueryForm},
  BHProp in 'BHProp.pas' {BhPropertiesForm},
  Geoelectric in 'Geoelectric.pas' {GeoElectricForm},
  RadioAct in 'RadioAct.pas' {RadioActiveForm},
  Magnetic in 'Magnetic.pas' {MagneticSusForm},
  SearchSites in 'SearchSites.pas' {SearchSitesForm},
  SiteImages in 'SiteImages.pas' {SiteImageForm},
  Targets in 'Targets.pas' {TargetsForm},
  ExpDewater in 'ExpDewater.pas' {ExpDewaterForm},
  Splash in 'Splash.pas',
  Editform in 'Editform.pas' {EditLookupForm},
  chemcharts {TChemChartsForm},
  EditFillColour, uscaledpi, editcolours, help, stiffdiagram, boxwhisker,
  importwms, boxsettings, loggerimport, importchem, lithprofile,
  lithprofilesettings, surfacewaterreport, repsettingssurfwatr, crsinfo, mapview,
  graduatedmap, repsettingstimechem, reporttemplatelandscape,
  TimeDeptChemReport, repsettingstimewl, timedeptwlreport, editchartdata,
  addrefline, repsettingstimedepth, repsettingssitemon, sitemonitorreport,
  repsettingsmeteor, flagrecords, importrain, importSYNOP, importdwsaudited;

{$R *.res}

{$IFDEF WINDOWS}
  {$R *.TLB}
{$ENDIF}

begin
  Application.Scaled:=True;
  RequireDerivedFormResource := True;
  Application.Initialize;
  Screen.Cursor := crAppStart;
  SplashForm := TSplashForm.Create(Application);
  try
    SplashForm.Show;
    while not SplashForm.Completed do
      Application.ProcessMessages;
    SplashForm.Hide;
  finally
    SplashForm.Free;
  end;
  Screen.Cursor := crDefault;
  HighDPI(96);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
