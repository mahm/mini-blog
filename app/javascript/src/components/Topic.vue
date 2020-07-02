<template>
  <div class="card mt-3">
    <div class="card-body">
      {{ body }}
    </div>
  </div>
</template>

<script lang="ts">
import Vue, { PropType } from 'vue'
import { IUser } from 'src/types/model'

export default Vue.extend({
  props: {
    id: {
      type: String,
      required: true,
    },
    body: {
      type: String,
      required: true,
    },
    user: {
      type: Object as PropType<IUser>,
      required: true,
    },
  },
})
</script>
