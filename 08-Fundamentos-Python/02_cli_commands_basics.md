# 🖥️ Comandos Básicos de Terminal (Pre-Package Management)

**Objetivo:** Dominar comandos esenciales ANTES de instalar software nuevo  
**Por qué este archivo:** Necesitas saber navegar y gestionar archivos antes de instalar paquetes  
**Requisito previo:** Haber leído `00_cli_fundamentals.md` (entender kernel→shell→CLI)

---

## 🎯 **Filosofía de Este Documento**

En este archivo aprenderás comandos para herramientas **YA instaladas** en tu sistema.

### **Badge System - Identificación de Comandos:**

Cada comando tiene un badge que indica su tipo:

- 🔵 **[BUILT-IN]** - Comando interno del shell (no es programa externo)
- 🖥️ **[SYS-PM]** - Programa instalado con package manager del sistema
- 📦 **[PREINSTALLED]** - Programa que viene con el OS por defecto

**Verificación rápida:**
```bash
# ¿Es built-in o programa?
type comando        # bash/zsh
Get-Command comando # PowerShell
```

---

# PARTE 1: Navegación y Exploración del Sistema

## 📍 1. Comandos de Navegación Básica

### 1.1. pwd - ¿Dónde Estoy?

**¿Qué hace?** Muestra el directorio actual (Print Working Directory)

**Tipo:** 🔵 [BUILT-IN] en bash/zsh/PowerShell

**Sintaxis:**
```bash
pwd
```

**Ejemplos por OS:**

```bash
# Linux
pwd
# Output: /home/usuario/proyectos

# macOS
pwd
# Output: /Users/usuario/proyectos

# Windows (PowerShell)
pwd
# Output: C:\Users\usuario\proyectos

# PowerShell también tiene:
Get-Location
# Output: Path
#         ----
#         C:\Users\usuario\proyectos
```

**Uso práctico:**
```bash
# Siempre verifica dónde estás antes de ejecutar comandos peligrosos
pwd
# /home/usuario/proyectos

# ¡Bien! Ahora puedo borrar archivos de prueba con seguridad
rm test_*.txt
```

### 1.2. ls - ¿Qué Hay Aquí?

**¿Qué hace?** Lista archivos y directorios

**Tipo:** 
- 📦 [PREINSTALLED] programa en Linux/macOS (`/usr/bin/ls` o `/bin/ls`)
- 🔵 [BUILT-IN] alias en PowerShell (apunta a `Get-ChildItem`)

**Sintaxis básica:**
```bash
ls [opciones] [ruta]
```

**Verificación:**
```bash
# Linux/macOS: ls es programa externo
type ls
# Output: ls is /usr/bin/ls

which ls
# Output: /usr/bin/ls

# PowerShell: ls es alias de Get-ChildItem
Get-Command ls
# Output: CommandType: Alias
#         Name: ls
#         ResolvedCommand: Get-ChildItem
```

**Tabla Comparativa de Opciones:**

| Tarea | Linux/macOS | PowerShell | Explicación |
|-------|-------------|------------|-------------|
| **Lista simple** | `ls` | `ls` o `dir` | Nombres de archivos |
| **Formato largo** | `ls -l` | `ls` | Detalles: permisos, tamaño, fecha |
| **Archivos ocultos** | `ls -a` | `ls -Force` | Incluye archivos que empiezan con `.` |
| **Todo junto** | `ls -la` | `ls -Force` | Largo + ocultos |
| **Recursivo** | `ls -R` | `ls -Recurse` | Incluye subdirectorios |
| **Tamaño legible** | `ls -lh` | `ls` | Muestra KB, MB, GB en vez de bytes |
| **Ordenar por fecha** | `ls -lt` | `ls \| Sort-Object LastWriteTime` | Más reciente primero |
| **Ordenar por tamaño** | `ls -lS` | `ls \| Sort-Object Length` | Más grande primero |

**Ejemplos Prácticos:**

```bash
# ════════════════════════════════════════
# Linux/macOS
# ════════════════════════════════════════

# Lista simple
📦 [PREINSTALLED] ls
# Output:
# Desktop  Documents  Downloads  Pictures

# Lista detallada
📦 [PREINSTALLED] ls -l
# Output:
# drwxr-xr-x  5 usuario  staff   160 Nov  1 10:30 Desktop
# drwxr-xr-x  8 usuario  staff   256 Nov  1 09:15 Documents
# -rw-r--r--  1 usuario  staff  1234 Oct 30 14:20 README.md

# Incluir archivos ocultos (empiezan con .)
📦 [PREINSTALLED] ls -a
# Output:
# .  ..  .bashrc  .gitconfig  Desktop  Documents

# Todo junto: largo + ocultos
📦 [PREINSTALLED] ls -la
# Output:
# drwxr-xr-x  15 usuario  staff    480 Nov  1 10:30 .
# drwxr-xr-x   6 root     admin    192 Oct 15 08:00 ..
# -rw-r--r--   1 usuario  staff   1234 Oct 30 14:20 .bashrc
# -rw-r--r--   1 usuario  staff    456 Oct 29 16:45 .gitconfig

# Tamaños legibles (KB, MB en vez de bytes)
📦 [PREINSTALLED] ls -lh
# Output:
# -rw-r--r--  1 usuario  staff   1.2K Oct 30 14:20 README.md
# -rw-r--r--  1 usuario  staff   5.6M Nov  1 10:30 video.mp4

# Solo archivos Python
📦 [PREINSTALLED] ls *.py
# Output:
# agent.py  config.py  tools.py

# Recursivo (todos los subdirectorios)
📦 [PREINSTALLED] ls -R
# Output:
# ./Desktop:
# proyecto1  proyecto2
# 
# ./Desktop/proyecto1:
# main.py  README.md


# ════════════════════════════════════════
# Windows (PowerShell)
# ════════════════════════════════════════

# Lista simple
🔵 [BUILT-IN] ls
# O el cmdlet real:
🔵 [BUILT-IN] Get-ChildItem

# Incluir ocultos
🔵 [BUILT-IN] ls -Force

# Recursivo
🔵 [BUILT-IN] ls -Recurse

# Solo archivos Python
🔵 [BUILT-IN] ls *.py

# Filtrar por tamaño (mayores a 1MB)
🔵 [BUILT-IN] ls | Where-Object { $_.Length -gt 1MB }

# Ordenar por tamaño
🔵 [BUILT-IN] ls | Sort-Object Length -Descending

# Mostrar solo nombres
🔵 [BUILT-IN] ls | Select-Object Name
```

**Entendiendo la salida de `ls -l` (Linux/macOS):**

```bash
ls -l README.md
# Output:
# -rw-r--r--  1 usuario  staff  1234 Oct 30 14:20 README.md
# │││││││││││  │ │       │     │    │            │
# │││││││││││  │ │       │     │    │            └─ Nombre
# │││││││││││  │ │       │     │    └─────────────── Fecha modificación
# │││││││││││  │ │       │     └──────────────────── Tamaño (bytes)
# │││││││││││  │ │       └────────────────────────── Grupo
# │││││││││││  │ └────────────────────────────────── Usuario dueño
# │││││││││││  └──────────────────────────────────── Número de links
# │││││││││└───────────────────────────────────────── Permisos otros
# ││││││└──────────────────────────────────────────── Permisos grupo
# │││└─────────────────────────────────────────────── Permisos usuario
# └────────────────────────────────────────────────── Tipo (- = archivo, d = directorio)
```

**Permisos explicados:**
```
r = read (leer)
w = write (escribir)
x = execute (ejecutar)

drwxr-xr-x
│└─┬─┘└─┬─┘└─┬─┘
│  │    │    └─── Otros: leer y ejecutar (r-x)
│  │    └──────── Grupo: leer y ejecutar (r-x)
│  └───────────── Usuario: leer, escribir, ejecutar (rwx)
└──────────────── Tipo: directorio (d)
```

### 1.3. cd - Cambiar Directorio

**¿Qué hace?** Cambia el directorio actual (Change Directory)

**Tipo:** 🔵 [BUILT-IN] en todos los shells

**¿Por qué es built-in?** Porque necesita cambiar el directorio del PROPIO shell. Un programa externo no puede hacer esto.

**Sintaxis:**
```bash
cd [ruta]
```

**Tabla de Uso:**

| Comando | Linux/macOS | Windows | Qué hace |
|---------|-------------|---------|----------|
| `cd directorio` | ✅ | ✅ | Ir a directorio (ruta relativa) |
| `cd /ruta/absoluta` | ✅ | `cd C:\ruta` | Ir a ruta absoluta |
| `cd ..` | ✅ | ✅ | Subir un nivel |
| `cd ../..` | ✅ | ✅ | Subir dos niveles |
| `cd ~` | ✅ | `cd $HOME` | Ir a directorio home |
| `cd -` | ✅ | ✅ (PS 7+) | Volver al directorio anterior |
| `cd` (sin args) | Va a home | Va a home | Directorio del usuario |

**Ejemplos Prácticos:**

```bash
# ════════════════════════════════════════
# Navegación Básica
# ════════════════════════════════════════

# Ver dónde estás
🔵 [BUILT-IN] pwd
# Output: /home/usuario

# Ir a directorio proyectos (ruta relativa)
🔵 [BUILT-IN] cd proyectos

# Verificar
🔵 [BUILT-IN] pwd
# Output: /home/usuario/proyectos

# Ir a subdirectorio
🔵 [BUILT-IN] cd agentes/src

🔵 [BUILT-IN] pwd
# Output: /home/usuario/proyectos/agentes/src


# ════════════════════════════════════════
# Navegación con .. (directorio padre)
# ════════════════════════════════════════

# Estás en: /home/usuario/proyectos/agentes/src
🔵 [BUILT-IN] pwd
# Output: /home/usuario/proyectos/agentes/src

# Subir un nivel
🔵 [BUILT-IN] cd ..
🔵 [BUILT-IN] pwd
# Output: /home/usuario/proyectos/agentes

# Subir dos niveles
🔵 [BUILT-IN] cd ../..
🔵 [BUILT-IN] pwd
# Output: /home/usuario


# ════════════════════════════════════════
# Rutas Absolutas
# ════════════════════════════════════════

# Linux/macOS: empiezan con /
🔵 [BUILT-IN] cd /usr/local/bin
🔵 [BUILT-IN] pwd
# Output: /usr/local/bin

# Windows: empiezan con C:\ (o D:\, etc.)
🔵 [BUILT-IN] cd C:\Users\usuario\Desktop
🔵 [BUILT-IN] pwd
# Output: C:\Users\usuario\Desktop


# ════════════════════════════════════════
# Atajos Útiles
# ════════════════════════════════════════

# Ir a home del usuario
🔵 [BUILT-IN] cd ~          # Linux/macOS
🔵 [BUILT-IN] cd $HOME      # Windows PowerShell

🔵 [BUILT-IN] pwd
# Linux: /home/usuario
# macOS: /Users/usuario
# Windows: C:\Users\usuario

# Volver al directorio anterior
🔵 [BUILT-IN] cd /tmp
🔵 [BUILT-IN] cd -
🔵 [BUILT-IN] pwd
# Output: (directorio donde estabas antes de /tmp)


# ════════════════════════════════════════
# Navegación con Tab (Autocompletado)
# ════════════════════════════════════════

# Escribe parte del nombre y presiona Tab
cd Doc<TAB>
# Se autocompleta a: cd Documents/

cd proj<TAB>
# Se autocompleta a: cd proyectos/
```

**Estructura de ejemplo para practicar:**

```
/home/usuario/
├── proyectos/
│   ├── agentes/
│   │   ├── src/
│   │   │   ├── agent.py
│   │   │   └── tools.py
│   │   ├── data/
│   │   └── README.md
│   └── web/
│       └── index.html
├── documentos/
└── descargas/
```

**Ejercicio de navegación:**

```bash
# Punto de partida
cd ~/proyectos/agentes/src
pwd
# Output: /home/usuario/proyectos/agentes/src

# 1. Ir a carpeta data (hermana de src)
cd ../data

# 2. Volver a agentes
cd ..

# 3. Ir a proyecto web
cd ../web

# 4. Ir a documentos (fuera de proyectos)
cd ~/documentos

# 5. Volver a agentes/src en un comando
cd ~/proyectos/agentes/src
```

---

## 📂 2. Gestión de Archivos y Directorios

### 2.1. mkdir - Crear Directorios

**¿Qué hace?** Crea directorios (Make Directory)

**Tipo:** 📦 [PREINSTALLED] en Linux/macOS, 🔵 [BUILT-IN] en PowerShell

**Sintaxis:**
```bash
mkdir [opciones] nombre_directorio
```

**Tabla de Opciones:**

| Opción | Linux/macOS | PowerShell | Qué hace |
|--------|-------------|------------|----------|
| Sin opciones | `mkdir carpeta` | `mkdir carpeta` | Crea directorio simple |
| **Crear padres** | `mkdir -p ruta/a/carpeta` | `mkdir -Force ruta\carpeta` | Crea padres si no existen |
| **Permisos** | `mkdir -m 755 carpeta` | N/A | Establece permisos (Linux) |
| **Múltiples** | `mkdir a b c` | `mkdir a,b,c` | Crea varios a la vez |

**Ejemplos Prácticos:**

```bash
# ════════════════════════════════════════
# Linux/macOS
# ════════════════════════════════════════

# Crear directorio simple
📦 [PREINSTALLED] mkdir mi_proyecto

# Verificar
📦 [PREINSTALLED] ls -l
# Output:
# drwxr-xr-x  2 usuario  staff   64 Nov  1 10:30 mi_proyecto

# Crear múltiples directorios
📦 [PREINSTALLED] mkdir proyecto1 proyecto2 proyecto3

# Crear estructura anidada (con -p crea directorios padres)
📦 [PREINSTALLED] mkdir -p mi_agente/src/tools
📦 [PREINSTALLED] mkdir -p mi_agente/data/raw
📦 [PREINSTALLED] mkdir -p mi_agente/logs

# Verificar estructura creada
📦 [PREINSTALLED] ls -R mi_agente
# Output:
# mi_agente:
# data  logs  src
# 
# mi_agente/data:
# raw
# 
# mi_agente/logs:
# 
# mi_agente/src:
# tools


# ════════════════════════════════════════
# Windows (PowerShell)
# ════════════════════════════════════════

# Crear directorio simple
🔵 [BUILT-IN] mkdir mi_proyecto

# Múltiples directorios
🔵 [BUILT-IN] mkdir proyecto1,proyecto2,proyecto3

# Estructura anidada
🔵 [BUILT-IN] mkdir -Force mi_agente\src\tools
🔵 [BUILT-IN] mkdir -Force mi_agente\data\raw
🔵 [BUILT-IN] mkdir -Force mi_agente\logs

# Verificar
🔵 [BUILT-IN] ls -Recurse mi_agente
```

**Caso Práctico: Crear Proyecto de Agente LangChain:**

```bash
# Linux/macOS
📦 [PREINSTALLED] mkdir -p agente_langchain/{src,data,logs,tests,docs}
📦 [PREINSTALLED] mkdir -p agente_langchain/src/{tools,models,prompts}

# Windows PowerShell (crear paso a paso)
🔵 [BUILT-IN] mkdir agente_langchain
🔵 [BUILT-IN] cd agente_langchain
🔵 [BUILT-IN] mkdir src,data,logs,tests,docs
🔵 [BUILT-IN] cd src
🔵 [BUILT-IN] mkdir tools,models,prompts

# Resultado (misma estructura):
# agente_langchain/
# ├── src/
# │   ├── tools/
# │   ├── models/
# │   └── prompts/
# ├── data/
# ├── logs/
# ├── tests/
# └── docs/
```

### 2.2. touch / ni - Crear Archivos Vacíos

**¿Qué hace?** Crea archivos vacíos o actualiza fecha de modificación

**Tipo:**
- 📦 [PREINSTALLED] `touch` en Linux/macOS
- 🔵 [BUILT-IN] `New-Item` (alias `ni`) en PowerShell

**Sintaxis:**
```bash
# Linux/macOS
touch archivo.txt

# PowerShell
ni archivo.txt
# O completo:
New-Item -Path archivo.txt -ItemType File
```

**Ejemplos:**

```bash
# ════════════════════════════════════════
# Linux/macOS
# ════════════════════════════════════════

# Crear archivo vacío
📦 [PREINSTALLED] touch agent.py

# Crear múltiples archivos
📦 [PREINSTALLED] touch config.json requirements.txt README.md

# Verificar
📦 [PREINSTALLED] ls -lh
# Output:
# -rw-r--r--  1 usuario  staff     0B Nov  1 10:30 agent.py
# -rw-r--r--  1 usuario  staff     0B Nov  1 10:30 config.json
# -rw-r--r--  1 usuario  staff     0B Nov  1 10:30 README.md


# ════════════════════════════════════════
# Windows (PowerShell)
# ════════════════════════════════════════

# Crear archivo vacío
🔵 [BUILT-IN] ni agent.py

# Múltiples archivos
🔵 [BUILT-IN] ni config.json,requirements.txt,README.md

# Verificar
🔵 [BUILT-IN] ls
```

**Caso Práctico: Setup de Proyecto Python:**

```bash
# Linux/macOS
cd agente_langchain
📦 [PREINSTALLED] touch src/agent.py src/tools.py src/config.py
📦 [PREINSTALLED] touch .env .gitignore requirements.txt README.md

# Windows PowerShell
cd agente_langchain
🔵 [BUILT-IN] ni src\agent.py,src\tools.py,src\config.py
🔵 [BUILT-IN] ni .env,.gitignore,requirements.txt,README.md

# Estructura resultante:
# agente_langchain/
# ├── src/
# │   ├── agent.py
# │   ├── tools.py
# │   └── config.py
# ├── .env
# ├── .gitignore
# ├── requirements.txt
# └── README.md
```

### 2.3. cp - Copiar Archivos y Directorios

**¿Qué hace?** Copia archivos o directorios (Copy)

**Tipo:** 📦 [PREINSTALLED] en Linux/macOS, 🔵 [BUILT-IN] en PowerShell

**Sintaxis:**
```bash
cp [opciones] origen destino
```

**Tabla de Opciones:**

| Tarea | Linux/macOS | PowerShell | Qué hace |
|-------|-------------|------------|----------|
| **Copiar archivo** | `cp file.txt backup.txt` | `cp file.txt backup.txt` | Copia simple |
| **Copiar directorio** | `cp -r carpeta nueva/` | `cp -r carpeta nueva/` | Recursivo (todo el contenido) |
| **Preservar atributos** | `cp -p file.txt backup.txt` | `cp -Preserve file.txt backup.txt` | Mantiene permisos, fecha |
| **Modo interactivo** | `cp -i file.txt dest.txt` | `cp -Confirm file.txt dest.txt` | Pregunta antes de sobrescribir |
| **Verbose** | `cp -v file.txt backup.txt` | `cp -Verbose file.txt backup.txt` | Muestra qué hace |

**Ejemplos Prácticos:**

```bash
# ════════════════════════════════════════
# Copiar Archivos Simples
# ════════════════════════════════════════

# Linux/macOS: Copiar archivo
📦 [PREINSTALLED] cp agent.py agent_backup.py

# Verificar
📦 [PREINSTALLED] ls -l agent*
# Output:
# -rw-r--r--  1 usuario  staff  1234 Nov  1 10:30 agent.py
# -rw-r--r--  1 usuario  staff  1234 Nov  1 10:35 agent_backup.py

# Windows PowerShell: igual
🔵 [BUILT-IN] cp agent.py agent_backup.py


# ════════════════════════════════════════
# Copiar Múltiples Archivos
# ════════════════════════════════════════

# Crear carpeta destino
📦 [PREINSTALLED] mkdir backup

# Copiar todos los archivos Python
📦 [PREINSTALLED] cp *.py backup/

# Verificar
📦 [PREINSTALLED] ls backup/
# Output:
# agent.py  agent_backup.py  config.py  tools.py


# ════════════════════════════════════════
# Copiar Directorios (Recursivo)
# ════════════════════════════════════════

# Linux/macOS: usar -r (recursive)
📦 [PREINSTALLED] cp -r src src_backup

# Verificar estructura
📦 [PREINSTALLED] ls -R src_backup
# Output: (misma estructura que src/)

# Windows PowerShell: igual
🔵 [BUILT-IN] cp -r src src_backup


# ════════════════════════════════════════
# Copiar con Confirmación
# ════════════════════════════════════════

# Linux/macOS: -i pregunta antes de sobrescribir
📦 [PREINSTALLED] cp -i agent.py agent_backup.py
# Output: overwrite agent_backup.py? (y/n [n])

# Windows PowerShell
🔵 [BUILT-IN] cp -Confirm agent.py agent_backup.py
# Muestra diálogo de confirmación
```

**Caso Práctico: Backup de Proyecto:**

```bash
# Linux/macOS
# Crear backup con fecha
fecha=$(date +%Y-%m-%d)
📦 [PREINSTALLED] mkdir ~/backups/$fecha
📦 [PREINSTALLED] cp -r agente_langchain ~/backups/$fecha/

# Windows PowerShell
$fecha = Get-Date -Format "yyyy-MM-dd"
🔵 [BUILT-IN] mkdir $HOME\backups\$fecha
🔵 [BUILT-IN] cp -r agente_langchain $HOME\backups\$fecha\
```

### 2.4. mv - Mover y Renombrar

**¿Qué hace?** Mueve archivos/directorios O los renombra (Move)

**Tipo:** 📦 [PREINSTALLED] en Linux/macOS, 🔵 [BUILT-IN] en PowerShell

**Sintaxis:**
```bash
mv origen destino
```

**Dos usos principales:**
1. **Renombrar:** `mv viejo.txt nuevo.txt` (mismo directorio)
2. **Mover:** `mv archivo.txt carpeta/` (diferente directorio)

**Ejemplos:**

```bash
# ════════════════════════════════════════
# Renombrar Archivo
# ════════════════════════════════════════

# Linux/macOS
📦 [PREINSTALLED] mv agent_old.py agent.py

# Windows PowerShell
🔵 [BUILT-IN] mv agent_old.py agent.py


# ════════════════════════════════════════
# Renombrar Directorio
# ════════════════════════════════════════

📦 [PREINSTALLED] mv proyecto_viejo proyecto_nuevo


# ════════════════════════════════════════
# Mover Archivo a Carpeta
# ════════════════════════════════════════

📦 [PREINSTALLED] mv config.json src/

# Verificar (ya no está en directorio actual)
📦 [PREINSTALLED] ls config.json
# Output: ls: config.json: No such file or directory

📦 [PREINSTALLED] ls src/
# Output: agent.py  config.json  tools.py


# ════════════════════════════════════════
# Mover Múltiples Archivos
# ════════════════════════════════════════

# Mover todos los .log a carpeta logs/
📦 [PREINSTALLED] mv *.log logs/

# Mover todos los .txt a backup/
📦 [PREINSTALLED] mv *.txt backup/
```

### 2.5. rm - Eliminar Archivos y Directorios

**¿Qué hace?** Elimina archivos o directorios (Remove)

**⚠️ PELIGRO:** `rm` no envía a papelera, **ELIMINA PERMANENTEMENTE**

**Tipo:** 📦 [PREINSTALLED] en Linux/macOS, 🔵 [BUILT-IN] en PowerShell

**Sintaxis:**
```bash
rm [opciones] archivo_o_directorio
```

**Tabla de Opciones:**

| Opción | Linux/macOS | PowerShell | Qué hace | Peligro |
|--------|-------------|------------|----------|---------|
| **Archivo simple** | `rm file.txt` | `rm file.txt` | Elimina archivo | ⚠️ |
| **Múltiples archivos** | `rm *.log` | `rm *.log` | Elimina todos los .log | ⚠️⚠️ |
| **Directorio vacío** | `rmdir carpeta` | `rmdir carpeta` | Solo si está vacía | ⚠️ |
| **Directorio con contenido** | `rm -r carpeta` | `rm -r carpeta` | Recursivo (todo dentro) | ⚠️⚠️⚠️ |
| **Forzar (sin confirm)** | `rm -rf carpeta` | `rm -r -Force carpeta` | Sin preguntar | ⚠️⚠️⚠️⚠️⚠️ |
| **Interactivo** | `rm -i file.txt` | `rm -Confirm file.txt` | Pregunta antes | ✅ Seguro |

**⚠️ REGLAS DE SEGURIDAD:**

```bash
# ✅ SIEMPRE verificar dónde estás
pwd

# ✅ SIEMPRE listar antes de borrar
ls *.log        # Ver qué se eliminará
rm *.log        # Ahora eliminar

# ✅ USAR -i para confirmación
rm -i importante.txt
# Output: remove importante.txt? (y/n)

# ❌ NUNCA usar rm -rf sin verificar
# ❌ NUNCA usar rm -rf / (destruye el sistema)
# ❌ NUNCA usar rm -rf * sin pwd antes
```

**Ejemplos Seguros:**

```bash
# ════════════════════════════════════════
# Eliminar Archivo Simple
# ════════════════════════════════════════

# Verificar que existe
📦 [PREINSTALLED] ls test.txt
# Output: test.txt

# Eliminar
📦 [PREINSTALLED] rm test.txt

# Verificar que se eliminó
📦 [PREINSTALLED] ls test.txt
# Output: ls: test.txt: No such file or directory


# ════════════════════════════════════════
# Eliminar Archivos Temporales
# ════════════════════════════════════════

# Ver qué archivos .tmp hay
📦 [PREINSTALLED] ls *.tmp
# Output: file1.tmp  file2.tmp  test.tmp

# Eliminar todos
📦 [PREINSTALLED] rm *.tmp


# ════════════════════════════════════════
# Eliminar Directorio con Confirmación
# ════════════════════════════════════════

# Linux/macOS: usar -i (interactivo)
📦 [PREINSTALLED] rm -ri old_project/
# Preguntará por cada archivo:
# remove old_project/file1.py? y
# remove old_project/file2.py? y
# ...

# Windows PowerShell
🔵 [BUILT-IN] rm -r -Confirm old_project/
```

**Caso Práctico: Limpiar Proyecto:**

```bash
# Verificar dónde estás
pwd
# Output: /home/usuario/proyectos/agente_langchain

# Listar archivos a eliminar
ls *.pyc __pycache__ *.log

# Eliminar archivos compilados Python
rm *.pyc
rm -r __pycache__

# Eliminar logs antiguos
rm *.log

# Eliminar carpetas de backup viejas
rm -r backups/2024-*
```

---

## 🔍 3. Visualización y Búsqueda de Contenido

### 3.1. cat - Ver Contenido de Archivos

**¿Qué hace?** Muestra contenido completo de archivo (Concatenate)

**Tipo:** 📦 [PREINSTALLED] en Linux/macOS, 🔵 [BUILT-IN] alias en PowerShell

**Sintaxis:**
```bash
cat archivo.txt
```

**Ejemplos:**

```bash
# ════════════════════════════════════════
# Ver Archivo Completo
# ════════════════════════════════════════

# Linux/macOS
📦 [PREINSTALLED] cat README.md

# Windows PowerShell (cat es alias de Get-Content)
🔵 [BUILT-IN] cat README.md


# ════════════════════════════════════════
# Ver Múltiples Archivos
# ════════════════════════════════════════

📦 [PREINSTALLED] cat file1.txt file2.txt
# Muestra file1.txt, luego file2.txt (concatenados)


# ════════════════════════════════════════
# Crear Archivo Rápido con cat
# ════════════════════════════════════════

# Linux/macOS: cat con redirección
cat > config.txt << EOF
OPENAI_API_KEY=sk-xxxxx
MODEL=gpt-4
TEMPERATURE=0.7
EOF

# Verificar
📦 [PREINSTALLED] cat config.txt
# Output:
# OPENAI_API_KEY=sk-xxxxx
# MODEL=gpt-4
# TEMPERATURE=0.7
```

### 3.2. head / tail - Ver Inicio o Final

**¿Qué hace?**
- `head` - Muestra primeras líneas
- `tail` - Muestra últimas líneas

**Tipo:** 📦 [PREINSTALLED]

**Sintaxis:**
```bash
head -n 10 archivo.txt   # Primeras 10 líneas
tail -n 10 archivo.txt   # Últimas 10 líneas
```

**Ejemplos:**

```bash
# ════════════════════════════════════════
# Ver Primeras Líneas
# ════════════════════════════════════════

# Primeras 5 líneas
📦 [PREINSTALLED] head -n 5 agent.py

# Por defecto muestra 10 líneas
📦 [PREINSTALLED] head agent.py


# ════════════════════════════════════════
# Ver Últimas Líneas
# ════════════════════════════════════════

# Últimas 20 líneas
📦 [PREINSTALLED] tail -n 20 agent.py


# ════════════════════════════════════════
# Seguir Archivo en Tiempo Real (logs)
# ════════════════════════════════════════

# Linux/macOS: -f (follow)
📦 [PREINSTALLED] tail -f logs/agent.log
# Muestra nuevas líneas en tiempo real
# Ctrl+C para salir

# Windows PowerShell
🔵 [BUILT-IN] Get-Content logs/agent.log -Wait -Tail 20
# Equivalente a tail -f
```

**Caso Práctico: Ver Logs de Aplicación:**

```bash
# Ver últimas 50 líneas del log
📦 [PREINSTALLED] tail -n 50 logs/agent.log

# Buscar errores en las últimas líneas
📦 [PREINSTALLED] tail -n 100 logs/agent.log | grep ERROR

# Seguir log mientras la aplicación corre
📦 [PREINSTALLED] tail -f logs/agent.log
```

---

Este archivo continúa con más secciones (grep, find, variables de entorno, procesos, Git, red). ¿Quieres que continúe con el resto del archivo, o prefieres revisar esta primera parte primero?

---

### 3.3. grep - Buscar Texto en Archivos

**¿Qué hace?** Busca patrones de texto dentro de archivos (Global Regular Expression Print)

**Tipo:** 📦 [PREINSTALLED] en Linux/macOS | 🖥️ [SYS-PM] en Windows (Select-String nativo)

**Sintaxis:**
```bash
grep "pattern" archivo.txt          # Buscar patrón
grep -r "pattern" directorio/       # Buscar recursivamente
grep -i "pattern" archivo.txt       # Case insensitive
grep -n "pattern" archivo.txt       # Mostrar números de línea
grep -v "pattern" archivo.txt       # Invertir match (líneas que NO contienen)
```

**Ejemplos por OS:**

```bash
# Linux/macOS - grep
grep "import" test.py
# Output: import os
#         import sys
#         from langchain import OpenAI

grep -r "TODO" src/
# Output: src/main.py:15:# TODO: Implement error handling
#         src/utils.py:42:# TODO: Add logging

grep -i "error" logs/app.log
# Busca "error", "Error", "ERROR", etc.

grep -n "def " *.py
# Output: test.py:5:def main():
#         test.py:12:def process_data():

# Windows PowerShell - Select-String (equivalente a grep)
Select-String -Pattern "import" -Path test.py
# Output: test.py:1:import os
#         test.py:2:import sys

Select-String -Pattern "TODO" -Path src\*.py -Recurse
# Busca recursivamente en todos los .py

Select-String -Pattern "error" -Path logs\app.log -CaseSensitive:$false
# Case insensitive

Get-Content test.py | Select-String "def "
# Pipeline similar a Linux
```

**Uso Común:**

```bash
# Buscar todas las funciones en código Python
grep -n "^def " *.py

# Encontrar archivos que importan langchain
grep -r "import langchain" .

# Ver logs de errores
grep -i "error\|warning" app.log

# Excluir comentarios
grep -v "^#" config.py

# Contar ocurrencias
grep -c "TODO" src/*.py
```

**Verificación rápida:**
```bash
# Linux/macOS
which grep
type grep

# Windows
Get-Command Select-String
```

---

### 3.4. find - Buscar Archivos por Nombre

**¿Qué hace?** Busca archivos y directorios por nombre, tipo, tamaño, fecha, etc.

**Tipo:** 📦 [PREINSTALLED] en Linux/macOS | 🔵 [BUILT-IN] Get-ChildItem en PowerShell

**Sintaxis:**
```bash
find directorio/ -name "patrón"        # Buscar por nombre
find directorio/ -type f               # Solo archivos
find directorio/ -type d               # Solo directorios
find directorio/ -size +10M            # Archivos > 10MB
find directorio/ -mtime -7             # Modificados últimos 7 días
```

**Ejemplos por OS:**

```bash
# Linux/macOS - find
find . -name "*.py"
# Output: ./test.py
#         ./src/main.py
#         ./src/utils.py

find . -type f -name "*.md"
# Solo archivos markdown (no directorios)

find . -name "*.log" -size +1M
# Logs mayores de 1MB

find . -name "__pycache__" -type d
# Encontrar todos los directorios __pycache__

find . -name "*.pyc" -delete
# ⚠️ Buscar y ELIMINAR archivos .pyc

find ~/projects -name "requirements.txt"
# Buscar en path específico

# Buscar archivos modificados hoy
find . -type f -mtime 0

# Windows PowerShell - Get-ChildItem (alias: gci, ls, dir)
Get-ChildItem -Recurse -Filter "*.py"
# Output: test.py
#         src\main.py
#         src\utils.py

Get-ChildItem -Recurse -File -Filter "*.md"
# Solo archivos markdown

Get-ChildItem -Recurse -Filter "*.log" | Where-Object {$_.Length -gt 1MB}
# Logs mayores de 1MB

Get-ChildItem -Recurse -Directory -Filter "__pycache__"
# Solo directorios __pycache__

Get-ChildItem -Recurse -Filter "*.pyc" | Remove-Item
# ⚠️ Buscar y ELIMINAR archivos .pyc

Get-ChildItem ~\projects -Recurse -Filter "requirements.txt"
# Buscar en path específico

# Archivos modificados hoy
Get-ChildItem -Recurse -File | Where-Object {$_.LastWriteTime.Date -eq (Get-Date).Date}
```

**Uso Común:**

```bash
# Encontrar todos los Python scripts
find . -name "*.py" -type f

# Limpiar cachés de Python
find . -name "__pycache__" -type d -exec rm -rf {} +  # Linux/macOS
Get-ChildItem -Recurse -Directory -Filter "__pycache__" | Remove-Item -Recurse -Force  # Windows

# Encontrar archivos grandes
find . -type f -size +100M  # Linux/macOS
Get-ChildItem -Recurse -File | Where-Object {$_.Length -gt 100MB} | Sort-Object Length -Descending  # Windows

# Buscar configuraciones
find . -name "*.json" -o -name "*.yaml" -o -name "*.toml"  # Linux/macOS
Get-ChildItem -Recurse -Include *.json,*.yaml,*.toml  # Windows
```

**Caso Práctico - Limpiar Proyecto Python:**

```bash
# Linux/macOS
# Eliminar cachés y archivos temporales
find . -type d -name "__pycache__" -exec rm -rf {} +
find . -type f -name "*.pyc" -delete
find . -type f -name "*.pyo" -delete
find . -type f -name ".DS_Store" -delete

# Windows PowerShell
Get-ChildItem -Recurse -Directory -Filter "__pycache__" | Remove-Item -Recurse -Force
Get-ChildItem -Recurse -File -Filter "*.pyc" | Remove-Item -Force
Get-ChildItem -Recurse -File -Filter "*.pyo" | Remove-Item -Force
Get-ChildItem -Recurse -File -Filter ".DS_Store" | Remove-Item -Force
```

---

# PARTE 4: Variables de Entorno en Práctica

## 🌍 4. Environment Variables - El Contexto del Shell

**¿Qué son?** Variables que almacenan configuración del sistema y aplicaciones

**Por qué importan:** Configuran dónde buscar comandos (PATH), qué Python usar, API keys, etc.

### 4.1. Ver Variables de Entorno

**Tipo:** 🔵 [BUILT-IN]

```bash
# Linux/macOS
echo $PATH
echo $HOME
echo $USER
env              # Ver todas las variables
printenv         # Alternativa a env
export           # Ver variables exportadas

# Windows PowerShell
echo $env:PATH
echo $env:USERPROFILE
echo $env:USERNAME
Get-ChildItem Env:    # Ver todas las variables
$env:VARIABLE_NAME    # Acceder a variable específica
```

**Variables Importantes:**

| Variable | Significado | Ejemplo |
|----------|-------------|---------|
| `PATH` | Directorios donde buscar comandos | `/usr/bin:/usr/local/bin` |
| `HOME` / `USERPROFILE` | Directorio home del usuario | `/home/usuario` o `C:\Users\xfrol` |
| `SHELL` | Shell actual (Linux/macOS) | `/bin/bash` |
| `PYTHONPATH` | Donde Python busca módulos | `/home/usuario/mylib` |
| `VIRTUAL_ENV` | Path del venv activo | `/home/usuario/myproject/.venv` |

**Verificación práctica:**

```bash
# Linux/macOS
echo $PATH
# Output: /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

which python
# Output: /usr/local/bin/python
# ↑ Este path debe estar en $PATH

echo $HOME
# Output: /home/usuario

# Windows PowerShell
echo $env:PATH
# Output: C:\Python311\;C:\Python311\Scripts\;C:\Windows\system32;...

(Get-Command python).Source
# Output: C:\Python311\python.exe
# ↑ Este path debe estar en $env:PATH

echo $env:USERPROFILE
# Output: C:\Users\xfrol
```

### 4.2. Modificar Variables (Sesión Actual)

**Temporal - solo para la sesión actual:**

```bash
# Linux/macOS
export MI_VARIABLE="valor"
echo $MI_VARIABLE
# Output: valor

export PATH="$HOME/bin:$PATH"
# Agregar directorio al inicio del PATH

export PYTHONPATH="$HOME/mylib:$PYTHONPATH"
# Agregar ruta para módulos Python

# Windows PowerShell
$env:MI_VARIABLE = "valor"
echo $env:MI_VARIABLE
# Output: valor

$env:PATH = "$env:USERPROFILE\bin;$env:PATH"
# Agregar directorio al inicio del PATH

$env:PYTHONPATH = "$env:USERPROFILE\mylib;$env:PYTHONPATH"
# Agregar ruta para módulos Python
```

### 4.3. Modificar Variables (Permanente)

**Permanente - persiste entre sesiones:**

```bash
# Linux (bash) - Editar ~/.bashrc o ~/.bash_profile
echo 'export MI_VARIABLE="valor"' >> ~/.bashrc
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc  # Recargar configuración

# macOS (zsh) - Editar ~/.zshrc
echo 'export MI_VARIABLE="valor"' >> ~/.zshrc
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc  # Recargar configuración

# Windows PowerShell - Variable de usuario (permanente)
[System.Environment]::SetEnvironmentVariable('MI_VARIABLE', 'valor', 'User')

# Windows - Modificar PATH permanente
$userPath = [System.Environment]::GetEnvironmentVariable('Path', 'User')
$newPath = "$env:USERPROFILE\bin;$userPath"
[System.Environment]::SetEnvironmentVariable('Path', $newPath, 'User')

# Reabrir terminal para ver cambios
```

**⚠️ Advertencia:** Modificar PATH permanentemente puede causar problemas si cometes errores. Siempre prueba primero de forma temporal.

**Caso Práctico - Configurar Python Custom:**

```bash
# Supongamos que instalaste Python en /opt/python311

# Linux/macOS - Temporal
export PATH="/opt/python311/bin:$PATH"
which python
# Output: /opt/python311/bin/python

# Linux/macOS - Permanente
echo 'export PATH="/opt/python311/bin:$PATH"' >> ~/.bashrc  # o ~/.zshrc
source ~/.bashrc

# Windows - Temporal
$env:PATH = "C:\opt\python311;$env:PATH"
(Get-Command python).Source
# Output: C:\opt\python311\python.exe

# Windows - Permanente
$userPath = [System.Environment]::GetEnvironmentVariable('Path', 'User')
[System.Environment]::SetEnvironmentVariable('Path', "C:\opt\python311;$userPath", 'User')
# Reabrir terminal
```

---

# PARTE 5: Procesos y Monitoreo del Sistema

## 🔍 5. Process Management - ¿Qué Está Corriendo?

**¿Qué son procesos?** Programas en ejecución en memoria (tu IDE, Python scripts, servidores, etc.)

**Por qué importa:** Para monitorear recursos (CPU, RAM), matar procesos colgados, ver qué consume recursos

### 5.1. Ver Procesos Activos

**Tipo:** 📦 [PREINSTALLED]

```bash
# Linux/macOS - ps (process status)
ps
# Output: Procesos de tu terminal actual

ps aux
# Output: TODOS los procesos del sistema (detallado)
# a = all users, u = user-oriented, x = include processes without terminal

ps aux | grep python
# Filtrar solo procesos Python

# Windows PowerShell - Get-Process
Get-Process
# Output: Todos los procesos

Get-Process | Where-Object {$_.ProcessName -like "*python*"}
# Filtrar procesos Python

Get-Process | Sort-Object CPU -Descending | Select-Object -First 10
# Top 10 procesos por uso de CPU
```

**Columnas importantes en `ps aux`:**

| Columna | Significado |
|---------|-------------|
| `USER` | Usuario que ejecuta el proceso |
| `PID` | Process ID (identificador único) |
| `%CPU` | Porcentaje de uso de CPU |
| `%MEM` | Porcentaje de uso de RAM |
| `VSZ` | Memoria virtual (KB) |
| `RSS` | Memoria física (KB) |
| `STAT` | Estado (R=running, S=sleeping, Z=zombie) |
| `COMMAND` | Comando ejecutado |

### 5.2. Monitoreo en Tiempo Real

**Tipo:** 📦 [PREINSTALLED] top | 🖥️ [SYS-PM] htop

```bash
# Linux/macOS - top (tiempo real)
top
# Presiona 'q' para salir
# Muestra procesos ordenados por CPU

top -o mem
# Ordenar por memoria (macOS)

# Linux - htop (más amigable, requiere instalación)
sudo apt install htop   # Ubuntu/Debian
brew install htop       # macOS
htop
# Interfaz interactiva con colores
# F9 para matar proceso, F10 para salir

# Windows PowerShell - Equivalente a top
while ($true) { 
    Clear-Host
    Get-Process | Sort-Object CPU -Descending | Select-Object -First 20 | Format-Table
    Start-Sleep -Seconds 2
}
# Ctrl+C para salir

# Alternativa: Task Manager desde PowerShell
taskmgr
```

**Caso Práctico - Verificar Servidor Python:**

```bash
# Linux/macOS
# Levantar servidor Flask en background
python app.py &
# Output: [1] 12345  (PID del proceso)

ps aux | grep python
# Verificar que está corriendo

# Ver puerto usado
lsof -i :5000
# Output: python 12345 usuario ... (LISTEN)

# Windows PowerShell
# Levantar servidor Flask en background
Start-Process python -ArgumentList "app.py" -WindowStyle Hidden

Get-Process | Where-Object {$_.ProcessName -eq "python"}
# Verificar que está corriendo

# Ver puerto usado
netstat -ano | Select-String ":5000"
# Output: TCP 0.0.0.0:5000 ... LISTENING 12345
```

### 5.3. Terminar Procesos

**Tipo:** 📦 [PREINSTALLED]

```bash
# Linux/macOS - kill
kill 12345           # Terminar proceso por PID (SIGTERM - graceful)
kill -9 12345        # Forzar terminación (SIGKILL - immediate)

pkill python         # Terminar por nombre (todos los Python)
pkill -f "app.py"    # Terminar por comando completo

killall python       # Alternativa a pkill (no en macOS por defecto)

# Windows PowerShell - Stop-Process
Stop-Process -Id 12345                    # Por PID
Stop-Process -Name "python"               # Por nombre
Stop-Process -Name "python" -Force        # Forzar

Get-Process python | Stop-Process         # Pipeline
```

**⚠️ Advertencia:** `kill -9` y `Stop-Process -Force` terminan procesos SIN permitirles guardar datos. Úsalos solo si el proceso no responde.

**Caso Práctico - Matar Servidor Colgado:**

```bash
# Linux/macOS
# Encontrar PID del servidor en puerto 5000
lsof -i :5000
# Output: python 12345 ...

kill 12345
# Esperar 5 segundos

# Si no responde:
kill -9 12345

# Alternativa rápida
pkill -f "app.py"

# Windows PowerShell
# Encontrar PID del servidor en puerto 5000
netstat -ano | Select-String ":5000"
# Output: ... LISTENING 12345

Stop-Process -Id 12345
# Esperar 5 segundos

# Si no responde:
Stop-Process -Id 12345 -Force

# Alternativa por nombre
Get-Process python | Where-Object {$_.MainWindowTitle -like "*app.py*"} | Stop-Process
```

### 5.4. Monitoreo de Recursos (CPU, RAM, GPU)

**Herramientas esenciales (ver 05_essential_packages.md para instalación):**

```bash
# Linux - htop (CPU, RAM)
htop

# Linux - nvidia-smi (GPU NVIDIA)
nvidia-smi
watch -n 1 nvidia-smi  # Actualizar cada segundo

# Linux - nvtop (GPU en tiempo real, mejor que nvidia-smi)
sudo apt install nvtop
nvtop

# macOS - htop (CPU, RAM)
htop

# macOS - GPU monitoring (Activity Monitor)
open -a "Activity Monitor"

# Windows PowerShell - CPU y RAM
Get-Counter '\Processor(_Total)\% Processor Time'
Get-Counter '\Memory\Available MBytes'

# Windows - GPU (NVIDIA)
nvidia-smi
# Si no funciona: C:\"Program Files"\NVIDIA Corporation\NVSMI\nvidia-smi.exe

# Windows - Task Manager
taskmgr
```

**Caso Práctico - Verificar Recursos Antes de Entrenar Modelo:**

```bash
# Linux
# Ver RAM disponible
free -h
# Output: Mem: 15Gi total, 8Gi used, 7Gi free

# Ver GPU disponible
nvidia-smi --query-gpu=memory.free --format=csv
# Output: memory.free [MiB]
#         10240

# Ver CPU idle
mpstat 1 1
# Output: ... %idle: 75.3

# Windows PowerShell
# Ver RAM disponible
Get-Counter '\Memory\Available MBytes'

# Ver GPU disponible
nvidia-smi --query-gpu=memory.free --format=csv

# Ver CPU usage
Get-Counter '\Processor(_Total)\% Processor Time'
```

---

# PARTE 6: Git Básico (Control de Versiones)

## 🌿 6. Git - Comandos Esenciales

**¿Qué es Git?** Sistema de control de versiones (track changes, colaboración, historial)

**Tipo:** 🖥️ [SYS-PM] (instalado vía apt/brew/winget o desde git-scm.com)

**Verificación:**
```bash
git --version
# Output: git version 2.39.0
```

### 6.1. Configuración Inicial (Una Sola Vez)

```bash
# Todas las plataformas
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"

# Verificar configuración
git config --list
git config user.name
git config user.email
```

### 6.2. Crear Repositorio

```bash
# Inicializar repo nuevo
mkdir mi_proyecto
cd mi_proyecto
git init
# Output: Initialized empty Git repository in .../mi_proyecto/.git/

# Verificar estado
git status
# Output: On branch main
#         No commits yet
```

### 6.3. Ciclo Básico: Add → Commit → Push

**Workflow fundamental:**

```bash
# 1. Crear/editar archivos
echo "print('Hello')" > test.py

# 2. Ver qué cambió
git status
# Output: Untracked files:
#           test.py

# 3. Agregar al staging area
git add test.py
# O agregar todo:
git add .

# 4. Commit (guardar snapshot)
git commit -m "Add test script"
# Output: [main 1a2b3c] Add test script
#          1 file changed, 1 insertion(+)

# 5. Ver historial
git log
git log --oneline  # Versión compacta

# 6. Conectar con GitHub (remoto)
git remote add origin https://github.com/usuario/repo.git

# 7. Push (subir a GitHub)
git push -u origin main
# -u flag crea tracking entre local y remoto
```

**Comandos comunes:**

```bash
# Ver diferencias antes de commit
git diff

# Ver cambios staged
git diff --staged

# Unstage archivo (quitar de staging)
git reset test.py

# Descartar cambios locales (⚠️ destructivo)
git checkout -- test.py

# Ver ramas
git branch

# Crear rama nueva
git branch feature-nueva

# Cambiar de rama
git checkout feature-nueva
# O crear y cambiar en un comando:
git checkout -b feature-nueva

# Merge rama
git checkout main
git merge feature-nueva

# Actualizar desde remoto
git pull origin main

# Ver remotos configurados
git remote -v
```

### 6.4. .gitignore - Excluir Archivos

**¿Qué es?** Archivo que indica a Git qué NO trackear (passwords, caches, archivos grandes)

**Crear .gitignore para proyecto Python:**

```bash
# Linux/macOS
cat > .gitignore << 'EOF'
# Python
__pycache__/
*.pyc
*.pyo
*.pyd
.Python
*.so
*.egg
*.egg-info/
dist/
build/

# Virtual environments
venv/
env/
.venv/

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Environment variables
.env
.env.local

# Logs
*.log

# Data files (opcional)
*.csv
*.db
*.sqlite
EOF

# Windows PowerShell
@"
# Python
__pycache__/
*.pyc
*.pyo
*.pyd
.Python
*.so
*.egg
*.egg-info/
dist/
build/

# Virtual environments
venv/
env/
.venv/

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Environment variables
.env
.env.local

# Logs
*.log

# Data files (opcional)
*.csv
*.db
*.sqlite
"@ | Out-File -FilePath .gitignore -Encoding utf8
```

**Agregar .gitignore al repo:**

```bash
git add .gitignore
git commit -m "Add gitignore"
```

**Caso Práctico - Workflow Diario:**

```bash
# 1. Actualizar desde GitHub
git pull origin main

# 2. Crear rama para nueva feature
git checkout -b add-langchain-agent

# 3. Trabajar en código
# ... editar archivos ...

# 4. Ver qué cambió
git status
git diff

# 5. Commit cambios
git add src/agent.py
git commit -m "Implement basic LangChain agent"

# 6. Push rama a GitHub
git push origin add-langchain-agent

# 7. Crear Pull Request en GitHub
# (Desde navegador web)

# 8. Después de merge, actualizar main local
git checkout main
git pull origin main

# 9. Eliminar rama local (opcional)
git branch -d add-langchain-agent
```

---

# PARTE 7: Red y Descarga de Archivos

## 🌐 7. Network Commands - Conectividad y Descarga

### 7.1. curl - Descargar Archivos y APIs

**¿Qué hace?** Cliente para transferir datos con URLs (descargas, APIs REST, etc.)

**Tipo:** 📦 [PREINSTALLED] en Linux/macOS | 🔵 [BUILT-IN] en PowerShell 7+ (Invoke-WebRequest)

```bash
# Linux/macOS - curl
curl https://example.com
# Output: HTML de la página

curl -O https://example.com/archivo.zip
# Descargar archivo (mantiene nombre original)

curl -o mi_archivo.zip https://example.com/archivo.zip
# Descargar con nombre custom

curl -L https://github.com/file
# Seguir redirects (-L)

# API REST
curl https://api.github.com/users/octocat
curl -X POST https://api.example.com/data \
  -H "Content-Type: application/json" \
  -d '{"key":"value"}'

# Windows PowerShell - Invoke-WebRequest (alias: curl, wget)
Invoke-WebRequest -Uri "https://example.com" -OutFile "index.html"

# Alias curl funciona:
curl https://example.com -OutFile index.html

# Descargar con progreso
Invoke-WebRequest -Uri "https://example.com/file.zip" -OutFile "file.zip"

# API REST
Invoke-RestMethod -Uri "https://api.github.com/users/octocat"

Invoke-RestMethod -Method Post -Uri "https://api.example.com/data" `
  -ContentType "application/json" `
  -Body '{"key":"value"}'
```

**Caso Práctico - Descargar Dataset:**

```bash
# Linux/macOS
curl -L -O https://raw.githubusercontent.com/usuario/repo/main/data.csv
# -L sigue redirects, -O mantiene nombre

# Verificar descarga
ls -lh data.csv

# Windows PowerShell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/usuario/repo/main/data.csv" -OutFile "data.csv"

# Verificar descarga
Get-Item data.csv | Select-Object Name, Length
```

### 7.2. wget - Alternativa a curl

**Tipo:** 📦 [PREINSTALLED] en Linux | 🖥️ [SYS-PM] en macOS (brew) | 🔵 [BUILT-IN] en PowerShell (alias)

```bash
# Linux
wget https://example.com/archivo.zip
# Descarga con nombre original por defecto

wget -O mi_archivo.zip https://example.com/archivo.zip
# Nombre custom

wget -c https://example.com/archivo_grande.zip
# Continuar descarga interrumpida

# macOS (requiere instalación)
brew install wget
wget https://example.com/archivo.zip

# Windows PowerShell (wget es alias de Invoke-WebRequest)
wget https://example.com/file.zip -OutFile file.zip
```

**Diferencia curl vs wget:**
- `curl`: Más flexible, mejor para APIs, muestra output en stdout por defecto
- `wget`: Más simple para descargas, guarda archivo por defecto, mejor para recursivo

### 7.3. ping - Verificar Conectividad

**¿Qué hace?** Verifica si un host es accesible en la red

**Tipo:** 📦 [PREINSTALLED] en todos los OS

```bash
# Linux/macOS
ping google.com
# Output: 64 bytes from... time=15ms
# Presiona Ctrl+C para detener

ping -c 4 google.com
# Enviar solo 4 paquetes y detenerse

# Windows PowerShell
ping google.com
# Se detiene automáticamente después de 4 paquetes

ping -t google.com
# Ping continuo (equivalente a Linux sin -c)
# Presiona Ctrl+C para detener
```

**Caso Práctico - Verificar Conectividad API:**

```bash
# Todas las plataformas
ping api.openai.com

# Si responde:
# Output: ... time=25ms
# ✅ Conectividad OK

# Si no responde (pero API funciona):
# Algunos servidores bloquean ping pero aceptan HTTP
curl -I https://api.openai.com/v1/models
# Verificar con HTTP en su lugar
```

### 7.4. netstat / ss - Ver Conexiones de Red

**¿Qué hace?** Muestra conexiones de red activas, puertos en escucha, etc.

**Tipo:** 📦 [PREINSTALLED]

```bash
# Linux - netstat (legacy) o ss (moderno)
netstat -tuln
# t=TCP, u=UDP, l=listening, n=numeric (no DNS lookup)

ss -tuln
# Reemplazo moderno de netstat

ss -tlnp
# p=process (muestra qué programa usa el puerto)

# Ver conexiones establecidas
ss -tn

# macOS
netstat -an | grep LISTEN
# Ver puertos en escucha

lsof -i -P
# Ver procesos con conexiones de red

# Windows PowerShell
netstat -an
# Todas las conexiones

Get-NetTCPConnection
# Alternativa PowerShell nativa

Get-NetTCPConnection -State Listen
# Solo puertos en escucha
```

**Caso Práctico - Verificar Puerto Usado:**

```bash
# Verificar si puerto 5000 está libre

# Linux
ss -tlnp | grep :5000
# Si vacío, puerto libre
# Si output, muestra proceso usando el puerto

# macOS
lsof -i :5000
# Si vacío, puerto libre

# Windows
netstat -ano | Select-String ":5000"
# Si vacío, puerto libre
# Si output, muestra PID del proceso
```

---

# PARTE 8: Workflows Comunes - Poniéndolo Todo Junto

## 🔄 8. Integrated Workflows

### 8.1. Workflow: Crear Proyecto Python desde Cero

**Escenario:** Nuevo proyecto LangChain Agent

```bash
# 1. Crear estructura
mkdir langchain_agent_project
cd langchain_agent_project

# 2. Inicializar Git
git init
git branch -M main

# 3. Crear .gitignore
# (usar ejemplo de sección 6.4)

# 4. Crear estructura de directorios
mkdir src tests data logs

# Linux/macOS
touch src/__init__.py src/agent.py src/utils.py
touch tests/__init__.py tests/test_agent.py
touch README.md requirements.txt .env.example

# Windows PowerShell
New-Item -ItemType File src/__init__.py, src/agent.py, src/utils.py
New-Item -ItemType File tests/__init__.py, tests/test_agent.py
New-Item -ItemType File README.md, requirements.txt, .env.example

# 5. Crear README básico
echo "# LangChain Agent Project" > README.md

# 6. Crear requirements.txt
cat > requirements.txt << 'EOF'  # Linux/macOS
langchain
langchain-openai
python-dotenv
pytest
EOF

# PowerShell:
@"
langchain
langchain-openai
python-dotenv
pytest
"@ | Out-File -FilePath requirements.txt -Encoding utf8

# 7. Crear .env.example (template para API keys)
echo "OPENAI_API_KEY=your_key_here" > .env.example

# 8. Primer commit
git add .
git commit -m "Initial project structure"

# 9. Crear repo en GitHub (desde navegador)
# Luego conectar:
git remote add origin https://github.com/usuario/langchain_agent_project.git
git push -u origin main
```

**Verificación:**

```bash
# Ver estructura
tree  # Linux/macOS con tree instalado
ls -R  # Alternativa

# Windows PowerShell
Get-ChildItem -Recurse -Name
```

### 8.2. Workflow: Setup Diario de Desarrollo

**Escenario:** Empezar a trabajar en proyecto existente

```bash
# 1. Actualizar código
cd ~/projects/langchain_agent_project
git pull origin main

# 2. Verificar estado
git status
git log --oneline -5  # Ver últimos 5 commits

# 3. Activar entorno virtual (si existe)
# Linux/macOS
source .venv/bin/activate

# Windows PowerShell
.\.venv\Scripts\Activate.ps1

# 4. Actualizar dependencias
pip install -r requirements.txt --upgrade

# 5. Verificar variables de entorno
cat .env  # Linux/macOS
Get-Content .env  # Windows

# 6. Crear rama para nueva feature
git checkout -b feature-add-memory

# 7. Empezar a codear
# ... trabajo del día ...

# 8. Al final del día: commit
git add src/agent.py
git commit -m "Add conversation memory to agent"
git push origin feature-add-memory
```

### 8.3. Workflow: Troubleshooting - Servidor No Responde

**Escenario:** Tu Flask/FastAPI no está accesible

```bash
# 1. Verificar que el proceso está corriendo
# Linux/macOS
ps aux | grep python

# Windows
Get-Process | Where-Object {$_.ProcessName -eq "python"}

# 2. Verificar puerto
# Linux
ss -tlnp | grep :5000

# macOS
lsof -i :5000

# Windows
netstat -ano | Select-String ":5000"

# 3. Si no está corriendo, revisar logs
cat logs/app.log  # Linux/macOS
Get-Content logs\app.log  # Windows

# 4. Verificar configuración
cat .env

# 5. Intentar curl local
curl http://localhost:5000
curl http://127.0.0.1:5000

# Windows
Invoke-WebRequest -Uri "http://localhost:5000"

# 6. Verificar firewall (si aplica)
# Linux
sudo ufw status

# Windows
Get-NetFirewallRule | Where-Object {$_.DisplayName -like "*5000*"}

# 7. Reiniciar servidor
# Encontrar PID y matar
kill <PID>  # Linux/macOS
Stop-Process -Id <PID>  # Windows

# Iniciar de nuevo
python app.py
```

### 8.4. Workflow: Limpiar Proyecto Python

**Escenario:** Eliminar archivos temporales antes de commit o compartir

```bash
# Script de limpieza completo

# Linux/macOS
#!/bin/bash
echo "🧹 Cleaning Python project..."

# Eliminar cachés Python
find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null
find . -type f -name "*.pyc" -delete
find . -type f -name "*.pyo" -delete
find . -type f -name "*.pyd" -delete

# Eliminar build artifacts
rm -rf build/ dist/ *.egg-info/

# Eliminar pytest cache
rm -rf .pytest_cache/

# Eliminar coverage reports
rm -rf htmlcov/ .coverage

# Eliminar Jupyter checkpoints
find . -type d -name ".ipynb_checkpoints" -exec rm -rf {} + 2>/dev/null

# Eliminar macOS files
find . -name ".DS_Store" -delete

echo "✅ Cleanup complete!"

# Windows PowerShell
Write-Host "🧹 Cleaning Python project..." -ForegroundColor Yellow

# Eliminar cachés Python
Get-ChildItem -Recurse -Directory -Filter "__pycache__" | Remove-Item -Recurse -Force
Get-ChildItem -Recurse -File -Filter "*.pyc" | Remove-Item -Force
Get-ChildItem -Recurse -File -Filter "*.pyo" | Remove-Item -Force
Get-ChildItem -Recurse -File -Filter "*.pyd" | Remove-Item -Force

# Eliminar build artifacts
Remove-Item -Recurse -Force build, dist, *.egg-info -ErrorAction SilentlyContinue

# Eliminar pytest cache
Remove-Item -Recurse -Force .pytest_cache -ErrorAction SilentlyContinue

# Eliminar coverage reports
Remove-Item -Recurse -Force htmlcov, .coverage -ErrorAction SilentlyContinue

# Eliminar Jupyter checkpoints
Get-ChildItem -Recurse -Directory -Filter ".ipynb_checkpoints" | Remove-Item -Recurse -Force

# Eliminar Windows files
Get-ChildItem -Recurse -File -Filter "Thumbs.db" | Remove-Item -Force

Write-Host "✅ Cleanup complete!" -ForegroundColor Green
```

**Guardar como script:**

```bash
# Linux/macOS
cat > clean.sh << 'EOF'
# (contenido del script de arriba)
EOF
chmod +x clean.sh
./clean.sh

# Windows
# Guardar como clean.ps1
# (contenido del script de arriba)
.\clean.ps1
```

### 8.5. Workflow: Backup Manual de Proyecto

**Escenario:** Crear backup antes de cambios riesgosos

```bash
# Linux/macOS
cd ~/projects
tar -czf langchain_agent_backup_$(date +%Y%m%d).tar.gz langchain_agent_project/
# Crea: langchain_agent_backup_20241101.tar.gz

# Verificar backup
tar -tzf langchain_agent_backup_20241101.tar.gz | head

# Restaurar (si necesario)
tar -xzf langchain_agent_backup_20241101.tar.gz

# Windows PowerShell
cd ~\projects
Compress-Archive -Path langchain_agent_project -DestinationPath "langchain_agent_backup_$(Get-Date -Format 'yyyyMMdd').zip"
# Crea: langchain_agent_backup_20241101.zip

# Verificar backup
Expand-Archive -Path langchain_agent_backup_20241101.zip -DestinationPath temp_verify -Force
Get-ChildItem temp_verify -Recurse
Remove-Item temp_verify -Recurse -Force

# Restaurar (si necesario)
Expand-Archive -Path langchain_agent_backup_20241101.zip -DestinationPath .
```

---

## 🎯 Resumen de Comandos Esenciales

| Categoría | Comandos Clave | Badge |
|-----------|----------------|-------|
| **Navegación** | `pwd`, `ls`, `cd` | 🔵 [BUILT-IN] |
| **Archivos** | `mkdir`, `touch`, `cp`, `mv`, `rm` | 🔵 / 📦 |
| **Visualización** | `cat`, `head`, `tail`, `less` | 📦 [PREINSTALLED] |
| **Búsqueda** | `grep`, `find` | 📦 [PREINSTALLED] |
| **Variables** | `echo $VAR`, `export`, `$env:VAR` | 🔵 [BUILT-IN] |
| **Procesos** | `ps`, `top`, `htop`, `kill` | 📦 [PREINSTALLED] |
| **Git** | `init`, `add`, `commit`, `push`, `pull` | 🖥️ [SYS-PM] |
| **Red** | `curl`, `wget`, `ping`, `netstat` | 📦 [PREINSTALLED] |

---

## ✅ Checkpoint de Aprendizaje

**Ahora sabes:**

1. ✅ Navegar el sistema de archivos en 3 OS
2. ✅ Crear, copiar, mover y eliminar archivos/directorios
3. ✅ Buscar texto en archivos (`grep`) y archivos por nombre (`find`)
4. ✅ Ver y modificar variables de entorno (temporal y permanente)
5. ✅ Monitorear procesos y recursos del sistema
6. ✅ Usar Git para control de versiones (básico)
7. ✅ Descargar archivos y verificar conectividad de red
8. ✅ Workflows integrados para proyectos reales

**Siguiente paso:**
→ **03_what_are_packages.md** - Entender qué son los paquetes y por qué necesitas package managers

---

## 📚 Referencias Rápidas

**Documentación oficial:**
- Bash: `man comando` (Linux/macOS)
- PowerShell: `Get-Help comando` o `Get-Help comando -Online`
- Git: https://git-scm.com/doc

**Cheatsheets:**
- Linux commands: https://ss64.com/bash/
- PowerShell: https://ss64.com/ps/
- Git: https://training.github.com/downloads/github-git-cheat-sheet/

**Próximos archivos en la serie:**
1. ✅ 00_cli_fundamentals.md
2. 01_cli_syntax_guide.md
3. ✅ 02_cli_commands_basics.md ← **Estás aquí**
4. 03_what_are_packages.md
5. 04_package_managers_by_type.md
6. 05_essential_packages.md
7. 06_runtime_version_managers.md
8. 07_python_virtual_environments_deep_dive.md
9. 08_hybrid_package_managers.md
10. 09_integrated_workflow_practice.md

---

**🎉 ¡File 2 Complete! Ready for File 3: What Are Packages?**
