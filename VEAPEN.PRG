/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: VEAPEN
   Params: None.
   Return: Undefined
  Example: VEAPEN()
  ..........................................................................
*/

PROCEDURE VEAPEN()

   AINPES()
   MEMVAR->SWP4 := 0
   SET(11, "ON")

   DO WHILE SWP4 = 0

      IF CODIGO <> WCOD

         DBSKIP(1)

         IF EOF()

            MEMVAR->SWP4 := 1
            EXIT

         ENDIF

         LOOP

      ENDIF

      IF CODIGO = WCOD .AND. NUMCOLOR <> WNUMCOL

         DBSKIP(1)

         IF EOF()

            MEMVAR->SWP4 := 1
            EXIT

         ENDIF

         LOOP

      ENDIF

      IF (WCOD = "724" .OR. WCOD = "704" .OR. WCOD = "734" .OR. WCOD = ;
            "754" .OR. WCOD = "774" .OR. WCOD = "784") .AND. (WNOMBRE <> ;
            NOMINS .OR. WNUMORD <> NUMDOC)

         DBSKIP(1)

         IF EOF()

            MEMVAR->SWP4 := 1

         ENDIF

         LOOP

      ENDIF

      MEMVAR->WCANPEN := CANTIDAD
      MEMVAR->WDOC := NUMDOC
      MEMVAR->WNOM := SUBSTR(NOMBRE, 1, 20)
      MEMVAR->WUNI := VALUNI
      MEMVAR->XMOV := TIPOMOV
      MEMVAR->WNOMBRE := NOMBRE
      MEMVAR->WNOMINS := NOMINS
      MEMVAR->WPOS4 := RECNO()
      AMAINS()
      DBGOTO(WPOS2)

      IF SALDOUNI < 0.001

         DBCLOSEARE()
         MEMVAR->SWP4 := 1
         LOOP

      ENDIF

      MEMVAR->WCANMOV := IF(SALDOUNI - WCANPEN < 0, SALDOUNI, WCANPEN)
      MEMVAR->WTOT := ROUND(WCANMOV * WUNI, 2)
      MEMVAR->WCOSUNITA := MEMVAR->WCOSSALEN := 0
      VEAUNITA()
      VEALOCK()
      FIELD->CONMESUNI := CONMESUNI + WCANMOV
      FIELD->CONANOUNI := CONANOUNI + WCANMOV
      FIELD->CONMESPES := CONMESPES + WTOT
      FIELD->CONANOPES := CONANOPES + WTOT
      FIELD->SALDOPES := SALDOPES - WCOSSALEN
      FIELD->SALDOUNI := SALDOUNI - WCANMOV
      FIELD->COSCONMES := COSCONMES + WCOSSALEN
      FIELD->COSCONANO := COSCONANO + WCOSSALEN
      FIELD->ULTMOV := WFECPRO

      IF SALDOPES > -10 .AND. SALDOPES < 1

         FIELD->SALDOPES := 0

      ENDIF

      DBCLOSEARE()
      ADI6P()
      DBSELECTAR("4")
      VEALOCK()
      FIELD->CANTIDAD := CANTIDAD - WCANMOV

      IF CANTIDAD < 0.001

         DBDELETE()

      ENDIF

      DBSKIP(1)

      IF EOF()

         MEMVAR->SWP4 := 1

      ENDIF

   ENDDO

   DBSELECTAR("4")
   DBCLOSEARE()
   SET(11, "OFF")

RETURN 

