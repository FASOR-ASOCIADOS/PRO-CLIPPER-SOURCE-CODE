/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: RUTMODPL
   Params: None.
   Return: Undefined
  Example: RUTMODPL()
  ..........................................................................
*/

PROCEDURE RUTMODPL()

   SETCOLOR("W")

   DO WHILE OPC <> "S"

      MEMVAR->WNUMCAM := " "
      DEVPOS(21, 20)
      DEVOUT("DIGITE CAMPO A MODIFICAR ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WNUMCAM", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF WNUMCAM = "1"

         DEVPOS(12, 10)
         DEVOUT("1. CODIGO      ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCOD", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WNUMCAM = "2"

         DEVPOS(13, 10)
         DEVOUT("2. GRUPO       ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WZON", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WNUMCAM = "3"

         DEVPOS(14, 10)
         DEVOUT("3. NOMBRES     ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WNOM", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WNUMCAM = "4"

         DEVPOS(15, 10)
         DEVOUT("4. APELLIDOS   ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WAPE", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WNUMCAM = "5"

         DEVPOS(16, 10)
         DEVOUT("5. DIRECCION   ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WDIR", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WNUMCAM = "6"

         DEVPOS(17, 10)
         DEVOUT("6. TELEFONOS   ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WTE1", NIL, NIL, NIL):DISPLAY())
         SETPOS(17, 34)
         AADD(GETLIST, __GET(NIL, "WTE2", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WNUMCAM = "7"

         DEVPOS(18, 10)
         DEVOUT("7. CEDULA      ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WCC", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WNUMCAM = "8"

         DEVPOS(19, 10)
         DEVOUT("8. FECHA ING.  ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WFECING", NIL, NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ELSEIF WNUMCAM = "9"

         DEVPOS(20, 10)
         DEVOUT("9. PUNTAJE     ")
         SETPOSBS()
         AADD(GETLIST, __GET(NIL, "WPUNTOS", "@Z 999", NIL, NIL):DISPLAY())
         READMODAL(GETLIST)
         MEMVAR->GETLIST := {}

      ENDIF

      MEMVAR->OPC := " "
      DEVPOS(23, 20)
      DEVOUT("ESTA TODO CORRECTO ? S/N ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}
      SETCOLOR("W")

   ENDDO


RETURN 

