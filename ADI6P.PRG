/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ADI6P
   Params: None.
   Return: Undefined
  Example: ADI6P()
  ..........................................................................
*/

PROCEDURE ADI6P()

   AMVPRSS()
   DBAPPEND()
   FIELD->CODNUM := WCODNUM
   FIELD->CODIGO := WCOD
   FIELD->NUMCOLOR := WNUMCOL
   FIELD->TIPOMOV := XMOV
   FIELD->NUMDOC := WDOC
   FIELD->FECHA := WFECPRO
   FIELD->CANTIDAD := WCANMOV
   FIELD->VALUNI := WCOSUNITA
   FIELD->VALTOT := WCOSSALEN
   FIELD->NOMBRE := WNOMBRE
   FIELD->NOMINS := WNOMBRE
   FIELD->NUMORDPR := ZNUMORD
   FIELD->NUMORDPRO := WNUMORD
   FIELD->CODUSU := WCODUSU
   FIELD->HORA := TIME()

   IF SW6 = 1

      FIELD->NUMDOC := WNUMDOC
      FIELD->CANTIDAD := WCT7
      FIELD->VALUNI := WVALUNI
      FIELD->VALTOT := WVALTOT
      FIELD->COSPRO := WCOSUNITA

   ENDIF

   IF WTIPMOV = "3 "

      FIELD->TIPOMOV := "7 "

   ENDIF

   IF WTIPMOV = "2 "

      FIELD->TIPOMOV := "8 "

   ENDIF

   DBCLOSEARE()

RETURN 

