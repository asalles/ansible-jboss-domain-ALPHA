#!/bin/bash
#set -x

IFS='|' read -r -a profile <<< $1
tipo=${profile[1]}
nombre=${profile[0]}



echo creacion profile jms
sed -n "/<profile name=\"$tipo\"/,/<\/profile/p" $2/domain/configuration/domain.xml >> $2/domain/configuration/$nombre.xml
sed -i "s/<profile name=\"$tipo\">/<profile name=\"$nombre\">/g" $2/domain/configuration/$nombre.xml

if [[ "$tipo" == "default" ]]; then
  sed -n "/<socket-binding-group name=\"standard-sockets\"/,/<\/socket-binding-group>/p" $2/domain/configuration/domain.xml >> $2/domain/configuration/$nombre-socket.xml
  sed -i "s/standard-sockets/$nombre-standard-sockets/g" $2/domain/configuration/$nombre-socket.xml
else
  sed -n "/<socket-binding-group name=\"$tipo-sockets\"/,/<\/socket-binding-group>/p" $2/domain/configuration/domain.xml >> $2/domain/configuration/$nombre-socket.xml
  sed -i "s/$tipo-sockets/$nombre-$tipo-sockets/g" $2/domain/configuration/$nombre-socket.xml
fi

tl=$(wc -l $2/domain/configuration/$nombre.xml | cut -d " " -f1)
for i in $(seq 1 $tl)
do
 linea=$(cat $2/domain/configuration/$nombre.xml | head -n $i | tail -1)
 sed -i "/<\/profiles>/ i\\$linea" $2/domain/configuration/domain.xml
done

tl=$(wc -l $2/domain/configuration/$nombre-socket.xml | cut -d " " -f1)
for i in $(seq 1 $tl)
do
 lineasocket=$(cat $2/domain/configuration/$nombre-socket.xml | head -n $i | tail -1)
 sed -i "/<socket-binding-group name=\"full-ha-sockets\"/ i\\$lineasocket" $2/domain/configuration/domain.xml
done
