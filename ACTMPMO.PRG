/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ACTMPMO
   Params: None.
   Return: Undefined
  Example: ACTMPMO()
  ..........................................................................
*/

PROCEDURE ACTMPMO()

   MEMVAR->OPC := " "

   DO WHILE OPC <> "*"

      MENU()
      DEVPOS(7, 1)
      DEVOUT(PADC(;
            "ACTUALIZACION DE MOVIMIENTOS DE MATERIA PRIMA Y MANO DE OBRA",;
             78))
      SETCOLOR("N+/BG")
      SCROLL(10, 20, 16, 60)
      SETPOS(10, 20)
      DISPBOX(10, 20, 16, 60, 2)
      DEVPOS(12, 25)
      DEVOUT("1. ACTUALIZA MATERIA PRIMA")
      DEVPOS(13, 25)
      DEVOUT("2. ACTUALIZA MANO DE OBRA")
      DEVPOS(14, 25)
      DEVOUT("*  FIN")
      SETCOLOR("+G")
      MEMVAR->OPC := "*"
      DEVPOS(18, 25)
      DEVOUT(" Seleccione una opci¢n ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "12*"}, NIL):DISPLAY();
            )
      SETCOLOR("+W")
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "*"

         LOOP

      ENDIF

      DBCLOSEALL()
      SCROLL(9, 1, 23, 78)
      SETPOS(9, 1)

      IF OPC = "1"

         MEMVAR->SWA := 1
         MEMVAR->WT1 := "ACTUALIZANDO MATERIA PRIMA"

      ELSE

         MEMVAR->SWA := 2
         MEMVAR->WT1 := "ACTUALIZANDO MANO DE OBRA"

      ENDIF

      DEVPOS(9, 1)
      DEVOUT(PADC(WT1, 78))

      IF SWA = 1

         MEMVAR->WBUS := " "
         DEVPOS(12, 20)
         DEVOUT("Busca por <N>" + U + "mero de orden " + O + " <C>" + O + ;
               "digo de insumo ? ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WBUS", "@!", {||WBUS $ "NC"}, NIL);
               :DISPLAY())
         SETCOLOR("+G")
         DEVPOS(12, 31)
         DEVOUT("N")
         DEVPOS(12, 51)
         DEVOUT("C")
         SETCOLOR("+W")
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF WBUS = "N"

            MEMVAR->WKEY := SPACE(7)
            MEMVAR->XKEY := "NUMORDPR"
            MEMVAR->WNOMKEY := "NUMERO DE LA ORDEN "

         ELSE

            MEMVAR->WKEY := SPACE(4)
            MEMVAR->XKEY := "CODIGO"
            MEMVAR->WNOMKEY := "CODIGO DEL INSUMO  "

         ENDIF

      ELSE

         MEMVAR->WBUS := " "
         DEVPOS(12, 20)
         DEVOUT("Busca por <N>umero de orden o por <P>roducto ? ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WBUS", "@!", {||WBUS $ "PN"}, NIL);
               :DISPLAY())
         SETCOLOR("+G")
         DEVPOS(12, 31)
         DEVOUT("N")
         DEVPOS(12, 55)
         DEVOUT("P")
         SETCOLOR("+W")
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         MEMVAR->WKEY := SPACE(6)

         IF WBUS = "N"

            MEMVAR->XKEY := "NUMORD"
            MEMVAR->WNOMKEY := "NUMERO DE LA ORDEN "

         ELSE

            MEMVAR->XKEY := "CODPRO"
            MEMVAR->WNOMKEY := "CODIGO DEL PRODUCTO "

         ENDIF

      ENDIF

      MEMVAR->OPC := " "
      ESPERE()
      MEMVAR->WAB := "BASURA.NTX"
      BA()

      IF SWA = 1

         AMVCOSE()

      ELSE

         AMOPAE()

      ENDIF

      DBCREATEIN("C:\BASURA", XKEY, (&("{||" + XKEY + "}")), NIL)
      DBCLOSEARE()
      MEMVAR->WMASACT := "S"
      MEMVAR->WCONBOR := 0

      DO WHILE WMASACT <> "N"

         MEMVAR->WMASACT := "N"
         SCROLL(10, 1, 23, 78)
         SETPOS(10, 1)
         DEVPOS(12, 5)
         DEVOUT("POR FAVOR DEME EL " + WNOMKEY)
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WKEY", NIL, NIL, NIL):DISPLAY())
         SETCOLOR("+G")
         DEVPOS(12, 50)
         DEVOUT("* FINALIZA")
         SETCOLOR("+W")
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF WKEY = "*"

            MEMVAR->WMASACT := "N"
            LOOP

         ENDIF

         IF SWA = 1

            AMVCOSS()

         ELSE

            AMOPAS()

         ENDIF

         ORDLISTCLE()
         ORDLISTADD("C:\BASURA")

         IF SWA = 2 .AND. XKEY = "NUMORD"

            MEMVAR->ZKEY := VAL(WKEY)
            DBSEEK(ZKEY, NIL)

         ELSE

            DBSEEK("&WKEY")

         ENDIF

         IF EOF()

            DBCLOSEARE()
            MEMVAR->WT1 := WNOMKEY + " NO ENCONTRADO, TIENE MAS ? S/N "
            DEVPOS(14, (80 - LEN(WT1)) / 2)
            DEVOUT(WT1)
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WMASACT", "@!", NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            LOOP

         ENDIF

         MEMVAR->WPOSN := RECNO()
         DBCLOSEARE()
         MEMVAR->WSIES := "N"
         MEMVAR->SWMOD := 0

         DO WHILE WSIES <> "S"

            MEMVAR->SWMOD := 0
            SCROLL(10, 1, 23, 78)
            MEMVAR->OPC := ( SETPOS(10, 1), " " )

            IF SWA = 1

               AMVCOSS()

            ELSE

               AMOPAS()

            ENDIF

            ORDLISTCLE()
            ORDLISTADD("C:\BASURA")
            DBGOTO(WPOSN)

            IF SWA = 1

               MEMVAR->WCAMPO1 := "CODIGO"
               MEMVAR->WCAMPO2 := "NUMCOLOR"
               MEMVAR->WCAMPO3 := "TIPOMOV"
               MEMVAR->WCAMPO4 := "NUMORDPR"
               MEMVAR->WCAMPO5 := "FECHA"
               MEMVAR->WCAMPO6 := "CANTIDAD"
               MEMVAR->WCAMPO7 := "VALUNI"
               MEMVAR->WCAMPO8 := "VALTOT"
               MEMVAR->WCAMPO9 := "NOMINS"
               MEMVAR->WCAMPO10 := MEMVAR->WCAMPO11 := MEMVAR->WCAMPO12 := ;
                     MEMVAR->WCAMPO13 := MEMVAR->WCAMPO14 := " "

            ELSE

               MEMVAR->WCAMPO1 := "CODOPE"
               MEMVAR->WCAMPO2 := "FECHA"
               MEMVAR->WCAMPO3 := "CODPRO"
               MEMVAR->WCAMPO4 := "NUMORD"
               MEMVAR->WCAMPO5 := "CODTAR"
               MEMVAR->WCAMPO6 := "UNIDADESH"
               MEMVAR->WCAMPO7 := "PAGO"
               MEMVAR->WCAMPO8 := "MINUTOS"
               MEMVAR->WCAMPO9 := "BUENAS"
               MEMVAR->WCAMPO10 := "MALAS"
               MEMVAR->WCAMPO11 := "PRUEBAS"
               MEMVAR->WCAMPO12 := "TOTAL"
               MEMVAR->WCAMPO13 := "PROMREAL"
               MEMVAR->WCAMPO14 := "LOGRPROM"

            ENDIF

            DEVPOS(11, 10)
            DEVOUT(WCAMPO1)
            DEVPOS(12, 10)
            DEVOUT(WCAMPO2)
            DEVPOS(13, 10)
            DEVOUT(WCAMPO3)
            DEVPOS(14, 10)
            DEVOUT(WCAMPO4)
            DEVPOS(15, 10)
            DEVOUT(WCAMPO5)
            DEVPOS(16, 10)
            DEVOUT(WCAMPO6)
            DEVPOS(17, 10)
            DEVOUT(WCAMPO7)
            DEVPOS(18, 10)
            DEVOUT(WCAMPO8)
            DEVPOS(19, 10)
            DEVOUT(WCAMPO9)
            DEVPOS(11, 19)
            DEVOUT((&(MEMVAR->WCAMPO1)))
            DEVPOS(12, 19)
            DEVOUT((&(MEMVAR->WCAMPO2)))
            DEVPOS(13, 19)
            DEVOUT((&(MEMVAR->WCAMPO3)))
            DEVPOS(14, 19)
            DEVOUT((&(MEMVAR->WCAMPO4)))
            DEVPOS(15, 19)
            DEVOUT((&(MEMVAR->WCAMPO5)))
            DEVPOS(16, 19)
            DEVOUT((&(MEMVAR->WCAMPO6)))
            DEVPOS(17, 19)
            DEVOUT((&(MEMVAR->WCAMPO7)))
            DEVPOS(18, 19)
            DEVOUT((&(MEMVAR->WCAMPO8)))
            DEVPOS(19, 19)
            DEVOUT((&(MEMVAR->WCAMPO9)))

            IF SWA = 2

               DEVPOS(11, 50)
               DEVOUT(WCAMPO10)
               DEVPOS(12, 50)
               DEVOUT(WCAMPO11)
               DEVPOS(13, 50)
               DEVOUT(WCAMPO12)
               DEVPOS(14, 50)
               DEVOUT(WCAMPO13)
               DEVPOS(15, 50)
               DEVOUT(WCAMPO14)
               DEVPOS(11, 59)
               DEVOUT((&(MEMVAR->WCAMPO10)))
               DEVPOS(12, 59)
               DEVOUT((&(MEMVAR->WCAMPO11)))
               DEVPOS(13, 59)
               DEVOUT((&(MEMVAR->WCAMPO12)))
               DEVPOS(14, 59)
               DEVOUT((&(MEMVAR->WCAMPO13)))
               DEVPOS(15, 59)
               DEVOUT((&(MEMVAR->WCAMPO14)))

            ENDIF

            MEMVAR->WSIES := "S"
            MEMVAR->OPC := " "

            IF DELETED()

               DEVPOS(23, 50)
               DEVOUT("BORRADA")

            ENDIF

            DBCLOSEARE()
            SETCOLOR("+W")
            DEVPOS(22, 13)
            DEVOUT(;
                  "<M>odifica, <A>delanta, <R>etrocede, <E>limina, <T>ermina  ";
                  )
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "MARET"}, NIL);
                  :DISPLAY())
            SETCOLOR("+G")
            DEVPOS(22, 14)
            DEVOUT("M")
            DEVPOS(22, 26)
            DEVOUT("A")
            DEVPOS(22, 38)
            DEVOUT("R")
            DEVPOS(22, 51)
            DEVOUT("E")
            DEVPOS(22, 62)
            DEVOUT("T")
            SETCOLOR("+W")
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

            IF OPC = "T"

               MEMVAR->SWMOD := 0
               MEMVAR->WSIES := "S"
               LOOP

            ENDIF

            IF OPC = "M"

               MEMVAR->SWMOD := 1
               MEMVAR->WSIES := "S"
               LOOP

            ENDIF

            IF SWA = 1

               AMVCOSS()

            ELSE

               AMOPAS()

            ENDIF

            ORDLISTCLE()
            ORDLISTADD("C:\BASURA")
            DBGOTO(WPOSN)

            IF OPC = "E"

               VEALOCK()

               IF DELETED()

                  DBRECALL()
                  MEMVAR->WCONBOR := WCONBOR - 1

               ELSE

                  DBDELETE()
                  MEMVAR->WCONBOR := WCONBOR + 1

               ENDIF

               DBCLOSEARE()
               MEMVAR->WSIES := " "
               LOOP

            ENDIF

            IF OPC = "A"

               IF EOF()

                  DBCLOSEARE()
                  SETCOLOR("+G")
                  DEVPOS(23, 1)
                  DEVOUT(PADC("ESTE ES EL ULTIMO MOVIMIENTO", 78))
                  MEMVAR->X := INKEY(0)
                  SETCOLOR("+W")

               ELSE

                  DBSKIP(1)
                  MEMVAR->WPOSN := RECNO()

               ENDIF

               DBCLOSEARE()
               MEMVAR->WSIES := " "
               LOOP

            ENDIF

            IF OPC = "R"

               IF BOF()

                  DBCLOSEARE()
                  SETCOLOR("+G")
                  DEVPOS(23, 1)
                  DEVOUT(PADC("ESTE ES EL PRIMER MOVIMIENTO", 78))
                  MEMVAR->X := INKEY(0)
                  SETCOLOR("+W")

               ELSE

                  DBSKIP(-1)
                  MEMVAR->WPOSN := RECNO()

               ENDIF

               DBCLOSEARE()
               MEMVAR->WSIES := " "
               LOOP

            ENDIF

         ENDDO

         IF SWMOD = 0

            MEMVAR->WMASACT := "N"
            SCROLL(22, 1, 23, 78)
            SETPOS(22, 1)
            DEVPOS(22, 5)
            DEVOUT("BUSCA MAS POR EL " + WNOMKEY + " ? S/N ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WMASACT", "@!", {||WMASACT $ "SN"}, ;
                  NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            LOOP

         ENDIF

         IF SWA = 1

            AMVCOSS()

         ELSE

            AMOPAS()

         ENDIF

         ORDLISTCLE()
         ORDLISTADD("C:\BASURA")
         DBGOTO(WPOSN)
         MEMVAR->WCONTE1 := (&(MEMVAR->WCAMPO1))
         MEMVAR->WCONTE2 := (&(MEMVAR->WCAMPO2))
         MEMVAR->WCONTE3 := (&(MEMVAR->WCAMPO3))
         MEMVAR->WCONTE4 := (&(MEMVAR->WCAMPO4))
         MEMVAR->WCONTE5 := (&(MEMVAR->WCAMPO5))
         MEMVAR->WCONTE6 := (&(MEMVAR->WCAMPO6))
         MEMVAR->WCONTE7 := (&(MEMVAR->WCAMPO7))
         MEMVAR->WCONTE8 := (&(MEMVAR->WCAMPO8))
         MEMVAR->WCONTE9 := (&(MEMVAR->WCAMPO9))
         DBCLOSEARE()
         SETPOS(11, 19)
         AADD(GETLIST, __GET(NIL, "WCONTE1", NIL, NIL, NIL):DISPLAY())
         SETPOS(12, 19)
         AADD(GETLIST, __GET(NIL, "WCONTE2", NIL, NIL, NIL):DISPLAY())
         SETPOS(13, 19)
         AADD(GETLIST, __GET(NIL, "WCONTE3", NIL, NIL, NIL):DISPLAY())
         SETPOS(14, 19)
         AADD(GETLIST, __GET(NIL, "WCONTE4", NIL, NIL, NIL):DISPLAY())
         SETPOS(15, 19)
         AADD(GETLIST, __GET(NIL, "WCONTE5", NIL, NIL, NIL):DISPLAY())
         SETPOS(16, 19)
         AADD(GETLIST, __GET(NIL, "WCONTE6", NIL, NIL, NIL):DISPLAY())
         SETPOS(17, 19)
         AADD(GETLIST, __GET(NIL, "WCONTE7", NIL, NIL, NIL):DISPLAY())
         SETPOS(18, 19)
         AADD(GETLIST, __GET(NIL, "WCONTE8", NIL, NIL, NIL):DISPLAY())
         SETPOS(19, 19)
         AADD(GETLIST, __GET(NIL, "WCONTE9", NIL, NIL, NIL):DISPLAY())

         IF SWA = 2

            IF SWA = 1

               AMVCOSS()

            ELSE

               AMOPAS()

            ENDIF

            ORDLISTCLE()
            ORDLISTADD("C:\BASURA")
            DBGOTO(WPOSN)
            MEMVAR->WCONTE10 := (&(MEMVAR->WCAMPO10))
            MEMVAR->WCONTE11 := (&(MEMVAR->WCAMPO11))
            MEMVAR->WCONTE12 := (&(MEMVAR->WCAMPO12))
            MEMVAR->WCONTE13 := (&(MEMVAR->WCAMPO13))
            MEMVAR->WCONTE14 := (&(MEMVAR->WCAMPO14))
            DBCLOSEARE()
            SETPOS(11, 59)
            AADD(GETLIST, __GET(NIL, "WCONTE10", NIL, NIL, NIL):DISPLAY())
            SETPOS(12, 59)
            AADD(GETLIST, __GET(NIL, "WCONTE11", NIL, NIL, NIL):DISPLAY())
            SETPOS(13, 59)
            AADD(GETLIST, __GET(NIL, "WCONTE12", NIL, NIL, NIL):DISPLAY())
            SETPOS(14, 59)
            AADD(GETLIST, __GET(NIL, "WCONTE13", NIL, NIL, NIL):DISPLAY())
            SETPOS(15, 59)
            AADD(GETLIST, __GET(NIL, "WCONTE14", NIL, NIL, NIL):DISPLAY())

         ENDIF

         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF SWA = 1

            AMVCOSS()

         ELSE

            AMOPAS()

         ENDIF

         ORDLISTCLE()
         ORDLISTADD("C:\BASURA")
         DBGOTO(WPOSN)
         VEALOCK()
         FIELD->&(MEMVAR->WCAMPO1) := WCONTE1
         FIELD->&(MEMVAR->WCAMPO2) := WCONTE2
         FIELD->&(MEMVAR->WCAMPO3) := WCONTE3
         FIELD->&(MEMVAR->WCAMPO4) := WCONTE4
         FIELD->&(MEMVAR->WCAMPO5) := WCONTE5
         FIELD->&(MEMVAR->WCAMPO6) := WCONTE6
         FIELD->&(MEMVAR->WCAMPO7) := WCONTE7
         FIELD->&(MEMVAR->WCAMPO8) := WCONTE8
         FIELD->&(MEMVAR->WCAMPO9) := WCONTE9

         IF SWA = 2

            FIELD->&(MEMVAR->WCAMPO10) := WCONTE10
            FIELD->&(MEMVAR->WCAMPO11) := WCONTE11
            FIELD->&(MEMVAR->WCAMPO12) := WCONTE12
            FIELD->&(MEMVAR->WCAMPO13) := WCONTE13
            FIELD->&(MEMVAR->WCAMPO14) := WCONTE14
            FIELD->NUMOPE := VAL(CODOPE)

         ELSE

            FIELD->CODNUM := VAL(CODIGO)
            FIELD->NUMORD := VAL(NUMORDPR)

         ENDIF

         FIELD->CODUSU := WCODUSU
         FIELD->HORA := TIME()
         DBCLOSEARE()
         MEMVAR->WMASACT := " "

      ENDDO

      MEMVAR->OPC := " "

      IF WCONBOR > 0

         SETCOLOR("+G")
         DEVPOS(23, 10)
         DEVOUT("HACIENDO EL PACK")
         SETCOLOR("+W")

         IF SWA = 1

            AMVCOSE()

         ELSE

            AMOPAE()

         ENDIF

         ORDLISTCLE()
         ORDLISTADD("C:\BASURA")
         DBGOTO(WPOSN)
         __DBPACK()
         DBCLOSEARE()

      ENDIF

      DBCLOSEALL()

   ENDDO

   DBCLOSEALL()
   MEMVAR->OPC := " "

RETURN 

