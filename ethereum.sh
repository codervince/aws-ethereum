#!/bin/bash -xe
# Launch Ethereum with the specified Network ID and a custom genesis block.
# Kenneth Falck <kennu@luottamuksenloyly.fi> 2016
cd /home/ubuntu
echo Initializing genesis block at `date` >> ethereum.log
env >> ethereum.log
geth init genesis.json >>ethereum.log 2>&1
echo Launching geth at `date` >> ethereum.log
geth --networkid "$1" --genesis ./genesis.json --nodiscover --support-dao-fork >>ethereum.log 2>&1 &
disown
