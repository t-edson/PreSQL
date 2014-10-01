{Unidad con formulario de configuración para manejar las propiedades de
 una aplicación. Está pensado para usarse con componentes o frames, que
 usen su propio frame de configuración}
unit FormConfig;

{$mode objfpc}{$H+}

interface

uses
  Classes, Forms, StdCtrls, ComCtrls, SynEdit, Dialogs, Buttons,
  FrameCfgGen, FrameCfgEdit, FrameCfgConOra, MisUtils,
  ConfigFrame;

type

  TEvCambiaProp = procedure of object;  //evento para indicar que hay cambio

  { TConfig }

  TConfig = class(TForm)
    bitAceptar: TBitBtn;
    bitAplicar: TBitBtn;
    bitCancel: TBitBtn;

    lstCateg: TListBox;
    procedure bitAceptarClick(Sender: TObject);
    procedure bitAplicarClick(Sender: TObject);
    procedure bitCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lstCategClick(Sender: TObject);
  private
    procedure LeerDeVentana;
    procedure MostEnVentana;
    { private declarations }
  public

    msjError : string;
    fraError: TFrame;
    arIni    : String;      //Archivo de configuración
    edSQL     : TSynEdit;    //referencia al editor SynEdit
    edVSe     : TSynEdit;    //referencia a la ventana de sesion
    edVTe     : TSynEdit;    //referencia al visor de texto
    //frames de configuración
    fcGeneral : TframeConfigGen;
    fcEditSQL : TfcEdit;
    fcVentSes : TfcEdit;
    fcVisText : TfcEdit;
    fcConOra: TfraCfgConOra;

    //configuración del entorno
    VerBarHer   : boolean;
    VerBarEst   : boolean;
    VerPanArc   : boolean;
    VerPanBD    : boolean;
    VerVenSes   : Boolean;
    AltVenSes   : integer;  //altura de la ventana de sesión
    procedure Iniciar(PanControl0: TStatusPanel);
    procedure leerArchivoIni;
    procedure escribirArchivoIni;
    function ConexActual: TConOra;
    procedure SetLanguage(lang: string);
  end;

var
  Config: TConfig;

implementation

{$R *.lfm}

{ TConfig }

procedure TConfig.FormCreate(Sender: TObject);
begin
  fcGeneral:= TframeConfigGen.Create(self);
  fcGeneral.Parent:=self;

  fcEditSQL:= TfcEdit.Create(self);
  fcEditSQL.Parent:=self;
  fcEditSQL.Name:='e1';   //para que puedan convivir
  fcVentSes:= TfcEdit.Create(self);
  fcVentSes.Parent:=self;
  fcVentSes.Name:='e2';  //para que puedan convivir
  fcVisText:= TfcEdit.Create(self);
  fcVisText.Parent:=self;
  fcVisText.Name:='e3';  //para que puedan convivir

  fcConOra:= TfraCfgConOra.Create(self);
  fcConOra.Parent:=self;

  arIni := GetIniName;
  //selecciona primera opción
  lstCateg.ItemIndex:=0;
  lstCategClick(Self);
end;
procedure TConfig.FormDestroy(Sender: TObject);
begin
  Free_AllConfigFrames(self);  //Libera los frames de configuración
end;
procedure TConfig.FormShow(Sender: TObject);
begin
  MostEnVentana;   //carga las propiedades en el frame
end;

procedure TConfig.Iniciar(PanControl0: TStatusPanel);
//Inicia el formulario de configuración. Debe llamarse antes de usar el formulario y
//después de haber cargado todos los frames.
begin
  fcGeneral.Iniciar('General');
  //asocia desde aquí a estas variables para que se accedan fácilmente
  fcGeneral.Asoc_Bol(@VerBarHer,'VerBarHer',false);
  fcGeneral.Asoc_Bol(@VerBarEst,'VerBarEst',false);
  fcGeneral.Asoc_Bol(@VerPanArc,'VerPanArc',false);
  fcGeneral.Asoc_Bol(@VerPanBD ,'VerPanBD',false);
  fcGeneral.Asoc_Bol(@VerVenSes,'VerVenSes',false);
  fcGeneral.Asoc_Int(@AltVenSes,'AltVenSes',200);

  fcEditSQL.Iniciar('Edit1',edSQL);
  fcVentSes.Iniciar('Edit2',edVSe);
  fcVisText.Iniciar('Edit3',edVTe);
  fcConOra.Iniciar('ConOra', PanControl0);

  //configura evento
  leerArchivoIni;  //lee parámetros del archivo de configuración.
end;

procedure TConfig.lstCategClick(Sender: TObject);
begin
  Hide_AllConfigFrames(self);   //oculta todos
  if lstCateg.ItemIndex = 0 then fcGeneral.ShowPos(115,0);
  if lstCateg.ItemIndex = 1 then fcEditSQL.ShowPos(115,0);
  if lstCateg.ItemIndex = 2 then fcVentSes.ShowPos(115,0);
  if lstCateg.ItemIndex = 3 then fcVisText.ShowPos(115,0);
  if lstCateg.ItemIndex = 4 then fcConOra.ShowPos(115,0);
end;

procedure TConfig.bitAceptarClick(Sender: TObject);
begin
  bitAplicarClick(Self);
  self.Hide;
end;
procedure TConfig.bitAplicarClick(Sender: TObject);
begin
  LeerDeVentana;       //Escribe propiedades de los frames
  if fraError<>nil then begin
    showmessage(fraError.MsjErr);
    exit;
  end;
  escribirArchivoIni;   //guarda propiedades en disco
end;
procedure TConfig.bitCancelClick(Sender: TObject);
begin
  self.Hide;
end;

procedure TConfig.LeerDeVentana;
//Lee las propiedades de la ventana de configuración.
begin
  fraError := WindowToProp_AllFrames(self);
end;
procedure TConfig.MostEnVentana;
//Muestra las propiedades en la ventana de configuración.
begin
  fraError := PropToWindow_AllFrames(self);
end;
procedure TConfig.leerArchivoIni;
//Lee el archivo de configuración
begin
  msjError := ReadFileToProp_AllFrames(self, arINI);
end;
procedure TConfig.escribirArchivoIni;
//Escribe el archivo de configuración
begin
  msjError := SavePropToFile_AllFrames(self, arINI);
end;
function TConfig.ConexActual: TConOra;  //devuelve la conexión actual
begin
  Result := fcConOra.ConexActual;
end;

procedure TConfig.SetLanguage(lang: string);
//Rutina de traducción
begin
  fcConOra.SetLanguage(lang);
  fcEditSQL.SetLanguage(lang);
  fcVentSes.SetLanguage(lang);
  fcVisText.SetLanguage(lang);
  case lowerCase(lang) of
  'es': begin
      lstCateg.Items.Clear;
      lstCateg.Items.Add('General');
      lstCateg.Items.Add('Editor');
      lstCateg.Items.Add('Vent. de Sesión');
      lstCateg.Items.Add('Visor de Texto');
      lstCateg.Items.Add('Conexiones');
    end;
  'en': begin
      lstCateg.Items.Clear;
      lstCateg.Items.Add('General');
      lstCateg.Items.Add('Editor');
      lstCateg.Items.Add('Sesion Window');
      lstCateg.Items.Add('Text Visor');
      lstCateg.Items.Add('Connections');
    end;
  end;
end;

end.

