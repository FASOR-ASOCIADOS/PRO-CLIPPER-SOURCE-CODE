/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MODPERPL
   Params: None.
   Return: Undefined
  Example: MODPERPL()
  ..........................................................................
*/

PROCEDURE MODPERPL()

   MEMVAR->OPC := " "
   MENU()
   AMAPERE()
   BORPER()
   DBCREATEIN("&ZDIS\&WDIRECTO\COD-PER", "CODIGO", {||CODIGO}, NIL)
   DBCLOSEARE()

   DO WHILE OPC <> "N"

      MENU()
      SETCOLOR("BR")
      DEVPOS(5, 1)
      DEVOUT(PADC("MODIFICACION DE OPERARIOS EN MAESTRO", 78))
      SETCOLOR("+W")
      MEMVAR->OPC := " "
      MEMVAR->WCOD := SPACE(2)
      DEVPOS(12, 20)
      DEVOUT("Por favor deme el codigo ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCOD", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      DEVPOS(12, 20)
      DEVOUT("                                 ")

      IF WCOD = "  " .OR. LASTKEY() = 27

         MEMVAR->OPC := "N"
         LOOP

      ENDIF

      AMAPERS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\COD-PER")
      DBSEEK("&WCOD")

      IF EOF()

         DBCLOSEARE()
         SETCOLOR("R")
         QOUT(CHR(7))
         SCROLL(23, 5, 23, 78)
         SETPOS(23, 5)
         DEVPOS(23, 10)
         DEVOUT("ESTE CODIGO NO EXISTE")
         MEMVAR->X := INKEY(0)
         LOOP

      ENDIF

      MEMVAR->WZON := ZONA
      MEMVAR->WNOM := NOM
      MEMVAR->WAPE := APE
      MEMVAR->WDIR := DIRECCION
      MEMVAR->WTE1 := TELEFONO_1
      MEMVAR->WTE2 := TELEFONO_2
      MEMVAR->WCC := CC
      MEMVAR->WFECING := FECING
      MEMVAR->WPUNTOS := PUNTOS
      MEMVAR->WPOS7 := RECNO()
      DBCLOSEARE()
      MEMVAR->SWLEE := 0
      MENPERPL()
      MEMVAR->OPC := " "
      RUTMODPL()

      IF WCOD = "   " .OR. LASTKEY() = 27

         MEMVAR->OPC := "N"
         LOOP

      ENDIF

      AMAPERS()
      __DBLOCATE({||CODIGO = WCOD .AND. RECNO() <> WPOS7}, NIL, NIL, NIL, ;
            .F.)

      IF  .NOT. EOF()

         DBCLOSEARE()
         SETCOLOR("R")
         QOUT(CHR(7))
         SCROLL(23, 5, 23, 78)
         SETPOS(23, 5)
         DEVPOS(23, 10)
         DEVOUT("ESTE CODIGO YA EXISTE")
         MEMVAR->X := INKEY(0)
         LOOP

      ENDIF

      DBGOTO(WPOS7)
      VEALOCK()
      FIELD->CODIGO := WCOD
      FIELD->CODOPE := VAL(WCOD)
      FIELD->ZONA := WZON
      FIELD->NOM := WNOM
      FIELD->APE := WAPE
      FIELD->DIRECCION := WDIR
      FIELD->TELEFONO_1 := WTE1
      FIELD->TELEFONO_2 := WTE2
      FIELD->CC := WCC
      FIELD->FECING := WFECING
      FIELD->PUNTOS := WPUNTOS
      DBCLOSEARE()
      MEMVAR->OPC := " "

   ENDDO

   MEMVAR->OPC := " "
   MENU()
   SETCOLOR("BR")
   DEVPOS(5, 22)
   DEVOUT("MODIFICACION DE OPERARIOS EN MAESTRO")
   ESPERE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   AMAPERS()
   __DBSORT("C:\BASURA", {"CODOPE"}, NIL, NIL, NIL, NIL, .F.)
   DBCLOSEARE()
   FERASE("&ZDIS\&WDIRECTO\MAEPERPL.DBF")
   BORPER()
   DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
   __DBCOPY("&ZDIS\&WDIRECTO\MAEPERPL.DBF", {}, NIL, NIL, NIL, NIL, .F., ;
         NIL)
   DBCLOSEARE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   AMAPERE()
   DBCREATEIN("&ZDIS\&WDIRECTO\COD-PER", "CODIGO", {||CODIGO}, NIL)
   DBCLOSEARE()
   SET(33, "OFF")
   SET(31, "ON")

RETURN 

