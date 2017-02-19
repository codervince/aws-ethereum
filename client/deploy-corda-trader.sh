#!/bin/sh
# Deploy the trader-demo nodeb to team cloud server
. /etc/ll-env
scp -ri $HOME/ll-ethereum.pem -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $HOME/corda/samples/trader-demo/build/nodes/nodeb ubuntu@$TEAM_ID.blockchain-bootcamp.com:
