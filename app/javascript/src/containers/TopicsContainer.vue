<template>
  <div>
    <Topic v-for="topic in topics" v-bind:key="topic.id" v-bind="topic"></Topic>
  </div>
</template>

<script lang="ts">
import Vue from 'vue'
import { getApolloClient } from 'src/lib'
import { TOPICS_QUERY } from 'src/graphql'
import { topicsQuery } from 'src/graphql/types'
import { ITopic, IUser } from 'src/types/model'

import Topic from '../components/Topic.vue'

type IState = {
  topics: ITopic[]
}

export default Vue.extend({
  components: {
    Topic,
  },
  data(): IState {
    return {
      topics: [],
    }
  },
  async created() {
    await this.refresh()
  },
  methods: {
    async refresh(): Promise<void> {
      const { data } = await getApolloClient().query<topicsQuery>({
        query: TOPICS_QUERY,
      })
      this.topics = data.topics
    },
  },
})
</script>
