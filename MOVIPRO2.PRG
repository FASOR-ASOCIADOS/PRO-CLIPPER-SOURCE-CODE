/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MOVIPRO2
   Params: None.
   Return: Undefined
  Example: MOVIPRO2()
  ..........................................................................
*/

PROCEDURE MOVIPRO2()

   MEMVAR->OPC := " "
   SCROLL(7, 1, 23, 78)
   SETPOS(7, 1)
   DEVPOS(12, 15)
   DEVOUT("Por medio  de este programa se obtiene un listado")
   DEVPOS(13, 15)
   DEVOUT("de todos los insumos pendientes de descargar en el")
   DEVPOS(14, 15)
   DEVOUT("archivo INSPEND.DBF")
   DEVPOS(17, 20)
   DEVOUT("desea continuar ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC <> "S"

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   SCROLL(7, 1, 23, 78)
   MEMVAR->OPC := ( SETPOS(7, 1), " " )
   PIDEIMP()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   AINPES()
   __DBCOPY("C:\PROTMP\BASURA", {}, NIL, NIL, NIL, NIL, .F., NIL)
   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "C:\PROTMP\BASURA", NIL, NIL, .F.)
   VEAIMP()
   ENIM()
   DEVPOS(PROW(), PCOL())
   DEVOUT(CHR(15)+" ")
   DEVPOS(PROW(), PCOL())
   DEVOUT(CHR(15)+" ")
   __RUN("MODE LPT1:132")
   __REPORTFO("MOVIPRO6", .T., NIL, .F., NIL, NIL, NIL, NIL, .F., .F., NIL,;
          .F., .F.)
   DEVPOS(PROW(), PCOL())
   DEVOUT(CHR(18)+" ")
   __EJECT()
   APIM()
   DBCLOSEARE()
   MEMVAR->WAB := "BASURA.DBF"
   BA()
   __RUN("MODE LPT1:80")
   MEMVAR->OPC := " "

RETURN 

