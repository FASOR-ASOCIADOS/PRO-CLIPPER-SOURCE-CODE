/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MENU
   Params: None.
   Return: Undefined
  Example: MENU()
  ..........................................................................
*/

PROCEDURE MENU()

   SETCOLOR("+W/+GR")

   IF ZDIS = "F"

      SETCOLOR("+W/+B")

   ENDIF

   SCROLL()
   SETPOS(0, 0)
   READKILL(.T.)
   MEMVAR->GETLIST := {}
   MEMVAR->WMES := MEMVAR->WNOMMES := ZMES
   NOMMES()
   DEVPOS(0, 1)
   DEVOUT(PADC(RAZON, 78))
   DEVPOS(2, 1)
   DEVOUT(PADC("SISTEMA  DE  PRODUCCION", 78))
   DEVPOS(2, 79 - LEN(WNOMMES))
   DEVOUT(WNOMMES)
   SETCOLOR("+W/B")
   MEMVAR->WT1 := "** PROGRESS ** Sistemas de informaci" + O + "n   "

   IF ZDIS = "C"

      SETCOLOR("*+W/GR")
      MEMVAR->WT1 := "Esta trabajando en el disco C:    ojo,   disco C:"

   ENDIF

   DEVPOS(24, 2)
   DEVOUT(WT1)
   SETCOLOR("+W")
   MEMVAR->WT1 := ZDIS + "\" + ALLTRIM(WDIRECTO)
   DEVPOS(24, 79 - LEN(ALLTRIM(WT1)))
   DEVOUT(ALLTRIM(WT1))
   DEVPOS(3, 1)
   DEVOUT(WNOMUSU)
   SCROLL(4, 1, 23, 78)
   SETPOS(4, 1)

RETURN 

