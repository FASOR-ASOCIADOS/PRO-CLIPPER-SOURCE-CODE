/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MENPERPL
   Params: None.
   Return: Undefined
  Example: MENPERPL()
  ..........................................................................
*/

PROCEDURE MENPERPL()

   DEVPOS(12, 10)
   DEVOUT("1. CODIGO      ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WCOD", NIL, NIL, NIL):DISPLAY())
   DEVPOS(13, 10)
   DEVOUT("2. GRUPO       ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WZON", NIL, NIL, NIL):DISPLAY())
   DEVPOS(14, 10)
   DEVOUT("3. NOMBRES     ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WNOM", NIL, NIL, NIL):DISPLAY())
   DEVPOS(15, 10)
   DEVOUT("4. APELLIDOS   ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WAPE", NIL, NIL, NIL):DISPLAY())
   DEVPOS(16, 10)
   DEVOUT("5. DIRECCION   ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WDIR", NIL, NIL, NIL):DISPLAY())
   DEVPOS(17, 10)
   DEVOUT("6. TELEFONOS   ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WTE1", NIL, NIL, NIL):DISPLAY())
   SETPOS(17, 34)
   AADD(GETLIST, __GET(NIL, "WTE2", NIL, NIL, NIL):DISPLAY())
   DEVPOS(18, 10)
   DEVOUT("7. CEDULA      ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WCC", NIL, NIL, NIL):DISPLAY())
   DEVPOS(19, 10)
   DEVOUT("8. FECHA ING.  ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WFECING", NIL, NIL, NIL):DISPLAY())
   DEVPOS(20, 10)
   DEVOUT("9. PUNTAJE     ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WPUNTOS", "@Z 999", NIL, NIL):DISPLAY())

   IF SWLEE = 1

      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

   ELSE

      READKILL(.T.)
      MEMVAR->GETLIST := {}

   ENDIF


RETURN 

