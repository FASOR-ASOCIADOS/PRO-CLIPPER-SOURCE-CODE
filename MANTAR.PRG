/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MANTAR
   Params: None.
   Return: Undefined
  Example: MANTAR()
  ..........................................................................
*/

PROCEDURE MANTAR()

   MEMVAR->OPC := " "

   DO WHILE OPC <> "*"

      MEMVAR->OPC := "*"
      MENU()
      DEVPOS(5, 30)
      DEVOUT("  MANEJO DE TAREAS")
      DEVPOS(12, 30)
      DEVOUT("1. CREACION ")
      DEVPOS(13, 30)
      DEVOUT("2. MODIFICACION ")
      DEVPOS(14, 30)
      DEVOUT("3. BORRADO ")
      DEVPOS(15, 30)
      DEVOUT("4. LISTADOS")
      DEVPOS(17, 30)
      DEVOUT("*  FIN")
      SETCOLOR("+G")
      DEVPOS(20, 20)
      DEVOUT("Seleccione una opci¢n ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", NIL, NIL, NIL):DISPLAY())
      SETCOLOR("+W")
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "*"

         LOOP

      ENDIF

      MEMVAR->WNIV := "15" + OPC + "  "
      MEMVAR->XS := " "
      VEANIV()

      IF XS = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      IF OPC = "1"

         CRETAR()

      ELSEIF OPC = "2"

         MODTAR()

      ELSEIF OPC = "3"

         BORTAR()

      ELSEIF OPC = "4"

         LISTAR()

      ENDIF

   ENDDO

   MEMVAR->OPC := " "

RETURN 

