/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: BORMOVPR
   Params: None.
   Return: Undefined
  Example: BORMOVPR()
  ..........................................................................
*/

PROCEDURE BORMOVPR()

   MEMVAR->OPC := " "
   MENU()
   MEMVAR->WPER := " "
   DEVPOS(12, 20)
   DEVOUT("<S>emanal o <M>ensual ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WPER", "@!", {||WPER $ "SM"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF WPER = "S"

      MEMVAR->WTIT := "SEMANALES"

   ELSE

      MEMVAR->WTIT := "MENSUALES"

   ENDIF

   DO WHILE OPC <> "*"

      MENU()
      SETCOLOR("+G")
      DEVPOS(6, 25)
      DEVOUT("BORRANDO MOVIMIENTOS " + WTIT)
      MEMVAR->WREC := 0
      SETCOLOR("+W")
      DEVPOS(15, 20)
      DEVOUT("DEME POR FAVOR EL CONSECUTIVO ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WREC", "@Z 9999", NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WREC = 0

         SET(27, "OFF")
         MEMVAR->OPC := "*"
         LOOP

      ENDIF

      IF WPER = "S"

         AMVPRSS()

      ELSE

         AMOVMESS()

      ENDIF

      IF WREC > LASTREC()

         DBCLOSEARE()
         DEVPOS(17, 20)
         DEVOUT("ESE NUMERO NO LO TENGO ")
         DEVPOS(18, 20)
         DEVOUT("OPRIMA ALGUNA TECLA PARA SEGUIR")
         MEMVAR->X := INKEY(0)
         LOOP

      ENDIF

      DBGOTO(WREC)
      SET(31, "OFF")
      SCROLL(7, 2, 23, 78)
      MEMVAR->WCOD := ( SETPOS(7, 2), CODIGO )
      MEMVAR->WTIP := TIPOMOV
      MEMVAR->WNUMDOC := NUMDOC
      MEMVAR->WFEC := FECHA
      MEMVAR->WCAN := CANTIDAD
      MEMVAR->WVALUNI := VALUNI
      MEMVAR->WVALTOT := VALTOT
      DBCLOSEARE()
      DEVPOS(12, 20)
      DEVOUT("CODIGO       " + WCOD)
      DEVPOS(13, 20)
      DEVOUT("TIPO DE MOV. " + WTIP)
      DEVPOS(14, 20)
      DEVOUT("NUMERO DE DOC." + WNUMDOC)
      DEVPOS(15, 20)
      DEVOUT("FECHA         " + DTOC(WFEC))
      DEVPOS(16, 20)
      DEVOUT("CANTIDAD      ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCAN", "@Z 999,999.99", NIL, NIL):DISPLAY();
            )
      DEVPOS(17, 20)
      DEVOUT("VR. UNITARIO  ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WVALUNI", "@Z 99,999,999.99", NIL, NIL);
            :DISPLAY())
      DEVPOS(18, 20)
      DEVOUT("VR. TOTAL     ")
      MEMVAR->OPC := ( SETPOSBS(), AADD(GETLIST, __GET(NIL, "WVALTOT", ;
            "@Z 99,999,999.99", NIL, NIL):DISPLAY()), " " )
      READKILL(.T.)
      MEMVAR->GETLIST := {}
      SET(27, "ON")
      SET(31, "ON")
      DEVPOS(22, 15)
      DEVOUT("ESTA SEGURO DE BORRAR ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      SET(27, "OFF")

      IF OPC = "S"

         IF WPER = "S"

            AMVPRSS()

         ELSE

            AMOVMESS()

         ENDIF

         DBGOTO(WREC)
         VEALOCK()
         DBDELETE()
         DBCLOSEARE()

      ENDIF

      MEMVAR->OPC := " "

   ENDDO

   IF WPER = "S"

      AMVPRSE()

   ELSE

      AMOVMESE()

   ENDIF

   __DBPACK()
   DBCLOSEARE()
   MEMVAR->OPC := " "

RETURN 

