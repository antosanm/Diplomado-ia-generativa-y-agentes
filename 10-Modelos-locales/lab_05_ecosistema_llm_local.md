# Lab 05: Ecosistema de Modelos de Lenguaje Locales

## Objetivo

Explorar y entender las **capas** y **patrones** de arquitectura para ejecutar modelos de lenguaje localmente. Al final podrás:

- Identificar tu hardware y sus capacidades
- Entender qué hace cada capa del stack
- Elegir la configuración correcta para tu máquina
- Instalar y probar diferentes opciones

---

## PARTE 1: Las Capas del Stack

```
┌─────────────────────────────────────────────────────────────┐
│  CAPA 4: CLIENTE                                            │
│  Tu código que consume el modelo                            │
│  → Python, curl, LangChain                                  │
├─────────────────────────────────────────────────────────────┤
│  CAPA 3: SERVIDOR API                                       │
│  Expone el modelo via HTTP                                  │
│  → Ollama, LM Studio, vLLM server                           │
├─────────────────────────────────────────────────────────────┤
│  CAPA 2: MOTOR DE INFERENCIA                                │
│  Ejecuta el modelo, genera tokens                           │
│  → llama.cpp, vLLM, transformers                            │
├─────────────────────────────────────────────────────────────┤
│  CAPA 1: ARCHIVOS DEL MODELO                                │
│  Los pesos del modelo en disco                              │
│  → .gguf, .safetensors                                      │
├─────────────────────────────────────────────────────────────┤
│  CAPA 0: HARDWARE                                           │
│  Donde se ejecutan los cálculos                             │
│  → CPU, GPU, RAM                                            │
└─────────────────────────────────────────────────────────────┘
```

**Punto clave:** Las capas superiores dependen de las inferiores. No puedes usar LangChain (Capa 4) sin un servidor (Capa 3), y el servidor necesita un motor (Capa 2), que necesita un modelo (Capa 1) y hardware (Capa 0).

---

## PARTE 2: Capa 0 - Hardware

### 2.1 Identificar tu hardware

Antes de instalar cualquier cosa, necesitas saber qué tienes.

**Ver todas las GPUs disponibles:**
```sh
lspci | grep -i "vga\|3d\|display"
```

**Detectar GPU específica según fabricante:**

| GPU | Comando | Instalar si no existe |
|-----|---------|----------------------|
| NVIDIA | `nvidia-smi` | `sudo apt install nvidia-utils-535` |
| AMD | `lspci \| grep -i amd` | (viene con el sistema) |
| Intel integrada | `lspci \| grep -i intel` | (viene con el sistema) |

```sh
# NVIDIA - información detallada
nvidia-smi

# Si no tienes nvidia-smi instalado:
sudo apt update
sudo apt install nvidia-utils-535  # o la versión de tu driver

# AMD - verificar si tienes GPU AMD
lspci | grep -i "vga\|display" | grep -i amd

# Intel integrada
lspci | grep -i "vga\|display" | grep -i intel
```

**Ver RAM disponible:**
```sh
free -h
```

**Ver CPU:**
```sh
lscpu | grep "Model name\|CPU(s):"
```

### 2.2 ¿Qué recursos necesito?

Los modelos usan **RAM** (memoria del sistema) y/o **VRAM** (memoria de la GPU).

**Escenarios de uso de recursos:**

| Escenario | CPU | GPU VRAM | RAM Sistema | Velocidad |
|-----------|-----|----------|-------------|-----------|
| **Solo CPU** | 100% | 0 GB | 8-64 GB | Lenta (5-15 tok/s) |
| **Solo GPU** | Mínimo | Todo el modelo | Mínima | Rápida (40-100 tok/s) |
| **Mixto (offload)** | Parcial | Parte del modelo | Resto del modelo | Media (15-40 tok/s) |

**¿Cuándo usar cada escenario?**

- **Solo CPU:** No tienes GPU, o tu GPU no es compatible
- **Solo GPU:** El modelo cabe completo en la VRAM de tu GPU
- **Mixto:** El modelo NO cabe en VRAM, entonces parte va a RAM del sistema

**Requisitos según tamaño del modelo (formato GGUF Q4):**

| Modelo | Parámetros | Solo CPU (RAM) | Solo GPU (VRAM) | Mixto |
|--------|------------|----------------|-----------------|-------|
| TinyLlama | 1B | 2 GB | 2 GB | N/A |
| Llama 3.2 | 3B | 4 GB | 4 GB | 2GB VRAM + 2GB RAM |
| Llama 3.1 | 8B | 6 GB | 6 GB | 4GB VRAM + 4GB RAM |
| Llama 3.1 | 70B | 40 GB | 40 GB | 8GB VRAM + 35GB RAM |

### 2.3 ¿Quién decide usar CPU, GPU o mixto?

**El motor de inferencia (Capa 2) decide**, pero tú puedes configurarlo.

| Capa | ¿Controla recursos? | ¿Cómo? |
|------|---------------------|--------|
| Capa 0 (Hardware) | Es el recurso | - |
| Capa 1 (Modelo) | No | - |
| **Capa 2 (Motor)** | **SÍ** | Flags de configuración |
| Capa 3 (Servidor) | Pasa config al motor | Variables de entorno |
| Capa 4 (Cliente) | NO | Solo consume la API |

**Ejemplo de control en Capa 2 (llama.cpp):**
```sh
# Solo CPU (0 capas en GPU)
./llama-cli -m model.gguf --n-gpu-layers 0

# GPU parcial (20 capas en GPU, resto en CPU)
./llama-cli -m model.gguf --n-gpu-layers 20

# GPU completa (todas las capas posibles en GPU)
./llama-cli -m model.gguf --n-gpu-layers 999
```

**Ejemplo de control en Capa 3 (Ollama):**
```sh
# Ollama decide automáticamente, pero puedes forzar:
OLLAMA_NUM_GPU=0 ollama run llama3.2      # Forzar solo CPU
OLLAMA_NUM_GPU=999 ollama run llama3.2    # Forzar máximo GPU
```

---

## PARTE 3: Capa 1 - Archivos del Modelo

### 3.1 Formatos de modelo

| Formato | Extensión | Uso | Compatibilidad |
|---------|-----------|-----|----------------|
| **GGUF** | `.gguf` | Inferencia local | llama.cpp, Ollama |
| **SafeTensors** | `.safetensors` | HuggingFace | transformers, vLLM |
| **PyTorch** | `.bin`, `.pth` | Entrenamiento | PyTorch |

**Para uso local, GGUF es el formato más común** porque está optimizado para llama.cpp (que usan Ollama y LM Studio).

### 3.2 Cuantización

Los modelos se comprimen para usar menos memoria. Esto se llama **cuantización**.

| Nivel | Nombre común | % del original | Calidad |
|-------|--------------|----------------|---------|
| Full | FP16 | 100% | 100% |
| Alta | Q8_0 | ~50% | ~99% |
| **Media** | **Q4_K_M** | **~25%** | **~95%** |
| Baja | Q2_K | ~15% | ~85% |

**Q4_K_M es el balance recomendado** entre tamaño y calidad.

### 3.3 Dónde conseguir modelos

```sh
# Opción 1: Ollama (más fácil)
ollama pull llama3.2

# Opción 2: HuggingFace (más opciones)
# Instalar herramienta
pip install huggingface_hub

# Descargar modelo específico
huggingface-cli download TheBloke/Llama-2-7B-GGUF llama-2-7b.Q4_K_M.gguf
```

**Modelos recomendados para empezar:**

| Modelo | Tamaño | Comando Ollama |
|--------|--------|----------------|
| TinyLlama | 1B (pequeño, rápido) | `ollama pull tinyllama` |
| Llama 3.2 | 3B (balance) | `ollama pull llama3.2` |
| Mistral | 7B (buena calidad) | `ollama pull mistral` |

---

## PARTE 4: Capa 2 - Motor de Inferencia

### 4.1 ¿Qué es un motor de inferencia?

Es el software que:
1. **Carga** el modelo en memoria (RAM o VRAM)
2. **Procesa** tu texto de entrada (tokenización)
3. **Genera** tokens de salida uno por uno
4. **Devuelve** el texto generado

### 4.2 Motores principales

| Motor | Lenguaje | GPU requerida | Ideal para |
|-------|----------|---------------|------------|
| **llama.cpp** | C++ | No (opcional) | Local, eficiente |
| **vLLM** | Python | Sí (NVIDIA) | Producción, alto tráfico |
| **transformers** | Python | No (opcional) | Experimentación, flexibilidad |

### 4.3 ¿Por qué llama.cpp tiene diferentes compilaciones?

**llama.cpp es código fuente que debes COMPILAR.** La compilación genera un ejecutable optimizado para TU hardware específico.

```
┌─────────────────────────────────────┐
│  Código fuente llama.cpp            │
└───────────────┬─────────────────────┘
                │
        ┌───────┴───────┐
        │    make       │  ← Comando de compilación
        └───────┬───────┘
                │
    ┌───────────┼───────────┬───────────┐
    ▼           ▼           ▼           ▼
 Sin flag   GGML_CUDA=1  GGML_HIP=1  GGML_METAL=1
    │           │           │           │
    ▼           ▼           ▼           ▼
 Solo CPU   NVIDIA GPU   AMD GPU    Apple GPU
```

**No son "varias instalaciones", es UNA compilación con diferentes opciones.**

### 4.4 Instalación de llama.cpp según tu hardware

#### Prerequisitos comunes (todos los casos):
```sh
sudo apt update
sudo apt install build-essential git cmake
```

#### Solo CPU (funciona en cualquier Linux):
```sh
git clone https://github.com/ggerganov/llama.cpp
cd llama.cpp
make
```

#### NVIDIA GPU:
```sh
# 1. Instalar drivers NVIDIA (si no los tienes)
sudo apt install nvidia-driver-535

# 2. Instalar CUDA toolkit
sudo apt install nvidia-cuda-toolkit

# 3. Verificar instalación
nvcc --version
nvidia-smi

# 4. Compilar llama.cpp con soporte CUDA
git clone https://github.com/ggerganov/llama.cpp
cd llama.cpp
make GGML_CUDA=1
```

#### AMD GPU (ROCm):

⚠️ **ROCm es complejo y solo soporta GPUs específicas.** Verifica compatibilidad primero: https://rocm.docs.amd.com/en/latest/release/gpu_os_support.html

```sh
# 1. Verificar si tu GPU es compatible (RX 6000/7000 series, MI series)
lspci | grep -i amd

# 2. Instalar ROCm (Ubuntu 22.04)
wget https://repo.radeon.com/amdgpu-install/latest/ubuntu/jammy/amdgpu-install_6.0.60000-1_all.deb
sudo dpkg -i amdgpu-install_6.0.60000-1_all.deb
sudo amdgpu-install --usecase=rocm

# 3. Agregar usuario a grupos necesarios
sudo usermod -aG video $USER
sudo usermod -aG render $USER

# 4. Reiniciar y verificar
sudo reboot
rocm-smi

# 5. Compilar llama.cpp con soporte ROCm
git clone https://github.com/ggerganov/llama.cpp
cd llama.cpp
make GGML_HIPBLAS=1
```

**Recomendación para AMD:** Si ROCm no funciona o tu GPU no es compatible, usa **solo CPU** o considera **Ollama** que intenta detectar automáticamente.

### 4.5 Probar llama.cpp directamente

```sh
# Descargar un modelo pequeño para probar
cd llama.cpp
wget https://huggingface.co/TheBloke/TinyLlama-1.1B-Chat-v1.0-GGUF/resolve/main/tinyllama-1.1b-chat-v1.0.Q4_K_M.gguf

# Ejecutar (modo interactivo)
./llama-cli -m tinyllama-1.1b-chat-v1.0.Q4_K_M.gguf -p "Hello!" -n 50

# Ejecutar como servidor (para usar desde API)
./llama-server -m tinyllama-1.1b-chat-v1.0.Q4_K_M.gguf --port 8080
```

### 4.6 Otros motores

#### vLLM (requiere NVIDIA GPU):
```sh
# Instalar
pip install vllm

# Usar desde Python (sin servidor)
python -c "
from vllm import LLM, SamplingParams
llm = LLM(model='TinyLlama/TinyLlama-1.1B-Chat-v1.0')
output = llm.generate(['Hello!'], SamplingParams(max_tokens=50))
print(output[0].outputs[0].text)
"

# O iniciar como servidor
python -m vllm.entrypoints.openai.api_server \
    --model TinyLlama/TinyLlama-1.1B-Chat-v1.0 \
    --port 8000
```

**Nota:** vLLM NO tiene CLI interactivo como Ollama. Solo servidor o uso desde Python.

#### transformers (CPU o GPU):
```sh
# Instalar (CPU)
pip install transformers torch

# Instalar (NVIDIA GPU)
pip install transformers torch --index-url https://download.pytorch.org/whl/cu118

# Usar
python -c "
from transformers import pipeline
generator = pipeline('text-generation', model='TinyLlama/TinyLlama-1.1B-Chat-v1.0')
print(generator('Hello!', max_new_tokens=50)[0]['generated_text'])
"
```

---

## PARTE 5: Capa 3 - Servidor API

### 5.1 ¿Qué hace el servidor API?

Envuelve el motor de inferencia con una **interfaz HTTP estándar**, permitiendo:
- Recibir peticiones via HTTP
- Manejar múltiples clientes
- Exponer API compatible con OpenAI

### 5.2 ¿El servidor incluye el motor?

Esta es una pregunta común. **Depende del servidor:**

| Servidor | ¿Incluye motor? | Motor interno | ¿Instalar motor aparte? |
|----------|-----------------|---------------|------------------------|
| **Ollama** | ✅ Sí | llama.cpp | NO necesitas |
| **LM Studio** | ✅ Sí | llama.cpp | NO necesitas |
| **vLLM server** | ✅ Sí | vLLM es el motor | NO necesitas |
| **LocalAI** | ✅ Sí | Varios backends | NO necesitas |
| **Tu FastAPI** | ❌ No | - | SÍ necesitas |

**Diagrama:**

```
OLLAMA (todo incluido):           TU SERVIDOR (debes armar):
┌────────────────────────┐        ┌────────────────────────┐
│  Ollama                │        │  Tu FastAPI            │
│  ├── API Server        │        │  └── Llama a:          │
│  ├── llama.cpp ←(incluido)      │      ├── Ollama        │
│  └── Gestión modelos   │        │      ├── llama-cpp-python
└────────────────────────┘        │      └── transformers  │
                                  └────────────────────────┘
```

### 5.3 Instalación de servidores según tu hardware

#### Ollama (recomendado para empezar):

Funciona en: **CPU, NVIDIA GPU, AMD GPU (limitado), Mac M1/M2/M3**

```sh
# Instalar
curl -fsSL https://ollama.ai/install.sh | sh

# Verificar
ollama --version

# Descargar modelo
ollama pull tinyllama

# Probar interactivo
ollama run tinyllama

# Ver que el servidor está corriendo
curl http://localhost:11434/api/tags
```

**Control de GPU en Ollama:**
```sh
# Automático (Ollama decide)
ollama run llama3.2

# Forzar solo CPU
OLLAMA_NUM_GPU=0 ollama run llama3.2

# Forzar máximo GPU
OLLAMA_NUM_GPU=999 ollama run llama3.2
```

#### LM Studio (alternativa con GUI):

Funciona en: **CPU, NVIDIA GPU, Mac M1/M2/M3**

```sh
# Descargar de https://lmstudio.ai
# Es una aplicación de escritorio con interfaz gráfica

# Para usar el servidor:
# 1. Abrir LM Studio
# 2. Descargar un modelo desde la app
# 3. Ir a pestaña "Local Server"
# 4. Click "Start Server"

# Probar
curl http://localhost:1234/v1/models
```

#### vLLM Server (producción):

Funciona en: **Solo NVIDIA GPU**

```sh
# Instalar
pip install vllm

# Iniciar servidor
python -m vllm.entrypoints.openai.api_server \
    --model TinyLlama/TinyLlama-1.1B-Chat-v1.0 \
    --port 8000

# Probar
curl http://localhost:8000/v1/models
```

### 5.4 Tabla resumen: ¿Qué instalar según tu máquina?

| Tu hardware | Servidor recomendado | Instalación |
|-------------|---------------------|-------------|
| **Solo CPU** | Ollama | `curl -fsSL https://ollama.ai/install.sh \| sh` |
| **NVIDIA GPU** | Ollama o vLLM | Ollama: mismo comando. vLLM: `pip install vllm` |
| **AMD GPU** | Ollama (prueba) | Mismo comando, puede no usar GPU |
| **Mac M1/M2/M3** | Ollama o LM Studio | Ollama: `brew install ollama`. LM Studio: descargar app |

### 5.5 Comparación de endpoints

Todos estos servidores exponen APIs similares:

```sh
# Ollama
curl http://localhost:11434/api/generate -d '{"model":"tinyllama","prompt":"Hello"}'

# Ollama (endpoint compatible OpenAI)
curl http://localhost:11434/v1/chat/completions -d '{"model":"tinyllama","messages":[{"role":"user","content":"Hello"}]}'

# LM Studio
curl http://localhost:1234/v1/chat/completions -d '{"model":"local-model","messages":[{"role":"user","content":"Hello"}]}'

# vLLM
curl http://localhost:8000/v1/chat/completions -d '{"model":"TinyLlama/TinyLlama-1.1B-Chat-v1.0","messages":[{"role":"user","content":"Hello"}]}'
```

**Punto clave:** El endpoint `/v1/chat/completions` es compatible con OpenAI en todos. Esto significa que **el mismo código de cliente funciona con cualquier servidor**.

---

## PARTE 6: Capa 4 - Cliente

### 6.1 El cliente NO controla recursos

El cliente solo envía peticiones HTTP. No decide si usar CPU o GPU.

```
Cliente (Capa 4)           Servidor (Capa 3)         Motor (Capa 2)
      │                          │                        │
      │ "Dame respuesta"         │                        │
      ├─────────────────────────►│                        │
      │                          │ "Genera tokens"        │
      │                          ├───────────────────────►│
      │                          │                        │ (usa CPU/GPU)
      │                          │◄───────────────────────┤
      │◄─────────────────────────┤                        │
      │ "Aquí está"              │                        │
```

### 6.2 Opciones de cliente

| Método | Complejidad | Cuándo usar |
|--------|-------------|-------------|
| `curl` | Mínima | Pruebas rápidas |
| `requests` | Baja | Scripts Python simples |
| SDK OpenAI | Baja | Código portable (local ↔ cloud) |
| **LangChain** | Media | Agentes, chains, RAG |

### 6.3 Ejemplos de cliente

**Con curl:**
```sh
curl http://localhost:11434/api/generate \
    -d '{"model": "tinyllama", "prompt": "Hello", "stream": false}'
```

**Con Python requests:**
```python
import requests

response = requests.post(
    "http://localhost:11434/api/generate",
    json={"model": "tinyllama", "prompt": "Hello", "stream": False}
)
print(response.json()["response"])
```

**Con SDK OpenAI (funciona con cualquier servidor compatible):**
```python
from openai import OpenAI

# Cambiar base_url según el servidor
client = OpenAI(
    base_url="http://localhost:11434/v1",  # Ollama
    # base_url="http://localhost:1234/v1",   # LM Studio
    # base_url="http://localhost:8000/v1",   # vLLM
    api_key="not-needed"
)

response = client.chat.completions.create(
    model="tinyllama",
    messages=[{"role": "user", "content": "Hello"}]
)
print(response.choices[0].message.content)
```

**Con LangChain:**
```python
from langchain_ollama import ChatOllama

llm = ChatOllama(model="tinyllama")
response = llm.invoke("Hello")
print(response.content)
```

---

## PARTE 7: Los Patrones de Arquitectura

### Patrón A: Cloud Provider

```
Tu código ────► Internet ────► OpenAI/Anthropic/Google
                                      │
                                  Su modelo
```

- Necesitas API key
- Pagas por uso
- Mejores modelos
- No controlas datos

```python
from openai import OpenAI
client = OpenAI()  # Usa OPENAI_API_KEY
response = client.chat.completions.create(
    model="gpt-4",
    messages=[{"role": "user", "content": "Hello"}]
)
```

### Patrón B: Local Simple (Ollama)

```
Tu código ────► localhost:11434 ────► Ollama ────► Modelo
```

- Todo en tu máquina
- Gratis
- Funciona offline
- Ollama maneja todo

```sh
ollama pull tinyllama
ollama run tinyllama
```

### Patrón C: Servidor Personalizado

```
Tu código ────► Tu API (FastAPI) ────► Ollama ────► Modelo
                     │
                 Tu lógica
```

- Control total
- Puedes agregar autenticación, logging, etc.
- Para producción

```python
from fastapi import FastAPI
import requests

app = FastAPI()

@app.post("/chat")
def chat(prompt: str):
    response = requests.post(
        "http://localhost:11434/api/generate",
        json={"model": "tinyllama", "prompt": prompt, "stream": False}
    )
    return {"response": response.json()["response"]}
```

### Patrón D: Híbrido

```
Tu código ────► Router ────┬────► Local (tareas simples)
                          └────► Cloud (tareas complejas)
```

- Optimiza costo
- Fallback si uno falla

### Patrón E: Python Puro

```
Tu código ────► transformers ────► Modelo en RAM
```

- Sin servidor HTTP
- Modelo se carga cada ejecución (lento)
- Para scripts únicos

```python
from transformers import pipeline
generator = pipeline("text-generation", model="TinyLlama/TinyLlama-1.1B-Chat-v1.0")
print(generator("Hello", max_new_tokens=50))
```

---

## PARTE 8: Diagrama de Decisión

```
¿Qué hardware tienes?
         │
         ├── NVIDIA GPU
         │      │
         │      ├── ¿Producción con alto tráfico? ──► vLLM
         │      └── ¿Desarrollo/aprendizaje? ──► Ollama
         │
         ├── AMD GPU
         │      └── Ollama (puede o no usar la GPU)
         │         Si no funciona ──► Solo CPU
         │
         ├── Intel integrada
         │      └── Solo CPU ──► Ollama
         │
         ├── Mac M1/M2/M3
         │      └── Ollama o LM Studio (ambos usan Metal)
         │
         └── Solo CPU
                └── Ollama (será lento pero funciona)
```

---

## PARTE 9: Ejercicio Práctico

### Paso 1: Identificar tu hardware
```sh
# Ver CPU
lscpu | grep "Model name"

# Ver RAM
free -h

# Ver GPU
lspci | grep -i "vga\|3d\|display"

# Si tienes NVIDIA
nvidia-smi
```

### Paso 2: Instalar Ollama
```sh
curl -fsSL https://ollama.ai/install.sh | sh
```

### Paso 3: Descargar un modelo pequeño
```sh
ollama pull tinyllama
```

### Paso 4: Probar interactivamente
```sh
ollama run tinyllama
# Escribe "Hello" y presiona Enter
# Para salir: /bye
```

### Paso 5: Probar via API
```sh
curl http://localhost:11434/api/generate \
    -d '{"model": "tinyllama", "prompt": "What is Python?", "stream": false}'
```

### Paso 6: Probar endpoint compatible OpenAI
```sh
curl http://localhost:11434/v1/chat/completions \
    -H "Content-Type: application/json" \
    -d '{
        "model": "tinyllama",
        "messages": [{"role": "user", "content": "What is Python?"}]
    }'
```

---

## Resumen

| Concepto | Lo que aprendiste |
|----------|-------------------|
| **5 Capas** | Hardware → Modelo → Motor → Servidor → Cliente |
| **Recursos** | CPU vs GPU vs Mixto, quién decide |
| **Compilación** | llama.cpp se compila para tu hardware |
| **Servidor incluye motor** | Ollama sí, tu FastAPI no |
| **5 Patrones** | Cloud, Local, Custom, Híbrido, Python puro |
| **Portabilidad** | Endpoint `/v1/chat/completions` funciona igual en todos |

**Siguiente paso (Lab 06):** Conversaciones y formato de mensajes (roles: system, user, assistant).
