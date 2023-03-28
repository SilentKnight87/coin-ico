const { ethers } = require("hardhat");
require("dotenv").config({ path: ".env" });
const { CRYPTO_DEVS_NFT_CONTRACT_ADDRESS } = require("../constants");

async function main() {
  // Address of the Crypto Devs NFt contract that you deployed in the previous module
  const cryptoDevstokenContract = await ethers.getContractFactory(
    "CryptoDevToken"
  );

  // deploy the contract
  const deployCryptoDevsTokenContract = await cryptoDevstokenContract.deploy(
    cryptoCevsNFTContract
  );

  await deployCryptoDevsTokenContract.deploy();
  // print the address of the deployed contract
  console.log(
    "Crypto Devs Token Address:",
    deployCryptoDevsTokenContract.address
  );
}

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
