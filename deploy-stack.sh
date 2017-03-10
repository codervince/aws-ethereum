#!/bin/sh
# Deploy the Ethereum CloudFormation template
# Kenneth Falck <kennu@luottamuksenloyly.fi> 2016
TEAM_ID="$1"
if [ "$TEAM_ID" = "" ]; then
  echo 'Usage: deploy-stack.sh <team-id>'
  echo 'Example: deploy-stack.sh team01'
  exit
fi
MASTER_ACCOUNT_ID="e986f163e65361be0f08aa48dcc3a7b12a57baf0"
NETWORK_ID="42424242"
DOMAIN="blockchain-bootcamp.com"
if [ "$TEAM_ID" = "master" -o "$TEAM_ID" = "corda" ]; then
  INSTANCE_TYPE="t2.medium"
else
  INSTANCE_TYPE="t2.micro"
fi
aws --profile luottamus cloudformation deploy --template-file ethereum-cf-stack.yml  --stack-name Ethereum-$TEAM_ID --parameter-overrides "TeamId=$TEAM_ID" "NetworkId=$NETWORK_ID" "KeyName=ethereum" "InstanceType=$INSTANCE_TYPE" "ImageId=ami-07174474" "VolumeSize=20" "AvailabilityZone=eu-west-1a" "Domain=$DOMAIN" "MasterAccountId=$MASTER_ACCOUNT_ID"
./status.sh "$TEAM_ID"
