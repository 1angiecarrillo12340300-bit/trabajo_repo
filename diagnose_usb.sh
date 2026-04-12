#!/bin/bash

# Script de diagnóstico para conectar celular Android

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║        🔍 Diagnóstico de Conexión USB Android                 ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Agregar adb al PATH
export PATH=$PATH:/home/oswal/Android/Sdk/platform-tools
export ANDROID_SDK_ROOT=/home/oswal/Android/Sdk

echo "1️⃣  Verificando si USB está conectado..."
echo ""
lsusb
echo ""
echo "Si ves tu celular en la lista, continúa."
echo "Si NO lo ves, asegúrate de conectar el cable USB."
echo ""

echo "2️⃣  Reiniciando ADB daemon..."
adb kill-server
sleep 1
adb start-server
sleep 2

echo ""
echo "3️⃣  Buscando dispositivos..."
adb devices

echo ""
echo "4️⃣  Si no ve su dispositivo:"
echo "   • Asegúrate de conectar el cable USB al celular"
echo "   • Ve a Configuración → Opciones de desarrollador"
echo "   • Activa 'Depuración por USB'"
echo "   • Desconecta y reconecta el cable"
echo "   • Ejecuta este script de nuevo"
echo ""

echo "5️⃣  Intenta autorizar en el celular:"
echo "   Cuando conectes, debe aparecer un popup en el celular"
echo "   que dice 'Permitir depuración USB'. Toca ACEPTAR."
echo ""

echo "Para más ayuda, consulta EJECUTAR_EN_CELULAR.md"
