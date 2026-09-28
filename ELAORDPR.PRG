/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ELAORDPR
   Params: None.
   Return: Undefined
  Example: ELAORDPR()
  ..........................................................................
*/

PROCEDURE ELAORDPR()

   SET(20, "SCREEN")
   CIERRE()
   __MRESTORE("&ZDIS\&WDIRECTO\LETRAS", .T.)
   __MRESTORE("ZPORCOS", .T.)
   MEMVAR->SWOK := 0
   SETCOLOR("+W")
   SCROLL(6, 1, 23, 78)
   SETPOS(6, 1)
   SET(27, "ON")
   MEMVAR->WDATE := DATE()
   DEVPOS(12, 20)
   DEVOUT("Por favor deme la fecha para las ordenes ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WDATE", NIL, {||MONTH(WDATE) = ZMES .AND. ;
         YEAR(WDATE) = 2000 + ZZANO}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   SET(27, "OFF")
   SET(3, 4)
   MEMVAR->WTIPCON := MEMVAR->OPC := " "
   MENU()
   DEVPOS(12, 20)
   DEVOUT("ordenes de A o de B ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WTIPCON", "@!", {||WTIPCON $ "AB"}, NIL);
         :DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF WTIPCON = "A"

      __MRESTORE("&ZDIS\&WDIRECTO\NUORPR", .T.)
      MEMVAR->WNUMORDP := NUORPR

   ELSE

      __MRESTORE("&ZDIS\&WDIRECTO\NUORPRB", .T.)
      MEMVAR->WNUMORDP := NUORPRB

   ENDIF

   MENU()
   DEVPOS(12, 20)
   DEVOUT("ESTA COMENZANDO LA GRABACION ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   SETCOLOR("BG")
   DEVPOS(13, 20)
   DEVOUT("NOTA:")
   DEVPOS(14, 25)
   DEVOUT("Al responder SI, se borrar" + A + "n las  ordenes que tenga")
   DEVPOS(15, 25)
   DEVOUT("creadas en el archivo para la impresi" + O + "n de hojas de")
   DEVPOS(16, 25)
   DEVOUT("empaque y res" + U + "men de materia prima para entregar. ")
   DEVPOS(17, 25)
   DEVOUT("Si responde NO, las que elabore ahora se acumular" + A + "n")
   DEVPOS(18, 25)
   DEVOUT("con las anteriores.")
   SETCOLOR("+W")
   DEVPOS(14, 25)
   DEVOUT("Al responder SI,")
   DEVPOS(17, 25)
   DEVOUT("Si responde NO,")
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF LASTKEY() = 27

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   IF OPC = "S"

      SALVAOPT()
      AOPTEE()
      SAP()
      DBCLOSEARE()

   ENDIF

   AMAINER()
   DBCLOSEARE()
   AOPTEE()
   BORPICO()
   DBCREATEIN("&ZDIS\&WDIRECTO\PICO", "PRINCOOP", {||PRINCOOP}, NIL)
   MEMVAR->WULTREC := LASTREC()
   DBCLOSEARE()

   DO WHILE OPC <> "*"

      MEMVAR->OPC := " "

      IF WTIPCON = "A"

         MEMVAR->NUORPR := WNUMORDP
         FERASE("&ZDIS\&WDIRECTO\NUORPR.MEM")
         __MSAVE("&ZDIS\&WDIRECTO\NUORPR", "NUORPR", .T.)

      ELSE

         MEMVAR->NUORPRB := WNUMORDP
         FERASE("&ZDIS\&WDIRECTO\NUORPRB.MEM")
         __MSAVE("&ZDIS\&WDIRECTO\NUORPRB", "NUORPRB", .T.)

      ENDIF

      MEMVAR->WNUMORDP := MEMVAR->WNUMORDP + 1
      MENU()
      DEVPOS(5, 22)
      DEVOUT("ELABORACION DE ORDENES DE PRODUCCION")
      MEMVAR->WCODPRO := ZLCPT
      MEMVAR->WPREVEN := 0
      DEVPOS(11, 20)
      DEVOUT("NUMERO DE LA ORDEN    " + ALLTRIM(TRANSFORM(WNUMORDP, ;
            "9999999")))
      DEVPOS(12, 20)
      DEVOUT("CODIGO DEL PRODUCTO : ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCODPRO", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WCODPRO = ZLCPT .OR. WCODPRO = "*" .OR. LASTKEY() = 27

         MEMVAR->OPC := "*"
         LOOP

      ENDIF

      AMAPAS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
      DBSEEK("&WCODPRO")

      IF EOF()

         DBCLOSEARE()
         SETCOLOR("+G/BR")
         DEVPOS(13, 20)
         DEVOUT("CODIGO NO EXISTE ")
         MEMVAR->X := INKEY(0)
         MEMVAR->WNUMORDP := WNUMORDP - 1
         LOOP

      ENDIF

      MEMVAR->WNOMBRE := TRIM(NOMBRE)
      MEMVAR->WUNIDAD := LTRIM(UNIDAD)
      MEMVAR->WPREVEN := VRLISTA
      DBCLOSEARE()
      MEMVAR->WSUR := " "
      SETCOLOR("+GR")
      DEVPOS(8, 1)
      DEVOUT(PADC("Elaborando orden para: " + ALLTRIM(WNOMBRE), 78))
      SETCOLOR("+W")
      MEMVAR->WCANT := 0
      DEVPOS(13, 20)
      DEVOUT("PRECIO DE VENTA       ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WPREVEN", "@Z 9,999,999", NIL, NIL);
            :DISPLAY())
      DEVPOS(14, 20)
      DEVOUT("CANTIDAD A FABRICAR : ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCANT", "@Z 999,999", NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WCANT = 0 .OR. LASTKEY() = 27

         MEMVAR->OPC := "*"
         LOOP

      ENDIF

      MEMVAR->SWCOLOR := MEMVAR->SWCOLOR2 := MEMVAR->WCANINSCO2 := 0
      MEMVAR->WNOMINS := SPACE(20)
      MEMVAR->WINSCOL := MEMVAR->WINSCOL2 := "    "
      MEMVAR->CINS := 1

      DO WHILE CINS < 21

         AMAPAS()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
         DBSEEK("&WCODPRO")
         MEMVAR->WCODINS := "CODINS" + ALLTRIM(TRANSFORM(CINS, "99"))
         MEMVAR->WCAN := "CAN" + ALLTRIM(TRANSFORM(CINS, "99"))

         IF VAL((&(MEMVAR->WCODINS))) > 199 .AND. VAL((&(MEMVAR->WCODINS))) ;
               < 300

            IF SWCOLOR = 0

               MEMVAR->SWCOLOR := 1
               MEMVAR->WINSCOL := (&(MEMVAR->WCODINS))
               MEMVAR->WCANINSCO := (&(MEMVAR->WCAN))

            ELSE

               MEMVAR->SWCOLOR2 := 1
               MEMVAR->WINSCOL2 := (&(MEMVAR->WCODINS))
               MEMVAR->WCANINSCO2 := (&(MEMVAR->WCAN))

            ENDIF

            DBCLOSEARE()

         ELSE

            MEMVAR->WCODINS := (&(MEMVAR->WCODINS))
            MEMVAR->WCANINS := WCANT * (&(MEMVAR->WCAN))
            DBCLOSEARE()

            IF WCODINS <> "  "

               AMAINS()
               ORDLISTCLE()
               ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
               DBSEEK("&WCODINS")
               MEMVAR->WNOMINS := NOMFASOR
               MEMVAR->WVUNI := 0
               VESAUN()
               DBCLOSEARE()
               MEMVAR->WVUNI := WVUNI + ROUND(WVUNI * ZPORCOS / 100, 2)
               SCROLL(15, 5, 19, 75)
               SETPOS(15, 5)
               SETCOLOR("+GR")
               DISPBOX(15, 5, 19, 75, 1)
               SETCOLOR("+W")
               DEVPOS(16, 10)
               DEVOUT("INSUMO " + WCODINS + SUBSTR(WNOMINS, 1, 20))
               DEVPOS(17, 10)
               DEVOUT("CANTIDAD TOTAL     ")
               MEMVAR->WCANRETAL := ( SETPOS(ROW(), COL()), AADD(GETLIST, ;
                     __GET(NIL, "WCANINS", "@Z 99,999.99", NIL, NIL);
                     :DISPLAY()), 0 )
               DEVPOS(18, 10)
               DEVOUT("CANTIDAD DE RETAL ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "WCANRETAL", "@Z 99,999.99", NIL, ;
                     NIL):DISPLAY())
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}
               AOPTES()
               ORDLISTCLE()
               ORDLISTADD("&ZDIS\&WDIRECTO\PICO")
               DBAPPEND()
               FIELD->CODPRO := WCODPRO
               FIELD->NUMCOLOR := " "
               FIELD->CANORD := WCANT
               FIELD->CANTOT := WCANT
               FIELD->CANPED := WCANT
               FIELD->CODINS := WCODINS
               FIELD->NUMINS := VAL(WCODINS)
               FIELD->CANINS := WCANINS
               FIELD->CANINV := WCANINS - WCANRETAL
               FIELD->CANRETAL := WCANRETAL
               FIELD->VALUNI := WVUNI
               FIELD->VALTOT := ROUND(CANINV * WVUNI, 2)
               FIELD->NUMORD := WNUMORDP
               FIELD->NOMBREPT := WNOMBRE
               FIELD->NOMINS := WNOMINS
               FIELD->SURTIDO := " "
               FIELD->UNIDAD := WUNIDAD
               FIELD->FECHA := WDATE
               FIELD->PREVEN := WPREVEN
               FIELD->CODUSU := WCODUSU
               FIELD->HORA := TIME()
               DBCOMMITAL()
               DBCLOSEARE()

            ENDIF

         ENDIF

         MEMVAR->CINS := MEMVAR->CINS + 1

      ENDDO

      SCROLL(15, 5, 19, 75)
      SETPOS(15, 5)
      DISPBOX(15, 5, 19, 75, 1)

      IF SWCOLOR = 1

         MEMVAR->WSUR := " "
         MEMVAR->WPIDCOL := "S"
         DEVPOS(16, 20)
         DEVOUT("SURTIDO ? S/N ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WSUR", "@!", {||WSUR $ "SN"}, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         SCROLL(15, 5, 19, 75)
         SETPOS(15, 5)
         SETCOLOR("+GR")
         DISPBOX(15, 5, 19, 75, 1)
         SETCOLOR("+W")
         AMAINS()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
         DBSEEK("&WINSCOL")
         MEMVAR->WNOMFAS := NOMFASOR
         MEMVAR->WSUMCOL := 0
         MEMVAR->WCANINSC := WCANINSCO
         DBCLOSEARE()

         DO WHILE WPIDCOL <> "N"

            MEMVAR->WCANCOL := 0
            MEMVAR->WNUMCOL := " "
            DEVPOS(16, 10)
            DEVOUT("INSUMO EN COLOR " + WINSCOL + " " + WNOMFAS)
            DEVPOS(17, 10)
            DEVOUT("NUMERO DEL COLOR ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WNUMCOL", NIL, NIL, NIL):DISPLAY())
            DEVPOS(18, 10)
            DEVOUT("CANT. DE UNID. PARA ESTE COLOR ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WCANCOL", "@Z 999999.99", NIL, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

            IF WSUMCOL + WCANCOL > WCANT

               DEVPOS(18, 30)
               DEVOUT("CANTIDAD EXCEDIDA, no la recibo")
               MEMVAR->X := INKEY(0)
               SCROLL(15, 5, 19, 75)
               SETPOS(15, 5)
               SETCOLOR("+GR")
               DISPBOX(15, 5, 19, 75, 1)
               SETCOLOR("+W")
               LOOP

            ENDIF

            AMAINS()
            __DBLOCATE({||CODIGO = WINSCOL .AND. NUMCOLOR = WNUMCOL}, NIL, ;
                  NIL, NIL, .F.)

            IF EOF()

               DBCLOSEARE()
               DEVPOS(17, 40)
               DEVOUT("COLOR NO EXISTE, no registro mov. ")
               MEMVAR->X := INKEY(0)
               SCROLL(15, 5, 19, 75)
               SETPOS(15, 5)
               SETCOLOR("+GR")
               DISPBOX(15, 5, 19, 75, 1)
               SETCOLOR("+W")
               LOOP

            ENDIF

            DEVPOS(18, 50)
            DEVOUT(COLOR)
            MEMVAR->WSUMCOL := WSUMCOL + WCANCOL
            MEMVAR->WNOMINS := NOMFASOR
            MEMVAR->WNOMCOL := COLOR
            MEMVAR->WCANRETAL := MEMVAR->WVUNI := 0
            VESAUN()
            DBCLOSEARE()
            MEMVAR->WVUNI := WVUNI + ROUND(WVUNI * ZPORCOS / 100, 2)
            SCROLL(15, 5, 19, 75)
            SETPOS(15, 5)
            SETCOLOR("+GR")
            DISPBOX(15, 5, 19, 75, 1)
            SETCOLOR("+W")
            MEMVAR->WCANINSCO := WCANINSC * WCANCOL
            SCROLL(16, 1, 18, 78)
            SETPOS(16, 1)
            DEVPOS(16, 10)
            DEVOUT("INSUMO " + WCODINS + SUBSTR(WNOMINS, 1, 20))
            DEVPOS(17, 10)
            DEVOUT("COLOR " + WNUMCOL + " CANT.para COLOR ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WCANINSCO", "@Z 999999.99", NIL, NIL);
                  :DISPLAY())
            DEVPOS(18, 10)
            DEVOUT("CANTIDAD DE RETAL ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WCANRETAL", "@Z 999999.99", NIL, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            AOPTES()
            ORDLISTCLE()
            ORDLISTADD("&ZDIS\&WDIRECTO\PICO")
            MEMVAR->WKEY := TRIM(WCODPRO) + TRIM(WINSCOL) + TRIM(WNUMCOL) + ;
                  ALLTRIM(TRANSFORM(WNUMORDP, "999999"))
            DBSEEK("&WKEY")

            IF EOF()

               DBAPPEND()

            ELSE

               VEALOCK()

            ENDIF

            FIELD->CODPRO := WCODPRO
            FIELD->NUMCOLOR := WNUMCOL
            FIELD->CANORD := CANORD + WCANCOL
            FIELD->CANTOT := WCANT
            FIELD->CANPED := WCANT
            FIELD->CODINS := WINSCOL
            FIELD->NUMINS := VAL(WINSCOL)
            FIELD->CANINS := CANINS + WCANINSCO
            FIELD->CANINV := CANINV + (WCANINSCO - WCANRETAL)
            FIELD->CANRETAL := CANRETAL + WCANRETAL
            FIELD->VALUNI := WVUNI
            FIELD->VALTOT := ROUND(CANINV * WVUNI, 2)
            FIELD->NUMORD := WNUMORDP
            FIELD->NOMBREPT := WNOMBRE
            FIELD->NOMINS := WNOMINS
            FIELD->FECHA := WDATE
            FIELD->PREVEN := WPREVEN
            FIELD->CODUSU := WCODUSU
            FIELD->HORA := TIME()
            MEMVAR->WPOSI := RECNO()

            IF WSUR = "S"

               DBGOTOP()

               DO WHILE  .NOT. EOF()

                  IF NUMORD = WNUMORDP

                     VEALOCK()
                     FIELD->SURTIDO := "S"

                  ENDIF

                  DBSKIP(1)

               ENDDO

            ENDIF

            DBGOTO(WPOSI)
            VEALOCK()
            FIELD->UNIDAD := WUNIDAD
            FIELD->PRINCOOP := WKEY
            FIELD->COLOR := WNOMCOL
            DBCOMMITAL()
            DBCLOSEARE()
            SCROLL(15, 5, 19, 75)
            SETPOS(15, 5)
            DISPBOX(15, 5, 19, 75, 1)
            MEMVAR->OPC := " "

            IF WCANT - WSUMCOL = 0

               MEMVAR->WPIDCOL := "N"
               LOOP

            ELSE

               DEVPOS(16, 10)
               DEVOUT("TIENE MAS COLORES ? S/N ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
                     :DISPLAY())
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}

               IF OPC = "N"

                  IF WSUMCOL - WCANT <> 0

                     DEVPOS(17, 10)
                     DEVOUT("LE QUEDAN AUN ")
                     DEVPOS(17, COL())
                     DEVOUTPICT(WCANT - WSUMCOL, "@# 999,999.99")
                     DEVPOS(17, COL() + 1)
                     DEVOUT("UNIDADES")
                     DEVPOS(18, 10)
                     DEVOUT("Por favor haga la orden")
                     MEMVAR->X := INKEY(0)
                     SCROLL(15, 5, 19, 75)
                     SETPOS(15, 5)
                     DISPBOX(15, 5, 19, 75, 1)

                  ELSE

                     MEMVAR->WPIDCOL := "N"

                  ENDIF

               ENDIF

            ENDIF

         ENDDO

      ENDIF

      SCROLL(15, 5, 19, 75)
      SETPOS(15, 5)
      DISPBOX(15, 5, 19, 75, 1)

      IF SWCOLOR2 = 1

         MEMVAR->WSUR := " "
         DEVPOS(16, 20)
         DEVOUT("SURTIDO SEGUNDO INS.EN COLOR ? S/N ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WSUR", "@!", {||WSUR $ "SN"}, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         MEMVAR->WPIDCOL := "S"
         SCROLL(15, 5, 19, 75)
         SETPOS(15, 5)
         SETCOLOR("+GR")
         DISPBOX(15, 5, 19, 75, 1)
         SETCOLOR("+W")
         AMAINS()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
         DBSEEK("&WINSCOL2")
         MEMVAR->WNOMFAS := NOMFASOR
         MEMVAR->WCANINSC := WCANINSCO2
         DBCLOSEARE()
         MEMVAR->WSUMCOL := 0

         DO WHILE WPIDCOL <> "N"

            MEMVAR->WCANCOL := 0
            MEMVAR->WNUMCOL := " "
            DEVPOS(16, 10)
            DEVOUT("2o INSUMO EN COLOR " + WINSCOL2 + " " + WNOMFAS)
            DEVPOS(17, 10)
            DEVOUT("NUMERO DEL COLOR ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WNUMCOL", NIL, NIL, NIL):DISPLAY())
            DEVPOS(18, 10)
            DEVOUT("CANT. DE UNID. PARA ESTE COLOR ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WCANCOL", "@Z 999,999", NIL, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

            IF WSUMCOL + WCANCOL > WCANT

               DEVPOS(18, 30)
               DEVOUT("CANTIDAD EXCEDIDA, no la recibo")
               MEMVAR->X := INKEY(0)
               SCROLL(15, 5, 19, 75)
               SETPOS(15, 5)
               SETCOLOR("+GR")
               DISPBOX(15, 5, 19, 75, 1)
               SETCOLOR("+W")
               LOOP

            ENDIF

            AMAINS()
            __DBLOCATE({||CODIGO = WINSCOL2 .AND. NUMCOLOR = WNUMCOL}, NIL,;
                   NIL, NIL, .F.)

            IF EOF()

               DBCLOSEARE()
               DEVPOS(17, 40)
               DEVOUT("COLOR NO EXISTE, no registro mov.")
               MEMVAR->X := INKEY(0)
               SCROLL(15, 5, 19, 75)
               SETPOS(15, 5)
               SETCOLOR("+GR")
               DISPBOX(15, 5, 19, 75, 1)
               SETCOLOR("+W")
               LOOP

            ENDIF

            DEVPOS(18, 50)
            DEVOUT(COLOR)
            MEMVAR->WSUMCOL := WSUMCOL + WCANCOL
            MEMVAR->WNOMINS := NOMFASOR
            MEMVAR->WNOMCOL := COLOR
            MEMVAR->WVUNI := MEMVAR->WCANRETAL := 0
            VESAUN()
            DBCLOSEARE()
            MEMVAR->WVUNI := WVUNI + ROUND(WVUNI * ZPORCOS / 100, 2)
            SCROLL(15, 5, 19, 75)
            SETPOS(15, 5)
            SETCOLOR("+GR")
            DISPBOX(15, 5, 19, 75, 1)
            SETCOLOR("+W")
            MEMVAR->WCANINSCO2 := WCANINSC * WCANCOL
            SCROLL(16, 1, 18, 78)
            SETPOS(16, 1)
            DEVPOS(16, 10)
            DEVOUT("INSUMO " + WCODINS + SUBSTR(WNOMINS, 1, 20))
            DEVPOS(17, 10)
            DEVOUT("COLOR " + WNUMCOL + " CANT.para COLOR ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WCANINSCO2", "@Z 999999.99", NIL, ;
                  NIL):DISPLAY())
            DEVPOS(18, 10)
            DEVOUT("CANTIDAD DE RETAL ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WCANRETAL", "@Z 999999.99", NIL, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            AOPTES()
            ORDLISTCLE()
            ORDLISTADD("&ZDIS\&WDIRECTO\PICO")
            MEMVAR->WKEY := TRIM(WCODPRO) + TRIM(WINSCOL2) + TRIM(WNUMCOL) +;
                   ALLTRIM(TRANSFORM(WNUMORDP, "999999"))
            DBSEEK("&WKEY")

            IF EOF()

               DBAPPEND()

            ELSE

               VEALOCK()

            ENDIF

            FIELD->CODPRO := WCODPRO
            FIELD->NUMCOLOR := WNUMCOL
            FIELD->CANORD := CANORD + WCANCOL
            FIELD->CANTOT := WCANT
            FIELD->CANPED := WCANT
            FIELD->CODINS := WINSCOL2
            FIELD->NUMINS := VAL(WINSCOL2)
            FIELD->CANINS := CANINS + WCANINSCO2
            FIELD->CANINV := CANINV + (WCANINSCO2 - WCANRETAL)
            FIELD->CANRETAL := CANRETAL + WCANRETAL
            FIELD->VALUNI := WVUNI
            FIELD->VALTOT := ROUND(CANINV * WVUNI, 2)
            FIELD->NUMORD := WNUMORDP
            FIELD->NOMBREPT := WNOMBRE
            FIELD->NOMINS := WNOMINS
            FIELD->FECHA := WDATE
            FIELD->PREVEN := WPREVEN
            FIELD->CODUSU := WCODUSU
            FIELD->HORA := TIME()
            MEMVAR->WPOSI := RECNO()

            IF WSUR = "S"

               DBGOTOP()

               DO WHILE  .NOT. EOF()

                  IF NUMORD = WNUMORDP

                     VEALOCK()
                     FIELD->SURTIDO := "S"

                  ENDIF

                  DBSKIP(1)

               ENDDO

            ENDIF

            DBGOTO(WPOSI)
            VEALOCK()
            FIELD->UNIDAD := WUNIDAD
            FIELD->PRINCOOP := WKEY
            FIELD->COLOR := WNOMCOL
            DBCOMMITAL()
            DBCLOSEARE()
            SCROLL(15, 5, 19, 75)
            SETPOS(15, 5)
            DISPBOX(15, 5, 19, 75, 1)
            MEMVAR->OPC := " "

            IF WCANT - WSUMCOL = 0

               MEMVAR->WPIDCOL := "N"
               LOOP

            ELSE

               DEVPOS(16, 10)
               DEVOUT("TIENE MAS COLORES ? S/N ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
                     :DISPLAY())
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}

               IF OPC = "N"

                  IF WSUMCOL - WCANT <> 0

                     DEVPOS(17, 10)
                     DEVOUT("LE QUEDAN AUN ")
                     DEVPOS(17, COL())
                     DEVOUTPICT(WCANT - WSUMCOL, "@# 999,999.99")
                     DEVPOS(17, COL() + 1)
                     DEVOUT("UNIDADES")
                     DEVPOS(18, 10)
                     DEVOUT("Por favor haga la orden")
                     MEMVAR->X := INKEY(0)
                     SCROLL(15, 5, 19, 75)
                     SETPOS(15, 5)
                     DISPBOX(15, 5, 19, 75, 1)

                  ELSE

                     MEMVAR->WPIDCOL := "N"

                  ENDIF

               ENDIF

            ENDIF

         ENDDO

      ENDIF

      SCROLL(6, 1, 23, 78)
      MEMVAR->OPC := ( SETPOS(6, 1), " " )
      DEVPOS(12, 20)
      DEVOUT("TIENE MAS ORDENES PARA ELABORAR ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      SETCOLOR("+G")
      DEVPOS(12, 30)
      DEVOUT("ORDENES")
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      SETCOLOR("+W")

      IF OPC = "N" .OR. LASTKEY() = 27

         MEMVAR->OPC := "*"

         IF WTIPCON = "A"

            MEMVAR->NUORPR := WNUMORDP
            FERASE("&ZDIS\&WDIRECTO\NUORPR.MEM")
            __MSAVE("&ZDIS\&WDIRECTO\NUORPR", "NUORPR", .T.)

         ELSE

            MEMVAR->NUORPRB := WNUMORDP
            FERASE("&ZDIS\&WDIRECTO\NUORPRB.MEM")
            __MSAVE("&ZDIS\&WDIRECTO\NUORPRB", "NUORPRB", .T.)

         ENDIF

      ENDIF

   ENDDO

   MENU()
   CIERRE()
   ESPERE()
   ACELAOR()
   CIERRE()
   __MRESTORE("&ZDIS\&WDIRECTO\LETRAS", .T.)
   MEMVAR->OPC := " "

RETURN 

