/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: DBMP
   Params: None.
   Return: Undefined
  Example: DBMP()
  ..........................................................................
*/

PROCEDURE DBMP()

   MEMVAR->OPC := " "
   AMVCOSE()
   SET(11, "OFF")
   DBEVAL({||DBRECALL()}, NIL, NIL, NIL, NIL, .F.)
   DBCLOSEARE()

   DO WHILE OPC <> "*"

      MEMVAR->OPC := " "
      MENU()
      DEVPOS(5, 30)
      DEVOUT("COSTOS DE PRODUCCION")
      DEVPOS(6, 1)
      DEVOUT(PADC("DANDO DE BAJA MOVIMIENTOS DE COSTOS DE MATERIA PRIMA", ;
            78))
      MEMVAR->WORDINI := MEMVAR->WORDFIN := 0
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
      DEVOUT("BAJA DESDE CUAL ORDEN ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WORDINI", "@Z 999999", NIL, NIL):DISPLAY())
      DEVPOS(13, 20)
      DEVOUT("BAJA HASTA CUAL ORDEN ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WORDFIN", "@Z 999999", NIL, NIL):DISPLAY())
      DEVPOS(14, 20)
      DEVOUT("MOVIMIENTOS DEL A" + NMA + "O : ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WANO", "@Z 9999", {||WANO > WAFI .AND. ;
            WANO < WAFT}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF LASTKEY() = 27 .OR. WORDINI = 0

         MEMVAR->OPC := "*"
         LOOP

      ENDIF

      ESPERE()
      AMVCOSS()

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
   AMVCOSE()
   __DBPACK()
   DBCLOSEARE()

RETURN 

