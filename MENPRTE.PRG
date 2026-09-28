/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MENPRTE
   Params: None.
   Return: Undefined
  Example: MENPRTE()
  ..........................................................................
*/

PROCEDURE MENPRTE()

   DEVPOS(10, 10)
   DEVOUT(" CODIGO   ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WCOD", NIL, NIL, NIL):DISPLAY())
   DEVPOS(11, 10)
   DEVOUT(" NOMBRE   ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WNOM", NIL, NIL, NIL):DISPLAY())
   DEVPOS(12, 10)
   DEVOUT(" UNIDAD   ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WUNI", NIL, NIL, NIL):DISPLAY())
   DEVPOS(13, 10)
   DEVOUT("% UTIL. 1 ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WPO1", "@# 999.99", NIL, NIL):DISPLAY())
   DEVPOS(14, 10)
   DEVOUT("% UTIL. 2 ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WPO2", "@# 999.99", NIL, NIL):DISPLAY())
   DEVPOS(15, 10)
   DEVOUT("% UTIL. 3 ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WPO3", "@# 999.99", NIL, NIL):DISPLAY())
   DEVPOS(16, 10)
   DEVOUT("Vr. LISTA ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "WVRLISTA", "@Z 9,999,999", NIL, NIL):DISPLAY();
         )

   IF SWLEE = 1

      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

   ELSE

      READKILL(.T.)
      MEMVAR->GETLIST := {}

   ENDIF


RETURN 

