/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MANDIROP
   Params: None.
   Return: Undefined
  Example: MANDIROP()
  ..........................................................................
*/

PROCEDURE MANDIROP()

   MEMVAR->OPC := " "
   AFACOSS()
   MEMVAR->WCANREC := LASTREC()
   DBGOTO(WCANREC)
   MEMVAR->WCOSHOR := PROMESES
   DBCLOSEARE()

   DO WHILE OPC <> "*"

      MEMVAR->OPC := "*"
      MENU()
      SETCOLOR("+GR")
      DEVPOS(7, 23)
      DEVOUT("MANEJO DIRECTO DE ORDENES DE PRODUCCION")
      SETCOLOR("+W")
      DEVPOS(12, 22)
      DEVOUT("1. REDUCCION DE CANTIDADES DE LA ORDEN")
      DEVPOS(13, 22)
      DEVOUT("2. ENTRAR EL TOTAL DE LA ORDEN")
      DEVPOS(14, 22)
      DEVOUT("3. LISTADO DE ORDENES TERMINADAS")
      DEVPOS(15, 22)
      DEVOUT("*  FIN")
      SETCOLOR("+BG")
      DEVPOS(22, 25)
      DEVOUT("SELECCIONE UNA OPCION ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "*"

         LOOP

      ENDIF

      MEMVAR->WNIV := "39" + OPC + "  "
      MEMVAR->XS := " "
      VEANIV()

      IF XS = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      SETCOLOR("+W")

      IF OPC = "3"

         LISCOSRE()
         MEMVAR->OPC := " "

      ELSEIF OPC = "4"

      ELSEIF OPC = "1"

         MEMVAR->OPC := " "
         MEMVAR->WNUMORD := 0
         MEMVAR->WAB := "BASURA.NTX"
         BA()
         ACOSE()
         DBCREATEIN("C:\BASURA", "LETORD+ACTUALIZAD", {||LETORD + ;
               ACTUALIZAD}, NIL)
         DBCLOSEARE()

         DO WHILE OPC <> "N"

            SETCOLOR("+W")
            SCROLL(5, 1, 23, 78)
            SETPOS(5, 1)
            DEVPOS(7, 1)
            DEVOUT(PADC("MANEJO DIRECTO DE ORDENES DE PRODUCCION", 78))
            DEVPOS(8, 1)
            DEVOUT(PADC("DESCARGANDO UNIDADES ENTRADAS DE PRODUCCION", 78))
            SETCOLOR("+G")
            DEVPOS(9, 26)
            DEVOUT("Y AFECTANDO CUADRO DE COSTOS")
            SETCOLOR("+W")
            DEVPOS(12, 20)
            DEVOUT("NUMERO DE LA ORDEN A DESCARGAR ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WNUMORD", "@# 99,999", NIL, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

            IF WNUMORD = 0

               MEMVAR->OPC := "N"
               LOOP

            ENDIF

            IF WNUMORD = 999

               MEMVAR->WCODPT := ZLCPT
               DEVPOS(13, 20)
               DEVOUT("CODIGO DE PRODUCTO TERMINADO ? ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "WCODPT", NIL, NIL, NIL):DISPLAY())
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}

            ENDIF

            ACOSS()
            ORDLISTCLE()
            ORDLISTADD("C:\BASURA")

            IF WNUMORD = 999

               __DBLOCATE({||NUMORD = WNUMORD .AND. ACTUALIZAD <> "C" ;
                     .AND. CODPRO = WCODPT}, NIL, NIL, NIL, .F.)

            ELSE

               MEMVAR->WLETORD := ALLTRIM(TRANSFORM(WNUMORD, "99999999")) + ;
                     SPACE(8 - LEN(ALLTRIM(TRANSFORM(WNUMORD, "99999999")));
                     )
               MEMVAR->WKEY := WLETORD + " "
               DBSEEK("&WKEY")

            ENDIF

            IF EOF()

               DBCLOSEARE()
               DEVPOS(13, 20)
               DEVOUT("ESA ORDEN NO ESTA EN EL ARCHIVO")
               MEMVAR->X := INKEY(0)
               LOOP

            ENDIF

            SETCOLOR("+GR")
            SCROLL(12, 20, 18, 65)
            MEMVAR->WCODPRO := ( SETPOS(12, 20), CODPRO )
            MEMVAR->WNOMBREPT := NOMBREPT
            MEMVAR->WCANORD := MEMVAR->WCANORD0 := CANORD
            MEMVAR->WCANPED := CANPED
            MEMVAR->WCANTOT := CANTOT
            MEMVAR->WFECHA := FECHA
            MEMVAR->WNOMCLI := NOMCLI
            MEMVAR->WCODCLI := CODCLI
            MEMVAR->WPOSI := RECNO()
            DBCLOSEARE()
            SETCOLOR("+GR")
            SCROLL(12, 20, 18, 65)
            SETPOS(12, 20)
            DEVPOS(12, 20)
            DEVOUT("PRODUCTO " + WCODPRO + " " + WNOMBREPT)
            DEVPOS(14, 20)
            DEVOUT("Cant. orig")
            DEVPOS(14, 35)
            DEVOUTPICT(WCANTOT, "@# 999,999")
            DEVPOS(15, 20)
            DEVOUT("Cant. a entrar ")
            SETPOS(15, 35)
            AADD(GETLIST, __GET(NIL, "WCANORD", "@# 999,999", NIL, NIL);
                  :DISPLAY())
            DEVPOS(16, 20)
            DEVOUT("Cant. pedida  ")
            DEVPOS(16, 35)
            DEVOUTPICT(WCANPED, "@# 999,999")
            DEVPOS(17, 20)
            DEVOUT("NUM. DE ORDEN ")
            DEVPOS(17, 35)
            DEVOUTPICT(WNUMORD, "@# 9999")
            DEVPOS(18, 20)
            DEVOUT("FECHA         ")
            DEVPOS(18, 33)
            DEVOUT(WFECHA)
            DEVPOS(19, 20)
            DEVOUT("CLIENTE " + TRIM(WCODCLI) + " " + WNOMCLI)
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

            IF WCANORD > WCANORD0

               SETCOLOR("*+GR/R")
               DEVPOS(19, 20)
               DEVOUT("NO LE PUEDO ENTRAR CANTIDADES MAYORES")
               MEMVAR->X := INKEY(0)
               SETCOLOR("+W")
               DEVPOS(19, 20)
               DEVOUT("                                          ")
               LOOP

            ENDIF

            ACOSS()
            DBGOTO(WPOSI)
            VEALOCK()
            FIELD->CANORD := CANORD - WCANORD
            MEMVAR->WNUMORD := NUMORD
            MEMVAR->WCANORD0 := CANORD
            DBCLOSEARE()

            IF WCANORD0 > 0

               MEMVAR->OPC := " "
               SETCOLOR("+W")
               SCROLL(19, 2, 20, 78)
               SETPOS(19, 2)
               SETCOLOR("+G")
               DEVPOS(19, 10)
               DEVOUT("Quedan" + ALLTRIM(TRANSFORM(WCANORD0, "999999")) + ;
                     ", Puedo dar por entrada toda la orden ")
               DEVPOS(20, 10)
               DEVOUT("tomando ese saldo como muestras o malas")
               DEVPOS(21, 10)
               DEVOUT("En este y los colores que tenga ? S/N ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
                     :DISPLAY())
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}
               SETCOLOR("+W")
               SCROLL(19, 2, 21, 78)
               SETPOS(19, 2)

            ENDIF

            ACOSS()
            DBGOTO(WPOSI)
            VEALOCK()

            IF OPC <> "S"

               IF CANORD < 0.001

                  FIELD->CANORD := 0
                  FIELD->ACTUALIZAD := "C"
                  FIELD->FACTORCUI := WCOSHOR

               ENDIF

            ELSE

               MEMVAR->WNUMORD := NUMORD
               MEMVAR->WCANSAL := CANORD
               FIELD->CANORD := WCANSAL
               FIELD->ACTUALIZAD := "C"
               FIELD->FACTORCUI := WCOSHOR

            ENDIF

            DBCLOSEARE()
            MEMVAR->OPC := " "
            SCROLL(12, 10, 23, 78)
            MEMVAR->OPC := ( SETPOS(12, 10), "N" )
            DEVPOS(15, 20)
            DEVOUT("BUSCA OTRAS ORDENES ? S/N ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

         ENDDO

      ELSEIF OPC = "2"

         SCROLL(5, 1, 23, 78)
         SETPOS(5, 1)
         SETCOLOR("+G")
         DEVPOS(12, 15)
         DEVOUT("NOTA:")
         SETCOLOR("+W")
         DEVPOS(13, 20)
         DEVOUT("Al eliminar una orden de producci¢n con esta  opci¢n")
         DEVPOS(14, 20)
         DEVOUT("se dar n por defectuosas o perdidas las unidades que")
         DEVPOS(15, 20)
         DEVOUT("faltaron por entrar de esa orden.")
         DEVPOS(16, 20)
         DEVOUT("Esto afectar  los resultados en la obtenci¢n  de los")
         DEVPOS(17, 20)
         DEVOUT("valores en la tabla de los costos de producci¢n.")
         DEVPOS(18, 20)
         DEVOUT("Si desea terminar las entradas de manera normal, use")
         DEVPOS(19, 20)
         DEVOUT("la opci¢n 1 de este mismo sub-men£.")
         MEMVAR->OPC := "S"
         DEVPOS(20, 20)
         DEVOUT("desea continuar ? S/N ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF OPC <> "S"

            MEMVAR->OPC := " "
            LOOP

         ENDIF

         MEMVAR->OPC := " "

         DO WHILE OPC <> "N"

            SCROLL(5, 1, 23, 78)
            SETPOS(5, 1)
            DEVPOS(7, 1)
            DEVOUT(PADC("MANEJO  DIRECTO DE ORDENES DE PRODUCCION", 78))
            DEVPOS(8, 1)
            DEVOUT(PADC("ENTRANDO EL SALDO DE LAS ORDENES", 78))
            MEMVAR->WNUMORD := 0
            DEVPOS(12, 25)
            DEVOUT("NUMERO DE LA ORDEN A ENTRARLE EL SALDO ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WNUMORD", "@# 999999", NIL, NIL);
                  :DISPLAY())
            DEVPOS(13, 25)
            DEVOUT("EL SALDO SE DA POR PERDIDO O MALO")
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            SCROLL(13, 1, 23, 78)
            SETPOS(13, 1)

            IF WNUMORD = 0

               MEMVAR->OPC := "N"
               LOOP

            ENDIF

            IF WNUMORD = 999

               MEMVAR->WCODPT := ZLCPT
               DEVPOS(14, 25)
               DEVOUT("CODIGO DE PRODUCTO TERMINADO ? ")
               SETPOSBS()
               AADD(GETLIST, __GET(NIL, "WCODPT", NIL, NIL, NIL):DISPLAY())
               READMODAL(GETLIST)
               MEMVAR->GETLIST := {}

            ENDIF

            ACOSE()

            IF WNUMORD = 999

               __DBLOCATE({||NUMORD = WNUMORD .AND. ACTUALIZAD <> "C" ;
                     .AND. CODPRO = WCODPT}, NIL, NIL, NIL, .F.)

            ELSE

               __DBLOCATE({||NUMORD = WNUMORD .AND. ACTUALIZAD <> "C"}, ;
                     NIL, NIL, NIL, .F.)

            ENDIF

            IF EOF()

               DBCLOSEARE()
               DEVPOS(13, 20)
               DEVOUT("ESA ORDEN NO ESTA EN EL ARCHIVO")
               MEMVAR->X := INKEY(0)
               LOOP

            ENDIF

            DEVPOS(12, 33)
            DEVOUT(CODPRO + " " + NOMBREPT)
            DEVPOS(14, 20)
            DEVOUT("Cant. orig")
            DEVPOS(14, 35)
            DEVOUTPICT(CANTOT, "@# 999,999")
            DEVPOS(15, 20)
            DEVOUT("Cant. a entrar ")
            DEVPOS(15, 35)
            DEVOUTPICT(CANORD, "@# 999,999")
            DEVPOS(16, 20)
            DEVOUT("Cant. pedida  ")
            DEVPOS(16, 35)
            DEVOUTPICT(CANPED, "@# 999,999")
            DEVPOS(17, 20)
            DEVOUT("NUM. DE ORDEN ")
            DEVPOS(17, 35)
            DEVOUTPICT(NUMORD, "@# 9999")
            DEVPOS(18, 20)
            DEVOUT("FECHA         ")
            DEVPOS(18, 33)
            DEVOUT(FECHA)
            DEVPOS(19, 20)
            DEVOUT("CLIENTE " + ALLTRIM(CODCLI) + " " + NOMCLI)
            MEMVAR->OPC := " "
            MEMVAR->WPOSI := RECNO()
            DBCLOSEARE()
            DEVPOS(20, 20)
            DEVOUT("SEGURO SE PERDIO ESTE SALDO ? S/N ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            DEVPOS(20, 20)
            DEVOUT("                             ")

            IF OPC = "S"

               ACOSS()
               DBGOTO(WPOSI)
               VEALOCK()
               FIELD->ACTUALIZAD := "C"
               FIELD->FACTORCUI := WCOSHOR
               DBCLOSEARE()

            ENDIF

            SCROLL(12, 10, 23, 78)
            MEMVAR->OPC := ( SETPOS(12, 10), "N" )
            DEVPOS(12, 20)
            DEVOUT("TIENE MAS PARA ENTRAR ? S/N ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

         ENDDO

      ENDIF

   ENDDO

   DBCLOSEALL()
   MEMVAR->WAB := "BASURA.NTX"
   BA()
   MEMVAR->OPC := " "

RETURN 

