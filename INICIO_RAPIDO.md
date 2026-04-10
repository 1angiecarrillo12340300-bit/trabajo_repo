# ⚡ Inicio Rápido - Ejecutar en Celular

## 🚀 La forma más fácil (3 pasos)

### **Paso 1: Preparar ambiente (primera vez)**
```bash
chmod +x setup_flutter.sh
./setup_flutter.sh
```

Esto configura:
- ✅ Flutter
- ✅ Android SDK
- ✅ Variables de entorno
- ✅ Permisos

### **Paso 2: Conectar celular**
1. Conecta el USB a tu PC
2. En el celular: Configuración → Desarrollador → Depuración USB
3. Acepta la autorización

### **Paso 3: Ejecutar**
```bash
chmod +x run_on_phone.sh
./run_on_phone.sh
```

**¡Listo!** La app se abrirá en tu celular 🎉

---

## 📱 Verificación Rápida

```bash
# Ver si el celular está conectado
adb devices

# Deberías ver algo como:
# 185B0...    device
```

---

## 🔧 Comandos Manuales (si prefieres)

```bash
# Ver dispositivos
adb devices

# Ejecutar directamente
flutter run -d [DEVICE_ID]

# O dejar que Flutter elija
flutter run
```

---

## 🛠️ Troubleshooting Rápido

| Problema | Solución |
|----------|----------|
| "adb no encontrado" | `export PATH=$PATH:~/Android/Sdk/platform-tools` |
| "No devices found" | Desconecta/reconecta USB, acepta popup |
| "Permission denied" | `sudo adb kill-server && adb devices` |
| Muy lento | Primera compilación es lenta (2-3 min) |

---

## 💡 Durante la ejecución

```
r      → Hot reload (recarga rápida)
R      → Hot restart (reinicia app)
L      → Ver logs
q      → Salir
```

---

## 📖 Documentación Completa

Ver `EJECUTAR_EN_CELULAR.md` para guía detallada

---

**¡Necesitas ayuda?** Revisa los logs:
```bash
flutter run -v
```
