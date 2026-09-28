/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LIORCOCL
   Params: None.
   Return: Undefined
  Example: LIORCOCL()
  ..........................................................................
*/

PROCEDURE LIORCOCL()

   MEMVAR->OPC := " "
   MENU()
   DEVPOS(12, 20)
   DEVOUT("En este momento obtendr" + A + " un listado de las")
   DEVPOS(13, 20)
   DEVOUT("ordenes de compra en orden de c" + O + "digo.")
   DEVPOS(14, 20)
   DEVOUT("Desea continuar ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC <> "S" .OR. LASTKEY() = 27

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   ESPERE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   AOCS()
   __DBSORT("C:\BASURA", {"NUMINS", "FECEMI"}, NIL, NIL, NIL, NIL, .F.)
   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
   SCROLL(6, 1, 23, 78)
   MEMVAR->WCODNUMI := ( SETPOS(6, 1), NUMINS )
   DBGOBOTTOM()
   MEMVAR->WCODNUMT := NUMINS
   DEVPOS(12, 20)
   DEVOUT("Desde que c" + O + "digo ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WCODNUMI", "@Z 999999", NIL, NIL):DISPLAY())
   DEVPOS(13, 20)
   DEVOUT("Hasta que c" + O + "digo ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WCODNUMT", "@Z 999999", NIL, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF WCODNUMI = 0 .OR. LASTKEY() = 27

      MEMVAR->OPC := " "
      DBCLOSEARE()
      MEMVAR->WAB := "BASURA.DBF"
      BA()
      RETURN 

   ENDIF

   ESPERE()
   MEMVAR->OPC := " "
   SET(11, "OFF")
   DBEVAL({||DBRECALL()}, NIL, NIL, NIL, NIL, .F.)
   DBEVAL({||DBDELETE()}, {||NUMINS < WCODNUMI .OR. NUMINS > WCODNUMT}, ;
         NIL, NIL, NIL, .F.)
   __DBPACK()
   DBGOTOP()
   PIDEIMP()
   __RUN("MODE LPT1:132")
   __RUN("MODE LPT1:132")
   MEMVAR->CP := MEMVAR->CL := 0
   ENIM0()
   QOUT(CHR(27)+CHR(15)+" ")
   QQOUT(" ")
   MEMVAR->WFECHA := DATE()
   MEMVAR->WMESL := ""
   FECHA()

   DO WHILE  .NOT. EOF()

      MEMVAR->CP := MEMVAR->CP + 1

      IF CL = 0

         QOUT(SPACE(50) + RAZON)
         QOUT(" ")
         QOUT(" ")
         QOUT(SPACE(50) + "SISTEMA DE PRODUCCION")
         QOUT(SPACE(33) + ;
               "RELACION DE ORDENES DE COMPRA EN ORDEN DE CODIGO DE INSUMO";
               )
         QOUT(" ")
         QOUT("LISTADO A : " + ALLTRIM(TRANSFORM(DAY(DATE()), "99")) + ;
               " DE " + WMESL + " DE " + ALLTRIM(TRANSFORM(YEAR(DATE()), ;
               "9999")) + SPACE(71) + "PAGINA Nro. " + LTRIM(STR(CP)))
         MEMVAR->WLINEA := REPLICATE("Ä", 132)
         QOUT(WLINEA)
         QOUT(;
               "C-PROV NOMBRE ESTABLECIMIENTO         INS.  CANTIDAD   CANTIDAD   VALOR        VALOR  NUMERO    FECHA  ORDENADO          CONS. ";
               )
         QOUT(;
               "                                            PEDIDA     ENTREGADA  UNITARIO     TOTAL  DE ORDEN  ORDEN  POR                     ";
               )
         QOUT(WLINEA)
         QOUT(" ")
         MEMVAR->CL := 12

      ENDIF

      QOUT(CODPROV + "  " + NOMEST + " " + CODINS + " ")
      QQOUT(CANPED)
      QQOUT(CANENT)
      QQOUT(VRUNIT)
      QQOUT(VALTOT)
      QQOUT(" ")
      QQOUT(ORD + " " + DTOC(FECEMI) + " " + ORDPOR + ALLTRIM(TRANSFORM(;
            CONSE, "999")))
      MEMVAR->CL := MEMVAR->CL + 1

      IF CL = 59

         __EJECT()
         MEMVAR->CL := 0

      ENDIF

      DBSKIP(1)

   ENDDO

   QOUT(CHR(27)+CHR(18))
   __EJECT()
   APIM0()
   DBCLOSEARE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->OPC := " "

RETURN 

