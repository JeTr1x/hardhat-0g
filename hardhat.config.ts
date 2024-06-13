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
    "morph": {
       url: "https://rpc-testnet.morphl2.io",
       accounts: [process.env.PRIVATE_KEY as string],
       gasPrice: 1500000000,
    },
  },
  etherscan: {
    apiKey: {
      morph: "abc"
    },
    customChains: [
      {
        network: "morph",
        chainId: 2710,
        urls: {
          apiURL: "https://explorer-api-testnet.morphl2.io/api",
          browserURL: "https://explorer-testnet.morphl2.io",
        }
      }
    ]
  },
  defaultNetwork: 'morph',
};

export default config;
