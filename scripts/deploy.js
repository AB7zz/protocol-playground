
const hre = require("hardhat");

async function main() {

  const FlashLoan = await hre.ethers.deployContract("FlashLoan", ["0x012bAC54348C0E635dCAc9D5FB99f06F24136C9A"]);

  console.log('Deployed ', FlashLoan.target);

}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});


// USDC 0x94a9D9AC8a22534E3FaCa9F4e7F2E2cf85d5E4C8
// Contract 0x1Dd857bf484ae5f5dc2F467E4BdcE01B8F979eC0