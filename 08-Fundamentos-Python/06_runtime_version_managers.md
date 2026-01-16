# 🔄 Runtime Version Managers (Multiple Python Versions)

**Objetivo:** Gestionar múltiples versiones de Python en el mismo sistema  
**Por qué este archivo:** Proyectos diferentes requieren versiones diferentes de Python  
**Requisito previo:** Haber leído `05_essential_packages.md` (setup básico completo)

---

## 🎯 **El Problema: Un Python No Es Suficiente**

### Escenario Real

```bash
# Proyecto A (legacy, Django 3.2)
cd ~/projects/old-django-app
python --version
# ❌ Necesita: Python 3.9 (Django 3.2 no soporta 3.11+)

# Proyecto B (nuevo, FastAPI + LangChain)
cd ~/projects/langchain-agent
python --version
# ✅ Necesita: Python 3.11+ (mejores tipos, performance)

# Proyecto C (data science, Tensorflow)
cd ~/projects/ml-models
python --version
# ⚠️ Necesita: Python 3.10 (Tensorflow 2.13 no certifica 3.11+)
```

**Sin version manager:**
- Solo puedes tener UN Python instalado
- Cambiar versión = desinstalar + reinstalar
- Rompes proyectos al actualizar

**Con version manager (pyenv):**
- Instala 3.9, 3.10, 3.11, 3.12 simultáneamente
- Cada proyecto usa su versión automáticamente
- Cambio transparente al entrar en directorio

---

## 📦 **Runtime Version Managers por Lenguaje**

| Lenguaje | Version Manager | Badge | Gestiona |
|----------|----------------|-------|----------|
| **Python** | pyenv | 🔄 [VER-MGR] | Python 3.6 - 3.12+ |
| **JavaScript** | nvm | 🔄 [VER-MGR] | Node.js 12 - 20+ |
| **Ruby** | rbenv | 🔄 [VER-MGR] | Ruby 2.x - 3.x |
| **Go** | gvm | 🔄 [VER-MGR] | Go 1.x |
| **Rust** | rustup | 🔄 [VER-MGR] | Rust stable/beta/nightly |
| **Java** | jenv | 🔄 [VER-MGR] | JDK 8 - 21 |

**Enfoque:** Este archivo cubre principalmente **pyenv** (Python) con ejemplos de nvm.

---

## 🐍 **pyenv - Python Version Manager**

### ¿Qué Hace pyenv?

**Sin pyenv:**
```bash
/usr/bin/python3.11  # Sistema tiene UN Python
```

**Con pyenv:**
```bash
~/.pyenv/versions/
├── 3.9.18/
│   └── bin/python
├── 3.10.13/
│   └── bin/python
├── 3.11.6/
│   └── bin/python
└── 3.12.0/
    └── bin/python
```

**pyenv intercepta comandos `python`:**
```bash
python --version
# pyenv busca en orden:
# 1. Variable PYENV_VERSION
# 2. Archivo .python-version (directorio actual)
# 3. Archivo .python-version (directorios padres)
# 4. ~/.pyenv/version (global)
```

---

## 🔧 **Instalación de pyenv**

### Linux (Ubuntu/Debian)

**Método recomendado - pyenv-installer:**

```bash
# 1. Instalar dependencias (CRÍTICO)
sudo apt update
sudo apt install -y \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    curl \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev

# 2. Instalar pyenv
curl https://pyenv.run | bash

# 3. Configurar shell (bash)
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc

# Si usas zsh:
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc

# 4. Reiniciar shell
exec "$SHELL"

# 5. Verificar instalación
pyenv --version
# Output: pyenv 2.3.x
```

**Verificar que pyenv está activo:**

```bash
which python
# Debe mostrar: /home/usuario/.pyenv/shims/python

type python
# Debe mostrar: python is /home/usuario/.pyenv/shims/python
```

### macOS

```bash
# 1. Instalar con Homebrew
brew install pyenv

# 2. Configurar shell (zsh - default en macOS)
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc

# Si usas bash:
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(pyenv init -)"' >> ~/.bash_profile

# 3. Reiniciar shell
exec "$SHELL"

# 4. Verificar
pyenv --version
```

### Windows (pyenv-win)

**pyenv-win es un port diferente para Windows:**

```powershell
# Método 1: Git (recomendado)
git clone https://github.com/pyenv-win/pyenv-win.git "$HOME\.pyenv"

# Agregar a PATH (ejecutar como admin o ajustar variables de usuario)
[System.Environment]::SetEnvironmentVariable('PYENV',"$HOME\.pyenv\pyenv-win\","User")
[System.Environment]::SetEnvironmentVariable('PYENV_ROOT',"$HOME\.pyenv\pyenv-win\","User")
[System.Environment]::SetEnvironmentVariable('PYENV_HOME',"$HOME\.pyenv\pyenv-win\","User")

$path = [System.Environment]::GetEnvironmentVariable('PATH', 'User')
$newPath = "$HOME\.pyenv\pyenv-win\bin;$HOME\.pyenv\pyenv-win\shims;$path"
[System.Environment]::SetEnvironmentVariable('PATH', $newPath, 'User')

# Reiniciar PowerShell

# Verificar
pyenv --version

# Método 2: Chocolatey
choco install pyenv-win
```

**Nota:** pyenv-win tiene limitaciones vs pyenv Unix. Alternativa: py launcher (ver sección final).

---

## 📋 **Comandos Esenciales de pyenv**

### Listar e Instalar Versiones

```bash
# Ver TODAS las versiones instalables
pyenv install --list
# Output: (truncado)
# 3.8.18
# 3.9.18
# 3.10.13
# 3.11.6
# 3.12.0
# 3.13.0a1  # Alpha releases

# Filtrar solo versiones estables 3.11
pyenv install --list | grep "^  3.11"
# Output:
# 3.11.0
# 3.11.1
# 3.11.2
# ...
# 3.11.6

# Instalar versión específica
pyenv install 3.11.6
# Descarga, compila e instala en ~/.pyenv/versions/3.11.6/
# ⏱️ Tarda ~5 minutos (compilación desde fuente)

# Instalar múltiples versiones
pyenv install 3.9.18
pyenv install 3.10.13
pyenv install 3.11.6

# Ver versiones instaladas
pyenv versions
# Output:
# * system (set by /home/usuario/.pyenv/version)
#   3.9.18
#   3.10.13
#   3.11.6

# system = Python del sistema (/usr/bin/python)
# * indica versión activa actual
```

### Establecer Versiones

**3 niveles de configuración:**

```bash
# 1. Shell (sesión actual)
pyenv shell 3.11.6
python --version  # Python 3.11.6
# Establece variable PYENV_VERSION solo para esta terminal

# 2. Local (directorio actual + subdirectorios)
cd ~/projects/mi-proyecto
pyenv local 3.11.6
python --version  # Python 3.11.6
# Crea archivo .python-version con "3.11.6"

# 3. Global (todo el sistema)
pyenv global 3.11.6
python --version  # Python 3.11.6
# Escribe ~/.pyenv/version

# Verificar versión activa
pyenv version
# Output: 3.11.6 (set by /home/usuario/projects/mi-proyecto/.python-version)
```

**Prioridad (de mayor a menor):**
1. `PYENV_VERSION` (shell)
2. `.python-version` (local - busca en directorio actual y padres)
3. `~/.pyenv/version` (global)
4. `system` (Python del sistema)

### Caso Práctico - Múltiples Proyectos

```bash
# Instalar versiones necesarias
pyenv install 3.9.18
pyenv install 3.11.6

# Proyecto legacy (Django 3.2)
cd ~/projects/old-django
pyenv local 3.9.18
cat .python-version  # 3.9.18
python --version     # Python 3.9.18
python -m venv .venv
source .venv/bin/activate
pip install django==3.2.0

# Proyecto nuevo (LangChain)
cd ~/projects/langchain-agent
pyenv local 3.11.6
cat .python-version  # 3.11.6
python --version     # Python 3.11.6
python -m venv .venv
source .venv/bin/activate
pip install langchain

# Cambio automático al entrar en directorios
cd ~/projects/old-django
python --version     # Python 3.9.18 (automático)

cd ~/projects/langchain-agent
python --version     # Python 3.11.6 (automático)
```

### Desinstalar Versiones

```bash
# Ver versiones instaladas
pyenv versions

# Desinstalar versión
pyenv uninstall 3.9.18

# Verificar
pyenv versions
# Ya no aparece 3.9.18
```

---

## 🔍 **Cómo Funciona pyenv (Internamente)**

### Shims - El Truco de pyenv

**pyenv usa "shims" (intercesores):**

```bash
# Estructura pyenv
~/.pyenv/
├── shims/              # ← Scripts intercesores
│   ├── python          # No es Python real, redirige
│   ├── pip
│   └── pytest
├── versions/           # ← Pythons reales
│   ├── 3.9.18/
│   │   └── bin/python
│   └── 3.11.6/
│       └── bin/python
└── version            # ← Global default
```

**Cuando ejecutas `python`:**

1. Shell encuentra `~/.pyenv/shims/python` (está en PATH)
2. Shim ejecuta `pyenv which python`
3. pyenv busca `.python-version` (local)
4. pyenv devuelve `~/.pyenv/versions/3.11.6/bin/python`
5. Shim ejecuta el Python real

**Verificación:**

```bash
# Ver ruta del shim
which python
# Output: /home/usuario/.pyenv/shims/python

# Ver Python real que usará
pyenv which python
# Output: /home/usuario/.pyenv/versions/3.11.6/bin/python

# Ver contenido del shim (es un script bash)
cat $(which python)
# #!/usr/bin/env bash
# set -e
# [ -n "$PYENV_DEBUG" ] && set -x
# program="${0##*/}"
# exec "$(dirname "$0")/pyenv" exec "$program" "$@"
```

### Rehash - Actualizar Shims

**Cuándo necesitas rehash:**
- Instalaste paquete que agrega comando CLI (e.g., `pip install black`)
- pyenv necesita crear shim para nuevo comando

```bash
# Instalar black en venv
pip install black

# Crear shim para comando black
pyenv rehash

# Ahora funciona
which black
# Output: /home/usuario/.pyenv/shims/black
```

**pyenv rehash automáticamente después de:**
- `pyenv install`
- `pip install` (si tienes pyenv-virtualenv plugin)

---

## 🔌 **pyenv-virtualenv Plugin (Recomendado)**

### ¿Qué Agrega?

**pyenv solo:** Gestiona versiones de Python  
**pyenv + pyenv-virtualenv:** Gestiona versiones + entornos virtuales

### Instalación

```bash
# Linux/macOS
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

# Agregar a shell (bash)
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
exec "$SHELL"

# macOS (zsh)
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
exec "$SHELL"

# Verificar
pyenv commands | grep virtualenv
# Output:
# virtualenv
# virtualenv-delete
# virtualenv-init
# virtualenvs
```

### Uso de pyenv-virtualenv

```bash
# Crear virtualenv
pyenv virtualenv 3.11.6 mi-proyecto-env
# Crea entorno basado en Python 3.11.6

# Listar virtualenvs
pyenv virtualenvs
# Output:
# 3.11.6/envs/mi-proyecto-env (created from /home/usuario/.pyenv/versions/3.11.6)
# mi-proyecto-env (created from /home/usuario/.pyenv/versions/3.11.6)

# Activar manualmente
pyenv activate mi-proyecto-env
python --version  # Python 3.11.6
pip list          # Entorno limpio

# Desactivar
pyenv deactivate

# Activación automática por directorio
cd ~/projects/mi-proyecto
pyenv local mi-proyecto-env
# Crea .python-version con "mi-proyecto-env"
# Activa automáticamente al entrar en directorio

# Eliminar virtualenv
pyenv virtualenv-delete mi-proyecto-env
```

### Comparación: venv vs pyenv-virtualenv

| Característica | venv | pyenv-virtualenv |
|---------------|------|------------------|
| **Activación** | Manual (`source .venv/bin/activate`) | Automática (por directorio) |
| **Ubicación** | En proyecto (`.venv/`) | Centralizada (`~/.pyenv/versions/`) |
| **Gestión** | Manual (crear/eliminar carpeta) | `pyenv virtualenv` / `pyenv virtualenv-delete` |
| **Cambio Python** | Recrear venv completo | `pyenv virtualenv 3.12.0 myenv` |
| **Mejor para** | Proyectos individuales | Múltiples proyectos, cambios frecuentes |

**Recomendación:**
- **Usa venv:** Si trabajas en 1-2 proyectos, Python único
- **Usa pyenv-virtualenv:** Si trabajas en 5+ proyectos, múltiples versiones Python

---

## 🌐 **nvm - Node Version Manager (JavaScript)**

### Instalación

```bash
# Linux/macOS
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

# Configurar shell (bash)
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
exec "$SHELL"

# macOS (zsh)
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc
exec "$SHELL"

# Windows
# Descargar nvm-windows desde GitHub:
# https://github.com/coreybutler/nvm-windows/releases

# Verificar
nvm --version
```

### Comandos Esenciales

```bash
# Listar versiones disponibles
nvm list-remote  # Linux/macOS
nvm list available  # Windows

# Instalar versión
nvm install 18.18.0
nvm install 20.9.0

# Listar instaladas
nvm list

# Usar versión
nvm use 18.18.0
node --version  # v18.18.0

# Establecer default
nvm alias default 18.18.0

# Por proyecto (.nvmrc)
echo "18.18.0" > .nvmrc
nvm use
# Lee de .nvmrc automáticamente
```

**Caso práctico:**

```bash
# Proyecto legacy (React 17)
cd ~/projects/old-react-app
echo "16.20.0" > .nvmrc
nvm use
npm install

# Proyecto nuevo (Next.js 14)
cd ~/projects/nextjs-app
echo "20.9.0" > .nvmrc
nvm use
npm install
```

---

## 🪟 **Windows py Launcher (Alternativa Ligera)**

### ¿Qué Es py Launcher?

**Incluido con Python en Windows desde 3.3+:**
- No requiere instalación adicional
- Menos features que pyenv-win
- Más simple, suficiente para muchos casos

### Uso del py Launcher

```powershell
# Ver versiones instaladas
py --list
# Output:
# -3.11-64 *
# -3.10-64
# -3.9-64

# Usar versión específica
py -3.9 --version
# Python 3.9.x

py -3.11 --version
# Python 3.11.x

# Ejecutar script con versión específica
py -3.9 script.py

# Crear venv con versión específica
py -3.9 -m venv .venv39
py -3.11 -m venv .venv311

# Activar
.\.venv311\Scripts\Activate.ps1
python --version  # Python 3.11.x
```

### Shebang en Scripts (Windows)

```python
#!/usr/bin/env python3.9
# script.py

print("Este script requiere Python 3.9")
```

```powershell
# py lee el shebang y usa Python 3.9
py script.py
```

### Comparación: pyenv-win vs py launcher

| Característica | pyenv-win | py launcher |
|---------------|-----------|-------------|
| **Instalación** | Manual (git clone) | Built-in con Python |
| **Instalar Pythons** | `pyenv install 3.11.0` | Manual (python.org) |
| **Cambio automático** | `.python-version` | No (manual) |
| **Simplicidad** | Complejo | Simple |
| **Mejor para** | Muchos proyectos | Pocos proyectos |

---

## 🎯 **Workflows Prácticos**

### Workflow 1: Setup Inicial con pyenv

```bash
# 1. Instalar pyenv (una sola vez)
curl https://pyenv.run | bash
# Configurar shell y reiniciar

# 2. Instalar versiones Python necesarias
pyenv install 3.11.6
pyenv install 3.10.13

# 3. Establecer global default
pyenv global 3.11.6

# 4. Verificar
python --version  # Python 3.11.6
pyenv versions
# * 3.11.6 (set by ~/.pyenv/version)
#   3.10.13

echo "✅ pyenv configurado"
```

### Workflow 2: Nuevo Proyecto con Versión Específica

```bash
# Proyecto necesita Python 3.10
mkdir ml-project && cd ml-project

# Establecer versión Python
pyenv local 3.10.13

# Verificar
python --version  # Python 3.10.13
cat .python-version  # 3.10.13

# Crear venv (usa Python 3.10 automáticamente)
python -m venv .venv
source .venv/bin/activate

# Instalar dependencias
pip install tensorflow==2.13.0

# Commitear .python-version
git add .python-version
git commit -m "Set Python 3.10 for tensorflow compatibility"
```

### Workflow 3: Colaborador Clona Proyecto

```bash
# Colaborador clona repo
git clone https://github.com/user/ml-project.git
cd ml-project

# Lee .python-version
cat .python-version  # 3.10.13

# Instalar versión si no la tiene
pyenv install 3.10.13  # Si ya está: "already installed"

# pyenv usa versión automáticamente
python --version  # Python 3.10.13

# Crear venv e instalar deps
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

echo "✅ Setup completo, mismo Python que el creador"
```

### Workflow 4: Actualizar Python del Proyecto

```bash
# Proyecto actualmente usa Python 3.10
cd ~/projects/mi-proyecto
cat .python-version  # 3.10.13

# Decisión: Actualizar a Python 3.11
pyenv install 3.11.6
pyenv local 3.11.6

# Recrear venv con nuevo Python
rm -rf .venv
python --version  # Python 3.11.6
python -m venv .venv
source .venv/bin/activate

# Reinstalar dependencias
pip install -r requirements.txt

# Probar que todo funciona
pytest

# Si OK, commitear cambio
git add .python-version
git commit -m "Upgrade to Python 3.11.6"
```

---

## ⚠️ **Troubleshooting Común**

### Problema 1: pyenv no cambia versión

```bash
# Síntoma
pyenv local 3.11.6
python --version
# Output: Python 3.10.13 (¡no cambió!)

# Diagnóstico
which python
# Output: /usr/bin/python (¡no es pyenv shim!)

# Solución: Verificar PATH
echo $PATH
# ~/.pyenv/shims DEBE estar al inicio

# Reconfigurar
echo 'export PATH="$HOME/.pyenv/shims:$PATH"' >> ~/.bashrc
exec "$SHELL"

# Verificar fix
which python
# Output: /home/usuario/.pyenv/shims/python ✅
```

### Problema 2: Error al compilar Python (Linux)

```bash
# Síntoma
pyenv install 3.11.6
# Error: BUILD FAILED

# Causa: Faltan dependencias de compilación

# Solución: Instalar todas las dependencias
sudo apt install -y \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    curl \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev

# Reintentar
pyenv install 3.11.6
```

### Problema 3: pyenv lento al cambiar directorios

```bash
# Síntoma: Delay de 1-2 segundos al cd

# Causa: pyenv verifica .python-version en CADA cd

# Solución 1: Usar pyenv-virtualenv con lazy loading
echo 'export PYENV_VIRTUALENV_DISABLE_PROMPT=1' >> ~/.bashrc

# Solución 2: Cache (pyenv 2.0+)
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc

exec "$SHELL"
```

---

## 📊 **Comparación Final: Gestión de Versiones Python**

| Método | Pros | Contras | Recomendado Para |
|--------|------|---------|------------------|
| **System Python** | Simple, pre-instalado | Una sola versión, puede romper OS | No recomendado |
| **Manual (múltiples apt)** | Control total | Difícil gestionar, conflictos PATH | Servidores, single-purpose |
| **pyenv** | Fácil switch, aislado | Compila (lento), configuración inicial | Desarrollo, múltiples proyectos |
| **conda** | Python + paquetes científicos | Pesado, lento | Data science exclusivamente |
| **Docker** | Aislamiento completo | Overhead, complejidad | Producción, CI/CD |
| **py launcher (Windows)** | Built-in, simple | Solo Windows, manual | Windows, pocos proyectos |

---

## ✅ **Checklist: ¿Necesitas Version Manager?**

```bash
# ✅ SÍ necesitas pyenv si:
[ ] Trabajas en 3+ proyectos Python
[ ] Proyectos requieren diferentes versiones Python
[ ] Contribuyes a open source (muchas versiones)
[ ] Quieres probar Python betas (3.13.0a1)
[ ] Equipo usa versiones específicas

# ❌ NO necesitas pyenv si:
[ ] Solo trabajas en 1-2 proyectos
[ ] Todos usan mismo Python (e.g., 3.11)
[ ] Solo desarrollo personal
[ ] Puedes usar conda (data science)
```

---

## 🎯 **Resumen: Comandos Esenciales**

```bash
# Instalación pyenv (Linux)
curl https://pyenv.run | bash

# Instalar Python
pyenv install 3.11.6

# Ver instaladas
pyenv versions

# Establecer versión
pyenv global 3.11.6   # Todo el sistema
pyenv local 3.11.6    # Proyecto actual (crea .python-version)
pyenv shell 3.11.6    # Sesión actual

# Verificar versión activa
pyenv version
python --version

# Crear venv con versión específica
python -m venv .venv
source .venv/bin/activate
```

---

## 🎯 **Siguiente Paso**

**Próximo archivo:** `07_python_virtual_environments_deep_dive.md`

**Aprenderás:**
- venv vs virtualenv vs pipenv en profundidad
- Cómo funcionan internamente los virtual environments
- Best practices: dónde crear venv, nombrar, activar
- Integración con IDEs (VS Code, PyCharm)
- Troubleshooting venv común

**Ya sabes gestionar versiones Python. Ahora profundizarás en aislar dependencias por proyecto.**

---

## 📚 **Referencias**

- **pyenv:** https://github.com/pyenv/pyenv
- **pyenv-virtualenv:** https://github.com/pyenv/pyenv-virtualenv
- **nvm:** https://github.com/nvm-sh/nvm
- **py launcher:** https://docs.python.org/3/using/windows.html#python-launcher-for-windows

---

**Archivos completados:**
1. ✅ 00_cli_fundamentals.md
2. 01_cli_syntax_guide.md
3. ✅ 02_cli_commands_basics.md
4. ✅ 03_what_are_packages.md
5. ✅ 04_package_managers_by_type.md
6. ✅ 05_essential_packages.md
7. ✅ 06_runtime_version_managers.md ← **Estás aquí**
8. 07_python_virtual_environments_deep_dive.md
9. 08_hybrid_package_managers.md
10. 09_integrated_workflow_practice.md

**🎉 File 6 Complete! Ready for File 7: Virtual Environments Deep Dive**
