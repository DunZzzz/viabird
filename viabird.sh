#!/bin/bash
#
# wget_install.sh
# Copyright (C) 2019 emilien <emilien@emilien-pc>
#
# Distributed under terms of the MIT license.
#

set -e

apt update && apt install git -y

cd ~ && git clone https://github.com/DunZzzz/viabird.git

./viabird/installer.sh
