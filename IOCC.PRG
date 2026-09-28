/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: IOCC
   Params: None.
   Return: Undefined
  Example: IOCC()
  ..........................................................................
*/

PROCEDURE IOCC()

   ESPERE()
   __MRESTORE("&ZDIS\&WDIRECTO\FACTOIVA", .T.)
   __MRESTORE("&ZDIS\&WDIRECTO\PPOC", .T.)
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   AOCS()
   __DBCOPY("C:\BASURA", {}, NIL, NIL, NIL, NIL, .F., NIL)
   DBCLOSEARE()
   DBSELECTAR("1")
   DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)

   DO WHILE OPC <> "*"

      MENU()
      DEVPOS(4, 25)
      DEVOUT("IMPRESION DE ORDENES DE COMPRA")
      DBSELECTAR("1")
      SET(11, "OFF")
      DBEVAL({||DBDELETE()}, NIL, NIL, NIL, NIL, .F.)
      DBGOTOP()
      MEMVAR->WNUMORDI := NUMORD
      DBGOBOTTOM()
      MEMVAR->WNUMORDT := NUMORD
      DEVPOS(12, 20)
      DEVOUT("DESDE QUE NUMERO IMPRIME ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WNUMORDI", "@Z 999999", NIL, NIL):DISPLAY();
            )
      DEVPOS(13, 20)
      DEVOUT("HASTA QUE NUMERO IMPRIME ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WNUMORDT", "@Z 999999", NIL, NIL):DISPLAY();
            )
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WNUMORDI = 0

         MEMVAR->OPC := "*"
         SET(11, "OFF")
         DBEVAL({||DBRECALL()}, NIL, NIL, NIL, NIL, .F.)
         LOOP

      ENDIF

      MEMVAR->OPC := " "
      DEVPOS(14, 20)
      DEVOUT("ESTA TODO CORRECTO ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC <> "S" .OR. LASTKEY() = 27

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      DBSELECTAR("1")
      DBEVAL({||DBRECALL()}, {||NUMORD > WNUMORDI - 1 .AND. NUMORD < ;
            WNUMORDT + 1}, NIL, NIL, NIL, .F.)
      SET(11, "ON")
      DBGOTOP()
      MEMVAR->WRECNO := RECNO()
      PIDEIMP()
      SETCOLOR("+G")
      SCROLL(5, 1, 23, 78)
      SETPOS(5, 1)
      DEVPOS(12, 20)
      DEVOUT("** IMPRIMIENDO **")
      SETCOLOR("+W")
      VEAIMP()

      DO WHILE  .NOT. EOF()

         MEMVAR->WCODPROV := CODPROV
         AMAPRVS()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\COD-PROV")
         DBSEEK("&WCODPROV")
         MEMVAR->WCIUDAD := CIUDAD
         MEMVAR->WHORATE := HORATE
         MEMVAR->WCANCOP := CANCOP
         DBCLOSEARE()

         IF WCANCOP = 0

            MEMVAR->WCANCOP := 1

         ENDIF

         MEMVAR->WSUMUNI := MEMVAR->WVALMER := MEMVAR->WSUMTOT := 0
         MEMVAR->LETRAS1 := MEMVAR->LETRAS2 := MEMVAR->LETRAS3 := MEMVAR->;
               LETRAS4 := MEMVAR->LETRAS5 := SPACE(60)
         DBSELECTAR("1")
         DBGOTO(WRECNO)
         MEMVAR->WNUMORD := NUMORD
         __DBLOCATE({||UNIPROV <> SPACE(10) .AND. NUMORD = WNUMORD}, NIL, ;
               NIL, NIL, .F.)
         MEMVAR->SWCOPPROV := 0

         IF  .NOT. EOF()

            MEMVAR->WCANCOP := MEMVAR->WCANCOP + 1
            MEMVAR->SWCOPPROV := 1

         ENDIF

         DBGOTO(WRECNO)
         MEMVAR->WNUMORD := NUMORD
         MEMVAR->SWOBS := MEMVAR->CONCANCOP := 0
         ENIM()

         DO WHILE CONCANCOP < WCANCOP

            MEMVAR->CL := MEMVAR->CP := MEMVAR->SWH := MEMVAR->SWFD := 0
            MEMVAR->CONCANCOP := CONCANCOP + 1

            DO WHILE  .NOT. EOF() .AND. NUMORD = WNUMORD

               DBSELECTAR("1")
               MEMVAR->CP := MEMVAR->CP + 1
               MEMVAR->CL := 0
               DEVPOS(CL, 1)
               DEVOUT(CHR(27)+"@")
               DEVPOS(CL, 28)
               DEVOUT(CHR(27)+"Ž" + RAZON)
               DEVPOS(CL, 1)
               DEVOUT(CHR(18))
               MEMVAR->CL := MEMVAR->CL + 1
               DEVPOS(CL, 21)
               DEVOUT("Importadores y Distribuidores de Papeles")
               MEMVAR->CL := MEMVAR->CL + 1
               DEVPOS(CL, 30)
               DEVOUT("Manufacturas Pl sticas")
               MEMVAR->CL := MEMVAR->CL + 1
               DEVPOS(CL, 32)
               DEVOUT("Nit. 901.455.769-6")
               MEMVAR->CL := MEMVAR->CL + 3
               DEVPOS(CL, 24)
               DEVOUT("ORDEN DE COMPRA # "+CHR(27)+"Ž" + ALLTRIM(TRANSFORM(;
                     NUMORD, "999999")))
               MEMVAR->WORDMOST := NUMORD
               MEMVAR->SWIMPCOP := 0

               IF SWCOPPROV = 1 .AND. CONCANCOP = WCANCOP

                  MEMVAR->SWIMPCOP := 1
                  MEMVAR->CL := MEMVAR->CL + 1
                  DEVPOS(CL, 1)
                  DEVOUT("ORDEN DE COMPRA PARA EL PROVEEDOR")
                  MEMVAR->CL := MEMVAR->CL + 1

               ELSE

                  MEMVAR->CL := MEMVAR->CL + 2

               ENDIF

               MEMVAR->WHOR := REPLICATE("Ä", 78)
               DEVPOS(CL, 0)
               DEVOUT("Ú")
               DEVPOS(CL, 1)
               DEVOUT(WHOR)
               DEVPOS(CL, 79)
               DEVOUT("¿")
               MEMVAR->CL := MEMVAR->CL + 1
               MEMVAR->WNOMEST := NOMEST
               MEMVAR->WDIR := DIRECCION
               MEMVAR->WTEL := TELEFONO
               MEMVAR->WFECFAC := FECEMI

               IF NOMEST <> "   "

                  DEVPOS(CL, 0)
                  DEVOUT("³PROVEEDOR : " + CODPROV + " " + NOMEST)
                  DEVPOS(CL, 79)
                  DEVOUT("³")
                  MEMVAR->CL := MEMVAR->CL + 1

               ELSE

                  DEVPOS(CL, 0)
                  DEVOUT("³PROVEEDOR Nro. " + CODPROV)
                  DEVPOS(CL, 79)
                  DEVOUT("³")
                  MEMVAR->CL := MEMVAR->CL + 1

               ENDIF

               IF WDIR <> "    "

                  DEVPOS(CL, 0)
                  DEVOUT("³Direcci¢n: " + TRIM(DIRECCION) + " - " + TRIM(;
                        WCIUDAD))
                  DEVPOS(CL, 79)
                  DEVOUT("³")
                  MEMVAR->CL := MEMVAR->CL + 1

               ENDIF

               IF WTEL <> "    "

                  DEVPOS(CL, 0)
                  DEVOUT("³Telefono :  " + WTEL)
                  DEVPOS(CL, 79)
                  DEVOUT("³")
                  MEMVAR->CL := MEMVAR->CL + 1

               ENDIF

               DEVPOS(CL, 0)
               DEVOUT("³Fecha de la orden : ")
               DEVPOS(CL, 23)
               DEVOUT(FECEMI)
               DEVPOS(CL, 79)
               DEVOUT("³")
               MEMVAR->CL := MEMVAR->CL + 1
               DEVPOS(CL, 0)
               DEVOUT("À")
               DEVPOS(CL, 1)
               DEVOUT(WHOR)
               DEVPOS(CL, 79)
               DEVOUT("Ù")
               MEMVAR->CL := MEMVAR->CL + 1
               DEVPOS(CL, 0)
               DEVOUT("Ú" + WHOR + "¿")
               MEMVAR->CL := MEMVAR->CL + 1
               DEVPOS(CL, 0)
               DEVOUT(;
                     "³INSUMO   CANTIDAD   DESCRIPCION                      VR.UNIT      VR.TOTAL    ³";
                     )
               MEMVAR->CL := MEMVAR->CL + 1
               DEVPOS(CL, 0)
               DEVOUT("À" + WHOR + "Ù")
               MEMVAR->WCONPAG := CONPAG
               MEMVAR->CL := MEMVAR->CL + 1
               DEVPOS(CL, 0)
               DEVOUT("³")
               DEVPOS(CL, 79)
               DEVOUT("³")

               IF SWH = 1

                  DEVPOS(CL, 1)
                  DEVOUT(;
                        "VIENEN . . . . . . . . . . . . . . . . . . . . .")
                  DEVPOS(CL, 66)
                  DEVOUTPICT(WSUMTOT, "@# $$9,999.99")
                  MEMVAR->CL := MEMVAR->CL + 1

               ENDIF

               MEMVAR->SWFHOJA := 0

               DO WHILE SWFHOJA = 0

                  IF CL = 50

                     MEMVAR->SWFHOJA := 1

                  ENDIF

                  MEMVAR->CL := MEMVAR->CL + 1
                  MEMVAR->WVRUNIT := VRUNIT
                  MEMVAR->WVALTOT := VALTOT
                  MEMVAR->WUNI := SPACE(10)
                  MEMVAR->WCAN := CANPED
                  MEMVAR->WDES := DESCUENTO
                  MEMVAR->WORDPOR := ORDPOR

                  IF SWIMPCOP = 1 .AND. FACTUNI <> 0

                     MEMVAR->WVRUNIT := COSTO2

                     IF WDES < 0

                        MEMVAR->WVRUNIT := WVRUNIT - WVRUNIT * Abs(WDES) / ;
                              100

                     ENDIF

                     MEMVAR->WUNI := UNIPROV
                     MEMVAR->WCAN := ROUND(CANPED * FACTUNI, 0)
                     MEMVAR->WVALTOT := WCAN * WVRUNIT

                  ENDIF

                  DEVPOS(CL, 0)
                  DEVOUT("³")
                  DEVPOS(CL, 79)
                  DEVOUT("³")
                  DEVPOS(CL, 2)
                  DEVOUT(CODINS)

                  IF NUMCOLOR <> " "

                     DEVPOS(CL, 6)
                     DEVOUT("-" + NUMCOLOR)

                  ENDIF

                  MEMVAR->WNUMCOL := NUMCOLOR
                  DEVPOS(CL, 9)
                  DEVOUTPICT(WCAN, "@# 999,999")

                  IF VAL(CODINS) > 699 .AND. VAL(CODINS) < 800

                     DEVPOS(CL, 19)
                     DEVOUT(LEFT(NOMART, 30))
                     DEVPOS(CL, 50)
                     DEVOUTPICT(WVRUNIT, "@# $99,999.99")
                     DEVPOS(CL, 66)
                     DEVOUTPICT(WVALTOT, "@# $$,$99,999.99")
                     MEMVAR->CL := MEMVAR->CL + 1

                     IF SUBSTR(NOMART, 31, 5) <> "     "

                        DEVPOS(CL, 0)
                        DEVOUT("³")
                        DEVPOS(CL, 19)
                        DEVOUT(SUBSTR(NOMART, 31, 30))
                        DEVPOS(CL, 79)
                        DEVOUT("³")

                        IF SUBSTR(NOMART, 61, 5) <> "     "

                           MEMVAR->CL := MEMVAR->CL + 1
                           DEVPOS(CL, 0)
                           DEVOUT("³")
                           DEVPOS(CL, 19)
                           DEVOUT(SUBSTR(NOMART, 61, 30))
                           DEVPOS(CL, 79)
                           DEVOUT("³")

                        ENDIF

                     ENDIF

                  ELSE

                     IF SWIMPCOP = 1

                        IF UNIPROV <> SPACE(10)

                           DEVPOS(CL, 19)
                           DEVOUT(ALLTRIM(UNIPROV) + " " + ALLTRIM(LEFT(;
                                 NOMART, 30)))

                        ELSE

                           DEVPOS(CL, 19)
                           DEVOUT(LEFT(NOMART, 30))

                        ENDIF

                     ELSEIF SWCOPPROV = 1

                        MEMVAR->WCOD := CODINS
                        AMAINS()
                        ORDLISTCLE()
                        ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
                        DBSEEK("&WCOD")

                        IF WNUMCOL = " "

                           __DBLOCATE({||CODIGO = WCOD}, NIL, NIL, NIL, ;
                                 .F.)

                        ELSE

                           __DBLOCATE({||CODIGO = WCOD .AND. NUMCOLOR = ;
                                 WNUMCOL}, NIL, NIL, NIL, .F.)

                        ENDIF

                        MEMVAR->WNOMART := SPACE(30)

                        IF  .NOT. EOF()

                           MEMVAR->WNOMART := NOMFASOR
                           DEVPOS(CL, 19)
                           DEVOUT(LEFT(WNOMART, 30))

                        ENDIF

                        DBCLOSEARE()
                        DBSELECTAR("1")

                     ELSE

                        DEVPOS(CL, 19)
                        DEVOUT(LEFT(NOMART, 30))

                     ENDIF

                     DEVPOS(CL, 50)
                     DEVOUTPICT(WVRUNIT, "@# $99,999.99")
                     DEVPOS(CL, 66)
                     DEVOUTPICT(WVALTOT, "@# $$,$99,999.99")

                     IF NUMCOLOR <> " "

                        MEMVAR->WWCODINS := CODINS
                        MEMVAR->WWNUMCOLOR := NUMCOLOR
                        AMAINS()
                        __DBLOCATE({||CODIGO = WWCODINS .AND. NUMCOLOR = ;
                              WWNUMCOLOR}, NIL, NIL, NIL, .F.)
                        MEMVAR->WNOMCOLOR := SPACE(10)

                        IF  .NOT. EOF()

                           MEMVAR->WNOMCOLOR := COLOR

                        ENDIF

                        DBCLOSEARE()
                        DBSELECTAR("1")
                        MEMVAR->CL := MEMVAR->CL + 1
                        DEVPOS(CL, 0)
                        DEVOUT("³")
                        DEVPOS(CL, 19)
                        DEVOUT("Color " + WNOMCOLOR)
                        DEVPOS(CL, 79)
                        DEVOUT("³")

                     ENDIF

                  ENDIF

                  DEVPOS(CL, 79)
                  DEVOUT("³")
                  MEMVAR->WSUMUNI := WSUMUNI + WVRUNIT
                  MEMVAR->WVALMER := WVALMER + WVALTOT
                  MEMVAR->WSUMTOT := WSUMTOT + WVALTOT
                  DBSKIP(1)

                  IF NUMORD <> WNUMORD

                     MEMVAR->SWFD := MEMVAR->SWH := 0
                     MEMVAR->WRECNO2 := RECNO()
                     MEMVAR->SWFHOJA := 1
                     EXIT

                  ELSE

                     MEMVAR->SWFD := 1

                  ENDIF

                  IF EOF()

                     IF WCANCOP < CONCANCOP + 1

                        DBGOTO(WRECNO)

                     ELSE

                        MEMVAR->LETRAS1 := MEMVAR->LETRAS2 := MEMVAR->LETRAS3 ;
                              := MEMVAR->LETRAS4 := MEMVAR->LETRAS5 := SPACE(;
                              60)

                     ENDIF

                  ELSEIF WCANCOP = CONCANCOP + 1 .AND. NUMORD <> WNUMORD

                     MEMVAR->WRECNO := RECNO2
                     DBGOTO(WRECNO)

                  ENDIF

                  IF CL = 50 .AND. NUMORD = WNUMORD

                     MEMVAR->SWH := 1

                  ENDIF

               ENDDO

               IF SWH = 1

                  DEVPOS(CL, 1)
                  DEVOUT(;
                        "PASAN ------------------------------------------>";
                        )
                  DEVPOS(CL, 69)
                  DEVOUTPICT(WSUMTOT, "@# $,999,999.99")
                  MEMVAR->CL := MEMVAR->CL + 1
                  MEMVAR->WCONPAS := 0

                  DO WHILE WCONPAS < 15

                     MEMVAR->CL := CL + 1
                     DEVPOS(CL, 0)
                     DEVOUT(" ")
                     MEMVAR->WCONPAS := WCONPAS + 1

                  ENDDO

               ELSE

                  MEMVAR->CL := MEMVAR->CL + 1

                  DO WHILE CL < 42

                     DEVPOS(CL, 0)
                     DEVOUT("³")
                     DEVPOS(CL, 3)
                     DEVOUT("Ý")
                     DEVPOS(CL, 13)
                     DEVOUT("Ý")
                     DEVPOS(CL, 55)
                     DEVOUT("Ý")
                     DEVPOS(CL, 72)
                     DEVOUT("Ý")
                     DEVPOS(CL, 79)
                     DEVOUT("³")
                     MEMVAR->CL := MEMVAR->CL + 1

                  ENDDO

                  DEVPOS(CL, 2)
                  DEVOUT(WHOR)
                  MEMVAR->WHORC := REPLICATE("Ä", 39)
                  MEMVAR->CL := MEMVAR->CL + 1
                  DEVPOS(CL, 39)
                  DEVOUT("Ú" + WHORC + "¿")
                  MEMVAR->CL := MEMVAR->CL + 1
                  DEVPOS(CL, 39)
                  DEVOUT("³")
                  DEVPOS(CL, 44)
                  DEVOUT("             Total: ")
                  DEVPOS(CL, 66)
                  DEVOUTPICT(WSUMTOT, "@# $$,999,999.99")
                  DEVPOS(CL, 79)
                  DEVOUT("³")
                  MEMVAR->CL := MEMVAR->CL + 1
                  DEVPOS(CL, 39)
                  DEVOUT("³")
                  MEMVAR->WLETIVA := ALLTRIM(TRANSFORM(FACTOIVA, "99.99"))
                  DEVPOS(CL, 44)
                  DEVOUT("   " + WLETIVA + "%  Impoventas: ")
                  DEVPOS(CL, 66)
                  DEVOUTPICT(WSUMTOT * FACTOIVA / 100, "@# 99,999,999.99")
                  DEVPOS(CL, 79)
                  DEVOUT("³")
                  MEMVAR->CL := MEMVAR->CL + 1
                  DEVPOS(CL, 39)
                  DEVOUT("³")
                  DEVPOS(CL, 44)
                  DEVOUT("          Subtotal: ")
                  DEVPOS(CL, 66)
                  DEVOUTPICT(WSUMTOT + WSUMTOT * FACTOIVA / 100, ;
                        "@# 99,999,999.99")
                  DEVPOS(CL, 79)
                  DEVOUT("³")
                  MEMVAR->CL := MEMVAR->CL + 1
                  DEVPOS(CL, 39)
                  DEVOUT("³")
                  DEVPOS(CL, 44)
                  DEVOUT("         Descuento: ")

                  IF WDES < 0

                     MEMVAR->WDES := 0

                  ENDIF

                  DEVPOS(CL, 63)
                  DEVOUTPICT(WDES, "@# 99.99")
                  DEVPOS(CL, 68)
                  DEVOUT("%")
                  MEMVAR->WVALDES := WSUMTOT * WDES / 100
                  DEVPOS(CL, 69)
                  DEVOUTPICT(WVALDES, "@# 999,999.99")
                  DEVPOS(CL, 79)
                  DEVOUT("³")
                  MEMVAR->CL := MEMVAR->CL + 1
                  DEVPOS(CL, 39)
                  DEVOUT("³")
                  DEVPOS(CL, 44)
                  DEVOUT("     Total a pagar: ")
                  DEVPOS(CL, 66)
                  DEVOUTPICT(WSUMTOT * FACTOIVA / 100 + WSUMTOT - WVALDES, ;
                        "@# 99,999,999.99")
                  DEVPOS(CL, 66)
                  DEVOUTPICT(WSUMTOT * FACTOIVA / 100 + WSUMTOT - WVALDES, ;
                        "@# 99,999,999.99")
                  DEVPOS(CL, 79)
                  DEVOUT("³")
                  MEMVAR->CL := MEMVAR->CL + 1
                  DEVPOS(CL, 39)
                  DEVOUT("À" + WHORC + "Ù")
                  MEMVAR->LINCOR := REPLICATE("Ä", 20)
                  MEMVAR->CL := MEMVAR->CL + 1
                  DEVPOS(CL, 15)
                  DEVOUT(LINCOR)
                  MEMVAR->CL := MEMVAR->CL + 1
                  DEVPOS(CL, 0)
                  DEVOUT(" ")
                  DEVPOS(CL, 0)
                  DEVOUT(" ")
                  APIM()
                  DISPBOX(17, 5, 24, 78, 1)
                  SCROLL(16, 1, 16, 78)
                  SETPOS(16, 1)
                  SETCOLOR("+G")
                  DEVPOS(16, 20)
                  DEVOUT("ORDEN NUMERO ")
                  DEVPOS(16, 33)
                  DEVOUTPICT(WORDMOST, "@# 99999")
                  SETCOLOR("+W")
                  SCROLL(18, 6, 23, 77)
                  SETPOS(18, 6)
                  DEVPOS(18, 10)
                  DEVOUT("OBSERVACIONES  : ")
                  SET(34, "{}")
                  SETPOS(19, 10)
                  AADD(GETLIST, __GET(NIL, "LETRAS1", NIL, NIL, NIL);
                        :DISPLAY())
                  SETPOS(20, 10)
                  AADD(GETLIST, __GET(NIL, "LETRAS2", NIL, NIL, NIL);
                        :DISPLAY())
                  SETPOS(21, 10)
                  AADD(GETLIST, __GET(NIL, "LETRAS3", NIL, NIL, NIL);
                        :DISPLAY())
                  SETPOS(22, 10)
                  AADD(GETLIST, __GET(NIL, "LETRAS4", NIL, NIL, NIL);
                        :DISPLAY())
                  SETPOS(23, 10)
                  AADD(GETLIST, __GET(NIL, "LETRAS5", NIL, NIL, NIL);
                        :DISPLAY())

                  IF SWOBS = 0

                     READMODAL(GETLIST)
                     MEMVAR->GETLIST := {}
                     MEMVAR->SWOBS := 1

                  ELSE

                     READKILL(.T.)
                     MEMVAR->GETLIST := {}

                  ENDIF

                  SET(34, "[]")
                  ENIM()

                  IF WORDPOR <> "   "

                     DEVPOS(CL, 1)
                     DEVOUT("Ordenado por : " + WORDPOR)
                     MEMVAR->CL := CL + 1

                  ENDIF

                  DEVPOS(CL, 0)
                  DEVOUT("Ú")
                  DEVPOS(CL, 1)
                  DEVOUT(WHOR)
                  DEVPOS(CL, 79)
                  DEVOUT("¿")
                  MEMVAR->CL := MEMVAR->CL + 1
                  DEVPOS(CL, 0)
                  DEVOUT("³")
                  DEVPOS(CL, 9)
                  DEVOUT(LETRAS1)
                  DEVPOS(CL, 79)
                  DEVOUT("³")
                  MEMVAR->CL := MEMVAR->CL + 1
                  DEVPOS(CL, 0)
                  DEVOUT("³")
                  DEVPOS(CL, 9)
                  DEVOUT(LETRAS2)
                  DEVPOS(CL, 79)
                  DEVOUT("³")
                  MEMVAR->CL := MEMVAR->CL + 1
                  DEVPOS(CL, 0)
                  DEVOUT("³")
                  DEVPOS(CL, 9)
                  DEVOUT(LETRAS3)
                  DEVPOS(CL, 79)
                  DEVOUT("³")
                  MEMVAR->CL := MEMVAR->CL + 1
                  DEVPOS(CL, 0)
                  DEVOUT("³")
                  DEVPOS(CL, 9)
                  DEVOUT(LETRAS4)
                  DEVPOS(CL, 79)
                  DEVOUT("³")
                  MEMVAR->CL := MEMVAR->CL + 1
                  DEVPOS(CL, 0)
                  DEVOUT("³")
                  DEVPOS(CL, 9)
                  DEVOUT(LETRAS5)
                  DEVPOS(CL, 79)
                  DEVOUT("³")
                  MEMVAR->CL := MEMVAR->CL + 1
                  DEVPOS(CL, 0)
                  DEVOUT("À")
                  DEVPOS(CL, 1)
                  DEVOUT(WHOR)
                  DEVPOS(CL, 79)
                  DEVOUT("Ù")
                  MEMVAR->CL := MEMVAR->CL + 1
                  DEVPOS(CL, 0)
                  DEVOUT(" ")
                  DEVPOS(CL, 1)
                  DEVOUT(PADC(PPOC, 78))
                  MEMVAR->CL := MEMVAR->CL + 1
                  MEMVAR->CL := 0
                  DEVPOS(CL, 0)
                  DEVOUT(" ")

               ENDIF

            ENDDO

            DBSELECTAR("1")

            IF CONCANCOP < WCANCOP

               DBGOTO(WRECNO)
               MEMVAR->WSUMUNI := MEMVAR->WVALMER := MEMVAR->WSUMTOT := ;
                     MEMVAR->WIVA := 0

            ELSE

               IF EOF()

                  EXIT

               ENDIF

               MEMVAR->SWOF := 0

               IF  .NOT. EOF()

                  MEMVAR->WRECA := RECNO()
                  MEMVAR->SWOF := 1

               ENDIF

               IF SWOF = 1

                  DBGOTO(WRECA)

               ENDIF

               IF EOF()

                  EXIT

               ENDIF

               MEMVAR->WRECNO := RECNO()
               DBGOTO(WRECNO)
               MEMVAR->WNUMORD := NUMORD

            ENDIF

         ENDDO

         DEVPOS(PROW(), PCOL())
         DEVOUT(" ")
         APIM()

      ENDDO

      MEMVAR->WNUMORD := NUMORD
      MENU()
      DEVPOS(12, 25)
      DEVOUT("TIENE MAS ORDENES PARA IMPRIMIR ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "N"

         EXIT

      ENDIF

   ENDDO

   SET(11, "OFF")
   CIERRE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->OPC := " "

RETURN 

