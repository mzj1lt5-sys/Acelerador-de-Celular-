#!/usr/bin/env bash
# Diagnóstico de calentamiento y lentitud para Android vía ADB.
# Solo LEE información del teléfono: no instala, borra ni cambia nada.
#
# Uso:
#   1. Activa "Opciones de desarrollador" y "Depuración USB" en el teléfono.
#   2. Conecta el teléfono al PC por USB y acepta el aviso de depuración.
#   3. Ejecuta:  bash diagnostico_android.sh
#   El informe se guarda en informe_<fecha>.txt

set -u

if ! command -v adb >/dev/null 2>&1; then
  echo "ERROR: no se encontró 'adb'. Instala Android Platform Tools:"
  echo "  https://developer.android.com/tools/releases/platform-tools"
  exit 1
fi

if ! adb get-state >/dev/null 2>&1; then
  echo "ERROR: no hay ningún teléfono conectado o no aceptaste la depuración USB."
  echo "Revisa el cable, desbloquea el teléfono y vuelve a intentarlo."
  exit 1
fi

INFORME="informe_$(date +%Y%m%d_%H%M%S).txt"
ALERTAS=()

sh_() { adb shell "$@" 2>/dev/null | tr -d '\r'; }
titulo() { printf '\n========== %s ==========\n' "$1"; }
alerta() { ALERTAS+=("$1"); }

{
  titulo "DISPOSITIVO"
  echo "Modelo:   $(sh_ getprop ro.product.manufacturer) $(sh_ getprop ro.product.model)"
  echo "Android:  $(sh_ getprop ro.build.version.release) (SDK $(sh_ getprop ro.build.version.sdk))"
  echo "Parche:   $(sh_ getprop ro.build.version.security_patch)"
  UPTIME=$(sh_ uptime)
  echo "Encendido: $UPTIME"
  if echo "$UPTIME" | grep -Eq 'up ([7-9]|[1-9][0-9]+) days'; then
    alerta "El teléfono lleva 7 días o más sin reiniciarse: reinícialo."
  fi

  titulo "BATERÍA Y TEMPERATURA"
  BAT=$(sh_ dumpsys battery)
  echo "$BAT"
  TEMP_DECIMAS=$(echo "$BAT" | awk -F': ' '/temperature/ {print $2; exit}')
  if [[ "$TEMP_DECIMAS" =~ ^[0-9]+$ ]]; then
    TEMP=$((TEMP_DECIMAS / 10))
    echo ">> Temperatura de batería: ${TEMP} °C"
    if (( TEMP >= 45 )); then
      alerta "Batería MUY caliente (${TEMP} °C). Desconecta el cargador, quita la funda y deja de usarlo hasta que enfríe."
    elif (( TEMP >= 40 )); then
      alerta "Batería caliente (${TEMP} °C). Lo normal en reposo es 25-35 °C."
    fi
  fi
  SALUD=$(echo "$BAT" | awk -F': ' '/health/ {print $2; exit}')
  # health: 2=buena, 3=sobrecalentada, 4=muerta, 5=sobrevoltaje, 6=fallo, 7=fría
  case "$SALUD" in
    3) alerta "Android reporta la batería como SOBRECALENTADA." ;;
    4|5|6) alerta "Android reporta un problema de batería (código $SALUD). Llévalo a servicio técnico." ;;
  esac

  titulo "ESTADO TÉRMICO DEL SISTEMA"
  TERM=$(sh_ dumpsys thermalservice)
  if [[ -n "$TERM" ]]; then
    echo "$TERM" | head -n 40
    ESTADO=$(echo "$TERM" | awk -F': ' '/Thermal Status/ {print $2; exit}')
    # 0=ninguno 1=leve 2=moderado 3=severo 4=crítico 5=emergencia 6=apagado
    if [[ "$ESTADO" =~ ^[0-9]+$ ]] && (( ESTADO >= 2 )); then
      alerta "El sistema está limitando el rendimiento por calor (estado térmico $ESTADO). Esto explica la lentitud."
    fi
  else
    echo "(No disponible en esta versión de Android)"
  fi

  titulo "PROCESOS QUE MÁS CPU CONSUMEN"
  sh_ top -b -n 1 -m 15 || sh_ top -n 1 -m 15

  titulo "MEMORIA RAM"
  MEM=$(sh_ cat /proc/meminfo)
  echo "$MEM" | grep -E 'MemTotal|MemAvailable|SwapTotal|SwapFree'
  TOTAL=$(echo "$MEM" | awk '/MemTotal/ {print $2}')
  DISP=$(echo "$MEM" | awk '/MemAvailable/ {print $2}')
  if [[ "$TOTAL" =~ ^[0-9]+$ && "$DISP" =~ ^[0-9]+$ && "$TOTAL" -gt 0 ]]; then
    PCT=$((DISP * 100 / TOTAL))
    echo ">> RAM disponible: ${PCT}%"
    if (( PCT < 15 )); then
      alerta "Poca RAM disponible (${PCT}%). Cierra apps o desinstala las que no uses."
    fi
  fi

  titulo "APPS QUE MÁS RAM USAN"
  sh_ dumpsys meminfo | sed -n '/Total PSS by process/,/Total PSS by OOM/p' | head -n 20

  titulo "ALMACENAMIENTO"
  DF=$(sh_ df -h /data)
  echo "$DF"
  USO=$(sh_ df /data | awk 'NR==2 {gsub("%","",$5); print $5}')
  if [[ "$USO" =~ ^[0-9]+$ ]]; then
    echo ">> Almacenamiento usado: ${USO}%"
    if (( USO >= 90 )); then
      alerta "Almacenamiento casi lleno (${USO}%). Por encima de ~85% el teléfono se vuelve muy lento: libera espacio."
    elif (( USO >= 85 )); then
      alerta "Almacenamiento alto (${USO}%). Libera espacio para recuperar velocidad."
    fi
  fi

  titulo "APPS QUE MANTIENEN EL TELÉFONO DESPIERTO (wakelocks)"
  WL=$(sh_ dumpsys power | grep -i 'PARTIAL_WAKE_LOCK')
  if [[ -n "$WL" ]]; then
    echo "$WL"
    alerta "Hay apps reteniendo el procesador activo (ver sección wakelocks). Pueden calentar el teléfono aun con pantalla apagada."
  else
    echo "(Ninguno activo en este momento)"
  fi

  titulo "APPS INSTALADAS POR EL USUARIO"
  APPS=$(sh_ pm list packages -3 | sed 's/^package://' | sort)
  NUM=$(echo "$APPS" | grep -c . )
  echo "Total: $NUM"
  echo "$APPS"
  if (( NUM > 80 )); then
    alerta "Tienes $NUM apps instaladas. Desinstala las que no uses: muchas corren en segundo plano."
  fi
  SOSPECHOSAS=$(echo "$APPS" | grep -Ei 'cleaner|booster|battery.?saver|antivirus|speedup|optimizer')
  if [[ -n "$SOSPECHOSAS" ]]; then
    alerta "Apps tipo 'limpiador/acelerador/antivirus' detectadas: $(echo "$SOSPECHOSAS" | tr '\n' ' ')— suelen EMPEORAR el calor y la lentitud; considera desinstalarlas."
  fi

  titulo "ANIMACIONES"
  for k in window_animation_scale transition_animation_scale animator_duration_scale; do
    echo "$k = $(sh_ settings get global $k)"
  done

  titulo "RESUMEN DE ALERTAS"
  if (( ${#ALERTAS[@]} == 0 )); then
    echo "No se detectaron problemas evidentes en este momento."
    echo "Si el calor aparece solo al usar ciertas apps, vuelve a ejecutar el diagnóstico mientras las usas."
  else
    for a in "${ALERTAS[@]}"; do echo "- $a"; done
  fi
} | tee "$INFORME"

echo
echo "Informe guardado en: $INFORME"
