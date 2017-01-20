#!/bin/sh
# Connect to Ethereum CloudFormation deployed node 1
# Kenneth Falck <kennu@luottamuksenloyly.fi> 2016-2017
[ -f /etc/ll-env ] && . /etc/ll-env
if [ "$TEAM_ID" = "" ]; then
  TEAM_ID="$1"
fi
if [ "$TEAM_ID" = "" ]; then
  echo 'Usage: connect.sh [team-id]'
  echo 'Example: connect.sh team01'
  exit
fi
if [ "$TEAM_ID" = "master" ]; then
  ADDR='master.ethereum.luottamuksenloyly.fi'
else
  ADDR=`aws cloudformation describe-stacks --stack-name Ethereum-$TEAM_ID --query "Stacks[0].Outputs[?OutputKey=='Node1PublicDnsName'].OutputValue" --output text`
fi
ssh -i ll-ethereum.pem -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ubuntu@$ADDR
