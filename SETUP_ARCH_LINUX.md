# 🐧 Configuración para EndeavourOS (Arch Linux)

## 📋 Verificación de tu Sistema

Tu máquina:
- **OS:** EndeavourOS (Arch Linux)
- **DE:** KDE Plasma 6.6.1
- **WM:** KWin (Wayland)
- **CPU:** Intel Celeron N4120 (4 núcleos)
- **RAM:** 7.56 GiB
- **Storage:** 223 GiB

---

## 🔧 Instalación en EndeavourOS (Arch)

### **Paso 1: Instalar dependencias necesarias**

```bash
# Actualizar sistema
sudo pacman -Syu

# Instalar Java JDK
sudo pacman -S jdk-openjdk

# Instalar Flutter (última versión)
sudo pacman -S flutter

# Instalar Android SDK (si no lo tienes)
sudo pacman -S android-sdk android-sdk-platform-tools

# Instalar herramientas de construcción
sudo pacman -S base-devel git
```

### **Paso 2: Configurar variables de entorno**

Edita `~/.bashrc` o `~/.zshrc` (según tu shell):

```bash
# Editar archivo
nano ~/.bashrc

# Agregar al final:
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin

# Guardar: Ctrl+O, Enter, Ctrl+X
```

Aplicar cambios:
```bash
source ~/.bashrc
```

### **Paso 3: Verificar instalación**

```bash
flutter doctor
flutter doctor -v
```

Deberías ver ✓ en:
- Flutter SDK
- Dart SDK
- Android toolchain
- Linux (si compilas para Linux)

---

## 📱 Conectar Celular en EndeavourOS

### **Paso 1: Permisos USB**

En EndeavourOS/Arch, a veces necesitas permisos especiales:

```bash
# Agregar tu usuario al grupo plugdev (para acceso USB)
sudo usermod -a -G plugdev $USER

# O al grupo dialout
sudo usermod -a -G dialout $USER

# Aplicar cambios (logout y login necesario)
```

### **Paso 2: Configurar udev rules**

```bash
# Crear archivo de reglas para Android
sudo nano /etc/udev/rules.d/51-android.rules
```

Agregar estas líneas:

```
# Adb (Android Debug Bridge)
SUBSYSTEM=="usb", ATTR{idVendor}=="0fce", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="19d2", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="05c6", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="0bb4", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="12d1", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="8087", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="1f3a", MODE="0666", GROUP="plugdev"

# Adb over network
SUBSYSTEM=="tcp", PROGRAM="/bin/grep -l adb /proc/*/oom_score_adj", OWNER="adb"
```

Recargar reglas:
```bash
sudo udevadm control --reload
sudo udevadm trigger
```

### **Paso 3: En KDE Plasma Wayland**

KDE Plasma 6 usa Wayland por defecto, lo que puede causar problemas. Opciones:

**Opción A: Usar Xorg (más compatible con desarrollo)**
```
En KDE Plasma:
1. Click menú inicio
2. Salir
3. En login, selecciona "Plasmawayland" y cambia a "PlasmaX11"
4. Reinicia
```

**Opción B: Mantener Wayland pero configurar Flutter**
```bash
export GDK_BACKEND=x11
export QT_QPA_PLATFORM=wayland
```

---

## 🚀 Ejecutar en tu Celular

### **Paso 1: Activar Depuración USB en Android**

En tu celular:
```
Configuración
  → Información del teléfono
    → Toca "Número de compilación" 7 veces
  → Volver a Configuración
    → Opciones de desarrollador
      → Activa "Depuración USB"
```

### **Paso 2: Conectar USB**

```bash
# Ver dispositivos conectados
export PATH=$PATH:$HOME/Android/Sdk/platform-tools
adb devices

# Si no aparece, reiniciar adb
adb kill-server
sleep 2
adb start-server
adb devices
```

### **Paso 3: Ejecutar tu app**

```bash
cd /home/oswal/Documentos/cristian/movil/estilos-de-ropa-

# Opción 1: Dejar que Flutter elija
flutter run

# Opción 2: Especificar dispositivo
flutter run -d [DEVICE_ID]

# Opción 3: Ver todos los dispositivos
flutter devices
```

---

## 🎯 Script Automatizado para EndeavourOS

```bash
#!/bin/bash
# setup_arch.sh

# Instalar dependencias
sudo pacman -Syu
sudo pacman -S jdk-openjdk flutter android-sdk android-sdk-platform-tools base-devel git

# Configurar permisos USB
sudo usermod -a -G plugdev $USER

# Variables de entorno
echo "" >> ~/.bashrc
echo "# Android SDK (EndeavourOS)" >> ~/.bashrc
echo "export ANDROID_SDK_ROOT=\$HOME/Android/Sdk" >> ~/.bashrc
echo "export ANDROID_HOME=\$HOME/Android/Sdk" >> ~/.bashrc
echo "export PATH=\$PATH:\$ANDROID_SDK_ROOT/platform-tools" >> ~/.bashrc
echo "export PATH=\$PATH:\$ANDROID_SDK_ROOT/emulator" >> ~/.bashrc

source ~/.bashrc

echo "✓ Configuración completada"
echo "Por favor, reinicia sesión (logout/login) para aplicar cambios de permisos"
```

Guardar como `setup_arch.sh`:
```bash
chmod +x setup_arch.sh
./setup_arch.sh
```

---

## 🆘 Troubleshooting para EndeavourOS

### **Error: "flutter: command not found"**
```bash
# Flutter instalado por pacman debería estar en /opt/flutter
export PATH=$PATH:/opt/flutter/bin
echo 'export PATH=$PATH:/opt/flutter/bin' >> ~/.bashrc
```

### **Error: "No permission for USB"**
```bash
# Verificar grupo
id $USER

# Agregar a grupos
sudo usermod -a -G uucp,plugdev $USER
sudo usermod -a -G kvm $USER

# Logout y login
```

### **Error: "adb not found"**
```bash
# En Arch, está en:
/opt/android-sdk/platform-tools/adb

# Agregar al PATH:
export PATH=$PATH:/opt/android-sdk/platform-tools
```

### **Wayland causa problemas gráficos**
```bash
# Cambiar a Xorg temporalmente
export GDK_BACKEND=x11
flutter run
```

---

## ✅ Comandos Rápidos para EndeavourOS

```bash
# Ver versiones instaladas
flutter --version
dart --version
java -version
adb version

# Verificar todo
flutter doctor -v

# Ver dispositivos
flutter devices

# Ejecutar con logs verbosos
flutter run -v

# Limpiar y recompilar
flutter clean
flutter pub get
flutter run
```

---

## 📊 Checklist Final

```
□ EndeavourOS/Arch actualizado (sudo pacman -Syu)
□ Java JDK instalado (sudo pacman -S jdk-openjdk)
□ Flutter instalado (sudo pacman -S flutter)
□ Android SDK instalado
□ PATH configurado en ~/.bashrc
□ Permisos USB configurados (sudo usermod -a -G plugdev $USER)
□ Sesión reiniciada
□ Celular conectado con Depuración USB activada
□ flutter doctor sin errores
□ flutter run compilando
```

---

## 🎉 ¡Listo para EndeavourOS!

Una vez hecho todo, ejecuta:

```bash
cd /home/oswal/Documentos/cristian/movil/estilos-de-ropa-
flutter run
```

---

## 💡 Tips Específicos de EndeavourOS

- **Wayland vs Xorg:** Para desarrollo móvil, Xorg es más estable
- **pacman es más rápido que apt/dnf** - Las instalaciones son muy rápidas
- **AUR disponible** - Si necesitas paquetes adicionales:
  ```bash
  # Instalar yay (AUR helper)
  sudo pacman -S yay
  ```

¡Tu máquina está lista para desarrollo Flutter! 🚀
