#!/bin/bash
#
# installer.sh
# Copyright (C) 2019 emilien <emilien@emilien-pc>
#
# Distributed under terms of the MIT license.
#

if [ "$EUID" -ne 0 ]
  then echo "Se script doit être lancer en tant qu'administrateur: sudo ./install.sh"
  exit 1
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export GQL_ENDPOINT="http://localhost:8080"

#apt update && apt install npm nodejs python pip -y

./bin/python entry.py && \
source "/tmp/viabird.temp.sh" && \
echo " -- Lance viabird au démarrage --" && \
cat $DIR/tools/viabird.service \
	 | sed "s/{{ PATH }}/$(echo $DIR | sed 's/\//\\\//g')/" \
	 | sed "s/{{ API_ENDPOINT }}/$(echo $GQL_ENDPOINT | sed 's/\//\\\//g')/" \
	 | sed "s/{{ CITY }}/$VIABIRD_CITY/" \
	 | sed "s/{{ ZIP_CODE }}/$VIABIRD_ZIP_CODE/" \
	 | sed "s/{{ API_KEY }}/$VIABIRD_API_KEY/" \
	 | sed "s/{{ MACHINE_ID }}/$(cat /etc/machine-id)/" \
	> /etc/systemd/system/viabird.service && \
systemctl daemon-reload && \
systemctl enable viabird.service && \
systemctl start viabird.service && \
echo "Viabird a bien été installer." && \
echo "/!\\ Changer l'emplacement de se dossier cassera l'installation de viabird."
