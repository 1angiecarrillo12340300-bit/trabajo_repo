# 🔴 Celular No Detectado - Pasos para Conectar

## ✅ Checklist de Conexión

### **Paso 1: Activar Depuración USB en Android**

1. **En tu celular Android:**
   - Abre **Configuración**
   - Busca **"Información del teléfono"** o **"Acerca de"**
   - Toca **"Número de compilación"** 7 veces rápidamente
   - Verás: "Ahora eres desarrollador" ✓

2. **Vuelve a Configuración:**
   - Busca **"Opciones de desarrollador"** (debe estar visible ahora)
   - Abre **Opciones de desarrollador**
   - Busca **"Depuración USB"**
   - **Actívala** (debe estar en ON/Azul)

### **Paso 2: Conectar con Cable USB**

1. **Conecta el cable USB:**
   - Usa un cable USB que funcione (preferiblemente el original)
   - Conecta del PC a tu celular
   - En la PC deberías ver algo como: `/dev/ttyUSB0` o similar

2. **En el celular aparecerá un popup:**
   - **"¿Permitir depuración USB desde este ordenador?"**
   - **Marca:** "Permitir siempre desde este ordenador"
   - Toca: **ACEPTAR** ✓

### **Paso 3: Verificar Conexión**

```bash
export PATH=$PATH:/home/oswal/Android/Sdk/platform-tools
adb devices
```

Deberías ver:
```
List of attached devices
XXXXXXXXXX                device
```

Si ves "unauthorized", espera a que aceptes el popup en el celular.

### **Paso 4: Ejecutar la App**

Una vez que `adb devices` muestre tu celular, ejecuta:

```bash
cd /home/oswal/Documentos/cristian/movil/estilos-de-ropa-
flutter run
```

---

## 🆘 Troubleshooting

### **"List of attached devices" (vacío)**

**Solución 1: Reconectar cable**
```bash
# Desconecta el cable
# Espera 5 segundos
# Vuelve a conectar
# Acepta el popup en el celular
```

**Solución 2: Reiniciar ADB**
```bash
export PATH=$PATH:/home/oswal/Android/Sdk/platform-tools
adb kill-server
sleep 2
adb start-server
sleep 2
adb devices
```

**Solución 3: Verificar USB en el celular**
- El celular debe estar en modo "Transferencia de datos"
- No en modo "Carga solamente"

### **"unauthorized"**
```
XXXXXXXXXX                unauthorized
```
- Verifica que aceptaste el popup en el celular
- Desconecta y vuelve a conectar
- Intenta con otro puerto USB

### **No aparece popup en celular**
- El cable USB puede ser defectuoso
- Intenta con otro cable
- Prueba en otro puerto USB de tu PC

---

## 📱 Verificación Final

Una vez que `adb devices` muestre tu celular:

```bash
# Ejecutar la app
cd /home/oswal/Documentos/cristian/movil/estilos-de-ropa-
flutter run

# O especificar el dispositivo
adb devices -l  # Ver ID del dispositivo
flutter run -d [DEVICE_ID]
```

---

## 💡 Tips

- **Primera compilación:** 2-3 minutos
- **Compilaciones siguientes:** 30-60 segundos
- **Mantén el celular desbloqueado** durante la compilación
- **No desconectes el USB** durante el proceso

---

**Después de conectar correctamente, avísame y ejecutamos:**
```bash
./run_on_phone.sh
```
