import { getApolloClient } from 'src/lib'
import VueApollo from 'vue-apollo'

export const apolloProvider = new VueApollo({
  defaultClient: getApolloClient(),
})
