import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";

import args from "../arguments/NFT";
const CONTRACT_NAME = "IMXMintableWrapper";

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  await deploy(CONTRACT_NAME, {
    from: deployer,
    args,
    log: true,
  });
};
export default func;
func.tags = [CONTRACT_NAME];
