#!/bin/bash
#
# run.sh
# Copyright (C) 2019 emilien <emilien@emilien-pc>
#
# Distributed under terms of the MIT license.
#

sh -c "cd ./tools && python2 pir.py" &
npm run production
