/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MANINSPR
   Params: None.
   Return: Undefined
  Example: MANINSPR()
  ..........................................................................
*/

PROCEDURE MANINSPR()

   MEMVAR->OPC := " "

   DO WHILE OPC <> "*"

      MENU()
      MEMVAR->OPC := "*"
      DEVPOS(5, 22)
      DEVOUT("  MANEJO DE INSUMOS POR PRODUCTO   ")
      DEVPOS(12, 25)
      DEVOUT("1. CREACION DE INSUMOS/PRODUCTO")
      DEVPOS(13, 25)
      DEVOUT("2. MODIFICACION DE INSUMOS/PRODUCTO")
      DEVPOS(14, 25)
      DEVOUT("3. BORRADO DE INSUMOS/PRODUCTO")
      DEVPOS(15, 25)
      DEVOUT("4. LISTADO DE INSUMOS/PRODUCTO")
      DEVPOS(16, 25)
      DEVOUT("5. CAMBIA CODIGOS DE INSUMOS")
      DEVPOS(17, 25)
      DEVOUT("*  FIN")
      DEVPOS(20, 20)
      DEVOUT("Seleccione una opci¢n ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "*"

         LOOP

      ENDIF

      MEMVAR->WNIV := "13" + OPC + "  "
      MEMVAR->XS := " "
      VEANIV()

      IF XS = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      IF OPC = "1"

         CREINSPR()

      ELSEIF OPC = "2"

         MODINSPR()

      ELSEIF OPC = "3"

         BORINSPR()

      ELSEIF OPC = "4"

         LISINSPR()

      ELSEIF OPC = "5"

         CAMCODIN()

      ENDIF

   ENDDO

   MEMVAR->OPC := " "

RETURN 

