/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MODPRTE
   Params: None.
   Return: Undefined
  Example: MODPRTE()
  ..........................................................................
*/

PROCEDURE MODPRTE()

   MEMVAR->OPC := " "
   MEMVAR->WCLAVE := SPACE(8)
   MENU()
   __MRESTORE("DATO", .T.)
   SET(17, "OFF")
   DEVPOS(12, 20)
   DEVOUT("POR FAVOR DEME LA CLAVE DE ACCESO ")
   MEMVAR->WCLAVE := __ACCEPT()
   SET(17, "ON")

   IF ALLTRIM(WCLAVE) <> ALLTRIM(DATO)

      __MRELEASE("DATO?", .T.)
      SETCOLOR("*W/R")
      DEVPOS(18, 20)
      DEVOUT("ACCESO NEGADO, CLAVE INCORRECTA  ")
      SETCOLOR("+W/G")
      DEVPOS(19, 20)
      DEVOUT("OPRIMA ALGUNA TECLA PARA REGRESAR")
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      SETCOLOR("+W")
      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   SCROLL(6, 1, 23, 78)
   SETPOS(6, 1)
   __MRELEASE("DATO?", .T.)
   AMAPAE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
   ORDLISTREB()
   DBCLOSEARE()
   ATAE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\PROTARCO")
   ORDLISTREB()
   DBCLOSEARE()

   DO WHILE OPC <> "*"

      MENU()
      DEVPOS(5, 1)
      DEVOUT(PADC("MODIFICACION DE REFERENCIAS EN MAESTRO", 78))
      MEMVAR->OPC := " "
      MEMVAR->WCOD := ZLCPT
      DEVPOS(13, 20)
      DEVOUT("CODIGO ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WCOD", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      MEMVAR->WCODANT := WCOD
      SCROLL(12, 20, 13, 60)
      SETPOS(12, 20)

      IF WCOD = ZLCPT

         MEMVAR->OPC := "*"
         LOOP

      ENDIF

      AMAPAS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
      DBSEEK("&WCOD")

      IF EOF()

         DBCLOSEARE()
         SETCOLOR("+GR")
         DEVPOS(15, 20)
         DEVOUT("CODIGO NO EXISTE")
         MEMVAR->X := INKEY(0)
         LOOP

      ENDIF

      MEMVAR->WCOD := CODART
      MEMVAR->WNOM := NOMBRE
      MEMVAR->WUNI := UNIDAD
      MEMVAR->WPO1 := PORC1
      MEMVAR->WPO2 := PORC2
      MEMVAR->WPO3 := PORC3
      MEMVAR->WVRLISTA := VRLISTA
      MEMVAR->WPOS1 := RECNO()
      DBCLOSEARE()
      MEMVAR->SWLEE := 1
      MENPRTE()
      SETCOLOR("+BG")
      MEMVAR->OPC := " "
      AMAPAS()
      MEMVAR->CI := 0
      DBEVAL({||MEMVAR->CI := CI + 1}, {||CODART = WCOD}, NIL, NIL, NIL, ;
            .F.)

      IF CI > 1

         DBCLOSEARE()
         SETCOLOR("+R")
         QOUT(CHR(7))
         DEVPOS(22, 10)
         DEVOUT("ESTE CODIGO YA EXISTE")
         MEMVAR->X := INKEY(0)
         LOOP

      ENDIF

      ESPERE()
      DBGOTO(WPOS1)
      VEALOCK()
      FIELD->CODART := WCOD
      FIELD->NUMART := VAL(WCOD)
      FIELD->NOMBRE := WNOM
      FIELD->UNIDAD := UPPER(LTRIM(WUNI))
      FIELD->PORC1 := WPO1
      FIELD->PORC2 := WPO2
      FIELD->PORC3 := WPO3
      FIELD->VRLISTA := WVRLISTA
      ATAE()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\PROTARCO")
      DBEVAL({||FIELD->CODPRO := WCOD, FIELD->NUMPRO := VAL(WCOD)}, {||;
            CODPRO = WCODANT}, NIL, NIL, NIL, .F.)
      DBCLOSEARE()
      ATAE()
      BORPTC()
      DBEVAL({||FIELD->PROTARCOL := TRIM(CODPRO) + TRIM(CODTAR) + "*****"}, ;
            NIL, NIL, NIL, NIL, .F.)
      DBCREATEIN("&ZDIS\&WDIRECTO\PROTARCO", "PROTARCOL", {||PROTARCOL}, ;
            NIL)
      DBCLOSEARE()
      MEMVAR->OPC := " "

   ENDDO

   MEMVAR->OPC := " "
   CIERRE()

RETURN 

