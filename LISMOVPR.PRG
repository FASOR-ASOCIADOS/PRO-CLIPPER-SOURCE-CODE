/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LISMOVPR
   Params: None.
   Return: Undefined
  Example: LISMOVPR()
  ..........................................................................
*/

PROCEDURE LISMOVPR()

   MEMVAR->OPC := " "
   MENU()
   MEMVAR->WFECLIS := DATE()
   DEVPOS(12, 20)
   DEVOUT("POR FAVOR DEME LA FECHA DE LOS LISTADOS")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WFECLIS", NIL, NIL, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   DO WHILE OPC <> "*"

      MENU()
      DEVPOS(6, 26)
      DEVOUT("MENU DE LISTADOS DE MOVIMIENTOS")
      MEMVAR->OPC := "*"
      DEVPOS(12, 20)
      DEVOUT("1. MOVIMIENTOS EN GENERAL")
      DEVPOS(13, 20)
      DEVOUT("2. LISTADO DE INSUMOS PENDIENTES DE DESCARGAR")
      DEVPOS(14, 20)
      DEVOUT("*  FIN")
      SETCOLOR("+W/+B")
      DEVPOS(20, 20)
      DEVOUT("SELECCIONE UNA OPCION ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "12*"}, NIL):DISPLAY();
            )
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      SETCOLOR("+W")

      IF OPC = "*"

         LOOP

      ENDIF

      MEMVAR->WNIV := "65" + OPC + "  "
      MEMVAR->XS := " "
      VEANIV()

      IF XS = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      MEMVAR->WPRO := "MOVIPRO" + OPC
      &WPRO()

   ENDDO

   MEMVAR->OPC := " "

RETURN 

