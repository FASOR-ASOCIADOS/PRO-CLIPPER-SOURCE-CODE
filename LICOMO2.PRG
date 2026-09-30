/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LICOMO2
   Params: None.
   Return: Undefined
  Example: LICOMO2()
  ..........................................................................
*/

PROCEDURE LICOMO2()

   MEMVAR->OPC := " "
   DBCLOSEALL()

   DO WHILE OPC <> "*"

      MEMVAR->OPC := " "
      MENU()
      DEVPOS(5, 30)
      DEVOUT("COSTOS DE PRODUCCION")
      MEMVAR->WNUMORDI := MEMVAR->WNUMORDT := 0
      DEVPOS(12, 20)
      DEVOUT("NUMERO DE ORDEN PARA INICIO ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WNUMORDI", "@# 999999", NIL, NIL):DISPLAY();
            )
      DEVPOS(13, 20)
      DEVOUT("NUMERO DE ORDEN PARA FIN    ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WNUMORDT", "@# 999999", NIL, NIL):DISPLAY();
            )
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WNUMORDI = 0

         MEMVAR->OPC := "*"
         LOOP

      ENDIF

      ESPERE()
      MEMVAR->WAB := "FILETEMP.DBF"
      BA()
      AMOPAS()
      __DBSORT("C:\PROTMP\FILETEMP", {"NUMORD", "NUMOPE", "FECHA"}, {||NUMORD > ;
            WNUMORDI - 1 .AND. NUMORD < WNUMORDT + 1}, NIL, NIL, NIL, .F.)
      DBCLOSEARE()
      DBUSEAREA(.F., NIL, "C:\PROTMP\FILETEMP", NIL, NIL, .F.)

      IF LASTREC() < 1

         MEMVAR->OPC := " "
         DEVPOS(14, 20)
         DEVOUT("RANGO DE ORDENES EN BLANCO")
         DEVPOS(15, 20)
         DEVOUT("TIENE MAS PARA IMPRIMIR ? S/N ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         SCROLL(12, 20, 14, 78)
         SETPOS(12, 20)

         IF OPC = "N"

            MEMVAR->OPC := "*"

         ENDIF

         LOOP

      ENDIF

      MEMVAR->OPC := " "
      PIDEIMP()
      __RUN("MODE LPT1:132")
      SETCOLOR("+W")
      __REPORTFO("LICOMO", .T., NIL, .F., NIL, NIL, NIL, NIL, .F., .F., ;
            NIL, .F., .F.)
      DBCLOSEARE()
      __RUN("MODE LPT1:80")
      MENU()
      MEMVAR->OPC := "N"
      DEVPOS(14, 20)
      DEVOUT("TIENE MAS PARA IMPRIMIR ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "N"

         MEMVAR->OPC := "*"

      ENDIF

   ENDDO

   MEMVAR->OPC := " "
   DBCLOSEARE()
   DBCLOSEALL()
   MEMVAR->WAB := "FILETEMP.DBF"
   BA()

RETURN 

