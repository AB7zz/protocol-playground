require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config()

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.10",
  networks: {
    amoy_testnet: {
      url: process.env.AMOY_TESTNET,
      accounts: [process.env.PRIVATE_KEY],
    },
    sepolia_testnet: {
      url: process.env.SEPOLIA_TESTNET,
      accounts: [process.env.PRIVATE_KEY]
    }
  },
};
