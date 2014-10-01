unit FormVisor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SynEdit, Forms, Controls, Graphics, Dialogs,
  SynFacilUtils, SynFacilHighlighter, LCLType, Menus;

type

  { TfrmVisor }

  TfrmVisor = class(TForm)
    edVis: TSynEdit;
    MainMenu1: TMainMenu;
    procedure edVisKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edVisKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    f: TForm; //referencia al padre
  public
    procedure mostrar(arc: string; pad: TForm);  //muestra un archivo
  end;

var
  frmVisor: TfrmVisor;

implementation
var
  Sintaxis: TSynFacilSyn;

{$R *.lfm}

{ TfrmVisor }

procedure TfrmVisor.edVisKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Key = VK_ESCAPE then Self.Hide;   //se oculta
  IF (key = VK_TAB) and (Shift = [ssCtrl]) then
    if f<> nil then f.SetFocus;  //cambia enfoque
//  IF (key = VK_E) and (Shift = [ssCtrl]) then
//    edVis.SelectAll;
end;

procedure TfrmVisor.edVisKeyPress(Sender: TObject; var Key: char);
begin

end;

procedure TfrmVisor.FormCreate(Sender: TObject);
begin
  InicEditorC1(edVis);   //configura editor
  Sintaxis := TSynFacilSyn.Create(Self);
  edVis.Highlighter:=Sintaxis;   //asigna sintaxis

end;

procedure TfrmVisor.FormDestroy(Sender: TObject);
begin
  edVis.Highlighter := nil;  //quita objeto sintaxis
  Sintaxis.Destroy;     //libera objeto

end;

procedure TfrmVisor.mostrar(arc: string; pad: TForm);
var arc8: string;
  a: TLineEnd;
  b: string;
begin
  f := pad;  //toma referencia al padre
  arc8 := SysToUTF8(arc);
  Caption := 'VISOR DE TEXTO - ' + arc8;  //pone titulo
  CargarArchivoLin(arc8,edVis.Lines,a,b);  //carga viendo la codificación
//  edVis.Lines.LoadFromFile(arc8);
  Show;
end;

end.

