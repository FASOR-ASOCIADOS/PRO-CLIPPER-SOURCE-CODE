/* ------ HBCOMPAT.PRG ------
   Compatibilidad de la version Harbour con los fuentes recuperados por Rescue5.

   1) Nombres truncados
      CA-Clipper 5.2 guarda los nombres de funcion truncados a 10 caracteres, y
      asi los emitio el descompilador (DBCLOSEARE, DBSELECTAR, ORDLISTCLE,
      __REPORTFO, __SETCENTU...). Harbour reconoce todos esos nombres cortos
      menos uno, que se resuelve aqui.

   2) Ordenes del sistema operativo
      El programa llama a __RUN() para tareas que en DOS resolvia el interprete
      de comandos. compat.ch desvia esas llamadas a HBRUN(), que las hace dentro
      del programa: en Windows moderno cada __RUN() abriria una ventana de
      consola, y ordenes como "MODE LPT1:132" ya no tienen sentido.
*/

#include "directry.ch"

FUNCTION DBCREATEIN()                      // dbCreateIndex()
   RETURN HB_ExecFromArray( "DBCREATEINDEX", HB_AParams() )


FUNCTION HBRUN( cCmd )

   LOCAL cOrden := UPPER( ALLTRIM( IF( cCmd == NIL, "", cCmd ) ) )

   DO CASE
   CASE LEFT( cOrden, 9 ) == "MODE LPT1"
      /* Ancho de impresion de la impresora matricial conectada al puerto
         paralelo. En Windows moderno esa orden ya no configura nada; el
         texto a imprimir queda igual en C:\PROTMP\BASURA.TXT. */

   CASE LEFT( cOrden, 4 ) == "DEL "
      BorraArchivos( SUBSTR( ALLTRIM( cCmd ), 5 ) )

   CASE LEFT( cOrden, 3 ) == "MD "
      HB_DirBuild( ALLTRIM( SUBSTR( ALLTRIM( cCmd ), 4 ) ) )

   CASE cOrden == "CD"
      /* Mostraba el directorio actual en pantalla. No aporta nada aqui. */

   OTHERWISE
      /* Todo lo demas (por ejemplo DATE, o el volcado a la impresora) sigue
         yendo al sistema operativo (HB_RUN, sin pasar por compat.ch). */
      RETURN HB_RUN( cCmd )

   ENDCASE

   RETURN NIL


/* Borra los archivos que coincidan con la mascara, como haria DEL.
   Las mascaras que usa el programa son del tipo "A*." : archivos cuyo
   nombre empieza con esa letra y no tienen extension. */
STATIC PROCEDURE BorraArchivos( cMascara )

   LOCAL aFiles, aFile

   cMascara := ALLTRIM( cMascara )

   IF EMPTY( cMascara )
      RETURN
   ENDIF

   aFiles := DIRECTORY( cMascara )

   FOR EACH aFile IN aFiles
      IF ! "D" $ aFile[ F_ATTR ]
         FERASE( aFile[ F_NAME ] )
      ENDIF
   NEXT

   RETURN
