/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: GENPAGTA
   Params: None.
   Return: Undefined
  Example: GENPAGTA()
  ..........................................................................
*/

PROCEDURE GENPAGTA()

   MENU()
   CIERRE()
   ESPERE()
   BORPTC()
   BORPER()
   ATAE()
   DBCREATEIN("&ZDIS\&WDIRECTO\PROTARCO", "PROTARCOL", {||PROTARCOL}, NIL)
   DBCLOSEARE()
   ACOSE()
   MEMVAR->WAB := "COSTOS.KEY"
   BA()
   DBCREATEIN("&ZDIS\&WDIRECTO\COSTOS.KEY", "LETORD", {||LETORD}, NIL)
   DBCLOSEARE()
   AMAPERS()
   DBCREATEIN("&ZDIS\&WDIRECTO\COD-PER", "CODIGO", {||CODIGO}, NIL)
   DBCLOSEARE()
   ADEMASE()
   DBCLOSEARE()
   MENU()
   DEVPOS(5, 1)
   DEVOUT(PADC("<<  MANEJO  DE  TAREAS  >>", 78))
   DEVPOS(7, 1)
   DEVOUT(PADC("CREACION DE PAGOS", 78))
   MEMVAR->LINEA := REPLICATE("ß", 17)
   SETCOLOR("+GR")
   DEVPOS(8, 31)
   DEVOUT(LINEA)
   __MRESTORE("&ZDIS\&WDIRECTO\SALMIN", .T.)
   __MRESTORE("&ZDIS\&WDIRECTO\HORWMES", .T.)
   SETCOLOR("+G")
   MEMVAR->WVALHOR := SALMIN / ZHORWMES
   MEMVAR->WNUMORD := 0
   MEMVAR->OPC := " "
   MEMVAR->WOPE := "  "
   MEMVAR->WCODPRO := ZLCPT
   APAMOS()
   MEMVAR->WFECHA := FECHA
   DBCLOSEARE()
   MEMVAR->SWN := 1

   DO WHILE OPC <> "*"

      SET(3, 2)
      SET(2, "ON")
      SETCOLOR("+W")
      SCROLL(10, 1, 23, 78)
      MEMVAR->WCONINI := MEMVAR->WCONFIN := ( SETPOS(10, 1), 0 )

      IF SWN = 1

         MEMVAR->WCODTAR := MEMVAR->WCODMAQ := "  "
         MEMVAR->WMINUTOS := MEMVAR->WBUENAS := MEMVAR->WMALAS := MEMVAR->;
               WPRUEBAS := MEMVAR->WTOTAL := MEMVAR->WCONINI := MEMVAR->;
               WCONFIN := MEMVAR->WPROM := MEMVAR->WWTOT := MEMVAR->WTARMAX ;
               := 0

      ENDIF

      MEMVAR->WCANXUNI := 0
      SETCOLOR("+G")
      DEVPOS(10, 60)
      DEVOUT("S/MINIMO ")
      DEVPOS(10, COL())
      DEVOUTPICT(SALMIN, "@# 999,999.99")
      DEVPOS(11, 60)
      DEVOUT("Vr./Hora ")
      DEVPOS(11, COL())
      DEVOUTPICT(WVALHOR, "@# 9,999.99")
      DEVPOS(22, 36)
      DEVOUT("ESC para salir")
      SETCOLOR("+W")

      IF YEAR(WFECHA) < 2000

         MEMVAR->WFECHA := DATE()
         DEVPOS(10, 15)
         DEVOUT("A. FECHA         ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WFECHA", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         MEMVAR->SWFF := 0

      ELSE

         DEVPOS(10, 15)
         DEVOUT("A. FECHA         ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WFECHA", NIL, NIL, NIL):DISPLAY())
         READKILL(.T.)
         MEMVAR->GETLIST := {}
         MEMVAR->SWFF := 1

      ENDIF

      DEVPOS(11, 15)
      DEVOUT("B. COD. OPERARIO ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WOPE", NIL, NIL, NIL):DISPLAY())
      DEVPOS(12, 15)
      DEVOUT("C. NUMERO DE O.P.")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WNUMORD", "@# 99999", NIL, NIL):DISPLAY())
      DEVPOS(13, 15)
      DEVOUT("D. COD. DE P.T.  ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCODPRO", "@!", NIL, NIL):DISPLAY())
      DEVPOS(14, 15)
      DEVOUT("E. COD. DE LABOR ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCODTAR", "@!", NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WOPE = "  " .OR. LASTKEY() = 27

         MEMVAR->OPC := "*"
         LOOP

      ENDIF

      AMAPERS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\COD-PER")
      DBSEEK("&WOPE")

      IF EOF()

         DBCLOSEARE()
         DEVPOS(11, 45)
         DEVOUT("NO EXISTE")
         MEMVAR->X := INKEY(0)
         LOOP

      ENDIF

      MEMVAR->WPUNTOS := PUNTOS
      DBCLOSEARE()
      MEMVAR->WCONTSN := "S"
      MEMVAR->KEY := TRIM(WCODPRO) + TRIM(WCODTAR)
      MEMVAR->KEY := KEY + REPLICATE("*", 7 - LEN(KEY))
      ATAS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\PROTARCO")
      DBSEEK("&KEY")

      IF EOF()

         DBCLOSEARE()
         SETCOLOR("+GR/R")
         DEVPOS(23, 20)
         DEVOUT("ESE PRODUCTO CON ESA TAREA NO EXISTE")
         MEMVAR->X := INKEY(0)
         MEMVAR->OPC := " "
         LOOP

      ENDIF

      MEMVAR->WCONTSN := CONTADORES
      DBCLOSEARE()
      DEVPOS(15, 15)
      DEVOUT("F. MINUTOS       ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WMINUTOS", "@Z 999,999.99", NIL, NIL);
            :DISPLAY())
      DEVPOS(16, 15)
      DEVOUT("G. BUENAS        ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WBUENAS", "@Z 999,999.99", NIL, NIL);
            :DISPLAY())
      DEVPOS(17, 15)
      DEVOUT("H. MALAS         ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WMALAS", "@Z 999,999.99", NIL, NIL);
            :DISPLAY())
      DEVPOS(18, 15)
      DEVOUT("I. PRUEBAS       ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WPRUEBAS", "@Z 999,999.99", NIL, NIL);
            :DISPLAY())
      DEVPOS(19, 15)
      DEVOUT("J. C/INICIAL     ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCONINI", "@Z 999,999.99", {||WCONINI > 0},;
             {||WCONTSN <> "N"}):DISPLAY())
      DEVPOS(20, 15)
      DEVOUT("K. C/FINAL       ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCONFIN", "@Z 999,999.99", {||WCONFIN > 0},;
             {||WCONTSN <> "N"}):DISPLAY())
      DEVPOS(21, 15)
      DEVOUT("L. COD. MAQUINA  ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCODMAQ", NIL, NIL, {||WCONTSN <> "N"});
            :DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF LASTKEY() = 27

         MEMVAR->OPC := "*"
         LOOP

      ENDIF

      SCROLL(22, 36, 22, 78)
      MEMVAR->WLETORD := ( SETPOS(22, 36), LTRIM(TRANSFORM(WNUMORD, ;
            "99999999")) )
      MEMVAR->WLONORD := LEN(WLETORD)
      MEMVAR->WLETORD := WLETORD + SPACE(8 - WLONORD)
      ACOSE()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\COSTOS.KEY")
      DBSEEK("&WLETORD")

      IF EOF()

         DBCLOSEARE()
         SETCOLOR("+GR")
         DEVPOS(22, 10)
         DEVOUT("ORDEN NO ESTA EN PRODUCCION")
         MEMVAR->X := INKEY(0)
         LOOP

      ENDIF

      IF ALLTRIM(WLETORD) = "999"

         __DBLOCATE({||LETORD = WLETORD .AND. CODPRO = WCODPRO}, NIL, NIL, ;
               NIL, .F.)

         IF EOF()

            DBCLOSEARE()
            SETCOLOR("+GR")
            DEVPOS(22, 10)
            DEVOUT("ESA ORDEN CON ESE CODIGO NO ESTA EN PRODUCCION")
            MEMVAR->X := INKEY(0)
            LOOP

         ENDIF

      ENDIF

      IF CODPRO <> WCODPRO

         DBCLOSEARE()
         SETCOLOR("+GR")
         DEVPOS(22, 10)
         DEVOUT("CODIGO DEL PRODUCTO NO CORRESPONDE A ESA ORDEN")
         MEMVAR->X := INKEY(0)
         LOOP

      ENDIF

      MEMVAR->WTARMAX := CANTOT
      MEMVAR->WPOSI := RECNO()
      DBCLOSEARE()
      MEMVAR->KEY := TRIM(WCODPRO) + TRIM(WCODTAR)
      MEMVAR->KEY := KEY + REPLICATE("*", 7 - LEN(KEY))

      IF SUBSTR(WCODPRO, 1, 4) <> "6030"

         ATAS()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\PROTARCO")
         DBSEEK("&KEY")

         IF EOF()

            DBCLOSEARE()
            SETCOLOR("+GR/R")
            DEVPOS(23, 20)
            DEVOUT("ESE PRODUCTO CON ESA TAREA NO EXISTE")
            MEMVAR->X := INKEY(0)
            MEMVAR->OPC := " "
            LOOP

         ENDIF

         MEMVAR->WUNIDAD := UNIDADESH
         MEMVAR->WTARMAX := WTARMAX * CANXUNI
         MEMVAR->WCANXUNI := CANXUNI
         DBCLOSEARE()

      ELSE

         AP6030S()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\PAG6030.KEY")
         MEMVAR->WKP := WCODTAR + PADL(ALLTRIM(WLETORD), 8, "0")
         DBSEEK("&WKP")

         IF EOF()

            DBCLOSEARE()
            SETCOLOR("+GR/R")
            DEVPOS(23, 20)
            DEVOUT("NO DEFINIO ESA TAREA PARA ESTA ORDEN")
            MEMVAR->X := INKEY(0)
            MEMVAR->OPC := " "
            LOOP

         ENDIF

         MEMVAR->WUNIDAD := UNIDADESH
         MEMVAR->WTARMAX := WTARMAX * CANXUNI
         MEMVAR->WCANXUNI := CANXUNI
         DBCLOSEARE()

      ENDIF

      IF WCODPRO = "6030" .AND. WCANXUNI = 0 .OR. WCANXUNI = 0 .AND. ;
            WCODPRO <> "6030"

         SCROLL(23, 1, 23, 78)
         SETPOS(23, 1)
         DEVPOS(23, 10)
         DEVOUT("No se puede grabar, no tiene definido factor de pago")
         MEMVAR->X := INKEY(0)
         LOOP

      ENDIF

      IF WCONTSN <> "N"

         AMAQS()
         DBSEEK("&WCODMAQ")

         IF EOF()

            DBCLOSEARE()
            DEVPOS(23, 1)
            DEVOUT("C" + O + "digo de m" + A + "quina no existe")
            MEMVAR->SWN := 0
            MEMVAR->X := INKEY(0)
            LOOP

         ENDIF

         MEMVAR->WCONT := CONTADOR
         DBCLOSEARE()

         IF WCONINI <> WCONT

            SCROLL(22, 1, 23, 78)
            SETPOS(22, 1)
            DEVPOS(22, 5)
            DEVOUT("El contador que registra la m" + A + "quina (" + ;
                  ALLTRIM(TRANSFORM(WCONT, "999,999,999")) + ;
                  ") es diferente al que usted da")
            DEVPOS(23, 5)
            DEVOUT(;
                  "como contador inicial. Para aceptarlo digite la clave especial";
                  )
            MEMVAR->WCLAVE := "        "
            SET(17, "OFF")
            MEMVAR->WCLAVE := __ACCEPT()
            SET(17, "ON")
            __MRESTORE("DATO", .T.)

            IF ALLTRIM(WCLAVE) <> ALLTRIM(DATO)

               SCROLL(24, 1, 24, 78)
               SETPOS(24, 1)
               DEVPOS(24, 10)
               DEVOUT("Pago rechazado")
               MEMVAR->X := INKEY(0)
               MEMVAR->OPC := " "
               __MRELEASE("DATO?", .T.)
               MEMVAR->SWN := 0
               SCROLL(22, 1, 24, 78)
               SETPOS(22, 1)
               LOOP

            ELSE

               SCROLL(24, 1, 24, 78)
               SETPOS(24, 1)
               DEVPOS(24, 10)
               DEVOUT("Pago aceptado")
               MEMVAR->X := INKEY(0)
               SCROLL(22, 1, 24, 78)
               SETPOS(22, 1)

            ENDIF

            __MRELEASE("DATO?", .T.)
            MEMVAR->WCLAVE := "        "

         ENDIF

      ENDIF

      MEMVAR->WUNIDAD := MEMVAR->SWMOD := MEMVAR->SWCANCE := 0
      RUMOPATA()

      IF LASTKEY() = 27 .OR. SWCANCE = 1

         LOOP

      ENDIF

      SET(2, "OFF")
      SET(3, 0)
      SET(2, "ON")

      IF WUNIDAD > 0

         IF WCODTAR = "PA" .OR. WCODTAR = "PC" .OR. WCODTAR = "GC" .OR. ;
               WCODTAR = "GP"

            MEMVAR->WPAGO := WMINUTOS / WUNIDAD * WVALHOR

         ELSE

            MEMVAR->WPAGO := WBUENAS / WUNIDAD * WVALHOR

         ENDIF

      ELSE

         MEMVAR->WPAGO := 0

      ENDIF

      MEMVAR->WNUEPAG := WPAGO * WPUNTOS / 100
      MEMVAR->WPAGO := WNUEPAG
      SETCOLOR("+G")
      DEVPOS(21, 15)
      DEVOUT("Valor del pago ")
      DEVPOS(21, 32)
      DEVOUTPICT(WPAGO, "@# 999,999.99")
      MEMVAR->X := INKEY(0)
      SETCOLOR("+W")
      SCROLL(21, 15, 21, 78)
      SETPOS(21, 15)

      IF WCODPRO <> "6030  " .OR. WCODPRO = "6030  "

         MEMVAR->WKEY1 := WCODTAR + WLETORD
         ADEMASS()
         DBSEEK("&WKEY1")

         IF EOF()

            DBAPPEND()
            FIELD->CODOPE := WOPE
            FIELD->CODPRO := WCODPRO
            FIELD->CODTAR := WCODTAR
            FIELD->LETORD := WLETORD
            FIELD->NUMORD := WNUMORD
            FIELD->MAXIMO := WTARMAX
            FIELD->CODUSU := WCODUSU
            FIELD->HORA := TIME()

         ENDIF

         DBCOMMITAL()
         VEALOCK()
         MEMVAR->WCANTAR := PAGADAS
         MEMVAR->WMAXIMO := MAXIMO
         DBCLOSEARE()

         IF WCODTAR = "PA" .OR. WCODTAR = "PC" .OR. WCODTAR = "GC" .OR. ;
               WCODTAR = "GP"

            MEMVAR->WCONT := WCANTAR + WMINUTOS
            MEMVAR->WTEMA := "el tiempo "
            MEMVAR->WSUME := WMINUTOS

         ELSE

            MEMVAR->WCONT := WCANTAR + WBUENAS
            MEMVAR->WTEMA := "las unidades "
            MEMVAR->WSUME := WBUENAS

         ENDIF

         IF WCONT > WMAXIMO

            MEMVAR->WCONF := " "
            PIDECONF()

            IF WCONF <> "S"

               MEMVAR->OPC := " "
               LOOP

            ENDIF

         ENDIF

         ADEMASS()
         DBSEEK("&WKEY1")
         VEALOCK()
         FIELD->PAGADAS := PAGADAS + WSUME

         IF WCONT > WMAXIMO

            FIELD->CODUSU := WCODUSU
            FIELD->HORA := TIME()

         ENDIF

         DBCLOSEARE()

      ENDIF

      APAMOS()
      DBAPPEND()
      FIELD->CODOPE := WOPE
      FIELD->NUMORD := WNUMORD
      FIELD->CODPRO := WCODPRO
      FIELD->CODTAR := WCODTAR
      FIELD->MINUTOS := WMINUTOS
      FIELD->BUENAS := WBUENAS
      FIELD->MALAS := WMALAS
      FIELD->PRUEBAS := WPRUEBAS
      FIELD->TOTAL := WWTOT
      FIELD->CONINI := WCONINI
      FIELD->CONFIN := WCONFIN
      FIELD->FECHA := WFECHA
      FIELD->UNIDADESH := WUNIDAD
      FIELD->PAGO := WPAGO
      FIELD->CODUSU := WCODUSU
      FIELD->HORA := TIME()
      DBCLOSEARE()

      IF WCONTSN <> "N"

         AMAQS()
         DBSEEK("&WCODMAQ")

         IF  .NOT. EOF()

            VEALOCK()
            FIELD->CONTADOR := WCONFIN

         ENDIF

         DBCLOSEARE()

      ENDIF

      SCROLL(8, 1, 23, 78)
      MEMVAR->OPC := ( SETPOS(8, 1), " " )

   ENDDO

   CIERRE()
   MEMVAR->WAB := "COSTOS.KEY"
   BA()
   MEMVAR->OPC := " "
   SET(2, "OFF")
   SET(3, 2)

RETURN 

