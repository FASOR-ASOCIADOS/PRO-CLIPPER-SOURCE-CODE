/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: PRO
   Params: None.
   Return: Undefined
  Example: PRO()
  ..........................................................................
*/

PROCEDURE PRO()

   SET(32, "OFF")
   SET(4, IF(__SETCENTU(), "yyyy.mm.dd", "yy.mm.dd"))
   SET(4, "YYYY/MM/DD")
   SET(35, "ON")
   MEMVAR->A := " "
   MEMVAR->E := "‚"
   MEMVAR->I := "¡"
   MEMVAR->O := "¢"
   MEMVAR->U := "£"
   MEMVAR->NMI := "¤"
   MEMVAR->NMA := "¥"
   MEMVAR->WCODUSU := SPACE(5)
   MEMVAR->ZLCPT := SPACE(6)
   SCROLL()
   SETPOS(0, 0)
   READKILL(.T.)
   MEMVAR->GETLIST := {}

   IF FILE("c:\YO")

      MEMVAR->WCODUSU := "0    "

   ELSE

      SET(17, "OFF")
      DEVPOS(12, 10)
      DEVOUT("CODIGO DEL USUARIO ")
      MEMVAR->WCODUSU := __ACCEPT()
      SET(17, "ON")

      IF WCODUSU = SPACE(LEN(WCODUSU))

         RETURN 

      ENDIF

      MEMVAR->WCODUSU := ALLTRIM(UPPER(WCODUSU))
      MEMVAR->WCODUSU := WCODUSU + SPACE(5 - LEN(WCODUSU))

   ENDIF

   DBUSEAREA(.F., NIL, "CLIENTE.PRO", NIL, .T., .F.)
   __DBLOCATE({||COD = WCODUSU}, NIL, NIL, NIL, .F.)

   IF EOF()

      MEMVAR->OPC := " "
      DBCLOSEARE()
      DEVPOS(14, 10)
      DEVOUT("Usuario no reconocido ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", NIL, NIL, NIL):DISPLAY())
      RETURN 

   ENDIF

   MEMVAR->WNOMUSU := " " + ALLTRIM(NOMUSU)
   DBCLOSEARE()
   MEMVAR->WCAMPAR := "N"
   MEMVAR->WNIV := "0" + SPACE(4)
   MEMVAR->XS := " "
   VEANIV()

   IF XS = "S"

      MEMVAR->WCAMPAR := "S"

   ENDIF

   IF  .NOT. FILE("LETRAS.MEM")

      __MSAVE("LETRAS", "???", .T.)

   ENDIF

   IF FILE("WDIRECTO.MEM")

      __MRESTORE("WDIRECTO", .T.)

   ELSE

      MEMVAR->WDIRECTO := "PRO      "

   ENDIF

   IF FILE("ZDIS.MEM")

      __MRESTORE("ZDIS.MEM", .T.)

   ELSE

      MEMVAR->ZDIS := "C:"

   ENDIF

   SCROLL()
   SETPOS(0, 0)
   READKILL(.T.)
   MEMVAR->GETLIST := {}

   IF WCAMPAR = "S"

      DEVPOS(12, 20)
      DEVOUT("Disco de trabajo ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "ZDIS", "@!", {||ZDIS $ "C:F:"}, NIL);
            :DISPLAY())
      DEVPOS(13, 20)
      DEVOUT("Directorio de trabajo ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "WDIRECTO", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

   ENDIF

   IF FILE("ZDIS.MEM")

      FERASE("ZDIS.MEM")

   ENDIF

   /* Windows 7 y posteriores no ignoran los espacios al final de una
      carpeta intermedia de la ruta, como si lo hacian MS-DOS y Windows XP:
      "F:\PRO      \ZDIS.MEM" da error de ruta no encontrada. Por eso el
      directorio se recorta aqui, antes de armar ninguna ruta. */
   MEMVAR->WDIRECTO := ALLTRIM(WDIRECTO)

   __MSAVE("&ZDIS\&WDIRECTO\ZDIS", "ZDIS", .T.)

   IF FILE("WDIRECTO.MEM")

      FERASE("WDIRECTO.MEM")

   ENDIF

   /* se vuelve a rellenar solo para guardarlo: asi el campo de la
      proxima ejecucion conserva su ancho */
   MEMVAR->WDIRECTO := PADR(WDIRECTO, 9)
   __MSAVE("WDIRECTO", "WDIRECTO", .T.)
   MEMVAR->WDIRECTO := ALLTRIM(WDIRECTO)
   MEMVAR->XDIS := ZDIS

   IF FILE("&ZDIS\&WDIRECTO\ZMES.DAT")

      __MRESTORE("&ZDIS\&WDIRECTO\ZMES.DAT", .T.)

   ELSE

      MEMVAR->ZMES := 1
      MEMVAR->ZANO := "  "

   ENDIF

   MEMVAR->ZDIS := XDIS
   MEMVAR->WMESA := ZMES
   MEMVAR->WANOA := ZANO
   MEMVAR->RAZON := "FASOR ASOCIADOS  S.A.S."
   MENU()

   IF WCAMPAR = "S"

      DEVPOS(12, 10)
      DEVOUT("EN QUE MES VA A TRABAJAR ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "ZMES", "@Z 99", {||ZMES > 0 .AND. ZMES < ;
            13}, NIL):DISPLAY())
      DEVPOS(13, 10)
      DEVOUT("DE QUE A" + NMA + "O ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "ZANO", NIL, NIL, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

   ENDIF

   IF FILE("&ZDIS\&WDIRECTO\ZMES.DAT")

      FERASE("&ZDIS\&WDIRECTO\ZMES.DAT")

   ENDIF

   MEMVAR->XDIS := ZDIS
   __MRELEASE("ZDIS", .T.)
   __MSAVE("&XDIS\&WDIRECTO\ZMES.DAT", "Z???", .T.)
   MEMVAR->ZZANO := VAL(ZANO)
   __MRESTORE("ZDIS.MEM", .T.)
   __MRELEASE("XDIS", .T.)
   SET(36, "F  A  S  O  R    S. A.")
   SET(37, .F.)
   SET(2, "ON")
   MEMVAR->OPC := " "
   __MRESTORE("&ZDIS\&WDIRECTO\RAZON", .T.)
   MEMVAR->FMOVINS := "MOVINS" + ALLTRIM(TRANSFORM(ZMES, "99")) + ".DBF"
   MEMVAR->FMAINSU := "MAINSU" + ALLTRIM(TRANSFORM(ZMES, "99")) + ".DBF"

   IF WMESA <> ZMES .OR. WANOA <> ZANO

      MEMVAR->SWAUTO := 1
      PROG8()

   ENDIF

   AMVPRSS()
   __DBLOCATE({||MONTH(FECHA) <> ZMES}, NIL, NIL, NIL, .F.)

   IF EOF()

      DBCLOSEARE()

   ELSE

      MENU()
      MEMVAR->OPC := " "
      SETCOLOR("*+GR")
      DEVPOS(10, 20)
      DEVOUT("!!!!!!   A D V E R T E N C I A   !!!!!")
      SETCOLOR("+W")
      DEVPOS(14, 10)
      DEVOUT("EN EL ARCHIVO DE MOVIMIENTO DE LA SEMANA EXISTEN REGISTROS")
      DEVPOS(15, 10)
      DEVOUT("CON MES DE LA FECHA DIFERENTE AL QUE ESTA TRABAJANDO.....")
      DEVPOS(16, 10)
      DEVOUT("Sigue <A>delante o <C>ancela el programa ? ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "AC"}, NIL):DISPLAY())
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "C" .OR. LASTKEY() = 27

         RETURN 

      ENDIF

      MEMVAR->OPC := " "

   ENDIF

   DBCLOSEARE()

   DO WHILE OPC <> "*"

      MEMVAR->OPC := "*"
      MENU()
      DEVPOS(7, 1)
      DEVOUT(PADC("M E N U     P R I N C I P A L", 78))
      DISPBOX(10, 20, 21, 63, 2)
      DEVPOS(12, 25)
      DEVOUT("1. MANEJO ARCHIVOS MAESTROS y BROWSE")
      DEVPOS(13, 25)
      DEVOUT("2. ORDENES DE COMPRA")
      DEVPOS(14, 25)
      DEVOUT("3. ORDENES DE PRODUCCION")
      DEVPOS(15, 25)
      DEVOUT("4. COSTOS DE PRODUCCION")
      DEVPOS(16, 25)
      DEVOUT("5. PAGO DE M. O.")
      DEVPOS(17, 25)
      DEVOUT("6. MOVIMIENTOS DE INSUMOS (M.P.)")
      DEVPOS(18, 25)
      DEVOUT("7. BATCH Y AUDITORIAS")
      DEVPOS(19, 25)
      DEVOUT("8. RECONSTRUCCION ARCHIVOS INDICES")
      DEVPOS(20, 25)
      DEVOUT("9. ABRIR MES, TRASLADAR SALDOS")
      DEVPOS(21, 25)
      DEVOUT("*. FIN")
      SETCOLOR("+G")
      MEMVAR->OPC := "*"
      DEVPOS(23, 25)
      DEVOUT(" Seleccione una opci¢n ")
      SETPOSBS()
      AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "123456789*"}, NIL);
            :DISPLAY())
      SETCOLOR("+W")
      READMODAL(GETLIST)
      MEMVAR->GETLIST := {}

      IF OPC = "*"

         EXIT

      ENDIF

      MEMVAR->WNIV := OPC + SPACE(4)
      MEMVAR->XS := " "
      VEANIV()

      IF XS = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      MEMVAR->SWAUTO := 0
      MEMVAR->WPRO := "PROG" + OPC
      &WPRO()
      __MRESTORE("&ZDIS\&WDIRECTO\RAZON", .T.)
      __MRESTORE("&ZDIS\&WDIRECTO\LETRAS", .T.)

   ENDDO

   SET(17, "OFF")
   __RUN("DEL A*.")
   __RUN("DEL B*.")
   __RUN("DEL D*.")
   __RUN("DEL E*.")
   __RUN("DEL F*.")
   __RUN("DEL G*.")
   __RUN("DEL H*.")
   __RUN("DEL I*.")
   __RUN("DEL J*.")
   __RUN("DEL K*.")
   __RUN("DEL L*.")
   __RUN("DEL M*.")
   __RUN("DEL N*.")
   __RUN("DEL O*.")
   __RUN("DEL P*.")
   __RUN("DEL Q*.")
   __RUN("DEL R*.")
   SET(17, "ON")
   SCROLL()
   SETPOS(0, 0)
   READKILL(.T.)
   MEMVAR->GETLIST := {}
   __RUN("CD")
   SETCOLOR("+G")
   DISPBOX(16, 55, 20, 75, 1)
   DEVPOS(17, 60)
   DEVOUT("** F.I.N. **")
   SETCOLOR("+BG")
   DEVPOS(18, 65)
   DEVOUT("**GENESIS**   PRODUCCION")
   SETCOLOR("+W")
   DEVPOS(19, 60)
   DEVOUT("   CFV.")

RETURN 

