#!/bin/bash

#verificar si se proporciono un argumento valido 
if [ $# -ne 1 ]; then
    echo "Uso: $0 <ID_process>"
    exit 1
fi

#Variable que contiene el ID del proceso
ID_process=$1

#Obtener informacion del proceso
nombre=$(ps -p $ID_process -o comm=) #Obtiene el nombre del proceso con el PID proporcionado como argumento
id_proceso=$ID_process
ppid=$(ps -p $ID_process -o ppid=) #Obtiene el proceso padre del PID proporcionado inicialmente
usuario=$(ps -p $ID_process -o user=) #Obtiene usuario del propietario del proceso
cpu=$(ps -p $PID_process-o %cpu=) #Obtiene el porcenatje de uso de CPU durante la ejecucion del proceso
memoria=$(ps -p $ID_process -o %mem=) #Obteien el porcentaje de uso de memoria durante la ejecucion
estado=$(ps -p $ID_process -o stat=) #Status del proceso
path=$(readlink /proc/$ID_process/exe) #Ruta del ejecutable del proceso

# Imprimir la información obtenida
echo "Nombre del proceso: $nombre"
echo "ID del proceso: $id_proceso"
echo "Parent process ID: $ppid"
echo "Usuario propietario: $usuario"
echo "Porcentaje de uso de CPU: $cpu"
echo "Consumo de memoria: $memoria"
echo "Estado: $estado"
echo "Path del ejecutable: $path"

