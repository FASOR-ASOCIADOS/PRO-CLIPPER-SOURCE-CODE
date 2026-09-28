/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LISVALPR
   Params: None.
   Return: Undefined
  Example: LISVALPR()
  ..........................................................................
*/

PROCEDURE LISVALPR()

   MEMVAR->OPC := "S"
   MENU()
   DEVPOS(12, 20)
   DEVOUT("Ahora se dispone a listar los valores de los")
   DEVPOS(13, 20)
   DEVOUT("productos que se encuentran en proceso.")
   DEVPOS(14, 20)
   DEVOUT("Desea continuar ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC <> "S"

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   SCROLL(5, 1, 23, 78)
   SETPOS(5, 1)
   __MRESTORE("&ZDIS\&WDIRECTO\ORDEXC", .T.)
   __MRESTORE("&ZDIS\&WDIRECTO\COSDIR", .T.)
   DEVPOS(12, 20)
   DEVOUT("N£mero de orden a excluir del listado ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "ORDEXC", NIL, NIL, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   FERASE("&ZDIS\&WDIRECTO\ORDEXC.MEM")
   __MSAVE("&ZDIS\&WDIRECTO\ORDEXC", "ORDEXC", .T.)
   ESPERE()
   MEMVAR->WAB := "BASURA.NTX"
   BA()
   MEMVAR->WAB := "FILETEM1.DBF"
   BA()
   MEMVAR->WSOR := " "
   SCROLL(5, 1, 23, 78)
   SETPOS(5, 1)
   DEVPOS(12, 20)
   DEVOUT("clasificado por <O>rden o por <C>odigo ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WSOR", "@!", {||WSOR $ "CO"}, NIL):DISPLAY())
   SETCOLOR("+G")
   DEVPOS(12, 37)
   DEVOUT("O")
   DEVPOS(12, 51)
   DEVOUT("C")
   SETCOLOR("+W")
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   ESPERE()
   AFACOSS()
   MEMVAR->WCANREC := LASTREC()
   DBGOTO(WCANREC)
   MEMVAR->WCOSHOR := PROMESES
   DBCLOSEARE()
   __MRESTORE("&ZDIS\&WDIRECTO\PORMOI", .T.)
   ACOSE()
   DBEVAL({||FIELD->LETORD := ALLTRIM(TRANSFORM(NUMORD, "99999999"))}, {||;
         LETORD = SPACE(8)}, NIL, NIL, NIL, .F.)

   IF WSOR = "O"

      DBCREATEIN("C:BASURA", "NUMORD", {||NUMORD}, NIL)
      __DBCOPY("C:\FILETEM1", {}, {||ACTUALIZAD <> "C"}, NIL, NIL, NIL, ;
            .F., NIL)

   ELSE

      DBCREATEIN("C:\BASURA", "VAL(CODPRO)", {||VAL(CODPRO)}, NIL)
      __DBCOPY("C:\FILETEM1", {}, {||ACTUALIZAD <> "C"}, NIL, NIL, NIL, ;
            .F., NIL)

   ENDIF

   DBCLOSEARE()
   DBSELECTAR("30")
   DBUSEAREA(.F., NIL, "C:\FILETEM1", NIL, NIL, .F.)
   PIDEIMP()
   MEMVAR->OPC := " "
   SCROLL(5, 1, 23, 78)
   SETPOS(5, 1)
   SETCOLOR("*+G")
   DEVPOS(12, 20)
   DEVOUT("* * *   I M P R I M I E N D O  * * *")
   SETCOLOR("+W")
   VEAIMP()
   ENIM()
   MEMVAR->CL := MEMVAR->CP := MEMVAR->WTOTPRO := MEMVAR->WTOTCOS := 0
   MEMVAR->WRAYA := REPLICATE("Ä", 80)
   ACOSE()
   MEMVAR->WAB := "COSTOS.NTX"
   BA()
   DBCREATEIN("C:\COSTOS.NTX", "LETORD", {||LETORD}, NIL)
   DBCLOSEARE()
   AMAPAE()
   ORDLISTCLE()
   ORDLISTADD("CODMAEPA")
   ORDLISTREB()
   DBCLOSEARE()
   DBSELECTAR("30")

   DO WHILE  .NOT. EOF()

      IF CL = 0

         MEMVAR->CP := MEMVAR->CP + 1
         DEVPOS(CL, (80 - LEN(RAZON)) / 2)
         DEVOUT(RAZON)
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 1)
         DEVOUT(PADC("SISTEMA DE PRODUCCION", 78))
         MEMVAR->CL := MEMVAR->CL + 2
         DEVPOS(CL, 1)
         DEVOUT(PADC("LISTADO DE VALORES DE PRODUCTOS EN PROCESO", 78))
         DEVPOS(CL, 1)
         DEVOUT(DATE())
         DEVPOS(CL, 68)
         DEVOUT("PAGINA Nro." + ALLTRIM(TRANSFORM(CP, "99")))
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 0)
         DEVOUT(WRAYA)
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 1)
         DEVOUT(;
               "NUM.DE ORD. COD.ART. CAN.ORIGIN. CAN.EN PROCES. VR EN PROCESO COSTO EN PROC.";
               )
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 0)
         DEVOUT(WRAYA)
         MEMVAR->CL := MEMVAR->CL + 1

      ENDIF

      DBSELECTAR("30")

      IF LETORD = ORDEXC

         DBSKIP(1)
         LOOP

      ENDIF

      MEMVAR->WNUMORD := LETORD
      MEMVAR->WCODPRO := CODPRO
      ACOSS()
      ORDLISTCLE()
      ORDLISTADD("C:\COSTOS.NTX")
      MEMVAR->WVALSAL := MEMVAR->WCANTOT := MEMVAR->WCANORD := 0
      DBSEEK("&WNUMORD")

      IF  .NOT. EOF()

         MEMVAR->WCANTOT := CANTOT
         MEMVAR->WCANORD := CANORD
         MEMVAR->WVALTOT := VALTOT
         MEMVAR->WVALSAL := WVALTOT * CANORD / CANTOT
         MEMVAR->WTEXT := "   "

      ELSE

         MEMVAR->WVALTOT := 0
         MEMVAR->WTEXT := "No esta en costos.dbf"

      ENDIF

      DBCLOSEARE()
      MEMVAR->WCOSPRO := 0
      DBSELECTAR("30")
      MEMVAR->WPAGINT := PAGO + PAGO * PORMOI / 100
      MEMVAR->WVALUNI := VALTOT / (CANTOT - CANORD)
      MEMVAR->WCOSUNIND := MINUTOS * WCOSHOR / 60 / CANTOT

      IF CANTOT <> 0

         MEMVAR->WMOUNI := WPAGINT / CANTOT

      ELSE

         MEMVAR->WMOUNI := WPAGINT

      ENDIF

      MEMVAR->WCOSUN := WVALUNI + WMOUNI + WCOSUNIND
      MEMVAR->WCOSPRO := (WCOSUN - WVALUNI) * CANORD
      MEMVAR->WTOTCOS := MEMVAR->WTOTCOS + WCOSPRO
      MEMVAR->WTOTPRO := WTOTPRO + WVALSAL
      DEVPOS(CL, 2)
      DEVOUT(LETORD)
      DEVPOS(CL, 14)
      DEVOUT(CODPRO)
      DEVPOS(CL, 22)
      DEVOUTPICT(WCANTOT, "@# 99,999,999")
      DEVPOS(CL, 35)
      DEVOUTPICT(WCANORD, "@# 99,999,999")
      DEVPOS(CL, 50)
      DEVOUTPICT(WVALSAL, "@# 999,999,999")
      DEVPOS(CL, 64)
      DEVOUTPICT(WCOSPRO, "@# 999,999,999")
      DEVPOS(CL, 70)
      DEVOUT(WTEXT)
      MEMVAR->CL := MEMVAR->CL + 1

      IF CL > 58

         MEMVAR->CL := 0

      ENDIF

      DBSKIP(1)

   ENDDO

   MEMVAR->CL := MEMVAR->CL + 1
   DEVPOS(CL, 0)
   DEVOUT(WRAYA)
   MEMVAR->CL := MEMVAR->CL + 1
   DEVPOS(CL, 1)
   DEVOUT(CHR(15)+" Pro1.lisvalpr"+CHR(18)+" ")
   DEVPOS(CL, 12)
   DEVOUT("VALOR TOTAL DE PRODUCTOS EN PROCESO : ")
   DEVPOS(CL, 50)
   DEVOUTPICT(WTOTPRO, "@# 99,999,999,999")
   DEVPOS(CL, 64)
   DEVOUTPICT(WTOTCOS, "@# 99,999,999,999")
   DEVPOS(CL, 0)
   DEVOUT(" ")
   __EJECT()
   APIM()
   CIERRE()
   MEMVAR->OPC := " "
   MEMVAR->WAB := "FILETEM1.DBF"
   BA()
   MEMVAR->WAB := "BASURA.NTX"
   BA()

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LISVALPR1
   Params: None.
   Return: Undefined
  Example: LISVALPR1()
  ..........................................................................
*/

PROCEDURE LISVALPR1()

   MEMVAR->OPC := "S"
   MENU()
   DEVPOS(12, 20)
   DEVOUT("Ahora se dispone a listar los valores de los")
   DEVPOS(13, 20)
   DEVOUT("productos que se encuentran en proceso.")
   DEVPOS(14, 20)
   DEVOUT("Desea continuar ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC <> "S"

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   SCROLL(5, 1, 23, 78)
   SETPOS(5, 1)
   __MRESTORE("&ZDIS\&WDIRECTO\ORDEXC", .T.)
   __MRESTORE("&ZDIS\&WDIRECTO\COSDIR", .T.)
   DEVPOS(12, 20)
   DEVOUT("N£mero de orden a excluir del listado ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "ORDEXC", NIL, NIL, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   FERASE("&ZDIS\&WDIRECTO\ORDEXC.MEM")
   __MSAVE("&ZDIS\&WDIRECTO\ORDEXC", "ORDEXC", .T.)
   ESPERE()
   MEMVAR->WAB := "BASURA.NTX"
   BA()
   MEMVAR->WAB := "FILETEM1.DBF"
   BA()
   MEMVAR->WSOR := " "
   SCROLL(5, 1, 23, 78)
   SETPOS(5, 1)
   DEVPOS(12, 20)
   DEVOUT("clasificado por <O>rden o por <C>odigo ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WSOR", "@!", {||WSOR $ "CO"}, NIL):DISPLAY())
   SETCOLOR("+G")
   DEVPOS(12, 37)
   DEVOUT("O")
   DEVPOS(12, 51)
   DEVOUT("C")
   SETCOLOR("+W")
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   ESPERE()
   ACOSE()
   DBEVAL({||FIELD->LETORD := ALLTRIM(TRANSFORM(NUMORD, "99999999"))}, {||;
         LETORD = SPACE(8)}, NIL, NIL, NIL, .F.)

   IF WSOR = "O"

      DBCREATEIN("C:BASURA", "NUMORD", {||NUMORD}, NIL)
      __DBCOPY("C:\FILETEM1", {}, {||ACTUALIZAD <> "C"}, NIL, NIL, NIL, ;
            .F., NIL)

   ELSE

      DBCREATEIN("C:\BASURA", "VAL(CODPRO)", {||VAL(CODPRO)}, NIL)
      __DBCOPY("C:\FILETEM1", {}, {||ACTUALIZAD <> "C"}, NIL, NIL, NIL, ;
            .F., NIL)

   ENDIF

   DBCLOSEARE()
   DBSELECTAR("30")
   DBUSEAREA(.F., NIL, "C:\FILETEM1", NIL, NIL, .F.)
   PIDEIMP()
   MEMVAR->OPC := " "
   SCROLL(5, 1, 23, 78)
   SETPOS(5, 1)
   SETCOLOR("*+G")
   DEVPOS(12, 20)
   DEVOUT("* * *   I M P R I M I E N D O  * * *")
   SETCOLOR("+W")
   VEAIMP()
   ENIM()
   MEMVAR->CL := MEMVAR->CP := MEMVAR->WTOTPRO := MEMVAR->WTOTCOS := 0
   MEMVAR->WRAYA := REPLICATE("Ä", 80)
   ACOSE()
   MEMVAR->WAB := "COSTOS.NTX"
   BA()
   DBCREATEIN("C:\COSTOS.NTX", "LETORD", {||LETORD}, NIL)
   DBCLOSEARE()
   AMAPAE()
   ORDLISTCLE()
   ORDLISTADD("CODMAEPA")
   ORDLISTREB()
   DBCLOSEARE()
   DBSELECTAR("30")

   DO WHILE  .NOT. EOF()

      IF CL = 0

         MEMVAR->CP := MEMVAR->CP + 1
         DEVPOS(CL, (80 - LEN(RAZON)) / 2)
         DEVOUT(RAZON)
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 1)
         DEVOUT(PADC("SISTEMA DE PRODUCCION", 78))
         MEMVAR->CL := MEMVAR->CL + 2
         DEVPOS(CL, 1)
         DEVOUT(PADC("LISTADO DE VALORES DE PRODUCTOS EN PROCESO", 78))
         DEVPOS(CL, 1)
         DEVOUT(DATE())
         DEVPOS(CL, 68)
         DEVOUT("PAGINA Nro." + ALLTRIM(TRANSFORM(CP, "99")))
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 0)
         DEVOUT(WRAYA)
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 1)
         DEVOUT(;
               "NUM.DE ORD. COD.ART. CAN.ORIGIN. CAN.EN PROCES. VR EN PROCESO COSTO EN PROC.";
               )
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 0)
         DEVOUT(WRAYA)
         MEMVAR->CL := MEMVAR->CL + 1

      ENDIF

      DBSELECTAR("30")

      IF LETORD = ORDEXC

         DBSKIP(1)
         LOOP

      ENDIF

      MEMVAR->WNUMORD := LETORD
      MEMVAR->WCODPRO := CODPRO
      ACOSS()
      ORDLISTCLE()
      ORDLISTADD("C:\COSTOS.NTX")
      MEMVAR->WVALSAL := MEMVAR->WCANTOT := MEMVAR->WCANORD := 0
      DBSEEK("&WNUMORD")

      IF  .NOT. EOF()

         MEMVAR->WCANTOT := CANTOT
         MEMVAR->WCANORD := CANORD
         MEMVAR->WVALTOT := VALTOT
         MEMVAR->WVALSAL := WVALTOT * CANORD / CANTOT
         MEMVAR->WTEXT := "   "

      ELSE

         MEMVAR->WVALTOT := 0
         MEMVAR->WTEXT := "No esta en costos.dbf"

      ENDIF

      DBCLOSEARE()
      MEMVAR->WCOSPRO := 0
      AMAPAS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
      DBSEEK("&WCODPRO")

      IF  .NOT. EOF()

         MEMVAR->WCOSPRO := COSDIR * MO * WCANORD
         MEMVAR->WTOTCOS := MEMVAR->WTOTCOS + WCOSPRO

      ENDIF

      DBSELECTAR("1")
      DBCLOSEARE()
      DBSELECTAR("30")
      MEMVAR->WTOTPRO := WTOTPRO + WVALSAL
      DEVPOS(CL, 2)
      DEVOUT(LETORD)
      DEVPOS(CL, 14)
      DEVOUT(CODPRO)
      DEVPOS(CL, 22)
      DEVOUTPICT(WCANTOT, "@# 99,999,999")
      DEVPOS(CL, 35)
      DEVOUTPICT(WCANORD, "@# 99,999,999")
      DEVPOS(CL, 50)
      DEVOUTPICT(WVALSAL, "@# 999,999,999")
      DEVPOS(CL, 64)
      DEVOUTPICT(WCOSPRO, "@# 999,999,999")
      DEVPOS(CL, 70)
      DEVOUT(WTEXT)
      MEMVAR->CL := MEMVAR->CL + 1

      IF CL > 58

         MEMVAR->CL := 0

      ENDIF

      DBSKIP(1)

   ENDDO

   MEMVAR->CL := MEMVAR->CL + 1
   DEVPOS(CL, 0)
   DEVOUT(WRAYA)
   MEMVAR->CL := MEMVAR->CL + 1
   DEVPOS(CL, 1)
   DEVOUT(CHR(15)+" Pro1.lisvalpr"+CHR(18)+" ")
   DEVPOS(CL, 12)
   DEVOUT("VALOR TOTAL DE PRODUCTOS EN PROCESO : ")
   DEVPOS(CL, 50)
   DEVOUTPICT(WTOTPRO, "@# 99,999,999,999")
   DEVPOS(CL, 64)
   DEVOUTPICT(WTOTCOS, "@# 99,999,999,999")
   DEVPOS(CL, 0)
   DEVOUT(" ")
   __EJECT()
   APIM()
   CIERRE()
   MEMVAR->OPC := " "
   MEMVAR->WAB := "FILETEM1.DBF"
   BA()
   MEMVAR->WAB := "BASURA.NTX"
   BA()

RETURN 

