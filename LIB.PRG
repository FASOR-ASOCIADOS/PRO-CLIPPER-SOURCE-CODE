/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: VEANIV
   Params: None.
   Return: Undefined
  Example: VEANIV()
  ..........................................................................
*/

PROCEDURE VEANIV()

   DBSELECTAR("20")
   DBUSEAREA(.F., NIL, "CLIENTE.PRO", NIL, .T., .F.)
   __DBLOCATE({||COD = WCODUSU .AND. NIVEL = WNIV}, NIL, NIL, NIL, .F.)
   MEMVAR->XS := "N"

   IF  .NOT. EOF()

      MEMVAR->XS := ENTRA
      LOCK()
      FIELD->ULTENT := DATE()
      DBUNLOCK()

   ENDIF

   DBCLOSEARE()

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AMVPRSS
   Params: None.
   Return: Undefined
  Example: AMVPRSS()
  ..........................................................................
*/

PROCEDURE AMVPRSS()

   DBSELECTAR("6")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MOVPRSEM", NIL, .T., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MOVPRSEM", NIL, .T., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE MOVIMIENTO DE LA SEMANA")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: PRO1
   Params: None.
   Return: Undefined
  Example: PRO1()
  ..........................................................................
*/

PROCEDURE PRO1()


RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: NOMMES
   Params: None.
   Return: Undefined
  Example: NOMMES()
  ..........................................................................
*/

PROCEDURE NOMMES()

   IF WMES = 1

      MEMVAR->WNOMMES := "ENERO"

   ELSEIF WMES = 2

      MEMVAR->WNOMMES := "FEBRERO"

   ELSEIF WMES = 3

      MEMVAR->WNOMMES := "MARZO"

   ELSEIF WMES = 4

      MEMVAR->WNOMMES := "ABRIL"

   ELSEIF WMES = 5

      MEMVAR->WNOMMES := "MAYO"

   ELSEIF WMES = 6

      MEMVAR->WNOMMES := "JUNIO"

   ELSEIF WMES = 7

      MEMVAR->WNOMMES := "JULIO"

   ELSEIF WMES = 8

      MEMVAR->WNOMMES := "AGOSTO"

   ELSEIF WMES = 9

      MEMVAR->WNOMMES := "SEPTIEMBRE"

   ELSEIF WMES = 10

      MEMVAR->WNOMMES := "OCTUBRE"

   ELSEIF WMES = 11

      MEMVAR->WNOMMES := "NOVIEMBRE"

   ELSEIF WMES = 12

      MEMVAR->WNOMMES := "DICIEMBRE"

   ENDIF


RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: BA
   Params: None.
   Return: Undefined
  Example: BA()
  ..........................................................................
*/

PROCEDURE BA()

   IF FILE("C:\PROTMP\&WAB")

      FERASE("C:\PROTMP\&WAB")

   ENDIF


RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: CIERRE
   Params: None.
   Return: Undefined
  Example: CIERRE()
  ..........................................................................
*/

PROCEDURE CIERRE()

   DBSELECTAR("1")
   DBCLOSEARE()
   DBSELECTAR("2")
   DBCLOSEARE()
   DBSELECTAR("3")
   DBCLOSEARE()
   DBSELECTAR("4")
   DBCLOSEARE()
   DBSELECTAR("5")
   DBCLOSEARE()
   DBSELECTAR("6")
   DBCLOSEARE()
   DBSELECTAR("7")
   DBCLOSEARE()
   DBSELECTAR("8")
   DBCLOSEARE()
   DBSELECTAR("9")
   DBCLOSEARE()

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: CAMCONOC
   Params: None.
   Return: Undefined
  Example: CAMCONOC()
  ..........................................................................
*/

PROCEDURE CAMCONOC()

   SET(3, 0)
   MENU()
   DEVPOS(6, 20)
   DEVOUT("MODIFICANDO CONSECUTIVO DE ORDENES DE COMPRA")
   __MRESTORE("&ZDIS\&WDIRECTO\NUMORD", .T.)
   SET(3, 0)
   SETCOLOR("+GR")
   DEVPOS(12, 20)
   DEVOUT("ULTIMO")
   SETCOLOR("W")
   DEVPOS(12, 28)
   DEVOUT("NUMERO DE DOCUMENTO EMITIDO : ")
   DEVPOS(14, 20)
   DEVOUT("# DE ORDEN ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "NUMORDCI", NIL, NIL, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}
   MEMVAR->WCLA := " "
   SETCOLOR("+GR")
   DEVPOS(20, 20)
   DEVOUT("GRACIAS")
   SETCOLOR("W")
   FERASE("&ZDIS\&WDIRECTO\NUMORD.MEM")
   __MSAVE("&ZDIS\&WDIRECTO\NUMORD", "NUMORD?I", .T.)
   MENU()
   SET(3, 2)
   MEMVAR->OPC := " "

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: APAMOS
   Params: None.
   Return: Undefined
  Example: APAMOS()
  ..........................................................................
*/

PROCEDURE APAMOS()

   DBSELECTAR("9")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\PAGOSMO", NIL, .T., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\PAGOSMO", NIL, .T., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE PAGOS pagosmo.")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: RUTTC
   Params: None.
   Return: Undefined
  Example: RUTTC()
  ..........................................................................
*/

PROCEDURE RUTTC()

   MEMVAR->TC := " "
   DEVPOS(20, 10)
   DEVOUT("ESTA TODO CORRECTO ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "TC", "@!", {||TC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MANCON
   Params: None.
   Return: Undefined
  Example: MANCON()
  ..........................................................................
*/

PROCEDURE MANCON()

   MEMVAR->OPC := 1

   DO WHILE OPC <> 3

      MENU()
      MEMVAR->OPC := 3
      DEVPOS(4, 1)
      DEVOUT(PADC("MANEJO DE ARCHIVO DE CONTROL DE PAGOS DE TAREAS", 78))
      __ATPROMPT(12, 25, "1. INFORME DE REPORTES EXCEDIDOS", NIL)
      __ATPROMPT(13, 25, "2. DAR DE BAJA INFORMACION", NIL)
      __ATPROMPT(14, 25, "3. FIN", NIL)
      MEMVAR->OPC := __MENUTO({|BL1|IF(PCOUNT() == 0, OPC, MEMVAR->OPC := ;
            BL1)}, "OPC")

      IF OPC = 3 .OR. OPC = 0

         EXIT

      ENDIF

      IF OPC = 1

         CONEX()

      ELSEIF OPC = 2

         BAJEX()

      ENDIF

   ENDDO

   MEMVAR->OPC := "1"

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ESPERE
   Params: None.
   Return: Undefined
  Example: ESPERE()
  ..........................................................................
*/

PROCEDURE ESPERE()

   SETCOLOR("*+W")
   DEVPOS(22, 1)
   DEVOUT(PADC("* * *  POR FAVOR ESPERE UN MOMENTO   * * *", 78))
   SETCOLOR("+W")

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AMAINS
   Params: None.
   Return: Undefined
  Example: AMAINS()
  ..........................................................................
*/

PROCEDURE AMAINS()

   DBSELECTAR("2")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\&FMAINSU", NIL, .T., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\&FMAINSU", NIL, .T., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE INSUMOS")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ACOSE
   Params: None.
   Return: Undefined
  Example: ACOSE()
  ..........................................................................
*/

PROCEDURE ACOSE()

   DBSELECTAR("13")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\COSTOS", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\COSTOS", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE COSTOS")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AMOVMESE
   Params: None.
   Return: Undefined
  Example: AMOVMESE()
  ..........................................................................
*/

PROCEDURE AMOVMESE()

   DBSELECTAR("14")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\&FMOVINS", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\&FMOVINS", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO MENSUAL DE MOVIMIENTOS")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AMVPRSE
   Params: None.
   Return: Undefined
  Example: AMVPRSE()
  ..........................................................................
*/

PROCEDURE AMVPRSE()

   DBSELECTAR("6")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MOVPRSEM", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MOVPRSEM", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE MOVIMIENTO DE LA SEMANA")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: SAP
   Params: None.
   Return: Undefined
  Example: SAP()
  ..........................................................................
*/

PROCEDURE SAP()

   __DBZAP()

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ATIPMOVS
   Params: None.
   Return: Undefined
  Example: ATIPMOVS()
  ..........................................................................
*/

PROCEDURE ATIPMOVS()

   DBSELECTAR("12")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\TIPMOVPR", NIL, .T., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\TIPMOVPR", NIL, .T., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE TIPOS DE MOVIMIENTO")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AINPES
   Params: None.
   Return: Undefined
  Example: AINPES()
  ..........................................................................
*/

PROCEDURE AINPES()

   DBSELECTAR("4")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\INSPEND", NIL, .T., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\INSPEND", NIL, .T., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE INSUMOS PENDIENTES")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: VEAVALTO
   Params: None.
   Return: Undefined
  Example: VEAVALTO()
  ..........................................................................
*/

PROCEDURE VEAVALTO()

   MEMVAR->WVALTOT := IF(WCAN = 0, WVALUNI, ROUND(WVALUNI * WCAN, 2))

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: VEAUNITA
   Params: None.
   Return: Undefined
  Example: VEAUNITA()
  ..........................................................................
*/

PROCEDURE VEAUNITA()

   MEMVAR->WCOSUNITA := IF(SALDOUNI <> 0, ROUND(SALDOPES / SALDOUNI, 2), ;
         SALDOPES)
   MEMVAR->WCOSSALEN := ROUND(WCOSUNITA * WCANMOV, 2)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: VEALOCK
   Params: None.
   Return: Undefined
  Example: VEALOCK()
  ..........................................................................
*/

PROCEDURE VEALOCK()

   LOCK()

   DO WHILE  .NOT. LOCK()

      LOCK()

      IF  .NOT. LOCK()

         SCROLL(23, 1, 23, 78)
         SETPOS(23, 1)
         DEVPOS(23, 5)
         DEVOUT("POR FAVOR ESPERE, EL REGISTRO ESTA OCUPADO..." + DBF())

      ELSE

         SCROLL(23, 1, 23, 78)
         SETPOS(23, 1)

      ENDIF

   ENDDO


RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ADI6
   Params: None.
   Return: Undefined
  Example: ADI6()
  ..........................................................................
*/

PROCEDURE ADI6()

   AMVPRSS()
   DBAPPEND()
   FIELD->CODNUM := WCODNUM
   FIELD->CODIGO := WCOD
   FIELD->NUMCOLOR := WNUMCOL
   FIELD->TIPOMOV := WTIPMOV
   FIELD->NUMDOC := WNUMDOC
   FIELD->FECHA := WFECPRO
   FIELD->CANTIDAD := WCAN
   FIELD->VALUNI := WVALUNI
   FIELD->VALTOT := WVALTOT
   FIELD->NOMINS := WNOMBRE
   FIELD->NUMORDPR := ZNUMORD
   FIELD->CODPROV := WCODPROV
   FIELD->NUMPROV := VAL(WCODPROV)
   FIELD->COSPRO := WCOSUNITA
   FIELD->NOMBRE := WNOMBRE
   FIELD->NUMORDPRO := ALLTRIM(TRANSFORM(ZNUMORD, "99999999"))
   FIELD->CODUSU := WCODUSU
   FIELD->HORA := TIME()
   DBCOMMITAL()

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ACOSS
   Params: None.
   Return: Undefined
  Example: ACOSS()
  ..........................................................................
*/

PROCEDURE ACOSS()

   DBSELECTAR("13")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\COSTOS", NIL, .T., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\COSTOS", NIL, .T., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE COSTOS")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AOPTES
   Params: None.
   Return: Undefined
  Example: AOPTES()
  ..........................................................................
*/

PROCEDURE AOPTES()

   DBSELECTAR("5")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\ORDPRTEM", NIL, .T., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\ORDPRTEM", NIL, .T., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO TEMPORAL DE O.P.")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ADI8
   Params: None.
   Return: Undefined
  Example: ADI8()
  ..........................................................................
*/

PROCEDURE ADI8()

   AMVCOSS()
   DBAPPEND()
   FIELD->CODNUM := WCODNUM
   FIELD->CODIGO := WCOD
   FIELD->NUMCOLOR := WNUMCOL
   FIELD->TIPOMOV := WTIPMOV
   FIELD->FECHA := WFECPRO
   FIELD->CANTIDAD := WCAN
   FIELD->VALUNI := WCOSUNITA
   FIELD->VALTOT := WCOSSALEN
   FIELD->NUMORDPR := WNUMORD
   FIELD->NOMINS := WNOMBRE
   FIELD->NUMORD := ZNUMORD
   FIELD->CODUSU := WCODUSU
   FIELD->HORA := TIME()

   IF SWMV = 1

      FIELD->CANTIDAD :=  -WCAN
      FIELD->VALTOT :=  -WVALENTRA

   ENDIF

   DBCLOSEARE()
   DBCOMMITAL()

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AINPEE
   Params: None.
   Return: Undefined
  Example: AINPEE()
  ..........................................................................
*/

PROCEDURE AINPEE()

   DBSELECTAR("4")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\INSPEND", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\INSPEND", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE INSUMOS PENDIENTES")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AMVCOSS
   Params: None.
   Return: Undefined
  Example: AMVCOSS()
  ..........................................................................
*/

PROCEDURE AMVCOSS()

   DBSELECTAR("8")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MOVCOS", NIL, .T., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MOVCOS", NIL, .T., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE MOVIMIENTO DE COSTOS")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AMAINE
   Params: None.
   Return: Undefined
  Example: AMAINE()
  ..........................................................................
*/

PROCEDURE AMAINE()

   DBSELECTAR("2")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\&FMAINSU", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\&FMAINSU", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE INSUMOS")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AOPTEE
   Params: None.
   Return: Undefined
  Example: AOPTEE()
  ..........................................................................
*/

PROCEDURE AOPTEE()

   DBSELECTAR("5")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\ORDPRTEM", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\ORDPRTEM", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO TEMPORAL DE O.P.")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: BORPICO
   Params: None.
   Return: Undefined
  Example: BORPICO()
  ..........................................................................
*/

PROCEDURE BORPICO()

   IF FILE("&ZDIS\&WDIRECTO\PICO.NTX")

      FERASE("&ZDIS\&WDIRECTO\PICO.NTX")

   ENDIF


RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AMAPAE
   Params: None.
   Return: Undefined
  Example: AMAPAE()
  ..........................................................................
*/

PROCEDURE AMAPAE()

   DBSELECTAR("1")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MAEPAR", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MAEPAR", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE INSUMOS POR PRODUCTO")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: BORPRVX
   Params: None.
   Return: Undefined
  Example: BORPRVX()
  ..........................................................................
*/

PROCEDURE BORPRVX()

   IF FILE("&ZDIS\&WDIRECTO\COD-PROV.NTX")

      FERASE("&ZDIS\&WDIRECTO\COD-PROV.NTX")

   ENDIF


RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AMAPRVE
   Params: None.
   Return: Undefined
  Example: AMAPRVE()
  ..........................................................................
*/

PROCEDURE AMAPRVE()

   DBSELECTAR("17")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MAPROV", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MAPROV", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE PROVEEDORES")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AMAPERE
   Params: None.
   Return: Undefined
  Example: AMAPERE()
  ..........................................................................
*/

PROCEDURE AMAPERE()

   DBSELECTAR("7")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MAEPERPL", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MAEPERPL", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE PESONAL DE PLANTA")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: BORPER
   Params: None.
   Return: Undefined
  Example: BORPER()
  ..........................................................................
*/

PROCEDURE BORPER()

   IF FILE("&ZDIS\&WDIRECTO\COD-PER.NTX")

      FERASE("&ZDIS\&WDIRECTO\COD-PER.NTX")

   ENDIF


RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ATAE
   Params: None.
   Return: Undefined
  Example: ATAE()
  ..........................................................................
*/

PROCEDURE ATAE()

   DBSELECTAR("3")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\TAREAS", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\TAREAS", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE TAREAS")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: BORPTC
   Params: None.
   Return: Undefined
  Example: BORPTC()
  ..........................................................................
*/

PROCEDURE BORPTC()

   IF FILE("&ZDIS\&WDIRECTO\PROTARCO.NTX")

      FERASE("&ZDIS\&WDIRECTO\PROTARCO.NTX")

   ENDIF


RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ATIPMOVE
   Params: None.
   Return: Undefined
  Example: ATIPMOVE()
  ..........................................................................
*/

PROCEDURE ATIPMOVE()

   DBSELECTAR("12")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\TIPMOVPR", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\TIPMOVPR", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE TIPOS DE MOVIMIENTO")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AMAIBKE
   Params: None.
   Return: Undefined
  Example: AMAIBKE()
  ..........................................................................
*/

PROCEDURE AMAIBKE()

   DBSELECTAR("19")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MAINSBAK", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MAINSBAK", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE RESPALDO DE INSUMOS")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ADEMASE
   Params: None.
   Return: Undefined
  Example: ADEMASE()
  ..........................................................................
*/

PROCEDURE ADEMASE()

   DBSELECTAR("21")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\PAGDEMAS", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\PAGDEMAS", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE PAGOS EXCEDIDOS")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

   IF FILE("&ZDIS\&WDIRECTO\PAGDEMAS.KEY")

      FERASE("&ZDIS\&WDIRECTO\PAGDEMAS.KEY")

   ENDIF

   DBCREATEIN("&ZDIS\&WDIRECTO\PAGDEMAS.KEY", "CODTAR+LETORD", {||CODTAR + ;
         LETORD}, NIL)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AMAQE
   Params: None.
   Return: Undefined
  Example: AMAQE()
  ..........................................................................
*/

PROCEDURE AMAQE()

   DBSELECTAR("22")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MAQUINAS", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MAQUINAS", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE MAQUINAS")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

   IF FILE("&ZDIS\&WDIRECTO\MAQUINAS.KEY")

      FERASE("&ZDIS\&WDIRECTO\MAQUINAS.KEY")

   ENDIF

   DBCREATEIN("&ZDIS\&WDIRECTO\MAQUINAS.KEY", "CODMAQ", {||CODMAQ}, NIL)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AP6030E
   Params: None.
   Return: Undefined
  Example: AP6030E()
  ..........................................................................
*/

PROCEDURE AP6030E()

   DBSELECTAR("23")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\PAG6030", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\PAG6030", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE PAGOS DE LOS ESPECIALES")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

   IF FILE("&ZDIS\&WDIRECTO\PAG6030.KEY")

      FERASE("&ZDIS\&WDIRECTO\PAG6030.KEY")

   ENDIF

   DBCREATEIN("&ZDIS\&WDIRECTO\PAG6030.KEY", "CODTAR+LETORD", {||CODTAR + ;
         LETORD}, NIL)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AHP63E
   Params: None.
   Return: Undefined
  Example: AHP63E()
  ..........................................................................
*/

PROCEDURE AHP63E()

   DBSELECTAR("24")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\HISPAG63", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\HISPAG63", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO HISTORICO DE PAGOS DE LOS ESPECIALES")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

   IF FILE("&ZDIS\&WDIRECTO\HISPAG63.KEY")

      FERASE("&ZDIS\&WDIRECTO\HISPAG63.KEY")

   ENDIF

   DBCREATEIN("&ZDIS\&WDIRECTO\HP63.KEY", "CODTAR+LETORD", {||CODTAR + ;
         LETORD}, NIL)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AP6030S
   Params: None.
   Return: Undefined
  Example: AP6030S()
  ..........................................................................
*/

PROCEDURE AP6030S()

   DBSELECTAR("23")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\PAG6030", NIL, .T., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\PAG6030", NIL, .T., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE PAGOS DE LOS ESPECIALES")

   ENDDO

   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\PAG6030.KEY")
   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AMAPAS
   Params: None.
   Return: Undefined
  Example: AMAPAS()
  ..........................................................................
*/

PROCEDURE AMAPAS()

   DBSELECTAR("1")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MAEPAR", NIL, .T., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MAEPAR", NIL, .T., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE INSUMOS POR PRODUCTO")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: PIDEIMP
   Params: None.
   Return: Undefined
  Example: PIDEIMP()
  ..........................................................................
*/

PROCEDURE PIDEIMP()

   SETCOLOR("+W")
   SCROLL(20, 1, 23, 78)
   SETPOS(20, 1)
   DEVPOS(22, 20)
   DEVOUT("POR FAVOR ALISTE LA IMPRESORA, Y PULSE UNA TECLA ")
   MEMVAR->X := INKEY(0)
   SCROLL(20, 1, 23, 78)
   SETPOS(20, 1)
   VEAIMP()

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ENIM
   Params: None.
   Return: Undefined
  Example: ENIM()
  ..........................................................................
*/

PROCEDURE ENIM()

   MEMVAR->WAB := "BASURA.TXT"
   BA()
   SET(24, "C:\PROTMP\BASURA.TXT", .F.)
   SET(23, "ON")
   SET(20, "PRINTER")

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: APIM
   Params: None.
   Return: Undefined
  Example: APIM()
  ..........................................................................
*/

PROCEDURE APIM()

   SET(24, "")
   SET(23, "OFF")
   SET(20, "SCREEN")
   __RUN("TYPE C:\PROTMP\BASURA.TXT > PRN")
   MEMVAR->WAB := "BASURA.TXT"
   BA()

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: VEAIMP
   Params: None.
   Return: Undefined
  Example: VEAIMP()
  ..........................................................................
*/

PROCEDURE VEAIMP()

   MEMVAR->SWIMP := 0

   DO WHILE SWIMP = 0

      MEMVAR->WPR := ISPRINTER()

      IF  .NOT. WPR

         DEVPOS(22, 10)
         DEVOUT("LA IMPRESORA NO ESTA LISTA, VERIFIQUE...")
         MEMVAR->X := INKEY(0)
         SCROLL(17, 1, 23, 78)
         SETPOS(17, 1)
         LOOP

      ELSE

         MEMVAR->SWIMP := 1

      ENDIF

   ENDDO


RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AMAINER
   Params: None.
   Return: Undefined
  Example: AMAINER()
  ..........................................................................
*/

PROCEDURE AMAINER()

   DBSELECTAR("2")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\&FMAINSU", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\&FMAINSU", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE INSUMOS")

   ENDDO

   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\COD-INS")
   ORDLISTREB()
   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AMAIBKS
   Params: None.
   Return: Undefined
  Example: AMAIBKS()
  ..........................................................................
*/

PROCEDURE AMAIBKS()

   DBSELECTAR("19")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MAINSBAK", NIL, .T., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MAINSBAK", NIL, .T., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE RESPALDO DE INSUMOS ")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: BORMAIBK
   Params: None.
   Return: Undefined
  Example: BORMAIBK()
  ..........................................................................
*/

PROCEDURE BORMAIBK()

   IF FILE("&ZDIS\&WDIRECTO\MAINSU.BAK")

      FERASE("&ZDIS\&WDIRECTO\MAINSU.BAK")

   ENDIF


RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: FECHA
   Params: None.
   Return: Undefined
  Example: FECHA()
  ..........................................................................
*/

PROCEDURE FECHA()

   IF MONTH(WFECHA) = 1

      MEMVAR->WMESL := "ENERO"

   ELSEIF MONTH(WFECHA) = 2

      MEMVAR->WMESL := "FEBRERO"

   ELSEIF MONTH(WFECHA) = 3

      MEMVAR->WMESL := "MARZO"

   ELSEIF MONTH(WFECHA) = 4

      MEMVAR->WMESL := "ABRIL"

   ELSEIF MONTH(WFECHA) = 5

      MEMVAR->WMESL := "MAYO"

   ELSEIF MONTH(WFECHA) = 6

      MEMVAR->WMESL := "JUNIO"

   ELSEIF MONTH(WFECHA) = 7

      MEMVAR->WMESL := "JULIO"

   ELSEIF MONTH(WFECHA) = 8

      MEMVAR->WMESL := "AGOSTO"

   ELSEIF MONTH(WFECHA) = 9

      MEMVAR->WMESL := "SEPTIEMBRE"

   ELSEIF MONTH(WFECHA) = 10

      MEMVAR->WMESL := "OCTUBRE"

   ELSEIF MONTH(WFECHA) = 11

      MEMVAR->WMESL := "NOVIEMBRE"

   ELSEIF MONTH(WFECHA) = 12

      MEMVAR->WMESL := "DICIEMBRE"

   ENDIF

   MEMVAR->WDIA := ALLTRIM(TRANSFORM(DAY(WFECHA), "99")) + " de " + WMESL + ;
         " de " + ALLTRIM(TRANSFORM(YEAR(WFECHA), "9999"))

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AFACOSS
   Params: None.
   Return: Undefined
  Example: AFACOSS()
  ..........................................................................
*/

PROCEDURE AFACOSS()

   DBSELECTAR("15")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\FACCOSIN", NIL, .T., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\FACCOSIN", NIL, .T., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE FACTOR DE COSTOS")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: LISINSPR
   Params: None.
   Return: Undefined
  Example: LISINSPR()
  ..........................................................................
*/

PROCEDURE LISINSPR()

   MEMVAR->OPC := " "
   MENU()
   DEVPOS(12, 20)
   DEVOUT("Ahora se imprimira un listado de los insumos ")
   DEVPOS(13, 20)
   DEVOUT("por producto, desea continuar ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC <> "S"

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   ESPERE()
   MEMVAR->WAB := "BASURA.NTX"
   BA()
   AMAPAE()
   DBCREATEIN("C:\PROTMP\BASURA", "NUMART", {||NUMART}, NIL)
   __RUN("MODE LPT1:132,8")
   __REPORTFO("LISINSPR", .T., NIL, .F., NIL, NIL, NIL, NIL, .F., .F., NIL,;
          .F., .F.)
   DBCLOSEARE()
   __EJECT()
   __RUN("MODE LPT1:80,6")
   MEMVAR->OPC := " "
   MEMVAR->WAB := "BASURA.NTX"
   BA()

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ININPR
   Params: None.
   Return: Undefined
  Example: ININPR()
  ..........................................................................
*/

PROCEDURE ININPR()

   ESPERE()
   AMAPAE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
   ORDLISTREB()
   DBCLOSEARE()
   AMAINER()
   DBCLOSEARE()

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AMAPRVS
   Params: None.
   Return: Undefined
  Example: AMAPRVS()
  ..........................................................................
*/

PROCEDURE AMAPRVS()

   DBSELECTAR("17")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MAPROV", NIL, .T., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MAPROV", NIL, .T., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE PROVEEDORES")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: CARVPR
   Params: None.
   Return: Undefined
  Example: CARVPR()
  ..........................................................................
*/

PROCEDURE CARVPR()

   MEMVAR->WCOD := CODIGO
   MEMVAR->WNOMEST := NOMEST
   MEMVAR->WNOMPROV := NOMPROV
   MEMVAR->WDIR := DIRECCION
   MEMVAR->WTE1 := TELEFONO
   MEMVAR->WCIU := CIUDAD
   MEMVAR->WNIT := NIT
   MEMVAR->WHORATE := HORATE
   MEMVAR->WCONPAG := CONPAG
   MEMVAR->WDES := DESCUENTO
   MEMVAR->WSALDOCI := SALDOCI
   MEMVAR->WSALDOSI := SALDOSI
   MEMVAR->WULTFAC := ULTFAC
   MEMVAR->WCANCOP := RIGHT(LTRIM(STR(CANCOP)), 2)
   MEMVAR->WPOS17 := RECNO()

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AINTA
   Params: None.
   Return: Undefined
  Example: AINTA()
  ..........................................................................
*/

PROCEDURE AINTA()

   MENU()
   ESPERE()
   ATAE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\PROTARCO")
   ORDLISTREB()
   DBCLOSEARE()
   AMAPAE()
   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\CODMAEPA")
   ORDLISTREB()
   DBCLOSEARE()

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ATAS
   Params: None.
   Return: Undefined
  Example: ATAS()
  ..........................................................................
*/

PROCEDURE ATAS()

   DBSELECTAR("3")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\TAREAS", NIL, .T., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\TAREAS", NIL, .T., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE TAREAS")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AMAPERS
   Params: None.
   Return: Undefined
  Example: AMAPERS()
  ..........................................................................
*/

PROCEDURE AMAPERS()

   DBSELECTAR("7")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MAEPERPL", NIL, .T., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MAEPERPL", NIL, .T., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE PESONAL DE PLANTA")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AOCS
   Params: None.
   Return: Undefined
  Example: AOCS()
  ..........................................................................
*/

PROCEDURE AOCS()

   DBSELECTAR("16")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\ORDCOM", NIL, .T., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\ORDCOM", NIL, .T., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE ORDENES DE COMPRA")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AOCE
   Params: None.
   Return: Undefined
  Example: AOCE()
  ..........................................................................
*/

PROCEDURE AOCE()

   DBSELECTAR("16")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\ORDCOM", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\ORDCOM", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE ORDENES DE COMPRA")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ENIM0
   Params: None.
   Return: Undefined
  Example: ENIM0()
  ..........................................................................
*/

PROCEDURE ENIM0()

   MENU()
   MEMVAR->WT1 := "* * * I M P R I M I E N D O * * *"
   DEVPOS(12, (80 - LEN(WT1)) / 2)
   DEVOUT(WT1)
   MEMVAR->WAB := "BASURA.TXT"
   BA()
   SET(24, "C:\PROTMP\BASURA.TXT", .F.)
   SET(23, "ON")

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: APIM0
   Params: None.
   Return: Undefined
  Example: APIM0()
  ..........................................................................
*/

PROCEDURE APIM0()

   SET(24, "")
   SET(23, "OFF")
   __RUN("TYPE C:\PROTMP\BASURA.TXT > PRN")
   MEMVAR->WAB := "BASURA.TXT"
   BA()
   MEMVAR->OPC := 1

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: PROG9
   Params: None.
   Return: Undefined
  Example: PROG9()
  ..........................................................................
*/

PROCEDURE PROG9()

   MEMVAR->OPC := 1

   DO WHILE OPC <> 3

      MENU()
      MEMVAR->OPC := 3
      __ATPROMPT(14, 25, "1. ABRIR MES", NIL)
      __ATPROMPT(15, 25, "2. TRASLADAR SALDOS", NIL)
      __ATPROMPT(16, 25, "3. FIN", NIL)
      MEMVAR->OPC := __MENUTO({|BL1|IF(PCOUNT() == 0, OPC, MEMVAR->OPC := ;
            BL1)}, "OPC")

      IF OPC < 1 .OR. OPC > 2

         EXIT

      ENDIF

      MEMVAR->WNIV := "9" + ALLTRIM(TRANSFORM(OPC, "9")) + "   "
      MEMVAR->XS := " "
      VEANIV()

      IF XS = "N"

         MEMVAR->OPC := 1
         LOOP

      ENDIF

      MEMVAR->WPROG := "PROG9" + ALLTRIM(TRANSFORM(OPC, "99"))
      &WPROG()
      MEMVAR->OPC := 0

   ENDDO

   MEMVAR->OPC := " "

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AMOVMESS
   Params: None.
   Return: Undefined
  Example: AMOVMESS()
  ..........................................................................
*/

PROCEDURE AMOVMESS()

   DBSELECTAR("14")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\&FMOVINS", NIL, .T., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\&FMOVINS", NIL, .T., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO MENSUAL DE MOVIMIENTOS")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ADEMASS
   Params: None.
   Return: Undefined
  Example: ADEMASS()
  ..........................................................................
*/

PROCEDURE ADEMASS()

   DBSELECTAR("21")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\PAGDEMAS", NIL, .T., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\PAGDEMAS", NIL, .T., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE PAGOS EXCEDIDOS")

   ENDDO

   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\PAGDEMAS.KEY")
   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AMAQS
   Params: None.
   Return: Undefined
  Example: AMAQS()
  ..........................................................................
*/

PROCEDURE AMAQS()

   DBSELECTAR("22")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MAQUINAS", NIL, .T., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MAQUINAS", NIL, .T., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE MAQUINAS")

   ENDDO

   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\MAQUINAS.KEY")
   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: MODNOTMQ
   Params: None.
   Return: Undefined
  Example: MODNOTMQ()
  ..........................................................................
*/

PROCEDURE MODNOTMQ()

   __XSAVESCR()
   SCROLL(12, 7, 23, 69)
   SETPOS(12, 7)
   DISPBOX(12, 7, 23, 69, 2)
   DEVPOS(8, 1)
   DEVOUT(PADC("<< PRONTUARIO DE LA MAQUINA " + ALLTRIM(WNOMBRE) + " >>", ;
         78))
   MEMVAR->N := NOTAS

   IF SWLEE = 0

      MEMVAR->T := MEMOEDIT(NOTAS, 10, 2, 21, 60, .F.)
      DEVPOS(6, 1)
      DEVOUT(PADC("<< Comentarios >>", 78))

   ELSE

      SETCOLOR("+GR")
      DEVPOS(11, 1)
      DEVOUT(PADC("Ctrl-w : graba,   ESC : cancela", 78))
      SETCOLOR("+W")
      FIELD->NOTAS := MEMOEDIT(N, 13, 8, 22, 68, .T., NIL, 60)
      DBCOMMITAL()

   ENDIF

   SCROLL()
   SETPOS(0, 0)
   READKILL(.T.)
   MEMVAR->GETLIST := {}
   __XRESTSCR()

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AHP63S
   Params: None.
   Return: Undefined
  Example: AHP63S()
  ..........................................................................
*/

PROCEDURE AHP63S()

   DBSELECTAR("24")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\HISPAG63", NIL, .T., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\HISPAG63", NIL, .T., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO HISTORICO DE PAGOS DE LOS ESPECIALES")

   ENDDO

   ORDLISTCLE()
   ORDLISTADD("&ZDIS\&WDIRECTO\HP63.KEY")
   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: PRO2
   Params: None.
   Return: Undefined
  Example: PRO2()
  ..........................................................................
*/

PROCEDURE PRO2()


RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: SALVAOPT
   Params: None.
   Return: Undefined
  Example: SALVAOPT()
  ..........................................................................
*/

PROCEDURE SALVAOPT()

   IF  .NOT. FILE("HORDPRTE.DBF")

      AOPTES()
      __DBCOPY("HORDPRTE.DBF", {}, NIL, NIL, NIL, NIL, .F., NIL)
      DBCLOSEARE()

   ELSE

      DBSELECTAR("5")
      DBUSEAREA(.F., NIL, "HORDPRTE", NIL, NIL, .F.)
      __DBAPP("&ZDIS\&WDIRECTO\ORDPRTEM", {}, NIL, NIL, NIL, NIL, .F., NIL)
      DBCLOSEARE()

   ENDIF

   AOPTEE()
   SAP()
   DBCLOSEARE()

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: VESAUN
   Params: None.
   Return: Undefined
  Example: VESAUN()
  ..........................................................................
*/

PROCEDURE VESAUN()

   IF SALDOUNI > 0

      MEMVAR->WVUNI := IF(SALDOPES > 0, ROUND(SALDOPES / SALDOUNI, 2), ;
            ROUND(COSTO1, 2))

   ELSE

      MEMVAR->WVUNI := COSTO1

   ENDIF


RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AMVCOSE
   Params: None.
   Return: Undefined
  Example: AMVCOSE()
  ..........................................................................
*/

PROCEDURE AMVCOSE()

   DBSELECTAR("8")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MOVCOS", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MOVCOS", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE MOVIMIENTO DE COSTOS")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AMOPAE
   Params: None.
   Return: Undefined
  Example: AMOPAE()
  ..........................................................................
*/

PROCEDURE AMOPAE()

   DBSELECTAR("11")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MOVPAG", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MOVPAG", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE MOVIMIENTO DE PAGOS movpag.")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AMOPAS
   Params: None.
   Return: Undefined
  Example: AMOPAS()
  ..........................................................................
*/

PROCEDURE AMOPAS()

   DBSELECTAR("11")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MOVPAG", NIL, .T., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MOVPAG", NIL, .T., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE MOVIMIENTO DE PAGOS movpag.")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AMVOPE
   Params: None.
   Return: Undefined
  Example: AMVOPE()
  ..........................................................................
*/

PROCEDURE AMVOPE()

   DBSELECTAR("25")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MOVIORDE", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\MOVIORDE", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE ENTRADAS DE P.T. (Moviorde)")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: AFACOSE
   Params: None.
   Return: Undefined
  Example: AFACOSE()
  ..........................................................................
*/

PROCEDURE AFACOSE()

   DBSELECTAR("15")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\FACCOSIN", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\FACCOSIN", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE FACTOR DE COSTOS")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: APAMOE
   Params: None.
   Return: Undefined
  Example: APAMOE()
  ..........................................................................
*/

PROCEDURE APAMOE()

   DBSELECTAR("9")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\PAGOSMO", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\PAGOSMO", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE PAGOS pagosmo.")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: APAGAE
   Params: None.
   Return: Undefined
  Example: APAGAE()
  ..........................................................................
*/

PROCEDURE APAGAE()

   DBSELECTAR("10")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\PAGAR", NIL, .F., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\PAGAR", NIL, .F., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE PAGOS pagar.")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: APAGAS
   Params: None.
   Return: Undefined
  Example: APAGAS()
  ..........................................................................
*/

PROCEDURE APAGAS()

   DBSELECTAR("10")
   DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\PAGAR", NIL, .T., .F.)

   DO WHILE NETERR()

      DBUSEAREA(.F., NIL, "&ZDIS\&WDIRECTO\PAGAR", NIL, .T., .F.)
      DEVPOS(23, 10)
      DEVOUT("ESPERANDO ARCHIVO DE PAGOS pagar.")

   ENDDO

   SCROLL(23, 1, 23, 78)
   SETPOS(23, 1)

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: PRO3
   Params: None.
   Return: Undefined
  Example: PRO3()
  ..........................................................................
*/

PROCEDURE PRO3()


RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ENIM0A
   Params: None.
   Return: Undefined
  Example: ENIM0A()
  ..........................................................................
*/

PROCEDURE ENIM0A()

   MENU()
   MEMVAR->WT1 := "* * * I M P R I M I E N D O * * *"
   DEVPOS(12, (80 - LEN(WT1)) / 2)
   DEVOUT(WT1)
   SET(24, "C:\PROTMP\BASURA.TXT", .T.)
   SET(23, "ON")

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: APIM0A
   Params: None.
   Return: Undefined
  Example: APIM0A()
  ..........................................................................
*/

PROCEDURE APIM0A()

   SET(24, "")
   SET(23, "OFF")
   MEMVAR->OPC := 1

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: ENIMA
   Params: None.
   Return: Undefined
  Example: ENIMA()
  ..........................................................................
*/

PROCEDURE ENIMA()

   MENU()
   MEMVAR->WT1 := "* * * I M P R I M I E N D O * * *"
   DEVPOS(12, (80 - LEN(WT1)) / 2)
   DEVOUT(WT1)
   SET(24, "C:\PROTMP\BASURA.TXT", .T.)
   SET(23, "ON")
   SET(20, "PRINTER")

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: APIMA
   Params: None.
   Return: Undefined
  Example: APIMA()
  ..........................................................................
*/

PROCEDURE APIMA()

   SET(24, "")
   SET(23, "OFF")
   SET(20, "SCREEN")

RETURN 

/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: PROG72
   Params: None.
   Return: Undefined
  Example: PROG72()
  ..........................................................................
*/

PROCEDURE PROG72()

   MEMVAR->OPC := 1

   DO WHILE OPC <> 2

      MENU()
      MEMVAR->OPC := 2
      DEVPOS(4, 1)
      DEVOUT(PADC("MENU DE AUDITORIAS", 78))
      __ATPROMPT(12, 15, "1. AUDITORIA ENTRE MAESTRO Y MOVIMIENTO", NIL)
      __ATPROMPT(13, 15, "2. FIN", NIL)
      MEMVAR->OPC := __MENUTO({|BL1|IF(PCOUNT() == 0, OPC, MEMVAR->OPC := ;
            BL1)}, "OPC")

      IF OPC > 1 .OR. OPC = 0

         EXIT

      ENDIF

      MEMVAR->WNIV := "72" + ALLTRIM(TRANSFORM(OPC, "9")) + "  "
      MEMVAR->XS := " "
      VEANIV()

      IF XS = "N"

         MEMVAR->OPC := " "
         LOOP

      ENDIF

      MEMVAR->WPRO := "AUD" + ALLTRIM(TRANSFORM(OPC, "9"))
      &WPRO()

   ENDDO

   MEMVAR->OPC := " "

RETURN 

