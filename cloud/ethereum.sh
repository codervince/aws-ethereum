#!/bin/bash -xe
# Launch Ethereum with the specified Network ID and a custom genesis block.
# Kenneth Falck <kennu@luottamuksenloyly.fi> 2016-2017
cd /home/ethereum
echo "----------------------------------------------------------------------" >> ethereum.log
if [ ! -f $HOME/.ssh/id_rsa ]; then
  echo 'SSH key missing!'
fi
echo Detecting IP address >> ethereum.log
curl -s -o /var/www/html/ip.json 'https://api.ipify.org?format=json'
echo Downloading JDK >> ethereum.log
if [ ! -d /opt/jdk ]; then
  curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k "http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz" >> ethereum.log 2>&1
  tar xzvf jdk-8u121-linux-x64.tar.gz
  sudo mv jdk1.8.0_121 /opt/jdk
fi
PUBLICIP=`curl -s https://api.ipify.org`
NATOPTION="--nat=extip:$PUBLICIP"
echo Initializing genesis block at `date` >> ethereum.log
geth init genesis.json >>ethereum.log 2>&1
echo Launching geth at `date` >> ethereum.log
mkdir -p /home/ethereum/.ethereum/keystore

curl -s -o /home/ethereum/account.passwd https://blockchain-bootcamp.com/files/cloud/account.passwd
if [ "$TEAM_ID" = "master" ]; then
  # Use predefined master account
  curl -o /home/ethereum/.ethereum/keystore/UTC--2016-12-28T17-28-02.207258170Z-$MASTER_ACCOUNT_ID https://blockchain-bootcamp.com/files/cloud/account.json
  BOOTNODES=""
  UNLOCK="--unlock $MASTER_ACCOUNT_ID"
else
  # Create a random account for this node
  geth --password /home/ethereum/account.passwd account new
  BOOTNODES=`curl -s -d 'op=bootnode' http://master.blockchain-bootcamp.com/cgi-bin/ethereum.py`
  UNLOCK="--unlock 0"
fi
geth --port 30301 --networkid "$NETWORK_ID" $NATOPTION $BOOTNODES $UNLOCK --password /home/ethereum/account.passwd --mine --minerthreads=1 >>ethereum.log 2>&1 &
disown
sleep 5
geth --exec 'console.log(JSON.stringify(admin.nodeInfo, null, 2))' attach | head -n -1 > /var/www/html/nodeinfo.json
