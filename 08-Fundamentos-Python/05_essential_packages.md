# 🛠️ Paquetes Esenciales para Desarrollo Python (Essential Setup)

**Objetivo:** Saber QUÉ instalar primero para desarrollo Python productivo  
**Por qué este archivo:** No quieres descubrir que falta una herramienta a mitad de proyecto  
**Requisito previo:** Haber leído `04_package_managers_by_type.md` (saber cuándo usar cada PM)

---

## 🎯 **Filosofía: Setup en Capas**

### 3 Capas de Instalación

```
Capa 1: Sistema Base (🖥️ System PM)
    └─ Git, Python, curl, build tools
    
Capa 2: Monitoreo y Debug (🖥️ System PM + 🐍 pip)
    └─ htop, nvidia-smi, psutil
    
Capa 3: Python Development (🐍 pip en venv)
    └─ langchain, pytest, black, mypy
```

**Regla:** Instala en orden. No saltes capas.

---

## 📦 **CAPA 1: Sistema Base (Obligatorio)**

### ¿Qué Instalar?

**Herramientas que TODOS los proyectos necesitan:**
- **Git** - Control de versiones
- **Python** - Intérprete (3.11+ recomendado)
- **curl/wget** - Descargar archivos
- **Build tools** - Compilar extensiones C (NumPy, Pillow, etc.)

### Linux (Ubuntu/Debian)

```bash
# Actualizar sistema
sudo apt update && sudo apt upgrade -y

# Git
sudo apt install -y git
git --version  # Verificar: git version 2.x

# Python 3.11 (más reciente)
sudo apt install -y python3.11 python3.11-venv python3.11-dev

# Verificar
python3.11 --version  # Python 3.11.x

# Crear alias (opcional pero recomendado)
echo "alias python=python3.11" >> ~/.bashrc
echo "alias pip=python3.11 -m pip" >> ~/.bashrc
source ~/.bashrc

# curl y wget
sudo apt install -y curl wget

# Build tools (compilar extensiones C)
sudo apt install -y build-essential

# Librerías desarrollo (para NumPy, Pillow, etc.)
sudo apt install -y \
    python3.11-dev \
    libffi-dev \
    libssl-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev

# Opcional: Herramientas útiles
sudo apt install -y \
    tree \
    vim \
    htop \
    ncdu
```

**Verificación completa:**

```bash
# Verificar todo instalado
git --version
python3.11 --version
curl --version
gcc --version

# Verificar que Python puede crear venv
python3.11 -m venv test_env
rm -rf test_env  # Eliminar test
echo "✅ Sistema base listo"
```

### macOS

```bash
# Instalar Homebrew (si no lo tienes)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Git (macOS trae git, pero actualizarlo es mejor)
brew install git
git --version

# Python 3.11
brew install python@3.11

# Verificar
python3.11 --version

# Crear alias (agregar a ~/.zshrc)
echo "alias python=python3.11" >> ~/.zshrc
echo "alias pip='python3.11 -m pip'" >> ~/.zshrc
source ~/.zshrc

# curl y wget
brew install curl wget

# Build tools (Xcode Command Line Tools)
xcode-select --install

# Herramientas útiles
brew install tree htop
```

**Verificación:**

```bash
git --version
python3.11 --version
curl --version
brew --version
echo "✅ Sistema base listo"
```

### Windows

```powershell
# Git
winget install Git.Git

# Python 3.11
winget install Python.Python.3.11

# Verificar instalación
git --version
python --version

# Verificar que Python está en PATH
(Get-Command python).Source
# Debe mostrar: C:\Users\...\Python311\python.exe

# curl (built-in en PowerShell 7+)
curl --version

# Build tools (para extensiones C)
# Instalar Visual Studio Build Tools
winget install Microsoft.VisualStudio.2022.BuildTools

# Herramientas útiles
winget install Notepad++.Notepad++
```

**Verificación:**

```powershell
git --version
python --version
curl --version
Write-Host "✅ Sistema base listo" -ForegroundColor Green
```

---

## 🔍 **CAPA 2: Monitoreo y Debugging (Recomendado)**

### ¿Por Qué Monitoreo?

**Necesitas saber:**
- ¿Cuánta RAM usa mi script?
- ¿Qué proceso consume 100% CPU?
- ¿Mi GPU está siendo usada?
- ¿Cuánto espacio en disco queda?

### Herramientas de Monitoreo

| Herramienta | Monitorea | OS | Badge |
|-------------|-----------|----|----|
| **htop** | CPU, RAM, procesos | Linux/macOS | 🖥️ [SYS-PM] |
| **nvidia-smi** | GPU NVIDIA | Todos | 🖥️ [SYS-PM] |
| **nvtop** | GPU (mejor UI) | Linux | 🖥️ [SYS-PM] |
| **psutil** | CPU, RAM (Python) | Todos | 🐍 [LANG-PM] |
| **GPUtil** | GPU (Python) | Todos | 🐍 [LANG-PM] |

### Linux - Herramientas Monitoreo

```bash
# htop - Monitor procesos interactivo
sudo apt install -y htop
htop
# Presiona F10 para salir

# iotop - Monitor I/O disco
sudo apt install -y iotop
sudo iotop
# Presiona q para salir

# ncdu - Disk usage (mejor que du)
sudo apt install -y ncdu
ncdu ~
# Navega con flechas, presiona q para salir

# nvidia-smi - GPU monitoring (si tienes NVIDIA)
nvidia-smi
# Si funciona, ya está instalado con drivers NVIDIA
# Si no: sudo apt install nvidia-utils-535

# nvtop - GPU monitor mejorado
sudo apt install -y nvtop
nvtop
# Presiona q para salir

# lm-sensors - Temperaturas CPU
sudo apt install -y lm-sensors
sudo sensors-detect  # Detectar sensores (responde Yes a todo)
sensors  # Ver temperaturas
```

**Verificación:**

```bash
# Test rápido de todas las herramientas
htop --version
nvidia-smi --version  # Solo si tienes NVIDIA GPU
sensors
echo "✅ Herramientas monitoreo instaladas"
```

### macOS - Herramientas Monitoreo

```bash
# htop
brew install htop
htop

# Activity Monitor (built-in GUI)
open -a "Activity Monitor"

# iStat Menus (de pago, pero excelente)
# Comprar desde Mac App Store

# GPU monitoring
# macOS: Activity Monitor > Window > GPU History

# Python tools (ver sección siguiente)
```

### Windows - Herramientas Monitoreo

```powershell
# Task Manager (built-in)
taskmgr

# Performance Monitor
perfmon

# Resource Monitor
resmon

# nvidia-smi (si tienes GPU NVIDIA)
nvidia-smi
# Si no funciona:
# C:\"Program Files"\NVIDIA Corporation\NVSMI\nvidia-smi.exe

# Process Explorer (Sysinternals)
winget install Microsoft.Sysinternals.ProcessExplorer

# GPU-Z (para info detallada GPU)
winget install TechPowerUp.GPU-Z
```

### Python Tools (Todos los OS)

**Instalar en virtual environment:**

```bash
# Crear venv para herramientas
python -m venv ~/tools_env
source ~/tools_env/bin/activate  # Linux/macOS
# o
~\tools_env\Scripts\Activate.ps1  # Windows

# psutil - System monitoring desde Python
pip install psutil

# Uso:
python -c "import psutil; print(f'RAM: {psutil.virtual_memory().percent}%')"
python -c "import psutil; print(f'CPU: {psutil.cpu_percent(interval=1)}%')"

# GPUtil - GPU monitoring desde Python
pip install gputil

# Uso:
python -c "import GPUtil; GPUtil.showUtilization()"
```

**Script de monitoreo completo:**

```python
# monitor.py
import psutil
import GPUtil

def monitor_system():
    # CPU
    print(f"CPU Usage: {psutil.cpu_percent(interval=1)}%")
    print(f"CPU Cores: {psutil.cpu_count()}")
    
    # RAM
    ram = psutil.virtual_memory()
    print(f"RAM Total: {ram.total / (1024**3):.2f} GB")
    print(f"RAM Used: {ram.used / (1024**3):.2f} GB ({ram.percent}%)")
    print(f"RAM Available: {ram.available / (1024**3):.2f} GB")
    
    # Disk
    disk = psutil.disk_usage('/')
    print(f"Disk Total: {disk.total / (1024**3):.2f} GB")
    print(f"Disk Used: {disk.used / (1024**3):.2f} GB ({disk.percent}%)")
    
    # GPU (si disponible)
    try:
        gpus = GPUtil.getGPUs()
        for gpu in gpus:
            print(f"GPU {gpu.id}: {gpu.name}")
            print(f"  Memory Used: {gpu.memoryUsed} MB / {gpu.memoryTotal} MB")
            print(f"  GPU Load: {gpu.load * 100}%")
    except:
        print("No NVIDIA GPU detected")

if __name__ == "__main__":
    monitor_system()
```

**Ejecutar:**

```bash
python monitor.py
# Output:
# CPU Usage: 15.2%
# CPU Cores: 8
# RAM Total: 15.50 GB
# RAM Used: 8.20 GB (52.9%)
# RAM Available: 7.30 GB
# ...
```

---

## 🐍 **CAPA 3: Python Development Tools (Por Proyecto)**

### ¿Qué Instalar en Cada Proyecto?

**Estos van en el venv del proyecto, NO globalmente:**

| Categoría | Paquetes | Para Qué |
|-----------|----------|----------|
| **Testing** | pytest, pytest-cov | Tests automatizados |
| **Formatting** | black, isort | Formatear código |
| **Linting** | ruff, mypy | Detectar errores |
| **Type Checking** | mypy | Validar tipos |
| **Documentation** | sphinx, mkdocs | Generar docs |
| **Environment** | python-dotenv | Variables de entorno |
| **HTTP** | requests, httpx | Llamadas API |
| **CLI** | click, typer | Crear comandos |

### Setup Básico: Testing + Formatting

```bash
# En tu proyecto
cd ~/projects/mi-proyecto

# Crear venv
python -m venv .venv
source .venv/bin/activate

# Testing
pip install pytest pytest-cov

# Formateo código
pip install black isort

# Linting (ruff es más rápido que flake8)
pip install ruff

# Type checking
pip install mypy

# Guardar
pip freeze > requirements-dev.txt
```

**Uso:**

```bash
# Ejecutar tests
pytest

# Coverage report
pytest --cov=src tests/

# Formatear código
black .
isort .

# Lint
ruff check .

# Type check
mypy src/
```

### Setup Completo: LangChain Development

```bash
# Crear proyecto
mkdir langchain-agent && cd langchain-agent
python -m venv .venv
source .venv/bin/activate

# Core dependencies
pip install langchain langchain-openai langchain-community

# Utilidades
pip install python-dotenv requests

# Development tools
pip install pytest pytest-cov black isort ruff mypy

# Jupyter (opcional, para exploración)
pip install jupyter ipython

# Guardar
pip freeze > requirements.txt

# Crear requirements-dev.txt separado
cat > requirements-dev.txt << 'EOF'
pytest>=7.0
pytest-cov>=4.0
black>=23.0
isort>=5.12
ruff>=0.1.0
mypy>=1.7
jupyter>=1.0
ipython>=8.0
EOF
```

**Estructura proyecto:**

```
langchain-agent/
├── .venv/                  # Virtual environment
├── src/
│   ├── __init__.py
│   ├── agent.py
│   └── utils.py
├── tests/
│   ├── __init__.py
│   └── test_agent.py
├── .env                    # Variables entorno (NO commitear)
├── .env.example            # Template (SÍ commitear)
├── .gitignore
├── requirements.txt        # Dependencias producción
├── requirements-dev.txt    # Dependencias desarrollo
├── README.md
└── pyproject.toml          # Configuración tools (opcional)
```

### pyproject.toml - Configuración Tools

```toml
# pyproject.toml
[tool.black]
line-length = 88
target-version = ['py311']

[tool.isort]
profile = "black"
line_length = 88

[tool.ruff]
line-length = 88
target-version = "py311"

[tool.mypy]
python_version = "3.11"
warn_return_any = true
warn_unused_configs = true

[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = "test_*.py"
python_functions = "test_*"
addopts = "-v --cov=src --cov-report=html"
```

**Comandos configurados:**

```bash
# Formatear todo
black .
isort .

# Lint
ruff check .

# Type check
mypy src/

# Tests con coverage
pytest

# Ver coverage en navegador
open htmlcov/index.html  # macOS
xdg-open htmlcov/index.html  # Linux
start htmlcov\index.html  # Windows
```

---

## 📋 **Checklist de Instalación Completa**

### Para TODOS (Obligatorio)

```bash
# ✅ Capa 1: Sistema Base
[ ] Git instalado y configurado
[ ] Python 3.11+ instalado
[ ] curl/wget funcionando
[ ] Build tools instalados
[ ] Alias python/pip configurados

# Verificación:
git --version
python --version
curl --version
```

### Para Development (Recomendado)

```bash
# ✅ Capa 2: Monitoreo
[ ] htop instalado (Linux/macOS)
[ ] nvidia-smi funcionando (si GPU NVIDIA)
[ ] psutil instalado en tools venv
[ ] GPUtil instalado en tools venv (si GPU)

# Verificación:
htop --version
nvidia-smi  # Solo si GPU
python -c "import psutil; print('OK')"
```

### Para Cada Proyecto (Por Proyecto)

```bash
# ✅ Capa 3: Python Dev Tools
[ ] Virtual environment creado (.venv)
[ ] pytest instalado
[ ] black + isort instalados
[ ] ruff instalado
[ ] mypy instalado
[ ] requirements.txt creado

# Verificación:
source .venv/bin/activate
pytest --version
black --version
ruff --version
mypy --version
```

---

## 🚀 **Scripts de Setup Automatizado**

### Linux Setup Script

```bash
#!/bin/bash
# setup_linux.sh

set -e  # Exit on error

echo "🚀 Instalando sistema base..."
sudo apt update
sudo apt install -y \
    git \
    python3.11 \
    python3.11-venv \
    python3.11-dev \
    build-essential \
    curl \
    wget \
    htop \
    tree \
    ncdu

echo "🔍 Instalando herramientas monitoreo..."
sudo apt install -y iotop lm-sensors

echo "🐍 Configurando Python..."
echo "alias python=python3.11" >> ~/.bashrc
echo "alias pip='python3.11 -m pip'" >> ~/.bashrc

echo "✅ Setup completo. Reinicia terminal."
echo "Verificar con: git --version && python --version"
```

**Ejecutar:**

```bash
chmod +x setup_linux.sh
./setup_linux.sh
# Reiniciar terminal
```

### macOS Setup Script

```bash
#!/bin/bash
# setup_macos.sh

set -e

echo "🚀 Verificando Homebrew..."
if ! command -v brew &> /dev/null; then
    echo "Instalando Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "🔧 Instalando herramientas..."
brew install \
    git \
    python@3.11 \
    curl \
    wget \
    htop \
    tree

echo "🐍 Configurando Python..."
echo "alias python=python3.11" >> ~/.zshrc
echo "alias pip='python3.11 -m pip'" >> ~/.zshrc

echo "✅ Setup completo. Reinicia terminal."
echo "Verificar con: git --version && python --version"
```

### Windows Setup Script

```powershell
# setup_windows.ps1

Write-Host "🚀 Instalando herramientas base..." -ForegroundColor Yellow

# Git
Write-Host "Instalando Git..."
winget install Git.Git

# Python 3.11
Write-Host "Instalando Python 3.11..."
winget install Python.Python.3.11

# Build Tools
Write-Host "Instalando Visual Studio Build Tools..."
winget install Microsoft.VisualStudio.2022.BuildTools

Write-Host "✅ Setup completo" -ForegroundColor Green
Write-Host "Verificar con: git --version; python --version"
```

**Ejecutar:**

```powershell
# Permitir scripts (una vez, como admin)
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Ejecutar
.\setup_windows.ps1
```

---

## 🎯 **Workflow: Primer Proyecto LangChain**

### Setup Completo Paso a Paso

```bash
# 1. Verificar sistema base
git --version
python --version  # Debe ser 3.11+

# 2. Crear proyecto
mkdir langchain-agent
cd langchain-agent

# 3. Inicializar Git
git init
git branch -M main

# 4. Crear estructura
mkdir src tests data logs
touch src/__init__.py src/agent.py
touch tests/__init__.py tests/test_agent.py
touch README.md

# 5. Crear .gitignore
cat > .gitignore << 'EOF'
__pycache__/
*.pyc
.venv/
.env
*.log
.pytest_cache/
htmlcov/
.coverage
EOF

# 6. Crear virtual environment
python -m venv .venv
source .venv/bin/activate  # Linux/macOS
# .\.venv\Scripts\Activate.ps1  # Windows

# 7. Instalar dependencias
pip install langchain langchain-openai python-dotenv

# 8. Instalar dev tools
pip install pytest black isort ruff mypy

# 9. Crear requirements
pip freeze > requirements.txt

# 10. Crear .env.example
cat > .env.example << 'EOF'
OPENAI_API_KEY=your_key_here
LANGCHAIN_TRACING_V2=false
LANGCHAIN_API_KEY=your_key_here
EOF

# 11. Crear README
cat > README.md << 'EOF'
# LangChain Agent

## Setup
```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
# Editar .env con tus API keys
```

## Run
```bash
python src/agent.py
```

## Test
```bash
pytest
```
EOF

# 12. Primer commit
git add .
git commit -m "Initial project setup"

# 13. Verificar todo funciona
python -c "import langchain; print('✅ LangChain importado')"
pytest --version
black --version

echo "🎉 Proyecto listo para desarrollo"
```

---

## 📊 **Comparación: Instalación Mínima vs Completa**

### Setup Mínimo (Beginner)

```bash
# Tiempo: ~10 minutos
sudo apt install git python3.11 python3.11-venv  # Linux
python -m venv .venv
source .venv/bin/activate
pip install langchain

# ✅ Puedes empezar a programar
# ❌ Sin herramientas de calidad código
# ❌ Sin monitoreo
```

### Setup Completo (Professional)

```bash
# Tiempo: ~30 minutos

# Sistema
sudo apt install git python3.11 python3.11-venv build-essential htop

# Proyecto
python -m venv .venv
source .venv/bin/activate

# Dependencias
pip install langchain langchain-openai python-dotenv

# Dev tools
pip install pytest black isort ruff mypy

# Configuración
# - pyproject.toml
# - .gitignore
# - .env.example
# - README.md

# ✅ Setup profesional
# ✅ Tests automatizados
# ✅ Código formateado
# ✅ Documentación
```

---

## ✅ **Resumen: Qué Instalar y Cuándo**

### Instalar UNA VEZ (Sistema)

```bash
# 🖥️ System PM
git, python3.11, curl, build-essential, htop

# Comando:
sudo apt install git python3.11 python3.11-venv build-essential htop
```

### Instalar POR PROYECTO (Virtual Env)

```bash
# 🐍 pip en .venv

# Producción
langchain, langchain-openai, python-dotenv, requests

# Desarrollo
pytest, black, isort, ruff, mypy

# Comando:
python -m venv .venv
source .venv/bin/activate
pip install langchain python-dotenv pytest black ruff
```

### NO Instalar Globalmente (❌)

```bash
# ❌ NUNCA hagas:
sudo pip install langchain
pip install --user pytest

# ✅ SIEMPRE usa venv:
python -m venv .venv
source .venv/bin/activate
pip install langchain
```

---

## 🎯 **Siguiente Paso**

**Próximo archivo:** `06_runtime_version_managers.md`

**Aprenderás:**
- pyenv en profundidad (múltiples versiones Python)
- nvm para Node.js (si trabajas con JS)
- py launcher de Windows
- Workflow: Proyecto legacy (3.9) + Proyecto nuevo (3.11)

**Ya sabes QUÉ instalar. Ahora aprenderás a gestionar MÚLTIPLES VERSIONES de Python.**

---

## 📚 **Referencias**

**Herramientas mencionadas:**
- htop: https://htop.dev
- nvidia-smi: https://developer.nvidia.com/nvidia-system-management-interface
- psutil: https://github.com/giampaolo/psutil
- pytest: https://pytest.org
- black: https://black.readthedocs.io
- ruff: https://docs.astral.sh/ruff/

**Guías instalación:**
- Python: https://www.python.org/downloads/
- Git: https://git-scm.com/downloads
- Homebrew: https://brew.sh

---

**Archivos completados:**
1. ✅ 00_cli_fundamentals.md
2. 01_cli_syntax_guide.md
3. ✅ 02_cli_commands_basics.md
4. ✅ 03_what_are_packages.md
5. ✅ 04_package_managers_by_type.md
6. ✅ 05_essential_packages.md ← **Estás aquí**
7. 06_runtime_version_managers.md
8. 07_python_virtual_environments_deep_dive.md
9. 08_hybrid_package_managers.md
10. 09_integrated_workflow_practice.md

**🎉 File 5 Complete! Ready for File 6: Runtime Version Managers**
