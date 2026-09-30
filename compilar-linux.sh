#!/bin/bash
# ==================================================================
#  Genera PRO.exe (Harbour, Windows x64) desde Linux, por compilacion
#  cruzada con mingw-w64.
#
#    ./compilar-linux.sh           compila lo que cambio
#    ./compilar-linux.sh todo      compila todo de nuevo
#
#  Necesita:
#    - x86_64-w64-mingw32-gcc            (paquete mingw-w64)
#    - Harbour 3.2 compilado para Linux y para win/mingw64, en HB
#      (ver docs/COMO_SE_ARMO_HARBOUR.txt)
# ==================================================================
set -e

HB="${HB:-$HOME/.cache/pro-harbour/hb-linux}"
cd "$(dirname "$0")"

if [ ! -x "$HB/bin/hbmk2" ]; then
   echo "ERROR: no encuentro hbmk2 en $HB/bin"
   echo "       Indique la ruta con:  HB=/ruta/harbour ./compilar-linux.sh"
   exit 1
fi

OPCION=""
[ "${1,,}" = "todo" ] && OPCION="-rebuild"

# El .bashrc del usuario define HB_PLATFORM/HB_COMPILER para otra
# instalacion: hay que limpiarlos para no confundir a hbmk2.
env -u HB_PLATFORM -u HB_COMPILER -u HB_INSTALL_PREFIX \
    HB_CCPREFIX=x86_64-w64-mingw32- \
    "$HB/bin/hbmk2" pro.hbp -plat=win -comp=mingw64 $OPCION

echo
ls -la PRO.exe
file PRO.exe
