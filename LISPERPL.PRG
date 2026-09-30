/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LISPERPL
   Params: None.
   Return: Undefined
  Example: LISPERPL()
  ..........................................................................
*/

PROCEDURE LISPERPL()

   MEMVAR->OPC := " "
   MENU()
   DEVPOS(12, 20)
   DEVOUT("POR MEDIO DE ESTA OPCION SE OBTIENE UN LISTADO")
   DEVPOS(13, 20)
   DEVOUT("CON LOS DATOS  PERSONALES  DE LOS OPERARIOS DE")
   DEVPOS(14, 20)
   DEVOUT("LA PLANTA.")
   SETCOLOR("+GR")
   DEVPOS(16, 20)
   DEVOUT("Desea continuar ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   SETCOLOR("W")

   IF OPC <> "S" .OR. LASTKEY() = 27

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   SCROLL(12, 20, 18, 78)
   MEMVAR->OPC := ( SETPOS(12, 20), " " )
   DEVPOS(12, 20)
   DEVOUT("Ordenado por <C>odigo, <A>pellido o <P>untaje ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "CAP"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   AMAPERS()

   IF OPC = "A"

      __DBSORT("C:\PROTMP\BASURA", {"APE", "NOM"}, NIL, NIL, NIL, NIL, .F.)

   ELSEIF OPC = "P"

      __DBSORT("C:\PROTMP\BASURA", {"PUNTOS", "APE", "NOM"}, NIL, NIL, NIL, NIL, ;
            .F.)

   ELSE

      __DBSORT("C:\PROTMP\BASURA", {"CODOPE", "APE"}, NIL, NIL, NIL, NIL, .F.)

   ENDIF

   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)
   PIDEIMP()
   __RUN("MODE LPT1:132")
   __REPORTFO("LISPERPL", .T., NIL, .F., NIL, NIL, NIL, NIL, .F., .F., NIL,;
          .F., .F.)
   DBCLOSEARE()
   __EJECT()
   __RUN("MODE LPT1:80")
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->OPC := " "

RETURN 

