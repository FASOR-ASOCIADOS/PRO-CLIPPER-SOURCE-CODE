/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: PROG6
   Params: None.
   Return: Undefined
  Example: PROG6()
  ..........................................................................
*/

PROCEDURE PROG6()

   CIERRE()
   MEMVAR->OPC := " "
   SET(3, 2)

   DO WHILE OPC <> "*"

      MEMVAR->OPC := "*"
      MENU()
      DEVPOS(6, 1)
      DEVOUT(PADC("MANEJO DE MOVIMIENTOS", 78))
      DEVPOS(12, 20)
      DEVOUT("1. GRABACION DE MOVIMIENTOS   ")
      DEVPOS(13, 20)
      DEVOUT("2. MODIFICACION DE MOVIMIENTOS")
      DEVPOS(14, 20)
      DEVOUT("3. BORRADO DE MOVIMIENTOS     ")
      DEVPOS(15, 20)
      DEVOUT("4. VISUALIZACION DE MOVIMIENTOS")
      DEVPOS(16, 20)
      DEVOUT("5. LISTADOS")
      DEVPOS(17, 20)
      DEVOUT("*  FIN")
      SCROLL(19, 25, 19, 40)
      SETPOS(19, 25)
      DEVPOS(19, 25)
      DEVOUT("Seleccione una opci¢n ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "*"

         LOOP

      ENDIF

      MEMVAR->WNIV := "6" + OPC + "   "
      MEMVAR->XS := " "
      VEANIV()

      IF XS = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      IF OPC = "2"

         MODMOVPR()

      ELSEIF OPC = "3"

         BORMOVPR()

      ELSEIF OPC = "4"

         VISMOVPR()

      ELSEIF OPC = "5"

         LISMOVPR()

      ELSEIF OPC = "1"

         ESPERE()
         AMAINS()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
         ORDLISTREB()
         DBCLOSEARE()
         ACOSE()
         MEMVAR->WAB := "COSTOS.NTX"
         BA()
         DBCREATEIN("C:\COSTOS.NTX", "LETORD", {||LETORD}, NIL)
         DBCLOSEARE()
         SCROLL(5, 1, 23, 78)
         MEMVAR->IS := ( SETPOS(5, 1), " " )
         DEVPOS(12, 20)
         DEVOUT("Est  comenzando la semana ? S/N ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "IS", "@!", {||IS $ "SN"}, NIL):DISPLAY();
               )
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF IS = "S"

            SETCOLOR("*+G")
            DEVPOS(13, 20)
            DEVOUT("!!OJO !!")
            SETCOLOR("+R")
            MEMVAR->IS := "N"
            DEVPOS(14, 20)
            DEVOUT("DE VERDAD LO DESEA ? S/N ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "IS", "@!", {||IS $ "SN"}, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            SETCOLOR("+W")

            IF IS = "S"

               AMOVMESE()
               __DBAPP("&ZDIS\&WDIRECTO\MOVPRSEM", {}, NIL, NIL, NIL, NIL, ;
                     .F., NIL)
               DBCLOSEARE()
               AMVPRSE()
               SAP()
               DBCLOSEARE()

            ENDIF

         ENDIF

         MEMVAR->WTIPMOV := "  "
         MEMVAR->WNUMDOC := SPACE(7)
         MEMVAR->WFECPRO := DATE()

         DO WHILE OPC <> "*"

            MEMVAR->WCAN := MEMVAR->WVALUNI := MEMVAR->WVALTOT := MEMVAR->;
                  ZNUMORD := 0.0
            MEMVAR->OPC := MEMVAR->WNUMCOL := " "
            MEMVAR->WCOD := MEMVAR->WNUMORD := SPACE(4)
            MEMVAR->WCODPROV := SPACE(5)
            MEMVAR->WCODPT := ZLCPT
            MENU()
            DEVPOS(6, 1)
            DEVOUT(PADC("GRABACION DE MOVIMIENTOS", 78))
            DEVPOS(12, 10)
            DEVOUT("1. CODIGO              ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WCOD", NIL, NIL, NIL):DISPLAY())
            DEVPOS(13, 10)
            DEVOUT("2. TIPO DE MOVIMIENTO  ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WTIPMOV", NIL, NIL, NIL):DISPLAY())
            DEVPOS(14, 10)
            DEVOUT("3. NUMERO DE DOCUMENTO ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WNUMDOC", NIL, NIL, NIL):DISPLAY())
            DEVPOS(15, 10)
            DEVOUT("4. FECHA DE PROCESO    ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WFECPRO", NIL, {||MONTH(WFECPRO) = ;
                  ZMES .AND. YEAR(WFECPRO) = 2000 + ZZANO}, NIL):DISPLAY())
            DEVPOS(16, 10)
            DEVOUT("5. CANTIDAD            ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WCAN", "@Z 999,999.99", NIL, NIL);
                  :DISPLAY())
            DEVPOS(17, 10)
            DEVOUT("6. VALOR UNIT.         ")
            DEVPOS(17, 52)
            DEVOUT("Valor total:")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WVALTOT", "@# 99,999,999.99", NIL, ;
                  NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            MEMVAR->WVALUNI := IF(WCAN <> 0, WVALTOT / WCAN, WVALTOT)
            DEVPOS(17, 34)
            DEVOUTPICT(WVALUNI, "@Z 99,999,999.99")
            MEMVAR->WCANMOV := WCAN

            IF WCOD = "   " .OR. LASTKEY() = 27

               MEMVAR->OPC := "*"
               LOOP

            ENDIF

            MEMVAR->LL := VAL(WTIPMOV)

            IF LL > 6

               MEMVAR->WNIV := "61" + ALLTRIM(TRANSFORM(LL, "99")) + SPACE(;
                     3 - LEN(ALLTRIM(WTIPMOV)))
               MEMVAR->XS := " "
               VEANIV()

               IF XS = "N"

                  DEVPOS(22, 10)
                  DEVOUT(;
                        "Su clave de entrada no tiene permiso para registrar";
                        )
                  DEVPOS(23, 10)
                  DEVOUT("este tipo de movimiento.")
                  MEMVAR->X := INKEY(0)
                  MEMVAR->OPC := " "
                  LOOP

               ENDIF

            ENDIF

            IF WTIPMOV = "1 " .AND. WCAN > 0

               MENU()
               SETCOLOR("*+GR")
               DEVPOS(12, 15)
               DEVOUT("!! ATENCION !!")
               SETCOLOR("+W")
               DEVPOS(14, 5)
               DEVOUT("LAS ENTRADAS DE INSUMOS DEBEN HACERSE POR EL MENU")
               DEVPOS(15, 5)
               DEVOUT(;
                     "DE ORDENES DE COMPRA POR LA OPCION DE GRABACION DE ENTRADAS.";
                     )
               MEMVAR->X := INKEY(0)
               LOOP

            ENDIF

            IF WTIPMOV = "4 "

               SCROLL(12, 10, 17, 70)
               SETPOS(12, 10)
               DEVPOS(12, 10)
               DEVOUT("TIPO DE MOVIMIENTO FUERA DE LINEA ")
               MEMVAR->X := INKEY(0)
               DEVPOS(12, 10)
               DEVOUT("                                      ")
               LOOP

            ENDIF

            IF VAL(WCOD) > 199 .AND. VAL(WCOD) < 300

               DEVPOS(11, 13)
               DEVOUT("Num. de color ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "WNUMCOL", NIL, NIL, NIL):DISPLAY();
                     )
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}

            ENDIF

            AMAINS()

            IF VAL(WCOD) > 199 .AND. VAL(WCOD) < 300

               __DBLOCATE({||CODIGO = WCOD .AND. NUMCOLOR = WNUMCOL}, NIL, ;
                     NIL, NIL, .F.)

            ELSE

               ORDLISTCLE()
               ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
               DBSEEK("&WCOD")

            ENDIF

            IF EOF()

               DBCLOSEARE()
               SETCOLOR("+R")
               DEVPOS(12, 50)
               DEVOUT("CODIGO ERRADO    ")
               DEVPOS(13, 50)
               DEVOUT("INTENTE DE NUEVO ")
               MEMVAR->X := INKEY(0)
               SETCOLOR("+W")
               LOOP

            ENDIF

            MEMVAR->WCODNUM := CODNUM
            MEMVAR->WNOMBRE := MEMVAR->WNOMINS := NOMFASOR

            IF WVALUNI = 0

               MEMVAR->WVALUNI := IF(SALDOUNI = 0, SALDOPES, ROUND(SALDOPES ;
                     / SALDOUNI, 2))

            ENDIF

            MEMVAR->WPOS2 := RECNO()

            IF WVALUNI > 0

               MEMVAR->WCOSUNITA := WVALUNI

            ELSE

               MEMVAR->WCOSUNITA := IF(SALDOUNI <> 0, ROUND(SALDOPES / ;
                     SALDOUNI, 2), SALDOPES)

            ENDIF

            DBCLOSEARE()
            DEVPOS(12, 50)
            DEVOUT(WNOMBRE)
            ATIPMOVS()
            __DBLOCATE({||TIPO = WTIPMOV}, NIL, NIL, NIL, .F.)

            IF EOF()

               DBCLOSEARE()
               SETCOLOR("+R")
               DEVPOS(13, 50)
               DEVOUT("MOV. ERRADO")
               DEVPOS(14, 50)
               DEVOUT("INTENTE DE NUEVO")
               MEMVAR->X := INKEY(0)
               SETCOLOR("+W")
               LOOP

            ENDIF

            DEVPOS(13, 50)
            DEVOUT(NOMBRE)
            DBCLOSEARE()
            MEMVAR->WCODARNUM := VAL(WCOD)

            IF WCODARNUM > 699 .AND. WCODARNUM < 800

               SETCOLOR("+B/+W")
               SETPOS(12, 45)
               AADD(GETLIST, __GET(NIL, "WNOMBRE", NIL, NIL, NIL):DISPLAY();
                     )
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}
               MEMVAR->WNOMINS := WNOMBRE

               IF WNOMBRE = SPACE(LEN(WNOMBRE))

                  MEMVAR->WNOMBRE := "EN MOV. NO DIGITADO"

               ENDIF

               SETCOLOR("+W")

            ENDIF

            MEMVAR->WNUMORD := SPACE(8)

            IF WTIPMOV = "3 " .OR. WTIPMOV = "5 " .OR. WTIPMOV = "7 " .OR. ;
                  WTIPMOV = "8 "

               SETCOLOR("+GR")
               DEVPOS(18, 10)
               DEVOUT("N£mero de OP.que afecta")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "WNUMORD", NIL, NIL, NIL):DISPLAY();
                     )
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}
               SETCOLOR("+W")

            ENDIF

            MEMVAR->ZNUMORD := VAL(WNUMORD)

            IF (WTIPMOV = "3 " .OR. WTIPMOV = "5 ") .AND. (WCOD = "724" ;
                  .OR. WCOD = "704" .OR. WCOD = "734" .OR. WCOD = "754" ;
                  .OR. WCOD = "774" .OR. WCOD = "784") .AND. WCAN <> 0

               AINPES()
               __DBLOCATE({||NUMDOC = WNUMORD .AND. CODIGO = WCOD .AND. ;
                     NUMCOLOR = WNUMCOL .AND. CANTIDAD > 0 .AND. UPPER(;
                     WNOMBRE) = UPPER(NOMINS)}, NIL, NIL, NIL, .F.)

               IF EOF()

                  DBCLOSEARE()
                  SCROLL(22, 1, 23, 78)
                  SETPOS(22, 1)
                  SETCOLOR("+GR")
                  DEVPOS(20, 10)
                  DEVOUT("NO TIENE NADA PENDIENTE PARA ESA ORDEN")
                  DEVPOS(21, 10)
                  DEVOUT("INTENTE DESPUES DE REVISAR:")
                  SETCOLOR("+G")
                  DEVPOS(22, 15)
                  DEVOUT("NUMERO O.P., CODIGO INSUMO, COLOR, O NOMBRE")
                  MEMVAR->X := INKEY(0)
                  SETCOLOR("+W")
                  SCROLL(22, 1, 23, 78)
                  SETPOS(22, 1)
                  LOOP

               ENDIF

               MEMVAR->WPOS4 := RECNO()
               MEMVAR->WQ := CANTIDAD

               IF WCAN > CANTIDAD

                  DBCLOSEARE()
                  SCROLL(22, 1, 23, 78)
                  SETPOS(22, 1)
                  DEVPOS(22, 1)
                  DEVOUT("NO LE RECIBO, Esta entrando " + ALLTRIM(;
                        TRANSFORM(WCAN - WQ, "999,999.99")) + " m" + A + ;
                        "s de lo")
                  DEVPOS(23, 1)
                  DEVOUT("Que tiene pendiente. Trate nuevamente.")
                  MEMVAR->X := INKEY(0)
                  SCROLL(22, 1, 23, 78)
                  SETPOS(22, 1)
                  LOOP

               ENDIF

            ENDIF

            DBSELECTAR("4")
            DBCLOSEARE()

            IF (WTIPMOV = "2 " .OR. WTIPMOV = "8 ") .AND. (VAL(WCOD) < ;
                  1000 .OR. VAL(WCOD) > 1199)

               SCROLL(12, 10, 17, 70)
               SETPOS(12, 10)
               DEVPOS(12, 10)
               DEVOUT("EN ESTE TIPO DE MOVIMIENTO NO LE  ")
               DEVPOS(13, 10)
               DEVOUT("PUEDO RECIBIR ESE CODIGO")
               MEMVAR->X := INKEY(0)
               SCROLL(12, 10, 13, 78)
               SETPOS(12, 10)
               LOOP

            ENDIF

            IF VAL(WCOD) > 999 .AND. VAL(WCOD) < 1200 .AND. WTIPMOV <> ;
                  "2 " .AND. WTIPMOV <> "8 "

               SCROLL(12, 10, 17, 70)
               SETPOS(12, 10)
               DEVPOS(12, 10)
               DEVOUT("EN ESTE TIPO DE MOVIMIENTO NO LE  ")
               DEVPOS(13, 10)
               DEVOUT("PUEDO RECIBIR ESE CODIGO")
               MEMVAR->X := INKEY(0)
               SCROLL(12, 10, 13, 78)
               SETPOS(12, 10)
               LOOP

            ENDIF

            MEMVAR->SWAVI := 0
            AMAINS()
            DBGOTO(WPOS2)

            IF LL > 0 .AND. LL < 7

               IF SALDOUNI + WCAN < 0

                  MEMVAR->SWAVI := 1

               ENDIF

            ELSEIF SALDOUNI - WCAN < 0

               MEMVAR->SWAVI := 1

            ENDIF

            DBCLOSEARE()

            IF SWAVI = 1

               SCROLL(23, 1, 23, 78)
               SETPOS(23, 1)
               DEVPOS(23, 5)
               DEVOUT(;
                     "CON ESTE MOVIM. QUEDARIA SALDO NEGATIVO, NO SE GRABA";
                     )
               MEMVAR->X := INKEY(0)
               __MRELEASE("SWAVI", .T.)
               __MRELEASE("LL", .T.)
               LOOP

            ENDIF

            __MRELEASE("SWAVI", .T.)
            AINPES()

            IF (WCOD = "724" .OR. WCOD = "704" .OR. WCOD = "734" .OR. WCOD ;
                  = "754" .OR. WCOD = "774" .OR. WCOD = "784") .AND. WCAN ;
                  <> 0 .AND. (WTIPMOV = "1 " .OR. WTIPMOV = "2 " .OR. ;
                  WTIPMOV = "3 " .OR. WTIPMOV = "5 ")

               __DBLOCATE({||NUMDOC = WNUMORD .AND. CODIGO = WCOD .AND. ;
                     NUMCOLOR = WNUMCOL .AND. NOMINS = WNOMBRE}, NIL, NIL, ;
                     NIL, .F.)

               IF EOF()

                  __DBLOCATE({||NUMDOC = WNUMORD .AND. CODIGO = WCOD .AND. ;
                        NUMCOLOR = WNUMCOL}, NIL, NIL, NIL, .F.)

                  IF  .NOT. EOF()

                     DBCLOSEARE()
                     MEMVAR->OPC := " "
                     SCROLL(20, 1, 23, 78)
                     SETPOS(20, 1)
                     SETCOLOR("*+BG")
                     DEVPOS(21, 5)
                     DEVOUT("transacci" + O + "n cancelada")
                     SETCOLOR("+W")
                     DEVPOS(22, 1)
                     DEVOUT(;
                           "Todos los datos fueron encontrados en insumos pendientes";
                           )
                     DEVPOS(23, 1)
                     DEVOUT("excepto el NOMBRE DE INSUMO. Deber" + A + ;
                           " registrar de nuevo. PULSE *")
                     SETPOSBS()
                     AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "*"}, ;
                           NIL):DISPLAY())
                     READMODAL(GETLIST)
                     MEMVAR->GETLIST := {}
                     MEMVAR->OPC := " "
                     LOOP

                  ENDIF

                  MEMVAR->WPOS4 := RECNO()
                  DBCLOSEARE()

               ENDIF

            ENDIF

            MEMVAR->TC := "S"
            MEMVAR->SW6 := 0
            MEMVAR->WDOC := SPACE(7)

            IF WTIPMOV <> "7 "

               RUTTC()

               IF TC <> "S"

                  MEMVAR->TC := MEMVAR->OPC := " "
                  SETCOLOR("+W")
                  LOOP

               ENDIF

            ENDIF

            IF WTIPMOV <> "3 "

               MEMVAR->WVALTOT := 0
               VEAVALTO()

            ENDIF

            IF LL > 8 .AND. LL <> 10

               AMAINS()
               DBGOTO(WPOS2)
               MEMVAR->WCOSUNITA := MEMVAR->WCOSSALEN := 0
               VEAUNITA()
               DBCLOSEARE()
               SETCOLOR("+GR")
               MEMVAR->WVALUNI := WCOSUNITA
               DEVPOS(17, 10)
               DEVOUT("6. COSTO UNIT. ACTUAL  ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "WVALUNI", "@Z 99,999,999.99", NIL,;
                      NIL):DISPLAY())
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}
               MEMVAR->WVALTOT := IF(WCAN <> 0, WVALUNI * WCAN, WVALUNI)
               DEVPOS(17, 52)
               DEVOUT("Valor total:")
               DEVPOS(17, 65)
               DEVOUTPICT(WVALTOT, "@# 99,999,999.99")
               SETCOLOR("+W")

            ENDIF

            MEMVAR->XMOV := " "

            IF WTIPMOV = "1 "

               AMAINS()
               DBGOTO(WPOS2)
               VEALOCK()
               FIELD->SALDOUNI := SALDOUNI + WCAN
               FIELD->SALDOPES := SALDOPES + WVALTOT
               FIELD->ENTMESUNI := ENTMESUNI + WCAN
               FIELD->ENTMESPES := ENTMESPES + WVALTOT
               FIELD->ENTANOUNI := ENTANOUNI + WCAN
               FIELD->ENTANOPES := ENTANOPES + WVALTOT
               DBCLOSEARE()
               ADI6()

               IF WCAN > 0

                  VEAPEN()

               ENDIF

            ELSEIF WTIPMOV = "2 "

               AMAINS()
               DBGOTO(WPOS2)
               VEALOCK()
               FIELD->SALDOUNI := SALDOUNI + WCAN
               FIELD->SALDOPES := SALDOPES + WVALTOT
               FIELD->OTRENMEUNI := OTRENMEUNI + WCAN
               FIELD->OTRENMEPES := OTRENMEPES + WVALTOT
               FIELD->OTRENANOUN := OTRENANOUN + WCAN
               FIELD->OTRENANOPE := OTRENANOPE + WVALTOT
               DBCLOSEARE()
               ADI6()

               IF WCAN > 0

                  VEAPEN()

               ENDIF

            ELSEIF WTIPMOV = "3 "

               MEMVAR->WVALCON := MEMVAR->WCOSUNITA := MEMVAR->SWP := 0
               ACOSS()
               ORDLISTCLE()
               ORDLISTADD("C:\COSTOS.NTX")
               DBSEEK("&WNUMORD")

               IF EOF()

                  DBCLOSEARE()
                  AOPTES()
                  __DBLOCATE({||NUMORD = ZNUMORD}, NIL, NIL, NIL, .F.)

                  IF EOF()

                     MEMVAR->SWP := 1

                  ENDIF

                  DBCLOSEARE()

               ENDIF

               DBSELECTAR("13")
               DBCLOSEARE()

               IF SWP = 1

                  SETCOLOR("+R")
                  DEVPOS(22, 1)
                  DEVOUT("!!ADVERTENCIA !!")
                  SETCOLOR("+G")
                  MEMVAR->OPC := "S"
                  DEVPOS(23, 1)
                  DEVOUT(;
                        "Orden no encontrada en COSTOS ni ORDPRTEM continua con el movimiento ? S/N ";
                        )
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, ;
                        NIL):DISPLAY())
                  READMODAL(GETLIST)
                  MEMVAR->GETLIST := {}
                  SETCOLOR("+W")
                  SCROLL(22, 1, 23, 78)
                  SETPOS(22, 1)

                  IF OPC = "N"

                     MEMVAR->OPC := " "
                     LOOP

                  ENDIF

               ENDIF

               ESPERE()
               AMAINS()
               DBGOTO(WPOS2)
               VEALOCK()
               FIELD->CONMESUNI := CONMESUNI - WCAN
               FIELD->CONANOUNI := CONANOUNI - WCAN
               FIELD->CONMESPES := CONMESPES - WVALTOT
               FIELD->CONANOPES := CONANOPES - WVALTOT

               IF SALDOUNI <> 0

                  MEMVAR->WCOSUNITA := ROUND(SALDOPES / SALDOUNI, 2)
                  DBCLOSEARE()

               ELSE

                  DBCLOSEARE()
                  MEMVAR->WCOSUNITA := 0
                  SETCOLOR("+GR")
                  SCROLL(18, 5, 21, 70)
                  SETPOS(18, 5)
                  DISPBOX(18, 5, 21, 70, 1)
                  SETCOLOR("+G")
                  DEVPOS(19, 10)
                  DEVOUT("POR FAVOR DEME EL COSTO UNITARIO DE")
                  DEVPOS(20, 10)
                  DEVOUT("ESA REFERENCIA ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "WCOSUNITA", "@Z 99999,999.99", ;
                        NIL, NIL):DISPLAY())
                  READMODAL(GETLIST)
                  MEMVAR->GETLIST := {}
                  SETCOLOR("+W")

               ENDIF

               MEMVAR->WVALENTRA := MEMVAR->WCOSSALEN := ROUND(WCOSUNITA * ;
                     WCAN, 2)
               AMAINS()
               DBGOTO(WPOS2)
               VEALOCK()
               FIELD->SALDOPES := SALDOPES + WVALENTRA
               FIELD->SALDOUNI := SALDOUNI + WCAN
               FIELD->COSCONMES := COSCONMES - WVALENTRA
               FIELD->COSCONANO := COSCONANO - WVALENTRA
               DBCLOSEARE()
               ADI6()
               ACOSS()
               ORDLISTCLE()
               ORDLISTADD("C:\COSTOS.NTX")
               DBSEEK("&WNUMORD")

               IF  .NOT. EOF()

                  VEALOCK()
                  FIELD->VALTOT := VALTOT - WVALENTRA
                  DBCLOSEARE()

               ELSE

                  DBCLOSEARE()
                  SCROLL(22, 1, 23, 78)
                  SETPOS(22, 1)
                  SETCOLOR("+R")
                  DEVPOS(22, 1)
                  DEVOUT("!!ADVERTENCIA !!")
                  SETCOLOR("+G")
                  DEVPOS(23, 10)
                  DEVOUT("Orden no encontrada en COSTOS")
                  MEMVAR->X := INKEY(0)
                  SETCOLOR("+W")
                  SCROLL(22, 1, 23, 78)
                  SETPOS(22, 1)

               ENDIF

               MEMVAR->SWMV := 1
               ADI8()
               SET(11, "ON")
               AINPES()
               __DBLOCATE({||NUMDOC = WNUMORD .AND. CODIGO = WCOD .AND. ;
                     NUMCOLOR = WNUMCOL .AND. NOMINS = WNOMBRE}, NIL, NIL, ;
                     NIL, .F.)

               IF  .NOT. EOF()

                  MEMVAR->WPENCOS := CANTIDAD
                  MEMVAR->WNOMBRE := NOMBRE
                  MEMVAR->WNOMINS := NOMINS
                  MEMVAR->XMOV := TIPOMOV
                  VEALOCK()

                  IF WCAN > WPENCOS .OR. WCAN = WPENCOS

                     DBDELETE()
                     FIELD->CODIGO := "    "
                     MEMVAR->WCT7 := WPENCOS

                  ELSE

                     MEMVAR->WPENCOS := WPENCOS - WCAN
                     FIELD->CANTIDAD := WPENCOS
                     MEMVAR->WCT7 := WCAN

                  ENDIF

                  DBCLOSEARE()
                  MEMVAR->WVALTOT := IF(WCT7 = 0, WVALUNI, ROUND(WVALUNI * ;
                        WCT7, 2))
                  MEMVAR->SW6 := 1
                  ADI6P()
                  AMAINS()
                  DBGOTO(WPOS2)
                  VEALOCK()
                  FIELD->CONMESUNI := CONMESUNI + WCT7
                  FIELD->CONANOUNI := CONANOUNI + WCT7
                  FIELD->CONMESPES := CONMESPES + WVALTOT
                  FIELD->CONANOPES := CONANOPES + WVALTOT
                  MEMVAR->WCOSUNITA := IF(SALDOUNI <> 0, ROUND(SALDOPES / ;
                        SALDOUNI, 2), SALDOPES)
                  MEMVAR->WCOSSALEN := ROUND(WCOSUNITA * WCT7, 2)
                  FIELD->SALDOPES := SALDOPES - WCOSSALEN
                  FIELD->SALDOUNI := SALDOUNI - WCT7
                  FIELD->COSCONMES := COSCONMES + WCOSSALEN
                  FIELD->COSCONANO := COSCONANO + WCOSSALEN
                  FIELD->ULTMOV := WFECPRO
                  DBCLOSEARE()

               ENDIF

               SET(11, "OFF")
               VEAPEN()
               SETCOLOR("+W")
               SCROLL(23, 1, 23, 78)
               SETPOS(23, 1)

            ELSEIF WTIPMOV = "5 "

               AMAINS()
               DBGOTO(WPOS2)
               VEALOCK()
               FIELD->SALDOUNI := SALDOUNI + WCAN
               FIELD->SALDOPES := SALDOPES + WVALTOT
               FIELD->OTRENMEUNI := OTRENMEUNI + WCAN
               FIELD->OTRENMEPES := OTRENMEPES + WVALTOT
               FIELD->OTRENANOUN := OTRENANOUN + WCAN
               FIELD->OTRENANOPE := OTRENANOPE + WVALTOT
               DBCLOSEARE()
               ADI6()

               IF WCAN > 0

                  VEAPEN()

               ENDIF

            ELSEIF WTIPMOV = "6 "

               AMAINS()
               DBGOTO(WPOS2)
               VEALOCK()
               FIELD->SALDOUNI := SALDOUNI + WCAN
               FIELD->SALDOPES := SALDOPES + WVALTOT
               FIELD->OTRENMEUNI := OTRENMEUNI + WCAN
               FIELD->OTRENMEPES := OTRENMEPES + WVALTOT
               FIELD->OTRENANOUN := OTRENANOUN + WCAN
               FIELD->OTRENANOPE := OTRENANOPE + WVALTOT
               DBCLOSEARE()
               ADI6()

               IF WCAN > 0

                  VEAPEN()

               ENDIF

            ELSEIF WTIPMOV = "7 "

               AMAINS()
               DBGOTO(WPOS2)
               MEMVAR->WWSAUNI := SALDOUNI
               DBCLOSEARE()

               IF WWSAUNI < WCAN

                  MEMVAR->OPC := "N"
                  SETCOLOR("GR")
                  DEVPOS(21, 10)
                  DEVOUT("SOLO TENGO " + ALLTRIM(TRANSFORM(WWSAUNI, ;
                        "999,999.99")) + " UNIDADES")
                  DEVPOS(22, 10)
                  DEVOUT("SE LAS ENTREGO ? S/N ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, ;
                        NIL):DISPLAY())
                  READMODAL(GETLIST)
                  MEMVAR->GETLIST := {}
                  SETCOLOR("+W")
                  SCROLL(21, 9, 22, 78)
                  SETPOS(21, 9)

                  IF OPC <> "S"

                     MEMVAR->OPC := " "
                     LOOP

                  ENDIF

                  MEMVAR->WCAN := WWSAUNI
                  DEVPOS(16, 10)
                  DEVOUT("5. CANTIDAD            ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "WCAN", "@Z 999,999.99", NIL, ;
                        NIL):DISPLAY())
                  READKILL(.T.)
                  MEMVAR->GETLIST := {}

               ENDIF

               MEMVAR->WVALCON := MEMVAR->SWMV := 0
               RUTTC()

               IF TC <> "S"

                  MEMVAR->TC := MEMVAR->OPC := " "
                  SETCOLOR("+W")
                  SET(27, "OFF")
                  LOOP

               ENDIF

               SET(27, "OFF")
               VEAVALTO()
               AMAINS()
               DBGOTO(WPOS2)
               MEMVAR->WCOSUNITA := MEMVAR->WCOSSALEN := 0
               VEAUNITA()
               VEALOCK()
               FIELD->CONMESUNI := CONMESUNI + WCAN
               FIELD->CONANOUNI := CONANOUNI + WCAN
               FIELD->CONMESPES := CONMESPES + WVALTOT
               FIELD->CONANOPES := CONANOPES + WVALTOT
               FIELD->SALDOPES := SALDOPES - WCOSSALEN
               FIELD->SALDOUNI := SALDOUNI - WCAN
               FIELD->COSCONMES := COSCONMES + WCOSSALEN
               FIELD->COSCONANO := COSCONANO + WCOSSALEN
               FIELD->ULTMOV := WFECPRO
               DBCLOSEARE()
               ADI6()
               ADI8()
               ACOSS()
               ORDLISTCLE()
               ORDLISTADD("C:\COSTOS.NTX")
               DBSEEK("&WNUMORD")

               IF  .NOT. EOF()

                  VEALOCK()
                  FIELD->VALTOT := VALTOT + WCOSSALEN

               ENDIF

               DBCLOSEARE()

            ELSEIF WTIPMOV = "8 "

               MEMVAR->SWMV := 0
               AMAINS()
               DBGOTO(WPOS2)
               MEMVAR->WCOSUNITA := MEMVAR->WCOSSALEN := 0
               VEAUNITA()
               VEALOCK()
               FIELD->ULTMOV := WFECPRO
               FIELD->SALDOPES := SALDOPES - WVALTOT
               FIELD->SALDOUNI := SALDOUNI - WCAN
               FIELD->CONMESUNI := CONMESUNI + WCAN
               FIELD->CONMESPES := CONMESPES + WVALTOT
               FIELD->CONANOUNI := CONANOUNI + WCAN
               FIELD->CONANOPES := CONANOPES + WVALTOT
               FIELD->COSCONMES := COSCONMES + WVALTOT
               FIELD->COSCONANO := COSCONANO + WVALTOT
               DBCLOSEARE()
               ADI6()
               ADI8()
               ACOSS()
               ORDLISTCLE()
               ORDLISTADD("C:\COSTOS.NTX")
               DBSEEK("&WNUMORD")

               IF  .NOT. EOF()

                  VEALOCK()
                  FIELD->VALTOT := VALTOT + WCOSSALEN

               ENDIF

               DBCLOSEARE()

            ELSEIF WTIPMOV = "9 "

               AMAINS()
               DBGOTO(WPOS2)
               MEMVAR->WCOSUNITA := MEMVAR->WCOSSALEN := 0
               VEAUNITA()
               VEALOCK()
               FIELD->SALDOUNI := SALDOUNI - WCAN
               FIELD->SALDOPES := SALDOPES - WVALTOT
               FIELD->ENTMESUNI := ENTMESUNI - WCAN
               FIELD->ENTMESPES := ENTMESPES - WVALTOT
               FIELD->ENTANOUNI := ENTANOUNI - WCAN
               FIELD->ENTANOPES := ENTANOPES - WVALTOT
               FIELD->ULTMOV := WFECPRO
               DBCLOSEARE()
               ADI6()

            ELSEIF WTIPMOV = "10"

               AMAINS()
               DBGOTO(WPOS2)
               VEALOCK()
               FIELD->SALDOUNI := SALDOUNI - WCAN
               FIELD->SALDOPES := SALDOPES - WVALTOT
               FIELD->OTRENMEUNI := OTRENMEUNI - WCAN
               FIELD->OTRENMEPES := OTRENMEPES - WVALTOT
               FIELD->OTRENANOUN := OTRENANOUN - WCAN
               FIELD->OTRENANOPE := OTRENANOPE - WVALTOT
               FIELD->ULTMOV := WFECPRO
               DBCLOSEARE()
               ADI6()

            ELSEIF WTIPMOV = "11"

               AMAINS()
               DBGOTO(WPOS2)
               VEALOCK()
               FIELD->SALDOUNI := SALDOUNI - WCAN
               FIELD->SALDOPES := SALDOPES - WVALTOT
               FIELD->OTRSAMESUN := OTRSAMESUN + WCAN
               FIELD->OTRSAMESPE := OTRSAMESPE + WVALTOT
               FIELD->OTRSAANOUN := OTRSAANOUN + WCAN
               FIELD->OTRSAANOPE := OTRSAANOPE + WVALTOT
               FIELD->ULTMOV := WFECPRO
               DBCLOSEARE()
               ADI6()

            ELSEIF WTIPMOV = "12"

               AMAINS()
               DBGOTO(WPOS2)
               VEALOCK()
               FIELD->SALDOUNI := SALDOUNI - WCAN
               FIELD->SALDOPES := SALDOPES - WVALTOT
               FIELD->OTRSAMESUN := OTRSAMESUN + WCAN
               FIELD->OTRSAMESPE := OTRSAMESPE + WVALTOT
               FIELD->OTRSAANOUN := OTRSAANOUN + WCAN
               FIELD->OTRSAANOPE := OTRSAANOPE + WVALTOT
               FIELD->ULTMOV := WFECPRO
               DBCLOSEARE()
               ADI6()

            ENDIF

            IF LL > 8

               AMAINS()
               DBGOTO(WPOS2)

               IF SALDOPES > -10 .AND. SALDOPES < 1

                  VEALOCK()
                  FIELD->SALDOPES := 0

               ENDIF

               IF SALDOPES < -10

                  MEMVAR->OPC := " "
                  SCROLL(20, 1, 23, 78)
                  SETPOS(20, 1)
                  DEVPOS(21, 10)
                  DEVOUT(;
                        "Le acaba de generar un saldo en pesos negativo, de aviso y pulse * ";
                        )
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "*"}, NIL);
                        :DISPLAY())
                  READMODAL(GETLIST)
                  MEMVAR->GETLIST := {}

               ENDIF

               DBCLOSEARE()

            ENDIF

            __MRELEASE("LL", .T.)
            SCROLL(20, 1, 23, 78)
            MEMVAR->OPC := ( SETPOS(20, 1), " " )
            DEVPOS(23, 20)
            DEVOUT("TIENE MAS PARA GRABAR ? S/N ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

            IF OPC = "N"

               MEMVAR->OPC := "*"

            ENDIF

         ENDDO

         SET(11, "OFF")
         AINPEE()
         DBEVAL({||DBDELETE()}, {||CANTIDAD < 0.001}, NIL, NIL, NIL, .F.)
         __DBPACK()
         CIERRE()
         MEMVAR->OPC := " "

      ENDIF

   ENDDO

   MEMVAR->OPC := " "
   DBCLOSEALL()
   MEMVAR->WAB := "BASURA.NTX"
   BA()

RETURN 

