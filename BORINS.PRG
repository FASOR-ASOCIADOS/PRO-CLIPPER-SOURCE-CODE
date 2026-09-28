/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: BORINS
   Params: None.
   Return: Undefined
  Example: BORINS()
  ..........................................................................
*/

PROCEDURE BORINS()

   MEMVAR->OPC := " "
   SET(3, 5)
   MENU()
   ESPERE()
   AMAINER()
   DBCLOSEARE()
   AMAIBKE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\MAINSBAK")
   ORDLISTREB()
   DBCLOSEARE()

   DO WHILE OPC <> "N"

      MENU()
      SETCOLOR("+G")
      DEVPOS(4, 30)
      DEVOUT("BORRANDO INSUMOS EN MAESTRO")
      SETCOLOR("+W")
      MEMVAR->OPC := " "
      MEMVAR->WCOD := SPACE(4)
      DEVPOS(13, 20)
      DEVOUT("CODIGO ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCOD", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      SCROLL(12, 20, 13, 70)
      SETPOS(12, 20)

      IF WCOD = "    "

         EXIT

      ENDIF

      IF VAL(WCOD) > 199 .AND. VAL(WCOD) < 300

         MEMVAR->WNUMCOLOR := " "
         DEVPOS(14, 20)
         DEVOUT("NUMERO DEL COLOR ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNUMCOLOR", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ENDIF

      AMAINS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
      AMAIBKS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\MAINSBAK")

      IF VAL(WCOD) > 199 .AND. VAL(WCOD) < 300

         DBSELECTAR("2")
         __DBLOCATE({||CODIGO = WCOD .AND. NUMCOLOR = WNUMCOLOR}, NIL, NIL,;
                NIL, .F.)
         DBSELECTAR("19")
         __DBLOCATE({||CODIGO = WCOD .AND. NUMCOLOR = WNUMCOLOR}, NIL, NIL,;
                NIL, .F.)

      ELSE

         DBSELECTAR("2")
         DBSEEK("&WCOD")
         DBSELECTAR("19")
         DBSEEK("&WCOD")

      ENDIF

      DBSELECTAR("2")

      IF EOF()

         DBSELECTAR("2")
         DBCLOSEARE()
         DBSELECTAR("19")
         DBCLOSEARE()
         SETCOLOR("R")
         DEVPOS(15, 20)
         DEVOUT("CODIGO NO EXISTE")
         MEMVAR->X := INKEY(0)
         LOOP

      ENDIF

      IF DELETED()

         DBSELECTAR("2")
         DBCLOSEARE()
         DBSELECTAR("19")
         DBCLOSEARE()
         SETCOLOR("+GR")
         DEVPOS(15, 20)
         DEVOUT("LO ACABA DE BORRAR")
         MEMVAR->X := INKEY(0)
         LOOP

      ENDIF

      DBSELECTAR("19")
      MEMVAR->WPOS19 := RECNO()
      DBCLOSEARE()
      DBSELECTAR("2")
      MEMVAR->WLIN := LINEA
      MEMVAR->WCOD := CODIGO
      MEMVAR->WNOMFASOR := NOMFASOR
      MEMVAR->WNOM := NOMBRE
      MEMVAR->WCOLOR := COLOR
      MEMVAR->WNUMCOLOR := NUMCOLOR
      MEMVAR->WUNI := UNIDAD
      MEMVAR->WUNIPROV := UNIPROV
      MEMVAR->WFACTUNI := FACTUNI
      MEMVAR->WMIN := MINIMO
      MEMVAR->WMAX := MAXIMO
      MEMVAR->WPR1 := COSTO1
      MEMVAR->WESC := ESCALA
      MEMVAR->WPR2 := COSTO2
      MEMVAR->WULTMOV := ULTMOV
      MEMVAR->WSALUNI := SALDOUNI
      MEMVAR->WSALPES := SALDOPES
      MEMVAR->WENTMESUNI := ENTMESUNI
      MEMVAR->WENTMESPES := ENTMESPES
      MEMVAR->WOTRENMEUN := OTRENMEUNI
      MEMVAR->WOTRENMEPE := OTRENMEPES
      MEMVAR->WCONMESUNI := CONMESUNI
      MEMVAR->WCONMESPES := CONMESPES
      MEMVAR->WOTRSAMESU := OTRSAMESUN
      MEMVAR->WOTRSAMESP := OTRSAMESPE
      MEMVAR->WCOSCONMES := COSCONMES
      MEMVAR->WENTANOUNI := ENTANOUNI
      MEMVAR->WENTANOPES := ENTANOPES
      MEMVAR->WOTRENANOU := OTRENANOUN
      MEMVAR->WOTRENANOP := OTRENANOPE
      MEMVAR->WCONANOUNI := CONANOUNI
      MEMVAR->WCONANOPES := CONANOPES
      MEMVAR->WOTRSAANOU := OTRSAANOUN
      MEMVAR->WOTRSAANOP := OTRSAANOPE
      MEMVAR->WCOSCONANO := COSCONANO
      MEMVAR->WPOS2 := RECNO()
      DBCLOSEARE()
      MEMVAR->SWLEE := 0
      MENINS()
      MEMVAR->WVERIF := WSALUNI + WSALPES + WENTMESUNI + WENTMESPES + ;
            WOTRENMEUN + WCONMESUNI + WCONMESPES + WOTRSAMESU + WOTRSAMESP ;
            + WCOSCONMES
      SCROLL(24, 1, 24, 78)
      SETPOS(24, 1)

      IF WVERIF <> 0

         MEMVAR->OPC := " "
         SETCOLOR("+GR")
         DEVPOS(24, 7)
         DEVOUT(;
               "Tiene saldos o movimientos en el mes, no se puede borrar, pulse * ";
               )
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "*"}, NIL):DISPLAY(;
               ))
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         MEMVAR->OPC := " "
         LOOP

      ENDIF

      MEMVAR->WCODTRA := "    "
      SETCOLOR("+GR")
      SCROLL(24, 1, 24, 78)
      SETPOS(24, 1)
      DEVPOS(24, 10)
      DEVOUT("a que codigo traslada los acumulados anuales ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCODTRA", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      AMAINS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
      DBSEEK("&WCODTRA")

      IF EOF()

         DBCLOSEARE()
         SCROLL(24, 1, 24, 78)
         SETPOS(24, 1)
         DEVPOS(24, 10)
         DEVOUT("El codigo " + WCODTRA + " no existe")
         MEMVAR->X := INKEY(0)
         LOOP

      ENDIF

      MEMVAR->WNOMT := NOMBRE
      DBCLOSEARE()
      SCROLL(24, 1, 24, 78)
      SETPOS(24, 1)
      DEVPOS(24, 5)
      DEVOUT("Los traslada a " + WCODTRA + " " + ALLTRIM(WNOMT) + "? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      MEMVAR->OPC := " "
      SCROLL(24, 1, 24, 78)
      SETPOS(24, 1)
      DEVPOS(24, 20)
      DEVOUT("ESTA SEGURO DE BORRAR ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      SETCOLOR("W")

      IF OPC = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      SCROLL(24, 1, 24, 78)
      SETPOS(24, 1)
      AMAINS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
      DBSEEK("&WCODTRA")
      VEALOCK()
      FIELD->ENTANOUNI := ENTANOUNI + WENTANOUNI
      FIELD->ENTANOPES := ENTANOPES + WENTANOPES
      FIELD->OTRENANOUN := OTRENANOUN + WOTRENANOU
      FIELD->OTRENANOPE := OTRENANOPE + WOTRENANOP
      FIELD->CONANOUNI := CONANOUNI + WCONANOUNI
      FIELD->CONANOPES := CONANOPES + WCONANOPES
      FIELD->OTRSAANOUN := OTRSAANOUN + OTRSAANOUN
      FIELD->OTRSAANOPE := OTRSAANOPE + WOTRSAANOP
      FIELD->COSCONANO := COSCONANO + WCOSCONANO
      DBUNLOCK()
      DBGOTO(WPOS2)
      VEALOCK()
      DBDELETE()
      DBCLOSEARE()
      AMAIBKS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\MAINSBAK")
      __DBLOCATE({||CODIGO = WCODTRA}, NIL, NIL, NIL, .F.)

      IF  .NOT. EOF()

         VEALOCK()
         FIELD->ENTANOUNI := ENTANOUNI + WENTANOUNI
         FIELD->ENTANOPES := ENTANOPES + WENTANOPES
         FIELD->OTRENANOUN := OTRENANOUN + WOTRENANOU
         FIELD->OTRENANOPE := OTRENANOPE + WOTRENANOP
         FIELD->CONANOUNI := CONANOUNI + WCONANOUNI
         FIELD->CONANOPES := CONANOPES + WCONANOPES
         FIELD->OTRSAANOUN := OTRSAANOUN + OTRSAANOUN
         FIELD->OTRSAANOPE := OTRSAANOPE + WOTRSAANOP
         FIELD->COSCONANO := COSCONANO + WCOSCONANO

      ENDIF

      DBGOTO(WPOS19)

      IF  .NOT. EOF()

         VEALOCK()
         DBDELETE()

      ENDIF

      DBCLOSEARE()

   ENDDO

   MEMVAR->OPC := " "
   AMAINE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
   __DBPACK()
   DBCLOSEARE()
   AMAIBKE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\MAINSBAK")
   __DBPACK()
   DBCLOSEARE()
   SET(3, 2)

RETURN 

