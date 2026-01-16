# 📦 ¿Qué Son los Paquetes? (Package Fundamentals)

**Objetivo:** Entender QUÉ son los paquetes antes de aprender a instalarlos  
**Por qué este archivo:** No puedes dominar package managers sin entender qué gestionan  
**Requisito previo:** Haber leído `00_cli_fundamentals.md` y `02_cli_commands_basics.md`

---

## 🎯 **El Problema que Resuelven los Paquetes**

### Escenario Sin Paquetes (El Infierno del Desarrollo)

Imagina que quieres crear un agente con LangChain:

```python
# agent.py
from langchain import OpenAI  # ❌ ModuleNotFoundError: No module named 'langchain'
```

**Sin sistema de paquetes, tendrías que:**

1. **Buscar el código fuente de LangChain**
   - Ir a GitHub, encontrar el repo
   - Descargar todo el código (miles de archivos)
   
2. **Gestionar dependencias manualmente**
   - LangChain necesita `requests`, `pydantic`, `numpy`, etc.
   - Cada dependencia tiene SUS propias dependencias
   - Acabas con 50+ librerías para descargar manualmente

3. **Instalar cada una en el lugar correcto**
   - ¿Dónde poner los archivos para que Python los encuentre?
   - ¿Qué versión de cada librería es compatible?
   - ¿Cómo actualizar cuando sale nueva versión?

4. **Resolver conflictos de versiones**
   - LangChain necesita `pydantic >= 2.0`
   - Otra librería necesita `pydantic < 2.0`
   - 💥 Conflicto imposible de resolver

**Conclusión:** Sería imposible desarrollar software moderno sin automatización.

---

## 📦 **¿Qué Es un Paquete?**

### Definición Simple

> **Paquete (Package):** Unidad distribuible de software que contiene código, metadata, y dependencias empaquetadas para fácil instalación.

### Componentes de un Paquete

```
langchain-0.1.0.tar.gz  ← El paquete completo
│
├── Código fuente
│   ├── langchain/
│   │   ├── __init__.py
│   │   ├── llms.py
│   │   ├── agents.py
│   │   └── ...
│   
├── Metadata (información del paquete)
│   ├── Nombre: langchain
│   ├── Versión: 0.1.0
│   ├── Autor: Harrison Chase
│   ├── Licencia: MIT
│   └── Descripción: "Framework para LLM apps"
│   
├── Dependencias (qué otros paquetes necesita)
│   ├── pydantic >= 2.0
│   ├── requests >= 2.28.0
│   ├── numpy >= 1.20
│   └── ...
│   
└── Instrucciones de instalación
    ├── Dónde copiar archivos
    ├── Scripts post-instalación
    └── Entry points (comandos CLI)
```

### Analogía: Paquete = IKEA Furniture Box

| Concepto | Mueble IKEA | Paquete Python |
|----------|-------------|----------------|
| **Producto** | Estantería BILLY | Librería `langchain` |
| **Embalaje** | Caja plana | Archivo `.tar.gz` o `.whl` |
| **Piezas** | Tablones, tornillos | Archivos `.py` |
| **Instrucciones** | Manual IKEA | `setup.py` / `pyproject.toml` |
| **Dependencias** | "Requiere destornillador" | `requires = ["pydantic>=2.0"]` |
| **Instalación** | Ensamblar según manual | `pip install` |
| **Resultado** | Mueble funcional en tu casa | Librería importable en Python |

---

## 🔍 **Anatomía de un Paquete Python**

### Estructura Típica de un Paquete

```
langchain/                    ← Directorio del proyecto
│
├── langchain/                ← Código fuente principal
│   ├── __init__.py          ← Hace que sea un paquete Python
│   ├── llms/
│   │   ├── __init__.py
│   │   ├── openai.py
│   │   └── anthropic.py
│   ├── agents/
│   │   ├── __init__.py
│   │   └── agent.py
│   └── utils.py
│
├── tests/                    ← Tests (no se instalan)
│   ├── test_llms.py
│   └── test_agents.py
│
├── docs/                     ← Documentación (no se instala)
│
├── pyproject.toml            ← **Metadata moderna (PEP 621)**
├── setup.py                  ← Metadata legacy (aún común)
├── README.md                 ← Descripción del proyecto
├── LICENSE                   ← Términos de uso
└── MANIFEST.in               ← Qué archivos incluir en distribución
```

### pyproject.toml - El Corazón del Paquete Moderno

```toml
[project]
name = "langchain"
version = "0.1.0"
description = "Framework for building LLM applications"
authors = [{name = "Harrison Chase", email = "harrison@langchain.com"}]
license = {text = "MIT"}
readme = "README.md"
requires-python = ">=3.8"

dependencies = [
    "pydantic>=2.0",
    "requests>=2.28.0",
    "numpy>=1.20.0",
    "aiohttp>=3.8.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=7.0",
    "black>=22.0",
    "mypy>=0.990",
]
openai = [
    "openai>=1.0",
]

[project.urls]
Homepage = "https://langchain.com"
Repository = "https://github.com/langchain-ai/langchain"
Documentation = "https://docs.langchain.com"

[build-system]
requires = ["setuptools>=61.0", "wheel"]
build-backend = "setuptools.build_meta"
```

**Desglose:**

| Sección | Propósito | Ejemplo |
|---------|-----------|---------|
| `[project]` | Metadata básica | Nombre, versión, autores |
| `dependencies` | Paquetes REQUERIDOS | `pydantic>=2.0` |
| `optional-dependencies` | Extras opcionales | `dev` para desarrollo, `openai` para soporte OpenAI |
| `requires-python` | Versión mínima de Python | `>=3.8` |
| `[build-system]` | Cómo construir el paquete | `setuptools`, `poetry`, `hatch` |

---

## 🏗️ **Tipos de Paquetes**

### 1. Paquetes Binarios (System Packages)

**¿Qué son?** Software compilado para el sistema operativo (no código Python)

**Ejemplos:**
- `htop` - Monitor de procesos (Linux)
- `git` - Control de versiones
- `curl` - Cliente HTTP
- `nginx` - Servidor web

**Gestor:** Package manager del sistema (apt, brew, winget)

**Instalación:**
```bash
# Linux
sudo apt install htop

# macOS
brew install htop

# Windows
winget install htop
```

**Características:**
- ✅ Instalación global (todos los usuarios)
- ✅ Integrado con el OS
- ❌ No aislado por proyecto
- ❌ Requiere permisos de administrador

### 2. Paquetes de Lenguaje (Language Packages)

**¿Qué son?** Librerías escritas en el lenguaje (Python, JavaScript, etc.)

**Ejemplos Python:**
- `langchain` - Framework para LLMs
- `requests` - HTTP client
- `pandas` - Data analysis
- `numpy` - Numerical computing

**Gestor:** Package manager del lenguaje (pip para Python, npm para JavaScript)

**Instalación:**
```bash
# Python
pip install langchain

# JavaScript/Node.js
npm install express
```

**Características:**
- ✅ Específico del lenguaje
- ✅ Puede instalarse por proyecto (con virtual environments)
- ✅ Fácil actualización
- ❌ No incluye binarios del sistema

### 3. Paquetes Híbridos (Hybrid Packages)

**¿Qué son?** Combinan gestión de lenguaje + binarios + entornos

**Ejemplos:**
- `conda` - Python + R + paquetes del sistema
- `poetry` - Python + gestión de dependencias avanzada

**Instalación:**
```bash
# Conda
conda install numpy

# Poetry
poetry add langchain
```

**Características:**
- ✅ Gestionan múltiples lenguajes
- ✅ Incluyen binarios (e.g., CUDA, BLAS)
- ✅ Gestión de entornos integrada
- ❌ Más complejos de configurar

---

## 📚 **Repositorios de Paquetes**

### ¿Qué Es un Repositorio?

> **Repositorio (Repository):** Servidor centralizado que almacena y distribuye paquetes.

**Analogía:** App Store para código

| App Store | Package Repository |
|-----------|-------------------|
| Apple App Store | PyPI (Python Package Index) |
| Google Play Store | npm registry (JavaScript) |
| Descargar app | `pip install package` |
| Actualizar app | `pip install --upgrade package` |
| Ver descripción | `pip show package` |

### Repositorios Principales por Lenguaje

| Lenguaje | Repositorio | URL | Número de Paquetes |
|----------|-------------|-----|-------------------|
| **Python** | PyPI | https://pypi.org | ~500,000 |
| **JavaScript** | npm | https://www.npmjs.com | ~2,000,000 |
| **Ruby** | RubyGems | https://rubygems.org | ~175,000 |
| **Rust** | crates.io | https://crates.io | ~130,000 |
| **Go** | pkg.go.dev | https://pkg.go.dev | Distribuido |

### PyPI - Python Package Index

**¿Qué es?** Repositorio oficial de paquetes Python

**URL:** https://pypi.org

**Estadísticas (Nov 2025):**
- ~500,000 paquetes
- ~5 millones de descargas por día
- Cualquiera puede publicar (gratis)

**Buscar paquetes:**
```bash
# En navegador
https://pypi.org/search/?q=langchain

# Desde CLI
pip search langchain  # ⚠️ Deshabilitado desde 2021 (sobrecarga servidor)
```

**Ver información de paquete:**
```bash
# Desde CLI
pip show langchain

# Output:
# Name: langchain
# Version: 0.1.0
# Summary: Framework for building LLM applications
# Home-page: https://langchain.com
# Author: Harrison Chase
# License: MIT
# Location: /home/user/.venv/lib/python3.11/site-packages
# Requires: pydantic, requests, numpy, aiohttp
# Required-by: langchain-experimental, langchain-openai
```

**Explorar en navegador:**
```
https://pypi.org/project/langchain/
```

Muestra:
- Descripción completa
- Historial de versiones
- Dependencias
- Estadísticas de descargas
- Enlaces a GitHub, documentación

### Repositorios del Sistema

| OS | Repositorio | Gestor | Paquetes |
|----|-------------|--------|----------|
| **Ubuntu/Debian** | Ubuntu Archive | `apt` | ~60,000 |
| **Fedora/RHEL** | Fedora Repository | `dnf` | ~50,000 |
| **Arch Linux** | Arch Repository + AUR | `pacman` | ~80,000 |
| **macOS** | Homebrew | `brew` | ~6,000 |
| **Windows** | Microsoft Store + winget | `winget` | ~10,000 |

**Ejemplo - Ver repositorios configurados:**

```bash
# Ubuntu/Debian
cat /etc/apt/sources.list

# Output:
# deb http://archive.ubuntu.com/ubuntu/ jammy main restricted
# deb http://security.ubuntu.com/ubuntu/ jammy-security main

# macOS
brew tap

# Output:
# homebrew/core
# homebrew/cask

# Windows PowerShell
winget source list

# Output:
# Name: winget
# Argument: https://cdn.winget.microsoft.com/cache
```

---

## 🔢 **Versionado de Paquetes (Semantic Versioning)**

### ¿Por Qué Importan las Versiones?

**Problema:**
```python
# Tu código funciona con langchain 0.1.0
from langchain import Agent

# Alguien actualiza a langchain 0.2.0
from langchain import Agent  # ❌ ImportError: Agent renamed to BaseAgent
```

**Solución:** Especificar versiones compatibles en `requirements.txt`

### Semantic Versioning (SemVer)

**Formato:** `MAJOR.MINOR.PATCH` (e.g., `2.1.5`)

```
2  .  1  .  5
│     │     │
│     │     └─ PATCH: Bug fixes (compatible)
│     └─────── MINOR: New features (compatible)
└───────────── MAJOR: Breaking changes (incompatible)
```

**Reglas:**

| Incremento | Cuándo | Compatibilidad | Ejemplo |
|------------|--------|----------------|---------|
| **MAJOR** | Cambios incompatibles | ❌ Breaking | `1.9.3` → `2.0.0` (API cambió) |
| **MINOR** | Nuevas features compatibles | ✅ Compatible | `2.1.5` → `2.2.0` (nueva función) |
| **PATCH** | Bug fixes | ✅ Compatible | `2.1.5` → `2.1.6` (arreglo) |

**Ejemplos reales:**

```
Django 4.2.7
│  │  └─ Patch 7: Bug fix (seguro actualizar)
│  └──── Minor 2: Nuevas features (seguro actualizar)
└────── Major 4: Cambios grandes (revisar changelog)

pydantic 2.5.3
│  │  └─ Patch 3: Bug fixes
│  └──── Minor 5: New validators
└────── Major 2: Complete rewrite (incompatible con v1)
```

### Especificadores de Versión

**En `requirements.txt` o `pyproject.toml`:**

```txt
# Versión exacta (muy restrictivo)
langchain==0.1.0

# Versión mínima (cualquier versión >= 0.1.0)
langchain>=0.1.0

# Rango compatible (~= compatible release)
langchain~=0.1.0    # Equivale a >=0.1.0, <0.2.0

# Rango explícito
langchain>=0.1.0,<0.2.0

# Excluir versiones problemáticas
langchain>=0.1.0,!=0.1.5,<0.2.0

# Cualquier versión (peligroso en producción)
langchain
```

**Operadores:**

| Operador | Significado | Ejemplo | Permite |
|----------|-------------|---------|---------|
| `==` | Exacto | `==0.1.0` | Solo 0.1.0 |
| `>=` | Mínimo | `>=0.1.0` | 0.1.0, 0.2.0, 1.0.0... |
| `<` | Menor que | `<0.2.0` | 0.1.0, 0.1.9, pero NO 0.2.0 |
| `~=` | Compatible | `~=0.1.0` | 0.1.0, 0.1.5, pero NO 0.2.0 |
| `!=` | Excluir | `!=0.1.5` | Cualquiera excepto 0.1.5 |

**Mejores prácticas:**

```txt
# ✅ Bueno: Permite patches y minors seguros
langchain>=0.1.0,<1.0.0

# ✅ Bueno: Compatible release (recomienda pip)
langchain~=0.1.0

# ⚠️ Aceptable en desarrollo: Siempre última versión
langchain

# ❌ Malo en producción: Demasiado restrictivo
langchain==0.1.0

# ❌ Malo: Puede romper en actualizaciones mayores
langchain>=0.1.0
```

---

## 🧩 **Dependencias - La Cascada de Paquetes**

### ¿Qué Son las Dependencias?

> **Dependencia:** Paquete que OTRO paquete necesita para funcionar.

**Ejemplo:**

```
Tu proyecto
    └─ langchain 0.1.0
        ├─ pydantic >= 2.0
        │   └─ typing-extensions >= 4.0
        ├─ requests >= 2.28.0
        │   ├─ urllib3 >= 1.26
        │   ├─ certifi >= 2020.0
        │   └─ charset-normalizer >= 2.0
        └─ numpy >= 1.20.0
            └─ (sin dependencias, pure C)
```

**Cuando instalas `langchain`, pip automáticamente:**
1. Lee `langchain` dependencies
2. Descarga `pydantic`, `requests`, `numpy`
3. Lee ESAS dependencies
4. Descarga `typing-extensions`, `urllib3`, `certifi`, etc.
5. Instala todo en orden correcto

**Verificación:**

```bash
# Ver dependencias de un paquete
pip show langchain

# Output:
# Requires: pydantic, requests, numpy, aiohttp
# Required-by: langchain-experimental, langchain-openai

# Ver árbol completo de dependencias (requiere pipdeptree)
pip install pipdeptree
pipdeptree -p langchain

# Output:
# langchain==0.1.0
# ├── pydantic [required: >=2.0, installed: 2.5.3]
# │   └── typing-extensions [required: >=4.0, installed: 4.9.0]
# ├── requests [required: >=2.28.0, installed: 2.31.0]
# │   ├── certifi [required: >=2020.0, installed: 2023.11.17]
# │   ├── charset-normalizer [required: >=2.0, installed: 3.3.2]
# │   └── urllib3 [required: >=1.26, installed: 2.1.0]
# └── numpy [required: >=1.20.0, installed: 1.26.2]
```

### Tipos de Dependencias

#### 1. Runtime Dependencies (Requeridas)

**¿Qué son?** Paquetes necesarios para USAR la librería

```toml
# pyproject.toml
dependencies = [
    "pydantic>=2.0",      # Necesario para validación
    "requests>=2.28.0",   # Necesario para HTTP calls
]
```

**Se instalan automáticamente:**
```bash
pip install langchain  # Instala langchain + runtime deps
```

#### 2. Development Dependencies (Opcionales)

**¿Qué son?** Paquetes necesarios para DESARROLLAR la librería (no para usarla)

```toml
# pyproject.toml
[project.optional-dependencies]
dev = [
    "pytest>=7.0",        # Para tests
    "black>=22.0",        # Para formatear código
    "mypy>=0.990",        # Para type checking
    "sphinx>=5.0",        # Para documentación
]
```

**Se instalan explícitamente:**
```bash
pip install langchain[dev]  # Instala con extras "dev"
```

#### 3. Optional Dependencies (Features Extras)

**¿Qué son?** Paquetes para funcionalidad adicional (no core)

```toml
# pyproject.toml
[project.optional-dependencies]
openai = ["openai>=1.0"]           # Para soporte OpenAI
anthropic = ["anthropic>=0.8"]     # Para soporte Anthropic
all = ["openai>=1.0", "anthropic>=0.8"]  # Todas las opciones
```

**Instalación selectiva:**
```bash
pip install langchain              # Solo core
pip install langchain[openai]      # Core + OpenAI
pip install langchain[anthropic]   # Core + Anthropic
pip install langchain[all]         # Core + todos los extras
pip install langchain[openai,anthropic]  # Core + selección manual
```

### Dependency Hell - El Problema de Conflictos

**Escenario:**

```
Tu proyecto necesita:
    ├─ libreria-a 1.0
    │   └─ pydantic >= 2.0
    └─ libreria-b 1.0
        └─ pydantic < 2.0

❌ CONFLICTO: No existe versión de pydantic que satisfaga ambas
```

**Soluciones:**

1. **Actualizar librerías:**
   ```bash
   pip install --upgrade libreria-b  # Esperar que soporte pydantic 2.0
   ```

2. **Usar versiones compatibles:**
   ```bash
   pip install libreria-a==0.9  # Versión anterior que use pydantic < 2.0
   ```

3. **Separar en virtual environments:**
   ```bash
   # venv1 para libreria-a
   python -m venv venv1
   source venv1/bin/activate
   pip install libreria-a

   # venv2 para libreria-b
   python -m venv venv2
   source venv2/bin/activate
   pip install libreria-b
   ```

4. **Reportar issue en GitHub:**
   - Pedir a los desarrolladores que actualicen dependencias

---

## 📦 **Formatos de Paquetes Python**

### Source Distribution (sdist)

**Formato:** `.tar.gz` o `.zip`

**Contenido:** Código fuente sin compilar

**Ejemplo:**
```
langchain-0.1.0.tar.gz
    ├── langchain/          ← Código Python
    ├── setup.py            ← Instrucciones instalación
    ├── pyproject.toml
    ├── README.md
    └── LICENSE
```

**Instalación:**
```bash
pip install langchain-0.1.0.tar.gz
```

**Proceso:**
1. Descomprime el archivo
2. Ejecuta `python setup.py build` (si hay C extensions)
3. Copia archivos a `site-packages/`

**Ventajas:**
- ✅ Compatible con cualquier plataforma
- ✅ Transparente (puedes ver el código antes de instalar)

**Desventajas:**
- ❌ Instalación lenta (compila en tu máquina)
- ❌ Requiere compilador si hay C extensions

### Wheel (bdist_wheel)

**Formato:** `.whl` (archivo ZIP con nombre especial)

**Contenido:** Código pre-compilado (listo para copiar)

**Ejemplo:**
```
langchain-0.1.0-py3-none-any.whl
│          │    │   │    │
│          │    │   │    └─ any: Cualquier plataforma
│          │    │   └────── none: Sin ABI específico
│          │    └────────── py3: Python 3
│          └─────────────── Versión
└────────────────────────── Nombre paquete
```

**Tipos de wheels:**

```
# Pure Python (multiplataforma)
langchain-0.1.0-py3-none-any.whl

# Python + C extensions (específico de plataforma)
numpy-1.26.0-cp311-cp311-manylinux_2_17_x86_64.whl
│            │     │     │
│            │     │     └─ manylinux: Linux compatible
│            │     └─────── ABI tag
│            └───────────── CPython 3.11
```

**Instalación:**
```bash
pip install langchain-0.1.0-py3-none-any.whl
```

**Proceso:**
1. Descomprime el .whl
2. Copia directo a `site-packages/` (sin compilar)
3. Registra metadata

**Ventajas:**
- ✅ Instalación rápida (pre-compilado)
- ✅ No requiere compilador
- ✅ Formato preferido de pip

**Desventajas:**
- ❌ Específico de plataforma (si tiene C extensions)
- ❌ Tamaño mayor que sdist

**Verificar qué formato descarga pip:**

```bash
pip install --no-cache-dir --verbose langchain

# Output incluye:
# Downloading langchain-0.1.0-py3-none-any.whl (1.2 MB)
# Using cached langchain-0.1.0.tar.gz (800 KB)
```

---

## 🔍 **Inspeccionar Paquetes Instalados**

### Listar Paquetes Instalados

```bash
# Ver todos los paquetes
pip list

# Output:
# Package          Version
# ---------------- -------
# langchain        0.1.0
# pydantic         2.5.3
# requests         2.31.0
# ...

# Solo paquetes instalados manualmente (no dependencies)
pip list --not-required

# Ver paquetes desactualizados
pip list --outdated

# Output:
# Package    Version  Latest   Type
# ---------- -------- -------- -----
# requests   2.28.0   2.31.0   wheel
```

### Información Detallada de un Paquete

```bash
pip show langchain

# Output:
# Name: langchain
# Version: 0.1.0
# Summary: Framework for building LLM applications
# Home-page: https://langchain.com
# Author: Harrison Chase
# Author-email: harrison@langchain.com
# License: MIT
# Location: /home/user/.venv/lib/python3.11/site-packages
# Requires: pydantic, requests, numpy, aiohttp
# Required-by: langchain-experimental, langchain-openai
```

**Campos importantes:**

| Campo | Significado |
|-------|-------------|
| `Location` | Dónde está instalado el paquete |
| `Requires` | Dependencias directas (qué necesita) |
| `Required-by` | Dependencias inversas (quién lo necesita) |

### Ver Archivos de un Paquete

```bash
pip show --files langchain

# Output (truncado):
# Location: /home/user/.venv/lib/python3.11/site-packages
# Files:
#   langchain/__init__.py
#   langchain/llms/__init__.py
#   langchain/llms/openai.py
#   langchain/agents/agent.py
#   ...
#   langchain-0.1.0.dist-info/METADATA
#   langchain-0.1.0.dist-info/RECORD
```

**Estructura instalada:**

```
site-packages/
    ├── langchain/              ← Código del paquete
    │   ├── __init__.py
    │   ├── llms/
    │   └── agents/
    │
    └── langchain-0.1.0.dist-info/  ← Metadata del paquete
        ├── METADATA            ← Información del paquete
        ├── RECORD              ← Lista de archivos instalados
        ├── WHEEL               ← Formato de distribución
        ├── top_level.txt       ← Módulos top-level
        └── entry_points.txt    ← Comandos CLI (si hay)
```

### Verificar Integridad de Paquetes

```bash
# Verificar que todos los archivos están intactos
pip check

# Output si todo OK:
# No broken requirements found.

# Output si hay problemas:
# langchain 0.1.0 requires pydantic>=2.0, but you have pydantic 1.10.0.
```

---

## 🛠️ **Caso Práctico: Anatomía de una Instalación**

### Instalar y Explorar un Paquete

```bash
# 1. Crear entorno limpio
python -m venv test_venv
source test_venv/bin/activate  # Linux/macOS
.\test_venv\Scripts\Activate.ps1  # Windows

# 2. Instalar paquete con verbose
pip install --verbose langchain

# Observa el proceso:
# - Downloading langchain-0.1.0-py3-none-any.whl
# - Collecting pydantic>=2.0
# - Downloading pydantic-2.5.3-py3-none-any.whl
# - Installing collected packages: typing-extensions, pydantic, ...
# - Successfully installed langchain-0.1.0 pydantic-2.5.3 ...

# 3. Ver qué se instaló
pip list

# 4. Ver dependencias
pip show langchain

# 5. Ver árbol completo (instalar pipdeptree primero)
pip install pipdeptree
pipdeptree -p langchain

# 6. Explorar archivos
pip show --files langchain | head -20

# 7. Ver ubicación exacta
python -c "import langchain; print(langchain.__file__)"
# Output: /path/to/venv/lib/python3.11/site-packages/langchain/__init__.py

# 8. Inspeccionar metadata
cat $(pip show langchain | grep Location | cut -d' ' -f2)/langchain-0.1.0.dist-info/METADATA

# 9. Ver requisitos originales
cat $(pip show langchain | grep Location | cut -d' ' -f2)/langchain-0.1.0.dist-info/METADATA | grep "Requires-Dist:"
```

---

## 📊 **Resumen Visual: Ecosistema de Paquetes**

```
┌─────────────────────────────────────────────────────────┐
│                    DESARROLLO                           │
│                                                         │
│  Developer crea paquete                                 │
│  └─ Código Python                                       │
│  └─ pyproject.toml (metadata + dependencies)            │
│  └─ README, LICENSE                                     │
│                                                         │
│  Developer ejecuta: python -m build                     │
│  └─ Genera: langchain-0.1.0.tar.gz (sdist)              │
│  └─ Genera: langchain-0.1.0-py3-none-any.whl (wheel)    │
│                                                         │
│  Developer publica: python -m twine upload dist/*       │
│                                                         │
└────────────────┬────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────┐
│              PyPI (REPOSITORIO)                         │
│                                                         │
│  Almacena:                                              │
│  ├─ langchain-0.1.0.tar.gz                              │
│  ├─ langchain-0.1.0-py3-none-any.whl                    │
│  └─ Metadata (descripción, versiones, stats)            │
│                                                         │
│  URL: https://pypi.org/project/langchain/               │
│                                                         │
└────────────────┬────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────┐
│               USUARIO FINAL                             │
│                                                         │
│  Usuario ejecuta: pip install langchain                 │
│                                                         │
│  pip hace:                                              │
│  1. Busca "langchain" en PyPI                           │
│  2. Descarga langchain-0.1.0-py3-none-any.whl           │
│  3. Lee metadata → Ve dependencias: pydantic, requests  │
│  4. Descarga pydantic-2.5.3-py3-none-any.whl            │
│  5. Descarga requests-2.31.0-py3-none-any.whl           │
│  6. Descarga typing-extensions, urllib3, certifi...     │
│  7. Instala todo en orden en site-packages/             │
│                                                         │
│  Resultado:                                             │
│  ~/.venv/lib/python3.11/site-packages/                  │
│      ├─ langchain/                                      │
│      ├─ pydantic/                                       │
│      ├─ requests/                                       │
│      └─ ... (+ metadata .dist-info)                     │
│                                                         │
│  Usuario puede: from langchain import Agent             │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## ✅ **Checkpoint de Aprendizaje**

**Ahora sabes:**

1. ✅ **Qué es un paquete:** Unidad distribuible de software (código + metadata + dependencias)
2. ✅ **Componentes:** Código fuente, metadata (pyproject.toml), dependencias, instrucciones
3. ✅ **Tipos:** System packages (binarios), language packages (Python/JS), híbridos (conda)
4. ✅ **Repositorios:** PyPI para Python, npm para JS, Homebrew para macOS, etc.
5. ✅ **Versionado:** Semantic Versioning (MAJOR.MINOR.PATCH)
6. ✅ **Dependencias:** Runtime (requeridas), development (dev), optional (extras)
7. ✅ **Formatos:** Source distribution (.tar.gz) vs Wheel (.whl)
8. ✅ **Inspección:** `pip list`, `pip show`, `pip show --files`, `pipdeptree`

---

## 🎯 **Conceptos Clave para Recordar**

```
📦 Paquete = Código + Metadata + Dependencias + Instrucciones
🏪 Repositorio = Servidor centralizado de paquetes (PyPI, npm, brew)
🔢 SemVer = MAJOR.MINOR.PATCH (2.1.5)
🔗 Dependencias = Paquetes que otro paquete necesita
🎡 Wheel (.whl) = Formato pre-compilado (rápido)
📦 sdist (.tar.gz) = Código fuente (compatible)
```

---

## 🚀 **Siguiente Paso**

**Próximo archivo:** `04_package_managers_by_type.md`

**Aprenderás:**
- Diferencias entre apt, brew, pip, npm, conda
- Cuándo usar cada package manager
- Badge system aplicado (🖥️ vs 🐍 vs 🔧)
- Comandos básicos de cada gestor
- Cómo interactúan entre sí

**Ahora que entiendes QUÉ son los paquetes, aprenderás CÓMO gestionarlos.**

---

## 📚 **Referencias y Profundización**

**Documentación oficial:**
- PyPI: https://pypi.org
- Python Packaging: https://packaging.python.org
- PEP 621 (pyproject.toml): https://peps.python.org/pep-0621/
- Semantic Versioning: https://semver.org

**Herramientas mencionadas:**
- `pipdeptree`: https://github.com/tox-dev/pipdeptree
- `setuptools`: https://setuptools.pypa.io
- `build`: https://pypa-build.readthedocs.io
- `twine`: https://twine.readthedocs.io

**Explorar paquetes:**
- PyPI: https://pypi.org
- Libraries.io: https://libraries.io (multi-lenguaje)
- Snyk Advisor: https://snyk.io/advisor/ (seguridad + popularidad)

---

**Archivos en la serie:**
1. ✅ 00_cli_fundamentals.md
2. 01_cli_syntax_guide.md
3. ✅ 02_cli_commands_basics.md
4. ✅ 03_what_are_packages.md ← **Estás aquí**
5. 04_package_managers_by_type.md
6. 05_essential_packages.md
7. 06_runtime_version_managers.md
8. 07_python_virtual_environments_deep_dive.md
9. 08_hybrid_package_managers.md
10. 09_integrated_workflow_practice.md

---

**🎉 ¡File 3 Complete! Ready for File 4: Package Managers by Type**
