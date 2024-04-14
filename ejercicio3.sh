#!/bin/bash

# Verificar si se proporciona un argumento válido 
if [ $# -ne 1 ]; then
    echo "Uso: $0 <ruta_del_ejecutable>"
    exit 1
fi

# Guardar el ejecutable como una variable
ejecutable=$1 

# Ejecutar el binario del parámetro recibido
echo "Ejecutando $ejecutable..."
$ejecutable &

# Archivo de registro de consumo de CPU y memoria
archivo_log="registro_consumo.log"

# Obtener el ID del proceso
PID=$!

# Ciclo para monitorear el proceso y muestrear el consumo de CPU y memoria
while ps -p $PID > /dev/null; do
    # Obtener la fecha y hora actual
    fecha=$(date +"%F %T")

    # Obtener el uso de CPU y memoria del proceso
    uso_cpu=$(ps -p $PID -o %cpu=)
    uso_memoria=$(ps -p $PID -o %mem=)

    # Registrar el consumo en el archivo de log
    echo "$fecha | Uso de CPU: $uso_cpu% | Uso de memoria: $uso_memoria%" >> $archivo_log

    # Esperar 1 segundo antes de la próxima lectura
    sleep 1
done

# Graficar los valores mediante gnuplot
echo "Generando gráfica..."
gnuplot << EOF
set terminal png
set output 'grafica_consumo.png'
set title 'Consumo de CPU y Memoria'
set xlabel 'Tiempo'
set ylabel 'Porcentaje'
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%H:%M:%S"
plot '$archivo_log' using 1:12 title 'Uso de CPU' with lines, \
     '$archivo_log' using 1:16 title 'Uso de Memoria' with lines
EOF

echo "La gráfica se ha generado en 'grafica_consumo.png'."

