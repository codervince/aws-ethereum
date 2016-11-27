#!/bin/sh
# Deploy the Ethereum CloudFormation template
# Kenneth Falck <kennu@luottamuksenloyly.fi> 2016
TEAM_ID="LL"
NETWORK_ID="42424242"
aws --profile luottamus cloudformation deploy --template-file ethereum-cf-stack.yml  --stack-name Ethereum-$TEAM_ID-$NETWORK_ID --parameter-overrides "TeamId=$TEAM_ID" "NetworkId=$NETWORK_ID" "KeyName=ethereum" "InstanceType=t2.medium" "ImageId=ami-07174474" "VolumeSize=20" "AvailabilityZone=eu-west-1a"
aws --profile luottamus cloudformation describe-stacks --stack-name Ethereum-$TEAM_ID-$NETWORK_ID --query Stacks[0].Outputs[].OutputValue --output text
