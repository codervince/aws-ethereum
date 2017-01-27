#!/bin/sh
if [ -f "$HOME/Library/Application Support/Ethereum Wallet/binaries/Geth/unpacked/geth" ]; then
  # Mac
  exec "$HOME/Library/Application Support/Ethereum Wallet/binaries/Geth/unpacked/geth" --datadir "$HOME/Library/Ethereum-LL" --port 30301 --rpcport 8645 --wsport 8646 --networkid 42424242 --fast --cache 512 --ipcpath $HOME/Library/Ethereum/geth.ipc --bootnodes enode://eeab46b802c5462f8aa75c7384bcb5d1b127b4e7365ae3b774595da23f5c3a22985acdc481432c91eca0618210a7d6ef6c2a711ebe4718f36b64bd15969540f6@52.208.196.206:30301 console
else
  # Linux
  exec geth --datadir "$HOME/.ethereum-ll" --port 30301 --rpcport 8645 --wsport 8646 --networkid 42424242 --fast --cache 512 --ipcpath "$HOME/.ethereum/geth.ipc" --bootnodes enode://eeab46b802c5462f8aa75c7384bcb5d1b127b4e7365ae3b774595da23f5c3a22985acdc481432c91eca0618210a7d6ef6c2a711ebe4718f36b64bd15969540f6@52.208.196.206:30301 console
fi
