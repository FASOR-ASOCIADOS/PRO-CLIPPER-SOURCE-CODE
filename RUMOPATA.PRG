/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: RUMOPATA
   Params: None.
   Return: Undefined
  Example: RUMOPATA()
  ..........................................................................
*/

PROCEDURE RUMOPATA()

   MEMVAR->TC := " "
   MEMVAR->SWCANCE := 0

   DO WHILE TC <> "S"

      SETCOLOR("+W")
      DEVPOS(23, 20)
      DEVOUT("ESTA TODO CORRECTO ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "TC", "@!", {||TC $ "SNX "}, NIL):DISPLAY())
      SETCOLOR("*+G")
      DEVPOS(23, 58)
      DEVOUT("X=cancela registro")
      SETCOLOR("+W")
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF TC = " " .OR. TC = "X" .OR. LASTKEY() = 27

         IF TC = "X"

            MEMVAR->SWCANCE := 1
            RETURN 

         ENDIF

         MEMVAR->TC := "S"

      ENDIF

      DEVPOS(23, 20)
      DEVOUT("                               ")

      IF WOPE = "  "

         MEMVAR->TC := "S"
         LOOP

      ENDIF

      DEVPOS(23, 20)
      DEVOUT("                           ")
      MEMVAR->KEY := TRIM(WCODPRO) + TRIM(WCODTAR)
      MEMVAR->KEY := KEY + REPLICATE("*", 7 - LEN(KEY))
      ATAS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\PROTARCO")
      DBSEEK("&KEY")

      IF EOF()

         DBCLOSEARE()
         SETCOLOR("+GR/R")
         DEVPOS(23, 20)
         DEVOUT("ESE PRODUCTO CON ESA TAREA NO EXISTE")
         MEMVAR->X := INKEY(0)
         SETCOLOR("+W")
         DEVPOS(23, 20)
         DEVOUT("                                       ")
         MEMVAR->TC := "N"

      ELSE

         MEMVAR->WUNIDAD := UNIDADESH

      ENDIF

      DBCLOSEARE()
      AMAPERS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\COD-PER")
      DBSEEK("&WOPE")

      IF EOF()

         DBCLOSEARE()
         SETCOLOR("+GR/R")
         DEVPOS(23, 20)
         DEVOUT("OPERARIO NO EXISTE")
         MEMVAR->X := INKEY(0)
         SETCOLOR("+W")
         DEVPOS(23, 20)
         DEVOUT("                       ")
         MEMVAR->TC := "N"

      ENDIF

      DBCLOSEARE()
      MEMVAR->WWTOT := WBUENAS + WMALAS + WPRUEBAS
      MEMVAR->WWCON := WCONFIN - WCONINI

      IF WCONINI <> 0 .AND. WCONFIN <> 0 .AND. WWTOT <> WWCON

         SETCOLOR("+GR/R")
         DEVPOS(23, 20)
         DEVOUT("LAS UNIDADES NO CUADRAN")
         MEMVAR->X := INKEY(0)
         SETCOLOR("+W")
         DEVPOS(23, 20)
         DEVOUT("                           ")
         MEMVAR->TC := "N"

      ENDIF

      IF TC = "S"

         LOOP

      ENDIF

      SETCOLOR("+GR")
      MEMVAR->WNUMCAM := " "
      DEVPOS(23, 10)
      DEVOUT("C¢digo del campo a modificar,ESC para cancelar grabacion ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WNUMCAM", "@!", NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF LASTKEY() = 27

         RETURN 

      ENDIF

      DEVPOS(23, 20)
      DEVOUT("                                 ")

      IF WNUMCAM = "A"

         IF SWFF = 0

            DEVPOS(10, 15)
            DEVOUT("A. FECHA         ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WFECHA", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}

         ENDIF

      ELSEIF WNUMCAM = "B"

         DEVPOS(11, 15)
         DEVOUT("B. COD. OPERARIO ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WOPE", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WNUMCAM = "C"

         DEVPOS(12, 15)
         DEVOUT("C. NUMERO DE O.P.")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNUMORD", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WNUMCAM = "D" .AND. SWMOD = 0

         DEVPOS(13, 15)
         DEVOUT("D. COD. DE P.T.  ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCODPRO", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WNUMCAM = "E" .AND. SWMOD = 0

         DEVPOS(14, 15)
         DEVOUT("E. COD. DE LABOR ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCODTAR", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WNUMCAM = "F" .AND. SWMOD = 0

         DEVPOS(15, 15)
         DEVOUT("F. MINUTOS       ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WMINUTOS", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WNUMCAM = "G" .AND. SWMOD = 0

         DEVPOS(16, 15)
         DEVOUT("G. BUENAS        ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WBUENAS", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WNUMCAM = "H" .AND. SWMOD = 0

         DEVPOS(17, 15)
         DEVOUT("H. MALAS         ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WMALAS", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WNUMCAM = "I" .AND. SWMOD = 0

         DEVPOS(18, 15)
         DEVOUT("I. PRUEBAS       ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WPRUEBAS", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WNUMCAM = "J" .AND. SWMOD = 0

         DEVPOS(19, 15)
         DEVOUT("K. C/INICIAL     ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCONINI", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WNUMCAM = "K" .AND. SWMOD = 0

         DEVPOS(20, 15)
         DEVOUT("L. C/FINAL       ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCONFIN", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WNUMCAM = "M" .AND. SWMOD = 0 .AND. VAL(WCODPRO) > 5999 .AND. ;
            VAL(WCODPRO) < 7000

         DEVPOS(22, 15)
         DEVOUT("M. PROM. HORA    ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WPROM", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ENDIF

      MEMVAR->TC := " "
      MEMVAR->WCODTAR := UPPER(WCODTAR)

      IF (SUBSTR(WCODTAR, 1, 1) = "S" .OR. SUBSTR(WCODTAR, 1, 1) = "Z") ;
            .AND. (WCONINI = 0 .OR. WCONFIN = 0)

         SETCOLOR("+W")
         DEVPOS(23, 10)
         DEVOUT("ESTA TAREA REQUIERE LOS CONTADORES")
         MEMVAR->X := INKEY(0)
         SCROLL(23, 1, 23, 78)
         MEMVAR->OPC := MEMVAR->TC := ( SETPOS(23, 1), " " )

      ENDIF

   ENDDO


RETURN 

