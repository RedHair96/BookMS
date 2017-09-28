class SessionsController < ApplicationController
  def new
    sign_out if signed_in?
  end

  def create
    user = User.find_by(email: params[:session][:email]);
    if user &&  user.authenticate(params[:session][:password])
      sign_in user
      params[:session][:remember_me] == "1"? remember(user) : forget(user)
      redirect_to_previous_url user
    else
      flash.now[:danger] = 'Invalid email/password!!!'
      render 'new'
    end
  end

  def destroy
    sign_out if signed_in?
    redirect_to signin_path
  end
end
