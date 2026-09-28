/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LISTAINS
   Params: None.
   Return: Undefined
  Example: LISTAINS()
  ..........................................................................
*/

PROCEDURE LISTAINS()

   MEMVAR->OPC := " "
   SCROLL(5, 1, 23, 78)
   SETPOS(5, 1)
   DEVPOS(12, 20)
   DEVOUT("POR FAVOR DEME LA FECHA DE LOS LISTADOS")
   DEVPOS(13, 5)
   DEVOUT(" ")
   __RUN("DATE")

   DO WHILE OPC <> "*"

      MEMVAR->OPC := "*"
      MENU()
      DEVPOS(4, 1)
      DEVOUT(PADC("MANEJO DE MAESTRO DE INSUMOS, INFORMES", 78))
      DEVPOS(12, 25)
      DEVOUT("1. LISTADO GENERAL DE INSUMOS ")
      DEVPOS(13, 25)
      DEVOUT("2. LISTADO DE COMPRAS Y OTRAS ENTRADAS")
      DEVPOS(14, 25)
      DEVOUT("3. LISTADO DE CONSUMO POR PRODUCTO")
      DEVPOS(15, 25)
      DEVOUT("4. LISTADO RESUMEN")
      DEVPOS(16, 25)
      DEVOUT("5. LISTADO DE INSUMOS PARA INV. FISICO")
      DEVPOS(17, 25)
      DEVOUT("6. LISTA DE PRECIOS DE INSUMOS")
      DEVPOS(18, 25)
      DEVOUT("7. LISTDO DE VALORES DE PRODUCTOS EN PROCESO")
      DEVPOS(19, 25)
      DEVOUT("8. LISTADO DE MAXIMOS Y MINIMOS")
      DEVPOS(20, 25)
      DEVOUT("9. LISTADO DE UNIDADES Y FACTORES/PROVEEDOR")
      DEVPOS(21, 25)
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

      MEMVAR->WNIV := "122" + OPC + " "
      MEMVAR->XS := " "
      VEANIV()

      IF XS = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      MEMVAR->SWF := 0

      IF OPC = "1"

         LISINS()

      ELSEIF OPC = "2"

         LISCOMPR()

      ELSEIF OPC = "3"

         LISCONPR()

      ELSEIF OPC = "4"

         LISRESIN()

      ELSEIF OPC = "5"

         MENU()
         PIDEIMP()
         ENIM()
         QOUT(CHR(27)+CHR(15)+" ")
         AMAINS()
         __REPORTFO("INVINSU", .T., NIL, .F., NIL, NIL, NIL, NIL, .F., .F.,;
                NIL, .F., .F.)
         DBCLOSEARE()
         QOUT(CHR(27)+CHR(18)+" ")
         __EJECT()
         APIM()
         MEMVAR->OPC := " "

      ELSEIF OPC = "6"

         LISPREIN()

      ELSEIF OPC = "7"

         LISVALPR()

      ELSEIF OPC = "8"

         SCROLL(5, 1, 23, 78)
         MEMVAR->WTOD := ( SETPOS(5, 1), " " )
         DEVPOS(12, 10)
         DEVOUT("<T>odos o <S>olo criticos ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WTOD", "@!", {||WTOD $ "TS"}, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         PIDEIMP()
         AMAINS()

         IF WTOD = "S"

            ENIM()
            DEVPOS(PROW(), PCOL())
            DEVOUT(CHR(15)+" ")
            __REPORTFO("INVMIMA", .T., NIL, .F., {||SALDOUNI < MINIMO .OR. ;
                  SALDOUNI > MAXIMO}, NIL, NIL, NIL, .F., .F., NIL, .F., ;
                  .F.)
            DEVPOS(PROW(), PCOL())
            DEVOUT(CHR(18)+" ")
            APIM()

         ELSE

            ENIM()
            DEVPOS(PROW(), PCOL())
            DEVOUT(CHR(15)+" ")
            __REPORTFO("INVMIMA", .T., NIL, .F., NIL, NIL, NIL, NIL, .F., ;
                  .F., NIL, .F., .F.)
            DEVPOS(PROW(), PCOL())
            DEVOUT(CHR(18)+" ")
            APIM()

         ENDIF

         DBCLOSEARE()
         MEMVAR->OPC := " "

      ELSEIF OPC = "9"

         SCROLL(5, 1, 23, 78)
         SETPOS(5, 1)
         PIDEIMP()
         AMAINS()
         VEAIMP()
         ENIM()
         DEVPOS(PROW(), PCOL())
         DEVOUT(CHR(15)+" ")
         __REPORTFO("UNIPROV", .T., NIL, .F., {||UNIPROV <> SPACE(10) .OR. ;
               FACTUNI <> 0}, NIL, NIL, NIL, .F., .F., NIL, .F., .F.)
         DBCLOSEARE()
         DEVPOS(PROW(), PCOL())
         DEVOUT(CHR(18)+" ")
         MEMVAR->OPC := " "
         __EJECT()
         APIM()

      ENDIF

      IF SWF = 1

         SCROLL(5, 1, 23, 78)
         SETPOS(5, 1)
         DEVPOS(12, 20)
         DEVOUT("POR FAVOR DEME LA FECHA ACTUAL ")
         MEMVAR->SWF := 0
         __RUN("DATE")

      ENDIF

   ENDDO

   MEMVAR->OPC := " "

RETURN 

