git pull && npm install

while true; do
	NODE_ENV=production node .
	echo "Restarting Server in 5 seconds ...";
	sleep 5;
done
