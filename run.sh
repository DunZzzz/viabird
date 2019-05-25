#!/bin/bash
#
# run.sh
# Copyright (C) 2019 emilien <emilien@emilien-pc>
#
# Distributed under terms of the MIT license.
#

npm run production &
cd ./tools && python2 pir.py
