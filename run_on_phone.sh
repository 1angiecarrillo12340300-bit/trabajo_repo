#!/bin/bash

# Script para ejecutar la app en celular desde Linux
# Uso: chmod +x run_on_phone.sh && ./run_on_phone.sh

set -e

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║     🚀 Flutter App Runner - StyleStack en Celular             ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Colores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función para imprimir mensajes
print_step() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}!${NC} $1"
}

# 1. Verificar Flutter
echo ""
echo "1️⃣  Verificando Flutter..."
if ! command -v flutter &> /dev/null; then
    print_error "Flutter no está instalado"
    exit 1
fi
print_step "Flutter encontrado"

# 2. Verificar ADB
echo ""
echo "2️⃣  Verificando Android Debug Bridge..."
if ! command -v adb &> /dev/null; then
    print_error "adb no está en el PATH"
    print_warning "Agrega Android SDK a tu PATH:"
    echo "export PATH=\$PATH:~/Android/Sdk/platform-tools"
    exit 1
fi
print_step "adb encontrado"

# 3. Listar dispositivos
echo ""
echo "3️⃣  Buscando dispositivos conectados..."
devices=$(adb devices | grep -v "List of attached devices" | grep -v "^$" | awk '{print $1}')
device_count=$(echo "$devices" | wc -l)

if [ $device_count -eq 0 ]; then
    print_error "No hay dispositivos conectados"
    echo ""
    echo "Por favor:"
    echo "1. Conecta tu celular con USB"
    echo "2. Activa 'Depuración por USB' en Configuración"
    echo "3. Acepta la autorización en el celular"
    echo "4. Ejecuta este script de nuevo"
    exit 1
fi

print_step "Dispositivo(s) encontrado(s)"
echo ""
echo "Dispositivos disponibles:"
i=1
for device in $devices; do
    device_info=$(adb -s $device shell getprop ro.product.model 2>/dev/null || echo "Desconocido")
    echo "  $i. $device ($device_info)"
    i=$((i + 1))
done

# 4. Si hay multiple dispositivos, pedir selección
if [ $device_count -gt 1 ]; then
    echo ""
    echo "¿Cuál dispositivo deseas usar? (numero 1-$device_count):"
    read -p "Selecciona: " device_choice
    
    device=$(echo "$devices" | sed -n "${device_choice}p")
    if [ -z "$device" ]; then
        print_error "Selección inválida"
        exit 1
    fi
else
    device=$(echo "$devices" | head -1)
fi

print_step "Dispositivo seleccionado: $device"

# 5. Preparar proyecto
echo ""
echo "4️⃣  Preparando proyecto..."
flutter clean > /dev/null 2>&1
print_step "Build limpiado"

flutter pub get > /dev/null 2>&1
print_step "Dependencias descargadas"

# 6. Compilar y ejecutar
echo ""
echo "5️⃣  Compilando y ejecutando en el dispositivo..."
echo "Esto puede tomar 2-3 minutos la primera vez..."
echo ""

flutter run -d $device

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                    ✅ ¡Completado!                             ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "Tips durante la ejecución:"
echo "  • Presiona 'r' para hot reload (cambios rápidos)"
echo "  • Presiona 'R' para hot restart (reiniciar app)"
echo "  • Presiona 'L' para ver logs"
echo "  • Presiona 'q' para salir"
echo ""
