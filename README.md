# PRO — Sistema de Producción (código fuente)

Código fuente del Sistema de Producción de FASOR ASOCIADOS, recuperado del
ejecutable original de CA-Clipper 5.2c (`PRO.EXE`) con el descompilador
Rescue5 1.11.

El mismo programa se puede compilar de dos maneras:

- **Clipper**: el ejecutable original de DOS, para la PC con Windows XP.
- **Harbour**: un ejecutable nativo de 64 bits para Windows 7, 10 y 11, que no
  necesita DOS.

Cada una vive en su propia rama.

---

## Ramas

| Rama | Contenido | Compilador | El `PRO.exe` corre en |
|---|---|---|---|
| `main` | Los 124 módulos originales, tal como los recuperó Rescue5, sin cambios | CA-Clipper 5.2c + RTLink | DOS / Windows XP (32 bits) |
| `harbour` | Los mismos 124 módulos adaptados a Harbour, más 2 módulos de compatibilidad | Harbour 3.2 + MinGW-w64 | Windows 7, 10, 11 (64 bits) |
| *ramas de trabajo* | Un cambio cada una (por ejemplo `arreglo-orden-999`) | — | — |

### Por qué están separadas

- **`main` es el punto de partida y la versión de producción de las PC con XP.**
  Es el código tal como salió del ejecutable original. No se edita salvo que
  haya que corregir la versión Clipper.
- **`harbour` es `main` más un solo commit** ("Adaptación a Harbour x64") que
  reúne todo lo que hubo que cambiar para pasar a Harbour. Comparando las dos
  ramas se ve exactamente qué cambió y por qué (detalle en el `LEEME.TXT` de
  la rama `harbour`).
- **No hay una rama por sistema operativo.** Harbour se compila igual en
  Windows y en Linux: son los mismos fuentes y el mismo producto (un `PRO.exe`
  para Windows x64). Lo único que cambia es el script que se ejecuta, y los
  dos conviven en la rama `harbour`.

### Cómo trabajar

Los cambios nuevos se hacen a partir de `harbour`, cada uno en su propia rama:

```bash
git switch harbour
git switch -c arreglo-orden-999      # rama nueva para el cambio
# ... editar, compilar, probar ...
git add -A
git commit -m "Desempata las ordenes 999 por fecha"
git switch harbour
git merge arreglo-orden-999          # cuando el cambio está probado
```

Si un cambio también tiene que llegar a las PC con XP, hay que llevarlo a
`main` y compilarlo con Clipper. Mientras esas PC sigan en uso, conviene
mantener los cambios de `harbour` lo más acotados posible.

---

## Prerrequisitos y cómo compilar

| Versión | Dónde se compila | Guía completa |
|---|---|---|
| Clipper | PC con Windows XP | [`LEEME.TXT` de la rama `main`](https://github.com/FASOR-ASOCIADOS/PRO-CLIPPER-SOURCE-CODE/blob/main/LEEME.TXT) |
| Harbour | PC con Windows x64 | [`docs/COMPILAR_EN_WINDOWS.md`](https://github.com/FASOR-ASOCIADOS/PRO-CLIPPER-SOURCE-CODE/blob/harbour/docs/COMPILAR_EN_WINDOWS.md) |
| Harbour | PC con Linux (compilación cruzada) | [`docs/COMPILAR_EN_LINUX.md`](https://github.com/FASOR-ASOCIADOS/PRO-CLIPPER-SOURCE-CODE/blob/harbour/docs/COMPILAR_EN_LINUX.md) |

### 1. Clipper en Windows XP — rama `main`

**Requisitos**

| Requisito | Detalle |
|---|---|
| Sistema | Windows XP de 32 bits (o DOS). Los Windows de 64 bits no ejecutan programas de DOS. |
| CA-Clipper 5.2c | Instalado en `C:\CLIPPER5`, con `BIN\CLIPPER.EXE`, `BIN\RMAKE.EXE` y `BIN\RTLINK.EXE` |
| Librerías | En `C:\CLIPPER5\LIB`: `CLIPPER.LIB`, `EXTEND.LIB`, `DBFNTX.LIB`, `TERMINAL.LIB` |
| Carpeta del proyecto | En una ruta corta y **sin espacios** (por ejemplo `C:\PROSRC`): los programas de DOS no admiten espacios |
| Fin de línea | Los `.BAT`, `.RMK` y `.LNK` tienen que conservar CRLF, o fallan en XP |

Si Clipper está en otra carpeta, se ajusta la línea `SET CLIPPERHOME=` al
principio de `COMPILAR.BAT`.

**Compilar**

```
git switch main
C:
CD \PROSRC
COMPILAR TODO
```

Resultado: `PRO.EXE` de DOS, de 797.696 bytes. La primera compilación tarda un
par de minutos. Verificado en una copia de la PC con XP: los 124 módulos
compilan sin errores ni advertencias, y el ejecutable se comporta igual que el
original.

### 2. Harbour en Windows x64 — rama `harbour`

**Requisitos**

| Requisito | Detalle |
|---|---|
| Sistema | Windows de 64 bits. Verificado en Windows 7 Home Premium SP1 x64. |
| Harbour 3.2 para Windows x64 | Carpeta portable en `C:\hb32` (Harbour 3.2.1dev, commit `8d94c31`) |
| MinGW-w64 (compilador C) | Carpeta portable en `C:\mingw64`: WinLibs GCC 14.2.0 + MinGW-w64 12.0.0, runtime **msvcrt**, hilos win32. Para Windows 7 tiene que ser la variante `msvcrt`, no la `ucrt`. |
| Espacio en disco | ≈ 500 MB para las herramientas |
| Permisos | Usuario normal; no hace falta ser administrador ni instalar nada |

Ninguna de las dos herramientas tiene instalador: se copian a su carpeta y
funcionan. De dónde sale cada una se explica en la guía. Si están en otras
carpetas, se ajustan `SET HB_DIR=` y `SET MINGW_DIR=` al principio de
`COMPILAR.BAT`.

**Compilar**

```
git switch harbour
COMPILAR TODO
```

No hace falta tocar el PATH: `COMPILAR.BAT` lo arma solo. Tarda unos 25
segundos.

### 3. Harbour desde Linux — rama `harbour`

**Requisitos**

| Requisito | Detalle |
|---|---|
| Sistema | Linux x86-64. Verificado en Debian 13 (trixie). |
| Paquetes | `build-essential`, `make`, `git`, `gcc-mingw-w64-x86-64`, `binutils-mingw-w64-x86-64`, `mingw-w64-x86-64-dev` |
| Harbour 3.2 | Compilado desde el código fuente (commit `8d94c31`) dos veces: para Linux y, en forma cruzada, para Windows x64. Se instala en `~/.cache/pro-harbour/hb-linux`. Pasos en `docs/COMO_SE_ARMO_HARBOUR.txt`. |
| Espacio en disco | ≈ 300 MB para Harbour |
| Permisos | `sudo` sólo para instalar los paquetes; lo demás, usuario normal |
| Red | Sólo para instalar los paquetes y clonar Harbour de GitHub |

**Compilar**

```bash
git switch harbour
./compilar-linux.sh todo
```

El resultado es el mismo que en Windows: un `PRO.exe` para Windows x64. Se
puede probar en Linux con Wine; el procedimiento está en la guía.

### Qué es normal ver al compilar con Harbour

- Unas **9.800 advertencias** `W0001 Ambiguous reference`. Son propias del
  código descompilado y Harbour las resuelve igual que Clipper. No son errores.
- `PRO.exe` y la carpeta `.hbmk/` se generan al compilar y no se guardan en el
  repositorio.

---

## Instalar

| Versión | Qué se copia | Requisitos en la PC |
|---|---|---|
| Clipper | `PRO.EXE` | Windows XP (o DOS) |
| Harbour | `PRO.exe` | Windows de 64 bits. No necesita DLL extra: sólo usa las de Windows. |

Las dos versiones pueden trabajar sobre los mismos archivos de datos a la vez.
Antes de reemplazar un ejecutable en producción, respaldar el que está en uso.

---

## Al editar los fuentes

- Los `.PRG` están en **página de códigos 850** con fin de línea **CRLF**. El
  editor tiene que conservar las dos cosas (en VS Code:
  `"files.encoding": "cp850"`). Si se guardan en UTF-8 se rompen los acentos,
  la eñe y los recuadros de pantalla.
- `.gitattributes` impide que git convierta los fines de línea al clonar en
  Windows o en Linux. No hay que quitarlo.
- Probar siempre sobre una **copia** de los datos, nunca sobre los de
  producción.
- Mientras haya PC con el EXE de Clipper trabajando sobre los mismos datos, no
  cambiar la estructura de los DBF ni las claves de los índices.
- En la versión Harbour, los archivos temporales van en `C:\PROTMP`, nunca en la
  raíz de `C:` (Windows moderno no deja crear archivos ahí a un usuario normal).
