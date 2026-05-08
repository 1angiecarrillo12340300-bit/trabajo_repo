#!/bin/bash

# 🚀 SCRIPT PARA COMPILAR Y EJECUTAR EL APP

# Colors para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   🚀 COMPILADOR AUTOMÁTICO DE FLUTTER     ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}"
echo ""

# 1. Ir a la carpeta correcta
echo -e "${YELLOW}[1/4] Yendo a la carpeta del proyecto...${NC}"
cd /home/oswal/Documentos/cristian/movil/estilos-de-ropa-
echo -e "${GREEN}✓ En carpeta: $(pwd)${NC}"
echo ""

# 2. Limpiar compilaciones anteriores
echo -e "${YELLOW}[2/4] Limpiando compilaciones anteriores...${NC}"
flutter clean
echo -e "${GREEN}✓ Limpieza completada${NC}"
echo ""

# 3. Obtener dependencias
echo -e "${YELLOW}[3/4] Obteniendo dependencias...${NC}"
flutter pub get
echo -e "${GREEN}✓ Dependencias instaladas${NC}"
echo ""

# 4. Compilar y ejecutar
echo -e "${YELLOW}[4/4] Compilando y ejecutando en dispositivo...${NC}"
echo -e "${YELLOW}⏱️  Esto toma 3-5 minutos la primera vez${NC}"
echo ""

flutter run -d KBGUKRAA5T4L45GM

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   ✅ ¡COMPILACIÓN COMPLETADA!             ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}💡 El app está en tu teléfono${NC}"
echo ""
echo -e "${YELLOW}Ahora prueba:${NC}"
echo "  1. Presiona el corazón ❤️ en una prenda"
echo "  2. Debería volverse ROJO"
echo "  3. Aparecerá notificación"
echo "  4. El contador de favoritos aumentará"
echo ""
echo -e "${BLUE}Happy coding! 🎉${NC}"
