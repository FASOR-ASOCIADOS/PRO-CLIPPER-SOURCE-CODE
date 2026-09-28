/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ACELAOR
   Params: None.
   Return: Undefined
  Example: ACELAOR()
  ..........................................................................
*/

PROCEDURE ACELAOR()

   ACOSE()
   MEMVAR->WAB := "COSTOS.NTX"
   BA()
   DBCREATEIN("C:\COSTOS.NTX", "LETORD", {||LETORD}, NIL)
   DBCLOSEARE()
   AOPTES()
   MEMVAR->WVALPOS := 20 / LASTREC()
   MEMVAR->WPOS := RECNO()
   DBCLOSEARE()
   SETCOLOR("+W/B")
   MEMVAR->RAYA := REPLICATE("Û", 20)
   DEVPOS(20, 10)
   DEVOUT(RAYA)
   MEMVAR->WCOL := 10
   SETCOLOR("+W")
   MEMVAR->SWT := 1

   DO WHILE SWT = 1

      AOPTES()
      DBGOTO(WPOS)
      MEMVAR->WCOL := WCOL + WVALPOS
      SETCOLOR("+G")
      DEVPOS(20, WCOL)
      DEVOUT(CHR(26))
      SETCOLOR("+W")

      IF ACTUALIZAD = "X"

         DBSKIP(1)

         IF EOF()

            MEMVAR->SWT := 0

         ENDIF

         MEMVAR->WPOS := RECNO()
         DBCLOSEARE()
         LOOP

      ENDIF

      MEMVAR->WCODART := CODPRO
      MEMVAR->WCOD := CODINS
      MEMVAR->WNUMCOL := NUMCOLOR
      MEMVAR->WCOLOR := COLOR
      MEMVAR->WCANORD := CANORD
      MEMVAR->WCANTOT := CANTOT
      MEMVAR->WCANPED := CANPED
      MEMVAR->WCAN := CANINV
      MEMVAR->WVAL := VALUNI
      MEMVAR->WTOTINV := ROUND(WCAN * WVAL, 2)
      MEMVAR->WTOT := VALTOT
      MEMVAR->WDOC := ALLTRIM(TRANSFORM(NUMORD, "99999999")) + SPACE(8 - ;
            LEN(ALLTRIM(TRANSFORM(NUMORD, "99999999"))))
      MEMVAR->WNOMPT := NOMBREPT
      MEMVAR->WNOMINS := NOMINS
      MEMVAR->WPREVEN := PREVEN
      MEMVAR->WNOMCLI := NOMCLI
      MEMVAR->WCODCLI := CODCLI
      MEMVAR->WCOSDIR := COSDIR
      MEMVAR->WFEC := FECHA
      DBCLOSEARE()
      AMAINS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")

      IF VAL(WCOD) > 199 .AND. VAL(WCOD) < 300

         __DBLOCATE({||CODIGO = WCOD .AND. NUMCOLOR = WNUMCOL}, NIL, NIL, ;
               NIL, .F.)

      ELSE

         DBSEEK("&WCOD")

      ENDIF

      IF EOF()

         DBCLOSEARE()
         AOPTES()
         DBGOTO(WPOS)
         DBSKIP(1)

         IF EOF()

            MEMVAR->SWT := 0

         ENDIF

         MEMVAR->WPOS := RECNO()
         DBCLOSEARE()
         LOOP

      ENDIF

      IF SALDOUNI - WCAN < 0

         MEMVAR->WDIF := ROUND(WCAN - SALDOUNI, 2)
         MEMVAR->WSAL := SALDOUNI
         VEALOCK()
         FIELD->SALDOUNI := SALDOUNI - WSAL
         FIELD->SALDOPES := SALDOPES - ROUND(WVAL * WSAL, 2)
         FIELD->CONMESUNI := CONMESUNI + WSAL
         FIELD->CONMESPES := CONMESPES + ROUND(WVAL * WSAL, 2)
         FIELD->CONANOUNI := CONANOUNI + WSAL
         FIELD->CONANOPES := CONANOPES + ROUND(WVAL * WSAL, 2)
         FIELD->COSCONMES := COSCONMES + ROUND(WVAL * WSAL, 2)
         FIELD->COSCONANO := COSCONANO + ROUND(WVAL * WSAL, 2)
         MEMVAR->WCOS1 := COSTO1

         IF SALDOPES > -10 .AND. SALDOPES < 1

            FIELD->SALDOPES := 0

         ENDIF

         DBCLOSEARE()
         AINPES()
         DBAPPEND()
         FIELD->CODIGO := WCOD
         FIELD->CODNUM := VAL(WCOD)
         FIELD->NUMCOLOR := WNUMCOL
         FIELD->FECHA := WDATE
         FIELD->NUMDOC := WDOC
         FIELD->CANTIDAD := WDIF
         FIELD->VALUNI := WVAL
         FIELD->VALTOT := ROUND(WDIF * WVAL, 2)
         FIELD->NOMINS := WNOMINS
         FIELD->NOMBRE := WNOMPT
         FIELD->CODUSU := WCODUSU
         FIELD->HORA := TIME()

         IF VAL(WCOD) > 999 .AND. VAL(WCOD) < 1200

            FIELD->TIPOMOV := "8 "

         ELSE

            FIELD->TIPOMOV := "7 "

         ENDIF

         DBCLOSEARE()

         IF WSAL > 0

            AMVPRSS()
            DBAPPEND()
            FIELD->CODIGO := WCOD
            FIELD->CODNUM := VAL(WCOD)
            FIELD->NUMCOLOR := WNUMCOL
            FIELD->NUMDOC := WDOC
            FIELD->CANTIDAD := WSAL
            FIELD->VALUNI := WVAL
            FIELD->VALTOT := ROUND(WSAL * WVAL, 2)
            FIELD->NOMINS := WNOMINS
            FIELD->NOMBRE := WNOMPT
            FIELD->FECHA := WDATE
            FIELD->NUMORDPRO := WDOC
            FIELD->NUMORDPR := VAL(WDOC)
            FIELD->CODUSU := WCODUSU
            FIELD->HORA := TIME()
            FIELD->COSPRO := WVAL

            IF VAL(WCOD) > 999 .AND. VAL(WCOD) < 1200

               FIELD->TIPOMOV := "8 "

            ELSE

               FIELD->TIPOMOV := "7 "

            ENDIF

            DBCLOSEARE()

         ENDIF

         MEMVAR->WCANCOS := WSAL
         MEMVAR->WUNICOS := WVAL

      ELSE

         VEALOCK()
         FIELD->SALDOUNI := SALDOUNI - WCAN
         FIELD->SALDOPES := SALDOPES - WTOTINV
         FIELD->CONMESUNI := CONMESUNI + WCAN
         FIELD->CONMESPES := CONMESPES + WTOTINV
         FIELD->CONANOUNI := CONANOUNI + WCAN
         FIELD->CONANOPES := CONANOPES + WTOTINV
         FIELD->COSCONMES := COSCONMES + WTOTINV
         FIELD->COSCONANO := COSCONANO + WTOTINV

         IF SALDOPES > -10 .AND. SALDOPES < 1

            FIELD->SALDOPES := 0

         ENDIF

         DBCLOSEARE()
         AMVPRSS()
         DBAPPEND()
         FIELD->CODIGO := WCOD
         FIELD->CODNUM := VAL(WCOD)
         FIELD->NUMCOLOR := WNUMCOL
         FIELD->NUMDOC := WDOC
         FIELD->CANTIDAD := WCAN
         FIELD->VALUNI := WVAL
         FIELD->VALTOT := WTOTINV
         FIELD->NOMINS := WNOMINS
         FIELD->NOMBRE := WNOMPT
         FIELD->FECHA := WDATE
         FIELD->NUMORDPRO := WDOC
         FIELD->NUMORDPR := VAL(WDOC)
         FIELD->CODUSU := WCODUSU
         FIELD->HORA := TIME()
         FIELD->COSPRO := WVAL

         IF VAL(WCOD) > 999 .AND. VAL(WCOD) < 1200

            FIELD->TIPOMOV := "8 "

         ELSE

            FIELD->TIPOMOV := "7 "

         ENDIF

         DBCLOSEARE()

      ENDIF

      MEMVAR->WCANCOS := WCAN
      MEMVAR->WUNICOS := WVAL
      MEMVAR->WTOTCOS := WTOTINV
      ACOSS()
      ORDLISTCLE()
      ORDLISTADD("C:\COSTOS.NTX")
      MEMVAR->ZNUMORD := VAL(WDOC)
      DBSEEK("&WDOC")

      IF EOF()

         DBAPPEND()

      ELSE

         VEALOCK()

      ENDIF

      FIELD->NUMORD := VAL(WDOC)
      FIELD->LETORD := WDOC
      FIELD->CODPRO := WCODART
      FIELD->CANORD := WCANTOT
      FIELD->CANPED := WCANPED
      FIELD->CANTOT := WCANTOT
      FIELD->NOMBREPT := WNOMPT
      FIELD->FECHA := WDATE
      FIELD->PREVEN := WPREVEN
      FIELD->VALTOT := VALTOT + WTOTCOS
      FIELD->VALUNI := VALUNI + WVAL
      FIELD->NUMCLI := VAL(WCODCLI)
      FIELD->NOMCLI := WNOMCLI
      FIELD->CODCLI := WCODCLI
      FIELD->CODUSU := WCODUSU
      FIELD->HORA := TIME()

      IF WCOD = "724 "

         FIELD->SCREEN := SCREEN + WCAN * WVAL

      ENDIF

      DBCLOSEARE()
      AMVCOSS()
      DBAPPEND()
      FIELD->CODIGO := WCOD
      FIELD->CODNUM := VAL(WCOD)
      FIELD->NUMCOLOR := WNUMCOL
      FIELD->NUMORDPR := WDOC
      FIELD->CANTIDAD := WCANCOS
      FIELD->VALUNI := WUNICOS
      FIELD->VALTOT := WTOTCOS
      FIELD->NOMINS := WNOMINS
      FIELD->FECHA := WDATE
      FIELD->CODUSU := WCODUSU
      FIELD->HORA := TIME()

      IF VAL(WCOD) > 999 .AND. VAL(WCOD) < 1200

         FIELD->TIPOMOV := "8 "
         FIELD->NUMORD := VAL(NUMORDPR)

      ELSE

         FIELD->TIPOMOV := "7 "
         FIELD->NUMORD := VAL(NUMORDPR)

      ENDIF

      DBCLOSEARE()
      AOPTES()
      DBGOTO(WPOS)
      VEALOCK()
      FIELD->ACTUALIZAD := "X"

      IF VALTOT = 0

         IF CANINV < 0.001

            FIELD->VALTOT := 0

         ELSE

            FIELD->VALTOT := ROUND(VALUNI * CANINV, 2)

         ENDIF

      ENDIF

      DBCOMMITAL()
      DBSKIP(1)

      IF EOF()

         MEMVAR->SWT := 0

      ENDIF

      MEMVAR->WPOS := RECNO()
      DBCLOSEARE()

   ENDDO


RETURN 

