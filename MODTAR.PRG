/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MODTAR
   Params: None.
   Return: Undefined
  Example: MODTAR()
  ..........................................................................
*/

PROCEDURE MODTAR()

   SET(17, "OFF")
   MENU()
   MEMVAR->WCLA := "        "
   DEVPOS(12, 20)
   DEVOUT("POR FAVOR DEME SU CLAVE ")
   MEMVAR->WCLA := __ACCEPT()
   SET(17, "OFF")
   MEMVAR->OPC := " "
   __MRESTORE("DATO", .T.)

   IF ALLTRIM(WCLA) <> ALLTRIM(DATO)

      __MRELEASE("DATO?", .T.)
      SETCOLOR("*+GR")
      DEVPOS(14, 20)
      DEVOUT("CLAVE ERRADA, ACCESO NEGADO ")
      MEMVAR->X := INKEY(0)
      SETCOLOR("+W")
      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   __MRELEASE("DATO?", .T.)
   SET(17, "ON")
   AINTA()
   SET(3, 0)
   MEMVAR->WCODART := ZLCPT
   MEMVAR->BLANCOS := "                                            "

   DO WHILE OPC <> "N"

      MENU()
      DEVPOS(3, 1)
      DEVOUT(PADC("MODIFICACION DE TAREAS POR PRODUCTO", 78))
      DEVPOS(12, 20)
      DEVOUT("Por favor deme el c¢digo del art¡culo")
      DEVPOS(13, 20)
      DEVOUT("a modificar la tarea ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCODART", NIL, NIL, NIL):DISPLAY())
      DEVPOS(13, 50)
      DEVOUT("Espacios o ESC para terminar")
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      SCROLL(13, 1, 13, 79)
      SETPOS(13, 1)

      IF WCODART = ZLCPT .OR. WCODART = "*" .OR. LASTKEY() = 27

         MEMVAR->OPC := "N"
         LOOP

      ENDIF

      AMAPAS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
      DBSEEK("&WCODART")

      IF EOF()

         DBCLOSEARE()
         SETCOLOR("+W/R")
         DEVPOS(15, 20)
         DEVOUT("CODIGO PRODUCTO NO EXISTE")
         MEMVAR->X := INKEY(0)
         LOOP

      ENDIF

      MEMVAR->WNOMBRE := NOMBRE
      DBCLOSEARE()
      SCROLL(12, 20, 13, 60)
      SETPOS(12, 20)
      SETCOLOR("+BG")
      DEVPOS(7, 20)
      DEVOUT("ARTICULO " + WCODART + "  " + WNOMBRE)
      SETCOLOR("+W")
      MEMVAR->MASTAR := "S"
      MEMVAR->WCONTA := " "

      DO WHILE MASTAR <> "N"

         MEMVAR->WTAR := "  "
         SCROLL(12, 1, 23, 78)
         SETPOS(12, 1)
         DEVPOS(12, 20)
         DEVOUT("CODIGO DE LA TAREA ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WTAR", "@!", NIL, NIL):DISPLAY())
         SETCOLOR("+G")
         DEVPOS(14, 20)
         DEVOUT("ESC para terminar")
         SETCOLOR("+W")
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         SCROLL(14, 1, 23, 78)
         SETPOS(14, 1)

         IF WTAR = "*" .OR. WTAR = "  " .OR. LASTKEY() = 27

            MEMVAR->MASTAR := "N"
            LOOP

         ENDIF

         MEMVAR->WPROTARC := TRIM(WCODART) + TRIM(WTAR)
         MEMVAR->WPROTARC := PADR(WPROTARC, 9, "*")
         ATAS()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\PROTARCO")
         DBSEEK("&WPROTARC")

         IF EOF()

            DBCLOSEARE()
            DEVPOS(12, 45)
            DEVOUT("NO LA TIENE ESE PRODUCTO")
            MEMVAR->X := INKEY(0)
            LOOP

         ENDIF

         DEVPOS(12, 20)
         DEVOUT(BLANCOS)
         MEMVAR->WCAN := UNIDADESH
         MEMVAR->WCANXUNI := CANXUNI
         MEMVAR->WCONTA := CONTADORES
         MEMVAR->WPOS3 := RECNO()
         DBCLOSEARE()
         DEVPOS(12, 20)
         DEVOUT("       CODIGO DE LA TAREA ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WTAR", "@!", NIL, NIL):DISPLAY())
         DEVPOS(13, 20)
         DEVOUT("        CANTIDAD POR HORA ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCAN", "@Z 99,999.99", NIL, NIL);
               :DISPLAY())
         DEVPOS(14, 20)
         DEVOUT("CANTIDAD x UNIDAD DE P.T. ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCANXUNI", "@Z 99,999.9999", NIL, NIL);
               :DISPLAY())
         DEVPOS(15, 20)
         DEVOUT("Requiere contadores ? S/N ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCONTA", "@!", {||WCONTA $ "SN"}, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF WTAR = "*" .OR. WTAR = "  " .OR. LASTKEY() = 27

            MEMVAR->MASTAR := "N"
            LOOP

         ENDIF

         IF WCAN > 9999 .OR. WCAN < -9999

            DEVPOS(14, 20)
            DEVOUT("SOLO LE RECIBO HASTA 9999 ")
            DEVPOS(15, 20)
            DEVOUT("NO ACTUALIZO NADA.")
            MEMVAR->X := INKEY(0)
            DEVPOS(13, 20)
            DEVOUT(BLANCOS)
            DEVPOS(14, 20)
            DEVOUT(BLANCOS)
            DEVPOS(15, 20)
            DEVOUT(BLANCOS)
            MEMVAR->WCAN := 0
            LOOP

         ENDIF

         MEMVAR->WPROTARC := TRIM(WCODART) + TRIM(WTAR)
         MEMVAR->WPROTARC := PADR(WPROTARC, 9, "*")
         ATAS()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\PROTARCO")
         ESPERE()
         MEMVAR->CI := 0
         DBEVAL({||MEMVAR->CI := CI + 1}, {||PROTARCOL = WPROTARC}, NIL, ;
               NIL, NIL, .F.)
         SCROLL(22, 1, 23, 78)
         SETPOS(22, 1)

         IF CI > 1

            DBCLOSEARE()
            DEVPOS(12, 20)
            DEVOUT(BLANCOS)
            DEVPOS(13, 20)
            DEVOUT(BLANCOS)
            DEVPOS(12, 20)
            DEVOUT("YA ESTA CREADO, NO ACTUALIZO NADA")
            MEMVAR->X := INKEY(0)
            LOOP

         ENDIF

         DBGOTO(WPOS3)
         VEALOCK()
         FIELD->NUMPRO := VAL(CODPRO)
         FIELD->CODTAR := WTAR
         FIELD->UNIDADESH := WCAN
         FIELD->PROTARCOL := WPROTARC
         FIELD->CANXUNI := WCANXUNI
         FIELD->CONTADORES := WCONTA
         DBCLOSEARE()

      ENDDO

   ENDDO

   ESPERE()
   MEMVAR->OPC := " "
   CIERRE()
   SET(3, 2)
   ATAE()
   DBEVAL({||FIELD->PROTARCOL := TRIM(CODPRO) + TRIM(CODTAR) + "*******"}, ;
         NIL, NIL, NIL, NIL, .F.)
   BORPTC()
   DBCREATEIN("&ZDIS\&WDIRECTO\PROTARCO", "PROTARCOL", {||PROTARCOL}, NIL)
   DBCLOSEARE()

RETURN 

