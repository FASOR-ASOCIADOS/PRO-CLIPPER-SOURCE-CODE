/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: GRAORD
   Params: None.
   Return: Undefined
  Example: GRAORD()
  ..........................................................................
*/

PROCEDURE GRAORD()

   MEMVAR->OPC := " "
   ESPERE()
   __MRESTORE("&ZDIS\&WDIRECTO\FACTOIVA", .T.)
   MEMVAR->WAB := "ORDTEM.DBF"
   BA()

   IF  .NOT. FILE("C:\PROTMP\ORDTEM.DBF")

      AOCS()
      __DBCOPYST("C:\PROTMP\ORDTEM", {})
      DBCLOSEARE()

   ENDIF

   DBSELECTAR("1")
   DBUSEAREA(.F., NIL, "C:\PROTMP\ORDTEM", NIL, NIL, .F.)
   AMAPRVE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\COD-PROV")
   ORDLISTREB()
   DBCLOSEARE()
   AMAINER()
   DBCLOSEARE()
   MEMVAR->WFECORD := DATE()
   SET(3, 2)
   MEMVAR->WORDPOR := SPACE(25)

   DO WHILE OPC <> "*"

      __MRESTORE("&ZDIS\&WDIRECTO\NUMORD", .T.)
      MEMVAR->NUMORDCI := MEMVAR->NUMORDCI + 1
      MENU()
      DEVPOS(23, 10)
      DEVOUT("FECHA DE LA ORDEN   ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WFECORD", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      DEVPOS(23, 10)
      DEVOUT("                                  ")
      MEMVAR->WCODPROV := SPACE(5)
      DEVPOS(23, 10)
      DEVOUT("CODIGO DEL PROVEED. ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCODPROV", NIL, NIL, NIL):DISPLAY())
      DEVPOS(23, 50)
      DEVOUT("* o ESC para terminar")
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF SUBSTR(WCODPROV, 1, 1) = "*" .OR. LASTKEY() = 27

         MEMVAR->OPC := "*"
         LOOP

      ENDIF

      AMAPRVS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\COD-PROV")
      DBSEEK("&WCODPROV")

      IF EOF()

         DBCLOSEARE()
         SETCOLOR("+W/R")
         DEVPOS(23, 30)
         DEVOUT("PROVEED. NO EXISTE")
         MEMVAR->X := INKEY(0)
         SETCOLOR("+W")
         SCROLL(23, 1, 24, 78)
         SETPOS(23, 1)
         LOOP

      ENDIF

      MEMVAR->WNOMEST := NOMEST
      MEMVAR->WNOMPROV := NOMPROV
      MEMVAR->WDIR := DIRECCION
      MEMVAR->WTEL := TELEFONO
      MEMVAR->WCONPAG := SUBSTR(CONPAG, 1, 20)
      MEMVAR->WDES := DESCUENTO
      MEMVAR->XNIT := SPACE(11)
      DBCLOSEARE()
      SCROLL(23, 1, 24, 78)
      SETPOS(23, 1)
      DEVPOS(23, 10)
      DEVOUT("DESCUENTO ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WDES", "@Z 999.99", NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      SCROLL(23, 1, 24, 78)
      SETPOS(23, 1)
      DEVPOS(23, 10)
      DEVOUT("ORDENADO POR : ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WORDPOR", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      DEVPOS(24, 10)
      DEVOUT(SPACE(60))
      MEMVAR->SWZV := 0

      IF VAL(WCODPROV) > 999 .AND. VAL(WCODPROV) < 1199

         MEMVAR->SWZV := 1
         DEVPOS(6, 17)
         DEVOUT("NOMEST    ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNOMEST", NIL, NIL, NIL):DISPLAY())
         DEVPOS(7, 17)
         DEVOUT("NOMPROV   ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNOMPROV", NIL, NIL, NIL):DISPLAY())
         DEVPOS(8, 17)
         DEVOUT("TELEFONO  ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WTEL", NIL, NIL, NIL):DISPLAY())
         DEVPOS(9, 17)
         DEVOUT("DIRECCION ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WDIR", NIL, NIL, NIL):DISPLAY())
         DEVPOS(10, 17)
         DEVOUT("C. PAGO   ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCONPAG", NIL, NIL, NIL):DISPLAY())
         DEVPOS(11, 17)
         DEVOUT("NIT.      ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "XNIT", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         SCROLL(6, 0, 13, 79)
         SETPOS(6, 0)

      ELSE

         DEVPOS(23, 10)
         DEVOUT("Cond.de PAG.  ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCONPAG", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         DEVPOS(23, 10)
         DEVOUT("                                        ")

      ENDIF

      DEVPOS(5, 1)
      DEVOUT("Orden de compra n" + U + "mero " + ALLTRIM(TRANSFORM(;
            NUMORDCI, "999999")))
      SCROLL(6, 17, 12, 78)
      SETPOS(6, 17)
      DEVPOS(6, 17)
      DEVOUT(WNOMEST)
      SETCOLOR("W")
      MEMVAR->WMF := "0"
      DBSELECTAR("1")
      MEMVAR->WNUMFIL := 9
      SET(3, 2)
      DEVPOS(8, 0)
      DEVOUT(;
            "CODIGO INSUMO o articulo              CANTIDAD      VR. UNIT.     VR. TOTAL";
            )
      DEVPOS(9, 0)
      DEVOUT(;
            "------ ------------------------------ ----------    ------------  ------------";
            )
      MEMVAR->SWNUMORD := 0

      DO WHILE WMF = "0"

         MEMVAR->WCODINS := SPACE(4)
         MEMVAR->WNUMOP := SPACE(8)
         MEMVAR->WVALUNI := MEMVAR->WCAN := 0.00
         SCROLL(23, 1, 24, 78)
         SETPOS(23, 1)
         DEVPOS(23, 10)
         DEVOUT("         COD. INSUMO  ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCODINS", NIL, NIL, NIL):DISPLAY())
         SETCOLOR("+G")
         DEVPOS(23, 39)
         DEVOUT("¢ * o ESC para salir")
         SETCOLOR("+W")
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF WCODINS = "*" .OR. LASTKEY() = 27

            MEMVAR->WMF := "1"
            LOOP

         ENDIF

         MEMVAR->WNUMCOLOR := " "

         IF VAL(WCODINS) > 199 .AND. VAL(WCODINS) < 300

            DEVPOS(23, 10)
            DEVOUT("                                              ")
            DEVPOS(23, 10)
            DEVOUT("N£mero del color ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WNUMCOLOR", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            DEVPOS(23, 10)
            DEVOUT("                                              ")

         ENDIF

         AMAINS()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")

         IF VAL(WCODINS) > 199 .AND. VAL(WCODINS) < 300

            __DBLOCATE({||CODIGO = WCODINS .AND. NUMCOLOR = WNUMCOLOR}, ;
                  NIL, NIL, NIL, .F.)

         ELSE

            DBSEEK("&WCODINS")

         ENDIF

         IF EOF()

            DBCLOSEARE()
            SETCOLOR("+GR")
            DEVPOS(23, 35)
            DEVOUT("NO EXISTE ")
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            SETCOLOR("+W")
            DEVPOS(23, 10)
            DEVOUT(SPACE(40))
            LOOP

         ENDIF

         MEMVAR->WSALDOUNI := SALDOUNI
         MEMVAR->WNOMART := NOMBRE
         MEMVAR->WPOS6 := RECNO()
         MEMVAR->WVRUNIT := MEMVAR->WVORI := COSTO1
         MEMVAR->WCOSTO2 := COSTO2
         MEMVAR->WFACTUNI := FACTUNI
         MEMVAR->WUNIPROV := UNIPROV
         DBCLOSEARE()
         MEMVAR->WNUMFIL := MEMVAR->WNUMFIL + 1
         DEVPOS(23, 34)
         DEVOUT("SALDO EN INV.: " + ALLTRIM(TRANSFORM(WSALDOUNI, "999,999");
               ) + "     ")

         IF WNUMFIL > 20

            SCROLL(10, 0, 22, 79)
            MEMVAR->WNUMFIL := ( SETPOS(10, 0), 10 )

         ENDIF

         MEMVAR->MM := " "
         DEVPOS(WNUMFIL, 0)
         DEVOUT(WCODINS)
         DEVPOS(WNUMFIL, 7)
         DEVOUT(SPACE(60))
         DEVPOS(WNUMFIL, 7)
         DEVOUT(LEFT(WNOMART, 30))
         MEMVAR->SWESP := 0

         IF VAL(WCODINS) > 699 .AND. VAL(WCODINS) < 800

            MEMVAR->SWESP := 1
            MEMVAR->WNOMART1 := MEMVAR->WNOMART2 := MEMVAR->WNOMART3 := SPACE(;
                  30)
            SETPOS(WNUMFIL, 7)
            AADD(GETLIST, __GET(NIL, "WNOMART1", NIL, NIL, NIL):DISPLAY())
            SETPOS(WNUMFIL + 1, 7)
            AADD(GETLIST, __GET(NIL, "WNOMART2", NIL, NIL, NIL):DISPLAY())
            SETPOS(WNUMFIL + 2, 7)
            AADD(GETLIST, __GET(NIL, "WNOMART3", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            MEMVAR->WNOMART := WNOMART1 + WNOMART2 + WNOMART3
            MEMVAR->WNUMFIL := MEMVAR->WNUMFIL + 2

         ENDIF

         DEVPOS(23, 55)
         DEVOUT("CANTIDAD ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCAN", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF WCAN = 0

            SCROLL(WNUMFIL, 0, 24, 79)
            MEMVAR->WNUMFIL := ( SETPOS(WNUMFIL, 0), IF(SWESP = 1, WNUMFIL -;
                   2, WNUMFIL - 1) )
            LOOP

         ENDIF

         IF VAL(WCODINS) > 699 .AND. VAL(WCODINS) < 800 .AND. VAL(WCODINS) ;
               <> 764

            MEMVAR->WNUMOP := SPACE(8)
            SCROLL(23, 1, 23, 78)
            SETPOS(23, 1)
            DEVPOS(23, 10)
            DEVOUT("Numero de o.p. del pendiente ? ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WNUMOP", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            AINPES()
            __DBLOCATE({||NUMDOC = WNUMOP .AND. CODIGO = WCODINS .AND. ;
                  UPPER(SUBSTR(WNOMART, 1, 20)) = UPPER(NOMINS)}, NIL, NIL,;
                   NIL, .F.)

            IF EOF()

               DBCLOSEARE()
               SCROLL(20, 1, 23, 78)
               SETPOS(20, 1)
               DEVPOS(21, 10)
               DEVOUT("La o.p. # " + ALLTRIM(WNUMOP) + ;
                     " no tiene pendiente el codigo " + WCODINS)
               DEVPOS(22, 10)
               DEVOUT("Esta orden de compra no se grabara. ")
               MEMVAR->X := INKEY(0)
               MEMVAR->WNUMFIL := WNUMFIL - 2
               SCROLL(WNUMFIL, 1, 23, 78)
               SETPOS(WNUMFIL, 1)
               LOOP

            ENDIF

            MEMVAR->WCANPE := CANTIDAD
            DBCLOSEARE()

            IF WCAN > WCANPE

               SCROLL(20, 1, 23, 78)
               SETPOS(20, 1)
               DEVPOS(21, 10)
               DEVOUT("La cantidad que esta pidiendo " + ALLTRIM(TRANSFORM(;
                     WCAN, "999999")) + " es mayor que la pendiente " + ;
                     ALLTRIM(TRANSFORM(WCANPE, "99999999")) + ",")
               DEVPOS(22, 10)
               DEVOUT("Por favor reconsidere la cantidad. ")
               MEMVAR->X := INKEY(0)
               MEMVAR->WNUMFIL := WNUMFIL - 2
               SCROLL(WNUMFIL, 1, 23, 78)
               SETPOS(WNUMFIL, 1)
               LOOP

            ENDIF

         ENDIF

         DEVPOS(WNUMFIL, 31)
         DEVOUT("             ")
         DEVPOS(WNUMFIL, 38)
         DEVOUTPICT(WCAN, "@# 999,999.99")
         SETPOS(WNUMFIL, 51)
         AADD(GETLIST, __GET(NIL, "WVRUNIT", "@Z 9,999,999.99", NIL, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

         IF WVRUNIT > WVORI .AND. (VAL(WCODINS) < 700 .OR. VAL(WCODINS) > ;
               799)

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
            MEMVAR->OP := " "
            LOOP

         ENDIF

         MEMVAR->WDES := 0

         IF WVRUNIT < WVORI

            MEMVAR->WDES := 100 - WVRUNIT * 100 / WVORI
            MEMVAR->WDES := WDES * -1

         ENDIF

         DEVPOS(WNUMFIL, 51)
         DEVOUT("             ")
         DEVPOS(WNUMFIL, 55)
         DEVOUTPICT(WVRUNIT, "@# 99,999.99")
         MEMVAR->WVALTOT := WCAN * WVRUNIT
         SET(3, 2)
         DEVPOS(WNUMFIL, 66)
         DEVOUTPICT(WVALTOT, "@# 9,999,999.99")
         DEVPOS(23, 1)
         DEVOUT(SPACE(77))
         SETCOLOR("*B/BG")
         DEVPOS(24, 20)
         DEVOUT("POR FAVOR ESPERE . . . ")
         SETCOLOR("+W")
         DBSELECTAR("1")
         __DBLOCATE({||CODINS = WCODINS}, NIL, NIL, NIL, .F.)

         IF EOF() .OR. VAL(WCODINS) > 699 .AND. VAL(WCODINS) < 800 .AND. ;
               WCAN > 0 .OR. VAL(WCODINS) > 199 .AND. VAL(WCODINS) < 300

            DBAPPEND()
            FIELD->NOMEST := WNOMEST
            FIELD->NOMPROV := WNOMPROV
            FIELD->VRUNIT := WVRUNIT
            FIELD->CANPED := WCAN
            FIELD->CANENT := 0
            FIELD->VALTOT := WVRUNIT * WCAN
            FIELD->CODPROV := WCODPROV
            FIELD->CODINS := WCODINS
            FIELD->NUMINS := VAL(WCODINS)
            FIELD->NUMCOLOR := WNUMCOLOR
            FIELD->CONPAG := WCONPAG
            FIELD->DESCUENTO := WDES
            FIELD->FECEMI := WFECORD
            FIELD->DIRECCION := WDIR
            FIELD->TELEFONO := WTEL
            FIELD->NOMART := WNOMART
            FIELD->ORDPOR := WORDPOR
            FIELD->IVA := WVALTOT * FACTOIVA / 100
            FIELD->ORDPROD := WNUMOP
            FIELD->COSTO2 := WCOSTO2
            FIELD->UNIPROV := WUNIPROV
            FIELD->FACTUNI := WFACTUNI

         ELSEIF VAL(WCODINS) > 699 .AND. VAL(WCODINS) < 800 .AND. WCAN < 0

            DBGOTOP()

            DO WHILE  .NOT. EOF()

               IF WCAN = -CANPED .AND. CODINS = WCODINS .AND. VRUNIT = ;
                     WVRUNIT

                  FIELD->CANPED := 0
                  FIELD->VALTOT := 0
                  FIELD->IVA := 0
                  MEMVAR->WCODINS := "    "
                  LOOP

               ENDIF

               DBSKIP(1)

            ENDDO

         ELSE

            FIELD->CANPED := CANPED + WCAN

            IF WCAN > 0

               FIELD->VRUNIT := WVRUNIT

            ELSE

               FIELD->VRUNIT := VRUNIT - WVRUNIT

            ENDIF

            FIELD->VALTOT := VALTOT + WCAN * WVRUNIT
            FIELD->IVA := IVA + WCAN * WVRUNIT * FACTOIVA / 100

         ENDIF

      ENDDO

      MEMVAR->SWNUMORD := 0
      DBSELECTAR("1")
      DBEVAL({||DBDELETE()}, {||CANPED = 0}, NIL, NIL, NIL, .F.)
      __DBPACK()

      IF LASTREC() > 0

         __MRESTORE("&ZDIS\&WDIRECTO\NUMORD", .T.)
         MEMVAR->NUMORDCI := MEMVAR->NUMORDCI + 1
         DBEVAL({||FIELD->ORD := ALLTRIM(TRANSFORM(NUMORDCI, "999999")), ;
               FIELD->NUMORD := NUMORDCI}, NIL, NIL, NIL, NIL, .F.)

         IF FILE("&ZDIS\&WDIRECTO\NUMORD.MEM")

            FERASE("&ZDIS\&WDIRECTO\NUMORD.MEM")

         ENDIF

         __MSAVE("&ZDIS\&WDIRECTO\NUMORD", "NUMORD?I", .T.)

      ENDIF

      DBCLOSEARE()
      AOCE()
      __DBAPP("C:\PROTMP\ORDTEM", {}, {||CANPED > 0}, NIL, NIL, NIL, .F., NIL)
      DBEVAL({||FIELD->CONSE := RECNO()}, NIL, NIL, NIL, NIL, .F.)
      DBCLOSEARE()
      DBSELECTAR("1")
      DBUSEAREA(.F., NIL, "C:\PROTMP\ORDTEM", NIL, NIL, .F.)
      SAP()
      DBCLOSEARE()
      DBSELECTAR("1")
      DBUSEAREA(.F., NIL, "C:\PROTMP\ORDTEM", NIL, NIL, .F.)
      DEVPOS(23, 0)
      DEVOUT("                                                   ")

   ENDDO

   MEMVAR->OPC := " "
   CIERRE()
   DBCLOSEALL()

RETURN 

