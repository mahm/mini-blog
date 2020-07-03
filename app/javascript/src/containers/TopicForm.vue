<template>
  <div class="card">
    <div class="card-body">
      <form @submit.prevent="onSubmit">
        <div class="mb-3">
          <textarea
            class="form-control"
            rows="3"
            v-model="body"
            :disabled="sending"
          ></textarea>
        </div>
        <div style="text-align: right">
          <button type="submit" class="btn btn-primary" :disabled="sending">
            投稿する
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from 'vue'
import gql from 'graphql-tag'
import { apolloProvider } from 'src/lib'
import { CREATE_TOPIC, RETRIEVE_TOPICS } from 'src/graphql'

type IState = {
  body: string
  sending: boolean
}

export default Vue.extend({
  apolloProvider,
  data(): IState {
    return {
      body: '',
      sending: false,
    }
  },
  methods: {
    async onSubmit(): Promise<void> {
      this.sending = true
      const { data } = await this.$apollo.mutate({
        mutation: CREATE_TOPIC,
        variables: {
          input: {
            body: this.body,
          },
        },
        update: (
          store,
          {
            data: {
              createTopic: { topic: newTopic },
            },
          }
        ) => {
          const data = store.readQuery({ query: RETRIEVE_TOPICS })
          data.topics.unshift(newTopic)
          store.writeQuery({ query: RETRIEVE_TOPICS, data })
        },
      })
      const { result } = data.createTopic
      if (data.createTopic.result) {
        this.body = ''
      }
      this.sending = false
    },
  },
})
</script>
