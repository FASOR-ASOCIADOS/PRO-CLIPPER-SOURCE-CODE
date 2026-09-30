/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: CONSTIEC
   Params: None.
   Return: Undefined
  Example: CONSTIEC()
  ..........................................................................
*/

PROCEDURE CONSTIEC()

   MENU()
   ESPERE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   APAGAE()
   DBEVAL({||FIELD->NUMOPE := VAL(CODOPE)}, NIL, NIL, NIL, NIL, .F.)
   __DBSORT("C:\PROTMP\BASURA", {"NUMOPE", "FECHA", "NUMORD", "CODTAR"}, NIL, NIL,;
          NIL, NIL, .F.)
   DBCLOSEARE()
   DBSELECTAR("10")
   DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)
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
      DEVOUT("LISTADO COMPARATIVO DE TIEMPOS POR LABOR")
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
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

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
      MEMVAR->SWE := 0
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
      MEMVAR->RAYA := REPLICATE("Ä", 78)
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
            DEVOUT("COMPARATIVO DE TIEMPOS POR LABOR PARA " + WOPE + " " + ;
                  ALLTRIM(WNOM) + " " + ALLTRIM(WAPE))
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 1)
            DEVOUT("FECHA DEL INFORME ")
            DEVPOS(CL, 20)
            DEVOUT(DATE())
            DEVPOS(CL, 60)
            DEVOUT("PAGINA : " + ALLTRIM(TRANSFORM(CP, "99")))
            MEMVAR->CL := MEMVAR->CL + 2
            DEVPOS(CL, 0)
            DEVOUT("CD")
            DEVPOS(CL, 3)
            DEVOUT(CHR(15)+" FECHA O.P.  #OP. COD."+CHR(18)+" ")
            DEVPOS(CL, 17)
            DEVOUT("COD. PROM. PROM.  % DE  PAGO   MIN. CAN.  MAL+  TOT.")
            ++MEMVAR->CL
            DEVPOS(CL, 0)
            DEVOUT("op")
            DEVPOS(CL, 3)
            DEVOUT(CHR(15)+"                  P.T."+CHR(18)+" ")
            DEVPOS(CL, 16)
            DEVOUT("LABOR STD. en OP. LOGRO              BUE.  PRUE.     ")
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 0)
            DEVOUT(RAYA)
            MEMVAR->CL := MEMVAR->CL + 1

         ENDIF

         MEMVAR->WPROH := BUENAS * 60 / MINUTOS
         MEMVAR->WLOGRO := IF(UNIDADESH <> 0, WPROH * 100 / UNIDADESH, 0)
         DEVPOS(CL, 0)
         DEVOUT(CODOPE)
         DEVPOS(CL, 3)
         DEVOUT(CHR(15)+" ")
         DEVPOS(CL, PCOL())
         DEVOUT(FECHA)
         DEVPOS(CL, PCOL())
         DEVOUT(" " + ALLTRIM(TRANSFORM(NUMORD, "999999")) + " " + CODPRO +;
                CHR(18) + " ")
         DEVPOS(CL, 17)
         DEVOUT(CODTAR + "   ")
         DEVPOS(CL, PCOL())
         DEVOUT(TRANSFORM(UNIDADESH, "9999") + " " + TRANSFORM(WPROH, ;
               "99999") + " " + TRANSFORM(WLOGRO, "999.9") + "% ")
         DEVPOS(CL, PCOL())
         DEVOUTPICT(PAGO, "@# $$$,$$$")
         DEVPOS(CL, PCOL())
         DEVOUT(TRANSFORM(MINUTOS, "99999") + " " + TRANSFORM(BUENAS, ;
               "9999") + " ")
         DEVPOS(CL, PCOL())
         DEVOUT(TRANSFORM(MALAS + PRUEBAS, "9999") + " " + TRANSFORM(TOTAL,;
                "9999"))
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
            DEVPOS(CL, 40)
            DEVOUTPICT(WTOTPAG, "@# $99,999")
            DEVPOS(CL, 47)
            DEVOUTPICT(WTOTMIN, "@# 99999")
            MEMVAR->WVALDIA := WTOTPAG / WDIATRA
            MEMVAR->WNUEPAG := INT(WVALDIA * WDIAPAG)
            MEMVAR->CL := MEMVAR->CL + 1
            DBSELECTAR("10")

            IF  .NOT. EOF()

               MEMVAR->WOPEE := CODOPE

            ENDIF

            MEMVAR->WTOTPAG := MEMVAR->WTOTMIN := 0
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

