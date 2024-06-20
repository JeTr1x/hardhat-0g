// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Marketplace {
    struct Item {
        uint id;
        address payable seller;
        string name;
        uint price;
        bool sold;
    }

    uint public itemCount;
    mapping(uint => Item) public items;

    event ItemCreated(uint id, address seller, string name, uint price);
    event ItemSold(uint id, address buyer, string name, uint price);

    function createItem(string memory _name, uint _price) public {
        require(bytes(_name).length > 0, "Item name is required");
        require(_price > 0, "Item price must be greater than zero");

        itemCount++;
        items[itemCount] = Item(itemCount, payable(msg.sender), _name, _price, false);

        emit ItemCreated(itemCount, msg.sender, _name, _price);
    }

    function purchaseItem(uint _id) public payable {
        Item storage item = items[_id];
        require(_id > 0 && _id <= itemCount, "Invalid item id");
        require(msg.value >= item.price, "Not enough ether sent");
        require(!item.sold, "Item already sold");

        item.seller.transfer(item.price);
        item.sold = true;

        emit ItemSold(_id, msg.sender, item.name, item.price);
    }
}
