/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ELAORDPE
   Params: None.
   Return: Undefined
  Example: ELAORDPE()
  ..........................................................................
*/

PROCEDURE ELAORDPE()

   MEMVAR->OPC := " "
   __MRESTORE("&ZDIS\&WDIRECTO\LETRAS", .T.)
   __MRESTORE("ZPORCOS", .T.)
   CIERRE()
   MENU()
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

   IF MONTH(WDATE) <> ZMES

      __WAIT(" FECHA ERRADA, INTENTE DE NUEVO")
      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   AMAPAE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
   ORDLISTREB()
   DBCLOSEARE()
   AOPTEE()
   BORPICO()
   DBCREATEIN("&ZDIS\&WDIRECTO\PICO", "PRINCOOP", {||PRINCOOP}, NIL)
   DBCLOSEARE()
   AMAINER()
   DBCLOSEARE()
   MEMVAR->WTIPCON := " "
   SCROLL(5, 1, 23, 78)
   SETPOS(5, 1)
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

   MEMVAR->OPC := "N"
   DBSELECTAR("5")
   MENU()
   DEVPOS(12, 20)
   DEVOUT("ESTA COMENZANDO LA GRABACION ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   SETCOLOR("BG")
   DEVPOS(13, 20)
   DEVOUT("NOTA:")
   DEVPOS(14, 25)
   DEVOUT("Al responder SI, se borraran las  ordenes que tenga")
   DEVPOS(15, 25)
   DEVOUT("creadas en el archivo para la impresion de hojas de")
   DEVPOS(16, 25)
   DEVOUT("empaque y resumen de materia prima para entregar. ")
   DEVPOS(17, 25)
   DEVOUT("Si responde NO, las que elabore ahora se acumularan")
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

   AOPTEE()
   DBCREATEIN("&ZDIS\&WDIRECTO\PICO", "PRINCOOP", {||PRINCOOP}, NIL)
   MEMVAR->WULTREC := LASTREC()
   DBCLOSEARE()
   MEMVAR->WROL := " "

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

      MEMVAR->WNUMORDP := WNUMORDP + 1
      MENU()
      DEVPOS(5, 10)
      DEVOUT(;
            "ELABORACION DE ORDENES DE PRODUCCION DE PRODUCTOS ESPECIALES")
      MEMVAR->WCODPRO := ZLCPT
      DEVPOS(11, 20)
      DEVOUT("NUMERO DE LA ORDEN  :  " + ALLTRIM(TRANSFORM(WNUMORDP, ;
            "999999")))
      DEVPOS(12, 20)
      DEVOUT("CODIGO DEL PRODUCTO : ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCODPRO", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WCODPRO = "  " .OR. WCODPRO = "*" .OR. LASTKEY() = 27

         MEMVAR->OPC := "*"
         LOOP

      ENDIF

      IF VAL(WCODPRO) < 6000 .OR. VAL(WCODPRO) > 6999

         SETCOLOR("+GR")
         SET(31, "OFF")
         DEVPOS(14, 20)
         DEVOUT("La orden de producci" + O + "n para esa referencia ")
         DEVPOS(15, 20)
         DEVOUT("la debe elaborar con la opci" + O + "n n" + U + ;
               "mero 1 de ")
         DEVPOS(16, 20)
         DEVOUT("el  men" + U + " de  producci" + O + ;
               "n, correspondiente a ")
         DEVPOS(17, 20)
         DEVOUT("los productos de l" + I + "nea. ")
         MEMVAR->X := INKEY(0)
         SET(31, "ON")
         SETCOLOR("+W")
         SCROLL(14, 1, 23, 78)
         MEMVAR->WNUMORDP := ( SETPOS(14, 1), WNUMORDP - 1 )
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
         DEVOUT("CODIGO NO EXISTE")
         MEMVAR->X := INKEY(0)
         LOOP

      ENDIF

      DBCLOSEARE()
      MEMVAR->WCANT := MEMVAR->WCANPED := MEMVAR->WCOSDIR := MEMVAR->WPREVEN ;
            := 0
      MEMVAR->WSUR := " "
      MEMVAR->WCODCLI := SPACE(11)
      MEMVAR->WUNIDAD := SPACE(10)
      MEMVAR->WNOMCLI := SPACE(20)
      MEMVAR->WNOMBRE := SPACE(30)
      SETCOLOR("BG")
      DEVPOS(10, 20)
      DEVOUT("NOMBRE P.T.: ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WNOMBRE", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      SETCOLOR("+W")
      MEMVAR->WNOMBRE := UPPER(WNOMBRE)
      DEVPOS(13, 20)
      DEVOUT("CANTIDAD A FABRICAR : ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCANT", "@Z 999,999", NIL, NIL):DISPLAY())
      DEVPOS(14, 20)
      DEVOUT("    CANTIDAD PEDIDA : ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCANPED", "@Z 999,999", NIL, NIL):DISPLAY();
            )
      DEVPOS(15, 20)
      DEVOUT("VALOR DEL COSTO DIR.: ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCOSDIR", "@Z 999,999.99", NIL, NIL);
            :DISPLAY())
      DEVPOS(16, 20)
      DEVOUT("  UNIDAD DE EMPAQUE : ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WUNIDAD", "@!", NIL, NIL):DISPLAY())
      DEVPOS(17, 20)
      DEVOUT("     PRECIO DE VENTA: ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WPREVEN", "@# $$,$$$,$$$.$$", NIL, NIL);
            :DISPLAY())
      DEVPOS(18, 20)
      DEVOUT("            CLIENTE : ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WNOMCLI", NIL, NIL, NIL):DISPLAY())
      DEVPOS(19, 20)
      DEVOUT("       COD. CLIENTE : ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCODCLI", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WCANT = 0 .OR. LASTKEY() = 27

         MEMVAR->OPC := "*"
         LOOP

      ENDIF

      IF WTIPCON <> "A"

         MEMVAR->SWP := 1

      ELSE

         MEMVAR->SWP := 0

         IF WCOSDIR > 0

            MEMVAR->SWP := 1

         ENDIF

      ENDIF

      IF SWP = 0

         DEVPOS(15, 20)
         DEVOUT("VALOR DEL COSTO DIR.: ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCOSDIR", "@Z 999,999.99", {||WCOSDIR > ;
               0}, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ENDIF

      MEMVAR->WUNIDAD := UPPER(LTRIM(WUNIDAD))
      DEVPOS(19, 20)
      DEVOUT("                                  ")
      MEMVAR->ASIM := " "
      DEVPOS(19, 20)
      DEVOUT("ESTA REFERENCIA SE ASIMILA A ALGUNA DE LINEA ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "ASIM", "@!", {||ASIM $ "SN"}, NIL):DISPLAY(;
            ))
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      DEVPOS(19, 20)
      DEVOUT("                                                       ")
      MEMVAR->WCODASI := ZLCPT

      IF ASIM = "S"

         MEMVAR->SWEXISTE := 0

         DO WHILE SWEXISTE = 0

            MEMVAR->WCODAIS := ZLCPT
            DEVPOS(19, 20)
            DEVOUT("CUAL ES LA REFERENCIA ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WCODASI", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            AMAPAS()
            ORDLISTCLE()
            ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
            DBSEEK("&WCODASI")

            IF EOF()

               DBCLOSEARE()
               SETCOLOR("+G/BR")
               DEVPOS(19, 44)
               DEVOUT("CODIGO NO EXISTE")
               MEMVAR->X := INKEY(0)
               SETCOLOR("+W")
               SCROLL(19, 1, 19, 78)
               SETPOS(19, 1)
               LOOP

            ELSE

               DBCLOSEARE()
               MEMVAR->SWEXISTE := 1

            ENDIF

         ENDDO

      ENDIF

      SCROLL(6, 1, 23, 78)
      SETPOS(6, 1)
      DEVPOS(7, 2)
      DEVOUT("# O.P. ")
      SETCOLOR("+GR")
      DEVPOS(7, COL())
      DEVOUT(ALLTRIM(TRANSFORM(WNUMORDP, "999999")))
      SETCOLOR("+W")
      DEVPOS(7, 20)
      DEVOUT("C/TOT. ")
      SETCOLOR("+GR")
      DEVPOS(7, COL())
      DEVOUTPICT(WCANT, "@# 9999")
      SETCOLOR("+W")
      DEVPOS(7, 40)
      DEVOUT("C/PED. ")
      SETCOLOR("+GR")
      DEVPOS(7, COL())
      DEVOUTPICT(WCANPED, "@# 9999")
      SETCOLOR("+W")
      DEVPOS(8, 2)
      DEVOUT("PRODUCTO: ")
      SETCOLOR("+GR")
      DEVPOS(8, COL())
      DEVOUT(WCODPRO + WNOMBRE)
      SETCOLOR("+W")
      DEVPOS(9, 2)
      DEVOUT("CLIENTE : ")
      SETCOLOR("+GR")
      DEVPOS(9, COL())
      DEVOUT(ALLTRIM(WCODCLI) + " " + ALLTRIM(WNOMCLI))
      SETCOLOR("+W")
      MEMVAR->WCODINS := MEMVAR->WINSCOL := MEMVAR->WINSCOL2 := "    "
      MEMVAR->SWCOLOR := MEMVAR->WCANINSCO2 := MEMVAR->SWCOLOR2 := 0
      MEMVAR->WCODI := WCOSDIR

      IF ASIM = "S"

         MEMVAR->WCANINSCO := 0
         RUTPIDIN()
         MEMVAR->WCOSDIR := WCODI
         SCROLL(12, 5, 22, 75)
         SETPOS(12, 5)
         DISPBOX(12, 5, 22, 75, 1)

         IF SWCOLOR = 1

            MEMVAR->WSUR := " "
            SETCOLOR("+G")
            DEVPOS(20, 20)
            DEVOUT("SURTIDO ? S/N ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WSUR", "@!", {||WSUR $ "SN"}, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            SETCOLOR("+W")
            DEVPOS(20, 20)
            DEVOUT("                  ")
            MEMVAR->WPIDCOL := "S"
            SCROLL(12, 5, 22, 75)
            SETPOS(12, 5)
            SETCOLOR("+GR")
            DISPBOX(12, 5, 22, 75, 1)
            SETCOLOR("+W")
            AMAINS()
            ORDLISTCLE()
            ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
            DBSEEK("&WINSCOL")
            MEMVAR->WNOMFAS := NOMFASOR
            MEMVAR->WSUMCOL := 0
            DBCLOSEARE()
            MEMVAR->WCANINSC := WCANINSCO
            MEMVAR->WLLEVA := 0

            DO WHILE WPIDCOL <> "N"

               MEMVAR->WCANCOL := 0
               MEMVAR->WNUMCOL := " "
               SCROLL(13, 8, 21, 74)
               SETPOS(13, 8)

               IF WLLEVA > 0

                  SETCOLOR("+GR")
                  DEVPOS(12, 50)
                  DEVOUT("Lleva en colores " + ALLTRIM(TRANSFORM(WLLEVA, ;
                        "999,999")))
                  SETCOLOR("+W")

               ENDIF

               DEVPOS(13, 10)
               DEVOUT("INSUMO EN COLOR   : " + ALLTRIM(WINSCOL) + " " + ;
                     ALLTRIM(WNOMFAS))
               DEVPOS(14, 10)
               DEVOUT("NUMERO DEL COLOR ?:")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "WNUMCOL", NIL, NIL, NIL):DISPLAY();
                     )
               DEVPOS(15, 10)
               DEVOUT("UNIDADES DE P.T. PARA ESTE COLOR   ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "WCANCOL", "@Z 999999.99", NIL, ;
                     NIL):DISPLAY())
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}

               IF WSUMCOL + WCANCOL > WCANT

                  DEVPOS(16, 10)
                  DEVOUT("CANTIDAD EXCEDIDA, no la recibo")
                  MEMVAR->X := INKEY(0)
                  SCROLL(12, 5, 22, 75)
                  SETPOS(12, 5)
                  SETCOLOR("+GR")
                  DISPBOX(12, 5, 22, 75, 1)
                  SETCOLOR("+W")
                  LOOP

               ENDIF

               AMAINS()
               __DBLOCATE({||CODIGO = WINSCOL .AND. NUMCOLOR = WNUMCOL}, ;
                     NIL, NIL, NIL, .F.)

               IF EOF()

                  DBCLOSEARE()
                  DEVPOS(14, 35)
                  DEVOUT("COLOR NO EXISTE, no registro mov.")
                  MEMVAR->X := INKEY(0)
                  SCROLL(12, 5, 22, 75)
                  SETPOS(12, 5)
                  SETCOLOR("+GR")
                  DISPBOX(12, 5, 22, 75, 1)
                  SETCOLOR("+W")
                  LOOP

               ENDIF

               MEMVAR->WLLEVA := MEMVAR->WLLEVA + WCANCOL
               DEVPOS(14, 33)
               DEVOUT(COLOR)
               MEMVAR->WSUMCOL := WSUMCOL + WCANCOL
               MEMVAR->WNOMINS := NOMFASOR
               MEMVAR->WNOMCOL := COLOR
               MEMVAR->WCANRETAL := MEMVAR->WVUNI := 0
               VESAUN()
               DBCLOSEARE()
               MEMVAR->WVUNI := WVUNI + ROUND(WVUNI * ZPORCOS / 100, 2)
               MEMVAR->WCANINSCO := WCANINSC * WCANCOL
               DEVPOS(16, 10)
               DEVOUT("CANTIDAD DE MATERIAL DE ESTE COLOR ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "WCANINSCO", "@Z 999999.99", NIL, ;
                     NIL):DISPLAY())
               DEVPOS(17, 10)
               DEVOUT("                 CANTIDAD DE RETAL ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "WCANRETAL", "@Z 999999.99", NIL, ;
                     NIL):DISPLAY())
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}
               MEMVAR->WKEY := TRIM(WCODPRO) + TRIM(WINSCOL) + TRIM(WNUMCOL);
                      + ALLTRIM(TRANSFORM(WNUMORDP, "999999"))
               AOPTES()
               ORDLISTCLE()
               ORDLISTADD("&ZDIS\&WDIRECTO\PICO")
               DBSEEK("&WKEY")

               IF  .NOT. EOF()

                  DBCLOSEARE()
                  SETCOLOR("*+G")
                  DEVPOS(18, 10)
                  DEVOUT("INSUMO EN ORDEN YA EXISTE")
                  SETCOLOR("+G")
                  MEMVAR->OPC := " "
                  DEVPOS(19, 10)
                  DEVOUT("AUN ASI LO GRABA ? S/N ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, ;
                        NIL):DISPLAY())
                  READMODAL(GETLIST)
                  MEMVAR->GETLIST := {}
                  SCROLL(12, 5, 22, 75)
                  SETPOS(12, 5)
                  SETCOLOR("+W")

                  IF OPC <> "S"

                     MEMVAR->OPC := " "
                     LOOP

                  ENDIF

               ENDIF

               DBCLOSEARE()
               SCROLL(12, 5, 22, 75)
               SETPOS(12, 5)
               AOPTES()
               ORDLISTCLE()
               ORDLISTADD("&ZDIS\&WDIRECTO\PICO")
               DBAPPEND()
               FIELD->CODPRO := WCODPRO
               FIELD->NUMCOLOR := WNUMCOL
               FIELD->CANORD := CANORD + WCANCOL
               FIELD->CANPED := WCANPED
               FIELD->CANTOT := WCANT
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
               FIELD->UNIDAD := WUNIDAD
               FIELD->COLOR := WNOMCOL
               FIELD->NOMCLI := WNOMCLI
               FIELD->CODCLI := WCODCLI
               FIELD->COSDIR := WCOSDIR
               FIELD->PRINCOOP := WKEY
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

               DBCOMMITAL()
               DBCLOSEARE()
               SCROLL(12, 5, 22, 75)
               SETPOS(12, 5)
               DISPBOX(12, 5, 22, 75, 1)
               MEMVAR->OPC := " "

               IF WCANT - WSUMCOL = 0

                  MEMVAR->WPIDCOL := "N"
                  LOOP

               ELSE

                  DEVPOS(16, 10)
                  DEVOUT("TIENE MAS COLORES ? S/N ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, ;
                        NIL):DISPLAY())
                  READMODAL(GETLIST)
                  MEMVAR->GETLIST := {}

                  IF OPC = "N"

                     IF WSUMCOL - WCANT <> 0

                        DEVPOS(17, 10)
                        DEVOUT("LE QUEDAN AUN " + ALLTRIM(TRANSFORM(WCANT -;
                               WSUMCOL, "999,999")) + ;
                              " unidades por definir color")
                        DEVPOS(18, 10)
                        DEVOUT("Por favor haga la orden")
                        MEMVAR->X := INKEY(0)
                        SCROLL(12, 5, 22, 75)
                        SETPOS(12, 5)
                        DISPBOX(12, 5, 22, 75, 1)

                     ELSE

                        MEMVAR->WPIDCOL := "N"

                     ENDIF

                  ENDIF

               ENDIF

            ENDDO

         ENDIF

         IF SWCOLOR2 = 1

            MEMVAR->WSUR := " "
            SETCOLOR("+G")
            DEVPOS(20, 20)
            DEVOUT("2o INSUMO SURTIDO ? S/N ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WSUR", "@!", {||WSUR $ "SN"}, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            SETCOLOR("+W")
            DEVPOS(20, 20)
            DEVOUT("                  ")
            MEMVAR->WPIDCOL := "S"
            SCROLL(12, 5, 22, 75)
            SETPOS(12, 5)
            SETCOLOR("+GR")
            DISPBOX(12, 5, 22, 75, 1)
            SETCOLOR("+W")
            AMAINS()
            ORDLISTCLE()
            ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
            DBSEEK("&WINSCOL2")
            MEMVAR->WNOMFAS := NOMFASOR
            DBCLOSEARE()
            MEMVAR->WSUMCOL := 0
            MEMVAR->WCANINSC := WCANINSCO2

            DO WHILE WPIDCOL <> "N"

               MEMVAR->WCANCOL := 0
               MEMVAR->WNUMCOL := " "
               SCROLL(16, 1, 18, 78)
               SETPOS(16, 1)
               DEVPOS(16, 10)
               DEVOUT("INSUMO EN COLOR " + WNOMFAS)
               DEVPOS(17, 10)
               DEVOUT("NUMERO DEL COLOR ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "WNUMCOL", NIL, NIL, NIL):DISPLAY();
                     )
               DEVPOS(18, 10)
               DEVOUT("CANT. DE UNID. PARA ESTE COLOR ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "WCANCOL", "@Z 999999.99", NIL, ;
                     NIL):DISPLAY())
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}

               IF WSUMCOL + WCANCOL > WCANT

                  DEVPOS(18, 30)
                  DEVOUT("CANTIDAD EXCEDIDA, no la recibo")
                  MEMVAR->X := INKEY(0)
                  SCROLL(12, 5, 22, 75)
                  SETPOS(12, 5)
                  SETCOLOR("+GR")
                  DISPBOX(12, 5, 22, 75, 1)
                  SETCOLOR("+W")
                  LOOP

               ENDIF

               AMAINS()
               __DBLOCATE({||CODIGO = WINSCOL2 .AND. NUMCOLOR = WNUMCOL}, ;
                     NIL, NIL, NIL, .F.)

               IF EOF()

                  DBCLOSEARE()
                  DEVPOS(17, 40)
                  DEVOUT("COLOR NO EXISTE, no registro mov.")
                  MEMVAR->X := INKEY(0)
                  SCROLL(12, 5, 22, 75)
                  SETPOS(12, 5)
                  SETCOLOR("+GR")
                  DISPBOX(12, 5, 22, 75, 1)
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
               SCROLL(12, 5, 22, 75)
               SETPOS(12, 5)
               SETCOLOR("+GR")
               DISPBOX(12, 5, 22, 75, 1)
               SETCOLOR("+W")
               MEMVAR->WCANINSCO2 := WCANINSC * WCANCOL
               SCROLL(16, 1, 18, 78)
               MEMVAR->WCODINS2 := ( SETPOS(16, 1), WINSCOL2 )
               DEVPOS(16, 10)
               DEVOUT("INSUMO " + WCODINS2 + SUBSTR(WNOMINS, 1, 20))
               DEVPOS(17, 10)
               DEVOUT("COLOR " + WNUMCOL + " CANT. x COLOR. ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "WCANINSCO2", "@Z 999999.99", NIL, ;
                     NIL):DISPLAY())
               DEVPOS(18, 10)
               DEVOUT("CANTIDAD DE RETAL ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "WCANRETAL", "@Z 999999.99", NIL, ;
                     NIL):DISPLAY())
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}

               IF WCANINSCO2 + WCANRETAL = 0

                  MEMVAR->WSUMCOL := WSUMCOL - WCANCOL
                  LOOP

               ENDIF

               MEMVAR->WKEY := TRIM(WCODPRO) + TRIM(WINSCOL2) + TRIM(;
                     WNUMCOL) + ALLTRIM(TRANSFORM(WNUMORDP, "999999"))
               AOPTES()
               ORDLISTCLE()
               ORDLISTADD("&ZDIS\&WDIRECTO\PICO")
               DBSEEK("&WKEY")

               IF  .NOT. EOF()

                  DBCLOSEARE()
                  SETCOLOR("*+G")
                  DEVPOS(18, 10)
                  DEVOUT("INSUMO EN ORDEN YA EXISTE")
                  SETCOLOR("+G")
                  MEMVAR->OPC := " "
                  DEVPOS(19, 10)
                  DEVOUT("AUN ASI LO GRABA ? S/N ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, ;
                        NIL):DISPLAY())
                  READMODAL(GETLIST)
                  MEMVAR->GETLIST := {}
                  SCROLL(12, 5, 22, 75)
                  SETPOS(12, 5)
                  SETCOLOR("+W")

                  IF OPC <> "S" .OR. LASTKEY() = 27

                     MEMVAR->OPC := " "
                     LOOP

                  ENDIF

               ENDIF

               SCROLL(12, 5, 22, 75)
               SETPOS(12, 5)
               DBCLOSEARE()
               AOPTES()
               ORDLISTCLE()
               ORDLISTADD("&ZDIS\&WDIRECTO\PICO")
               DBAPPEND()
               FIELD->CODPRO := WCODPRO
               FIELD->NUMCOLOR := WNUMCOL
               FIELD->CANORD := CANORD + WCANCOL
               FIELD->CANPED := WCANPED
               FIELD->CANTOT := WCANT
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
               FIELD->UNIDAD := WUNIDAD
               FIELD->COLOR := WNOMCOL
               FIELD->NOMCLI := WNOMCLI
               FIELD->CODCLI := WCODCLI
               FIELD->COSDIR := WCOSDIR
               FIELD->PRINCOOP := WKEY
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

               DBCOMMITAL()
               DBCLOSEARE()
               SCROLL(12, 5, 22, 75)
               SETPOS(12, 5)
               DISPBOX(12, 5, 22, 75, 1)
               MEMVAR->OPC := " "

               IF WCANT - WSUMCOL = 0

                  MEMVAR->WPIDCOL := "N"
                  LOOP

               ELSE

                  DEVPOS(16, 10)
                  DEVOUT("TIENE MAS COLORES ? S/N ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, ;
                        NIL):DISPLAY())
                  READMODAL(GETLIST)
                  MEMVAR->GETLIST := {}

                  IF OPC = "N" .OR. LASTKEY() = 27

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
                        SCROLL(12, 5, 22, 75)
                        SETPOS(12, 5)
                        DISPBOX(12, 5, 22, 75, 1)

                     ELSE

                        MEMVAR->WPIDCOL := "N"

                     ENDIF

                  ENDIF

               ENDIF

            ENDDO

         ENDIF

      ENDIF

      MEMVAR->OPC := " "

      DO WHILE OPC <> "N"

         MEMVAR->WCODINS := "    "
         MEMVAR->WNOMINS := SPACE(20)
         MEMVAR->WCANINS := MEMVAR->WCANRETAL := 0
         SCROLL(12, 5, 22, 75)
         SETPOS(12, 5)
         SETCOLOR("+GR")
         DISPBOX(12, 5, 22, 75, 1)
         SETCOLOR("W")
         DEVPOS(16, 10)
         DEVOUT("CODIGO DEL INSUMO ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCODINS", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF WCODINS = "   " .OR. LASTKEY() = 27

            MEMVAR->OPC := "N"
            LOOP

         ENDIF

         AMAINS()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
         DBSEEK("&WCODINS")

         IF EOF()

            DBCLOSEARE()
            DEVPOS(16, 36)
            DEVOUT("Ins. no existe ")
            MEMVAR->X := INKEY(0)
            SCROLL(12, 5, 22, 75)
            SETPOS(12, 5)
            SETCOLOR("+GR")
            DISPBOX(12, 5, 22, 75, 1)
            SETCOLOR("+W")
            LOOP

         ENDIF

         DBCLOSEARE()
         MEMVAR->WNUMCOL := " "

         IF VAL(WCODINS) > 199 .AND. VAL(WCODINS) < 300

            MEMVAR->WINSCOL := WCODINS
            MEMVAR->WSUR := " "
            DEVPOS(20, 20)
            DEVOUT("SURTIDO ? S/N ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WSUR", "@!", {||WSUR $ "SN"}, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            MEMVAR->WPIDCOL := "S"
            SCROLL(12, 5, 22, 75)
            SETPOS(12, 5)
            SETCOLOR("+GR")
            DISPBOX(12, 5, 22, 75, 1)
            SETCOLOR("+W")
            AMAINS()
            ORDLISTCLE()
            ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
            DBSEEK("&WINSCOL")
            MEMVAR->WNOMFAS := NOMFASOR
            DBCLOSEARE()
            MEMVAR->WSUMCOL := 0

            DO WHILE WPIDCOL <> "N"

               MEMVAR->WCANCOL := 0
               MEMVAR->WNUMCOL := " "
               DEVPOS(16, 10)
               DEVOUT("INSUMO EN COLOR " + WNOMFAS)
               DEVPOS(17, 10)
               DEVOUT("NUMERO DEL COLOR ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "WNUMCOL", NIL, NIL, NIL):DISPLAY();
                     )
               DEVPOS(18, 10)
               DEVOUT("CANT. DE P.T. PARA ESTE COLOR ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "WCANCOL", "@Z 999999", {||WCANCOL ;
                     <> 0}, NIL):DISPLAY())
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}
               AMAINS()
               __DBLOCATE({||CODIGO = WINSCOL .AND. NUMCOLOR = WNUMCOL}, ;
                     NIL, NIL, NIL, .F.)

               IF  .NOT. EOF()

                  DEVPOS(16, 10)
                  DEVOUT(WCODINS + " " + TRIM(SUBSTR(WNOMINS, 1, 20)) + ;
                        " " + COLOR)

               ENDIF

               DBCLOSEARE()
               MEMVAR->WKEY := TRIM(WCODPRO) + TRIM(WINSCOL) + TRIM(WNUMCOL);
                      + ALLTRIM(TRANSFORM(WNUMORDP, "999999"))
               AOPTES()
               ORDLISTCLE()
               ORDLISTADD("&ZDIS\&WDIRECTO\PICO")
               DBSEEK("&WKEY")

               IF  .NOT. EOF()

                  DBCLOSEARE()
                  SETCOLOR("*+G")
                  DEVPOS(18, 10)
                  DEVOUT("INSUMO EN ORDEN YA EXISTE")
                  SETCOLOR("+G")
                  MEMVAR->OPC := " "
                  DEVPOS(19, 10)
                  DEVOUT("LO GRABA ? S/N ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, ;
                        NIL):DISPLAY())
                  READMODAL(GETLIST)
                  MEMVAR->GETLIST := {}
                  SETCOLOR("+W")
                  SCROLL(12, 5, 22, 75)
                  SETPOS(12, 5)

                  IF OPC <> "S" .OR. LASTKEY() = 27

                     MEMVAR->OPC := " "
                     LOOP

                  ENDIF

               ENDIF

               SCROLL(12, 5, 22, 75)
               SETPOS(12, 5)
               DBCLOSEARE()

               IF WSUMCOL + WCANCOL > WCANT

                  DEVPOS(18, 30)
                  DEVOUT("CANTIDAD EXCEDIDA, no la recibo")
                  MEMVAR->X := INKEY(0)
                  SCROLL(12, 5, 22, 75)
                  SETPOS(12, 5)
                  SETCOLOR("+GR")
                  DISPBOX(12, 5, 22, 75, 1)
                  SETCOLOR("+W")
                  LOOP

               ENDIF

               AMAINS()
               __DBLOCATE({||CODIGO = WINSCOL .AND. NUMCOLOR = WNUMCOL}, ;
                     NIL, NIL, NIL, .F.)

               IF EOF()

                  DBCLOSEARE()
                  DEVPOS(17, 40)
                  DEVOUT("COLOR NO EXISTE, no registro mov.")
                  MEMVAR->X := INKEY(0)
                  SCROLL(12, 5, 22, 75)
                  SETPOS(12, 5)
                  SETCOLOR("+GR")
                  DISPBOX(12, 5, 22, 75, 1)
                  SETCOLOR("+W")
                  LOOP

               ENDIF

               DEVPOS(18, 50)
               DEVOUT(COLOR)
               MEMVAR->WSUMCOL := WSUMCOL + WCANCOL
               MEMVAR->WNOMINS := NOMFASOR
               MEMVAR->WNOMCOL := COLOR
               MEMVAR->WVUNI := MEMVAR->WCANRETAL := MEMVAR->WCANINSCO := 0
               VESAUN()
               DBCLOSEARE()
               MEMVAR->WVUNI := WVUNI + ROUND(WVUNI * ZPORCOS / 100, 2)
               SCROLL(12, 5, 22, 75)
               SETPOS(12, 5)
               SETCOLOR("+GR")
               DISPBOX(12, 5, 22, 75, 1)
               SETCOLOR("+W")
               SCROLL(12, 5, 22, 75)
               SETPOS(12, 5)
               SETCOLOR("+GR")
               DISPBOX(12, 5, 22, 75, 1)
               SETCOLOR("+W")
               MEMVAR->WCAL := " "
               DEVPOS(14, 15)
               DEVOUT("Realizo calculos de rendimiento ? S/N ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "WCAL", "@!", {||WCAL $ "SN"}, NIL);
                     :DISPLAY())
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}
               DEVPOS(14, 15)
               DEVOUT("                                          ")
               MEMVAR->WY1 := MEMVAR->WY2 := MEMVAR->WX1 := MEMVAR->WX2 := ;
                     MEMVAR->CC := MEMVAR->SWCAL := 0
               MEMVAR->WCH := " "

               IF WCAL = "S"

                  MEMVAR->SWCAL := 1

               ENDIF

               IF WCAL = "S"

                  SETCOLOR("+GR/+B")
                  DEVPOS(13, 23)
                  DEVOUT("REALIZANDO CALCULOS DE RENDIMIENTO")
                  SETCOLOR("+W")
                  MEMVAR->WROL := " "
                  DEVPOS(15, 20)
                  DEVOUT("<R>ollo o <L>amina ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "WROL", "@!", {||WROL $ "RL"}, ;
                        NIL):DISPLAY())
                  READMODAL(GETLIST)
                  MEMVAR->GETLIST := {}
                  SET(3, 4)

                  IF WROL = "R"

                     SETCOLOR("+GR/+B")
                     DEVPOS(14, 30)
                     DEVOUT("PARA CORTES DE ROLLO")
                     SETCOLOR("W")
                     DEVPOS(16, 15)
                     DEVOUT("Ancho del rollo ? ")
                     SETPOSBS()
                     AADD(GETLIST, __GET(NIL, "WY1", "@# 999.9999", NIL, ;
                           NIL):DISPLAY())
                     DEVPOS(17, 15)
                     DEVOUT("Largo del corte ? ")
                     SETPOSBS()
                     AADD(GETLIST, __GET(NIL, "WX1", "@# 999.9999", NIL, ;
                           NIL):DISPLAY())
                     DEVPOS(18, 15)
                     DEVOUT("Ancho del corte ? ")
                     SETPOSBS()
                     AADD(GETLIST, __GET(NIL, "WX2", "@# 999.9999", NIL, ;
                           NIL):DISPLAY())

                     IF UPPER(WCAL) = "N"

                        READKILL(.T.)
                        MEMVAR->GETLIST := {}

                     ELSE

                        READMODAL(GETLIST)
                        MEMVAR->GETLIST := {}

                     ENDIF

                     MEMVAR->WZ1 := INT(WY1 / WX1)
                     MEMVAR->WW1 := WZ1 * WX1 - WY1
                     MEMVAR->WSALEN1 := WZ1
                     MEMVAR->WTIRA1 := WX2
                     MEMVAR->WZ2 := INT(WY1 / WX2)
                     MEMVAR->WW2 := WZ2 * WX2 - WY1
                     MEMVAR->WSALEN2 := WZ2
                     MEMVAR->WTIRA2 := WX1

                     IF WW1 > WW2

                        MEMVAR->WSALEN := WSALEN1
                        MEMVAR->WTIRA := WTIRA1

                     ELSEIF WW1 = WW2

                        MEMVAR->WSALEN := WSALEN1
                        MEMVAR->WTIRA := WTIRA1
                        DEVPOS(18, 50)
                        DEVOUT("DA IGUAL ")

                     ELSEIF WW1 < WW2

                        MEMVAR->WSALEN := WSALEN2
                        MEMVAR->WTIRA := WTIRA2

                     ENDIF

                     SETCOLOR("+W")
                     DEVPOS(19, 15)
                     DEVOUT("SALEN ")
                     SETCOLOR("+G")
                     DEVPOS(19, COL())
                     DEVOUT(ALLTRIM(TRANSFORM(WSALEN, "999999")))
                     SETCOLOR("+W")
                     DEVPOS(19, COL())
                     DEVOUT(" EN TIRAS DE ")
                     SETCOLOR("+G")
                     DEVPOS(19, COL())
                     DEVOUTPICT(WTIRA, "@# 99,999.99")
                     SETCOLOR("+W")

                     IF UPPER(WCAL) = "N"

                        READKILL(.T.)
                        MEMVAR->GETLIST := {}

                     ELSE

                        READMODAL(GETLIST)
                        MEMVAR->GETLIST := {}

                     ENDIF

                     SCROLL(12, 5, 22, 75)
                     SETPOS(12, 5)
                     SETCOLOR("+GR")
                     DISPBOX(12, 5, 22, 75, 1)
                     SETCOLOR("W")
                     DEVPOS(15, 10)
                     DEVOUT("Cuantos cortes necesita ? ")
                     SETPOSBS()
                     AADD(GETLIST, __GET(NIL, "CC", "@Z 999,999", NIL, NIL);
                           :DISPLAY())

                     IF WCAL = "N"

                        READKILL(.T.)
                        MEMVAR->GETLIST := {}

                     ELSE

                        READMODAL(GETLIST)
                        MEMVAR->GETLIST := {}

                     ENDIF

                     MEMVAR->WCANINS := CC / WSALEN * WTIRA
                     MEMVAR->WCANRETAL := 999999

                     DO WHILE WCANRETAL > WCANINS

                        MEMVAR->WCANRETAL := 0
                        DEVPOS(16, 10)
                        DEVOUT("De los ")
                        SETPOS(16, COL())
                        AADD(GETLIST, __GET(NIL, "WCANINS", "@# 9,999.99", ;
                              NIL, NIL):DISPLAY())
                        DEVPOS(16, COL() + 1)
                        DEVOUT("metros, cuantos son de ")
                        DEVPOS(17, 10)
                        DEVOUT("retal ? ")
                        SETPOSBS()
                        AADD(GETLIST, __GET(NIL, "WCANRETAL", ;
                              "@# 9,999.99", NIL, NIL):DISPLAY())
                        READMODAL(GETLIST)
                        MEMVAR->GETLIST := {}

                     ENDDO

                     MEMVAR->WCANINV := WCANINS - WCANRETAL

                  ELSEIF WROL = "L"

                     SETCOLOR("+GR/+B")
                     DEVPOS(14, 30)
                     DEVOUT("PARA CORTES DE PLIEGO")
                     SETCOLOR("W")
                     DEVPOS(16, 15)
                     DEVOUT("Ancho del pliego ? ")
                     SETPOSBS()
                     AADD(GETLIST, __GET(NIL, "WY1", "@# 999.9999", NIL, ;
                           NIL):DISPLAY())
                     DEVPOS(17, 15)
                     DEVOUT("Largo del pliego ? ")
                     SETPOSBS()
                     AADD(GETLIST, __GET(NIL, "WY2", "@# 999.9999", NIL, ;
                           NIL):DISPLAY())
                     DEVPOS(18, 15)
                     DEVOUT("Ancho del corte  ? ")
                     SETPOSBS()
                     AADD(GETLIST, __GET(NIL, "WX1", "@# 999.9999", NIL, ;
                           NIL):DISPLAY())
                     DEVPOS(19, 15)
                     DEVOUT("Largo del corte  ? ")
                     SETPOSBS()
                     AADD(GETLIST, __GET(NIL, "WX2", "@# 999.9999", NIL, ;
                           NIL):DISPLAY())

                     IF UPPER(WCAL) = "N"

                        READKILL(.T.)
                        MEMVAR->GETLIST := {}

                     ELSE

                        READMODAL(GETLIST)
                        MEMVAR->GETLIST := {}

                     ENDIF

                     MEMVAR->WZ1 := INT(WY1 / WX1)
                     MEMVAR->WZ2 := INT(WY2 / WX2)
                     MEMVAR->WW1 := INT(WZ1) * INT(WZ2)
                     MEMVAR->WZ3 := INT(WY2 / WX1)
                     MEMVAR->WZ4 := INT(WY1 / WX2)
                     MEMVAR->WW2 := INT(WZ3) * INT(WZ4)

                     IF WW1 > WW2

                        MEMVAR->WLARGO := INT(WZ1)
                        MEMVAR->WANCHO := INT(WZ2)
                        MEMVAR->WCORTE1 := LTRIM(STR(WY1 * 100)) + "/" + ;
                              LTRIM(STR(WX1 * 100)) + "=" + LTRIM(STR(WZ1))
                        MEMVAR->WCORTE2 := LTRIM(STR(WY2 * 100)) + "/" + ;
                              LTRIM(STR(WX2 * 100)) + "=" + LTRIM(STR(WZ2))

                     ELSEIF WW1 = WW2

                        MEMVAR->WLARGO := INT(WZ1)
                        MEMVAR->WANCHO := INT(WZ2)
                        MEMVAR->WCORTE1 := LTRIM(STR(WY1 * 100)) + "/" + ;
                              LTRIM(STR(WX1 * 100)) + "=" + LTRIM(STR(WZ1))
                        MEMVAR->WCORTE2 := LTRIM(STR(WY2 * 100)) + "/" + ;
                              LTRIM(STR(WX2 * 100)) + "=" + LTRIM(STR(WZ2))

                     ELSEIF WW1 < WW2

                        MEMVAR->WLARGO := INT(WZ3)
                        MEMVAR->WANCHO := INT(WZ4)
                        MEMVAR->WCORTE1 := LTRIM(STR(WY2 * 100)) + "/" + ;
                              LTRIM(STR(WX1 * 100)) + "=" + LTRIM(STR(WZ3))
                        MEMVAR->WCORTE2 := LTRIM(STR(WY1 * 100)) + "/" + ;
                              LTRIM(STR(WX2 * 100)) + "=" + LTRIM(STR(WZ4))

                     ENDIF

                     SCROLL(12, 5, 22, 75)
                     SETPOS(12, 5)
                     DEVPOS(14, 10)
                     DEVOUT("SALEN ")
                     SETCOLOR("+G")
                     DEVPOS(14, COL())
                     DEVOUT(WCORTE1 + " Y " + WCORTE2)
                     DEVPOS(15, 10)
                     DEVOUTPICT(WLARGO * WANCHO, "@# 999")
                     SETCOLOR("+W")
                     DEVPOS(15, COL())
                     DEVOUT("POR PLIEGO")

                     IF WCAL = "N"

                        READKILL(.T.)
                        MEMVAR->GETLIST := {}

                     ELSE

                        READMODAL(GETLIST)
                        MEMVAR->GETLIST := {}

                     ENDIF

                     SCROLL(12, 5, 22, 75)
                     SETPOS(12, 5)
                     SETCOLOR("+GR")
                     DISPBOX(12, 5, 22, 75, 1)
                     SETCOLOR("+W")
                     DEVPOS(15, 10)
                     DEVOUT("Cuantos cortes necesita ? ")
                     SETPOSBS()
                     AADD(GETLIST, __GET(NIL, "CC", "@Z 99999,999.99", NIL,;
                            NIL):DISPLAY())

                     IF WCAL = "N"

                        READKILL(.T.)
                        MEMVAR->GETLIST := {}

                     ELSE

                        READMODAL(GETLIST)
                        MEMVAR->GETLIST := {}

                     ENDIF

                     MEMVAR->WCANINS := CC / (WLARGO * WANCHO)
                     MEMVAR->WCANRETAL := 99999

                     DO WHILE WCANRETAL > WCANINS

                        MEMVAR->WCANRETAL := 0
                        DEVPOS(16, 10)
                        DEVOUT("De los ")
                        SETPOS(16, COL())
                        AADD(GETLIST, __GET(NIL, "WCANINS", "@# 9,999.99", ;
                              NIL, NIL):DISPLAY())
                        DEVPOS(16, COL() + 1)
                        DEVOUT("pliegos, cuantos son de ")
                        DEVPOS(17, 10)
                        DEVOUT("retal ? ")
                        SETPOSBS()
                        AADD(GETLIST, __GET(NIL, "WCANRETAL", ;
                              "@# 9,999.99", NIL, NIL):DISPLAY())
                        READMODAL(GETLIST)
                        MEMVAR->GETLIST := {}

                     ENDDO

                     MEMVAR->WCANINV := WCANINS - WCANRETAL

                  ENDIF

               ELSE

                  DEVPOS(14, 15)
                  DEVOUT("                                          ")
                  DEVPOS(14, 15)
                  DEVOUT("son <C>ortes o <H>errajes ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "WCH", "@!", {||WCH $ "CH"}, ;
                        NIL):DISPLAY())
                  SETCOLOR("+G")
                  DEVPOS(14, 20)
                  DEVOUT("C")
                  DEVPOS(14, 31)
                  DEVOUT("H")
                  SETCOLOR("+GR")
                  DEVPOS(15, 5)
                  DEVOUT("Nota:")
                  DEVPOS(16, 15)
                  DEVOUT("Seleccione Cortes SOLO si ")
                  DEVPOS(17, 15)
                  DEVOUT("el anterior insumo fue de cortes")
                  DEVPOS(18, 15)
                  DEVOUT("y tiene las mismas medidas que este.")
                  SETCOLOR("+W")
                  READMODAL(GETLIST)
                  MEMVAR->GETLIST := {}
                  SCROLL(15, 5, 18, 60)
                  SETPOS(15, 5)
                  DEVPOS(14, 15)
                  DEVOUT("                                   ")

                  IF WCH = "H"

                     MEMVAR->WROL := " "
                     MEMVAR->WCANINS := MEMVAR->WCANRETAL := 0
                     SCROLL(14, 10, 17, 50)
                     SETPOS(14, 10)

                     DO WHILE WCANINS + WCANRETAL = 0

                        DEVPOS(14, 15)
                        DEVOUT("CUANTOS SON EN TOTAL ?   ")
                        SETPOSBS()
                        AADD(GETLIST, __GET(NIL, "WCANINS", ;
                              "@Z 99999,999.99", NIL, NIL):DISPLAY())
                        DEVPOS(15, 15)
                        DEVOUT("CUANTOS SON DE <retal> ? ")
                        SETPOSBS()
                        AADD(GETLIST, __GET(NIL, "WCANRETAL", ;
                              "@Z 99999,999.99", NIL, NIL):DISPLAY())
                        READMODAL(GETLIST)
                        MEMVAR->GETLIST := {}

                     ENDDO

                  ENDIF

               ENDIF

               SET(3, 4)
               AOPTES()
               ORDLISTCLE()
               ORDLISTADD("&ZDIS\&WDIRECTO\PICO")
               DBAPPEND()
               FIELD->CODPRO := WCODPRO
               FIELD->NUMCOLOR := WNUMCOL
               FIELD->CANORD := CANORD + WCANCOL
               FIELD->CANPED := WCANPED
               FIELD->CANTOT := WCANT
               FIELD->CODINS := WINSCOL
               FIELD->NUMINS := VAL(WINSCOL)
               FIELD->CANINS := CANINS + WCANINS
               FIELD->CANINV := CANINV + (WCANINS - WCANRETAL)
               FIELD->CANRETAL := CANRETAL + WCANRETAL
               FIELD->VALUNI := WVUNI
               FIELD->CODUSU := WCODUSU
               FIELD->HORA := TIME()

               IF CANINV < 0.001

                  FIELD->VALTOT := 0

               ELSE

                  FIELD->VALTOT := ROUND(CANINV * WVUNI, 2)

               ENDIF

               FIELD->NUMORD := WNUMORDP
               FIELD->NOMBREPT := WNOMBRE
               FIELD->NOMINS := WNOMINS
               FIELD->FECHA := WDATE
               FIELD->PREVEN := WPREVEN

               IF WCH <> "H" .AND. SWCAL = 1

                  FIELD->ROL := WROL
                  FIELD->UNIDAD := WUNIDAD

                  IF WROL = "L"

                     FIELD->CORTE1 := WCORTE1
                     FIELD->CORTE2 := WCORTE2

                  ELSE

                     FIELD->SALEN := WSALEN
                     FIELD->TIRAS := WTIRA

                  ENDIF

               ENDIF

               MEMVAR->WKEY := TRIM(WCODPRO) + TRIM(WCODINS) + TRIM(WNUMCOL);
                      + ALLTRIM(TRANSFORM(WNUMORDP, "999999"))
               FIELD->UNIDAD := WUNIDAD
               FIELD->COLOR := WNOMCOL
               FIELD->NOMCLI := WNOMCLI
               FIELD->CODCLI := WCODCLI
               FIELD->COSDIR := WCOSDIR
               FIELD->PRINCOOP := WKEY
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

               DBCOMMITAL()
               DBCLOSEARE()
               SCROLL(12, 5, 22, 75)
               SETPOS(12, 5)
               DISPBOX(12, 5, 22, 75, 1)
               MEMVAR->OPC := " "

               IF WCANT - WSUMCOL = 0

                  MEMVAR->WPIDCOL := "N"
                  LOOP

               ELSE

                  DEVPOS(16, 10)
                  DEVOUT("TIENE MAS COLORES ? S/N ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, ;
                        NIL):DISPLAY())
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
                        SCROLL(12, 5, 22, 75)
                        SETPOS(12, 5)
                        DISPBOX(12, 5, 22, 75, 1)

                     ELSE

                        MEMVAR->WPIDCOL := "N"

                     ENDIF

                  ENDIF

               ENDIF

            ENDDO

         ELSE

            AOPTES()
            ORDLISTCLE()
            ORDLISTADD("&ZDIS\&WDIRECTO\PICO")
            MEMVAR->WKEY := TRIM(WCODPRO) + TRIM(WCODINS) + ALLTRIM(;
                  TRANSFORM(WNUMORDP, "999999"))
            MEMVAR->WPOS := RECNO()
            DBSEEK("&WKEY")

            IF  .NOT. EOF()

               DBCLOSEARE()
               SETCOLOR("*+G")
               DEVPOS(18, 10)
               DEVOUT("INSUMO EN ORDEN YA EXISTE")
               SETCOLOR("+G")
               MEMVAR->OPC := " "
               DEVPOS(19, 10)
               DEVOUT("LO GRABA ? S/N ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
                     :DISPLAY())
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}
               SETCOLOR("+W")
               SCROLL(12, 5, 22, 75)
               SETPOS(12, 5)
               SCROLL(18, 10, 19, 70)
               SETPOS(18, 10)

               IF OPC <> "S" .OR. LASTKEY() = 27

                  MEMVAR->OPC := " "
                  LOOP

               ENDIF

            ENDIF

            DBCLOSEARE()
            SCROLL(12, 5, 22, 75)
            SETPOS(12, 5)
            AMAINS()
            ORDLISTCLE()
            ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
            DBSEEK("&WCODINS")
            MEMVAR->WNOMINS := NOMFASOR
            DBCLOSEARE()
            MEMVAR->WVUNI := 0

            IF VAL(WCODINS) > 699 .AND. VAL(WCODINS) < 800

               SCROLL(12, 5, 22, 75)
               SETPOS(12, 5)
               DISPBOX(12, 5, 22, 75, 1)
               DEVPOS(16, 20)
               DEVOUT("COSTO UNITARIO    ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "WVUNI", "@Z 99,999,999.99", NIL, ;
                     NIL):DISPLAY())
               DEVPOS(17, 20)
               DEVOUT("NOMBRE DEL INSUMO ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "WNOMINS", NIL, NIL, NIL):DISPLAY();
                     )
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}

            ELSE

               AMAINS()
               ORDLISTCLE()
               ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
               DBSEEK("&WCODINS")
               MEMVAR->WNOMINS := NOMFASOR
               VESAUN()
               DBCLOSEARE()

            ENDIF

            MEMVAR->WVUNI := WVUNI + ROUND(WVUNI * ZPORCOS / 100, 2)
            SCROLL(12, 5, 22, 75)
            SETPOS(12, 5)
            SETCOLOR("+GR")
            DISPBOX(12, 5, 22, 75, 1)
            SETCOLOR("+W")
            SCROLL(12, 5, 22, 75)
            SETPOS(12, 5)
            SETCOLOR("+GR")
            DISPBOX(12, 5, 22, 75, 1)
            SETCOLOR("+W")
            MEMVAR->WCANRETAL := MEMVAR->WCANINSCO := MEMVAR->SWCAL := 0
            MEMVAR->WCAL := MEMVAR->WCH := " "
            DEVPOS(14, 15)
            DEVOUT("Realizo calculos de rendimiento ? S/N ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WCAL", "@!", {||WCAL $ "SN"}, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            DEVPOS(14, 15)
            DEVOUT("                                          ")

            IF WCAL = "S"

               MEMVAR->SWCAL := 1
               SETCOLOR("+GR/+B")
               DEVPOS(13, 23)
               DEVOUT("REALIZANDO CALCULOS DE RENDIMIENTO")
               SETCOLOR("+W")
               MEMVAR->WROL := " "
               DEVPOS(15, 20)
               DEVOUT("<R>ollo o <L>amina ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "WROL", "@!", {||WROL $ "RL"}, NIL);
                     :DISPLAY())
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}
               SET(3, 4)

               IF WROL = "R"

                  SETCOLOR("+GR/+B")
                  DEVPOS(14, 30)
                  DEVOUT("PARA CORTES DE ROLLO")
                  SETCOLOR("+W")
                  MEMVAR->WY1 := MEMVAR->WY2 := MEMVAR->WX1 := MEMVAR->WX2 := ;
                        0
                  DEVPOS(16, 15)
                  DEVOUT("Ancho del rollo ? ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "WY1", "@# 999.9999", NIL, NIL);
                        :DISPLAY())
                  DEVPOS(17, 15)
                  DEVOUT("Largo del corte ? ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "WX1", "@# 999.9999", NIL, NIL);
                        :DISPLAY())
                  DEVPOS(18, 15)
                  DEVOUT("Ancho del corte ? ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "WX2", "@# 999.9999", NIL, NIL);
                        :DISPLAY())
                  READMODAL(GETLIST)
                  MEMVAR->GETLIST := {}
                  MEMVAR->WZ1 := INT(WY1 / WX1)
                  MEMVAR->WW1 := WZ1 * WX1 - WY1
                  MEMVAR->WSALEN1 := WZ1
                  MEMVAR->WTIRA1 := WX2
                  MEMVAR->WZ2 := INT(WY1 / WX2)
                  MEMVAR->WW2 := WZ2 * WX2 - WY1
                  MEMVAR->WSALEN2 := WZ2
                  MEMVAR->WTIRA2 := WX1

                  IF WW1 > WW2

                     MEMVAR->WSALEN := WSALEN1
                     MEMVAR->WTIRA := WTIRA1

                  ELSEIF WW1 = WW2

                     MEMVAR->WSALEN := WSALEN1
                     MEMVAR->WTIRA := WTIRA1
                     SETCOLOR("+G")
                     DEVPOS(18, 50)
                     DEVOUT("DA IGUAL ")
                     SETCOLOR("+W")

                  ELSEIF WW1 < WW2

                     MEMVAR->WSALEN := WSALEN2
                     MEMVAR->WTIRA := WTIRA2

                  ENDIF

                  SETCOLOR("+W")
                  DEVPOS(19, 15)
                  DEVOUT("SALEN ")
                  SETCOLOR("+G")
                  DEVPOS(19, COL())
                  DEVOUT(ALLTRIM(TRANSFORM(WSALEN, "999999")))
                  SETCOLOR("+W")
                  DEVPOS(19, COL())
                  DEVOUT(" EN TIRAS DE ")
                  SETCOLOR("+G")
                  DEVPOS(19, COL())
                  DEVOUTPICT(WTIRA, "@# 99,999.99")
                  SETCOLOR("+W")
                  READMODAL(GETLIST)
                  MEMVAR->GETLIST := {}
                  SCROLL(12, 5, 22, 75)
                  SETPOS(12, 5)
                  SETCOLOR("+GR")
                  DISPBOX(12, 5, 22, 75, 1)
                  SETCOLOR("+W")
                  MEMVAR->CC := 0
                  DEVPOS(15, 10)
                  DEVOUT("Cuantos cortes necesita ? ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "CC", "@Z 999999.99", NIL, NIL);
                        :DISPLAY())
                  READMODAL(GETLIST)
                  MEMVAR->GETLIST := {}
                  MEMVAR->WCANINS := CC / WSALEN * WTIRA
                  MEMVAR->WCANRETAL := 99999

                  DO WHILE WCANRETAL > WCANINS

                     MEMVAR->WCANRETAL := 0
                     DEVPOS(16, 10)
                     DEVOUT("De los ")
                     SETPOS(16, COL())
                     AADD(GETLIST, __GET(NIL, "WCANINS", "@# 9,999.99", ;
                           NIL, NIL):DISPLAY())
                     DEVPOS(16, COL() + 1)
                     DEVOUT("metros, cuantos son de ")
                     DEVPOS(17, 10)
                     DEVOUT("retal ? ")
                     SETPOSBS()
                     AADD(GETLIST, __GET(NIL, "WCANRETAL", "@# 9,999.99", ;
                           NIL, NIL):DISPLAY())
                     READMODAL(GETLIST)
                     MEMVAR->GETLIST := {}

                  ENDDO

                  MEMVAR->WCANINV := WCANINS - WCANRETAL

               ELSEIF WROL = "L"

                  SETCOLOR("+GR/+B")
                  DEVPOS(14, 30)
                  DEVOUT("PARA CORTES DE PLIEGO")
                  SETCOLOR("W")
                  MEMVAR->WY1 := MEMVAR->WY2 := MEMVAR->WX1 := MEMVAR->WX2 := ;
                        0
                  DEVPOS(16, 15)
                  DEVOUT("Ancho del pliego ? ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "WY1", "@# 999.9999", NIL, NIL);
                        :DISPLAY())
                  DEVPOS(17, 15)
                  DEVOUT("Largo del pliego ? ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "WY2", "@# 999.9999", NIL, NIL);
                        :DISPLAY())
                  DEVPOS(18, 15)
                  DEVOUT("Ancho del corte  ? ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "WX1", "@# 999.9999", NIL, NIL);
                        :DISPLAY())
                  DEVPOS(19, 15)
                  DEVOUT("Largo del corte  ? ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "WX2", "@# 999.9999", NIL, NIL);
                        :DISPLAY())
                  READMODAL(GETLIST)
                  MEMVAR->GETLIST := {}
                  MEMVAR->WZ1 := INT(WY1 / WX1)
                  MEMVAR->WZ2 := INT(WY2 / WX2)
                  MEMVAR->WW1 := INT(WZ1) * INT(WZ2)
                  MEMVAR->WZ3 := INT(WY2 / WX1)
                  MEMVAR->WZ4 := INT(WY1 / WX2)
                  MEMVAR->WW2 := INT(WZ3) * INT(WZ4)

                  IF WW1 > WW2

                     MEMVAR->WLARGO := INT(WZ1)
                     MEMVAR->WANCHO := INT(WZ2)
                     MEMVAR->WCORTE1 := LTRIM(STR(WY1 * 100)) + "/" + LTRIM(;
                           STR(WX1 * 100)) + "=" + LTRIM(STR(WZ1))
                     MEMVAR->WCORTE2 := LTRIM(STR(WY2 * 100)) + "/" + LTRIM(;
                           STR(WX2 * 100)) + "=" + LTRIM(STR(WZ2))

                  ELSEIF WW1 = WW2

                     MEMVAR->WLARGO := INT(WZ1)
                     MEMVAR->WANCHO := INT(WZ2)
                     MEMVAR->WCORTE1 := LTRIM(STR(WY1 * 100)) + "/" + LTRIM(;
                           STR(WX1 * 100)) + "=" + LTRIM(STR(WZ1))
                     MEMVAR->WCORTE2 := LTRIM(STR(WY2 * 100)) + "/" + LTRIM(;
                           STR(WX2 * 100)) + "=" + LTRIM(STR(WZ2))

                  ELSEIF WW1 < WW2

                     MEMVAR->WLARGO := INT(WZ3)
                     MEMVAR->WANCHO := INT(WZ4)
                     MEMVAR->WCORTE1 := LTRIM(STR(WY2 * 100)) + "/" + LTRIM(;
                           STR(WX1 * 100)) + "=" + LTRIM(STR(WZ3))
                     MEMVAR->WCORTE2 := LTRIM(STR(WY1 * 100)) + "/" + LTRIM(;
                           STR(WX2 * 100)) + "=" + LTRIM(STR(WZ4))

                  ENDIF

                  SCROLL(12, 5, 22, 75)
                  SETPOS(12, 5)
                  SETCOLOR("+W")
                  DEVPOS(14, 10)
                  DEVOUT("SALEN ")
                  SETCOLOR("+G")
                  DEVPOS(14, COL())
                  DEVOUT(WCORTE1 + " Y " + WCORTE2)
                  DEVPOS(15, 10)
                  DEVOUTPICT(WLARGO * WANCHO, "@# 999")
                  SETCOLOR("+W")
                  DEVPOS(15, COL() + 1)
                  DEVOUT("POR PLIEGO")
                  READMODAL(GETLIST)
                  MEMVAR->GETLIST := {}
                  SCROLL(12, 5, 22, 75)
                  SETPOS(12, 5)
                  SETCOLOR("+GR")
                  DISPBOX(12, 5, 22, 75, 1)
                  SETCOLOR("+W")
                  MEMVAR->CC := 0
                  DEVPOS(15, 10)
                  DEVOUT("Cuantos cortes necesita ? ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "CC", "@Z 999999.99", NIL, NIL);
                        :DISPLAY())
                  READMODAL(GETLIST)
                  MEMVAR->GETLIST := {}
                  MEMVAR->WCANINS := CC / (WLARGO * WANCHO)
                  MEMVAR->WCANRETAL := 99999

                  DO WHILE WCANRETAL > WCANINS

                     MEMVAR->WCANRETAL := 0
                     DEVPOS(16, 10)
                     DEVOUT("De los ")
                     SETPOS(16, COL())
                     AADD(GETLIST, __GET(NIL, "WCANINS", "@# 9,999.99", ;
                           NIL, NIL):DISPLAY())
                     DEVPOS(16, COL() + 1)
                     DEVOUT("pliegos, cuantos son de ")
                     DEVPOS(17, 10)
                     DEVOUT("retal ? ")
                     SETPOSBS()
                     AADD(GETLIST, __GET(NIL, "WCANRETAL", "@# 9,999.99", ;
                           NIL, NIL):DISPLAY())
                     READMODAL(GETLIST)
                     MEMVAR->GETLIST := {}

                  ENDDO

                  MEMVAR->WCANINV := WCANINS - WCANRETAL

               ENDIF

            ELSE

               DEVPOS(14, 15)
               DEVOUT("                                          ")
               DEVPOS(14, 15)
               DEVOUT("son <C>ortes o <H>errajes ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "WCH", "@!", {||WCH $ "CH"}, NIL);
                     :DISPLAY())
               SETCOLOR("+G")
               DEVPOS(14, 20)
               DEVOUT("C")
               DEVPOS(14, 31)
               DEVOUT("H")
               SETCOLOR("+W")
               SETCOLOR("+GR")
               DEVPOS(15, 5)
               DEVOUT("Nota:")
               DEVPOS(16, 15)
               DEVOUT("Seleccione Cortes SOLO si ")
               DEVPOS(17, 15)
               DEVOUT("el anterior insumo fue de cortes")
               DEVPOS(18, 15)
               DEVOUT("y tiene las mismas medidas que este.")
               SETCOLOR("+W")
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}
               SCROLL(15, 5, 18, 60)
               SETPOS(15, 5)
               DEVPOS(14, 15)
               DEVOUT("                                   ")

               IF UPPER(WCH) = "H"

                  MEMVAR->WROL := " "
                  MEMVAR->WCANINS := MEMVAR->WCANRETAL := 0
                  SCROLL(14, 10, 17, 50)
                  SETPOS(14, 10)
                  DEVPOS(14, 15)
                  DEVOUT("CUANTOS SON EN TOTAL ? ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "WCANINS", "@Z 999999.99", NIL, ;
                        NIL):DISPLAY())
                  DEVPOS(15, 15)
                  DEVOUT("CUANTOS SON DE <retal> ? ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "WCANRETAL", "@Z 999999.99", ;
                        NIL, NIL):DISPLAY())
                  READMODAL(GETLIST)
                  MEMVAR->GETLIST := {}

               ENDIF

            ENDIF

            SET(3, 4)
            AOPTES()
            ORDLISTCLE()
            ORDLISTADD("&ZDIS\&WDIRECTO\PICO")
            DBAPPEND()
            FIELD->CODPRO := WCODPRO
            FIELD->CANORD := WCANT
            FIELD->CANPED := WCANPED
            FIELD->CANTOT := WCANT
            FIELD->CODINS := WCODINS
            FIELD->NUMINS := VAL(WCODINS)
            FIELD->CANINS := WCANINS
            FIELD->CANINV := WCANINS - WCANRETAL
            FIELD->HORA := TIME()
            FIELD->CANRETAL := WCANRETAL
            FIELD->VALUNI := WVUNI
            FIELD->VALTOT := ROUND(CANINV * WVUNI, 2)
            FIELD->NUMORD := WNUMORDP
            FIELD->NOMBREPT := WNOMBRE
            FIELD->NOMINS := WNOMINS
            FIELD->FECHA := WDATE
            FIELD->PREVEN := WPREVEN
            FIELD->CODUSU := WCODUSU

            IF WCH <> "H" .AND. SWCAL = 1

               FIELD->ROL := WROL

               IF WROL = "L"

                  FIELD->CORTE1 := WCORTE1
                  FIELD->CORTE2 := WCORTE2

               ELSE

                  FIELD->SALEN := WSALEN
                  FIELD->TIRAS := WTIRA

               ENDIF

            ENDIF

            FIELD->UNIDAD := WUNIDAD
            FIELD->NOMCLI := WNOMCLI
            FIELD->CODCLI := WCODCLI
            FIELD->COSDIR := WCOSDIR
            MEMVAR->WKEY := TRIM(WCODPRO) + TRIM(WCODINS) + ALLTRIM(;
                  TRANSFORM(WNUMORDP, "999999"))
            FIELD->PRINCOOP := WKEY
            DBCOMMITAL()
            DBCLOSEARE()

         ENDIF

         SCROLL(12, 5, 22, 75)
         SETPOS(12, 5)
         SETCOLOR("+GR")
         DISPBOX(12, 5, 22, 75, 1)
         SETCOLOR("+W")
         MEMVAR->OPC := " "
         DEVPOS(17, 10)
         DEVOUT("TIENE MAS INSUMOS PARA CREARLE ? S/N ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ENDDO

      MEMVAR->WAB := "BASURA.DBF"
      BA()
      MEMVAR->WAB := "BASURA1.DBF"
      BA()
      MEMVAR->WAB := "BASURA1.NTX"
      BA()
      AP6030S()
      __DBCOPYST("C:\PROTMP\BASURA", {})
      __DBCOPYST("C:\PROTMP\BASURA1", {})
      DBCLOSEARE()
      MEMVAR->SWESTA := 0

      DO WHILE .T.

         MEMVAR->WNOPH := 0
         SCROLL(12, 1, 23, 78)
         SETPOS(12, 1)
         DEVPOS(14, 10)
         DEVOUT("Si desea traer los factores de una orden anterior")
         DEVPOS(15, 10)
         DEVOUT("digite el numero ahora y ENTER; sino, pulse solo ENTER")
         DEVPOS(16, 10)
         DEVOUT("para continuar.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNOPH", "@Z 999999", NIL, NIL):DISPLAY();
               )
         DEVPOS(17, 30)
         DEVOUT("cero para no traer ")
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF WNOPH = 0

            EXIT

         ELSE

            DEVPOS(18, 10)
            DEVOUT(" Por favor espere, busco la orden indicada....")
            AP6030S()
            DBSELECTAR("23")
            __DBLOCATE({||NUMORD = WNOPH}, NIL, NIL, NIL, .F.)

            IF EOF()

               DBCLOSEARE()
               AHP63S()
               DBSELECTAR("24")
               __DBLOCATE({||NUMORD = WNOPH}, NIL, NIL, NIL, .F.)

               IF EOF()

                  DBCLOSEARE()
                  MEMVAR->OPC := " "
                  SCROLL(17, 1, 23, 78)
                  SETPOS(17, 1)
                  DEVPOS(17, 10)
                  DEVOUT(;
                        "NO FUERON ENCONTRADOS REGISTROS NI EN EL ARCHIVO ACTIVO";
                        )
                  DEVPOS(18, 10)
                  DEVOUT("NI EN EL ARCHIVO HISTORICO para esa  O.P.")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "OPC", NIL, NIL, NIL):DISPLAY())
                  READMODAL(GETLIST)
                  MEMVAR->GETLIST := {}
                  MEMVAR->OPC := " "

               ELSE

                  MEMVAR->SWESTA := 24
                  DBCLOSEARE()

               ENDIF

            ELSE

               MEMVAR->SWESTA := 23
               DBCLOSEARE()

            ENDIF

         ENDIF

         IF SWESTA = 23 .OR. SWESTA = 24

            EXIT

         ENDIF

      ENDDO

      DBSELECTAR("23")
      DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)

      IF WNOPH <> 0

         IF SWESTA = 23

            __DBAPP("PAG6030", {}, {||NUMORD = WNOPH}, NIL, NIL, NIL, .F., ;
                  NIL)

         ENDIF

         IF SWESTA = 24

            __DBAPP("HISPAG63", {}, {||NUMORD = WNOPH}, NIL, NIL, NIL, .F.,;
                   NIL)

         ENDIF

         DBCOMMITAL()

         IF LASTREC() < 1

            MEMVAR->OPC := " "
            DEVPOS(17, 10)
            DEVOUT(;
                  "NO FUERON ENCONTRADOS REGISTROS NI EN EL ARCHIVO ACTIVO";
                  )
            DEVPOS(18, 10)
            DEVOUT("NI EN EL ARCHIVO HISTORICO.")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "OPC", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            MEMVAR->OPC := " "

         ELSE

            DBEVAL({||FIELD->NUMORD := WNUMORDP, FIELD->LETORD := PADL(;
                  ALLTRIM(TRANSFORM(WNUMORDP, "999999")), 8, "0"), FIELD->;
                  FECHA := WDATE}, NIL, NIL, NIL, NIL, .F.)
            DBGOTOP()
            SCROLL(11, 1, 23, 78)
            SETPOS(11, 1)
            DEVPOS(11, 1)
            DEVOUT(PADC(;
                  "ACTUALIZACION DE FACTORES DE LABORES x P.T. EN LOS ESPECIALES";
                  , 80, " "))
            DEVPOS(14, 10)
            DEVOUT("CODIGO DE LABOR UNIDADES/hora     FACTOR  ")
            MEMVAR->CL := 15

            DO WHILE  .NOT. EOF()

               MEMVAR->WCODTAR := CODTAR
               DEVPOS(CL, 17)
               DEVOUT(WCODTAR)
               MEMVAR->WCANX := CANXUNI
               SETCOLOR("+G")
               DEVPOS(CL, 65)
               DEVOUT("(0=borra)")
               SETCOLOR("+W")
               DEVPOS(CL, 28)
               DEVOUT(UNIDADESH)
               SETPOS(CL, 43)
               AADD(GETLIST, __GET(NIL, "WCANX", "@Z 99999.9999", NIL, NIL);
                     :DISPLAY())
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}
               FIELD->CANXUNI := WCANX
               DBCOMMITAL()
               DBSKIP(1)
               ++MEMVAR->CL

               IF CL > 22

                  MEMVAR->CL := 15
                  SCROLL(CL, 1, 23, 78)
                  SETPOS(CL, 1)

               ENDIF

            ENDDO

         ENDIF

      ENDIF

      MEMVAR->WCODPRO := SUBSTR(WCODPRO, 1, 4)
      DBSELECTAR("50")
      DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA1", NIL, NIL, .F.)
      __DBAPP("TAREAS", {}, {||CODPRO = WCODPRO}, NIL, NIL, NIL, .F., NIL)
      DBEVAL({||FIELD->NUMORD := WNUMORDP, FIELD->LETORD := PADL(ALLTRIM(;
            TRANSFORM(WNUMORDP, "999999")), 8, "0")}, NIL, NIL, NIL, NIL, ;
            .F.)
      DBEVAL({||FIELD->CANXUNI := 0, FIELD->FECHA := WDATE}, NIL, NIL, NIL, ;
            NIL, .F.)
      DBSELECTAR("23")
      DBCREATEIN("C:\PROTMP\BASURA1.NTX", "CODTAR", {||CODTAR}, NIL)
      DBSELECTAR("50")
      DBGOTOP()

      DO WHILE  .NOT. EOF()

         MEMVAR->WCT := CODTAR
         DBSELECTAR("23")
         DBSEEK("&WCT")

         IF  .NOT. EOF()

            DBSELECTAR("50")
            DBDELETE()

         ENDIF

         DBSELECTAR("50")
         DBSKIP(1)

      ENDDO

      DBSELECTAR("50")
      __DBPACK()
      DBCLOSEARE()
      DBSELECTAR("23")
      __DBAPP("C:\PROTMP\BASURA1", {}, NIL, NIL, NIL, NIL, .F., NIL)
      ORDLISTREB()
      MEMVAR->WAB := "BASURA1.DBF"
      BA()
      DBCOMMITAL()
      __XSAVESCR()
      SCROLL(12, 1, 23, 78)
      SETPOS(12, 1)
      DEVPOS(13, 1)
      DEVOUT(PADC(;
            "ACTUALIZACION DE FACTORES DE LABORES x P.T. EN LOS ESPECIALES";
            , 80, " "))
      DEVPOS(14, 10)
      DEVOUT("CODIGO DE LABOR UNIDADES/hora     FACTOR  ")
      MEMVAR->CL := 15
      SETCOLOR("+G")
      DEVPOS(14, 60)
      DEVOUT("(ESC=termina)")
      SETCOLOR("+W")

      DO WHILE .T.

         MEMVAR->WCODTAR := "  "
         SETPOS(CL, 17)
         AADD(GETLIST, __GET(NIL, "WCODTAR", "@!", NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF LASTKEY() = 27 .OR. WCODTAR = "  "

            EXIT

         ENDIF

         DBSEEK("&WCODTAR")

         IF EOF()

            DEVPOS(CL, 55)
            DEVOUT("NO EXISTE ")
            MEMVAR->X := INKEY(0)
            SCROLL(CL, 1, 23, 78)
            SETPOS(CL, 1)
            LOOP

         ENDIF

         MEMVAR->WCANX := CANXUNI
         DEVPOS(CL, 28)
         DEVOUT(UNIDADESH)
         SETPOS(CL, 43)
         AADD(GETLIST, __GET(NIL, "WCANX", "@Z 99999.9999", NIL, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         FIELD->CANXUNI := WCANX
         DBCOMMITAL()
         DBSKIP(1)
         ++MEMVAR->CL

         IF CL > 22

            MEMVAR->CL := 15
            SCROLL(CL, 1, 23, 78)
            SETPOS(CL, 1)

         ENDIF

      ENDDO

      DBEVAL({||DBDELETE()}, {||CANXUNI = 0}, NIL, NIL, NIL, .F.)
      __DBPACK()
      DBEVAL({||FIELD->FECHA := DATE()}, {||FECHA = CTOD("  /  /  ")}, NIL, ;
            NIL, NIL, .F.)
      DBCLOSEARE()
      AP6030E()
      __DBAPP("C:\PROTMP\BASURA", {}, {||CANXUNI > 0}, NIL, NIL, NIL, .F., NIL)
      DBCLOSEARE()
      MEMVAR->WAB := "BASURA.DBF"
      BA()
      MEMVAR->WAB := "BASURA1.NTX"
      BA()
      SCROLL(6, 1, 23, 78)
      MEMVAR->OPC := ( SETPOS(6, 1), " " )
      DEVPOS(12, 20)
      DEVOUT("TIENE MAS ORDENES PARA ELABORAR ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      SETCOLOR("+G")
      DEVPOS(12, 30)
      DEVOUT("ORDENES")
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

   ESPERE()
   CIERRE()
   ACELAOR()
   CIERRE()
   __MRESTORE("&ZDIS\&WDIRECTO\LETRAS", .T.)
   __MRESTORE("&ZDIS\&WDIRECTO\ZDIS", .T.)
   MEMVAR->OPC := " "

RETURN 

