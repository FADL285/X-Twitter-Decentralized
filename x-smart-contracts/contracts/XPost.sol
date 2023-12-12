// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;

import "hardhat/console.sol";

contract XPost {
    uint256 totalPosts;

    constructor() {
        console.log(
            "I will be the smart contract to make a decentralized Twitter post."
        );
    }

    function createPost() public {
        totalPosts += 1;
        console.log("%s created the post!", msg.sender);
    }

    function getTotalPosts() public view returns (uint256) {
        console.log("We have %d total posts!", totalPosts);
        return totalPosts;
    }
}
