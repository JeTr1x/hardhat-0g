// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleLending {
    mapping(address => uint256) public deposits;
    mapping(address => uint256) public loans;
    uint256 public interestRate = 5; // 5% interest rate

    event Deposited(address indexed user, uint256 amount);
    event Borrowed(address indexed user, uint256 amount, uint256 interest);
    event Repaid(address indexed user, uint256 amount);

    function deposit() public payable {
        deposits[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    function borrow(uint256 _amount) public {
        require(deposits[msg.sender] >= _amount, "Insufficient deposit");
        
        uint256 interest = (_amount * interestRate) / 100;
        loans[msg.sender] += _amount + interest;
        
        payable(msg.sender).transfer(_amount);
        emit Borrowed(msg.sender, _amount, interest);
    }

    function repay() public payable {
        require(loans[msg.sender] > 0, "No loan to repay");
        
        loans[msg.sender] -= msg.value;
        if (loans[msg.sender] < 0) {
            deposits[msg.sender] += loans[msg.sender];
            loans[msg.sender] = 0;
        }
        
        emit Repaid(msg.sender, msg.value);
    }
}
