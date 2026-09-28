/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MODPAGTA
   Params: None.
   Return: Undefined
  Example: MODPAGTA()
  ..........................................................................
*/

PROCEDURE MODPAGTA()

   AMAPERE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\COD-PER")
   ORDLISTREB()
   DBCLOSEARE()
   AP6030E()
   DBCLOSEARE()
   __MRESTORE("&ZDIS\&WDIRECTO\SALMIN", .T.)
   __MRESTORE("&ZDIS\&WDIRECTO\HORWMES", .T.)
   SETCOLOR("G")
   MEMVAR->WFECHA := DATE()
   MEMVAR->WVALHOR := SALMIN / ZHORWMES
   MEMVAR->OPC := " "
   MEMVAR->WFEC := DATE()

   DO WHILE OPC <> "N"

      MENU()
      DEVPOS(4, 1)
      DEVOUT(PADC("MODIFICACION DE PAGOS DE TAREAS", 78))
      MEMVAR->WNUMORD := 0
      MEMVAR->WOPE := MEMVAR->WCODTAR := "  "
      MEMVAR->WCODPRO := ZLCPT
      DEVPOS(10, 15)
      DEVOUT("NUMERO DE LA O.P.   ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WNUMORD", "@# 99999", NIL, NIL):DISPLAY())
      DEVPOS(11, 15)
      DEVOUT("CODIGO DEL OPERARIO ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WOPE", NIL, NIL, NIL):DISPLAY())
      DEVPOS(12, 15)
      DEVOUT("FECHA DEL PAGO      ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WFECHA", NIL, NIL, NIL):DISPLAY())
      DEVPOS(13, 15)
      DEVOUT("COD. DE LABOR       ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCODTAR", NIL, NIL, NIL):DISPLAY())
      SETCOLOR("+G")
      DEVPOS(15, 15)
      DEVOUT("ESC para cancelar")
      SETCOLOR("+W")
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WNUMORD = 0 .OR. LASTKEY() = 27

         MEMVAR->OPC := "N"
         LOOP

      ENDIF

      SCROLL(15, 1, 23, 78)
      SETPOS(15, 1)

      IF WNUMORD = 999

         DEVPOS(14, 15)
         DEVOUT("CODIGO DE P.T.      ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCODPRO", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ENDIF

      AMAPERS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\COD-PER")
      DBSEEK("&WOPE")

      IF  .NOT. EOF()

         MEMVAR->WNOM := TRIM(NOM) + " " + TRIM(APE)

      ELSE

         MEMVAR->WNOM := "Nombre no encontrado en maestro"

      ENDIF

      DBCLOSEARE()
      DEVPOS(11, 42)
      DEVOUT(WNOM)
      APAGAS()

      IF WNUMORD <> 999

         __DBLOCATE({||NUMORD = WNUMORD .AND. CODOPE = WOPE .AND. FECHA = ;
               WFECHA .AND. CODTAR = WCODTAR}, NIL, NIL, NIL, .F.)

      ELSE

         __DBLOCATE({||NUMORD = WNUMORD .AND. CODOPE = WOPE .AND. FECHA = ;
               WFECHA .AND. CODTAR = WCODTAR .AND. WCODPRO = CODPRO}, NIL, ;
               NIL, NIL, .F.)

      ENDIF

      IF EOF()

         DBCLOSEARE()
         DEVPOS(16, 20)
         DEVOUT("PAGO NO REGISTRADO EN EL MES")
         MEMVAR->X := INKEY(0)
         LOOP

      ENDIF

      MEMVAR->WPOS10 := RECNO() - 1
      DBCLOSEARE()
      AMOPAS()

      IF WNUMORD <> 999

         __DBLOCATE({||NUMORD = WNUMORD .AND. CODOPE = WOPE .AND. FECHA = ;
               WFECHA .AND. CODTAR = WCODTAR}, NIL, NIL, NIL, .F.)

      ELSE

         __DBLOCATE({||NUMORD = WNUMORD .AND. CODOPE = WOPE .AND. FECHA = ;
               WFECHA .AND. CODTAR = WCODTAR .AND. CODPRO = WCODPRO}, NIL, ;
               NIL, NIL, .F.)

      ENDIF

      MEMVAR->WPOS11 := RECNO() - 1
      DBCLOSEARE()
      MEMVAR->SWPARE := 0

      DO WHILE SWPARE = 0

         SCROLL(23, 1, 23, 78)
         SETPOS(23, 1)
         APAGAS()

         IF WNUMORD <> 999

            __DBLOCATE({||NUMORD = WNUMORD .AND. CODOPE = WOPE .AND. FECHA ;
                  = WFECHA .AND. CODTAR = WCODTAR .AND. RECNO() > WPOS10}, ;
                  NIL, NIL, NIL, .F.)

         ELSE

            __DBLOCATE({||NUMORD = WNUMORD .AND. CODOPE = WOPE .AND. FECHA ;
                  = WFECHA .AND. CODTAR = WCODTAR .AND. WCODPRO = CODPRO ;
                  .AND. RECNO() > WPOS10}, NIL, NIL, NIL, .F.)

         ENDIF

         IF EOF()

            DBCLOSEARE()
            EXIT

         ENDIF

         MEMVAR->WPOS10 := RECNO()
         MEMVAR->WPAGO := PAGO
         MEMVAR->WCODPRO := CODPRO

         IF WCODTAR = "PA" .OR. WCODTAR = "PC" .OR. WCODTAR = "GC" .OR. ;
               WCODTAR = "GP"

            MEMVAR->WTEMA := "el tiempo "
            MEMVAR->WSUME := MINUTOS

         ELSE

            MEMVAR->WTEMA := "las unidades "
            MEMVAR->WSUME := BUENAS

         ENDIF

         DBCLOSEARE()
         MEMVAR->WOPEN := WOPE
         MEMVAR->WFECHAN := WFECHA
         SETCOLOR("+GR")
         DEVPOS(11, 15)
         DEVOUT("CODIGO DEL OPERARIO ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WOPEN", NIL, NIL, NIL):DISPLAY())
         DEVPOS(12, 15)
         DEVOUT("FECHA DEL PAGO      ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WFECHAN", NIL, NIL, NIL):DISPLAY())
         SETCOLOR("+W")
         DEVPOS(15, 15)
         DEVOUT("VALOR PAGO          " + TRANSFORM(WPAGO, "999,999.99"))
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         ESPERE()
         AMAPERS()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\COD-PER")
         DBSEEK("&WOPE")

         IF EOF()

            DBCLOSEARE()
            DEVPOS(11, 42)
            DEVOUT("OPERARIO INVALIDO ")
            MEMVAR->X := INKEY(0)
            LOOP

         ENDIF

         DBCLOSEARE()

         IF (WCODPRO <> "6030  " .OR. WCODPRO = "6030  ") .AND. WOPE <> ;
               WOPEN

            MEMVAR->WLETORD := LTRIM(TRANSFORM(WNUMORD, "99999999"))
            MEMVAR->WLONORD := LEN(WLETORD)
            MEMVAR->WLETORD := WLETORD + SPACE(8 - WLONORD)
            MEMVAR->WKEY1 := WCODTAR + WLETORD
            MEMVAR->WKEY1N := WCODTAR + WLETORD
            ADEMASE()
            DBCLOSEARE()
            ADEMASS()
            DBSEEK("&WKEY1")
            MEMVAR->WMAXIMO := 0

            IF  .NOT. EOF()

               MEMVAR->WMAXIMO := MAXIMO

            ENDIF

            DBSEEK("&WKEY1N")

            IF  .NOT. EOF()

               IF PAGADAS + WSUME > MAXIMO

                  MEMVAR->WCONT := PAGADAS + WSUME
                  DBCLOSEARE()
                  MEMVAR->WCONF := " "
                  PIDECONF()

                  IF WCONF <> "S"

                     MEMVAR->OPC := " "
                     LOOP

                  ENDIF

               ENDIF

               DBCLOSEARE()
               ADEMASS()
               DBSEEK("&WKEY1N")
               VEALOCK()
               FIELD->PAGADAS := PAGADAS + WSUME

            ELSE

               ADEMASS()
               DBAPPEND()
               FIELD->CODOPE := WOPEN
               FIELD->CODPRO := WCODPRO
               FIELD->CODTAR := WCODTAR
               FIELD->LETORD := WLETORD
               FIELD->NUMORD := WNUMORD
               FIELD->PAGADAS := WSUME
               FIELD->MAXIMO := WMAXIMO
               FIELD->CODUSU := WCODUSU
               FIELD->HORA := TIME()
               DBCOMMITAL()

            ENDIF

            DBSEEK("&WKEY1")

            IF  .NOT. EOF()

               VEALOCK()
               FIELD->PAGADAS := PAGADAS - WSUME

            ENDIF

            DBCLOSEARE()

         ENDIF

         APAGAS()
         DBGOTO(WPOS10)
         VEALOCK()
         FIELD->CODOPE := WOPEN
         FIELD->FECHA := WFECHAN
         FIELD->CODUSU := WCODUSU
         FIELD->HORA := TIME()
         DBCLOSEARE()
         AMOPAS()

         IF WNUMORD <> 999

            __DBLOCATE({||NUMORD = WNUMORD .AND. CODOPE = WOPE .AND. FECHA ;
                  = WFECHA .AND. CODTAR = WCODTAR .AND. RECNO() > WPOS11}, ;
                  NIL, NIL, NIL, .F.)

         ELSE

            __DBLOCATE({||NUMORD = WNUMORD .AND. CODOPE = WOPE .AND. FECHA ;
                  = WFECHA .AND. CODTAR = WCODTAR .AND. CODPRO = WCODPRO ;
                  .AND. RECNO() > WPOS11}, NIL, NIL, NIL, .F.)

         ENDIF

         IF  .NOT. EOF()

            VEALOCK()
            FIELD->CODOPE := WOPEN
            FIELD->NUMOPE := VAL(WOPEN)
            FIELD->FECHA := WFECHAN
            FIELD->CODUSU := WCODUSU
            FIELD->HORA := TIME()
            MEMVAR->WPOS11 := RECNO()

         ENDIF

         DBCLOSEARE()

      ENDDO

   ENDDO

   CIERRE()
   MEMVAR->OPC := " "

RETURN 

