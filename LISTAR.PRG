/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LISTAR
   Params: None.
   Return: Undefined
  Example: LISTAR()
  ..........................................................................
*/

PROCEDURE LISTAR()

   MEMVAR->OPC := " "
   MENU()
   MEMVAR->WFECHA := DATE()
   DEVPOS(12, 20)
   DEVOUT("POR FAVOR DEME LA FECHA PARA LOS LISTADOS ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WFECHA", NIL, NIL, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   SET(3, 0)

   DO WHILE OPC <> "*"

      MEMVAR->OPC := "*"
      MENU()
      DEVPOS(12, 25)
      DEVOUT("1. TAREAS POR PRODUCTO")
      DEVPOS(13, 25)
      DEVOUT("2. PRODUCTOS POR TAREA")
      DEVPOS(15, 25)
      DEVOUT("*  FIN")
      DEVPOS(18, 20)
      DEVOUT("Seleccione una opci¢n ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "*"

         LOOP

      ENDIF

      MEMVAR->WNIV := "154" + OPC + " "
      MEMVAR->XS := " "
      VEANIV()

      IF XS = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      IF OPC = "1"

         LITARPRO()

      ELSEIF OPC = "2"

         LIPROTAR()

      ENDIF

   ENDDO

   MEMVAR->OPC := " "
   SET(3, 2)

RETURN 

