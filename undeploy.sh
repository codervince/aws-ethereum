#!/bin/sh
# Deploy the Ethereum CloudFormation template
# Kenneth Falck <kennu@luottamuksenloyly.fi> 2016
TEAM_ID="LL"
NETWORK_ID="42424242"
aws --profile luottamus cloudformation delete-stack --stack-name Ethereum-$TEAM_ID-$NETWORK_ID
aws --profile luottamus cloudformation wait stack-delete-complete --stack-name Ethereum-$TEAM_ID-$NETWORK_ID
