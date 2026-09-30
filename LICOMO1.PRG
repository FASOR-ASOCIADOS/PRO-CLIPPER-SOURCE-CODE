/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LICOMO1
   Params: None.
   Return: Undefined
  Example: LICOMO1()
  ..........................................................................
*/

PROCEDURE LICOMO1()

   MEMVAR->OPC := " "
   DBCLOSEALL()

   DO WHILE OPC <> "*"

      MENU()
      SETCOLOR("+GR")
      DEVPOS(6, 1)
      DEVOUT(PADC("CONSTULTA DE MOVIMIENTOS DE PAGOS DE MANO DE OBRA", 78))
      MEMVAR->OPC := " "
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
      MEMVAR->WPANIM := " "

      IF WNUMORDI = 0

         MEMVAR->OPC := "*"
         LOOP

      ENDIF

      DEVPOS(14, 20)
      DEVOUT("Por <P>antalla o <I>mpresora ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WPANIM", "@!", {||WPANIM $ "PI"}, NIL);
            :DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      ESPERE()
      AMOPAS()
      MEMVAR->WAB := "FILETEMP.DBF"
      BA()
      __DBSORT("C:\PROTMP\FILETEMP", {"NUMORD", "NUMOPE", "FECHA"}, {||NUMORD > ;
            WNUMORDI - 1 .AND. NUMORD < WNUMORDT + 1}, NIL, NIL, NIL, .F.)
      DBCLOSEARE()
      DBUSEAREA(.F., NIL, "C:\PROTMP\FILETEMP", NIL, NIL, .F.)

      IF LASTREC() < 1

         MEMVAR->OPC := " "
         DEVPOS(13, 20)
         DEVOUT("RANGO DE ORDENES EN BLANCO")
         DEVPOS(14, 20)
         DEVOUT("TIENE MAS ? S/N ")
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

         DBCLOSEARE()
         MEMVAR->WAB := "FILETEMP.DBF"
         BA()
         LOOP

      ENDIF

      MEMVAR->OPC := " "

      IF WPANIM = "P"

         MEMVAR->WTOPE := 22
         SCROLL()
         SETPOS(0, 0)
         READKILL(.T.)
         MEMVAR->GETLIST := {}

      ELSE

         MENU()
         PIDEIMP()
         MENU()
         ENIM()
         MEMVAR->WTOPE := 55

      ENDIF

      MEMVAR->CL := MEMVAR->CP := MEMVAR->SWCOL := 0

      DO WHILE  .NOT. EOF()

         IF CL = 0

            SETCOLOR("+G")
            MEMVAR->CP := MEMVAR->CP + 1
            DEVPOS(CL, 1)
            DEVOUT(PADC(RAZON, 78))
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 1)
            DEVOUT(PADC("MOVIMIENTOS DE PAGOS EN ORDENES DE PRODUCCION", ;
                  78))
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 1)
            DEVOUT(DATE())
            MEMVAR->WT1 := "Pagina : " + ALLTRIM(TRANSFORM(CP, "999"))
            DEVPOS(CL, 80 - LEN(WT1))
            DEVOUT(WT1)
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 5)
            DEVOUT(;
                  "======   ==========  ======= =======  =======  =======   =======";
                  )
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 5)
            DEVOUT(;
                  "ORDEN       PAGO     MINUTOS  BUENAS   MALAS   PRUEBAS    TOTAL";
                  )
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 5)
            DEVOUT(;
                  "======   ==========  ======= =======  =======  =======   =======";
                  )
            MEMVAR->CL := MEMVAR->CL + 1
            SETCOLOR("+W")

         ENDIF

         MEMVAR->WNUMORD := NUMORD
         MEMVAR->WPAGO := MEMVAR->WMINUTOS := MEMVAR->WBUENAS := MEMVAR->;
               WMALAS := MEMVAR->WPRUEBAS := MEMVAR->WTOTAL := 0
         DEVPOS(CL, 5)
         DEVOUTPICT(WNUMORD, "@Z 999999")

         DO WHILE NUMORD = WNUMORD

            MEMVAR->WPAGO := MEMVAR->WPAGO + PAGO
            MEMVAR->WMINUTOS := MEMVAR->WMINUTOS + MINUTOS
            MEMVAR->WBUENAS := MEMVAR->WBUENAS + BUENAS
            MEMVAR->WMALAS := MEMVAR->WMALAS + MALAS
            MEMVAR->WPRUEBAS := MEMVAR->WPRUEBAS + PRUEBAS
            MEMVAR->WTOTAL := MEMVAR->WTOTAL + TOTAL
            DBSKIP(1)

            IF EOF()

               MEMVAR->WNUMORD := 999999

            ENDIF

         ENDDO

         DEVPOS(CL, 14)
         DEVOUT(TRANSFORM(WPAGO, "99,999,999") + "  " + TRANSFORM(WMINUTOS,;
                "999,999") + " " + TRANSFORM(WBUENAS, "999,999") + "  " + ;
               TRANSFORM(WMALAS, "999,999") + "  " + TRANSFORM(WPRUEBAS, ;
               "999,999") + "   " + TRANSFORM(WTOTAL, "999,999"))
         MEMVAR->CL := MEMVAR->CL + 1
         MEMVAR->WPAGO := MEMVAR->WMINUTOS := MEMVAR->WBUENAS := MEMVAR->;
               WMALAS := MEMVAR->WPRUEBAS := MEMVAR->WTOTAL := 0

         IF CL > WTOPE

            IF WPANIM = "P"

               SETCOLOR("+G")
               DEVPOS(23, 10)
               DEVOUT("LEA Y PULSE ALGUNA TECLA...")
               MEMVAR->X := INKEY(0)
               SETCOLOR("+W")
               SCROLL()
               SETPOS(0, 0)
               READKILL(.T.)
               MEMVAR->GETLIST := {}

            ENDIF

            MEMVAR->CL := 0

         ENDIF

      ENDDO

      DBCLOSEALL()
      MEMVAR->WAB := "FILETEMP.DBF"
      BA()

      IF WPANIM = "P"

         SETCOLOR("+G")
         DEVPOS(23, 10)
         DEVOUT("LEA Y PULSE ALGUNA TECLA...")
         MEMVAR->X := INKEY(0)
         SETCOLOR("+W")

      ELSE

         DEVPOS(CL, 5)
         DEVOUT(;
               "======   ==========  ======= =======  =======  =======   =======";
               )
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 1)
         DEVOUT(DTOC(DATE()) + " / " + TIME())
         __EJECT()
         APIM()

      ENDIF

      MEMVAR->OPC := "N"
      MENU()
      DEVPOS(23, 15)
      DEVOUT("TIENE MAS PARA CONSULTAR ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "N"

         MEMVAR->OPC := "*"

      ENDIF

   ENDDO

   MEMVAR->OPC := " "
   CIERRE()
   DBCLOSEARE()
   MEMVAR->WAB := "FILETEMP.DBF"
   BA()

RETURN 

