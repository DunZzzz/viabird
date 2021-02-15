#!/bin/bash

set -e

DATE=$(date +"%Y-%m-%d_%H%M")

echo "Message Taken" $VIABIRD_MACHINE_ID

IMAGE_PATH="/tmp/viabird.jpg"
raspistill -o "${IMAGE_PATH}" &&\
	curl -X POST "${VIABIRD_API_ENDPOINT}/upload" \
		-H "clearance-token:${VIABIRD_API_KEY}" \
		-F "file=@${IMAGE_PATH}"  \
		-F "machine_id=${VIABIRD_MACHINE_ID}" \
		-F "zip_code=${VIABIRD_ZIP_CODE}" \
		-F "city=${VIABIRD_CITY}" \

echo "Image succesfully sent to viabird.eu"
