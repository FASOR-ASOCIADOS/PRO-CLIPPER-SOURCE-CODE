/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MANINS
   Params: None.
   Return: Undefined
  Example: MANINS()
  ..........................................................................
*/

PROCEDURE MANINS()

   MEMVAR->OPC := " "

   DO WHILE OPC <> "*"

      MEMVAR->OPC := "*"
      MENU()
      DEVPOS(4, 1)
      DEVOUT(PADC("MANEJO DE MAESTRO DE INSUMOS", 78))
      DEVPOS(10, 25)
      DEVOUT("1. MANEJO DIRECTO DEL MAESTRO")
      DEVPOS(11, 25)
      DEVOUT("2. LISTADOS")
      DEVPOS(12, 25)
      DEVOUT("3. MANEJO DE MAXIMOS Y MINIMO")
      DEVPOS(13, 25)
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

      MEMVAR->WNIV := "12" + OPC + "  "
      MEMVAR->XS := " "
      VEANIV()

      IF XS = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      MEMVAR->SWF := 0

      IF OPC = "4" .OR. OPC = "5" .OR. OPC = "6" .OR. OPC = "7" .OR. OPC = ;
            "8" .OR. OPC = "9" .OR. OPC = "0"

         MEMVAR->SWF := 1
         SCROLL(5, 1, 23, 78)
         SETPOS(5, 1)
         DEVPOS(12, 20)
         DEVOUT("POR FAVOR DEME LA FECHA DE LOS LISTADOS")
         DEVPOS(13, 5)
         DEVOUT(" ")
         __RUN("DATE")

      ENDIF

      IF OPC = "1"

         MANDIRIN()

      ELSEIF OPC = "2"

         LISTAINS()

      ELSEIF OPC = "3"

         MANMAMI()

      ENDIF

   ENDDO

   MEMVAR->OPC := " "

RETURN 

