class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_profile_owner_or_admin, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Hello, #{@user.username}, Welcome to Alpha Blog, You have successfully signed up"
      redirect_to user_path(@user)
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your profile has been updated successfully."
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account has been successfully deleted, and all associated data has also been removed."
    redirect_to articles_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_profile_owner_or_admin
    if @user != current_user && !current_user.admin?
      flash[:alert] = "You can not edit or delete this profile."
      redirect_to user_path(@user)
    end
  end
end