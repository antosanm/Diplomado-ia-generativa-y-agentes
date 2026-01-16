# Guía de Paquetes Linux para Desarrollo de Agentes IA

## PARTE 1: TAXONOMÍA COMPLETA DE PAQUETES

### 📋 Visión General

Esta guía organiza los paquetes de Linux necesarios para desarrollar agentes autónomos con IA en 6 niveles, desde lo básico hasta lo avanzado.

---

### 🟢 NIVEL 1: Sistema Base (Ya Instalado)

Estos paquetes vienen preinstalados en Ubuntu/Debian. No necesitas instalarlos.

#### Shell y Comandos Básicos
| Paquete | Comandos que incluye | Para qué sirve |
|---------|---------------------|----------------|
| `bash` | bash | Shell principal de Linux |
| `coreutils` | ls, cp, mv, rm, cat, mkdir, chmod, chown | Comandos básicos de archivos |
| `grep` | grep, egrep, fgrep | Buscar patrones en archivos |
| `sed` | sed | Editar archivos automáticamente |
| `awk` | awk | Procesar y analizar texto |
| `findutils` | find, locate, xargs | Buscar archivos |

#### Red Básica
| Paquete | Comandos que incluye | Para qué sirve |
|---------|---------------------|----------------|
| `iproute2` | ip, ss | Ver y configurar red |
| `iputils-ping` | ping | Probar conexión a internet |
| `systemd` | systemctl | Gestionar servicios del sistema |

#### Sistema
| Paquete | Comandos que incluye | Para qué sirve |
|---------|---------------------|----------------|
| `procps` | ps, top, kill | Ver y matar procesos |
| `util-linux` | mount, dmesg, logger | Herramientas del sistema |
| `apt` | apt, apt-get | Instalar paquetes |
| `dpkg` | dpkg | Gestor de paquetes bajo nivel |

---

### 🟡 NIVEL 2: Herramientas de Desarrollo (ESENCIAL)

Este nivel es **obligatorio** para cualquier desarrollo. Aquí instalas lo básico para programar.

#### Compilación (para instalar paquetes de C/C++)
| Paquete | Qué incluye | Para qué sirve |
|---------|-------------|----------------|
| `build-essential` | gcc, g++, make, libc-dev | Compilar código en C/C++ |
| `cmake` | cmake | Sistema de construcción moderno |
| `pkg-config` | pkg-config | Encontrar librerías instaladas |

**Comando de instalación:**
```bash
sudo apt install build-essential cmake pkg-config
```

#### Control de Versiones
| Paquete | Qué incluye | Para qué sirve |
|---------|-------------|----------------|
| `git` | git | Guardar código con historial |
| `git-lfs` | git-lfs | Manejar archivos grandes en Git |

**Comando de instalación:**
```bash
sudo apt install git git-lfs
```

#### Python (⭐ MUY IMPORTANTE)
| Paquete | Qué incluye | Para qué sirve |
|---------|-------------|----------------|
| `python3` | python3 | Ejecutar programas Python |
| `python3-pip` | pip3 | Instalar librerías de Python |
| `python3-venv` | venv | Crear entornos virtuales |
| `python3-dev` | headers de Python | Compilar extensiones de Python |

**Comando de instalación:**
```bash
sudo apt install python3 python3-pip python3-venv python3-dev
```

#### Herramientas de Red
| Paquete | Qué incluye | Para qué sirve |
|---------|-------------|----------------|
| `curl` | curl | Descargar desde internet (APIs) |
| `wget` | wget | Descargar archivos |
| `ca-certificates` | certificados SSL | Conectar con HTTPS seguro |

**Comando de instalación:**
```bash
sudo apt install curl wget ca-certificates
```

#### Editores de Texto
| Paquete | Qué incluye | Para qué sirve |
|---------|-------------|----------------|
| `vim` | vim | Editor de texto avanzado |
| `nano` | nano | Editor de texto simple |

**Comando de instalación:**
```bash
sudo apt install vim nano
```

#### Terminal Avanzada
| Paquete | Qué incluye | Para qué sirve |
|---------|-------------|----------------|
| `tmux` | tmux | Dividir la terminal en paneles |
| `screen` | screen | Mantener sesiones abiertas |

**Comando de instalación:**
```bash
sudo apt install tmux screen
```

#### Compresión de Archivos
| Paquete | Qué incluye | Para qué sirve |
|---------|-------------|----------------|
| `zip` | zip | Crear archivos .zip |
| `unzip` | unzip | Extraer archivos .zip |
| `p7zip-full` | 7z | Manejar archivos .7z |

**Comando de instalación:**
```bash
sudo apt install zip unzip p7zip-full
```

#### Utilidades
| Paquete | Qué incluye | Para qué sirve |
|---------|-------------|----------------|
| `tree` | tree | Ver estructura de carpetas |
| `htop` | htop | Monitor de procesos mejorado |
| `rsync` | rsync | Sincronizar archivos |

**Comando de instalación:**
```bash
sudo apt install tree htop rsync
```

**✅ Instalación completa del Nivel 2 (todo junto):**
```bash
sudo apt update
sudo apt install -y build-essential cmake pkg-config \
    git git-lfs \
    python3 python3-pip python3-venv python3-dev \
    curl wget ca-certificates \
    vim nano \
    tmux screen \
    zip unzip p7zip-full \
    tree htop rsync
```

---

### 🔵 NIVEL 3: Infraestructura de Agentes (CORE)

Este nivel incluye bases de datos, servidores y contenedores necesarios para agentes.

#### Bases de Datos

**SQLite (Base de datos local, simple)**
| Paquete | Qué incluye | Para qué sirve |
|---------|-------------|----------------|
| `sqlite3` | sqlite3 | Base de datos embebida en archivo |

```bash
sudo apt install sqlite3
```

**PostgreSQL (Base de datos profesional)**
| Paquete | Qué incluye | Para qué sirve |
|---------|-------------|----------------|
| `postgresql` | servidor PostgreSQL | Base de datos relacional potente |
| `postgresql-client` | psql | Cliente para conectarse |
| `libpq-dev` | headers | Para instalar psycopg2 en Python |

```bash
sudo apt install postgresql postgresql-client libpq-dev
```

**Redis (Caché y colas de tareas)**
| Paquete | Qué incluye | Para qué sirve |
|---------|-------------|----------------|
| `redis-server` | redis-server | Base de datos en memoria (rápida) |
| `redis-tools` | redis-cli | Cliente de línea de comandos |

```bash
sudo apt install redis-server redis-tools
```

#### Servidores Web
| Paquete | Qué incluye | Para qué sirve |
|---------|-------------|----------------|
| `nginx` | nginx | Servidor web / proxy inverso |

```bash
sudo apt install nginx
```

#### Message Brokers (Colas de mensajes)
| Paquete | Qué incluye | Para qué sirve |
|---------|-------------|----------------|
| `rabbitmq-server` | rabbitmq-server | Sistema de colas de mensajes |

```bash
sudo apt install rabbitmq-server
```

#### Contenedores (Docker)
| Paquete | Qué incluye | Para qué sirve |
|---------|-------------|----------------|
| `docker.io` | docker | Ejecutar aplicaciones en contenedores |
| `docker-compose` | docker-compose | Orquestar múltiples contenedores |

```bash
sudo apt install docker.io docker-compose
sudo usermod -aG docker $USER  # Agregar tu usuario al grupo docker
```

**✅ Instalación completa del Nivel 3:**
```bash
sudo apt install -y sqlite3 \
    postgresql postgresql-client libpq-dev \
    redis-server redis-tools \
    nginx \
    rabbitmq-server \
    docker.io docker-compose
```

---

### 🟣 NIVEL 4: Procesamiento de Documentos y ML

Para agentes que procesan PDFs, imágenes, OCR, audio y video.

#### Procesamiento de PDFs
| Paquete | Qué incluye | Para qué sirve |
|---------|-------------|----------------|
| `poppler-utils` | pdftotext, pdfimages | Extraer texto e imágenes de PDFs |
| `ghostscript` | gs | Manipular PDFs |
| `qpdf` | qpdf | Transformar PDFs |

```bash
sudo apt install poppler-utils ghostscript qpdf
```

#### OCR (Reconocimiento de texto en imágenes)
| Paquete | Qué incluye | Para qué sirve |
|---------|-------------|----------------|
| `tesseract-ocr` | tesseract | Motor de OCR |
| `tesseract-ocr-eng` | datos inglés | Reconocer texto en inglés |
| `tesseract-ocr-spa` | datos español | Reconocer texto en español |

```bash
sudo apt install tesseract-ocr tesseract-ocr-eng tesseract-ocr-spa
```

#### Conversión de Documentos
| Paquete | Qué incluye | Para qué sirve |
|---------|-------------|----------------|
| `pandoc` | pandoc | Convertir entre formatos (md, docx, pdf) |

```bash
sudo apt install pandoc
```

#### Procesamiento de Imágenes
| Paquete | Qué incluye | Para qué sirve |
|---------|-------------|----------------|
| `imagemagick` | convert, identify | Redimensionar, convertir imágenes |
| `graphicsmagick` | gm | Alternativa más rápida |
| `exiftool` | exiftool | Leer/editar metadatos |

```bash
sudo apt install imagemagick graphicsmagick exiftool
```

#### Procesamiento de Audio y Video
| Paquete | Qué incluye | Para qué sirve |
|---------|-------------|----------------|
| `ffmpeg` | ffmpeg, ffprobe | Convertir video/audio |
| `sox` | sox | Procesar audio |
| `lame` | lame | Codificar MP3 |

```bash
sudo apt install ffmpeg sox lame
```

#### Librerías Científicas (para numpy, scipy)
| Paquete | Qué incluye | Para qué sirve |
|---------|-------------|----------------|
| `libopenblas-dev` | librerías BLAS | Operaciones de álgebra lineal |
| `liblapack-dev` | librerías LAPACK | Álgebra lineal avanzada |
| `gfortran` | compilador Fortran | Necesario para scipy |

```bash
sudo apt install libopenblas-dev liblapack-dev gfortran
```

**✅ Instalación completa del Nivel 4:**
```bash
sudo apt install -y poppler-utils ghostscript qpdf \
    tesseract-ocr tesseract-ocr-eng tesseract-ocr-spa \
    pandoc \
    imagemagick graphicsmagick exiftool \
    ffmpeg sox lame \
    libopenblas-dev liblapack-dev gfortran
```

---

### 🔴 NIVEL 5: Monitoreo y Debugging

Herramientas para ver qué está pasando en el sistema.

#### Monitoreo del Sistema
| Paquete | Comando | Para qué sirve |
|---------|---------|----------------|
| `htop` | htop | Ver procesos (mejor que top) |
| `iotop` | iotop | Ver uso de disco por proceso |
| `iftop` | iftop | Ver uso de red en tiempo real |
| `nethogs` | nethogs | Ver qué programa usa internet |
| `ncdu` | ncdu | Ver espacio en disco (interactivo) |

```bash
sudo apt install htop iotop iftop nethogs ncdu
```

#### Análisis de Logs
| Paquete | Comando | Para qué sirve |
|---------|---------|----------------|
| `lnav` | lnav | Ver logs con colores |
| `multitail` | multitail | Ver varios logs a la vez |

```bash
sudo apt install lnav multitail
```

#### Red Avanzada
| Paquete | Comandos | Para qué sirve |
|---------|----------|----------------|
| `net-tools` | ifconfig, netstat | Ver configuración de red (antiguo) |
| `dnsutils` | dig, nslookup | Consultar DNS |
| `traceroute` | traceroute | Ver ruta a un servidor |
| `nmap` | nmap | Escanear puertos |
| `netcat` | nc | Enviar/recibir datos por red |

```bash
sudo apt install net-tools dnsutils traceroute nmap netcat
```

#### Testing de APIs
| Paquete | Comando | Para qué sirve |
|---------|---------|----------------|
| `httpie` | http | Cliente HTTP amigable |
| `jq` | jq | Procesar JSON en terminal |
| `curl` | curl | Cliente HTTP (ya instalado) |

```bash
sudo apt install httpie jq
```

#### Debugging de Programas
| Paquete | Comando | Para qué sirve |
|---------|---------|----------------|
| `strace` | strace | Ver qué hace un programa |
| `ltrace` | ltrace | Ver llamadas a librerías |

```bash
sudo apt install strace ltrace
```

**✅ Instalación completa del Nivel 5:**
```bash
sudo apt install -y htop iotop iftop nethogs ncdu \
    lnav multitail \
    net-tools dnsutils traceroute nmap netcat \
    httpie jq \
    strace ltrace
```

---

### 🟤 NIVEL 6: Seguridad (Producción)

Para cuando tu agente vaya a producción.

#### SSL/TLS (Certificados HTTPS)
| Paquete | Comando | Para qué sirve |
|---------|---------|----------------|
| `certbot` | certbot | Obtener certificados SSL gratis |
| `openssl` | openssl | Herramientas SSL/TLS |

```bash
sudo apt install certbot openssl
```

#### Firewall
| Paquete | Comando | Para qué sirve |
|---------|---------|----------------|
| `ufw` | ufw | Firewall simple |
| `fail2ban` | fail2ban | Bloquear ataques automáticamente |

```bash
sudo apt install ufw fail2ban
```

#### Encriptación
| Paquete | Comando | Para qué sirve |
|---------|---------|----------------|
| `gnupg` | gpg | Encriptar archivos y mensajes |

```bash
sudo apt install gnupg
```

**✅ Instalación completa del Nivel 6:**
```bash
sudo apt install -y certbot openssl ufw fail2ban gnupg
```

---

## PARTE 2: COMANDOS ESENCIALES

Esta sección explica los comandos más importantes para gestionar paquetes en Linux.

### 📦 Comandos APT (Gestor de Paquetes)

APT es el comando principal para instalar, actualizar y eliminar programas en Ubuntu/Debian.

| Comando | Para qué sirve | Ejemplo |
|---------|----------------|---------|
| `sudo apt update` | Actualizar lista de paquetes disponibles | `sudo apt update` |
| `sudo apt upgrade` | Actualizar todos los paquetes instalados | `sudo apt upgrade` |
| `sudo apt install <paquete>` | Instalar un paquete | `sudo apt install git` |
| `sudo apt install -y <paquete>` | Instalar sin pedir confirmación | `sudo apt install -y python3-pip` |
| `sudo apt remove <paquete>` | Desinstalar un paquete | `sudo apt remove nginx` |
| `sudo apt purge <paquete>` | Desinstalar + eliminar configuración | `sudo apt purge postgresql` |
| `sudo apt autoremove` | Eliminar paquetes que ya no se necesitan | `sudo apt autoremove` |
| `sudo apt search <término>` | Buscar paquetes | `sudo apt search redis` |
| `apt show <paquete>` | Ver información de un paquete | `apt show docker.io` |
| `apt list --installed` | Ver todos los paquetes instalados | `apt list --installed` |
| `apt list --installed \| grep <nombre>` | Buscar un paquete instalado | `apt list --installed \| grep python` |

**Ejemplo práctico:**
```bash
# 1. Actualizar lista de paquetes
sudo apt update

# 2. Instalar varios paquetes a la vez
sudo apt install -y git curl vim

# 3. Ver si está instalado
apt list --installed | grep git

# 4. Desinstalar
sudo apt remove git
```

---

### 🔍 Comandos DPKG (Bajo Nivel)

DPKG es el gestor de paquetes de bajo nivel. APT lo usa internamente.

| Comando | Para qué sirve | Ejemplo |
|---------|----------------|---------|
| `dpkg -l` | Listar todos los paquetes instalados | `dpkg -l` |
| `dpkg -l \| grep <nombre>` | Buscar un paquete específico | `dpkg -l \| grep python` |
| `dpkg -L <paquete>` | Ver archivos instalados por un paquete | `dpkg -L python3` |
| `dpkg -S <archivo>` | Saber qué paquete instaló un archivo | `dpkg -S /usr/bin/python3` |
| `dpkg -s <paquete>` | Ver información de un paquete | `dpkg -s git` |

**Ejemplo práctico:**
```bash
# ¿Qué archivos instaló Python3?
dpkg -L python3

# ¿De qué paquete viene el comando 'ls'?
dpkg -S /bin/ls

# Ver todos los paquetes instalados
dpkg -l | less
```

---

### 🐍 Comandos PIP (Paquetes de Python)

PIP instala librerías de Python (como langchain, openai, pandas, etc.).

#### ⚠️ Aclaración Importante: ¿Qué es un "paquete" en Python?

**Hay 2 conceptos diferentes de "paquete":**

**1. Paquete de Sistema Linux (apt/dpkg):**
- Son programas completos (git, nginx, postgresql)
- Se instalan con `apt install`
- Van a `/usr/bin`, `/usr/lib`, etc.

**2. Paquete/Módulo de Python (pip):**
- Son librerías de Python (langchain, openai, pandas)
- Se instalan con `pip install`
- Van a `/usr/lib/python3.12/` o `.venv/lib/python3.12/`

**En Python hay 2 tipos:**

| Tipo | Qué es | En el disco | Ejemplo de uso |
|------|--------|-------------|----------------|
| **Módulo** | Un archivo `.py` | `math.py` | `import math` |
| **Paquete** | Una carpeta con `__init__.py` | `langchain/` con `__init__.py` | `import langchain` |

**Ejemplo visual:**

```
/usr/lib/python3.12/
├── math.py                    ← MÓDULO (un archivo)
├── json/                      ← PAQUETE (carpeta)
│   ├── __init__.py           ← Archivo especial que hace esto un paquete
│   ├── decoder.py
│   └── encoder.py
├── os.py                      ← MÓDULO
└── email/                     ← PAQUETE
    ├── __init__.py
    ├── message.py
    └── parser.py
```

**¿Por qué algunos son archivos .py y otros carpetas?**

- **Módulos simples** (como `math`, `os`, `sys`): Un solo archivo `.py` es suficiente
- **Paquetes complejos** (como `langchain`, `django`, `pandas`): Necesitan muchos archivos organizados en carpetas

**Ejemplo práctico:**

```bash
# Ver módulos y paquetes de Python
ls /usr/lib/python3.12/

# Ver un módulo (archivo)
ls -lh /usr/lib/python3.12/math.py

# Ver un paquete (carpeta)
ls /usr/lib/python3.12/json/
# Salida:
# __init__.py  decoder.py  encoder.py  scanner.py  tool.py
```

**En tu entorno virtual (.venv):**

```bash
# Después de: pip install langchain
ls .venv/lib/python3.12/site-packages/

# Verás carpetas (paquetes):
langchain/           ← PAQUETE (carpeta con __init__.py)
openai/              ← PAQUETE
requests/            ← PAQUETE

# Y algunos archivos (módulos):
six.py               ← MÓDULO
typing_extensions.py ← MÓDULO
```

**¿Cómo saber si algo es módulo o paquete?**

```bash
# Si es un archivo .py → MÓDULO
file /usr/lib/python3.12/math.py
# Salida: Python script

# Si es una carpeta con __init__.py → PAQUETE
ls /usr/lib/python3.12/json/__init__.py
# Salida: /usr/lib/python3.12/json/__init__.py (existe)
```

**En código Python, se usan igual:**

```python
# Importar módulo (archivo)
import math
print(math.pi)

# Importar paquete (carpeta)
import json
data = json.loads('{"key": "value"}')

# Importar sub-módulo de un paquete
from json import decoder

# Importar paquete instalado con pip
import langchain
from langchain.llms import OpenAI
```

**Resumen:**
- ✅ **Módulo** = archivo `.py` individual
- ✅ **Paquete** = carpeta con `__init__.py` + otros archivos
- ✅ Ambos se llaman "paquetes" cuando hablas de `pip install`
- ✅ En `/usr/lib/python3.12/` ves ambos mezclados

---

| Comando | Para qué sirve | Ejemplo |
|---------|----------------|---------|
| `pip3 list` | Ver paquetes Python instalados | `pip3 list` |
| `pip3 install <paquete>` | Instalar un paquete | `pip3 install langchain` |
| `pip3 install -r requirements.txt` | Instalar desde archivo | `pip3 install -r requirements.txt` |
| `pip3 uninstall <paquete>` | Desinstalar un paquete | `pip3 uninstall langchain` |
| `pip3 show <paquete>` | Ver información de un paquete | `pip3 show openai` |
| `pip3 freeze` | Listar paquetes con versiones | `pip3 freeze` |
| `pip3 freeze > requirements.txt` | Guardar lista de paquetes | `pip3 freeze > requirements.txt` |
| `pip3 search <término>` | Buscar paquetes (deprecado) | Use https://pypi.org |
| `python3 -m pip install <paquete>` | **MEJOR PRÁCTICA** | `python3 -m pip install langchain` |

**⚠️ Siempre usa `python3 -m pip` en lugar de solo `pip3`:**
```bash
# ❌ NO usar
pip3 install langchain

# ✅ USAR (garantiza el Python correcto)
python3 -m pip install langchain
```

**Ejemplo práctico con venv:**
```bash
# 1. Crear entorno virtual
python3 -m venv .venv

# 2. Activar entorno
source .venv/bin/activate

# 3. Instalar paquetes
python3 -m pip install langchain openai chromadb

# 4. Guardar lista
python3 -m pip freeze > requirements.txt

# 5. Ver qué está instalado
python3 -m pip list

# 6. Desactivar entorno
deactivate
```

---

### 🛠️ Comandos de Sistema Útiles

| Comando | Para qué sirve | Ejemplo |
|---------|----------------|---------|
| `which <comando>` | Ver dónde está un comando | `which python3` |
| `command -v <comando>` | Ver si existe un comando | `command -v docker` |
| `whereis <comando>` | Buscar binarios y manuales | `whereis python3` |
| `type <comando>` | Ver tipo de comando | `type cd` |
| `ls -la /usr/bin \| grep python` | Ver versiones de Python | `ls -la /usr/bin \| grep python` |

**Ejemplo práctico:**
```bash
# ¿Dónde está Python?
which python3
# Salida: /usr/bin/python3

# ¿Está instalado Docker?
command -v docker
# Si no sale nada, no está instalado

# Ver todas las versiones de Python
ls -la /usr/bin/python*
```

---

### 🐳 Comandos Docker Básicos

| Comando | Para qué sirve | Ejemplo |
|---------|----------------|---------|
| `docker --version` | Ver versión de Docker | `docker --version` |
| `docker ps` | Ver contenedores corriendo | `docker ps` |
| `docker ps -a` | Ver todos los contenedores | `docker ps -a` |
| `docker images` | Ver imágenes descargadas | `docker images` |
| `docker pull <imagen>` | Descargar imagen | `docker pull postgres` |
| `docker run <imagen>` | Ejecutar contenedor | `docker run hello-world` |
| `docker stop <id>` | Detener contenedor | `docker stop abc123` |
| `docker rm <id>` | Eliminar contenedor | `docker rm abc123` |
| `docker rmi <imagen>` | Eliminar imagen | `docker rmi postgres` |

---

### 🔧 Comandos de Servicios (systemctl)

| Comando | Para qué sirve | Ejemplo |
|---------|----------------|---------|
| `sudo systemctl start <servicio>` | Iniciar servicio | `sudo systemctl start postgresql` |
| `sudo systemctl stop <servicio>` | Detener servicio | `sudo systemctl stop nginx` |
| `sudo systemctl restart <servicio>` | Reiniciar servicio | `sudo systemctl restart redis-server` |
| `sudo systemctl status <servicio>` | Ver estado de servicio | `sudo systemctl status docker` |
| `sudo systemctl enable <servicio>` | Iniciar automático al arrancar | `sudo systemctl enable postgresql` |
| `sudo systemctl disable <servicio>` | No iniciar al arrancar | `sudo systemctl disable nginx` |

**Ejemplo práctico:**
```bash
# Ver si PostgreSQL está corriendo
sudo systemctl status postgresql

# Iniciar Redis
sudo systemctl start redis-server

# Hacer que Nginx arranque automáticamente
sudo systemctl enable nginx
```

---

## PARTE 3: SCRIPTS DE AUTOMATIZACIÓN (SIMPLIFICADOS)

Esta sección explica cómo crear scripts para automatizar la instalación.

### 🎯 ¿Qué vamos a automatizar?

En lugar de escribir muchos comandos manualmente:
```bash
sudo apt update
sudo apt install git
sudo apt install python3
sudo apt install python3-pip
sudo apt install python3-venv
# ... etc (30+ comandos)
```

Creamos un script que haga todo automáticamente:
```bash
./instalar_todo.sh
```

---

### 📝 Script 1: Instalación Básica (Nivel 2)

Vamos a crear un script simple que instale lo esencial para desarrollo.

**Crear archivo:** `instalar_basico.sh`

```bash
#!/bin/bash

# Este script instala herramientas básicas de desarrollo

echo "=== Instalando herramientas de desarrollo ==="

# 1. Actualizar lista de paquetes
echo "Paso 1: Actualizando lista de paquetes..."
sudo apt update

# 2. Instalar herramientas de compilación
echo "Paso 2: Instalando compiladores..."
sudo apt install -y build-essential cmake

# 3. Instalar Git
echo "Paso 3: Instalando Git..."
sudo apt install -y git

# 4. Instalar Python
echo "Paso 4: Instalando Python..."
sudo apt install -y python3 python3-pip python3-venv python3-dev

# 5. Instalar herramientas de red
echo "Paso 5: Instalando herramientas de red..."
sudo apt install -y curl wget

# 6. Instalar editor y terminal
echo "Paso 6: Instalando vim y tmux..."
sudo apt install -y vim tmux

# 7. Instalar utilidades
echo "Paso 7: Instalando utilidades..."
sudo apt install -y tree htop zip unzip

echo ""
echo "✅ ¡Instalación completada!"
echo ""
echo "Verifica las instalaciones:"
echo "  python3 --version"
echo "  pip3 --version"
echo "  git --version"
```

**Cómo usar:**
```bash
# 1. Crear el archivo
nano instalar_basico.sh

# 2. Pegar el contenido de arriba

# 3. Guardar (Ctrl+O, Enter, Ctrl+X)

# 4. Dar permisos de ejecución
chmod +x instalar_basico.sh

# 5. Ejecutar
./instalar_basico.sh
```

**Explicación línea por línea:**

- `#!/bin/bash` → Dice que es un script de bash
- `echo "texto"` → Imprime texto en pantalla
- `sudo apt update` → Actualiza lista de paquetes
- `sudo apt install -y` → Instala sin pedir confirmación
- `\` al final de línea → Continúa en la siguiente línea

---

### 📝 Script 2: Instalación de Bases de Datos (Nivel 3)

**Crear archivo:** `instalar_bases_datos.sh`

```bash
#!/bin/bash

echo "=== Instalando bases de datos ==="

# 1. SQLite (base de datos simple)
echo "Instalando SQLite..."
sudo apt install -y sqlite3

# 2. PostgreSQL (base de datos profesional)
echo "Instalando PostgreSQL..."
sudo apt install -y postgresql postgresql-client libpq-dev

# 3. Redis (caché rápida)
echo "Instalando Redis..."
sudo apt install -y redis-server redis-tools

echo ""
echo "✅ Bases de datos instaladas!"
echo ""
echo "Verifica:"
echo "  sqlite3 --version"
echo "  psql --version"
echo "  redis-cli --version"
echo ""
echo "Inicia servicios:"
echo "  sudo systemctl start postgresql"
echo "  sudo systemctl start redis-server"
```

---

### 📝 Script 3: Verificar Instalación

**Crear archivo:** `verificar.sh`

```bash
#!/bin/bash

echo "=== Verificando instalación ==="
echo ""

# Función para verificar si un comando existe
verificar() {
    if command -v $1 &> /dev/null
    then
        echo "✅ $1 instalado"
    else
        echo "❌ $1 NO instalado"
    fi
}

# Verificar comandos importantes
verificar python3
verificar pip3
verificar git
verificar gcc
verificar curl
verificar vim
verificar tmux
verificar docker
verificar psql
verificar redis-cli

echo ""
echo "=== Versiones ==="
python3 --version
pip3 --version
git --version
```

**Uso:**
```bash
chmod +x verificar.sh
./verificar.sh
```

---

### 📝 Script 4: Desinstalar Todo

**Crear archivo:** `desinstalar_todo.sh`

```bash
#!/bin/bash

echo "⚠️  ADVERTENCIA: Esto eliminará todos los paquetes instalados"
echo ""
read -p "¿Estás seguro? Escribe SI en mayúsculas: " confirmacion

if [ "$confirmacion" != "SI" ]; then
    echo "Operación cancelada"
    exit 0
fi

echo ""
echo "=== Desinstalando paquetes ==="

# Desinstalar bases de datos
echo "Eliminando bases de datos..."
sudo apt purge -y postgresql redis-server sqlite3

# Desinstalar herramientas de desarrollo
echo "Eliminando herramientas de desarrollo..."
sudo apt purge -y build-essential git python3-pip python3-venv

# Limpiar paquetes huérfanos
echo "Limpiando paquetes no necesarios..."
sudo apt autoremove -y
sudo apt autoclean

echo ""
echo "✅ Desinstalación completada"
```

**Explicación del script:**

- `read -p` → Pide confirmación al usuario
- `if [ "$confirmacion" != "SI" ]` → Verifica la respuesta
- `exit 0` → Sale del script
- `apt purge` → Desinstala y elimina configuración
- `apt autoremove` → Limpia paquetes no usados

---

### 🎓 Conceptos de Bash que Debes Entender

#### 1. Variables
```bash
# Crear variable
nombre="Juan"

# Usar variable (con $)
echo "Hola $nombre"
```

#### 2. Condicionales
```bash
# Si existe un comando
if command -v python3 &> /dev/null
then
    echo "Python está instalado"
else
    echo "Python NO está instalado"
fi
```

#### 3. Funciones
```bash
# Definir función
saludar() {
    echo "Hola $1"
}

# Llamar función
saludar "María"  # Imprime: Hola María
```

#### 4. Redireccionamiento
```bash
# > guarda output en archivo (sobrescribe)
echo "Hola" > archivo.txt

# >> agrega al final del archivo
echo "Mundo" >> archivo.txt

# 2>&1 redirige errores al mismo lugar
comando 2>&1 | tee log.txt
```

---

### 📋 Ejercicio Práctico para Estudiantes

Crea un script llamado `mi_setup.sh` que:

1. Actualice el sistema
2. Instale Git, Python3, pip y venv
3. Configure Git con tu nombre y email
4. Cree un entorno virtual de prueba
5. Instale langchain en ese entorno

**Solución:**
```bash
#!/bin/bash

echo "=== Mi Setup Personal ==="

# 1. Actualizar
sudo apt update

# 2. Instalar herramientas
sudo apt install -y git python3 python3-pip python3-venv

# 3. Configurar Git
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"

# 4. Crear entorno virtual
cd ~
mkdir -p proyectos/test-agent
cd proyectos/test-agent
python3 -m venv .venv

# 5. Activar y instalar langchain
source .venv/bin/activate
python3 -m pip install langchain openai

echo ""
echo "✅ Setup completado!"
echo ""
echo "Para activar el entorno:"
echo "  cd ~/proyectos/test-agent"
echo "  source .venv/bin/activate"
```

---

## RESUMEN RÁPIDO

### Para instalar todo de una vez:

```bash
# Nivel 2: Desarrollo básico
sudo apt update
sudo apt install -y build-essential git python3 python3-pip python3-venv \
    python3-dev curl wget vim tmux tree htop

# Nivel 3: Bases de datos y Docker
sudo apt install -y sqlite3 postgresql redis-server docker.io

# Nivel 4: Procesamiento de documentos
sudo apt install -y poppler-utils tesseract-ocr imagemagick ffmpeg pandoc

# Nivel 5: Monitoreo
sudo apt install -y htop iotop iftop jq httpie
```

### Para verificar:
```bash
python3 --version
pip3 --version
git --version
docker --version
```

### Para crear un proyecto:
```bash
mkdir mi-proyecto
cd mi-proyecto
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install langchain openai
```

---

## 📚 Próximos Pasos

1. **Practica** creando y ejecutando los scripts básicos
2. **Modifica** los scripts para agregar tus propios paquetes
3. **Entiende** cada comando antes de usarlo
4. **Experimenta** en una máquina virtual antes de tu sistema principal
