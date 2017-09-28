module UsersHelper
  # Returns the Gravatar for the given user.
  def update_information(user)
    user.password_confirmation = user.password
    unless user.authenticate(params[:password])
      flash.now[:danger] = "Invalid password!!!"
      return false
    end
    return true
  end
end
