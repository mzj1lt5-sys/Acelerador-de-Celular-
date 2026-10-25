# Acelerador de Celular

Guía para resolver un celular que **se calienta mucho y se pone lento**, más un
script de diagnóstico automático para Android.

> El calor y la lentitud casi siempre van juntos: cuando el procesador se
> calienta, el sistema **reduce su velocidad a propósito** (*thermal throttling*)
> para protegerse. Si quitas la causa del calor, recuperas la velocidad.

---

## 1. Primero: ¿es peligroso?

Deja de usarlo, desconéctalo del cargador y llévalo a servicio técnico **ya** si:

- La batería está **hinchada** (la tapa o la pantalla se despegan o abomban).
- Se calienta mucho **estando apagado o sin usarlo**.
- Huele a quemado, se apaga solo o muestra aviso de temperatura.
- Se calienta solo en una zona concreta aun en reposo.

Si nada de eso ocurre, sigue la guía en orden.

---

## 2. Arreglos rápidos (10 minutos, resuelven la mayoría de casos)

1. **Reinicia el teléfono.** Libera RAM y detiene procesos atascados.
   Hazlo al menos una vez por semana.
2. **Quita la funda** mientras cargas o juegas: atrapa el calor.
3. **No lo uses mientras carga**, sobre todo con juegos o video.
   Cargar + uso intenso = la combinación que más calienta.
4. **Usa cargador y cable originales** o certificados. Los genéricos baratos
   calientan la batería.
5. **No lo dejes al sol**, en el auto, sobre la cama o bajo la almohada.
6. **Actualiza el sistema y las apps** (Ajustes → Sistema/Software →
   Actualización). Muchas actualizaciones corrigen consumos excesivos.

---

## 3. Encuentra la app culpable

En la mayoría de casos el calor lo provoca **una app concreta** trabajando en
segundo plano.

**Android:** Ajustes → Batería → Uso de batería.
**iPhone:** Ajustes → Batería (desplaza hacia abajo).

Fíjate en apps que gasten mucho **sin que las uses**. Sospechosas habituales:
redes sociales (Facebook, Instagram, TikTok), apps de mensajería con copias de
seguridad, apps con GPS, juegos que quedaron abiertos y apps desconocidas.

Para cada app sospechosa:
- Fuerza su cierre y observa si el teléfono se enfría.
- Restringe su uso en segundo plano
  (Android: Ajustes → Apps → [app] → Batería → *Restringido*;
  iPhone: Ajustes → General → Actualización en segundo plano).
- Si no la necesitas, **desinstálala**. Usa la versión web o *Lite* si existe.

### Prueba de modo seguro (Android)
Mantén pulsado *Apagar* y luego mantén pulsado *Reiniciar/Apagar* hasta ver
*Modo seguro*. En ese modo solo funcionan las apps del sistema.
**Si en modo seguro no se calienta ni va lento, el problema es una app
instalada.** Reinicia normal y desinstala las apps más recientes una a una.

---

## 4. Desinstala "limpiadores", "aceleradores" y antivirus

Las apps tipo *Cleaner*, *Booster*, *Ahorro de batería*, *Enfriador de CPU* o
antivirus de terceros **suelen empeorar el problema**: corren todo el tiempo,
muestran publicidad y fuerzan a reabrir apps que el sistema ya gestiona.
Android e iOS ya administran la memoria por sí solos. Desinstálalas.

---

## 5. Libera almacenamiento

Con el almacenamiento por encima del **~85 %**, el teléfono se vuelve
notablemente lento.

- Borra videos/fotos ya respaldados (Google Fotos → *Liberar espacio*;
  iPhone: Fotos de iCloud con *Optimizar almacenamiento*).
- WhatsApp: Ajustes → Almacenamiento y datos → Administrar almacenamiento.
  Borra videos reenviados y desactiva la descarga automática de multimedia.
- Borra la caché de apps pesadas (Android: Ajustes → Apps → [app] →
  Almacenamiento → Borrar caché).
- Borra la carpeta *Descargas* y apps que no uses.
- Objetivo: dejar **al menos 15–20 % libre**.

---

## 6. Ajustes que reducen calor y aceleran

| Ajuste | Dónde | Efecto |
|---|---|---|
| Brillo automático, no al máximo | Pantalla | La pantalla es de lo que más calienta |
| Tasa de refresco 60 Hz | Pantalla → Fluidez del movimiento | Menos consumo y calor |
| Desactivar GPS cuando no lo uses | Ubicación | Evita uso constante de CPU/radio |
| Desactivar Bluetooth/NFC si no los usas | Conexiones | Menos consumo |
| Usar Wi‑Fi en lugar de datos móviles | Conexiones | Con mala señal el módem calienta mucho |
| Desactivar fondos de pantalla animados y widgets | Pantalla de inicio | Menos trabajo de CPU/GPU |
| Ahorro de energía | Batería | Limita procesos en segundo plano |
| Reducir animaciones a 0.5x (Android) | Opciones de desarrollador | Se siente más rápido |
| Reducir movimiento (iPhone) | Accesibilidad → Movimiento | Se siente más rápido |

**Mala señal = calor:** si el teléfono se calienta en lugares con poca
cobertura, es el módem buscando antena. Activa el modo avión o usa Wi‑Fi.

---

## 7. La cámara se traba, no deja salir o la imagen va lenta

La cámara es lo que **más exige** al procesador y a la memoria. Si el teléfono
ya está caliente o con poco espacio libre, la cámara es lo primero que falla.

### Si se quedó trabada y no puedes salir
Fuerza el reinicio (no borra nada):
- **Samsung:** mantén *Bajar volumen* + *Encendido* unos 7–10 s.
- **Xiaomi / Redmi / POCO:** mantén **solo** *Encendido* 10–15 s. No uses
  *Encendido* + *Bajar volumen*: en Xiaomi eso puede abrir el modo *Fastboot*
  (si pasa, mantén *Encendido* 15 s y reinicia normal).
- **Otros Android:** mantén *Encendido* 10–15 s.
- **iPhone 8 o posterior:** pulsa y suelta *Subir volumen*, luego *Bajar
  volumen*, y mantén el botón lateral hasta ver la manzana.

### Pasos para arreglarla (en orden)
1. **Déjalo enfriar** antes de abrir la cámara: con calor, el sistema la frena
   y puede desactivar el flash o cerrarla.
2. **Libera espacio** (sección 5). Con el almacenamiento casi lleno, la cámara
   no puede guardar y se congela.
3. **Saca la tarjeta SD de la ecuación:** en los ajustes de la cámara cambia
   *Ubicación de almacenamiento* a **Almacenamiento interno** y prueba. Una SD
   lenta, falsa o dañada es causa muy común de que la cámara se trabe.
4. **Borra caché y datos de la cámara (Android):** Ajustes → Aplicaciones →
   (mostrar apps del sistema) → *Cámara* → Almacenamiento → **Borrar caché**.
   Si sigue igual, **Borrar datos**: solo resetea los ajustes de la cámara,
   **no borra tus fotos**. Haz lo mismo con *Fotos/Galería*.
   En Samsung también: Cámara → ⚙️ → *Restablecer ajustes*.
5. **Baja la exigencia de la cámara:**
   - Video en **1080p a 30 fps** en lugar de 4K o 60 fps.
   - Desactiva *Optimizador de escenas* / IA, *Fotos en movimiento* /
     *Live Photos*, *HDR automático*, filtros de belleza y la estabilización
     "súper estable".
6. **Revisa qué otras apps usan la cámara:** WhatsApp, Instagram, TikTok,
   Snapchat, linternas, lectores de QR o apps de filtros pueden quedarse
   "agarrando" la cámara. Ajustes → Privacidad → Administrador de permisos →
   Cámara: quítale el permiso a las que no necesites y desinstala linternas o
   apps de filtros de terceros.
7. **Actualiza** el sistema, la app de Cámara y *Actualización del sistema de
   Google Play* (Ajustes → Seguridad).
8. **Prueba en modo seguro** (sección 3). Si ahí la cámara va fluida, la culpa
   es de una app instalada.
9. **Prueba otra app de cámara** (por ejemplo *Open Camera* de la Play Store):
   - Si con ella **va fluida**, el problema es la app de cámara del sistema
     (pasos 4, 5 y 7, o restablecer de fábrica).
   - Si **también se traba**, puede ser el módulo de la cámara (hardware):
     respalda y prueba un restablecimiento de fábrica; si persiste, servicio
     técnico.

---

## 8. Diagnóstico automático (Android + PC)

`diagnostico_android.sh` revisa tu teléfono desde una computadora y genera un
informe con alertas. **Solo lee datos; no cambia ni borra nada.**

Revisa:
- Temperatura y salud de la batería
- Estado térmico (si el sistema está frenando el procesador por calor)
- Procesos que más CPU consumen y apps que más RAM usan
- RAM disponible y almacenamiento usado
- Apps que mantienen el teléfono despierto con la pantalla apagada (*wakelocks*)
- Apps instaladas y presencia de "limpiadores/aceleradores"
- Días sin reiniciar
- Apps con permiso de cámara, apps usando la cámara y tarjeta SD

### Cómo usarlo
1. En el teléfono: Ajustes → Acerca del teléfono → toca 7 veces
   *Número de compilación* para activar las *Opciones de desarrollador*.
2. Ajustes → Opciones de desarrollador → activa **Depuración USB**.
3. Instala [Android Platform Tools](https://developer.android.com/tools/releases/platform-tools)
   (incluye `adb`) en tu PC.
4. Conecta el teléfono por USB y acepta el aviso *¿Permitir depuración USB?*.
5. Ejecuta (Linux/macOS, o Git Bash/WSL en Windows):
   ```bash
   bash diagnostico_android.sh
   ```
6. Lee la sección **RESUMEN DE ALERTAS** al final y aplica las acciones.

Consejo: ejecútalo **mientras el teléfono está caliente** o justo después de
usar la app con la que se calienta, para capturar al culpable.

### Opcional: animaciones más rápidas por ADB
```bash
adb shell settings put global window_animation_scale 0.5
adb shell settings put global transition_animation_scale 0.5
adb shell settings put global animator_duration_scale 0.5
# Para volver a lo normal, usa 1 en lugar de 0.5
```

---

## 9. Si nada de lo anterior funciona

1. **Revisa la salud de la batería.**
   iPhone: Ajustes → Batería → Estado y carga (si es < 80 %, cámbiala).
   Samsung: app *Samsung Members* → Diagnóstico → Batería.
   Una batería desgastada se calienta más y provoca que el sistema vaya lento.
2. **Respalda y restablece de fábrica.** Elimina configuraciones y apps
   corruptas. Después instala solo las apps que realmente uses (no restaures
   todo de golpe para identificar si alguna vuelve a causar el problema).
3. **Servicio técnico**, si tras restablecer sigue calentándose: puede ser la
   batería, la pasta térmica o una falla de placa.

---

## Lista de verificación

- [ ] Reiniciado
- [ ] Sin funda al cargar, sin usarlo mientras carga, cargador original
- [ ] Sistema y apps actualizados
- [ ] App culpable identificada en *Uso de batería* y restringida/desinstalada
- [ ] Limpiadores/aceleradores/antivirus desinstalados
- [ ] Al menos 15–20 % de almacenamiento libre
- [ ] Brillo automático, 60 Hz, GPS/Bluetooth apagados si no se usan
- [ ] Cámara: caché borrada, guarda en memoria interna, video 1080p 30 fps
- [ ] Diagnóstico ejecutado y alertas atendidas
- [ ] Salud de batería revisada
