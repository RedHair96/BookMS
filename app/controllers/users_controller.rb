class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(book_params)
    @user.email =
    if @user.save
      sign_in @user
      redirect_to @user
      flash[:success] = "Welcome to the BookMS!"
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(book_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private
  def book_params
    params.require(:user).permit(:name, :birthday, :is_female, :phone, :email,
                                 :address, :password, :password_confirmation)
  end
end
