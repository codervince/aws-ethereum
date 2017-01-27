#!/bin/sh
# Copy the client scripts to blockchain-bootcamp.com/files for downloading.
for ff in connect.sh geth.sh; do
  aws --profile luottamus s3 cp $ff s3://blockchain-bootcamp/files/$ff
done
