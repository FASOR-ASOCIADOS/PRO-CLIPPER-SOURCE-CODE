/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: PROG4
   Params: None.
   Return: Undefined
  Example: PROG4()
  ..........................................................................
*/

PROCEDURE PROG4()

   MEMVAR->OPC := " "

   DO WHILE OPC <> "*"

      MEMVAR->OPC := "*"
      MENU()
      DEVPOS(5, 30)
      DEVOUT("COSTOS DE PRODUCCION")
      DEVPOS(8, 20)
      DEVOUT("1. VARIACION DE PORCENTAJES DE UTILIDAD")
      DEVPOS(9, 20)
      DEVOUT("2. LISTADO DE COSTOS Y UTILIDAD DE PROD. TERM.")
      DEVPOS(10, 20)
      DEVOUT("3. LISTADO DE COSTOS REALES DE PRODUCCION")
      DEVPOS(11, 20)
      DEVOUT("4. ACTUALIZAR DATOS EN CUADRO DE COSTOS")
      DEVPOS(12, 20)
      DEVOUT("5. ACTUALIZAR DATOS DE Movts. DE MP & MO")
      DEVPOS(13, 20)
      DEVOUT("6. LISTADO DE MOVIMIENTOS DE COSTOS DE MAT. PRIMA")
      DEVPOS(14, 20)
      DEVOUT("7. LISTADO DE MOVIMIENTOS DE COSTOS DE MANO DE OBRA")
      DEVPOS(15, 20)
      DEVOUT("8. DAR DE BAJA MOVIMIENTOS DE COSTOS DE MAT.PRIMA (movcos)")
      DEVPOS(16, 20)
      DEVOUT("9. DAR DE BAJA MOVIMIENTOS DE MANO DE OBRA (movpag)")
      DEVPOS(17, 20)
      DEVOUT("0. DAR DE BAJA O.P. EN CUADRO DE COSTOS Y PAG6030 (costos)")
      DEVPOS(18, 20)
      DEVOUT("X. DAR DE BAJA EN MOV. DE ENTRADAS DE P.T. (moviorde)")
      DEVPOS(19, 20)
      DEVOUT("Y. DAR DE BAJA PAGOS DE TAREAS HISTORICOS (hispag63)")
      DEVPOS(20, 20)
      DEVOUT("Z. MANEJO DE COSTOS INDIRECTOS")
      DEVPOS(21, 20)
      DEVOUT("*  FIN")
      DEVPOS(23, 20)
      DEVOUT("SELECCIONE UNA OPCION ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "*"

         LOOP

      ENDIF

      MEMVAR->WNIV := "4" + OPC + "   "
      MEMVAR->XS := " "
      VEANIV()

      IF XS = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      IF OPC = "1"

         MODPRTE()

      ELSEIF OPC = "2"

         LISCOSIN()

      ELSEIF OPC = "3"

         LISCOSRE()

      ELSEIF OPC = "4"

         ACTCUACO()

      ELSEIF OPC = "5"

         ACTMPMO()

      ELSEIF OPC = "6"

         LICOMP()

      ELSEIF OPC = "7"

         SETCOLOR("+W")
         MEMVAR->OPC := " "

         DO WHILE OPC <> "*"

            MEMVAR->OPC := "*"
            MENU()
            DEVPOS(6, 1)
            DEVOUT(PADC(;
                  "INFORMES DE MOVIMIENTOS DE COSTOS DE MANO DE OBRA", 78))
            DEVPOS(12, 25)
            DEVOUT("1. SOLO TOTALES pantalla o impresora")
            DEVPOS(13, 25)
            DEVOUT("2. DISCRIMINADO en impresora")
            DEVPOS(14, 25)
            DEVOUT("*  NINGUNO")
            DEVPOS(17, 25)
            DEVOUT("SELECCIONE UNA OPCION ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "OPC", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

            IF OPC = "*"

               LOOP

            ENDIF

            IF OPC = "1"

               LICOMO1()

            ELSEIF OPC = "2"

               LICOMO2()

            ENDIF

         ENDDO

         MEMVAR->OPC := " "

      ELSEIF OPC = "8"

         DBMP()

      ELSEIF OPC = "9"

         DBMO()

      ELSEIF OPC = "0"

         DBOP()

      ELSEIF OPC = "X"

         DBMOOP()

      ELSEIF OPC = "Y"

         DBP63()

      ELSEIF OPC = "Z"

         MANCOSIN()

      ENDIF

   ENDDO

   MEMVAR->OPC := " "

RETURN 

