/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: CREINSPR
   Params: None.
   Return: Undefined
  Example: CREINSPR()
  ..........................................................................
*/

PROCEDURE CREINSPR()

   MEMVAR->OPC := " "
   ININPR()
   SET(3, 5)

   DO WHILE OPC <> "*"

      MENU()
      DEVPOS(3, 24)
      DEVOUT("CREACION DE INSUMOS POR PRODUCTO")
      MEMVAR->WCODART := ZLCPT
      DEVPOS(12, 20)
      DEVOUT("Por favor deme el c¢digo del art¡culo")
      DEVPOS(13, 20)
      DEVOUT("a crearle el insumo ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCODART", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WCODART = "      " .OR. LASTKEY() = 27

         MEMVAR->OPC := "*"
         LOOP

      ENDIF

      AMAPAS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
      DBSEEK("&WCODART")

      IF EOF()

         DBCLOSEARE()
         SETCOLOR("+W/R")
         DEVPOS(15, 20)
         DEVOUT("CODIGO NO EXISTE")
         MEMVAR->X := INKEY(0)
         LOOP

      ENDIF

      MEMVAR->WNOMBRE := NOMBRE
      MEMVAR->WPOS1 := RECNO()
      SCROLL(12, 20, 13, 60)
      MEMVAR->WMO := ( SETPOS(12, 20), MO )
      MEMVAR->WCI := 1

      DO WHILE WCI < 21

         MEMVAR->WXCODINS := "WCODINS" + ALLTRIM(TRANSFORM(WCI, "99"))
         MEMVAR->WXCAN := "WCAN" + ALLTRIM(TRANSFORM(WCI, "99"))
         MEMVAR->WYCOD := "CODINS" + ALLTRIM(TRANSFORM(WCI, "99"))
         MEMVAR->WYCAN := "CAN" + ALLTRIM(TRANSFORM(WCI, "99"))
         &WXCODINS := (&(MEMVAR->WYCOD))
         &WXCAN := (&(MEMVAR->WYCAN))
         MEMVAR->WCI := MEMVAR->WCI + 1

      ENDDO

      DBCLOSEARE()
      MEMVAR->SWPAN := 1
      SETCOLOR("BG")
      DEVPOS(7, 20)
      DEVOUT("ARTICULO " + WCODART + "  " + WNOMBRE)
      SETCOLOR("+W")
      DEVPOS(10, 15)
      DEVOUT("INSUMO       CANTIDAD           NOMBRE ")
      DEVPOS(8, 20)
      DEVOUT("Valor total de M.O. ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WMO", "@Z 999,999.99999", NIL, NIL);
            :DISPLAY())

      IF WMO = 0

         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSE

         READKILL(.T.)
         MEMVAR->GETLIST := {}

      ENDIF

      MEMVAR->MASINS := "S"

      DO WHILE MASINS <> "N"

         MEMVAR->OK := " "
         MEMVAR->WCI := 1
         MEMVAR->WFIL := 11

         DO WHILE WCI < 11

            DO WHILE OK <> "E"

               IF WCI = 11

                  MEMVAR->OK := "E"
                  LOOP

               ENDIF

               MEMVAR->WXCODINS := "WCODINS" + ALLTRIM(TRANSFORM(WCI, "99"))
               MEMVAR->WXCAN := "WCAN" + ALLTRIM(TRANSFORM(WCI, "99"))
               DEVPOS(WFIL + WCI, 7)
               DEVOUT(ALLTRIM(TRANSFORM(WCI, "99")) + ".    ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, WXCODINS, NIL, NIL, NIL):DISPLAY())
               SETPOS(WFIL + WCI, 28)
               AADD(GETLIST, __GET(NIL, WXCAN, "@Z 99.99999", NIL, NIL);
                     :DISPLAY())
               READKILL(.T.)
               MEMVAR->GETLIST := {}
               MEMVAR->WC := (&(MEMVAR->WXCODINS))

               IF WC <> "   "

                  AMAINS()
                  ORDLISTCLE()
                  ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
                  DBSEEK("&WC")

                  IF  .NOT. EOF()

                     DEVPOS(WFIL + WCI, 40)
                     DEVOUT(NOMFASOR)

                  ENDIF

                  DBCLOSEARE()
                  MEMVAR->WCI := MEMVAR->WCI + 1
                  LOOP

               ELSE

                  DEVPOS(WFIL + WCI, 7)
                  DEVOUT(ALLTRIM(TRANSFORM(WCI, "99")) + ".    ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, WXCODINS, NIL, NIL, NIL);
                        :DISPLAY())
                  SETPOS(WFIL + WCI, 28)
                  AADD(GETLIST, __GET(NIL, WXCAN, "@Z 99.99999", NIL, NIL);
                        :DISPLAY())
                  READMODAL(GETLIST)
                  MEMVAR->GETLIST := {}

               ENDIF

               MEMVAR->WC := (&(MEMVAR->WXCODINS))

               IF WC = "  "

                  MEMVAR->OK := "E"
                  MEMVAR->MASINS := "N"
                  MEMVAR->WCI := 100
                  LOOP

               ENDIF

               AMAINS()
               ORDLISTCLE()
               ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
               DBSEEK("&WC")

               IF  .NOT. EOF()

                  DEVPOS(WFIL + WCI, 40)
                  DEVOUT(NOMFASOR)

               ELSE

                  DBCLOSEARE()
                  DEVPOS(WFIL + WCI, 40)
                  DEVOUT("NO EXISTE")
                  MEMVAR->X := INKEY(0)
                  &WXCODINS := SPACE(4)
                  &WXCAN := 0
                  MEMVAR->OK := " "

               ENDIF

               DBCLOSEARE()

            ENDDO

            MEMVAR->WCI := MEMVAR->WCI + 1

         ENDDO

         IF WCODINS10 <> "  "

            DEVPOS(22, 10)
            DEVOUT("Puedo recibir otros diez campos ")
            DEVPOS(23, 10)
            DEVOUT("en una segunda pantalla         ")
            MEMVAR->X := INKEY(0)
            SCROLL(22, 10, 23, 70)
            SETPOS(22, 10)

         ELSE

            MEMVAR->MASINS := "N"
            LOOP

         ENDIF

         SCROLL(5, 1, 23, 78)
         MEMVAR->SWPAN := ( SETPOS(5, 1), 2 )
         SETCOLOR("+BG")
         DEVPOS(8, 20)
         DEVOUT("ARTICULO " + WCODART + "  " + WNOMBRE)
         SETCOLOR("+W")
         MEMVAR->OK := " "
         MEMVAR->WCI := 11
         MEMVAR->WFIL := 1

         DO WHILE WCI < 21

            DO WHILE OK <> "E"

               IF WCI = 21

                  MEMVAR->OK := "E"
                  LOOP

               ENDIF

               MEMVAR->WXCODINS := "WCODINS" + ALLTRIM(TRANSFORM(WCI, "99"))
               MEMVAR->WXCAN := "WCAN" + ALLTRIM(TRANSFORM(WCI, "99"))
               DEVPOS(WFIL + WCI, 7)
               DEVOUT(ALLTRIM(TRANSFORM(WCI, "99")) + ".    ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, WXCODINS, NIL, NIL, NIL):DISPLAY())
               SETPOS(WFIL + WCI, 28)
               AADD(GETLIST, __GET(NIL, WXCAN, "@Z 99.99999", NIL, NIL);
                     :DISPLAY())
               READKILL(.T.)
               MEMVAR->GETLIST := {}
               MEMVAR->WC := (&(MEMVAR->WXCODINS))

               IF WC <> "   "

                  AMAINS()
                  ORDLISTCLE()
                  ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
                  DBSEEK("&WC")

                  IF  .NOT. EOF()

                     DEVPOS(WFIL + WCI, 40)
                     DEVOUT(NOMFASOR)

                  ENDIF

                  DBCLOSEARE()
                  MEMVAR->WCI := MEMVAR->WCI + 1
                  LOOP

               ELSE

                  DEVPOS(WFIL + WCI, 7)
                  DEVOUT(ALLTRIM(TRANSFORM(WCI, "99")) + ".    ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, WXCODINS, NIL, NIL, NIL);
                        :DISPLAY())
                  SETPOS(WFIL + WCI, 28)
                  AADD(GETLIST, __GET(NIL, WXCAN, "@Z 99.99999", NIL, NIL);
                        :DISPLAY())
                  READMODAL(GETLIST)
                  MEMVAR->GETLIST := {}

               ENDIF

               MEMVAR->WC := (&(MEMVAR->WXCODINS))

               IF WC = "  "

                  MEMVAR->OK := "E"
                  MEMVAR->MASINS := "N"
                  MEMVAR->WCI := 100
                  LOOP

               ENDIF

               AMAINS()
               ORDLISTCLE()
               ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
               DBSEEK("&WC")

               IF  .NOT. EOF()

                  DEVPOS(WFIL + WCI, 40)
                  DEVOUT(NOMFASOR)

               ELSE

                  DBCLOSEARE()
                  DEVPOS(WFIL + WCI, 40)
                  DEVOUT("NO EXISTE")
                  MEMVAR->X := INKEY(0)
                  &WXCODINS := SPACE(4)
                  &WXCAN := 0
                  MEMVAR->OK := " "

               ENDIF

               DBCLOSEARE()

            ENDDO

            MEMVAR->WCI := MEMVAR->WCI + 1

         ENDDO

         MEMVAR->MASINS := "N"

      ENDDO

      AMAPAS()
      DBGOTO(WPOS1)
      VEALOCK()
      FIELD->MO := WMO
      DBSELECTAR("1")
      MEMVAR->CF := 1

      DO WHILE CF < 21

         MEMVAR->WVAR1 := "WCODINS" + ALLTRIM(TRANSFORM(CF, "99"))
         MEMVAR->WVAR2 := "WCAN" + ALLTRIM(TRANSFORM(CF, "99"))
         MEMVAR->WCAMPOINS := "CODINS" + ALLTRIM(TRANSFORM(CF, "99"))
         MEMVAR->WCAMPOCAN := "CAN" + ALLTRIM(TRANSFORM(CF, "99"))
         FIELD->&(MEMVAR->WCAMPOINS) := (&(MEMVAR->WVAR1))
         FIELD->&(MEMVAR->WCAMPOCAN) := (&(MEMVAR->WVAR2))
         MEMVAR->CF := MEMVAR->CF + 1

      ENDDO

      ORGMAEPA()
      DBSELECTAR("1")
      DBCLOSEARE()

   ENDDO

   MEMVAR->OPC := " "
   AMAPAE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
   ORDLISTREB()
   DBCLOSEARE()
   SET(3, 2)

RETURN 

