/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: DBP63
   Params: None.
   Return: Undefined
  Example: DBP63()
  ..........................................................................
*/

PROCEDURE DBP63()

   MEMVAR->OPC := " "
   SET(11, "OFF")
   AHP63E()
   MEMVAR->WORDINI := 0
   DBEVAL({||DBRECALL()}, NIL, NIL, NIL, NIL, .F.)
   MEMVAR->WORDFIN := 0
   DBCLOSEARE()

   DO WHILE OPC <> "*"

      MEMVAR->OPC := " "
      MENU()
      DEVPOS(5, 1)
      DEVOUT(PADC("COSTOS DE PRODUCCION", 78))
      DEVPOS(6, 1)
      DEVOUT(PADC(;
            "DANDO DE BAJA ORDENES DEL ARCHIVO HISTORICO DE PAGOS DE TAREAS";
            , 78))
      DEVPOS(11, 20)
      DEVOUT("DESDE QUE ORDEN DA DE BAJA ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WORDINI", "@# 999999", NIL, NIL):DISPLAY())
      DEVPOS(12, 20)
      DEVOUT("HASTA QUE ORDEN DA DE BAJA ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WORDFIN", "@Z 999999", NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      ESPERE()

      IF WORDINI = 0

         MEMVAR->OPC := "*"
         LOOP

      ENDIF

      MEMVAR->WANO := "0 "
      SETCOLOR("*+GR")
      DEVPOS(18, 10)
      DEVOUT("Por favor anteponga el 0 si es antes del 2010")
      SETCOLOR("+W")
      DEVPOS(19, 10)
      DEVOUT("Por favor escriba los dos " + U + "ltimos d" + I + ;
            "gitos del a" + NMI + "o de las")
      DEVPOS(20, 10)
      DEVOUT("ordenes que piensa dar de baja: ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WANO", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      MEMVAR->OPC := " "
      DEVPOS(21, 10)
      DEVOUT("Los datos suministrados son correctos ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "N"

         LOOP

      ENDIF

      ESPERE()
      MEMVAR->WNUEVO := "HISPAG" + ALLTRIM(WANO) + ".DBF"

      IF FILE("&ZDIS\&WDIRECTO\&WNUEVO")

         SCROLL(16, 1, 23, 78)
         MEMVAR->OPC := ( SETPOS(16, 1), " " )
         DEVPOS(18, 10)
         DEVOUT("El archivo de ese a" + NMI + "o: " + WNUEVO + ;
               ", ya existe,")
         DEVPOS(19, 5)
         DEVOUT("<A>diciona a " + E + "l, lo <R>eemplaza o <C>ancela ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "CAR"}, NIL);
               :DISPLAY())
         SETCOLOR("*+G")
         DEVPOS(19, 6)
         DEVOUT("A")
         DEVPOS(19, 26)
         DEVOUT("R")
         DEVPOS(19, 40)
         DEVOUT("C")
         SETCOLOR("+W")
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF OPC = "C"

            MEMVAR->OPC := " "
            RETURN 

         ENDIF

         IF OPC = "R"

            FERASE("&ZDIS\&WDIRECTO\WNUEVO")
            AHP63S()
            __DBCOPYST("&ZDIS\&WDIRECTO\&WNUEVO", {})
            DBCLOSEARE()

         ENDIF

      ELSE

         AHP63S()
         __DBCOPYST("&ZDIS\&WDIRECTO\&WNUEVO", {})
         DBCLOSEARE()

      ENDIF

      ESPERE()
      AHP63E()
      MEMVAR->WANOV := 2000 + VAL(WANO)
      DBEVAL({||DBDELETE()}, {||NUMORD > WORDINI - 1 .AND. NUMORD < ;
            WORDFIN + 1 .AND. YEAR(FECHA) = WANOV}, NIL, NIL, NIL, .F.)
      MEMVAR->WAB := "BASURA.DBF"
      BA()
      __DBCOPY("C:\BASURA", {}, {||DELETED()}, NIL, NIL, NIL, .F., NIL)
      __DBPACK()
      DBCLOSEARE()
      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\&WNUEVO", NIL, NIL, .F.)
      __DBAPP("C:\BASURA", {}, NIL, NIL, NIL, NIL, .F., NIL)
      DBEVAL({||DBRECALL()}, NIL, NIL, NIL, NIL, .F.)
      DBCLOSEARE()
      MEMVAR->OPC := "N"
      SCROLL(7, 1, 23, 78)
      SETPOS(7, 1)
      DEVPOS(14, 20)
      DEVOUT("TIENE MAS PARA ELIMINAR ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "N"

         MEMVAR->OPC := "*"

      ENDIF

   ENDDO

   MEMVAR->OPC := " "
   AHP63E()
   __DBPACK()
   DBCLOSEARE()

RETURN 

