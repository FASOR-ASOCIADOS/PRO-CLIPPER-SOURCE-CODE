/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LISOPERE
   Params: None.
   Return: Undefined
  Example: LISOPERE()
  ..........................................................................
*/

PROCEDURE LISOPERE()

   MENU()
   DEVPOS(5, 27)
   DEVOUT("<<  MANEJO  DE  TAREAS  >>")
   DEVPOS(7, 19)
   DEVOUT("LISTADO ACUMULADO DE TRABAJOS DE UN OPERARIO O DE UNA ORDEN")
   MEMVAR->LINEA := REPLICATE("ß", 41)
   SETCOLOR("+GR")
   DEVPOS(8, 20)
   DEVOUT(LINEA)
   SETCOLOR("G")
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->WAB := "BASURA1.DBF"
   BA()
   APAGAE()
   __DBCOPYST("C:\PROTMP\BASURA", {})
   DBCLOSEARE()
   DBSELECTAR("10")
   DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)
   __DBAPP("&ZDIS\&WDIRECTO\PAGOSMO", {}, NIL, NIL, NIL, NIL, .F., NIL)
   __DBAPP("&ZDIS\&WDIRECTO\PAGAR", {}, NIL, NIL, NIL, NIL, .F., NIL)
   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)
   DBEVAL({||FIELD->NUMOPE := VAL(CODOPE)}, NIL, NIL, NIL, NIL, .F.)
   DBCLOSEARE()
   AMAPERE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\COD-PER")
   ORDLISTREB()
   DBCLOSEARE()
   MEMVAR->OPC := " "
   DBSELECTAR("10")

   DO WHILE OPC <> "*"

      SCROLL(8, 1, 23, 78)
      MEMVAR->WOPEI := MEMVAR->WOPEF := MEMVAR->WOPI := MEMVAR->WOPF := ( ;
            SETPOS(8, 1), 0 )
      MEMVAR->OPC := MEMVAR->WORD := " "
      MEMVAR->WFECINI := MEMVAR->WFECFIN := DATE()
      SETCOLOR("+W")
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
      DEVPOS(16, 20)
      DEVOUT("desde que Numero de O.P.? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "Wopi", "@Z 999999", NIL, NIL):DISPLAY())
      DEVPOS(17, 20)
      DEVOUT("hasta que numero de O.P.? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WOPF", "@Z 999999", NIL, NIL):DISPLAY())
      DEVPOS(18, 20)
      DEVOUT("En orden de <N>umero de O.P. o <C>odigo operario ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WORD", "@!", {||WORD $ "NC"}, NIL):DISPLAY(;
            ))
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      SCROLL(12, 20, 18, 78)
      SETPOS(12, 20)

      IF WOPEI = 0

         MEMVAR->OPC := "*"
         LOOP

      ENDIF

      MEMVAR->WAB := "BASURA1.DBF"
      BA()
      DBSELECTAR("10")
      DBCLOSEARE()
      DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)

      IF WORD = "C"

         __DBSORT("C:\PROTMP\BASURA1", {"NUMOPE", "NUMORD", "CODTAR", "PAGO", ;
               "FECHA"}, NIL, NIL, NIL, NIL, .F.)
         MEMVAR->WCRI := "NUMOPE"
         MEMVAR->WPT := "CODIGO DE OPERARIO"
         MEMVAR->WCRIA := "NUMORD"

      ELSE

         __DBSORT("C:\PROTMP\BASURA1", {"NUMORD", "NUMOPE", "CODTAR", "PAGO", ;
               "FECHA"}, NIL, NIL, NIL, NIL, .F.)
         MEMVAR->WCRI := "NUMORD"
         MEMVAR->WPT := "NUMERO DE OREN DE PRODUCCION"
         MEMVAR->WCRIA := "NUMOPE"

      ENDIF

      DBCLOSEARE()
      DBSELECTAR("10")
      DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA1", NIL, NIL, .F.)
      SET(11, "OFF")
      DBEVAL({||DBDELETE()}, NIL, NIL, NIL, NIL, .F.)
      DBEVAL({||DBRECALL()}, {||NUMOPE > WOPEI - 1 .AND. NUMOPE < WOPEF + ;
            1}, NIL, NIL, NIL, .F.)
      DBEVAL({||DBDELETE()}, {||FECHA < WFECINI}, NIL, NIL, NIL, .F.)
      DBEVAL({||DBDELETE()}, {||FECHA > WFECFIN}, NIL, NIL, NIL, .F.)
      DBEVAL({||DBDELETE()}, {||NUMORD < WOPI}, NIL, NIL, NIL, .F.)
      DBEVAL({||DBDELETE()}, {||NUMORD > WOPF}, NIL, NIL, NIL, .F.)
      SET(11, "ON")
      MEMVAR->OPC := " "
      DBGOTOP()
      PIDEIMP()
      SETCOLOR("*G")
      DEVPOS(12, 20)
      DEVOUT("**  IMPRIMIENDO **")
      SETCOLOR("W")
      MEMVAR->CL := MEMVAR->CP := MEMVAR->WTOTPAG := MEMVAR->WTOTMIN := MEMVAR->;
            SWST := 0
      MEMVAR->OPC := " "
      MEMVAR->RAYA := REPLICATE("Ä", 80)
      VEAIMP()
      ENIM()

      DO WHILE  .NOT. EOF()

         IF CL = 0

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
            DEVPOS(CL, 20)
            DEVOUT("PAGOS DE LABORES ORDENADOS POR " + WPT)
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 1)
            DEVOUT("FECHA DEL INFORME " + DTOC(DATE()))
            DEVPOS(CL, 60)
            DEVOUT("PAGINA : " + ALLTRIM(TRANSFORM(CP, "99")))
            MEMVAR->CL := MEMVAR->CL + 2

            IF WORD = "N"

               DEVPOS(CL, 0)
               DEVOUT(CHR(15)+"  FECHA      OPER. P.T. LABOR PROM. "+CHR(;
                     18)+" ")

            ELSE

               DEVPOS(CL, 0)
               DEVOUT(CHR(15)+"  FECHA     #O.P. P.T. LABOR PROM. "+CHR(18);
                     +" ")

            ENDIF

            DEVPOS(CL, 24)
            DEVOUT("PAGO     MIN.  BUE.  MAL.  PRUE.   TOT. C/INI. C/FIN")
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 0)
            DEVOUT(RAYA)
            MEMVAR->CL := MEMVAR->CL + 1

         ENDIF

         IF SWST = 1

            MEMVAR->SWST := 0
            DBSELECTAR("10")
            MEMVAR->WOPE := CODOPE
            MEMVAR->WVALCRI := (&(MEMVAR->WCRI))
            AMAPERS()
            ORDLISTCLE()
            ORDLISTADD("&ZDIS\&WDIRECTO\COD-PER")
            DBSEEK("&WOPE")

            IF EOF()

               MEMVAR->WNOM := "NOMBRE NO ENCONTRADO"
               MEMVAR->WAPE := "APELL. NO ENCONTRADO"

            ELSE

               MEMVAR->WNOM := NOM
               MEMVAR->WAPE := APE

            ENDIF

            DBCLOSEARE()

            IF WORD = "C"

               DEVPOS(CL, 2)
               DEVOUT("ACUMULADO DE PAGOS DEL MES PARA ")
               DEVPOS(CL, 35)
               DEVOUT(TRANSFORM(WVALCRI, "99") + " " + TRIM(WNOM) + " " + ;
                     TRIM(WAPE))

            ELSE

               DEVPOS(CL, 2)
               DEVOUT("ACUMULADO DE PAGOS PARA LA ORDEN #")
               DEVPOS(CL, PCOL())
               DEVOUT(TRANSFORM(WVALCRI, "999999"))

            ENDIF

            MEMVAR->CL := MEMVAR->CL + 1

         ENDIF

         DBSELECTAR("10")
         MEMVAR->WVALCRIA := (&(MEMVAR->WCRIA))
         DEVPOS(CL, 0)
         DEVOUT(CHR(15)+" ")
         DEVPOS(CL, PCOL())
         DEVOUT(FECHA)
         DEVPOS(CL, PCOL())
         DEVOUT(" " + PADC(ALLTRIM(TRANSFORM(WVALCRIA, "999999")), 6) + ;
               " " + CODPRO + " " + CODTAR + " " + TRANSFORM(UNIDADESH, ;
               "9999") + CHR(18) + " ")
         DEVPOS(CL, 24)
         DEVOUTPICT(PAGO, "@# $$$,$$$")
         DEVPOS(CL, 32)
         DEVOUTPICT(MINUTOS, "@# 99999")
         DEVPOS(CL, 39)
         DEVOUTPICT(BUENAS, "@# 9999")
         DEVPOS(CL, 45)
         DEVOUTPICT(MALAS, "@# 9999")
         DEVPOS(CL, 51)
         DEVOUTPICT(PRUEBAS, "@# 9999")
         DEVPOS(CL, 58)
         DEVOUTPICT(TOTAL, "@# 9999")
         DEVPOS(CL, 63)
         DEVOUTPICT(CONINI, "@# 999999")
         DEVPOS(CL, 71)
         DEVOUTPICT(CONFIN, "@# 999999")
         MEMVAR->WTOTPAG := WTOTPAG + PAGO
         MEMVAR->WTOTMIN := WTOTMIN + MINUTOS
         DBSKIP(1)

         IF WVALCRI <> (&(MEMVAR->WCRI)) .OR. EOF()

            IF  .NOT. EOF()

               MEMVAR->WOPE := CODOPE
               MEMVAR->WVALCRI := (&(MEMVAR->WCRI))
               MEMVAR->WVALCRIA := (&(MEMVAR->WCRIA))
               MEMVAR->SWST := 1

            ENDIF

            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 1)
            DEVOUT("** TOTALES ")
            DEVPOS(CL, 24)
            DEVOUTPICT(WTOTPAG, "@# $99,999")
            DEVPOS(CL, 31)
            DEVOUTPICT(WTOTMIN, "@# 99,999")
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

            IF CL > 60

               MEMVAR->CL := 0
               DEVPOS(CL, 1)
               DEVOUT(" ")

            ENDIF

         ENDIF

      ENDDO

      APIM()
      DBSELECTAR("10")
      DBCLOSEARE()
      MEMVAR->WAB := "BASURA1.DBF"
      BA()
      DEVPOS(12, 20)
      DEVOUT("TIENE MAS PARA IMPRIMIR ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "N"

         MEMVAR->OPC := "*"

      ENDIF

   ENDDO

   CIERRE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->OPC := " "

RETURN 

