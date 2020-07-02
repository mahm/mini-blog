module Types
  class TopicType < Types::BaseObject
    implements GraphQL::Types::Relay::Node
    global_id_field :gid

    field :id, ID, null: false
    field :body, String, null: false
    field :user, Types::UserType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
