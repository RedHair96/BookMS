module SessionsHelper
  def sign_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @curent_user ||= User.find_by(id: session[:user_id])
  end

  def sign_in?
    !current_user.nil?
  end

  def sign_out
    session.delete(:user_id)
    @current_user = nil
  end
end
