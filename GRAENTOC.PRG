/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: GRAENTOC
   Params: None.
   Return: Undefined
  Example: GRAENTOC()
  ..........................................................................
*/

PROCEDURE GRAENTOC()

   SET(3, 2)
   SET(1, "ON")
   MEMVAR->OPC := " "
   MEMVAR->WFECORD := DATE()
   SET(3, 2)
   SCROLL(6, 0, 24, 79)
   MEMVAR->WNUMFIL := ( SETPOS(6, 0), 9 )
   MEMVAR->WAB := "BASURA.NTX"
   BA()
   AOCE()
   DBCREATEIN("C:\PROTMP\BASURA", "ORD+CODINS", {||ORD + CODINS}, NIL)
   DBCLOSEARE()

   DO WHILE OPC <> "*"

      SETCOLOR("+W")
      SET(3, 2)
      DEVPOS(8, 0)
      DEVOUT(;
            "CODIGO INSUMO o articulo              CANTIDAD      VR. UNIT.     VR. TOTAL";
            )
      DEVPOS(9, 0)
      DEVOUT(;
            "------ ------------------------------ ----------    ------------  ------------";
            )
      SCROLL(22, 0, 24, 79)
      SETPOS(22, 0)
      DEVPOS(24, 10)
      DEVOUT("FECHA DE LA ENTRADA ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WFECORD", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      DEVPOS(24, 10)
      DEVOUT("                                            ")
      MEMVAR->NOESTA := "N"
      MEMVAR->WCODINS := SPACE(4)
      MEMVAR->WNUMENT := MEMVAR->WNUMORD := MEMVAR->WNUMOP := SPACE(7)
      DEVPOS(24, 10)
      DEVOUT("NUMERO DE LA ENTRADA ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WNUMENT", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WNUMENT = SPACE(7) .OR. LASTKEY() = 27

         MEMVAR->OPC := "*"
         LOOP

      ENDIF

      DEVPOS(24, 10)
      DEVOUT("                                  ")

      DO WHILE NOESTA = "N"

         MEMVAR->WNUMORD := SPACE(7)
         DEVPOS(24, 10)
         DEVOUT("NUMERO DE ORDEN DE COMPRA ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNUMORD", NIL, NIL, NIL):DISPLAY())
         SETCOLOR("+G")
         DEVPOS(24, 50)
         DEVOUT("* o ESC Para salir")
         SETCOLOR("+W")
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         SCROLL(23, 1, 24, 78)
         SETPOS(23, 1)

         IF WNUMORD = "*" .OR. LASTKEY() = 27

            EXIT

         ENDIF

         DEVPOS(24, 10)
         DEVOUT("CODIGO DEL INSUMO A ENTRAR ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCODINS", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF LASTKEY() = 27

            LOOP

         ENDIF

         SCROLL(24, 1, 24, 78)
         MEMVAR->WNUMCOLOR := ( SETPOS(24, 1), " " )

         IF VAL(WCODINS) > 199 .AND. VAL(WCODINS) < 300

            DEVPOS(24, 20)
            DEVOUT("N£mero del color ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WNUMCOLOR", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            SCROLL(24, 1, 24, 78)
            SETPOS(24, 1)

         ENDIF

         MEMVAR->WNUMOP := SPACE(7)

         IF VAL(WCODINS) > 699 .AND. VAL(WCODINS) < 800 .AND. VAL(WCODINS) ;
               <> 764

            DEVPOS(24, 20)
            DEVOUT("N£mero de O.P. ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WNUMOP", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            SCROLL(24, 1, 24, 78)
            SETPOS(24, 1)

         ENDIF

         AOCS()

         IF VAL(WCODINS) > 699 .AND. VAL(WCODINS) < 800 .AND. VAL(WCODINS) ;
               <> 764

            __DBLOCATE({||VAL(WNUMORD) = NUMORD .AND. CODINS = WCODINS ;
                  .AND. NUMCOLOR = WNUMCOLOR .AND. ORDPROD = WNUMOP .AND. ;
                  .NOT. DELETED()}, NIL, NIL, NIL, .F.)

         ELSE

            __DBLOCATE({||VAL(WNUMORD) = NUMORD .AND. CODINS = WCODINS ;
                  .AND. NUMCOLOR = WNUMCOLOR .AND. .NOT. DELETED()}, NIL, ;
                  NIL, NIL, .F.)

         ENDIF

         IF EOF()

            DBCLOSEARE()
            DEVPOS(24, 10)
            DEVOUT("ESA ORDEN CON ESE INSUMO NO ESTAN PEDIDOS.")
            MEMVAR->X := INKEY(0)
            SCROLL(24, 1, 24, 78)
            SETPOS(24, 1)
            LOOP

         ENDIF

         MEMVAR->WPOS16 := RECNO()
         DBCLOSEARE()
         MEMVAR->NOESTA := "S"

      ENDDO

      IF SUBSTR(WNUMORD, 1, 1) = "*"

         LOOP

      ENDIF

      MEMVAR->WNUMFIL := MEMVAR->WNUMFIL + 1
      AMAINS()
      __DBLOCATE({||CODIGO = WCODINS .AND. NUMCOLOR = WNUMCOLOR}, NIL, NIL,;
             NIL, .F.)

      IF EOF()

         DBCLOSEARE()
         __WAIT("NO ESTA ESE INSUMO  EN MAESTRO")
         MEMVAR->WVORI := MEMVAR->WSALDOUNI := 0

      ELSE

         MEMVAR->WSALDOUNI := SALDOUNI
         MEMVAR->WVORI := COSTO1

      ENDIF

      MEMVAR->WPOS2 := RECNO()
      DBCLOSEARE()
      DEVPOS(24, 34)
      DEVOUT("SALDO EN INV.: " + ALLTRIM(TRANSFORM(WSALDOUNI, "999,999")) +;
             "     ")

      IF WNUMFIL > 20

         SCROLL(10, 0, 22, 79)
         MEMVAR->WNUMFIL := ( SETPOS(10, 0), 10 )

      ENDIF

      AOCS()
      DBGOTO(WPOS16)
      MEMVAR->WCANPED := CANPED - CANENT
      MEMVAR->WCODPROV := CODPROV
      MEMVAR->WNOMEST := NOMEST
      MEMVAR->WNOMPROV := NOMPROV
      MEMVAR->WDIR := DIRECCION
      MEMVAR->WTEL := TELEFONO
      MEMVAR->WCONPAG := SPACE(20)
      MEMVAR->XNIT := SPACE(11)
      MEMVAR->WCODINS := CODINS
      MEMVAR->WNUMCOLOR := NUMCOLOR
      MEMVAR->WVRUNIT := VRUNIT
      MEMVAR->WVALTOT := VALTOT
      MEMVAR->WNOMBRE := MEMVAR->WNOMART := NOMART
      MEMVAR->WNOMINS := SUBSTR(NOMART, 1, 20)
      DBCLOSEARE()
      MEMVAR->MM := " "
      DEVPOS(WNUMFIL, 0)
      DEVOUT(WCODINS)
      MEMVAR->WNOMART1 := LEFT(WNOMBRE, 30)
      MEMVAR->WNOMART2 := SUBSTR(WNOMBRE, 30, 30)
      MEMVAR->WNOMART3 := SUBSTR(WNOMBRE, 60, 30)
      DEVPOS(WNUMFIL, 7)
      DEVOUT(SPACE(60))
      DEVPOS(WNUMFIL, 7)
      DEVOUT(LEFT(WNOMART, 30))
      MEMVAR->SWESP := 0
      MEMVAR->WNUMOP := WNUMOP + " "

      IF VAL(WCODINS) > 699 .AND. VAL(WCODINS) < 800 .AND. VAL(WCODINS) <> ;
            764

         SCROLL(22, 1, 23, 78)
         SETPOS(22, 1)
         DEVPOS(22, 5)
         DEVOUT("Nombre exacto del insumo ? ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNOMINS", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         AINPES()
         __DBLOCATE({||CODIGO = WCODINS .AND. NUMDOC = WNUMOP .AND. ;
               NUMCOLOR = WNUMCOLOR .AND. NOMINS = WNOMINS .AND. .NOT. ;
               DELETED()}, NIL, NIL, NIL, .F.)
         SCROLL(22, 1, 23, 78)
         SETPOS(22, 1)

         IF EOF()

            DBCLOSEARE()
            DEVPOS(23, 10)
            DEVOUT("LA ORDEN " + ALLTRIM(WNUMOP) + ;
                  " NO TIENE ESE PENDIENTE")
            MEMVAR->X := INKEY(0)
            SCROLL(22, 1, 23, 78)
            SETPOS(22, 1)
            LOOP

         ENDIF

         MEMVAR->WPOS4 := RECNO()
         DBCLOSEARE()
         MEMVAR->SWESP := 1
         AOCS()
         DBGOTO(WPOS16)
         MEMVAR->WNOMART1 := LEFT(NOMART, 30)
         MEMVAR->WNOMART2 := SUBSTR(NOMART, 30, 30)
         MEMVAR->WNOMART3 := SUBSTR(NOMART, 60, 30)
         MEMVAR->WCANPED := CANPED - CANENT
         MEMVAR->WWVALUNI := VRUNIT
         MEMVAR->WWVALTOT := VALTOT
         DBCLOSEARE()
         DEVPOS(WNUMFIL, 7)
         DEVOUT(WNOMART1)
         DEVPOS(WNUMFIL + 1, 7)
         DEVOUT(WNOMART2)
         DEVPOS(WNUMFIL + 2, 7)
         DEVOUT(WNOMART3)
         DEVPOS(WNUMFIL, 38)
         DEVOUTPICT(WCANPED, "@Z 999,999.99")
         DEVPOS(WNUMFIL, 55)
         DEVOUTPICT(WWVALUNI, "@Z 99,999.99")
         DEVPOS(WNUMFIL, 65)
         DEVOUTPICT(WWVALTOT, "@Z 999,999,999.99")
         SCROLL(WNUMFIL, 1, 23, 78)
         SETPOS(WNUMFIL, 1)
         DEVPOS(WNUMFIL, 7)
         DEVOUT(WNOMART1)
         MEMVAR->WNUMFIL := MEMVAR->WNUMFIL + 1
         AOCS()
         DBGOTO(WPOS16)
         MEMVAR->WCANPED := CANPED - CANENT
         MEMVAR->WCODINS := CODINS
         MEMVAR->WCODPROV := CODPROV
         MEMVAR->WCONPAG := SPACE(20)
         MEMVAR->WDIR := DIRECCION
         MEMVAR->WNOMART := MEMVAR->WNOMBRE := NOMART
         MEMVAR->WNOMEST := NOMEST
         MEMVAR->WNOMPROV := NOMPROV
         MEMVAR->WNUMCOLOR := NUMCOLOR
         MEMVAR->WTEL := TELEFONO
         MEMVAR->WVALTOT := VALTOT
         MEMVAR->WVRUNIT := VRUNIT
         MEMVAR->XNIT := SPACE(11)
         DBCLOSEARE()

      ENDIF

      MEMVAR->WCANENT := 0
      DEVPOS(24, 55)
      DEVOUT("CANTIDAD ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCANENT", "@# 99,999,999.99", NIL, NIL);
            :DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      SCROLL(24, 1, 24, 78)
      SETPOS(24, 1)

      IF WCANENT = 0

         SCROLL(WNUMFIL, 0, 24, 79)
         SETPOS(WNUMFIL, 0)

         IF SWESP = 1

            MEMVAR->WNUMFIL := IF(WNOMART3 <> "    ", WNUMFIL - 2, WNUMFIL -;
                   1)

         ELSE

            MEMVAR->WNUMFIL := WNUMFIL - 1

         ENDIF

         LOOP

      ENDIF

      IF WCANPED - WCANENT < 0

         SCROLL(24, 1, 24, 78)
         SETPOS(24, 1)
         DEVPOS(24, 5)
         DEVOUT("ESTA ENTRANDO MAS DE LO PEDIDO, NO SE RECIBE")
         MEMVAR->X := INKEY(0)
         SCROLL(WNUMFIL, 0, 24, 79)
         SETPOS(WNUMFIL, 0)

         IF SWESP = 0

            MEMVAR->WNUMFIL := WNUMFIL - 1

         ELSE

            MEMVAR->WNUMFIL := WNUMFIL - 1

            IF WNOMART3 <> "    "

               MEMVAR->WNUMFIL := WNUMFIL - 1

            ENDIF

         ENDIF

         LOOP

      ENDIF

      SETCOLOR("+G")
      DEVPOS(WNUMFIL, 38)
      DEVOUTPICT(WCANENT, "@# 999,999.99")
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      SETCOLOR("+W")
      MEMVAR->WVALTOT := WCANENT * WVRUNIT
      SETPOS(WNUMFIL, 65)
      AADD(GETLIST, __GET(NIL, "WVALTOT", "@# 999,999,999.99", NIL, NIL);
            :DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      MEMVAR->WVRUNIT := ROUND(WVALTOT / WCANENT, 2)
      DEVPOS(WNUMFIL, 55)
      DEVOUTPICT(WVRUNIT, "@# 99,999.99")

      IF VAL(WCODINS) < 700 .OR. VAL(WCODINS) > 799

         MEMVAR->WTRES := WVORI * 3 / 100

         IF WVRUNIT > WVORI + WTRES

            SCROLL(22, 1, 23, 78)
            MEMVAR->OP := ( SETPOS(22, 1), " " )
            DEVPOS(22, 5)
            DEVOUT(;
                  "No puede grabar ordenes con valor unitario mayor que el ";
                  )
            DEVPOS(23, 5)
            DEVOUT("registrado en inventario : " + ALLTRIM(TRANSFORM(WVORI,;
                   "999,999,999.99")) + ", PULSE * ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "OP", "@!", {||OP $ "*"}, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            MEMVAR->WNUMFIL := WNUMFIL - 1
            SCROLL(WNUMFIL, 0, 23, 78)
            MEMVAR->OP := ( SETPOS(WNUMFIL, 0), " " )
            LOOP

         ENDIF

      ENDIF

      MEMVAR->OPC := " "
      DEVPOS(23, 10)
      DEVOUT("ESTA BIEN TODO ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "N" .OR. LASTKEY() = 27

         MEMVAR->WNUMFIL := WNUMFIL - 1
         SCROLL(WNUMFIL, 1, 23, 78)
         MEMVAR->OPC := ( SETPOS(WNUMFIL, 1), " " )
         LOOP

      ENDIF

      SCROLL(WNUMFIL + 1, 1, 23, 78)
      MEMVAR->OPC := ( SETPOS(WNUMFIL + 1, 1), " " )
      SET(3, 2)
      ESPERE()
      AOCS()
      DBGOTO(WPOS16)
      VEALOCK()
      FIELD->CANENT := CANENT + WCANENT
      FIELD->CODUSU := WCODUSU
      FIELD->HORA := TIME()

      IF CANENT = CANPED

         DBDELETE()

      ENDIF

      DBCLOSEARE()
      AMAINS()
      DBGOTO(WPOS2)
      VEALOCK()
      FIELD->SALDOUNI := SALDOUNI + WCANENT
      FIELD->SALDOPES := SALDOPES + WCANENT * WVRUNIT
      FIELD->ENTMESUNI := ENTMESUNI + WCANENT
      FIELD->ENTMESPES := ENTMESPES + WCANENT * WVRUNIT
      FIELD->ENTANOUNI := ENTANOUNI + WCANENT
      FIELD->ENTANOPES := ENTANOPES + WCANENT * WVRUNIT
      FIELD->ULTMOV := WFECORD

      IF SALDOPES > -10 .AND. SALDOPES < 1

         FIELD->SALDOPES := 0

      ENDIF

      AMVPRSS()
      DBAPPEND()
      FIELD->CODNUM := VAL(WCODINS)
      FIELD->CODIGO := WCODINS
      FIELD->NUMCOLOR := WNUMCOLOR
      FIELD->TIPOMOV := "1 "
      FIELD->NUMDOC := WNUMENT
      FIELD->FECHA := WFECORD
      FIELD->CANTIDAD := WCANENT
      FIELD->VALUNI := WVRUNIT
      FIELD->VALTOT := WVALTOT
      FIELD->CODPROV := WCODPROV
      FIELD->NUMPROV := VAL(WCODPROV)
      FIELD->NOMBRE := WNOMART
      FIELD->NOMINS := WNOMINS
      FIELD->NUMORDPRO := WNUMOP
      FIELD->NUMORDPR := VAL(WNUMOP)
      FIELD->CODUSU := WCODUSU
      FIELD->HORA := TIME()
      DBCLOSEARE()

      IF WCANENT > 0

         SET(11, "ON")
         AINPES()
         DBGOTOP()

         DO WHILE  .NOT. EOF()

            IF DELETED() .OR. VAL(CODIGO) = 764 .OR. CODIGO <> WCODINS ;
                  .OR. NUMCOLOR <> WNUMCOLOR

               DBSKIP(1)
               LOOP

            ENDIF

            IF VAL(CODIGO) > 699 .AND. VAL(CODIGO) < 800 .AND. (NOMINS <> ;
                  WNOMINS .OR. WNUMOP <> NUMDOC) .OR. VAL(CODIGO) > 699 ;
                  .AND. VAL(CODIGO) < 800 .AND. NOMINS <> WNOMINS

               DBSKIP(1)
               LOOP

            ENDIF

            MEMVAR->WCANPEN := CANTIDAD
            MEMVAR->WDOC := NUMDOC
            MEMVAR->WNOM := WNOMINS
            MEMVAR->WUNI := VALUNI
            MEMVAR->XMOV := TIPOMOV
            AMAINS()
            DBGOTO(WPOS2)

            IF SALDOUNI < 0.1

               DBCLOSEARE()
               DBSELECTAR("4")
               DBGOBOTTOM()
               DBSKIP(1)
               LOOP

            ENDIF

            MEMVAR->WCANMOV := IF(SALDOUNI - WCANPEN > -0.9999, WCANPEN, ;
                  SALDOUNI)
            MEMVAR->WTOT := ROUND(WCANMOV * WUNI, 2)
            VEALOCK()
            FIELD->CONMESUNI := CONMESUNI + WCANMOV
            FIELD->CONANOUNI := CONANOUNI + WCANMOV
            FIELD->CONMESPES := CONMESPES + WTOT
            FIELD->CONANOPES := CONANOPES + WTOT
            MEMVAR->WCOSUNITA := IF(SALDOUNI <> 0, ROUND(SALDOPES / ;
                  SALDOUNI, 2), SALDOPES)
            MEMVAR->WCOSSALEN := ROUND(WCOSUNITA * WCANMOV, 2)
            FIELD->SALDOPES := SALDOPES - WCOSSALEN
            FIELD->SALDOUNI := SALDOUNI - WCANMOV
            FIELD->COSCONMES := COSCONMES + WCOSSALEN
            FIELD->COSCONANO := COSCONANO + WCOSSALEN
            FIELD->ULTMOV := WFECORD

            IF SALDOPES > -10 .AND. SALDOPES < 1

               FIELD->SALDOPES := 0

            ENDIF

            DBCLOSEARE()
            AMVPRSS()
            DBAPPEND()
            FIELD->CODNUM := VAL(WCODINS)
            FIELD->CODIGO := WCODINS
            FIELD->NUMCOLOR := WNUMCOLOR
            FIELD->NUMDOC := WDOC
            FIELD->FECHA := WFECORD
            FIELD->CANTIDAD := WCANMOV
            FIELD->VALUNI := WUNI
            FIELD->VALTOT := WTOT
            FIELD->NOMBRE := WNOM
            FIELD->NOMINS := WNOMINS
            FIELD->TIPOMOV := XMOV
            FIELD->CODUSU := WCODUSU
            FIELD->HORA := TIME()

            IF VAL(CODIGO) > 699 .AND. VAL(CODIGO) < 800

               FIELD->NUMORDPRO := WNUMOP
               FIELD->NUMORDPR := VAL(WNUMOP)

            ELSE

               FIELD->NUMORDPRO := WDOC
               FIELD->NUMORDPR := VAL(WDOC)

            ENDIF

            DBCLOSEARE()
            DBSELECTAR("4")
            VEALOCK()
            FIELD->CANTIDAD := CANTIDAD - WCANMOV

            IF CANTIDAD < 0.001

               DBDELETE()

            ENDIF

            DBSKIP(1)

         ENDDO

         DBCLOSEARE()

      ENDIF

   ENDDO

   MEMVAR->OPC := " "
   AOCE()
   __DBPACK()
   AINPEE()
   __DBPACK()
   CIERRE()
   SET(1, "OFF")

RETURN 

