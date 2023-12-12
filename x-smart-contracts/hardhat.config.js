require('@nomicfoundation/hardhat-toolbox')
require('dotenv').config()

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: '0.8.19',
  networks: {
    staging: {
      url: `${process.env.ALCHEMY_API_URL}/${process.env.ALCHEMY_API_KEY}`,
      accounts: [process.env.METAMASK_PRIVATE_KEY]
    }
  }
}
