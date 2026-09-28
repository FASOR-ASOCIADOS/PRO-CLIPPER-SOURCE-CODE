/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: CONSUPAG
   Params: None.
   Return: Undefined
  Example: CONSUPAG()
  ..........................................................................
*/

PROCEDURE CONSUPAG()

   MENU()
   DEVPOS(5, 1)
   DEVOUT(PADC("CONSULTA A LOS PAGOS DE LABORES", 78))
   MEMVAR->WPER := "D"
   MEMVAR->WTODTAR := MEMVAR->WORD := MEMVAR->WSAL := " "
   MEMVAR->WCODTAR := "  "
   MEMVAR->WOPEI := MEMVAR->WOPEF := MEMVAR->WOPD := MEMVAR->WOPH := 0
   MEMVAR->WFECINI := MEMVAR->WFECFIN := DATE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   APAGAE()
   AMAPERE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\COD-PER")
   ORDLISTREB()
   DBCLOSEARE()
   MEMVAR->OPC := " "

   DO WHILE OPC <> "*"

      SCROLL(8, 1, 23, 78)
      MEMVAR->OPC := ( SETPOS(8, 1), " " )
      DEVPOS(10, 15)
      DEVOUT("Desde la O.P. # ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WOPD", "@Z 9999999", NIL, NIL):DISPLAY())
      DEVPOS(11, 15)
      DEVOUT("Hasta la O.P. # ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WOPH", "@Z 9999999", NIL, NIL):DISPLAY())
      DEVPOS(12, 15)
      DEVOUT("Desde que operario  ?  ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WOPEI", "@# 99", NIL, NIL):DISPLAY())
      DEVPOS(13, 15)
      DEVOUT("hasta que operario  ?  ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WOPEF", "@# 99", NIL, NIL):DISPLAY())
      DEVPOS(14, 15)
      DEVOUT("desde que fecha  ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WFECINI", NIL, NIL, NIL):DISPLAY())
      DEVPOS(15, 15)
      DEVOUT("hasta que fecha  ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WFECFIN", NIL, NIL, NIL):DISPLAY())
      DEVPOS(16, 15)
      DEVOUT("<H>istorico, <D>iario, <M>ensual o <C>onsolidado ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WPER", "@!", {||WPER $ "DMCH"}, NIL);
            :DISPLAY())
      DEVPOS(17, 15)
      DEVOUT("<T>oda las tareas o <U>na sola ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WTODTAR", "@!", {||WTODTAR $ "TU"}, NIL);
            :DISPLAY())
      DEVPOS(18, 15)
      DEVOUT("Cual tarea ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCODTAR", "@!", NIL, {||WTODTAR = "U"});
            :DISPLAY())
      DEVPOS(19, 15)
      DEVOUT("Ordenado por <O>.P., <T>area, o<P>erario ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WORD", "@!", {||WORD $ "OTP"}, NIL);
            :DISPLAY())
      DEVPOS(20, 15)
      DEVOUT("Por <P>antalla o <I>mpresora ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WSAL", "@!", {||WSAL $ "PI"}, NIL):DISPLAY(;
            ))
      SETCOLOR("+G")
      DEVPOS(21, 20)
      DEVOUT("ESC para terminar")
      SETCOLOR("+W")
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      SCROLL(10, 15, 21, 78)
      SETPOS(10, 15)

      IF LASTKEY() = 27

         EXIT

      ENDIF

      MEMVAR->WAB := "BASURA.DBF"
      BA()
      MEMVAR->WAB := "BASURA1.DBF"
      BA()

      IF WPER = "H"

         MEMVAR->WTITPER := "ARCHIVO HISTORICO"
         AMOPAS()

      ELSEIF WPER = "D"

         MEMVAR->WTITPER := "ARCHIVO DIARIO"
         APAMOS()

      ELSEIF WPER = "M"

         MEMVAR->WTITPER := "ARCHIVO MENSUAL"
         APAGAS()

      ELSEIF WPER = "C"

         MEMVAR->WTITPER := "ARCHIVO CONSOLIDADO"

         IF WTODTAR = "T"

            APAGAS()
            __DBCOPYST("C:\BASURA", {})
            DBCLOSEARE()
            DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
            __DBAPP("&ZDIS\&WDIRECTO\PAGOSMO", {}, NIL, NIL, NIL, NIL, .F.,;
                   NIL)
            DBCOMMITAL()
            __DBAPP("&ZDIS\&WDIRECTO\MOVPAG", {}, NIL, NIL, NIL, NIL, .F., ;
                  NIL)
            DBCLOSEARE()

         ELSE

            APAGAS()
            __DBCOPYST("c:\basura", {})
            DBCLOSEARE()
            DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
            __DBAPP("&ZDIS\&WDIRECTO\PAGOSMO", {}, {||CODTAR = WCODTAR}, ;
                  NIL, NIL, NIL, .F., NIL)
            DBCOMMITAL()
            __DBAPP("&ZDIS\&WDIRECTO\MOVPAG", {}, {||CODTAR = WCODTAR}, ;
                  NIL, NIL, NIL, .F., NIL)
            DBCLOSEARE()

         ENDIF

         DBSELECTAR("10")
         DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)

      ENDIF

      IF WORD = "O"

         __DBSORT("C:\BASURA1", {"NUMORD", "NUMOPE", "CODTAR"}, NIL, NIL, ;
               NIL, NIL, .F.)
         MEMVAR->WCRI := "NUMORD"
         MEMVAR->WTITSOR := "O. P."

      ELSEIF WORD = "T"

         __DBSORT("C:\BASURA1", {"CODTAR", "NUMOPE", "NUMORD"}, NIL, NIL, ;
               NIL, NIL, .F.)
         MEMVAR->WCRI := "CODTAR"
         MEMVAR->WTITSOR := "LABOR"

      ELSEIF WORD = "P"

         MEMVAR->WCRI := "NUMOPE"
         MEMVAR->WTITSOR := "OPERARIO"
         __DBSORT("C:\BASURA1", {"NUMOPE", "CODTAR", "NUMORD"}, NIL, NIL, ;
               NIL, NIL, .F.)

      ENDIF

      SET(11, "OFF")
      DBCLOSEARE()
      DBSELECTAR("10")
      DBUSEAREA(.F., NIL, "C:\BASURA1", NIL, NIL, .F.)
      DBEVAL({||DBRECALL()}, NIL, NIL, NIL, NIL, .F.)
      DBEVAL({||FIELD->NUMOPE := VAL(CODOPE)}, NIL, NIL, NIL, NIL, .F.)
      DBEVAL({||DBDELETE()}, {||NUMORD < WOPD .OR. NUMORD > WOPH}, NIL, ;
            NIL, NIL, .F.)
      DBEVAL({||DBDELETE()}, {||NUMOPE < WOPEI .OR. NUMOPE > WOPEF}, NIL, ;
            NIL, NIL, .F.)
      DBEVAL({||DBDELETE()}, {||FECHA < WFECINI .OR. FECHA > WFECFIN}, NIL,;
             NIL, NIL, .F.)
      SET(11, "ON")
      MEMVAR->OPC := " "
      DBGOTOP()
      MEMVAR->RAYA := REPLICATE("Ä", 80)
      MEMVAR->CL := MEMVAR->CP := MEMVAR->WTOTPAG := MEMVAR->WTOTMIN := MEMVAR->;
            SWST := 0

      IF WSAL = "I"

         MEMVAR->WTOPE := 55
         PIDEIMP()
         SETCOLOR("*G")
         DEVPOS(12, 20)
         DEVOUT("**  IMPRIMIENDO **")
         SETCOLOR("W")
         VEAIMP()
         ENIM()

      ELSE

         MEMVAR->WTOPE := 22
         SCROLL()
         SETPOS(0, 0)
         READKILL(.T.)
         MEMVAR->GETLIST := {}

      ENDIF

      DO WHILE  .NOT. EOF()

         IF CL = 0

            SETCOLOR("+G")
            MEMVAR->SWST := 1
            DBSELECTAR("2")
            MEMVAR->CP := MEMVAR->CP + 1
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 30)
            DEVOUT(RAZON)
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 30)
            DEVOUT("SISTEMA DE PRODUCCION")
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 0)
            DEVOUT(PADC(WTITPER, 78))
            DEVPOS(CL, 1)
            DEVOUT("FECHA DEL INFORME " + DTOC(DATE()))
            DEVPOS(CL, 60)
            DEVOUT("PAGINA : " + ALLTRIM(TRANSFORM(CP, "99")))
            MEMVAR->CL := MEMVAR->CL + 2
            DEVPOS(CL, 0)
            DEVOUT(;
                  "CO FECHA      O.P.   P.T.   LB PROM.  PAGO   MIN.   BUENAS  MALAS PRUEBA  TOTAL";
                  )
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 0)
            DEVOUT(RAYA)
            MEMVAR->CL := MEMVAR->CL + 1
            SETCOLOR("+W")

         ENDIF

         IF SWST = 1

            MEMVAR->SWST := 0
            DBSELECTAR("10")
            MEMVAR->WCAMPO := (&(MEMVAR->WCRI))
            MEMVAR->WOPE := CODOPE
            MEMVAR->WNUMORD := NUMORD
            MEMVAR->WCODTAR := CODTAR

            IF WCRI = "NUMOPE"

               AMAPERS()
               ORDLISTCLE()
               ORDLISTADD("&ZDIS\&WDIRECTO\COD-PER")
               DBSEEK("&WOPE")

               IF EOF()

                  MEMVAR->WNOM := SPACE(20)
                  MEMVAR->WAPE := SPACE(20)

               ELSE

                  MEMVAR->WNOM := NOM
                  MEMVAR->WAPE := APE

               ENDIF

               DBCLOSEARE()
               SETCOLOR("+G")
               DEVPOS(CL, 2)
               DEVOUT("ACUMULADO DE PAGOS DEL MES PARA ")
               DEVPOS(CL, 35)
               DEVOUT(WOPE + " " + TRIM(WNOM) + " " + TRIM(WAPE))
               SETCOLOR("+W")
               MEMVAR->CL := MEMVAR->CL + 1

            ENDIF

            IF WCRI = "NUMORD"

               SETCOLOR("+G")
               DEVPOS(CL, 2)
               DEVOUT("ACUMULADO DE PAGOS DE LA O.P. " + TRANSFORM(WNUMORD,;
                      "999999"))
               SETCOLOR("+W")
               MEMVAR->CL := MEMVAR->CL + 1

            ENDIF

            IF WCRI = "CODTAR"

               SETCOLOR("+G")
               DEVPOS(CL, 2)
               DEVOUT("ACUMULADO DE PAGOS DE LA LABOR " + WCODTAR)
               SETCOLOR("+W")
               MEMVAR->CL := MEMVAR->CL + 1

            ENDIF

         ENDIF

         DBSELECTAR("10")
         MEMVAR->WL := CODOPE + " " + DTOC(FECHA) + " " + TRANSFORM(NUMORD, ;
               "999999") + " " + CODPRO + " " + CODTAR + " "
         MEMVAR->WL := WL + TRANSFORM(UNIDADESH, "9999") + " " + TRANSFORM(;
               PAGO, "$$$,$$$") + " " + TRANSFORM(MINUTOS, "99999") + " " +;
                TRANSFORM(BUENAS, "99,999") + " " + TRANSFORM(MALAS, ;
               "99,999") + " " + TRANSFORM(PRUEBAS, "99,999") + " " + ;
               TRANSFORM(TOTAL, "99,999")
         DEVPOS(CL, 0)
         DEVOUT(WL)
         MEMVAR->WTOTPAG := WTOTPAG + PAGO
         MEMVAR->WTOTMIN := WTOTMIN + MINUTOS
         DBSKIP(1)

         IF EOF() .OR. (&(MEMVAR->WCRI)) <> WCAMPO

            IF  .NOT. EOF()

               MEMVAR->WCAMPO := (&(MEMVAR->WCRI))
               MEMVAR->WOPE := CODOPE
               MEMVAR->SWST := 1

            ENDIF

            MEMVAR->CL := MEMVAR->CL + 1
            SETCOLOR("+G")
            DEVPOS(CL, 1)
            DEVOUT("** TOTALES ")
            DEVPOS(CL, 36)
            DEVOUTPICT(WTOTPAG, "@# $99,999")
            DEVPOS(CL, 43)
            DEVOUTPICT(WTOTMIN, "@# 99,999")
            SETCOLOR("+G")
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 0)
            DEVOUT(RAYA)
            MEMVAR->CL := MEMVAR->CL + 1
            MEMVAR->WTOTPAG := MEMVAR->WTOTMIN := 0
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 1)
            DEVOUT(" ")

         ELSE

            MEMVAR->CL := MEMVAR->CL + 1

            IF CL > WTOPE

               IF WSAL = "P"

                  SETCOLOR("+G")
                  DEVPOS(24, 20)
                  DEVOUT("Pulse alguna tecla, ESC para terminar ")
                  SETCOLOR("+W")
                  MEMVAR->X := INKEY(0)

                  IF LASTKEY() = 27 .OR. X = 27

                     SCROLL()
                     SETPOS(0, 0)
                     READKILL(.T.)
                     MEMVAR->GETLIST := {}
                     EXIT

                  ENDIF

                  SCROLL()
                  SETPOS(0, 0)
                  READKILL(.T.)
                  MEMVAR->GETLIST := {}

               ENDIF

               MEMVAR->CL := 0

            ENDIF

         ENDIF

      ENDDO

      DBSELECTAR("10")
      DBCLOSEARE()
      MEMVAR->WAB := "BASURA1.DBF"
      BA()

      IF WSAL = "I"

         APIM()

      ELSE

         SCROLL(24, 1, 24, 78)
         SETPOS(24, 1)
         DEVPOS(24, 10)
         DEVOUT("Lea y pulse alguna tecla")
         MEMVAR->X := INKEY(0)

      ENDIF

      MENU()
      DEVPOS(12, 20)
      DEVOUT("TIENE MAS PARA CONSULTAR ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "N" .OR. LASTKEY() = 27

         EXIT

      ENDIF

      SET(11, "OFF")

   ENDDO

   CIERRE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->OPC := " "

RETURN 

