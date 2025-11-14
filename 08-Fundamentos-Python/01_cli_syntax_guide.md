# 🎓 PARTE 1: Entendiendo la Sintaxis de la Terminal (CLI)

**Objetivo:** Comprender la LÓGICA y ESTRUCTURA de los comandos antes de memorizarlos.

---

## 📖 1. Anatomía de un Comando CLI

### 🎯 Estructura Universal

Todo comando en terminal sigue esta estructura básica en TODOS los sistemas operativos:

```
comando [opciones] [argumentos]
```

### 🔍 Desglosando Cada Parte

#### 1️⃣ **El Comando (El Verbo - La Acción)**

Es la acción que quieres ejecutar. Es **siempre** lo primero que escribes.

| **Linux/macOS** | **Windows PowerShell** | **Git Bash (Windows)** | **Qué hace** |
|-----------------|------------------------|------------------------|--------------|
| `ls` | `ls` o `dir` | `ls` | Listar archivos |
| `cd` | `cd` | `cd` | Cambiar directorio |
| `pwd` | `pwd` o `Get-Location` | `pwd` | Mostrar directorio actual |
| `cat` | `cat` o `type` | `cat` | Ver contenido de archivo |
| `rm` | `rm` o `del` | `rm` | Eliminar archivo |

**Ejemplo visual:**
```bash
ls              # El comando es "ls" (list)
   ↑
   └── Esta es la ACCIÓN que quieres realizar
```

#### 2️⃣ **Las Opciones/Flags (Los Modificadores)**

Modifican **cómo** se ejecuta el comando. Empiezan con `-` (corto) o `--` (largo).

**Reglas universales:**
- `-x` → Opción corta (una letra)
- `--palabra` → Opción larga (palabra completa)
- `-xyz` → Combinar múltiples opciones cortas (equivale a `-x -y -z`)
- `--option=value` → Opción con valor asignado

**Ejemplos comparados:**

| **Concepto** | **Linux/macOS/Git Bash** | **PowerShell** | **Explicación** |
|--------------|--------------------------|----------------|-----------------|
| Lista detallada | `ls -l` | `ls` (ya es detallado) | `-l` = long format |
| Mostrar ocultos | `ls -a` | `ls -Force` | `-a` = all, `-Force` = forzar mostrar |
| Combinar opciones | `ls -la` | `ls -Force` | Ambas opciones juntas |
| Opción larga | `ls --all` | `Get-ChildItem -Force` | Mismo resultado que `-a` |

**Ejemplo visual:**
```bash
ls -la /home
│    └─ Opción 2: mostrar todos los archivos (all)
└── Opción 1: formato largo/detallado (long)
```

#### 3️⃣ **Los Argumentos (Los Objetos)**

Son **sobre qué** actúa el comando. Pueden ser archivos, carpetas, texto, etc.

**Ejemplos comparados:**

| **Acción** | **Linux/macOS/Git Bash** | **PowerShell** | **Anatomía** |
|------------|--------------------------|----------------|--------------|
| Cambiar a carpeta | `cd proyectos` | `cd proyectos` | `cd` (comando) + `proyectos` (argumento) |
| Ver archivo | `cat script.py` | `cat script.py` | `cat` (comando) + `script.py` (argumento) |
| Eliminar archivo | `rm viejo.txt` | `rm viejo.txt` | `rm` (comando) + `viejo.txt` (argumento) |
| Instalar paquete | `pip install langchain` | `pip install langchain` | `pip install` (comando) + `langchain` (argumento) |

**Ejemplo visual:**
```bash
pip install langchain
    │        │
    │        └── ARGUMENTO: el paquete que quiero instalar
    └────────── COMANDO: la acción (instalar)
```

### 📊 Ejemplos Completos Explicados

#### **Ejemplo 1: Python**

| **Sistema** | **Comando** | **Anatomía** |
|-------------|-------------|--------------|
| Todos | `python --version` | `python` = comando<br>`--version` = opción |
| Todos | `python script.py` | `python` = comando<br>`script.py` = argumento |
| Todos | `python -m venv env` | `python` = comando<br>`-m` = opción (module)<br>`venv env` = argumentos |

**Desglose visual completo:**
```bash
python -m venv mi_entorno
│      │  │    │
│      │  │    └──────────── ARGUMENTO 2: nombre del entorno
│      │  └────────────────── ARGUMENTO 1: módulo a ejecutar
│      └───────────────────── OPCIÓN: ejecutar como módulo (-m = module)
└──────────────────────────── COMANDO: intérprete Python
```

#### **Ejemplo 2: Git**

```bash
git commit -m "Añadir agente de búsqueda" archivo.py
│   │      │   │                          │
│   │      │   │                          └── ARGUMENTO 2: archivo específico
│   │      │   └───────────────────────────── ARGUMENTO 1: mensaje del commit
│   │      └──────────────────────────────── OPCIÓN: mensaje (-m = message)
│   └─────────────────────────────────────── SUB-COMANDO: acción de git
└─────────────────────────────────────────── COMANDO PRINCIPAL: git
```

#### **Ejemplo 3: Pip con múltiples opciones**

```bash
pip install --upgrade --no-cache-dir langchain
│   │       │         │              │
│   │       │         │              └────── ARGUMENTO: paquete
│   │       │         └───────────────────── OPCIÓN 2: no usar caché
│   │       └─────────────────────────────── OPCIÓN 1: actualizar si existe
│   └─────────────────────────────────────── SUB-COMANDO: instalar
└─────────────────────────────────────────── COMANDO: gestor de paquetes
```

---

## 🔗 2. Operadores y Símbolos Especiales

### ➡️ Redirección de Entrada/Salida

Estos operadores **redirigen** hacia dónde va o de dónde viene la información.

| **Operador** | **Nombre** | **Linux/macOS/Git Bash** | **PowerShell** | **Qué hace** |
|--------------|------------|--------------------------|----------------|--------------|
| `>` | Redirigir salida | ✅ Funciona | ✅ Funciona | Guarda la salida en archivo (SOBRESCRIBE) |
| `>>` | Añadir salida | ✅ Funciona | ✅ Funciona | Añade al final del archivo (NO sobrescribe) |
| `<` | Entrada desde archivo | ✅ Funciona | ✅ Funciona | Lee entrada desde archivo |
| `2>` | Redirigir errores | ✅ Funciona | ✅ Funciona | Solo guarda los ERRORES |
| `&>` | Redirigir todo | ✅ Funciona (Bash) | ❌ Usa `*>` | Salida + errores juntos |

**Ejemplos con explicación:**

```bash
# EJEMPLO 1: Guardar lista de archivos
ls > archivos.txt
│  │ │
│  │ └── DESTINO: archivo donde se guarda
│  └──── OPERADOR: redirigir salida
└────── COMANDO: listar

# EJEMPLO 2: Añadir fecha al final (sin borrar contenido anterior)
date >> archivos.txt
│    │  │
│    │  └── DESTINO: se añade al final
│    └──── OPERADOR: añadir (no sobrescribir)
└────── COMANDO: fecha actual

# EJEMPLO 3: Separar salida normal y errores
python agent.py > salida.log 2> errores.log
│              │ │            │  │
│              │ │            │  └── ERRORES van aquí
│              │ │            └──── Operador: redirigir errores (2 = stderr)
│              │ └────────────────── SALIDA NORMAL va aquí
│              └──────────────────── Operador: redirigir salida estándar
└─────────────────────────────────── Ejecutar script
```

### 🔄 Tuberías (Pipes) - Conectar Comandos

El operador `|` (pipe) envía la **salida** de un comando como **entrada** del siguiente.

**Funcionamiento:**
```
comando1 | comando2 | comando3
   │          │          │
   │          │          └─── Recibe y procesa salida de comando2
   │          └──────────────── Recibe y procesa salida de comando1
   └─────────────────────────── Se ejecuta primero
```

**Ejemplos prácticos:**

| **Tarea** | **Linux/macOS/Git Bash** | **PowerShell** | **Explicación** |
|-----------|--------------------------|----------------|-----------------|
| Filtrar archivos Python | `ls \| grep "\.py"` | `ls \| Select-String "\.py"` | Lista archivos → Filtra los .py |
| Contar archivos Python | `ls \| grep "\.py" \| wc -l` | `(ls \| Select-String "\.py").Count` | Lista → Filtra → Cuenta |
| Buscar en paquetes | `pip list \| grep "lang"` | `pip list \| Select-String "lang"` | Lista paquetes → Busca "lang" |
| Últimas líneas de log | `cat log.txt \| tail -n 10` | `Get-Content log.txt \| Select-Object -Last 10` | Lee archivo → Muestra últimas 10 |

**Ejemplo visual detallado:**
```bash
pip list | grep "lang" | wc -l
│        │ │           │ │
│        │ │           │ └─── COMANDO 3: cuenta líneas (word count -lines)
│        │ │           └───── PIPE: envía resultado de grep a wc
│        │ └───────────────── COMANDO 2: filtra líneas con "lang"
│        └─────────────────── PIPE: envía resultado de pip list a grep
└──────────────────────────── COMANDO 1: lista todos los paquetes instalados

Flujo de datos:
pip list → [lista completa] → grep → [solo líneas con "lang"] → wc -l → [número]
```

### ⚡ Ejecución Secuencial y Condicional

Controlan **cuándo** y **cómo** se ejecutan múltiples comandos.

| **Operador** | **Nombre** | **Comportamiento** | **Linux/macOS/Git Bash** | **PowerShell** |
|--------------|------------|-------------------|--------------------------|----------------|
| `;` | Secuencial simple | Ejecuta todos, ignore errores | ✅ Funciona | ✅ Funciona |
| `&&` | Y lógico (AND) | Ejecuta siguiente solo si anterior tuvo ÉXITO | ✅ Funciona | ✅ Funciona |
| `\|\|` | O lógico (OR) | Ejecuta siguiente solo si anterior FALLÓ | ✅ Funciona | ✅ Funciona |
| `&` | Segundo plano | Ejecuta en background (no bloquea terminal) | ✅ Funciona | ⚠️ Diferente sintaxis |

**Ejemplos con casos de uso:**

```bash
# EJEMPLO 1: Ejecutar todo sin importar errores
cd carpeta; ls; pwd
│         │  │  │
│         │  │  └── Ejecuta SIEMPRE (aunque cd y ls fallen)
│         │  └──── Ejecuta SIEMPRE (aunque cd falle)
│         └────── Separador: continúa sin importar resultado
└──────────────── Puede fallar (carpeta no existe)

# EJEMPLO 2: Solo continuar si hay éxito (común en instalaciones)
pip install langchain && python agent.py
│                   │  │
│                   │  └── Solo se ejecuta si pip install tuvo ÉXITO
│                   └──── AND: ejecuta siguiente solo si exitoso
└───────────────────────── Si esto falla, no ejecuta lo siguiente

# EJEMPLO 3: Plan B si falla (manejo de errores)
python agent.py || echo "Error: el agente falló"
│               │  │
│               │  └── Solo se ejecuta si python agent.py FALLÓ
│               └──── OR: ejecuta siguiente solo si hay error
└───────────────────── Intenta ejecutar primero

# EJEMPLO 4: Combinación compleja (instalación robusta)
pip install langchain && python agent.py || echo "Algo falló"
│                   │                     │
│                   │                     └── Si alguno de los anteriores falla
│                   └────────────────────── Si pip tiene éxito, ejecuta python
└────────────────────────────────────────── Paso 1
```

**Tabla de flujo de decisión:**

| **Comando** | **Resultado Comando 1** | **¿Ejecuta Comando 2?** |
|-------------|-------------------------|-------------------------|
| `cmd1 ; cmd2` | Éxito ✅ | SÍ |
| `cmd1 ; cmd2` | Error ❌ | SÍ (no le importa) |
| `cmd1 && cmd2` | Éxito ✅ | SÍ |
| `cmd1 && cmd2` | Error ❌ | NO |
| `cmd1 \|\| cmd2` | Éxito ✅ | NO |
| `cmd1 \|\| cmd2` | Error ❌ | SÍ |

### 🌟 Comodines (Wildcards)

Patrones para trabajar con **múltiples archivos** a la vez.

| **Símbolo** | **Coincide con** | **Ejemplo** | **Resultado** |
|-------------|------------------|-------------|---------------|
| `*` | Cualquier cantidad de caracteres | `*.py` | Todos los archivos que terminan en .py |
| `?` | Exactamente UN carácter | `agent?.py` | agent1.py, agent2.py, agentA.py |
| `[abc]` | Uno de los caracteres listados | `agent[123].py` | agent1.py, agent2.py, agent3.py |
| `[a-z]` | Rango de caracteres | `file[a-c].txt` | filea.txt, fileb.txt, filec.txt |
| `[!abc]` | Cualquier carácter EXCEPTO estos | `agent[!12].py` | agent3.py, agent4.py, NO agent1.py |
| `{opt1,opt2}` | Una de las opciones | `{agent,tool}.py` | agent.py O tool.py |

**Ejemplos prácticos comparados:**

| **Tarea** | **Linux/macOS/Git Bash** | **PowerShell** | **Qué hace** |
|-----------|--------------------------|----------------|--------------|
| Listar .py | `ls *.py` | `ls *.py` | Todos los archivos Python |
| Copiar configs | `cp *.json backup/` | `cp *.json backup/` | Todos los archivos JSON a backup |
| Eliminar logs | `rm *.log` | `rm *.log` | Eliminar todos los logs |
| Buscar en varios tipos | `grep "def" *.{py,txt}` | `Select-String "def" *.py,*.txt` | Buscar "def" en .py y .txt |
| Archivos numerados | `ls agent[1-5].py` | `ls agent[1-5].py` | agent1.py hasta agent5.py |

**Ejemplo visual:**
```bash
ls agent*.py
   │    │└─ Extensión fija
   │    └── Cualquier cosa después de "agent"
   └────── Debe empezar con "agent"

Coincide con:
✅ agent.py
✅ agent1.py
✅ agent_backup.py
✅ agent_old_version.py
❌ my_agent.py (no empieza con "agent")
❌ agent.txt (no termina en .py)
```

---

## 🌍 3. Variables de Entorno - Explicación Completa

### 🤔 ¿Qué son las Variables de Entorno?

Son **valores guardados en memoria** que pueden usar los programas. Piensa en ellas como **configuraciones globales** del sistema.

**¿Por qué son importantes para desarrollo?**
- 🔐 Guardar **API keys** de forma segura (no en el código)
- 📁 Saber dónde están las **rutas** importantes del sistema
- ⚙️ **Configurar** cómo se comportan los programas
- 🔄 **Compartir** información entre programas

### 📋 Sintaxis por Sistema Operativo

#### **Linux / macOS / Git Bash**

```bash
# 1️⃣ DEFINIR variable (solo para esta sesión de terminal)
export MI_VARIABLE="valor"
│      │           │
│      │           └── El valor que quieres guardar
│      └───────────── Nombre de la variable (MAYÚSCULAS por convención)
└──────────────────── Comando para definir variable de entorno

# 2️⃣ USAR variable (leer su valor)
echo $MI_VARIABLE
     │
     └── $ indica que es una variable

# 3️⃣ ELIMINAR variable
unset MI_VARIABLE

# 4️⃣ DEFINIR solo para UN comando
MI_VARIABLE="valor" python script.py
│                   │
│                   └── Solo este comando ve la variable
└───────────────────── Variable temporal
```

#### **PowerShell (Windows)**

```powershell
# 1️⃣ DEFINIR variable (solo para esta sesión)
$env:MI_VARIABLE = "valor"
│    │            │
│    │            └── El valor
│    └─────────────── Nombre de la variable
└──────────────────── Acceso a variables de entorno

# 2️⃣ USAR variable
echo $env:MI_VARIABLE
     │
     └── $env: indica variable de entorno

# 3️⃣ ELIMINAR variable
Remove-Item env:MI_VARIABLE

# 4️⃣ DEFINIR solo para UN comando
$env:MI_VARIABLE="valor"; python script.py; Remove-Item env:MI_VARIABLE
```

### 🔑 Ejemplo Práctico: API Keys

**Problema:** Necesitas usar tu API key de OpenAI en Python, pero NO quieres escribirla en el código (inseguro).

**Solución con variables de entorno:**

| **Paso** | **Linux/macOS/Git Bash** | **PowerShell** |
|----------|--------------------------|----------------|
| 1. Definir API key | `export OPENAI_API_KEY="sk-xxxxx"` | `$env:OPENAI_API_KEY="sk-xxxxx"` |
| 2. Verificar que existe | `echo $OPENAI_API_KEY` | `echo $env:OPENAI_API_KEY` |
| 3. Usar en Python | `python agent.py` | `python agent.py` |

**En Python, leer la variable:**
```python
import os

# Python lee la variable de entorno automáticamente
api_key = os.getenv("OPENAI_API_KEY")
print(f"API Key: {api_key}")
```

### 📂 Variables de Entorno Comunes

Cada sistema operativo tiene variables predefinidas útiles:

| **Variable** | **Linux/macOS** | **PowerShell** | **Qué contiene** |
|--------------|-----------------|----------------|------------------|
| Directorio del usuario | `$HOME` | `$env:USERPROFILE` | /home/usuario o C:\Users\usuario |
| Nombre del usuario | `$USER` | `$env:USERNAME` | Tu nombre de usuario |
| Rutas de programas | `$PATH` | `$env:PATH` | Dónde buscar ejecutables |
| Directorio actual | `$PWD` | `$env:CD` o `pwd` | Carpeta donde estás ahora |
| Sistema operativo | `$OSTYPE` | `$env:OS` | Tipo de sistema |

**Ejemplo práctico - Ver todas las variables:**

```bash
# Linux/macOS/Git Bash
env                    # Ver todas las variables
env | grep "HOME"      # Buscar variable específica

# PowerShell
Get-ChildItem env:     # Ver todas
gci env: | Select-String "USER"  # Buscar específica
```

### 🔒 Hacer Variables Permanentes

Por defecto, las variables solo duran mientras la terminal está abierta.

#### **Linux / macOS (permanente)**

```bash
# Agregar al archivo de configuración de tu shell
echo 'export OPENAI_API_KEY="sk-xxxxx"' >> ~/.bashrc    # Bash
# o
echo 'export OPENAI_API_KEY="sk-xxxxx"' >> ~/.zshrc     # Zsh (macOS moderno)

# Recargar configuración
source ~/.bashrc   # o source ~/.zshrc
```

#### **PowerShell (permanente)**

```powershell
# Definir variable permanente para el usuario
[System.Environment]::SetEnvironmentVariable('OPENAI_API_KEY', 'sk-xxxxx', 'User')

# O editar el perfil de PowerShell
notepad $PROFILE
# Agregar: $env:OPENAI_API_KEY = "sk-xxxxx"
```

### 📁 Uso Práctico con Archivo .env

**La mejor práctica:** Usar archivo `.env` + librería `python-dotenv`

**1. Crear archivo `.env`:**
```bash
# archivo: .env
OPENAI_API_KEY=sk-xxxxxxxxxxxxx
DATABASE_URL=postgresql://localhost/mydb
DEBUG=True
```

**2. En Python, cargar automáticamente:**
```python
from dotenv import load_dotenv
import os

# Cargar variables desde .env
load_dotenv()

# Usar las variables
api_key = os.getenv("OPENAI_API_KEY")
debug = os.getenv("DEBUG")
```

**3. Ventajas:**
- ✅ No expones API keys en el código
- ✅ Funciona igual en todos los sistemas operativos
- ✅ Fácil de compartir proyecto (sin compartir keys)
- ✅ Cada desarrollador tiene su propio .env

---

## 📂 4. Rutas: Absolutas vs Relativas

### 🗺️ Ruta Absoluta (Completa)

Especifica la ubicación **desde la raíz** del sistema de archivos.

| **Sistema** | **Formato** | **Ejemplo** |
|-------------|-------------|-------------|
| Linux/macOS | `/ruta/completa/archivo` | `/home/usuario/proyectos/agent.py` |
| Windows | `C:\ruta\completa\archivo` | `C:\Users\usuario\proyectos\agent.py` |
| Git Bash (Windows) | `/c/ruta/completa/archivo` | `/c/Users/usuario/proyectos/agent.py` |

**Características:**
- ✅ Funciona desde **cualquier** ubicación
- ✅ Siempre encuentra el archivo
- ❌ Largo de escribir
- ❌ No es portable entre sistemas

### 🧭 Ruta Relativa (Desde donde estás)

Especifica la ubicación **relativa a tu directorio actual**.

| **Símbolo** | **Significado** | **Ejemplo** |
|-------------|-----------------|-------------|
| `.` | Directorio actual | `./agent.py` = archivo en carpeta actual |
| `..` | Directorio padre (un nivel arriba) | `../data/file.txt` |
| `../..` | Dos niveles arriba | `../../config.json` |
| `sin prefijo` | También es relativo | `agent.py` = mismo que `./agent.py` |

**Ejemplo visual:**

```
/home/usuario/
├── proyectos/
│   ├── agentes/         ← ESTÁS AQUÍ (tu ubicación actual)
│   │   ├── agent.py
│   │   └── tools/
│   │       └── search.py
│   └── data/
│       └── training.csv
└── documentos/
    └── notas.txt

# Si estás en: /home/usuario/proyectos/agentes/

./agent.py              →  /home/usuario/proyectos/agentes/agent.py
./tools/search.py       →  /home/usuario/proyectos/agentes/tools/search.py
../data/training.csv    →  /home/usuario/proyectos/data/training.csv
../../documentos/notas.txt → /home/usuario/documentos/notas.txt
```

**Casos prácticos:**

```bash
# Estás en: /home/usuario/proyectos/agentes/

# Ejecutar script en carpeta actual
python agent.py              # o python ./agent.py

# Ejecutar script en carpeta padre
python ../main.py

# Copiar archivo de carpeta hermana
cp ../data/config.json .     # El punto final = aquí

# Ir a carpeta hermana
cd ../data

# Subir dos niveles y entrar en otra carpeta
cd ../../documentos
```

---

## ✅ Resumen: Dominando la Sintaxis CLI

### 🎯 Estructura Siempre:
```
comando [opciones] [argumentos]
```

### 🔑 Operadores Clave:
- `>` y `>>` → Guardar salida
- `|` → Conectar comandos
- `&&` → Ejecutar si hay éxito
- `||` → Ejecutar si hay error
- `*` → Comodín para múltiples archivos

### 🌍 Variables de Entorno:
- Linux/macOS: `export VAR="valor"` y usar con `$VAR`
- PowerShell: `$env:VAR="valor"` y usar con `$env:VAR`
- Mejor práctica: Archivo `.env` + `python-dotenv`

### 📂 Rutas:
- Absoluta: `/ruta/completa` o `C:\ruta\completa`
- Relativa: `.` (aquí), `..` (arriba), `./archivo`

---

**🎓 Con esto dominas la LÓGICA de la terminal. Ahora puedes entender CUALQUIER comando que veas.**

**➡️ Siguiente paso:** Parte 2 - Comandos específicos organizados por tarea.