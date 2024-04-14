#!/bin/bash

# Directorio que se desea monitoreas
directorio="/home/valeria/Documents"

# Archivo de registro
archivo_log="/home/valeria/Documents/cambios.txt"

# Monitorear el directorio en busca de eventos de creación, modificación y eliminación
inotifywait -m -r -e create,modify,delete --format '%w%f %T' "$directorio" |
while read archivo fecha; do
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Se detectó un cambio en el archivo $archivo en $fecha" >> "$archivo_log"
done

