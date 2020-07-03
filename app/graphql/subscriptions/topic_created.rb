module Subscriptions
  class TopicCreated < Subscriptions::BaseSubscription
    field :topic, Types::TopicType, null: false

    def update
      {
        topic: object,
      }
    end
  end
end
