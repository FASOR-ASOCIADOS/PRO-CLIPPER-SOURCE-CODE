/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: BATCOS0
   Params: None.
   Return: Undefined
  Example: BATCOS0()
  ..........................................................................
*/

PROCEDURE BATCOS0()

   MENU()
   MEMVAR->OPC := " "
   SETCOLOR("*+GR")
   DEVPOS(8, 10)
   DEVOUT("L E A   C O N   A T E N C I O N")
   SETCOLOR("GR")
   DEVPOS(9, 5)
   DEVOUT("El procedimiento a realizar restringe las entradas de P.T.")
   DEVPOS(10, 5)
   DEVOUT("y todo el sistema de produccion. Se recomienda sacar a TODOS")
   DEVPOS(11, 5)
   DEVOUT("los usuarios de inventario y produccion d ela red.")
   SETCOLOR("+W")
   DEVPOS(12, 10)
   DEVOUT("POR MEDIO DE ESTA OPCION DE CREAN ORDENES DE PRODUCCION")
   DEVPOS(13, 10)
   DEVOUT("EN EL ARCHIVO DE COSTOS, POR PERDIDA DE ESTAS POR FALLO")
   DEVPOS(14, 10)
   DEVOUT("EN EL SISTEMA. SI LA OP YA EXISTE ALLI, LE BORRA EN CONTENIDO")
   DEVPOS(15, 10)
   DEVOUT("DEL CAMPO COSEST Y LO RECALCULA A PARTIR DE LOS MOVIMIENTOS ")
   DEVPOS(16, 10)
   DEVOUT("SEMANAL Y/O MENSUAL.")
   DEVPOS(19, 10)
   DEVOUT("DESEA CONTINUAR ?S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC = "N"

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   MEMVAR->OPC := " "
   __MRESTORE("&ZDIS\&WDIRECTO\COSDIR", .T.)
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   AMVPRSS()
   __DBCOPYST("C:\PROTMP\BASURA", {})
   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)
   __DBAPP("&ZDIS\&WDIRECTO\MOVPRSEM", {}, NIL, NIL, NIL, NIL, .F., NIL)
   MEMVAR->WCM := 1

   DO WHILE WCM < 13

      MEMVAR->WNM := "MOVINS" + ALLTRIM(TRANSFORM(WCM, "99")) + ".DBF"

      IF FILE("&ZDIS\&WDIRECTO\&WNM")

         __DBAPP("&ZDIS\&WDIRECTO\&WNM", {}, {||TIPOMOV = "7 " .OR. ;
               TIPOMOV = "8 "}, NIL, NIL, NIL, .F., NIL)

      ENDIF

      MEMVAR->WCM := MEMVAR->WCM + 1

   ENDDO

   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)

   DO WHILE OPC <> "*"

      MENU()
      MEMVAR->WORD := SPACE(8)
      DEVPOS(12, 10)
      DEVOUT("Numero de o.p. a crear o calcular ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WORD", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WORD = SPACE(8)

         MEMVAR->OPC := "*"
         LOOP

      ENDIF

      ACOSE()
      __DBLOCATE({||LETORD = WORD}, NIL, NIL, NIL, .F.)

      IF EOF()

         DBAPPEND()
         FIELD->LETORD := WORD
         FIELD->NUMORD := VAL(WORD)

      ENDIF

      MEMVAR->WCODPRO := CODPRO
      MEMVAR->WNUMPRO := VAL(WCODPRO)
      MEMVAR->WCANORD := CANORD
      MEMVAR->WCANPED := CANPED
      MEMVAR->WCANTOT := CANTOT
      MEMVAR->WNOM := NOMBREPT
      FIELD->COSEST := 0
      DEVPOS(14, 10)
      DEVOUT("Codigo del producto ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCODPRO", NIL, NIL, NIL):DISPLAY())
      DEVPOS(15, 10)
      DEVOUT("CANTIDAD PENDIENTE POR ENTRAR ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCANORD", "@Z 999,999", NIL, NIL):DISPLAY();
            )
      DEVPOS(16, 10)
      DEVOUT("CANTIDAD PEDIDA ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCANPED", "@Z 999,999", NIL, NIL):DISPLAY();
            )
      DEVPOS(17, 10)
      DEVOUT("CANTIDAD TOTAL DE LA O.P. ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCANTOT", "@Z 999,999", NIL, NIL):DISPLAY();
            )
      DEVPOS(18, 10)
      DEVOUT("NOMBRE ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WNOM", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      FIELD->CODPRO := WCODPRO
      FIELD->NOMBREPT := WNOM
      FIELD->CANORD := WCANORD
      FIELD->CANPED := WCANPED
      FIELD->CANTOT := WCANTOT
      DEVPOS(23, 10)
      DEVOUT("Sumando costos por insumo..........")
      DBSELECTAR("6")
      MEMVAR->WORDN := VAL(WORD)
      MEMVAR->WVALTOT := 0
      DBEVAL({||MEMVAR->WVALTOT := WVALTOT + VALTOT}, {||NUMORDPR = WORDN ;
            .AND. (TIPOMOV = "7 " .OR. TIPOMOV = "8 ")}, NIL, NIL, NIL, ;
            .F.)
      DEVPOS(23, 10)
      DEVOUT("Calculando el costo estimado.......")
      AMAPAS()
      __DBLOCATE({||CODART = WCODPRO}, NIL, NIL, NIL, .F.)
      MEMVAR->WMO := 0

      IF  .NOT. EOF()

         MEMVAR->WMO := MO

      ENDIF

      DBCLOSEARE()

      IF WNUMPRO > 5999 .AND. WNUMPRO < 7000

         MEMVAR->WCOSDIR := 0
         DEVPOS(19, 10)
         DEVOUT("Por favor el costo directo")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCOSDIR", "@Z 999,999.99", NIL, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         MEMVAR->WCOSEST := WVALTOT / WCANPED + WCOSDIR

      ELSE

         MEMVAR->WCOSEST := WVALTOT / WCANTOT + WMO * COSDIR

      ENDIF

      DBSELECTAR("13")
      FIELD->COSEST := WCOSEST

   ENDDO

   DBSELECTAR("13")
   DBCLOSEARE()
   DBSELECTAR("6")
   DBCLOSEARE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->OPC := " "

RETURN 

