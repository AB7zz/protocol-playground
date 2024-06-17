// SPDX-License-Identifier: MIT
pragma solidity =0.8.11;

import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

contract RandomNumber is VRFConsumerBase {
    bytes32 internal keyHash;   // identifies which chainlink orace to use
    uint internal fee;          // LNIK token fee to pay chainlink oracle to get random number
    uint256 public randomNumber;

    constructor()
        VRFConsumerBase(
            0x7E10652Cb79Ba97bC1D0F38a1e8FaD8464a8a908,
            0x0Fd9e8d3aF1aaee056EB9e802c3A762a667b1904
        )
    {
        keyHash = 0x3f631d5ec60a0ce16203bcd6aff7ffbc423e22e452786288e172d467354304c8;
        fee = 0.0005 * 10 ** 18;                    // 0.0005 LINK
    }
    

    function getRandomNumber() public returns (bytes32 requestId) {
        require(LINK.balanceOf(address(this)) >= fee, "Not enough LINK in contract");
        return requestRandomness(keyHash, fee);
    }

    function fulfillRandomness(bytes32 requestId, uint randomness) virtual internal override {
        randomNumber = randomness;
    }

    function setRandomNumber(uint256 _randomNumber) external {
        randomNumber = _randomNumber;
    }

}
