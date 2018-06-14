module Api
  module V1
    class ListItemResource < Api::V1::ApplicationResource
      attributes :name, :description, :completed
      has_one :todo_list

      paginator :paged_with_all
    end
  end
end
