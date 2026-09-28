/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LIORCOGR
   Params: None.
   Return: Undefined
  Example: LIORCOGR()
  ..........................................................................
*/

PROCEDURE LIORCOGR()

   MEMVAR->OPC := "S"
   MENU()
   DEVPOS(12, 20)
   DEVOUT("En este momento obtendr" + A + " un listado de las")
   DEVPOS(13, 20)
   DEVOUT("ordenes de compra en orden de grabaci" + O + "n.")
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

   MEMVAR->WAB := "BASURA.DBF"
   BA()
   AOCS()
   __DBCOPY("C:\BASURA", {}, NIL, NIL, NIL, NIL, .F., NIL)
   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
   MENU()
   MEMVAR->WRECI := 1
   MEMVAR->WRECT := LASTREC()
   DEVPOS(12, 20)
   DEVOUT("Desde qu" + E + " registro ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WRECI", "@Z 9999", NIL, NIL):DISPLAY())
   DEVPOS(13, 20)
   DEVOUT("Hasta qu" + E + " registro ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WRECT", "@Z 9999", NIL, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF WRECI = 0 .OR. LASTKEY() = 27

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
   DBEVAL({||DBDELETE()}, {||RECNO() < WRECI .OR. RECNO() > WRECT}, NIL, ;
         NIL, NIL, .F.)
   SET(11, "ON")
   DBGOTOP()
   PIDEIMP()
   SET(31, "ON")
   __RUN("MODE LPT1:132")
   MEMVAR->WLONPAP := 134
   MENU()
   DEVPOS(12, 20)
   DEVOUT("IMPRIMIENDO")
   MEMVAR->CP := MEMVAR->CL := 0
   VEAIMP()
   ENIM()
   DEVPOS(PROW(), PCOL())
   DEVOUT(CHR(15)+" ")
   MEMVAR->WLINEA := REPLICATE("Ä", 132)

   DO WHILE  .NOT. EOF()

      IF CL = 0

         MEMVAR->CP := MEMVAR->CP + 1
         DEVPOS(CL, 1)
         DEVOUT(PADC(RAZON, WLONPAP))
         MEMVAR->CL := MEMVAR->CL + 2
         DEVPOS(CL, 1)
         DEVOUT(PADC("SISTEMA DE PRODUCCION", WLONPAP))
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 1)
         DEVOUT(PADC("RELACION DE ORDENES DE COMPRA EN ORDEN DE GRABACION",;
                WLONPAP))
         MEMVAR->CL := MEMVAR->CL + 2
         MEMVAR->WFECHA := DATE()
         MEMVAR->WDIA := ""
         FECHA()
         DEVPOS(CL, 1)
         DEVOUT("LISTADO A : " + WDIA)
         MEMVAR->WT1 := "PAGINA Nro. " + ALLTRIM(TRANSFORM(CP, "99"))
         DEVPOS(CL, WLONPAP - LEN(WT1))
         DEVOUT(WT1)
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 0)
         DEVOUT(WLINEA)
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 1)
         DEVOUT(;
               "C-PROV NOMBRE ESTABLECIMIENTO         INS.    CANTIDAD   CANTIDAD   VALOR        VALOR    NUMERO    FECHA  ORDENADO          CONS. ";
               )
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 1)
         DEVOUT(;
               "                                              PEDIDA     ENTREGADA  UNITARIO     TOTAL    DE ORDEN  ORDEN  POR                     ";
               )
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 1)
         DEVOUT(WLINEA)
         MEMVAR->CL := MEMVAR->CL + 1

      ENDIF

      DEVPOS(CL, 1)
      DEVOUT(CODPROV + " " + NOMEST + " " + CODINS + " " + NUMCOLOR + " " +;
             TRANSFORM(CANPED, "999,999.99") + " " + TRANSFORM(CANENT, ;
            "999,999.99") + " " + TRANSFORM(VRUNIT, "999,999.99") + " " + ;
            TRANSFORM(VALTOT, "99999,999.99"))
      DEVPOS(CL, 92)
      DEVOUT(ORD)
      DEVPOS(CL, 100)
      DEVOUT(DTOC(FECEMI) + " " + ALLTRIM(ORDPOR) + "-" + TRANSFORM(CONSE, ;
            "999"))
      MEMVAR->CL := MEMVAR->CL + 1

      IF CL = 59

         MEMVAR->CL := 0

      ENDIF

      DBSKIP(1)

   ENDDO

   MEMVAR->CL := MEMVAR->CL + 1
   DEVPOS(CL, 1)
   DEVOUT(WLINEA)
   MEMVAR->CL := MEMVAR->CL + 1
   MEMVAR->WT1 := "** FIN DEL INFORME **"
   DEVPOS(CL, WLONPAP - LEN(WT1))
   DEVOUT(WT1 + CHR(18) + " ")
   DEVPOS(CL + 1, 1)
   DEVOUT(DTOC(DATE()) + " / " + TIME())
   __EJECT()
   APIM()
   DBCLOSEARE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->OPC := " "

RETURN 

