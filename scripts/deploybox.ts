import { ethers } from 'hardhat';

async function main() {
  const nft = await ethers.deployContract('Box');

  await nft.waitForDeployment();

  console.log('BOX Contract Deployed at ' + nft.target);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
