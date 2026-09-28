/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: BATMO
   Params: None.
   Return: Undefined
  Example: BATMO()
  ..........................................................................
*/

PROCEDURE BATMO()

   MEMVAR->OPC := " "
   MENU()
   SETCOLOR("+GR")
   DEVPOS(4, 15)
   DEVOUT("RECONSTRUCCION DE MANO DE OBRA EN MAESTRO DE COSTOS")
   SETCOLOR("+W")
   MEMVAR->OPC := " "
   DEVPOS(12, 6)
   DEVOUT(;
         "Por medio de esta opcion se reconstruye el valor de los pagos de mano de";
         )
   DEVPOS(13, 6)
   DEVOUT(;
         "obra para el archivo maestro de costos con el cual se imprime la hoja";
         )
   DEVPOS(14, 6)
   DEVOUT("grande de costos. DESEA CONTINUAR ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC <> "S"

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   ESPERE()
   MEMVAR->WAB := "COSTOS.NTX"
   BA()
   ACOSE()
   DBEVAL({||FIELD->LETORD := ALLTRIM(TRANSFORM(NUMORD, "99999999"))}, NIL, ;
         NIL, NIL, NIL, .F.)
   DBCOMMITAL()
   DBCREATEIN("C:\COSTOS.NTX", "LETORD", {||LETORD}, NIL)
   DBCLOSEARE()
   MEMVAR->OPC := " "

   DO WHILE OPC <> "N"

      SETCOLOR("+W")
      SCROLL(8, 1, 23, 78)
      MEMVAR->WLETORD := ( SETPOS(8, 1), SPACE(8) )
      DEVPOS(12, 20)
      DEVOUT("Numero de la orden a afectar ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WLETORD", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WLETORD = "        "

         MEMVAR->OPC := "N"
         LOOP

      ENDIF

      IF SUBSTR(WLETORD, 1, 4) = "999 "

         MEMVAR->WCODPT := ZLCPT
         DEVPOS(13, 20)
         DEVOUT("Codigo de producto terminado ? ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCODPT", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ENDIF

      MEMVAR->WNUMORD := VAL(WLETORD)
      ACOSS()
      ORDLISTCLE()
      ORDLISTADD("C:\COSTOS.NTX")

      IF SUBSTR(WLETORD, 1, 4) = "999 "

         __DBLOCATE({||NUMORD = WNUMORD .AND. CODPRO = WCODPT}, NIL, NIL, ;
               NIL, .F.)

      ELSE

         DBSEEK("&WLETORD")

      ENDIF

      IF EOF()

         DBCLOSEARE()
         MEMVAR->OPC := " "
         DEVPOS(13, 20)
         DEVOUT("NUMERO NO EXISTE,")
         DEVPOS(14, 20)
         DEVOUT("TIENE MAS PARA ARREGLAR ? S/N ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         LOOP

      ENDIF

      VEALOCK()
      FIELD->PAGO := 0
      FIELD->MINUTOS := 0
      MEMVAR->TP := MEMVAR->TM := 0
      AMOPAE()
      DEVPOS(23, 1)
      DEVOUT("SUMANDO VALORES PARA LA ORDEN " + WLETORD)

      IF SUBSTR(WLETORD, 1, 4) = "999 "

         MEMVAR->TP := 0
         DBEVAL({||MEMVAR->TP := TP + PAGO}, {||NUMORD = WNUMORD .AND. ;
               CODPRO = WCODPT}, NIL, NIL, NIL, .F.)
         MEMVAR->TM := 0
         DBEVAL({||MEMVAR->TM := TM + MINUTOS}, {||NUMORD = WNUMORD .AND. ;
               CODPRO = WCODPT}, NIL, NIL, NIL, .F.)

      ELSE

         MEMVAR->TP := 0
         DBEVAL({||MEMVAR->TP := TP + PAGO}, {||NUMORD = WNUMORD}, NIL, NIL,;
                NIL, .F.)
         MEMVAR->TM := 0
         DBEVAL({||MEMVAR->TM := TM + MINUTOS}, {||NUMORD = WNUMORD}, NIL, ;
               NIL, NIL, .F.)

      ENDIF

      DBCLOSEARE()
      DEVPOS(23, 1)
      DEVOUT("                             ")
      DBSELECTAR("13")
      VEALOCK()
      FIELD->PAGO := TP
      FIELD->MINUTOS := TM
      DBCLOSEARE()
      SCROLL(12, 10, 23, 78)
      MEMVAR->OPC := ( SETPOS(12, 10), " " )

   ENDDO

   CIERRE()
   MEMVAR->OPC := " "

RETURN 

