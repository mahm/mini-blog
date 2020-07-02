module Types
  class UserType < Types::BaseObject
    implements GraphQL::Types::Relay::Node
    global_id_field :gid

    field :id, ID, null: false
    field :name, String, null: false
    field :topics, [Types::TopicType], null: false
  end
end
