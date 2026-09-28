@ECHO OFF
REM ==================================================================
REM  COMPILAR.BAT - Reconstruye PRO.EXE con CA-Clipper 5.2c + RTLink
REM
REM  Uso:  COMPILAR         compila los .PRG modificados y enlaza
REM        COMPILAR TODO    recompila todos los modulos
REM
REM  Ejecutar dentro de esta carpeta, copiada a una ruta corta y sin
REM  espacios (por ejemplo C:\PROSRC). El ejecutable queda en PRO.EXE
REM  de esta misma carpeta y el detalle completo en COMPILAR.LOG.
REM ==================================================================

SETLOCAL

REM ---- Carpeta donde esta instalado CA-Clipper 5.2 (ajustar si cambia)
SET CLIPPERHOME=C:\CLIPPER5

REM ---- Entorno para CLIPPER, RMAKE y RTLINK
SET PATH=%CLIPPERHOME%\BIN;%SystemRoot%\system32;%SystemRoot%
SET LIB=%CLIPPERHOME%\LIB
SET INCLUDE=%CLIPPERHOME%\INCLUDE
SET CLIPPERCMD=
SET OBJ=

ECHO.
ECHO  Reconstruccion de PRO.EXE - CA-Clipper 5.2c + RTLink
ECHO  -----------------------------------------------------
ECHO.

REM ---- Los programas DOS no admiten rutas con espacios
SET RUTA=%CD%
IF NOT "%RUTA%"=="%RUTA: =%" GOTO ERR_RUTA

IF NOT EXIST %CLIPPERHOME%\BIN\CLIPPER.EXE GOTO ERR_CLIPPER
IF NOT EXIST %CLIPPERHOME%\BIN\RMAKE.EXE GOTO ERR_CLIPPER
IF NOT EXIST %CLIPPERHOME%\BIN\RTLINK.EXE GOTO ERR_CLIPPER
IF NOT EXIST %CLIPPERHOME%\LIB\CLIPPER.LIB GOTO ERR_CLIPPER
IF NOT EXIST PRO.RMK GOTO ERR_CARPETA
IF NOT EXIST PRO.LNK GOTO ERR_CARPETA
IF NOT EXIST MAIN.PRG GOTO ERR_CARPETA

REM ---- Archivos temporales del compilador y del enlazador
IF NOT EXIST TMP\NUL MD TMP
SET TMP=%CD%\TMP
SET TEMP=%CD%\TMP

SET FORZAR=
IF /I "%1"=="TODO" SET FORZAR=/F

ECHO  Compilando y enlazando, espere...
RMAKE %FORZAR% PRO > COMPILAR.LOG
IF ERRORLEVEL 1 GOTO ERR_BUILD
IF NOT EXIST PRO.EXE GOTO ERR_BUILD

ECHO.
ECHO  COMPILACION CORRECTA: %CD%\PRO.EXE
ECHO.
ECHO  Antes de instalarlo, respalde el PRO.EXE de produccion
ECHO  (por ejemplo C:\PRO\PRO.EXE) y luego copie este en su lugar.
GOTO FIN_OK

:ERR_RUTA
ECHO  ERROR: la ruta de esta carpeta contiene espacios:
ECHO         %CD%
ECHO  Copie la carpeta a una ruta corta, por ejemplo C:\PROSRC
GOTO FIN_ERROR

:ERR_CLIPPER
ECHO  ERROR: no se encontro CA-Clipper completo en %CLIPPERHOME%
ECHO  Se necesitan BIN\CLIPPER.EXE, BIN\RMAKE.EXE, BIN\RTLINK.EXE
ECHO  y LIB\CLIPPER.LIB. Si Clipper esta en otra carpeta, corrija
ECHO  la linea SET CLIPPERHOME= al principio de este archivo.
GOTO FIN_ERROR

:ERR_CARPETA
ECHO  ERROR: falta PRO.RMK, PRO.LNK o MAIN.PRG en esta carpeta.
ECHO  Ejecute COMPILAR.BAT dentro de la carpeta PROSRC.
GOTO FIN_ERROR

:ERR_BUILD
ECHO  ERROR: fallo la compilacion o el enlace. Mensajes:
ECHO.
FINDSTR /I /C:"error" /C:"fatal" /C:"warning" /C:"undefined" /C:".OBJ" COMPILAR.LOG
ECHO.
ECHO  Detalle completo en COMPILAR.LOG
REM RTLINK escribe PRO.EXE aunque falten simbolos: se borra para
REM que un ejecutable defectuoso no llegue a produccion.
IF EXIST PRO.EXE DEL PRO.EXE
GOTO FIN_ERROR

:FIN_ERROR
ECHO.
PAUSE
ENDLOCAL
EXIT /B 1

:FIN_OK
ECHO.
PAUSE
ENDLOCAL
EXIT /B 0
