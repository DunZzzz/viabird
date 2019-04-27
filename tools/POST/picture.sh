#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H%M")

echo "Message Taken"

fswebcam -r 1280x720 --no-banner /home/pi/POST/Picture.jpg && curl -X POST -F 'image=@/home/pi/POST/Picture.jpg' http://172.20.10.5:8080/api/images/upload

rm /home/pi/POST/Picture.jpg
