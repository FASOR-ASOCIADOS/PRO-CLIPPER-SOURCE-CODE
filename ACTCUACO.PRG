/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ACTCUACO
   Params: None.
   Return: Undefined
  Example: ACTCUACO()
  ..........................................................................
*/

PROCEDURE ACTCUACO()

   ESPERE()
   ACOSE()
   MEMVAR->WAB := "COSTOS.NTX"
   BA()
   DBCREATEIN("C:\PROTMP\COSTOS.NTX", "LETORD", {||LETORD}, NIL)
   DBCLOSEARE()
   MEMVAR->OPC := " "
   SET(34, "[]")
   SET(31, "OFF")
   SET(33, "ON")
   MENU()
   DEVPOS(4, 1)
   DEVOUT(PADC("ACTUALIZANDO CUADRO DE COSTOS DE PRODUCCION", 78))
   MEMVAR->OPC := " "
   DEVPOS(12, 20)
   DEVOUT("Por medio de esta opcion se actualizan algunos datos")
   DEVPOS(13, 20)
   DEVOUT("como cantidad total, cantidad facturada, costo estimado,")
   DEVPOS(14, 20)
   DEVOUT("precio de venta y factor de costo unitario en el archivo")
   DEVPOS(15, 20)
   DEVOUT("de costos.")
   DEVPOS(17, 20)
   DEVOUT("DESEA CONTINUAR ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   SETCOLOR("+W")
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC = "N"

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   MEMVAR->OPC := " "
   SCROLL(12, 20, 18, 77)
   SETPOS(12, 20)

   DO WHILE OPC <> "*"

      MENU()
      DEVPOS(4, 1)
      DEVOUT(PADC("ACTUALIZACION DE VALORES EN CUADRO DE COSTOS", 78))
      MEMVAR->WNUMORD := SPACE(8)
      DEVPOS(12, 20)
      DEVOUT("Numero de la orden a actualizar ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WNUMORD", NIL, NIL, NIL):DISPLAY())
      DEVPOS(13, 20)
      DEVOUT("ENTER para terminar")
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      DEVPOS(13, 20)
      DEVOUT("                    ")

      IF WNUMORD = SPACE(8)

         MEMVAR->OPC := "*"
         LOOP

      ENDIF

      IF WNUMORD = "999     "

         MEMVAR->WCODPT := 999
         DEVPOS(14, 20)
         DEVOUT("CODIGO DE PRODUCTO TERMINADO ? ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCODPT", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ENDIF

      ACOSS()
      ORDLISTCLE()
      ORDLISTADD("C:\PROTMP\COSTOS.NTX")

      IF WNUMORD = "999     "

         __DBLOCATE({||NUMORD = WNUMORD .AND. CODPRO = WCODPT}, NIL, NIL, ;
               NIL, .F.)

      ELSE

         DBSEEK("&WNUMORD")

      ENDIF

      IF EOF()

         DBCLOSEARE()
         SETCOLOR("+GR")
         MEMVAR->OPC := " "
         DEVPOS(13, 20)
         DEVOUT("Numero no encontrado")
         DEVPOS(14, 20)
         DEVOUT("TIENE MAS PARA ACTUALIZAR ? S/N ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         SETCOLOR("+W")
         SCROLL(13, 20, 14, 78)
         SETPOS(13, 20)

         IF OPC = "N"

            MEMVAR->OPC := "*"

         ENDIF

         LOOP

      ENDIF

      MEMVAR->WCANORD := CANORD
      MEMVAR->WCANFAC := CANFAC
      MEMVAR->WCANPED := CANPED
      MEMVAR->WCANTOT := CANTOT
      MEMVAR->WCODPRO := VAL(CODPRO)
      MEMVAR->WCOSEST := COSEST
      MEMVAR->WPREVEN := PREVEN
      MEMVAR->WFACTORCUI := FACTORCUI
      MEMVAR->WPOSI := RECNO()
      DBCLOSEARE()
      SETCOLOR("+W")
      MEMVAR->WCANSAL := "N"
      DEVPOS(12, 20)
      DEVOUT("Orden de produccion #                  " + WNUMORD)
      DEVPOS(13, 20)
      DEVOUT("FALTAN POR ENTRAR     ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCANORD", "@# 999,999", NIL, NIL):DISPLAY();
            )
      DEVPOS(14, 20)
      DEVOUT("COSTO ESTIMADO        ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCOSEST", "@# 999,999.99", NIL, NIL);
            :DISPLAY())
      DEVPOS(15, 20)
      DEVOUT("PRECIO DE VENTA       ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WPREVEN", "@# 9,999,999", NIL, NIL);
            :DISPLAY())
      DEVPOS(16, 20)
      DEVOUT("FACTOR COSTO UNITARIO ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WFACTORCUI", "@# $$,$$$.$$", NIL, NIL);
            :DISPLAY())

      IF WCODPRO > 5999 .AND. WCODPRO < 7000

         DEVPOS(18, 20)
         DEVOUT("CANTIDAD DEL PEDIDO   " + TRANSFORM(WCANPED, "999,999"))
         DEVPOS(19, 20)
         DEVOUT("CANTIDAD TOTAL        " + TRANSFORM(WCANTOT, "999,999"))
         DEVPOS(20, 20)
         DEVOUT("CANTIDAD FACTURADA    ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCANFAC", "@# 999,999", NIL, NIL);
               :DISPLAY())
         DEVPOS(21, 20)
         DEVOUT("Desea cancelar el saldo por facturar? S/N ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "wcansal", "@!", {||WCANSAL $ "SN"}, NIL);
               :DISPLAY())

      ENDIF

      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      MEMVAR->OPC := "S"
      SETCOLOR("+G")
      DEVPOS(22, 20)
      DEVOUT("CORRECTO ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      SETCOLOR("+W")

      IF OPC = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      IF WCANSAL = "S"

         SCROLL(21, 1, 23, 78)
         SETPOS(21, 1)
         SETCOLOR("+GR")
         MEMVAR->WCANSAL := "N"
         DEVPOS(21, 10)
         DEVOUT(;
               "Cancelar el saldo por facturar de este producto significa")
         DEVPOS(22, 10)
         DEVOUT(;
               "que el sistema de facturacion no lo podra incluir en ninguna";
               )
         DEVPOS(23, 10)
         DEVOUT(;
               "otra factura. Asi que, cancela el saldo por facturar ? S/N ";
               )
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCANSAL", "@!", {||WCANSAL $ "SN"}, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ENDIF

      ACOSS()
      DBGOTO(WPOSI)
      VEALOCK()
      FIELD->CANORD := WCANORD
      FIELD->CANFAC := WCANFAC
      FIELD->COSEST := WCOSEST
      FIELD->PREVEN := WPREVEN
      FIELD->FACTORCUI := WFACTORCUI
      FIELD->CODUSU := WCODUSU
      FIELD->HORA := TIME()

      IF WCANSAL = "S"

         FIELD->CANFAC := CANPED + 1

      ENDIF

      DBCLOSEARE()

   ENDDO

   MEMVAR->OPC := " "
   SET(33, "OFF")
   SET(31, "ON")

RETURN 

