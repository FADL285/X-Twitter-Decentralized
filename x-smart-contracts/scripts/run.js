const main = async () => {
  const [owner] = await hre.ethers.getSigners()
  const xPost = await hre.ethers.deployContract('XPost', {
    value: hre.ethers.parseEther('0.1')
  })
  await xPost.waitForDeployment()

  console.log('Deploy the contract to the address:', xPost.target)
  console.log('Deploy the contract made by:', owner.address)

  let contractBalance = await hre.ethers.provider.getBalance(xPost.target)
  console.log('Contract balance:', hre.ethers.formatEther(contractBalance))

  const postTxn = await xPost.createPost('Post # 1')
  await postTxn.wait()

  contractBalance = await hre.ethers.provider.getBalance(xPost.target)
  console.log('Contract balance after a post is created:', hre.ethers.formatEther(contractBalance))

  await xPost.getTotalPosts()
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
