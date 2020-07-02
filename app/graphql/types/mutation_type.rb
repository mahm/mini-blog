module Types
  class MutationType < Types::BaseObject
    field :create_topic, mutation: Mutations::CreateTopic
  end
end
