// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Whitelist {
    address public owner;
    mapping(address => bool) public whitelistedAddresses;

    event AddressWhitelisted(address indexed addr);
    event AddressRemovedFromWhitelist(address indexed addr);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function whitelistAddress(address _addr) public onlyOwner {
        whitelistedAddresses[_addr] = true;
        emit AddressWhitelisted(_addr);
    }

    function removeWhitelistAddress(address _addr) public onlyOwner {
        whitelistedAddresses[_addr] = false;
        emit AddressRemovedFromWhitelist(_addr);
    }

    function isWhitelisted(address _addr) public view returns (bool) {
        return whitelistedAddresses[_addr];
    }
}
