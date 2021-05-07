#!/bin/bash
wget -O minecraft_server.jar https://papermc.io/api/v1/paper/1.16.5/latest/download
unzip server.zip
wget -O plugins/IllegalStack.jar https://api.spiget.org/v2/resources/44411/download
echo eula=true>eula.txt
sudo chmod +x pktriot
echo $PKTRIOT>pktriot.json
./pktriot --config ./pktriot.json start > /dev/null &
echo Starting!
java -Xmx4096M -Xms4096M -jar minecraft_server.jar nogui > /dev/null
