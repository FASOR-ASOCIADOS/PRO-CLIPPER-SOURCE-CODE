/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LISOPEDI
   Params: None.
   Return: Undefined
  Example: LISOPEDI()
  ..........................................................................
*/

PROCEDURE LISOPEDI()

   ESPERE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   __COPYFILE("&ZDIS\&WDIRECTO\PAGOSMO.DBF", "C:\PROTMP\BASURA.DBF")
   DBSELECTAR("9")
   DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, .F., .F.)
   AMAPERE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\COD-PER")
   ORDLISTREB()
   DBCLOSEARE()
   MENU()
   DEVPOS(5, 27)
   DEVOUT("<<  MANEJO  DE  TAREAS  >>")
   DEVPOS(7, 20)
   DEVOUT("LISTADO DIARIO DE TRABAJOS DE UN OPERARIO")
   MEMVAR->LINEA := REPLICATE("ß", 41)
   SETCOLOR("+GR")
   DEVPOS(8, 20)
   DEVOUT(LINEA)
   SETCOLOR("G")
   MEMVAR->OPC := " "
   DBSELECTAR("9")
   SET(11, "OFF")
   DBEVAL({||DBRECALL()}, NIL, NIL, NIL, NIL, .F.)

   DO WHILE OPC <> "N"

      SCROLL(8, 1, 23, 78)
      MEMVAR->OPC := ( SETPOS(8, 1), " " )
      MEMVAR->WOPE := "  "
      DEVPOS(12, 20)
      DEVOUT("Codigo del operario a imprimir ?  ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WOPE", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WOPE = "  "

         MEMVAR->OPC := "N"
         LOOP

      ENDIF

      __DBLOCATE({||CODOPE = WOPE}, NIL, NIL, NIL, .F.)

      IF EOF()

         DEVPOS(13, 20)
         DEVOUT("NO TIENE PAGOS ")
         MEMVAR->X := INKEY(0)
         LOOP

      ENDIF

      AMAPERS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\COD-PER")
      DBSEEK("&WOPE")

      IF EOF()

         MEMVAR->WNOM := MEMVAR->WAPE := SPACE(20)

      ELSE

         MEMVAR->WNOM := NOM
         MEMVAR->WAPE := APE

      ENDIF

      DBCLOSEARE()
      DBSELECTAR("9")
      DBEVAL({||DBDELETE()}, {||CODOPE <> WOPE}, NIL, NIL, NIL, .F.)
      SET(11, "ON")
      DBGOTOP()
      PIDEIMP()
      SETCOLOR("*G")
      DEVPOS(12, 20)
      DEVOUT("**  IMPRIMIENDO **")
      SETCOLOR("W")
      VEAIMP()
      ENIM()
      MEMVAR->CL := MEMVAR->WTOTPAG := MEMVAR->WTOTMIN := MEMVAR->CP := 0
      MEMVAR->OPC := " "
      MEMVAR->RAYA := REPLICATE("Ä", 80)

      DO WHILE  .NOT. EOF()

         IF CL = 0

            MEMVAR->CP := MEMVAR->CP + 1
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 30)
            DEVOUT(RAZON)
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 30)
            DEVOUT("SISTEMA DE PRODUCCION")
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 2)
            DEVOUT("RESUMEN DE PAGOS DEL DIA PARA ")
            DEVPOS(CL, 33)
            DEVOUT(WOPE + " " + TRIM(WNOM) + " " + TRIM(WAPE))
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 1)
            DEVOUT("FECHA DEL INFORME " + DTOC(DATE()))
            MEMVAR->WT1 := "PAGINA : " + ALLTRIM(TRANSFORM(CP, "99"))
            DEVPOS(CL, 80 - LEN(WT1))
            DEVOUT(WT1)
            MEMVAR->CL := MEMVAR->CL + 2
            DEVPOS(CL, 1)
            DEVOUT(;
                  "CO  FECHA  O.P.  LABOR  PROM. PAGO   MIN. BUE.  MAL.  PRUE.   TOT. C/INI. C/FIN";
                  )
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 0)
            DEVOUT(RAYA)
            MEMVAR->CL := MEMVAR->CL + 1

         ENDIF

         DEVPOS(CL, 1)
         DEVOUT(CODOPE)
         DEVPOS(CL, 4)
         DEVOUT(CHR(15)+" ")
         DEVPOS(CL, PCOL())
         DEVOUT(FECHA)
         DEVPOS(CL, PCOL())
         DEVOUT(" " + ALLTRIM(TRANSFORM(NUMORD, "999999")) + " " + ALLTRIM(;
               CODPRO) + CHR(18) + " ")
         DEVPOS(CL, 19)
         DEVOUT(CODTAR)
         DEVPOS(CL, 25)
         DEVOUTPICT(UNIDADESH, "@# 9999")
         DEVPOS(CL, 30)
         DEVOUTPICT(PAGO, "@# $$$,$$$")
         DEVPOS(CL, 37)
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
         MEMVAR->WTOTPAG := WTOTPAG + PAGO
         MEMVAR->WTOTMIN := WTOTMIN + MINUTOS
         DBSKIP(1)
         MEMVAR->CL := MEMVAR->CL + 1

         IF CL > 60

            MEMVAR->CL := 0
            DEVPOS(CL, 1)
            DEVOUT(" ")

         ENDIF

      ENDDO

      MEMVAR->CL := MEMVAR->CL + 1
      DEVPOS(CL, 0)
      DEVOUT(RAYA)
      MEMVAR->CL := MEMVAR->CL + 1
      DEVPOS(CL, 1)
      DEVOUT("** TOTALES ")
      DEVPOS(CL, 29)
      DEVOUTPICT(WTOTPAG, "@# $999,999")
      DEVPOS(CL, 37)
      DEVOUTPICT(WTOTMIN, "@# 99,999")
      MEMVAR->CL := MEMVAR->CL + 1
      DEVPOS(CL, 1)
      DEVOUT(" ")
      MEMVAR->CL := 0
      DEVPOS(CL, 1)
      DEVOUT(" ")
      APIM()
      SET(11, "OFF")
      DBEVAL({||DBRECALL()}, NIL, NIL, NIL, NIL, .F.)
      DEVPOS(12, 20)
      DEVOUT("TIENE MAS PARA IMPRIMIR ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

   ENDDO

   CIERRE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->OPC := " "

RETURN 

