import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require('dotenv').config();

const config: HardhatUserConfig = {
  solidity: {
        compilers: [
      {
        version: "0.8.19"
      },
      {
        version: "0.8.20"
      }
    ]
  },
  networks: {
    "zerogravity": {
       url: "https://rpc-testnet.0g.ai",
       accounts: [process.env.PRIVATE_KEY as string],
       gasPrice: 1000000000,
    },
  },
  etherscan: {
    apiKey: {
      zerogravity: "abc"
    },
    customChains: [
      {
        network: "zerogravity",
        chainId: 16600,
        urls: {
          apiURL: "",
          browserURL: "https://chainscan-newton.0g.ai",
        }
      }
    ]
  },
  defaultNetwork: 'zerogravity',
};

export default config;
