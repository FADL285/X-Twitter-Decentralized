<script setup lang="ts">
const { loading = false } = defineProps<{
  loading?: boolean
  text: string
}>()

defineEmits(['click'])
</script>

<template>
  <button
    @click="$emit('click')"
    type="button"
    class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800"
  >
    <span v-if="loading">Loading...</span>
    <span v-else>{{ text }}</span>
  </button>
</template>

<style scoped></style>
