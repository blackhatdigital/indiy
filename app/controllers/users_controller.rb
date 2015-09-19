class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to thankyou_path
    else
      flash[:danger] = "Invalid information given, check errors below."
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username,:email,:password)
  end
end