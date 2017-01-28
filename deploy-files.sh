#!/bin/sh
# Copy client and cloud node files to blockchain-bootcamp.com/files for downloading.
for ff in connect.sh geth.sh; do
  aws --profile luottamus s3 cp client/$ff s3://blockchain-bootcamp/files/client/$ff
done

for ff in account.passwd account.json genesis.json ethereum.sh ethereum.py index.html; do
  aws --profile luottamus s3 cp cloud/$ff s3://blockchain-bootcamp/files/cloud/$ff
done
