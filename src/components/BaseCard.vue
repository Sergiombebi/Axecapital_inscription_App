<script setup>
import { computed } from 'vue'

const props = defineProps({
  padding: {
    type: String,
    default: 'medium',
    validator: (value) => ['small', 'medium', 'large'].includes(value)
  },
  shadow: {
    type: String,
    default: 'medium',
    validator: (value) => ['none', 'small', 'medium', 'large'].includes(value)
  },
  bordered: {
    type: Boolean,
    default: true
  }
})

const cardClasses = computed(() => {
  const baseClasses = 'bg-white rounded-lg'
  
  const paddingClasses = {
    small: 'p-4',
    medium: 'p-6',
    large: 'p-8'
  }
  
  const shadowClasses = {
    none: '',
    small: 'shadow-sm',
    medium: 'shadow-md',
    large: 'shadow-lg'
  }
  
  const borderClass = props.bordered ? 'border border-gray-200' : ''
  
  return `${baseClasses} ${paddingClasses[props.padding]} ${shadowClasses[props.shadow]} ${borderClass}`
})
</script>

<template>
  <div :class="cardClasses">
    <slot />
  </div>
</template>
