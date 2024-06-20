// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Oracle {
    address public admin;
    uint public data;

    event DataUpdated(uint data);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function updateData(uint _data) public onlyAdmin {
        data = _data;
        emit DataUpdated(data);
    }

    function getData() public view returns (uint) {
        return data;
    }
}
