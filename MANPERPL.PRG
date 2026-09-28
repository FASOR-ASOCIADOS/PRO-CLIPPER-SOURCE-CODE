/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MANPERPL
   Params: None.
   Return: Undefined
  Example: MANPERPL()
  ..........................................................................
*/

PROCEDURE MANPERPL()

   MEMVAR->OPC := " "

   DO WHILE OPC <> "*"

      MEMVAR->OPC := "*"
      MENU()
      DEVPOS(6, 24)
      DEVOUT(" MANEJO DE ARCHIVO MAESTRO DE OPERARIOS")
      DEVPOS(12, 25)
      DEVOUT("1. CREACION ")
      DEVPOS(13, 25)
      DEVOUT("2. MODIFICACION DE DATOS")
      DEVPOS(14, 25)
      DEVOUT("3. BORRADO ")
      DEVPOS(15, 25)
      DEVOUT("4. LISTADO DE DATOS PERSONALES")
      DEVPOS(16, 25)
      DEVOUT("*  FIN")
      SETCOLOR("+G")
      DEVPOS(20, 20)
      DEVOUT("SELECCIONE UNA OPCION ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      SETCOLOR("+W")

      IF OPC = "*"

         LOOP

      ENDIF

      MEMVAR->WNIV := "17" + OPC + "  "
      MEMVAR->XS := " "
      VEANIV()

      IF XS = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      IF OPC = "1"

         CREPERPL()

      ELSEIF OPC = "2"

         MODPERPL()

      ELSEIF OPC = "3"

         BORPERPL()

      ELSEIF OPC = "4"

         LISPERPL()

      ENDIF

   ENDDO

   MEMVAR->OPC := " "

RETURN 

