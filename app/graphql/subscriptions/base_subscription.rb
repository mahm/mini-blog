module Subscriptions
  class BaseSubscription < GraphQL::Schema::Subscription
    include ActionPolicy::GraphQL::Behaviour

    object_class Types::BaseObject
    field_class Types::BaseField
    argument_class Types::BaseArgument
  end
end
