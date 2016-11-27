# Running a custom Ethereum client connected to the AWS nodes

## Step 1: Install Ethereum Wallet

Install from https://github.com/ethereum/mist/releases

* Ethereum Wallet: The wallet application
* Mist: Application platform for custom wallets (optional)

## Step 2: Backup your existing wallet data (optional)

If you already have Ethereum account(s) in your wallet, you probably want
to ensure they are backed up before using the custom test network.

The wallet data is stored in this folder:

    $HOME/Library/Ethereum/keystore

- Install Ethereum Wallet on a new computer. Wait for the installation to
  complete and then close the application.
- Copy files from your old computer's keystore folder to the same folder on the
  new computer.
- Start Ethereum Wallet on the new computer and check that the wallet works.

## Step 3: Customize geth

In order to connect to a custom blockchain, you need to run a new geth instance
with new parameters overriding the defaults. You also need to initialize the
custom blockchain with the correct genesis block.

To initialize the genesis block, run this in Terminal:

    "$HOME/Library/Application Support/Ethereum Wallet/binaries/Geth/unpacked/geth" --datadir $HOME/Library/Ethereum-LL init genesis.json

To start geth, run this in Terminal:

    "$HOME/Library/Application Support/Ethereum Wallet/binaries/Geth/unpacked/geth" --fast --cache 512 --support-dao-fork --datadir $HOME/Library/Ethereum-LL --port 30301 --rpcport 8645 --wsport 8646 --networkid 42424242 --ipcpath $HOME/Library/Ethereum/geth.ipc --bootnodes enode://NODEID@NODEADDR:30303 console

Note: You need to get the correct NODEID and NODEADDR and replace them in the command line.

The new parameters specified for the custom blockchain network are:

* New data dir is $HOME/Library/Ethereum-LL
* New RPC port is 8645
* New WS-RPC port is 8646
* New listening port is 30301
* New network identifier is 42424242
* IPC path is still the old path so that Ethereum Wallet and Mist can connect
