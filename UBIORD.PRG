/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: UBIORD
   Params: None.
   Return: Undefined
  Example: UBIORD()
  ..........................................................................
*/

PROCEDURE UBIORD()

   MENU()
   DEVPOS(7, 1)
   DEVOUT(PADC(;
         "ACTUALIZACION Y CONSULTA DE LA UBICACION DE LAS ORDENES DE PRODUCCION";
         , 78))
   MEMVAR->WACT := " "
   DEVPOS(12, 10)
   DEVOUT("Antes de imprimir desea actualizar ubicaciones ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WACT", "@!", {||WACT $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   DEVPOS(14, 10)
   DEVOUT("Por favor espere un momento...")
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   ACOSS()
   __DBSORT("C:\BASURA", {"NUMORD"}, {||ACTUALIZAD <> "C"}, NIL, NIL, NIL, ;
         .F.)
   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
   MEMVAR->WDESDE := NUMORD
   DBGOBOTTOM()
   MEMVAR->WHASTA := NUMORD
   MEMVAR->WORD := "C"
   SCROLL(8, 1, 23, 78)
   SETPOS(8, 1)
   DEVPOS(12, 20)
   DEVOUT("MANEJA DESDE LA ORDEN ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WDESDE", "@Z 999,999", NIL, NIL):DISPLAY())
   DEVPOS(13, 20)
   DEVOUT("       HASTA LA ORDEN ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WHASTA", "@Z 999,999", NIL, NIL):DISPLAY())
   DEVPOS(14, 20)
   DEVOUT("Ordenado por <N>" + U + "mero de orden o <C>" + O + "digo ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WORD", "@!", {||WORD $ "CN"}, NIL):DISPLAY())
   SETCOLOR("+G")
   DEVPOS(14, 34)
   DEVOUT("N")
   DEVPOS(14, 54)
   DEVOUT("C")
   DEVPOS(12, 65)
   DEVOUT("ESC=cancela")
   SETCOLOR("+W")
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF LASTKEY() = 27

      MEMVAR->OPC := " "
      DBCLOSEALL()
      MEMVAR->WAB := "BASURA.DBF"
      BA()
      RETURN 

   ENDIF

   DEVPOS(17, 10)
   DEVOUT("Por favor espere otro momento...")
   DBEVAL({||DBDELETE()}, {||NUMORD < WDESDE .OR. NUMORD > WHASTA}, NIL, ;
         NIL, NIL, .F.)
   __DBPACK()

   IF LASTREC() < 1

      MEMVAR->OPC := " "
      DBCLOSEARE()
      MEMVAR->WAB := "BASURA.DBF"
      BA()
      RETURN 

   ENDIF

   MEMVAR->WAB := "BASURA1.DBF"
   BA()
   MEMVAR->WAB := "BASURA2.DBF"
   BA()
   __DBCOPYST("C:\BASURA1", {"CODPRO", "NUMORD", "NOMBREPT", "CORTE", ;
         "SELLADO", "RASGUE", "OBS", "LETORD", "CANTOT", "CANORD"})

   IF WORD = "C"

      MEMVAR->WAB := "BASURA.NTX"
      BA()
      DBEVAL({||FIELD->BASURA := VAL(CODPRO)}, NIL, NIL, NIL, NIL, .F.)
      __DBSORT("C:\BASURA2", {"BASURA", "NUMORD"}, NIL, NIL, NIL, NIL, .F.)
      DBCLOSEARE()

   ELSE

      __DBCOPY("C:\BASURA2", {}, NIL, NIL, NIL, NIL, .F., NIL)

   ENDIF

   IF WACT = "S"

      DBCLOSEARE()
      DBUSEAREA(.F., NIL, "C:\BASURA1", NIL, NIL, .F.)
      __DBAPP("C:\BASURA2", {}, NIL, NIL, NIL, NIL, .F., NIL)
      DBGOTOP()
      SET(3, 0)
      BROWSE()
      SET(3, 2)
      DBCLOSEARE()
      DBSELECTAR("1")
      DBUSEAREA(.F., NIL, "C:\BASURA1", NIL, NIL, .F.)
      ACOSE()
      MEMVAR->WAB := "COSTOS.NTX"
      BA()
      DBCREATEIN("C:\COSTOS.NTX", "LETORD", {||LETORD}, NIL)
      DBCLOSEARE()
      ACOSS()
      ORDLISTCLE()
      ORDLISTADD("C:\COSTOS.NTX")
      DBSELECTAR("1")

      DO WHILE  .NOT. EOF()

         MEMVAR->WORD := LETORD
         MEMVAR->WCORTE := CORTE
         MEMVAR->WSELLADO := SELLADO
         MEMVAR->WRASGUE := RASGUE
         MEMVAR->WOBS := OBS
         DBSELECTAR("13")
         DBSEEK("&WORD")

         IF  .NOT. EOF()

            VEALOCK()
            FIELD->CORTE := WCORTE
            FIELD->SELLADO := WSELLADO
            FIELD->RASGUE := WRASGUE
            FIELD->OBS := WOBS

         ENDIF

         DBSELECTAR("1")
         DBSKIP(1)

      ENDDO

      DBSELECTAR("13")
      DBCLOSEARE()
      DBSELECTAR("1")

   ELSE

      DBSELECTAR("1")
      DBCLOSEARE()
      DBUSEAREA(.F., NIL, "C:\BASURA2", NIL, NIL, .F.)

   ENDIF

   SCROLL(8, 1, 23, 78)
   MEMVAR->OPC := ( SETPOS(8, 1), " " )
   DEVPOS(14, 20)
   DEVOUT("Contin" + U + "a con la impresi" + O + "n del informe ? S/N")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC = "N" .OR. LASTKEY() = 27

      DBCLOSEARE()
      MEMVAR->OPC := " "
      MEMVAR->WAB := "BASURA1.DBF"
      BA()
      MEMVAR->WAB := "BASURA2.DBF"
      BA()
      MEMVAR->WAB := "COSTOS.NTX"
      BA()
      RETURN 

   ENDIF

   SCROLL(8, 1, 23, 78)
   SETPOS(8, 1)
   DBGOTOP()
   PIDEIMP()
   SCROLL(7, 1, 23, 78)
   SETPOS(7, 1)
   SETCOLOR("*+G")
   DEVPOS(12, 1)
   DEVOUT(PADC("* * IMPRIMIENDO * *", 78))
   SETCOLOR("+W")
   MEMVAR->CL := MEMVAR->CP := 0
   MEMVAR->OPC := " "
   MEMVAR->WL := 141
   MEMVAR->RAYA := REPLICATE("-", WL)
   ENIM()
   DEVPOS(CL, 1)
   DEVOUT(CHR(15)+" ")
   MEMVAR->CR := 0

   DO WHILE  .NOT. EOF()

      IF CL = 0

         ++MEMVAR->CP
         DEVPOS(CL, 0)
         DEVOUT(RAYA)
         ++MEMVAR->CL
         DEVPOS(CL, (WL - LEN(RAZON)) / 2)
         DEVOUT(RAZON)
         ++MEMVAR->CL
         DEVPOS(CL, 1)
         DEVOUT(PADC("SISTEMA DE COSTOS DE PRODUCCION", WL))
         ++MEMVAR->CL
         DEVPOS(CL, 1)
         DEVOUT(PADC("INFORME DE UBICACION DE ORDENES DE PRODUCCION", WL))
         ++MEMVAR->CL
         DEVPOS(CL, 1)
         DEVOUT("INFORME A: " + DTOC(DATE()))
         MEMVAR->WT1 := "PAGINA: " + ALLTRIM(TRANSFORM(CP, "999999"))
         DEVPOS(CL, WL - LEN(WT1))
         DEVOUT(WT1)
         ++MEMVAR->CL
         DEVPOS(CL, 0)
         DEVOUT(RAYA)
         ++MEMVAR->CL
         DEVPOS(CL, 1)
         DEVOUT(;
               "COD.   # OP   PEND. ORIGINAL   PRODUCTO                        CORTE     SELLADO     RASGUE     OBSERVACIONES";
               )
         ++MEMVAR->CL

      ENDIF

      DEVPOS(CL, 1)
      DEVOUT(CODPRO + " " + TRANSFORM(NUMORD, "999999") + " " + TRANSFORM(;
            CANORD, "999,999") + " " + TRANSFORM(CANPED, "999,999") + " " +;
             NOMBREPT + " |" + CORTE + " |" + SELLADO + " |" + RASGUE + ;
            "| " + OBS)
      ++MEMVAR->CL
      ++MEMVAR->CR

      IF CR = 3

         DEVPOS(CL, 1)
         DEVOUT(RAYA)
         ++MEMVAR->CL
         MEMVAR->CR := 0

      ENDIF

      DBSKIP(1)

      IF CL > 60

         DEVPOS(CL, 0)
         DEVOUT(RAYA)
         MEMVAR->CL := 0

      ENDIF

   ENDDO

   ++MEMVAR->CL
   DEVPOS(CL, 0)
   DEVOUT(RAYA)
   ++MEMVAR->CL
   DEVPOS(CL, 1)
   DEVOUT("* *  FIN DEL INFORME  * *")
   DEVPOS(CL + 1, 1)
   DEVOUT(DTOC(DATE()) + " / " + TIME())
   DEVPOS(CL + 1, 1)
   DEVOUT(CHR(18)+" ")
   __EJECT()
   APIM()
   DBCLOSEARE()
   MEMVAR->WAB := "BASURA1.DBF"
   BA()
   MEMVAR->WAB := "BASURA2.DBF"
   BA()
   MEMVAR->WAB := "COSTOS.NTX"
   BA()
   MEMVAR->OPC := " "

RETURN 

