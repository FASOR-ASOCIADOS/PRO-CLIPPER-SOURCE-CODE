/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MOVIPRO1
   Params: None.
   Return: Undefined
  Example: MOVIPRO1()
  ..........................................................................
*/

PROCEDURE MOVIPRO1()

   MEMVAR->OPC := " "
   MENU()
   MEMVAR->WPER := " "
   SETCOLOR("+W/+G")
   DEVPOS(12, 20)
   DEVOUT("<S>emanal,<M>ensual o <C>onsolidado ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WPER", "@!", {||WPER $ "SMC"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   MENU()

   IF WPER = "S"

      AMVPRSS()

   ELSEIF WPER = "M"

      AMOVMESS()

   ELSEIF WPER = "C"

      MEMVAR->WAB := "BASURA5.DBF"
      BA()
      AMVPRSS()
      __DBCOPYST("C:\PROTMP\BASURA5", {})
      DBCLOSEARE()
      DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA5", NIL, NIL, .F.)
      __DBAPP("&ZDIS\&WDIRECTO\&FMOVINS", {}, NIL, NIL, NIL, NIL, .F., NIL)
      __DBAPP("&ZDIS\&WDIRECTO\MOVPRSEM", {}, NIL, NIL, NIL, NIL, .F., NIL)
      DBCLOSEARE()
      DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA5", NIL, NIL, .F.)

   ENDIF

   IF LASTREC() < 2

      DEVPOS(18, 10)
      DEVOUT("NO HAY INFORMACION ")
      MEMVAR->X := INKEY(0)
      DBCLOSEALL()
      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   MEMVAR->WINI := 1
   MEMVAR->WFIN := LASTREC()
   DBCLOSEARE()
   DEVPOS(4, 1)
   DEVOUT(PADC("OBTENCION DE LISTADOS DE MOVIMIENTOS DE INSUMOS", 78))
   DEVPOS(12, 15)
   DEVOUT("Ahora se dispone a imprimir los movimientos de insumos")
   DEVPOS(13, 15)
   DEVOUT("segun lo clasifique. Desea continuar ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC <> "S"

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   MENU()
   MEMVAR->WTODTIP := MEMVAR->WTODCOD := MEMVAR->WTODTOT := MEMVAR->WORD := ;
         " "
   MEMVAR->WTITULO := "MOVIMIENTO "

   IF WPER = "S"

      MEMVAR->WTITULO := MEMVAR->WTITULO + "SEMANAL DE INSUMOS "

   ELSEIF WPER = "M"

      MEMVAR->WTITULO := MEMVAR->WTITULO + "MENSUAL DE INSUMOS "

   ELSEIF WPER = "C"

      MEMVAR->WTITULO := MEMVAR->WTITULO + "MENSUAL Y SEMANAL DE INSUMOS "

   ENDIF

   DEVPOS(12, 3)
   DEVOUT("<T>odos los codigos o <U>no solo ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WTODCOD", "@!", {||WTODCOD $ "TU"}, NIL);
         :DISPLAY())
   DEVPOS(13, 3)
   DEVOUT("<T>odos los movimientos o <S>olo totales ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WTODTOT", "@!", {||WTODTOT $ "TS"}, NIL);
         :DISPLAY())
   DEVPOS(14, 3)
   DEVOUT("<T>odos los tipos de operacion o <U>no solo ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WTODTIP", "@!", {||WTODTIP $ "TU"}, NIL);
         :DISPLAY())
   DEVPOS(15, 3)
   DEVOUT(;
         "Ordenado por <C>odigo, <T>.oper.,<O>rden de grabacion o # <D>ocum. ? ";
         )
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WORD", "@!", {||WORD $ "DCTO"}, NIL):DISPLAY();
         )
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   SETCOLOR("+G")

   IF WTODTOT = "S"

      MEMVAR->WTITULO := MEMVAR->WTITULO + "TOTALIZADO "

   ELSE

      MEMVAR->WTITULO := MEMVAR->WTITULO + "DETALLADO "

   ENDIF

   IF WTODCOD = "U"

      MEMVAR->WCOD := "    "
      DEVPOS(12, 55)
      DEVOUT("CUAL ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCOD", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      MEMVAR->XXVALCOD := VAL(WCOD)

      IF XXVALCOD > 199 .AND. XXVALCOD < 300

         MEMVAR->WNUMCOL := " "
         DEVPOS(11, 35)
         DEVOUT("# de color, <T> para todos los colores ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "wnumcol", "@!", NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ENDIF

      MEMVAR->WTITULO := MEMVAR->WTITULO + ("DEL CODIGO " + ALLTRIM(WCOD) + ;
            " ")

   ELSE

      MEMVAR->WTITULO := MEMVAR->WTITULO + "DE TODAS LAS REFERENCIAS "

   ENDIF

   IF WTODTIP = "U"

      MEMVAR->WTIP := "  "
      DEVPOS(14, 55)
      DEVOUT("CUAL ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WTIP", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      MEMVAR->WTITULO := MEMVAR->WTITULO + ("T.O." + WTIP)

   ENDIF

   IF WTODTOT = "T"

      IF WORD = "O"

         MEMVAR->WTITULO := MEMVAR->WTITULO + "EN ORDEN DE GRABACION"

      ELSEIF WORD = "T"

         MEMVAR->WTITULO := MEMVAR->WTITULO + "ORDENADO POR T.OP."

      ELSEIF WORD = "C"

         MEMVAR->WTITULO := MEMVAR->WTITULO + "ORDENADO POR CODIGO"

      ELSEIF WORD = "D"

         MEMVAR->WTITULO := MEMVAR->WTITULO + "ORDENADO POR DOCUMENTO"

      ENDIF

   ENDIF

   IF WORD = "O"

      DEVPOS(16, 3)
      DEVOUT("En orden de grabacion desde el ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WINI", "@Z 9999", NIL, NIL):DISPLAY())
      DEVPOS(17, 3)
      DEVOUT("                      hasta el ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WFIN", "@Z 9999", NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

   ENDIF

   MENU()
   ESPERE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->WAB := "BASURA2.DBF"
   BA()

   IF WPER = "S"

      AMVPRSS()

   ELSEIF WPER = "M"

      AMOVMESS()

   ELSEIF WPER = "C"

      DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA5", NIL, NIL, .F.)

   ENDIF

   SET(3, 2)
   ESPERE()
   __DBCOPY("C:\PROTMP\BASURA2", {}, NIL, NIL, NIL, NIL, .F., NIL)
   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA2", NIL, NIL, .F.)
   DBEVAL({||FIELD->NUMPROV := RECNO()}, NIL, NIL, NIL, NIL, .F.)

   IF WORD = "O"

      IF WTODCOD = "T" .AND. WTODTIP = "T"

         __DBCOPY("C:\PROTMP\BASURA", {}, NIL, NIL, NIL, NIL, .F., NIL)

      ELSEIF WTODCOD = "T" .AND. WTODTIP = "U"

         __DBCOPY("C:\PROTMP\BASURA", {}, {||TIPOMOV = WTIP}, NIL, NIL, NIL, .F., ;
               NIL)

      ELSEIF WTODCOD = "U" .AND. WTODTIP = "T"

         __DBCOPY("C:\PROTMP\BASURA", {}, {||CODIGO = WCOD}, NIL, NIL, NIL, .F., ;
               NIL)

      ELSEIF WTODCOD = "U" .AND. WTODTIP = "U"

         __DBCOPY("C:\PROTMP\BASURA", {}, {||CODIGO = WCOD .AND. TIPOMOV = WTIP}, ;
               NIL, NIL, NIL, .F., NIL)

      ENDIF

   ELSEIF WORD = "C"

      IF WTODCOD = "T" .AND. WTODTIP = "T"

         __DBSORT("C:\PROTMP\BASURA", {"CODNUM", "NUMCOLOR", "FECHA", "TIPOMOV", ;
               "NUMDOC"}, NIL, NIL, NIL, NIL, .F.)

      ELSEIF WTODCOD = "T" .AND. WTODTIP = "U"

         __DBSORT("C:\PROTMP\BASURA", {"CODNUM", "NUMCOLOR", "FECHA", "TIPOMOV", ;
               "NUMDOC"}, {||TIPOMOV = WTIP}, NIL, NIL, NIL, .F.)

      ELSEIF WTODCOD = "U" .AND. WTODTIP = "T"

         __DBSORT("C:\PROTMP\BASURA", {"CODNUM", "NUMCOLOR", "FECHA", "TIPOMOV", ;
               "NUMDOC"}, {||CODIGO = WCOD}, NIL, NIL, NIL, .F.)

      ELSEIF WTODCOD = "U" .AND. WTODTIP = "U"

         __DBSORT("C:\PROTMP\BASURA", {"CODNUM", "NUMCOLOR", "FECHA", "TIPOMOV", ;
               "NUMDOC"}, {||TIPOMOV = WTIP .AND. CODIGO = WCOD}, NIL, NIL,;
                NIL, .F.)

      ENDIF

   ELSEIF WORD = "T"

      IF WTODCOD = "T" .AND. WTODTIP = "T"

         __DBSORT("C:\PROTMP\BASURA", {"TIPOMOV", "CODNUM", "NUMCOLOR", "FECHA", ;
               "NUMDOC"}, NIL, NIL, NIL, NIL, .F.)

      ELSEIF WTODCOD = "T" .AND. WTODTIP = "U"

         __DBSORT("C:\PROTMP\BASURA", {"TIPOMOV", "CODNUM", "NUMCOLOR", "FECHA", ;
               "NUMDOC"}, {||TIPOMOV = WTIP}, NIL, NIL, NIL, .F.)

      ELSEIF WTODCOD = "U" .AND. WTODTIP = "T"

         __DBSORT("C:\PROTMP\BASURA", {"TIPOMOV", "CODNUM", "NUMCOLOR", "FECHA", ;
               "NUMDOC"}, {||CODIGO = WCOD}, NIL, NIL, NIL, .F.)

      ELSEIF WTODCOD = "U" .AND. WTODTIP = "U"

         __DBSORT("C:\PROTMP\BASURA", {"TIPOMOV", "CODNUM", "NUMCOLOR", "FECHA", ;
               "NUMDOC"}, {||TIPOMOV = WTIP .AND. CODIGO = WCOD}, NIL, NIL,;
                NIL, .F.)

      ENDIF

   ELSEIF WORD = "D"

      IF WTODCOD = "T" .AND. WTODTIP = "T"

         __DBSORT("C:\PROTMP\BASURA", {"NUMDOC", "CODNUM", "NUMCOLOR", "TIPOMOV", ;
               "FECHA"}, NIL, NIL, NIL, NIL, .F.)

      ELSEIF WTODCOD = "T" .AND. WTODTIP = "U"

         __DBSORT("C:\PROTMP\BASURA", {"NUMDOC", "CODNUM", "NUMCOLOR", "TIPOMOV", ;
               "FECHA"}, {||TIPOMOV = WTIP}, NIL, NIL, NIL, .F.)

      ELSEIF WTODCOD = "U" .AND. WTODTIP = "T"

         __DBSORT("C:\PROTMP\BASURA", {"NUMDOC", "CODNUM", "NUMCOLOR", "TIPOMOV", ;
               "FECHA"}, {||CODIGO = WCOD}, NIL, NIL, NIL, .F.)

      ELSEIF WTODCOD = "U" .AND. WTODTIP = "U"

         __DBSORT("C:\PROTMP\BASURA", {"NUMDOC", "CODNUM", "NUMCOLOR", "TIPOMOV", ;
               "FECHA"}, {||TIPOMOV = WTIP .AND. CODIGO = WCOD}, NIL, NIL, ;
               NIL, .F.)

      ENDIF

   ELSE

      __DBSORT("C:\PROTMP\BASURA", {"CODNUM", "NUMCOLOR", "FECHA", "TIPOMOV", ;
            "NUMDOC"}, NIL, NIL, NIL, NIL, .F.)

   ENDIF

   DBCLOSEARE()
   DBSELECTAR("6")
   DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)

   IF WTODCOD = "U" .AND. XXVALCOD > 199 .AND. XXVALCOD < 300

      IF WNUMCOL <> "T"

         DBEVAL({||DBDELETE()}, {||NUMCOLOR <> WNUMCOL}, NIL, NIL, NIL, ;
               .F.)
         __DBPACK()

      ENDIF

      DBGOTOP()

   ENDIF

   IF LASTREC() < 1

      DBCLOSEARE()
      SCROLL(5, 1, 23, 78)
      SETPOS(5, 1)
      DEVPOS(12, 20)
      DEVOUT("NO HAY NADA PARA IMPRIMIR ")
      MEMVAR->X := INKEY(0)

      IF WTODCOD = "U"

         AMAINS()
         __DBLOCATE({||CODIGO = WCOD}, NIL, NIL, NIL, .F.)
         MEMVAR->WSU := SALDOUNI
         DBCLOSEARE()
         ENIM()
         DEVPOS(PROW(), 1)
         DEVOUT(;
               "** NO HAY TRANSACCIONES EN UNIDADES NI VALORES PARA EL CODIGO ";
                + WCOD + " Saldo: " + ALLTRIM(TRANSFORM(WSU, ;
               "999,999,999.99")))
         SCROLL(PROW() + 1, 1, PROW() + 1)
         SETPOS(PROW() + 1, 1)
         DEVPOS(PROW() + 2, 1)
         DEVOUT(DTOC(WFECLIS) + " / " + TIME())
         DEVPOS(PROW() + 3, 1)
         DEVOUT(" ")
         __EJECT()
         APIM()

      ENDIF

      MEMVAR->OPC := " "
      DBCLOSEALL()
      RETURN 

   ENDIF

   MEMVAR->WRECTOT := LASTREC()

   IF WORD = "O" .AND. LASTREC() <> WFIN

      DBEVAL({||DBDELETE()}, {||NUMPROV < WINI .OR. NUMPROV > WFIN}, NIL, ;
            NIL, NIL, .F.)
      __DBPACK()
      DBGOTOP()

   ENDIF

   MEMVAR->WTU1 := MEMVAR->WTU2 := MEMVAR->WTU3 := MEMVAR->WTU4 := MEMVAR->WTU5 ;
         := MEMVAR->WTU6 := MEMVAR->WTU7 := MEMVAR->WTU8 := MEMVAR->WTU9 := ;
         MEMVAR->WTU10 := MEMVAR->WTU11 := MEMVAR->WTU12 := MEMVAR->WTP1 := ;
         MEMVAR->WTP2 := MEMVAR->WTP3 := MEMVAR->WTP4 := MEMVAR->WTP5 := ;
         MEMVAR->WTP6 := MEMVAR->WTP7 := MEMVAR->WTP8 := MEMVAR->WTP9 := ;
         MEMVAR->WTP10 := MEMVAR->WTP11 := MEMVAR->WTP12 := MEMVAR->CP := ;
         MEMVAR->CL := MEMVAR->SWT := 0.0
   PIDEIMP()
   VEAIMP()
   ENIM()
   MEMVAR->WLON := 132
   DEVPOS(PROW(), PCOL())
   DEVOUT(CHR(15))
   MEMVAR->WCOD := "    "
   MEMVAR->WNUMCOLOR := " "

   DO WHILE  .NOT. EOF()

      IF SWT = 0

         MEMVAR->SWT := 1
         MEMVAR->CP := MEMVAR->CP + 1
         DEVPOS(CL, 1)
         DEVOUT(PADC(RAZON, WLON))
         MEMVAR->CL := MEMVAR->CL + 2
         DEVPOS(CL, (WLON - LEN(WTITULO)) / 2)
         DEVOUT(WTITULO)
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 1)
         DEVOUT("FECHA : " + DTOC(WFECLIS))
         MEMVAR->WT1 := "PAGINA " + ALLTRIM(TRANSFORM(CP, "99"))
         DEVPOS(CL, WLON - LEN(WT1))
         DEVOUT(WT1)
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 1)
         DEVOUT(;
               "COD. C NOMBRE              T.OP.  FECHA     CANTIDAD       VR UNIT      VR.TOTAL    NUM.DOC     # O.P  CONSEC. saldo actual";
               )
         MEMVAR->CL := MEMVAR->CL + 1

      ENDIF

      IF WTODTOT = "T"

         DEVPOS(CL, 1)
         DEVOUT(CODIGO + " " + NUMCOLOR + " " + NOMINS + " " + TIPOMOV + ;
               " " + DTOC(FECHA) + " " + TRANSFORM(CANTIDAD, ;
               "99,999,999.99") + " " + TRANSFORM(VALUNI, "99,999,999.99") ;
               + " " + TRANSFORM(VALTOT, "99,999,999.99") + " " + NUMDOC + ;
               "   " + NUMORDPRO + "  " + TRANSFORM(NUMPROV, "9999") + " ")

         IF CANTIDAD = 0 .AND. VALTOT = 0

            DEVPOS(CL, 126)
            DEVOUT("P E N D I E N T E ")

         ENDIF

         IF WORD = "C" .OR. WTODCOD = "U"

            DBSELECTAR("6")

            IF RECNO() = WRECTOT .OR. CODIGO <> WCOD .AND. NUMCOLOR = " " ;
                  .OR. CODIGO = WCOD .AND. NUMCOLOR <> WNUMCOLOR .OR. ;
                  CODIGO <> WCOD

               MEMVAR->WCOD := CODIGO
               MEMVAR->WNUMCOLOR := NUMCOLOR
               AMAINS()
               __DBLOCATE({||CODIGO = WCOD .AND. NUMCOLOR = WNUMCOLOR}, ;
                     NIL, NIL, NIL, .F.)

               IF  .NOT. EOF()

                  DEVPOS(CL, 112)
                  DEVOUTPICT(SALDOUNI, "@# 99,999,999.99")

               ELSE

                  DEVPOS(CL, 112)
                  DEVOUT("error en busqueda")

               ENDIF

               DBCLOSEARE()
               DBSELECTAR("6")

            ENDIF

         ENDIF

         MEMVAR->CL := MEMVAR->CL + 1

      ENDIF

      IF CL = 58

         MEMVAR->CL := 0
         MEMVAR->SWT := 0
         __EJECT()

      ENDIF

      IF TIPOMOV = "1 "

         MEMVAR->WTU1 := WTU1 + CANTIDAD
         MEMVAR->WTP1 := WTP1 + VALTOT

      ELSEIF TIPOMOV = "2 "

         MEMVAR->WTU2 := WTU2 + CANTIDAD
         MEMVAR->WTP2 := WTP2 + VALTOT

      ELSEIF TIPOMOV = "3 "

         MEMVAR->WTU3 := WTU3 + CANTIDAD
         MEMVAR->WTP3 := WTP3 + VALTOT

      ELSEIF TIPOMOV = "4 "

         MEMVAR->WTU4 := WTU4 + CANTIDAD
         MEMVAR->WTP4 := WTP4 + VALTOT

      ELSEIF TIPOMOV = "5 "

         MEMVAR->WTU5 := WTU5 + CANTIDAD
         MEMVAR->WTP5 := WTP5 + VALTOT

      ELSEIF TIPOMOV = "6 "

         MEMVAR->WTU6 := WTU6 + CANTIDAD
         MEMVAR->WTP6 := WTP6 + VALTOT

      ELSEIF TIPOMOV = "7 "

         MEMVAR->WTU7 := WTU7 + CANTIDAD
         MEMVAR->WTP7 := WTP7 + VALTOT

      ELSEIF TIPOMOV = "8 "

         MEMVAR->WTU8 := WTU8 + CANTIDAD
         MEMVAR->WTP8 := WTP8 + VALTOT

      ELSEIF TIPOMOV = "9 "

         MEMVAR->WTU9 := WTU9 + CANTIDAD
         MEMVAR->WTP9 := WTP9 + VALTOT

      ELSEIF TIPOMOV = "10"

         MEMVAR->WTU10 := WTU10 + CANTIDAD
         MEMVAR->WTP10 := WTP10 + VALTOT

      ELSEIF TIPOMOV = "11"

         MEMVAR->WTU11 := WTU11 + CANTIDAD
         MEMVAR->WTP11 := WTP11 + VALTOT

      ELSEIF TIPOMOV = "12"

         MEMVAR->WTU12 := WTU12 + CANTIDAD
         MEMVAR->WTP12 := WTP12 + VALTOT

      ENDIF

      DBSKIP(1)

   ENDDO

   IF CL > 50

      MEMVAR->CL := MEMVAR->SWT := 0
      __EJECT()

   ENDIF

   MEMVAR->CL := MEMVAR->CL + 1
   MEMVAR->WT1 := "TOTALES DE MOVIMIENTOS POR TIPO DE OPERACION"
   DEVPOS(CL, (WLON - LEN(WT1)) / 2)
   DEVOUT(WT1)
   MEMVAR->CL := MEMVAR->CL + 2
   ATIPMOVS()
   __DBLOCATE({||TIPO = "1 "}, NIL, NIL, NIL, .F.)
   MEMVAR->WNOM1 := NOMBRE
   __DBLOCATE({||TIPO = "2 "}, NIL, NIL, NIL, .F.)
   MEMVAR->WNOM2 := NOMBRE
   __DBLOCATE({||TIPO = "3 "}, NIL, NIL, NIL, .F.)
   MEMVAR->WNOM3 := NOMBRE
   __DBLOCATE({||TIPO = "5 "}, NIL, NIL, NIL, .F.)
   MEMVAR->WNOM5 := NOMBRE
   __DBLOCATE({||TIPO = "6 "}, NIL, NIL, NIL, .F.)
   MEMVAR->WNOM6 := NOMBRE
   __DBLOCATE({||TIPO = "7 "}, NIL, NIL, NIL, .F.)
   MEMVAR->WNOM7 := NOMBRE
   __DBLOCATE({||TIPO = "8 "}, NIL, NIL, NIL, .F.)
   MEMVAR->WNOM8 := NOMBRE
   __DBLOCATE({||TIPO = "9 "}, NIL, NIL, NIL, .F.)
   MEMVAR->WNOM9 := NOMBRE
   __DBLOCATE({||TIPO = "10"}, NIL, NIL, NIL, .F.)
   MEMVAR->WNOM10 := NOMBRE
   __DBLOCATE({||TIPO = "11"}, NIL, NIL, NIL, .F.)
   MEMVAR->WNOM11 := NOMBRE
   __DBLOCATE({||TIPO = "12"}, NIL, NIL, NIL, .F.)
   MEMVAR->WNOM12 := NOMBRE
   DBCLOSEARE()
   DEVPOS(CL, 20)
   DEVOUT("TIPO DE OPERACION         CANTIDAD          VALOR  ")
   MEMVAR->CL := MEMVAR->CL + 1

   IF WTP1 <> 0 .OR. WTU1 <> 0

      DEVPOS(CL, 20)
      DEVOUT("1. " + WNOM1 + TRANSFORM(WTU1, "999,999,999.99") + "  " + ;
            TRANSFORM(WTP1, "999,999,999.99"))
      MEMVAR->CL := MEMVAR->CL + 1

   ENDIF

   IF WTP2 <> 0 .OR. WTU2 <> 0

      DEVPOS(CL, 20)
      DEVOUT("2. " + WNOM2 + TRANSFORM(WTU2, "999,999,999.99") + "  " + ;
            TRANSFORM(WTP2, "999,999,999.99"))
      MEMVAR->CL := MEMVAR->CL + 1

   ENDIF

   IF WTP3 <> 0 .OR. WTU3 <> 0

      DEVPOS(CL, 20)
      DEVOUT("3. " + WNOM3 + TRANSFORM(WTU3, "999,999,999.99") + "  " + ;
            TRANSFORM(WTP3, "999,999,999.99"))
      MEMVAR->CL := MEMVAR->CL + 1

   ENDIF

   IF WTP5 <> 0 .OR. WTU5 <> 0

      DEVPOS(CL, 20)
      DEVOUT("5. " + WNOM5 + TRANSFORM(WTU5, "999,999,999.99") + "  " + ;
            TRANSFORM(WTP5, "999,999,999.99"))
      MEMVAR->CL := MEMVAR->CL + 1

   ENDIF

   IF WTP6 <> 0 .OR. WTU6 <> 0

      DEVPOS(CL, 20)
      DEVOUT("6. " + WNOM6 + TRANSFORM(WTU6, "999,999,999.99") + "  " + ;
            TRANSFORM(WTP6, "999,999,999.99"))
      MEMVAR->CL := MEMVAR->CL + 1

   ENDIF

   IF WTP7 <> 0 .OR. WTU7 <> 0

      DEVPOS(CL, 20)
      DEVOUT("7. " + WNOM7 + TRANSFORM(WTU7, "999,999,999.99") + "  " + ;
            TRANSFORM(WTP7, "999,999,999.99"))
      MEMVAR->CL := MEMVAR->CL + 1

   ENDIF

   IF WTP8 <> 0 .OR. WTU8 <> 0

      DEVPOS(CL, 20)
      DEVOUT("8. " + WNOM8 + TRANSFORM(WTU8, "999,999,999.99") + "  " + ;
            TRANSFORM(WTP8, "999,999,999.99"))
      MEMVAR->CL := MEMVAR->CL + 1

   ENDIF

   IF WTP9 <> 0 .OR. WTU9 <> 0

      DEVPOS(CL, 20)
      DEVOUT("9. " + WNOM9 + TRANSFORM(WTU9, "999,999,999.99") + "  " + ;
            TRANSFORM(WTP9, "999,999,999.99"))
      MEMVAR->CL := MEMVAR->CL + 1

   ENDIF

   IF WTP10 <> 0 .OR. WTU10 <> 0

      DEVPOS(CL, 20)
      DEVOUT("10." + WNOM10 + TRANSFORM(WTU10, "999,999,999.99") + "  " + ;
            TRANSFORM(WTP10, "999,999,999.99"))
      MEMVAR->CL := MEMVAR->CL + 1

   ENDIF

   IF WTP11 <> 0 .OR. WTU11 <> 0

      DEVPOS(CL, 20)
      DEVOUT("11." + WNOM11 + TRANSFORM(WTU11, "999,999,999.99") + "  " + ;
            TRANSFORM(WTP11, "999,999,999.99"))
      MEMVAR->CL := MEMVAR->CL + 1

   ENDIF

   IF WTP12 <> 0 .OR. WTU12 <> 0

      DEVPOS(CL, 20)
      DEVOUT("12." + WNOM12 + TRANSFORM(WTU12, "999,999,999.99") + "  " + ;
            TRANSFORM(WTP12, "999,999,999.99"))
      MEMVAR->CL := MEMVAR->CL + 1

   ENDIF

   DEVPOS(CL, 1)
   DEVOUT(CHR(18))
   DEVPOS(CL, 1)
   DEVOUT(DTOC(DATE()) + " / " + TIME())
   __EJECT()
   APIM()
   CIERRE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->WAB := "BASURA2.DBF"
   BA()
   MEMVAR->OPC := " "

RETURN 

