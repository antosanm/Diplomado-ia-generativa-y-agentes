# 🎛️ Package Managers por Tipo (Complete Classification)

**Objetivo:** Entender TODOS los tipos de package managers y cuándo usar cada uno  
**Por qué este archivo:** Evitar confusión entre apt, pip, conda, brew, npm, etc.  
**Requisito previo:** Haber leído `03_what_are_packages.md` (entender qué son paquetes)

---

## 🎯 **El Problema: Demasiados Gestores**

### Situación Confusa Común

```bash
# ¿Cuál usar? ¿Cuál es correcto?
sudo apt install python-langchain     # ❌ No existe
pip install langchain                  # ✅ Correcto
conda install langchain                # ✅ También correcto
brew install langchain                 # ❌ No existe (brew es para binarios)
npm install langchain                  # ❌ Ese es para JavaScript
```

**Necesitas saber:**
1. **Qué gestiona cada package manager** (binarios OS vs librerías lenguaje)
2. **Cuándo usar cada uno** (conflictos si mezclas mal)
3. **Cómo interactúan** (pip dentro de venv, no con sudo)

---

## 🏗️ **Clasificación Completa de Package Managers**

### Badge System Recordatorio

| Badge | Tipo | Gestiona | Ejemplos |
|-------|------|----------|----------|
| 🖥️ **[SYS-PM]** | System Package Manager | Binarios del OS | apt, brew, winget |
| 🐍 **[LANG-PM]** | Language Package Manager | Librerías del lenguaje | pip, npm, gem |
| 🔄 **[VER-MGR]** | Runtime Version Manager | Versiones de runtimes | pyenv, nvm, rbenv |
| 📦 **[ENV-MGR]** | Environment Manager | Entornos aislados | venv, virtualenv |
| 🔧 **[HYBRID-PM]** | Hybrid Package Manager | Todo lo anterior | conda, poetry |

---

## 1️⃣ **System Package Managers (🖥️ [SYS-PM])**

### ¿Qué Gestionan?

**Binarios del sistema operativo:**
- Compiladores (gcc, clang)
- Herramientas CLI (git, curl, htop)
- Servidores (nginx, postgresql)
- Librerías del sistema (OpenSSL, CUDA)
- Python INTÉRPRETE (no librerías Python)

### Gestores por OS

| OS | Package Manager | Repositorio | Comando Base |
|----|----------------|-------------|--------------|
| **Ubuntu/Debian** | apt | Ubuntu Archive | `apt install` |
| **Fedora/RHEL** | dnf | Fedora Repos | `dnf install` |
| **Arch Linux** | pacman | Arch Repos | `pacman -S` |
| **macOS** | Homebrew | Homebrew Core | `brew install` |
| **Windows** | winget | Microsoft Store | `winget install` |

### Ubuntu/Debian - apt (Advanced Package Tool)

**Instalación:** Pre-instalado en Ubuntu/Debian

**Comandos esenciales:**

```bash
# Actualizar lista de paquetes disponibles
sudo apt update

# Actualizar paquetes instalados
sudo apt upgrade

# Instalar paquete
sudo apt install htop

# Buscar paquete
apt search htop

# Ver información
apt show htop

# Eliminar paquete
sudo apt remove htop

# Eliminar con configuraciones
sudo apt purge htop

# Limpiar caché
sudo apt autoremove
sudo apt autoclean
```

**Archivos importantes:**

```bash
# Lista de repositorios
cat /etc/apt/sources.list

# Paquetes instalados
dpkg -l

# Verificar si paquete está instalado
dpkg -l | grep htop
```

**Caso práctico - Instalar herramientas esenciales:**

```bash
# Actualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar herramientas desarrollo
sudo apt install -y \
    git \
    curl \
    wget \
    build-essential \
    htop \
    tree \
    vim

# Verificar instalación
git --version
htop --version
```

### macOS - Homebrew

**Instalación:**

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Comandos esenciales:**

```bash
# Instalar paquete
brew install htop

# Buscar paquete
brew search htop

# Ver información
brew info htop

# Listar instalados
brew list

# Actualizar Homebrew
brew update

# Actualizar paquetes
brew upgrade

# Eliminar paquete
brew uninstall htop

# Limpiar versiones antiguas
brew cleanup
```

**Diferencia formulas vs casks:**

```bash
# Formulas = CLI tools
brew install git          # Herramienta CLI

# Casks = GUI applications
brew install --cask visual-studio-code  # App con interfaz
brew install --cask google-chrome
```

**Caso práctico:**

```bash
# Herramientas desarrollo
brew install git python@3.11 node htop

# Aplicaciones GUI
brew install --cask iterm2 visual-studio-code docker
```

### Windows - winget

**Instalación:** Pre-instalado en Windows 11, instalar desde Microsoft Store en Windows 10

**Comandos esenciales:**

```powershell
# Buscar paquete
winget search python

# Instalar paquete
winget install Python.Python.3.11

# Ver información
winget show Python.Python.3.11

# Listar instalados
winget list

# Actualizar paquete
winget upgrade Python.Python.3.11

# Actualizar todo
winget upgrade --all

# Eliminar paquete
winget uninstall Python.Python.3.11
```

**Caso práctico:**

```powershell
# Instalar herramientas desarrollo
winget install Git.Git
winget install Microsoft.VisualStudioCode
winget install Python.Python.3.11
winget install OpenJS.NodeJS

# Verificar
python --version
git --version
```

### ⚠️ **Regla Crítica: System PM vs Language PM**

```bash
# ❌ NUNCA hagas esto:
sudo apt install python3-langchain     # No existe o versión MUY antigua
sudo pip install langchain              # PELIGRO: Contamina Python del sistema

# ✅ SIEMPRE:
# 1. Instala Python con system PM
sudo apt install python3.11

# 2. Instala librerías Python con pip EN VIRTUAL ENV
python3.11 -m venv .venv
source .venv/bin/activate
pip install langchain
```

**Por qué es importante:**
- System PM gestiona binarios (Python intérprete)
- Language PM gestiona librerías (módulos Python)
- Mezclarlos causa conflictos y puede romper el OS

---

## 2️⃣ **Language Package Managers (🐍 [LANG-PM])**

### ¿Qué Gestionan?

**Librerías específicas del lenguaje:**
- Python: `langchain`, `requests`, `numpy`
- JavaScript: `express`, `react`, `axios`
- Ruby: `rails`, `devise`
- Rust: `serde`, `tokio`

### Gestores por Lenguaje

| Lenguaje | Package Manager | Repositorio | Comando |
|----------|----------------|-------------|---------|
| **Python** | pip | PyPI | `pip install` |
| **JavaScript** | npm | npm registry | `npm install` |
| **JavaScript** | yarn | npm registry | `yarn add` |
| **Ruby** | gem | RubyGems | `gem install` |
| **Rust** | cargo | crates.io | `cargo add` |
| **Go** | go | pkg.go.dev | `go get` |

### Python - pip (Package Installer for Python)

**Instalación:** Incluido con Python 3.4+

**Comandos esenciales:**

```bash
# Instalar paquete
pip install langchain

# Instalar versión específica
pip install langchain==0.1.0

# Instalar con extras
pip install langchain[openai]

# Instalar desde requirements.txt
pip install -r requirements.txt

# Listar instalados
pip list

# Ver información paquete
pip show langchain

# Buscar actualizaciones
pip list --outdated

# Actualizar paquete
pip install --upgrade langchain

# Desinstalar
pip uninstall langchain

# Congelar versiones (crear requirements.txt)
pip freeze > requirements.txt

# Verificar dependencias
pip check
```

**Archivos de configuración:**

```bash
# requirements.txt - Dependencias proyecto
langchain>=0.1.0,<1.0.0
pydantic~=2.5.0
requests>=2.28.0

# requirements-dev.txt - Herramientas desarrollo
pytest>=7.0
black>=22.0
mypy>=0.990
```

**Caso práctico - Setup proyecto:**

```bash
# Crear entorno virtual
python -m venv .venv
source .venv/bin/activate  # Linux/macOS
.\.venv\Scripts\Activate.ps1  # Windows

# Instalar dependencias
pip install langchain langchain-openai python-dotenv

# Guardar versiones instaladas
pip freeze > requirements.txt

# Otro desarrollador clona proyecto:
git clone repo
cd repo
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt  # Instala versiones exactas
```

### JavaScript - npm (Node Package Manager)

**Instalación:** Incluido con Node.js

**Comandos esenciales:**

```bash
# Inicializar proyecto
npm init

# Instalar paquete (guarda en package.json)
npm install express

# Instalar como dev dependency
npm install --save-dev jest

# Instalar globalmente (comandos CLI)
npm install -g typescript

# Instalar desde package.json
npm install

# Listar instalados
npm list

# Ver información
npm show express

# Actualizar paquetes
npm update

# Desinstalar
npm uninstall express

# Ver paquetes desactualizados
npm outdated
```

**Archivos de configuración:**

```json
// package.json
{
  "name": "mi-proyecto",
  "version": "1.0.0",
  "dependencies": {
    "express": "^4.18.0",
    "axios": "^1.5.0"
  },
  "devDependencies": {
    "jest": "^29.0.0",
    "typescript": "^5.0.0"
  }
}
```

**Comparación npm vs yarn:**

| Característica | npm | yarn |
|---------------|-----|------|
| Velocidad | Normal | Más rápido (cache) |
| Lock file | `package-lock.json` | `yarn.lock` |
| Comando install | `npm install` | `yarn` o `yarn add` |
| Workspaces | Sí | Sí |
| Popularidad | Mayor | Alta |

---

## 3️⃣ **Runtime Version Managers (🔄 [VER-MGR])**

### ¿Qué Gestionan?

**Múltiples versiones del runtime/lenguaje en el MISMO sistema:**
- Proyecto A necesita Python 3.9
- Proyecto B necesita Python 3.11
- Proyecto C necesita Python 3.12

**Sin version manager:** Imposible, solo puedes tener una versión instalada

**Con version manager:** Cambias entre versiones por proyecto

### Gestores por Lenguaje

| Lenguaje | Version Manager | Comando Switch |
|----------|----------------|----------------|
| **Python** | pyenv | `pyenv local 3.11.0` |
| **JavaScript** | nvm | `nvm use 18.0.0` |
| **Ruby** | rbenv | `rbenv local 3.2.0` |
| **Go** | gvm | `gvm use go1.21` |

### Python - pyenv

**¿Qué hace?** Gestiona múltiples versiones de Python

**Instalación:**

```bash
# Linux/macOS
curl https://pyenv.run | bash

# Agregar a ~/.bashrc o ~/.zshrc:
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Windows (pyenv-win)
# Instalar con pip o desde GitHub
```

**Comandos esenciales:**

```bash
# Ver versiones instalables
pyenv install --list

# Instalar versión específica
pyenv install 3.11.0

# Listar instaladas
pyenv versions

# Establecer versión global
pyenv global 3.11.0

# Establecer versión para proyecto (crea .python-version)
pyenv local 3.11.0

# Verificar versión activa
pyenv version
python --version
```

**Caso práctico:**

```bash
# Proyecto legacy necesita Python 3.9
cd ~/projects/old-project
pyenv local 3.9.0
python --version  # Output: Python 3.9.0

# Proyecto nuevo necesita Python 3.11
cd ~/projects/new-project
pyenv local 3.11.0
python --version  # Output: Python 3.11.0

# pyenv crea archivo .python-version en cada directorio
cat ~/projects/old-project/.python-version  # 3.9.0
cat ~/projects/new-project/.python-version  # 3.11.0
```

### JavaScript - nvm (Node Version Manager)

**Instalación:**

```bash
# Linux/macOS
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Windows (nvm-windows)
# Descargar desde GitHub releases
```

**Comandos esenciales:**

```bash
# Ver versiones disponibles
nvm list available

# Instalar versión
nvm install 18.0.0

# Listar instaladas
nvm list

# Usar versión específica
nvm use 18.0.0

# Establecer versión por defecto
nvm alias default 18.0.0

# Ver versión activa
nvm current
node --version
```

---

## 4️⃣ **Environment Managers (📦 [ENV-MGR])**

### ¿Qué Gestionan?

**Entornos aislados de dependencias:**
- Proyecto A: `langchain 0.1.0` + `pydantic 2.0`
- Proyecto B: `langchain 0.2.0` + `pydantic 1.10`
- Sin conflictos: Cada proyecto tiene su propio directorio de paquetes

### Python Environment Managers

| Herramienta | Método | Cuándo Usar |
|-------------|--------|-------------|
| **venv** | Built-in Python | Simple, estándar, suficiente |
| **virtualenv** | Tercera party | Features extras, legacy |
| **pipenv** | Pipfile + env | Lock files automáticos |

### Python - venv (Recomendado)

**¿Qué hace?** Crea entorno aislado para dependencias Python

**Instalación:** Built-in desde Python 3.3+

**Comandos esenciales:**

```bash
# Crear entorno virtual
python -m venv .venv

# Activar
source .venv/bin/activate           # Linux/macOS
.\.venv\Scripts\Activate.ps1        # Windows PowerShell
.\.venv\Scripts\activate.bat        # Windows CMD

# Verificar activación
which python                         # Linux/macOS: debe mostrar .venv/bin/python
(Get-Command python).Source          # Windows: debe mostrar .venv\Scripts\python.exe

# Instalar paquetes (quedan en .venv)
pip install langchain

# Desactivar
deactivate

# Eliminar entorno (solo borrar carpeta)
rm -rf .venv
```

**Estructura de .venv:**

```
.venv/
├── bin/                    # Linux/macOS
│   ├── python              # Symlink a Python
│   ├── pip
│   └── activate            # Script activación
├── Scripts/                # Windows
│   ├── python.exe
│   ├── pip.exe
│   └── Activate.ps1
├── lib/
│   └── python3.11/
│       └── site-packages/  # Aquí se instalan paquetes
└── pyvenv.cfg              # Configuración
```

**Caso práctico - Dos proyectos aislados:**

```bash
# Proyecto A
mkdir project-a && cd project-a
python -m venv .venv
source .venv/bin/activate
pip install langchain==0.1.0
pip list  # Solo ve langchain 0.1.0
deactivate

# Proyecto B
mkdir project-b && cd project-b
python -m venv .venv
source .venv/bin/activate
pip install langchain==0.2.0
pip list  # Solo ve langchain 0.2.0
deactivate

# Sin conflictos: Cada .venv es independiente
```

---

## 5️⃣ **Hybrid Package Managers (🔧 [HYBRID-PM])**

### ¿Qué Gestionan?

**TODO en uno:**
- ✅ Versiones de Python (como pyenv)
- ✅ Entornos virtuales (como venv)
- ✅ Dependencias Python (como pip)
- ✅ Binarios del sistema (CUDA, librerías C)

### Conda vs Poetry

| Característica | Conda | Poetry |
|---------------|-------|--------|
| **Scope** | Científico (data science) | Desarrollo Python general |
| **Gestiona** | Python + binarios + R | Solo Python |
| **Repositorio** | Anaconda + PyPI | Solo PyPI |
| **Archivo config** | `environment.yml` | `pyproject.toml` |
| **Lock file** | No nativo | `poetry.lock` |
| **Velocidad** | Lento (resuelve todo) | Rápido |
| **Tamaño** | Grande (Anaconda ~3GB) | Ligero |

### Conda

**Instalación:**

```bash
# Miniconda (ligero, recomendado)
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh

# Anaconda (completo, incluye Jupyter, NumPy, etc.)
# Descargar desde anaconda.com
```

**Comandos esenciales:**

```bash
# Crear entorno
conda create -n myenv python=3.11

# Activar entorno
conda activate myenv

# Instalar paquetes
conda install numpy pandas scikit-learn

# Instalar desde PyPI (si no está en conda)
pip install langchain

# Listar entornos
conda env list

# Listar paquetes en entorno actual
conda list

# Exportar entorno
conda env export > environment.yml

# Crear desde archivo
conda env create -f environment.yml

# Desactivar
conda deactivate

# Eliminar entorno
conda env remove -n myenv
```

**environment.yml:**

```yaml
name: ml-project
channels:
  - conda-forge
  - defaults
dependencies:
  - python=3.11
  - numpy=1.24
  - pandas=2.0
  - scikit-learn=1.3
  - pip
  - pip:
      - langchain>=0.1.0
      - openai>=1.0
```

**Caso práctico - Data Science:**

```bash
# Crear entorno para ML
conda create -n ml python=3.11
conda activate ml

# Instalar stack científico
conda install numpy pandas matplotlib scikit-learn jupyter

# Instalar LLM tools desde pip
pip install langchain openai

# Verificar
python -c "import numpy; import langchain; print('OK')"
```

### Poetry

**Instalación:**

```bash
# Linux/macOS/Windows
curl -sSL https://install.python-poetry.org | python3 -
```

**Comandos esenciales:**

```bash
# Inicializar proyecto nuevo
poetry new mi-proyecto

# O agregar a proyecto existente
poetry init

# Instalar dependencias
poetry add langchain

# Instalar dev dependencies
poetry add --group dev pytest black

# Instalar desde pyproject.toml
poetry install

# Actualizar dependencias
poetry update

# Ver dependencias
poetry show
poetry show --tree

# Ejecutar comando en entorno
poetry run python main.py

# Shell en entorno
poetry shell

# Build (crear wheel/sdist)
poetry build

# Publish a PyPI
poetry publish
```

**pyproject.toml (Poetry):**

```toml
[tool.poetry]
name = "mi-proyecto"
version = "0.1.0"
description = "LangChain agent"
authors = ["Tu Nombre <tu@email.com>"]

[tool.poetry.dependencies]
python = "^3.11"
langchain = "^0.1.0"
pydantic = "^2.5.0"

[tool.poetry.group.dev.dependencies]
pytest = "^7.0"
black = "^22.0"
mypy = "^0.990"

[build-system]
requires = ["poetry-core"]
build-backend = "poetry.core.masonry.api"
```

**Caso práctico - Proyecto con Poetry:**

```bash
# Crear proyecto
poetry new langchain-agent
cd langchain-agent

# Agregar dependencias
poetry add langchain langchain-openai python-dotenv

# Agregar dev tools
poetry add --group dev pytest black mypy

# Instalar todo
poetry install

# Trabajar en proyecto
poetry shell
python main.py

# Build para distribución
poetry build  # Crea dist/ con .whl y .tar.gz
```

---

## 🔄 **Interacciones Entre Package Managers**

### Flujo Correcto de Instalación

```
1. System PM instala Python intérprete
   └─ sudo apt install python3.11  (Linux)
   └─ brew install python@3.11     (macOS)
   └─ winget install Python.Python.3.11  (Windows)

2. (Opcional) Version Manager gestiona múltiples Pythons
   └─ pyenv install 3.11.0
   └─ pyenv global 3.11.0

3. Crear entorno virtual (SIEMPRE)
   └─ python -m venv .venv
   └─ source .venv/bin/activate

4. Language PM instala librerías EN EL ENTORNO
   └─ pip install langchain
   └─ pip install -r requirements.txt

5. (Alternativa) Usar Hybrid PM
   └─ conda create -n myenv python=3.11
   └─ conda install numpy pandas
   └─ pip install langchain
```

### ❌ Errores Comunes

```bash
# ❌ ERROR 1: sudo pip (contamina sistema)
sudo pip install langchain
# Problema: Instala en Python del sistema, puede romper OS

# ✅ CORRECTO:
python -m venv .venv && source .venv/bin/activate
pip install langchain

# ❌ ERROR 2: Mezclar conda y pip mal
conda create -n myenv python=3.11
conda activate myenv
pip install numpy  # MALO: usa pip para algo que conda gestiona mejor
# Problema: conda no sabe de paquetes instalados con pip

# ✅ CORRECTO:
conda install numpy  # Usa conda para paquetes científicos
pip install langchain  # Usa pip solo para paquetes no en conda

# ❌ ERROR 3: Instalar Python con system PM Y conda
sudo apt install python3.11
conda install python=3.11
# Problema: Dos Pythons, confusión en PATH

# ✅ CORRECTO: Elige UNO
# Opción A: Solo system PM + venv
sudo apt install python3.11
python3.11 -m venv .venv

# Opción B: Solo conda
conda create -n myenv python=3.11
```

---

## 📊 **Tabla Decisión: ¿Qué Package Manager Usar?**

### Por Caso de Uso

| Escenario | Usar | Razón |
|-----------|------|-------|
| **Instalar Python** | 🖥️ apt/brew/winget | System PM para binarios |
| **Instalar git, curl** | 🖥️ apt/brew/winget | Herramientas del sistema |
| **Librerías Python** | 🐍 pip | Estándar, simple |
| **Múltiples versiones Python** | 🔄 pyenv | Cambiar entre proyectos |
| **Aislar dependencias** | 📦 venv | Built-in, suficiente |
| **Data Science** | 🔧 conda | Gestiona NumPy, CUDA, etc. |
| **Publicar paquete PyPI** | 🔧 poetry | Gestión moderna |
| **Proyecto complejo Python** | 🔧 poetry | Lock files, reproducible |

### Por Tipo de Proyecto

```bash
# Proyecto web simple (Flask/FastAPI)
System PM: apt/brew (instalar Python)
Env: venv
Packages: pip

# Data Science / ML
System PM: No necesario
All-in-one: conda (Python + NumPy + CUDA + Jupyter)

# Aplicación enterprise Python
System PM: apt/brew (instalar Python)
Version: pyenv (si múltiples proyectos)
Env: venv
Packages: pip
Lock: poetry (opcional, para reproducibilidad)

# Desarrollo de librería Python
All-in-one: poetry (gestión completa + publish)
```

---

## ✅ **Resumen Comandos Esenciales**

### System Package Managers

```bash
# Ubuntu/Debian
sudo apt update && sudo apt install htop

# macOS
brew install htop

# Windows
winget install htop
```

### Language Package Managers

```bash
# Python
pip install langchain

# JavaScript
npm install express
```

### Version Managers

```bash
# Python
pyenv install 3.11.0
pyenv local 3.11.0

# JavaScript
nvm install 18.0.0
nvm use 18.0.0
```

### Environment Managers

```bash
# venv (Python)
python -m venv .venv
source .venv/bin/activate
pip install langchain
```

### Hybrid Managers

```bash
# Conda
conda create -n myenv python=3.11
conda activate myenv
conda install numpy pandas

# Poetry
poetry new proyecto
poetry add langchain
poetry install
```

---

## 🎯 **Siguiente Paso**

**Próximo archivo:** `05_essential_packages.md`

**Aprenderás:**
- Qué paquetes instalar PRIMERO (htop, git, curl)
- Herramientas de monitoreo (CPU, RAM, GPU)
- Setup completo para desarrollo Python
- Orden de instalación correcto

**Ya sabes QUÉ son los paquetes y CÓMO gestionarlos. Ahora aprenderás CUÁLES instalar.**

---

## 📚 **Referencias**

- **apt:** https://wiki.debian.org/Apt
- **Homebrew:** https://brew.sh
- **pip:** https://pip.pypa.io
- **pyenv:** https://github.com/pyenv/pyenv
- **venv:** https://docs.python.org/3/library/venv.html
- **conda:** https://docs.conda.io
- **poetry:** https://python-poetry.org

---

**Archivos completados:**
1. ✅ 00_cli_fundamentals.md
2. 01_cli_syntax_guide.md
3. ✅ 02_cli_commands_basics.md
4. ✅ 03_what_are_packages.md
5. ✅ 04_package_managers_by_type.md ← **Estás aquí**
6. 05_essential_packages.md
7. 06_runtime_version_managers.md
8. 07_python_virtual_environments_deep_dive.md
9. 08_hybrid_package_managers.md
10. 09_integrated_workflow_practice.md

**🎉 File 4 Complete! Ready for File 5: Essential Packages to Install**
