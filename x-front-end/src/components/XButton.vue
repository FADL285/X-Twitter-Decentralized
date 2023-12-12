<script setup lang="ts">
const { loading = false } = defineProps<{
  loading?: boolean
  text?: string
}>()

defineEmits(['click'])
</script>

<template>
  <button
    @click="$emit('click')"
    type="button"
    class="text-gray-900 bg-white hover:bg-gray-100 border border-gray-200 focus:ring-4 focus:outline-none focus:ring-gray-100 font-medium rounded-lg text-sm px-5 py-2.5 text-center inline-flex items-center dark:focus:ring-gray-600 dark:bg-gray-800 dark:border-gray-700 dark:text-white dark:hover:bg-gray-700 me-2 mb-2"
  >
    <template v-if="loading">Loading...</template>
    <template v-else>
      <slot>
        {{ text }}
      </slot>
    </template>
  </button>
</template>

<style scoped></style>
