/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: PROG91
   Params: None.
   Return: Undefined
  Example: PROG91()
  ..........................................................................
*/

PROCEDURE PROG91()

   MENU()
   MEMVAR->OPC := " "
   DEVPOS(12, 10)
   DEVOUT(;
         "Ahora se dispone a abrir un nuevo mes en el sistema de produccion";
         )
   DEVPOS(13, 10)
   DEVOUT("Desea continuar ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC = "N" .OR. LASTKEY() = 27

      MEMVAR->OPC := 1
      RETURN 

   ENDIF

   MENU()
   MEMVAR->OPC := " "
   MEMVAR->WNUEMES := ZMES + 1

   IF WNUEMES = 13

      MEMVAR->WNUEMES := 1

   ENDIF

   MEMVAR->FMOVINS := "MOVINS" + ALLTRIM(TRANSFORM(ZMES, "99")) + ".DBF"
   MEMVAR->FMAINSU := "MAINSU" + ALLTRIM(TRANSFORM(ZMES, "99")) + ".DBF"
   MEMVAR->FMOVINSN := "MOVINS" + ALLTRIM(TRANSFORM(WNUEMES, "99")) + ;
         ".DBF"
   MEMVAR->FMAINSUN := "MAINSU" + ALLTRIM(TRANSFORM(WNUEMES, "99")) + ;
         ".DBF"

   IF FILE("&ZDIS\&WDIRECTO\&FMOVINSN") .OR. FILE(;
         "&ZDIS\&WDIRECTO\&FMAINSUN")

      MEMVAR->OPC := " "
      DEVPOS(15, 10)
      DEVOUT("!!  ADVERTENCIA !!")
      DEVPOS(17, 10)
      DEVOUT("Se encontraron archivos correspondientes al mes que piensa")
      DEVPOS(18, 10)
      DEVOUT("abrir. Contin" + U + "a con el proceso ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "N" .OR. LASTKEY() = 27

         MEMVAR->OPC := 1
         RETURN 

      ENDIF

   ENDIF

   IF FILE("&ZDIS\&WDIRE\&FMOVINSN")

      FERASE("&ZDIS\&WDIRE\&FMOVINSN")

   ENDIF

   IF FILE("&ZDIS\&WDIRE\&FMAINSUN")

      FERASE("&ZDIS\&WDIRE\&FMAINSUN")

   ENDIF

   MENU()
   DEVPOS(12, 10)
   DEVOUT("Abriendo el mes # " + ALLTRIM(TRANSFORM(WNUEMES, "99")))
   DEVPOS(13, 10)
   DEVOUT("POR FAVOR ESPERE...")
   __COPYFILE("&ZDIS\&WDIRECTO\&FMAINSU", "&ZDIS\&WDIRECTO\&FMAINSUN")
   AMOVMESS()
   __DBCOPYST("&ZDIS\&WDIRECTO\&FMOVINSN", {})
   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\&FMAINSUN", NIL, .F., .F.)
   DBEVAL({||FIELD->ENTMESUNI := 0, FIELD->ENTMESPES := 0, FIELD->OTRENMEUNI ;
         := 0, FIELD->OTRENMEPES := 0, FIELD->CONMESUNI := 0, FIELD->;
         CONMESPES := 0, FIELD->OTRSAMESUN := 0, FIELD->OTRSAMESPE := 0, ;
         FIELD->COSCONMES := 0}, NIL, NIL, NIL, NIL, .F.)
   DBCLOSEARE()

   IF WNUEMES = 1

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\&FMAINSUN", NIL, .F., .F.)
      DBEVAL({||FIELD->ENTMESUNI := 0, FIELD->ENTMESPES := 0, FIELD->;
            OTRENMEUNI := 0, FIELD->OTRENMEPES := 0, FIELD->CONMESUNI := 0, ;
            FIELD->CONMESPES := 0, FIELD->OTRSAMESUN := 0, FIELD->OTRSAMESPE ;
            := 0, FIELD->COSCONMES := 0, FIELD->ENTANOUNI := 0, FIELD->;
            ENTANOPES := 0, FIELD->OTRENANOUN := 0, FIELD->OTRENANOPE := 0}, ;
            NIL, NIL, NIL, NIL, .F.)
      DBEVAL({||FIELD->CONANOUNI := 0, FIELD->CONANOPES := 0, FIELD->;
            OTRSAANOUN := 0, FIELD->OTRSAANOPE := 0, FIELD->COSCONANO := 0}, ;
            NIL, NIL, NIL, NIL, .F.)
      DBCLOSEARE()

   ENDIF

   DBCLOSEARE()
   MEMVAR->SWAUTO := 1
   PROG8()
   MENU()
   DEVPOS(7, 1)
   DEVOUT(PADC(;
         "ACTUALIZANDO PRECIOS DE VENTA DESDE INVENTARIO DE PRODUCTO TERMINADO";
         , 78))
   MEMVAR->ZMESP := ZMES
   MEMVAR->ZANOP := ZANO
   __MRESTORE("&ZDIS\IFC\ZMES.DAT", .T.)
   MEMVAR->ZMESIFC := ZMES
   MEMVAR->ZMES := ZMESP
   MEMVAR->ZANO := ZANOP
   MEMVAR->WMAINV := "MAINV" + ALLTRIM(TRANSFORM(ZMESIFC, "99")) + ".DBF"
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   __COPYFILE("&ZDIS\IFC\&WMAINV", "C:\BASURA.DBF")
   AMAPAS()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
   DBSELECTAR("2")
   DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
   DBCREATEIN("C:\BASURA", "CODIGO", {||CODIGO}, NIL)
   DBSELECTAR("1")

   DO WHILE  .NOT. EOF()

      MEMVAR->WCOD := CODART
      DBSELECTAR("2")
      DBSEEK(WCOD)

      IF  .NOT. EOF()

         IF PRECIO2 > 0

            MEMVAR->WVRLIS := PRECIO2

         ELSE

            MEMVAR->WVRLIS := PRECIO1

         ENDIF

         DBSELECTAR("1")
         VEALOCK()
         FIELD->VRLISTA := WVRLIS

      ENDIF

      DBSELECTAR("1")
      DBSKIP(1)

   ENDDO

   DBSELECTAR("1")
   DBCLOSEARE()
   DBSELECTAR("2")
   DBCLOSEARE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->WAB := "BASURA.NTX"
   BA()
   MEMVAR->OPC := 1

RETURN 

