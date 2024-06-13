// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFT is ERC721 {
    uint256 counter;

    constructor() ERC721("Coke", "COLA") {}

    function mint(address recipient)
        public
        returns (uint256)
    {
        ++counter;
        uint256 tokenId = counter;
        _safeMint(recipient, tokenId);
        return tokenId;
    }
}



