class ApplicationSchema < GraphQL::Schema
  max_complexity 181
  max_depth 13

  mutation(Types::MutationType)
  query(Types::QueryType)
  subscription(Types::SubscriptionType)

  query_analyzer(LogQueryComplexityAnalyzer) if Rails.env.development?

  # Opt in to the new runtime (default in future graphql-ruby versions)
  use GraphQL::Execution::Interpreter
  use GraphQL::Analysis::AST

  # Add built-in connections for pagination
  use GraphQL::Pagination::Connections

  use GraphQL::Subscriptions::ActionCableSubscriptions
  use GraphQL::Batch
end
