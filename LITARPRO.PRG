/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LITARPRO
   Params: None.
   Return: Undefined
  Example: LITARPRO()
  ..........................................................................
*/

PROCEDURE LITARPRO()

   MEMVAR->OPC := "S"
   MENU()
   DEVPOS(12, 20)
   DEVOUT("Por medio de esta opci¢n se obtiene un listado de")
   DEVPOS(13, 20)
   DEVOUT("los las tareas que lleva un producto determinado.")
   DEVPOS(15, 20)
   DEVOUT("Desea continuar ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC = "N" .OR. LASTKEY() = 27

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   __MRESTORE("&ZDIS\&WDIRECTO\SALMIN", .T.)
   __MRESTORE("&ZDIS\&WDIRECTO\HORWMES", .T.)
   SET(3, 2)
   MEMVAR->WVALHOR := SALMIN / ZHORWMES
   MEMVAR->BLANCOS := ;
         "                                                          "
   SCROLL(12, 10, 15, 70)
   MEMVAR->WPROI := MEMVAR->WPROT := ( SETPOS(12, 10), 0 )
   SCROLL(8, 1, 23, 78)
   SETPOS(8, 1)
   DEVPOS(13, 20)
   DEVOUT("CODIGO DE PRODUCTO PARA INICIAR  ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WPROI", "@Z 999999", NIL, NIL):DISPLAY())
   DEVPOS(14, 20)
   DEVOUT("CODIGO DE PRODUCTO PARA TERMINAR ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WPROT", "@Z 999999", NIL, NIL):DISPLAY())
   DEVPOS(15, 30)
   DEVOUT("ESC para cancelar")
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF WPROI = 0 .OR. LASTKEY() = 27

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   ESPERE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->WAB := "BASURA.NTX"
   BA()
   ATAS()
   __DBSORT("C:\BASURA", {"NUMPRO", "CODTAR", "NUMCOLOR"}, {||NUMPRO > ;
         WPROI - 1 .AND. NUMPRO < WPROT + 1}, NIL, NIL, NIL, .F.)
   DBCLOSEARE()
   DBSELECTAR("3")
   DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
   MENU()
   ESPERE()
   VEAIMP()
   ENIM()
   DEVPOS(PROW(), PCOL())
   DEVOUT(CHR(15)+" ")
   MEMVAR->CP := MEMVAR->CL := MEMVAR->CLE := 0
   MEMVAR->WPRO := "    "
   MEMVAR->RAYA := REPLICATE("Ä", 132)

   DO WHILE  .NOT. EOF() .AND. INKEY() <> 27

      IF CL = 0

         MEMVAR->CP := MEMVAR->CP + 1
         DEVPOS(1, 1)
         DEVOUT(PADC("FASOR ASOCIADOS S.A.S.", 132))
         DEVPOS(2, 1)
         DEVOUT(PADC("SISTEMA DE PRODUCCION", 132))
         DEVPOS(4, 1)
         DEVOUT(PADC(;
               "RELACION DE TAREAS QUE TIENE UN PRODUCTO DETERMINADO", 132);
               )
         DEVPOS(5, 1)
         DEVOUT("LISTADO A : " + DTOC(WFECHA))
         MEMVAR->WT1 := "PAGINA NUMERO " + ALLTRIM(TRANSFORM(CP, "99"))
         DEVPOS(5, 132 - LEN(WT1))
         DEVOUT(WT1)
         DEVPOS(6, 0)
         DEVOUT(RAYA)
         DEVPOS(7, 1)
         DEVOUT(;
               "CODIGO NOMBRE PRODUCTO      TA  CANT  VALOR   CAxPT    TA CANT   VALOR  CAxPT.    TA CANT   VALOR  CAxPT.    TA CANT.  VALOR  CAxPT.";
               )
         DEVPOS(8, 0)
         DEVOUT(RAYA)
         MEMVAR->CL := MEMVAR->CL + 8

      ENDIF

      MEMVAR->SWCOL := 0

      IF WPRO <> CODPRO .OR. CL = 8

         MEMVAR->CL := MEMVAR->CL + 1

         IF CL = 58

            MEMVAR->CL := 0
            LOOP

         ENDIF

         MEMVAR->WPRO := MEMVAR->WCODPRO := CODPRO
         MEMVAR->WNUMPRO := NUMPRO
         AMAPAS()
         ORDLISTCLE()
         ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
         DBSEEK("&WCODPRO")
         MEMVAR->WNOMBRE := IF(EOF(), "NOMBRE NO ENCONTRADO", NOMBRE)
         DBCLOSEARE()
         DEVPOS(CL, 1)
         DEVOUT(WCODPRO)
         DEVPOS(CL, 8)
         DEVOUT(WNOMBRE)
         MEMVAR->CLE := 28

      ENDIF

      DBSELECTAR("3")
      MEMVAR->WCONT := "*"

      IF CONTADORES = "N"

         MEMVAR->WCONT := " "

      ENDIF

      MEMVAR->WCAN := UNIDADESH
      MEMVAR->WCODTAR := CODTAR
      MEMVAR->WVALTAR := WVALHOR / WCAN
      MEMVAR->WCANXUNI := CANXUNI

      IF CLE < 120

         DEVPOS(CL, CLE)
         DEVOUT(WCONT + WCODTAR + " " + TRANSFORM(WCAN, "99999") + " " + ;
               TRANSFORM(WVALTAR, "$$$$.$$") + " " + TRANSFORM(WCANXUNI, ;
               "999.9999"))
         MEMVAR->CLE := MEMVAR->CLE + 26

      ELSE

         MEMVAR->CL := MEMVAR->CL + 1

         IF CL = 58

            MEMVAR->CL := 0
            LOOP

         ENDIF

         MEMVAR->CLE := 28
         DEVPOS(CL, CLE)
         DEVOUT(WCONT + WCODTAR + " " + TRANSFORM(WCAN, "99999") + " " + ;
               TRANSFORM(WVALTAR, "$$$$.$$") + " " + TRANSFORM(WCANXUNI, ;
               "999.9999"))
         MEMVAR->CLE := MEMVAR->CLE + 26

      ENDIF

      DBSKIP(1)

   ENDDO

   MEMVAR->CL := MEMVAR->CL + 1

   IF  .NOT. EOF()

      DEVPOS(CL, 1)
      DEVOUT("Cancelado por el usuario")
      MEMVAR->CL := MEMVAR->CL + 1

   ENDIF

   DEVPOS(CL, 0)
   DEVOUT(RAYA)
   ++MEMVAR->CL
   DEVPOS(CL, 1)
   DEVOUT("Tareas con prefijo * requieren contadores")
   ++MEMVAR->CL
   DEVPOS(PROW(), PCOL())
   DEVOUT(CHR(18)+" ")
   DEVPOS(CL + 1, 1)
   DEVOUT("*** fin del informe *** " + DTOC(DATE()) + " / " + TIME())
   __EJECT()
   APIM()
   CIERRE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->WAB := "BASURA.NTX"
   BA()
   MEMVAR->OPC := " "

RETURN 

