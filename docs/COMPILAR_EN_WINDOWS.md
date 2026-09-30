# Compilar PRO.exe en Windows

Cómo generar `PRO.exe` (Windows x64) directamente en una PC con Windows, a
partir de los fuentes de este repositorio (rama `harbour`).

Para compilar **desde Linux** ver `COMPILAR_EN_LINUX.md`. Las dos formas usan
los mismos fuentes y producen el mismo tipo de ejecutable.

---

## 1. Requisitos

| Requisito | Detalle |
|---|---|
| Windows de 64 bits | Probado en Windows 7 Home Premium SP1 x64. Debería funcionar igual en 10 y 11. |
| Harbour 3.2 para Windows x64 | En `C:\hb32` (ver 2.1) |
| MinGW-w64 (compilador C de 64 bits) | En `C:\mingw64` (ver 2.2) |
| Espacio en disco | ≈ 500 MB para las herramientas, ≈ 20 MB para compilar |
| Permisos | Usuario normal. No hace falta ser administrador. |

Las dos herramientas son **portables**: se copian a una carpeta y funcionan, sin
instalador ni cambios en el registro de Windows.

## 2. Las herramientas

### 2.1 Harbour 3.2 → `C:\hb32`

| Dato | Valor |
|---|---|
| Versión validada | Harbour 3.2.1dev, commit `8d94c31` de `github.com/harbour/core` |
| Contenido | `bin\` (`harbour.exe`, `hbmk2.exe`, `harbour-32-x64.dll`...), `include\`, `lib\win\mingw64\` |
| Tamaño | 227 archivos, 36 MB |

Harbour 3.2 no publica binarios oficiales recientes para Windows x64. La copia
validada se armó en Linux por compilación cruzada (ver
`COMO_SE_ARMO_HARBOUR.txt`, paso 3, y `COMPILAR_EN_LINUX.md`): es la carpeta
de instalación `hb-win64` que genera ese paso, copiada tal cual a `C:\hb32`.
**Conviene guardar una copia de esa carpeta**: es la que se probó.

### 2.2 MinGW-w64 → `C:\mingw64`

| Dato | Valor |
|---|---|
| Distribución | WinLibs: GCC 14.2.0 + MinGW-w64 12.0.0, runtime **msvcrt**, hilos win32, SEH, release r1 |
| Archivo | `winlibs-x86_64-win32-seh-gcc-14.2.0-mingw-w64msvcrt-12.0.0-r1.zip` (245.777.965 bytes) |
| Descarga | `https://github.com/brechtsanders/winlibs_mingw/releases/download/14.2.0win32-12.0.0-msvcrt-r1/winlibs-x86_64-win32-seh-gcc-14.2.0-mingw-w64msvcrt-12.0.0-r1.zip` |

Se descomprime y la carpeta `mingw64` que trae se copia a `C:\mingw64`.

**Por qué esta variante y no otra:**

- Misma versión mayor de GCC (14) y misma biblioteca de C (`msvcrt`) que la
  toolchain con la que se compilaron las bibliotecas de Harbour. Así los objetos
  del programa y los de Harbour son compatibles.
- Sus programas corren desde Windows 7. Las variantes `ucrt` necesitan
  Windows 10 (o una actualización aparte en 7).

**Recorte opcional** (de 871 MB a 416 MB): para compilar este programa sólo hace
falta C. Se pueden borrar `share\`, el `include\` de nivel superior, los
compiladores de C++, Fortran y Objective-C (`g++`, `gfortran`, `cc1plus`,
`f951`, `cc1obj`, `cc1objplus`), `gdb`, `cmake`, `ctest`, `cpack`, `doxygen`,
`cppcheck`, `lto-dump`, Python y los plugins de GCC. Hay que conservar `gcc`,
`cc1`, `collect2`, `as`, `ld`, `ar`, `windres`, `dlltool`, las cabeceras de
Windows y las bibliotecas `lib*.a`.

## 3. Compilar

1. Clonar o copiar el repositorio (rama `harbour`) a una carpeta, por ejemplo
   `C:\PRO_FUENTES`.
2. Abrir una consola (`cmd`) en esa carpeta.
3. Ejecutar:

   ```
   COMPILAR TODO
   ```

   `COMPILAR` sin `TODO` recompila sólo lo que cambió.

4. Debe terminar así:

   ```
   hbmk2: Compiling Harbour sources...
   hbmk2: Compiling...
   hbmk2: Linking... PRO.exe

    COMPILACION CORRECTA: C:\PRO_FUENTES\PRO.EXE
   ```

No hace falta tocar el PATH: `COMPILAR.BAT` agrega por su cuenta
`C:\hb32\bin` y `C:\mingw64\bin`. Si las herramientas están en otras carpetas,
se ajustan las líneas `SET HB_DIR=` y `SET MINGW_DIR=` al principio del
archivo.

### Qué es normal ver

- Unas **9.800 advertencias** `W0001 Ambiguous reference`. Son propias del código
  descompilado: referencias a campos sin prefijo, que Harbour resuelve igual que
  Clipper. No son errores.
- En una PC de 1 CPU, la compilación completa tarda alrededor de **25 segundos**.

## 4. Verificar el resultado

```
certutil -hashfile PRO.exe MD5
```

El MD5 cambia en cada compilación; no se compara contra un valor fijo. Lo que
tiene que cumplirse:

- `COMPILACION CORRECTA` y ningún `Error` en la salida.
- El programa abre su ventana "Sistema de Produccion" y pide
  `CODIGO DEL USUARIO`.

Probar siempre sobre una **copia** de los datos, nunca sobre los de producción.

## 5. Distribuir

`PRO.exe` no necesita ninguna DLL extra: sólo usa las de Windows (`KERNEL32`,
`USER32`, `GDI32`, `ADVAPI32`, `WINMM`, `msvcrt`). Se copia a la PC y se
ejecuta. **No corre en Windows XP**: esas PC siguen con el EXE de Clipper
(rama `main`).

Los ejecutables no se guardan en el repositorio. Si se quieren publicar, se usan
las *Releases* de GitHub.

## 6. Problemas frecuentes

| Mensaje | Causa | Solución |
|---|---|---|
| `ERROR: no se encontro hbmk2 (Harbour).` | Harbour no está en `C:\hb32` | Copiarlo ahí o corregir `SET HB_DIR=` |
| `ERROR: no se encontro gcc (MinGW-w64).` | MinGW-w64 no está en `C:\mingw64` | Copiarlo ahí o corregir `SET MINGW_DIR=` |
| `hbmk2: Error: Referenced, missing, but unknown function(s)` | Falta un alias de nombre truncado | Agregarlo en `HBCOMPAT.PRG` (ver `COMPILAR_EN_LINUX.md`, paso 5) |
| `gcc` no arranca en Windows 7 | Se instaló una variante `ucrt` de MinGW-w64 | Usar la variante `msvcrt` de la sección 2.2 |
| El `.BAT` salta a lugares raros o no encuentra etiquetas | `COMPILAR.BAT` quedó con fin de línea de Linux | El repositorio lo guarda con CRLF; no convertirlo (ver `.gitattributes`) |

## 7. Validación realizada

El 2026-09-28 se compiló con este procedimiento en la máquina virtual
`Fasor-Win7x64` (Windows 7 Home Premium SP1 x64, 1 CPU, 1,5 GB de RAM),
con un usuario sin privilegios de administrador y el PATH de fábrica:

| Concepto | Resultado |
|---|---|
| Errores | 0 |
| Advertencias | 9.792 `W0001` (las mismas que en la compilación desde Linux) |
| Duración | 25 s |
| Producto | `PE32+ executable (GUI) x86-64`, 3.001.560 bytes |
| Prueba funcional | Arranca, recorre menús, movimientos y la consulta general de órdenes con datos reales, usa `C:\PROTMP` para los temporales y sale limpio |

Comparado con el EXE compilado desde Linux, cambian el tamaño y el MD5 (cada
toolchain enlaza su propia versión del runtime de MinGW-w64), pero importa las
mismas DLL de Windows y se comporta igual. Los dos son intercambiables.

La evidencia (registros, capturas y los scripts con que se manejó la VM) quedó
en la carpeta de trabajo original, `FuentePro Rescu5/PruebaHarbour/win7x64_compilacion_sin_pdf/`,
fuera de este repositorio.
