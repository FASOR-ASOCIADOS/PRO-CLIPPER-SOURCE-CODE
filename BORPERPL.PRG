/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: BORPERPL
   Params: None.
   Return: Undefined
  Example: BORPERPL()
  ..........................................................................
*/

PROCEDURE BORPERPL()

   MEMVAR->OPC := " "
   MENU()
   AMAPERE()
   BORPER()
   DBCREATEIN("&ZDIS\&WDIRECTO\COD-PER", "CODIGO", {||CODIGO}, NIL)
   DBCLOSEARE()

   DO WHILE OPC <> "N"

      MENU()
      SETCOLOR("+BG")
      DEVPOS(5, 1)
      DEVOUT(PADC("BORRADO DE OPERARIOS EN MAESTRO", 78))
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
      SETCOLOR("+G")
      MEMVAR->OPC := " "
      DEVPOS(23, 20)
      DEVOUT("ESTA SEGURO DE BORRAR ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "S"

         AMAPERS()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\COD-PER")
         DBGOTO(WPOS7)
         VEALOCK()
         DBDELETE()
         DBCLOSEARE()

      ENDIF

      MEMVAR->OPC := " "

   ENDDO

   MEMVAR->OPC := " "
   AMAPERE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\COD-PER")
   __DBLOCATE({||DELETED()}, NIL, NIL, NIL, .F.)

   IF  .NOT. EOF()

      __DBPACK()

   ENDIF

   ORDLISTREB()
   DBCLOSEARE()

RETURN 

