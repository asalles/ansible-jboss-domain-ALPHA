#/bin/bash
#set -x

JCPASSWORD=$(echo -n $3 | base64)

$1/bin/jboss-cli.sh --connect controller=$2:9999 -c "/host=master/core-service=management/security-realm=ManagementRealm/server-identity=secret:add(value=\"$JCPASSWORD\")"
