/* ------ Rescue5 1.11 (c) APTware 1993,94 ------
     Name: CAMCOD
   Params: None.
   Return: Undefined
  Example: CAMCOD()
  ..........................................................................
*/

PROCEDURE CAMCOD()

   MENU()
   MEMVAR->WCLAVE := "        "
   SET(17, "OFF")
   DEVPOS(12, 10)
   DEVOUT("CLAVE DE ACCESO, es la misma del BROWSE ")
   MEMVAR->WCLAVE := __ACCEPT()
   SET(17, "ON")
   __MRESTORE("DATO", .T.)

   IF ALLTRIM(WCLAVE) <> ALLTRIM(DATO)

      MEMVAR->OPC := " "
      __MRELEASE("DATO?", .T.)
      RETURN 

   ENDIF

   __MRELEASE("DATO?", .T.)
   SCROLL()
   SETPOS(0, 0)
   READKILL(.T.)
   MEMVAR->GETLIST := {}
   MEMVAR->OPC := " "
   DEVPOS(1, 1)
   DEVOUT(PADC("Por favor lea con atenci" + O + "n:", 78))
   DEVPOS(2, 1)
   DEVOUT(PADC("Esta opci" + O + "n reemplaza c" + O + ;
         "digos anteriores de insumos por unos nuevos", 78))
   DEVPOS(3, 1)
   DEVOUT(PADC("Se reemplazar" + A + ;
         "n en los archivos que se indican a continuaci" + O + "n.", 78))
   DEVPOS(4, 10)
   DEVOUT("Desea continuar ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC = "N"

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   DBUSEAREA(.F., NIL, "BASE1", NIL, NIL, .F.)
   SCROLL()
   SETPOS(0, 0)
   READKILL(.T.)
   MEMVAR->GETLIST := {}
   DEVPOS(1, 1)
   DEVOUT(PADC(;
         "Por favor pulse la tecla DEL o SUPR para marcar como borrado el registro";
         , 78))
   DEVPOS(2, 1)
   DEVOUT(PADC(;
         "que corresponda a un archivo que NO SE HA DE AFECTAR. En la parte superior";
         , 78))
   DEVPOS(3, 1)
   DEVOUT(PADC("se indicar" + A + " cuales registros tienen la condici" + ;
         O + "n de borrado.", 78))
   DEVPOS(4, 1)
   DEVOUT(PADC("NO CAMBIE EL CONTENIDO DE NINGUN REGISTRO.", 78))
   DEVPOS(5, 1)
   DEVOUT(PADC("Antes de comenzar el proceso se pedir" + A + ;
         " una confirmaci" + O + "n", 78))
   BROWSE(7, 1, 23, 78)
   DBCLOSEARE()
   DBUSEAREA(.F., NIL, "BASE2", NIL, NIL, .F.)
   SCROLL()
   SETPOS(0, 0)
   READKILL(.T.)
   MEMVAR->GETLIST := {}
   DEVPOS(1, 1)
   DEVOUT(PADC("Ahora actualice los c" + O + ;
         "digos anteriores y nuevos seg" + U + "n lo haya definido.", 78))
   DEVPOS(2, 1)
   DEVOUT(PADC("El sistema leer" + A + ;
         " cada registro de cada uno de los archivos que no marc" + O + ;
         " antes", 78))
   DEVPOS(3, 1)
   DEVOUT(PADC("como borrados y cada uno de sus insumos ser" + A + ;
         " buscado en la tabla que est" + A, 78))
   DEVPOS(4, 1)
   DEVOUT(PADC(;
         "actualizando en este momento. El cambio es secuencial en cada uno de los DBFs";
         , 78))
   DEVPOS(5, 1)
   DEVOUT(PADC("as" + I + ;
         " que no hay problema con el orden en que Usted los ingrese ahora.";
         , 78))
   DEVPOS(6, 1)
   DEVOUT(PADC(;
         "Para eliminar registros pulse DEL. La marca de borrado aparecer" ;
         + A + " en la parte", 78))
   DEVPOS(7, 1)
   DEVOUT(PADC("Superior del cuadro de browse. Al terminar se hace autom" +;
          A + "tico el pack.", 78))
   DEVPOS(8, 1)
   DEVOUT(PADC("Antes de comenzar el proceso se pedir" + A + ;
         " una confirmaci" + O + "n", 78))
   BROWSE(9, 1, 23, 78)
   __DBPACK()
   DBCLOSEARE()
   MENU()
   MEMVAR->TMES := 0
   DEVPOS(12, 10)
   DEVOUT("DE QUE MES CAMBIA LOS CODIGOS ? ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "TMES", "@Z 999", NIL, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF TMES < 1 .OR. TMES > 12 .OR. LASTKEY() = 27

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   MENU()
   MEMVAR->OPC := " "
   SETCOLOR("*+GR")
   DEVPOS(10, 5)
   DEVOUT("Ultima confirmacion   ...   ultima confirmacion")
   SETCOLOR("+W")
   DEVPOS(12, 10)
   DEVOUT("YA ESTA TODO LISTO PARA COMENZAR, AUN DESEA CONTINUAR ? S/N ")
   SETPOSBS()
   AADD(GETLIST, __GET(NIL, "OPC", "@!", {||OPC $ "SN"}, NIL):DISPLAY())
   READMODAL(GETLIST)
   MEMVAR->GETLIST := {}

   IF OPC = "N"

      MEMVAR->OPC := " "
      RETURN 

   ENDIF

   DBSELECTAR("1")
   DBUSEAREA(.F., NIL, "BASE1", NIL, NIL, .F.)
   DBSELECTAR("2")
   DBUSEAREA(.F., NIL, "BASE2", NIL, NIL, .F.)

   IF FILE("BASU.KEY")

      FERASE("BASU.KEY")

   ENDIF

   DBCREATEIN("BASU.KEY", "CODANT", {||CODANT}, NIL)
   DBSELECTAR("1")

   DO WHILE  .NOT. EOF()

      MEMVAR->TNOMARC := LTRIM(TRIM(ARCHIVO))
      MEMVAR->WCAMPO1 := CAMPO1
      MEMVAR->WCAMPO2 := CAMPO2

      IF MES = "S"

         MEMVAR->TNOMARC := TNOMARC + LTRIM(TRIM(TRANSFORM(TMES, "99")))

      ENDIF

      MEMVAR->TNOMARC := TNOMARC + ".DBF"
      QOUT(TNOMARC)

      IF  .NOT. FILE("&TNOMARC")

         QOUT("archivo no existe ")
         QQOUT(TNOMARC)
         DBSELECTAR("1")
         DBSKIP(1)
         LOOP

      ENDIF

      DBSELECTAR("3")
      DBUSEAREA(.F., NIL, TNOMARC, NIL, NIL, .F.)

      DO WHILE  .NOT. EOF()

         DBSELECTAR("3")

         IF TNOMARC = "MAEPAR.DBF"

            MEMVAR->CC := 1

            DO WHILE CC < 21

               MEMVAR->WCAM := "CODINS" + LTRIM(TRIM(TRANSFORM(CC, "99")))

               IF (&(MEMVAR->WCAM)) = SPACE(4)

                  EXIT

               ENDIF

               MEMVAR->WCOD := (&(MEMVAR->WCAM))
               DBSELECTAR("2")
               DBSEEK("&WCOD")

               IF  .NOT. EOF()

                  MEMVAR->WCODNUE := CODNUE
                  DBSELECTAR("3")
                  FIELD->&(MEMVAR->WCAM) := WCODNUE

               ENDIF

               DBSELECTAR("3")
               ++MEMVAR->CC

            ENDDO

         ELSE

            MEMVAR->WCOD := (&(MEMVAR->WCAMPO1))
            DBSELECTAR("2")
            DBSEEK("&WCOD")

            IF  .NOT. EOF()

               MEMVAR->WCODNUE := CODNUE
               DBSELECTAR("3")
               FIELD->&(MEMVAR->WCAMPO1) := WCODNUE
               FIELD->&(MEMVAR->WCAMPO2) := VAL(WCODNUE)

            ENDIF

         ENDIF

         DBSELECTAR("3")
         DBSKIP(1)

      ENDDO

      DBSELECTAR("3")
      DBCLOSEARE()
      DBSELECTAR("1")
      DBSKIP(1)

   ENDDO

   DBCLOSEALL()
   MEMVAR->OPC := " "

RETURN 

