
const hre = require("hardhat");

async function main() {

  const SingleSwapCF = await hre.ethers.getContractFactory("SingleSwap");
  const SingleSwap = await SingleSwapCF.deploy();

  await SingleSwap.deployed()

  console.log('Deployed');
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
