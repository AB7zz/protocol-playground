// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;


/// @title Lottery contract
/// @author AB7zz
/// @notice This cotract is used to create a lottery system using Chainlink VRF

import './RandomNumber.sol';

contract Lottery is RandomNumber {
    RandomNumber public RN;

    address public owner;
    address payable[] public players;
    uint public lotteryId;

    mapping(uint => address) public winners;

    constructor() {
        owner = msg.sender;
        lotteryId = 1;

        RN = new RandomNumber();
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function getPlayers() public view returns (address payable[] memory) {
        return players;
    }

    function enter() public payable {
        require(msg.value > 0.01 ether, "Minimum amount is 0.01 ether");

        players.push(payable(msg.sender));
    }

    function pickWinner() public onlyOwner {
        RN.getRandomNumber();
    }

    function payWinner() public onlyOwner {
        uint256 index = RN.randomNumber() % players.length;
        players[index].transfer(address(this).balance);
        winners[lotteryId] = players[index];

        lotteryId++;
        players = new address payable[](0);
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal virtual override {
        RN.setRandomNumber(randomness);
        payWinner();
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
}