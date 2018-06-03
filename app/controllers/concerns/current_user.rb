module CurrentUser
  def context
    { current_user: current_user }
  end
end