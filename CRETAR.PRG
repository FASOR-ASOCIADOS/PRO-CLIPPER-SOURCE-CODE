/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: CRETAR
   Params: None.
   Return: Undefined
  Example: CRETAR()
  ..........................................................................
*/

PROCEDURE CRETAR()

   MEMVAR->OPC := " "
   AINTA()
   SET(3, 0)
   MEMVAR->WCODART := ZLCPT
   MEMVAR->BLANCOS := "                                            "

   DO WHILE OPC <> "N"

      MENU()
      DEVPOS(3, 1)
      DEVOUT(PADC("CREACION DE TAREAS POR PRODUCTO", 78))
      DEVPOS(12, 20)
      DEVOUT("Por favor deme el c¢digo del art¡culo")
      DEVPOS(13, 20)
      DEVOUT("a crearle la tarea ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCODART", NIL, NIL, NIL):DISPLAY())
      SETCOLOR("+G")
      DEVPOS(15, 20)
      DEVOUT("* o ESC para terminar")
      SETCOLOR("+W")
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      SCROLL(14, 20, 14, 78)
      SETPOS(14, 20)

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
         MEMVAR->OPC := " "
         DEVPOS(15, 20)
         DEVOUT("CODIGO NO EXISTE, TIENE MAS ? S/N ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         LOOP

      ENDIF

      MEMVAR->WNOMBRE := NOMBRE
      DBCLOSEARE()
      SCROLL(12, 20, 23, 60)
      SETPOS(12, 20)
      SETCOLOR("+BG")
      DEVPOS(7, 20)
      DEVOUT("ARTICULO " + WCODART + "  " + WNOMBRE)
      SETCOLOR("+W")
      MEMVAR->MASTAR := "S"
      MEMVAR->WCONTA := " "

      DO WHILE MASTAR <> "N"

         SCROLL(8, 1, 23, 60)
         MEMVAR->WTAR := ( SETPOS(8, 1), "  " )
         DEVPOS(12, 20)
         DEVOUT("CODIGO DE LA TAREA ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WTAR", "@!", NIL, NIL):DISPLAY())
         SETCOLOR("+G")
         DEVPOS(14, 20)
         DEVOUT("* o ESC para terminar")
         SETCOLOR("+W")
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         SCROLL(13, 1, 14, 78)
         SETPOS(13, 1)

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

         IF  .NOT. EOF()

            DBCLOSEARE()
            DEVPOS(13, 20)
            DEVOUT("ESTE YA ESTA CREADO ")
            MEMVAR->X := INKEY(0)
            DEVPOS(13, 20)
            DEVOUT(BLANCOS)
            LOOP

         ENDIF

         DBCLOSEARE()
         MEMVAR->WCAN := MEMVAR->WCANXUNI := 0
         DEVPOS(13, 10)
         DEVOUT("                         Cantidad por hora")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCAN", "@Z 99,999.99", NIL, NIL);
               :DISPLAY())
         DEVPOS(14, 10)
         DEVOUT("Cantidad de la tarea por unidad de p.t. ? ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCANXUNI", "@Z 99,999.9999", NIL, NIL);
               :DISPLAY())
         DEVPOS(15, 10)
         DEVOUT("                Requiere contadores ? S/N ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCONTA", "@!", {||WCONTA $ "SN"}, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         SCROLL(13, 1, 23, 78)
         SETPOS(13, 1)

         IF WCAN > 9999 .OR. WCAN < -9999

            DEVPOS(14, 20)
            DEVOUT("SOLO LE RECIBO HASTA 9999 ")
            DEVPOS(15, 20)
            DEVOUT("NO ACTUALIZO NADA.")
            MEMVAR->X := INKEY(0)
            MEMVAR->WCAN := 0
            LOOP

         ENDIF

         ATAS()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\PROTARCO")
         DBAPPEND()
         FIELD->CODPRO := WCODART
         FIELD->NUMPRO := VAL(WCODART)
         FIELD->CODTAR := WTAR
         FIELD->UNIDADESH := WCAN
         FIELD->PROTARCOL := WPROTARC
         FIELD->CANXUNI := WCANXUNI
         FIELD->CONTADORES := WCONTA
         DBCLOSEARE()

      ENDDO

   ENDDO

   MEMVAR->OPC := " "
   CIERRE()
   SET(3, 2)

RETURN 

