#!/bin/bash -xe
# Launch Ethereum with the specified Network ID and a custom genesis block.
# Kenneth Falck <kennu@luottamuksenloyly.fi> 2016
cd /home/ubuntu
geth init genesis.json
geth --networkid "$1"
