import { ApolloClient } from 'apollo-client'
import { BatchHttpLink } from 'apollo-link-batch-http'
import { InMemoryCache, NormalizedCacheObject } from 'apollo-cache-inmemory'
import { setContext } from 'apollo-link-context'
import { split } from 'apollo-link'
import * as ActionCable from '@rails/actioncable'
import ActionCableLink from 'graphql-ruby-client/dist/subscriptions/ActionCableLink'
import Rails from '@rails/ujs'

interface GetApolloClient {
  (): ApolloClient<NormalizedCacheObject>
  client?: ApolloClient<NormalizedCacheObject>
}

export const getApolloClient: GetApolloClient = () => {
  if (getApolloClient.client) {
    return getApolloClient.client
  }

  const cable = ActionCable.createConsumer()

  const httpLink = new BatchHttpLink({
    uri: '/graphql',
    batchMax: 50,
  })

  const authLink = setContext((_, { headers }) => {
    return {
      headers: {
        ...headers,
        'X-CSRF-TOKEN': Rails.csrfToken(),
      },
    }
  })

  const cache = new InMemoryCache()

  const hasSubscriptionOperation = ({
    query: { definitions },
  }: any): boolean => {
    return definitions.some(
      ({ kind, operation }) =>
        kind === 'OperationDefinition' && operation === 'subscription'
    )
  }

  const link = split(
    hasSubscriptionOperation,
    new ActionCableLink({ cable }),
    authLink.concat(httpLink)
  )

  // Create the apollo client
  getApolloClient.client = new ApolloClient({
    link,
    cache,
  })

  return getApolloClient.client
}
