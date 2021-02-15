#!/bin/bash
#
# installer.sh
# Copyright (C) 2019 emilien <emilien@emilien-pc>
#
# Distributed under terms of the MIT license.
#

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export GQL_ENDPOINT="http://viabird.eu:8080"

echo "Pre-installation de viabird..."
echo "Entrer votre mot de passe administrateur:"
sudo apt update
sudo apt install python python3-pip python2-pip python2 -y

pip install PyInquirer art requests > /dev/null
pip2 install RPi.GPIO > /dev/null

python entry.py
source "/tmp/viabird.temp.sh"
echo " -- Lance viabird au démarrage --"
cat $DIR/tools/viabird.service \
	 | sed "s/{{ PATH }}/$(echo $DIR | sed 's/\//\\\//g')/" \
	 | sed "s/{{ API_ENDPOINT }}/$(echo $GQL_ENDPOINT | sed 's/\//\\\//g')/" \
	 | sed "s/{{ CITY }}/$VIABIRD_CITY/" \
	 | sed "s/{{ ZIP_CODE }}/$VIABIRD_ZIP_CODE/" \
	 | sed "s/{{ API_KEY }}/$VIABIRD_API_KEY/" \
	 | sed "s/{{ MACHINE_ID }}/$(cat /etc/machine-id)/" \
	> /tmp/viabird.service
sudo mv /tmp/viabird.service /etc/systemd/system/viabird.service
sudo systemctl daemon-reload
sudo systemctl enable viabird.service
sudo systemctl start viabird.service
echo "Viabird a bien été installer."
echo "** Attention! changer l'emplacement de ce dossier cassera l'installation de viabird. **"
