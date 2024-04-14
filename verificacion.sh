#!/bin/bash

# Verificar si se proporcionan los argumentos validos; nombre y comando de ejecucion
if [ $# -ne 2 ]; then
    echo "Uso: $0 <nombre> <comando_para_ejecutar>"
    exit 1
fi

#Variables que contienen el proceso y comando de ejecucion
nombre=$1
comando=$2

#Ciclo de monitoreo del proceso
while true; do
    # Verificar si el proceso está corriendo
    pgrep -x "$nombre" > /dev/null
    proceso_corriendo=$?

    # Si el proceso no está corriendo, levantarlo
    if [ $proceso_corriendo -ne 0 ]; then
        echo "El proceso $nombre no está corriendo. Levantando..."
        # Ejecutar el comando para relanzar el proceso en segundo plano
        ($comando &) >/dev/null 2>&1
    fi

    # Esperar un tiempo antes de verificar nuevamente
    sleep 12
done

