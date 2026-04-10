#!/bin/bash

# Script para configurar el ambiente Flutter en Linux
# Uso: chmod +x setup_flutter.sh && ./setup_flutter.sh

set -e

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║          🔧 Flutter Setup - Configuración Inicial              ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Colores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_step() { echo -e "${GREEN}✓${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }
print_warning() { echo -e "${YELLOW}!${NC} $1"; }
print_info() { echo -e "${BLUE}ℹ${NC} $1"; }

# 1. Verificar sistema
echo "1️⃣  Verificando sistema operativo..."
if [[ "$OSTYPE" != "linux-gnu"* ]]; then
    print_error "Este script solo funciona en Linux"
    exit 1
fi
print_step "Linux detectado"

# 2. Verificar si Flutter está instalado
echo ""
echo "2️⃣  Buscando Flutter..."
if command -v flutter &> /dev/null; then
    FLUTTER_VERSION=$(flutter --version | head -1)
    print_step "Flutter ya está instalado: $FLUTTER_VERSION"
    read -p "¿Deseas continuar con la configuración? (s/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Ss]$ ]]; then
        echo "Abortado."
        exit 0
    fi
else
    print_warning "Flutter no encontrado"
    echo ""
    echo "Descargando Flutter..."
    cd ~
    git clone https://github.com/flutter/flutter.git -b stable
    
    print_info "Agregando Flutter al PATH..."
    if ! grep -q "export PATH=" ~/.bashrc; then
        echo "" >> ~/.bashrc
        echo "# Flutter PATH" >> ~/.bashrc
        echo "export PATH=\$PATH:~/flutter/bin" >> ~/.bashrc
        echo "export PATH=\$PATH:~/flutter/bin/cache/dart-sdk/bin" >> ~/.bashrc
    fi
    
    source ~/.bashrc
    print_step "Flutter instalado"
fi

# 3. Verificar Java
echo ""
echo "3️⃣  Verificando Java..."
if ! command -v java &> /dev/null; then
    print_warning "Java JDK no encontrado"
    echo "Instalando OpenJDK..."
    sudo apt-get update -qq
    sudo apt-get install -y default-jdk
    print_step "Java instalado"
else
    JAVA_VERSION=$(java -version 2>&1 | head -1)
    print_step "Java encontrado: $JAVA_VERSION"
fi

# 4. Verificar/Instalar Android SDK
echo ""
echo "4️⃣  Configurando Android SDK..."
if [ ! -d "$HOME/Android/Sdk" ]; then
    print_warning "Android SDK no encontrado"
    print_info "Descargando Android SDK Command Line Tools..."
    
    cd /tmp
    wget -q https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip
    unzip -q commandlinetools-linux-8512546_latest.zip
    
    mkdir -p ~/Android/Sdk/cmdline-tools
    mv cmdline-tools ~/Android/Sdk/cmdline-tools/latest
    
    print_step "Android SDK instalado"
else
    print_step "Android SDK encontrado en $HOME/Android/Sdk"
fi

# 5. Configurar variables de entorno
echo ""
echo "5️⃣  Configurando variables de entorno..."
if ! grep -q "ANDROID_SDK_ROOT" ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "# Android SDK" >> ~/.bashrc
    echo "export ANDROID_SDK_ROOT=\$HOME/Android/Sdk" >> ~/.bashrc
    echo "export ANDROID_HOME=\$HOME/Android/Sdk" >> ~/.bashrc
    echo "export PATH=\$PATH:\$ANDROID_HOME/emulator" >> ~/.bashrc
    echo "export PATH=\$PATH:\$ANDROID_HOME/tools" >> ~/.bashrc
    echo "export PATH=\$PATH:\$ANDROID_HOME/tools/bin" >> ~/.bashrc
    echo "export PATH=\$PATH:\$ANDROID_HOME/platform-tools" >> ~/.bashrc
    
    source ~/.bashrc
    print_step "Variables de entorno configuradas"
else
    print_step "Variables de entorno ya configuradas"
fi

# 6. Aceptar licencias de Android
echo ""
echo "6️⃣  Aceptando licencias de Android..."
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
yes | $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager --licenses > /dev/null 2>&1 || true
print_step "Licencias aceptadas"

# 7. Ejecutar flutter doctor
echo ""
echo "7️⃣  Ejecutando flutter doctor..."
echo ""
flutter doctor

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║              ✅ Configuración Completada                       ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "Próximos pasos:"
echo "1. Conecta tu celular con USB"
echo "2. Activa 'Depuración por USB' en Configuración"
echo "3. Ejecuta: ./run_on_phone.sh"
echo ""
