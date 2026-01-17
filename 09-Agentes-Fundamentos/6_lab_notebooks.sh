# ============================================================
# GUÍA: Configuración de Notebooks con Conda
# ============================================================
# Ejecuta estos comandos paso a paso en tu terminal
# ============================================================


# PASO 1: Verificar Conda
conda --version


# PASO 2: Ir a carpeta de trabajo
cd ~/repos


# PASO 3: Crear ambiente desde environment.yml
# (Si ya existe, elimínalo primero: conda env remove -n agentes_ai)
conda env create -f environment.yml


# PASO 4: Activar el ambiente
conda activate agentes_ai
python --version


# PASO 5: Registrar kernel para VS Code
# ¿Qué hace? Conecta tu ambiente Conda con VS Code Notebooks
# - Crea un "kernel" que VS Code puede detectar
# - Sin esto, VS Code no verá tu ambiente en la lista de kernels
# - El kernel es el puente entre el notebook y tu Python
python -m ipykernel install --user --name agentes_ai --display-name "Python (agentes_ai)"


# PASO 6: Verificar kernel instalado
jupyter kernelspec list


# PASO 7: Abrir VS Code y seleccionar kernel
code .
# En VS Code:
# 1. Abre 01_agent_memory.ipynb
# 2. Arriba a la derecha, clic en "Select Kernel"
# 3. Selecciona "Python (agentes_ai)"


# ============================================================
# COMANDOS ÚTILES
# ============================================================
# Activar ambiente
conda activate agentes_ai

# Desactivar ambiente
conda deactivate

# Listar ambientes
conda env list

# Actualizar ambiente si cambias environment.yml
conda env update -f environment.yml --prune
