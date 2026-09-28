/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: RUTMODPV
   Params: None.
   Return: Undefined
  Example: RUTMODPV()
  ..........................................................................
*/

PROCEDURE RUTMODPV()

   MEMVAR->WMASCAM := " "

   DO WHILE WMASCAM <> "N"

      MEMVAR->WMASCAM := " "
      MEMVAR->WCAM := "  "
      SCROLL(23, 20, 23, 70)
      SETPOS(23, 20)
      DEVPOS(23, 20)
      DEVOUT("DIGITE EL CAMPO A MODIFICAR ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCAM", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WCAM = "1 "

         DEVPOS(10, 10)
         DEVOUT("1. CODIGO     ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCOD", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "2 "

         DEVPOS(11, 10)
         DEVOUT("2. ESTABLEC.  ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNOMEST", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "3 "

         DEVPOS(12, 10)
         DEVOUT("3. CONTAC.o AGENTE")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNOMPROV", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "4 "

         DEVPOS(13, 10)
         DEVOUT("4. DIRECCION  ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WDIR", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "5 "

         DEVPOS(14, 10)
         DEVOUT("5. TELELEFONO ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WTE1", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "6 "

         DEVPOS(15, 10)
         DEVOUT("6. CIUDAD     ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCIU", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "7 "

         DEVPOS(16, 10)
         DEVOUT("7. NIT.       ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNIT", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "8 "

         DEVPOS(17, 10)
         DEVOUT("8. ULT.FACT.  ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WULTFAC", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "9 "

         DEVPOS(18, 10)
         DEVOUT("9. Cant.Cop.  ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCANCOP", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "10"

         DEVPOS(19, 10)
         DEVOUT("10.COND.PAG   ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCONPAG", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "11"

         DEVPOS(20, 10)
         DEVOUT("11.DESCTO.    ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WDES", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "12"

         DEVPOS(21, 10)
         DEVOUT("12.HOR.ATEN.  ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WHORATE", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "13"

         DEVPOS(22, 10)
         DEVOUT("13.SALDO      ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WSALDOCI", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WCAM = "14" .AND. CL = ">"

         DEVPOS(23, 10)
         DEVOUT("14.SALDO    ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WSALDOSI", NIL, NIL, NIL):DISPLAY())
         SETCOLOR("+W/BR")
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         SETCOLOR("W")
         DEVPOS(23, 10)
         DEVOUT("                               ")

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

   ENDDO


RETURN 

