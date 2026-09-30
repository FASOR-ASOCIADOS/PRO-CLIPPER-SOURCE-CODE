/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: PROG8
   Params: None.
   Return: Undefined
  Example: PROG8()
  ..........................................................................
*/

PROCEDURE PROG8()

   MENU()
   DEVPOS(5, 1)
   DEVOUT(PADC(;
         "MANTENIMIENTO Y REORGANIZACION DE ARCHIVOS DE INDICES DEL SISTEMA";
         , 78))
   MEMVAR->OPC := " "

   IF SWAUTO = 0

      DEVPOS(12, 10)
      DEVOUT("!!! ADVERTENCIA !!!")
      DEVPOS(14, 5)
      DEVOUT("Esta opci" + O + "n bloquear" + A + ;
            " el sistema de producci" + O + "n y las entradas")
      DEVPOS(15, 5)
      DEVOUT("a inventario de producto terminado. Desea continuar ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "N"

         MEMVAR->OPC := " "
         RETURN 

      ENDIF

   ENDIF

   MEMVAR->OPC := " "
   ESPERE()
   AMAINE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   DBEVAL({||FIELD->CODNUM := VAL(CODIGO)}, NIL, NIL, NIL, NIL, .F.)
   __DBSORT("C:\PROTMP\BASURA", {"CODNUM", "NUMCOLOR"}, NIL, NIL, NIL, NIL, .F.)
   DBCLOSEARE()

   IF FILE("&ZDIS\&WDIRECTO\MAINSUBK.DBF")

      FERASE("&ZDIS\&WDIRECTO\MAINSUBK.DBF")

   ENDIF

   FRENAME("&ZDIS\&WDIRECTO\&FMAINSU", "&ZDIS\&WDIRECTO\MAINSUBK.DBF")
   __COPYFILE("C:\PROTMP\BASURA.DBF", "&ZDIS\&WDIRECTO\&FMAINSU")
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   AMAINE()

   IF FILE("&ZDIS\&WDIRECTO\COD-INS.NTX")

      FERASE("&ZDIS\&WDIRECTO\COD-INS.NTX")

   ENDIF

   DBCREATEIN("&ZDIS\&WDIRECTO\COD-INS", "CODIGO", {||CODIGO}, NIL)
   DBCLOSEARE()
   AOPTEE()
   BORPICO()
   DBCREATEIN("&ZDIS\&WDIRECTO\PICO", "PRINCOOP", {||PRINCOOP}, NIL)
   DBCLOSEARE()

   IF FILE("&ZDIS\&WDIRECTO\CODMAEPA.NTX")

      FERASE("&ZDIS\&WDIRECTO\CODMAEPA.NTX")

   ENDIF

   AMAPAE()
   DBCREATEIN("&ZDIS\&WDIRECTO\CODMAEPA", "CODART", {||CODART}, NIL)
   DBCLOSEARE()
   BORPRVX()
   AMAPRVE()
   DBCREATEIN("&ZDIS\&WDIRECTO\COD-PROV", "CODIGO", {||CODIGO}, NIL)
   DBCLOSEARE()
   AMAPERE()
   BORPER()
   DBCREATEIN("&ZDIS\&WDIRECTO\COD-PER", "CODIGO", {||CODIGO}, NIL)
   DBCLOSEARE()
   ATAE()
   BORPTC()
   DBCREATEIN("&ZDIS\&WDIRECTO\PROTARCO", "PROTARCOL", {||PROTARCOL}, NIL)
   DBCLOSEARE()
   ACOSE()
   MEMVAR->WAB := "COSTOS.KEY"
   BA()
   DBCREATEIN("&ZDIS\&WDIRECTO\COSTOS.KEY", "LETORD", {||LETORD}, NIL)
   DBCLOSEARE()

   IF FILE("&ZDIS\&WDIRECTO\TIPMOVPR.NTX")

      FERASE("&ZDIS\&WDIRECTO\TIPMOVPR.NTX")

   ENDIF

   ATIPMOVE()
   DBCREATEIN("&ZDIS\&WDIRECTO\TIPMOVPR", "TIPO", {||TIPO}, NIL)
   DBCLOSEARE()
   AMAIBKE()

   IF FILE("&ZDIS\&WDIRECTO\MAINSBAK.NTX")

      FERASE("&ZDIS\&WDIRECTO\MAINSBAK.NTX")

   ENDIF

   DBCREATEIN("&ZDIS\&WDIRECTO\MAINSBAK.NTX", "CODIGO", {||CODIGO}, NIL)
   DBCLOSEARE()
   ADEMASE()
   DBCLOSEARE()
   AMAQE()
   DBCLOSEARE()
   AP6030E()
   DBCLOSEARE()
   AHP63E()
   DBCLOSEARE()
   AP6030S()
   ACOSS()
   MEMVAR->WAB := "BASURA1.NTX"
   BA()
   DBSELECTAR("13")
   DBCREATEIN("C:\PROTMP\BASURA1.NTX", "LETORD", {||LETORD}, NIL)
   DBSELECTAR("23")
   DBGOTOP()

   DO WHILE  .NOT. EOF()

      IF FECHA = CTOD("  /  /  ")

         MEMVAR->WNO := PADR(ALLTRIM(TRANSFORM(NUMORD, "99999999")), 8, " ")
         DBSELECTAR("13")
         DBSEEK("&WNO")

         IF  .NOT. EOF()

            MEMVAR->WFECHA := FECHA
            DBSELECTAR("23")
            VEALOCK()
            FIELD->FECHA := WFECHA

         ENDIF

      ENDIF

      DBSELECTAR("23")
      DBSKIP(1)

   ENDDO

   DBSELECTAR("23")
   DBCLOSEARE()
   DBSELECTAR("13")
   DBCLOSEARE()
   MEMVAR->WAB := "BASURA1.NTX"
   BA()

RETURN 

