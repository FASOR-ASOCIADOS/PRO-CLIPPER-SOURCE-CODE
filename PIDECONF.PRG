/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: PIDECONF
   Params: None.
   Return: Undefined
  Example: PIDECONF()
  ..........................................................................
*/

PROCEDURE PIDECONF()

   SCROLL(20, 1, 23, 78)
   MEMVAR->WCLAVE := ( SETPOS(20, 1), SPACE(8) )
   __MRESTORE("DATO", .T.)
   SET(17, "OFF")
   DEVPOS(20, 1)
   DEVOUT("Grabado, m" + A + "s este pago " + ALLTRIM(TRANSFORM(WCONT, ;
         "99999.9999")) + " M" + A + "ximo permitido " + ALLTRIM(TRANSFORM(;
         WMAXIMO, "99999.9999")))
   DEVPOS(21, 5)
   DEVOUT("Con este pago excede " + WTEMA + "de la labor requerida(s)")
   DEVPOS(22, 5)
   DEVOUT("en la elaboraci" + O + "n del producto. Pulse X para cancelar")
   DEVPOS(23, 5)
   DEVOUT("el movimiento o escriba la contrase" + NMI + "a de aprobaci" + ;
         O + "n.")
   MEMVAR->WCLAVE := __ACCEPT()
   SET(17, "ON")

   IF SUBSTR(WCLAVE, 1, 1) = "X"

      MEMVAR->WCONF := "N"
      RETURN 

   ENDIF

   IF WCODTAR = "PA" .AND. ALLTRIM(WCLAVE) <> ALLTRIM(DATO2) .OR. WCODTAR ;
         <> "PA" .AND. ALLTRIM(WCLAVE) <> ALLTRIM(DATO)

      __MRELEASE("DATO?", .T.)
      SCROLL(23, 1, 23, 78)
      SETPOS(23, 1)
      DEVPOS(23, 10)
      DEVOUT("ACCESO NEGADO, CLAVE INCORRECTA, OPRIMA ALGUNA TECLA")
      MEMVAR->X := INKEY(0)
      MEMVAR->WCONF := "N"
      RETURN 

   ELSE

      MEMVAR->WCONF := "S"

   ENDIF

   SCROLL(21, 1, 23, 78)
   SETPOS(21, 1)
   __MRELEASE("DATO?", .T.)

RETURN 

