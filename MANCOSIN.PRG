/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MANCOSIN
   Params: None.
   Return: Undefined
  Example: MANCOSIN()
  ..........................................................................
*/

PROCEDURE MANCOSIN()

   MEMVAR->OPC := " "

   IF  .NOT. FILE("&ZDIS\&WDIRECTO\CANMESIN.MEM")

      MEMVAR->CANMESIN := 12

   ELSE

      __MRESTORE("&ZDIS\&WDIRECTO\CANMESIN", .T.)

   ENDIF

   MENU()
   DEVPOS(12, 10)
   DEVOUT("CON CUANTOS MESES MANEJA EL PROMEDIO ? (12 max.) ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "CANMESIN", "@Z 99", NIL, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF FILE("&ZDIS\&WDIRECTO\CANMESIN.MEM")

      FERASE("&ZDIS\&WDIRECTO\CANMESIN.MEM")

   ENDIF

   __MSAVE("&ZDIS\&WDIRECTO\CANMESIN.MEM", "CANMESIN", .T.)

   DO WHILE OPC <> "T"

      MENU()
      SETCOLOR("+G")
      DEVPOS(5, 26)
      DEVOUT("MANEJO DE COSTOS INDIRECTOS")
      MEMVAR->OPC := " "
      DEVPOS(7, 1)
      DEVOUT(;
            "MES    VR IND. DEL MES   HORAS DEL MES  COSTO/H/MES   COSTO/HORA/PROM.";
            )
      MEMVAR->CL := 8
      SETCOLOR("+W")
      AFACOSE()

      DO WHILE  .NOT. EOF()

         DEVPOS(CL, 2)
         DEVOUTPICT(MES, "@Z 99")
         DEVPOS(CL, 9)
         DEVOUTPICT(VALMES, "@Z 9999,999,999")
         DEVPOS(CL, 28)
         DEVOUTPICT(HORMES, "@Z 999,999")
         DEVPOS(CL, 42)
         DEVOUTPICT(COSHOR, "@Z 999,999.99")
         DEVPOS(CL, 58)
         DEVOUTPICT(PROMESES, "@Z 999,999.99")
         MEMVAR->CL := MEMVAR->CL + 1
         DBSKIP(1)

      ENDDO

      DBCLOSEARE()
      MEMVAR->OPC := " "
      DEVPOS(23, 7)
      DEVOUT("<C>rea, <M>odifica, <B>orra, <I>mprime, <T>ermina ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "CMBIT"}, NIL);
            :DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      SCROLL(23, 1, 23, 78)
      SETPOS(23, 1)

      IF OPC = "C"

         DEVPOS(6, 1)
         DEVOUT(PADC("CARGANDO INDIRECTOS PARA UN MES", 78))
         AFACOSE()
         DBGOTO(LASTREC())

         IF MES = 12

            MEMVAR->WNUMMES := 1

         ELSE

            MEMVAR->WNUMMES := MES + 1

         ENDIF

         DBCLOSEARE()
         MEMVAR->WVALMES := MEMVAR->WHORMES := MEMVAR->WVALPAG := MEMVAR->;
               WCOSUNI := 0
         DEVPOS(23, 1)
         DEVOUT("MES A CREAR:" + TRANSFORM(WNUMMES, "99"))
         DEVPOS(23, 20)
         DEVOUT("Vr.Ind.del mes:")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WVALMES", "@Z 999,999,999", NIL, NIL);
               :DISPLAY())
         DEVPOS(23, 50)
         DEVOUT("Horas del mes:")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WHORMES", "@Z 99,999,999", NIL, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF WVALMES = 0 .AND. WHORMES = 0

            MEMVAR->OPC := " "
            LOOP

         ENDIF

         MEMVAR->WCOSUNI := WVALMES / WHORMES
         SETCOLOR("+W")
         DEVPOS(16, 10)
         DEVOUT("COSTO INDIRECTO HORA : ")
         DEVPOS(16, 35)
         DEVOUTPICT(WCOSUNI, "@# 9,999,999.99")
         SETCOLOR("+G")
         MEMVAR->OPC := " "
         AFACOSE()
         DBAPPEND()
         FIELD->MES := WNUMMES
         FIELD->VALMES := WVALMES
         FIELD->HORMES := WHORMES
         FIELD->COSHOR := WCOSUNI
         DBCOMMITAL()
         SET(11, "OFF")
         DBEVAL({||DBDELETE()}, {||RECNO() < LASTREC() - CANMESIN + 1}, ;
               NIL, NIL, NIL, .F.)
         __DBPACK()
         DBCLOSEARE()
         AFACOSE()
         MEMVAR->WPOS15 := LASTREC()
         MEMVAR->WSUMAVALS := 0
         DBEVAL({||MEMVAR->WSUMAVALS := WSUMAVALS + VALMES}, NIL, NIL, NIL, ;
               NIL, .F.)
         MEMVAR->WSUMAHORS := 0
         DBEVAL({||MEMVAR->WSUMAHORS := WSUMAHORS + HORMES}, NIL, NIL, NIL, ;
               NIL, .F.)
         DBGOTO(WPOS15)
         VEALOCK()
         FIELD->PROMESES := WSUMAVALS / WSUMAHORS
         DBCLOSEARE()

      ELSEIF OPC = "M"

         DEVPOS(6, 1)
         DEVOUT(PADC("MODIFICANDO INDIRECTOS DE UN MES", 78))
         MEMVAR->WNUMMES := 0
         DEVPOS(23, 1)
         DEVOUT("# DE MES ?")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNUMMES", "@Z 99", NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF WNUMMES = 0

            MEMVAR->OPC := " "
            LOOP

         ENDIF

         AFACOSE()
         __DBLOCATE({||MES = WNUMMES}, NIL, NIL, NIL, .F.)

         IF EOF()

            DBCLOSEARE()
            MEMVAR->OPC := " "
            LOOP

         ENDIF

         MEMVAR->WVALMES := VALMES
         MEMVAR->WHORMES := HORMES
         DBCLOSEARE()
         DEVPOS(23, 20)
         DEVOUT("Vr.Ind.del mes:")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WVALMES", "@Z 999,999,999", NIL, NIL);
               :DISPLAY())
         DEVPOS(23, 50)
         DEVOUT("Horas del mes:")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WHORMES", "@Z 99,999,999", NIL, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         SCROLL(23, 1, 23, 79)
         SETPOS(23, 1)
         AFACOSE()
         __DBLOCATE({||MES = WNUMMES}, NIL, NIL, NIL, .F.)
         VEALOCK()
         FIELD->VALMES := WVALMES
         FIELD->HORMES := WHORMES
         DBGOTOP()
         MEMVAR->WTOTVAL := MEMVAR->WTOTHOR := 0

         DO WHILE  .NOT. EOF()

            FIELD->COSHOR := VALMES / HORMES
            MEMVAR->WTOTVAL := MEMVAR->WTOTVAL + VALMES
            MEMVAR->WTOTHOR := MEMVAR->WTOTHOR + HORMES
            FIELD->PROMESES := WTOTVAL / WTOTHOR
            DBSKIP(1)

         ENDDO

         DBCLOSEARE()

      ELSEIF OPC = "B"

         DEVPOS(6, 1)
         DEVOUT(PADC("BORRANDO INDIRECTOS DE UN MES", 78))
         MEMVAR->WNUMMES := 0
         DEVPOS(23, 1)
         DEVOUT("# DE MES A BORRAR ?")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNUMMES", "@Z 99", NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF WNUMMES = 0

            MEMVAR->OPC := " "
            LOOP

         ENDIF

         AFACOSE()
         __DBLOCATE({||MES = WNUMMES}, NIL, NIL, NIL, .F.)

         IF  .NOT. EOF()

            DBDELETE()

         ENDIF

         __DBPACK()
         DBCLOSEARE()
         AFACOSE()
         MEMVAR->WTOTVAL := MEMVAR->WTOTHOR := 0

         DO WHILE  .NOT. EOF()

            FIELD->COSHOR := VALMES / HORMES
            MEMVAR->WTOTVAL := MEMVAR->WTOTVAL + VALMES
            MEMVAR->WTOTHOR := MEMVAR->WTOTHOR + HORMES
            FIELD->PROMESES := WTOTVAL / WTOTHOR
            DBSKIP(1)

         ENDDO

         DBCLOSEARE()

      ELSEIF OPC = "I"

         PIDEIMP()
         MEMVAR->OPC := " "
         AFACOSS()
         __REPORTFO("FACCOSIN", .T., NIL, .F., NIL, NIL, NIL, NIL, .F., ;
               .F., NIL, .F., .F.)
         DBCLOSEARE()
         __EJECT()

      ENDIF

   ENDDO

   MEMVAR->OPC := " "
   DBCLOSEARE()
   SETCOLOR("+W")
   SET(33, "OFF")
   SET(31, "ON")

RETURN 

