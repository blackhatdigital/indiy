class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "You Have Successfully Signed In!"
      redirect_to user_path(@user)
    else
      flash[:danger] = "Invalid Username/Password."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You Successfully Logged Out."
    redirect_to root_path
  end
end