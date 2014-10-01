unit FrameCfgGen;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls, Globales,
 ConfigFrame;

type

  { TframeConfigGen }

  TframeConfigGen = class(TFrame)
    chkGuarAntes: TCheckBox;
    RadioGroup1: TRadioGroup;
  private
    { private declarations }
  public
    GuarAntes: boolean;
    procedure Iniciar(secINI0: string);
  end;

implementation
{$R *.lfm}

procedure TframeConfigGen.Iniciar(secINI0: string);
begin
  secINI := secINI0;  //sección INI
  //asocia propiedades a controles
  Asoc_Bol_TChkB(@GuarAntes, chkGuarAntes, 'GuarAntes', false);
end;


end.

