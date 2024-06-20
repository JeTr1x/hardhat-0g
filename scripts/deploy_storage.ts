import { ethers } from 'hardhat';

async function main() {
  const contract = await ethers.deployContract('SimpleStorage');

  await contract.waitForDeployment();

  console.log('SimpleStorage Contract Deployed at ' + contract.target);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
