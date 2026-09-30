/* ------ compat.ch ------
   Cabecera que se incluye automaticamente en todos los modulos (opcion -u
   del compilador, ver pro.hbp).

   Desvia las llamadas al sistema operativo heredadas de DOS hacia HBRUN(),
   que las resuelve dentro del programa. En Windows moderno cada __RUN()
   abriria una ventana de consola y varias ordenes (MODE LPT1:) ya no
   existen.
*/

/* -u reemplaza el juego de comandos estandar de Harbour: hay que volver a
   incluirlo para no perder REQUEST, SET, FOR EACH y demas. */
#include "std.ch"

#xtranslate __RUN( <cmd> )  =>  HBRUN( <cmd> )
