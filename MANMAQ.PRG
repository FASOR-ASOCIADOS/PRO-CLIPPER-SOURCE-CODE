/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MANMAQ
   Params: None.
   Return: Undefined
  Example: MANMAQ()
  ..........................................................................
*/

PROCEDURE MANMAQ()

   MEMVAR->WAB := "BASURA.DBF"
   BA()
   AMAQS()
   __DBCOPY("C:\BASURA", {}, NIL, NIL, NIL, NIL, .F., NIL)
   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
   MEMVAR->OPC := " "
   MENU()
   DEVPOS(4, 1)
   DEVOUT(PADC("MANEJO DE MAQUINAS", 78))
   SETCOLOR("+G")
   DEVPOS(5, 5)
   DEVOUT(;
         "COD NOMBRE                          CONTADOR   ULT.MANT.  ULT. FALLA";
         )
   SETCOLOR("+W")
   MEMVAR->CL := 6

   DO WHILE OPC <> "T"

      DEVPOS(CL, 5)
      DEVOUT(CODMAQ + " " + NOMBRE)
      DEVPOS(CL, 39)
      DEVOUTPICT(CONTADOR, "@Z 999,999,999")
      DEVPOS(CL, 51)
      DEVOUT(ULTMANT)
      DEVPOS(CL, 62)
      DEVOUT(ULTFALLO)
      DBSKIP(1)
      MEMVAR->CL := MEMVAR->CL + 1

      IF  .NOT. EOF() .AND. CL < 21

         LOOP

      ENDIF

      MEMVAR->OPC := "T"
      DEVPOS(23, 2)
      DEVOUT(;
            "<A>delanta, <R>etrocede, <C>rea, <M>odifica, <B>orra, <I>mprime o <T>ermina";
            )
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "ARCMBIT"}, NIL);
            :DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "T" .OR. OPC = "A" .OR. OPC = "R"

         SCROLL(6, 1, 23, 78)
         MEMVAR->CL := ( SETPOS(6, 1), 6 )

         IF OPC = "R"

            DBSKIP(-20)

         ENDIF

         LOOP

      ENDIF

      IF OPC = "C"

         MEMVAR->WCODMAQ := "  "
         MEMVAR->WNOMBRE := SPACE(30)
         MEMVAR->WCONT := 0
         MEMVAR->WULTMANT := MEMVAR->WULTFALLO := DATE()
         SCROLL(22, 1, 23, 78)
         SETPOS(22, 1)
         DEVPOS(22, 1)
         DEVOUT("C" + O + "digo a crear ? ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCODMAQ", NIL, NIL, NIL):DISPLAY())
         DEVPOS(22, 30)
         DEVOUT("Nombre ?")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNOMBRE", "@!", NIL, NIL):DISPLAY())
         DEVPOS(23, 1)
         DEVOUT("Contador ? ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCONT", "@Z 999,999,999", NIL, NIL);
               :DISPLAY())
         DEVPOS(23, 28)
         DEVOUT("Ult.manten.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WULTMANT", NIL, NIL, NIL):DISPLAY())
         DEVPOS(23, 53)
         DEVOUT("Ult. fallo ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WULTFALLO", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF WCODMAQ = "  " .OR. WNOMBRE = SPACE(30) .OR. LASTKEY() = 27

            MEMVAR->OPC := " "
            DBGOTOP()
            MEMVAR->CL := 6
            SCROLL(CL, 1, 23, 78)
            SETPOS(CL, 1)
            LOOP

         ENDIF

         __DBLOCATE({||CODMAQ = WCODMAQ}, NIL, NIL, NIL, .F.)

         IF  .NOT. EOF()

            DEVPOS(23, 10)
            DEVOUT("CODIGO YA EXISTE, PULSE ALGUNA TECLA ")
            MEMVAR->X := INKEY(0)
            DBGOTOP()
            MEMVAR->CL := 6
            SCROLL(CL, 1, 23, 78)
            SETPOS(CL, 1)
            LOOP

         ENDIF

         DBAPPEND()
         FIELD->CODMAQ := WCODMAQ
         FIELD->NUMMAQ := VAL(WCODMAQ)
         FIELD->NOMBRE := WNOMBRE
         FIELD->CONTADOR := WCONT
         FIELD->ULTMANT := WULTMANT
         FIELD->ULTFALLO := WULTFALLO
         DBCLOSEARE()
         AMAQS()
         DBAPPEND()
         FIELD->CODMAQ := WCODMAQ
         FIELD->NUMMAQ := VAL(WCODMAQ)
         FIELD->NOMBRE := WNOMBRE
         FIELD->CONTADOR := WCONT
         FIELD->ULTMANT := WULTMANT
         FIELD->ULTFALLO := WULTFALLO
         DBCLOSEARE()
         DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
         MEMVAR->CL := 6
         SCROLL(CL, 1, 23, 78)
         SETPOS(CL, 1)
         LOOP

      ENDIF

      IF OPC = "M"

         MEMVAR->WCODMAQ := "  "
         SCROLL(22, 1, 23, 78)
         SETPOS(22, 1)
         DEVPOS(22, 1)
         DEVOUT("C" + O + "digo a modificar ? ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCODMAQ", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         __DBLOCATE({||CODMAQ = WCODMAQ}, NIL, NIL, NIL, .F.)

         IF EOF()

            MEMVAR->OPC := " "
            DBGOTOP()
            MEMVAR->CL := 6
            SCROLL(CL, 1, 23, 78)
            SETPOS(CL, 1)
            LOOP

         ENDIF

         MEMVAR->WNOMBRE := NOMBRE
         MEMVAR->WCONT := CONTADOR
         MEMVAR->WULTMANT := ULTMANT
         MEMVAR->WULTFALLO := ULTFALLO
         MEMVAR->WPOS := RECNO()
         DEVPOS(22, 30)
         DEVOUT("Nombre ?")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNOMBRE", "@!", NIL, NIL):DISPLAY())
         DEVPOS(23, 1)
         DEVOUT("Contador ? ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCONT", "@Z 999,999,999", NIL, NIL);
               :DISPLAY())
         DEVPOS(23, 28)
         DEVOUT("Ult.manten.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WULTMANT", NIL, NIL, NIL):DISPLAY())
         DEVPOS(23, 53)
         DEVOUT("Ult. fallo ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WULTFALLO", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF WNOMBRE = SPACE(30)

            MEMVAR->OPC := " "
            DBGOTOP()
            MEMVAR->CL := 6
            SCROLL(CL, 1, 23, 78)
            SETPOS(CL, 1)
            LOOP

         ENDIF

         __DBLOCATE({||CODMAQ = WCODMAQ .AND. RECNO() <> WPOS}, NIL, NIL, ;
               NIL, .F.)

         IF  .NOT. EOF()

            DEVPOS(23, 10)
            DEVOUT("datos ya existen, PULSE ALGUNA TECLA ")
            MEMVAR->X := INKEY(0)
            DBGOTOP()
            MEMVAR->CL := 6
            SCROLL(CL, 1, 23, 78)
            SETPOS(CL, 1)
            LOOP

         ENDIF

         DBGOTO(WPOS)
         MEMVAR->SWLEE := 1
         MODNOTMQ()
         FIELD->CODMAQ := WCODMAQ
         FIELD->NUMMAQ := VAL(WCODMAQ)
         FIELD->NOMBRE := WNOMBRE
         FIELD->CONTADOR := WCONT
         FIELD->ULTMANT := WULTMANT
         FIELD->ULTFALLO := WULTFALLO
         DBCLOSEARE()
         AMAQE()
         DBEVAL({||DBDELETE()}, NIL, NIL, NIL, NIL, .F.)
         __DBAPP("C:\BASURA", {}, NIL, NIL, NIL, NIL, .F., NIL)
         __DBPACK()
         DBCLOSEARE()
         DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
         MEMVAR->CL := 6
         SCROLL(CL, 1, 23, 78)
         SETPOS(CL, 1)
         LOOP

      ENDIF

      IF OPC = "B"

         MEMVAR->WCODMAQ := "  "
         SCROLL(22, 1, 23, 78)
         SETPOS(22, 1)
         DEVPOS(22, 1)
         DEVOUT("C" + O + "digo a borrar ? ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCODMAQ", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         __DBLOCATE({||CODMAQ = WCODMAQ}, NIL, NIL, NIL, .F.)

         IF EOF()

            MEMVAR->OPC := " "
            DEVPOS(23, 10)
            DEVOUT("datos no existen, PULSE ALGUNA TECLA ")
            MEMVAR->X := INKEY(0)
            DBGOTOP()
            MEMVAR->CL := 6
            SCROLL(CL, 1, 23, 78)
            SETPOS(CL, 1)
            LOOP

         ENDIF

         MEMVAR->WNOMBRE := NOMBRE
         MEMVAR->WPOS := RECNO()
         DEVPOS(22, 30)
         DEVOUT("Nombre  ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNOMBRE", "@!", NIL, NIL):DISPLAY())
         READKILL(.T.)
         MEMVAR->GETLIST := {}
         MEMVAR->OPC := " "
         DEVPOS(23, 10)
         DEVOUT("Esta seguro de borrar ? S/N ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF OPC = "S"

            DBDELETE()
            __DBPACK()
            DBCLOSEARE()
            DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)

         ENDIF

         DBGOTOP()
         MEMVAR->CL := 6
         SCROLL(CL, 1, 23, 78)
         SETPOS(CL, 1)
         LOOP

      ENDIF

      IF OPC = "I"

         IMPMAQ()
         MEMVAR->OPC := " "

      ENDIF

   ENDDO

   AMAQE()
   DBEVAL({||DBDELETE()}, NIL, NIL, NIL, NIL, .F.)
   __DBAPP("C:\BASURA", {}, NIL, NIL, NIL, NIL, .F., NIL)
   __DBPACK()
   DBCLOSEARE()
   MEMVAR->OPC := " "

RETURN 

