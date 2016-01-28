#!/bin/bash
# -*- ENCODING: UTF-8 -*-
#Script programado por hackendemoniado
#Fecha de terminación:16/01/2016
#Detalles con explicación detallada
#Seguime en mi blog http://hackendemoniado.blogspot.com/
#


#creamos la ruta para guardar los txt necesarios para que trabaje el script
ruta=$HOME/controlared/
#es un simple if para saber si existe o no la carpeta
if [ ! -d $ruta ]; then
echo "creando la carpeta controlared en el direcotrio home "
mkdir $ruta
fi
echo "path: " $ruta
echo "Para empezar ingrese el o los segmentos de ip a analizar:"
read ips
#Lanzo nmap en mi red, deben modificar por el segmento correspondiente a su red #sed '1,4d'
echo "Ejecutando nmap en la red: "$ips
nmap -sP $ips > $ruta/controlred.txt
#busco el MAC de los hosts conectados
echo "creando los archivos pertinentes"
cat $ruta/controlred.txt | grep Address | cut -c 14-31 | tr -d "()" > $ruta/host.txt
#busco las ip de los hosts conectados
cat $ruta/controlred.txt | grep for | cut -c 22-36 | tr -d "()" > $ruta/ip.txt
#cuento la cantidad de hosts conectado para utilizarlo en el bucle for
canthost=`wc -l $ruta/host.txt | awk '{print $1}'`
#declaro una bandera para controlar si existe al menos un intruso y luego mandar el mail
bandera=0
echo "Busqueda de las mac"
for ((i=1; i<= $canthost ; i++))
do
#guardo en una variable el MAC de los host, esto es un for...
hostmac=`head -$i $ruta/host.txt | tail -1 | cut -c 1-17`
#guardo en otra variable la ip de los hosts
hostip=`head -$i $ruta/ip.txt | tail -1 | cut -c 1-15`
#Tengo una lista blanca de MAC permitidas de la cual debo buscarlas 
busca=`grep -ic "$hostmac" $ruta/listablanca.txt`
#Si la variable busca es igual a cero significa que es un intruso
if [ $busca == 0 ];then
#Cambio la bandera porque debo mandar el mail para notificar
bandera=1
#Extraigo info del intruso y lo guardo en un txt
echo $hostmac | nmap -v -A -O $hostip >> $ruta/infointruso.txt
echo "Se encontro un intruso con MAC Address: "$hostmac "IP: "$hostip
#fin if
fi
#fin for
done
#Acá pregunto si la bandera es igual a uno pues significa que hay intruso
if [ $bandera == 1 ];then
#mando el mail con el archivo adjunto con la información extraida de los mismos
echo "Se conecto algún/os intruso/s en la red" #| mutt -s "ACCESO A LA RED" -a $ruta/infointruso.txt -- sergiosysforence@hotmail.com.ar
#borro el archivo con la info para que la proxima ves no se siga agregando info repetida
#rm -rf $ruta/infointruso.txt
fi
echo ---------Fin del script-------------
