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
} &> /dev/null
echo running server! also sleeping for 5hrs...
{
java -Xmx4096M -Xms4096M -jar minecraft_server.jar nogui &
cd ..
sleep 5h
} &> /dev/null
echo uploading to dropbox...
{
7z a server.7z ./server
curl -X POST https://content.dropboxapi.com/2/files/upload --header "Authorization: Bearer $DROPBOX" --header "Dropbox-API-Arg: {\"path\": \"/server.7z\",\"mode\": \"overwrite\",\"autorename\": true,\"mute\": false,\"strict_conflict\": false}" --header "Content-Type: application/octet-stream" --data-binary @server.7z
} &> /dev/null
echo done!
