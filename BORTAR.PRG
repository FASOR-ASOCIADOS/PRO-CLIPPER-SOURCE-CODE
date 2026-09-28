/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: BORTAR
   Params: None.
   Return: Undefined
  Example: BORTAR()
  ..........................................................................
*/

PROCEDURE BORTAR()

   MEMVAR->OPC := " "
   AINTA()
   SET(3, 0)
   MEMVAR->WCODART := ZLCPT
   MEMVAR->BLANCOS := "                                            "

   DO WHILE OPC <> "N"

      MENU()
      DEVPOS(3, 1)
      DEVOUT(PADC("BORRADO DE PAGOS DE TAREAS", 78))
      DEVPOS(12, 20)
      DEVOUT("Por favor deme el c¢digo del art¡culo")
      DEVPOS(13, 20)
      DEVOUT("a borrarle la tarea ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCODART", NIL, NIL, NIL):DISPLAY())
      SETCOLOR("+G")
      DEVPOS(14, 20)
      DEVOUT("ESC o ESPACIOS para terminar")
      SETCOLOR("+W")
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WCODART = ZLCPT .OR. WCODART = "*" .OR. LASTKEY() = 27

         EXIT

      ENDIF

      SCROLL(14, 20, 23, 78)
      SETPOS(14, 20)
      AMAPAS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
      DBSEEK("&WCODART")

      IF EOF()

         DBCLOSEARE()
         SETCOLOR("+W/R")
         DEVPOS(15, 20)
         DEVOUT("PRODUCTO NO EXISTE")
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

      DO WHILE MASTAR <> "N"

         SETCOLOR("+W")
         SCROLL(12, 1, 23, 78)
         MEMVAR->WTAR := ( SETPOS(12, 1), "  " )
         DEVPOS(12, 20)
         DEVOUT("CODIGO DE LA TAREA ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WTAR", NIL, NIL, NIL):DISPLAY())
         SETCOLOR("+G")
         DEVPOS(14, 20)
         DEVOUT("ESC o ESPACIOS para terminar")
         SETCOLOR("+W")
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         SCROLL(14, 1, 23, 78)
         SETPOS(14, 1)

         IF WTAR = "*" .OR. WTAR = "  " .OR. LASTKEY() = 27

            EXIT

         ENDIF

         MEMVAR->WPROTARC := TRIM(WCODART) + TRIM(WTAR)
         MEMVAR->WPROTARC := PADR(WPROTARC, 9, "*")
         ATAS()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\PROTARCO")
         DBSEEK("&WPROTARC")

         IF EOF()

            DBCLOSEARE()
            DEVPOS(12, 20)
            DEVOUT(BLANCOS)
            DEVPOS(12, 20)
            DEVOUT("NO ESTABA CREADA ")
            MEMVAR->X := INKEY(0)
            LOOP

         ENDIF

         MEMVAR->WCAN := UNIDADESH
         MEMVAR->WCANXUNI := CANXUNI
         MEMVAR->WCONTA := CONTADORES
         MEMVAR->WPOS3 := RECNO()
         DBCLOSEARE()
         DEVPOS(13, 20)
         DEVOUT("       CANTIDAD POR HORA " + TRANSFORM(WCAN, "999"))
         DEVPOS(14, 20)
         DEVOUT("CANTIDAD x UNIDAD DE P.T." + TRANSFORM(WCANXUNI, ;
               "99,999.9999"))
         DEVPOS(14, 10)
         DEVOUT("REQUIERE CONTADORES ? S/N" + WCONTA)
         MEMVAR->OPC := " "
         DEVPOS(18, 20)
         DEVOUT("Seguro de borrar ? S/N ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF OPC = "S"

            ATAS()
            ORDLISTCLE()
            ORDLISTADD("&ZDIS\&WDIRECTO\PROTARCO")
            DBSEEK("&WPROTARC")
            VEALOCK()
            DBDELETE()
            DBCLOSEARE()

         ENDIF

         SCROLL(8, 1, 23, 78)
         SETPOS(8, 1)

      ENDDO

   ENDDO

   MEMVAR->OPC := " "
   ATAE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\PROTARCO")
   __DBPACK()
   ORDLISTREB()
   DBCLOSEARE()
   SET(3, 2)

RETURN 

