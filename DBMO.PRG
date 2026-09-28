/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: DBMO
   Params: None.
   Return: Undefined
  Example: DBMO()
  ..........................................................................
*/

PROCEDURE DBMO()

   MEMVAR->OPC := " "
   AMOPAE()
   SET(11, "OFF")
   DBEVAL({||DBRECALL()}, NIL, NIL, NIL, NIL, .F.)
   DBCLOSEARE()

   DO WHILE OPC <> "*"

      MEMVAR->OPC := " "
      MENU()
      DEVPOS(5, 1)
      DEVOUT(PADC("COSTOS DE PRODUCCION - MANO DE OBRA", 78))
      DEVPOS(6, 1)
      DEVOUT(PADC("DANDO DE BAJA MOVIMIENTOS DE PAGOS DE MANO DE OBRA", 78);
            )
      MEMVAR->WNUMORD := MEMVAR->WORDINI := MEMVAR->WORDFIN := 0
      MEMVAR->WANO := YEAR(DATE()) - 2
      MEMVAR->WAFI := YEAR(DATE()) - 10
      MEMVAR->WAFT := YEAR(DATE()) + 1
      SCROLL(7, 1, 23, 78)
      SETPOS(7, 1)
      SETCOLOR("+GR")
      DEVPOS(8, 1)
      DEVOUT("Advertencia:")
      DEVPOS(9, 10)
      DEVOUT("La informacion a dar de baja no sera almacenada")
      DEVPOS(10, 10)
      DEVOUT("en ningun archivo historico.")
      DEVPOS(11, 30)
      DEVOUT("pulse    ESC    para cancelar")
      SETCOLOR("+W")
      DEVPOS(12, 20)
      DEVOUT("DESDE QUE ORDEN DA DE BAJA ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WORDINI", "@# 999999", NIL, NIL):DISPLAY())
      DEVPOS(13, 20)
      DEVOUT("HASTA QUE ORDEN DA DE BAJA ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WORDFIN", "@Z 999999", NIL, NIL):DISPLAY())
      DEVPOS(14, 20)
      DEVOUT("MOVIMIENTOS DEL A" + NMA + "O : ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WANO", "@Z 9999", {||WANO > WAFI .AND. ;
            WANO < WAFT}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      ESPERE()

      IF WORDINI = 0 .OR. LASTKEY() = 27

         MEMVAR->OPC := "*"
         LOOP

      ENDIF

      AMOPAS()

      DO WHILE  .NOT. EOF()

         IF NUMORD > WORDINI - 1 .AND. NUMORD < WORDFIN + 1 .AND. YEAR(;
               FECHA) = WANO

            VEALOCK()
            DBDELETE()

         ENDIF

         DBSKIP(1)

      ENDDO

      DBCLOSEARE()
      MEMVAR->OPC := "N"
      SCROLL(14, 1, 14, 78)
      SETPOS(14, 1)
      DEVPOS(14, 20)
      DEVOUT("TIENE MAS PARA BAJAR ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "N"

         MEMVAR->OPC := "*"

      ENDIF

   ENDDO

   MEMVAR->OPC := " "
   AMOPAE()
   __DBPACK()
   DBCLOSEARE()

RETURN 

