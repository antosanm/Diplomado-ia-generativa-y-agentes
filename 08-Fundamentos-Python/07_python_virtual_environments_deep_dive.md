# 🔒 Python Virtual Environments Deep Dive

**Objetivo:** Entender CÓMO funcionan los virtual environments y dominar su uso  
**Por qué este archivo:** venv es fundamental pero muchos lo usan sin entenderlo  
**Requisito previo:** Haber leído `06_runtime_version_managers.md` (gestión versiones Python)

---

## 🎯 **El Problema: Dependency Hell Sin Aislamiento**

### Escenario Sin Virtual Environments

```bash
# Sistema global (UN solo directorio de paquetes)
/usr/lib/python3.11/site-packages/
├── langchain==0.1.0/
├── pydantic==2.5.0/
└── requests==2.31.0/

# Proyecto A necesita:
pip install langchain==0.1.0  # ✅ OK

# Proyecto B necesita:
pip install langchain==0.2.0  # ❌ SOBRESCRIBE 0.1.0
# Resultado: Proyecto A se rompe

# Proyecto C necesita:
pip install pydantic==1.10.0  # ❌ CONFLICTO
# langchain necesita pydantic>=2.0
# ERROR: Incompatible dependencies
```

**Consecuencias:**
- Solo un conjunto de paquetes para TODOS los proyectos
- Actualizar paquete en proyecto A rompe proyecto B
- Imposible trabajar en múltiples proyectos simultáneamente
- Contaminas Python del sistema (puede romper OS tools)

### Con Virtual Environments

```bash
# Cada proyecto tiene SU PROPIO directorio de paquetes

proyecto-a/
└── .venv/
    └── lib/python3.11/site-packages/
        └── langchain==0.1.0/  # Versión independiente

proyecto-b/
└── .venv/
    └── lib/python3.11/site-packages/
        └── langchain==0.2.0/  # Versión diferente, sin conflicto

proyecto-c/
└── .venv/
    └── lib/python3.11/site-packages/
        └── pydantic==1.10.0/  # Compatible con SUS necesidades
```

**Ventajas:**
- ✅ Aislamiento completo entre proyectos
- ✅ Actualiza paquetes sin miedo
- ✅ Experimenta sin romper nada
- ✅ Requirements.txt reproduce entorno exacto

---

## 📦 **Herramientas de Virtual Environments**

| Herramienta | Badge | Cuándo Usar | Python |
|-------------|-------|-------------|--------|
| **venv** | 📦 [ENV-MGR] | Estándar, simple, suficiente | Built-in 3.3+ |
| **virtualenv** | 📦 [ENV-MGR] | Features extras, Python antiguo | pip install |
| **pipenv** | 🔧 [HYBRID-PM] | Lock files automáticos | pip install |
| **poetry** | 🔧 [HYBRID-PM] | Gestión moderna, publicar paquetes | pip install |
| **conda** | 🔧 [HYBRID-PM] | Data science, binarios del sistema | Anaconda |

**Enfoque:** Este archivo se centra en **venv** (recomendado para 90% casos).

---

## 🏗️ **venv - Virtual Environment (Estándar)**

### ¿Qué Es venv?

> **venv:** Módulo built-in de Python que crea entornos aislados con su propio `pip` y directorio de paquetes.

**Incluido con Python:** No requiere instalación adicional (Python 3.3+)

### Crear Virtual Environment

```bash
# Sintaxis básica
python -m venv nombre_del_entorno

# Convención: Nombrar .venv (oculto en Linux/macOS)
python -m venv .venv

# Alternativas comunes
python -m venv venv
python -m venv env
python -m venv .env  # ⚠️ Confusión con .env (variables entorno)

# Con versión específica de Python
python3.11 -m venv .venv

# Con pyenv (usa versión configurada)
pyenv local 3.11.6
python -m venv .venv  # Usa Python 3.11.6
```

**¿Qué crea venv?**

```bash
.venv/
├── bin/                    # Linux/macOS
│   ├── activate            # Script activación bash/zsh
│   ├── activate.csh        # Script activación csh
│   ├── activate.fish       # Script activación fish
│   ├── Activate.ps1        # Script activación PowerShell
│   ├── python              # Symlink a Python base
│   ├── python3             # Symlink a Python base
│   └── pip                 # pip del entorno
│
├── Scripts/                # Windows
│   ├── activate.bat        # Script activación CMD
│   ├── Activate.ps1        # Script activación PowerShell
│   ├── deactivate.bat
│   ├── python.exe          # Copia de Python
│   └── pip.exe             # pip del entorno
│
├── lib/                    # Paquetes instalados
│   └── python3.11/
│       └── site-packages/  # ← AQUÍ se instalan paquetes
│           └── (vacío inicialmente)
│
├── include/                # Headers C (para extensiones)
│
└── pyvenv.cfg              # Configuración del entorno
```

**Ver pyvenv.cfg:**

```bash
cat .venv/pyvenv.cfg

# Output:
# home = /usr/bin
# include-system-site-packages = false
# version = 3.11.6
# executable = /usr/bin/python3.11
# command = /usr/bin/python3.11 -m venv /home/usuario/proyecto/.venv
```

**Campos importantes:**
- `home`: Dónde está el Python base
- `include-system-site-packages`: Si incluye paquetes del sistema (normalmente `false`)
- `version`: Versión de Python

---

## 🔄 **Activar y Desactivar Virtual Environment**

### Activar venv

**¿Qué hace activar?**
1. Modifica `PATH` para que `python` apunte a `.venv/bin/python`
2. Establece variable `VIRTUAL_ENV` con ruta del entorno
3. Cambia prompt del shell (muestra `(.venv)`)

**Comandos por OS/shell:**

```bash
# Linux/macOS - bash/zsh
source .venv/bin/activate

# Linux/macOS - fish
source .venv/bin/activate.fish

# Linux/macOS - csh
source .venv/bin/activate.csh

# Windows - PowerShell
.\.venv\Scripts\Activate.ps1

# Windows - CMD
.\.venv\Scripts\activate.bat

# Windows - Git Bash
source .venv/Scripts/activate
```

**Verificar activación:**

```bash
# Prompt cambia
(.venv) usuario@host:~/proyecto$

# which python muestra venv
which python
# Output: /home/usuario/proyecto/.venv/bin/python

# Variable VIRTUAL_ENV establecida
echo $VIRTUAL_ENV
# Output: /home/usuario/proyecto/.venv

# pip install va a venv
pip list
# Output: (solo pip, setuptools inicialmente)
```

### Desactivar venv

```bash
# Todos los OS y shells
deactivate

# Prompt vuelve a normal
usuario@host:~/proyecto$

# which python vuelve a sistema
which python
# Output: /usr/bin/python (o pyenv shim)

# VIRTUAL_ENV desaparece
echo $VIRTUAL_ENV
# Output: (vacío)
```

### PowerShell Execution Policy (Windows)

**Problema común:**

```powershell
.\.venv\Scripts\Activate.ps1
# Error: no se puede cargar porque la ejecución de scripts está deshabilitada
```

**Solución:**

```powershell
# Opción 1: Cambiar política para usuario actual (recomendado)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Opción 2: Bypass solo para esta sesión
PowerShell -ExecutionPolicy Bypass

# Ahora funciona
.\.venv\Scripts\Activate.ps1
```

---

## 🔍 **Cómo Funciona la Activación (Internamente)**

### Análisis del Script activate

```bash
# Ver contenido de activate (Linux/macOS)
cat .venv/bin/activate | head -50

# Extrayendo lo esencial:
```

```bash
#!/bin/bash
# Script activate (simplificado)

# 1. Guardar PATH original
_OLD_VIRTUAL_PATH="$PATH"

# 2. Agregar bin de venv al inicio del PATH
VIRTUAL_ENV="/home/usuario/proyecto/.venv"
PATH="$VIRTUAL_ENV/bin:$PATH"
export PATH

# 3. Establecer variable VIRTUAL_ENV
export VIRTUAL_ENV

# 4. Cambiar prompt
_OLD_VIRTUAL_PS1="$PS1"
PS1="(.venv) $PS1"
export PS1

# 5. Crear función deactivate
deactivate () {
    # Restaurar PATH original
    PATH="$_OLD_VIRTUAL_PATH"
    unset _OLD_VIRTUAL_PATH
    
    # Restaurar prompt
    PS1="$_OLD_VIRTUAL_PS1"
    unset _OLD_VIRTUAL_PS1
    
    # Limpiar variables
    unset VIRTUAL_ENV
}
```

**Por qué funciona:**

```bash
# Sin activar
which python
# Output: /usr/bin/python

echo $PATH
# Output: /usr/local/bin:/usr/bin:/bin

# Después de source .venv/bin/activate
which python
# Output: /home/usuario/proyecto/.venv/bin/python

echo $PATH
# Output: /home/usuario/proyecto/.venv/bin:/usr/local/bin:/usr/bin:/bin
#         ↑ Agregado al inicio
```

**Consecuencia:** Cuando ejecutas `python`, shell encuentra primero el del venv.

---

## 📦 **Instalar Paquetes en Virtual Environment**

### Workflow Básico

```bash
# 1. Activar venv
source .venv/bin/activate

# 2. Verificar que pip es del venv
which pip
# Output: /home/usuario/proyecto/.venv/bin/pip

# 3. Instalar paquetes
pip install langchain langchain-openai

# 4. Ver qué se instaló
pip list
# Output:
# Package         Version
# langchain       0.1.0
# langchain-openai 0.0.5
# pydantic        2.5.3
# requests        2.31.0
# ...

# 5. Verificar ubicación
pip show langchain
# Output:
# Location: /home/usuario/proyecto/.venv/lib/python3.11/site-packages

# 6. Congelar dependencias
pip freeze > requirements.txt

# 7. Ver requirements.txt
cat requirements.txt
# Output:
# langchain==0.1.0
# langchain-openai==0.0.5
# pydantic==2.5.3
# requests==2.31.0
# ...
```

### requirements.txt - Buenas Prácticas

**Estructura recomendada:**

```txt
# requirements.txt - Dependencias producción

# Core framework
langchain>=0.1.0,<1.0.0
langchain-openai>=0.0.5

# Utilities
python-dotenv>=1.0.0
requests>=2.28.0

# Data validation
pydantic>=2.5.0,<3.0.0
```

**requirements-dev.txt - Herramientas desarrollo:**

```txt
# requirements-dev.txt - Solo para desarrollo

# Testing
pytest>=7.4.0
pytest-cov>=4.1.0
pytest-asyncio>=0.21.0

# Code quality
black>=23.0.0
isort>=5.12.0
ruff>=0.1.0
mypy>=1.7.0

# Documentation
sphinx>=7.0.0
```

**Instalación separada:**

```bash
# Producción
pip install -r requirements.txt

# Desarrollo (incluye producción + dev)
pip install -r requirements.txt
pip install -r requirements-dev.txt

# O en un solo comando
pip install -r requirements.txt -r requirements-dev.txt
```

### Actualizar Paquetes en venv

```bash
# Ver paquetes desactualizados
pip list --outdated

# Output:
# Package    Version  Latest   Type
# langchain  0.1.0    0.1.5    wheel

# Actualizar paquete específico
pip install --upgrade langchain

# Actualizar todos (⚠️ puede romper compatibilidad)
pip install --upgrade -r requirements.txt

# Mejor: Actualizar uno por uno y probar
pip install --upgrade langchain
pytest  # Verificar que no se rompe nada
pip freeze > requirements.txt  # Actualizar requirements
```

---

## 🗂️ **Gestión de Virtual Environments**

### ¿Dónde Crear el venv?

**Opción 1: Dentro del proyecto (Recomendado)**

```bash
proyecto/
├── .venv/              # ← Virtual environment aquí
├── src/
├── tests/
├── requirements.txt
└── .gitignore          # Debe incluir .venv/
```

**Ventajas:**
- ✅ venv viaja con proyecto
- ✅ Fácil activar (`source .venv/bin/activate`)
- ✅ IDE lo detecta automáticamente
- ✅ `.gitignore` simple

**Desventajas:**
- ❌ Ocupa espacio en cada proyecto (~100-500MB)
- ❌ Backups incluyen venv (innecesario)

**Opción 2: Centralizado (pyenv-virtualenv)**

```bash
~/.pyenv/versions/
├── 3.11.6/
└── 3.11.6/envs/
    ├── proyecto-a-env/
    ├── proyecto-b-env/
    └── proyecto-c-env/
```

**Ventajas:**
- ✅ No ocupa espacio en cada proyecto
- ✅ Gestión centralizada

**Desventajas:**
- ❌ Activación menos intuitiva
- ❌ IDE puede no detectar automáticamente

**Recomendación:** Opción 1 (dentro proyecto) para 90% casos.

### Nombrar Virtual Environment

**Convenciones comunes:**

| Nombre | Pros | Contras |
|--------|------|---------|
| `.venv` | Oculto (Linux/macOS), estándar VSCode | No oculto en Windows |
| `venv` | Simple, visible | Puede confundir con módulo venv |
| `env` | Corto | Muy genérico |
| `.env` | Oculto | ⚠️ Confusión con archivos .env (variables) |

**Recomendación:** `.venv` (estándar de facto).

### .gitignore para Virtual Environments

**Siempre excluir venv de Git:**

```bash
# .gitignore

# Virtual environments
.venv/
venv/
env/
.env/
ENV/
env.bak/
venv.bak/

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

# IDE
.vscode/
.idea/
*.swp

# Environment variables
.env
.env.local

# Testing
.pytest_cache/
.coverage
htmlcov/

# OS
.DS_Store
Thumbs.db
```

**Por qué NO commitear venv:**
1. **Tamaño:** 100-500MB innecesarios en repo
2. **OS-specific:** venv de Windows no funciona en Linux
3. **Reproducible:** `requirements.txt` recrea entorno exacto
4. **Binarios:** Archivos compilados no son multiplataforma

### Eliminar Virtual Environment

```bash
# Desactivar primero (si está activo)
deactivate

# Eliminar es simplemente borrar carpeta
rm -rf .venv

# Windows PowerShell
Remove-Item -Recurse -Force .venv

# Recrear desde cero
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

**Cuándo recrear venv:**
- Cambiar versión de Python
- Venv corrupto (errores raros)
- Limpiar paquetes huérfanos
- Migrar entre OS

---

## 🔧 **virtualenv - Alternative más Potente**

### Diferencias venv vs virtualenv

| Característica | venv | virtualenv |
|---------------|------|------------|
| **Incluido** | Built-in Python 3.3+ | Requiere instalación |
| **Velocidad** | Normal | Más rápido |
| **Python 2** | No | Sí |
| **Features** | Básico | Extras (templates, etc.) |
| **API** | Solo CLI | CLI + Python API |

### Instalar y Usar virtualenv

```bash
# Instalar (global o en tools venv)
pip install virtualenv

# Crear venv (sintaxis similar)
virtualenv .venv

# Especificar Python
virtualenv -p python3.11 .venv
virtualenv -p /usr/bin/python3.9 .venv

# Activar (igual que venv)
source .venv/bin/activate

# No incluir paquetes del sistema
virtualenv --no-site-packages .venv

# Copiar Python en lugar de symlink
virtualenv --always-copy .venv
```

**Cuándo usar virtualenv:**
- Necesitas Python 2.7 (legacy)
- Features avanzados (templates, hooks)
- API programática (crear venvs desde script)

**Recomendación:** Usa **venv** a menos que necesites algo específico.

---

## 🖥️ **Integración con IDEs**

### Visual Studio Code

**Detección automática:**

```bash
# VSCode detecta automáticamente .venv en proyecto
proyecto/
└── .venv/  # ← VSCode lo encuentra

# O configura manualmente:
# Ctrl+Shift+P → "Python: Select Interpreter"
# Selecciona: Python 3.11.6 (.venv)
```

**settings.json (workspace):**

```json
{
  "python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python",
  "python.terminal.activateEnvironment": true,
  "python.analysis.extraPaths": [
    "${workspaceFolder}/src"
  ]
}
```

**Activación automática en terminal integrada:**
- VSCode activa venv automáticamente al abrir terminal
- Verifica que prompt muestre `(.venv)`

### PyCharm

**Configuración:**

1. File → Settings → Project → Python Interpreter
2. Add Interpreter → Existing environment
3. Selecciona: `proyecto/.venv/bin/python`

**O crear nuevo:**

1. Add Interpreter → Virtualenv Environment
2. Location: `proyecto/.venv`
3. Base interpreter: Python 3.11

**PyCharm gestiona activación automáticamente.**

### Jupyter Notebook

**Instalar jupyter en venv:**

```bash
source .venv/bin/activate
pip install jupyter ipython ipykernel

# Registrar venv como kernel
python -m ipykernel install --user --name=proyecto-kernel --display-name="Python (proyecto)"

# Verificar kernels
jupyter kernelspec list
# Output:
# Available kernels:
#   proyecto-kernel    /home/usuario/.local/share/jupyter/kernels/proyecto-kernel
#   python3            /usr/share/jupyter/kernels/python3

# Iniciar Jupyter
jupyter notebook

# En notebook: Kernel → Change kernel → Python (proyecto)
```

**Desinstalar kernel:**

```bash
jupyter kernelspec uninstall proyecto-kernel
```

---

## 🎯 **Workflows Prácticos**

### Workflow 1: Nuevo Proyecto desde Cero

```bash
# 1. Crear directorio proyecto
mkdir langchain-agent && cd langchain-agent

# 2. Crear venv
python -m venv .venv

# 3. Activar
source .venv/bin/activate

# 4. Actualizar pip
pip install --upgrade pip

# 5. Instalar dependencias
pip install langchain langchain-openai python-dotenv

# 6. Instalar dev tools
pip install pytest black ruff

# 7. Crear requirements
pip freeze > requirements.txt

# 8. Inicializar Git
git init
echo ".venv/" > .gitignore
git add requirements.txt .gitignore
git commit -m "Initial setup"

# 9. Verificar
python -c "import langchain; print('✅ Setup OK')"
```

### Workflow 2: Clonar Proyecto Existente

```bash
# 1. Clonar repo
git clone https://github.com/user/proyecto.git
cd proyecto

# 2. Verificar Python version (si hay .python-version)
cat .python-version  # 3.11.6
python --version     # Debe coincidir

# 3. Crear venv
python -m venv .venv

# 4. Activar
source .venv/bin/activate

# 5. Instalar dependencias
pip install -r requirements.txt

# 6. Verificar
pytest
python src/main.py

echo "✅ Setup completo"
```

### Workflow 3: Actualizar Dependencias

```bash
# 1. Activar venv
source .venv/bin/activate

# 2. Ver desactualizados
pip list --outdated

# 3. Actualizar selectivamente
pip install --upgrade langchain

# 4. Probar
pytest

# 5. Actualizar requirements
pip freeze > requirements.txt

# 6. Commitear
git add requirements.txt
git commit -m "Update langchain to 0.1.5"
```

### Workflow 4: Cambiar Versión Python

```bash
# Proyecto actualmente Python 3.10
cd ~/projects/mi-proyecto
python --version  # Python 3.10.13

# Decisión: Migrar a Python 3.11

# 1. Backup requirements
cp requirements.txt requirements.txt.backup

# 2. Eliminar venv antiguo
deactivate
rm -rf .venv

# 3. Cambiar Python (con pyenv)
pyenv local 3.11.6

# 4. Crear nuevo venv
python -m venv .venv

# 5. Activar
source .venv/bin/activate

# 6. Verificar versión
python --version  # Python 3.11.6

# 7. Reinstalar dependencias
pip install -r requirements.txt

# 8. Probar
pytest

# 9. Si OK, commitear
git add .python-version
git commit -m "Migrate to Python 3.11.6"
```

---

## ⚠️ **Troubleshooting Común**

### Problema 1: pip install instala globalmente

```bash
# Síntoma
pip install langchain
# Se instala fuera de venv

# Diagnóstico
which pip
# Output: /usr/bin/pip (¡no es del venv!)

# Causa: venv no activado

# Solución
source .venv/bin/activate
which pip
# Output: /home/usuario/proyecto/.venv/bin/pip ✅
```

### Problema 2: ModuleNotFoundError en venv activo

```bash
# Síntoma
python -c "import langchain"
# ModuleNotFoundError: No module named 'langchain'

# Diagnóstico 1: ¿Instalado en venv correcto?
which python
# /home/usuario/proyecto/.venv/bin/python ✅

pip list | grep langchain
# (vacío) ← No instalado

# Solución: Instalar en venv activo
pip install langchain

# Diagnóstico 2: ¿Python distinto al del venv?
/usr/bin/python -c "import langchain"
# Usa Python del sistema, no del venv

# Solución: Usar python del venv (activado)
python -c "import langchain"  # OK
```

### Problema 3: venv corrupto

```bash
# Síntoma
source .venv/bin/activate
# Error: cannot find python

# Causa: Moviste proyecto o cambiaste Python base

# Solución: Recrear venv
deactivate
rm -rf .venv
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

### Problema 4: Activar venv no cambia prompt

```bash
# Síntoma
source .venv/bin/activate
# Prompt NO muestra (.venv)

# Causa: Variable PS1 modificada por tema shell

# Verificación (sigue funcionando)
echo $VIRTUAL_ENV
# Output: /home/usuario/proyecto/.venv ✅

which python
# Output: /home/usuario/proyecto/.venv/bin/python ✅

# Solución: Agregar a prompt manualmente (opcional)
# En ~/.bashrc:
export PS1='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))} '$PS1
```

---

## 📊 **Comparación: venv vs Otras Soluciones**

| Característica | venv | pyenv-virtualenv | conda | Docker |
|---------------|------|------------------|-------|--------|
| **Setup** | Simple | Medio | Medio | Complejo |
| **Aislamiento** | Paquetes Python | Paquetes Python | Python + binarios | Todo (OS completo) |
| **Tamaño** | 100-200 MB | 100-200 MB | 1-3 GB | 1-5 GB |
| **Portabilidad** | requirements.txt | requirements.txt | environment.yml | Dockerfile |
| **Reproducibilidad** | Buena | Buena | Excelente | Perfecta |
| **Velocidad** | Rápida | Rápida | Lenta | Media |
| **Mejor para** | Desarrollo general | Multi-versión Python | Data science | Producción, CI/CD |

---

## ✅ **Checklist: Virtual Environment Setup**

```bash
# ✅ Proyecto nuevo
[ ] python -m venv .venv
[ ] source .venv/bin/activate
[ ] pip install --upgrade pip
[ ] pip install <dependencias>
[ ] pip freeze > requirements.txt
[ ] echo ".venv/" >> .gitignore
[ ] git add requirements.txt .gitignore

# ✅ Proyecto clonado
[ ] git clone <repo>
[ ] python -m venv .venv
[ ] source .venv/bin/activate
[ ] pip install -r requirements.txt
[ ] pytest (verificar)

# ✅ Mantenimiento
[ ] pip list --outdated (mensual)
[ ] Actualizar selectivamente
[ ] pytest después de cada update
[ ] pip freeze > requirements.txt
[ ] git commit -m "Update dependencies"
```

---

## 🎯 **Resumen: Comandos Esenciales**

```bash
# Crear venv
python -m venv .venv

# Activar
source .venv/bin/activate           # Linux/macOS
.\.venv\Scripts\Activate.ps1        # Windows

# Desactivar
deactivate

# Instalar dependencias
pip install -r requirements.txt

# Guardar dependencias
pip freeze > requirements.txt

# Limpiar y recrear
deactivate
rm -rf .venv
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

---

## 🎯 **Siguiente Paso**

**Próximo archivo:** `08_hybrid_package_managers.md`

**Aprenderás:**
- conda vs pip: Cuándo usar cada uno
- poetry: Gestión moderna de dependencias
- pipenv: Alternativa con lock files
- Comparación completa y decisiones

**Ya dominas venv. Ahora verás soluciones híbridas que combinan gestión de paquetes + entornos.**

---

## 📚 **Referencias**

- **venv:** https://docs.python.org/3/library/venv.html
- **virtualenv:** https://virtualenv.pypa.io
- **pip:** https://pip.pypa.io
- **VSCode Python:** https://code.visualstudio.com/docs/python/environments

---

**Archivos completados:**
1. ✅ 00_cli_fundamentals.md
2. 01_cli_syntax_guide.md
3. ✅ 02_cli_commands_basics.md
4. ✅ 03_what_are_packages.md
5. ✅ 04_package_managers_by_type.md
6. ✅ 05_essential_packages.md
7. ✅ 06_runtime_version_managers.md
8. ✅ 07_python_virtual_environments_deep_dive.md ← **Estás aquí**
9. 08_hybrid_package_managers.md
10. 09_integrated_workflow_practice.md

**🎉 File 7 Complete! Ready for File 8: Hybrid Package Managers (conda & poetry)**
