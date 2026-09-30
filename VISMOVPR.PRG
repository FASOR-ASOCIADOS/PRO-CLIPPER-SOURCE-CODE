/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: VISMOVPR
   Params: None.
   Return: Undefined
  Example: VISMOVPR()
  ..........................................................................
*/

PROCEDURE VISMOVPR()

   MEMVAR->OPC := " "
   MEMVAR->WPERI := "S"
   MEMVAR->WTODCOD := "T"
   MEMVAR->WTODTIP := "T"
   MEMVAR->WTODDOC := "T"
   MENU()
   DEVPOS(12, 10)
   DEVOUT("Consulta el mov. <S>emanal o el <M>ensual ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WPERI", "@!", {||WPERI $ "SM"}, NIL):DISPLAY();
         )
   DEVPOS(13, 10)
   DEVOUT("         <T>odos los codigos o <U>no solo ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WTODCOD", "@!", {||WTODCOD $ "TU"}, NIL);
         :DISPLAY())
   DEVPOS(14, 10)
   DEVOUT("    <T>odos los tip. de mov. o <U>no solo ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WTODTIP", "@!", {||WTODTIP $ "TU"}, NIL);
         :DISPLAY())
   DEVPOS(15, 10)
   DEVOUT("      <T>odos los documentos o <U>no solo ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WTODDOC", "@!", {||WTODDOC $ "TU"}, NIL);
         :DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF WTODCOD = "U"

      MEMVAR->WCOD := SPACE(4)
      DEVPOS(15, 10)
      DEVOUT("CUAL CODIGO ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCOD", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

   ENDIF

   IF WTODTIP = "U"

      MEMVAR->WTIP := "  "
      DEVPOS(16, 10)
      DEVOUT("QUE TIPO DE MOVIMIENTO ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WTIP", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

   ENDIF

   IF WTODDOC = "U"

      MEMVAR->WNUMDOC := "       "
      DEVPOS(17, 10)
      DEVOUT("QUE NUMERO DE DOCUMENTO ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WNUMDOC", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

   ENDIF

   ESPERE()

   IF WPERI = "S"

      AMVPRSS()

   ELSE

      MENU()
      AMOVMESS()

   ENDIF

   MEMVAR->WAB := "BASURA.DBF"
   BA()
   __DBCOPY("C:\PROTMP\BASURA", {}, NIL, NIL, NIL, NIL, .F., NIL)
   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, .F., .F.)

   IF WTODCOD <> "T"

      DBEVAL({||DBDELETE()}, {||CODIGO <> WCOD}, NIL, NIL, NIL, .F.)

   ENDIF

   IF WTODTIP <> "T"

      DBEVAL({||DBDELETE()}, {||TIPOMOV <> WTIP}, NIL, NIL, NIL, .F.)

   ENDIF

   IF WTODCOD = "U" .OR. WTODTIP <> "U" .OR. WTODDOC = "U"

      SET(11, "ON")

   ENDIF

   IF WTODTIP = "U" .AND. WTODDOC = "U"

      MEMVAR->WD := ALLTRIM(WNUMDOC)
      DBEVAL({||DBDELETE()}, {||SUBSTR(NUMDOC, 1, LEN(WD)) <> WD}, NIL, ;
            NIL, NIL, .F.)
      DBEVAL({||DBDELETE()}, {||TIPOMOV <> WTIP}, NIL, NIL, NIL, .F.)
      MEMVAR->WTV := MEMVAR->WTC := 0
      MEMVAR->WTC := 0
      DBEVAL({||MEMVAR->WTC := WTC + CANTIDAD}, NIL, NIL, NIL, NIL, .F.)
      MEMVAR->WTV := 0
      DBEVAL({||MEMVAR->WTV := WTV + VALTOT}, NIL, NIL, NIL, NIL, .F.)

   ENDIF

   DBGOTOP()
   MEMVAR->WFECHA := DATE()
   DEVPOS(18, 10)
   DEVOUT("EN QUE FECHA LO UBICO ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WFECHA", NIL, NIL, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   __DBLOCATE({||FECHA = WFECHA}, NIL, NIL, NIL, .F.)

   IF EOF()

      DBGOTOP()

   ENDIF

   MENU()

   IF WPERI = "M"

      MEMVAR->WT1 := "VISUALIZACION DE MOVIMIENTOS DE INSUMOS DEL MES "

   ELSE

      MEMVAR->WT1 := "VISUALIZACION DE MOVIMIENTOS DE INSUMOS DE LA SEMANA"

   ENDIF

   DEVPOS(5, 1)
   DEVOUT(PADC(WT1, 78))
   SETCOLOR("+GR")
   DEVPOS(7, 1)
   DEVOUT(;
         "CONS. COD. NOMBRE               DOCUM.  V. UNIT   V. TOT. CANT.  DIA T.MOV O.P.";
         )

   IF WTODTIP = "U" .AND. WTODDOC = "U"

      SETCOLOR("+G")
      DEVPOS(8, 10)
      DEVOUT("TOTALES PARA EL DOCUMENTO : unidades: " + ALLTRIM(TRANSFORM(;
            WTC, "999,999,999")) + "   Valor: $" + ALLTRIM(TRANSFORM(WTV, ;
            "9999,999,999.99")))
      SETCOLOR("+GR")
      DEVPOS(9, 1)
      DEVOUT(;
            "----- ---- -------------------- ------- -------- -------- ------  --   -- -----";
            )
      MEMVAR->CL := 10

   ELSE

      DEVPOS(8, 1)
      DEVOUT(;
            "----- ---- -------------------- ------- -------- -------- ------  --   -- -----";
            )
      MEMVAR->CL := 9

   ENDIF

   SETCOLOR("+W")
   MEMVAR->SWCO := 0

   DO WHILE OPC <> "T"

      IF SWCO = 0

         MEMVAR->SWCO := 1
         SETCOLOR("+W")

      ELSE

         SETCOLOR("W")
         MEMVAR->SWCO := 0

      ENDIF

      DEVPOS(CL, 1)
      DEVOUTPICT(RECNO(), "@Z 99999")
      DEVPOS(CL, 7)
      DEVOUT(CODIGO)
      DEVPOS(CL, 12)
      DEVOUT(SUBSTR(NOMINS, 1, 17))
      DEVPOS(CL, 30)
      DEVOUT(NUMDOC)
      DEVPOS(CL, 38)
      DEVOUTPICT(VALUNI, "@Z 999999.9")
      DEVPOS(CL, 47)
      DEVOUTPICT(VALTOT, "@Z 99999999.99")
      DEVPOS(CL, 59)
      DEVOUTPICT(CANTIDAD, "@Z 999999")
      DEVPOS(CL, 67)
      DEVOUTPICT(DAY(FECHA), "@Z 99")
      DEVPOS(CL, 72)
      DEVOUT(TIPOMOV)
      DEVPOS(CL, 75)
      DEVOUT(SUBSTR(NUMORDPRO, 1, 5))
      SETCOLOR("+W")
      DBSKIP(1)

      IF  .NOT. EOF()

         MEMVAR->CL := MEMVAR->CL + 1

         IF CL = 22

            MEMVAR->OPC := "T"
            SETCOLOR("+G")
            DEVPOS(23, 10)
            DEVOUT("<A>delanta, <R>etrocede, <T>ermina ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "ART"}, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            SETCOLOR("+W")

            IF OPC = "T"

               LOOP

            ENDIF

            MEMVAR->CL := 10
            SCROLL(CL, 1, 23, 78)
            SETPOS(CL, 1)

            IF OPC = "A"

               LOOP

            ENDIF

            IF OPC = "R"

               DBSKIP(-24)
               LOOP

            ENDIF

         ELSE

            LOOP

         ENDIF

      ELSE

         MEMVAR->OPC := "T"
         SETCOLOR("+G")
         DEVPOS(23, 15)
         DEVOUT("<R>etrocede, <T>ermina ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "RT"}, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         SETCOLOR("+W")

         IF OPC = "T"

            LOOP

         ENDIF

         MEMVAR->CL := 10
         SCROLL(CL, 1, 23, 78)
         SETPOS(CL, 1)

         IF OPC = "R"

            DBSKIP(-24)
            LOOP

         ENDIF

      ENDIF

   ENDDO

   DBCLOSEARE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->OPC := " "

RETURN 

