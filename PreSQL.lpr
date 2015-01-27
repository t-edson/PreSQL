{PreSQL 2.4
Por Tito Hinostroza.

A diferencia de las versiones anteriores, esta versión de PreSQL, se presenta
solo como aplicación de consola.
La interfaaz gráfica, se deja como una aplicación diferente llamada "PreSQLDev"

Descripción
===========
PreSQL, es un cliente para Base de datos Oracle que usa el cliente SQL*Plus
pero realiza un pre-procesamiento previo del contenido de la consulta.

El pre-procesador usa un lenguaje similar a los lenguajes de macros, pero que
se ha definido en español. Para información sobre el lengauje, revisar la
documentación.

La sintaxis de la línea de comando, implementada es:

  PreSQL @<archivo_entrada> [archivo_salida]

  Por ejemplo para lanzar la consulta que se encuentra en el archivo "consulta.sql",
se debe ejcutar:

  PreSQL @consulta.sql

  La cadena de conexión, debe estar indicada al inicio del archivo consulta.sql.

  Cuando se especifica el archivo de salida, el PreSQL solo realiza la expansión
del texto, sin lanzar la consulta a la base de datos.

IMPORTANTE: EL PreSQL, necesita que el SQL*Plus, se encuentre instalado si se
quiere realizar consultas a la base de datos.

Se ha diseñado que el PreSQL, se comporte de forma similar a como se comportaría
el SQL*Plus, pero con algunas diferencias:

* La línea de comandos del PreSQL es diferentea al del SQL*Plus. Solo guarda
ciertas similitudes, como la forma de indicar el archivo de entrada.
* El PreSQL pre-procesa el texto antes de enviar la consulta a la base de datos.
* El PreSQL crea un archivo temporal antes de lanzar la consulta, así, es posible
modificar la misma consulta y lanzarla nuevamente (lo que no se puede hacer con el
SQL*Plus)
* El PreSQL, espera siempre que la cadena de conexión se encuentre en el mismo
archivo de consulta (CONNECT usuario/clave@sid). No se puede incluir la cadena
de conexión en la línea de comandos (hasta la versión actual). Es equivalente a
ejecutar: sqlplus /nolog
* El PreSQL, puede generar mensajes de error adicionales, que tienen que ver con
la sintaxis del lenguaje de macros.


}
program PreSQL;
{$mode objfpc}{$H+}
uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, process, interfaces, SysUtils, FileUtil, uPrebasicos, uPreProces;
var
  dirSal      : string;    //directorio donde se generan los archivos preprocesados
  //parámetros
  archivoEnt  : string;    //archivo de entrada
  archivoSal  : string;    //archivo de salida
  Prepro      : Boolean;   //bandera para preprocesar
  EjecOracle  : Boolean;   //bandera para ejecutar en Oracle
  MostrarError: Boolean;   //Bandera para mostrar mensajesde error.

procedure MostrarSintaxis;
begin
   writeln('PreSQL 2.4b');
   writeln('Por Tito E Hinostroza - Derechos Reservados');
   writeln('Lima - Peru - 2014');
   writeln('');
   writeln('Syntax:');
   writeln('=======');
   writeln('');
   writeln('  PreSQL @<archivo_entrada> [archivo_salida]');
   writeln('');
//    WriteLn('Pulse una tecla para salir...');
//    readln;
end;
function Exec(com: string): boolean;
//Ejecuta un programa. Devuelve FALSE si hubo error
var
  p    : TProcess;   //el proceso a manejar
begin
  Result := true;
  p := TProcess.Create(nil); //Crea proceso
//  p.CommandLine := SysToUTF8(Application.ExeName +  arc0 + parMsg);
  p.CommandLine := SysToUTF8(com);
  p.Options:=[poWaitOnExit];
  try
    p.Execute;
  except
    Result := false;
    writeln('Fallo al iniciar aplicativo: '+ p.CommandLine);;
  end;
  p.Free;
end;
function GenNombSal(nomBase: String; ext: string = 'sql'): String;
{Devuelve el nombre de un archivo de salida. Debe estar inicializado "dirSal".
 Esta función busca un nombre libre de archivo (igual a nomBase más un ordinal ~00)
 en la ubicación "dirSal". Si no encuentra un nombre libre, devuelve el nombre del
 archivo más antiguo.}
const MAX_ARCH = 10;   {máximo número de archivos de salida a crear, para un mismo archivo
                        de entrada. Se recomienda menos de 100}
var i : Integer;    //Número de intentos con el nombre de archivo de salida
    cadBase : String;   //Cadena base del nombre base
    fileDate: Integer;  //Timestamp de fecha de mofificación
    minDate: Integer;   //Fecha mínima
    minFile: string;    //nombe del archivo más antiguo
  function NombArchivo(i: integer): string;
  begin
    Result := cadBase + '~' + FormatFloat('00',i) + '.' + ext;
  end;

begin
   PErr.IniError;
   Result := '~00.tmp';  //nombre por defecto
   if dirSal = '' then begin
      writeln('No se ha iniciado directorio de salida');
      exit;
   end;
   //quita ruta y cambia extensión
   cadBase := dirSal + ChangeFileExt(ExtractFileName(nomBase),'');
   //busca archivo libre
   minDate := High(integer);  //inicia con valor máximo
   minFile := '';
   for i := 0 to MAX_ARCH-1 do begin
      If FileExists(NombArchivo(i)) then begin   //ya existe este nombre
        fileDate := FileAge(NombArchivo(i));     //toma fecha
        if fileDate < minDate then begin
           mindate := fileDate;   //nuevo mínimo
           minFile := NombArchivo(i);
        end;
      end else  //Se encontró nombre libre
        Exit(NombArchivo(i));  //Sale con nombre
   end;
   //todos los nombres estaban ocupados
   if minFile = '' then begin
     //hubo error
     writeln('Error buscando nombre de archivo de salida.');
     exit;
   end else  //devuelve el más antiguo
     Result := minFile;
End;
function LeerParametros: boolean;
{lee la linea de comandos
 PreSQL @<archivo_entrada> [archivo_salida] [PREPRO] [CONSULTA] [NOERROR]
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
   Prepro := False;
   EjecOracle := False;
   //Lee parámetros de entrada
   i := 1;
   while i <= ParamCount do begin
      par := ParamStr(i);
      if par[1] = '/' Then begin
         Case UpCase(par) of
            '/PREPRO': Prepro := True;
            '/CONSULTA': EjecOracle := True;
            '/NOERROR': MostrarError := False;
            '/ERROR': MostrarError := True;
         Else begin
                writeln('Error. Parámetro desconocido: ' + par);
                Result := true;
                exit;  //sale con error
              End
         End
      end else if par[1] = '@' then begin
         //es nombre de archvio de entrada
         archivoEnt := copy(par, 2,1000);
      end else begin
         archivoSal := par;
      End;
      inc(i);  //pasa al siguiente
   end;
   //Por defecto se asume que si "EjecOracle", está en Verdadero, "Prepro"
   //debe también estarlo.
   If EjecOracle Then Prepro := True;
end;

var
  usu: string;
  HabiaSalida: Boolean;
begin
  if Paramcount = 0 then begin   //No hay parámetros
    MostrarSintaxis;
    exit;
  end;
  LeerParametros;
  //verifica archivo de entrada
  if archivoEnt='' then begin  //No hay archivo de entrada
    MostrarSintaxis;
    exit;
  end;
  //verifica el archivo de salida
  if archivoSal = '' then begin
    {Solo en este caso, se hace la verificación del directrio temporal, porque aquí
     necesitamos crear un archivo temporal. }
    //Verifica
    dirSal := ExtractFilePath(ParamStr(0)) + 'bolsa\';
    if not DirectoryExists(dirSal) then begin
       Writeln('No exste directorio: ' + dirSal + '. Se creará. ');
       CreateDir(dirSal);
    end;
    //genera un nombre temporal
    archivoSal := GenNombSal(archivoEnt);
    HabiaSalida := false;   //guarda información
  end else begin
    //se ha indicado el nombre del archivo de salida.
    if FileExists(archivoSal) Then begin  //existe
       try
         DeleteFile(archivoSal);
       except
         Writeln('No se puede crear: '+archivoSal);
         exit;
       end
    end;
    HabiaSalida := true;   //guarda información
  end;
  //Pre-procesa el archivo de entrada
  //abre archivo de registro de eventos
//    nlog = FreeFile
//    Open App.Path & "\bolsa\eventos.txt" For Append Access Write: #nlog
//    Print #nlog, Date & "  " & Time & "   OPERACION: " & arc & "   ----->   " & arcsal
  PreProcesar(archivoEnt, '', usu);   //preprocesa
  PPro.GenArchivo(archivoSal);  //escribe en archivo de salida
  { TODO : Tal vez deba incluir siempre un EXIT para asegurar que sale del SQLPlus }
  if PErr.HayError and MostrarError Then begin
    //se muestra en un formato que sea fácil de procesar.
    //Otra opción sería usar PErr.GenTxtError
    writeln('');
    writeln('ERROR: ' + Perr.cadError);
    writeln('FILE : ' + Perr.ArcError);
    writeln('POS  : ', PErr.nLinError,',',PErr.nColError);
    writeln('');
    exit;
  end;
  //Ve si debe lanzar el archivo de salida
  if not HabiaSalida then begin
    //No se especificó archivo de salida, asumimos que debemos lanzar la consulta
    Exec('sqlplus /nolog @"'+archivoSal+'"');
  end;
//  WriteLn('Pulse una tecla para salir...');
//  readln;
end.

