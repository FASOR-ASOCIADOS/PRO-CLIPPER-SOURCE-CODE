/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LISCOSRE
   Params: None.
   Return: Undefined
  Example: LISCOSRE()
  ..........................................................................
*/

PROCEDURE LISCOSRE()

   CIERRE()
   __MRESTORE("&ZDIS\&WDIRECTO\PORMOI", .T.)
   MENU()
   DEVPOS(4, 29)
   DEVOUT("LISTADO DE COSTOS POR INSUMO")
   MEMVAR->OPC := " "
   DEVPOS(12, 10)
   DEVOUT("Listado de <T>odos, de los <E>speciales o <N>inguno ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "TEN"}, NIL):DISPLAY())
   SETCOLOR("+G")
   DEVPOS(12, 22)
   DEVOUT("T")
   DEVPOS(12, 38)
   DEVOUT("E")
   DEVPOS(12, 53)
   DEVOUT("N")
   SETCOLOR("+W")
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   MEMVAR->WSEL := OPC

   IF OPC = "N"

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   SCROLL(10, 1, 23, 78)
   MEMVAR->CP := ( SETPOS(10, 1), 0 )
   DEVPOS(12, 20)
   DEVOUT("NUMERO DE ULTIMA PAGINA IMPRESA ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "CP", "@Z 999", NIL, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   SCROLL(10, 1, 23, 78)
   SETPOS(10, 1)

   IF WSEL = "T"

      MEMVAR->WSEL1 := "PRODUCTOS EN GENERAL"
      SCROLL(10, 2, 23, 78)
      SETPOS(10, 2)

   ELSEIF WSEL = "E"

      MEMVAR->WSEL1 := "PRODUCTOS ESPECIALES"

   ENDIF

   SETCOLOR("+G")
   MEMVAR->WT1 := "RANGO PARA " + WSEL1
   DEVPOS(10, (80 - LEN(WT1)) / 2)
   DEVOUT(WT1)
   SETCOLOR("+W")
   SCROLL(7, 1, 23, 78)
   MEMVAR->WAB := ( SETPOS(7, 1), "BASURA.DBF" )
   BA()
   MEMVAR->WSELCOD := " "
   MEMVAR->SWUNITARIO := 0
   DEVPOS(12, 20)
   DEVOUT("<T>odos los codigos o <U>no solo ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WSELCOD", "@!", {||WSELCOD $ "TU"}, NIL);
         :DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF WSELCOD = "U"

      MEMVAR->WCOD := ZLCPT
      DEVPOS(14, 20)
      DEVOUT("CUAL CODIGO ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCOD", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WCOD = ZLCPT

         MEMVAR->OPC := " "
         RETURN 

      ENDIF

      ESPERE()
      ACOSE()
      __DBCOPY("C:\BASURA", {}, {||CODPRO = WCOD}, NIL, NIL, NIL, .F., NIL)
      MEMVAR->SWUNITARIO := 1
      DBCLOSEARE()

   ELSE

      MEMVAR->WDESDE := MEMVAR->WHASTA := 0
      SET(31, "OFF")
      SET(34, "[]")
      SET(33, "ON")
      DEVPOS(12, 20)
      DEVOUT("Por favor deme el rango a imprimir.")
      DEVPOS(13, 20)
      DEVOUT("ORDEN PARA INICIAR  ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WDESDE", "@Z 99999999", NIL, NIL):DISPLAY();
            )
      DEVPOS(14, 20)
      DEVOUT("ORDEN PARA TERMINAR ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WHASTA", "@Z 99999999", NIL, NIL):DISPLAY();
            )
      SETCOLOR("+G")
      DEVPOS(13, 55)
      DEVOUT("0 PARA CANCELAR")
      SETCOLOR("+W")
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      ESPERE()
      SET(33, "OFF")
      SET(31, "ON")

      IF WDESDE = 0

         MEMVAR->OPC := " "
         RETURN 

      ENDIF

      ACOSE()
      __DBCOPY("C:\BASURA", {}, {||(NUMORD > WDESDE .OR. NUMORD = WDESDE) ;
            .AND. (NUMORD < WHASTA .OR. NUMORD = WHASTA)}, NIL, NIL, NIL, ;
            .F., NIL)
      DBCLOSEARE()

   ENDIF

   DBCLOSEARE()
   DBSELECTAR("1")
   DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
   MEMVAR->WAB := "BASURA.NTX"
   BA()

   IF LASTREC() < 1

      DBCLOSEARE()
      SCROLL(12, 1, 23, 78)
      SETPOS(12, 1)
      DEVPOS(12, 20)
      DEVOUT("NO TENGO INFORMACION POR AHORA")
      MEMVAR->X := INKEY(0)
      SET(11, "OFF")
      DBCLOSEARE()
      RETURN 

   ENDIF

   MEMVAR->WAB := "FILETEMP.DBF"
   BA()

   IF OPC = "T"

      IF LASTREC() > 1

         DBCREATEIN("C:\BASURA", "NUMORD", {||NUMORD}, NIL)
         __DBCOPY("C:\FILETEMP", {}, {||ACTUALIZAD = "C"}, NIL, NIL, NIL, ;
               .F., NIL)

      ELSE

         __DBCOPY("C:\FILETEMP.DBF", {}, NIL, NIL, NIL, NIL, .F., NIL)

      ENDIF

   ENDIF

   IF OPC = "E"

      IF LASTREC() > 1

         DBCREATEIN("C:\BASURA", "NUMORD", {||NUMORD}, NIL)
         __DBCOPY("C:\FILETEMP", {}, {||ACTUALIZAD = "C" .AND. VAL(CODPRO) ;
               > 5999 .AND. VAL(CODPRO) < 7000}, NIL, NIL, NIL, .F., NIL)

      ELSE

         __DBCOPY("C:\FILETEMP.DBF", {}, NIL, NIL, NIL, NIL, .F., NIL)

      ENDIF

   ENDIF

   SET(11, "OFF")
   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "C:\FILETEMP", NIL, NIL, .F.)

   IF OPC = "E"

      DBEVAL({||DBDELETE()}, {||VAL(CODPRO) < 6000 .OR. VAL(CODPRO) > 6999};
            , NIL, NIL, NIL, .F.)
      __DBPACK()
      DBCLOSEARE()
      DBUSEAREA(.F., NIL, "C:\FILETEMP", NIL, NIL, .F.)

   ENDIF

   IF LASTREC() < 1

      DBCLOSEARE()
      SCROLL(21, 1, 23, 78)
      SETPOS(21, 1)
      DEVPOS(22, 20)
      DEVOUT("NO TENGO INFORMACION POR AHORA")
      MEMVAR->X := INKEY(0)
      SET(11, "OFF")
      RETURN 

   ENDIF

   DBGOTOP()
   MENU()
   SETCOLOR("+GR")
   DEVPOS(10, 5)
   DEVOUT("ATENCION :")
   DEVPOS(11, 15)
   DEVOUT("Debe achicar MANUALMENTE la letra de la impresora")
   DEVPOS(12, 15)
   DEVOUT("a 17 caracteres por pulgada")
   SETCOLOR("+W")
   DEVPOS(14, 20)
   DEVOUT("OPRIMA UNA TECLA PARA INICIAR")
   MEMVAR->X := INKEY(0)
   __RUN("MODE LPT1:132")
   MENU()
   SETCOLOR("*+G")
   DEVPOS(12, 1)
   DEVOUT(PADC("*** IMPRIMIENDO " + WSEL1 + " ***", 78))
   VEAIMP()
   ENIM()
   MEMVAR->WRAYA := REPLICATE("Ä", 133)
   MEMVAR->CL := 0

   IF WSEL = "E"

      SET(25, 7)

      DO WHILE  .NOT. EOF()

         IF CL = 0

            MEMVAR->CP := MEMVAR->CP + 1
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 45)
            DEVOUT(CHR(27)+"Ž" + RAZON)
            MEMVAR->CL := MEMVAR->CL + 2
            DEVPOS(CL, 1)
            DEVOUT(PADC(;
                  "COSTEO GENERAL DE ORDENES DE PRODUCCION DE PRODUCTOS ESPECIALES";
                  , 131))
            MEMVAR->CL := MEMVAR->CL + 2
            DEVPOS(CL, 1)
            DEVOUT("FECHA DEL INFORME: " + DTOC(DATE()))
            DEVPOS(CL, 119)
            DEVOUT("PAGINA Nro:" + ALLTRIM(TRANSFORM(CP, "99")))
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 0)
            DEVOUT(WRAYA)
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 1)
            DEVOUT(;
                  "G E N E R A L I D A D E S----><------UNITARIOS------>   <----------------------- INFORMATIVAS ----------------------> SCREEN";
                  )
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 0)
            DEVOUT(WRAYA)
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 1)
            DEVOUT(;
                  "NUM.     CANT.  CANT.  REFE-     UNIT.  UNIT.   $$$$    MARGEN           PRODUCTO                     CLIENTE";
                  )
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 1)
            DEVOUT(;
                  "O.P.     PED.   PROD.  RENCIA    REAL   ESTIM   VENT.    BRUTO          ";
                  )
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 0)
            DEVOUT(WRAYA)
            MEMVAR->CL := MEMVAR->CL + 1

         ENDIF

         MEMVAR->WPAGINT := PAGO + PAGO * PORMOI / 100
         MEMVAR->WVALUNI := VALTOT / (CANTOT - CANORD)
         MEMVAR->WCOSUNIND := MINUTOS * FACTORCUI / 60 / (CANTOT - CANORD)

         IF CANTOT - CANORD <> 0

            MEMVAR->WMOUNI := WPAGINT / (CANTOT - CANORD)

         ELSE

            MEMVAR->WMOUNI := WPAGINT

         ENDIF

         MEMVAR->WCOSUN := WVALUNI + WMOUNI + WCOSUNIND
         MEMVAR->WVRTOUNI := WVALUNI + WMOUNI + WCOSUNIND
         MEMVAR->WMAR := (PREVEN - WVRTOUNI) * 100 / WVRTOUNI
         MEMVAR->WCOSEST := COSEST
         DEVPOS(CL, 0)
         DEVOUTPICT(NUMORD, "@# 99999")
         DEVPOS(CL, 6)
         DEVOUTPICT(CANPED, "@# 999,999")
         DEVPOS(CL, 14)
         DEVOUTPICT(CANTOT - CANORD, "@# 999,999")
         DEVPOS(CL, 24)
         DEVOUT(CODPRO)
         DEVPOS(CL, 32)
         DEVOUTPICT(WCOSUN, "@# 999,999")
         DEVPOS(CL, 41)
         DEVOUTPICT(WCOSEST, "@Z 99999")
         DEVPOS(CL, 48)
         DEVOUTPICT(PREVEN, "@# 99,999")
         DEVPOS(CL, 56)
         DEVOUTPICT(WMAR, "@# 999,999")

         IF PREVEN > 0 .AND. WMAR < 0

            DEVPOS(CL, 56)
            DEVOUTPICT(WMAR, "@# 999,999")
            DEVPOS(CL, 56)
            DEVOUTPICT(WMAR, "@# 999,999")

         ENDIF

         DEVPOS(CL, 64)
         DEVOUT(NOMBREPT)
         DEVPOS(CL, 96)
         DEVOUT(NOMCLI)
         DEVPOS(CL, 118)
         DEVOUTPICT(SCREEN, "@Z 9999,999")
         MEMVAR->CL := MEMVAR->CL + 1
         DBSKIP(1)

         IF  .NOT. EOF()

            IF CL = 55

               MEMVAR->CL := 0
               DEVPOS(CL, 1)
               DEVOUT(" ")

            ENDIF

         ENDIF

      ENDDO

   ELSE

      MEMVAR->WRAYA := REPLICATE("Ä", 139)
      SET(25, 7)

      DO WHILE  .NOT. EOF()

         IF CL = 0

            MEMVAR->CP := MEMVAR->CP + 1
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 45)
            DEVOUT(CHR(27)+"Ž" + RAZON)
            MEMVAR->CL := MEMVAR->CL + 2
            DEVPOS(CL, 43)
            DEVOUT("COSTEO GENERAL DE ORDENES DE PRODUCCION")
            MEMVAR->CL := MEMVAR->CL + 2
            DEVPOS(CL, 1)
            DEVOUT("FECHA DEL INFORME: ")
            DEVPOS(CL, 20)
            DEVOUT(DATE())
            DEVPOS(CL, 119)
            DEVOUT("PAGINA Nro: ")
            DEVPOS(CL, 131)
            DEVOUTPICT(CP, "@# 99")
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 0)
            DEVOUT(WRAYA)
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 1)
            DEVOUT(;
                  "G E N E R A L I D A D E S----> <---- TIEMPOS --------><-VR. INSUMOS---> <-------  U N I T A R I O S ---------> <------ INFORMATIVAS ----->";
                  )
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 0)
            DEVOUT(WRAYA)
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 1)
            DEVOUT(;
                  "NUM.   CANT.  CANT.  REFE-     CANT.   PAGO   PAGO         VALOR        COS.UN.  COS.UN.   COS.UN. UNIT. UNIT.   $$$$    MARGEN   CLIENTE";
                  )
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 1)
            DEVOUT(;
                  "O.P.   PED.   PROD.  RENCIA    MINUT.  BASICO INTEGRAL     TOTAL         M. O.   INSUM.    INDIR.  REAL  ESTIM   VENT.    BRUTO          ";
                  )
            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 0)
            DEVOUT(WRAYA)
            MEMVAR->CL := MEMVAR->CL + 1

         ENDIF

         MEMVAR->WPAGINT := PAGO + PAGO * PORMOI / 100
         MEMVAR->WVALUNI := VALTOT / (CANTOT - CANORD)
         MEMVAR->WCOSUNIND := MINUTOS * FACTORCUI / 60 / (CANTOT - CANORD)
         MEMVAR->WMOUNI := WPAGINT / (CANTOT - CANORD)
         MEMVAR->WCOSUN := WVALUNI + WMOUNI + WCOSUNIND
         MEMVAR->WVRTOUNI := WVALUNI + WMOUNI + WCOSUNIND
         MEMVAR->WMAR := (PREVEN - WVRTOUNI) * 100 / WVRTOUNI
         MEMVAR->WCOSEST := COSEST
         DEVPOS(CL, 0)
         DEVOUT(TRANSFORM(NUMORD, "99999") + " " + TRANSFORM(CANPED, ;
               "99,999") + "  " + TRANSFORM(CANTOT - CANORD, "99,999") + ;
               "  " + CODPRO)
         DEVPOS(CL, 30)
         DEVOUTPICT(MINUTOS, "@# 99999")
         DEVPOS(CL, 36)
         DEVOUTPICT(PAGO, "@# 9,999,999")
         DEVPOS(CL, 48)
         DEVOUTPICT(WPAGINT, "@Z 999,999")
         DEVPOS(CL, 58)
         DEVOUTPICT(VALTOT, "@# 99999,999")
         DEVPOS(CL, 71)
         DEVOUTPICT(WMOUNI, "@# 9,999.99")
         DEVPOS(CL, 80)
         DEVOUTPICT(WVALUNI, "@# 999999.99")
         DEVPOS(CL, 90)
         DEVOUTPICT(WCOSUNIND, "@Z 9,999.99")
         DEVPOS(CL, 98)
         DEVOUTPICT(WCOSUN, "@# 99,999")
         DEVPOS(CL, 105)
         DEVOUTPICT(WCOSEST, "@Z 99,999")
         DEVPOS(CL, 113)
         DEVOUTPICT(PREVEN, "@# 99,999")
         DEVPOS(CL, 121)
         DEVOUTPICT(WMAR, "@# 99,999")

         IF PREVEN > 0 .AND. WMAR < 0

            DEVPOS(CL, 121)
            DEVOUTPICT(WMAR, "@# 99,999")
            DEVPOS(CL, 121)
            DEVOUTPICT(WMAR, "@# 99,999")

         ENDIF

         DEVPOS(CL, 130)
         DEVOUT(SUBSTR(NOMCLI, 1, 10))
         MEMVAR->CL := MEMVAR->CL + 1

         IF SWUNITARIO = 1

            DEVPOS(CL, 71)
            DEVOUT("äunitarios")
            DEVPOS(CL, 83)
            DEVOUTPICT(WMOUNI + WCOSUNIND, "@Z 9,999,999")
            MEMVAR->CL := MEMVAR->CL + 1

         ENDIF

         DBSKIP(1)

         IF CL > 55 .AND. .NOT. EOF()

            MEMVAR->CL := 0
            DEVPOS(CL, 1)
            DEVOUT(" ")

         ENDIF

      ENDDO

   ENDIF

   DEVPOS(CL, 0)
   DEVOUT(WRAYA)
   DEVPOS(CL, 0)
   DEVOUT(CHR(18)+" ")
   DEVPOS(CL + 1, 100)
   DEVOUT("** Fin del informe **")
   __EJECT()
   SET(25, 0)
   APIM()
   CIERRE()
   MEMVAR->WAB := "FILETEMP.DBF"
   BA()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->WAB := "BASURA.NTX"
   BA()
   MEMVAR->OPC := " "

RETURN 

