class LogQueryComplexityAnalyzer < GraphQL::Analysis::AST::QueryComplexity
  def result
    complexity = super
    message = "[GraphQL Query Complexity] #{complexity} | user_id #{query.context[:current_user]&.id}"
    Rails.logger.info(message)
  end
end
