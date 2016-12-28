#!/bin/sh
# Conncet to Ethereum CloudFormation deployed node 1
# Kenneth Falck <kennu@luottamuksenloyly.fi> 2016
TEAM_ID="LL"
NETWORK_ID="42424242"
ADDR=`aws --profile luottamus cloudformation describe-stacks --stack-name Ethereum-$TEAM_ID-$NETWORK_ID --query "Stacks[0].Outputs[?OutputKey=='Node1PublicDnsName'].OutputValue" --output text`
scp -i ethereum.pem -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no index.html ubuntu@$ADDR:/var/www/html/index.html
scp -i ethereum.pem -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ethereum.py ubuntu@$ADDR:/usr/lib/cgi-bin/ethereum.py
