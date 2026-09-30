/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LISCONPR
   Params: None.
   Return: Undefined
  Example: LISCONPR()
  ..........................................................................
*/

PROCEDURE LISCONPR()

   MENU()
   DEVPOS(3, 20)
   DEVOUT("LISTADO DE CONSUMO DE PRODUCCION")
   MEMVAR->OPC := " "
   DEVPOS(12, 20)
   DEVOUT("Por medio de esta opcion se obtiene el listado de")
   DEVPOS(13, 20)
   DEVOUT("CONSUMO DE MATERIA PRIMA.")
   DEVPOS(14, 20)
   DEVOUT("desea continuar ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   SCROLL(12, 20, 15, 78)
   SETPOS(12, 20)

   IF OPC <> "S"

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   MEMVAR->OPC := " "
   DEVPOS(12, 20)
   DEVOUT("<D>iscriminado o <T>otales ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "DT"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   SCROLL(12, 20, 15, 78)
   SETPOS(12, 20)

   IF OPC = "D"

      MEMVAR->WDESDE := MEMVAR->WHASTA := 0
      DEVPOS(12, 20)
      DEVOUT("DESDE QUE CODIGO LISTO ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WDESDE", "@Z 999999", NIL, NIL):DISPLAY())
      DEVPOS(13, 20)
      DEVOUT("HASTA QUE CODIGO LISTO ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WHASTA", "@Z 999999", NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WDESDE = 0

         MEMVAR->OPC := " "
         RETURN 

      ENDIF

      AMAINS()
      ESPERE()
      __DBSORT("C:\PROTMP\BASURA.DBF", {"LINEA", "CODNUM"}, {||CODNUM > WDESDE - ;
            1 .AND. CODNUM < WHASTA + 1}, NIL, NIL, NIL, .F.)
      DBCLOSEARE()
      SETCOLOR("+W")
      DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)
      PIDEIMP()
      __RUN("MODE LPT1:132")
      __REPORTFO("LISCONPR", .T., NIL, .F., NIL, NIL, NIL, NIL, .F., .F., ;
            NIL, .F., .F.)
      __REPORTFO("LISCONPX", .T., NIL, .F., {||LINEA <> 11}, NIL, NIL, NIL,;
             .F., .F., NIL, .F., .T.)
      __EJECT()
      DBCLOSEARE()
      FERASE("&ZDIS\&WDIRECTO\BASURA.DBF")
      __RUN("MODE LPT1:80")
      MEMVAR->OPC := " "

   ELSEIF OPC = "T"

      AMAINS()
      PIDEIMP()
      __RUN("MODE LPT1:132")
      __REPORTFO("LISCOPRT", .T., NIL, .F., NIL, NIL, NIL, NIL, .F., .F., ;
            NIL, .F., .T.)
      __REPORTFO("LISCONPX", .T., NIL, .F., {||LINEA <> 11}, NIL, NIL, NIL,;
             .F., .F., NIL, .F., .T.)
      __EJECT()
      DBCLOSEARE()
      __RUN("MODE LPT1:80")
      MEMVAR->OPC := " "

   ENDIF

   MEMVAR->WAB := "BASURA.DBF"
   BA()

RETURN 

