/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: RUTMODIP
   Params: None.
   Return: Undefined
  Example: RUTMODIP()
  ..........................................................................
*/

PROCEDURE RUTMODIP()

   IF SWPAN = 1

      MEMVAR->WMASCAM := " "

      DO WHILE WMASCAM <> "N"

         MEMVAR->WMASCAM := " "
         MEMVAR->WNCAM := -1
         SCROLL(23, 20, 23, 70)
         SETPOS(23, 20)
         DEVPOS(23, 20)
         DEVOUT("DIGITE EL CAMPO A MODIFICAR ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNCAM", "@Z 99", {||WNCAM > -2 .AND. ;
               WNCAM < 11}, NIL):DISPLAY())
         DEVPOS(23, 49)
         DEVOUT("   ")
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF WNCAM = -1

            MEMVAR->WMASCAM := "N"
            LOOP

         ENDIF

         IF WNCAM = 0

            DEVPOS(8, 10)
            DEVOUT("0.  Valor total M.O. ")
            SETPOS(ROW(), COL())
            AADD(GETLIST, __GET(NIL, "WMO", "@Z 999,999.99999", NIL, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

         ELSEIF WNCAM > 0 .AND. WNCAM < 11

            MEMVAR->WFIL := 11
            MEMVAR->WWCODINS := "WCODINS" + ALLTRIM(TRANSFORM(WNCAM, "99"))
            MEMVAR->TCODINS := (&(MEMVAR->WWCODINS))
            MEMVAR->WWCAN := "WCAN" + ALLTRIM(TRANSFORM(WNCAM, "99"))

            IF (&(MEMVAR->WWCODINS)) = "   "

               MEMVAR->WCAM := "  "
               LOOP

            ENDIF

            SCROLL(WFIL + WNCAM, 6, WFIL + WNCAM, 20)
            SETPOS(WFIL + WNCAM, 6)
            DEVPOS(WFIL + WNCAM, 6)
            DEVOUT(TRANSFORM(WNCAM, "99") + ".   ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, WWCODINS, NIL, NIL, NIL):DISPLAY())
            SETPOS(WFIL + WNCAM, 28)
            AADD(GETLIST, __GET(NIL, WWCAN, "@Z 99.99999", NIL, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            MEMVAR->WXCOD := (&(MEMVAR->WWCODINS))
            MEMVAR->XCODINS := "CODINS" + ALLTRIM(TRANSFORM(WNCAM, "99"))
            MEMVAR->XCAN := "CAN" + ALLTRIM(TRANSFORM(WNCAM, "99"))
            AMAINS()
            ORDLISTCLE()
            ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
            DBSEEK("&WXCOD")

            IF EOF()

               DBCLOSEARE()
               &WWCODINS := MEMVAR->WXCOD := TCODINS
               SETCOLOR("+GR")
               DEVPOS(WFIL + WNCAM, 40)
               DEVOUT("NO EXISTE")
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}
               SETCOLOR("+W")
               LOOP
               AMAPAS()
               ORDLISTCLE()
               ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
               DBSEEK("&WCODART")
               &WWCODINS := XCODINS
               &WWCAN := XCAN
               DEVPOS(WFIL + WNCAM, 7)
               DEVOUT(ALLTRIM(TRANSFORM(WNCAM, "99")) + ".    ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, WWCODINS, NIL, NIL, NIL):DISPLAY())
               SETPOS(12, 21)
               AADD(GETLIST, __GET(NIL, WWCAN, "@Z 99.99999", NIL, NIL);
                     :DISPLAY())
               READKILL(.T.)
               MEMVAR->GETLIST := {}
               DBCLOSEARE()
               LOOP

            ENDIF

            DEVPOS(WFIL + WNCAM, 40)
            DEVOUT(NOMFASOR)
            DBCLOSEARE()

         ENDIF

         SCROLL(23, 20, 23, 70)
         SETPOS(23, 20)
         DEVPOS(23, 20)
         DEVOUT("TIENE MAS MODIFICACIONES  S/N ")
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
         MEMVAR->WCAM := "  "
         MEMVAR->WNCAM := 0
         SCROLL(23, 20, 23, 70)
         SETPOS(23, 20)
         DEVPOS(23, 20)
         DEVOUT("DIGITE EL CAMPO A MODIFICAR ")
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

         IF (&(MEMVAR->WWCODINS)) = "   "

            MEMVAR->WCAM := 0
            LOOP

         ENDIF

         SCROLL(WFIL + WNCAM, 6, WFIL + WNCAM, 20)
         SETPOS(WFIL + WNCAM, 6)
         DEVPOS(WFIL + WNCAM, 6)
         DEVOUT(ALLTRIM(TRANSFORM(WNCAM, "99")) + ".    ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, WWCODINS, NIL, NIL, NIL):DISPLAY())
         SETPOS(WFIL + WNCAM, 28)
         AADD(GETLIST, __GET(NIL, WWCAN, "@Z 99.99999", NIL, NIL):DISPLAY();
               )
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         MEMVAR->WXCOD := (&(MEMVAR->WWCODINS))
         MEMVAR->XCODINS := "CODINS" + ALLTRIM(TRANSFORM(WNCAM, "99"))
         MEMVAR->XCAN := "CAN" + ALLTRIM(TRANSFORM(WNCAM, "99"))
         AMAINS()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
         DBSEEK("&WXCOD")

         IF EOF()

            DBCLOSEARE()
            SETCOLOR("R")
            DEVPOS(WFIL + WNCAM, 40)
            DEVOUT("NO EXISTE")
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            SETCOLOR("W")
            AMAPAS()
            ORDLISTCLE()
            ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
            DBSEEK("&WCODART")
            &WWCODINS := XCODINS
            &WWCAN := XCAN
            DEVPOS(WFIL + WNCAM, 6)
            DEVOUT(ALLTRIM(TRANSFORM(WNCAM, "99")) + ".    ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, WWCODINS, NIL, NIL, NIL):DISPLAY())
            SETPOS(12, 28)
            AADD(GETLIST, __GET(NIL, WWCAN, "@Z 99.99999", NIL, NIL);
                  :DISPLAY())
            READKILL(.T.)
            MEMVAR->GETLIST := {}
            DBCLOSEARE()
            LOOP

         ENDIF

         DEVPOS(WFIL + WNCAM, 40)
         DEVOUT(NOMFASOR)
         DBCLOSEARE()
         DBSELECTAR("1")

      ENDDO

   ENDIF


RETURN 

