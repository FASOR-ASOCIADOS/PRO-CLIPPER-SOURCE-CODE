/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: RUTPIDIN
   Params: None.
   Return: Undefined
  Example: RUTPIDIN()
  ..........................................................................
*/

PROCEDURE RUTPIDIN()

   MEMVAR->SWCOLOR := MEMVAR->SWCOLOR2 := 0
   MEMVAR->WNOMINS := SPACE(20)
   MEMVAR->WINSCOL := MEMVAR->WINSCOL2 := "    "
   MEMVAR->CINS := 1

   DO WHILE CINS < 21

      AMAPAS()
      ORDLISTCLE()
      ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
      DBSEEK("&WCODASI")
      MEMVAR->WWCODINS := "CODINS" + ALLTRIM(TRANSFORM(CINS, "99"))
      MEMVAR->WCAN := "CAN" + ALLTRIM(TRANSFORM(CINS, "99"))

      IF VAL((&(MEMVAR->WWCODINS))) > 199 .AND. VAL((&(MEMVAR->WWCODINS))) < ;
            300

         IF SWCOLOR = 0

            MEMVAR->SWCOLOR := 1
            MEMVAR->WINSCOL := (&(MEMVAR->WWCODINS))
            MEMVAR->WCANINSCO := (&(MEMVAR->WCAN))

         ELSE

            MEMVAR->SWCOLOR2 := 1
            MEMVAR->WINSCOL2 := (&(MEMVAR->WWCODINS))
            MEMVAR->WCANINSCO2 := (&(MEMVAR->WCAN))

         ENDIF

         DBCLOSEARE()

      ELSE

         MEMVAR->WCODINS := (&(MEMVAR->WWCODINS))
         MEMVAR->WCANINS := WCANT * (&(MEMVAR->WCAN))
         DBCLOSEARE()

         IF WCODINS <> "  "

            AMAINS()
            ORDLISTCLE()
            ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
            DBSEEK("&WCODINS")
            MEMVAR->WNOMINS := NOMFASOR
            MEMVAR->WVUNI := 0
            VESAUN()
            DBCLOSEARE()
            MEMVAR->WVUNI := WVUNI + ROUND(WVUNI * ZPORCOS / 100, 2)
            SCROLL(15, 5, 19, 75)
            SETPOS(15, 5)
            SETCOLOR("+GR")
            DISPBOX(15, 5, 19, 75, 1)
            SETCOLOR("+W")
            DEVPOS(16, 10)
            DEVOUT("INSUMO " + WCODINS + SUBSTR(WNOMINS, 1, 20))
            DEVPOS(17, 10)
            DEVOUT("CANTIDAD TOTAL     ")
            MEMVAR->WCANRETAL := ( SETPOS(ROW(), COL()), AADD(GETLIST, ;
                  __GET(NIL, "WCANINS", NIL, NIL, NIL):DISPLAY()), 0 )
            DEVPOS(18, 10)
            DEVOUT("CANTIDAD DE RETAL ")
            SETPOSBS()
            AADD(GETLIST, __GET(NIL, "WCANRETAL", NIL, NIL, NIL):DISPLAY())
            READMODAL(GETLIST)
            MEMVAR->GETLIST := {}
            AOPTES()
            DBAPPEND()
            FIELD->CODPRO := WCODPRO
            FIELD->NUMCOLOR := " "
            FIELD->CANORD := WCANT
            FIELD->CANPED := WCANPED
            FIELD->CANTOT := WCANT
            FIELD->CODINS := WCODINS
            FIELD->NUMINS := VAL(WCODINS)
            FIELD->CANINS := WCANINS
            FIELD->CANINV := WCANINS - WCANRETAL
            FIELD->CANRETAL := WCANRETAL
            FIELD->VALUNI := WVUNI
            FIELD->VALTOT := ROUND(CANINV * WVUNI, 2)
            FIELD->NUMORD := WNUMORDP
            FIELD->NOMBREPT := WNOMBRE
            FIELD->NOMINS := WNOMINS
            FIELD->SURTIDO := " "
            FIELD->UNIDAD := WUNIDAD
            FIELD->FECHA := WDATE
            FIELD->NOMCLI := WNOMCLI
            FIELD->CODCLI := WCODCLI
            FIELD->COSDIR := WCOSDIR
            FIELD->PREVEN := WPREVEN
            FIELD->CODUSU := WCODUSU
            FIELD->HORA := TIME()
            DBCLOSEARE()

         ENDIF

      ENDIF

      MEMVAR->CINS := MEMVAR->CINS + 1

   ENDDO


RETURN 

