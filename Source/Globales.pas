{                                    Pre SQL
Preprocesador de Consultas SQL para Oracle.
Adaptado de la versión PreSQL en Visual Basic.
Se han mantenido la mayoría de las características del PreSQL anterior y se han añadido
algunas más.
                 Creado por Tito Hinostroza - 28/08/2013
}
unit Globales; {$mode objfpc}{$H+}
interface
uses
  Classes, SysUtils, Forms, SynEdit, SynEditKeyCmds, SynEditTypes, lclType,
  Process, FileUtil, ShellApi, MisUtils;

const
  NOM_PROG = 'PreSQL 2.4b';   //nombre de programa

var
   //Variables globales
   MsjError    : String;      //Bandera - Mensaje de error

   archivoEnt  : string;    //archivo de entrada
   archivoSal  : string;    //archivo de salida
   Prepro      : Boolean;   //bandera para preprocesar
   EjecOracle  : Boolean;   //bandera para ejecutar en Oracle
   MostrarError: Boolean;   //Bandera para mostrar mensajesde error.
   MsjeIni     : String;    //Mensaje inicial
//   ActAyudCon  : Boolean;   //Activa ayuda contextual
   ActConsSeg  : Boolean;   //Activa consultas en segundo plano

//Funciones para control del editor
procedure SubirCursorBloque(ed: TSynEdit; Shift: TShiftState);
procedure BajarCursorBloque(ed: TSynEdit; Shift: TShiftState);
//procedure InsertaColumnasBloque(ed: TsynEdit; var key: TUTF8Char);

procedure AbrirPreSQL(arc0: string; MsjIni: string = '');
function  LeerParametros: boolean;
procedure DeleteToBin( aFile : PChar );  //Envía a papelera

implementation

//Funciones para control del editor
procedure EdSubirCursor(ed: TSynEdit; Shift: TShiftState);
//Sube el cursor del SynEdit, una psoición, considerando el estado de <Shift>
{ TODO : Es muy lento para varias líneas (>100) }
begin
  if ed.SelectionMode = smColumn then  //en modo columna
     ed.ExecuteCommand(ecColSelUp, #0, nil)  //solo se puede mover con selección
  else         //en modo normal
     if ssShift in Shift then
        ed.ExecuteCommand(ecSelUp, #0, nil)   //sube
     else
        ed.ExecuteCommand(ecUp, #0, nil);   //sube
end;
procedure EdBajarCursor(ed: TSynEdit; Shift: TShiftState);
//Baja el cursor del SynEdit, una psoición, considerando el estado de <Shift>
begin
  if ed.SelectionMode = smColumn then  //en modo columna
     ed.ExecuteCommand(ecColSelDown, #0, nil)  //solo se puede mover con selección
  else         //en modo normal
     if ssShift in Shift then
        ed.ExecuteCommand(ecSelDown, #0, nil)   //sube
     else
        ed.ExecuteCommand(ecDown, #0, nil);   //sube
end;
procedure SubirCursorBloque(ed: TSynEdit; Shift: TShiftState);
//Sube el cursor hasta encontrar una línea en blanco (si estaba en una diferente de blanco)
//o hasta encontrar una línea diferente de blanco (si estaba en una línea en blanco)
var
  curY : longint;
begin
  CurY := ed.CaretY;    //Lee posición de cursor
  if CurY = 1 then exit;   //no se puede subir más
  if CurY = 2 then begin
     EdSubirCursor(ed, Shift);   //solo puede subir una posición.
     exit;
  end;
  if trim(ed.lines[CurY-2]) = '' then begin
     //busca línea diferente de blanco
     while CurY > 1 do begin
        if trim(ed.lines[Cury-2]) <> '' then Exit;    //pone y sale
        Dec(CurY);
        EdSubirCursor(ed, Shift);
     end;
  end else begin
     //busca línea en blanco hacia abajo
     while CurY > 1 do begin
        if trim(ed.lines[CurY-2]) = '' then Exit;    //pone y sale
        Dec(CurY);
        EdSubirCursor(ed, Shift);
     end;
  end;
end;
procedure BajarCursorBloque(ed: TSynEdit; Shift: TShiftState);
//Baja el cursor hasta encontrar una línea en blanco (si estaba en una diferente de blanco)
//o hasta encontrar una línea diferente de blanco (si estaba en una línea en blanco)
var
  curY : longint;
begin
   CurY := ed.CaretY;    //Lee posición de cursor
   if CurY = ed.Lines.Count then exit; //no se puede bajar más
   if CurY = ed.Lines.Count - 1 then begin
      EdBajarCursor(ed, Shift);   //solo puede bajar una posición.
      exit;
   end;
   if trim(ed.lines[CurY-1]) = '' then begin
     //busca línea diferente de blanco
     while CurY < ed.Lines.Count do begin
        if trim(ed.lines[CurY-1]) <> '' then Exit;    //pone y sale
        Inc(CurY);
        EdBajarCursor(ed, Shift);
     end;
   end else begin
      //busca línea en blanco hacia abajo
      while CurY < ed.Lines.Count do begin
         if trim(ed.lines[CurY-1]) = '' then Exit;    //pone y sale
         Inc(CurY);
         EdBajarCursor(ed, Shift);
      end;
   end;
end;

procedure AbrirPreSQL(arc0: string; MsjIni: string = '');
//Abre un archivo en otra instancia del PreSQL
var p: Tprocess;
    parMsg: string;  //parámetro de mensaje
begin
  //Muestra archivo preprocesado
  p := TProcess.Create(nil);
  //por algúnh motivo se le debe pasar como UTF8
  if MsjIni = '' then parMsg := '' else parMsg:= ' /MSJE "'+MsjIni+'"';
  if arc0 <> '' then arc0 := ' "'+arc0+'"';  //completa con comillas
  p.CommandLine := SysToUTF8(Application.ExeName +  arc0 + parMsg);
//    p.Options := p.Options ;
  p.Execute;
  p.Free;
end;

function  LeerParametros: boolean;
{lee la linea de comandos
 PSQL <archivo_entrada> [archivo_salida]] [PREPRO] [CONSULTA] [NOERROR]
 El nombre de archivo de entrada siempre va a al inicio, pero los demás
 parámetros pueden ir en cualquier orden.
 Valores por defecto:
     archivo de salida --> automático
     preprocesamiento  --> NO
     lanzar consulta   --> NO
     mensajes de error --> mostrar mensajes de error
 Actualiza las variables "archivo", "archivoSal", "MostrarError" y "EjecOracle"
 Si hay error devuelve TRUE}
var
   par : String;
   i   : Integer;
begin
   Result := false;    //valor por defecto
   //valores por defecto
   archivoEnt := '';
   archivoSal := '';
   MostrarError := True;
   MsjeIni := '';
   Prepro := False;
   EjecOracle := False;
   ActConsSeg := False;
   //Lee parámetros de entrada
   par := ParamStr(1);
   if par = '' then begin
     MsgErr('Nombre de archivo vacío.');
     Result := true;
     exit;  //sale con error
   end;
   if par[1] = '/' then begin  //es parámetro
      i := 1;  //para que explore desde el principio
   end else begin  //es archivo
      archivoEnt := par;  //el primer elemento es el archivo de entrada
      i := 2;  //explora siguientes
   end;
   while i <= ParamCount do begin
      par := ParamStr(i);
      If par[1] = '/' Then begin
         Case UpCase(par) of
            '/PREPRO': Prepro := True;
            '/CONSULTA': EjecOracle := True;
            '/NOERROR': MostrarError := False;
            '/ERROR': MostrarError := True;
            '/CONSEG': ActConsSeg := True;
            '/NOCONSEG': ActConsSeg := False;
            '/MSJE': if i < ParamCount then begin  //lee mensaje
                        inc(i);
                        MsjeIni := ParamStr(i);
                     end;
         Else begin
                MsgErr('Error. Parámetro desconocido: ' + par);
                Result := true;
                exit;  //sale con error
              End
         End
      end Else begin
         archivoSal := par;
      End;
      inc(i);  //pasa al siguiente
   end;
   //Por defecto se asume que si "EjecOracle", está en Verdadero, "Prepro"
   //debe también estarlo.
   If EjecOracle Then Prepro := True;
End;

procedure DeleteToBin( aFile : PChar );  //Envía a papelera
var
  fileOpStruct : TSHFileOpStruct;
begin
  fileOpStruct.Wnd := 0;
  fileOpStruct.wFunc := FO_DELETE;
  fileOpStruct.pFrom := aFile;
  fileOpStruct.fFlags := FOF_ALLOWUNDO + FOF_NOCONFIRMATION;
  SHFileOperation( fileOpStruct );
end;

initialization

   archivoEnt := '';    //archivo de entrada
   archivoSal := '';    //archivo de salida

finalization

end.

