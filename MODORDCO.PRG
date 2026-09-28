/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MODORDCO
   Params: None.
   Return: Undefined
  Example: MODORDCO()
  ..........................................................................
*/

PROCEDURE MODORDCO()

   MEMVAR->OPC := " "
   AMAPRVE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\COD-PROV")
   ORDLISTREB()
   DBCLOSEARE()
   AMAINE()
   DBCLOSEARE()
   MEMVAR->WFECORD := DATE()
   SET(3, 2)
   MEMVAR->WORDPOR := SPACE(25)
   MENU()
   DEVPOS(6, 25)
   DEVOUT("MODIFICACION DE ORDENES DE COMPRA")

   DO WHILE OPC <> "*"

      SCROLL(7, 1, 23, 78)
      MEMVAR->WNUMORD := ( SETPOS(7, 1), SPACE(7) )
      MEMVAR->WCODINS := SPACE(4)
      MEMVAR->WNUMCOL := " "
      DEVPOS(12, 20)
      DEVOUT("NUMERO DE LA ORDEN ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WNUMORD", NIL, NIL, NIL):DISPLAY())
      DEVPOS(13, 20)
      DEVOUT("CODIGO DEL INSUMO  ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCODINS", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WNUMORD = "   "

         MEMVAR->OPC := "*"
         LOOP

      ENDIF

      IF VAL(WCODINS) > 199 .AND. VAL(WCODINS) < 300

         DEVPOS(14, 20)
         DEVOUT("NUMERO DEL COLOR   ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNUMCOL", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ENDIF

      AOCS()

      IF VAL(WCODINS) > 199 .AND. VAL(WCODINS) < 300

         __DBLOCATE({||ORD = WNUMORD .AND. CODINS = WCODINS .AND. NUMCOLOR ;
               = WNUMCOL}, NIL, NIL, NIL, .F.)

      ELSEIF VAL(WCODINS) > 699 .AND. VAL(WCODINS) < 800

         MEMVAR->WNOMINS := SPACE(30)
         SCROLL(22, 1, 23, 8)
         SETPOS(22, 1)
         DEVPOS(22, 5)
         DEVOUT("Nombre exacto del insumo ? ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNOMINS", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         __DBLOCATE({||ORD = WNUMORD .AND. CODINS = WCODINS .AND. SUBSTR(;
               NOMART, 1, 30) = WNOMINS}, NIL, NIL, NIL, .F.)

      ELSE

         __DBLOCATE({||ORD = WNUMORD .AND. CODINS = WCODINS}, NIL, NIL, ;
               NIL, .F.)

      ENDIF

      IF EOF()

         DBCLOSEARE()
         MEMVAR->OPC := " "

         IF VAL(WCODINS) > 199 .AND. VAL(WCODINS) < 300

            DEVPOS(15, 20)
            DEVOUT("ESA ORDEN CON ESE CODIGO Y COLOR NO EXISTE ")

         ELSE

            DEVPOS(15, 20)
            DEVOUT("ESA ORDEN CON ESE CODIGO NO EXISTE ")

         ENDIF

         MEMVAR->X := INKEY(0)
         SCROLL(15, 1, 23, 78)
         MEMVAR->OPC := ( SETPOS(15, 1), " " )
         LOOP

      ENDIF

      MEMVAR->SWNOES := 0

      IF VAL(WCODINS) < 700 .OR. VAL(WCODINS) > 799

         MEMVAR->WCODPROV := CODPROV
         MEMVAR->WNOMEST := NOMEST
         MEMVAR->WNOMPROV := NOMPROV
         MEMVAR->WDIR := DIRECCION
         MEMVAR->WTEL := TELEFONO
         MEMVAR->WCONPAG := CONPAG
         MEMVAR->WDES := DESCUENTO
         MEMVAR->WNUMCOLOR := NUMCOLOR
         MEMVAR->WCAN := CANPED
         MEMVAR->WVRUNIT := VRUNIT
         MEMVAR->WFECEMI := FECEMI
         MEMVAR->WORDPOR := ORDPOR
         MEMVAR->WNOMART1 := SUBSTR(NOMART, 1, 30)
         MEMVAR->WNOMART2 := SUBSTR(NOMART, 31, 30)
         MEMVAR->WNOMART3 := SUBSTR(NOMART, 61, 30)
         SCROLL(7, 1, 23, 78)
         SETPOS(7, 1)
         DEVPOS(10, 12)
         DEVOUT("A. CODIGO DEL PROVEEDOR       ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCODPROV", NIL, NIL, NIL):DISPLAY())
         DEVPOS(11, 12)
         DEVOUT("B. NOMBRE DEL ESTABLECIMIENTO ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNOMEST", NIL, NIL, NIL):DISPLAY())
         DEVPOS(12, 12)
         DEVOUT("C. NOMBRE DEL CONTACTO        ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNOMPROV", NIL, NIL, NIL):DISPLAY())
         DEVPOS(13, 12)
         DEVOUT("D. DIRECCION                  ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WDIR", NIL, NIL, NIL):DISPLAY())
         DEVPOS(13, 52)
         DEVOUT("E. TELEFONO ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WTEL", NIL, NIL, NIL):DISPLAY())
         DEVPOS(14, 12)
         DEVOUT("F. CONDICIONES DE PAGO        ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCONPAG", NIL, NIL, NIL):DISPLAY())
         DEVPOS(15, 12)
         DEVOUT("G. DESCUENTO                  ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WDES", "@Z 999.99", NIL, NIL):DISPLAY())
         DEVPOS(16, 12)
         DEVOUT("H. CANTIDAD                   ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCAN", "@Z 999,999.99", NIL, NIL);
               :DISPLAY())
         DEVPOS(17, 12)
         DEVOUT("I. VALOR UNITARIO             ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WVRUNIT", "@Z 999,999.99", NIL, NIL);
               :DISPLAY())
         DEVPOS(18, 12)
         DEVOUT("J. FECHA                      ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WFECEMI", NIL, NIL, NIL):DISPLAY())
         DEVPOS(19, 12)
         DEVOUT("K. ORDENADO POR               ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WORDPOR", NIL, NIL, NIL):DISPLAY())
         DEVPOS(20, 12)
         DEVOUT("L. NOMBRE DEL ARTICULO ")
         SETPOS(20, 43)
         AADD(GETLIST, __GET(NIL, "WNOMART1", NIL, NIL, NIL):DISPLAY())
         SETPOS(21, 43)
         AADD(GETLIST, __GET(NIL, "WNOMART2", NIL, NIL, NIL):DISPLAY())
         DEVPOS(22, 43)
         DEVOUT(WNOMART3)
         READKILL(.T.)
         MEMVAR->GETLIST := {}

      ELSE

         MEMVAR->NOES := "N"

         DO WHILE NOES = "N"

            MEMVAR->NOES := " "
            MEMVAR->WCODPROV := CODPROV
            MEMVAR->WNOMEST := NOMEST
            MEMVAR->WNOMPROV := NOMPROV
            MEMVAR->WDIR := DIRECCION
            MEMVAR->WTEL := TELEFONO
            MEMVAR->WCONPAG := CONPAG
            MEMVAR->WDES := DESCUENTO
            MEMVAR->WNUMCOLOR := NUMCOLOR
            MEMVAR->WCAN := CANPED
            MEMVAR->WVRUNIT := VRUNIT
            MEMVAR->WFECEMI := FECEMI
            MEMVAR->WORDPOR := ORDPOR
            MEMVAR->WNOMART1 := SUBSTR(NOMART, 1, 30)
            MEMVAR->WNOMART2 := SUBSTR(NOMART, 31, 30)
            MEMVAR->WNOMART3 := SUBSTR(NOMART, 61, 30)
            SCROLL(7, 1, 23, 78)
            SETPOS(7, 1)
            DEVPOS(10, 12)
            DEVOUT("A. CODIGO DEL PROVEEDOR       ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WCODPROV", NIL, NIL, NIL):DISPLAY())
            DEVPOS(11, 12)
            DEVOUT("B. NOMBRE DEL ESTABLECIMIENTO ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WNOMEST", NIL, NIL, NIL):DISPLAY())
            DEVPOS(12, 12)
            DEVOUT("C. NOMBRE DEL CONTACTO        ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WNOMPROV", NIL, NIL, NIL):DISPLAY())
            DEVPOS(13, 12)
            DEVOUT("D. DIRECCION                  ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WDIR", NIL, NIL, NIL):DISPLAY())
            DEVPOS(13, 52)
            DEVOUT("E. TELEFONO ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WTEL", NIL, NIL, NIL):DISPLAY())
            DEVPOS(14, 12)
            DEVOUT("F. CONDICIONES DE PAGO        ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WCONPAG", NIL, NIL, NIL):DISPLAY())
            DEVPOS(15, 12)
            DEVOUT("G. DESCUENTO                  ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WDES", "@Z 999.99", NIL, NIL);
                  :DISPLAY())
            DEVPOS(16, 12)
            DEVOUT("H. CANTIDAD                   ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WCAN", "@Z 999,999.99", NIL, NIL);
                  :DISPLAY())
            DEVPOS(17, 12)
            DEVOUT("I. VALOR UNITARIO             ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WVRUNIT", "@Z 999,999.99", NIL, NIL);
                  :DISPLAY())
            DEVPOS(18, 12)
            DEVOUT("J. FECHA                      ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WFECEMI", NIL, NIL, NIL):DISPLAY())
            DEVPOS(19, 12)
            DEVOUT("K. ORDENADO POR               ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WORDPOR", NIL, NIL, NIL):DISPLAY())
            DEVPOS(20, 12)
            DEVOUT("L. NOMBRE DEL ARTICULO ")
            SETPOS(20, 43)
            AADD(GETLIST, __GET(NIL, "WNOMART1", NIL, NIL, NIL):DISPLAY())
            SETPOS(21, 43)
            AADD(GETLIST, __GET(NIL, "WNOMART2", NIL, NIL, NIL):DISPLAY())
            SETPOS(22, 43)
            AADD(GETLIST, __GET(NIL, "WNOMART3", NIL, NIL, NIL):DISPLAY())
            READKILL(.T.)
            MEMVAR->GETLIST := {}
            DEVPOS(23, 20)
            DEVOUT("ESTA ES ? S/N ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "NOES", "@!", {||NOES $ "SN"}, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

            IF NOES = "N"

               DBSKIP(1)
               MEMVAR->SWNO := 0

               IF EOF() .OR. ORD <> WNUMORD .OR. CODINS <> WCODINS

                  MEMVAR->SWNO := 1
                  MEMVAR->SWNOES := 1
                  DEVPOS(23, 20)
                  DEVOUT("NO HAY MAS DE ESPECIALES")
                  MEMVAR->X := INKEY(0)
                  MEMVAR->NOES := "S"

               ENDIF

            ENDIF

            MEMVAR->WPOS16 := RECNO()

         ENDDO

      ENDIF

      DBSELECTAR("16")
      MEMVAR->WPOS16 := RECNO()
      DBCLOSEARE()

      IF SWNOES = 1

         MEMVAR->OPC := " "
         DEVPOS(23, 20)
         DEVOUT("                                             ")
         DEVPOS(23, 10)
         DEVOUT("TIENE MAS PARA MODIFICAR ? S/N ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         DEVPOS(23, 10)
         DEVOUT("                                             ")

         IF OPC = "N" .OR. LASTKEY() = 27

            MEMVAR->OPC := "*"

         ENDIF

         LOOP

      ENDIF

      MEMVAR->WMASCAM := " "

      DO WHILE OPC <> "N"

         SETCOLOR("+GR")
         MEMVAR->WCAM := " "
         DEVPOS(23, 20)
         DEVOUT("Digite el campo a modificar ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCAM", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}
         DEVPOS(23, 20)
         DEVOUT("                                  ")

         IF WCAM = "A"

            DEVPOS(10, 12)
            DEVOUT("A. CODIGO DEL PROVEEDOR       ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WCODPROV", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

         ELSEIF WCAM = "B"

            DEVPOS(11, 12)
            DEVOUT("B. NOMBRE DEL ESTABLECIMIENTO ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WNOMEST", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

         ELSEIF WCAM = "C"

            DEVPOS(12, 12)
            DEVOUT("C. NOMBRE DEL CONTACTO        ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WNOMPROV", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

         ELSEIF WCAM = "D"

            DEVPOS(13, 12)
            DEVOUT("D. DIRECCION                  ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WDIR", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

         ELSEIF WCAM = "E"

            DEVPOS(13, 52)
            DEVOUT("E. TELEFONO ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WTEL", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

         ELSEIF WCAM = "F"

            DEVPOS(14, 12)
            DEVOUT("F. CONDICIONES DE PAGO        ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WCONPAG", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

         ELSEIF WCAM = "G"

            DEVPOS(15, 12)
            DEVOUT("G. DESCUENTO                  ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WDES", "@Z 999.99", NIL, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

         ELSEIF WCAM = "H"

            DEVPOS(16, 12)
            DEVOUT("H. CANTIDAD                   ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WCAN", "@Z 999,999.99", NIL, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

         ELSEIF WCAM = "I"

            DEVPOS(17, 12)
            DEVOUT("I. VALOR UNITARIO             ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WVRUNIT", "@Z 999,999.99", NIL, NIL);
                  :DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

            IF VAL(WCODINS) < 700 .OR. VAL(WCODINS) > 799

               AMAINS()
               ORDLISTCLE()
               ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
               DBSEEK("&WCODINS")

               IF WVRUNIT > COSTO1

                  DBCLOSEARE()
                  SCROLL(23, 1, 23, 78)
                  SETPOS(23, 1)
                  DEVPOS(23, 1)
                  DEVOUT(;
                        "NO LE PUEDO RECIBIR ESE VALOR, EXCEDE AL MAESTRO")
                  MEMVAR->X := INKEY(0)
                  SCROLL(23, 1, 23, 78)
                  SETPOS(23, 1)
                  LOOP

               ENDIF

               DBCLOSEARE()

            ENDIF

         ELSEIF WCAM = "J"

            DEVPOS(18, 12)
            DEVOUT("J. FECHA                      ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WFECEMI", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

         ELSEIF WCAM = "K"

            DEVPOS(19, 12)
            DEVOUT("K. ORDENADO POR               ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WORDPOR", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

         ELSEIF WCAM = "L"

            DEVPOS(20, 12)
            DEVOUT("L. NOMBRE DEL ARTICULO ")
            SETPOS(20, 43)
            AADD(GETLIST, __GET(NIL, "WNOMART1", NIL, NIL, NIL):DISPLAY())
            SETPOS(21, 43)
            AADD(GETLIST, __GET(NIL, "WNOMART2", NIL, NIL, NIL):DISPLAY())
            SETPOS(22, 43)
            AADD(GETLIST, __GET(NIL, "WNOMART3", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

         ENDIF

         AMAPRVS()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\COD-PROV")
         DBSEEK("&WCODPROV")

         IF EOF()

            DBCLOSEARE()
            DEVPOS(10, 50)
            DEVOUT("Prov. NO EXISTE")
            MEMVAR->X := INKEY(0)
            DEVPOS(10, 50)
            DEVOUT("                     ")
            LOOP

         ENDIF

         DBCLOSEARE()
         DEVPOS(23, 20)
         DEVOUT("Tiene mas modificaciones ? S/N ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL);
               :DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ENDDO

      __MRESTORE("&ZDIS\&WDIRECTO\FACTOIVA", .T.)
      SETCOLOR("+W")
      AOCS()
      DBGOTO(WPOS16)
      VEALOCK()
      FIELD->NOMEST := WNOMEST
      FIELD->NOMPROV := WNOMPROV
      FIELD->VRUNIT := WVRUNIT
      FIELD->CANPED := WCAN
      FIELD->VALTOT := WVRUNIT * WCAN
      FIELD->CODPROV := WCODPROV
      FIELD->CODINS := WCODINS
      FIELD->NUMINS := VAL(WCODINS)
      FIELD->NUMCOLOR := WNUMCOLOR
      FIELD->CONPAG := WCONPAG
      FIELD->FECEMI := WFECORD
      FIELD->DIRECCION := WDIR
      FIELD->TELEFONO := WTEL
      FIELD->NOMART := WNOMART1 + WNOMART2 + WNOMART3
      FIELD->ORDPOR := WORDPOR
      FIELD->NUMORD := VAL(WNUMORD)
      FIELD->IVA := VALTOT * FACTOIVA / 100
      FIELD->CODUSU := WCODUSU
      FIELD->HORA := TIME()
      DBCLOSEARE()
      MEMVAR->OPC := " "
      SCROLL(7, 1, 23, 78)
      SETPOS(7, 1)
      DEVPOS(12, 20)
      DEVOUT("TIENE MAS ORDENES PARA ARREGLAR ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "N"

         MEMVAR->OPC := "*"

      ENDIF

   ENDDO

   CIERRE()
   MEMVAR->OPC := " "

RETURN 

