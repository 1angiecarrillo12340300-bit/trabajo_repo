# 📋 INSTRUCCIONES PASO A PASO - EJECUTAR EL APP

## ✅ ESTADO ACTUAL

```
✓ Todos los cambios implementados
✓ Código sin errores de compilación
✓ Dependencias instaladas
✓ Listo para ejecutar en dispositivo
```

---

## 🚀 MÉTODO 1: EJECUTAR DIRECTAMENTE EN DISPOSITIVO (RECOMENDADO)

### Paso 1: Abrir Terminal
```bash
cd /home/oswal/Documentos/cristian/movil/estilos-de-ropa-
```

### Paso 2: Verificar que el dispositivo esté conectado
```bash
$HOME/Android/Sdk/platform-tools/adb devices -l
```

**Resultado esperado:**
```
List of devices attached
KBGUKRAA5T4L45GM       device usb:1-3 product:citrine_global model:24094RAD4G
```

### Paso 3: Limpiar compilaciones anteriores
```bash
flutter clean
```

### Paso 4: Obtener dependencias
```bash
flutter pub get
```

**Espera a que termine y debería ver:**
```
Got dependencies!
Changed X dependencies!
```

### Paso 5: Ejecutar en el dispositivo (SIN INTERRUPCIONES)
```bash
flutter run -d KBGUKRAA5T4L45GM
```

**⏱️ TIEMPO**: 3-5 minutos en la compilación inicial

**Cuando termina, verás:**
```
✓ Built build/app/outputs/flutter-apk/app-debug.apk
✓ Installed app-debug.apk
I/flutter (PID): [Información de inicio]
```

### 🎉 ¡LISTO! El app está en tu teléfono

---

## 🔄 DURANTE LA EJECUCIÓN: USAR HOT RELOAD

Mientras el app está corriendo en la terminal:

```
Presiona 'r' → Hot Reload (actualización rápida)
Presiona 'R' → Hot Restart (recarga completa)
Presiona 'q' → Salir
```

---

## 🚀 MÉTODO 2: COMPILAR APK PARA INSTALAR DESPUÉS

Si prefieres compilar el APK y luego instalarlo en el teléfono manualmente:

```bash
cd /home/oswal/Documentos/cristian/movil/estilos-de-ropa-

# Compilar APK en modo DEBUG
flutter build apk --debug

# Resultado: build/app/outputs/flutter-apk/app-debug.apk
# Tamaño: ~80MB
```

**Instalar en el teléfono:**
```bash
$HOME/Android/Sdk/platform-tools/adb install -r \
  build/app/outputs/flutter-apk/app-debug.apk
```

---

## 🚀 MÉTODO 3: COMPILAR APK RELEASE (FINAL)

Para una versión optimizada sin debug:

```bash
cd /home/oswal/Documentos/cristian/movil/estilos-de-ropa-

flutter build apk --release

# Resultado: build/app/outputs/flutter-apk/app-release.apk
# Tamaño: ~50MB (más pequeño que debug)
```

---

## 🧪 DESPUÉS DE INSTALAR: PROBAR FUNCIONES

### TEST 1: Favoritos (❤️)

1. Abre el app
2. Ve a "Guardarropa" (pestaña central)
3. Presiona el corazón ❤️ en cualquier prenda
4. Debería:
   - Volverse **ROJO**
   - Mostrar "Favorito" en **ROJO**
   - Aparecer notificación: "❤️ ¡Agregado a favoritos!"
   - Aumentar contador: "❤️ X"

✅ Si todo funciona → ¡ÉXITO!

### TEST 2: Mini Player

1. En la pantalla "Guardarropa"
2. Busca el carousel de sugerencias al inicio
3. Debería:
   - Mostrar imagen + precio + categoría
   - Indicador: "1/5" "2/5" etc
   - Cambiar de producto cada 5 segundos automáticamente
   - Permitir deslizar manualmente

✅ Si todo funciona → ¡ÉXITO!

### TEST 3: Persistencia de Favoritos

1. Marca 2-3 prendas como favoritas
2. Cierra completamente el app
3. Reabre el app
4. Ve a "Guardarropa"
5. Debería:
   - Ver las mismas prendas marcadas como favoritas
   - Contador con el mismo número

✅ Si todo funciona → ¡ÉXITO!

### TEST 4: Categorías

1. En "Guardarropa"
2. Presiona diferentes categorías (Camisetas, Pantalones, etc)
3. Debería:
   - Cambiar el chip de color a AZUL
   - Grilla actualizar con solo esas prendas
   - Contador mostrar número de prendas de esa categoría

✅ Si todo funciona → ¡ÉXITO!

---

## ⚠️ SOLUCIÓN DE PROBLEMAS

### Problema 1: "Gradle task assembleDebug failed"

**Solución:**
```bash
flutter clean
rm pubspec.lock
flutter pub get
flutter run -d KBGUKRAA5T4L45GM
```

### Problema 2: "Device not found"

**Solución:**
```bash
# Verificar conexión
$HOME/Android/Sdk/platform-tools/adb devices

# Si no aparece, reconectar USB
$HOME/Android/Sdk/platform-tools/adb kill-server
$HOME/Android/Sdk/platform-tools/adb start-server
$HOME/Android/Sdk/platform-tools/adb devices
```

### Problema 3: App no actualiza después de cambios

**Solución:**
Mientras flutter run está ejecutándose:
- Presiona `r` para Hot Reload
- Presiona `R` para Hot Restart completo
- O mata el proceso y ejecuta nuevamente

### Problema 4: "Timeout waiting for Gradle"

**Solución:**
```bash
export GRADLE_OPTS=-Xmx4096m
flutter clean
flutter run -d KBGUKRAA5T4L45GM
```

### Problema 5: Favoritos no se guardan

**Solución:**
- Verifica que SharedPreferences esté instalado: `flutter pub get`
- Verifica permisos de almacenamiento en el teléfono
- Intenta: `flutter clean` y nuevamente

---

## 📱 CARACTERÍSTICAS VISIBLES

### En la pantalla "Guardarropa" verás:

```
┌────────────────────────────────┐
│ 👕 Mi Guardarropa              │  ← AppBar mejorado
├────────────────────────────────┤
│ 💡 Sugerencias de Temporada    │  ← Mini player
│ [Carousel de productos]     → │
│                                │
│ 📂 Categorías                  │
│ [Todos] [Camisetas] [...]     │
│                                │
│ 👗 4 prendas          ❤️ 2    │  ← Contadores
│                                │
│ ┌──────────┐  ┌──────────┐    │
│ │ Imagen   │  │ Imagen   │    │
│ │ ❤️ Red   │  │ 🤍 White │    │  ← Nuevas tarjetas
│ │ Favorito │  │          │    │
│ └──────────┘  └──────────┘    │
│                                │
└────────────────────────────────┘
```

---

## 📚 DOCUMENTACIÓN ADICIONAL

Si necesitas más información, revisa:

1. **CAMBIOS_IMPLEMENTADOS.md** - Qué se cambió exactamente
2. **RESUMEN_CAMBIOS.md** - Comparación visual antes/después
3. **GUIA_COMPILACION.md** - Guía detallada de compilación
4. **README.md** - Documentación general del proyecto

---

## 🎯 RESUMEN RÁPIDO

```bash
# Comando corto para compilar y ejecutar:
cd /home/oswal/Documentos/cristian/movil/estilos-de-ropa- && \
flutter clean && \
flutter pub get && \
flutter run -d KBGUKRAA5T4L45GM
```

⏱️ **Tiempo total**: ~4-5 minutos primera vez
⏱️ **Siguientes veces**: ~1-2 minutos (sin `flutter clean`)

---

## ✅ CHECKLIST FINAL

- [ ] Terminal abierta en carpeta del proyecto
- [ ] Dispositivo conectado (verificado con `adb devices`)
- [ ] `flutter clean` ejecutado
- [ ] `flutter pub get` ejecutado sin errores
- [ ] Sin errores de compilación (`flutter analyze` limpio)
- [ ] `flutter run` en ejecución
- [ ] App abierto en el teléfono
- [ ] Presionado el corazón en una prenda
- [ ] Favorito guardado y visible
- [ ] Cerrado y reabierto el app
- [ ] Favorito aún está ahí ✓

---

**Si todo está ✓ → ¡FELICIDADES! El app está funcionando perfectamente**

---

Autor: Copilot  
Fecha: 10 de Abril de 2026  
Estado: ✅ Listo para ejecutar
