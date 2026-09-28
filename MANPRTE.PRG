/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MANPRTE
   Params: None.
   Return: Undefined
  Example: MANPRTE()
  ..........................................................................
*/

PROCEDURE MANPRTE()

   MEMVAR->OPC := " "

   DO WHILE OPC <> "*"

      MEMVAR->OPC := "*"
      MENU()
      DEVPOS(4, 20)
      DEVOUT(" MANEJO DE ARCHIVO DE PRODUCTO TERMINADO")
      DEVPOS(12, 25)
      DEVOUT("1. CREACION DE REFERENCIAS")
      DEVPOS(13, 25)
      DEVOUT("2. MODIFICACION DE DATOS")
      DEVPOS(14, 25)
      DEVOUT("3. BORRADO DE REFERENCIAS")
      DEVPOS(15, 25)
      DEVOUT("4. LISTADO")
      DEVPOS(16, 25)
      DEVOUT("*  FIN")
      SETCOLOR("+G")
      DEVPOS(20, 20)
      DEVOUT("SELECCIONE UNA OPCION ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", NIL, NIL, NIL):DISPLAY())
      SETCOLOR("+W")
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "*"

         LOOP

      ENDIF

      MEMVAR->WNIV := "11" + OPC + "  "
      MEMVAR->XS := " "
      VEANIV()

      IF XS = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      IF OPC = "1"

         MEMVAR->OPC := " "
         MENU()
         AMAPAE()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
         ORDLISTREB()
         DBCLOSEARE()

         DO WHILE OPC <> "*"

            MENU()
            SETCOLOR("+BR")
            DEVPOS(7, 1)
            DEVOUT(PADC("CREACION DE REFERENCIAS EN MAESTRO", 78))
            SETCOLOR("+W")
            SET(3, 2)
            MEMVAR->WPO1 := MEMVAR->WPO2 := MEMVAR->WPO3 := MEMVAR->WVRLISTA ;
                  := 0
            MEMVAR->OPC := " "
            MEMVAR->WCOD := ZLCPT
            MEMVAR->WUNI := SPACE(10)
            MEMVAR->WNOM := SPACE(20)
            MEMVAR->SWLEE := 1
            MENPRTE()
            SETCOLOR("+W")

            IF WCOD = "      "

               EXIT

            ENDIF

            MEMVAR->OPC := " "
            DEVPOS(23, 10)
            DEVOUT("ESTA TODO BIEN ? S/N ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

            IF OPC <> "S"

               LOOP

            ENDIF

            AMAPAS()
            ORDLISTCLE()
            ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
            DBSEEK("&WCOD")

            IF  .NOT. EOF()

               DBCLOSEARE()
               SETCOLOR("+GR")
               QOUT(CHR(7))
               DEVPOS(22, 10)
               DEVOUT("ESTE CODIGO YA EXISTE")
               MEMVAR->X := INKEY(0)
               LOOP

            ENDIF

            DBAPPEND()
            FIELD->CODART := WCOD
            FIELD->NUMART := VAL(WCOD)
            FIELD->NOMBRE := WNOM
            FIELD->UNIDAD := UPPER(LTRIM(WUNI))
            FIELD->PORC1 := WPO1
            FIELD->PORC2 := WPO2
            FIELD->PORC3 := WPO3
            FIELD->VRLISTA := WVRLISTA
            DBCLOSEARE()

         ENDDO

         MEMVAR->OPC := " "
         LOOP

      ELSEIF OPC = "2"

         MODPRTE()

      ELSEIF OPC = "3"

         MEMVAR->OPC := " "
         ESPERE()
         AMAPAE()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
         ORDLISTREB()
         DBCLOSEARE()
         ATAE()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\PROTARCO")
         ORDLISTREB()
         DBCLOSEARE()

         DO WHILE OPC <> "*"

            MENU()
            SETCOLOR("+G")
            DEVPOS(5, 1)
            DEVOUT(PADC("BORRANDO DE REFERENCIAS EN MAESTRO", 78))
            SETCOLOR("+W")
            MEMVAR->OPC := " "
            MEMVAR->WCOD := ZLCPT
            DEVPOS(13, 20)
            DEVOUT("CODIGO ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WCOD", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            SCROLL(12, 20, 13, 70)
            SETPOS(12, 20)

            IF WCOD = "    "

               EXIT

            ENDIF

            AMAPAS()
            ORDLISTCLE()
            ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
            DBSEEK("&WCOD")

            IF EOF()

               DBCLOSEARE()
               SETCOLOR("+R")
               DEVPOS(15, 20)
               DEVOUT("CODIGO NO EXISTE")
               MEMVAR->X := INKEY(0)
               LOOP

            ENDIF

            IF DELETED()

               DBCLOSEARE()
               SETCOLOR("+R")
               DEVPOS(15, 20)
               DEVOUT("LO ACABA DE BORRAR")
               MEMVAR->X := INKEY(0)
               LOOP

            ENDIF

            MEMVAR->WCOD := CODART
            MEMVAR->WNOM := NOMBRE
            MEMVAR->WUNI := UNIDAD
            MEMVAR->WPO1 := PORC1
            MEMVAR->WPO2 := PORC2
            MEMVAR->WPO3 := PORC3
            MEMVAR->WVRLISTA := VRLISTA
            MEMVAR->WPOS1 := RECNO()
            DBCLOSEARE()
            MEMVAR->SWLEE := 0
            MENPRTE()
            SETCOLOR("+BG")
            MEMVAR->OPC := " "
            DEVPOS(21, 20)
            DEVOUT("SERA BORRADO TAMBIEN DEL ARCHIVO DE TAREAS")
            DEVPOS(22, 20)
            DEVOUT("ESTA SEGURO DE BORRAR ? S/N ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            SETCOLOR("+W")

            IF OPC = "S"

               ESPERE()
               AMAPAS()
               DBGOTO(WPOS1)
               VEALOCK()
               DBDELETE()
               DBCLOSEARE()
               ATAE()
               DBEVAL({||DBDELETE()}, {||CODPRO = WCOD}, NIL, NIL, NIL, ;
                     .F.)
               DBCLOSEARE()

            ENDIF

         ENDDO

         MEMVAR->OPC := " "
         AMAPAE()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
         __DBPACK()
         DBCLOSEARE()
         ATAE()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\PROTARCO")
         __DBPACK()
         DBCLOSEARE()

      ELSEIF OPC = "4"

         SCROLL(5, 1, 23, 78)
         SETPOS(5, 1)
         DEVPOS(12, 20)
         DEVOUT("POR FAVOR DEME LA FECHA DEL LISTADO")
         DEVPOS(13, 5)
         DEVOUT(" ")
         __RUN("DATE")
         MENU()
         ESPERE()
         MEMVAR->WAB := "BASURA.NTX"
         BA()
         AMAPAS()
         __DBSORT("C:\BASURA", {"NUMART"}, NIL, NIL, NIL, NIL, .F.)
         DBCLOSEARE()
         DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
         DEVPOS(12, 20)
         DEVOUT("                        ")
         MEMVAR->OPC := " "
         PIDEIMP()
         MEMVAR->OPC := " "
         __REPORTFO("LISPRTE", .T., NIL, .F., NIL, NIL, NIL, NIL, .F., .F.,;
                NIL, .F., .F.)
         __EJECT()
         DBCLOSEARE()
         MEMVAR->WAB := "BASURA.NTX"
         BA()
         SCROLL(5, 1, 23, 78)
         SETPOS(5, 1)
         DEVPOS(12, 20)
         DEVOUT("POR FAVOR DEVUELVA LA FECHA ACTUAL ")
         __RUN("DATE")

      ENDIF

   ENDDO

   MEMVAR->OPC := " "

RETURN 

