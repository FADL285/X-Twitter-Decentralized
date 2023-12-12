<script setup>
import XButton from './components/XButton.vue'
import XTextField from './components/XTextField.vue'
import XPost from './components/XPost.vue'
import MetaMaskIcon from './components/MetaMaskIcon.vue'

import { ref, onMounted } from 'vue'

const connectedWallet = ref(null)
const loading = ref(false)

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
    getAllWaves()
  } catch (error) {
    console.error(error)
  }
  loading.value = false
}

onMounted(async () => {
  await findMetamaskAccount()
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
          label="Post"
          name="post"
          class="mb-2"
          type="text"
          id="post"
          placeholder="John"
          required
        />
        <XButton text="Send post" />
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
      v-if="connectedWallet"
    >
      <h1 class="text-white text-lg mb-4">All posts</h1>
      <div class="text-center mb-4">Loading...</div>
      <XPost address="123" timestamp="16:54" message="Message description" />
    </div>
  </main>
</template>
