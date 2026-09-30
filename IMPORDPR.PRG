/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: IMPORDPR
   Params: None.
   Return: Undefined
  Example: IMPORDPR()
  ..........................................................................
*/

PROCEDURE IMPORDPR()

   ESPERE()
   MEMVAR->WAB := "COSTOS.NTX"
   BA()
   ACOSE()
   DBCREATEIN("C:\PROTMP\COSTOS.NTX", "NUMORD", {||NUMORD}, NIL)
   DBCLOSEARE()
   MEMVAR->OPC := " "
   __MRESTORE("&ZDIS\&WDIRECTO\COSDIR", .T.)
   MEMVAR->WCOSTO := COSDIR
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   __COPYFILE("&ZDIS\&WDIRECTO\ORDPRTEM.DBF", "C:\PROTMP\BASURA.DBF")
   DBSELECTAR("5")
   DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, .F., .F.)
   AMAPAE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
   ORDLISTREB()
   DBCLOSEARE()
   MEMVAR->OPC := " "
   MENU()
   DEVPOS(4, 23)
   DEVOUT("IMPRESION DE ORDENES DE PRODUCCION")
   DBSELECTAR("5")

   DO WHILE  .NOT. EOF()

      MEMVAR->WVCOD := VAL(CODPRO)

      IF WVCOD > 5999 .AND. WVCOD < 7000

         DBDELETE()

      ENDIF

      DBSKIP(1)

   ENDDO

   __DBPACK()
   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, .F., .F.)
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
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   SETCOLOR("+W")

   IF WINI = 0 .OR. LASTKEY() = 27

      MEMVAR->OPC := " "
      DBCLOSEARE()
      MEMVAR->WAB := "BASURA.DBF"
      BA()
      RETURN 

   ENDIF

   ESPERE()
   SET(11, "OFF")
   DBEVAL({||DBRECALL()}, NIL, NIL, NIL, NIL, .F.)
   DBEVAL({||DBDELETE()}, {||NUMORD < WINI .OR. NUMORD > WFIN}, NIL, NIL, ;
         NIL, .F.)
   SET(11, "ON")
   DBGOTOP()
   PIDEIMP()
   VEAIMP()

   IF LASTKEY() = 27

      DBCLOSEARE()
      MEMVAR->WAB := "BASURA.DBF"
      BA()
      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   MEMVAR->RAYA := REPLICATE("Ä", 78)
   MEMVAR->RARA := REPLICATE("°", 78)

   DO WHILE  .NOT. EOF()

      MEMVAR->CL := MEMVAR->CC := 0
      MEMVAR->WNUMORD := NUMORD
      MEMVAR->WUNIDAD := UNIDAD
      MEMVAR->WPOS := RECNO()
      ENIM()

      DO WHILE CC < 2

         DBSELECTAR("5")
         MEMVAR->WCODPRO := CODPRO
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
               DEVOUT("Codigo del producto " + CODPRO)
               DEVPOS(CL, 79)
               DEVOUT("³")
               MEMVAR->CL := MEMVAR->CL + 1
               DEVPOS(CL, 0)
               DEVOUT("³")
               DEVPOS(CL, 1)
               DEVOUT("Cant. a Fabricar " + ALLTRIM(TRANSFORM(WCANTOT, ;
                     "99,999,999")))
               DEVPOS(CL, 50)
               DEVOUT("FECHA: ")
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
                     "NOMBRE              CODIGO  COLOR FECHA ENT.  Cant.   Vr.Unit.    Vr. Tot.";
                     )
               DEVPOS(CL, 79)
               DEVOUT("³")
               MEMVAR->CL := CL + 1
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
               DEVOUTPICT(CANORD, "@# 99,999")
               DEVPOS(CL, 31)
               DEVOUT(SUBSTR(COLOR, 1, 4))

            ELSE

               DEVPOS(CL, 27)
               DEVOUT("TRANSP.")

            ENDIF

            DEVPOS(CL, 35)
            DEVOUT("__________")
            DEVPOS(CL, 44)
            DEVOUTPICT(CANINV, "@# 99,999.99")
            DEVPOS(CL, 55)
            DEVOUTPICT(VALUNI, "@# $$,$$$.$$")
            DEVPOS(CL, 66)
            DEVOUTPICT(VALTOT, "@# $$$$,$$$.$$")
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
         DEVOUT("Cos/U.M.P.")
         DEVPOS(CL, 33)
         DEVOUTPICT(WSUMTOT / WCANTOT, "@# $$,$$$.$$")
         DEVPOS(CL, 43)
         DEVOUT("C/Dir+Ind. ")
         DEVPOS(CL, 54)
         DEVOUTPICT(WMO * WCOSTO, "@# $$$,$$$.$$")
         DEVPOS(CL, 64)
         DEVOUT("C/Tot.")
         DEVPOS(CL, 70)
         DEVOUTPICT(WSUMTOT / WCANTOT + WMO * WCOSTO, "@# $$$,$$$.$$")
         MEMVAR->WCOSEST := IF(WCANTOT <> 0, WSUMTOT / WCANTOT + WMO * ;
               WCOSTO, WSUMTOT + WMO * WCOSTO)
         DEVPOS(CL, 9)
         DEVOUTPICT(WSUMTOT, "@# $$$$$,$$$.$$")
         DEVPOS(CL, 33)
         DEVOUTPICT(WSUMTOT / WCANTOT, "@# $$,$$$.$$")
         DEVPOS(CL, 54)
         DEVOUTPICT(WMO * WCOSTO, "@# $$$,$$$.$$")
         DEVPOS(CL, 70)
         DEVOUTPICT(WSUMTOT / WCANTOT + WMO * WCOSTO, "@# $$$,$$$.$$")
         DEVPOS(CL, 1)
         DEVOUT(" ")
         APIM()

         IF CC = 0

            ACOSE()
            ORDLISTCLE()
            ORDLISTADD("C:\PROTMP\COSTOS.NTX")
            __DBLOCATE({||NUMORD = WWNUMORD}, NIL, NIL, NIL, .F.)

            IF  .NOT. EOF()

               VEALOCK()
               FIELD->COSEST := WCOSEST

            ENDIF

            DBCLOSEARE()
            DBSELECTAR("5")
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

   SET(11, "OFF")
   DBSELECTAR("5")
   DBCLOSEARE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   __MRESTORE("&ZDIS\&WDIRECTO\LETRAS", .T.)
   MEMVAR->OPC := " "

RETURN 

