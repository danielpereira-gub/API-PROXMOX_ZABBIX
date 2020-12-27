#!/bin/bash

###COLOCAR HOST ID###

decodeDataFromJson(){
    echo `echo $1 \
            | sed 's/{\"data\"\:{//g' \
            | sed 's/\\\\\//\//g' \
            | sed 's/[{}]//g' \
            | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' \
            | sed 's/\"\:\"/\|/g' \
            | sed 's/[\,]/ /g' \
            | sed 's/\"// g' \
            | grep -w $2 \
            | awk -F "|" '{print $2}'`
}


PROX_USERNAME=root@pam
PROX_PASSWORD=gub@2019
NOME_PROX=proxmoxgub02
IP_PROX=172.20.10.33

URL='http://186.216.240.42/api_jsonrpc.php'
HEADER='Content-Type:application/json'
USER='"Daniel"'
PASS='"leinad0805115405"'

##TICKET PROXMOX
DATA=$(curl https://$IP_PROX:8006/api2/json/access/ticket -k -d 'username='$PROX_USERNAME'&password='$PROX_PASSWORD'')
TICKET=$(decodeDataFromJson $DATA 'ticket')
CSRF=$(decodeDataFromJson $DATA 'CSRFPreventionToken')

json=$(curl -k -b "PVEAuthCookie="$TICKET"" https://$IP_PROX:8006/api2/json/nodes/$NOME_PROX/qemu)


###ENVIANDO TICKET PARA O ZABBIX###

autenticacao()
{
        JSON='
        {
                "jsonrpc": "2.0",
                "method":"user.login",
                "params": {
                        "user": '$USER',
                        "password": '$PASS'
                },
                "id": 0
        }
        '

        curl -s -X POST -H "$HEADER" -d "$JSON" "$URL" | cut -d '"' -f8
}
TOKEN=$(autenticacao)

echo "$TOKEN"

MACRO()
{
        JSON1='
        {
                "jsonrpc": "2.0",
                "method":  "host.update",
                "params": {
                        "hostid": "10418",
                        "macros": [
                           {
                                "macro": "{$TICKET2}",
                                "value": "'$TICKET'"
                          },
                           {
                                "macro": "{$IP}",
                                "value": "'$IP_PROX'"
                          },
                           {
                                "macro": "{$NOME}",
                                "value": "'$NOME_PROX'"
                          }
                        ]
                },
                "auth": "'$TOKEN'",
                "id": 1
        }
        '
        curl -s -X POST -H "$HEADER" -d "$JSON1" "$URL"

}
