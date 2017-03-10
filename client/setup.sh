#!/bin/sh
# Setup a VirtualBox appliance client for a specific team
# Kenneth Falck <kennu@luottamuksenloyly.fi> 2016-2017
set -e

if [ "x$1" = "x-c" ]; then
  # Clear all previously generated setup.
  echo 'Clearing all settings...'
  rm -rf "$HOME/.aws" "$HOME/.ethereum-ll" "$HOME/.config/Mist" "$HOME/.config/Ethereum Wallet" ll-ethereum.pem ll-credentials.csv geth.sh connect.sh genesis.json
  sudo rm -f /etc/ll-env
  exit
fi

echo '-------------------------------------------------------------------------'
echo 'Welcome to Blockchain Bootcamp setup!'

# Ask for setup password
while [ ! -f ll-ethereum.pem -o ! -f ll-credentials.csv ]; do
  echo '-------------------------------------------------------------------------'
  echo -n 'Please enter your setup password: '
  read PASSWORD
  gpg --passphrase "$PASSWORD" --batch --yes -d -o ll-ethereum.pem ll-ethereum.pem.asc
  gpg --passphrase "$PASSWORD" --batch --yes -d -o ll-credentials.csv ll-credentials.csv.asc
  if [ ! -f ll-ethereum.pem -o ! -f ll-credentials.csv ]; then
    echo '-------------------------------------------------------------------------'
    echo 'Looks like something went wrong! Please try again.'
  fi
done

chmod 600 ll-ethereum.pem

TEAM_ID=''

# Ask for team identifier
echo '-------------------------------------------------------------------------'
while [ "x$TEAM_ID" = "x" ]; do
  echo -n 'Please enter your team id (e.g. team01): '
  read TEAM_ID
done

# Setup team identifier (store in /etc/llenv)
echo "Setting up client appliance as $TEAM_ID."
echo TEAM_ID="$TEAM_ID" | sudo tee /etc/ll-env >/dev/null

# Install/update additional scripts
echo "Downloading additional files..."
for ff in connect.sh geth.sh; do
  curl -f -o "$ff" "https://blockchain-bootcamp.com/files/client/$ff" >/dev/null
  chmod 755 "$ff"
done
curl -f -o "genesis.json" "https://blockchain-bootcamp.com/files/cloud/genesis.json" >/dev/null

if [ -d "$HOME/.ethereum-ll" ]; then
  echo "Ethereum data directory already exists, using existing Genesis block."
else
  echo "Initializing Ethereum genesis block..."
  geth --datadir "$HOME/.ethereum-ll" init "genesis.json"
fi

# Setup completed.
echo '-------------------------------------------------------------------------'
echo "Setup completed. You can run ./setup.sh again if needed. Have a nice day!"
echo '-------------------------------------------------------------------------'
