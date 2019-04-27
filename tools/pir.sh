fswebcam -r 1280x720 --no-banner Picture.jpg
curl -X POST -F "file_name=Picture" -F 'file_image=@/home/pi/Picture/Picture.jpg' http://localhost:8000/add