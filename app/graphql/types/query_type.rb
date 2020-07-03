module Types
  class QueryType < Types::BaseObject
    field :topics, [Types::TopicType], null: false

    def topics
      Topic.order(id: :desc)
    end

    field :topic, Types::TopicType, null: false do
      argument :id, Int, required: false
    end

    def topic(id:)
      Topic.find(id)
    end
  end
end
