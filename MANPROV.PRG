/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MANPROV
   Params: None.
   Return: Undefined
  Example: MANPROV()
  ..........................................................................
*/

PROCEDURE MANPROV()

   MEMVAR->OPC := " "

   DO WHILE OPC <> "*"

      MEMVAR->OPC := "*"
      MENU()
      DEVPOS(6, 22)
      DEVOUT("MANEJO DE ARCHIVO MAESTRO DE PROVEEDORES")
      DEVPOS(12, 25)
      DEVOUT("1. CREACION ")
      DEVPOS(13, 25)
      DEVOUT("2. MODIFICACION DE DATOS")
      DEVPOS(14, 25)
      DEVOUT("3. BORRADO ")
      DEVPOS(15, 25)
      DEVOUT("4. LISTADO ")
      DEVPOS(16, 25)
      DEVOUT("*  FIN")
      DEVPOS(20, 20)
      DEVOUT("SELECCIONE UNA OPCION ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "*"

         LOOP

      ENDIF

      MEMVAR->WNIV := "14" + OPC + "  "
      MEMVAR->XS := " "
      VEANIV()

      IF XS = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      IF OPC = "1"

         MEMVAR->OPC := " "
         MENU()
         SET(3, 2)
         AMAPRVE()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\COD-PROV")
         ORDLISTREB()
         DBCLOSEARE()

         DO WHILE OPC <> "*"

            MEMVAR->WDES := MEMVAR->WSALDOCI := MEMVAR->WSALDOSI := 0.0
            MEMVAR->OPC := MEMVAR->WCANCOP := " "
            MEMVAR->WCOD := SPACE(5)
            MEMVAR->WNIT := SPACE(11)
            MEMVAR->WTE1 := SPACE(18)
            MEMVAR->WCIU := SPACE(15)
            MEMVAR->WHORATE := SPACE(20)
            MEMVAR->WCONPAG := SPACE(25)
            MEMVAR->WNOMEST := MEMVAR->WNOMPROV := MEMVAR->WDIR := MEMVAR->;
                  WCON := SPACE(30)
            MEMVAR->WULTFAC := DATE()
            MENU()
            SETCOLOR("+BR")
            DEVPOS(5, 25)
            DEVOUT("CREACION DE PROVEEDORES EN MAESTRO")
            SETCOLOR("+W")
            MEMVAR->SWLEE := 1
            MENPRV()

            IF WCOD = "  "

               MEMVAR->OPC := "*"
               LOOP

            ENDIF

            MEMVAR->CL := " "
            SETCOLOR("G")
            MEMVAR->OPC := " "
            DEVPOS(23, 20)
            DEVOUT("ESTA TODO CORRECTO ? S/N ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            DEVPOS(23, 10)
            DEVOUT("                                              ")
            SETCOLOR("W")

            IF OPC <> "S"

               RUTMODPV()

            ENDIF

            IF WCOD = "   "

               MEMVAR->OPC := "*"
               LOOP

            ENDIF

            AMAPRVS()
            ORDLISTCLE()
            ORDLISTADD("&ZDIS\&WDIRECTO\COD-PROV")
            DBSEEK("&WCOD")

            IF  .NOT. EOF()

               DBCLOSEARE()
               SETCOLOR("+GR")
               QOUT(CHR(7))
               SCROLL(23, 5, 23, 78)
               SETPOS(23, 5)
               DEVPOS(23, 10)
               DEVOUT("ESTE CODIGO YA EXISTE")
               MEMVAR->X := INKEY(0)
               LOOP

            ENDIF

            DBAPPEND()
            FIELD->CODIGO := WCOD
            FIELD->CODPROV := VAL(WCOD)
            FIELD->NOMEST := WNOMEST
            FIELD->NOMPROV := WNOMPROV
            FIELD->DIRECCION := WDIR
            FIELD->TELEFONO := WTE1
            FIELD->CIUDAD := WCIU
            FIELD->NIT := WNIT
            FIELD->HORATE := WHORATE
            FIELD->CONPAG := WCONPAG
            FIELD->DESCUENTO := WDES
            FIELD->SALDOCI := WSALDOCI
            FIELD->SALDOSI := WSALDOSI
            FIELD->ULTFAC := WULTFAC
            FIELD->CANCOP := VAL(WCANCOP)
            DBCLOSEARE()

         ENDDO

         MEMVAR->OPC := " "
         AMAPRVS()

         IF LASTREC() > 1

            DBCLOSEARE()
            MENU()
            SETCOLOR("+BR")
            DEVPOS(5, 25)
            DEVOUT("CREACION DE PROVEEDORES EN MAESTRO")
            ESPERE()
            AMAPRVS()
            MEMVAR->WAB := "BASURA.DBF"
            BA()
            __DBSORT("C:\BASURA", {"CODPROV"}, NIL, NIL, NIL, NIL, .F.)
            DBCLOSEARE()
            FERASE("&ZDIS\&WDIRECTO\MAPROV.DBF")
            FERASE("&ZDIS\&WDIRECTO\COD-PROV.NTX")
            DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
            __DBCOPY("&ZDIS\&WDIRECTO\MAPROV.DBF", {}, NIL, NIL, NIL, NIL, ;
                  .F., NIL)
            DBCLOSEARE()
            MEMVAR->WAB := "BASURA.DBF"
            BA()
            AMAPRVE()
            DBCREATEIN("&ZDIS\&WDIRECTO\COD-PROV", "CODIGO", {||CODIGO}, ;
                  NIL)

         ENDIF

         DBCLOSEARE()
         SETCOLOR("W")
         SET(33, "OFF")
         SET(31, "ON")

      ELSEIF OPC = "2"

         MEMVAR->OPC := " "
         AMAPRVE()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\COD-PROV")
         ORDLISTREB()
         DBCLOSEARE()

         DO WHILE OPC <> "N"

            MEMVAR->OPC := " "
            MENU()
            DEVPOS(5, 25)
            DEVOUT("MODIFICACION DE PROVEEDORES EN MAESTRO")
            MEMVAR->WCOD := SPACE(5)
            DEVPOS(12, 20)
            DEVOUT("POR FAVOR DEME EL CODIGO A MODIFICAR ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WCOD", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

            IF WCOD = "  " .OR. LASTKEY() = 27

               MEMVAR->OPC := "N"
               LOOP

            ENDIF

            AMAPRVS()
            ORDLISTCLE()
            ORDLISTADD("&ZDIS\&WDIRECTO\COD-PROV")
            DBSEEK("&WCOD")

            IF EOF()

               DBCLOSEARE()
               SETCOLOR("+W/R")
               QOUT(CHR(7))
               DEVPOS(14, 20)
               DEVOUT("ESE CODIGO NO EXISTE, INTENTE DE NUEVO")
               MEMVAR->X := INKEY(0)
               LOOP

            ENDIF

            SCROLL(12, 20, 14, 78)
            SETPOS(12, 20)
            SETCOLOR("+W")
            MEMVAR->WCOD := CODIGO
            MEMVAR->WNOMEST := MEMVAR->WNOMPROV := MEMVAR->WDIR := MEMVAR->;
                  WTE1 := MEMVAR->WCIU := MEMVAR->WNIT := MEMVAR->WHORATE := ;
                  MEMVAR->WCONPAG := MEMVAR->WDES := MEMVAR->WSALDOCI := ;
                  MEMVAR->WSALDOSI := MEMVAR->WULTFAC := MEMVAR->WCANCOP := ;
                  MEMVAR->WPOS17 := ""
            CARVPR()
            DBCLOSEARE()
            MEMVAR->SWLEE := 0
            MENPRV()
            SETCOLOR("+W")
            MEMVAR->CL := " "
            READKILL(.T.)
            MEMVAR->GETLIST := {}
            RUTMODPV()
            SETCOLOR("W")
            AMAPRVS()
            ORDLISTCLE()
            ORDLISTADD("&ZDIS\&WDIRECTO\COD-PROV")
            DBSEEK("&WCOD")

            IF  .NOT. EOF() .AND. RECNO() <> WPOS17

               DBCLOSEARE()
               SETCOLOR("R")
               QOUT(CHR(7))
               SCROLL(23, 5, 23, 78)
               SETPOS(23, 5)
               DEVPOS(23, 10)
               DEVOUT("ESTE CODIGO YA EXISTE")
               MEMVAR->X := INKEY(0)
               LOOP

            ENDIF

            DBGOTO(WPOS17)
            VEALOCK()
            FIELD->CODIGO := WCOD
            FIELD->CODPROV := VAL(WCOD)
            FIELD->NOMEST := WNOMEST
            FIELD->NOMPROV := WNOMPROV
            FIELD->DIRECCION := WDIR
            FIELD->TELEFONO := WTE1
            FIELD->CIUDAD := WCIU
            FIELD->NIT := WNIT
            FIELD->HORATE := WHORATE
            FIELD->CONPAG := WCONPAG
            FIELD->DESCUENTO := WDES
            FIELD->SALDOCI := WSALDOCI
            FIELD->ULTFAC := WULTFAC
            FIELD->CANCOP := VAL(WCANCOP)
            DBCLOSEARE()

         ENDDO

         MEMVAR->OPC := " "
         ESPERE()
         MEMVAR->WAB := "BASURA.DBF"
         BA()
         AMAPRVS()
         __DBSORT("C:\BASURA", {"CODPROV"}, NIL, NIL, NIL, NIL, .F.)
         DBCLOSEARE()

         IF FILE("&ZDIS\&WDIRECTO\MAPROV.BAK")

            FERASE("&ZDIS\&WDIRECTO\MAPROV.BAK")

         ENDIF

         FRENAME("&ZDIS\&WDIRECTO\MAPROV.DBF", ;
               "&ZDIS\&WDIRECTO\MAPROV.BAK")
         DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
         __DBCOPY("&ZDIS\&WDIRECTO\MAPROV.DBF", {}, NIL, NIL, NIL, NIL, ;
               .F., NIL)
         DBCLOSEARE()
         MEMVAR->WAB := "BASURA.DBF"
         BA()
         AMAPRVE()
         BORPRVX()
         DBCREATEIN("&ZDIS\&WDIRECTO\COD-PROV", "CODIGO", {||CODIGO}, NIL)
         DBCLOSEARE()

      ELSEIF OPC = "3"

         MEMVAR->OPC := " "
         SCROLL(5, 1, 23, 78)
         SETPOS(5, 1)
         AMAPRVE()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\COD-PROV")
         ORDLISTREB()
         DBCLOSEARE()

         DO WHILE OPC <> "N"

            MEMVAR->OPC := " "
            MENU()
            SETCOLOR("BR")
            DEVPOS(5, 28)
            DEVOUT("BORRADO DE PROVEEDORES EN MAESTRO")
            MEMVAR->WCOD := SPACE(5)
            DEVPOS(12, 20)
            DEVOUT("POR FAVOR DEME EL CODIGO A BORRAR ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WCOD", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

            IF WCOD = "  " .OR. LASTKEY() = 27

               MEMVAR->OPC := "N"
               LOOP

            ENDIF

            AMAPRVS()
            ORDLISTCLE()
            ORDLISTADD("&ZDIS\&WDIRECTO\COD-PROV")
            DBSEEK("&WCOD")

            IF EOF()

               DBCLOSEARE()
               SETCOLOR("+W/R")
               QOUT(CHR(7))
               DEVPOS(14, 20)
               DEVOUT("ESE CODIGO NO EXISTE ")
               MEMVAR->X := INKEY(0)
               LOOP

            ENDIF

            IF DELETED()

               DBCLOSEARE()
               DEVPOS(14, 20)
               DEVOUT("LO ACABA DE BORRAR")
               MEMVAR->X := INKEY(0)
               SETCOLOR("W")
               SCROLL(12, 20, 14, 78)
               SETPOS(12, 20)
               LOOP

            ENDIF

            SCROLL(12, 20, 14, 78)
            SETPOS(12, 20)
            SETCOLOR("+W")
            MEMVAR->WNOMEST := MEMVAR->WNOMPROV := MEMVAR->WDIR := MEMVAR->;
                  WTE1 := MEMVAR->WCIU := MEMVAR->WNIT := MEMVAR->WHORATE := ;
                  MEMVAR->WCONPAG := MEMVAR->WDES := MEMVAR->WSALDOCI := ;
                  MEMVAR->WSALDOSI := MEMVAR->WULTFAC := MEMVAR->WCANCOP := ;
                  MEMVAR->WPOS17 := ""
            CARVPR()
            DBCLOSEARE()
            MEMVAR->SWLEE := 0
            MENPRV()
            SETCOLOR("+W")
            MEMVAR->OPC := " "
            DEVPOS(23, 20)
            DEVOUT("ESTA SEGURO DE BORRAR ? S/N ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

            IF OPC = "S"

               AMAPRVE()
               ORDLISTCLE()
               ORDLISTADD("&ZDIS\&WDIRECTO\COD-PROV")
               DBSEEK("&WCOD")
               DBDELETE()

            ENDIF

            MEMVAR->OPC := " "
            DBCLOSEARE()

         ENDDO

         MEMVAR->OPC := " "
         AMAPRVE()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\COD-PROV")
         __DBPACK()
         ORDLISTREB()
         DBCLOSEARE()

      ELSEIF OPC = "4"

         MEMVAR->OPC := " "
         SCROLL(5, 1, 23, 78)
         SETPOS(5, 1)
         PIDEIMP()
         AMAPRVS()
         __RUN("MODE LPT1:132")
         __REPORTFO("LISPROV", .T., NIL, .F., NIL, NIL, NIL, NIL, .F., .F.,;
                NIL, .F., .F.)
         __EJECT()
         DBCLOSEARE()
         __RUN("MODE LPT1:80")
         MEMVAR->OPC := " "

      ENDIF

   ENDDO

   MEMVAR->OPC := " "

RETURN 

