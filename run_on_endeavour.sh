#!/bin/bash

# Script específico para EndeavourOS - Configurar y ejecutar Flutter en celular

set -e

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║     🚀 Flutter App Runner - EndeavourOS Específico             ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_step() { echo -e "${GREEN}✓${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }
print_warning() { echo -e "${YELLOW}!${NC} $1"; }

# 1. Verificar Flutter
echo "1️⃣  Verificando Flutter..."
if ! command -v flutter &> /dev/null; then
    print_error "Flutter no encontrado"
    echo "Instala con: sudo pacman -S flutter"
    exit 1
fi
print_step "Flutter encontrado"

# 2. Buscar adb (Android Debug Bridge)
echo ""
echo "2️⃣  Buscando adb..."

ADB_PATH=""
if command -v adb &> /dev/null; then
    ADB_PATH="adb"
    print_step "adb encontrado en PATH"
elif [ -f "$HOME/Android/Sdk/platform-tools/adb" ]; then
    ADB_PATH="$HOME/Android/Sdk/platform-tools/adb"
    print_step "adb encontrado en Android SDK personal"
elif [ -f "/opt/android-sdk/platform-tools/adb" ]; then
    ADB_PATH="/opt/android-sdk/platform-tools/adb"
    print_step "adb encontrado en /opt/android-sdk"
else
    print_warning "adb no encontrado. Intentando instalar android-tools..."
    sudo pacman -S android-tools --noconfirm > /dev/null 2>&1 || true
    ADB_PATH="/usr/bin/adb"
    
    if [ ! -f "$ADB_PATH" ]; then
        print_error "No se pudo instalar adb"
        exit 1
    fi
fi

# 3. Listar dispositivos
echo ""
echo "3️⃣  Buscando dispositivos conectados..."

# Matar y reiniciar adb daemon
$ADB_PATH kill-server > /dev/null 2>&1 || true
sleep 1
$ADB_PATH start-server > /dev/null 2>&1 || true
sleep 2

devices=$($ADB_PATH devices 2>/dev/null | grep -v "List of" | grep -v "^$" | awk '{print $1}' || true)
device_count=$(echo "$devices" | wc -w)

if [ $device_count -eq 0 ]; then
    print_error "❌ No hay dispositivos conectados"
    echo ""
    echo "Por favor:"
    echo "1. Conecta tu celular con USB"
    echo "2. En el celular: Configuración → Opciones de desarrollador → Depuración USB (ON)"
    echo "3. Acepta el popup de autorización en el celular"
    echo "4. Ejecuta este script de nuevo"
    echo ""
    echo "Diagnóstico:"
    echo "  - Conectividad USB: $(lsusb | grep -i android || echo '  ⚠️  Celular no detectado en lsusb')"
    exit 1
fi

print_step "Dispositivo(s) encontrado(s)"
echo ""
for device in $devices; do
    echo "  ✓ $device"
done

device=$(echo "$devices" | head -1)

# 4. Preparar proyecto
echo ""
echo "4️⃣  Preparando proyecto..."

cd /home/oswal/Documentos/cristian/movil/estilos-de-ropa-

flutter clean > /dev/null 2>&1
print_step "Build limpiado"

flutter pub get > /dev/null 2>&1
print_step "Dependencias descargadas"

# 5. Compilar y ejecutar
echo ""
echo "5️⃣  Compilando y ejecutando (esto toma 2-3 minutos la primera vez)..."
echo ""

flutter run -d $device

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                    ✅ ¡Completado!                             ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "Durante la ejecución, puedes usar:"
echo "  • r  - Hot reload (recarga cambios)"
echo "  • R  - Hot restart (reinicia app)"
echo "  • L  - Ver logs"
echo "  • q  - Salir"
echo ""
