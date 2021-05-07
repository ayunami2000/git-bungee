#!/bin/bash
#apt update
#apt install p7zip-full
sleep 5
curl -X POST https://content.dropboxapi.com/2/files/download --header "Authorization: Bearer $DROPBOX" --header "Dropbox-API-Arg: {\"path\": \"/server.7z\"}"
ls
#sudo chmod +x pktriot
#echo $PKTRIOT>pktriot.json
#./pktriot --config ./pktriot.json start > /dev/null &
#echo Starting!
#java -Xmx4096M -Xms4096M -jar minecraft_server.jar nogui > /dev/null
sleep 15
echo $RANDOM>bruh.txt
curl -X POST https://content.dropboxapi.com/2/files/upload --header "Authorization: Bearer $DROPBOX" --header "Dropbox-API-Arg: {\"path\": \"/bruh.txt\",\"mode\": \"overwrite\",\"autorename\": true,\"mute\": false,\"strict_conflict\": false}" --header "Content-Type: application/octet-stream" --data-binary @bruh.txt
