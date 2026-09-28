/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MODMOVPR
   Params: None.
   Return: Undefined
  Example: MODMOVPR()
  ..........................................................................
*/

PROCEDURE MODMOVPR()

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
      DEVOUT("MODIFICANDO MOVIMIENTOS " + WTIT)
      MEMVAR->WREC := 0
      SETCOLOR("+W")
      DEVPOS(15, 20)
      DEVOUT("DEME POR FAVOR EL CONSECUTIVO ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WREC", "@Z 99999", NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WREC = 0

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
      SET(3, 2)
      SCROLL(7, 2, 23, 78)
      MEMVAR->WCOD := ( SETPOS(7, 2), CODIGO )
      MEMVAR->WNUMCOL := NUMCOLOR
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
      DEVOUT("COLOR " + WNUMCOL)
      DEVPOS(14, 20)
      DEVOUT("TIPO DE MOV. " + WTIP)
      DEVPOS(15, 20)
      DEVOUT("NUMERO DE DOC.")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WNUMDOC", NIL, NIL, NIL):DISPLAY())
      DEVPOS(16, 20)
      DEVOUT("FECHA         ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WFEC", NIL, NIL, NIL):DISPLAY())
      DEVPOS(17, 20)
      DEVOUT("CANTIDAD      ")
      DEVPOS(ROW(), COL())
      DEVOUTPICT(WCAN, "@# 999,999.99")
      DEVPOS(18, 20)
      DEVOUT("VR. UNITARIO  " + TRANSFORM(WVALUNI, "99,999,999.99"))
      DEVPOS(19, 20)
      DEVOUT("VR. TOTAL     " + TRANSFORM(WVALTOT, "99,999,999.99"))
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      MEMVAR->OPC := " "
      SET(27, "ON")
      DEVPOS(22, 15)
      DEVOUT("ESTA TODO CORRECTO ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      SET(27, "OFF")

      IF OPC <> "S"

         LOOP

      ENDIF

      IF WPER = "S"

         AMVPRSS()

      ELSE

         AMOVMESS()

      ENDIF

      DBGOTO(WREC)
      VEALOCK()
      FIELD->NUMDOC := WNUMDOC
      FIELD->FECHA := WFEC
      FIELD->CODUSU := WCODUSU
      FIELD->HORA := TIME()
      DBCLOSEARE()
      MEMVAR->OPC := " "

   ENDDO

   MEMVAR->OPC := " "

RETURN 

