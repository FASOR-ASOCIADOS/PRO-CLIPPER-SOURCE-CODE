/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LISINS
   Params: None.
   Return: Undefined
  Example: LISINS()
  ..........................................................................
*/

PROCEDURE LISINS()

   MEMVAR->OPC := " "
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
      DEVPOS(12, 20)
      DEVOUT("POR FAVOR DEME LA FECHA PARA REGRESAR ")
      __RUN("DATE")
      RETURN 

   ENDIF

   ESPERE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   AMAINS()
   __DBSORT("C:\PROTMP\BASURA", {"LINEA", "CODNUM", "NUMCOLOR"}, {||CODNUM > ;
         WDESDE - 1 .AND. CODNUM < WHASTA + 1}, NIL, NIL, NIL, .F.)
   DBCLOSEARE()
   PIDEIMP()
   __RUN("MODE LPT1:132")
   __RUN("MODE LPT1:132")
   __RUN("MODE LPT1:132")
   __RUN("MODE LPT1:132")
   __RUN("MODE LPT1:132")
   __RUN("MODE LPT1:132")
   __RUN("MODE LPT1:132")
   __RUN("MODE LPT1:132")
   DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)
   SET(3, 2)
   SET(1, "ON")

   IF WDETTOT = "D"

      __REPORTFO("LISINS", .T., NIL, .F., NIL, NIL, NIL, NIL, .F., .F., ;
            NIL, .F., .F.)

   ELSE

      __REPORTFO("LISINS", .T., NIL, .F., NIL, NIL, NIL, NIL, .F., .F., ;
            NIL, .F., .T.)

   ENDIF

   __REPORTFO("LISINSSP", .T., NIL, .F., {||LINEA <> 11}, NIL, NIL, NIL, ;
         .F., .F., NIL, .F., .T.)
   __EJECT()
   SET(1, "OFF")
   DBCLOSEARE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   __RUN("MODE LPT1:80,6")
   MEMVAR->OPC := " "

RETURN 

