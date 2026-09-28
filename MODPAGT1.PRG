/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MODPAGT1
   Params: None.
   Return: Undefined
  Example: MODPAGT1()
  ..........................................................................
*/

PROCEDURE MODPAGT1()

   ESPERE()
   DBSELECTAR("3")
   ATAE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\PROTARCO")
   ORDLISTREB()
   DBCLOSEARE()
   AMAPERE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\COD-PER")
   ORDLISTREB()
   DBCLOSEARE()
   AP6030E()
   DBCLOSEARE()
   MENU()
   SCROLL(5, 1, 23, 78)
   SETPOS(5, 1)
   DEVPOS(5, 27)
   DEVOUT("<<  MANEJO  DE  TAREAS  >>")
   DEVPOS(7, 29)
   DEVOUT("MODIFICACION DE PAGOS")
   MEMVAR->LINEA := REPLICATE("ß", 21)
   SETCOLOR("+GR")
   DEVPOS(8, 29)
   DEVOUT(LINEA)
   __MRESTORE("&ZDIS\&WDIRECTO\SALMIN", .T.)
   __MRESTORE("&ZDIS\&WDIRECTO\HORWMES", .T.)
   SETCOLOR("+G")
   MEMVAR->WFECHA := DATE()
   MEMVAR->WVALHOR := SALMIN / ZHORWMES
   MEMVAR->OPC := " "
   MEMVAR->XREV := "  "
   SCROLL(9, 1, 23, 78)
   SETPOS(9, 1)
   DEVPOS(12, 10)
   DEVOUT("QUE OPERARIO CORRIGE ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "XREV", NIL, NIL, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   APAMOS()
   __DBLOCATE({||CODOPE = XREV}, NIL, NIL, NIL, .F.)

   DO WHILE  .NOT. EOF()

      SCROLL(9, 1, 23, 78)
      SETPOS(9, 1)

      IF CODOPE <> XREV

         DBSKIP(1)
         LOOP

      ENDIF

      MEMVAR->WOPE := MEMVAR->WOPEORI := CODOPE
      MEMVAR->WNUMORD := NUMORD
      MEMVAR->WLETORD := LTRIM(TRANSFORM(WNUMORD, "99999999"))
      MEMVAR->WLONORD := LEN(WLETORD)
      MEMVAR->WLETORD := WLETORD + SPACE(8 - WLONORD)
      MEMVAR->WCODPRO := CODPRO
      MEMVAR->WCODTAR := CODTAR
      MEMVAR->WMINUTOS := MEMVAR->WMINORI := MINUTOS
      MEMVAR->WBUENAS := MEMVAR->WBUEORI := BUENAS
      MEMVAR->WMALAS := MEMVAR->WMALORI := MALAS
      MEMVAR->WPRUEBAS := MEMVAR->WPRUORI := PRUEBAS
      MEMVAR->WTOTAL := TOTAL
      MEMVAR->WCONINI := CONINI
      MEMVAR->WCONFIN := CONFIN

      IF DELETED()

         SETCOLOR("*+R")
         DEVPOS(9, 60)
         DEVOUT("BORRADO")
         SETCOLOR("+W")

      ELSE

         SETCOLOR("+W")
         DEVPOS(9, 60)
         DEVOUT("       ")

      ENDIF

      SETCOLOR("+GR")
      DEVPOS(10, 60)
      DEVOUT("99 = borra registro")
      SETCOLOR("+G")
      DEVPOS(11, 60)
      DEVOUT("S/MINIMO " + TRANSFORM(SALMIN, "999,999.99"))
      DEVPOS(12, 60)
      DEVOUT("Vr./Hora " + TRANSFORM(WVALHOR, "9,999.99"))
      SETCOLOR("+W")
      DEVPOS(10, 15)
      DEVOUT("A. COD. OPERARIO ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WOPE", NIL, NIL, NIL):DISPLAY())
      DEVPOS(11, 15)
      DEVOUT("B. FECHA         " + DTOC(WFECHA))
      DEVPOS(12, 15)
      DEVOUT("C. NUMERO DE O.P." + TRANSFORM(WNUMORD, "99999"))
      DEVPOS(13, 15)
      DEVOUT("D. COD. DE P.T.  " + WCODPRO)
      DEVPOS(14, 15)
      DEVOUT("E. COD. DE LABOR " + WCODTAR)
      DEVPOS(15, 15)
      DEVOUT("F. MINUTOS       ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WMINUTOS", "@Z 999,999.99", NIL, NIL);
            :DISPLAY())
      DEVPOS(16, 15)
      DEVOUT("G. BUENAS        " + TRANSFORM(WBUENAS, "99,999"))
      DEVPOS(17, 15)
      DEVOUT("H. MALAS         " + TRANSFORM(WMALAS, "99,999"))
      DEVPOS(18, 15)
      DEVOUT("I. PRUEBAS       " + TRANSFORM(WPRUEBAS, "99,999"))
      DEVPOS(19, 15)
      DEVOUT("J. TOTAL         " + TRANSFORM(WTOTAL, "99,999"))
      DEVPOS(20, 15)
      DEVOUT("K. C/INICIAL     " + TRANSFORM(WCONINI, "999,999"))
      DEVPOS(21, 15)
      DEVOUT("L. C/FINAL       " + TRANSFORM(WCONFIN, "999,999"))
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WOPE = "  " .OR. LASTKEY() = 27

         MEMVAR->OPC := "*"
         LOOP

      ENDIF

      IF WOPE = "99"

         DBSELECTAR("9")
         VEALOCK()
         FIELD->BUENAS := 0
         FIELD->MALAS := 0
         FIELD->PRUEBAS := 0
         FIELD->MINUTOS := 0
         DBDELETE()
         DBSKIP(1)

         IF WCODPRO <> "6030  " .OR. WCODPRO = "6030  "

            ADEMASE()
            MEMVAR->WKEY1 := WCODTAR + WLETORD
            DBSEEK("&WKEY1")

            IF  .NOT. EOF()

               VEALOCK()

               IF WCODTAR = "PA" .OR. WCODTAR = "PC" .OR. WCODTAR = "GC" ;
                     .OR. WCODTAR = "GP"

                  FIELD->PAGADAS := PAGADAS - WMINUTOS

               ELSE

                  FIELD->PAGADAS := PAGADAS - WBUENAS

               ENDIF

            ENDIF

            DBCLOSEARE()

         ENDIF

         DBSELECTAR("9")
         LOOP

      ENDIF

      AMAPERS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\COD-PER")
      DBSEEK("&WOPE")

      IF EOF()

         DBCLOSEARE()
         DEVPOS(10, 50)
         DEVOUT("NO EXISTE")
         MEMVAR->X := INKEY(0)
         DBSELECTAR("9")
         LOOP

      ENDIF

      MEMVAR->WPUNTOS := PUNTOS
      DBCLOSEARE()
      MEMVAR->WKEY := TRIM(WCODPRO) + TRIM(WCODTAR)

      IF LEN(WKEY) = 2

         MEMVAR->WKEY := WKEY + "*****"

      ELSEIF LEN(WKEY) = 3

         MEMVAR->WKEY := WKEY + "****"

      ELSEIF LEN(WKEY) = 4

         MEMVAR->WKEY := WKEY + "***"

      ELSEIF LEN(WKEY) = 5

         MEMVAR->WKEY := WKEY + "**"

      ELSEIF LEN(WKEY) = 6

         MEMVAR->WKEY := WKEY + "*"

      ENDIF

      ATAS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\PROTARCO")
      DBSEEK("&WKEY")
      MEMVAR->SWNADA := 0

      IF  .NOT. EOF()

         MEMVAR->WUNIDAD := UNIDADESH

      ELSE

         DBCLOSEARE()
         MEMVAR->SWNADA := 1
         LOOP

      ENDIF

      DBCLOSEARE()

      IF WUNIDAD > 0

         IF WCODTAR = "PA" .OR. WCODTAR = "PC" .OR. WCODTAR = "GC" .OR. ;
               WCODTAR = "GP"

            MEMVAR->WPAGO := WMINUTOS / WUNIDAD * WVALHOR

         ELSE

            MEMVAR->WPAGO := WBUENAS / WUNIDAD * WVALHOR

         ENDIF

      ELSE

         MEMVAR->WPAGO := 0

      ENDIF

      MEMVAR->WNUEPAG := WPAGO * WPUNTOS / 100
      MEMVAR->WPAGO := WNUEPAG

      IF SWNADA = 0

         DBSELECTAR("9")
         VEALOCK()
         FIELD->MINUTOS := WMINUTOS
         FIELD->UNIDADESH := WUNIDAD
         FIELD->PAGO := WPAGO
         FIELD->CODOPE := WOPE

         IF WMINUTOS <> WMINORI

            ADEMASE()
            MEMVAR->WKEY1 := WCODTAR + WLETORD
            DBSEEK("&WKEY1")

            IF  .NOT. EOF()

               VEALOCK()
               FIELD->PAGADAS := PAGADAS - WMINUTOS

            ENDIF

            DBCLOSEARE()

         ENDIF

      ENDIF

      DBSELECTAR("9")
      SCROLL(8, 1, 23, 78)
      MEMVAR->OPC := ( SETPOS(8, 1), " " )
      DBSKIP(1)

   ENDDO

   DBSELECTAR("9")
   __DBLOCATE({||DELETED()}, NIL, NIL, NIL, .F.)

   IF  .NOT. EOF()

      DBCLOSEARE()
      APAMOE()
      __DBPACK()

   ENDIF

   CIERRE()
   MEMVAR->OPC := " "

RETURN 

