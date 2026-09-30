/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: CIEDIATA
   Params: None.
   Return: Undefined
  Example: CIEDIATA()
  ..........................................................................
*/

PROCEDURE CIEDIATA()

   MEMVAR->OPC := " "
   MENU()
   DEVPOS(7, 24)
   DEVOUT("CIERRE DE DIA DE PAGOS DE TAREAS")
   MEMVAR->LINEA := REPLICATE("ß", 32)
   SETCOLOR("+GR")
   DEVPOS(8, 24)
   DEVOUT(LINEA)
   SETCOLOR("+W")
   DEVPOS(12, 25)
   DEVOUT("Por medio de esta opci" + O + "n se cerrar" + A + ;
         " el dia de pagos")
   DEVPOS(13, 25)
   DEVOUT("de tareas, esto es; los datos  antes grabados ser" + A + "n")
   DEVPOS(14, 25)
   DEVOUT("pasados al archivo mensual de pagos.")
   DEVPOS(16, 25)
   DEVOUT("desea continuar ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC <> "S" .OR. LASTKEY() = 27

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   ESPERE()
   MEMVAR->WAB := "COSTOS.NTX"
   BA()
   ACOSE()
   DBCREATEIN("C:\PROTMP\COSTOS.NTX", "LETORD", {||LETORD}, NIL)
   DBCLOSEARE()
   APAGAE()
   __DBAPP("&ZDIS\&WDIRECTO\PAGOSMO", {}, NIL, NIL, NIL, NIL, .F., NIL)
   DBCLOSEARE()
   APAMOS()
   SET(2, "OFF")
   SET(3, 0)
   SET(2, "ON")

   DO WHILE  .NOT. EOF()

      MEMVAR->WNUMORD := NUMORD
      MEMVAR->WPAGO := PAGO
      MEMVAR->WMINUTOS := MINUTOS
      MEMVAR->WCODPT := CODPRO
      ACOSS()
      ORDLISTCLE()
      ORDLISTADD("C:\PROTMP\COSTOS.NTX")
      MEMVAR->WLETORD := ALLTRIM(TRANSFORM(WNUMORD, "99999999")) + SPACE(8 -;
             LEN(ALLTRIM(TRANSFORM(WNUMORD, "99999999"))))
      DEVPOS(22, 10)
      DEVOUT("BUSCANDO OP # " + TRANSFORM(WNUMORD, "99999999"))

      IF WNUMORD <> 999

         DBSEEK("&WLETORD")

      ELSE

         __DBLOCATE({||NUMORD = WNUMORD .AND. CODPRO = WCODPT}, NIL, NIL, ;
               NIL, .F.)

      ENDIF

      IF  .NOT. EOF()

         VEALOCK()
         FIELD->PAGO := PAGO + WPAGO
         FIELD->MINUTOS := MINUTOS + WMINUTOS
         FIELD->CODUSU := WCODUSU
         FIELD->HORA := TIME()

      ENDIF

      DBCLOSEARE()
      DBSELECTAR("9")
      DBSKIP(1)

   ENDDO

   DBSELECTAR("9")
   DBCLOSEARE()
   DEVPOS(22, 10)
   DEVOUT("ADICIONANDO LA INFORMACION AL ARCHIVO MENSUAL")
   SCROLL(15, 40, 22, 75)
   SETPOS(15, 40)
   DISPBOX(15, 40, 22, 75, 1)
   SETCOLOR("+GR")
   DEVPOS(16, 41)
   DEVOUT("Este proceso se puede agilizar dando")
   DEVPOS(17, 41)
   DEVOUT("de baja los movimientos  de pagos de")
   DEVPOS(18, 41)
   DEVOUT("mano de obra de  las ordenes que han")
   DEVPOS(19, 41)
   DEVOUT("sido entradas hace varios meses, que")
   DEVPOS(20, 41)
   DEVOUT("ya se debe haber dado  de baja en el")
   DEVPOS(21, 41)
   DEVOUT("cuadro grande de costos.")
   AMOPAE()
   __DBAPP("&ZDIS\&WDIRECTO\PAGOSMO", {}, NIL, NIL, NIL, NIL, .F., NIL)
   DEVPOS(22, 10)
   DEVOUT("RECALCULANDO PROMEDIOS Y LOGROS              ")
   DBEVAL({||FIELD->PROMREAL := BUENAS / MINUTOS * 60, FIELD->NUMOPE := VAL(;
         CODOPE)}, {||MINUTOS <> 0}, NIL, NIL, NIL, .F.)
   DBEVAL({||FIELD->LOGRPROM := PROMREAL / UNIDADESH * 100, FIELD->NUMOPE := ;
         VAL(CODOPE)}, {||UNIDADESH <> 0}, NIL, NIL, NIL, .F.)
   DBCLOSEARE()
   APAMOE()
   SAP()
   DBCLOSEARE()
   APAGAE()
   DEVPOS(22, 10)
   DEVOUT("HACIENDO AJUSTES FINALES A LA INFORMACION    ")
   DBEVAL({||FIELD->NUMOPE := VAL(CODOPE)}, NIL, NIL, NIL, NIL, .F.)
   DBCLOSEARE()
   SET(2, "OFF")
   SET(3, 2)
   DBCLOSEARE()
   MEMVAR->OPC := " "

RETURN 

