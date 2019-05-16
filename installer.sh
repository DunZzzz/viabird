#!/bin/bash
#
# installer.sh
# Copyright (C) 2019 emilien <emilien@emilien-pc>
#
# Distributed under terms of the MIT license.
#

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

apt update && apt install npm nodejs -y

cat $DIR/tools/viabird.service | sed "s/{{ PATH }}/$(echo $DIR | sed 's/\//\\\//g')/" > /etc/systemd/system/viabird.service

sudo systemctl daemon-reload
sudo systemctl enable viabird.service
sudo systemctl start viabird.service
