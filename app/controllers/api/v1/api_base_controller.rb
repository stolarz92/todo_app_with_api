module Api
  module V1
    class ApiBaseController < JSONAPI::ResourceController
      include CurrentUser
      protect_from_forgery with: :null_session
      before_action :authenticate_user!
    end
  end
end

