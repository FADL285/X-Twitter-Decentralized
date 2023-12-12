<script setup lang="ts">
import XButton from './components/XButton.vue'
import XTextField from './components/XTextField.vue'
import XPost from './components/XPost.vue'
import MetaMaskICon from './components/MetaMaskICon.vue'
</script>

<template>
  <main class="bg-gray-900 min-h-screen flex items-center justify-center flex-col p-20">
    <div
      class="rounded-md border border-gray-700 text-white bg-gray-800 p-6 mx-auto w-full max-w-[600px]"
    >
      <h1 class="text-2xl mb-4">𝕏 (Twitter) Decentralized</h1>
      <p class="text-base mb-4">
        This is a decentralized twitter, connect your blockchain wallet and use your Ethereum to
        send a message. Every post sent you will have a chance to earn a value of Ethereum back.
      </p>
      <XButton>
        <MetaMaskICon />
        Connect wallet
      </XButton>
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
      <div class="flex items-center justify-end">
        <span
          class="bg-green-100 text-green-800 text-xs font-semibold mr-2 px-2.5 py-0.5 rounded dark:bg-green-200 dark:text-green-900 h-fit"
        >
          Connected!
        </span>
        <span class="truncate">
          <!-- {{ currentAccount }} -->
        </span>
      </div>
    </div>
    <div
      class="mt-8 rounded-md border border-gray-700 text-white bg-gray-800 p-6 mx-auto w-full max-w-[600px]"
    >
      <h1 class="text-white text-lg mb-4">All posts</h1>
      <div class="text-center mb-4">Loading...</div>
      <XPost address="123" timestamp="16:54" message="Message description" />
    </div>
  </main>
</template>
