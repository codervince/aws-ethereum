#!/bin/sh
# Check status of the Ethereum CloudFormation deployment
# Kenneth Falck <kennu@luottamuksenloyly.fi> 2016
TEAM_ID="LL"
NETWORK_ID="42424242"
aws --profile luottamus cloudformation describe-stacks --stack-name Ethereum-$TEAM_ID-$NETWORK_ID
