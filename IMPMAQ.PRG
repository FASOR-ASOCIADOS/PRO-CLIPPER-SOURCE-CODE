/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: IMPMAQ
   Params: None.
   Return: Undefined
  Example: IMPMAQ()
  ..........................................................................
*/

PROCEDURE IMPMAQ()

   __XSAVESCR()
   MENU()
   MEMVAR->WD := MEMVAR->WH := 0
   MEMVAR->WORD := " "
   DEVPOS(12, 10)
   DEVOUT("Desde la m" + A + "quina n" + U + "mero ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WD", "@Z 99", NIL, NIL):DISPLAY())
   DEVPOS(13, 10)
   DEVOUT("Hasta la m" + A + "quina n" + U + "mero ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WH", "@Z 99", NIL, NIL):DISPLAY())
   DEVPOS(14, 10)
   DEVOUT("En orden de <C>" + O + "digo, <F>alla o <M>antenimiento ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WORD", "@!", {||WORD $ "CFM"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   MEMVAR->WAB := "BASURA.NTX"
   BA()

   IF WORD = "C"

      DBCREATEIN("C:\BASURA.KEY", "CODMAQ", {||CODMAQ}, NIL)

   ELSEIF WORD = "F"

      DBCREATEIN("C:\BASURA.KEY", "ULTFALLO", {||ULTFALLO}, NIL)

   ELSEIF WORD = "M"

      DBCREATEIN("C:\BASURA.KEY", "ULTMANT", {||ULTMANT}, NIL)

   ENDIF

   MEMVAR->WD := WD - 1
   ++MEMVAR->WH
   MENU()
   DEVPOS(12, 10)
   DEVOUT("Por favor aliste la impresora y pulse alguna tecla,")
   DEVPOS(13, 10)
   DEVOUT("ESC para cancelar ")
   MEMVAR->X := INKEY(0)

   IF LASTKEY() = 27

      ORDLISTCLE()
      MEMVAR->WAB := "BASURA.NTX"
      BA()
      __XRESTSCR()
      RETURN 

   ENDIF

   __REPORTFO("MAQUINAS", .T., NIL, .T., {||NUMMAQ > WD .AND. NUMMAQ < WH},;
          NIL, NIL, NIL, .F., .F., NIL, .F., .F.)
   ORDLISTCLE()
   DBGOTOP()
   MEMVAR->WAB := "BASURA.NTX"
   BA()
   __XRESTSCR()

RETURN 

