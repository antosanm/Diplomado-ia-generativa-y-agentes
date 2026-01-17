#https://www.anaconda.com/docs/getting-started/miniconda/install

# 1. Instalar miniconda3

# 64-bit
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm ~/miniconda3/miniconda.sh

#ARM 64
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm ~/miniconda3/miniconda.sh

# 2. Activar entorno base
source ~/miniconda3/bin/activate

# 3. Donde esta instalado conda
which conda

# 4. Activarlo para la shell por defecto
conda init --all --dry-run

# 5. Donde esta instalado conda
which conda

# 6. Desactivar base por defecto en la shell
conda config --set auto_activate_base false

# 7. Activar base por defecto en la shell
conda config --set auto_activate_base true

# 8. Activar conda base
conda activate

#Base existe porque conda necesita su propio Python controlado 
#para funcionar de forma segura e independiente del sistema operativo.

# 9. crear un entorno

#Conda asigna automáticamente la versión del BASE 
#(tener presente esto. Cambiar puede ser problemático)
conda create --name my_python_env

# Instalar version de python dentro de entorno
conda install python=3.11


# Conda descarga automáticamente Python en la creación del entorno si no esta
conda create --name my_python_env python=3.9 

# 10. Activar un environment específico creado
conda activate my_python_env

# 11. Desactivar y volver al sistema
conda deactivate

# 12. listar entornos y ubicacion (La filosofía de conda es centralizar envs)
conda env list

# 13. Eliminar un entorno específico por nombre
conda env remove --name my_python_env

# 14. O usar la forma corta
conda remove --name my_python_env --all

# 15. Eliminar un entorno por ruta (si no está en la ubicación estándar)
conda env remove --prefix /ruta/al/entorno

# 16. Ver paquetes instalados
conda list
conda list --name my_python_env

# 17. Instalar paquetes con conda install 
conda install numpy pandas

# 18. Actualizar todo los paquetes
conda update --all

# 19. Desinstalar paquetes
conda uninstall pycaret

# 20.Exportar TODO (paquetes + dependencias)
conda env export > environment.yml

# 21. Exportar solo paquetes instalados manualmente (más limpio)
conda env export --from-history > environment.yml

# 22. Exportar como requirements.txt
conda list --export > requirements.txt

# 23. Crear entorno desde YAML (el archivo tiene el nombre del entorno y version de python)
conda env create --file environment.yml

# 24. O especificar nombre diferente
conda env create --name nuevo_nombre --file environment.yml

# 24.b Crear entorno desde requirements.txt (solo paquetes)
conda create --name mi_env --file requirements.txt

# MANEJO DE CHANNELS EN CONDA
# 1. Ver channels activos
conda config --show channels

# 2. Agregar channel (se vuelve prioritario)
conda config --add channels conda-forge

# 3. Remover channel
conda config --remove channels conda-forge

# 4. Ver prioridad de channels
conda config --show channels

# 5. Instalar desde channel específico
conda install -c conda-forge numpy
conda install -c pytorch pytorch

# USAR PIP DENTRO DE CONDA
#  conda primero, pip después
# 1. Instalar pip dentro de conda si no está (generalmente ya está)
conda install pip

# 2. Paquete NO existe en conda
conda search some_package  # No encontrado
pip install some_package # Instalar con pip

#CLONAR ENTORNOS CONDA

# Clonar el entorno
conda create --clone my_python_env --name proyecto_backup

# El nuevo entorno es identico
conda activate proyecto_backup

# Casos de uso comunes:
# Backup antes de cambios riesgosos
conda create --clone production --name production_backup

# Crear variaciones de un entorno base
conda create --clone base_ml --name proyecto_a
conda create --clone base_ml --name proyecto_b

# Experimentar sin romper el original
conda create --clone working_env --name test_env

# FORMAS DE CLONAR ENTORNOS CONDA

# 1. CLONAR: Copia exacta
conda create --clone old_env --name new_env

# 2. DESDE YAML: Recrear desde archivo  
conda env export > env.yml
conda env create --name new_env --file env.yml

# 3. DESDE REQUIREMENTS: Solo paquetes
conda list --export >  requeriments.txt
conda create --name new_env --file  requeriments.txt
