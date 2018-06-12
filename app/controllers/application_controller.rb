class ApplicationController < ActionController::Base
  respond_to :html, :json
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    todo_lists_path
  end
end
