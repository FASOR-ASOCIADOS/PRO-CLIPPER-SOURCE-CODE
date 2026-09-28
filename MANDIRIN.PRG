/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MANDIRIN
   Params: None.
   Return: Undefined
  Example: MANDIRIN()
  ..........................................................................
*/

PROCEDURE MANDIRIN()

   MEMVAR->OPC := " "

   DO WHILE OPC <> "*"

      MEMVAR->OPC := "*"
      MENU()
      DEVPOS(4, 1)
      DEVOUT(PADC("MANEJO DE MAESTRO DE INSUMOS", 78))
      DEVPOS(9, 25)
      DEVOUT("1. CREACION DE INSUMOS    ")
      DEVPOS(10, 25)
      DEVOUT("2. MODIFICACION DE INSUMOS")
      DEVPOS(11, 25)
      DEVOUT("3. BORRADO DE INSUMOS     ")
      DEVPOS(21, 25)
      DEVOUT("*  FIN")
      SETCOLOR("+G")
      DEVPOS(22, 20)
      DEVOUT("SELECCIONE UNA OPCION ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", NIL, NIL, NIL):DISPLAY())
      SETCOLOR("+W")
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "*"

         LOOP

      ENDIF

      MEMVAR->WNIV := "121" + OPC + " "
      MEMVAR->XS := " "
      VEANIV()

      IF XS = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      MEMVAR->SWF := 0

      IF OPC = "1"

         CREINS()

      ELSEIF OPC = "2"

         MODINS()

      ELSEIF OPC = "3"

         BORINS()

      ENDIF

   ENDDO

   MEMVAR->OPC := " "

RETURN 

