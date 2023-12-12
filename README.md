# Decentralized Twitter Clone

This project is a decentralized application (dApp) that mimics the basic functionality of Twitter. Unlike traditional social media platforms, this application is built on the blockchain, which means that to create a post, you will need to have a blockchain wallet and pay fees for the post to be saved on the blockchain.

## Features

- Create and post tweets on the blockchain
- View tweets from all users

## Technologies Used

- Solidity: For writing smart contracts
- Hardhat: For compiling, testing, and deploying our smart contracts
- Vue3: For building the frontend of the application
- Metamask: For user authentication and interaction with the Ethereum blockchain

## Getting Started

1. Clone the repository
2. Move to `x-smart-contract` directory
3. Install dependencies with `npm install`
4. Compile the smart contract with `npx hardhat compile`
5. Start the local Hardhat network with `npx hardhat node`
6. Deploy the contract to the local network with `npx hardhat run scripts/deploy.js --network localhost`
7. Move to `x-front-end` directory
8. Start the Vue app with `npm run dev`

## Disclaimer

This project is for educational purposes only. It is not a fully decentralized Twitter platform.
