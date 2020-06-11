#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Viabird is running"
# TODO: fix photo script
# ./bin/python tools/pir.py

while true; do
	echo "Executing photo script";
	"$DIR/tools/test.sh";
	sleep 60
done

