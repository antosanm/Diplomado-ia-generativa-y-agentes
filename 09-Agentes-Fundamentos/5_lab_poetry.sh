#https://python-poetry.org/docs/#installing-with-the-official-installer

# 1. Instalar Poetry

# Método oficial (Linux/macOS/WSL)
curl -sSL https://install.python-poetry.org | python3 -

# O con pip (no recomendado para desarrollo)
python3 -m pip install poetry

# O con apt en Ubuntu
sudo apt install python3-poetry

# 2. Verificar instalación
poetry --version

# 3. Donde está instalado poetry
which poetry

# 4. Configurar path si no funciona (después de instalación oficial)
export PATH="$HOME/.local/bin:$PATH"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

#FILOSOFÍA POETRY vs CONDA:
#- Poetry: Gestiona proyectos, no entornos globales
#- NO hay "entorno base" como conda
#- Cada proyecto tiene su propio pyproject.toml
#- Puede crear entornos in-project (.venv) o centralizados

# 5. Configurar comportamiento de entornos virtuales

# Ver configuración actual
poetry config --list

# Crear entornos dentro del proyecto (como venv)
poetry config virtualenvs.in-project true

# Crear entornos centralizados (como conda) - por defecto
poetry config virtualenvs.in-project false

# Ver donde crea entornos centralizados
poetry config virtualenvs.path
# Default: ~/.cache/pypoetry/virtualenvs/

# 6. Inicializar un proyecto Poetry (NO existe en conda)

# Crear proyecto nuevo desde cero
poetry new mi_proyecto
cd mi_proyecto

# O inicializar en proyecto existente
cd mi_proyecto_existente
poetry init  # Interactivo, crea pyproject.toml

# 7. Crear entorno virtual para el proyecto actual

# Poetry detecta automáticamente si necesita crear entorno
poetry install

# O forzar creación de entorno
poetry env use python3.11
poetry env use python3.9

# Ver entornos del proyecto actual
poetry env list

# Ver información del entorno activo
poetry env info

# 8. Activar entorno del proyecto

# Activar shell interactiva (como conda activate)
poetry shell

# Ejecutar comando en el entorno SIN activar
poetry run python script.py
poetry run pip list

# Salir del shell
exit

# 9. NO EXISTE entorno "base" como conda
# Poetry SIEMPRE trabaja en el contexto de un proyecto específico
# Usa el Python del sistema hasta que crees un proyecto

# 10. Gestión de entornos por proyecto

# Listar entornos del proyecto actual
poetry env list

# Remover entorno del proyecto actual
poetry env remove python3.11

# Remover TODOS los entornos del proyecto
poetry env remove --all

# Ver donde está ubicado el entorno
poetry env info --path
# Centralizado: ~/.cache/pypoetry/virtualenvs/proyecto-hash/
# In-project: ./mi_proyecto/.venv/

# 11. Instalar paquetes (equivale a conda install)

# Instalar paquetes de producción
poetry add requests numpy pandas

# Instalar ejemplo específico
poetry add langchain

# Instalar con versión específica
poetry add "django>=4.0,<5.0"

# Instalar paquetes de desarrollo solamente
poetry add --group dev pytest black flake8

# También puedes crear grupos personalizados
poetry add --group test pytest coverage
poetry add --group lint black flake8 mypy

# Instalar desde archivo local
poetry add ./mi_paquete_local

# 12. Ver paquetes instalados (equivale a conda list)
poetry show

# Ver árbol de dependencias
poetry show --tree

# Ver solo paquetes de desarrollo
poetry show --only dev

# 13. Actualizar paquetes (equivale a conda update)

# Actualizar todos los paquetes
poetry update

# Actualizar paquete específico
poetry update requests

# 14. Remover paquetes (equivale a conda uninstall)
poetry remove numpy

# Remover paquete de desarrollo
poetry remove --group dev pytest

# 15. Export/Import - DIFERENTE a conda

# NO usa environment.yml, usa pyproject.toml + poetry.lock

# Exportar como requirements.txt (para compatibilidad)
poetry export -f requirements.txt --output requirements.txt

# Exportar incluyendo dependencias de desarrollo
poetry export -f requirements.txt --dev --output requirements-dev.txt

# Exportar sin hashes (más limpio)
poetry export -f requirements.txt --without-hashes --output requirements.txt

# 16. Reproducir proyecto Poetry (equivale a conda env create)

# Clonar proyecto con Poetry
git clone proyecto-repo
cd proyecto-repo

# Instalar EXACTAMENTE las mismas versiones (usa poetry.lock)
poetry install

# Instalar sin dependencias de desarrollo
poetry install --without dev

# Instalar solo dependencias de desarrollo
poetry install --only dev

# 17. NO HAY CHANNELS como conda
# Poetry usa PyPI por defecto
# Puede agregar repositorios privados:

# Agregar repositorio privado
poetry source add mi_repo https://mi-repositorio.com/simple/

# Ver fuentes configuradas
poetry source show

# 18. NO necesita pip por separado
# poetry add usa pip por debajo automáticamente
# Pero puedes usar pip si necesario:
poetry run pip install paquete-no-en-pypi

# 19. "Clonar" proyectos Poetry

# NO existe clone directo como conda
# Pero puedes duplicar la configuración:

# MÉTODO 1: Copiar pyproject.toml
cp pyproject.toml ../nuevo_proyecto/
cd ../nuevo_proyecto
poetry install  # Crea entorno idéntico

# MÉTODO 2: Export/Import via requirements
poetry export -f requirements.txt --output requirements.txt
cd ../nuevo_proyecto
python -m venv .venv
source .venv/bin/activate  # O usar poetry si tienes pyproject.toml
pip install -r requirements.txt

# 20. Gestión de versiones Python (DIFERENTE a conda)

# Poetry NO descarga Python automáticamente
# Usa Python instalado en el sistema

# Ver versiones Python disponibles en sistema
poetry env use python3.9    # Si tienes Python 3.9 instalado
poetry env use python3.11   # Si tienes Python 3.11 instalado

# Ver Python activo en proyecto
poetry run python --version

# 21. Comandos útiles específicos de Poetry

# Verificar configuración del proyecto
poetry check

# Actualizar Poetry mismo
poetry self update

# Limpiar cache
poetry cache clear pypi --all

# Ver configuración global
poetry config --list

# Configurar credenciales para repositorios privados
poetry config repositories.mi_repo https://mi-repo.com
poetry config http-basic.mi_repo username password

# DIFERENCIAS CLAVE CONDA vs POETRY:

# CONDA:
# - Gestiona entornos globalmente
# - Descarga Python automáticamente  
# - Usa channels (conda-forge, etc)
# - Entorno "base" siempre presente
# - environment.yml para reproducción

# POETRY:
# - Gestiona proyectos específicos
# - Usa Python del sistema
# - Solo PyPI (y repos privados)
# - NO hay entorno "base"
# - pyproject.toml + poetry.lock para reproducción
# - Entornos por proyecto (in-project o hash único)

# 22. Control de versiones con Poetry

# SIEMPRE commitear estos archivos
git add pyproject.toml poetry.lock
git commit -m "Add Poetry dependency management"

# pyproject.toml: Define dependencias y configuración
# poetry.lock: Versiones exactas para reproducibilidad

# NO commitear: .venv/ (si usas in-project)

# 23. Reproducir proyecto Poetry desde Git

# Flujo completo de reproducción
git clone "https://github.com/usuario/fraud-detection-repo"
cd fraud-detection
poetry install  # Lee pyproject.toml y poetry.lock

# El entorno será EXACTAMENTE igual al original

# 24. Configuraciones útiles adicionales

# Ver toda la configuración
poetry config --list

# Configurar timeout para instalaciones lentas
poetry config installer.timeout 300

# Configurar cache de poetry
poetry config cache-dir ~/.cache/pypoetry

# Deshabilitar parallel installation si hay problemas
poetry config installer.parallel false

# FLUJO TÍPICO POETRY:
# 1. poetry new mi_proyecto  O  poetry init
# 2. poetry add dependencias
# 3. poetry install (crea entorno)
# 4. poetry shell (activar) O poetry run comando
# 5. Commit pyproject.toml + poetry.lock
# 6. En otro lado: poetry install (reproduce exacto)