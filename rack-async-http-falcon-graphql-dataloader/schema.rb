require_relative "query"

class Schema < GraphQL::Schema
  query Query
  use GraphQL::Dataloader
end
