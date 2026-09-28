/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: PROG5
   Params: None.
   Return: Undefined
  Example: PROG5()
  ..........................................................................
*/

PROCEDURE PROG5()

   MEMVAR->OPC := " "

   DO WHILE OPC <> "*"

      MEMVAR->OPC := "*"
      MENU()
      DEVPOS(7, 1)
      DEVOUT(PADC("MANEJO DE PAGOS DE TAREAS", 78))
      DEVPOS(10, 25)
      DEVOUT("1. GENERAR PAGOS DE TAREAS (diario)")
      DEVPOS(11, 25)
      DEVOUT("2. INFORME COMPARATIVO TIEMPOS: STD vs REAL")
      DEVPOS(12, 25)
      DEVOUT("3. MODIFICACION DE DATOS (mensual)")
      DEVPOS(13, 25)
      DEVOUT("4. LISTADO POR OPERARIO (mensual)")
      DEVPOS(14, 25)
      DEVOUT("5. LISTADO GENERAL PARA REVISION")
      DEVPOS(15, 25)
      DEVOUT("6. CIERRE DE MES")
      DEVPOS(16, 25)
      DEVOUT("7. MANEJO DE ARCHIVO DE CONTROL DE PAGOS")
      DEVPOS(17, 25)
      DEVOUT("8. CONSULTA A PAGOS DIARIOS Y MENSUALES")
      DEVPOS(18, 25)
      DEVOUT("*  FIN")
      DEVPOS(22, 20)
      DEVOUT(" Seleccione una opci¢n ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "*" .OR. LASTKEY() = 27

         EXIT

      ENDIF

      MEMVAR->WNIV := "5" + OPC + "   "
      MEMVAR->XS := " "
      VEANIV()

      IF XS = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      IF OPC = "1"

         MEMVAR->TC := " "
         MEMVAR->SA := "S"

         DO WHILE UPPER(TC) <> "S"

            MEMVAR->TC := " "

            IF UPPER(SA) = "S"

               GENPAGTA()
               MEMVAR->SA := " "

            ENDIF

            APAMOS()

            IF LASTREC() > 0

               DBCLOSEARE()
               LISGENDI()

            ENDIF

            DBCLOSEARE()
            SCROLL(5, 1, 23, 78)
            MEMVAR->TC := ( SETPOS(5, 1), " " )
            RUTTC()
            SCROLL(20, 1, 23, 78)
            SETPOS(20, 1)

            IF TC <> "S"

               LISOPEDI()
               MODPAGT1()
               MEMVAR->SA := " "
               DEVPOS(23, 20)
               DEVOUT("SIGUE ADICIONANDO PAGOS ? S/N ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "SA", "@!", {||SA $ "SN"}, NIL);
                     :DISPLAY())
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}
               DEVPOS(23, 20)
               DEVOUT("                                   ")
               MEMVAR->OPC := " "
               SCROLL(5, 1, 23, 78)
               SETPOS(5, 1)

            ENDIF

         ENDDO

         CIEDIATA()

      ELSEIF OPC = "2"

         CONSTIEC()

      ELSEIF OPC = "3"

         MODPAGTA()

      ELSEIF OPC = "4"

         LISOPEAC()

      ELSEIF OPC = "5"

         LISOPERE()

      ELSEIF OPC = "6"

         CIEMESTA()

      ELSEIF OPC = "7"

         MANCON()

      ELSEIF OPC = "8"

         CONSUPAG()

      ENDIF

   ENDDO

   MEMVAR->OPC := " "
   SET(3, 2)

RETURN 

