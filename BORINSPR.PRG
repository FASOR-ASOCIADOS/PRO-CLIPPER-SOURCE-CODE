/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: BORINSPR
   Params: None.
   Return: Undefined
  Example: BORINSPR()
  ..........................................................................
*/

PROCEDURE BORINSPR()

   MEMVAR->OPC := " "
   ININPR()
   DBSELECTAR("3")
   DBUSEAREA(.F., NIL, "TEMPPART", NIL, NIL, .F.)
   SAP()
   SET(3, 5)

   DO WHILE OPC <> "N"

      MENU()
      DEVPOS(4, 24)
      DEVOUT("BORRADO DE INSUMOS POR PRODUCTO")
      MEMVAR->WCODART := ZLCPT
      DEVPOS(12, 20)
      DEVOUT("Por favor deme el c¢digo del art¡culo")
      DEVPOS(13, 20)
      DEVOUT("a borrarle el insumo ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCODART", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WCODART = "   "

         MEMVAR->OPC := "N"
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
         DEVOUT("ARTICULO NO EXISTE")
         MEMVAR->X := INKEY(0)
         LOOP

      ENDIF

      MEMVAR->WNOMBRE := NOMBRE
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

      MEMVAR->WPOS1 := RECNO()
      DBCLOSEARE()
      MEMVAR->SWPAN := 1
      SETCOLOR("BG")
      DEVPOS(7, 20)
      DEVOUT("Articulo : " + TRIM(WCODART) + " " + WNOMBRE)
      SETCOLOR("W")
      DEVPOS(10, 15)
      DEVOUT("INSUMO       CANTIDAD           NOMBRE ")
      DEVPOS(8, 10)
      DEVOUT("0. Valor total M.O. ")
      DEVPOS(ROW(), COL())
      DEVOUTPICT(WMO, "@Z 999,999.99999")
      MEMVAR->WCI := 1
      MEMVAR->WFIL := 11

      DO WHILE WCI < 11

         MEMVAR->WXCODINS := "WCODINS" + ALLTRIM(TRANSFORM(WCI, "99"))
         MEMVAR->WXCAN := "WCAN" + ALLTRIM(TRANSFORM(WCI, "99"))

         IF (&(MEMVAR->WXCODINS)) <> "  "

            DEVPOS(WFIL + WCI, 7)
            DEVOUT(ALLTRIM(TRANSFORM(WCI, "99")) + ".    " + (&(MEMVAR->;
                  WXCODINS)))
            DEVPOS(WFIL + WCI, 28)
            DEVOUTPICT((&(MEMVAR->WXCAN)), "@Z 99.99999")
            MEMVAR->WC := (&(MEMVAR->WXCODINS))
            AMAINS()
            ORDLISTCLE()
            ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
            DBSEEK("&WC")

            IF  .NOT. EOF()

               DEVPOS(WFIL + WCI, 40)
               DEVOUT(NOMFASOR)

            ENDIF

            DBCLOSEARE()

         ENDIF

         MEMVAR->WCI := MEMVAR->WCI + 1

      ENDDO

      IF WCODINS11 <> "  "

         DEVPOS(22, 10)
         DEVOUT("Hay mas, borre aqui ")
         DEVPOS(23, 10)
         DEVOUT("para pasar a la segunda pantalla")
         MEMVAR->X := INKEY(0)
         SCROLL(22, 10, 23, 70)
         SETPOS(22, 10)

      ENDIF

      RUTBORIP()
      SETCOLOR("BG")

      IF WCODINS11 <> "  "

         MEMVAR->OPC := " "
         MEMVAR->SWPAN := 2
         MEMVAR->CC := MEMVAR->CF := 1
         MENU()
         DEVPOS(4, 24)
         DEVOUT("BORRADO DE INSUMOS POR PRODUCTO")
         DEVPOS(7, 20)
         DEVOUT("Articulo : " + TRIM(WCODART) + " " + WNOMBRE)
         DEVPOS(10, 15)
         DEVOUT("INSUMO       CANTIDAD           NOMBRE ")
         MEMVAR->WCI := 11
         MEMVAR->WFIL := 1

         DO WHILE WCI < 21

            MEMVAR->WXCODINS := "WCODINS" + ALLTRIM(TRANSFORM(WCI, "99"))
            MEMVAR->WXCAN := "WCAN" + ALLTRIM(TRANSFORM(WCI, "99"))

            IF (&(MEMVAR->WXCODINS)) <> "  "

               DEVPOS(WFIL + WCI, 7)
               DEVOUT(ALLTRIM(TRANSFORM(WCI, "99")) + ".    " + (&(MEMVAR->;
                     WXCODINS)))
               DEVPOS(WFIL + WCI, 28)
               DEVOUTPICT((&(MEMVAR->WXCAN)), "@Z 99.99999")
               MEMVAR->WC := (&(MEMVAR->WXCODINS))
               AMAINS()
               ORDLISTCLE()
               ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
               DBSEEK("&WC")

               IF  .NOT. EOF()

                  DEVPOS(WFIL + WCI, 40)
                  DEVOUT(NOMFASOR)

               ENDIF

               DBCLOSEARE()

            ENDIF

            MEMVAR->WCI := MEMVAR->WCI + 1

         ENDDO

         RUTBORIP()

      ENDIF

      AMAPAS()
      DBGOTO(WPOS1)
      VEALOCK()
      FIELD->MO := WMO
      FIELD->CODINS1 := WCODINS1
      FIELD->CAN1 := WCAN1
      FIELD->CODINS2 := WCODINS2
      FIELD->CAN2 := WCAN2
      FIELD->CODINS3 := WCODINS3
      FIELD->CAN3 := WCAN3
      FIELD->CODINS4 := WCODINS4
      FIELD->CAN4 := WCAN4
      FIELD->CODINS5 := WCODINS5
      FIELD->CAN5 := WCAN5
      FIELD->CODINS6 := WCODINS6
      FIELD->CAN6 := WCAN6
      FIELD->CODINS7 := WCODINS7
      FIELD->CAN7 := WCAN7
      FIELD->CODINS8 := WCODINS8
      FIELD->CAN8 := WCAN8
      FIELD->CODINS9 := WCODINS9
      FIELD->CAN9 := WCAN9
      FIELD->CODINS10 := WCODINS10
      FIELD->CAN10 := WCAN10
      FIELD->CODINS11 := WCODINS11
      FIELD->CAN11 := WCAN11
      FIELD->CODINS12 := WCODINS12
      FIELD->CAN12 := WCAN12
      FIELD->CODINS13 := WCODINS13
      FIELD->CAN13 := WCAN13
      FIELD->CODINS14 := WCODINS14
      FIELD->CAN14 := WCAN14
      FIELD->CODINS15 := WCODINS15
      FIELD->CAN15 := WCAN15
      FIELD->CODINS16 := WCODINS16
      FIELD->CAN16 := WCAN16
      FIELD->CODINS17 := WCODINS17
      FIELD->CAN17 := WCAN17
      FIELD->CODINS18 := WCODINS18
      FIELD->CAN18 := WCAN18
      FIELD->CODINS19 := WCODINS19
      FIELD->CAN19 := WCAN19
      FIELD->CODINS20 := WCODINS20
      FIELD->CAN20 := WCAN20
      DBCOMMITAL()
      SCROLL(20, 1, 23, 78)
      SETPOS(20, 1)
      ESPERE()
      DEVPOS(21, 20)
      DEVOUT("Reorganizo los insumos dentro del registro...")
      MEMVAR->CF := 1

      DO WHILE CF < 21

         DBSELECTAR("1")
         MEMVAR->WVAR1 := "WCODINS" + ALLTRIM(TRANSFORM(CF, "99"))
         MEMVAR->WVAR2 := "WCAN" + ALLTRIM(TRANSFORM(CF, "99"))
         DBSELECTAR("3")

         IF (&(MEMVAR->WVAR1)) <> "  "

            DBAPPEND()
            FIELD->CODINS := (&(MEMVAR->WVAR1))
            FIELD->CAN := (&(MEMVAR->WVAR2))

         ENDIF

         MEMVAR->CF := MEMVAR->CF + 1
         DBSELECTAR("1")

      ENDDO

      DBSELECTAR("1")
      VEALOCK()
      MEMVAR->CF := 1

      DO WHILE CF < 21

         MEMVAR->WVAR1 := "WCODINS" + ALLTRIM(TRANSFORM(CF, "99"))
         MEMVAR->WVAR2 := "WCAN" + ALLTRIM(TRANSFORM(CF, "99"))
         MEMVAR->WCAMPOINS := "CODINS" + ALLTRIM(TRANSFORM(CF, "99"))
         MEMVAR->WCAMPOCAN := "CAN" + ALLTRIM(TRANSFORM(CF, "99"))
         FIELD->&(MEMVAR->WCAMPOINS) := "    "
         FIELD->&(MEMVAR->WCAMPOCAN) := 0
         MEMVAR->CF := MEMVAR->CF + 1

      ENDDO

      DBSELECTAR("3")
      DBEVAL({||DBDELETE()}, {||CODINS = "   "}, NIL, NIL, NIL, .F.)
      __DBPACK()
      DBGOTOP()
      MEMVAR->CF := 1

      DO WHILE  .NOT. EOF()

         DBSELECTAR("3")
         MEMVAR->WCODINS := CODINS
         MEMVAR->WCAN := CAN
         MEMVAR->WVAR1 := "WCODINS" + ALLTRIM(TRANSFORM(CF, "99"))
         MEMVAR->WVAR2 := "WCAN" + ALLTRIM(TRANSFORM(CF, "99"))
         MEMVAR->WCAMPOINS := "CODINS" + ALLTRIM(TRANSFORM(CF, "99"))
         MEMVAR->WCAMPOCAN := "CAN" + ALLTRIM(TRANSFORM(CF, "99"))
         DBSELECTAR("1")
         VEALOCK()
         FIELD->&(MEMVAR->WCAMPOINS) := WCODINS
         FIELD->&(MEMVAR->WCAMPOCAN) := WCAN
         MEMVAR->CF := MEMVAR->CF + 1
         DBSELECTAR("3")
         DBSKIP(1)

      ENDDO

      DBSELECTAR("3")
      SAP()
      DBSELECTAR("1")
      DBCLOSEARE()

   ENDDO

   DBSELECTAR("3")
   SAP()
   MEMVAR->OPC := " "
   CIERRE()
   SET(3, 2)

RETURN 

