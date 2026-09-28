/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: RUTMODIN
   Params: None.
   Return: Undefined
  Example: RUTMODIN()
  ..........................................................................
*/

PROCEDURE RUTMODIN()

   MEMVAR->WMASCAM := " "

   DO WHILE WMASCAM <> "N"

      MEMVAR->WMASCAM := " "
      MEMVAR->WCAM := "  "
      SCROLL(24, 20, 24, 70)
      SETPOS(24, 20)
      DEVPOS(24, 20)
      DEVOUT("DIGITE EL CAMPO A MODIFICAR ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCAM", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF LASTKEY() = 27

         EXIT

      ENDIF

      MEMVAR->WNCAM := VAL(WCAM)

      IF SWMODI = 0 .AND. (WNCAM = 14 .OR. WNCAM = 15 .OR. WNCAM > 17)

         LOOP

      ENDIF

      IF WCAM = "1 "

         DEVPOS(5, 2)
         DEVOUT("1. LINEA       ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WLIN", "@Z 99", NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "2 "

         DEVPOS(6, 2)
         DEVOUT("2. CODIGO      ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCOD", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "3 "

         DEVPOS(7, 2)
         DEVOUT("3. NOMBRE FASOR")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNOMFASOR", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "4 "

         DEVPOS(8, 2)
         DEVOUT("4. NOMBRE PROV.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNOM", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "5 "

         DEVPOS(9, 2)
         DEVOUT("5. UNIDAD FASOR")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WUNI", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "6 "

         DEVPOS(10, 2)
         DEVOUT("6. UNIDAD PROV.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WUNIPROV", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "7 "

         DEVPOS(11, 2)
         DEVOUT("7. FACTOR/UNIDADES")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WFACTUNI", "@Z 999.99999", NIL, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "8 "

         DEVPOS(12, 2)
         DEVOUT("8. FEC.ULT.MOV.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WULTMOV", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "9 "

         DEVPOS(5, 40)
         DEVOUT("9. MAXIMO       ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WMAX", "@Z 999,999.99", NIL, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "10"

         DEVPOS(6, 40)
         DEVOUT("10.MINIMO       ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WMIN", "@Z 999,999.99", NIL, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "11"

         DEVPOS(7, 40)
         DEVOUT("11.COSTO  1     ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WPR1", "@Z 999,999,999.99", NIL, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "12"

         DEVPOS(8, 40)
         DEVOUT("12.ESCAL.       ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WESC", "@Z 9,999,999.99", NIL, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "13"

         DEVPOS(9, 40)
         DEVOUT("13.COSTO  2     ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WPR2", "@Z 999,999,999.99", NIL, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "14"

         DEVPOS(10, 40)
         DEVOUT("14.SALDO (UNID.)")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WSALUNI", "@Z 9,999,999.99", NIL, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "15"

         DEVPOS(11, 40)
         DEVOUT("15.SALDO (PESOS)")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WSALPES", "@Z 999,999,999.99", NIL, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "16"

         DEVPOS(12, 40)
         DEVOUT("16.#-COLOR")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNUMCOLOR", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "17"

         DEVPOS(12, 53)
         DEVOUT("17.COLOR ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCOLOR", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "18"

         DEVPOS(15, 16)
         DEVOUT("18.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WENTMESUNI", "@Z 9,999,999.99", NIL, ;
               NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "19"

         DEVPOS(15, 40)
         DEVOUT("19.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WENTANOUNI", "@Z 9,999,999.99", NIL, ;
               NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "20"

         DEVPOS(16, 16)
         DEVOUT("20.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WENTMESPES", "@Z 999,999,999.99", NIL, ;
               NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "21"

         DEVPOS(16, 40)
         DEVOUT("21 ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WENTANOPES", "@Z 999,999,999.99", NIL, ;
               NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "22"

         DEVPOS(17, 16)
         DEVOUT("22.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WOTRENMEUNI", "@Z 9,999,999.99", NIL, ;
               NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "23"

         DEVPOS(17, 40)
         DEVOUT("23.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WOTRENANOUN", "@Z 9,999,999.99", NIL, ;
               NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "24"

         DEVPOS(18, 16)
         DEVOUT("24.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WOTRENMEPES", "@Z 999,999,999.99", NIL, ;
               NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "25"

         DEVPOS(18, 40)
         DEVOUT("25.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WOTRENANOPE", "@Z 999,999,999.99", NIL, ;
               NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "26"

         DEVPOS(19, 16)
         DEVOUT("26.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCONMESUNI", "@Z 9,999,999.99", NIL, ;
               NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "27"

         DEVPOS(19, 40)
         DEVOUT("27.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCONANOUNI", "@Z 9,999,999.99", NIL, ;
               NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "28"

         DEVPOS(20, 16)
         DEVOUT("28.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCONMESPES", "@Z 999,999,999.99", NIL, ;
               NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "29"

         DEVPOS(20, 40)
         DEVOUT("29.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCONANOPES", "@Z 999,999,999.99", NIL, ;
               NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "30"

         DEVPOS(21, 16)
         DEVOUT("30.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WOTRSAMESUN", "@Z 9,999,999.99", NIL, ;
               NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "31"

         DEVPOS(21, 40)
         DEVOUT("31.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WOTRSAANOUN", "@Z 9,999,999.99", NIL, ;
               NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "32"

         DEVPOS(22, 16)
         DEVOUT("32.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WOTRSAMESPE", "@Z 999,999,999.99", NIL, ;
               NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "33"

         DEVPOS(22, 40)
         DEVOUT("33.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WOTRSAANOPE", "@Z 999,999,999.99", NIL, ;
               NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "34"

         DEVPOS(23, 16)
         DEVOUT("34.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCOSCONMES", "@Z 999,999,999.99", NIL, ;
               NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "35"

         DEVPOS(23, 40)
         DEVOUT("35.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCOSCONANO", "@Z 999,999,999.99", NIL, ;
               NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ENDIF

      SCROLL(24, 20, 24, 70)
      SETPOS(24, 20)
      DEVPOS(24, 20)
      DEVOUT("TIENE MAS MODIFICACIONES  S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WMASCAM", "@!", {||WMASCAM $ "SN"}, NIL);
            :DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      DISPBOX(24, 20, 24, 70, 2)

   ENDDO


RETURN 

