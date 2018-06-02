module Api
  module V1
    class TodoListResource < Api::V1::ApplicationResource
      attributes :name, :description
      has_one :user
      has_many :list_items
    end
  end
end
