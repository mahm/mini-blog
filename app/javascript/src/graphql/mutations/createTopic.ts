import gql from 'graphql-tag'
import { TOPIC_FRAGMENTS } from '../fragments/topic'

export const CREATE_TOPIC = gql`
  ${TOPIC_FRAGMENTS}

  mutation createTopic($input: CreateTopicInput!) {
    createTopic(input: $input) {
      result
      topic {
        ...topic
      }
    }
  }
`
