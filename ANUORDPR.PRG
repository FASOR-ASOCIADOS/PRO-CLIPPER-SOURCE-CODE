/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ANUORDPR
   Params: None.
   Return: Undefined
  Example: ANUORDPR()
  ..........................................................................
*/

PROCEDURE ANUORDPR()

   MEMVAR->OPC := " "
   MENU()
   DEVPOS(2, 25)
   DEVOUT("ANULACION DE ORDENES DE PRODUCCION")
   DEVPOS(10, 15)
   DEVOUT("Por medio  de esta  opci¢n se anulan las ordenes de")
   DEVPOS(11, 15)
   DEVOUT("producci¢n que fueron mal elaboradas, no importando")
   DEVPOS(12, 15)
   DEVOUT("si ya est n o no impresas.")
   DEVPOS(13, 15)
   DEVOUT("Esta  opci¢n borra los registros correspondientes a los")
   DEVPOS(14, 15)
   DEVOUT("archivos :  ORDPRTEM, COSTOS E INSPEND; DESEA CONTINUAR ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC <> "S"

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   ESPERE()
   SET(11, "OFF")
   AOPTEE()
   DBEVAL({||DBRECALL()}, NIL, NIL, NIL, NIL, .F.)
   DBCLOSEARE()
   ACOSE()
   MEMVAR->WAB := "COSTOS.NTX"
   BA()
   DBCREATEIN("C:\PROTMP\COSTOS.NTX", "LETORD", {||LETORD}, NIL)
   DBEVAL({||DBRECALL()}, NIL, NIL, NIL, NIL, .F.)
   DBCLOSEARE()
   AINPEE()
   DBEVAL({||DBRECALL()}, NIL, NIL, NIL, NIL, .F.)
   DBCLOSEARE()
   AMVCOSE()
   DBEVAL({||DBRECALL()}, NIL, NIL, NIL, NIL, .F.)
   DBCLOSEARE()
   MEMVAR->OPC := " "

   DO WHILE OPC <> "*"

      MENU()
      DEVPOS(4, 1)
      DEVOUT(PADC("ANULACION DE ORDENES DE PRODUCCION", 78))
      MEMVAR->OPC := " "
      MEMVAR->WLETORD := SPACE(8)
      SCROLL(5, 1, 23, 78)
      SETPOS(5, 1)
      DEVPOS(12, 10)
      DEVOUT("N" + U + "mero de orden a anular ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WLETORD", NIL, NIL, NIL):DISPLAY())
      DEVPOS(12, 52)
      DEVOUT("ENTER para terminar ")
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      SCROLL(12, 50, 12, 78)
      SETPOS(12, 50)

      IF WLETORD = SPACE(8)

         MEMVAR->OPC := "*"
         LOOP

      ENDIF

      MEMVAR->WNUMORD := VAL(WLETORD)
      AOPTES()
      __DBLOCATE({||NUMORD = WNUMORD}, NIL, NIL, NIL, .F.)

      IF EOF()

         DBCLOSEARE()
         DEVPOS(13, 20)
         DEVOUT("NO ENCONTRADA")
         MEMVAR->X := INKEY(0)
         LOOP

      ENDIF

      DEVPOS(13, 20)
      DEVOUT("PRODUCTO " + CODPRO + " " + SUBSTR(NOMBREPT, 1, 20))
      MEMVAR->OPC := " "
      DBCLOSEARE()
      DEVPOS(15, 20)
      DEVOUT("SEGURO DE BORRAR ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC <> "S"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      ESPERE()
      AOPTES()

      DO WHILE  .NOT. EOF()

         IF NUMORD = WNUMORD

            VEALOCK()
            DBDELETE()

         ENDIF

         DBSKIP(1)

      ENDDO

      DBCLOSEARE()
      DBCLOSEARE()
      ACOSS()
      ORDLISTCLE()
      ORDLISTADD("C:\PROTMP\COSTOS.NTX")
      DBSEEK("&WLETORD")

      IF  .NOT. EOF()

         VEALOCK()
         DBDELETE()

      ENDIF

      DBCLOSEARE()
      AINPES()

      DO WHILE  .NOT. EOF()

         IF NUMDOC = WLETORD

            VEALOCK()
            DBDELETE()

         ENDIF

         DBSKIP(1)

      ENDDO

      DBCLOSEARE()
      AP6030E()
      MEMVAR->WNO := PADL(ALLTRIM(WLETORD), 8, "0")
      DBEVAL({||DBDELETE()}, {||LETORD = WNO}, NIL, NIL, NIL, .F.)
      __DBPACK()
      DBCLOSEARE()
      AMVCOSS()

      DO WHILE  .NOT. EOF()

         IF NUMORDPR = WLETORD

            VEALOCK()
            DBDELETE()

         ENDIF

         DBSKIP(1)

      ENDDO

      DBCLOSEARE()
      MEMVAR->WAB := "BASURA.DBF"
      BA()
      AMVPRSS()
      __DBCOPY("C:\PROTMP\BASURA", {}, {||NUMDOC = SUBSTR(WLETORD, 1, 7)}, NIL, ;
            NIL, NIL, .F., NIL)
      DBCLOSEARE()
      DBSELECTAR("8")
      DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)
      DBEVAL({||FIELD->CANTIDAD := CANTIDAD * -1, FIELD->VALTOT := VALTOT * -;
            1, FIELD->CODUSU := WCODUSU, FIELD->HORA := TIME()}, NIL, NIL, ;
            NIL, NIL, .F.)
      DBGOTOP()

      DO WHILE  .NOT. EOF()

         MEMVAR->WCOD := CODIGO
         MEMVAR->WCOL := NUMCOLOR
         MEMVAR->WCAN := CANTIDAD
         MEMVAR->WVAL := VALTOT
         AMAINS()
         __DBLOCATE({||CODIGO = WCOD .AND. NUMCOLOR = WCOL}, NIL, NIL, NIL,;
                .F.)

         IF  .NOT. EOF()

            VEALOCK()
            FIELD->SALDOUNI := SALDOUNI - WCAN
            FIELD->SALDOPES := SALDOPES - WVAL
            FIELD->CONMESUNI := CONMESUNI + WCAN
            FIELD->CONMESPES := CONMESPES + WVAL
            FIELD->CONANOUNI := CONANOUNI + WCAN
            FIELD->CONANOPES := CONANOPES + WVAL
            FIELD->COSCONMES := COSCONMES + WVAL
            FIELD->COSCONANO := COSCONANO + WVAL

            IF SALDOPES > -10 .AND. SALDOPES < 1

               FIELD->SALDOPES := 0

            ENDIF

         ENDIF

         DBCLOSEARE()
         DBSELECTAR("8")
         DBSKIP(1)

      ENDDO

      DBCLOSEARE()
      AMVPRSE()
      __DBAPP("C:\PROTMP\BASURA", {}, NIL, NIL, NIL, NIL, .F., NIL)
      DBCLOSEARE()
      MEMVAR->WAB := "BASURA.DBF"
      BA()

   ENDDO

   BORPICO()
   AOPTES()
   __DBLOCATE({||DELETED()}, NIL, NIL, NIL, .F.)

   IF  .NOT. EOF()

      DBCLOSEARE()
      AOPTEE()
      __DBPACK()

   ENDIF

   DBCREATEIN("&ZDIS\&WDIRECTO\PICO", "PRINCOOP", {||PRINCOOP}, NIL)
   DBCLOSEARE()
   ACOSE()
   __DBPACK()
   DBCLOSEARE()
   AINPES()
   __DBLOCATE({||DELETED()}, NIL, NIL, NIL, .F.)

   IF  .NOT. EOF()

      DBCLOSEARE()
      AINPEE()
      __DBPACK()

   ENDIF

   DBCLOSEARE()
   AMVCOSS()
   __DBLOCATE({||DELETED()}, NIL, NIL, NIL, .F.)

   IF  .NOT. EOF()

      DBCLOSEARE()
      AMVCOSE()
      __DBPACK()

   ENDIF

   DBCLOSEARE()
   DBSELECTAR("8")
   DBCLOSEARE()
   MEMVAR->OPC := " "

RETURN 

