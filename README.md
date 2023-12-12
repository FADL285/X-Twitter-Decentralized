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

## Prerequisites

- An Alchemy account and API key
- A Metamask account and API key

## Getting Started

1. Clone the repository
2. Move to `x-smart-contract` directory
3. Install dependencies with `npm install`
4. Copy `.env.example` to `.env` and update the data with your Alchemy and Metamask API keys
5. Compile the smart contract with `npx hardhat compile`
6. Start the local Hardhat network with `npx hardhat node`
7. Deploy the contract to the staging network with `npx hardhat run scripts/deploy.js --network staging`
8. Move to `x-front-end` directory
9. Start the Vue app with `npm run dev`

## Disclaimer

This project is for educational purposes only. It is not a fully decentralized Twitter platform. Please use responsibly.
