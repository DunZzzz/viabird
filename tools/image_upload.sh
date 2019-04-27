#!/bin/bash

#
# image_upload.sh
# Copyright (C) 2018 emilien <emilien@emilien-pc>
#
# Distributed under terms of the MIT license.
#

if [ ${#1} -eq 0 ]; then
	echo "Error" 1>&2
	exit 1;
fi

#curl http://localhost:8080/images/upload -X POST -F "image=@$1" | jq
