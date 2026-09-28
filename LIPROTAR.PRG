/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LIPROTAR
   Params: None.
   Return: Undefined
  Example: LIPROTAR()
  ..........................................................................
*/

PROCEDURE LIPROTAR()

   MEMVAR->OPC := " "
   MENU()
   DEVPOS(12, 20)
   DEVOUT("Por medio de esta opci¢n se obtiene un listado de")
   DEVPOS(13, 20)
   DEVOUT("los productos que llevan una tarea determinada.")
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

   SCROLL(12, 10, 14, 70)
   MEMVAR->WTAR := ( SETPOS(12, 10), "  " )
   DEVPOS(13, 20)
   DEVOUT("CODIGO DE LA TAREA A LISTAR ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WTAR", "@!", NIL, NIL):DISPLAY())
   DEVPOS(14, 20)
   DEVOUT("ESC para cancelar ")
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF LASTKEY() = 27

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   ESPERE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   ATAS()
   __DBSORT("C:\BASURA", {"NUMPRO"}, {||CODTAR = WTAR}, NIL, NIL, NIL, .F.)
   DBCLOSEARE()
   DBSELECTAR("3")
   DBUSEAREA(.F., NIL, "C:\BASURA", NIL, NIL, .F.)
   MENU()
   VEAIMP()
   ENIM()
   MEMVAR->RAYA := REPLICATE("Ä", 80)
   MEMVAR->CP := MEMVAR->CL := 0

   DO WHILE  .NOT. EOF() .AND. INKEY() <> 27

      IF CL = 0

         MEMVAR->CP := MEMVAR->CP + 1
         DEVPOS(CL, 0)
         DEVOUT(PADC(RAZON, 79))
         ++MEMVAR->CL
         DEVPOS(CL, 0)
         DEVOUT(PADC(;
               "RELACION DE PRODUCTOS QUE CONTIENEN UNA TAREA DETERMINADA",;
                79))
         ++MEMVAR->CL
         DEVPOS(CL, 0)
         DEVOUT("LISTADO A : " + DTOC(WFECHA))
         MEMVAR->WT1 := "PAGINA NUMERO " + ALLTRIM(TRANSFORM(CP, "99"))
         DEVPOS(CL, 79 - LEN(WT1))
         DEVOUT(WT1)
         ++MEMVAR->CL
         DEVPOS(CL, 0)
         DEVOUT(RAYA)
         ++MEMVAR->CL
         DEVPOS(CL, 0)
         DEVOUT(;
               "COD-PRO  NOMBRE DEL PRODUCTO  COD.DE LA TAREA  UNIDADES/H   FACTOR x PROD";
               )
         ++MEMVAR->CL
         DEVPOS(CL, 0)
         DEVOUT(RAYA)
         ++MEMVAR->CL

      ENDIF

      MEMVAR->WCODPRO := CODPRO + " "
      MEMVAR->WCAN := UNIDADESH
      MEMVAR->WCODTAR := CODTAR
      MEMVAR->WNUMPRO := NUMPRO
      MEMVAR->WCANXUNI := CANXUNI
      AMAPAS()
      __DBLOCATE({||CODART = WCODPRO}, NIL, NIL, NIL, .F.)
      MEMVAR->WNOMBRE := IF(EOF(), "NOMBRE NO ENCONTRADO", NOMBRE)
      DBCLOSEARE()
      DBSELECTAR("3")
      DEVPOS(CL, 0)
      DEVOUT(WCODPRO + "  " + WNOMBRE + "        " + WCODTAR + SPACE(4) + ;
            TRANSFORM(WCAN, "999,999.9") + SPACE(10) + TRANSFORM(WCANXUNI, ;
            "999.9999"))
      MEMVAR->CL := MEMVAR->CL + 1

      IF CL = 55

         MEMVAR->CL := 0
         __EJECT()

      ENDIF

      DBSKIP(1)

   ENDDO

   DEVPOS(CL, 0)
   DEVOUT(RAYA)
   ++MEMVAR->CL

   IF  .NOT. EOF()

      DEVPOS(CL, 5)
      DEVOUT("CANCELADO POR EL USUARIO")

   ENDIF

   __EJECT()
   APIM()
   CIERRE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   MEMVAR->OPC := " "

RETURN 

