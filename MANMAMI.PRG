/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MANMAMI
   Params: None.
   Return: Undefined
  Example: MANMAMI()
  ..........................................................................
*/

PROCEDURE MANMAMI()

   MEMVAR->OPC := " "

   DO WHILE OPC <> "*"

      MEMVAR->OPC := "*"
      MENU()
      DEVPOS(4, 1)
      DEVOUT(PADC("MANEJO DE MAXIMOS Y MINIMOS DE INSUMOS", 78))
      DEVPOS(11, 25)
      DEVOUT("1. DEFINE COBERTURA DE ACUMULADOS")
      DEVPOS(12, 25)
      DEVOUT("2. DEFINE FACTOR DEL MINIMO")
      DEVPOS(13, 25)
      DEVOUT("3. DEFINE FACTOR DEL MAXIMO")
      DEVPOS(14, 25)
      DEVOUT("4. RECALCULA MINIMOS Y MAXIMOS")
      DEVPOS(15, 25)
      DEVOUT("5. LISTADO DE MINIMOS Y MAXIMOS")
      DEVPOS(16, 25)
      DEVOUT("*  FIN")
      SETCOLOR("+G")
      DEVPOS(22, 20)
      DEVOUT("SELECCIONE UNA OPCION ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "12345*"}, NIL);
            :DISPLAY())
      SETCOLOR("+W")
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "*"

         LOOP

      ENDIF

      MEMVAR->WNIV := "123" + OPC + " "
      MEMVAR->XS := " "
      VEANIV()

      IF XS = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      MEMVAR->SWF := 0

      IF OPC = "1"

         MEMVAR->ZMINMAX0 := 11

         IF FILE("ZMINMAX0.MEM")

            __MRESTORE("ZMINMAX0", .T.)
            FERASE("ZMINMAX0.MEM")

         ENDIF

         MENU()
         DEVPOS(12, 10)
         DEVOUT("Cu" + A + ;
               "ntos meses quiere tomar para calcular el promedio")
         DEVPOS(13, 10)
         DEVOUT("de CONSUMO ? (m" + A + "ximo 11) ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "ZMINMAX0", "@Z 99", {||ZMINMAX0 > 1 ;
               .AND. ZMINMAX0 < 12}, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         __MSAVE("ZMINMAX0", "ZMINMAX0", .T.)

      ELSEIF OPC = "2"

         MEMVAR->ZMINMAX1 := 1

         IF FILE("ZMINMAX1.MEM")

            __MRESTORE("ZMINMAX1", .T.)
            FERASE("ZMINMAX1.MEM")

         ENDIF

         MENU()
         DEVPOS(12, 10)
         DEVOUT("El inventario m" + I + "nimo ser" + A)
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "ZMINMAX1", "@Z 99.9", NIL, NIL):DISPLAY(;
               ))
         DEVPOS(13, 10)
         DEVOUT("veces el promedio ")
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         __MSAVE("ZMINMAX1", "ZMINMAX1", .T.)

      ELSEIF OPC = "3"

         MEMVAR->ZMINMAX2 := 2

         IF FILE("ZMINMAX2.MEM")

            __MRESTORE("ZMINMAX2", .T.)
            FERASE("ZMINMAX2.MEM")

         ENDIF

         MENU()
         DEVPOS(12, 10)
         DEVOUT("El inventario m" + A + "ximo ser" + A)
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "ZMINMAX2", "@Z 99.9", NIL, NIL):DISPLAY(;
               ))
         DEVPOS(13, 10)
         DEVOUT("veces el promedio ")
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         __MSAVE("ZMINMAX2", "ZMINMAX2", .T.)

      ELSEIF OPC = "4"

         __MRESTORE("ZMINMAX0", .T.)
         __MRESTORE("ZMINMAX1", .T.)
         __MRESTORE("ZMINMAX2", .T.)
         MENU()
         MEMVAR->OPC := " "
         DEVPOS(12, 10)
         DEVOUT("Ahora recalculara los minimos y maximos con base en")
         DEVPOS(13, 10)
         DEVOUT("los consumos de los ultimos " + ALLTRIM(TRANSFORM(;
               ZMINMAX0, "99")) + " meses.")
         DEVPOS(14, 10)
         DEVOUT("Desea continuar ? S/N ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF OPC = "N" .OR. LASTKEY() = 27

            MEMVAR->OPC := " "
            LOOP

         ENDIF

         MEMVAR->WFACTOR := ZMINMAX0
         DEVPOS(15, 10)
         DEVOUT("Factor o divisor del acumulado para promediar ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "wfactor", "@Z 99.9", {||INT(WFACTOR) = ;
               ZMINMAX0}, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         DEVPOS(22, 10)
         DEVOUT("POR FAVOR ESPERE...")
         MEMVAR->CM := 0
         MEMVAR->WWMES := MEMVAR->WXMES := ZMES - 1

         IF WXMES = 0

            MEMVAR->WXMES := 12
            MEMVAR->WWMES := 12

         ENDIF

         MEMVAR->WAB := "BASURA.DBF"
         BA()
         MEMVAR->WAB := "BASURA1.DBF"
         BA()
         MEMVAR->WAB := "BASURA.NTX"
         BA()
         AMAINS()
         __DBCOPYST("C:\BASURA", {})
         DBCLOSEARE()
         DBSELECTAR("1")
         DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
         DBCREATEIN("C:\BASURA.NTX", "CODIGO", {||CODIGO}, NIL)

         DO WHILE CM < ZMINMAX0 + 1

            MEMVAR->WAB := "BASURA1.DBF"
            BA()
            MEMVAR->WNOMARC := "MAINSU" + ALLTRIM(TRANSFORM(WXMES, "99")) + ;
                  ".DBF"
            __COPYFILE("&ZDIS\&WDIRECTO\&WNOMARC", "C:\BASURA1.DBF")
            DBSELECTAR("2")
            DBUSEAREA(.F., NIL, "C:\BASURA1", NIL, NIL, .F.)

            DO WHILE  .NOT. EOF()

               MEMVAR->WCOD := CODIGO
               MEMVAR->WCOL := COLOR
               MEMVAR->WCONS := CONMESUNI
               DBSELECTAR("1")
               __DBLOCATE({||CODIGO = WCOD .AND. COLOR = WCOL}, NIL, NIL, ;
                     NIL, .F.)

               IF EOF()

                  DBAPPEND()
                  FIELD->CODIGO := WCOD
                  FIELD->COLOR := WCOL

               ENDIF

               FIELD->CONMESUNI := CONMESUNI + WCONS
               DBSELECTAR("2")
               DBSKIP(1)

            ENDDO

            DBSELECTAR("2")
            DBCLOSEARE()
            ++MEMVAR->CM

            IF CM = ZMINMAX0

               EXIT

            ENDIF

            MEMVAR->WWMES := WWMES - 1

            IF WWMES > 0

               MEMVAR->WXMES := WWMES

            ELSEIF WWMES = 0

               MEMVAR->WXMES := 12

            ELSEIF WWMES = -1

               MEMVAR->WXMES := 11

            ELSEIF WWMES = -2

               MEMVAR->WXMES := 10

            ELSEIF WWMES = -3

               MEMVAR->WXMES := 9

            ELSEIF WWMES = -4

               MEMVAR->WXMES := 8

            ELSEIF WWMES = -5

               MEMVAR->WXMES := 7

            ELSEIF WWMES = -6

               MEMVAR->WXMES := 6

            ELSEIF WWMES = -7

               MEMVAR->WXMES := 5

            ELSEIF WWMES = -8

               MEMVAR->WXMES := 4

            ELSEIF WWMES = -9

               MEMVAR->WXMES := 3

            ELSEIF WWMES = -10

               MEMVAR->WXMES := 2

            ELSEIF WWMES = -11

            ENDIF

         ENDDO

         DBSELECTAR("1")
         ORDLISTCLE()
         DBEVAL({||FIELD->CONMESUNI := CONMESUNI / WFACTOR}, NIL, NIL, NIL, ;
               NIL, .F.)
         AMAINER()
         DBSELECTAR("1")
         DBGOTOP()

         DO WHILE  .NOT. EOF()

            MEMVAR->WCOD := CODIGO
            MEMVAR->WCOL := COLOR
            MEMVAR->WMIN := CONMESUNI * ZMINMAX1
            MEMVAR->WMAX := CONMESUNI * ZMINMAX2
            DBSELECTAR("2")
            __DBLOCATE({||CODIGO = WCOD .AND. COLOR = WCOL}, NIL, NIL, NIL,;
                   .F.)

            IF  .NOT. EOF()

               FIELD->MINIMO := WMIN
               FIELD->MAXIMO := WMAX

            ENDIF

            DBSELECTAR("1")
            DBSKIP(1)

         ENDDO

         DBSELECTAR("1")
         DBCLOSEARE()
         DBSELECTAR("2")
         DBCLOSEARE()
         MEMVAR->WAB := "BASURA.DBF"
         BA()
         MEMVAR->WAB := "BASURA1.DBF"
         BA()
         MEMVAR->WAB := "BASURA.NTX"
         BA()
         MEMVAR->OPC := " "

      ELSEIF OPC = "5"

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

      ENDIF

   ENDDO

   MEMVAR->OPC := " "

RETURN 

