@ECHO OFF
REM ==================================================================
REM  COMPILAR.BAT - Genera PRO.EXE (Harbour, Windows x64)
REM
REM  Uso:  COMPILAR          compila lo que cambio
REM        COMPILAR TODO     compila todo de nuevo
REM
REM  Requiere Harbour 3.2 para Windows de 64 bits y el compilador C
REM  MinGW-w64 (gcc de 64 bits), en el PATH o instalados en las carpetas
REM  que indican HB_DIR y MINGW_DIR (abajo).
REM  Ver docs\COMPILAR_EN_WINDOWS.md.
REM ==================================================================

SETLOCAL

REM ---- Carpeta de Harbour (ajustar si es otra)
SET HB_DIR=C:\hb32

REM ---- Carpeta de MinGW-w64 (ajustar si es otra)
SET MINGW_DIR=C:\mingw64

IF EXIST "%HB_DIR%\bin\hbmk2.exe" SET PATH=%HB_DIR%\bin;%PATH%
IF EXIST "%MINGW_DIR%\bin\gcc.exe" SET PATH=%MINGW_DIR%\bin;%PATH%

hbmk2 -version >NUL 2>&1
IF ERRORLEVEL 1 GOTO :SIN_HARBOUR

gcc --version >NUL 2>&1
IF ERRORLEVEL 1 GOTO :SIN_MINGW

SET OPCION=
IF /I "%1"=="TODO" SET OPCION=-rebuild

ECHO.
ECHO  Compilando PRO.EXE con Harbour...
ECHO.
hbmk2 pro.hbp -comp=mingw64 %OPCION%
IF ERRORLEVEL 1 GOTO :FALLO
IF NOT EXIST PRO.EXE GOTO :FALLO

ECHO.
ECHO  COMPILACION CORRECTA: %CD%\PRO.EXE
ECHO.
ECHO  Antes de instalarlo, respalde el ejecutable que este en uso.
GOTO :FIN_OK

:SIN_HARBOUR
ECHO  ERROR: no se encontro hbmk2 (Harbour).
ECHO  Instale Harbour 3.2 para Windows x64 y ajuste la linea
ECHO  SET HB_DIR= al principio de este archivo.
GOTO :FIN_ERROR

:SIN_MINGW
ECHO  ERROR: no se encontro gcc (MinGW-w64).
ECHO  Instale MinGW-w64 de 64 bits y ajuste la linea
ECHO  SET MINGW_DIR= al principio de este archivo.
GOTO :FIN_ERROR

:FALLO
ECHO.
ECHO  ERROR: la compilacion fallo. Revise los mensajes de arriba.
IF EXIST PRO.EXE DEL PRO.EXE
GOTO :FIN_ERROR

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
