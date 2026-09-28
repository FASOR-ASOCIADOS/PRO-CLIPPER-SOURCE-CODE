/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: PROG7
   Params: None.
   Return: Undefined
  Example: PROG7()
  ..........................................................................
*/

PROCEDURE PROG7()

   MEMVAR->OPC := " "

   DO WHILE OPC <> "*"

      MENU()
      MEMVAR->OPC := "*"
      DEVPOS(6, 1)
      DEVOUT(PADC("SISTEMA DE COPIAS Y PROCESOS EN BATCH", 78))
      DEVPOS(14, 28)
      DEVOUT("1. BATCH")
      DEVPOS(15, 28)
      DEVOUT("2. AUDITORIAS")
      DEVPOS(16, 28)
      DEVOUT("*  FIN")
      SETCOLOR("+W/R")
      DEVPOS(17, 28)
      DEVOUT("SELECCIONE UNA OPCION ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "123*"}, NIL):DISPLAY(;
            ))
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "*"

         LOOP
         RETURN 

      ENDIF

      MEMVAR->WNIV := "7" + OPC + "   "
      MEMVAR->XS := " "
      VEANIV()

      IF XS = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      MEMVAR->SWAUTO := 0
      MEMVAR->WPROG := "PROG7" + OPC
      &WPROG()

   ENDDO

   MEMVAR->OPC := " "

RETURN 

