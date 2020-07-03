import gql from 'graphql-tag'
import { TOPIC_FRAGMENTS } from '../fragments/topic'

export const RETRIEVE_TOPICS = gql`
  ${TOPIC_FRAGMENTS}

  query retrieveTopics {
    topics {
      ...topic
    }
  }
`
