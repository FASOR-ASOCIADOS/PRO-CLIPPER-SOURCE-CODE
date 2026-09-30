/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LICOMP
   Params: None.
   Return: Undefined
  Example: LICOMP()
  ..........................................................................
*/

PROCEDURE LICOMP()

   MEMVAR->OPC := " "
   ESPERE()
   AMVCOSE()
   MEMVAR->WAB := "BASURA.NTX"
   BA()
   DBEVAL({||FIELD->NUMORD := VAL(NUMORDPR), FIELD->CODNUM := VAL(CODIGO)}, ;
         NIL, NIL, NIL, NIL, .F.)
   DBCREATEIN("C:\PROTMP\BASURA", "NUMORD", {||NUMORD}, NIL)
   DBCLOSEARE()
   AMVCOSS()
   ORDLISTCLE()
   ORDLISTADD("C:\PROTMP\BASURA")
   MEMVAR->OPC := " "
   MENU()
   DEVPOS(5, 30)
   DEVOUT("COSTOS DE PRODUCCION")
   DBGOTOP()
   MEMVAR->WDESDE := NUMORD
   DBGOBOTTOM()
   MEMVAR->WHASTA := NUMORD
   DEVPOS(12, 20)
   DEVOUT("NUMERO DE ORDEN PARA INICIO ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WDESDE", "@Z 999999", NIL, NIL):DISPLAY())
   DEVPOS(13, 20)
   DEVOUT("NUMERO DE ORDEN PARA FINAL  ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WHASTA", "@Z 999999", NIL, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF WDESDE = 0

      MEMVAR->OPC := "*"

   ENDIF

   __DBLOCATE({||NUMORD > WDESDE - 1 .AND. NUMORD < WHASTA + 1}, NIL, NIL, ;
         NIL, .F.)

   IF EOF()

      DBCLOSEARE()
      MEMVAR->OPC := " "
      DEVPOS(13, 20)
      DEVOUT("RANGO EN BLANCO ")
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      SCROLL(12, 20, 14, 78)
      MEMVAR->WAB := ( SETPOS(12, 20), "BASURA.NTX" )
      BA()
      RETURN 

   ENDIF

   PIDEIMP()
   __REPORTFO("LICOMP", .T., NIL, .F., {||NUMORD > WDESDE - 1 .AND. NUMORD ;
         < WHASTA + 1}, NIL, NIL, NIL, .F., .F., NIL, .F., .F.)
   MEMVAR->OPC := " "
   DBCLOSEARE()
   MEMVAR->WAB := "BASURA.NTX"
   BA()

RETURN 

