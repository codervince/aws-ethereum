#!/bin/bash -xe
# Launch Ethereum with the specified Network ID and a custom genesis block.
# Kenneth Falck <kennu@luottamuksenloyly.fi> 2016
cd /home/ubuntu
echo "----------------------------------------------------------------------" >> ethereum.log
echo Detecting IP address >> ethereum.log
curl -s -o /var/www/html/ip.json 'https://api.ipify.org?format=json'
echo Initializing genesis block at `date` >> ethereum.log
geth init genesis.json >>ethereum.log 2>&1
echo Launching geth at `date` >> ethereum.log
geth --networkid "$NETWORK_ID" --support-dao-fork >>ethereum.log 2>&1 &
disown
sleep 5
geth --exec 'console.log(JSON.stringify(admin.nodeInfo, null, 2))' attach | head -n -1 > /var/www/html/nodeinfo.json
