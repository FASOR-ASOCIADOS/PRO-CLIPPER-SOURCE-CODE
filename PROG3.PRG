/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: PROG3
   Params: None.
   Return: Undefined
  Example: PROG3()
  ..........................................................................
*/

PROCEDURE PROG3()

   MEMVAR->OPC := " "

   DO WHILE OPC <> "*"

      MEMVAR->OPC := "*"
      MENU()
      DEVPOS(6, 1)
      DEVOUT(PADC("MANEJO DE ORDENES DE PRODUCCION", 78))
      DEVPOS(9, 21)
      DEVOUT("1. ELABORACION DE ORDENES DE LINEA")
      DEVPOS(10, 21)
      DEVOUT("2. ELABORACION DE ORDENES DE ESPECIALES")
      DEVPOS(11, 21)
      DEVOUT("3. IMPRESION DE ORDENES DE LINEA")
      DEVPOS(12, 21)
      DEVOUT("4. IMPRESION DE ORDENES DE ESPECIALES")
      DEVPOS(13, 21)
      DEVOUT("5. IMPRESION DE HOJA DE EMPAQUE")
      DEVPOS(14, 21)
      DEVOUT("6. IMPRESION DE RESUMEN DE MATERIA PRIMA")
      DEVPOS(15, 21)
      DEVOUT("7. CAMBIAR CONSECUTIVOS")
      DEVPOS(16, 21)
      DEVOUT("8. CONSULTAR PRODUCTOS EN FABRICACION")
      DEVPOS(17, 21)
      DEVOUT("9. MANEJO DIRECTO ARCHIVO O.P.")
      DEVPOS(18, 21)
      DEVOUT("0. ANULACION DE ORDENES")
      DEVPOS(19, 21)
      DEVOUT("Z. UBICACION DE LAS ORDENES")
      DEVPOS(21, 21)
      DEVOUT("*  FIN")
      SETCOLOR("+gr")
      DEVPOS(22, 23)
      DEVOUT("Seleccione una opci" + O + "n ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", NIL, NIL, NIL):DISPLAY())
      SETCOLOR("+G")
      DEVPOS(18, 52)
      DEVOUT("(entradas)")
      SETCOLOR("+W")
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "*"

         LOOP
         RETURN 

      ENDIF

      MEMVAR->WNIV := "3" + OPC + "   "
      MEMVAR->XS := " "
      VEANIV()

      IF XS = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      IF OPC = "1"

         ELAORDPR()

      ELSEIF OPC = "2"

         ELAORDPE()

      ELSEIF OPC = "3"

         IMPORDPR()

      ELSEIF OPC = "4"

         IMPORDPE()

      ELSEIF OPC = "5"

         MEMVAR->OPC := " "

         DO WHILE OPC <> "*"

            MENU()
            MEMVAR->OPC := "*"
            DEVPOS(4, 1)
            DEVOUT(PADC("IMPRESION DE HOJAS DE EMPAQUE", 78))
            DEVPOS(12, 23)
            DEVOUT("1. IMPRIME CANTIDADES EXACTAS")
            DEVPOS(13, 23)
            DEVOUT("2. IMPRIME CANTIDADES CONTROLADAS")
            DEVPOS(14, 23)
            DEVOUT("*. FIN")
            DEVPOS(16, 23)
            DEVOUT("Seleccione una opcion ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "OPC", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

            IF OPC = "1"

               IMPHOJEM()

            ENDIF

            IF OPC = "2"

               IMPHOJE1()

            ENDIF

         ENDDO

      ELSEIF OPC = "6"

         RESMATPR()

      ELSEIF OPC = "7"

         MENU()
         SETCOLOR("+W/B")
         DEVPOS(3, 20)
         DEVOUT("ACTUALIZANDO NUMERO DE ORDENES DE PRODUCCION")
         __MRESTORE("&ZDIS\&WDIRECTO\NUORPR", .T.)
         __MRESTORE("&ZDIS\&WDIRECTO\NUORPRB", .T.)
         SETCOLOR("+W")
         DEVPOS(12, 20)
         DEVOUT("ULTIMO NUMERO EDITADO DE A:")
         SETPOS(12, COL())
         AADD(GETLIST, __GET(NIL, "NUORPR", "@# 999999", NIL, NIL):DISPLAY(;
               ))
         DEVPOS(13, 20)
         DEVOUT("ULTIMO NUMERO EDITADO DE B:")
         SETPOS(13, COL())
         AADD(GETLIST, __GET(NIL, "NUORPRB", "@# 999999", NIL, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         FERASE("&ZDIS\&WDIRECTO\NUORPR.MEM")
         FERASE("&ZDIS\&WDIRECTO\NUORPRB.MEM")
         __MSAVE("&ZDIS\&WDIRECTO\NUORPR", "NUORPR", .T.)
         __MSAVE("&ZDIS\&WDIRECTO\NUORPRB", "NUORPRB", .T.)
         MEMVAR->OPC := " "

      ELSEIF OPC = "8"

         CONPROD()

      ELSEIF OPC = "9"

         MANDIROP()

      ELSEIF OPC = "0"

         ANUORDPR()

      ELSEIF OPC = "Z"

         UBIORD()

      ENDIF

      DBCLOSEALL()

   ENDDO

   MEMVAR->OPC := " "

RETURN 

