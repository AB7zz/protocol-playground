require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config()

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.7.6",
  networks: {
    amoy_testnet: {
      url: process.env.AMOY_TESTNET,
      accounts: [process.env.PRIVATE_KEY],
    },
  },
};
