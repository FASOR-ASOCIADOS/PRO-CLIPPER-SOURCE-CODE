/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LIORCODI
   Params: None.
   Return: Undefined
  Example: LIORCODI()
  ..........................................................................
*/

PROCEDURE LIORCODI()

   MEMVAR->OPC := " "
   MENU()
   DEVPOS(12, 20)
   DEVOUT("En este momento obtendr  un listado de las")
   DEVPOS(13, 20)
   DEVOUT("ordenes de compra seg£n los dias de emitidas.")
   DEVPOS(14, 20)
   DEVOUT("teniendo en cuenta la fecha de elaboraci¢n,")
   DEVPOS(15, 20)
   DEVOUT("y la fecha de hoy que es ")
   SETCOLOR("+g")
   DEVPOS(15, 45)
   DEVOUTPICT(DAY(DATE()), "@# 99")
   DEVPOS(15, 49)
   DEVOUT("de")
   MEMVAR->WFECHA := DATE()
   MEMVAR->WMESL := ""
   FECHA()
   DEVPOS(15, 52)
   DEVOUT(WMESL)
   SETCOLOR("+W")
   DEVPOS(16, 20)
   DEVOUT("Desea continuar ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC <> "S" .OR. LASTKEY() = 27

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   SCROLL(6, 1, 23, 78)
   MEMVAR->WDIAS := ( SETPOS(6, 1), 0 )
   DEVPOS(12, 20)
   DEVOUT("DE MAS DE CUANTOS DIAS DE EMITIDAS ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WDIAS", "@Z 9999", NIL, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF WDIAS = 0

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   ESPERE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   AOCS()

   IF LASTREC() > 1

      __DBSORT("C:\PROTMP\BASURA", {"FECEMI", "NUMINS"}, {||DATE() - FECEMI > ;
            WDIAS - 1}, NIL, NIL, NIL, .F.)

   ELSE

      __DBCOPY("C:\PROTMP\BASURA", {}, NIL, NIL, NIL, NIL, .F., NIL)

   ENDIF

   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)
   PIDEIMP()
   __RUN("MODE LPT1:132")
   __RUN("MODE LPT1:132")
   MEMVAR->CP := MEMVAR->CL := 0
   ENIM0()
   MEMVAR->WFECHA := DATE()
   QOUT(CHR(27)+CHR(15)+" ")
   QOUT(CHR(27)+CHR(15)+" ")
   MEMVAR->WMESL := ""
   FECHA()
   MEMVAR->WLINEA := REPLICATE("Ä", 132)

   DO WHILE  .NOT. EOF()

      MEMVAR->CP := MEMVAR->CP + 1

      IF CL = 0

         QOUT(SPACE(50) + RAZON)
         QOUT(" ")
         QOUT(" ")
         QOUT(SPACE(50) + "SISTEMA DE PRODUCCION")
         QOUT(SPACE(33) + ;
               "RELACION DE ORDENES DE COMPRA EN ORDEN DE DIAS DE ELABORADAS";
               )
         QOUT(" ")
         QOUT("LISTADO A : " + LTRIM(STR(DAY(DATE()))) + " DE " + WMESL + ;
               " DE " + LTRIM(STR(YEAR(DATE()))) + SPACE(71) + ;
               "PAGINA Nro. " + LTRIM(STR(CP)))
         QOUT(WLINEA)
         QOUT(;
               "C-PROV NOMBRE ESTABLECIMIENTO         INS.  CANTIDAD   CANTIDAD   VALOR        VALOR  NUMERO    FECHA  ORDENADO          ACUM. ";
               )
         QOUT(;
               "                                            PEDIDA     ENTREGADA  UNITARIO     TOTAL  DE ORDEN  ORDEN  POR               DIAS  ";
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
      QQOUT(" " + ORD + " " + DTOC(FECEMI) + " " + ORDPOR + ALLTRIM(;
            TRANSFORM(DATE() - FECEMI, "99")))
      MEMVAR->CL := MEMVAR->CL + 1

      IF CL = 59

         QOUT(WLINEA)
         __EJECT()
         MEMVAR->CL := 0

      ENDIF

      DBSKIP(1)

   ENDDO

   QOUT(WLINEA)
   QOUT(CHR(27)+CHR(18)+" ")
   __EJECT()
   APIM0()
   DBCLOSEARE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->OPC := " "

RETURN 

