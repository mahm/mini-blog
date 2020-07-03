import gql from 'graphql-tag'

export const TOPIC_FRAGMENTS = gql`
  fragment topic on Topic {
    id
    body
    createdAt
    user {
      id
      name
    }
  }
`
