#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H%M")

echo "Message Taken"

IMAGE_PATH="/tmp/viabird.jpg"
raspistill -o "${IMAGE_PATH}" && curl -X POST -F "image=@${IMAGE_PATH}" http://127.0.0.1:80/images/upload && rm "${IMAGE_PATH}"
