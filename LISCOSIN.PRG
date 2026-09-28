/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LISCOSIN
   Params: None.
   Return: Undefined
  Example: LISCOSIN()
  ..........................................................................
*/

PROCEDURE LISCOSIN()

   MEMVAR->OPC := " "
   MENU()
   DEVPOS(4, 29)
   DEVOUT("LISTADO DE COSTOS POR INSUMO")
   DEVPOS(12, 18)
   DEVOUT("Por medio de esta opcion se emite un listado de")
   DEVPOS(13, 18)
   DEVOUT("cada uno de los productos del inventario, con")
   DEVPOS(14, 18)
   DEVOUT("sus respectivos insumos, relacionando en el, el")
   DEVPOS(15, 18)
   DEVOUT("costo de produccion y el precio real, asi como")
   DEVPOS(16, 18)
   DEVOUT("tambien los valores sugeridos para la lista de ")
   DEVPOS(17, 18)
   DEVOUT("precios de acuerdo con los porcentajes establecidos.")
   DEVPOS(19, 18)
   DEVOUT("Desea continuar ? s/n ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC = "N"

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   ESPERE()
   AMAPAS()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->WAB := "BASURA2.DBF"
   BA()
   __DBSORT("C:\BASURA", {"NUMART"}, NIL, NIL, NIL, NIL, .F.)
   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
   AMAINS()
   __DBSORT("C:\BASURA2", {"CODNUM"}, NIL, NIL, NIL, NIL, .F.)
   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "C:\BASURA2", NIL, NIL, .F.)
   DBSELECTAR("1")
   MEMVAR->WDESDE := NUMART
   DBGOBOTTOM()
   MEMVAR->WHASTA := NUMART
   MENU()
   DEVPOS(12, 5)
   DEVOUT("PARA PRODUCTO TERMINADO:")
   DEVPOS(13, 25)
   DEVOUT("DESDE QUE CODIGO LISTO ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WDESDE", "@Z 999999", NIL, NIL):DISPLAY())
   DEVPOS(14, 25)
   DEVOUT("HASTA QUE CODIGO LISTO ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WHASTA", "@Z 999999", NIL, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   ESPERE()
   DBSELECTAR("2")
   MEMVAR->WAB := "BASURA.NTX"
   BA()
   DBCREATEIN("C:\BASURA", "CODIGO", {||CODIGO}, NIL)
   DBSELECTAR("1")
   SET(11, "OFF")
   DBEVAL({||DBRECALL()}, NIL, NIL, NIL, NIL, .F.)
   DBEVAL({||DBDELETE()}, {||NUMART < WDESDE}, NIL, NIL, NIL, .F.)
   DBEVAL({||DBDELETE()}, {||NUMART > WHASTA}, NIL, NIL, NIL, .F.)
   SET(11, "ON")
   DBGOTOP()
   SCROLL(12, 1, 23, 78)
   SETPOS(12, 1)
   SETCOLOR("*G")
   DEVPOS(12, 20)
   DEVOUT("*** IMPRIMIENDO ***")
   VEAIMP()
   ENIM()
   MEMVAR->WRAYA := REPLICATE("Ä", 80)
   MEMVAR->CP := MEMVAR->CL := MEMVAR->SWART := 0
   __MRESTORE("&ZDIS\&WDIRECTO\COSDIR", .T.)

   DO WHILE  .NOT. EOF()

      IF CL = 0

         MEMVAR->CP := MEMVAR->CP + 1
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 30)
         DEVOUT(RAZON)
         MEMVAR->CL := MEMVAR->CL + 2
         DEVPOS(CL, 12)
         DEVOUT("RELACION DE PRODUCTO TERMINADO CON SUS INSUMOS Y COSTOS")
         MEMVAR->CL := MEMVAR->CL + 2
         DEVPOS(CL, 1)
         DEVOUT("FECHA DEL INFORME: " + DTOC(DATE()))
         DEVPOS(CL, 60)
         DEVOUT("PAGINA Nro: ")
         DEVPOS(CL, 73)
         DEVOUTPICT(CP, "@# 99")
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 0)
         DEVOUT(WRAYA)
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 1)
         DEVOUT(;
               "INSUMO      NOMBRE       COSTO UNIDAD      COSTO EN PRODUCTO";
               )
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 0)
         DEVOUT(WRAYA)
         MEMVAR->CL := MEMVAR->CL + 1
         MEMVAR->SWART := 0

      ENDIF

      IF CL > 54

         DEVPOS(1, 1)
         DEVOUT(" ")
         MEMVAR->CL := 0
         LOOP

      ENDIF

      IF SWART = 0

         DEVPOS(CL, 1)
         DEVOUT("ARTICULO: " + CODART + " " + NOMBRE)
         MEMVAR->CL := MEMVAR->CL + 1
         MEMVAR->SWART := 1

      ENDIF

      MEMVAR->WTOTINS := 0
      DEVPOS(CL, 1)
      DEVOUT("COSTOS Directos+Indirectos")
      MEMVAR->WMO := MO * COSDIR
      MEMVAR->WTOTINS := WTOTINS + WMO
      DEVPOS(CL, 30)
      DEVOUTPICT(MO, "@# 99,999.99")
      DEVPOS(CL, 50)
      DEVOUTPICT(WMO, "@# 99,999.99")
      MEMVAR->CL := MEMVAR->CL + 1
      MEMVAR->WCI := 1

      DO WHILE WCI < 21

         MEMVAR->WXCOD := "CODINS" + ALLTRIM(TRANSFORM(WCI, "99"))

         IF (&(MEMVAR->WXCOD)) = "    "

            MEMVAR->WCI := MEMVAR->WCI + 1
            LOOP

         ELSE

            DEVPOS(CL, 1)
            DEVOUT((&(MEMVAR->WXCOD)))
            MEMVAR->WCOD := (&(MEMVAR->WXCOD))
            DBSELECTAR("2")
            DBSEEK("&WCOD")

            IF  .NOT. EOF()

               MEMVAR->WNOM := NOMFASOR
               MEMVAR->WCOS := COSTO1

            ELSE

               MEMVAR->WNOM := "NOM. NO ENCONTRADO  "
               MEMVAR->WCOS := 0

            ENDIF

            DBSELECTAR("1")
            DEVPOS(CL, 6)
            DEVOUT(WNOM)
            DEVPOS(CL, 30)
            DEVOUTPICT(WCOS, "@# 99,999.99")
            MEMVAR->WXCAN := "CAN" + ALLTRIM(TRANSFORM(WCI, "99"))
            MEMVAR->WTOT := WCOS * (&(MEMVAR->WXCAN))
            DEVPOS(CL, 50)
            DEVOUTPICT(WTOT, "@# 99,999.99")
            MEMVAR->WTOTINS := WTOTINS + WTOT
            MEMVAR->CL := MEMVAR->CL + 1
            MEMVAR->WCI := MEMVAR->WCI + 1

         ENDIF

      ENDDO

      MEMVAR->WP1 := WTOTINS * PORC1 / 100 + WTOTINS
      MEMVAR->WP2 := WTOTINS * PORC2 / 100 + WTOTINS
      MEMVAR->WP3 := WTOTINS * PORC3 / 100 + WTOTINS
      DEVPOS(CL, 50)
      DEVOUT("==========")
      MEMVAR->CL := MEMVAR->CL + 1
      DEVPOS(CL, 68)
      DEVOUT(CHR(27)+CHR(15))
      DEVPOS(CL, 1)
      DEVOUTPICT(PORC1, "@# 999.99")
      DEVPOS(CL, 7)
      DEVOUT("%=")
      DEVPOS(CL, 10)
      DEVOUTPICT(WP1, "@# $$,$$$.$$")
      DEVPOS(CL, 20)
      DEVOUTPICT(PORC2, "@# 999.99")
      DEVPOS(CL, 26)
      DEVOUT("%=")
      DEVPOS(CL, 29)
      DEVOUTPICT(WP2, "@# $$,$$$.$$")
      DEVPOS(CL, 39)
      DEVOUTPICT(PORC3, "@# 999.99")
      DEVPOS(CL, 45)
      DEVOUT("%=")
      DEVPOS(CL, 48)
      DEVOUTPICT(WP3, "@# $$,$$$.$$")
      DEVPOS(CL, 48)
      DEVOUT(CHR(18)+" ")
      DEVPOS(CL, 49)
      DEVOUTPICT(WTOTINS, "@# 999,999.99")
      MEMVAR->CL := MEMVAR->CL + 1
      DEVPOS(CL, 0)
      DEVOUT(WRAYA)
      MEMVAR->CL := MEMVAR->CL + 1

      IF CL > 54

         MEMVAR->CL := 0
         DEVPOS(CL, 1)
         DEVOUT(" ")

      ENDIF

      MEMVAR->SWART := 0
      DBSKIP(1)

   ENDDO

   DEVPOS(1, 1)
   DEVOUT(" ")
   APIM()
   CIERRE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->WAB := "BASURA2.DBF"
   BA()
   MEMVAR->WAB := "BASURA.NTX"
   BA()
   MEMVAR->OPC := " "

RETURN 

