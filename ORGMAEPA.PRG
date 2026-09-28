/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ORGMAEPA
   Params: None.
   Return: Undefined
  Example: ORGMAEPA()
  ..........................................................................
*/

PROCEDURE ORGMAEPA()

   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->WAB := "BASURA1.DBF"
   BA()
   __DBCOPYST("C:\BASURA", {})
   DBSELECTAR("40")
   DBUSEAREA(.F., NIL, "c:\basura", NIL, NIL, .F.)
   MEMVAR->CC := 1

   DO WHILE CC < 21

      DBSELECTAR("1")
      MEMVAR->XCAMPOINS := "CODINS" + ALLTRIM(TRANSFORM(CC, "99"))
      MEMVAR->XCAMPOCAN := "CAN" + ALLTRIM(TRANSFORM(CC, "99"))
      MEMVAR->XVAR1 := (&(MEMVAR->XCAMPOINS))
      MEMVAR->XVAR2 := (&(MEMVAR->XCAMPOCAN))
      DBSELECTAR("40")
      DBAPPEND()
      FIELD->CODINS1 := XVAR1
      FIELD->CAN1 := XVAR2
      FIELD->CODINS2 := PADL(ALLTRIM(CODINS1), 4, " ")
      MEMVAR->CC := MEMVAR->CC + 1

   ENDDO

   DBSELECTAR("40")
   __DBSORT("c:\basura1", {"codins2"}, {||CODINS1 <> "    "}, NIL, NIL, ;
         NIL, .F.)
   DBCLOSEARE()
   DBSELECTAR("40")
   DBUSEAREA(.F., NIL, "C:\BASURA1", NIL, NIL, .F.)

   DO WHILE  .NOT. EOF()

      DBSELECTAR("40")
      MEMVAR->CC := RECNO()
      MEMVAR->XVAR1 := CODINS1
      MEMVAR->XVAR2 := CAN1
      MEMVAR->XCAMPOINS := "CODINS" + ALLTRIM(TRANSFORM(CC, "99"))
      MEMVAR->XCAMPOCAN := "CAN" + ALLTRIM(TRANSFORM(CC, "99"))
      DBSELECTAR("1")
      VEALOCK()
      FIELD->&(MEMVAR->XCAMPOINS) := XVAR1
      FIELD->&(MEMVAR->XCAMPOCAN) := XVAR2
      DBSELECTAR("40")
      DBSKIP(1)

   ENDDO

   DBSELECTAR("40")
   DBCLOSEARE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->WAB := "BASURA1.DBF"
   BA()

RETURN 

