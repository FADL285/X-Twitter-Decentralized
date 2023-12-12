const main = async () => {
  const [owner] = await hre.ethers.getSigners()
  const accountBalance = await owner.provider.getBalance(owner.address)

  console.log('Deploy the contract made by:', owner.address)
  console.log('Account balance:', accountBalance.toString())

  const xPost = await hre.ethers.deployContract('XPost', {
    value: hre.ethers.parseEther('0.1')
  })
  await xPost.waitForDeployment()

  console.log('Deploy the contract to the address:', xPost.target)
}

const runMain = async () => {
  try {
    await main()
    process.exit(0)
  } catch (error) {
    console.log(error)
    process.exit(1)
  }
}

runMain()
