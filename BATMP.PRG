/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: BATMP
   Params: None.
   Return: Undefined
  Example: BATMP()
  ..........................................................................
*/

PROCEDURE BATMP()

   ESPERE()
   MEMVAR->WAB := "COSTOS.NTX"
   BA()
   ACOSE()
   DBCREATEIN("C:\COSTOS.NTX", "LETORD", {||LETORD}, NIL)
   DBCLOSEARE()
   MENU()
   SETCOLOR("+GR")
   DEVPOS(6, 22)
   DEVOUT("  ELABORACION DE PROCESOS EN BATCH")
   DEVPOS(7, 8)
   DEVOUT(;
         "RECONSTRUCCION DE VALORES DE MATERIA PRIMA EN MAESTRO DE COSTOS")
   SETCOLOR("+W")
   MEMVAR->OPC := " "
   DEVPOS(12, 6)
   DEVOUT(;
         "Por medio de esta opcion se reconstruye el valor de la materia prima por ";
         )
   DEVPOS(13, 6)
   DEVOUT(;
         "o.p. en el archivo maestro de costos del cual se imprime la hoja grande";
         )
   DEVPOS(14, 6)
   DEVOUT("de costos. DESEA CONTINUAR ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC <> "S"

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

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

      IF WLETORD = SPACE(8)

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

      IF WLETORD = "999     "

         __DBLOCATE({||NUMORD = WNUMORD .AND. CODPRO = WCODPT}, NIL, NIL, ;
               NIL, .F.)

      ELSE

         DBSEEK("&WLETORD")

      ENDIF

      IF EOF()

         DBCLOSEARE()
         MEMVAR->OPC := " "
         DEVPOS(13, 10)
         DEVOUT("NUMERO NO EXISTE, TIENE OTRAS ? S/N ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         LOOP

      ENDIF

      VEALOCK()
      FIELD->VALTOT := 0
      MEMVAR->TP := 0
      AMVCOSE()
      MEMVAR->TP := 0
      DBEVAL({||MEMVAR->TP := TP + VALTOT}, {||NUMORDPR = SUBSTR(WLETORD, 1,;
             7)}, NIL, NIL, NIL, .F.)
      DBCLOSEARE()
      DBSELECTAR("13")
      VEALOCK()
      FIELD->VALTOT := TP
      DBCLOSEARE()
      SCROLL(12, 10, 23, 78)
      MEMVAR->OPC := ( SETPOS(12, 10), " " )
      DEVPOS(12, 20)
      DEVOUT("TIENE MAS PARA CORREGIR ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

   ENDDO

   CIERRE()
   MEMVAR->OPC := " "

RETURN 

