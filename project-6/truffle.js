if (process.env.NODE_ENV !== "production") {
	require("dotenv").config();
}
const HDWalletProvider = require("@truffle/hdwallet-provider");

const rinkebyProvider = function () {
	return new HDWalletProvider(
		process.env.RINKEBY_MNEMONIC,
		`https://rinkeby.infura.io/v3/${process.env.INFURA_PROJECT_ID}`
	);
};

module.exports = {
	networks: {
		development: {
			host: "127.0.0.1",
			port: 8545,
			network_id: "*", // Match any network id
		},
		rinkeby: {
			provider: rinkebyProvider,
			network_id: 4,
			confirmations: 1,
			skipDryRun: true,
		},
	},
	mocha: {
		timeout: 20000,
	},
	compilers: {
		solc: {
			version: "^0.8.0",
		},
	},
};
