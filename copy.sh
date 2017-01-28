#!/bin/sh
# Copy updated files to Ethereum CloudFormation deployed node 1
# Kenneth Falck <kennu@luottamuksenloyly.fi> 2016-2017
TEAM_ID="$1"
if [ "$TEAM_ID" = "" ]; then
  echo 'Usage: copy.sh <team-id>'
  echo 'Example: copy.sh team01'
  exit
fi
if [ "$TEAM_ID" = "master" ]; then
  ADDR='master.blockchain-bootcamp.com'
else
  ADDR=`aws --profile luottamus cloudformation describe-stacks --stack-name Ethereum-$TEAM_ID --query "Stacks[0].Outputs[?OutputKey=='Node1PublicDnsName'].OutputValue" --output text`
fi
scp -i ll-ethereum.pem -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no cloud/index.html ubuntu@$ADDR:/var/www/html/index.html
scp -i ll-ethereum.pem -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no cloud/ethereum.py ubuntu@$ADDR:/usr/lib/cgi-bin/ethereum.py
scp -i ll-ethereum.pem -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no cloud/ethereum.sh ubuntu@$ADDR:ethereum.sh
