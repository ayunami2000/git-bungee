#!/bin/bash
sleep 5
curl -X POST https://content.dropboxapi.com/2/files/download --header "Authorization: Bearer $DROPBOX" --header "Dropbox-API-Arg: {\"path\": \"/server.7z\"}"
7z e server.7z
rm -rf server.7z
ls
#sudo chmod +x pktriot
#echo $PKTRIOT>pktriot.json
#./pktriot --config ./pktriot.json start > /dev/null &
#echo Starting!
cd server
echo $RANDOM>test.txt
#java -Xmx4096M -Xms4096M -jar minecraft_server.jar nogui > /dev/null
cd ..
sleep 15
7z a server.7z ./server
curl -X POST https://content.dropboxapi.com/2/files/upload --header "Authorization: Bearer $DROPBOX" --header "Dropbox-API-Arg: {\"path\": \"/server.7z\",\"mode\": \"overwrite\",\"autorename\": true,\"mute\": false,\"strict_conflict\": false}" --header "Content-Type: application/octet-stream" --data-binary @server.7z
