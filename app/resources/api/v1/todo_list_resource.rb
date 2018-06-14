module Api
  module V1
    class TodoListResource < Api::V1::ApplicationResource
      attributes :name, :description
      has_one :user
      has_many :list_items

      paginator :paged_with_all

      def self.records(options)
        current_user = options.dig(:context, :current_user)
        current_user.todo_lists
      end
    end
  end
end
