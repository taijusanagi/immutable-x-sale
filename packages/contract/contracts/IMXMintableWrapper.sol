//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@imtbl/imx-contracts/contracts/Mintable.sol";

import "./chocomint/interfaces/IChocoMintERC721.sol";

contract IMXMintableWrapper is Mintable {
  IChocoMintERC721 public chocomintERC721;

  constructor(
    address chocomintERC721Address,
    address owner,
    address imx
  ) Mintable(owner, imx) {
    chocomintERC721 = IChocoMintERC721(chocomintERC721Address);
  }

  function _mintFor(
    address to,
    uint256 tokenId,
    bytes calldata blueprint
  ) internal override {
    SecurityLib.SecurityData memory validSecurityData = SecurityLib.SecurityData(0, 9999999999, 0);
    MintERC721Lib.MintERC721Data memory mintERC721Data = MintERC721Lib.MintERC721Data(
      validSecurityData,
      address(this),
      to,
      tokenId,
      blueprint
    );
    bytes32 root = MintERC721Lib.hashStruct(mintERC721Data);
    SignatureLib.SignatureData memory signatureData = SignatureLib.SignatureData(root, new bytes32[](0), "");
    chocomintERC721.mint(mintERC721Data, signatureData);
  }
}
