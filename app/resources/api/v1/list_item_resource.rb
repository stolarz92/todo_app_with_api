module Api
  module V1
    class ListItemResource < Api::V1::ApplicationResource
      attributes :name, :description, :completed
      belongs_to :todo_list
    end
  end
end
