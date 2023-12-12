<script setup>
import XButton from './components/XButton.vue'
import XTextField from './components/XTextField.vue'
import XPost from './components/XPost.vue'
import MetaMaskIcon from './components/MetaMaskIcon.vue'

import { ref, onMounted, watchEffect } from 'vue'

import { ethers } from 'ethers'
import abi from '@/contracts/XPost.json'

const connectedWallet = ref(null)
const loading = ref(false)
const loadingPosts = ref(false)
const message = ref(null)

const contractAddress = '0xa182f4a8A38Aee4d08D240a9d657Dd7D554c8c67'
const contractABI = abi.abi

const getEthereumObject = () => window.ethereum

const findMetamaskAccount = async () => {
  loading.value = true
  try {
    const ethereum = getEthereumObject()

    if (!ethereum) {
      console.error('Install the MetaMask extension!')
      return null
    }

    console.log('The MetaMask extension is installed:', ethereum)

    const accounts = await ethereum.request({ method: 'eth_accounts' })
    if (accounts.length !== 0) {
      const account = accounts[0]
      console.log('MetaMask account connected:', account)
      connectedWallet.value = account
      return account
    } else {
      console.error('No MetaMask accounts connected:')
      return null
    }
  } catch (error) {
    console.error(error)
    return null
  } finally {
    loading.value = false
  }
}

const connectWallet = async () => {
  loading.value = true
  try {
    const ethereum = getEthereumObject()
    if (!ethereum) {
      alert('Install the MetaMask extension!')
      return
    }

    const accounts = await ethereum.request({
      method: 'eth_requestAccounts'
    })

    console.log('Connected', accounts[0])
    connectedWallet.value = accounts[0]
    getAllPosts()
  } catch (error) {
    console.error(error)
  }
  loading.value = false
}
const createPost = async () => {
  loadingPosts.value = true

  const ethereum = getEthereumObject()
  if (!ethereum) {
    alert('Install the MetaMask extension!')
    return
  }

  try {
    const provider = new ethers.BrowserProvider(window.ethereum)
    const signer = await provider.getSigner()

    const xPostContract = new ethers.Contract(contractAddress, contractABI, signer)

    let count = await xPostContract.getTotalPosts()
    console.log('Total number of posts before a new one is created:', Number(count))

    const postTxn = await xPostContract.createPost(message.value, {
      gasLimit: 300000
    })
    console.log('Creating a new post...', postTxn.hash)

    await postTxn.wait()
    console.log('Created and saved on the blockchain!', postTxn.hash)

    count = await xPostContract.getTotalPosts()
    console.log('Total number of posts after a new one is created:', Number(count))
  } catch (error) {
    console.log(error)
  } finally {
    loadingPosts.value = false
  }
}

const allPosts = ref([])

const getAllPosts = async () => {
  loading.value = true

  const ethereum = getEthereumObject()
  if (!ethereum) {
    alert('Install the MetaMask extension!')
    return
  }

  try {
    const provider = new ethers.BrowserProvider(ethereum)
    const signer = await provider.getSigner()
    const xPostContract = new ethers.Contract(contractAddress, contractABI, signer)

    const posts = await xPostContract.getAllPosts()

    const normalizedPosts = posts
      .map((post) => {
        return {
          address: post[0],
          timestamp: new Date(Number(post[2]) * 1000),
          message: post[1]
        }
      })
      .sort((a, b) => new Date(b.timestamp) - new Date(a.timestamp))

    allPosts.value = normalizedPosts
  } catch (error) {
    console.log(error)
  }
  loading.value = false
}

watchEffect(async (onCleanup) => {
  let xPostContract

  const onNewPost = (from, timestamp, message) => {
    try {
      console.log('NewPost event received:', { from, timestamp, message })
      allPosts.value.unshift({
        address: from,
        timestamp: new Date(Number(timestamp) * 1000),
        message: message
      })
    } catch (e) {
      console.error(e)
    }
  }

  if (window.ethereum) {
    const provider = new ethers.BrowserProvider(window.ethereum)
    const signer = await provider.getSigner()

    xPostContract = new ethers.Contract(contractAddress, contractABI, signer)
    xPostContract.on('NewPost', onNewPost)
  }

  onCleanup(() => {
    if (xPostContract) {
      xPostContract.off('NewPost', onNewPost)
    }
  })
})

onMounted(async () => {
  await findMetamaskAccount()
  await getAllPosts()
})
</script>

<template>
  <main class="bg-gray-900 min-h-screen flex items-center justify-center flex-col p-20">
    <div
      class="rounded-md border border-gray-700 text-white bg-gray-800 p-6 mx-auto w-full max-w-[600px]"
    >
      <h1 class="text-2xl mb-4">𝕏 (Twitter) Decentralized</h1>
      <p class="text-base mb-4">
        This is a decentralized twitter, connect your your blockchain wallet and use your Ethereum
        to send a message. Each post sent you will have chance to earn a value of Ethereum back.
      </p>
      <XButton v-if="!connectedWallet" @click="connectWallet" :loading="loading">
        <MetaMaskIcon />
        Connect wallet
      </XButton>
      <template v-else>
        <XTextField
          v-model="message"
          label="Post"
          name="post"
          class="mb-2"
          type="text"
          id="post"
          placeholder="John"
          required
        />
        <XButton text="Send post" @click="createPost" />
        <div class="flex items-center justify-between">
          <span class="truncate">
            {{ connectedWallet }}
          </span>
          <span
            class="bg-green-100 text-green-800 text-xs font-semibold mr-2 px-2.5 py-0.5 rounded dark:bg-green-200 dark:text-green-900 h-fit"
          >
            Connected wallet!
          </span>
        </div>
      </template>
    </div>
    <div
      class="mt-8 rounded-md border border-gray-700 text-white bg-gray-800 p-6 mx-auto w-full max-w-[600px]"
      v-if="connectedWallet && allPosts?.length > 0"
    >
      <h1 class="text-white text-lg mb-4">All posts</h1>
      <div class="text-center mb-4" v-if="loadingPosts">Loading...</div>
      <div v-else>
        <XPost
          v-for="post in allPosts"
          :key="post"
          :address="post.address"
          :timestamp="post.timestamp.toString()"
          :message="post.message"
        />
      </div>
    </div>
  </main>
</template>
