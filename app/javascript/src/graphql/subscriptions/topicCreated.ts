import gql from 'graphql-tag'
import { TOPIC_FRAGMENTS } from '../fragments/topic'

export const TOPIC_CREATED = gql`
  ${TOPIC_FRAGMENTS}

  subscription topicCreated {
    topicCreated {
      topic {
        ...topic
      }
    }
  }
`
