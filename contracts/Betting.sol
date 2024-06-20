// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Betting {
    enum Outcome { TeamA, TeamB }
    struct Bet {
        uint amount;
        Outcome outcome;
    }

    mapping(address => Bet) public bets;
    address public owner;
    bool public bettingOpen;
    Outcome public result;
    bool public resultDeclared;

    event BetPlaced(address indexed bettor, uint amount, Outcome outcome);
    event ResultDeclared(Outcome result);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }

    constructor() {
        owner = msg.sender;
        bettingOpen = true;
    }

    function placeBet(Outcome _outcome) public payable {
        require(bettingOpen, "Betting is closed");
        require(msg.value > 0, "Bet amount must be greater than zero");

        bets[msg.sender] = Bet({
            amount: msg.value,
            outcome: _outcome
        });

        emit BetPlaced(msg.sender, msg.value, _outcome);
    }

    function closeBetting() public onlyOwner {
        bettingOpen = false;
    }

    function declareResult(Outcome _result) public onlyOwner {
        require(!resultDeclared, "Result already declared");

        result = _result;
        resultDeclared = true;

        emit ResultDeclared(_result);
    }

    function withdrawWinnings() public {
        require(resultDeclared, "Result not declared yet");
        Bet storage userBet = bets[msg.sender];
        require(userBet.amount > 0, "No bet placed");
        require(userBet.outcome == result, "Incorrect outcome");

        uint256 winnings = userBet.amount * 2;
        userBet.amount = 0;
        payable(msg.sender).transfer(winnings);
    }
}
