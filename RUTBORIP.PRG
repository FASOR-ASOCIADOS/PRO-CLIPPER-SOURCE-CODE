/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: RUTBORIP
   Params: None.
   Return: Undefined
  Example: RUTBORIP()
  ..........................................................................
*/

PROCEDURE RUTBORIP()

   IF SWPAN = 1

      MEMVAR->WMASCAM := " "

      DO WHILE WMASCAM <> "N"

         MEMVAR->WMASCAM := " "
         MEMVAR->WNCAM := -1
         SCROLL(23, 20, 23, 70)
         SETPOS(23, 20)
         DEVPOS(23, 20)
         DEVOUT("DIGITE EL CAMPO A BORRAR ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNCAM", "@Z 99", {||WNCAM > -2 .AND. ;
               WNCAM < 11}, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF WNCAM = -1

            MEMVAR->WMASCAM := "N"
            LOOP

         ENDIF

         IF WNCAM = 0

            MEMVAR->WMO := 0.0
            DEVPOS(8, 10)
            DEVOUT("0. Valor total M.O. ")
            DEVPOS(ROW(), COL())
            DEVOUTPICT(WMO, "@Z 999,999.99999")

         ELSEIF WNCAM >= 0 .AND. WNCAM < 11

            MEMVAR->WFIL := 11
            MEMVAR->WWCODINS := "WCODINS" + ALLTRIM(TRANSFORM(WNCAM, "99"))
            MEMVAR->WWCAN := "WCAN" + ALLTRIM(TRANSFORM(WNCAM, "99"))
            &WWCODINS := SPACE(4)
            &WWCAN := 0.0
            DEVPOS(WFIL + WNCAM, 10)
            DEVOUT(ALLTRIM(TRANSFORM(WNCAM, "99")) + ".    ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, WWCODINS, NIL, NIL, NIL):DISPLAY())
            SETPOS(WFIL + WNCAM, 28)
            AADD(GETLIST, __GET(NIL, WWCAN, "@Z 99.99999", NIL, NIL);
                  :DISPLAY())
            READKILL(.T.)
            MEMVAR->GETLIST := {}
            SCROLL(12, 40, 12, 78)
            SETPOS(12, 40)

         ENDIF

         SCROLL(23, 20, 23, 70)
         SETPOS(23, 20)
         DEVPOS(23, 20)
         DEVOUT("TIENE MAS INSUMOS PARA BORRAR  S/N ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WMASCAM", "@!", {||WMASCAM $ "SN"}, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         SCROLL(23, 20, 23, 70)
         SETPOS(23, 20)

      ENDDO

   ELSEIF SWPAN = 2

      MEMVAR->WMASCAM := " "

      DO WHILE WMASCAM <> "N"

         MEMVAR->WMASCAM := " "
         MEMVAR->WNCAM := 0
         SCROLL(23, 20, 23, 70)
         SETPOS(23, 20)
         DEVPOS(23, 20)
         DEVOUT("DIGITE EL CAMPO A BORRAR ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNCAM", "@Z 99", {||WNCAM > 10 .AND. ;
               WNCAM < 21 .OR. WNCAM = 0}, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF WNCAM = 0

            MEMVAR->WMASCAM := "N"
            LOOP

         ENDIF

         MEMVAR->WFIL := 1
         MEMVAR->WWCODINS := "WCODINS" + ALLTRIM(TRANSFORM(WNCAM, "99"))
         MEMVAR->WWCAN := "WCAN" + ALLTRIM(TRANSFORM(WNCAM, "99"))
         &WWCODINS := SPACE(4)
         &WWCAN := 0.0
         DEVPOS(WFIL + WNCAM, 10)
         DEVOUT(ALLTRIM(TRANSFORM(WNCAM, "99")) + ".    ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, WWCODINS, NIL, NIL, NIL):DISPLAY())
         SETPOS(WFIL + WNCAM, 28)
         AADD(GETLIST, __GET(NIL, WWCAN, "@Z 99.99999", NIL, NIL):DISPLAY();
               )
         READKILL(.T.)
         MEMVAR->GETLIST := {}
         SCROLL(12, 40, 12, 78)
         SETPOS(12, 40)
         SCROLL(23, 20, 23, 70)
         SETPOS(23, 20)
         DEVPOS(23, 20)
         DEVOUT("TIENE MAS INSUMOS PARA BORRAR S/N ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WMASCAM", "@!", {||WMASCAM $ "SN"}, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         SCROLL(23, 20, 23, 70)
         SETPOS(23, 20)

      ENDDO

   ENDIF


RETURN 

