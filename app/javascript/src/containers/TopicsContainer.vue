<template>
  <div>
    <Topic v-for="topic in topics" v-bind:key="topic.id" v-bind="topic"></Topic>
  </div>
</template>

<script lang="ts">
import Vue from 'vue'
import gql from 'graphql-tag'

import { apolloProvider } from 'src/lib'
import { RETRIEVE_TOPICS, TOPIC_CREATED } from 'src/graphql'
import Topic from '../components/Topic.vue'

export default Vue.extend({
  apolloProvider,
  components: {
    Topic,
  },
  apollo: {
    topics: {
      query: RETRIEVE_TOPICS,
      subscribeToMore: {
        document: TOPIC_CREATED,
        updateQuery: (previousResult, { subscriptionData }) => {
          const newTopic = subscriptionData.data.topicCreated.topic
          const existed: boolean = previousResult.topics.some((topic) => {
            return topic.id == newTopic.id
          })
          if (existed) {
            return previousResult
          } else {
            return {
              topics: [
                subscriptionData.data.topicCreated.topic,
                ...previousResult.topics,
              ],
            }
          }
        },
      },
    },
  },
})
</script>
