# profit-blockchain (PROFIT)

![Alt Profit Logo](https://github.com/ProfitCrypto/profit-blockchain/raw/main/profit-blockchain-gui/src/assets/img/profit_circle.png)

Profit (PROFIT) is a modern, green cryptocurrency built to be efficient, decentralized, and secure.


## Useful Links

- [Profit Website](https://www.profitcrypto.net/) - Visit the Profit Website
- [Profit FAQ](https://www.profitcrypto.net/faq) - Find answers to Frequently Asked Questions
- [Profit Calculator](https://chiaforkscalculator.com/) - Estimate out how your Profit earnings.
- [Profit Blockchain DB](https://www.profitcrypto.net//blockchain_v1_mainnet.sqlite) - Download the latest Profit Blockchain Database


## Social Links
- [Discord](https://discord.gg/wVAd75mJYR) - Join the Profit Discord Community
- [Twitter](https://twitter.com/ProfitCryptoNet) - Follow Profit on Twitter


## How to Install

Profit Executable are available from our [GitHub Releases Page](https://github.com/ProfitCrypto/profit-blockchain/releases). You can also build from source. An example case for Ubuntu source installation is provided below. Please [visit our wiki page](https://github.com/ProfitCrypto/profit-blockchain/wiki) for more details, and for source installation on operating systems.

```
# Update, install GIT, clone Profit repo

   sudo apt-get update
   sudo apt install git -y
   git clone https://github.com/ProfitCrypto/profit-blockchain.git
  
# Install Profit Blockchain

   cd profit-blockchain
   sh install.sh
   . ./activate
   profit init

# Install Profit GUI

   sh install-gui.sh
   cd profit-blockchain-gui
   npm run electron &
```

If the Profit client is unable to find peers automatically, please connect to the following official peers:

- introducer.profitcrypto.net / Port: 48444
- dns-introducer.profitcrypto.net / Port: 48444


## How to Stake

1. Query the staking addresses according to your farming plot list:

   ```
   $ profit farm summary
   ...
   Staking addresses:
     profit1x6jjvepyvjv7395nmtywvx9mknshgy78dsmuu38m0e9grxr080nsltjugr (balance: 0, plots: 27)
   ...
   ```

2. Deposit coins to the staking address:

   ```
   $ profit wallet send -t profit1x6jjvepyvjv7395nmtywvx9mknshgy78dsmuu38m0e9grxr080nsltjugr -a 1
   ```

   Wait for the transaction get confirmed, query staking balance again:

   ```
   $ profit farm summary
   ...
   Staking addresses:
     profit1x6jjvepyvjv7395nmtywvx9mknshgy78dsmuu38m0e9grxr080nsltjugr (balance: 1, plots: 27)
   ...
   ```

3. Withdraw coins from the staking address:

   ```
   $ profit wallet send_from -s profit1x6jjvepyvjv7395nmtywvx9mknshgy78dsmuu38m0e9grxr080nsltjugr -t $RECEIVER
   ```

   Do a transaction to transfer the coins from the staking address to any receive address.

   Make sure to choose the wallet that contains the plot farmer key.
