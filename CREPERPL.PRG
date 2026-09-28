/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: CREPERPL
   Params: None.
   Return: Undefined
  Example: CREPERPL()
  ..........................................................................
*/

PROCEDURE CREPERPL()

   MEMVAR->OPC := " "
   AMAPERE()
   BORPER()
   DBCREATEIN("&ZDIS\&WDIRECTO\COD-PER", "CODIGO", {||CODIGO}, NIL)
   DBCLOSEARE()

   DO WHILE OPC <> "N"

      MENU()
      SETCOLOR("+GR")
      DEVPOS(5, 1)
      DEVOUT(PADC("CREACION DE OPERARIOS EN MAESTRO", 78))
      SETCOLOR("+W")
      MEMVAR->WPUNTOS := 0
      MEMVAR->OPC := MEMVAR->WZON := " "
      MEMVAR->WCOD := SPACE(2)
      MEMVAR->WTE1 := SPACE(7)
      MEMVAR->WTE2 := SPACE(15)
      MEMVAR->WCC := SPACE(11)
      MEMVAR->WNOM := MEMVAR->WAPE := SPACE(20)
      MEMVAR->WDIR := SPACE(30)
      MEMVAR->WFECING := DATE()
      MEMVAR->SWLEE := 1
      MENPERPL()

      IF WCOD = "  "

         MEMVAR->OPC := "N"
         LOOP

      ENDIF

      SETCOLOR("+G")
      MEMVAR->OPC := " "
      DEVPOS(23, 20)
      DEVOUT("ESTA TODO CORRECTO ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "N"

         RUTMODPL()

      ENDIF

      IF WCOD = "  "

         MEMVAR->OPC := "N"
         LOOP

      ENDIF

      AMAPERE()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\COD-PER")
      DBSEEK("&WCOD")

      IF  .NOT. EOF()

         DBCLOSEARE()
         SETCOLOR("+GR")
         QOUT(CHR(7))
         SCROLL(23, 5, 23, 78)
         SETPOS(23, 5)
         DEVPOS(23, 10)
         DEVOUT("ESTE CODIGO YA EXISTE")
         MEMVAR->X := INKEY(0)
         LOOP

      ENDIF

      DBAPPEND()
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

   ENDDO

   MEMVAR->OPC := " "
   MENU()
   SETCOLOR("BR")
   DEVPOS(5, 25)
   DEVOUT("CREACION DE OPERARIOS EN MAESTRO")
   ESPERE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   AMAPERS()
   __DBSORT("C:\BASURA", {"CODOPE"}, NIL, NIL, NIL, NIL, .F.)
   DBCLOSEARE()
   BORPER()
   DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
   __DBCOPY("&ZDIS\&WDIRECTO\MAEPERPL.DBF", {}, NIL, NIL, NIL, NIL, .F., ;
         NIL)
   DBCLOSEARE()
   AMAPERE()
   DBCREATEIN("&ZDIS\&WDIRECTO\COD-PER", "CODIGO", {||CODIGO}, NIL)
   DBCLOSEARE()
   SETCOLOR("+W")
   SET(33, "OFF")
   SET(31, "ON")

RETURN 

