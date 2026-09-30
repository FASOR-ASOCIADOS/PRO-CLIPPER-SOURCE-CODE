/* ------ HBMAIN.PRG ------
   Punto de entrada y ajustes de arranque de la version Harbour.

   El programa descompilado no declara MAIN: su punto de entrada es PRO().
   Harbour arranca por la funcion MAIN, asi que se la damos aqui.
*/

#include "set.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"

/* Harbour solo incluye en el ejecutable las paginas de codigos que se piden */
REQUEST HB_CODEPAGE_ES850

PROCEDURE MAIN()

   /* Los archivos se comparten por red con las PC que sigan usando el
      ejecutable de CA-Clipper: hay que bloquearlos de la misma forma. */
   SET( _SET_DBFLOCKSCHEME, DB_DBFLOCK_CLIPPER )

   /* Los textos del programa y los datos estan en la pagina de codigos
      de DOS (850): acentos, enie y recuadros. */
   HB_CDPSELECT( "ES850" )
   HB_GTINFO( HB_GTI_CODEPAGE, 850 )

   /* Los archivos temporales van a C:\PROTMP en vez de la raiz de C:.
      Windows no deja crear archivos sueltos en la raiz a un usuario sin
      privilegios de administrador, pero si crear una carpeta y escribir
      dentro de ella. */
   HB_DirBuild( "C:\PROTMP" )

   HB_GTINFO( HB_GTI_WINTITLE, "Sistema de Produccion" )

   PRO()

RETURN
