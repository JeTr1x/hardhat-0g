// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NativeTokenSubscriptionService {
    uint256 public subscriptionFee;
    uint256 public subscriptionDuration;

    struct Subscriber {
        uint256 endTime;
        bool active;
    }

    mapping(address => Subscriber) public subscribers;

    event Subscribed(address indexed subscriber, uint256 endTime);
    event Unsubscribed(address indexed subscriber);

    constructor() {
        subscriptionFee = 1 ether; // Set your subscription fee here (in wei)
        subscriptionDuration = 30 days; // Set your subscription duration here
    }

    function subscribe() public payable {
        require(msg.value == subscriptionFee, "Incorrect subscription fee");

        Subscriber storage subscriber = subscribers[msg.sender];
        subscriber.endTime = block.timestamp + subscriptionDuration;
        subscriber.active = true;

        emit Subscribed(msg.sender, subscriber.endTime);
    }

    function unsubscribe() public {
        Subscriber storage subscriber = subscribers[msg.sender];
        require(subscriber.active, "Not an active subscriber");

        subscriber.active = false;

        emit Unsubscribed(msg.sender);
    }

    function isActiveSubscriber(address _subscriber) public view returns (bool) {
        return subscribers[_subscriber].active && block.timestamp <= subscribers[_subscriber].endTime;
    }

    function extendSubscription(uint256 _additionalDuration) public payable {
        require(msg.value == (subscriptionFee * _additionalDuration) / subscriptionDuration, "Incorrect subscription fee");

        Subscriber storage subscriber = subscribers[msg.sender];
        require(subscriber.active, "Not an active subscriber");

        subscriber.endTime += _additionalDuration;

        emit Subscribed(msg.sender, subscriber.endTime);
    }

    function withdrawFunds() public {
        payable(msg.sender).transfer(address(this).balance);
    }
}
