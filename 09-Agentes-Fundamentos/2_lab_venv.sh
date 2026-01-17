# 1. Instalar Python y herramientas
sudo apt install python3 python3-pip python3-venv

# 3. Verificar despues
python3 --version
python3 -m pip --version
which python3
which pip3
python3 -m venv --help

# 4. Crear proyecto
mkdir mi-proyecto
cd mi-proyecto

# 5. Crear entorno virtual
python3 -m venv .venv

# 6. Verificar el python activo antes de activar el venv
which python3 /usr/bin/python3.12

# 7. Crear requirements_system.txt antes de instalar dentro del venv
python3 -m pip freeze > requirements_system.txt
python3 -m pip list > requirements_system.txt

# 8. Activar
source .venv/bin/activate

# 9. Verificar que estás en el venv
which python3  # Debería mostrar .venv/bin/python

# 10. Crear requirements_old.txt antes de instalar dentro del venv
python3 -m pip freeze > requirements_old.txt
python3 -m pip list > requirements_old.txt

# 11. Instalar paquete
python -m pip install langchain

# 12. Crear requirements_new.txt despues de instalar dentro del venv
python3 -m pip freeze > requirements_new.txt
python3 -m pip list > requirements_new.txt

# 13. Ver qué se instaló
diff requirements_old.txt requirements_new.txt 

# 14. Installar pip-autoremove
python3 -m pip install pip-autoremove

# 15. desactivar
deactivate

# 16.  Eliminar la carpeta del venv
rm -rf .venv #cuidado a la ubicacion



