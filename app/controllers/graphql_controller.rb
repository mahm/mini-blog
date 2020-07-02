class GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token, if: :introspection_query_allow_by_noauth?

  def execute
    context = {
      current_user: current_user,
    }

    result = if params[:_json]
        queries = params[:_json].map do |param|
          {
            query: param[:query],
            operation_name: param[:operationName],
            variables: ensure_hash(param[:variables]),
            context: context,
          }
        end
        # NOTE: 複数クエリ実行時はmax_complexityを超えやすくなってしまうのでひとまず2倍にして様子見
        ApplicationSchema.multiplex(queries, max_complexity: ApplicationSchema.max_complexity * 2)
      else
        ApplicationSchema.execute(
          params[:query],
          operation_name: params[:operationName],
          variables: ensure_hash(params[:variables]),
          context: context,
        )
      end

    render json: result
  rescue => e
    raise e unless Rails.env.development?
    handle_error_in_development e
  end

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end

  def introspection_query_allow_by_noauth?
    Rails.env.development? && params[:operationName] == "IntrospectionQuery"
  end
end
