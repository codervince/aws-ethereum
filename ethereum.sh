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
geth --port 30301 --networkid "$NETWORK_ID" >>ethereum.log 2>&1 &
mkdir -p /home/ubuntu/.ethereum/keystore
curl -o /home/ubuntu/.ethereum/keystore/UTC--2016-12-28T17-28-02.207258170Z-48d8b7b8cd25ce99c6db70e1e373e6bfb51d1fbf https://raw.githubusercontent.com/luottamus/aws-ethereum/master/account.json
disown
sleep 5
geth --exec 'console.log(JSON.stringify(admin.nodeInfo, null, 2))' attach | head -n -1 > /var/www/html/nodeinfo.json
