/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: PROG92
   Params: None.
   Return: Undefined
  Example: PROG92()
  ..........................................................................
*/

PROCEDURE PROG92()

   MENU()
   SETCOLOR("*+G")
   DEVPOS(8, 1)
   DEVOUT(PADC("PROCESO DE SISTEMA COMPLETO RESTRINGIDO PARA A UN USUARIO",;
          78))
   SETCOLOR("+W")
   DEVPOS(10, 10)
   DEVOUT("Tiempo aproximado de duracion 3 minutos")
   MEMVAR->OPC := " "
   DEVPOS(12, 10)
   DEVOUT("Ahora de dispone a trasladar los saldos de inventario del mes")
   DEVPOS(13, 10)
   DEVOUT("anterior al mes actual. Desea continuar ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC = "N"

      MEMVAR->OPC := 1
      RETURN 

   ENDIF

   MEMVAR->WMESANT := ZMES - 1

   IF WMESANT = 0

      MEMVAR->WMESANT := 12

   ENDIF

   MEMVAR->FMOVINSA := "MOVINS" + ALLTRIM(TRANSFORM(WMESANT, "99")) + ;
         ".DBF"
   MEMVAR->FINSA := "MAINSU" + ALLTRIM(TRANSFORM(WMESANT, "99")) + ".DBF"

   IF  .NOT. FILE("&ZDIS\&WDIRECTO\&FMOVINSA") .OR. .NOT. FILE(;
         "&ZDIS\&WDIRECTO\&FINSA")

      MEMVAR->OPC := " "
      DEVPOS(15, 10)
      DEVOUT("!!  ERROR !!")
      DEVPOS(17, 10)
      DEVOUT("Los archivos del mes anterior no fueron encontrados")
      DEVPOS(18, 10)
      DEVOUT("Pulse  *  ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "*"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      MEMVAR->OPC := 1
      RETURN 

   ENDIF

   ESPERE()
   DEVPOS(13, 10)
   DEVOUT("Trayendo los saldos del mes anterior del maestro de insumos...")
   DBSELECTAR("1")
   DBUSEAREA(.F., NIL, FINSA, NIL, .F., .F.)
   MEMVAR->WAB := "BASURA.NTX"
   BA()
   DBCREATEIN("C:\BASURA.KEY", "CODIGO+COLOR", {||CODIGO + COLOR}, NIL)
   AMAINE()
   DBEVAL({||FIELD->SALDOUNI := 0, FIELD->SALDOPES := 0, FIELD->ENTMESUNI := ;
         0, FIELD->ENTMESPES := 0, FIELD->OTRENMEUNI := 0, FIELD->OTRENMEPES ;
         := 0, FIELD->CONMESUNI := 0, FIELD->CONMESPES := 0, FIELD->;
         OTRSAMESUN := 0, FIELD->OTRSAMESPE := 0, FIELD->COSCONMES := 0}, ;
         NIL, NIL, NIL, NIL, .F.)
   DBSELECTAR("1")
   DBGOTOP()
   MEMVAR->SWCANC := 0
   DEVPOS(22, 10)
   DEVOUT("VERIFICANDO CODIGOS ENTRE LOS DOS MESES....")

   DO WHILE  .NOT. EOF()

      MEMVAR->WCOD := CODIGO
      MEMVAR->WCOL := COLOR
      MEMVAR->WSU := SALDOUNI
      MEMVAR->WSP := SALDOPES
      DBSELECTAR("2")
      __DBLOCATE({||CODIGO = WCOD .AND. COLOR = WCOL}, NIL, NIL, NIL, .F.)

      IF EOF() .AND. (WSU <> 0 .OR. WSP <> 0)

         IF SWCAN = 0

            SCROLL()
            SETPOS(0, 0)
            READKILL(.T.)
            MEMVAR->GETLIST := {}

         ENDIF

         MEMVAR->SWCANC := 1
         QOUT("CODIGO " + WCOD + WCOL + ;
               " Trae saldo y no existe en el mes actual")

      ENDIF

      DBSELECTAR("2")
      DBSKIP(1)

   ENDDO

   IF SWCANC = 1

      MEMVAR->OPC := " "
      DEVPOS(23, 1)
      DEVOUT("TRASLADO DE SALDOS CANCELADO, faltan codigos, pulse * ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "*"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      MEMVAR->OPC := 1
      DBCLOSEALL()
      RETURN 

   ENDIF

   DBSELECTAR("2")
   DBGOTOP()
   SCROLL(7, 1, 23, 78)
   SETPOS(7, 1)

   DO WHILE  .NOT. EOF()

      DBSELECTAR("2")
      DEVPOS(20, 5)
      DEVOUT("Registro " + LTRIM(TRANSFORM(RECNO(), "9,999")) + " de " + ;
            LTRIM(TRANSFORM(LASTREC(), "9,999")))
      MEMVAR->WCOD := CODIGO
      MEMVAR->WCOL := COLOR
      MEMVAR->WLLA := WCOD + WCOL
      MEMVAR->WSU := MEMVAR->WSP := MEMVAR->WSALDOUNI := MEMVAR->WSALDOPES := ;
            MEMVAR->WENTANOUNI := MEMVAR->WENTANOPES := MEMVAR->WOTRENANOU := ;
            MEMVAR->WOTRENANOP := MEMVAR->WVENANOUNI := MEMVAR->WVENANOPES := ;
            MEMVAR->WOTRSAANOU := MEMVAR->WOTRSAANOP := MEMVAR->WCOSVENANO := ;
            0
      DBSELECTAR("1")
      DBSEEK("&WLLA")

      IF  .NOT. EOF()

         MEMVAR->WSU := MEMVAR->WSALDOUNI := SALDOUNI
         MEMVAR->WSP := MEMVAR->WSALDOPES := SALDOPES
         MEMVAR->WENTANOUNI := ENTANOUNI
         MEMVAR->WENTANOPES := ENTANOPES
         MEMVAR->WOTRENANOU := OTRENANOUN
         MEMVAR->WOTRENANOP := OTRENANOPE
         MEMVAR->WCONANOUNI := CONANOUNI
         MEMVAR->WCONANOPES := CONANOPES
         MEMVAR->WOTRSAANOU := OTRSAANOUN
         MEMVAR->WOTRSAANOP := OTRSAANOPE
         MEMVAR->WCOSCONANO := COSCONANO
         DBSELECTAR("2")
         VEALOCK()
         FIELD->SALDOUNI := WSU
         FIELD->SALDOPES := WSP
         FIELD->ENTMESUNI := 0
         FIELD->ENTMESPES := 0
         FIELD->OTRENMEUNI := 0
         FIELD->OTRENMEPES := 0
         FIELD->CONMESUNI := 0
         FIELD->CONMESPES := 0
         FIELD->OTRSAMESUN := 0
         FIELD->OTRSAMESPE := 0
         FIELD->COSCONMES := 0
         FIELD->ENTANOUNI := WENTANOUNI
         FIELD->ENTANOPES := WENTANOPES
         FIELD->OTRENANOUN := WOTRENANOU
         FIELD->OTRENANOPE := WOTRENANOP
         FIELD->CONANOUNI := WCONANOUNI
         FIELD->CONANOPES := WCONANOPES
         FIELD->OTRSAANOUN := WOTRSAANOU
         FIELD->OTRSAANOPE := WOTRSAANOP
         FIELD->COSCONANO := WCOSCONANO

         IF SALDOPES > -10 .AND. SALDOPES < 1

            FIELD->SALDOPES := 0

         ENDIF

         IF WMESANT = 12

            FIELD->ENTANOUNI := 0
            FIELD->ENTANOPES := 0
            FIELD->OTRENANOUN := 0
            FIELD->OTRENANOPE := 0
            FIELD->CONANOUNI := 0
            FIELD->CONANOPES := 0
            FIELD->OTRSAANOUN := 0
            FIELD->OTRSAANOPE := 0
            FIELD->COSCONANO := 0

         ENDIF

         DBCOMMITAL()
         DBUNLOCK()
         DBSKIP(1)

      ELSE

         __WAIT("NO EXISTE EN EL MES ANTERIOR LA REFERENCIA Y COLOR :" + ;
               WCOD + WCOL)
         DBSELECTAR("2")
         DBCOMMITAL()
         DBUNLOCK()
         DBSKIP(1)

      ENDIF

   ENDDO

   CIERRE()
   MEMVAR->WAB := "BASURA.NTX"
   BA()
   MEMVAR->SWAUTO := 1
   BATMAINS()
   MEMVAR->OPC := 1

RETURN 

