# 🧠 Fundamentos del Sistema: De Kernel a CLI

**Objetivo:** Entender CÓMO funciona tu sistema operativo ANTES de ejecutar comandos  
**Por qué este archivo primero:** No puedes usar bien una herramienta sin entender cómo funciona  
**Lo que aprenderás:** La arquitectura completa desde el hardware hasta el comando que escribes

---

## 🎯 **Filosofía de Este Documento**

> **"Cuando ejecutes un comando, debes saber QUÉ estás haciendo y POR QUÉ funciona"**

### ❌ **NO queremos:**
- Copiar comandos sin entender
- "Magia" que funciona pero no sabes por qué
- Ejecutar cosas que podrían romper tu sistema

### ✅ **SÍ queremos:**
- Entender cada capa del sistema
- Identificar qué herramienta usas en cada momento
- Verificar conceptos ejecutando comandos
- Fundamentos sólidos para toda tu carrera en programación

---

# PARTE 1: La Arquitectura del Sistema Operativo

## 📚 1. Del Hardware al Usuario: La Torre de Capas

### 1.1. La Torre Completa (Visión General)

Cuando escribes un comando, atraviesa **4 capas**:

```
┌─────────────────────────────────────┐
│  👤 USUARIO (tú)                    │
│  Escribes: ls -la                   │
└──────────────┬──────────────────────┘
               │ (1) escribes texto
               ↓
┌─────────────────────────────────────┐
│  🖥️  TERMINAL (ventana)              │
│  Programa GUI que captura tu texto  │
│  Ejemplos: Terminal.app, iTerm,     │
│            Windows Terminal, GNOME   │
└──────────────┬──────────────────────┘
               │ (2) envía texto a shell
               ↓
┌─────────────────────────────────────┐
│  💬 SHELL (intérprete)              │
│  Traduce comandos humanos           │
│  Ejemplos: bash, zsh, PowerShell    │
└──────────────┬──────────────────────┘
               │ (3) traduce a llamadas del sistema
               ↓
┌─────────────────────────────────────┐
│  🔧 KERNEL (núcleo del OS)          │
│  Controla el hardware directamente  │
│  Ejemplos: Linux kernel, Darwin,    │
│            Windows NT kernel         │
└──────────────┬──────────────────────┘
               │ (4) ejecuta operaciones en hardware
               ↓
┌─────────────────────────────────────┐
│  ⚙️  HARDWARE (físico)               │
│  CPU, RAM, Disco, GPU, Red          │
└─────────────────────────────────────┘
```

### 1.2. ¿Qué es el HARDWARE?

**Definición:** Los componentes físicos de tu computadora.

**Componentes principales:**
- **CPU (Procesador):** Ejecuta instrucciones
- **RAM (Memoria):** Almacena datos temporales
- **Disco (SSD/HDD):** Almacena datos permanentes
- **GPU (Tarjeta Gráfica):** Procesa gráficos y cálculos paralelos
- **Red (Network):** Conecta con internet/otras máquinas

**Importante:** Tú NO puedes hablar directamente con el hardware. Necesitas el kernel.

### 1.3. ¿Qué es el KERNEL?

**Definición:** El núcleo del sistema operativo que controla el hardware.

**Funciones principales:**
1. **Gestión de Procesos:** Decide qué programa usa la CPU y cuándo
2. **Gestión de Memoria:** Asigna RAM a cada programa
3. **Gestión de Archivos:** Lee y escribe en el disco
4. **Drivers de Hardware:** Comunica con GPU, teclado, mouse, etc.
5. **Seguridad:** Evita que programas accedan a memoria de otros

**Ejemplos de Kernels:**
| Sistema Operativo | Kernel |
|-------------------|--------|
| Linux (Ubuntu, Debian, Fedora) | Linux kernel |
| macOS | Darwin (basado en BSD + Mach) |
| Windows | Windows NT kernel |

**Analogía:** El kernel es como el gerente de una empresa. Tú (usuario) no hablas directamente con las máquinas (hardware), hablas con el gerente (kernel), y él se encarga.

**Verificación práctica:**

```bash
# Ver versión del kernel en Linux/macOS
uname -r
# Ejemplo salida: 6.2.0-35-generic (Linux)
#                 23.1.0 (macOS Darwin)

# Ver información completa del sistema
uname -a

# En Windows (PowerShell):
[System.Environment]::OSVersion
# O simplemente:
systeminfo | Select-String "OS Name","OS Version"
```

### 1.4. ¿Qué es el SHELL?

**Definición:** Un programa intérprete que traduce tus comandos a llamadas del kernel.

**Funciones principales:**
1. **Interpretar comandos:** `ls -la` → llamadas al kernel para listar archivos
2. **Gestionar variables de entorno:** `$PATH`, `$HOME`
3. **Ejecutar scripts:** Archivos .sh, .ps1
4. **Control de procesos:** Segundo plano, tuberías (pipes)
5. **Historial de comandos:** Flecha arriba para repetir

**Analogía:** El shell es tu **traductor** entre el lenguaje humano y el lenguaje que entiende el kernel.

**Tipos de shells:**

| Shell | Nombre Completo | OS Principal | Sintaxis |
|-------|-----------------|--------------|----------|
| **bash** | Bourne Again Shell | Linux | POSIX (estándar Unix) |
| **zsh** | Z Shell | macOS (10.15+) | POSIX + mejoras |
| **PowerShell** | PowerShell | Windows | Propia (orientada a objetos) |
| **fish** | Friendly Interactive Shell | Todos | Propia (moderna) |
| **cmd** | Command Prompt | Windows (legacy) | Antigua (evitar) |

**Verificación práctica:**

```bash
# Linux/macOS: ¿Qué shell estoy usando?
echo $SHELL
# Ejemplo salida: /bin/bash  o  /bin/zsh

# Ver proceso del shell actual
ps -p $$
# Muestra el proceso de tu shell con su PID

# Listar shells disponibles en el sistema
cat /etc/shells

# Windows (PowerShell): Ver versión de PowerShell
$PSVersionTable

# Windows: Ver qué shell estás usando
Get-Process -Id $PID
```

**Diferencia importante:**
```
Shell ≠ Terminal

Shell: El INTÉRPRETE (bash, zsh, PowerShell)
Terminal: La VENTANA que muestra el shell (iTerm, GNOME Terminal, Windows Terminal)
```

### 1.5. ¿Qué es el TERMINAL?

**Definición:** La aplicación GUI (interfaz gráfica) que muestra el shell.

**Función:** 
- Captura lo que escribes en el teclado
- Envía el texto al shell
- Muestra la salida del shell en pantalla

**Ejemplos de terminales:**

| Sistema | Terminales Disponibles |
|---------|------------------------|
| **Linux** | GNOME Terminal, Konsole, xterm, Alacritty, Terminator |
| **macOS** | Terminal.app (nativo), iTerm2, Alacritty, Warp |
| **Windows** | Windows Terminal, PowerShell ISE, ConEmu, Alacritty |

**Analogía:** El terminal es la **ventana** (GUI), el shell es el **intérprete** que trabaja dentro.

**Verificación práctica:**

```bash
# Linux/macOS: ¿Qué terminal estoy usando?
echo $TERM
# Ejemplo salida: xterm-256color, screen-256color

# Ver proceso del terminal
ps aux | grep -i terminal

# macOS específico
echo $TERM_PROGRAM
# Ejemplo salida: Apple_Terminal, iTerm.app

# Windows: Windows Terminal usa perfiles
# Ver si estás en Windows Terminal:
echo $env:WT_SESSION
# Si muestra un GUID, estás en Windows Terminal
```

### 1.6. ¿Qué es la CLI (Command Line Interface)?

**Definición:** La interfaz de texto donde escribes comandos.

**Características:**
- Solo texto (no mouse, no botones)
- Entrada: Teclado
- Salida: Texto en pantalla
- Más rápido que GUI para muchas tareas
- Scriptable (automatizable)

**CLI vs GUI:**

| Aspecto | CLI (Terminal) | GUI (Interfaz Gráfica) |
|---------|----------------|------------------------|
| **Input** | Teclado (comandos) | Mouse + Teclado (clicks) |
| **Output** | Texto | Ventanas, botones, imágenes |
| **Velocidad** | ⚡⚡⚡ Muy rápido | ⚡ Más lento |
| **Automatización** | ✅ Fácil (scripts) | ⚠️ Difícil |
| **Curva aprendizaje** | ⚠️ Empinada | ✅ Fácil |
| **Precisión** | ✅ Exacto | ⚠️ Limitado por UI |

**Ejemplo comparativo:**

```bash
# CLI: Copiar 1000 archivos .txt de A a B
cp ~/carpeta_a/*.txt ~/carpeta_b/
# Un comando, 1 segundo

# GUI: Abrir carpeta A, seleccionar archivos .txt (scroll, Ctrl+Click),
#      Ctrl+C, ir a carpeta B, Ctrl+V
# 2-3 minutos
```

---

## 🔄 2. Flujo Completo: Del Comando al Hardware

### 2.1. Ejemplo Detallado: `ls -la`

Veamos QUÉ pasa cuando escribes un comando simple:

```
PASO 1: Escribes en el teclado
────────────────────────────────
Teclado: l → s → ESPACIO → - → l → a → ENTER
         ↓
Terminal captura las teclas y las muestra en pantalla


PASO 2: Terminal envía al Shell
────────────────────────────────
Terminal: "El usuario presionó ENTER, aquí está el texto: ls -la"
         ↓
Shell (bash): Recibe la cadena de texto "ls -la"


PASO 3: Shell analiza el comando
────────────────────────────────
Shell: "¿Qué es 'ls'?"
       1. Verifico si es comando built-in → NO
       2. Busco en $PATH variable de entorno
          - /usr/local/bin/ls → No existe
          - /usr/bin/ls → ✅ ENCONTRADO
       3. Analizo las opciones: "-la"
          - l = long format (detallado)
          - a = all files (incluir ocultos)


PASO 4: Shell ejecuta el programa
────────────────────────────────
Shell: Ejecuto /usr/bin/ls con argumentos -la
       ↓
El programa 'ls' se carga en memoria (RAM)


PASO 5: Programa hace llamadas al Kernel
────────────────────────────────────────
Programa 'ls': "Kernel, dame la lista de archivos del directorio actual"
               ↓
Kernel: Recibe la petición (system call: getdents64)


PASO 6: Kernel accede al Hardware
────────────────────────────────
Kernel: "Disco duro, dame la tabla de archivos del directorio"
        ↓
Disco duro: Lee los inodes y devuelve metadata de archivos
        ↓
Kernel: Organiza la información y la devuelve a 'ls'


PASO 7: Programa formatea la salida
────────────────────────────────
Programa 'ls': Recibo la lista de archivos del kernel
               Formato según opciones -la:
               - Permisos, dueño, grupo, tamaño, fecha, nombre
               - Incluyo archivos ocultos (que empiezan con .)
               Devuelvo texto formateado al shell


PASO 8: Shell envía salida al Terminal
────────────────────────────────
Shell: Recibo la salida de 'ls'
       Envío el texto al terminal para mostrar


PASO 9: Terminal muestra en pantalla
────────────────────────────────
Terminal: Recibo el texto del shell
          Renderizo en pantalla:
          
drwxr-xr-x  5 usuario  staff   160 Nov  1 10:30 .
drwxr-xr-x 30 usuario  staff   960 Oct 30 15:22 ..
-rw-r--r--  1 usuario  staff  1234 Nov  1 09:15 .gitignore
-rw-r--r--  1 usuario  staff  5678 Nov  1 10:30 README.md
drwxr-xr-x  3 usuario  staff    96 Nov  1 08:00 src
```

**Tiempo total:** ~10-50 milisegundos (imperceptible para humanos)

### 2.2. Diagrama Visual del Flujo

```
┌─────────┐
│ Usuario │  Escribe: ls -la
└────┬────┘
     │
     ↓ (1) Teclas capturadas
┌──────────┐
│ Terminal │  Aplicación GUI (iTerm, Windows Terminal)
└────┬─────┘
     │
     ↓ (2) Texto enviado
┌──────────┐
│  Shell   │  bash/zsh/PowerShell
│          │  - Busca 'ls' en $PATH
│          │  - Encuentra /usr/bin/ls
└────┬─────┘
     │
     ↓ (3) Ejecuta programa
┌────────────┐
│ Programa   │  /usr/bin/ls
│    ls      │  - Lee opciones -la
│            │  - Hace system calls al kernel
└────┬───────┘
     │
     ↓ (4) System call: getdents64()
┌──────────┐
│  Kernel  │  Linux/Darwin/Windows NT
│          │  - Accede al sistema de archivos
│          │  - Lee directorio del disco
└────┬─────┘
     │
     ↓ (5) Lee bloques de datos
┌──────────┐
│ Hardware │  Disco duro (SSD/HDD)
│  (Disco) │  - Retorna metadata de archivos
└────┬─────┘
     │
     ↓ (6) Datos de vuelta
┌──────────┐
│  Kernel  │  Retorna lista de archivos
└────┬─────┘
     │
     ↓ (7) Formatea salida
┌────────────┐
│ Programa   │  Genera texto con formato
│    ls      │  (permisos, tamaño, fecha)
└────┬───────┘
     │
     ↓ (8) Retorna texto
┌──────────┐
│  Shell   │  Recibe stdout del programa
└────┬─────┘
     │
     ↓ (9) Envía a renderizar
┌──────────┐
│ Terminal │  Muestra texto en pantalla
└──────────┘
     ↓
┌─────────┐
│ Usuario │  Ve la lista de archivos
└─────────┘
```

### 2.3. Ejercicio de Verificación: Traza tu Propio Comando

Ahora **tú** verifica el flujo con comandos reales:

```bash
# Paso 1: Identifica tu shell
echo $SHELL
# Ejemplo salida Linux: /bin/bash
# Ejemplo salida macOS: /bin/zsh
# Windows PowerShell: usa $PSVersionTable

# Paso 2: Identifica tu terminal
echo $TERM
# Ejemplo salida: xterm-256color

# Paso 3: Busca dónde está el programa 'ls'
which ls          # Linux/macOS
where.exe ls      # Windows (pero 'ls' es alias en PowerShell)

# Ejemplo salida: /usr/bin/ls

# Paso 4: Verifica si 'ls' es built-in o programa externo
type ls           # bash/zsh
Get-Command ls    # PowerShell

# bash output: ls is /usr/bin/ls (programa externo)
# PowerShell output: ls is an alias for Get-ChildItem (built-in)

# Paso 5: Ve el contenido del programa (binario)
file $(which ls)  # Linux/macOS
# Output: /usr/bin/ls: ELF 64-bit executable (binario compilado)

# Paso 6: Ejecuta con 'strace' para ver system calls (Linux)
strace -e openat,getdents64 ls 2>&1 | head -n 20
# Verás las llamadas al kernel que hace 'ls'

# Windows equivalente: usar Process Monitor (GUI)

# Paso 7: Ve el proceso mientras corre
ls & echo $!     # Ejecuta ls en background y muestra su PID
# Nota: ls es tan rápido que termina antes de que lo veas
```

---

## 🎭 3. Los Tipos de Shells y Sus Diferencias

### 3.1. Bash (Bourne Again Shell)

**Historia:**
- Creado en 1989 por Brian Fox para GNU
- Reemplazo libre del Bourne Shell (sh)
- Shell por defecto en Linux

**Características:**
- ✅ Sintaxis POSIX (estándar Unix)
- ✅ Scripts portables entre sistemas Unix
- ✅ Ampliamente documentado
- ⚠️ Menos features que shells modernos

**Verificar si usas bash:**

```bash
# ¿Es bash?
echo $SHELL
# Output esperado: /bin/bash

# Ver versión
bash --version
# Output: GNU bash, version 5.1.16(1)-release

# Ver features de tu bash
echo $BASH_VERSION
```

**Ejemplo de sintaxis bash:**

```bash
# Variables
nombre="Juan"
echo "Hola, $nombre"

# Condicionales
if [ -f "archivo.txt" ]; then
    echo "El archivo existe"
fi

# Loops
for i in {1..5}; do
    echo "Número: $i"
done

# Funciones
mi_funcion() {
    echo "Hola desde función"
}
mi_funcion
```

### 3.2. Zsh (Z Shell)

**Historia:**
- Creado en 1990 por Paul Falstad
- Shell por defecto en macOS desde Catalina (10.15, 2019)
- Muy popular con framework Oh My Zsh

**Características:**
- ✅ Compatible con bash (casi 100%)
- ✅ Autocompletado mejorado (Tab muy potente)
- ✅ Corrección de typos automática
- ✅ Temas y plugins (Oh My Zsh)
- ✅ Mejores globbing patterns

**Verificar si usas zsh:**

```bash
# ¿Es zsh?
echo $SHELL
# Output esperado: /bin/zsh

# Ver versión
zsh --version
# Output: zsh 5.9 (x86_64-apple-darwin22.0)

# Ver features de zsh
echo $ZSH_VERSION
```

**Ejemplo de mejoras de zsh sobre bash:**

```bash
# Autocompletado inteligente
cd /u/l/b<TAB>
# zsh autocompleta a: cd /usr/local/bin

# Corrección de errores
cd /UsR/LoCaL/bin
# zsh: correct '/UsR/LoCaL/bin' to '/usr/local/bin' [nyae]?

# Globbing avanzado
ls **/*.py
# Busca archivos .py recursivamente en todos los subdirectorios

# Expansión de números
echo {01..10}
# 01 02 03 04 05 06 07 08 09 10 (con ceros)
```

### 3.3. PowerShell (Windows)

**Historia:**
- Creado en 2006 por Microsoft (Jeffrey Snover)
- Reemplazo moderno de cmd
- PowerShell Core (2016+): Open source y multiplataforma

**Características:**
- ✅ Orientado a objetos (no solo texto)
- ✅ Integración con .NET
- ✅ Cmdlets con verbos: Get-Process, Set-Location
- ✅ Pipelines de objetos (no solo texto)
- ⚠️ Sintaxis diferente a bash/zsh

**Verificar si usas PowerShell:**

```powershell
# Ver versión
$PSVersionTable

# Output:
# Name                           Value
# ----                           -----
# PSVersion                      7.3.9
# PSEdition                      Core
# OS                             Microsoft Windows 10.0.22621

# Ver proceso actual
Get-Process -Id $PID
```

**Diferencias clave con bash:**

| Concepto | Bash/Zsh | PowerShell | Explicación |
|----------|----------|------------|-------------|
| **Listar archivos** | `ls` | `Get-ChildItem` o `ls` (alias) | PowerShell usa verbos |
| **Cambiar directorio** | `cd /path` | `Set-Location` o `cd` (alias) | Mismo concepto |
| **Variable de entorno** | `$HOME` | `$env:USERPROFILE` | Prefijo $env: |
| **Pipeline** | Texto | Objetos | Fundamental diferencia |
| **Alias** | `alias ll='ls -la'` | `Set-Alias ll Get-ChildItem` | Sintaxis diferente |

**Ejemplo de objetos en PowerShell:**

```powershell
# En bash: ls retorna TEXTO
ls -la
# drwxr-xr-x  5 usuario  staff  160 Nov  1 10:30 .
# (es solo texto, difícil de procesar)

# En PowerShell: Get-ChildItem retorna OBJETOS
Get-ChildItem | Select-Object Name, Length, LastWriteTime

# Puedes filtrar objetos fácilmente:
Get-ChildItem | Where-Object { $_.Length -gt 1MB }
# Archivos mayores a 1MB (comparación numérica real, no texto)

# Puedes acceder a propiedades:
$archivo = Get-ChildItem "test.txt"
$archivo.Length        # Tamaño en bytes (número)
$archivo.LastWriteTime # Fecha (objeto DateTime)
```

### 3.4. Fish (Friendly Interactive Shell)

**Historia:**
- Creado en 2005 por Axel Liljencrantz
- Enfoque en user-friendliness

**Características:**
- ✅ Autocompletado basado en historial
- ✅ Highlighting de sintaxis en tiempo real
- ✅ No necesita configuración (.fishrc opcional)
- ⚠️ NO compatible con bash (sintaxis diferente)

**Ejemplo de sintaxis fish vs bash:**

```fish
# Fish: sintaxis diferente
set nombre "Juan"              # bash: nombre="Juan"
echo "Hola, $nombre"

if test -f archivo.txt         # bash: if [ -f archivo.txt ]; then
    echo "Existe"
end                            # bash: fi

for i in (seq 1 5)             # bash: for i in {1..5}; do
    echo "Número: $i"
end                            # bash: done
```

### 3.5. cmd (Command Prompt) - Windows Legacy

**⚠️ NO recomendado usar en 2025**

**Historia:**
- Heredado de MS-DOS (1980s)
- Reemplazado por PowerShell

**Por qué NO usarlo:**
- ❌ Sintaxis limitada y antigua
- ❌ No tiene pipes complejos
- ❌ No tiene funciones
- ❌ No soporta UTF-8 bien
- ✅ Usar PowerShell en su lugar

**Si estás en cmd, cambia a PowerShell:**

```cmd
REM En cmd:
powershell
REM Ahora estás en PowerShell
```

### 3.6. Tabla Comparativa Completa

| Feature | bash | zsh | PowerShell | fish | cmd |
|---------|------|-----|------------|------|-----|
| **OS Principal** | Linux | macOS | Windows | Todos | Windows |
| **Sintaxis** | POSIX | POSIX | Propia | Propia | Antigua |
| **Autocompletado** | ⚡⚡ | ⚡⚡⚡ | ⚡⚡⚡ | ⚡⚡⚡ | ⚡ |
| **Plugins** | ✅ | ✅✅✅ | ✅ | ✅ | ❌ |
| **Scripts portables** | ✅ | ✅ | ⚠️ | ❌ | ❌ |
| **Orientado objetos** | ❌ | ❌ | ✅ | ❌ | ❌ |
| **Facilidad uso** | ⚡⚡ | ⚡⚡⚡ | ⚡⚡ | ⚡⚡⚡ | ⚡ |
| **Popularidad** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐ |
| **Recomendación 2025** | ✅ | ✅ | ✅ | ✅ | ❌ |

### 3.7. Cambiar de Shell

**Linux/macOS: Cambiar shell permanentemente:**

```bash
# Ver shells disponibles
cat /etc/shells

# Cambiar a zsh
chsh -s /bin/zsh

# Cambiar a bash
chsh -s /bin/bash

# Cambiar a fish (si está instalado)
chsh -s /usr/local/bin/fish

# Ver cambio (requiere cerrar sesión y volver a entrar)
echo $SHELL
```

**Windows: Cambiar entre cmd y PowerShell:**

```powershell
# Si estás en cmd, escribe:
powershell
# Ahora estás en PowerShell

# Si estás en PowerShell, escribe:
cmd
# Ahora estás en cmd (pero no lo hagas, usa PowerShell)
```

---

## 🛣️ 4. Los 3 Patrones de Uso de la CLI

Existen **3 formas fundamentales** de ejecutar cosas en la terminal:

### 4.1. Patrón 1: Comandos Built-in del Shell

**¿Qué son?**
Comandos que el shell interpreta **directamente** sin ejecutar ningún programa externo.

**Características:**
- ✅ Ya incluidos en el shell
- ✅ NO necesitan instalación
- ✅ Muy rápidos (no cargan desde disco)
- ✅ Funcionan aunque el sistema esté roto

**Ejemplos comunes:**

| Comando | bash/zsh | PowerShell | Qué hace |
|---------|----------|------------|----------|
| `cd` | ✅ Built-in | ✅ Built-in | Cambiar directorio |
| `echo` | ✅ Built-in | ✅ Built-in | Imprimir texto |
| `pwd` | ✅ Built-in | ✅ Built-in | Mostrar directorio actual |
| `export` | ✅ Built-in | ❌ (usa `$env:`) | Definir variable |
| `alias` | ✅ Built-in | ❌ (usa `Set-Alias`) | Crear atajo |
| `history` | ✅ Built-in | ✅ Built-in | Ver historial |

**Verificar si un comando es built-in:**

```bash
# bash/zsh: Usar 'type'
type cd
# Output: cd is a shell builtin

type echo
# Output: echo is a shell builtin

type ls
# Output: ls is /usr/bin/ls (NO es built-in, es programa externo)

# PowerShell: Usar 'Get-Command'
Get-Command cd
# Output: CommandType: Cmdlet (built-in de PowerShell)

Get-Command Get-ChildItem
# Output: CommandType: Cmdlet
```

**Ejemplo de uso:**

```bash
# cd es built-in (el shell lo procesa directamente)
cd /home/usuario/proyectos
# No se ejecuta ningún programa externo
# El shell actualiza su variable interna PWD

# echo es built-in
echo "Hola Mundo"
# El shell imprime directamente

# pwd es built-in
pwd
# El shell lee su variable interna PWD y la imprime
```

**¿Por qué son built-in?**
- **cd:** Necesita cambiar el directorio del SHELL (no puede ser programa externo)
- **export:** Modifica variables del SHELL (debe ser interno)
- **alias:** Crea atajos que solo el shell conoce

### 4.2. Patrón 2: Programas Instalados (Instalar y Usar)

**¿Qué son?**
Programas externos que están instalados en directorios del sistema.

**Flujo:**
1. Instalas el programa (con package manager)
2. El programa se coloca en un directorio del `$PATH`
3. Escribes el nombre del programa
4. El shell busca en `$PATH` y lo ejecuta

**La Variable PATH - Explicación Completa:**

El `$PATH` es una lista de directorios donde el shell busca programas.

```bash
# Ver tu PATH (Linux/macOS)
echo $PATH
# Ejemplo output:
# /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# Ver tu PATH (Windows PowerShell)
echo $env:PATH
# Ejemplo output:
# C:\Windows\system32;C:\Windows;C:\Program Files\Python311

# Ver PATH de forma legible (Linux/macOS)
echo $PATH | tr ':' '\n'
# Output:
# /usr/local/bin
# /usr/bin
# /bin
# /usr/sbin
# /sbin

# Ver PATH de forma legible (Windows)
$env:PATH -split ';'
```

**Cómo funciona la búsqueda en PATH:**

```
Usuario escribe: git status

Shell procesa:
1. ¿Es 'git' un built-in? → NO
2. Busco 'git' en PATH (en orden):

   a) /usr/local/bin/git
      - ¿Existe? → NO, siguiente

   b) /usr/bin/git
      - ¿Existe? → ✅ SÍ, ENCONTRADO
      - Ejecuto: /usr/bin/git status
      - DEJO DE BUSCAR

Si no lo encuentro en ningún directorio:
bash: git: command not found
```

**Ejemplos de programas instalados:**

| Programa | Instalado con | Ubicación típica | Qué hace |
|----------|---------------|------------------|----------|
| `git` | apt/brew/winget | /usr/bin/git | Control de versiones |
| `curl` | apt/brew/winget | /usr/bin/curl | Descargar archivos HTTP |
| `python3` | apt/brew/winget | /usr/bin/python3 | Intérprete Python |
| `htop` | apt/brew | /usr/bin/htop | Monitor de sistema |
| `grep` | (preinstalado) | /usr/bin/grep | Buscar texto |

**Verificar dónde está instalado un programa:**

```bash
# Linux/macOS: 'which' muestra la ruta
which git
# Output: /usr/bin/git

which python3
# Output: /usr/bin/python3

which htop
# Output: /usr/bin/htop

# Si NO está instalado:
which program_inexistente
# (sin output)

# Windows PowerShell: 'where.exe'
where.exe git
# Output: C:\Program Files\Git\cmd\git.exe

where.exe python
# Output: C:\Python311\python.exe
```

**Ejemplo de instalación y uso:**

```bash
# ANTES de instalar git
git --version
# bash: git: command not found

# Instalar git
🖥️ [SYS-PM] sudo apt install git     # Linux
🖥️ [SYS-PM] brew install git         # macOS  
🖥️ [SYS-PM] winget install Git.Git   # Windows

# DESPUÉS de instalar
git --version
# git version 2.42.0

# ¿Dónde se instaló?
which git
# /usr/bin/git

# ¿Está en PATH?
echo $PATH | grep "/usr/bin"
# ...:/usr/bin:...  (✅ sí está)
```

**Agregar un directorio a PATH (temporalmente):**

```bash
# Linux/macOS
export PATH="/nueva/ruta:$PATH"
# Agrega /nueva/ruta al INICIO del PATH

# Verificar
echo $PATH
# /nueva/ruta:/usr/local/bin:/usr/bin:...

# Windows PowerShell
$env:PATH = "C:\nueva\ruta;$env:PATH"

# Verificar
echo $env:PATH
```

**Agregar a PATH permanentemente:**

```bash
# Linux/macOS (bash)
echo 'export PATH="/nueva/ruta:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Linux/macOS (zsh)
echo 'export PATH="/nueva/ruta:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Windows PowerShell (permanente)
# GUI: Panel de Control → Sistema → Variables de entorno
# O usar PowerShell con admin:
[System.Environment]::SetEnvironmentVariable('PATH', "C:\nueva\ruta;$env:PATH", 'User')
```

### 4.3. Patrón 3: Scripts (Escribir y Ejecutar)

**¿Qué son?**
Archivos de texto con comandos que ejecutas como un programa.

**Extensiones comunes:**
- `.sh` - Scripts de bash/zsh
- `.ps1` - Scripts de PowerShell
- `.py` - Scripts de Python
- `.js` - Scripts de Node.js

**Flujo:**
1. Escribes comandos en un archivo
2. Das permiso de ejecución (Linux/macOS)
3. Ejecutas el script

**Ejemplo 1: Script bash simple**

```bash
# Crear archivo: backup.sh
cat > backup.sh << 'EOF'
#!/bin/bash
# Este es un comentario

echo "Iniciando backup..."
fecha=$(date +%Y-%m-%d)
mkdir -p ~/backups/$fecha
cp -r ~/proyectos ~/backups/$fecha/
echo "Backup completado en ~/backups/$fecha"
EOF

# Ver el archivo
cat backup.sh

# Dar permiso de ejecución (Linux/macOS)
chmod +x backup.sh

# Ejecutar
./backup.sh
# Output:
# Iniciando backup...
# Backup completado en ~/backups/2025-11-01
```

**Ejemplo 2: Script con parámetros**

```bash
# Crear archivo: saludo.sh
cat > saludo.sh << 'EOF'
#!/bin/bash

nombre=$1
if [ -z "$nombre" ]; then
    echo "Uso: ./saludo.sh NOMBRE"
    exit 1
fi

echo "Hola, $nombre!"
echo "Hoy es $(date)"
EOF

chmod +x saludo.sh

# Ejecutar con parámetro
./saludo.sh Juan
# Output:
# Hola, Juan!
# Hoy es Fri Nov  1 10:30:45 CET 2025
```

**Ejemplo 3: Script PowerShell**

```powershell
# Crear archivo: backup.ps1
@"
# Script de backup
Write-Host "Iniciando backup..." -ForegroundColor Green

`$fecha = Get-Date -Format "yyyy-MM-dd"
`$destino = "`$HOME\backups\`$fecha"

New-Item -Path `$destino -ItemType Directory -Force
Copy-Item -Path "`$HOME\proyectos" -Destination `$destino -Recurse

Write-Host "Backup completado en `$destino" -ForegroundColor Green
"@ | Out-File -Encoding UTF8 backup.ps1

# Ejecutar (puede requerir cambiar ExecutionPolicy)
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
.\backup.ps1
```

**Script vs Programa Instalado:**

| Aspecto | Script | Programa Instalado |
|---------|--------|-------------------|
| **Ubicación** | Carpeta actual o proyecto | Directorio sistema (/usr/bin) |
| **PATH** | NO está en PATH | ✅ Está en PATH |
| **Ejecución** | `./script.sh` (ruta relativa) | `git` (solo nombre) |
| **Scope** | Específico del proyecto | Global (todo el sistema) |
| **Instalación** | Copiar archivo | Package manager |

**Shebang (#!) - ¿Qué es?**

La primera línea de un script indica QUÉ intérprete usar:

```bash
#!/bin/bash      # Usar bash
#!/bin/zsh       # Usar zsh
#!/usr/bin/env python3   # Usar python3
#!/usr/bin/env node      # Usar Node.js
```

**Ejemplo práctico:**

```bash
# Script Python
cat > hola.py << 'EOF'
#!/usr/bin/env python3

print("Hola desde Python!")
print(f"2 + 2 = {2 + 2}")
EOF

chmod +x hola.py

# Ejecutar (el shebang indica usar python3)
./hola.py
# Output:
# Hola desde Python!
# 2 + 2 = 4
```

---

## 📊 5. Resumen Visual: Los 3 Patrones

```
PATRÓN 1: BUILT-IN
═══════════════════════════════════════
Usuario: cd /home/usuario
           ↓
Shell: "cd es built-in, lo proceso yo mismo"
       (actualiza variable interna PWD)
       ✅ Cambio completado

Ejemplos: cd, echo, pwd, export, alias


PATRÓN 2: INSTALADO (busca en PATH)
═══════════════════════════════════════
Usuario: git status
           ↓
Shell: "git NO es built-in"
       "Busco en PATH:"
       - /usr/local/bin/git → No existe
       - /usr/bin/git → ✅ ENCONTRADO
           ↓
Shell ejecuta: /usr/bin/git status
           ↓
Programa git se ejecuta
       ✅ Muestra status del repositorio

Ejemplos: git, curl, python3, htop, grep


PATRÓN 3: SCRIPT (ejecutas archivo)
═══════════════════════════════════════
Usuario: ./backup.sh
           ↓
Shell: "Archivo en ruta relativa"
       "Leo shebang: #!/bin/bash"
       "Ejecuto con bash"
           ↓
Shell ejecuta: /bin/bash backup.sh
           ↓
Comandos dentro del script se ejecutan
       ✅ Script completado

Ejemplos: ./script.sh, ./app.py, .\backup.ps1
```

---

## ✅ Ejercicios de Verificación Final

### Ejercicio 1: Identifica Tu Stack Completo

```bash
# 1. ¿Qué OS?
uname -s    # Linux/macOS
# Windows: ver $env:OS

# 2. ¿Qué kernel?
uname -r

# 3. ¿Qué shell?
echo $SHELL             # Linux/macOS
$PSVersionTable         # Windows

# 4. ¿Qué terminal?
echo $TERM              # Linux/macOS
echo $TERM_PROGRAM      # macOS específico
echo $env:WT_SESSION    # Windows Terminal

# 5. ¿Qué shells disponibles?
cat /etc/shells         # Linux/macOS
```

### Ejercicio 2: Identifica Tipo de Comando

```bash
# Para cada comando, identifica si es:
# [BUILT-IN] o [INSTALADO] y su ubicación

# cd
type cd                 # bash/zsh
Get-Command cd          # PowerShell

# echo
type echo
Get-Command echo

# ls
type ls
Get-Command ls

# git
type git
Get-Command git

# python3
which python3           # Linux/macOS
where.exe python        # Windows
```

### Ejercicio 3: Explora tu PATH

```bash
# Ver PATH completo
echo $PATH | tr ':' '\n'        # Linux/macOS
$env:PATH -split ';'            # Windows

# ¿Cuántos directorios hay en tu PATH?
echo $PATH | tr ':' '\n' | wc -l    # Linux/macOS

# Listar todos los programas en /usr/bin
ls /usr/bin | head -n 20        # Linux/macOS
ls C:\Windows\System32 | Select-Object -First 20  # Windows
```

### Ejercicio 4: Crea y Ejecuta un Script

```bash
# Linux/macOS: Script bash
cat > test.sh << 'EOF'
#!/bin/bash
echo "Shell: $SHELL"
echo "Usuario: $USER"
echo "Directorio: $(pwd)"
echo "Archivos aquí: $(ls | wc -l)"
EOF

chmod +x test.sh
./test.sh

# Windows: Script PowerShell
@"
Write-Host "Shell: PowerShell $($PSVersionTable.PSVersion)"
Write-Host "Usuario: $env:USERNAME"
Write-Host "Directorio: $(Get-Location)"
Write-Host "Archivos aquí: $((Get-ChildItem).Count)"
"@ | Out-File test.ps1

.\test.ps1
```

---

## 🎓 Conclusión: Has Construido el Modelo Mental

### ✅ Ahora entiendes:

1. **La arquitectura completa:**
   - Hardware → Kernel → Shell → Terminal → Usuario

2. **Los 3 patrones de uso:**
   - 🔵 Built-in (cd, echo)
   - 🖥️ Instalado (git, python3)
   - 📄 Scripts (./backup.sh)

3. **Cómo funciona PATH:**
   - Lista de directorios donde el shell busca programas
   - Orden importa: primero encontrado, primero ejecutado

4. **Diferencias entre shells:**
   - bash: Estándar Linux
   - zsh: Moderno macOS
   - PowerShell: Windows orientado a objetos

### ➡️ Siguiente Paso: Sintaxis CLI

Ahora que entiendes **CÓMO** funciona el sistema, aprenderás la **SINTAXIS** de los comandos:
- `comando [opciones] [argumentos]`
- Operadores: `>`, `|`, `&&`, `||`
- Variables de entorno en detalle
- Rutas absolutas vs relativas

**Continúa con:** `01_cli_syntax_guide.md`

---

**🎯 Recuerda:** No eres un "copy-paster" de comandos. Eres un ingeniero que entiende cómo funciona su máquina. 💪
