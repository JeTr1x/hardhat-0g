// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SubscriptionService {
    struct Subscriber {
        uint256 endTime;
        bool active;
    }

    address public owner;
    uint256 public subscriptionFee;
    uint256 public subscriptionDuration;
    mapping(address => Subscriber) public subscribers;

    event Subscribed(address indexed subscriber, uint256 endTime);
    event Unsubscribed(address indexed subscriber);

    modifier only
