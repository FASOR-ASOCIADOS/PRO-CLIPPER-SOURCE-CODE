/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: CONPROD
   Params: None.
   Return: Undefined
  Example: CONPROD()
  ..........................................................................
*/

PROCEDURE CONPROD()

   MEMVAR->OPC := " "
   ESPERE()
   ACOSE()
   DBEVAL({||FIELD->NUMCLI := VAL(CODCLI)}, NIL, NIL, NIL, NIL, .F.)
   DBCLOSEARE()

   DO WHILE OPC <> "*"

      MEMVAR->OPC := "*"
      MENU()
      MEMVAR->WT1 := "CONSULTAS DE PRODUCCION"
      MEMVAR->LINEA := REPLICATE("п", LEN(WT1))
      DEVPOS(7, (80 - LEN(WT1)) / 2)
      DEVOUT(WT1)
      DEVPOS(12, 25)
      DEVOUT("1. CONSULTAR POR REFERENCIA")
      DEVPOS(13, 25)
      DEVOUT("2. CONSULTAR POR NUMERO DE ORDEN")
      DEVPOS(14, 25)
      DEVOUT("3. CONSULTAR POR CLIENTE")
      DEVPOS(15, 25)
      DEVOUT("4. CONSULTA DE TODAS LAS ORDENES")
      DEVPOS(16, 25)
      DEVOUT("*  FIN")
      DEVPOS(17, 20)
      DEVOUT("SELECCIONE UNA OPCION ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      DEVPOS(17, 20)
      DEVOUT("                          ")
      SCROLL(7, 1, 23, 78)
      SETPOS(7, 1)

      IF OPC = "1"

         ESPERE()
         MEMVAR->WAB := "BASURA.DBF"
         BA()
         ACOSS()
         __DBSORT("C:\PROTMP\BASURA", {"CODPRO", "NUMORD", "NUMCLI"}, {||;
               ACTUALIZAD <> "C"}, NIL, NIL, NIL, .F.)
         DBCLOSEARE()
         DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)
         MEMVAR->OPC := " "

         DO WHILE OPC <> "N"

            SETCOLOR("+W")
            MEMVAR->WT1 := ;
                  "CONSULTA DE ORDENES DE PRODUCCION POR REFERENCIA"
            DEVPOS(7, 1)
            DEVOUT(PADC(WT1, 78))
            MEMVAR->WCODPRO := ZLCPT
            DEVPOS(12, 20)
            DEVOUT("REFERENCIA A CONSULTAR ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WCODPRO", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

            IF WCODPRO = " " .OR. WCODPRO = "*" .OR. LASTKEY() = 27

               MEMVAR->OPC := "N"
               LOOP

            ENDIF

            __DBLOCATE({||CODPRO = WCODPRO .AND. CANORD > 0}, NIL, NIL, ;
                  NIL, .F.)

            IF EOF()

               DEVPOS(13, 20)
               DEVOUT("REFERENCIA NO ESTA EN FABRICACION")
               MEMVAR->X := INKEY(0)
               LOOP

            ENDIF

            SCROLL(8, 5, 15, 70)
            SETPOS(8, 5)
            SETCOLOR("+G")
            DEVPOS(9, 5)
            DEVOUT(CODPRO + " " + NOMBREPT)
            SETCOLOR("+W")
            DEVPOS(10, 5)
            DEVOUT(;
                  "       PENDIENTE. ORIGINAL.   NUM.O.P.  FECHA    DIAS   CLIENTE";
                  )
            MEMVAR->CL := 12
            SETCOLOR("+BR")
            DEVPOS(23, 55)
            DEVOUT("лл = ENTREGA DEMORADA")
            SETCOLOR("W")

            DO WHILE CODPRO = WCODPRO .AND. .NOT. EOF()

               DO WHILE CL < 20

                  SETCOLOR("+W")
                  DEVPOS(CL, 11)
                  DEVOUTPICT(CANORD, "@# 99,999")
                  SETCOLOR("W")
                  DEVPOS(CL, 23)
                  DEVOUTPICT(CANPED, "@# 99,999")
                  DEVPOS(CL, 35)
                  DEVOUTPICT(NUMORD, "@# 99,999")
                  DEVPOS(CL, 43)
                  DEVOUT(FECHA)

                  IF DATE() - FECHA > 15

                     SETCOLOR("+BR")

                  ENDIF

                  DEVPOS(CL, 54)
                  DEVOUTPICT(DATE() - FECHA, "@# 999")
                  SETCOLOR("W")

                  IF CODCLI = "  "

                     DEVPOS(CL, 61)
                     DEVOUT("F A S O R ")

                  ELSE

                     DEVPOS(CL, 61)
                     DEVOUT(CODCLI + " " + SUBSTR(NOMCLI, 1, 9))

                  ENDIF

                  MEMVAR->CL := MEMVAR->CL + 1
                  DBSKIP(1)

                  IF CL = 20 .AND. CODPRO = WCODPRO

                     DEVPOS(21, 20)
                     DEVOUT("HAY MAS PARA MOSTRAR")
                     MEMVAR->X := INKEY(0)
                     SCROLL(12, 2, 22, 78)
                     MEMVAR->CL := ( SETPOS(12, 2), 12 )
                     LOOP

                  ENDIF

                  MEMVAR->OPC := " "

                  IF CODPRO <> WCODPRO .OR. EOF()

                     DEVPOS(21, 20)
                     DEVOUT("ESAS SON TODAS ")
                     MEMVAR->CL := 30
                     MEMVAR->X := INKEY(0)
                     LOOP

                  ENDIF

               ENDDO

            ENDDO

            SCROLL(8, 2, 23, 78)
            MEMVAR->OPC := ( SETPOS(8, 2), " " )
            DEVPOS(15, 20)
            DEVOUT("TIENE MAS PARA CONSULTAR ? S/N ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

         ENDDO

         DBCLOSEARE()
         MEMVAR->WAB := "BASURA.DBF"
         BA()

      ELSEIF OPC = "2"

         ESPERE()
         MEMVAR->WAB := "BASURA.DBF"
         BA()
         MEMVAR->WAB := "BASURA.NTX"
         BA()
         ACOSE()
         DBCREATEIN("C:\PROTMP\BASURA", "LETORD", {||LETORD}, NIL)
         DBCLOSEARE()
         MEMVAR->OPC := " "

         DO WHILE OPC <> "N"

            MENU()
            MEMVAR->WT1 := "CONSULTA DE ORDENES DE PRODUCCION POR # O.P."
            DEVPOS(7, (80 - LEN(WT1)) / 2)
            DEVOUT(WT1)
            MEMVAR->WNUMORD := "        "
            DEVPOS(12, 20)
            DEVOUT("NUMERO DE ORDEN A CONSULTAR ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WNUMORD", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

            IF WNUMORD = "        "

               MEMVAR->OPC := "N"
               LOOP

            ENDIF

            ACOSS()
            ORDLISTCLE()
            ORDLISTADD("C:\PROTMP\BASURA")

            IF WNUMORD = "999     "

               MEMVAR->WCODPT := ZLCPT
               DEVPOS(13, 20)
               DEVOUT("CODIGO DE PRODUCTO TERMINADO ? ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "WCODPT", NIL, NIL, NIL):DISPLAY())
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}
               __DBLOCATE({||LETORD = WNUMORD .AND. CODPRO = WCODPT}, NIL, ;
                     NIL, NIL, .F.)

            ELSE

               DBSEEK("&WNUMORD")

            ENDIF

            IF EOF() .OR. ACTUALIZAD = "C"

               DBCLOSEARE()
               DEVPOS(13, 20)
               DEVOUT("ORDEN NO ESTA EN FABRICACION")
               MEMVAR->X := INKEY(0)
               LOOP

            ENDIF

            SCROLL(9, 1, 15, 70)
            SETPOS(9, 1)
            SETCOLOR("+G")
            DEVPOS(9, 10)
            DEVOUT(CODPRO + " " + NOMBREPT + "   O.P. # " + ALLTRIM(;
                  TRANSFORM(NUMORD, "999999")))
            SETCOLOR("+W")
            DEVPOS(10, 5)
            DEVOUT(;
                  "       CAN.PEND.  CANT. PED.   FECHA    DIAS   CLIENTE")
            SETCOLOR("W")
            MEMVAR->CL := 12
            MEMVAR->SWPARE := 0
            MEMVAR->WPOS13 := RECNO()
            DBCLOSEARE()

            DO WHILE SWPARE = 0

               ACOSS()
               ORDLISTCLE()
               ORDLISTADD("C:\PROTMP\BASURA")
               DBGOTO(WPOS13)

               DO WHILE CL < 20

                  DEVPOS(CL, 12)
                  DEVOUTPICT(CANORD, "@# 99,999")
                  DEVPOS(CL, 23)
                  DEVOUTPICT(CANPED, "@# 99,999")
                  DEVPOS(CL, 34)
                  DEVOUT(FECHA)

                  IF DATE() - FECHA > 15

                     SETCOLOR("+BR")

                  ENDIF

                  DEVPOS(CL, 45)
                  DEVOUTPICT(DATE() - FECHA, "@# 999")
                  SETCOLOR("W")

                  IF CODCLI = "  "

                     DEVPOS(CL, 61)
                     DEVOUT("F A S O R ")

                  ELSE

                     DEVPOS(CL, 61)
                     DEVOUT(CODCLI + " " + SUBSTR(NOMCLI, 1, 9))

                  ENDIF

                  MEMVAR->CL := MEMVAR->CL + 1
                  DBSKIP(1)

                  IF  .NOT. EOF() .AND. CL = 20 .AND. LETORD = WNUMORD

                     MEMVAR->WPOS13 := RECNO()
                     DBCLOSEARE()
                     SETCOLOR("+G")
                     DEVPOS(22, 20)
                     DEVOUT("HAY MAS PARA MOSTRAR")
                     MEMVAR->X := INKEY(0)
                     SETCOLOR("W")
                     SCROLL(12, 2, 23, 78)
                     MEMVAR->CL := ( SETPOS(12, 2), 12 )
                     LOOP

                  ENDIF

                  MEMVAR->OPC := " "

                  IF EOF() .OR. LETORD <> WNUMORD

                     DBCLOSEARE()
                     MEMVAR->SWPARE := 1
                     SETCOLOR("+GR")
                     DEVPOS(CL + 1, 20)
                     DEVOUT("ESAS SON TODAS")
                     MEMVAR->X := INKEY(0)
                     SETCOLOR("W")
                     MEMVAR->CL := 30
                     LOOP

                  ENDIF

               ENDDO

            ENDDO

         ENDDO

         DBCLOSEARE()
         MEMVAR->WAB := "BASURA.NTX"
         BA()

      ELSEIF OPC = "3"

         ESPERE()
         MEMVAR->WAB := "BASURA.DBF"
         BA()
         ACOSS()
         __DBSORT("C:\PROTMP\BASURA", {"NUMCLI", "NUMORD"}, {||ACTUALIZAD <> "C"},;
                NIL, NIL, NIL, .F.)
         DBCLOSEARE()
         DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)
         MEMVAR->OPC := " "

         DO WHILE OPC <> "N"

            MENU()
            SETCOLOR("+GR/B")
            DEVPOS(7, 1)
            DEVOUT(PADC("CONSULTA DE ORDENES DE PRODUCCION POR # CLIENTE", ;
                  78))
            SCROLL(12, 20, 15, 70)
            MEMVAR->WCODCLI := ( SETPOS(12, 20), SPACE(11) )
            DEVPOS(12, 20)
            DEVOUT("CODIGO DEL CLIENTE A CONSULTAR ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WCODCLI", NIL, NIL, NIL):DISPLAY())
            SETCOLOR("+G")
            DEVPOS(13, 20)
            DEVOUT("* o ESC para salir o espacios para FASOR")
            SETCOLOR("+W")
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            DEVPOS(13, 20)
            DEVOUT("                                    ")

            IF SUBSTR(WCODCLI, 1, 1) = "*" .OR. LASTKEY() = 27

               MEMVAR->OPC := "N"
               LOOP

            ENDIF

            __DBLOCATE({||NUMCLI = VAL(WCODCLI)}, NIL, NIL, NIL, .F.)

            IF EOF()

               DEVPOS(13, 20)
               DEVOUT("CLIENTE NO TIENE EN FABRICACION")
               MEMVAR->X := INKEY(0)
               LOOP

            ENDIF

            SCROLL(9, 2, 15, 70)
            SETPOS(9, 2)
            SETCOLOR("+G")

            IF WCODCLI = "    "

               DEVPOS(9, 10)
               DEVOUT("EN PRODUCCION PARA FASOR ")

            ELSE

               DEVPOS(9, 10)
               DEVOUT(CODCLI + " " + TRIM(NOMCLI) + " ")

            ENDIF

            SETCOLOR("+W")
            MEMVAR->CL := 12
            DEVPOS(10, 1)
            DEVOUT(;
                  "       PENDIENTE  ORIGINAL.    FECHA    DIAS      PRODUCTO             # OP";
                  )
            SETCOLOR("+BR")
            DEVPOS(23, 55)
            DEVOUT("лл = ENTREGA DEMORADA")
            SETCOLOR("W")

            DO WHILE NUMCLI = VAL(WCODCLI) .AND. .NOT. EOF()

               DO WHILE CL < 20

                  SETCOLOR("+W")
                  DEVPOS(CL, 8)
                  DEVOUTPICT(CANORD, "@# 99,999")
                  SETCOLOR("W")
                  DEVPOS(CL, 19)
                  DEVOUTPICT(CANPED, "@# 99,999")
                  DEVPOS(CL, 30)
                  DEVOUT(FECHA)

                  IF DATE() - FECHA > 15

                     SETCOLOR("+BR")

                  ENDIF

                  DEVPOS(CL, 41)
                  DEVOUTPICT(DATE() - FECHA, "@# 999")
                  SETCOLOR("W")
                  DEVPOS(CL, 45)
                  DEVOUT(SUBSTR(NOMBREPT, 1, 27))
                  DEVPOS(CL, 74)
                  DEVOUTPICT(NUMORD, "@# 9999")
                  MEMVAR->CL := MEMVAR->CL + 1
                  DBSKIP(1)

                  IF CL = 20 .AND. CODCLI = WCODCLI

                     SETCOLOR("+BG")
                     DEVPOS(22, 40)
                     DEVOUT("HAY MAS PARA MOSTRAR")
                     MEMVAR->X := INKEY(0)
                     SETCOLOR("W")
                     SCROLL(12, 1, 22, 78)
                     MEMVAR->CL := ( SETPOS(12, 1), 12 )
                     LOOP

                  ENDIF

                  MEMVAR->OPC := " "

                  IF NUMCLI <> VAL(WCODCLI) .OR. EOF()

                     SETCOLOR("+GR")
                     DEVPOS(CL + 1, 20)
                     DEVOUT("ESAS SON TODAS")
                     MEMVAR->X := INKEY(0)
                     MEMVAR->CL := 30
                     SETCOLOR("W")
                     LOOP

                  ENDIF

               ENDDO

            ENDDO

         ENDDO

         DBCLOSEARE()
         MEMVAR->WAB := "BASURA.DBF"
         BA()

      ELSEIF OPC = "4"

         SETCOLOR("+GR/B")
         DEVPOS(7, 1)
         DEVOUT(PADC("CONSULTA GENERAL DE ORDENES DE PRODUCCION", 78))
         SETCOLOR("+W")
         SCROLL(12, 20, 15, 70)
         MEMVAR->OPC := ( SETPOS(12, 20), " " )
         DEVPOS(14, 20)
         DEVOUT("Por <P>antalla o <I>mpresora ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "PI"}, NIL);
               :DISPLAY())
         SETCOLOR("+G")
         DEVPOS(14, 25)
         DEVOUT("P")
         DEVPOS(14, 38)
         DEVOUT("I")
         SETCOLOR("+W")
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         ESPERE()
         MEMVAR->WAB := "BASURA.DBF"
         BA()
         ACOSS()
         __DBSORT("C:\PROTMP\BASURA", {"NUMORD"}, {||ACTUALIZAD <> "C"}, NIL, NIL,;
                NIL, .F.)
         DBCLOSEARE()
         DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)

         IF OPC = "P"

            MEMVAR->OPC := " "

            DO WHILE OPC <> "N"

               SCROLL(12, 20, 15, 70)
               SETPOS(12, 20)
               SETCOLOR("+W")
               MEMVAR->CL := 12
               DEVPOS(10, 1)
               DEVOUT(;
                     "REF.     PENDIENTE  ORIGINAL.  FECHA    DIAS      PRODUCTO             # OP";
                     )
               SETCOLOR("+BR")
               DEVPOS(23, 55)
               DEVOUT("лл = ENTREGA DEMORADA")
               SETCOLOR("W")

               DO WHILE  .NOT. EOF()

                  DO WHILE CL < 20

                     SETCOLOR("+W")
                     DEVPOS(CL, 1)
                     DEVOUT(CODPRO)
                     DEVPOS(CL, 10)
                     DEVOUTPICT(CANORD, "@# 99,999")
                     SETCOLOR("W")
                     DEVPOS(CL, 21)
                     DEVOUTPICT(CANPED, "@# 99,999")
                     DEVPOS(CL, 29)
                     DEVOUT(FECHA)

                     IF DATE() - FECHA > 15

                        SETCOLOR("+BR")

                     ENDIF

                     DEVPOS(CL, 41)
                     DEVOUTPICT(DATE() - FECHA, "@# 999")
                     SETCOLOR("W")
                     DEVPOS(CL, 45)
                     DEVOUT(SUBSTR(NOMBREPT, 1, 27))
                     DEVPOS(CL, 74)
                     DEVOUTPICT(NUMORD, "@# 9999")
                     MEMVAR->CL := MEMVAR->CL + 1
                     DBSKIP(1)

                     IF CL = 20

                        MEMVAR->OPC := " "
                        SETCOLOR("BG")
                        DEVPOS(22, 40)
                        DEVOUT("HAY MAS PARA MOSTRAR   *=FIN ")
                        SETPOSBS()
                        AADD(GETLIST, __GET(NIL, "OPC", NIL, NIL, NIL);
                              :DISPLAY())
                        READMODAL(GETLIST)
                        MEMVAR->GETLIST := {}
                        SETCOLOR("W")

                        IF OPC = "*"

                           DBGOBOTTOM()
                           DBSKIP(1)
                           MEMVAR->CL := 30
                           LOOP

                        ENDIF

                        MEMVAR->OPC := " "
                        SCROLL(12, 1, 22, 78)
                        MEMVAR->CL := ( SETPOS(12, 1), 12 )
                        LOOP

                     ENDIF

                     MEMVAR->OPC := " "

                     IF EOF()

                        SETCOLOR("+GR")
                        DEVPOS(CL + 1, 20)
                        DEVOUT("ESAS SON TODAS")
                        MEMVAR->CL := 30
                        SETCOLOR("W")
                        MEMVAR->X := INKEY(0)
                        LOOP

                     ENDIF

                  ENDDO

               ENDDO

               SCROLL(12, 1, 23, 78)
               MEMVAR->OPC := ( SETPOS(12, 1), " " )
               DEVPOS(15, 20)
               DEVOUT("TIENE MAS PARA CONSULTAR ? S/N ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
                     :DISPLAY())
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}
               DBGOTOP()

            ENDDO

            DBCLOSEARE()
            MEMVAR->WAB := "BASURA.DBF"
            BA()

         ELSE

            SCROLL(8, 1, 23, 78)
            MEMVAR->WDESDE := ( SETPOS(8, 1), NUMORD )
            DBGOBOTTOM()
            MEMVAR->WHASTA := NUMORD
            MEMVAR->WORD := "C"
            DEVPOS(12, 20)
            DEVOUT("IMPRIMO DESDE LA ORDEN ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WDESDE", "@Z 999,999", NIL, NIL);
                  :DISPLAY())
            DEVPOS(13, 20)
            DEVOUT("        HASTA LA ORDEN ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WHASTA", "@Z 999,999", NIL, NIL);
                  :DISPLAY())
            DEVPOS(14, 20)
            DEVOUT("Ordenado por <N>umero de orden o <C>odigo ? ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WORD", "@!", {||WORD $ "CN"}, NIL);
                  :DISPLAY())
            SETCOLOR("+G")
            DEVPOS(14, 34)
            DEVOUT("N")
            DEVPOS(14, 54)
            DEVOUT("C")
            SETCOLOR("+W")
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

            IF WDESDE = 0

               MEMVAR->OPC := " "
               DBCLOSEALL()
               SETCOLOR("+W")
               LOOP

            ENDIF

            IF WORD = "C"

               MEMVAR->WAB := "FILETEMP.DBF"
               BA()
               MEMVAR->WAB := "BASURA.NTX"
               BA()
               MEMVAR->WAB := "BASURA1.DBF"
               BA()
               DBEVAL({||FIELD->CODPRO := RIGHT(STR(VAL(CODPRO)), 5)}, NIL, ;
                     NIL, NIL, NIL, .F.)
               __DBSORT("C:\PROTMP\BASURA1", {"CODPRO", "LETORD"}, {||NUMORD > ;
                     WDESDE - 1 .AND. NUMORD < WHASTA + 1}, NIL, NIL, NIL, ;
                     .F.)
               DBCLOSEARE()
               DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA1", NIL, NIL, .F.)
               DBEVAL({||FIELD->NUMCLI := VAL(CODPRO)}, NIL, NIL, NIL, NIL, ;
                     .F.)
               __DBSORT("C:\PROTMP\FILETEMP", {"NUMCLI", "LETORD"}, {||NUMORD > ;
                     WDESDE - 1 .AND. NUMORD < WHASTA + 1}, NIL, NIL, NIL, ;
                     .F.)
               DBCLOSEARE()
               DBUSEAREA(.F., NIL, "C:\PROTMP\FILETEMP", NIL, NIL, .F.)

            ELSE

               MEMVAR->WAB := "FILETEMP.DBF"
               BA()
               MEMVAR->WAB := "BASURA.NTX"
               BA()
               MEMVAR->WAB := "BASURA1.NTX"
               BA()
               __DBSORT("C:\PROTMP\BASURA1", {"NUMORD"}, {||NUMORD > WDESDE - 1 ;
                     .AND. NUMORD < WHASTA + 1}, NIL, NIL, NIL, .F.)
               DBCLOSEARE()
               DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA1", NIL, NIL, .F.)
               __DBSORT("C:\PROTMP\FILETEMP", {"NUMORD"}, {||NUMORD > WDESDE - 1 ;
                     .AND. NUMORD < WHASTA + 1}, NIL, NIL, NIL, .F.)
               DBCLOSEARE()
               DBUSEAREA(.F., NIL, "C:\PROTMP\FILETEMP", NIL, NIL, .F.)

            ENDIF

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
            MEMVAR->RAYA := REPLICATE("-", 80)
            MEMVAR->WLONPAP := 80
            ENIM()

            DO WHILE  .NOT. EOF()

               IF CL = 0

                  MEMVAR->CP := MEMVAR->CP + 1
                  DEVPOS(CL, 0)
                  DEVOUT(RAYA)
                  MEMVAR->CL := MEMVAR->CL + 1
                  DEVPOS(CL, (80 - LEN(RAZON)) / 2)
                  DEVOUT(RAZON)
                  MEMVAR->CL := MEMVAR->CL + 1
                  DEVPOS(CL, 1)
                  DEVOUT(PADC("SISTEMA DE COSTOS DE PRODUCCION", 78))
                  MEMVAR->CL := MEMVAR->CL + 1
                  DEVPOS(CL, 1)
                  DEVOUT(PADC(;
                        "ORDENES PENDIENTES POR ENTRAR DE PRODUCCION", 78))
                  MEMVAR->CL := MEMVAR->CL + 1
                  DEVPOS(CL, 1)
                  DEVOUT("INFORME A: " + DTOC(DATE()))
                  MEMVAR->WT1 := "PAGINA: " + ALLTRIM(TRANSFORM(CP, ;
                        "999999"))
                  DEVPOS(CL, 80 - LEN(WT1))
                  DEVOUT(WT1)
                  MEMVAR->CL := MEMVAR->CL + 1
                  DEVPOS(CL, 0)
                  DEVOUT(RAYA)
                  MEMVAR->CL := MEMVAR->CL + 1
                  DEVPOS(CL, 1)
                  DEVOUT(;
                        "REF.     PEND. ORIGINAL.  FECHA    DIAS  PRODUCTO                       # OP";
                        )
                  MEMVAR->CL := MEMVAR->CL + 1

               ENDIF

               DEVPOS(CL, 1)
               DEVOUT(CODPRO + " " + TRANSFORM(CANORD, "999,999") + " " + ;
                     TRANSFORM(CANTOT, "999,999") + "  " + DTOC(FECHA) + ;
                     " " + TRANSFORM(DATE() - FECHA, "9999") + "  " + ;
                     NOMBREPT + " " + TRANSFORM(NUMORD, "999999"))
               MEMVAR->CL := MEMVAR->CL + 1
               DBSKIP(1)

               IF CL > 60

                  DEVPOS(CL, 0)
                  DEVOUT(RAYA)
                  MEMVAR->CL := 0

               ENDIF

            ENDDO

            MEMVAR->CL := MEMVAR->CL + 1
            DEVPOS(CL, 0)
            DEVOUT(RAYA)
            MEMVAR->CL := MEMVAR->CL + 1
            MEMVAR->WT1 := "* *  FIN DEL INFORME  * *"
            DEVPOS(CL, WLONPAP - LEN(WT1))
            DEVOUT(WT1)
            DEVPOS(CL + 1, 1)
            DEVOUT(DTOC(DATE()) + " / " + TIME())
            __EJECT()
            APIM()
            SET(11, "OFF")
            SCROLL(7, 1, 23, 78)
            SETPOS(7, 1)

         ENDIF

         DBCLOSEARE()
         MEMVAR->WAB := "FILETEMP.DBF"
         BA()
         MEMVAR->WAB := "BASURA.DBF"
         BA()
         MEMVAR->WAB := "BASURA.NTX"
         BA()

      ENDIF

   ENDDO

   SET(11, "OFF")
   MEMVAR->OPC := " "

RETURN 

