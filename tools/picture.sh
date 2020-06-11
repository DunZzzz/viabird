#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H%M")

echo "Message Taken"

IMAGE_PATH="/tmp/viabird.jpg"
raspistill -o "${IMAGE_PATH}" \
	&& curl -X POST -F "image=@${IMAGE_PATH}" "${VIABIRD_API_ENDPOINT}/upload" \
	-H "clearance-token:${VIABIRD_API_KEY}" \
	-F "zip_code:${VIABIRD_ZIP_CODE}" \
	-F "machine_id:${VIABIRD_MACHINE_ID}" \
	-F "city:${VIABIRD_CITY}" \
	&& rm "${IMAGE_PATH}"
