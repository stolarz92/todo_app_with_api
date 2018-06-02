module Api
  module V1
    class UserResource < Api::V1::ApplicationResource
      attributes :email, :password, :password_confirmation
      has_many :todo_lists
    end
  end
end