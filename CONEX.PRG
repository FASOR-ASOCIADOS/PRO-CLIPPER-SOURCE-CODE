/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: CONEX
   Params: None.
   Return: Undefined
  Example: CONEX()
  ..........................................................................
*/

PROCEDURE CONEX()

   MENU()
   DEVPOS(4, 1)
   DEVOUT(PADC("INFORME DE PAGOS DE TAREAS EXCEDIDOS EN CANTIDADES", 78))
   MEMVAR->WTODOPE := MEMVAR->WTODTAR := MEMVAR->WTODORD := MEMVAR->WSOR := ;
         MEMVAR->WSAL := MEMVAR->WSOL := " "
   DEVPOS(12, 15)
   DEVOUT("<T>odos los operarios o <U>no solo ?     ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WTODOPE", "@!", {||WTODOPE $ "TU"}, NIL);
         :DISPLAY())
   DEVPOS(13, 15)
   DEVOUT("   <T>odas las tareas o <U>na sola ?     ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WTODTAR", "@!", {||WTODTAR $ "TU"}, NIL);
         :DISPLAY())
   DEVPOS(14, 15)
   DEVOUT("  <T>odas las ordenes o un <R>ango ?     ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WTODORD", "@!", {||WTODORD $ "TR"}, NIL);
         :DISPLAY())
   DEVPOS(15, 15)
   DEVOUT("Ordenado por <O>perario, <T>area o <N>um. de O.P. ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WSOR", "@!", {||WSOR $ "TON"}, NIL):DISPLAY())
   DEVPOS(16, 15)
   DEVOUT("<T>odo lo acumulado o <S>olo lo excedido?")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WSOL", "@!", {||WSOL $ "TS"}, NIL):DISPLAY())
   DEVPOS(17, 10)
   DEVOUT("por <P>antalla o por <I>mpresora ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WSAL", "@!", {||WSAL $ "PI"}, NIL):DISPLAY())
   SETCOLOR("+G")
   DEVPOS(18, 50)
   DEVOUT("ESC para cancelar ")
   SETCOLOR("+W")
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF LASTKEY() = 27

      MEMVAR->OPC := 1
      RETURN 

   ENDIF

   MEMVAR->WOPE := MEMVAR->WTAR := "  "
   MEMVAR->WORDD := MEMVAR->WORDH := 0
   MEMVAR->WTITU := "PAGOS "

   IF WTODOPE = "U"

      DEVPOS(12, 60)
      DEVOUT("Cual ?")
      MEMVAR->WTITU := ( SETPOSBS(), AADD(GETLIST, __GET(NIL, "WOPE", NIL, ;
            NIL, NIL):DISPLAY()), MEMVAR->WTITU + "UN OPERARIO " )

   ELSE

      MEMVAR->WTITU := MEMVAR->WTITU + "DE LOS OPERARIOS,"

   ENDIF

   IF WTODTAR = "U"

      DEVPOS(13, 60)
      DEVOUT("Cual ?")
      MEMVAR->WTITU := ( SETPOSBS(), AADD(GETLIST, __GET(NIL, "WTAR", NIL, ;
            NIL, NIL):DISPLAY()), MEMVAR->WTITU + "UNA TAREA," )

   ELSE

      MEMVAR->WTITU := MEMVAR->WTITU + "TODAS LAS TAREAS,"

   ENDIF

   IF WTODORD = "R"

      DEVPOS(14, 60)
      DEVOUT("Del")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WORDD", "@Z 999999", NIL, NIL):DISPLAY())
      DEVPOS(14, 71)
      DEVOUT("Al")
      MEMVAR->WTITU := ( SETPOSBS(), AADD(GETLIST, __GET(NIL, "WORDH", ;
            "@Z 999999", NIL, NIL):DISPLAY()), MEMVAR->WTITU + "UNA O.P.," )

   ELSE

      MEMVAR->WTITU := MEMVAR->WTITU + "TODAS LAS O.P.,"

   ENDIF

   IF WSOL = "S"

      MEMVAR->WTITU := MEMVAR->WTITU + "SOLO PAGOS EXCEDIDOS"

   ELSE

      MEMVAR->WTITU := MEMVAR->WTITU + "ACUMULADO DE PAGOS"

   ENDIF

   IF WTODOPE = "U" .OR. WTODTAR = "U" .OR. WTODORD = "R"

      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

   ELSE

      READKILL(.T.)
      MEMVAR->GETLIST := {}

   ENDIF

   MEMVAR->WAB := "BASURA.DBF"
   BA()
   ADEMASS()

   IF WSOR = "T"

      __DBSORT("C:\BASURA", {"CODTAR", "CODOPE", "LETORD"}, NIL, NIL, NIL, ;
            NIL, .F.)

   ELSEIF WSOR = "O"

      __DBSORT("C:\BASURA", {"CODOPE", "CODTAR", "LETORD"}, NIL, NIL, NIL, ;
            NIL, .F.)

   ELSEIF WSOR = "N"

      __DBSORT("C:\BASURA", {"LETORD", "CODOPE", "CODTAR"}, NIL, NIL, NIL, ;
            NIL, .F.)

   ENDIF

   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
   DBEVAL({||FIELD->EXCEDE := PAGADAS - MAXIMO}, NIL, NIL, NIL, NIL, .F.)

   IF WSOL = "S"

      DBEVAL({||DBDELETE()}, {||EXCEDE < 1}, NIL, NIL, NIL, .F.)

   ENDIF

   IF WTODOPE <> "T"

      DBEVAL({||DBDELETE()}, {||CODOPE <> WOPE}, NIL, NIL, NIL, .F.)

   ENDIF

   IF WTODTAR <> "T"

      DBEVAL({||DBDELETE()}, {||CODTAR <> WTAR}, NIL, NIL, NIL, .F.)

   ENDIF

   IF WTODORD <> "T"

      DBEVAL({||DBDELETE()}, {||NUMORD < WORDD .OR. NUMORD > WORDH}, NIL, ;
            NIL, NIL, .F.)

   ENDIF

   __DBPACK()
   DBGOTOP()
   SCROLL(12, 1, 23, 78)
   SETPOS(12, 1)

   IF WSAL = "I"

      DEVPOS(12, 10)
      DEVOUT("Aliste la impresora y pulse alguna tecla, ESC para cancelar")
      MEMVAR->X := INKEY(0)
      VEAIMP()
      ENIM()
      MEMVAR->WTOPE := 55

   ELSE

      SCROLL()
      SETPOS(0, 0)
      READKILL(.T.)
      MEMVAR->GETLIST := {}
      MEMVAR->WTOPE := 21

   ENDIF

   MEMVAR->CL := MEMVAR->CP := 0
   MEMVAR->WRAYA := REPLICATE("-", 80)

   DO WHILE  .NOT. EOF() .AND. INKEY() <> 27

      IF CL = 0

         MEMVAR->CP := MEMVAR->CP + 1
         DEVPOS(CL, 0)
         DEVOUT(WRAYA)
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 0)
         DEVOUT(PADC(RAZON, 80))
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 0)
         DEVOUT(PADC(WTITU, 80))
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 0)
         DEVOUT("INFORME A:" + DTOC(DATE()))
         DEVPOS(CL, 0)
         DEVOUT(PADR("P" + A + "gina #" + ALLTRIM(TRANSFORM(CP, "99")), 80);
               )
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 7)
         DEVOUT("O.P.     TAREA  MAXIMO   PAGADO  EXCEDIDO EN   OPERARIO")
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 0)
         DEVOUT(WRAYA)
         MEMVAR->CL := MEMVAR->CL + 1

      ENDIF

      MEMVAR->WCODOPE := CODOPE
      MEMVAR->WNOM := "NOMBRE ???"
      MEMVAR->WAPE := "APELLIDO ?"
      AMAPERS()
      __DBLOCATE({||CODIGO = WCODOPE}, NIL, NIL, NIL, .F.)

      IF  .NOT. EOF()

         MEMVAR->WNOM := SUBSTR(NOM, 1, 10)
         MEMVAR->WAPE := SUBSTR(APE, 1, 10)

      ENDIF

      DBCLOSEARE()
      DBSELECTAR("21")

      IF EXCEDE > 0

         DEVPOS(CL, 7)
         DEVOUT(LETORD + "  " + CODTAR + "   " + TRANSFORM(MAXIMO, ;
               "999,999") + "   " + TRANSFORM(PAGADAS, "999,999") + "    " ;
               + TRANSFORM(EXCEDE, "999,999") + "     " + CODOPE + " " + ;
               WNOM + " " + WAPE)

      ELSE

         DEVPOS(CL, 7)
         DEVOUT(LETORD + "  " + CODTAR + "   " + TRANSFORM(MAXIMO, ;
               "999,999") + "   " + TRANSFORM(PAGADAS, "999,999") + ;
               "                " + CODOPE + " " + WNOM + " " + WAPE)

      ENDIF

      DBSKIP(1)
      MEMVAR->CL := MEMVAR->CL + 1

      IF CL > WTOPE

         IF WSAL = "P"

            DEVPOS(23, 1)
            DEVOUT(PADC("Lea y pulse alguna tecla, ESC para terminar", 80))
            MEMVAR->X := INKEY(0)
            SCROLL()
            SETPOS(0, 0)
            READKILL(.T.)
            MEMVAR->GETLIST := {}

            IF LASTKEY() = 27

               EXIT

            ENDIF

         ELSE

            DEVPOS(CL, 0)
            DEVOUT(WRAYA)

         ENDIF

         MEMVAR->CL := 0

      ENDIF

   ENDDO

   IF  .NOT. EOF()

      MEMVAR->CL := MEMVAR->CL + 1
      DEVPOS(CL, 1)
      DEVOUT("*** CANCELADO, REPORTE INCOMPLETO")
      MEMVAR->CL := MEMVAR->CL + 1

   ENDIF

   IF WSAL = "I"

      DEVPOS(CL, 1)
      DEVOUT(DTOC(DATE()) + " - " + TIME())
      APIM()

   ELSE

      DEVPOS(23, 1)
      DEVOUT(PADC("Lea y pulse alguna tecla, ESC para terminar", 80))
      MEMVAR->X := INKEY(0)

   ENDIF

   DBCLOSEARE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->OPC := 1

RETURN 

