// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MessageBoard {
    string public message;

    function postMessage(string calldata newMessage) external {
        message = newMessage;
    }
}
