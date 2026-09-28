/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LISGENDI
   Params: None.
   Return: Undefined
  Example: LISGENDI()
  ..........................................................................
*/

PROCEDURE LISGENDI()

   MENU()
   DEVPOS(4, 27)
   DEVOUT("<<  MANEJO  DE  TAREAS  >>")
   MEMVAR->OPC := " "
   ESPERE()
   DBCLOSEALL()
   AMAPERE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\COD-PER")
   ORDLISTREB()
   DBCLOSEARE()
   APAMOS()
   MEMVAR->WAB := "BASURA.DBF"
   BA()

   IF LASTREC() < 2

      __DBCOPY("C:\BASURA", {}, NIL, NIL, NIL, NIL, .F., NIL)

   ELSE

      __DBSORT("C:\BASURA", {"CODOPE"}, NIL, NIL, NIL, NIL, .F.)

   ENDIF

   DBCLOSEARE()
   DBSELECTAR("9")
   DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
   DBGOTOP()
   MEMVAR->WFECHA := FECHA
   MEMVAR->WDIA := ""
   MEMVAR->WMESL := ""
   FECHA()
   SETCOLOR("+W")
   MEMVAR->CL := MEMVAR->CP := MEMVAR->SWL := 0

   DO WHILE  .NOT. EOF()

      IF CL = 0

         SCROLL()
         SETPOS(0, 0)
         READKILL(.T.)
         MEMVAR->GETLIST := {}
         MEMVAR->CP := MEMVAR->CP + 1
         DEVPOS(CL, 1)
         DEVOUT(PADC(RAZON, 78))
         DEVPOS(CL, 1)
         DEVOUT(PADR("Pagina " + ALLTRIM(TRANSFORM(CP, "99")), 78))
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 1)
         DEVOUT(PADC("RESUMEN DIARIO DE TRABAJOS DEL " + WDIA, 78))
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 1)
         DEVOUT(;
               "CODIGO        NOMBRE                                              TIEMPO";
               )
         MEMVAR->CL := MEMVAR->CL + 1

      ENDIF

      MEMVAR->WCODOPE := CODOPE
      MEMVAR->WTOTPAG := MEMVAR->WTOTMIN := 0
      AMAPERS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\COD-PER")
      DBSEEK("&WCODOPE")

      IF EOF()

         MEMVAR->WNOM := " NOMBRE NO"
         MEMVAR->WAPE := "ENCONTRADO"

      ELSE

         MEMVAR->WNOM := TRIM(NOM)
         MEMVAR->WAPE := TRIM(APE)

      ENDIF

      DBCLOSEARE()
      MEMVAR->WMIN := 0
      DEVPOS(CL, 1)
      DEVOUT(WCODOPE)
      DEVPOS(CL, 7)
      DEVOUT(WNOM + " " + WAPE)

      IF SWL = 0

         MEMVAR->WL := REPLICATE(".", 41 - (LEN(WNOM) + LEN(WAPE)) + 24)
         MEMVAR->SWL := 1
         DEVPOS(ROW(), COL())
         DEVOUT(WL)

      ELSE

         MEMVAR->SWL := 0

      ENDIF

      DBSELECTAR("9")

      DO WHILE CODOPE = WCODOPE

         MEMVAR->WMIN := WMIN + MINUTOS
         DBSKIP(1)

         IF EOF()

            MEMVAR->WCODOPE := "$%"

         ENDIF

      ENDDO

      DEVPOS(CL, 70)
      DEVOUTPICT(WMIN, "@# 99,999")
      MEMVAR->CL := MEMVAR->CL + 1

      IF CL = 22

         MEMVAR->CL := 0
         SETCOLOR("+GR")
         DEVPOS(23, 20)
         DEVOUT("Lea y oprima alguna tecla para continuar ")
         MEMVAR->X := INKEY(0)
         SCROLL()
         SETPOS(0, 0)
         READKILL(.T.)
         MEMVAR->GETLIST := {}
         SETCOLOR("+W")

      ENDIF

   ENDDO

   DEVPOS(23, 20)
   DEVOUT("Lea y oprima alguna tecla para continuar ")
   MEMVAR->X := INKEY(0)
   SCROLL()
   SETPOS(0, 0)
   READKILL(.T.)
   MEMVAR->GETLIST := {}
   CIERRE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->OPC := " "

RETURN 

