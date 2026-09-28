/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: PROG2
   Params: None.
   Return: Undefined
  Example: PROG2()
  ..........................................................................
*/

PROCEDURE PROG2()

   MEMVAR->OPC := " "

   DO WHILE OPC <> "*"

      CIERRE()
      MEMVAR->OPC := "*"
      MENU()
      DEVPOS(7, 27)
      DEVOUT("MANEJO DE ORDENES DE COMPRA")
      DEVPOS(12, 25)
      DEVOUT("1. GRABACION ORDENES")
      DEVPOS(13, 25)
      DEVOUT("2. IMPRESION")
      DEVPOS(14, 25)
      DEVOUT("3. GRABACION DE ENTRADAS")
      DEVPOS(15, 25)
      DEVOUT("4. MODIFICACION")
      DEVPOS(16, 25)
      DEVOUT("5. BORRADO")
      DEVPOS(17, 25)
      DEVOUT("6. CAMBIAR CONSECUTIVO")
      DEVPOS(18, 25)
      DEVOUT("7. LISTADOS")
      DEVPOS(19, 25)
      DEVOUT("*  FIN")
      DEVPOS(20, 25)
      DEVOUT("SELECCIONE UNA OPCION ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "1234567*"}, NIL);
            :DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "*"

         LOOP
         RETURN 

      ENDIF

      MEMVAR->WNIV := "2" + OPC + "   "
      MEMVAR->XS := " "
      VEANIV()

      IF XS = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      IF OPC = "1"

         GRAORD()

      ELSEIF OPC = "2"

         IOCC()

      ELSEIF OPC = "3"

         GRAENTOC()

      ELSEIF OPC = "4"

         MODORDCO()

      ELSEIF OPC = "5"

         BORORDCO()

      ELSEIF OPC = "6"

         CAMCONOC()

      ELSEIF OPC = "7"

         LISORDCO()

      ENDIF

      CIERRE()

   ENDDO

   MEMVAR->OPC := " "

RETURN 

