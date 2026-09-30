/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LISPREIN
   Params: None.
   Return: Undefined
  Example: LISPREIN()
  ..........................................................................
*/

PROCEDURE LISPREIN()

   MEMVAR->OPC := " "
   MENU()
   DEVPOS(12, 20)
   DEVOUT("Por medio de esta opci¢n se obtiene una lista")
   DEVPOS(13, 20)
   DEVOUT("de precios de insumos.")
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
   MEMVAR->WFECHA := DATE()
   MEMVAR->WDIA := ""
   FECHA()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   AMAINS()
   __DBSORT("C:\PROTMP\BASURA", {"CODNUM", "NUMCOLOR"}, NIL, NIL, NIL, NIL, .F.)
   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)
   SCROLL(5, 1, 23, 78)
   SETPOS(5, 1)
   __RUN("MODE LPT1:132,8")
   SCROLL(5, 1, 23, 78)
   SETPOS(5, 1)
   DEVPOS(12, 20)
   DEVOUT("* * *  IMPRIMIENDO  * * *")
   VEAIMP()
   ENIM()
   MEMVAR->CP := MEMVAR->CL := MEMVAR->CI := 0
   MEMVAR->RAYA := REPLICATE("Ä", 132)
   MEMVAR->PC := 1
   MEMVAR->SC := 6
   MEMVAR->TC := 27
   MEMVAR->CC := 29
   MEMVAR->QC := 34

   DO WHILE  .NOT. EOF()

      IF CL = 0

         MEMVAR->CP := MEMVAR->CP + 1
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 50)
         DEVOUT(CHR(27)+"Ž" + RAZON)
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 1)
         DEVOUT(PADC("LISTA DE PRECIOS DE INSUMOS", 131))
         DEVPOS(CL, 1)
         DEVOUT(WDIA)
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 0)
         DEVOUT(RAYA)
         MEMVAR->CL := MEMVAR->CL + 1
         DEVPOS(CL, 0)
         DEVOUT(;
               "COD. PRODUCTO             COLOR     VALOR    COD. PRODUCTO             COLOR     VALOR   COD. PRODUCTO             COLOR     VALOR";
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
         MEMVAR->QC := 34
         MEMVAR->CI := 0
         MEMVAR->CL := MEMVAR->CL + 1

      ENDIF

      MEMVAR->CI := MEMVAR->CI + 1
      DEVPOS(CL, PC)
      DEVOUT(CODIGO)
      DEVPOS(CL, PC)
      DEVOUT(CODIGO)
      DEVPOS(CL, SC)
      DEVOUT(NOMFASOR)
      DEVPOS(CL, TC)
      DEVOUT(NUMCOLOR)
      DEVPOS(CL, CC)
      DEVOUT(SUBSTR(COLOR, 1, 4))
      DEVPOS(CL, QC)
      DEVOUTPICT(COSTO1, "@# 999,999.99")
      MEMVAR->PC := PC + 44
      MEMVAR->SC := SC + 44
      MEMVAR->TC := TC + 44
      MEMVAR->CC := CC + 44
      MEMVAR->QC := QC + 44
      DBSKIP(1)

   ENDDO

   MEMVAR->CL := MEMVAR->CL + 1
   DEVPOS(CL, 0)
   DEVOUT(RAYA)
   DBCLOSEARE()
   DEVPOS(1, 1)
   DEVOUT(" ")
   APIM()
   __RUN("MODE LPT1:80,6")
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->OPC := " "

RETURN 

