/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: BAJEX
   Params: None.
   Return: Undefined
  Example: BAJEX()
  ..........................................................................
*/

PROCEDURE BAJEX()

   MENU()
   DEVPOS(4, 1)
   DEVOUT(PADC("DANDO DE BAJA CONTROL DE PAGOS", 78))
   MEMVAR->OPC := " "
   DEVPOS(9, 10)
   DEVOUT("Ahora dar" + A + " de baja informaci" + O + ;
         "n del archivo de control de")
   DEVPOS(10, 10)
   DEVOUT("pagos excedidos en tareas (PAGDEMAS). Desea continuar ?S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   DEVPOS(14, 5)
   DEVOUT("Al dar de baja aqui no genera ningun archivo historico")
   DEVPOS(15, 5)
   DEVOUT("con la informacion eliminada.")
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC = "N" .OR. LASTKEY() = 27

      MEMVAR->OPC := 1
      RETURN 

   ENDIF

   MEMVAR->WTIPO := " "
   DEVPOS(13, 10)
   DEVOUT("Dar" + A + " de baja por <N>" + U + ;
         "mero de o.p., por <O>perario o por <T>area ?")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WTIPO", "@!", {||WTIPO $ "NOT"}, NIL):DISPLAY(;
         ))
   SETCOLOR("+G")
   DEVPOS(22, 15)
   DEVOUT("ESC para cancelar el proceso")
   SETCOLOR("+W")
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF LASTKEY() = 27

      MEMVAR->OPC := 1
      RETURN 

   ENDIF

   DO WHILE .T.

      IF WTIPO = "N"

         MEMVAR->WNUMD := MEMVAR->WNUMH := 0
         DEVPOS(17, 10)
         DEVOUT("Desde la o.p. # ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNUMD", "@Z 999999", NIL, NIL):DISPLAY();
               )
         DEVPOS(18, 10)
         DEVOUT("Hasta la o.p. # ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNUMH", "@Z 999999", NIL, NIL):DISPLAY();
               )
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WTIPO = "O"

         MEMVAR->WOPE := "  "
         DEVPOS(17, 10)
         DEVOUT("Del operario c" + O + "digo ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WOPE", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WTIPO = "T"

         MEMVAR->WTAR := "  "
         DEVPOS(17, 10)
         DEVOUT("De la tarea  ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WTAR", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ENDIF

      IF LASTKEY() = 27

         DBCLOSEARE()
         MEMVAR->OPC := 1
         RETURN 

      ENDIF

      ADEMASE()

      IF WTIPO = "N"

         MEMVAR->WNUMD := WNUMD - 1
         MEMVAR->WNUMH := WNUMH + 1
         DBEVAL({||DBDELETE()}, {||NUMORD > WNUMD .AND. NUMORD < WNUMH}, ;
               NIL, NIL, NIL, .F.)

      ELSEIF WTIPO = "O"

         DBEVAL({||DBDELETE()}, {||CODOPE = WOPE}, NIL, NIL, NIL, .F.)

      ELSEIF WTIPO = "T"

         DBEVAL({||DBDELETE()}, {||CODTAR = WTAR}, NIL, NIL, NIL, .F.)

      ENDIF

      IF LASTKEY() = 27

         DBEVAL({||DBRECALL()}, NIL, NIL, NIL, NIL, .F.)

      ELSE

         __DBPACK()

      ENDIF

      DBCLOSEARE()

   ENDDO

   MEMVAR->OPC := 1

RETURN 

