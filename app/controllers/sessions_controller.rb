class SessionsController < ApplicationController
  def new
    if signed_in?
      sign_out
    end
  end

  def create
    user = User.find_by(email: params[:session][:email]);
    if user &&  user.authenticate(params[:session][:password])
      sign_in user
      if params[:session][:remember_me] == "1"
        remember user
      else
        forget user
      end
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid email/password!!!'
      render 'new'
    end
  end

  def destroy
    if signed_in?
      sign_out
    end
    redirect_to signin_path
  end
end
