// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import { IERC20 } from "@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol";

contract Dex {
    address payable public owner;

    address private immutable daiAddress = 0x3e622317f8C93f7328350cF0B56d9eD4C620C5d6;
    address private usdcAddress = 0x94a9D9AC8a22534E3FaCa9F4e7F2E2cf85d5E4C8;

    IERC20 private dai;
    IERC20 private usdc;

    uint256 private dexARate = 90;
    uint256 private dexBRate = 100;

    mapping(address => uint256) public daiBalances;
    mapping(address => uint256) public usdcBalances;

    constructor() {
        owner = payable(msg.sender);
        dai = IERC20(daiAddress);
        usdc = IERC20(usdcAddress);
    }

    function depositDai(uint256 _amount) external {
        uint256 allowance = dai.allowance(msg.sender, address(this));
        require(allowance >= _amount, "Check the token allowance");
        dai.transferFrom(msg.sender, address(this), _amount);
        daiBalances[msg.sender] += _amount;
    }

    function depositUsdc(uint256 _amount) external {
        uint256 allowance = usdc.allowance(msg.sender, address(this));
        require(allowance >= _amount, "Check the token allowance");
        usdc.transferFrom(msg.sender, address(this), _amount);
        usdcBalances[msg.sender] += _amount;
    }

    function buyDAI() external {
        uint256 daiToReceive = ((usdcBalances[msg.sender] / dexARate) * 100) * (10**12);
        dai.transfer(msg.sender, daiToReceive);
    }

    function sellDAI() external {
        uint256 usdcToReceive = ((daiBalances[msg.sender] * dexBRate) / 100) / (10**12);
        usdc.transfer(msg.sender, usdcToReceive);
    }

    function getBalance(address _tokenAddress) external view returns (uint256) {
        IERC20 token = IERC20(_tokenAddress);
        return token.balanceOf(address(this));
    }

    function withdraw(address _tokenAddress, uint256 _amount) external onlyOwner {
        IERC20 token = IERC20(_tokenAddress);
        token.transfer(msg.sender, _amount);
    }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only the contract owner can call this function"
        );
        _;
    }
}