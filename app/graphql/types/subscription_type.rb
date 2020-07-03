module Types
  class SubscriptionType < Types::BaseObject
    field :topic_created, subscription: Subscriptions::TopicCreated
  end
end