program Aquabase;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}
  clocale,
  {$ENDIF}
  Forms, Interfaces, controls, uScaleDPI,
  BASICINF in 'BASICINF.PAS' {BasicinfForm},
  VARINIT in 'VARINIT.PAS',
  SQLSEACH in 'SQLSEACH.PAS' {SQLSearchForm},
  NEWSITE in 'NEWSITE.PAS' {NewSiteForm},
  TIMEDEPT in 'TIMEDEPT.PAS' {TimeDeptForm},
  QUICKSCH in 'QUICKSCH.PAS' {QuickSearchForm},
  SELSITES in 'SELSITES.PAS' {SelectSitesDlg},
  INSTALLA in 'INSTALLA.PAS' {InstallForm},
  LOOKUP in 'LOOKUP.PAS' {LookupForm},
  PMPIMPRT in 'PMPIMPRT.PAS' {PmpimprtForm},
  FILTER in 'FILTER.PAS' {FilterForm},
  PROJ_MAN in 'PROJ_MAN.PAS' {ProjManForm},
  StrDATETIME in 'StrDATETIME.PAS',
  //Aquabase_TLB in 'Aquabase_TLB.pas',
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
  DistanceDepSettings in 'DistanceDepSettings.pas' {DistanceDepSettingsForm},
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
  EditFillColour,
  editcolours;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Scaled:=True;
  Application.Initialize;
  //Application.Title := 'Aquabase Twenty20';
  Screen.Cursor := crAppStart;
  SplashForm := TSplashForm.Create(Application);
  try
    SplashForm.Show;
    Application.CreateForm(TMainform, Mainform);
    while not SplashForm.Completed do
      Application.ProcessMessages;
    SplashForm.Hide;
  finally
    SplashForm.Free;
  end;
  Screen.Cursor := crDefault;
  HighDPI(96);
  Application.Run;
end.
