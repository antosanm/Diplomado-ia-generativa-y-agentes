# clonar el repositorio de langchain-academy
git clone https://github.com/langchain-ai/langchain-academy.git
cd langchain-academy
# crear y activar el entorno virtual
python3 -m venv lc-academy-env
source lc-academy-env/bin/activate
# instalar las dependencias
pip install -r requirements.txt
# activar kernel para notebooks
python -m ipykernel install --user --name=lc-academy-env
# volver al directorio anterior
cd ..


# clonar el repositorio de AI-Agent-RAG

git clone https://github.com/xfroldanf/AI-Agent-RAG.git
cd AI-Agent-RAG  

# Si ya tienes el repositorio clonado, actualízalo con:
# git pull origin main  


# crear y activar el entorno virtual
python3 -m venv .venv
source .venv/bin/activate
# instalar las dependencias
pip install --upgrade pip
pip install -r requirements.txt

python -m ipykernel install --user --name=.venv --display-name "Python (AI-Agent-RAG)"


#Activar kernel para notebooks
# selecciona el intérprete .venv en VS Code
#Ctrl + Shift + P
#Escribe: "Python: Select Interpreter"
#Enter interpreter path
#find 
#select .venv/bin/python