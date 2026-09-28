/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LISORDCO
   Params: None.
   Return: Undefined
  Example: LISORDCO()
  ..........................................................................
*/

PROCEDURE LISORDCO()

   MEMVAR->OPC := " "

   DO WHILE OPC <> "*"

      MEMVAR->OPC := "*"
      MENU()
      DEVPOS(5, 27)
      DEVOUT("LISTADOS DE ORDENES DE COMPRA")
      DEVPOS(12, 25)
      DEVOUT("1. PENDIENTES EN ORDEN DE GRABACION")
      DEVPOS(13, 25)
      DEVOUT("2. PENDIENTES EN ORDEN DE CODIGO")
      DEVPOS(14, 25)
      DEVOUT("3. PEDIDOS DE MAS DE <N> DIAS")
      DEVPOS(15, 25)
      DEVOUT("*  FIN")
      DEVPOS(18, 25)
      DEVOUT("Seleccione una opci¢n ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "*"

         LOOP

      ENDIF

      MEMVAR->WNIV := "27" + OPC + "  "
      MEMVAR->XS := " "
      VEANIV()

      IF XS = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      IF OPC = "1"

         LIORCOGR()

      ELSEIF OPC = "2"

         LIORCOCL()

      ELSEIF OPC = "3"

         LIORCODI()

      ENDIF

   ENDDO

   MEMVAR->OPC := " "

RETURN 

