# 🚀 Guía Paso a Paso: Ejecutar en Celular Android desde Linux

## 📋 Requisitos Previos

### 1. **Instalar Android SDK** (si no lo tienes)
```bash
# En Ubuntu/Debian
sudo apt-get update
sudo apt-get install default-jdk
sudo apt-get install android-sdk

# O descargar Android Studio
# Descargar desde: https://developer.android.com/studio
# Descomprimir y seguir instrucciones
```

### 2. **Configurar Variables de Entorno**
```bash
# Editar ~/.bashrc o ~/.bash_profile
nano ~/.bashrc

# Agregar estas líneas al final:
export ANDROID_SDK_ROOT=~/Android/Sdk
export ANDROID_HOME=~/Android/Sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/tools
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

# Guardar (Ctrl+O, Enter, Ctrl+X)

# Aplicar cambios
source ~/.bashrc
```

### 3. **Verificar Flutter está correctamente instalado**
```bash
flutter doctor
```

Debe mostrar ✓ en Flutter, Dart y Android toolchain.

---

## 📱 Opción A: Usar Celular Real (Recomendado)

### **Paso 1: Habilitar USB Debugging en Android**

1. **En tu celular (Android 6+):**
   - Ve a **Configuración** → **Información del teléfono**
   - Toca **Número de compilación** 7 veces
   - Regresa a Configuración → **Opciones de desarrollador**
   - Activa **Depuración por USB**
   - Conecta el USB al PC cuando se solicite

2. **Aceptar autorización:**
   - Cuando conectes el cable, verás un popup
   - Marca **"Permitir siempre desde esta computadora"**
   - Toca **Aceptar**

### **Paso 2: Verificar Conexión**
```bash
# En tu PC Linux
adb devices

# Deberías ver:
# List of attached devices
# XXXXXXXX                device
```

Si ves "unauthorized", desconecta y vuelve a conectar el cable.

### **Paso 3: Ejecutar en el Celular**
```bash
cd /home/oswal/Documentos/cristian/movil/estilos-de-ropa-

# Compilar y ejecutar
flutter run

# O especificar el dispositivo
flutter run -d [DEVICE_ID]
```

---

## 💻 Opción B: Usar Emulador Android

### **Paso 1: Crear Emulador**
```bash
# Ver AVD disponibles
emulator -list-avds

# Si no hay ninguno, crear uno:
# Abrir Android Studio → Virtual Device Manager → Create Device
# O desde línea de comandos:
avdmanager create avd -n android_emulator -k "system-images;android-33;google_apis;x86_64"
```

### **Paso 2: Iniciar Emulador**
```bash
# Desde Android Studio o:
emulator -avd android_emulator &

# Esperar a que inicie completamente (2-3 minutos)
```

### **Paso 3: Verificar Emulador**
```bash
adb devices

# Deberías ver:
# emulator-5554                 device
```

### **Paso 4: Ejecutar en Emulador**
```bash
cd /home/oswal/Documentos/cristian/movil/estilos-de-ropa-
flutter run -d emulator-5554
```

---

## 🔧 Pasos Completos desde Cero

### **1. Preparar el Proyecto**
```bash
# Navegar al proyecto
cd /home/oswal/Documentos/cristian/movil/estilos-de-ropa-

# Limpiar build anterior
flutter clean

# Descargar dependencias
flutter pub get

# Verificar que todo está bien
flutter doctor -v
```

### **2. Conectar Dispositivo (Celular Real)**
```bash
# En Linux
adb devices

# Conectar cable USB
# Aceptar popup en celular
# Verificar que aparezca en la lista
```

### **3. Ejecutar la App**
```bash
# Opción 1: Sin especificar dispositivo (si hay solo uno)
flutter run

# Opción 2: Especificar dispositivo
flutter run -d [DEVICE_ID]

# Opción 3: Ver todas las opciones
flutter run --help
```

### **4. Esperar a que Compile**
```
Launching lib/main.dart on SM-G950F in release mode...
```

- Primera compilación: 2-3 minutos
- Compilaciones siguientes: 30-60 segundos

### **5. ¡Listo! La app abrirá en tu celular**

---

## 🎮 Opciones Útiles Durante Ejecución

```bash
# Hot reload (recarga rápida de código)
# Presiona "r" en la terminal

# Hot restart (reinicia la app)
# Presiona "R" en la terminal

# Ver logs
# Presiona "L" en la terminal

# Salir
# Presiona "q" en la terminal
```

---

## 🆘 Troubleshooting

### **Error: "adb: command not found"**
```bash
# Solución: Configurar variables de entorno
export PATH=$PATH:~/Android/Sdk/platform-tools

# Verificar
adb version
```

### **Error: "No devices found"**
```bash
# Reconectar USB
adb reconnect

# O resetear USB
adb kill-server
adb start-server
adb devices
```

### **Error: "Permission denied" en Android**
```bash
# Ejecutar con permisos
sudo adb kill-server
sudo adb start-server
adb devices
```

### **Error: "Unable to locate adb"**
```bash
# Buscar dónde está Android SDK
find ~ -name "adb" 2>/dev/null

# Agregar a PATH
export PATH=$PATH:/ruta/a/android/sdk/platform-tools
```

### **La app no instala**
```bash
# Verificar que hay espacio en el celular
adb shell df

# Desinstalar versión anterior
adb uninstall com.stylestack.app

# Intentar de nuevo
flutter run
```

### **Conexión lenta o timeouts**
```bash
# Aumentar timeout
flutter run --device-timeout 120

# O usar conexión por red en lugar de USB
adb tcpip 5555
adb connect [IP_DEL_CELULAR]:5555
```

---

## 📊 Checklist Final

```
□ Android SDK instalado
□ Variables de entorno configuradas
□ flutter doctor sin errores
□ USB debugging activado en celular
□ Celular conectado y reconocido (adb devices)
□ flutter pub get ejecutado
□ Proyecto compilado (flutter run)
□ App abierta en celular
□ Pantallas funcionales:
  □ Inicio (Guardarropa)
  □ Cámara (Capturar fotos)
  □ Sugerencias (API)
```

---

## 🚀 Resumen Rápido (después de la primera vez)

```bash
cd /home/oswal/Documentos/cristian/movil/estilos-de-ropa-
adb devices  # Verificar celular conectado
flutter run  # ¡Listo!
```

---

## 💡 Tips Útiles

### **Para desarrollo rápido:**
```bash
# Hot reload automático
# Presiona "r" en la terminal después de cambios
```

### **Ver logs en tiempo real:**
```bash
# En otra terminal
adb logcat | grep flutter
```

### **Captura de pantalla del celular:**
```bash
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png ~/Desktop/
```

### **Grabar video:**
```bash
adb shell screenrecord /sdcard/video.mp4 --time-limit=10
adb pull /sdcard/video.mp4 ~/Desktop/
```

---

## 🎯 ¿Problemas Específicos?

Si tienes error específico, proporciona:
1. El código de error exacto
2. Tu versión de Android
3. Salida de `flutter doctor -v`
4. Salida de `adb devices`

¡Listo para ejecutar! 🎉
