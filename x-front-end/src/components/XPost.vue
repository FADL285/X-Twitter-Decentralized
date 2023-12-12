<script setup lang="ts">
defineProps<{
  address: string
  timestamp: string
  message: string
}>()
</script>

<template>
  <div class="border border-gray-700 p-4 rounded mb-2">
    <div class="truncate">Wallet Address: {{ address }}</div>
    <div>Date: {{ timestamp }}</div>
    <div>Message: {{ message }}</div>
  </div>
</template>

<style scoped></style>
