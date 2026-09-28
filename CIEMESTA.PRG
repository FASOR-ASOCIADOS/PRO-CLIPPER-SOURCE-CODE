/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: CIEMESTA
   Params: None.
   Return: Undefined
  Example: CIEMESTA()
  ..........................................................................
*/

PROCEDURE CIEMESTA()

   MEMVAR->OPC := " "
   SCROLL(5, 1, 23, 78)
   SETPOS(5, 1)
   DEVPOS(7, 1)
   DEVOUT(PADC("CIERRE DE MES DE PAGOS DE TAREAS", 78))
   MEMVAR->LINEA := REPLICATE("ß", 32)
   SETCOLOR("+GR")
   DEVPOS(8, 24)
   DEVOUT(LINEA)
   SETCOLOR("+W")
   DEVPOS(12, 25)
   DEVOUT("Por medio de esta opci" + O + "n se cerrar" + A + ;
         " el mes de pagos")
   DEVPOS(13, 25)
   DEVOUT("de tareas, esto es; los acumulados de pagos de todo")
   DEVPOS(14, 25)
   DEVOUT("el mes ser" + A + "n eliminados para iniciar el nuevo mes.")
   DEVPOS(16, 25)
   DEVOUT("desea continuar ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC <> "S"

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   APAGAE()
   SAP()
   DBCLOSEARE()
   APAMOE()
   SAP()
   DBCLOSEARE()
   MEMVAR->OPC := " "

RETURN 

