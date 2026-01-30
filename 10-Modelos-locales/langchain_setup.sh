# instalar portaudio para soporte de audio en notebooks
sudo apt-get update && sudo apt-get install -y portaudio19-dev

#clonar repositorio de langchain
git clone https://github.com/langchain-ai/lca-lc-foundations.git
cd lca-lc-foundations

cp example.env .env
# installar uv
pip install uv
# inicializar entorno 
uv sync
# correr script de utilidades de entorno
uv run python env_utils.py

# Crear proyecto en Google Cloud y obtener llave API de Gemini
# 1. Ir a Google AI Studio visitando el sitio web de Google AI Studio. https://aistudio.google.com/
# 2. Iniciar sesión con tu cuenta de Google.
# 3. Abrir el Panel de control desde el menú de la izquierda.
# 4. Seleccionar Proyectos en el menú.
# 5. Hacer clic en el botón Importar proyectos si aún no has importado ningún proyecto de Google Cloud.
# 6. Buscar el proyecto de Google Cloud deseado por nombre o ID del proyecto y hacer clic en Importar.
# 7. Una vez que el proyecto esté importado, navegar a la sección de Claves API en el menú del Panel de control.
# 8. Hacer clic en Crear clave API para generar una nueva clave para el proyecto seleccionado.
# 9. Copiar la clave API generada y guardarla de forma segura.


# create cuenta tavily y obtener llave API 
#https://app.tavily.com/

# crear una cuenta de LangSmith si no se tiene una 
# crear una llave API de LangSmith y agregarla al archivo .env

#seleccionar el kernel para los notebooks. Hay dos formas de hacerlo:

#1. desde jupyter notebook seleccionar el kernel "Python (lca-lc-foundations)"
# buscar la ruta del interprete del entorno virtual  /lca-lc-foundations/.venv/bin/python

#2. correr el siguiente comando para agregar el kernel a jupyter
uv run python -m ipykernel install --user --name lca-lc-foundations --display-name "Python (lca-lc-foundations)"


uv pip install --force-reinstall sounddevice



