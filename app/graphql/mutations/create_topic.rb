module Mutations
  class CreateTopic < BaseMutation
    graphql_name "CreateTopic"

    field :topic, Types::TopicType, null: false
    field :result, Boolean, null: true

    argument :body, String, required: true

    def resolve(**args)
      user = context[:current_user]
      topic = user.topics.create(body: args[:body])
      {
        topic: topic,
        result: topic.errors.blank?,
      }
    end
  end
end
