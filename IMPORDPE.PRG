/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: IMPORDPE
   Params: None.
   Return: Undefined
  Example: IMPORDPE()
  ..........................................................................
*/

PROCEDURE IMPORDPE()

   ESPERE()
   MEMVAR->WAB := "COSTOS.NTX"
   BA()
   ACOSE()
   DBCREATEIN("C:\COSTOS.NTX", "NUMORD", {||NUMORD}, NIL)
   DBCLOSEARE()
   SET(28, "ON")
   MEMVAR->OPC := " "
   AMAPAE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
   ORDLISTREB()
   DBCLOSEARE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   AOPTES()
   __DBCOPY("C:\BASURA", {}, NIL, NIL, NIL, NIL, .F., NIL)
   DBCLOSEARE()
   DBSELECTAR("5")
   DBUSEAREA(.F., NIL, "C:\BASURA", NIL, .F., .F.)

   DO WHILE  .NOT. EOF()

      MEMVAR->WVCOD := VAL(CODPRO)

      IF WVCOD < 6000 .OR. WVCOD > 6999

         DBDELETE()

      ENDIF

      DBSKIP(1)

   ENDDO

   __DBPACK()
   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "C:\BASURA", NIL, .F., .F.)
   MEMVAR->WOBS1 := MEMVAR->WOBS2 := MEMVAR->WOBS3 := SPACE(40)
   MEMVAR->OPC := " "
   MENU()
   DEVPOS(4, 16)
   DEVOUT("IMPRESION DE ORDENES DE PRODUCCION DE ESPECIALES")
   DBGOTOP()
   MEMVAR->WINI := NUMORD
   DBGOBOTTOM()
   MEMVAR->WFIN := NUMORD
   DEVPOS(12, 20)
   DEVOUT("Desde que orden imprimo ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WINI", "@Z 999999", NIL, NIL):DISPLAY())
   DEVPOS(13, 20)
   DEVOUT("Hasta que orden imprimo ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WFIN", "@Z 999999", NIL, NIL):DISPLAY())
   SETCOLOR("+G")
   DEVPOS(15, 30)
   DEVOUT("ESC para cancelar")
   SETCOLOR("+W")
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF WINI = 0 .OR. LASTKEY() = 27

      DBCLOSEARE()
      MEMVAR->WAB := "BASURA.DBF"
      BA()
      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   ESPERE()
   SET(11, "OFF")
   DBEVAL({||DBRECALL()}, NIL, NIL, NIL, NIL, .F.)
   DBEVAL({||DBDELETE()}, {||NUMORD < WINI .OR. NUMORD > WFIN}, NIL, NIL, ;
         NIL, .F.)
   SET(11, "ON")
   DBGOTOP()
   MENU()
   PIDEIMP()
   VEAIMP()

   IF LASTKEY() = 27

      DBCLOSEARE()
      MEMVAR->WAB := "BASURA.DBF"
      BA()
      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   MEMVAR->CL := 0
   MEMVAR->RAYA := REPLICATE("Ä", 78)
   MEMVAR->RARA := REPLICATE("°", 78)

   DO WHILE  .NOT. EOF()

      MEMVAR->CL := 0
      MEMVAR->WNUMORD := NUMORD
      MEMVAR->WCANPED := CANPED
      MEMVAR->WUNIDAD := UNIDAD
      MEMVAR->WPOS := RECNO()
      MEMVAR->CC := 0
      ENIM()

      DO WHILE CC < 2

         DBSELECTAR("5")
         MEMVAR->WCODPRO := CODPRO
         MEMVAR->WCOSDIR := COSDIR
         MEMVAR->ZCODUSU := CODUSU
         AMAPAS()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
         DBSEEK("&WCODPRO")

         IF  .NOT. EOF()

            MEMVAR->WMO := MO

         ELSE

            MEMVAR->WMO := 0

         ENDIF

         DBCLOSEARE()
         MEMVAR->ZNOMUSU := " "
         DBUSEAREA(.F., NIL, "CLIENTE.PRO", NIL, .T., .F.)
         __DBLOCATE({||COD = ZCODUSU}, NIL, NIL, NIL, .F.)

         IF  .NOT. EOF()

            MEMVAR->ZNOMUSU := NOMUSU

         ENDIF

         DBCLOSEARE()
         DBSELECTAR("5")
         MEMVAR->WSUMTOT := MEMVAR->WCANTOT := 0

         DO WHILE NUMORD = WNUMORD

            MEMVAR->WCANTOT := CANTOT

            IF CL = 0 .OR. CL = 33

               MEMVAR->CL := MEMVAR->CL + 1
               DEVPOS(CL, 30)
               DEVOUT(RAZON)
               MEMVAR->CL := MEMVAR->CL + 1
               DEVPOS(CL, 19)
               DEVOUT("S I S T E M A    D E   P R O D U C C I O N")
               MEMVAR->CL := MEMVAR->CL + 1
               DEVPOS(CL, 1)
               DEVOUT("ORDEN DE PRODUCCION NUMERO ")
               DEVPOS(CL, 29)
               DEVOUTPICT(NUMORD, "@# 99,999")
               MEMVAR->WWNUMORD := NUMORD
               DEVPOS(CL, 45)
               DEVOUT("EMPAQUE: ")

               IF SUBSTR(WUNIDAD, 1, 3) = "10X"

                  DEVPOS(CL, 54)
                  DEVOUT("Paquete X")
                  DEVPOS(CL, 64)
                  DEVOUT(SUBSTR(WUNIDAD, 1, 2))

               ELSEIF SUBSTR(WUNIDAD, 2, 3) = "10X"

                  DEVPOS(CL, 54)
                  DEVOUT("Paquete X")
                  DEVPOS(CL, 64)
                  DEVOUT(SUBSTR(WUNIDAD, 2, 2))

               ELSEIF WUNIDAD = "100"

                  DEVPOS(CL, 54)
                  DEVOUT("Bolsa  X ")
                  DEVPOS(CL, 64)
                  DEVOUT(SUBSTR(WUNIDAD, 1, 3))

               ELSEIF SUBSTR(WUNIDAD, 2, 3) = "100"

                  DEVPOS(CL, 54)
                  DEVOUT("Bolsa  X ")
                  DEVPOS(CL, 64)
                  DEVOUT(SUBSTR(WUNIDAD, 2, 3))

               ELSEIF WUNIDAD = "50"

                  DEVPOS(CL, 54)
                  DEVOUT("Bolsa  X ")
                  DEVPOS(CL, 64)
                  DEVOUT(SUBSTR(WUNIDAD, 1, 2))

               ELSEIF SUBSTR(WUNIDAD, 2, 3) = "50"

                  DEVPOS(CL, 54)
                  DEVOUT("Bolsa  X ")
                  DEVPOS(CL, 64)
                  DEVOUT(SUBSTR(WUNIDAD, 2, 2))

               ELSE

                  DEVPOS(CL, 64)
                  DEVOUT(WUNIDAD)

               ENDIF

               MEMVAR->CL := MEMVAR->CL + 1

               IF SURTIDO <> " "

                  DEVPOS(CL, 1)
                  DEVOUT("SURTIR")
                  DEVPOS(CL, 1)
                  DEVOUT("SURTIR")
                  DEVPOS(CL, 1)
                  DEVOUT("SURTIR")
                  DEVPOS(CL, 1)
                  DEVOUT("SURTIR")

               ENDIF

               DEVPOS(CL, 0)
               DEVOUT("Ú")
               DEVPOS(CL, 1)
               DEVOUT(RAYA)
               DEVPOS(CL, 79)
               DEVOUT("¿")
               MEMVAR->CL := MEMVAR->CL + 1
               DEVPOS(CL, 0)
               DEVOUT("³")
               DEVPOS(CL, 1)
               DEVOUT("NOMBRE : " + NOMBREPT)
               DEVPOS(CL, 50)
               DEVOUT("Codigo del producto " + ALLTRIM(CODPRO))
               DEVPOS(CL, 79)
               DEVOUT("³")
               MEMVAR->CL := MEMVAR->CL + 1
               DEVPOS(CL, 0)
               DEVOUT("³")
               DEVPOS(CL, 1)
               DEVOUT("Can. a Fabricar " + ALLTRIM(TRANSFORM(WCANTOT, ;
                     "99,999,999")))
               DEVPOS(CL, 28)
               DEVOUT("Cant. Pedida " + ALLTRIM(TRANSFORM(WCANPED, ;
                     "99,999,999")))
               DEVPOS(CL, 50)
               DEVOUT("FECHA:")
               DEVPOS(CL, PCOL())
               DEVOUT(FECHA)
               DEVPOS(CL, 79)
               DEVOUT("³")
               MEMVAR->CL := MEMVAR->CL + 1
               DEVPOS(CL, 0)
               DEVOUT("Ã")
               DEVPOS(CL, 1)
               DEVOUT(RAYA)
               DEVPOS(CL, 79)
               DEVOUT("´")
               MEMVAR->CL := MEMVAR->CL + 1
               DEVPOS(CL, 0)
               DEVOUT("³")
               DEVPOS(CL, 1)
               DEVOUT(;
                     "NOMBRE              COD. COLOR FEC.ENT.  Cant. Vr.Unit.  Vr. Tot. Cortes asi :";
                     )
               DEVPOS(CL, 79)
               DEVOUT("³")
               MEMVAR->CL := MEMVAR->CL + 1
               DEVPOS(CL, 0)
               DEVOUT("Ã")
               DEVPOS(CL, 1)
               DEVOUT(RAYA)
               DEVPOS(CL, 79)
               DEVOUT("´")
               MEMVAR->CL := MEMVAR->CL + 1

            ENDIF

            DEVPOS(CL, 0)
            DEVOUT("³")
            DEVPOS(CL, 1)
            DEVOUT(NOMINS)
            DEVPOS(CL, 21)
            DEVOUT(CODINS)

            IF NUMCOLOR <> " "

               DEVPOS(CL, 24)
               DEVOUTPICT(CANORD, "@# 9999")
               DEVPOS(CL, 28)
               DEVOUT(SUBSTR(COLOR, 1, 4))

            ELSE

               DEVPOS(CL, 25)
               DEVOUT("TRANSP.")

            ENDIF

            DEVPOS(CL, 32)
            DEVOUT("________")
            DEVPOS(CL, 37)
            DEVOUTPICT(CANINV, "@# 99,999.99")
            DEVPOS(CL, 47)
            DEVOUTPICT(VALUNI, "@# $$$$$$.$$")
            DEVPOS(CL, 57)
            DEVOUTPICT(VALTOT, "@# $$$$,$$$.$$")
            DEVPOS(CL, 68)
            DEVOUT(CHR(27)+CHR(15))

            IF ROL = "R"

               DEVPOS(CL, 71)
               DEVOUT("SALEN")
               DEVPOS(CL, 76)
               DEVOUTPICT(SALEN, "@# 99")
               DEVPOS(CL, 78)
               DEVOUT("x")
               DEVPOS(CL, 80)
               DEVOUTPICT(TIRAS, "@# 9.99")

            ELSEIF ROL = "L"

               DEVPOS(CL, 71)
               DEVOUT(TRIM(CORTE1) + "y" + TRIM(CORTE2))

            ENDIF

            DEVPOS(CL, 78)
            DEVOUT(CHR(18)+" ")
            MEMVAR->WSUMTOT := WSUMTOT + VALTOT
            DEVPOS(CL, 79)
            DEVOUT("³")
            MEMVAR->CL := MEMVAR->CL + 1
            DBSKIP(1)

         ENDDO

         DEVPOS(CL, 0)
         DEVOUT("À")
         DEVPOS(CL, 1)
         DEVOUT(RAYA)
         DEVPOS(CL, 79)
         DEVOUT("Ù")
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 1)
         DEVOUT("Tot.Ins.")
         DEVPOS(CL, 9)
         DEVOUTPICT(WSUMTOT, "@# $$$$$,$$$.$$")
         DEVPOS(CL, 23)
         DEVOUT("C/U.MP.")
         DEVPOS(CL, 30)
         DEVOUTPICT(WSUMTOT / WCANPED, "@# $$$$$,$$$.$$")
         DEVPOS(CL, 43)
         DEVOUT("Co/Dir+Ind.")
         DEVPOS(CL, 53)
         DEVOUTPICT(WCOSDIR, "@# $$,$$$.$$")
         DEVPOS(CL, 63)
         DEVOUT("C/T")
         DEVPOS(CL, 66)
         DEVOUTPICT(WSUMTOT / WCANPED + WCOSDIR, "@# $$$$$,$$$.$$")
         DEVPOS(CL, 9)
         DEVOUTPICT(WSUMTOT, "@# $$$$$,$$$.$$")
         DEVPOS(CL, 30)
         DEVOUTPICT(WSUMTOT / WCANPED, "@# $$$$$,$$$.$$")
         DEVPOS(CL, 53)
         DEVOUTPICT(WCOSDIR, "@# $$,$$$.$$")
         DEVPOS(CL, 66)
         DEVOUTPICT(WSUMTOT / WCANPED + WCOSDIR, "@# $$$$$,$$$.$$")
         DEVPOS(CL, 1)
         DEVOUT(" ")
         MEMVAR->WCOSEST := WSUMTOT / WCANPED + WCOSDIR
         APIM()

         IF CC = 0

            ACOSE()
            ORDLISTCLE()
            ORDLISTADD("C:\COSTOS.NTX")
            __DBLOCATE({||NUMORD = WWNUMORD}, NIL, NIL, NIL, .F.)

            IF  .NOT. EOF()

               VEALOCK()
               FIELD->COSEST := WCOSEST

            ENDIF

            DBCLOSEARE()
            SCROLL(5, 1, 23, 78)
            MEMVAR->WOBS1 := MEMVAR->WOBS2 := MEMVAR->WOBS3 := ( SETPOS(5, 1),;
                   SPACE(40) )
            SETCOLOR("+G")
            DEVPOS(16, 25)
            DEVOUT("ORDEN NUMERO ")
            DEVPOS(16, 39)
            DEVOUTPICT(WWNUMORD, "@# 999999")
            DEVPOS(18, 10)
            DEVOUT("Observaciones:")
            SETCOLOR("+B/+W")

            IF CL < 31

               SETPOS(19, 20)
               AADD(GETLIST, __GET(NIL, "WOBS1", NIL, NIL, NIL):DISPLAY())

               IF CL < 30

                  SETPOS(20, 20)
                  AADD(GETLIST, __GET(NIL, "WOBS2", NIL, NIL, NIL):DISPLAY(;
                        ))

                  IF CL < 29

                     SETPOS(21, 20)
                     AADD(GETLIST, __GET(NIL, "WOBS3", NIL, NIL, NIL);
                           :DISPLAY())

                  ENDIF

               ENDIF

               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}

            ENDIF

            SETCOLOR("+W")

         ENDIF

         ENIM()

         DO WHILE CL < 33

            DEVPOS(CL, 1)
            DEVOUT(" ")

            IF CL = 28 .AND. WOBS1 <> "    "

               DEVPOS(CL, 6)
               DEVOUT("Observaciones:")
               DEVPOS(CL, 20)
               DEVOUT(WOBS1)

            ENDIF

            IF CL = 29

               DEVPOS(CL, 20)
               DEVOUT(WOBS2)

            ENDIF

            IF CL = 30

               DEVPOS(CL, 20)
               DEVOUT(WOBS3)
               ++MEMVAR->CL
               DEVPOS(CL, 20)
               DEVOUT("Elaborada por :" + ALLTRIM(ZNOMUSU))

            ENDIF

            MEMVAR->CL := MEMVAR->CL + 1

         ENDDO

         IF CL > 33

            DO WHILE CL < 65

               DEVPOS(CL, 1)
               DEVOUT(" ")

               IF CL = 60 .AND. WOBS1 <> "    "

                  DEVPOS(CL, 6)
                  DEVOUT("Observaciones:")
                  DEVPOS(CL, 20)
                  DEVOUT(WOBS1)

               ENDIF

               IF CL = 61

                  DEVPOS(CL, 20)
                  DEVOUT(WOBS2)

               ENDIF

               IF CL = 62

                  DEVPOS(CL, 20)
                  DEVOUT(WOBS3)
                  ++MEMVAR->CL
                  DEVPOS(CL, 20)
                  DEVOUT("Elaborada por :" + ALLTRIM(ZNOMUSU))

               ENDIF

               MEMVAR->CL := MEMVAR->CL + 1

            ENDDO

         ENDIF

         IF CL < 50

            DEVPOS(CL, 0)
            DEVOUT(RAYA)

         ENDIF

         MEMVAR->CC := MEMVAR->CC + 1

         IF CC = 1

            DBSELECTAR("5")
            DBGOTO(WPOS)

         ENDIF

      ENDDO

      DEVPOS(0, 1)
      DEVOUT(" ")
      APIM()

   ENDDO

   CIERRE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->OPC := " "

RETURN 

