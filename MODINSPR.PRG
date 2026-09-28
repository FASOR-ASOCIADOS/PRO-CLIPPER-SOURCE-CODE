/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MODINSPR
   Params: None.
   Return: Undefined
  Example: MODINSPR()
  ..........................................................................
*/

PROCEDURE MODINSPR()

   MEMVAR->OPC := " "
   MEMVAR->WCLAVE := SPACE(8)
   SCROLL(5, 1, 23, 78)
   SETPOS(5, 1)
   SET(17, "OFF")
   __MRESTORE("DATO", .T.)

   IF DATO <> "CARLOSFDO"

      DEVPOS(12, 20)
      DEVOUT("POR FAVOR DEME LA CLAVE DE ACCESO ")
      MEMVAR->WCLAVE := __ACCEPT()

   ELSE

      MEMVAR->WCLAVE := DATO

   ENDIF

   SET(17, "ON")

   IF ALLTRIM(WCLAVE) <> ALLTRIM(DATO)

      __MRELEASE("DATO?", .T.)
      SETCOLOR("*W/R")
      DEVPOS(18, 20)
      DEVOUT("ACCESO NEGADO, CLAVE INCORRECTA  ")
      SETCOLOR("+W/G")
      DEVPOS(19, 20)
      DEVOUT("OPRIMA ALGUNA TECLA PARA REGRESAR")
      MEMVAR->X := INKEY(0)
      SETCOLOR("+W")
      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   __MRELEASE("DATO?", .T.)
   ININPR()
   SET(3, 5)

   DO WHILE OPC <> "N"

      MENU()
      DEVPOS(4, 22)
      DEVOUT("MODIFICACION DE INSUMOS POR PRODUCTO")
      MEMVAR->WCODART := ZLCPT
      DEVPOS(12, 20)
      DEVOUT("Por favor deme el c¢digo del art¡culo")
      DEVPOS(13, 20)
      DEVOUT("a modificarle el insumo ")
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
      DEVPOS(8, 10)
      DEVOUT("0.  Valor total M.O. ")
      DEVPOS(ROW(), COL())
      DEVOUTPICT(WMO, "@Z 999,999.99999")
      DEVPOS(10, 15)
      DEVOUT("INSUMO       CANTIDAD           NOMBRE ")
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
         DEVOUT("Hay mas, realice estas modificaciones")
         DEVPOS(23, 10)
         DEVOUT("para pasar a la segunda pantalla")
         MEMVAR->X := INKEY(0)
         SCROLL(22, 10, 23, 70)
         SETPOS(22, 10)

      ENDIF

      RUTMODIP()
      SETCOLOR("BG")

      IF WCODINS11 <> "  "

         MEMVAR->OPC := " "
         MEMVAR->SWPAN := 2
         MENU()
         DEVPOS(4, 22)
         DEVOUT("MODIFICACION DE INSUMOS POR PRODUCTO")
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

               DEVPOS(WFIL + WCI, 6)
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

         RUTMODIP()

      ENDIF

      AMAPAS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
      DBSEEK("&WCODART")
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
      ORGMAEPA()
      DBCLOSEARE()

   ENDDO

   MEMVAR->OPC := " "
   ININPR()
   SET(3, 2)

RETURN 

