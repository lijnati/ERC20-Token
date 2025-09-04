import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox-viem";  // Changed import
import "dotenv/config";

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.20",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  networks: {
    // ... your network configurations
  }
};

export default config;








// networks: {  
//     localhost: {  
//       url: "http://127.0.0.1:8545"  
//     },  
//     sepolia: {  
//       url: process.env.SEPOLIA_RPC_URL || "",  
//       accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : []  
//     }  
//   },  
//   etherscan: {  
//     apiKey: process.env.ETHERSCAN_API_KEY  
//   } 