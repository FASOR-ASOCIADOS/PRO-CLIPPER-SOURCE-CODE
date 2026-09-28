/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: DBMOOP
   Params: None.
   Return: Undefined
  Example: DBMOOP()
  ..........................................................................
*/

PROCEDURE DBMOOP()

   MEMVAR->OPC := " "
   MEMVAR->SWB := 0

   DO WHILE OPC <> "*"

      MEMVAR->OPC := " "
      MENU()
      DEVPOS(5, 1)
      DEVOUT(PADC("COSTOS DE PRODUCCION - ENTRADAS DE P.T.", 78))
      DEVPOS(6, 1)
      DEVOUT(PADC("DANDO DE BAJA ENTRADAS DE P.T. A INVENTARIO", 78))
      MEMVAR->WANO := YEAR(DATE()) - 2
      MEMVAR->WAFI := YEAR(DATE()) - 10
      MEMVAR->WAFT := YEAR(DATE()) + 1
      SCROLL(7, 1, 23, 78)
      SETPOS(7, 1)
      SETCOLOR("+GR")
      DEVPOS(8, 1)
      DEVOUT("Advertencia:")
      DEVPOS(9, 1)
      DEVOUT(PADC("La informacion a dar de baja no sera almacenada", 78))
      DEVPOS(10, 1)
      DEVOUT(PADC("en ningun archivo historico.", 78))
      DEVPOS(12, 1)
      DEVOUT(PADC("pulse    ESC    para cancelar", 78))
      SETCOLOR("+W")
      DEVPOS(14, 20)
      DEVOUT("ENTRADAS DEL A" + NMA + "O : ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WANO", "@Z 9999", {||WANO > WAFI .AND. ;
            WANO < WAFT}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF LASTKEY() = 27

         MEMVAR->OPC := "*"
         LOOP

      ENDIF

      SET(11, "OFF")
      AMVOPE()

      IF SWB = 0

         ESPERE()
         MEMVAR->SWB := 1
         DBEVAL({||DBRECALL()}, NIL, NIL, NIL, NIL, .F.)

      ENDIF

      DBEVAL({||DBDELETE()}, {||YEAR(FECHA) = WANO}, NIL, NIL, NIL, .F.)
      __DBPACK()
      DBCLOSEARE()
      MEMVAR->OPC := "N"
      SCROLL(14, 1, 14, 78)
      SETPOS(14, 1)
      DEVPOS(14, 20)
      DEVOUT("TIENE OTRO A" + NMA + "O PARA BAJAR ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "N"

         MEMVAR->OPC := "*"

      ENDIF

   ENDDO

   MEMVAR->OPC := " "

RETURN 

