const main = async () => {
  const [owner] = await hre.ethers.getSigners()
  const xPost = await hre.ethers.deployContract('XPost')
  await xPost.waitForDeployment()

  console.log('Deploy the contract to the address:', xPost.target)
  console.log('Deployed by:', owner.address)

  await xPost.getTotalPosts()

  const postTxn = await xPost.createPost()
  await postTxn.wait()

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
