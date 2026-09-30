/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LISRESIN
   Params: None.
   Return: Undefined
  Example: LISRESIN()
  ..........................................................................
*/

PROCEDURE LISRESIN()

   MEMVAR->OPC := " "
   MENU()
   DEVPOS(12, 20)
   DEVOUT("Por medio de esta opci¢n se obtiene un listado ")
   DEVPOS(13, 20)
   DEVOUT("resumido del maestro de insumos")
   DEVPOS(15, 20)
   DEVOUT("Desea continuar ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   SCROLL(6, 1, 23, 78)
   SETPOS(6, 1)

   IF OPC = "N"

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   ESPERE()
   AMAINS()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   __DBSORT("C:\PROTMP\BASURA", {"CODNUM", "NUMCOLOR"}, NIL, NIL, NIL, NIL, .F.)
   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)
   __RUN("MODE LPT1:132,8")
   MENU()
   VEAIMP()
   ENIM()
   MEMVAR->CP := MEMVAR->CL := MEMVAR->CI := 0
   MEMVAR->RAYA := REPLICATE("Ä", 132)
   MEMVAR->PC := 1
   MEMVAR->SC := 6
   MEMVAR->TC := 27
   MEMVAR->CC := 29

   DO WHILE  .NOT. EOF()

      IF CL = 0

         MEMVAR->CP := MEMVAR->CP + 1
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 50)
         DEVOUT("Ž" + RAZON)
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 60)
         DEVOUT("RESUMEN DE INSUMOS")
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 0)
         DEVOUT(RAYA)
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 0)
         DEVOUT(;
               "COD. PRODUCTO             COLOR            COD. PRODUCTO             COLOR          COD. PRODUCTO             COLOR ";
               )
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 0)
         DEVOUT(RAYA)
         MEMVAR->CL := MEMVAR->CL + 1

      ENDIF

      IF CI = 3

         MEMVAR->PC := 1
         MEMVAR->SC := 6
         MEMVAR->TC := 27
         MEMVAR->CC := 29
         MEMVAR->CI := 0
         MEMVAR->CL := MEMVAR->CL + 1

      ENDIF

      MEMVAR->CI := MEMVAR->CI + 1
      DEVPOS(CL, PC)
      DEVOUT(CODIGO)
      DEVPOS(CL, SC)
      DEVOUT(NOMFASOR)
      DEVPOS(CL, TC)
      DEVOUT(NUMCOLOR)
      DEVPOS(CL, CC)
      DEVOUT(SUBSTR(COLOR, 1, 4))
      MEMVAR->PC := PC + 42
      MEMVAR->SC := SC + 42
      MEMVAR->TC := TC + 42
      MEMVAR->CC := CC + 42
      DBSKIP(1)

   ENDDO

   MEMVAR->CL := MEMVAR->CL + 1
   DEVPOS(CL, 0)
   DEVOUT(RAYA)
   DBCLOSEARE()
   DEVPOS(1, 1)
   DEVOUT(" ")
   __EJECT()
   APIM()
   __RUN("MODE LPT1:80,6")
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->OPC := " "

RETURN 

