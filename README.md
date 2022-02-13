# Udacity Blockchain Nanodegree Project 3
## Project Overview
The [contract address](https://rinkeby.etherscan.io/address/0x8c1e8f207d4e45d94a1ed2da03e79e9982b2c7ae) - `0x8c1e8f207d4e45d94a1ed2da03e79e9982b2c7ae`

### Frontend
Run the project frontend using the command below
```
cd project-6
npm install
npm run dev
```

### Backend
To deploy the SupplyChain contract on the Rinkeby test network, run the following command:

```
truffle migrate --reset --network rinkeby
```

Ensure you have created an [Infura](https://infura.io/) project. Go to settings to retrieve your project key. Also, retrieve your Rinkeby endpoint from the project settings.

Finally, you should create a `.env` file with the following values:
```
INFURA_PROJECT_ID="[REDACTED]"
RINKEBY_MNEMONIC="[REDACTED]"
```


To run the test suite, use the following command:
```
truffle test
```

### UML Documents

[UML documents folder](https://ipfs.io/ipfs/QmS8vy9Rg62FymHqv3wvUrE21ij9piNepFWoZv9XzP7mT8)

[Activity](https://ipfs.io/ipfs/QmS7BkuTqHxj6VaTeGiD5FYZJYpvsmA4FJyGMbx2o2LTja?filename=activity.png) - actors and interactions

[Sequence](https://ipfs.io/ipfs/QmQ6Qeqfypt2mitAtUPj3pABtHGiq4bkdud1Xsr9scmrHc?filename=sequence.png) - Functions

[State](https://ipfs.io/ipfs/QmZNw29nyVbm5iMfZcRZd6WwjHcZ14XD3KoBZL5UyZ8rBx?filename=state.png) - Enums of asset states

[Class](https://ipfs.io/ipfs/QmaWP7vw7FEajyxp5VbKjnBK9eiKag389isYugs9DDTBzD?filename=class.png) (Data Model) - Databases

### Libraries
`dotenv` - To manage environment variables

### IPFS
[IPFS](https://ipfs.io/) is used to host the UML documents for this project

### Transaction history
Harvested - [0x9d73dfc50611adfe02501fc23684c5965a2bd5ac7d19b2582bd13194fe2e50fd](https://rinkeby.etherscan.io/tx/0x9d73dfc50611adfe02501fc23684c5965a2bd5ac7d19b2582bd13194fe2e50fd)

Processed - [0xcba7c91e6a9eac4fdcea57fe7067463973cadde2057180c0d1a97531ca5bb3d7](https://rinkeby.etherscan.io/tx/0xcba7c91e6a9eac4fdcea57fe7067463973cadde2057180c0d1a97531ca5bb3d7)

Packed - [0xf4265d454cd7f53dc8cb523f00131e7e9ae7d7cfcac099a6c96ef3113313686b](https://rinkeby.etherscan.io/tx/0xf4265d454cd7f53dc8cb523f00131e7e9ae7d7cfcac099a6c96ef3113313686b)

ForSale - [0xecfb625504d3f128d8c98db77fc0fabd951634464389cd6058e3f62414f48729](https://rinkeby.etherscan.io/tx/0xecfb625504d3f128d8c98db77fc0fabd951634464389cd6058e3f62414f48729)

Sold - [0x64869d764bcde57aa16d422114d0e83d1d7677bf66c3957ff7f8e2052599d6d3](https://rinkeby.etherscan.io/tx/0x64869d764bcde57aa16d422114d0e83d1d7677bf66c3957ff7f8e2052599d6d3)

Shipped - [0x56dd3ce3bed2eefe3e1aafccc64f1c3c691e3f71b5b7f6aa58f1a3d3a3d2044d](https://rinkeby.etherscan.io/tx/0x56dd3ce3bed2eefe3e1aafccc64f1c3c691e3f71b5b7f6aa58f1a3d3a3d2044d)

Received - [0x9381b22b352912e7c0c9b38c94f931a3ae67fdd812acd055f1b8b2e10a9b21ba](https://rinkeby.etherscan.io/tx/0x9381b22b352912e7c0c9b38c94f931a3ae67fdd812acd055f1b8b2e10a9b21ba)

Purchased - [0x83f63d857f81f6ccd0715ec27f72710b882c12d2eb8e02d31e7d50f749171072](https://rinkeby.etherscan.io/tx/0x83f63d857f81f6ccd0715ec27f72710b882c12d2eb8e02d31e7d50f749171072)


### Tools
Truffle v5.4.29 (core: 5.4.29)

Solidity v0.5.16 (solc-js)

Node v16.13.2

Web3.js v1.5.3