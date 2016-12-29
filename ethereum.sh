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
mkdir -p /home/ubuntu/.ethereum/keystore
curl -o /home/ubuntu/account.passwd https://raw.githubusercontent.com/luottamus/aws-ethereum/master/account.passwd
if
if [ "$TEAM_ID" = "master" ]; then
  # Use predefined master account
  curl -o /home/ubuntu/.ethereum/keystore/UTC--2016-12-28T17-28-02.207258170Z-$MASTER_ACCOUNT_ID https://raw.githubusercontent.com/luottamus/aws-ethereum/master/account.json
  BOOTNODES=""
  UNLOCK="--unlock $MASTER_ACCOUNT_ID"
else
  # Create a random account for this node
  geth --password /home/ubuntu/account.passwd account new
  BOOTNODES=`curl -s -d 'op=bootnode' http://master.ethereum.luottamuksenloyly.fi/cgi-bin/ethereum.py`
  UNLOCK=""
fi
geth --port 30301 --networkid "$NETWORK_ID" $BOOTNODES $UNLOCK --password /home/ubuntu/account.passwd --mine --minerthreads=1 >>ethereum.log 2>&1 &
disown
sleep 5
geth --exec 'console.log(JSON.stringify(admin.nodeInfo, null, 2))' attach | head -n -1 > /var/www/html/nodeinfo.json
