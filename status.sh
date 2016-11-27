#!/bin/sh
# Check status of the Ethereum CloudFormation deployment
# Kenneth Falck <kennu@luottamuksenloyly.fi> 2016
TEAM_ID="LL"
NETWORK_ID="42424242"
ADDR=`aws --profile luottamus cloudformation describe-stacks --stack-name Ethereum-$TEAM_ID-$NETWORK_ID --query "Stacks[0].Outputs[?OutputKey=='Node1PublicDnsName'].OutputValue" --output text`
echo "Node1 deployed at http://$ADDR"
