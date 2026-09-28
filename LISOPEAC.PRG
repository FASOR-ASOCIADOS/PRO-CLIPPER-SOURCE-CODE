/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LISOPEAC
   Params: None.
   Return: Undefined
  Example: LISOPEAC()
  ..........................................................................
*/

PROCEDURE LISOPEAC()

   MENU()
   ESPERE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   APAGAE()
   DBEVAL({||FIELD->NUMOPE := VAL(CODOPE)}, NIL, NIL, NIL, NIL, .F.)
   __DBSORT("C:\BASURA", {"NUMOPE", "FECHA", "NUMORD"}, NIL, NIL, NIL, NIL,;
          .F.)
   DBCLOSEARE()
   DBSELECTAR("10")
   DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
   AMAPERE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\COD-PER")
   ORDLISTREB()
   DBCLOSEARE()
   MEMVAR->OPC := " "
   DBSELECTAR("10")

   DO WHILE OPC <> "N"

      MENU()
      DEVPOS(4, 27)
      DEVOUT("<<  MANEJO  DE  TAREAS  >>")
      DEVPOS(5, 19)
      DEVOUT("LISTADO ACUMULADO DE TRABAJOS DE UN OPERARIO")
      MEMVAR->OPC := " "
      MEMVAR->WOPEI := MEMVAR->WOPEF := MEMVAR->WDIATRA := MEMVAR->WDIAPAG := ;
            0
      MEMVAR->WFECINI := MEMVAR->WFECFIN := DATE()
      DEVPOS(12, 20)
      DEVOUT("Desde que operario imprimo ?  ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WOPEI", "@# 99", NIL, NIL):DISPLAY())
      DEVPOS(13, 20)
      DEVOUT("hasta que operario imprimo ?  ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WOPEF", "@# 99", NIL, NIL):DISPLAY())
      DEVPOS(14, 20)
      DEVOUT("desde que fecha imprimo ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WFECINI", NIL, NIL, NIL):DISPLAY())
      DEVPOS(15, 20)
      DEVOUT("hasta que fecha imprimo ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WFECFIN", NIL, NIL, NIL):DISPLAY())
      DEVPOS(17, 5)
      DEVOUT("si escoge desde 1 hasta 99, genera archivo para nomina")
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WOPEI <> 1 .OR. WOPEF <> 99

         DEVPOS(16, 20)
         DEVOUT("Dias trabajados           ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WDIATRA", "@Z 99", NIL, NIL):DISPLAY())
         DEVPOS(17, 20)
         DEVOUT("Dias a pagar              ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WDIAPAG", "@Z 99", NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ENDIF

      IF WOPEI = 0

         MEMVAR->OPC := "N"
         LOOP

      ENDIF

      SETCOLOR("+GR")
      DEVPOS(18, 20)
      DEVOUT("ESTA TODO CORRECTO ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC <> "S"

         LOOP

      ENDIF

      SCROLL(12, 20, 18, 78)
      SETPOS(12, 20)
      ESPERE()
      SET(11, "OFF")
      DBEVAL({||DBDELETE()}, NIL, NIL, NIL, NIL, .F.)
      DBEVAL({||DBRECALL()}, {||NUMOPE > WOPEI - 1 .AND. NUMOPE < WOPEF + ;
            1}, NIL, NIL, NIL, .F.)
      DBEVAL({||DBDELETE()}, {||FECHA < WFECINI}, NIL, NIL, NIL, .F.)
      DBEVAL({||DBDELETE()}, {||FECHA > WFECFIN}, NIL, NIL, NIL, .F.)
      SET(11, "ON")
      DBGOTOP()
      MEMVAR->WOPE := " "

      DO WHILE  .NOT. EOF()

         IF WOPE <> CODOPE

            MEMVAR->WOPE := CODOPE
            AMAPERS()
            ORDLISTCLE()
            ORDLISTADD("&ZDIS\&WDIRECTO\COD-PER")
            DBSEEK("&WOPE")
            MEMVAR->WNOM := NOM
            MEMVAR->WAPE := APE
            DBCLOSEARE()
            MEMVAR->WDIATRA := MEMVAR->WDIAPAG := 0
            SCROLL(12, 1, 23, 78)
            SETPOS(12, 1)
            DISPBOX(20, 1, 23, 78, 2)
            DEVPOS(21, 2)
            DEVOUT(WOPE + " " + TRIM(WNOM) + " " + TRIM(WAPE))
            DEVPOS(22, 5)
            DEVOUT("dias trab ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WDIATRA", "@Z 999", NIL, NIL);
                  :DISPLAY())
            DEVPOS(22, 40)
            DEVOUT("Dias a pagar  ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WDIAPAG", "@Z 999", NIL, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

         ENDIF

         DBSELECTAR("10")
         FIELD->DIATRA := WDIATRA
         FIELD->DIAPAG := WDIAPAG
         DBSKIP(1)

      ENDDO

      MEMVAR->SWE := 0

      IF WOPEI = 1 .AND. WOPEF = 99

         MEMVAR->SWE := 1

         IF FILE("&ZDIS\&WDIRECTO\PAGAR1.DBF")

            FERASE("&ZDIS\&WDIRECTO\PAGAR1.DBF")

         ENDIF

         DBSELECTAR("4")
         DBCLOSEARE()
         DBSELECTAR("10")
         __DBCOPYST("&ZDIS\&WDIRECTO\PAGAR1", {})
         DBSELECTAR("4")
         DBUSEAREA(.F., NIL, "PAGAR1", NIL, NIL, .F.)

      ENDIF

      MEMVAR->OPC := " "
      DBSELECTAR("10")
      DBGOTOP()
      PIDEIMP()
      SETCOLOR("*G")
      DEVPOS(12, 20)
      DEVOUT("**  IMPRIMIENDO **")
      SETCOLOR("+W")
      MEMVAR->CL := MEMVAR->CP := MEMVAR->WTOTPAG := MEMVAR->WTOTMIN := 0
      MEMVAR->WOPEE := MEMVAR->WOPE := CODOPE
      MEMVAR->OPC := " "
      MEMVAR->RAYA := REPLICATE("Ä", 80)
      ENIM()
      SET(3, 2)

      DO WHILE  .NOT. EOF()

         IF CL = 0

            MEMVAR->WNOM := MEMVAR->WAPE := SPACE(20)
            AMAPERS()
            ORDLISTCLE()
            ORDLISTADD("&ZDIS\&WDIRECTO\COD-PER")
            DBSEEK("&WOPE")

            IF  .NOT. EOF()

               MEMVAR->WNOM := NOM
               MEMVAR->WAPE := APE

            ENDIF

            DBCLOSEARE()
            DBSELECTAR("10")
            MEMVAR->CP := MEMVAR->CP + 1
            DEVPOS(CL, 30)
            DEVOUT(RAZON)
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 30)
            DEVOUT("SISTEMA DE PRODUCCION")
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 2)
            DEVOUT("ACUMULADO DE PAGOS DEL MES PARA ")
            DEVPOS(CL, 35)
            DEVOUT(WOPE + " " + TRIM(WNOM) + " " + TRIM(WAPE))
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 1)
            DEVOUT("FECHA DEL INFORME ")
            DEVPOS(CL, 20)
            DEVOUT(DATE())
            DEVPOS(CL, 60)
            DEVOUT("PAGINA : " + ALLTRIM(TRANSFORM(CP, "99")))
            MEMVAR->CL := MEMVAR->CL + 2
            DEVPOS(CL, 0)
            DEVOUT("CO")
            DEVPOS(CL, 3)
            DEVOUT(CHR(15)+" FECHA O.P. P.T."+CHR(18)+" ")
            DEVPOS(CL, 18)
            DEVOUT(;
                  "LABOR  PROM. PAGO   MIN. BUE.  MAL.  PRUE.   TOT. C/INI. C/FIN";
                  )
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 0)
            DEVOUT(RAYA)
            MEMVAR->CL := MEMVAR->CL + 1

         ENDIF

         DEVPOS(CL, 0)
         DEVOUT(CODOPE)
         DEVPOS(CL, 3)
         DEVOUT(CHR(15)+" ")
         DEVPOS(CL, PCOL())
         DEVOUT(FECHA)
         DEVPOS(CL, PCOL())
         DEVOUT(" " + ALLTRIM(TRANSFORM(NUMORD, "999999")) + " " + CODPRO +;
                CHR(18) + " ")
         DEVPOS(CL, 19)
         DEVOUT(CODTAR)
         DEVPOS(CL, 25)
         DEVOUTPICT(UNIDADESH, "@# 9999")
         DEVPOS(CL, 31)
         DEVOUTPICT(PAGO, "@# $$$,$$$")
         DEVPOS(CL, 38)
         DEVOUTPICT(MINUTOS, "@# 99999")
         DEVPOS(CL, 43)
         DEVOUTPICT(BUENAS, "@# 9999")
         DEVPOS(CL, 49)
         DEVOUTPICT(MALAS, "@# 9999")
         DEVPOS(CL, 55)
         DEVOUTPICT(PRUEBAS, "@# 9999")
         DEVPOS(CL, 62)
         DEVOUTPICT(TOTAL, "@# 9999")
         DEVPOS(CL, 67)
         DEVOUTPICT(CONINI, "@# 999999")
         DEVPOS(CL, 74)
         DEVOUTPICT(CONFIN, "@# 999999")
         MEMVAR->WTOTPAG := WTOTPAG + INT(PAGO)
         MEMVAR->WTOTMIN := WTOTMIN + MINUTOS
         MEMVAR->WDIATRA := DIATRA
         MEMVAR->WDIAPAG := DIAPAG
         DBSKIP(1)

         IF CODOPE <> WOPE .OR. EOF()

            IF  .NOT. EOF()

               MEMVAR->WOPE := CODOPE
               MEMVAR->CP := 0

            ENDIF

            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 0)
            DEVOUT(RAYA)
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 1)
            DEVOUT("** TOTALES ")
            DEVPOS(CL, 31)
            DEVOUTPICT(WTOTPAG, "@# $99,999")
            DEVPOS(CL, 38)
            DEVOUTPICT(WTOTMIN, "@# 99999")
            MEMVAR->WVALDIA := WTOTPAG / WDIATRA
            MEMVAR->WNUEPAG := INT(WVALDIA * WDIAPAG)
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 1)
            DEVOUT("DIAS TRABAJADOS: ")
            DEVPOS(CL, PCOL())
            DEVOUT(ALLTRIM(TRANSFORM(WDIATRA, "99")) + " DIAS A PAGAR: " + ;
                  ALLTRIM(TRANSFORM(WDIAPAG, "99")) + " VR DIA: $" + ;
                  ALLTRIM(TRANSFORM(WVALDIA, "999,999")) + ;
                  " VR A PAGAR: $" + ALLTRIM(TRANSFORM(WNUEPAG, "9999,999");
                  ) + " HORAS: " + ALLTRIM(TRANSFORM(ROUND(WTOTMIN / 60, 0);
                  , "9999")))

            IF SWE = 1

               DBSELECTAR("4")
               DBAPPEND()
               FIELD->CODOPE := WOPEE
               FIELD->DIATRA := WDIATRA
               FIELD->DIAPAG := WDIAPAG
               FIELD->PAGO := WNUEPAG
               FIELD->MINUTOS := WTOTMIN

            ENDIF

            DBSELECTAR("10")

            IF  .NOT. EOF()

               MEMVAR->WOPEE := CODOPE

            ENDIF

            MEMVAR->WTOTPAG := MEMVAR->WTOTMIN := 0
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 1)
            DEVOUT(" ")
            MEMVAR->CL := 0

         ELSE

            MEMVAR->CL := MEMVAR->CL + 1

            IF CL > 57

               MEMVAR->CL := 0

            ENDIF

         ENDIF

      ENDDO

      APIM()
      DEVPOS(12, 20)
      DEVOUT("TIENE MAS PARA IMPRIMIR ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      SET(11, "OFF")
      DBEVAL({||DBRECALL()}, NIL, NIL, NIL, NIL, .F.)

   ENDDO

   DBSELECTAR("10")
   DBCLOSEARE()
   CIERRE()
   MEMVAR->WAB := "FILETEMP.DBF"
   BA()
   MEMVAR->OPC := " "

RETURN 

