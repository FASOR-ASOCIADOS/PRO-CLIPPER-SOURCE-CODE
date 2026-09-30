/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AUD1
   Params: None.
   Return: Undefined
  Example: AUD1()
  ..........................................................................
*/

PROCEDURE AUD1()

   MENU()
   MEMVAR->OPC := " "
   DEVPOS(12, 10)
   DEVOUT("Ahora se comparar" + A + ;
         "n los consumos reportados por el maestro de ")
   DEVPOS(13, 10)
   DEVOUT("insumos y los movimientos mensual y semanal consolidados.")
   DEVPOS(14, 10)
   DEVOUT("Desea continuar ? s/n ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC = "N"

      MEMVAR->OPC := 1
      RETURN 

   ENDIF

   MENU()
   ESPERE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->WAB := "BASURA2.DBF"
   BA()
   MEMVAR->WAB := "BASURA.NTX"
   BA()
   __COPYFILE("&ZDIS\&WDIRECTO\&FMAINSU", "C:\PROTMP\BASURA.DBF")
   AMOVMESS()
   __DBCOPYST("C:\PROTMP\BASURA2", {})
   DBCLOSEARE()
   DBSELECTAR("2")
   DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA2", NIL, NIL, .F.)
   __DBAPP("&ZDIS\&WDIRECTO\&FMOVINS", {}, NIL, NIL, NIL, NIL, .F., NIL)
   __DBAPP("&ZDIS\&WDIRECTO\MOVPRSEM", {}, NIL, NIL, NIL, NIL, .F., NIL)
   DBCOMMITAL()
   DBSELECTAR("1")
   DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)
   DBCREATEIN("C:\PROTMP\BASURA.NTX", "CODNUM", {||CODNUM}, NIL)
   MENU()
   DEVPOS(4, 1)
   DEVOUT(PADC(;
         "REFERENCIAS CON DIFERENCIAS EN CONSUMO MAESTRO vs MOVIMIENTOS", ;
         78))
   DEVPOS(5, 1)
   DEVOUT(;
         "CODIGO Q. MAESTRO Q. MOVIM.  DIFERENCIA    VR MAESTRO VR MOVIMI.  DIFERENCIA";
         )
   DBSELECTAR("1")
   MEMVAR->CL := 6
   MEMVAR->WDIFQ := MEMVAR->WDIFV := MEMVAR->WTVMA := MEMVAR->WTVMO := 0

   DO WHILE  .NOT. EOF()

      DBSELECTAR("1")
      DEVPOS(CL, 1)
      DEVOUT(CODIGO + "-" + NUMCOLOR)
      MEMVAR->QT7 := MEMVAR->QT3 := MEMVAR->VT7 := MEMVAR->VT3 := MEMVAR->;
            WDIFVM := 0
      MEMVAR->WCOD := CODIGO
      MEMVAR->WCOLO := NUMCOLOR
      DBSELECTAR("2")
      MEMVAR->QT7 := 0
      DBEVAL({||MEMVAR->QT7 := QT7 + CANTIDAD}, {||CODIGO = WCOD .AND. ;
            NUMCOLOR = WCOLO .AND. (TIPOMOV = "7 " .OR. TIPOMOV = "8 ")}, ;
            NIL, NIL, NIL, .F.)
      MEMVAR->QT3 := 0
      DBEVAL({||MEMVAR->QT3 := QT3 + CANTIDAD}, {||CODIGO = WCOD .AND. ;
            NUMCOLOR = WCOLO .AND. TIPOMOV = "3 "}, NIL, NIL, NIL, .F.)
      MEMVAR->VT7 := 0
      DBEVAL({||MEMVAR->VT7 := VT7 + VALTOT}, {||CODIGO = WCOD .AND. ;
            NUMCOLOR = WCOLO .AND. (TIPOMOV = "7 " .OR. TIPOMOV = "8 ")}, ;
            NIL, NIL, NIL, .F.)
      MEMVAR->VT3 := 0
      DBEVAL({||MEMVAR->VT3 := VT3 + VALTOT}, {||CODIGO = WCOD .AND. ;
            NUMCOLOR = WCOLO .AND. TIPOMOV = "3 "}, NIL, NIL, NIL, .F.)
      MEMVAR->WTVMO := MEMVAR->WTVMO + (VT7 - VT3)
      DBSELECTAR("1")
      MEMVAR->WTVMA := MEMVAR->WTVMA + CONMESPES

      IF CONMESUNI <> QT7 - QT3

         DEVPOS(CL, 8)
         DEVOUTPICT(CONMESUNI, "@Z 99,999,999")
         DEVPOS(CL, 19)
         DEVOUTPICT(QT7 - QT3, "@Z 99999,999")
         DEVPOS(CL, 29)
         DEVOUTPICT(CONMESUNI - (QT7 - QT3), "@Z 999,999,999")
         MEMVAR->WDIFQ := MEMVAR->WDIFQ + (CONMESUNI - (QT7 - QT3))

      ENDIF

      MEMVAR->WDIFV := MEMVAR->WDIFV + (ROUND(CONMESPES, 0) - ROUND(VT7 - ;
            VT3, 0))
      MEMVAR->WDIFVM := ROUND(CONMESPES, 0) - ROUND(VT7 - VT3, 0)

      IF WDIFVM <> 0

         DEVPOS(CL, 43)
         DEVOUTPICT(CONMESPES, "@Z 999,999,999")
         DEVPOS(CL, 55)
         DEVOUTPICT(VT7 - VT3, "@Z 999,999,999")
         DEVPOS(CL, 67)
         DEVOUTPICT(WDIFVM, "@Z 999,999,999")

         IF WDIFVM > -1 .AND. WDIFVM < 1

            DEVPOS(CL, 67)
            DEVOUTPICT(CONMESPES - (VT7 - VT3), "@Z 9999,999.99")

         ENDIF

      ENDIF

      IF WDIFVM <> 0 .OR. CONMESUNI <> QT7 - QT3

         MEMVAR->CL := MEMVAR->CL + 1

      ENDIF

      IF CL > 22

         DEVPOS(23, 10)
         DEVOUT("LEA Y PULSE ALGUNA TECLA ")
         MEMVAR->X := INKEY(0)
         MEMVAR->CL := 6
         SCROLL(CL, 1, 23, 78)
         SETPOS(CL, 1)

      ENDIF

      DBSELECTAR("1")
      DBSKIP(1)

   ENDDO

   IF CL > 6

      DEVPOS(22, 1)
      DEVOUT("TOTALES:")
      DEVPOS(22, 29)
      DEVOUTPICT(WDIFQ, "@Z 999,999,999")
      DEVPOS(22, 43)
      DEVOUTPICT(WTVMA, "@Z 999,999,999")
      DEVPOS(22, 55)
      DEVOUTPICT(WTVMO, "@Z 999,999,999")
      DEVPOS(22, 67)
      DEVOUTPICT(WDIFV, "@Z 999,999,999")
      DEVPOS(23, 10)
      DEVOUT("LEA Y PULSE ALGUNA TECLA ")
      MEMVAR->X := INKEY(0)

   ENDIF

   DBCLOSEALL()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->WAB := "BASURA2.DBF"
   BA()
   MEMVAR->OPC := 1

RETURN 

