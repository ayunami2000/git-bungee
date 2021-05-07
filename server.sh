#!/bin/bash
echo downloading from dropbox...
{
curl -X POST https://content.dropboxapi.com/2/files/download --header "Authorization: Bearer $DROPBOX" --header "Dropbox-API-Arg: {\"path\": \"/server.7z\"}" -o server.7z
7z x server.7z
rm -rf server.7z
} &> /dev/null
echo running pktriot...
{
sudo chmod +x pktriot
echo $PKTRIOT>pktriot.json
./pktriot --config ./pktriot.json start &
cd server
7z x freeop.7z
} &> /dev/null
echo running servers! also sleeping for 5hrs...
{
java -Xmx512M -Xms512M -jar BungeeCord.jar nogui &
cd lobby
java -Xmx2048M -Xms2048M -jar server.jar nogui &
cd ..
cd freeop
java -Xmx2048M -Xms2048M -jar server.jar nogui &
cd ..
sleep 5h
} &> /dev/null
echo uploading to dropbox...
{
rm -rf ./freeop
cd ..
7z a server.7z ./server
curl -X POST https://content.dropboxapi.com/2/files/upload --header "Authorization: Bearer $DROPBOX" --header "Dropbox-API-Arg: {\"path\": \"/server.7z\",\"mode\": \"overwrite\",\"autorename\": true,\"mute\": false,\"strict_conflict\": false}" --header "Content-Type: application/octet-stream" --data-binary @server.7z
} &> /dev/null
echo done!
