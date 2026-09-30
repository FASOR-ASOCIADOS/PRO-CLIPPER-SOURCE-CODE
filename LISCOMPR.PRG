/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LISCOMPR
   Params: None.
   Return: Undefined
  Example: LISCOMPR()
  ..........................................................................
*/

PROCEDURE LISCOMPR()

   MENU()
   DEVPOS(3, 1)
   DEVOUT(PADC("LISTADO DE COMPRAS Y OTRAS ENTRADAS", 78))
   MEMVAR->OPC := " "
   DEVPOS(12, 20)
   DEVOUT("Por medio de esta opcion se obtiene el listado de")
   DEVPOS(13, 20)
   DEVOUT("COMPRAS Y OTRAS ENTRADAS de materia prima.")
   DEVPOS(14, 20)
   DEVOUT("desea continuar ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC <> "S"

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   MENU()
   AMAINS()
   MEMVAR->WDESDE := CODNUM
   DBGOBOTTOM()
   MEMVAR->WHASTA := CODNUM
   DBCLOSEARE()
   MEMVAR->WDETTOT := " "
   DEVPOS(12, 20)
   DEVOUT("DESDE QUE CODIGO LISTO ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WDESDE", "@Z 999999", NIL, NIL):DISPLAY())
   DEVPOS(13, 20)
   DEVOUT("HASTA QUE CODIGO LISTO ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WHASTA", "@Z 999999", NIL, NIL):DISPLAY())
   DEVPOS(14, 20)
   DEVOUT("<D>etallado o solo <T>otales ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WDETTOT", "@!", {||WDETTOT $ "DT"}, NIL);
         :DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF WDESDE = 0

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   ESPERE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   AMAINS()
   __DBSORT("C:\PROTMP\BASURA", {"LINEA", "CODNUM"}, {||CODNUM > WDESDE - 1 .AND. ;
         CODNUM < WHASTA + 1}, NIL, NIL, NIL, .F.)
   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)
   PIDEIMP()
   __RUN("MODE LPT1:132")

   IF WDETTOT = "D"

      __REPORTFO("LISCOMPR", .T., NIL, .F., NIL, NIL, NIL, NIL, .F., .F., ;
            NIL, .F., .F.)

   ELSE

      __REPORTFO("LISCOMPR", .T., NIL, .F., NIL, NIL, NIL, NIL, .F., .F., ;
            NIL, .F., .T.)

   ENDIF

   DBCLOSEARE()
   __EJECT()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->OPC := " "
   __RUN("MODE LPT1:80")

RETURN 

