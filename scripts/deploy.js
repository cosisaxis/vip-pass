const {ethers } = require("hardhat");

async function main(){
    const vipPassesContract = await ethers.getContractFactory("VipPasses");
    const deployedVipPassesContract = await vipPassesContract.deploy();
    await deployedVipPassesContract.deployed();
    console.log("Address for VIP passes: ", deployedVipPassesContract.address);
}


main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });