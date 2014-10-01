program PreSQL;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Globales, FormConfig,
  FrameCfgGen, FormPrincipal, uprebasicos, upreproces,
  lazcontrols, FrameArcExplor, FormVisor, FormSelFuente;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TPrincipal, Principal);
  Application.CreateForm(TConfig, Config);
  Application.CreateForm(TfrmVisor, frmVisor);
  Application.CreateForm(TfrmSelFuente, frmSelFuente);
  Application.Run;
end.

