/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: RESMATPR
   Params: None.
   Return: Undefined
  Example: RESMATPR()
  ..........................................................................
*/

PROCEDURE RESMATPR()

   MEMVAR->OPC := " "
   MENU()
   DEVPOS(12, 20)
   DEVOUT("Ahora se imprimir" + A + " el res" + U + "men de materia")
   DEVPOS(13, 20)
   DEVOUT("prima para entregar en la bodega.")
   DEVPOS(15, 20)
   DEVOUT("desea continuar ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC = "N" .OR. LASTKEY() = 27

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   ESPERE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   AOPTES()

   IF LASTREC() > 1

      __DBSORT("C:\PROTMP\BASURA", {"NUMINS", "NUMCOLOR"}, NIL, NIL, NIL, NIL, ;
            .F.)

   ELSE

      __DBCOPY("C:\PROTMP\BASURA", {}, NIL, NIL, NIL, NIL, .F., NIL)

   ENDIF

   DBCLOSEARE()
   DBSELECTAR("1")
   DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)
   MEMVAR->WDESDE := 999999
   MEMVAR->WHASTA := 0

   DO WHILE  .NOT. EOF()

      IF NUMORD < WDESDE

         MEMVAR->WDESDE := NUMORD

      ENDIF

      IF NUMORD > WHASTA

         MEMVAR->WHASTA := NUMORD

      ENDIF

      DBSKIP(1)

   ENDDO

   DBGOTOP()
   AMAINER()
   DBCLOSEARE()
   DBSELECTAR("1")
   SCROLL(15, 1, 16, 78)
   MEMVAR->CP := MEMVAR->CL := ( SETPOS(15, 1), 0 )
   MEMVAR->RAYA := REPLICATE("Ä", 80)
   MEMVAR->RAYITA := REPLICATE("Ä", 40)
   SETCOLOR("+W")
   DEVPOS(15, 10)
   DEVOUT("OPRIMA ALGUNA TECLA PARA INICIAR ")
   MEMVAR->X := INKEY(0)
   DEVPOS(15, 10)
   DEVOUT("                                   ")
   DEVPOS(15, 20)
   DEVOUT(" **  IMPRIMIENDO ** ")
   VEAIMP()
   ENIM()

   DO WHILE  .NOT. EOF()

      DBSELECTAR("1")

      IF CL = 0

         MEMVAR->CP := MEMVAR->CP + 1
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 30)
         DEVOUT(RAZON)
         MEMVAR->CL := MEMVAR->CL + 2
         DEVPOS(CL, 20)
         DEVOUT("RELACION DE MERCANCIA A ENTREGAR PARA PRODUCCION")
         MEMVAR->CL := MEMVAR->CL + 2
         DEVPOS(CL, 1)
         DEVOUT("Nro_____ FECHA DE ENTREGA : ")
         DEVPOS(CL, PCOL())
         DEVOUT(DATE())
         DEVPOS(CL, PCOL())
         DEVOUT("  MATERIAL DE LAS O.P. Nrs." + ALLTRIM(TRANSFORM(WDESDE, ;
               "999999")) + " Al " + ALLTRIM(TRANSFORM(WHASTA, "999999")))
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 0)
         DEVOUT(RAYA)
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 1)
         DEVOUT(;
               "COD   NOMBRE               CANTIDAD   ENTREGADO   SALDO   ENTREGADO   SALDO";
               )
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 0)
         DEVOUT(RAYA)
         MEMVAR->CL := MEMVAR->CL + 1

      ENDIF

      MEMVAR->WCOD := CODINS
      MEMVAR->WCOLO := NUMCOLOR
      MEMVAR->WNOMCOL := COLOR
      SET(3, 5)
      MEMVAR->WCAN := 0

      IF VAL(WCOD) = 754

         MEMVAR->WNOM := NOMINS

         DO WHILE NOMINS = WNOM

            MEMVAR->WCAN := WCAN + CANINV
            DBSKIP(1)

         ENDDO

      ELSE

         DO WHILE CODINS = WCOD .AND. NUMCOLOR = WCOLO

            MEMVAR->WCAN := WCAN + CANINV
            DBSKIP(1)

         ENDDO

         AMAINS()
         __DBLOCATE({||CODIGO = WCOD .AND. NUMCOLOR = WCOLO}, NIL, NIL, ;
               NIL, .F.)
         MEMVAR->WNOM := NOMFASOR
         DBCLOSEARE()

      ENDIF

      DBSELECTAR("1")
      DEVPOS(CL, 1)
      DEVOUT(WCOD + " " + WNOM)
      DEVPOS(CL, 27)
      DEVOUTPICT(WCAN, "@# 999,999.99")
      DEVPOS(CL, 40)
      DEVOUT(RAYITA)
      DEVPOS(CL, 49)
      DEVOUT("Å")
      DEVPOS(CL, 57)
      DEVOUT("Å")
      DEVPOS(CL, 69)
      DEVOUT("Å")
      DEVPOS(CL, 80)
      DEVOUT(SUBSTR(WNOMCOL, 1, 4))
      SET(3, 2)
      MEMVAR->CL := MEMVAR->CL + 1

      IF CL > 55

         DEVPOS(CL, 0)
         DEVOUT(RAYA)
         MEMVAR->CL := 0

      ENDIF

   ENDDO

   DEVPOS(CL + 1, 0)
   DEVOUT(RAYA)
   DEVPOS(1, 1)
   DEVOUT(" ")
   APIM()
   CIERRE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->OPC := " "

RETURN 

