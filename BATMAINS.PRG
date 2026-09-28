/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: BATMAINS
   Params: None.
   Return: Undefined
  Example: BATMAINS()
  ..........................................................................
*/

PROCEDURE BATMAINS()

   SET(3, 2)
   MEMVAR->OPC := " "
   MENU()
   SETCOLOR("+G")
   DEVPOS(4, 15)
   DEVOUT("RECONSTRUCCION DE INFORMACION DE MAESTRO DE INSUMOS")
   SETCOLOR("+W")

   IF SWAUTO = 0

      DEVPOS(12, 15)
      DEVOUT("EN ESTE MOMENTO YA DEBIO COPIAR EL MAESTRO DE INSUMOS")
      DEVPOS(13, 15)
      DEVOUT("DESDE EL DISKETTE.  ESTA OPCION RECONSTRUYE EL MAESTRO DE")
      DEVPOS(14, 15)
      DEVOUT("INSUMOS < MAINSU.DBF >.  U N I C A M E N T E.")
      SETCOLOR("+G")
      DEVPOS(16, 10)
      DEVOUT("No debe haber mas usuarios en el sistema de produccion ")
      SETCOLOR("+W")
      DEVPOS(18, 15)
      DEVOUT("DESEA CONTINUAR ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC <> "S"

         MEMVAR->OPC := " "
         RETURN 

      ENDIF

   ENDIF

   SCROLL(5, 1, 23, 78)
   MEMVAR->OPC := ( SETPOS(5, 1), " " )
   DEVPOS(12, 20)
   DEVOUT("1. CORRER SOLO EL MES ")
   DEVPOS(13, 20)
   DEVOUT("2. CORRER EL MES Y LA SEMANA ")
   DEVPOS(14, 20)
   DEVOUT("3. CORRER SOLO LA SEMANA")
   DEVPOS(15, 20)
   DEVOUT("4. NINGUNO ")
   DEVPOS(17, 25)
   DEVOUT("SELECCIONE EL PROCEDIMIENTO ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "1234"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   SCROLL(5, 1, 23, 78)
   SETPOS(5, 1)

   IF OPC = "4"

      MEMVAR->OPC := " "
      CIERRE()
      RETURN 

   ENDIF

   MENU()
   MEMVAR->WCIME := MEMVAR->WCIAN := " "

   IF SWAUTO = 0

      DEVPOS(18, 20)
      DEVOUT("CIERRO EL MES ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCIME", "@!", {||WCIME $ "SN"}, NIL);
            :DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

   ELSE

      MEMVAR->WCIME := "S"

   ENDIF

   MEMVAR->WMESANT := ZMES - 1

   IF WMESANT = 0

      MEMVAR->WMESANT := 12

   ENDIF

   IF WMESANT = 12 .AND. SWAUTO = 1

      MEMVAR->WCIAN := "S"

   ELSEIF (OPC = "1" .OR. OPC = "2") .AND. WMESANT = 12

      SETCOLOR("+W/+B")
      DEVPOS(19, 20)
      DEVOUT("CIERRO EL A¥O ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCIAN", "@!", {||WCIAN $ "SN"}, NIL);
            :DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

   ENDIF

   AMAINE()

   IF OPC = "1" .OR. OPC = "2" .OR. WCIME = "S"

      DEVPOS(23, 20)
      DEVOUT("Cerrando el mes")
      DBEVAL({||FIELD->ENTMESUNI := 0, FIELD->ENTMESPES := 0, FIELD->;
            OTRENMEUNI := 0, FIELD->OTRENMEPES := 0, FIELD->CONMESUNI := 0, ;
            FIELD->CONMESPES := 0, FIELD->OTRSAMESUN := 0, FIELD->OTRSAMESPE ;
            := 0, FIELD->COSCONMES := 0}, NIL, NIL, NIL, NIL, .F.)

      IF WCIAN = "S"

         DEVPOS(23, 20)
         DEVOUT("Cerrando el a" + NMI + "o")
         DBEVAL({||FIELD->ENTANOUNI := 0, FIELD->ENTANOPES := 0, FIELD->;
               OTRENANOUN := 0, FIELD->OTRENANOPE := 0, FIELD->CONANOUNI := ;
               0, FIELD->CONANOPES := 0, FIELD->OTRSAANOUN := 0, FIELD->;
               OTRSAANOPE := 0, FIELD->COSCONANO := 0}, NIL, NIL, NIL, NIL, ;
               .F.)

      ENDIF

   ENDIF

   DBCLOSEARE()
   MENU()
   ESPERE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   AMVPRSS()
   __DBCOPYST("C:\BASURA", {})
   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
   MEMVAR->WCANREC := 0

   IF OPC = "1" .OR. OPC = "2"

      __DBAPP("&ZDIS\&WDIRECTO\&FMOVINS", {}, NIL, NIL, NIL, NIL, .F., NIL)
      DBCOMMITAL()
      DBEVAL({||FIELD->CODPROV := "M     "}, NIL, NIL, NIL, NIL, .F.)
      MEMVAR->WCANREC := LASTREC()

   ENDIF

   IF OPC = "2" .OR. OPC = "3"

      __DBAPP("&ZDIS\&WDIRECTO\MOVPRSEM", {}, NIL, NIL, NIL, NIL, .F., NIL)
      DBEVAL({||FIELD->CODPROV := "S     "}, {||RECNO() > WCANREC}, NIL, ;
            NIL, NIL, .F.)

   ENDIF

   DBCLOSEARE()
   MENU()
   MEMVAR->SWNM := 0
   DBSELECTAR("1")
   DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
   MEMVAR->WVALPOS := 20 / LASTREC()
   MEMVAR->RAYA := REPLICATE("Û", 20)
   DEVPOS(23, 30)
   DEVOUT(RAYA)
   MEMVAR->WCOLU := 10
   MEMVAR->CL := 7
   SETCOLOR("+W")

   DO WHILE  .NOT. EOF()

      IF SUBSTR(CODPROV, 1, 1) = "M"

         MEMVAR->WPERI := "MENSUALES"

      ELSE

         MEMVAR->WPERI := "SEMANALES"

      ENDIF

      DEVPOS(22, 20)
      DEVOUT("ESTOY REVISANDO LOS CODIGOS " + WPERI)
      MEMVAR->WCOLU := WCOLU + WVALPOS
      DEVPOS(23, WCOLU)
      DEVOUT(CHR(26))
      DBSELECTAR("1")
      MEMVAR->WCOD := CODIGO
      MEMVAR->WCOL := NUMCOLOR
      MEMVAR->WPOS := RECNO()
      AMAINS()
      __DBLOCATE({||CODIGO = WCOD .AND. NUMCOLOR = WCOL}, NIL, NIL, NIL, ;
            .F.)

      IF EOF()

         DBCLOSEARE()
         DEVPOS(CL, 1)
         DEVOUT("CODIGO <<" + WCOD + ">>   REGISTRO Nro. " + LTRIM(STR(;
               WPOS)))
         MEMVAR->SWNM := 1
         MEMVAR->CL := MEMVAR->CL + 1

         IF CL > 18

            SCROLL(7, 1, 19, 78)
            MEMVAR->CL := ( SETPOS(7, 1), 7 )

         ENDIF

      ENDIF

      DBCLOSEARE()
      DBSELECTAR("1")
      DBSKIP(1)

   ENDDO

   IF SWNM = 1

      SCROLL(22, 1, 23, 78)
      SETPOS(22, 1)
      DEVPOS(22, 20)
      DEVOUT("REFERENCIAS " + WPERI + " INCOMPLETAS, SE CANCELA PROCESO")
      DEVPOS(23, 20)
      DEVOUT("OPRIMA ALGUNA TECLA PARA REGRESAR")
      MEMVAR->X := INKEY(0)
      CIERRE()
      MEMVAR->WAB := "BASURA.DBF"
      BA()
      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   DBSELECTAR("1")
   DBGOTOP()
   SCROLL(5, 1, 23, 78)
   MEMVAR->WVALPOS := ( SETPOS(5, 1), 20 / LASTREC() )
   MEMVAR->RAYA := REPLICATE("Û", 20)
   DEVPOS(23, 20)
   DEVOUT(RAYA)
   MEMVAR->WCOLU := 10

   DO WHILE  .NOT. EOF()

      IF SUBSTR(CODPROV, 1, 1) = "M"

         MEMVAR->WPERI := "MENSUALES"

      ELSE

         MEMVAR->WPERI := "SEMANALES"

      ENDIF

      DEVPOS(12, 13)
      DEVOUT("Por favor espere unos minutos...Batch " + SUBSTR(WPERI, 1, 7);
             + " en proceso...")
      MEMVAR->WT1 := ALLTRIM(TRANSFORM(RECNO(), "9999")) + "/" + ALLTRIM(;
            TRANSFORM(LASTREC(), "9999")) + " " + SUBSTR(WPERI, 1, 7)
      DEVPOS(22, 79 - LEN(WT1))
      DEVOUT(WT1)
      MEMVAR->WCOLU := WCOLU + WVALPOS
      DEVPOS(23, WCOLU)
      DEVOUT(CHR(26))
      MEMVAR->WCOD := CODIGO
      MEMVAR->WCOL := NUMCOLOR
      MEMVAR->WNUMCOL := NUMCOLOR
      MEMVAR->WTIPMOV := TIPOMOV
      MEMVAR->WDOC := NUMDOC
      MEMVAR->WFECPRO := FECHA
      MEMVAR->WCAN := CANTIDAD
      MEMVAR->WVALUNI := VALUNI
      MEMVAR->WVALTOT := VALTOT
      MEMVAR->WCOSPRO := COSPRO
      DBSELECTAR("2")
      DBCLOSEARE()
      AMAINS()
      __DBLOCATE({||CODIGO = WCOD .AND. NUMCOLOR = WCOL}, NIL, NIL, NIL, ;
            .F.)

      IF EOF()

         DBCLOSEARE()
         QOUT(CHR(7))
         DBSELECTAR("1")
         DBSKIP(1)
         LOOP

      ENDIF

      BATINS1()
      DBCLOSEARE()
      DBSELECTAR("1")
      DBSKIP(1)

   ENDDO

   DBSELECTAR("1")
   DBCLOSEARE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   CIERRE()
   MEMVAR->OPC := " "

RETURN 

