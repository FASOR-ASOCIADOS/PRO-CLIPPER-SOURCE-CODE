/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: CAMCODIN
   Params: None.
   Return: Undefined
  Example: CAMCODIN()
  ..........................................................................
*/

PROCEDURE CAMCODIN()

   MEMVAR->OPC := " "
   MEMVAR->WCLAVE := SPACE(8)
   SCROLL(5, 1, 23, 78)
   SETPOS(5, 1)
   SET(17, "OFF")
   __MRESTORE("DATO", .T.)

   IF DATO <> "CARLOSFDO"

      DEVPOS(12, 20)
      DEVOUT("POR FAVOR DEME LA CLAVE DE ACCESO ")
      MEMVAR->WCLAVE := __ACCEPT()

   ELSE

      MEMVAR->WCLAVE := DATO

   ENDIF

   SET(17, "ON")

   IF ALLTRIM(WCLAVE) <> ALLTRIM(DATO)

      __MRELEASE("DATO?", .T.)
      SETCOLOR("*W/R")
      DEVPOS(18, 20)
      DEVOUT("ACCESO NEGADO, CLAVE INCORRECTA  ")
      SETCOLOR("+W/G")
      DEVPOS(19, 20)
      DEVOUT("OPRIMA ALGUNA TECLA PARA REGRESAR")
      MEMVAR->X := INKEY(0)
      SETCOLOR("+W")
      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   __MRELEASE("DATO?", .T.)
   ININPR()
   SET(3, 5)

   DO WHILE OPC <> "N"

      MENU()
      DEVPOS(4, 22)
      DEVOUT("SUSTITUYENDO INSUMOS EN INSUMOS POR PRODUCTO")
      MEMVAR->WCODINSV := SPACE(4)
      MEMVAR->WCODINSN := SPACE(4)
      DEVPOS(12, 5)
      DEVOUT("c¢digo del insumo a reemplazar")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCODINSV", NIL, NIL, NIL):DISPLAY())
      DEVPOS(13, 5)
      DEVOUT("c¢digo del insumo nuevo       ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCODINSN", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      MEMVAR->SWSI1 := 1
      MEMVAR->SWSI2 := 1

      IF WCODINSV = "    " .OR. WCODINSN = "    "

         MEMVAR->OPC := "N"
         LOOP

      ENDIF

      AMAINS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
      SETCOLOR("+G")
      DBSEEK("&WCODINSV")

      IF  .NOT. EOF()

         DEVPOS(12, 45)
         DEVOUT(NOMFASOR)

      ELSE

         DEVPOS(12, 45)
         DEVOUT("NO EXISTE ")
         MEMVAR->SWSI1 := 0

      ENDIF

      DBSEEK("&WCODINSN")

      IF  .NOT. EOF()

         DEVPOS(13, 45)
         DEVOUT(NOMFASOR)

      ELSE

         DEVPOS(13, 45)
         DEVOUT("NO EXISTE ")
         MEMVAR->SWSI2 := 0

      ENDIF

      DBCLOSEARE()
      SETCOLOR("+W")

      IF SWSI1 = 0 .OR. SWSI2 = 0

         MEMVAR->OPC := " "
         DEVPOS(14, 10)
         DEVOUT("Revise sus codigos y vuelva a intentarlo. Pulse *  ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "OPC", NIL, {||OPC $ "*"}, NIL):DISPLAY();
               )
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         MEMVAR->OPC := " "
         RETURN 

      ENDIF

      MEMVAR->OPC := " "
      DEVPOS(14, 10)
      DEVOUT("Estan correctos los codigos ingresados ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "N"

         MEMVAR->OPC := " "
         RETURN 

      ENDIF

      MENU()
      DEVPOS(12, 10)
      DEVOUT(;
            "POR FAVOR ESPERE.... BUSCO PREEXISTENCIA DE LOS DOS CODIGOS...";
            )
      AMAPAS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
      MEMVAR->WAB := "BASURA.DBF"
      BA()
      __DBCOPY("C:\PROTMP\BASURA", {}, NIL, NIL, NIL, NIL, .F., NIL)
      DBCLOSEARE()
      DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)
      DBEVAL({||DBDELETE()}, NIL, NIL, NIL, NIL, .F.)
      SET(11, "OFF")
      DBGOTOP()
      MEMVAR->SWNOEXV := 1

      DO WHILE  .NOT. EOF()

         MEMVAR->WCI := 1
         MEMVAR->SWN := 0
         MEMVAR->SWV := 0

         DO WHILE WCI < 21

            MEMVAR->WYCOD := "CODINS" + ALLTRIM(TRANSFORM(WCI, "99"))

            IF (&(MEMVAR->WYCOD)) = WCODINSV

               MEMVAR->SWV := 1
               MEMVAR->SWNOEXV := 0

            ENDIF

            IF (&(MEMVAR->WYCOD)) = WCODINSN

               MEMVAR->SWN := 1

            ENDIF

            IF SWN = 1 .AND. SWV = 1

               DBRECALL()
               EXIT

            ENDIF

            MEMVAR->WCI := MEMVAR->WCI + 1

         ENDDO

         DBSKIP(1)

      ENDDO

      __DBPACK()
      DBCLOSEARE()
      DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)

      IF LASTREC() > 0

         MENU()
         SETCOLOR("*+GR")
         DEVPOS(10, 1)
         DEVOUT("!!! AVISO DE CANCELACION DE PROCESO  !!!")
         SETCOLOR("+W")
         DEVPOS(12, 10)
         DEVOUT("SI REEMPLAZARA EL CODIGO VIEJO CON EL NUEVO, EL NUEVO")
         DEVPOS(13, 10)
         DEVOUT(;
               "QUEDARIA REPETIDO EN LOS PRODUCTOS QUE MOSTRARE. Pulse * ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "OPC", NIL, {||OPC $ "*"}, NIL):DISPLAY();
               )
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         BROWSE()
         DBCLOSEARE()
         MEMVAR->WAB := "BASURA.DBF"
         BA()
         MEMVAR->OPC := " "
         RETURN 

      ENDIF

      DBCLOSEARE()
      MEMVAR->WAB := "BASURA.DBF"
      BA()

      IF SWNOEXV = 1

         MENU()
         SETCOLOR("*+GR")
         DEVPOS(10, 1)
         DEVOUT("!!! AVISO DE CANCELACION DE PROCESO  !!!")
         SETCOLOR("+W")
         DEVPOS(12, 10)
         DEVOUT("EL INSUMO QUE PIENSA REEMPLAZAR NO SE ENCUENTRA ASIGNADO")
         DEVPOS(13, 10)
         DEVOUT("A NINGUN PRODUCTO ACTUALMENTE.  Pulse * ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "OPC", NIL, {||OPC $ "*"}, NIL):DISPLAY();
               )
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         MEMVAR->OPC := " "
         RETURN 

      ENDIF

      MENU()
      DEVPOS(12, 10)
      DEVOUT(;
            "POR FAVOR ESPERE.... BUSCO PREEXISTENCIA DEL CODIGO NUEVO...")
      AMAPAS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
      MEMVAR->WAB := "BASURA.DBF"
      BA()
      __DBCOPY("C:\PROTMP\BASURA", {}, NIL, NIL, NIL, NIL, .F., NIL)
      DBCLOSEARE()
      DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)
      DBEVAL({||DBDELETE()}, NIL, NIL, NIL, NIL, .F.)
      SET(11, "OFF")
      DBGOTOP()

      DO WHILE  .NOT. EOF()

         MEMVAR->WCI := 1

         DO WHILE WCI < 21

            MEMVAR->WYCOD := "CODINS" + ALLTRIM(TRANSFORM(WCI, "99"))

            IF (&(MEMVAR->WYCOD)) = WCODINSN

               DBRECALL()
               EXIT

            ENDIF

            MEMVAR->WCI := MEMVAR->WCI + 1

         ENDDO

         DBSKIP(1)

      ENDDO

      __DBPACK()
      DBCLOSEARE()
      DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)

      IF LASTREC() > 0

         MENU()
         SETCOLOR("*+G")
         DEVPOS(10, 1)
         DEVOUT("!!!!   Aviso de advertencia de coherencia de datos !!")
         SETCOLOR("+W")
         DEVPOS(12, 10)
         DEVOUT("El codigo nuevo fue encontrado en algunos productos")
         DEVPOS(13, 10)
         DEVOUT(;
               "No se repetira en un mismo producto, pero ya se encuentra")
         DEVPOS(14, 10)
         DEVOUT("en algunos otros. Le mostrare en cuales. Pulse * ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "OPC", NIL, {||OPC $ "*"}, NIL):DISPLAY();
               )
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         BROWSE()
         DBCLOSEARE()
         MEMVAR->WAB := "BASURA.DBF"
         BA()
         MEMVAR->OPC := " "
         DEVPOS(16, 15)
         DEVOUT("Desea continuar con el proceso ? S/N ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF OPC = "N"

            MEMVAR->OPC := " "
            RETURN 

         ENDIF

      ENDIF

      MEMVAR->OPC := " "
      DBCLOSEARE()
      MEMVAR->WAB := "BASURA.DBF"
      BA()
      MENU()
      DEVPOS(12, 10)
      DEVOUT("POR FAVOR ESPERE.... REEMPLAZO LOS CODIGOS...")
      AMAPAS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
      SET(11, "OFF")
      DBGOTOP()

      DO WHILE  .NOT. EOF()

         MEMVAR->WCI := 1
         MEMVAR->SWSI := 0

         DO WHILE WCI < 21

            MEMVAR->WYCOD := "CODINS" + ALLTRIM(TRANSFORM(WCI, "99"))

            IF (&(MEMVAR->WYCOD)) = WCODINSV

               VEALOCK()
               FIELD->&(MEMVAR->WYCOD) := WCODINSN
               MEMVAR->SWSI := 1

            ENDIF

            MEMVAR->WCI := MEMVAR->WCI + 1

         ENDDO

         IF SWSI = 1

            ORGMAEPA()

         ENDIF

         DBSELECTAR("1")
         DBSKIP(1)

      ENDDO

      DBCLOSEARE()

   ENDDO

   MEMVAR->OPC := " "
   ININPR()
   SET(3, 2)

RETURN 

