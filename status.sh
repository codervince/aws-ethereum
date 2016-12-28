#!/bin/sh
# Check status of the Ethereum CloudFormation deployment
# Kenneth Falck <kennu@luottamuksenloyly.fi> 2016
TEAM_ID="$1"
if [ "$TEAM_ID" = "" ]; then
  echo 'Usage: deploy.sh <team-id>'
  echo 'Example: deploy.sh team01'
  exit
fi
ADDR=`aws --profile luottamus cloudformation describe-stacks --stack-name Ethereum-$TEAM_ID --query "Stacks[0].Outputs[?OutputKey=='Node1PublicDnsName'].OutputValue" --output text`
echo "Node1 deployed at http://$ADDR"
