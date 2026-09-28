/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: PROG71
   Params: None.
   Return: Undefined
  Example: PROG71()
  ..........................................................................
*/

PROCEDURE PROG71()

   MEMVAR->OPC := " "
   MENU()
   SETCOLOR("+GR")
   DEVPOS(6, 22)
   DEVOUT("  ELABORACION DE PROCESOS EN BATCH")
   DEVPOS(12, 10)
   DEVOUT("Por medio de esta opci¢n se reconstruye la informaci¢n")
   DEVPOS(13, 10)
   DEVOUT("de uno o varios de los archivos de producci¢n, despues")
   DEVPOS(14, 10)
   DEVOUT("de haber traido las copias de diskette o disco duro.")
   DEVPOS(15, 20)
   DEVOUT("desea continuar con el procedimiento ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   SETCOLOR("W")

   IF OPC <> "S"

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   MEMVAR->F1 := MEMVAR->F2 := MEMVAR->F3 := MEMVAR->F4 := " "
   SETCOLOR("+W")
   SCROLL(9, 2, 23, 78)
   SETPOS(9, 2)
   DEVPOS(10, 25)
   DEVOUT("MAESTRO DE INSUMOS      ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "F1", "@!", NIL, NIL):DISPLAY())
   DEVPOS(11, 25)
   DEVOUT("CUADRO DE COSTOS (M.P.) ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "F2", "@!", NIL, NIL):DISPLAY())
   DEVPOS(12, 25)
   DEVOUT("CUADRO DE COSTOS (M.O.) ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "F3", "@!", NIL, NIL):DISPLAY())
   DEVPOS(13, 25)
   DEVOUT("CREA O.P. EN COSTOS     ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "F4", "@!", NIL, NIL):DISPLAY())
   DEVPOS(22, 20)
   DEVOUT("marque con < X > los archivos a reconstruir ")
   SETCOLOR("+G")
   DEVPOS(22, 33)
   DEVOUT("X")
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   SETCOLOR("*+G")
   MEMVAR->OPC := " "
   SETCOLOR("W")

   IF F1 = "X"

      BATMAINS()

   ENDIF

   IF F2 = "X"

      BATMP()

   ENDIF

   IF F3 = "X"

      BATMO()

   ENDIF

   IF F4 = "X"

      BATCOS0()

   ENDIF

   MEMVAR->OPC := " "
   MENU()

RETURN 

