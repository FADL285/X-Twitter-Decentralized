// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;

import 'hardhat/console.sol';

contract XPost {
  uint256 totalPosts;
  uint256 private seed;

  event NewPost(address indexed from, uint256 timestamp, string message);

  struct Post {
    address sender;
    string message;
    uint256 timestamp;
  }

  Post[] posts;

  // This mapping will help us to save the next date that the user can post, because each user can only post every 30 seconds (to reduce spam)
  mapping(address => uint256) public lastPostedAt;

  constructor() payable {
    console.log('The contract has been created!');
    // This "seed" is a random number between 1 and 100 that will determine whether or not the user will win a prize in the post they made
    seed = (block.timestamp + block.prevrandao) % 100;
  }

  function createPost(string memory _message) public {
    //  Remember the mapping? Here we are checking if the same user (same address) is trying to create more than one post in less than 30 seconds
    require(
      lastPostedAt[msg.sender] + 30 seconds < block.timestamp,
      'Must wait 30 seconds before posting again.'
    );

    // Here we are saving the date and time of the last post to be used in the function above
    lastPostedAt[msg.sender] = block.timestamp;

    totalPosts += 1;
    console.log('%s created a post!', msg.sender);

    // Here we are saving the post in the blockchain, all saved posts can be read on the front-end
    posts.push(Post(msg.sender, _message, block.timestamp));

    // Here we are updating the "seed" (random number) to find out if the person won the prize or not
    seed = (block.prevrandao + block.timestamp + seed) % 100;

    if (seed <= 50) {
      console.log('%s won a prize of 0.0001 Ethereum!', msg.sender);

      uint256 prizeAmount = 0.0001 ether;
      require(
        prizeAmount <= address(this).balance,
        'The contract does not have sufficient funds to pay the premium.'
      );
      (bool success, ) = (msg.sender).call{value: prizeAmount}('');
      require(success, 'It was not possible to send the prize.');
    }

    // Every time someone creates a post, this NewPost event will be triggered and can be "listened" by the front-end to update the posts in "real time"
    emit NewPost(msg.sender, block.timestamp, _message);
  }

  function getAllPosts() public view returns (Post[] memory) {
    return posts;
  }

  function getTotalPosts() public view returns (uint256) {
    console.log('I have %d posts!', totalPosts);
    return totalPosts;
  }
}
