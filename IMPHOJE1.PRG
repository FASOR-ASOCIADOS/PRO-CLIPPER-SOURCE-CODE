/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: IMPHOJE1
   Params: None.
   Return: Undefined
  Example: IMPHOJE1()
  ..........................................................................
*/

PROCEDURE IMPHOJE1()

   MEMVAR->OPC := " "
   MENU()
   DEVPOS(12, 20)
   DEVOUT("Ahora se imprimir" + A + ;
         "n las hojas de empaque con cantidades")
   DEVPOS(13, 20)
   DEVOUT("m" + A + "xima de 14 r" + O + "tulos por referencia.")
   DEVPOS(15, 20)
   DEVOUT("desea continuar ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC = "N" .OR. LASTKEY() = 27

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   ESPERE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->WAB := "BASURA5.DBF"
   BA()
   AOPTES()
   __DBCOPYST("C:\BASURA", {})
   __DBCOPY("C:\BASURA5", {}, NIL, NIL, NIL, NIL, .F., NIL)
   DBCLOSEARE()
   DBSELECTAR("2")
   DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
   DBSELECTAR("5")
   DBUSEAREA(.F., NIL, "C:\BASURA5", NIL, NIL, .F.)

   DO WHILE  .NOT. EOF()

      IF SUBSTR(UNIDAD, 1, 3) = "PAQ" .OR. SUBSTR(UNIDAD, 2, 3) = "PAQ"

         DBSKIP(1)
         LOOP

      ENDIF

      IF SUBSTR(UNIDAD, 3, 3) = "PAQ" .OR. SUBSTR(UNIDAD, 4, 3) = "PAQ"

         DBSKIP(1)
         LOOP

      ENDIF

      IF SUBSTR(UNIDAD, 5, 3) = "PAQ" .OR. SUBSTR(UNIDAD, 6, 3) = "PAQ"

         DBSKIP(1)
         LOOP

      ENDIF

      MEMVAR->WCANORD := CANORD
      MEMVAR->WNUMORD := NUMORD
      MEMVAR->WCODPRO := CODPRO
      MEMVAR->WFECHA := FECHA
      MEMVAR->WNOMBRE := NOMBREPT
      MEMVAR->WUNIDAD := UNIDAD
      MEMVAR->WCANORD := CANORD

      IF SUBSTR(UNIDAD, 1, 3) = "100"

         MEMVAR->WCANREC := INT(CANORD / 100) + 1
         DBSELECTAR("2")
         MEMVAR->CR := 1

         DO WHILE CR < WCANREC

            DBAPPEND()
            FIELD->CODPRO := WCODPRO
            FIELD->NOMBREPT := WNOMBRE
            FIELD->NUMORD := WNUMORD
            FIELD->FECHA := WFECHA
            FIELD->CANORD := WCANORD
            FIELD->UNIDAD := "100"
            MEMVAR->CR := MEMVAR->CR + 1

         ENDDO

      ELSEIF SUBSTR(UNIDAD, 1, 3) = "10X"

         MEMVAR->WCANREC := INT(CANORD / 10) + 1
         DBSELECTAR("2")
         MEMVAR->CR := 1

         DO WHILE CR < WCANREC

            DBAPPEND()
            FIELD->CODPRO := WCODPRO
            FIELD->NOMBREPT := WNOMBRE
            FIELD->NUMORD := WNUMORD
            FIELD->FECHA := WFECHA
            FIELD->CANORD := WCANORD
            FIELD->UNIDAD := "10"
            MEMVAR->CR := MEMVAR->CR + 1

         ENDDO

      ELSE

         MEMVAR->WCANREC := INT(CANORD / VAL(SUBSTR(WUNIDAD, 1, 4))) + 1
         DBSELECTAR("2")
         MEMVAR->CR := 1

         DO WHILE CR < WCANREC

            DBAPPEND()
            FIELD->CODPRO := WCODPRO
            FIELD->NOMBREPT := WNOMBRE
            FIELD->NUMORD := WNUMORD
            FIELD->FECHA := WFECHA
            FIELD->CANORD := WCANORD
            FIELD->UNIDAD := STR(VAL(SUBSTR(WUNIDAD, 1, 4)))
            MEMVAR->CR := MEMVAR->CR + 1

         ENDDO

      ENDIF

      DBSELECTAR("5")

      DO WHILE NUMORD = WNUMORD

         DBSKIP(1)

         IF EOF()

            EXIT

         ENDIF

      ENDDO

   ENDDO

   DBSELECTAR("2")
   DBEVAL({||FIELD->CANINV := 0}, NIL, NIL, NIL, NIL, .F.)
   DBGOTOP()

   DO WHILE  .NOT. EOF()

      __DBLOCATE({||CANINV = 0}, NIL, NIL, NIL, .F.)

      IF EOF()

         LOOP

      ENDIF

      MEMVAR->WNUMORD := NUMORD
      MEMVAR->TC := 0
      DBEVAL({||MEMVAR->TC := TC + 1}, {||NUMORD = WNUMORD}, NIL, NIL, NIL, ;
            .F.)
      DBEVAL({||FIELD->CANINV := TC}, {||NUMORD = WNUMORD}, NIL, NIL, NIL, ;
            .F.)
      DBGOTOP()

   ENDDO

   MEMVAR->WAB := "BASURA2.DBF"
   BA()

   IF LASTREC() > 1

      __DBSORT("C:\BASURA2", {"CANINV", "NUMORD"}, NIL, NIL, NIL, NIL, .F.)

   ELSE

      __DBCOPY("C:\BASURA2", {}, NIL, NIL, NIL, NIL, .F., NIL)

   ENDIF

   CIERRE()
   DBSELECTAR("2")
   DBUSEAREA(.F., NIL, "C:\BASURA2", NIL, NIL, .F.)
   __DBLOCATE({||CANINV > 14}, NIL, NIL, NIL, .F.)

   IF  .NOT. EOF()

      DO WHILE  .NOT. EOF()

         MEMVAR->WNUMORD := NUMORD
         MEMVAR->SWPARE := MEMVAR->CR := 0

         DO WHILE SWPARE = 0

            MEMVAR->CR := MEMVAR->CR + 1

            IF CR > 14

               DBDELETE()

            ENDIF

            DBSKIP(1)

            IF EOF() .OR. WNUMORD <> NUMORD

               MEMVAR->SWPARE := 1
               LOOP

            ENDIF

         ENDDO

      ENDDO

      __DBPACK()
      DBSELECTAR("2")
      DBCLOSEARE()
      DBSELECTAR("2")
      DBUSEAREA(.F., NIL, "C:\BASURA2", NIL, NIL, .F.)
      MEMVAR->WAB := "BASURA.DBF"
      BA()
      __DBCOPY("C:\BASURA", {}, {||CANINV > 14}, NIL, NIL, NIL, .F., NIL)
      DBEVAL({||DBDELETE()}, {||CANINV > 14}, NIL, NIL, NIL, .F.)
      __DBPACK()
      DBCLOSEARE()
      DBUSEAREA(.F., NIL, "C:\BASURA2", NIL, NIL, .F.)
      MEMVAR->WTH := LASTREC() / 14

      DO WHILE WTH <> INT(WTH)

         DBAPPEND()
         DBCLOSEARE()
         DBUSEAREA(.F., NIL, "C:\BASURA2", NIL, NIL, .F.)
         MEMVAR->WTH := LASTREC() / 14

      ENDDO

      __DBAPP("C:\BASURA", {}, NIL, NIL, NIL, NIL, .F., NIL)
      DBCLOSEARE()
      DBUSEAREA(.F., NIL, "C:\BASURA2", NIL, NIL, .F.)

   ENDIF

   DBGOTOP()
   MENU()
   SETCOLOR("G")
   DEVPOS(15, 10)
   DEVOUT("OPRIMA ALGUNA TECLA PARA INICIAR")
   MEMVAR->X := INKEY(0)
   SETCOLOR("+W")
   DEVPOS(15, 10)
   DEVOUT("                                   ")
   SETCOLOR("*+W/B")
   DEVPOS(15, 20)
   DEVOUT(" **  IMPRIMIENDO ** ")
   SETCOLOR("+W")
   MEMVAR->CP := 0
   MEMVAR->CC := 1
   MEMVAR->CL := 3
   MEMVAR->CCC := 44
   MEMVAR->OPC := " "
   VEAIMP()
   ENIM()
   MEMVAR->TOTREC := LASTREC()

   DO WHILE  .NOT. EOF()

      MEMVAR->CP := MEMVAR->CP + 1
      MEMVAR->CL := MEMVAR->CL + 1
      DEVPOS(CL, CC)
      DEVOUT("        CODIGO : " + CODPRO)

      IF TOTREC <> RECNO()

         DBSKIP(1)

         IF  .NOT. EOF()

            DEVPOS(CL, CCC)
            DEVOUT("        CODIGO : " + CODPRO)
            DBSKIP(-1)

         ENDIF

      ENDIF

      MEMVAR->CL := MEMVAR->CL + 1
      DEVPOS(CL, CC)
      DEVOUT("OPERARIO  ________________")

      IF TOTREC <> RECNO()

         DBSKIP(1)

         IF  .NOT. EOF()

            DEVPOS(CL, CCC)
            DEVOUT("OPERARIO  ________________")
            DBSKIP(-1)

         ENDIF

      ENDIF

      MEMVAR->CL := MEMVAR->CL + 1
      DEVPOS(CL, CC)
      DEVOUT("FECHA ")

      IF TOTREC <> RECNO()

         DBSKIP(1)

         IF  .NOT. EOF()

            DEVPOS(CL, CCC)
            DEVOUT("FECHA ")
            DBSKIP(-1)

         ENDIF

      ENDIF

      MEMVAR->CL := MEMVAR->CL + 1
      DEVPOS(CL, CC)
      DEVOUT("CANTIDAD  ______" + UNIDAD)

      IF TOTREC <> RECNO()

         DBSKIP(1)

         IF  .NOT. EOF()

            DEVPOS(CL, CCC)
            DEVOUT("CANTIDAD  ______" + UNIDAD)
            DBSKIP(-1)

         ENDIF

      ENDIF

      MEMVAR->CL := MEMVAR->CL + 1
      DEVPOS(CL, CC)
      DEVOUT("ARTICULO " + NOMBREPT)

      IF TOTREC <> RECNO()

         DBSKIP(1)

         IF  .NOT. EOF()

            MEMVAR->AA := ALLTRIM(NOMBREPT)

            IF LEN(AA) > 22

               DEVPOS(CL, CCC)
               DEVOUT("ARTICULO "+CHR(15) + ALLTRIM(NOMBREPT) + CHR(18) + ;
                     " ")

            ELSE

               DEVPOS(CL, CCC)
               DEVOUT("ARTICULO " + ALLTRIM(NOMBREPT))

            ENDIF

            DBSKIP(-1)

         ENDIF

      ENDIF

      MEMVAR->CL := MEMVAR->CL + 1
      DEVPOS(CL, CC)
      DEVOUT("ORDEN DE PRODUCCION " + ALLTRIM(TRANSFORM(NUMORD, "999999")))

      IF TOTREC <> RECNO()

         DBSKIP(1)

         IF  .NOT. EOF()

            DEVPOS(CL, CCC)
            DEVOUT("ORDEN DE PRODUCCION " + ALLTRIM(TRANSFORM(NUMORD, ;
                  "999999")))
            DBSKIP(-1)

         ENDIF

      ENDIF

      IF CL > 57

         MEMVAR->CL := 0
         DEVPOS(CL, 0)
         DEVOUT(" ")

      ENDIF

      DBSKIP(2)
      MEMVAR->CL := MEMVAR->CL + 3

   ENDDO

   DEVPOS(1, 1)
   DEVOUT(" ")
   APIM()
   CIERRE()
   MEMVAR->WAB := "FILETEMP.DBF"
   BA()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->WAB := "BASURA2.DBF"
   BA()
   MEMVAR->WAB := "BASURA5.DBF"
   BA()
   MEMVAR->OPC := " "

RETURN 

