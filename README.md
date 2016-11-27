# Ethereum deployment scripts on AWS CloudFormation
Kenneth Falck <kennu@luottamuksenloyly.fi> 2016

## Overview

These scripts are designed for launching a private Ethereum blockchain on AWS
CloudFormation.

## Pre-requisites

Install AWS CLI:

    pip install awscli

Create an AWS profile called "luottamus" to ensure that the deployment scripts
work out-of-the-box. Instructions can be found at:
http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html

## Deploying the stack

This command will create the servers and print out the public IP addresses:

    ./deploy.sh

## Undeploying the stack

This command will delete everything:

    ./undeploy.sh
