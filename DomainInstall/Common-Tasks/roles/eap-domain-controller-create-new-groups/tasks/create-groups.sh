#!/bin/bash
#set -x

echo $1
echo $2
echo $3

IFS='|' read -r -a grupo <<< $1
profile=${grupo[1]}
nombre=${grupo[0]}
socket_binding=${grupo[2]}

nombre=$(echo $nombre | sed -e "s/\[//")
socket_binding=$(echo $socket_binding | sed -e "s/\]//")

echo $nombre
echo $socket_binding

$2/bin/jboss-cli.sh -c controller=$3:9999 --command="/server-group=$nombre:add(profile=$profile,socket-binding-group=$socket_binding)"
$2/bin/jboss-cli.sh -c controller=$3:9999 --command="/server-group=$nombre/jvm=default:add()"
