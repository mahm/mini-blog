import gql from 'graphql-tag'

export const TOPICS_QUERY = gql`
  query topicsQuery {
    topics {
      id
      body
      createdAt
      user {
        id
        name
      }
    }
  }
`
