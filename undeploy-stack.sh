#!/bin/sh
# Deploy the Ethereum CloudFormation template
# Kenneth Falck <kennu@luottamuksenloyly.fi> 2016
TEAM_ID="$1"
if [ "$TEAM_ID" = "" ]; then
  echo 'Usage: deploy.sh <team-id>'
  echo 'Example: deploy.sh team01'
  exit
fi
aws --profile luottamus cloudformation delete-stack --stack-name Ethereum-$TEAM_ID
aws --profile luottamus cloudformation wait stack-delete-complete --stack-name Ethereum-$TEAM_ID
