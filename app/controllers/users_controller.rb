class UsersController < ApplicationController
  # Authorization user
  before_action :signed_in_user, only: [:edit, :create]
  before_action :correct_user, only: [:edit, :create]
  before_action :is_admin?, only: [:destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/:id
  def show
    @user = User.find(params[:id])
  end

  # GET /signup
  def new
    sign_out if signed_in?
    @user = User.new
  end

  # GET /users/:id/edit
  def edit
  end

  # POST /signup
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

  # PATCH /users/:id/edit
  def update
    if @user.update(book_params) and update_information(@user)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # DELETE /users/:id
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private
    # Allow strong params
    def book_params
      params.require(:user).permit(:name, :birthday, :is_female, :phone, :email,
                                   :address, :password, :password_confirmation)
    end

    # Deny users, who not yet sign in
    def signed_in_user
      unless signed_in?
        store_previous_url
        flash[:danger] = "Please sign in!!!"
        redirect_to signin_path
      end
    end

    # Deny inproper accession into different users
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless @user == current_user
    end

end