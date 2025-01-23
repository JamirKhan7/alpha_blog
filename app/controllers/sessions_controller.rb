class SessionsController < ApplicationController
  def new
    
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Hello #{user.username}, you have loggen in successfully"
      redirect_to user_path(user)
    else
      flash.now[:alert] = "You have entered incorrect login details"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have successfully logged out"
    redirect_to root_path
  end
end