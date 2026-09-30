/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: PROG1
   Params: None.
   Return: Undefined
  Example: PROG1()
  ..........................................................................
*/

PROCEDURE PROG1()

   MEMVAR->OPC := " "

   DO WHILE OPC <> "*"

      MEMVAR->OPC := "*"
      MENU()
      DEVPOS(7, 1)
      DEVOUT(PADC("M A N E J O    D E    M A E S T R O S", 78))
      DEVPOS(10, 25)
      DEVOUT("1. ARCHIVO MAESTRO DE PRODUCTO TERMINADO")
      DEVPOS(11, 25)
      DEVOUT("2. ARCHIVO MAESTRO DE INSUMOS")
      DEVPOS(12, 25)
      DEVOUT("3. INSUMOS POR PRODUCTO")
      DEVPOS(13, 25)
      DEVOUT("4. PROVEEDORES ")
      DEVPOS(14, 25)
      DEVOUT("5. TAREAS ")
      DEVPOS(15, 25)
      DEVOUT("6. MAESTRO DE MAQUINAS")
      DEVPOS(16, 25)
      DEVOUT("7. ACTUALIZACION DE VARIABLES Y %s")
      DEVPOS(17, 25)
      DEVOUT("8. PERSONAL DE PLANTA")
      DEVPOS(18, 25)
      DEVOUT("9. BROWSE DE ARCHIVOS")
      DEVPOS(19, 25)
      DEVOUT("Z. CAMBIO DE CODIGOS DE INSUMOS A .DBFs")
      SETCOLOR("+GR")
      DEVPOS(20, 25)
      DEVOUT("*")
      SETCOLOR("+W")
      DEVPOS(20, 28)
      DEVOUT("FIN")
      SETCOLOR("+GR/B")
      SCROLL(22, 18, 22, 38)
      SETPOS(22, 18)
      DEVPOS(22, 20)
      DEVOUT(" Seleccione una opci¢n ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "123456789*"}, NIL);
            :DISPLAY())
      SETCOLOR("+W")
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "*"

         LOOP

      ENDIF

      MEMVAR->WNIV := "1" + OPC + "   "
      MEMVAR->XS := " "
      VEANIV()

      IF XS = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      IF OPC = "1"

         MANPRTE()

      ELSEIF OPC = "2"

         MANINS()

      ELSEIF OPC = "3"

         MANINSPR()

      ELSEIF OPC = "4"

         MANPROV()

      ELSEIF OPC = "5"

         MANTAR()

      ELSEIF OPC = "6"

         MANMAQ()

      ELSEIF OPC = "7"

         MEMVAR->OPC := " "
         MEMVAR->PPOC := SPACE(76)
         MEMVAR->ZHORWMES := 0

         IF FILE("&ZDIS\&WDIRECTO\ZHORWMES.MEM")

            __MRESTORE("&ZDIS\&WDIRECTO\ZHORWMES.MEM", .T.)

         ENDIF

         __MRESTORE("&ZDIS\&WDIRECTO\SALMIN", .T.)
         __MRESTORE("&ZDIS\&WDIRECTO\COSDIR", .T.)
         __MRESTORE("&ZDIS\&WDIRECTO\PORMOI", .T.)
         __MRESTORE("&ZDIS\&WDIRECTO\FACTOIVA", .T.)
         __MRESTORE("&ZDIS\&WDIRECTO\PPOC", .T.)
         SCROLL(5, 1, 23, 78)
         SETPOS(5, 1)
         DEVPOS(7, 19)
         DEVOUT("ACTUALIZACION DE SALARIO MINIMO Y COSTOS DIRECTOS")
         DEVPOS(12, 20)
         DEVOUT("SALARIO MINIMO ACTUAL ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "SALMIN", "@Z 99,999,999.99", NIL, NIL);
               :DISPLAY())
         DEVPOS(13, 20)
         DEVOUT("COSTOS DIRECTOS       ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "COSDIR", "@Z 99,999,999.99", NIL, NIL);
               :DISPLAY())
         DEVPOS(14, 20)
         DEVOUT("% M.O. A" + NMA + "O            ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "PORMOI", "@Z 999.99", NIL, NIL):DISPLAY(;
               ))
         DEVPOS(15, 20)
         DEVOUT("NUEVO VALOR I.V.A. ?  ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "FACTOIVA", "@# 999", NIL, NIL):DISPLAY();
               )
         DEVPOS(16, 20)
         DEVOUT("HORAS LABORALES MES?  ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "ZHORWMES", "@# 999", NIL, NIL):DISPLAY();
               )
         DEVPOS(17, 20)
         DEVOUT("Pie de pagina de las ordenes de compra:")
         SETPOS(18, 20)
         AADD(GETLIST, __GET(NIL, "PPOC", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF FILE("&ZDIS\&WDIRECTO\ZHORWMES.MEM")

            __MRESTORE("&ZDIS\&WDIRECTO\ZHORWMES.MEM", .T.)

         ENDIF

         IF FILE("&ZDIS\&WDIRECTO\ZHORWMES.MEM")

            FERASE("&ZDIS\&WDIRECTO\ZHORWMES.MEM")

         ENDIF

         FERASE("&ZDIS\&WDIRECTO\SALMIN.MEM")
         FERASE("&ZDIS\&WDIRECTO\COSDIR.MEM")
         FERASE("&ZDIS\&WDIRECTO\PORMOI.MEM")
         FERASE("&ZDIS\&WDIRECTO\FACTOIVA.MEM")
         FERASE("&ZDIS\&WDIRECTO\PPOC.MEM")
         __MSAVE("&ZDIS\&WDIRECTO\SALMIN", "SALMIN", .T.)
         __MSAVE("&ZDIS\&WDIRECTO\COSDIR", "COSDIR", .T.)
         __MSAVE("&ZDIS\&WDIRECTO\PORMOI", "PORMOI", .T.)
         __MSAVE("&ZDIS\&WDIRECTO\FACTOIVA", "FACTOIVA", .T.)
         __MSAVE("&ZDIS\&WDIRECTO\PPOC", "PPOC", .T.)
         __MSAVE("&ZDIS\&WDIRECTO\HORWMES", "ZHORWMES", .T.)
         __MXRELEAS("FACTOIVA")
         MEMVAR->OPC := " "

      ELSEIF OPC = "8"

         MANPERPL()

      ELSEIF OPC = "9"

         MENU()
         MEMVAR->WCLAVE := "        "
         SET(17, "OFF")
         DEVPOS(12, 10)
         DEVOUT("CLAVE DE ACCESO ")
         MEMVAR->WCLAVE := __ACCEPT()
         SET(17, "ON")
         __MRESTORE("DATO", .T.)

         IF ALLTRIM(WCLAVE) <> ALLTRIM(DATO)

            MEMVAR->OPC := " "
            __MRELEASE("DATO?", .T.)
            LOOP

         ENDIF

         __MRELEASE("DATO?", .T.)
         MEMVAR->WARCH := "        "
         DEVPOS(14, 10)
         DEVOUT("ARCHIVO A EXAMINAR ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WARCH", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF WARCH = SPACE(8)

            MEMVAR->OPC := " "
            LOOP

         ENDIF

         MEMVAR->WARCH := ALLTRIM(WARCH) + ".DBF"

         IF  .NOT. FILE("&WARCH")

            DEVPOS(15, 10)
            DEVOUT("ESE ARCHIVO NO EXISTE, PULSE UNA TECLA ")
            MEMVAR->X := INKEY(0)
            LOOP

         ENDIF

         DBUSEAREA(.F., NIL, WARCH, NIL, NIL, .F.)
         MEMVAR->WNOMIND := MEMVAR->WNOMIND1 := "           "
         DEVPOS(15, 10)
         DEVOUT("Escriba el nombre de un campo para indexar, (opcional)")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNOMIND", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         MEMVAR->WAB := "BASURA.NTX"
         BA()

         IF WNOMIND <> SPACE(8)

            MEMVAR->WNOMIND := ALLTRIM(WNOMIND)
            DEVPOS(16, 10)
            DEVOUT("Otro sub indice (Opcional) ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WNOMIND1", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

            IF WNOMIND1 <> SPACE(8)

               MEMVAR->WNOMIND1 := ALLTRIM(WNOMIND1)
               DBCREATEIN("C:\PROTMP\BASURA.KEY", "&WNOMIND+&WNOMIND1", (&(;
                     "{|| &WNOMIND+&WNOMIND1}")), NIL)

            ELSE

               DBCREATEIN("C:\PROTMP\BASURA.KEY", WNOMIND, (&("{||" + WNOMIND + ;
                     "}")), NIL)

            ENDIF

         ENDIF

         SCROLL(23, 1, 23, 78)
         SETPOS(23, 1)
         SET(3, 4)
         BROWSE(5, 1, 23, 78)
         SET(3, 2)
         __DBLOCATE({||DELETED()}, NIL, NIL, NIL, .F.)

         IF  .NOT. EOF()

            MEMVAR->WBORR := " "
            SCROLL(5, 1, 23, 78)
            SETPOS(5, 1)
            DEVPOS(12, 10)
            DEVOUT("Borr" + O + " registros ? ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WBORR", "@!", {||WBORR $ "SN"}, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

            IF WBORR = "S"

               MEMVAR->WCAN := 0
               DEVPOS(13, 10)
               DEVOUT("CUANTOS ? ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "WCAN", "@Z 999", NIL, NIL);
                     :DISPLAY())
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}
               SET(11, "OFF")
               MEMVAR->WCB := 0
               DBEVAL({||MEMVAR->WCB := WCB + 1}, {||DELETED()}, NIL, NIL, ;
                     NIL, .F.)

               IF WCB = WCAN

                  MEMVAR->OPC := " "
                  DEVPOS(14, 10)
                  DEVOUT(TRANSFORM(WCB, "999") + ;
                        " BORRADOS, LO CONFIRMA ? S/N ")
                  SETPOSBS()
                  AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, ;
                        NIL):DISPLAY())
                  READMODAL(GETLIST)
                  MEMVAR->GETLIST := {}

                  IF OPC = "S"

                     __DBPACK()

                  ELSE

                     DBEVAL({||DBRECALL()}, NIL, NIL, NIL, NIL, .F.)
                     DEVPOS(15, 10)
                     DEVOUT("TODOS LOS REGISTROS FUERON DESMARCADOS")
                     MEMVAR->X := INKEY(0)

                  ENDIF

               ELSE

                  DEVPOS(14, 10)
                  DEVOUT("NO CUADRA ")
                  DEVPOS(15, 10)
                  DEVOUT("REGISTROS MARCADOS PARA BORRAR  " + TRANSFORM(;
                        WCB, "999"))
                  DEVPOS(16, 10)
                  DEVOUT("POR PRECAUCION TODOS SERAN DESBORRADOS")
                  MEMVAR->X := INKEY(0)
                  DBEVAL({||DBRECALL()}, NIL, NIL, NIL, NIL, .F.)

               ENDIF

            ENDIF

         ENDIF

         DBCLOSEARE()
         MEMVAR->OPC := " "

      ELSEIF OPC = "Z"

         CAMCOD()

      ENDIF

   ENDDO

   MEMVAR->OPC := " "

RETURN 

