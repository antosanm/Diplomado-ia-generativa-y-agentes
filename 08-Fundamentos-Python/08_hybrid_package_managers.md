# 🔧 Hybrid Package Managers (conda & poetry)

**Objetivo:** Entender gestores "todo en uno" que combinan múltiples funcionalidades  
**Por qué este archivo:** conda y poetry resuelven problemas específicos que pip+venv no pueden  
**Requisito previo:** Haber leído `07_python_virtual_environments_deep_dive.md`

---

## 🎯 **¿Qué Es un Hybrid Package Manager?**

### Definición

> **Hybrid PM:** Herramienta que combina gestión de versiones + entornos + paquetes en una sola solución.

**Comparación:**

| Tarea | pip + venv + pyenv | conda | poetry |
|-------|-------------------|-------|--------|
| **Versiones Python** | pyenv | ✅ Built-in | ❌ Usa system |
| **Entornos virtuales** | venv | ✅ Built-in | ✅ Built-in |
| **Paquetes Python** | pip | ✅ + binarios | ✅ PyPI |
| **Lock files** | Manual | ❌ No nativo | ✅ poetry.lock |
| **Binarios sistema** | apt/brew | ✅ CUDA, BLAS | ❌ No |
| **Publicar PyPI** | twine | ❌ No | ✅ poetry publish |

---

## 🐍 **conda - Data Science Package Manager**

### ¿Qué Es conda?

**conda = pyenv + venv + pip + apt (para Python)**

**Casos de uso principales:**
1. **Data Science:** NumPy, Pandas, Scikit-learn con optimizaciones
2. **GPU Computing:** CUDA, cuDNN sin compilar
3. **Múltiples lenguajes:** Python + R en mismo entorno
4. **Binarios del sistema:** Gestiona librerías C/C++

### Anaconda vs Miniconda

| | Anaconda | Miniconda |
|---|----------|-----------|
| **Tamaño** | ~3 GB | ~400 MB |
| **Paquetes incluidos** | 250+ (NumPy, Jupyter, etc.) | Solo conda + Python |
| **Instalación** | Todo de una vez | Instalar según necesidad |
| **Mejor para** | Principiantes data science | Control, espacio limitado |

**Recomendación:** **Miniconda** (instala solo lo que necesitas).

---

## 📦 **Instalación de conda**

### Linux

```bash
# Descargar Miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

# Instalar
bash Miniconda3-latest-Linux-x86_64.sh

# Seguir prompts:
# - Aceptar licencia: yes
# - Location: /home/usuario/miniconda3 (default)
# - Initialize: yes

# Reiniciar terminal
exec bash

# Verificar
conda --version
# Output: conda 23.x.x
```

### macOS

```bash
# Intel Mac
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
bash Miniconda3-latest-MacOSX-x86_64.sh

# Apple Silicon (M1/M2)
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh
bash Miniconda3-latest-MacOSX-arm64.sh

# Reiniciar terminal
exec zsh

# Verificar
conda --version
```

### Windows

```powershell
# Descargar instalador desde:
# https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe

# Ejecutar instalador GUI
# - Install for: Just Me
# - Add to PATH: No (usa Anaconda Prompt)
# - Register as default: No

# Verificar (en Anaconda Prompt)
conda --version
```

### Configuración Inicial

```bash
# Desactivar activación automática de base
conda config --set auto_activate_base false

# Agregar canal conda-forge (más paquetes, actualizados)
conda config --add channels conda-forge
conda config --set channel_priority strict

# Verificar configuración
conda config --show channels
# Output:
# channels:
#   - conda-forge
#   - defaults
```

---

## 🔧 **Comandos Esenciales de conda**

### Gestión de Entornos

```bash
# Crear entorno con Python específico
conda create -n myenv python=3.11

# Crear con paquetes iniciales
conda create -n ds-project python=3.11 numpy pandas matplotlib

# Listar entornos
conda env list
# Output:
# base                  /home/usuario/miniconda3
# myenv              *  /home/usuario/miniconda3/envs/myenv
# ds-project            /home/usuario/miniconda3/envs/ds-project

# Activar entorno
conda activate myenv

# Verificar Python
which python
# Output: /home/usuario/miniconda3/envs/myenv/bin/python

python --version
# Output: Python 3.11.x

# Desactivar
conda deactivate

# Eliminar entorno
conda env remove -n myenv
```

### Instalar Paquetes

```bash
# Activar entorno
conda activate myenv

# Instalar desde conda
conda install numpy pandas scikit-learn

# Instalar versión específica
conda install numpy=1.24.0

# Instalar múltiples
conda install jupyter matplotlib seaborn

# Buscar paquete
conda search tensorflow

# Ver paquetes instalados
conda list

# Ver info de paquete
conda info numpy

# Actualizar paquete
conda update numpy

# Actualizar todos
conda update --all

# Desinstalar
conda remove numpy
```

### conda vs pip en conda Environment

**Regla de oro: Preferir conda sobre pip cuando posible**

```bash
conda activate myenv

# ✅ CORRECTO: Instalar con conda primero
conda install numpy pandas scikit-learn

# ✅ CORRECTO: Usar pip solo para paquetes no en conda
pip install langchain
pip install openai

# ❌ EVITAR: Instalar con pip algo que existe en conda
pip install numpy  # Mejor: conda install numpy

# Ver qué se instaló con qué
conda list
# Output muestra canal:
# numpy     1.24.0    py311h...    conda-forge
# langchain 0.1.0     pypi_0       pypi  ← Instalado con pip
```

**Por qué preferir conda:**
- conda resuelve dependencias de TODO (Python + C libs)
- pip solo Python (puede generar conflictos con libs C)
- conda instala binarios optimizados (MKL para NumPy)

---

## 📄 **environment.yml - Reproducir Entornos conda**

### Crear environment.yml

```bash
# Exportar entorno actual
conda activate myenv
conda env export > environment.yml

# Ver contenido
cat environment.yml
```

```yaml
name: myenv
channels:
  - conda-forge
  - defaults
dependencies:
  - python=3.11.6
  - numpy=1.24.0
  - pandas=2.0.3
  - matplotlib=3.7.2
  - pip=23.2.1
  - pip:
      - langchain==0.1.0
      - openai==1.3.0
prefix: /home/usuario/miniconda3/envs/myenv
```

### environment.yml Manual (Recomendado)

```yaml
# environment.yml - Versión limpia (sin prefix, hashes)
name: ml-project
channels:
  - conda-forge
  - defaults
dependencies:
  - python=3.11
  - numpy>=1.24
  - pandas>=2.0
  - scikit-learn>=1.3
  - jupyter>=1.0
  - matplotlib>=3.7
  - pip
  - pip:
      - langchain>=0.1.0
      - openai>=1.0
      - python-dotenv>=1.0
```

### Crear Entorno desde environment.yml

```bash
# Crear entorno
conda env create -f environment.yml

# Activar
conda activate ml-project

# Actualizar entorno existente
conda env update -f environment.yml

# Verificar
conda list
```

---

## 🎯 **Casos de Uso: Cuándo Usar conda**

### ✅ USA conda si:

**1. Data Science / Machine Learning**
```bash
conda create -n ml python=3.11
conda activate ml
conda install numpy pandas scikit-learn jupyter matplotlib
conda install tensorflow pytorch  # Con optimizaciones GPU
```

**2. GPU Computing (CUDA)**
```bash
conda create -n gpu-env python=3.11
conda activate gpu-env
conda install cudatoolkit=11.8 cudnn=8.6
conda install pytorch torchvision torchaudio pytorch-cuda=11.8 -c pytorch -c nvidia
```

**3. R + Python**
```bash
conda create -n r-py python=3.11 r-base=4.3
conda activate r-py
conda install pandas rpy2  # Integración R-Python
```

### ❌ NO uses conda si:

**1. Desarrollo web simple**
```bash
# Mejor: venv + pip
python -m venv .venv
pip install fastapi uvicorn
```

**2. Microservicios / Docker**
```bash
# Docker gestiona entorno completo
# conda agrega complejidad innecesaria
```

**3. Desarrollo de librerías Python**
```bash
# Mejor: poetry (ver siguiente sección)
# Gestión de dependencias más precisa
```

---

## 🎨 **poetry - Modern Python Packaging**

### ¿Qué Es poetry?

**poetry = pip + venv + requirements.txt + setup.py**

**Ventajas sobre pip:**
1. **Lock files:** Versiones exactas garantizadas (como package-lock.json en npm)
2. **Dependency resolver:** Resuelve conflictos automáticamente
3. **Gestión integrada:** Un comando para todo
4. **Publicar a PyPI:** Built-in, simple

**Mejor para:**
- Desarrollo de aplicaciones Python
- Crear librerías para PyPI
- Equipos (lock file = mismo entorno)
- Proyectos enterprise

---

## 📦 **Instalación de poetry**

### Linux/macOS/Windows

```bash
# Método oficial (recomendado)
curl -sSL https://install.python-poetry.org | python3 -

# O con pip (no recomendado, puede causar conflictos)
pip install poetry

# Verificar
poetry --version
# Output: Poetry (version 1.7.0)

# Agregar a PATH (si usa método oficial)
export PATH="$HOME/.local/bin:$PATH"  # Linux/macOS
# Windows: Agregar C:\Users\usuario\AppData\Roaming\Python\Scripts
```

### Configuración Inicial

```bash
# Crear entornos en proyecto (no centralizado)
poetry config virtualenvs.in-project true

# Verificar configuración
poetry config --list
# Output:
# virtualenvs.create = true
# virtualenvs.in-project = true
```

---

## 🔧 **Comandos Esenciales de poetry**

### Nuevo Proyecto

```bash
# Crear proyecto nuevo (con estructura)
poetry new mi-proyecto

# Estructura creada:
# mi-proyecto/
# ├── mi_proyecto/
# │   └── __init__.py
# ├── tests/
# │   └── __init__.py
# ├── README.md
# └── pyproject.toml

# O agregar poetry a proyecto existente
cd proyecto-existente
poetry init
# Responde preguntas interactivas
```

### pyproject.toml - El Corazón de poetry

```toml
[tool.poetry]
name = "langchain-agent"
version = "0.1.0"
description = "LangChain agent for EDF research"
authors = ["Tu Nombre <tu@email.com>"]
readme = "README.md"
packages = [{include = "langchain_agent"}]

[tool.poetry.dependencies]
python = "^3.11"
langchain = "^0.1.0"
langchain-openai = "^0.0.5"
python-dotenv = "^1.0.0"
pydantic = "^2.5.0"

[tool.poetry.group.dev.dependencies]
pytest = "^7.4.0"
black = "^23.0.0"
ruff = "^0.1.0"
mypy = "^1.7.0"

[build-system]
requires = ["poetry-core"]
build-backend = "poetry.core.masonry.api"
```

**Sintaxis de versiones:**
- `^0.1.0` = `>=0.1.0 <0.2.0` (compatible release)
- `~0.1.0` = `>=0.1.0 <0.1.1` (patch updates)
- `*` = Cualquier versión
- `==0.1.0` = Versión exacta

### Gestionar Dependencias

```bash
# Instalar dependencias desde pyproject.toml
poetry install
# Crea .venv/ y poetry.lock

# Agregar dependencia
poetry add langchain

# Agregar versión específica
poetry add "langchain==0.1.0"

# Agregar como dev dependency
poetry add --group dev pytest

# Remover
poetry remove langchain

# Actualizar paquete específico
poetry update langchain

# Actualizar todo
poetry update

# Ver dependencias
poetry show

# Ver árbol de dependencias
poetry show --tree
```

### poetry.lock - Reproducibilidad Garantizada

```toml
# poetry.lock (generado automáticamente)
[[package]]
name = "langchain"
version = "0.1.0"
description = "..."
dependencies = [
    {name = "pydantic", version = "2.5.3"},
    {name = "requests", version = "2.31.0"},
]

[[package]]
name = "pydantic"
version = "2.5.3"
# ...
```

**¿Por qué lock file?**
- `pyproject.toml`: Rangos de versiones (`^0.1.0`)
- `poetry.lock`: Versiones EXACTAS instaladas (`0.1.0`)
- Equipo instala EXACTAMENTE las mismas versiones

```bash
# Desarrollador A
poetry add langchain  # Instala 0.1.5 (última)
git add pyproject.toml poetry.lock
git commit

# Desarrollador B
git pull
poetry install  # Instala 0.1.5 (misma que A, desde lock)
```

### Ejecutar Comandos en poetry Environment

```bash
# Activar shell en venv
poetry shell

# O ejecutar comando sin activar
poetry run python main.py
poetry run pytest
poetry run black .

# Verificar Python usado
poetry run which python
# Output: /home/usuario/proyecto/.venv/bin/python
```

---

## 📊 **Comparación: pip+venv vs conda vs poetry**

### Feature Comparison

| Característica | pip + venv | conda | poetry |
|---------------|-----------|-------|--------|
| **Instalación Python** | ❌ Sistema | ✅ conda install | ❌ Sistema |
| **Entornos virtuales** | ✅ venv | ✅ Built-in | ✅ Built-in |
| **Paquetes Python** | ✅ PyPI | ✅ Conda + PyPI | ✅ PyPI |
| **Binarios sistema** | ❌ | ✅ CUDA, libs C | ❌ |
| **Lock files** | ❌ Manual | ❌ No nativo | ✅ poetry.lock |
| **Resolver deps** | Básico | Excelente | Excelente |
| **Velocidad install** | Rápida | Lenta | Media |
| **Publicar PyPI** | twine | ❌ | ✅ poetry publish |
| **Curva aprendizaje** | Baja | Media | Media |
| **Tamaño** | 100MB | 1-3GB | 100MB |

### Por Tipo de Proyecto

**Desarrollo web (FastAPI, Django):**
```bash
# ✅ Mejor: venv + pip (simple, suficiente)
python -m venv .venv
pip install fastapi uvicorn

# ⚠️ Alternativa: poetry (si equipo grande)
poetry new api-project
poetry add fastapi uvicorn
```

**Data Science / ML:**
```bash
# ✅ Mejor: conda (gestiona CUDA, optimizaciones)
conda create -n ml python=3.11
conda install numpy pandas scikit-learn tensorflow

# ❌ No usar: pip (sin optimizaciones)
```

**Librería para PyPI:**
```bash
# ✅ Mejor: poetry (gestión + publicación)
poetry new mi-libreria
poetry add requests
poetry build
poetry publish

# ⚠️ Alternativa: setuptools + twine (legacy)
```

**Proyecto enterprise:**
```bash
# ✅ Mejor: poetry (lock files, reproducible)
poetry install  # Todos instalan exactamente lo mismo

# ⚠️ Alternativa: pip-tools (pip-compile)
```

---

## 🎯 **Workflows Prácticos**

### Workflow 1: Proyecto Data Science con conda

```bash
# 1. Crear entorno
conda create -n edf-research python=3.11
conda activate edf-research

# 2. Instalar stack científico
conda install numpy pandas matplotlib scikit-learn jupyter

# 3. Instalar paquetes específicos con pip
pip install langchain openai

# 4. Exportar environment
conda env export > environment.yml

# 5. Limpiar environment.yml manualmente (quitar hashes)

# 6. Commitear
git add environment.yml
git commit -m "Add conda environment"

# Colaborador:
# conda env create -f environment.yml
# conda activate edf-research
```

### Workflow 2: Aplicación con poetry

```bash
# 1. Crear proyecto
poetry new langchain-api
cd langchain-api

# 2. Configurar Python version en pyproject.toml
# [tool.poetry.dependencies]
# python = "^3.11"

# 3. Agregar dependencias
poetry add fastapi uvicorn langchain python-dotenv

# 4. Agregar dev tools
poetry add --group dev pytest black ruff

# 5. Instalar todo
poetry install

# 6. Desarrollar
poetry run uvicorn main:app --reload

# 7. Tests
poetry run pytest

# 8. Commitear lock file
git add pyproject.toml poetry.lock
git commit -m "Setup dependencies"

# Colaborador:
# poetry install  # Instala desde lock file
```

### Workflow 3: Migrar de pip a poetry

```bash
# Proyecto existente con requirements.txt
cd mi-proyecto

# 1. Crear pyproject.toml
poetry init

# 2. Importar desde requirements.txt
cat requirements.txt | while read package; do
  poetry add "$package"
done

# 3. O manualmente
poetry add langchain pydantic requests

# 4. Verificar
poetry show --tree

# 5. Eliminar venv antiguo (opcional)
rm -rf .venv

# 6. Recrear con poetry
poetry install

# 7. Verificar que funciona
poetry run pytest

# 8. Commitear
git add pyproject.toml poetry.lock
git rm requirements.txt
git commit -m "Migrate to poetry"
```

---

## ⚠️ **Pitfalls y Best Practices**

### conda Pitfalls

```bash
# ❌ EVITAR: Instalar en base
conda activate base
conda install numpy  # Contamina base

# ✅ CORRECTO: Siempre usar entornos
conda create -n myproject
conda activate myproject
conda install numpy

# ❌ EVITAR: Mezclar conda y pip indiscriminadamente
conda install pandas
pip install numpy  # Preferir conda para científicos

# ✅ CORRECTO: conda primero, pip solo si no existe en conda
conda install pandas numpy scikit-learn
pip install langchain  # No está en conda
```

### poetry Pitfalls

```bash
# ❌ EVITAR: Modificar pyproject.toml manualmente sin update
# Editar pyproject.toml
poetry install  # No actualiza lock

# ✅ CORRECTO: Usar comandos poetry
poetry add langchain
poetry update

# ❌ EVITAR: Commitear solo pyproject.toml sin lock
git add pyproject.toml
git commit  # Lock desincronizado

# ✅ CORRECTO: Commitear ambos
git add pyproject.toml poetry.lock
git commit

# ❌ EVITAR: poetry add dentro de venv activado manualmente
source .venv/bin/activate
poetry add langchain  # Puede causar conflictos

# ✅ CORRECTO: Usar poetry shell o poetry run
poetry shell
poetry add langchain
```

---

## 📊 **Decision Tree: ¿Qué Usar?**

```
¿Qué tipo de proyecto?
│
├─ Data Science / ML
│  └─ ¿Necesitas CUDA/GPU?
│     ├─ Sí → conda
│     └─ No → conda (igual recomendado por optimizaciones)
│
├─ Desarrollo web (FastAPI, Django)
│  └─ ¿Equipo grande?
│     ├─ Sí → poetry (lock files)
│     └─ No → pip + venv (simple)
│
├─ Librería para PyPI
│  └─ poetry (gestión + publicación integrada)
│
├─ Scripts/Automatización
│  └─ pip + venv (suficiente)
│
└─ Proyecto enterprise
   └─ poetry (reproducibilidad garantizada)
```

---

## ✅ **Resumen: Comandos Esenciales**

### conda

```bash
# Crear entorno
conda create -n myenv python=3.11

# Activar
conda activate myenv

# Instalar
conda install numpy pandas

# Exportar
conda env export > environment.yml

# Crear desde yml
conda env create -f environment.yml
```

### poetry

```bash
# Nuevo proyecto
poetry new mi-proyecto

# Agregar dependencia
poetry add langchain

# Instalar
poetry install

# Ejecutar
poetry run python main.py

# Shell
poetry shell
```

---

## 🎯 **Siguiente Paso**

**Próximo archivo (FINAL):** `09_integrated_workflow_practice.md`

**Aprenderás:**
- Workflow completo: Desde cero hasta producción
- Decisiones en cada paso (qué herramienta usar)
- Casos reales: LangChain agent, API, ML pipeline
- Troubleshooting integrado
- Best practices completas

**Último archivo: Poner TODO junto en workflows del mundo real.**

---

## 📚 **Referencias**

- **conda:** https://docs.conda.io
- **conda-forge:** https://conda-forge.org
- **poetry:** https://python-poetry.org
- **pyproject.toml:** https://peps.python.org/pep-0621/

---

**Archivos completados:**
1. ✅ 00_cli_fundamentals.md
2. 01_cli_syntax_guide.md
3. ✅ 02_cli_commands_basics.md
4. ✅ 03_what_are_packages.md
5. ✅ 04_package_managers_by_type.md
6. ✅ 05_essential_packages.md
7. ✅ 06_runtime_version_managers.md
8. ✅ 07_python_virtual_environments_deep_dive.md
9. ✅ 08_hybrid_package_managers.md ← **Estás aquí**
10. 09_integrated_workflow_practice.md

**🎉 File 8 Complete! Ready for FINAL File 9: Integrated Workflows!**
