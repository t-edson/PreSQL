unit FormPrincipal;
{$mode objfpc}{$H+}
interface
uses
  Classes, Windows, SysUtils, FileUtil, SynEdit, Forms, Controls, Graphics,
  Dialogs, Menus, ComCtrls, ExtCtrls, ActnList, SynEditTypes, lclproc,
  LCLType, StdActns, FormVisor, UnTerminal, SQLPlusConsole, SqlPlusHighlighter,
  Globales, MisUtils, FormConfig, uPreBasicos, uPreProces, FormSelFuente,
  SynEditMiscClasses, strutils, SynFacilUtils, FrameArcExplor;
type
  { TPrincipal }
  TPrincipal = class(TForm)
  published
    acBusBuscar: TAction;
    acBusBusSig: TAction;
    acBusRem: TAction;
    acPArcNueCon: TAction;
    acPArcNueCar: TAction;
    acPArcNueEnc: TAction;
    acPArcElim: TAction;
    acPArcRefres: TAction;
    acPArcAbrir: TAction;
    acPArcAbrNue: TAction;
    acPArcCamNom: TAction;
    acHerTabEsp: TAction;
    acHerFilLin: TAction;
    acHerQuiEsp: TAction;
    acHerConec: TAction;
    acHerDescon: TAction;
    acVerVenSes: TAction;
    acVerPanelBD: TAction;
    acVerBarHer: TAction;
    acVerPanArc: TAction;
    FindDialog1: TFindDialog;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    mnLenguajes: TMenuItem;
    mnVerVenSes: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    mnVerBarHer: TMenuItem;
    MenuItem31: TMenuItem;
    mnRecientes: TMenuItem;
    PopupMenu2: TPopupMenu;
    ReplaceDialog1: TReplaceDialog;
    edSal: TSynEdit;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton2: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    acVerBarEst1: TAction;
    acEdSelecAll: TAction;
    acEdUndo: TAction;
    acEdModCol: TAction;
    acEdRedo: TAction;
    acArcSalir: TAction;
    acArcGuaCom: TAction;
    acArcGuardar: TAction;
    acArcAbrir: TAction;
    acArcNueVent: TAction;
    acHerConfig: TAction;
    acHerProcCons: TAction;
    acHerProcesar: TAction;
    acArcNuevo: TAction;
    ActionList1: TActionList;
    acEdCopy: TEditCopy;
    acEdCut: TEditCut;
    acEdPaste: TEditPaste;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    mnBuscar: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    mnNuevaVen: TMenuItem;
    mnArCod: TMenuItem;
    mnForMAC: TMenuItem;
    mnForDOS: TMenuItem;
    mnForUNIX: TMenuItem;
    mnArConv: TMenuItem;
    mnForDescon: TMenuItem;
    mnArGuarC: TMenuItem;
    mnNuevo: TMenuItem;
    mnHerram: TMenuItem;
    mnEdSelTod: TMenuItem;
    mnEdModCol: TMenuItem;
    mnEdCop: TMenuItem;
    mnEdCor: TMenuItem;
    mnEdPeg: TMenuItem;
    mnVerPanDB: TMenuItem;
    mnVerPanArc: TMenuItem;
    mnVerBarEst: TMenuItem;
    mnArGuar: TMenuItem;
    mnEdDeshac: TMenuItem;
    mnEdRehac: TMenuItem;
    mnEdicion: TMenuItem;
    mnArSalir: TMenuItem;
    mnArAbrir: TMenuItem;
    mnArchivo: TMenuItem;
    mnVer: TMenuItem;
    OpenDialog1: TOpenDialog;
    edSQL: TSynEdit;
    PopupMenu1: TPopupMenu;
    SaveDialog1: TSaveDialog;
    Splitter1: TSplitter;
    StatusBar1: TStatusBar;
    procedure acBusRemExecute(Sender: TObject);
    procedure acHerConecExecute(Sender: TObject);
    procedure acHerDesconExecute(Sender: TObject);
    procedure acHerFilLinExecute(Sender: TObject);
    procedure acHerTabEspExecute(Sender: TObject);
    procedure acVerBarHerExecute(Sender: TObject);
    procedure acVerVenSesExecute(Sender: TObject);
    procedure eArchivoCargado;
    procedure eCambiaEstArchivo;

    procedure acEdCopyExecute(Sender: TObject);
    procedure acEdCutExecute(Sender: TObject);
    procedure acEdPasteExecute(Sender: TObject);
    procedure editChangeFileInform;
    procedure edKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edSalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edSpecialLineMarkup(Sender: TObject; Line: integer;
      var Special: boolean; Markup: TSynSelectedColor);
    procedure ExplorArchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure frmArcExplor1AbrirArc(nod: TExplorNode);
    procedure frmArcExplor1RightClickFile(nod: TExplorNode);
    procedure frmArcExplor1RightClickFolder(nod: TExplorNode);
    procedure MarcarError(nLin, nCol: integer);
    procedure FindDialog1Find(Sender: TObject);
    //Acciones de Archivo
    procedure acArcNuevoExecute(Sender: TObject);
    procedure acArcNueVentExecute(Sender: TObject);
    procedure acArcAbrirExecute(Sender: TObject);
    procedure acArcGuaComExecute(Sender: TObject);
    procedure acArcGuardarExecute(Sender: TObject);
    procedure acArcSalirExecute(Sender: TObject);
    procedure mnConfigClick(Sender: TObject);
    //Acciones de edición
    procedure mnEdDeshacClick(Sender: TObject);
    procedure mnEdRehacClick(Sender: TObject);
    procedure mnEdSelTodClick(Sender: TObject);
    procedure mnEdModColClick(Sender: TObject);
    //Acciones de búsqueda
    procedure acBusBuscarExecute(Sender: TObject);
    procedure mnRecientesClick(Sender: TObject);

    //Acciones de visualización
    procedure acVeBarEstClick(Sender: TObject);
    procedure acVePanArcClick(Sender: TObject);
    procedure acVerPanBDClick(Sender: TObject);

    procedure mnHerProcClick(Sender: TObject);
    procedure mnHerProConClick(Sender: TObject);
    procedure ReplaceDialog1Find(Sender: TObject);
    procedure ReplaceDialog1Replace(Sender: TObject);
    procedure Splitter3Moved(Sender: TObject);
    procedure sqlCon_ChangeState(info: string; pIni: TPoint);
    procedure sqlCon_ErrorConx;
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormDropFiles(Sender: TObject; const FileNames: array of String);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    edit      : TSynFacilEditor;  //editor principal
    hlSal     : TSQLplusHighligh;
    { private declarations }
    NombNodEdi: String;    //nombre actual de nodo en edición
    sqlCon: TSQLPlusCon;       //conexión a Oracle
    procedure ConfiguraEntorno;
    function ePreProcesar(var usu: String): Boolean;
    procedure eConsultar(arcsql: String; usu: string);
    //Funciones para cambiar el entrono
    procedure MostrarBarHer(visibilidad: boolean);
    procedure MostrarBarEst(visibilidad: boolean);
    procedure MostrarPanArc(visibilidad: boolean);
    procedure MostrarPanBD(visibilidad: boolean);
    procedure MostrarVenSes(visibilidad: boolean);
    procedure PreparaEditor;
    procedure VerificarError;
  public
    ExplorArch: TfrmArcExplor;
    procedure SetLanguage(lang: string);
  end;

var
  Principal: TPrincipal;

implementation
{$R *.lfm}

{ TPrincipal }
procedure TPrincipal.frmArcExplor1AbrirArc(nod: TExplorNode);  //abre archivo
begin
  if edit.SaveQuery then Exit;   //Verifica cambios
  edit.LoadFile(nod.Path);  //debería ser en UTF-8
end;

procedure TPrincipal.frmArcExplor1RightClickFile(nod: TExplorNode);
begin
//  msgbox('frmArcExplor1RightClickFile');
end;
procedure TPrincipal.frmArcExplor1RightClickFolder(nod: TExplorNode);
begin
//  msgbox('frmArcExplor1RightClickFolder')
end;

procedure TPrincipal.FormCreate(Sender: TObject);
begin
  TranslateMsgs:=true;   //activa la traducción
  ExplorArch := TfrmArcExplor.Create(self);  //crea explorador de archivos
  ExplorArch.Parent := self;
  hlSal  := TSQLplusHighligh.Create(self);   //crea resaltador
  edit := TSynFacilEditor.Create(edSQL,'SinNombre','psql');  //Crea objeto Editor
  MostrarError:= True;   //por defecto
  //Las variables globales se inician en el INIT de Principal
  archivoSal := '';   //inicia archivo de salida
  //Configura explorador de archivos
  ExplorArch.OnDoubleClickFile:=@frmArcExplor1AbrirArc;
  ExplorArch.OnKeyEnterOnFile:=@frmArcExplor1AbrirArc;
  ExplorArch.OnMenuOpenFile:=@frmArcExplor1AbrirArc;
  ExplorArch.OnRightClickFolder:=@frmArcExplor1RightClickFolder;
  ExplorArch.OnRightClickFile:=@frmArcExplor1RightClickFile;
  ExplorArch.InternalPopupFolder:=true;
  ExplorArch.InternalPopupFile:=true;
  ExplorArch.Filter.Items.Add('*.sql,*.psql,*.pdef,*.txt');
  ExplorArch.Filter.Items.Add('*.psql,*.pdef');
  ExplorArch.Filter.Items.Add('*.txt');
  ExplorArch.Filter.Items.Add('*');
  ExplorArch.Filter.ItemIndex:=0;
  ExplorArch.OnKeyDown:=@ExplorArchKeyDown;

  //Alineamiento
  ExplorArch.Align:=alLeft;
  Splitter1.Align:=alLeft;
  edSal.Align:=alBottom;
  edSal.Highlighter := hlSal;
  Splitter3.Align:=alBottom;
  edSQL.Align:=alClient; //alínea
  //configura conexión a Oracle
  sqlCon := TSQLPlusCon.Create;  //Crea conexión
  sqlCon.OnChangeState:=@sqlCon_ChangeState;
  sqlCon.OnErrorConx:=@sqlCon_ErrorConx;
end;
procedure TPrincipal.FormShow(Sender: TObject);
var p1: integer;
    tmp, usu: String;
begin
  SetLanguage('en');
  edit.SetLanguage('en');
  ExplorArch.SetLanguage('en');
  Config.SetLanguage('en');
  frmSelFuente.SetLanguage('en');
  StatusBar1.PopupMenu := Config.fcConOra.mnConex;  //menú contextual
  //Crea la sintaxis, antes de leer INI para que lea los colores
  edit.InitMenuLanguages(mnLenguajes, ExtractFilePath(Application.ExeName)+'lenguajes');
  edit.LoadSyntaxFromPath;
  //aquí ya sabemos que Config está creado. Lo configuramos
  Config.edSQL := edSQL;   //pasa referencia de editor.
  Config.edVSe := edSal;   //pasa referencia de editor.
  Config.edVTe := frmVisor.edVis;    //pasa referencia de editor.
  Config.Iniciar(StatusBar1.Panels[0]);
  sqlCon.Init(StatusBar1.Panels[1], edSal, Config.fcConOra);
  edit.InitMenuRecents(mnRecientes, Config.fcEditSQL.ArcRecientes);
  edit.InitMenuLineEnding(mnArConv);
  edit.InitMenuEncoding(mnArCod);
  //Ve si se ejecutó por línea de comandos
  if ParamCount = 0 then begin
    //No hay línea de comandos
    PreparaEditor;
    //Inicia con archivo nuevo
//    mnNuevoClick(nil);
  end else begin
     //hay parámetros
     if LeerParametros then self.Close;
     If Prepro Then begin    //Verifica si se debe preprocesar
        PreProcesar(archivoEnt, '', archivoSal, usu);   //Preprocesamiento
        If PErr.HayError Then begin
           //Sólo se deja el entorno para ver el error
           PreparaEditor;  //Tal vez debería hacerse antes
           VerificarError;
        end Else begin   //Seguimos con la ejecución
          If EjecOracle Then eConsultar(archivoSal, usu);
          If Not PErr.HayError Then Self.Close;  //sale normalmente
        End;
     end Else begin   //Sólo se carga en el editor
         PreparaEditor;
         If archivoEnt <> '' Then begin
            edit.LoadFile(SysToUTF8(archivoEnt));
         End;
     End;
  end;
  //ve si hay mensaje a mostrar
  if MsjeIni='' then exit;
  //Hay mensaje, lo muestra
  if MsjeIni[1] = '(' then begin  //mensaje con posición
     p1:= Pos(',',MsjeIni);
     if p1 = 0 then exit;  //error
     tmp := copy(MsjeIni,2,p1-2);
     MarcarError(StrToInt(tmp),1);  //marca error
  end;
  MsgExc(MsjeIni);
end;
procedure TPrincipal.FormDestroy(Sender: TObject);
begin
  hlSal.Destroy;
  sqlCon.Free;
  edSQL.Highlighter := nil;  //quita objeto sintaxis
  edit.Free;   //libera
  ExplorArch.Destroy;
end;

procedure TPrincipal.PreparaEditor;
//Configura el editor para empezar a trabajar
begin
  edit.OnChangeFileInform:=@editChangeFileInform;
  edit.OnChangeEditorState:=@eCambiaEstArchivo;
  edit.OnFileOpened:=@eArchivoCargado;
  edit.OnKeyDown:=@edKeyDown;  //evento
  edit.OnKeyUp:=@edKeyUp;      //evento

  edit.PanCursorPos := StatusBar1.Panels[2];
  edit.PanForEndLin := StatusBar1.Panels[4];
  edit.PanCodifFile := StatusBar1.Panels[5];
  InicEditorC1(edSQL);   //configura editor

  ConfiguraEntorno;     //cambia entorno con variables globales
  //Inicia menú contextual

  edSQL.OnSpecialLineMarkup:=@edSpecialLineMarkup;

  //configura editor de salida
  InicEditorC1(edSal);   //configura editor

  editChangeFileInform;  //actualiz encabezado
  eArchivoCargado;  //ubica el archivo actual
end;
procedure TPrincipal.eCambiaEstArchivo;
begin
  acArcGuardar.Enabled:=edit.Modified;
  acEdUndo.Enabled:=edit.CanUndo;
  acEdRedo.Enabled:=edit.CanRedo;
  acEdPaste.Enabled:=edit.CanPaste;
end;
function TPrincipal.ePreProcesar(var usu: String): Boolean;
//Lanza un preprocesamiento verificando si hay selección. Si se canceló, devuelve TRUE
//Actualiza la variable "usu", con la cadena de conexión usada en la consulta o la
//conexión actual de la configuración.
begin
  archivoSal := '';
  If edSQL.SelAvail Then begin
     frmSelFuente.optSel.Checked := true;
     frmSelFuente.optLin.Enabled := false;
     frmSelFuente.ShowModal;
     If frmSelFuente.cancelado Then begin  //se canceló
        Result := True;
        Exit;
     End;
     If frmSelFuente.optTod.Checked Then begin  //todo
        PreProcesar(edit.NomArc, '', archivoSal, usu);   //preprocesa
        VerificarError;
     end Else begin   //solo la selección
        PreProcesar(edit.NomArc, edSQL.SelText, archivoSal, usu);
        VerificarError;
     End;
     frmSelFuente.Close;     //Para no gastar memoria
  end Else begin    //Preprocesa directamente
      PreProcesar(edit.NomArc, '', archivoSal, usu);   //preprocesa
      VerificarError;
  End;
  Result := false;
End;
procedure TPrincipal.eConsultar(arcsql: String; usu: string);
//Lanza una consulta a la base de datos administrando los mensajes de error.
//Utiliza la cadena de conexión indicada.
var CamSqlDef : String;
    tmp : String;
begin
  If usu = '' Then begin   //no se indicó cadena de conexión
     usu := Config.ConexActual.Params;  //lee cadena de conexión
     //lee la ruta del sqlplus u otro aplicativo
     CamSqlDef := Config.ConexActual.RutSql;
  end else begin  //se indicó una cadena de conexión
    //usu :=
    //Se toma la ruta de la conexión actual
//    CamSqlDef := Config.ConexActual.RutSql;
    if CamSqlDef = '' then CamSqlDef := 'sqlplus';  //la última opción es esta.
  end;
  //validaciones
  if usu = '' then begin
    MsgErr('No se ha especificado cadena de conexión.'#13#10 +
         'Definir en la ventana de configuración o en el inicio del archivo.');
    exit;
  end;
  If CamSqlDef = '' Then begin
    MsgErr('No se ha especificado ruta del SQLPLUS.');
    exit;
  end;
  try
    tmp := CamSqlDef + ' ' + usu + ' @"' + arcsql + '"';
//    LanzarSQL(tmp);
    if sqlCon.state = ECO_STOPPED then begin  //está desconectado
//      sqlCon.InicConexion(CamSqlDef, usu);
      sqlCon.Open;
    end else begin
      //ya está conectado
      sqlCon.SendSQL(StringFromFile(arcsql) );
    end;
  except
    MsgErr('Error ejecutando SQLPLUS en ruta: ' + CamSqlDef);
  end;
End;
procedure TPrincipal.ConfiguraEntorno;
//Configura el entorno (IDE) usando variables globales
begin
  //Inicia visibilidad de paneles. Estas son propiedades del entrono, no de un editor en particular
  MostrarBarHer(Config.VerBarHer);
  MostrarBarEst(Config.VerBarEst);
  MostrarPanArc(Config.VerPanArc);
  MostrarPanBD(Config.VerPanBD);
  MostrarVenSes(Config.VerVenSes);
end;

procedure TPrincipal.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if edit.SaveQuery then
    CanClose := false;   //cancela
end;
procedure TPrincipal.FormDropFiles(Sender: TObject; const FileNames: array of String);
begin
   //Carga archivo arrastrados
  if edit.SaveQuery then Exit;   //Verifica cambios
  edit.LoadFile(FileNames[0]);
end;
procedure TPrincipal.MarcarError(nLin, nCol: integer);
begin
  //posiciona curosr
  edSQL.CaretX := nCol;
  edSQL.CaretY := nLin;
  //define línea con error
  edit.linErr := nLin;
  edSQL.Invalidate;  //refresca
end;
//eventos de edSQL
procedure TPrincipal.edSpecialLineMarkup(Sender: TObject; Line: integer;
  var Special: boolean; Markup: TSynSelectedColor);
begin
  if Line = edit.linErr then begin
      Special := True ;  //marca como línea especial
      Markup.Background := clRed; //color de fondo
  end;
end;

procedure TPrincipal.ExplorArchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //Ctrl + Tab, cambia el enfoque
  if (Shift = [ssCtrl]) and (Key = VK_TAB) then begin
    edSQL.SetFocus;
  end;
end;

procedure TPrincipal.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Config.escribirArchivoIni; //guarda cambio
end;

procedure TPrincipal.acEdCopyExecute(Sender: TObject);
begin
  edit.Copy;
end;
procedure TPrincipal.acEdCutExecute(Sender: TObject);
begin
   edit.Cut;
end;
procedure TPrincipal.acEdPasteExecute(Sender: TObject);
begin
  edit.Paste;
end;

procedure TPrincipal.editChangeFileInform;
begin
  //actualiza barra de título
  Caption:= NOM_PROG + ' - ' + SysToUTF8(edit.NomArc);
end;

procedure TPrincipal.edKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
//Se intercepta el evento KeyDown, para poder procesar las teclas pulsadas, antes de que
//las procese el editor, cuando se está en modo de selección por columnas.
//Utiliza el portapapeles, para la edición en modo columna.
var c: TUTF8char;
begin
  //comandos válidos en selección normal y en modo columna
  case Key of
  VK_UP   :  //procesa Ctrl + Arriba
     if ssCtrl in Shift then SubirCursorBloque(edSQL, Shift);
  VK_DOWN :  //procesa Ctrl + Abajo
     if ssCtrl in Shift then BajarCursorBloque(edSQL, Shift);
  VK_TAB:      //El "tab" no lo detecta KeyPress()
     if (Shift = [ssCtrl]) then begin
       if edsal.Visible then edSal.SetFocus
       else if ExplorArch.Visible then ExplorArch.SetFocus;
       exit;
     end;
  end;
end;
procedure TPrincipal.edKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//  debug.OutPut('---edKeyUp');
  if edSQL.SelectionMode = smColumn then StatusBar1.Panels[3].Text := 'Columnas' else StatusBar1.Panels[3].Text := 'Normal';
end;
//eventos de edSal
procedure TPrincipal.edSalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  //Ctrl + Tab, cambia el enfoque
  if (Shift = [ssCtrl]) and (Key = VK_TAB) then begin
    if ExplorArch.Visible then
      ExplorArch.TreeView1.SetFocus
    else if edSQL.Visible then
      edSQL.SetFocus;
    exit;
  end;
end;

procedure TPrincipal.VerificarError;
//Verifica si se ha producido algún error en el preprocesamiento y si lo hay
//Ve la mejor forma de msotrarlo
begin
    If not PErr.HayError Then exit;  //verificación
    //Selecciona posición de error en el Editor
    If PErr.ArcError <> '' Then begin
        //Se ha identificado el archivo con el error
        If edit.NomArc = '' Then begin
            //Tenemos el editor libre para mostrar el archivo
            edit.LoadFile(PErr.ArcError);
            //Ubicamos número de línea, si hay
            MarcarError(PErr.nLinError,PErr.nColError);
            If MostrarError Then Perr.MosError;
        end Else begin
            //Hay un archivo cargado
            If PErr.ArcError = edit.NomArc Then begin
                //El error está en el mismo archivo, lo mostramos
                If PErr.nLinError <> 0 Then begin
                   MarcarError(PErr.nLinError,PErr.nColError);
                   edSQL.Invalidate;
                end;
                If MostrarError Then Perr.MosError;
            end Else begin
                //Es otro archivo. Lo abre en otra ventana
               AbrirPreSQL(PErr.ArcError, PErr.TxtError);
            end;
        end;
    End else begin   //no hay archivo de error
      If MostrarError Then Perr.MosError;
    end;
End;

//////////////// Acciones de Archivo /////////////////
procedure TPrincipal.acArcNuevoExecute(Sender: TObject);
//Crea nuevo archivo
begin
  edit.NewFile;
end;
procedure TPrincipal.acArcNueVentExecute(Sender: TObject);
//Abre nueva ventana del PreSQL
begin
  AbrirPreSQL('');
end;
procedure TPrincipal.acArcAbrirExecute(Sender: TObject);
//Abre archivo
begin
  OpenDialog1.Filter:='Archivos PreSQL|*.psql;*.pdef|Todos los archivos|*.*';
  edit.OpenDialog(OpenDialog1);
end;
procedure TPrincipal.acArcGuardarExecute(Sender: TObject);
{ TODO : Se podría poner una verificación para que pregunte por un nuevo
 nombre cuando el archivo a guardar es SinNombre.psql}
begin
  edit.SaveFile;
end;
procedure TPrincipal.acArcGuaComExecute(Sender: TObject);  //Guardar como ...
begin
  SaveDialog1.Filter:='Archivos PreSQL|*.psql;*.pdef|Todos los archivos|*.*';
  edit.SaveAsDialog(SaveDialog1);
end;
procedure TPrincipal.mnRecientesClick(Sender: TObject);
//Actualiza el menú con  la lista de archivos recientes
begin
//  frmConfig.fraCfgEdit1.ActualMenusReciente(mnRec1,mnRec2,mnRec3,mnRec4,mnRec5);
end;
procedure TPrincipal.acArcSalirExecute(Sender: TObject);
begin
   Self.Close;
end;

procedure TPrincipal.FindDialog1Find(Sender: TObject);
var
  encon  : integer;
  buscado : string;
  opciones: TSynSearchOptions;
begin
  buscado := FindDialog1.FindText;
  opciones := [];
  if not(frDown in FindDialog1.Options) then opciones += [ssoBackwards];
  if frMatchCase in FindDialog1.Options then opciones += [ssoMatchCase];
  if frWholeWord in FindDialog1.Options then opciones += [ssoWholeWord];
  if frEntireScope in FindDialog1.Options then opciones += [ssoEntireScope];

  encon := edSQL.SearchReplace(buscado,'',opciones);
  if encon = 0 then
     ShowMessage('No se encuentra: ' + buscado);
end;
procedure TPrincipal.ReplaceDialog1Find(Sender: TObject);
var
  encon  : integer;
  buscado : string;
  opciones: TSynSearchOptions;
begin
  buscado := ReplaceDialog1.FindText;
  opciones := [];
  if not(frDown in ReplaceDialog1.Options) then opciones += [ssoBackwards];
  if frMatchCase in ReplaceDialog1.Options then opciones += [ssoMatchCase];
  if frWholeWord in ReplaceDialog1.Options then opciones += [ssoWholeWord];
  if frEntireScope in ReplaceDialog1.Options then opciones += [ssoEntireScope];

  encon := edSQL.SearchReplace(buscado,'',opciones);
  if encon = 0 then
     ShowMessage('No se encuentra: ' + buscado);
end;
procedure TPrincipal.ReplaceDialog1Replace(Sender: TObject);
var
  encon, r : integer;
  buscado : string;
  opciones: TSynSearchOptions;
begin
  buscado := ReplaceDialog1.FindText;
  opciones := [ssoFindContinue];
//  opciones := [];
  if not(frDown in ReplaceDialog1.Options) then opciones += [ssoBackwards];
  if frMatchCase in ReplaceDialog1.Options then opciones += [ssoMatchCase];
  if frWholeWord in ReplaceDialog1.Options then opciones += [ssoWholeWord];
  if frEntireScope in ReplaceDialog1.Options then opciones += [ssoEntireScope];
  if frReplaceAll in ReplaceDialog1.Options then begin
    //se ha pedido reemplazar todo
    encon := edSQL.SearchReplace(buscado,ReplaceDialog1.ReplaceText,
                              opciones+[ssoReplaceAll]);  //reemplaza
    ShowMessage('Se reemplazaron ' + IntToStr(encon) + ' ocurrencias.');
    exit;
  end;
  //reemplazo con confirmación
  ReplaceDialog1.CloseDialog;
  encon := edSQL.SearchReplace(buscado,'',opciones);  //búsqueda
  while encon <> 0 do begin
      //pregunta
      r := Application.MessageBox('¿Reemplazar esta ocurrencia?','Reemplazo',MB_YESNOCANCEL);
      if r = IDCANCEL then exit;
      if r = IDYES then begin
        edSQL.TextBetweenPoints[edSQL.BlockBegin,edSQL.BlockEnd] := ReplaceDialog1.ReplaceText;
      end;
      //busca siguiente
      encon := edSQL.SearchReplace(buscado,'',opciones);  //búsca siguiente
  end;
  ShowMessage('No se encuentra: ' + buscado);
end;

procedure TPrincipal.Splitter3Moved(Sender: TObject);
begin
  Config.AltVenSes := edSal.Height;  //actualiza caundo se mueve
end;
//////////////// Visibilidad de controles /////////////////
procedure TPrincipal.MostrarBarHer(visibilidad:boolean );
//Solo por esta función se debe cambiar la visibilidad de la barra de herramientas
begin
   ToolBar1.Visible:=visibilidad;
   mnVerBarHer.Checked:=visibilidad;
   Config.VerBarHer :=visibilidad; //Actualiza variable global
end;
procedure TPrincipal.MostrarBarEst(visibilidad:boolean );
//Solo por esta función se debe cambiar la visibilidad de la barra de estado
begin
   StatusBar1.Visible:=visibilidad;
   mnVerBarEst.Checked:=visibilidad;
   Config.VerBarEst :=visibilidad; //Actualiza variable global
end;
procedure TPrincipal.MostrarPanArc(visibilidad:boolean);
//Solo por esta función se debe cambiar la visibilidad del panel
begin
   if not ExplorArch.Visible and visibilidad then begin
     //se hace visible
     ExplorArch.LocateFileOnTree(edit.NomArc);  //ubica archivo actual
   end;
   ExplorArch.Visible := visibilidad;
   Splitter1.Visible := visibilidad;
   mnVerPanArc.Checked := visibilidad;
   Config.VerPanArc :=visibilidad; //Actualiza variable global
end;
procedure TPrincipal.MostrarPanBD(visibilidad:boolean );
//Solo por esta función se debe cambiar la visibilidad del panel
begin
//   Panel2.Visible := visibilidad;
   Splitter2.Visible := visibilidad;
   mnVerPanDB.Checked := visibilidad;
   Config.VerPanBD :=visibilidad; //Actualiza variable global
end;
procedure TPrincipal.MostrarVenSes(visibilidad:boolean );
//Solo por esta función se debe cambiar la visibilidad del panel
begin
   edsal.Visible := visibilidad;
   Splitter3.Visible := visibilidad;
   mnVerVenSes.Checked := visibilidad;
   Config.VerVenSes :=visibilidad; //Actualiza variable global
   if edSal.Visible then edSal.Height:=Config.AltVenSes;
end;
//////////////// Acciones de Edición /////////////////
procedure TPrincipal.mnEdDeshacClick(Sender: TObject);
begin
  edit.Undo;
end;
procedure TPrincipal.mnEdRehacClick(Sender: TObject);
begin
  edit.Redo;
end;
procedure TPrincipal.mnEdSelTodClick(Sender: TObject);
begin
  edSQL.SelectAll;
end;
procedure TPrincipal.mnEdModColClick(Sender: TObject);
begin
  edSQL.SelectionMode:= smColumn;
end;
procedure TPrincipal.acBusBuscarExecute(Sender: TObject);  //Búsqueda
begin
  if edSQL.SelAvail then FindDialog1.FindText:=edSQL.SelText;
  FindDialog1.Execute;
end;
procedure TPrincipal.acBusRemExecute(Sender: TObject);
begin
  if edSQL.SelAvail then ReplaceDialog1.FindText:=edSQL.SelText;
  ReplaceDialog1.Execute;
end;
////////////////////// Acciones Ver /////////////////////
procedure TPrincipal.acVerBarHerExecute(Sender: TObject); //Ver Barra de herramientas
begin
  MostrarBarHer(not mnVerBarHer.Checked);
  config.escribirArchivoIni; //guarda cambio
end;
procedure TPrincipal.acVeBarEstClick(Sender: TObject);
begin
   MostrarBarEst(not mnVerBarEst.Checked);
   Config.escribirArchivoIni; //guarda cambio
end;
procedure TPrincipal.acVePanArcClick(Sender: TObject);
begin
  MostrarPanArc(not mnVerPanArc.Checked);
  Config.escribirArchivoIni; //guarda cambio
end;
procedure TPrincipal.acVerVenSesExecute(Sender: TObject);
begin
  MostrarVenSes(not mnVerVenSes.Checked);
  Config.escribirArchivoIni; //guarda cambio
end;

procedure TPrincipal.eArchivoCargado;
//Evento que se dispara cuando se carga un archivo nuevo en el editor
begin
  if ExplorArch.Visible then
    ExplorArch.LocateFileOnTree(SysToUTF8(edit.NomArc));  //ubica ruta
//  Config.fcEditSQL.AgregArcReciente(edit.NomArc);  //agrega a lista de recientes
  Config.escribirArchivoIni;  //guarda registro
end;
procedure TPrincipal.acVerPanBDClick(Sender: TObject);
begin
  MostrarPanBD(not mnVerPanDB.Checked);
  Config.escribirArchivoIni; //guarda cambio
end;
procedure TPrincipal.sqlCon_ChangeState(info: string; pIni: TPoint);
begin
  acHerConec.Enabled := sqlCon.state = ECO_STOPPED;
  acHerDescon.Enabled:= not (sqlCon.state = ECO_STOPPED);
end;
procedure TPrincipal.sqlCon_ErrorConx;
begin
  msgErr(sqlCon.cadError);
end;
////////////////////// Acciones Herramientas /////////////////////
procedure TPrincipal.mnHerProcClick(Sender: TObject);
//Procesar
var usu: string;
begin
  MostrarError := True;
  acArcGuardarExecute(nil);
  edit.CloseCompletionWindow;  //cierra ventana de ayuda contextual por si acaso.
  If ePreProcesar(usu) Then Exit;
  If Not PErr.HayError Then begin
    //muestra la consulta
    frmVisor.mostrar(archivoSal, Self);
  End;
end;
procedure TPrincipal.mnHerProConClick(Sender: TObject);
//Procesar y Consultar
var usu: string;
begin
  MostrarError := True;
  acArcGuardarExecute(nil);
  edit.CloseCompletionWindow;  //cierra ventana de ayuda contextual por si acaso.
  If ePreProcesar(usu) Then Exit;
  If Not PErr.HayError Then begin
     //Ejcuta la consulta
     eConsultar(archivoSal, usu);
  End;
end;
procedure TPrincipal.acHerConecExecute(Sender: TObject);
var
  usu: String;
  CamSqlDef: String;
begin
  //lee datos de conexión actual
  usu := Config.ConexActual.Params;  //lee cadena de conexión
  //lee la ruta del sqlplus u otro aplicativo
  CamSqlDef := Config.ConexActual.RutSql;
  if usu = '' then begin
    MsgErr('No se ha especificado cadena de conexión.'#13#10 +
         'Definir en la ventana de configuración o en el inicio del archivo.');
    exit;
  end;
  If CamSqlDef = '' Then begin
    MsgErr('No se ha especificado ruta del SQLPLUS.');
    exit;
  end;

  if sqlCon.State = ECO_STOPPED then begin  //está desconectado
//    sqlCon.InicConexion(CamSqlDef, usu);
    sqlCon.Open;
  end else begin
    //ya está conectado
//    sqlCon.EnviarSQL( StringFromFile(arcsql));
  end;
end;
procedure TPrincipal.acHerDesconExecute(Sender: TObject);
begin
  sqlCon.Close;
end;
procedure TPrincipal.acHerTabEspExecute(Sender: TObject); //Tabulación a espacio
var
    i: integer;
begin
    if edSQL.SelAvail then begin
      frmSelFuente.optLin.Enabled:=false;
      frmSelFuente.optSel.Enabled:=true;
      frmSelFuente.optSel.Checked := true;
    end else begin
      frmSelFuente.optSel.Enabled:=false;
      frmSelFuente.optLin.Enabled := true;
      frmSelFuente.optLin.Checked := true;
    end;
    frmSelFuente.ShowModal;
    If frmSelFuente.cancelado Then begin  //se canceló
        //no hace nada
    end else If frmSelFuente.optLin.Checked Then begin  //línea
      edSQL.LineText:=StringReplace(edSQL.LineText,#9, stringOfChar(' ',edSQL.TabWidth), [rfReplaceAll]);
    end else If frmSelFuente.optSel.Checked Then begin  //seleción
      edSQL.SelText:=StringReplace(edSQL.seltext,#9, stringOfChar(' ',edSQL.TabWidth), [rfReplaceAll]);;
    end Else begin                           //todo
      for i:= 0 to edSQL.Lines.Count-1 do
        edSQL.Lines[i] := StringReplace(edSQL.Lines[i],#9, stringOfChar(' ',edSQL.TabWidth), [rfReplaceAll]);
    End;
    frmSelFuente.Close;     //Para no gastar memoria
//    edSQL.ClearUndo;  //no hay opción a deshacer
end;
procedure TPrincipal.acHerFilLinExecute(Sender: TObject);  //filtra líneas
var
    i: integer;
    s: string;
    sal: TStringList;
    arcsal: String;
begin
  sal := TStringList.Create;  //salida
  frmSelFuente.optLin.Enabled:=false;
  if edSQL.SelAvail and (edSQL.BlockEnd.y - edSQL.BlockBegin.y >0) then begin
     //hay selección de más de una línea
     frmSelFuente.optSel.Enabled:=true;
     frmSelFuente.optSel.Checked := true;
     frmSelFuente.ShowModal;  //solo muestra aquí
     If frmSelFuente.cancelado Then exit;  //se canceló
  end else begin  //no hay selección
     frmSelFuente.optTod.Checked := true;
//      frmSelFuente.ShowModal;
  end;
  If frmSelFuente.optSel.Checked Then begin  //seleción
    s := InputBox('Filtrar líneas:','Ingrese texto: ','');
    if s = '' then exit;
    for i:= edSQL.BlockBegin.y to edSQL.BlockEnd.y do
      if AnsiContainsText(edSQL.Lines[i],s) then sal.Add(edSQL.Lines[i]);
  end Else begin                           //todo
    if edSQL.BlockEnd.y = edSQL.BlockBegin.y then  //hay texto seleccionado, suguiere
      s := InputBox('Filtrar líneas:','Ingrese texto: ',edSQL.SelText)
    else
      s := InputBox('Filtrar líneas:','Ingrese texto: ','');
    if s = '' then exit;
    for i:= 0 to edSQL.Lines.Count-1 do
      if AnsiContainsText(edSQL.Lines[i],s) then sal.Add(edSQL.Lines[i]);
  End;
//    frmSelFuente.Close;     //Para no gastar memoria
  try
    { TODO : Debe generar un archivo de tipo *.txt, porque sql implica resaltado de sintaxis}
    arcsal := GenNombSal(edit.NomArc,'txt');     //genera nombre de salida
    sal.SaveToFile(arcSal);
    frmVisor.mostrar(arcSal,self);
//    AbrirPreSQL(arcSal);
  finally
    sal.Free;
  end;
end;

procedure TPrincipal.mnConfigClick(Sender: TObject);
//Muestra ventana de configuración
begin
   Config.ShowModal;
end;
procedure TPrincipal.StatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
//Manejador del evento de dibujo del Panel
begin
  if panel.Index = 0 then begin //dibujo de panel 0.
    Config.fcConOra.DrawStatusPanel(StatusBar.Canvas, Rect);  //refresca
  end else if panel.Index = 1 then begin //dibujo de panel 1.
    sqlcon.DrawStatePanel(StatusBar.Canvas, Rect);
  end;
end;
{ TODO : Verificar el error detectado al cargar un archvo de texto con dos saltos de línea al
 final. Ver si se mantiene el formato en el editor y al guardar. }

procedure TPrincipal.SetLanguage(lang: string);
begin
  case lowerCase(lang) of
  'es': begin
      //menú principal
      mnArchivo.Caption:='&Archivo';
      mnEdicion.Caption:='&Edición';
      mnBuscar.Caption:='&Buscar';
      mnVer.Caption:='&Ver';
      mnHerram.Caption:='&Herramientas';

      acArcNuevo.Caption := '&Nuevo';
      acArcNuevo.Hint := 'Nueva consulta';
      acArcNueVent.Caption := 'Nueva &Ventana';
      acArcNueVent.Hint := 'Nueva ventana de PreSQL';
      acArcAbrir.Caption := '&Abrir...';
      acArcAbrir.Hint := 'Abrir archivo';
      acArcGuardar.Caption := '&Guardar';
      acArcGuardar.Hint := 'Guardar archivo';
      acArcGuaCom.Caption := 'G&uardar Como...';
      acArcGuaCom.Hint := 'Guardar como';
      acArcSalir.Caption := '&Salir';
      acArcSalir.Hint := 'Cerrar el programa';
      acHerProcesar.Caption := '&Procesar';
      acHerProcesar.Hint := 'Pre-procesar';
      acHerProcCons.Caption := 'Procesar y Cons&ultar';
      acHerProcCons.Hint := 'Pre-procesar y consultar';
      acEdUndo.Caption := '&Deshacer';
      acEdUndo.Hint := 'Deshacer';
      acEdRedo.Caption := '&Rehacer';
      acEdRedo.Hint := 'Reahacer';
      acEdCut.Caption := 'Cor&tar';
      acEdCut.Hint := 'Cortar';
      acEdCopy.Caption := '&Copiar';
      acEdCopy.Hint := 'Copiar';
      acEdPaste.Caption := '&Pegar';
      acEdPaste.Hint := 'Pegar';
      acEdSelecAll.Caption := 'Seleccionar &Todo';
      acEdSelecAll.Hint := 'Seleccionar todo';
      acEdModCol.Caption := 'Modo Columna';
      acEdModCol.Hint := 'Modo columna';
      acBusBuscar.Caption := 'Buscar...';
      acBusBuscar.Hint := 'Buscar texto';
      acBusBusSig.Caption := 'Buscar &Siguiente';
      acBusBusSig.Hint := 'Buscar Siguiente';
      acBusRem.Caption := '&Remplazar...';
      acBusRem.Hint := 'Reemplazar texto';
      acVerBarHer.Caption := 'Barra de &Herramientas';
      acVerBarHer.Hint := 'Ver Barra de Herramientas';
      acVerBarEst1.Caption := 'Barra de &Estado';
      acVerBarEst1.Hint := 'Mostrar la barra de estado';
      acVerPanArc.Caption := 'Panel de &Archivos';
      acVerPanArc.Hint := 'Ver el Panel de Archivos';
      acVerPanelBD.Caption := 'Pánel de &Base de Datos';
      acVerPanelBD.Hint := 'Ver panel de Base de datos';
      acVerVenSes.Caption := 'Ventana de &Sesión';
      acVerVenSes.Hint := 'Ver Ventana de Sesión';
      acHerConec.Caption := '&Conectar';
      acHerConec.Hint := 'Conectar a Base de Datos';
      acHerDescon.Caption := '&Desconectar';
      acHerDescon.Hint := 'Desconectar de Base de Datos';
      acHerTabEsp.Caption := '&Tabulación a espacios';
      acHerTabEsp.Hint := 'Tabulación a espacio';
      acHerFilLin.Caption := '&Filtrar Líneas';
      acHerFilLin.Hint := 'Filtrar líneas';
      acHerQuiEsp.Caption := '&Quitar espacios laterales';
      acHerQuiEsp.Hint := 'Quitar espacios laterales';
      acHerConfig.Caption := '&Configuración';
      acHerConfig.Hint := 'Ver configuración';
    end;
  'en': begin
      //menú principal
      mnArchivo.Caption:='&File';
      mnEdicion.Caption:='&Edit';
      mnBuscar.Caption:='&Search';
      mnVer.Caption:='&View';
      mnHerram.Caption:='&Tools';

      acArcNuevo.Caption := '&New';
      acArcNuevo.Hint := 'New query';
      acArcNueVent.Caption := 'New &Window';
      acArcNueVent.Hint := 'New PreSQL window';
      acArcAbrir.Caption := '&Open...';
      acArcAbrir.Hint := 'Open file';
      acArcGuardar.Caption := '&Save';
      acArcGuardar.Hint := 'Save file';
      acArcGuaCom.Caption := 'Sa&ve As ...';
      acArcGuaCom.Hint := 'Save file as ...';
      acArcSalir.Caption := '&Quit';
      acArcSalir.Hint := 'Close the program';
      acHerProcesar.Caption := '&Process';
      acHerProcesar.Hint := 'Pre-process';
      acHerProcCons.Caption := 'Process and send';
      acHerProcCons.Hint := 'Pre-process and send query';
      acEdUndo.Caption := '&Undo';
      acEdUndo.Hint := 'Undo';
      acEdRedo.Caption := '&Redo';
      acEdRedo.Hint := 'Redo';
      acEdCut.Caption := 'C&ut';
      acEdCut.Hint := 'Cut';
      acEdCopy.Caption := '&Copy';
      acEdCopy.Hint := 'Copy';
      acEdPaste.Caption := '&Paste';
      acEdPaste.Hint := 'Paste';
      acEdSelecAll.Caption := 'Select &All';
      acEdSelecAll.Hint := 'Select all';
      acEdModCol.Caption := 'Column mode';
      acEdModCol.Hint := 'Column mode';
      acBusBuscar.Caption := 'Search...';
      acBusBuscar.Hint := 'Search text';
      acBusBusSig.Caption := 'Search &Next';
      acBusBusSig.Hint := 'Search Next';
      acBusRem.Caption := '&Replace...';
      acBusRem.Hint := 'Replace text';
      acVerBarHer.Caption := '&Toolbar';
      acVerBarHer.Hint := 'Show Toolbar';
      acVerBarEst1.Caption := '&Statusbar';
      acVerBarEst1.Hint := 'Show the Statusbar';
      acVerPanArc.Caption := '&File panel';
      acVerPanArc.Hint := 'Show the File panel';
      acVerPanelBD.Caption := '&Database panel';
      acVerPanelBD.Hint := 'Show the Database panel';
      acVerVenSes.Caption := '&Sesion window';
      acVerVenSes.Hint := 'Show the Sesion window';
      acHerConec.Caption := '&Connect';
      acHerConec.Hint := 'Connect to the Database';
      acHerDescon.Caption := '&Disconnect';
      acHerDescon.Hint := 'Disconnect from the Database';
      acHerTabEsp.Caption := '&Tabs to spaces';
      acHerTabEsp.Hint := 'Replace tabs for spaces';
      acHerFilLin.Caption := '&Filter lines';
      acHerFilLin.Hint := 'Filter lines';
      acHerQuiEsp.Caption := '&Trim spaces';
      acHerQuiEsp.Hint := 'Trim spaces';
      acHerConfig.Caption := '&Settings';
      acHerConfig.Hint := 'Configuration dialog';
    end;
  end;
end;

end.
