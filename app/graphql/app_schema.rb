class AppSchema < GraphQL::Schema
  use GraphQL::Subscriptions::ActionCableSubscriptions

  mutation(Types::MutationType)
  query(Types::QueryType)
  subscription(Types::SubscriptionType)
end

GraphQL::Errors.configure(AppSchema) do
    rescue_from AuthenticatedUserRequiredError do |exception, object, arguments, context|
    error = GraphQL::ExecutionError.new("User must be authenticated")
    error.path = context.path
    context.add_error(error)
    nil
  end
end
