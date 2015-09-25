class ConnectController < ApplicationController
#  def create
#    options = {
#      client_secret: ENV['STRIPE_SECRET'],
#      code: params[:code],
#      grant_type: "authorization_code"
#    }
#  end

  def create
    response = request.env['omniauth.auth']
    @user = current_user
    @user.publishable_key = response.info.stripe_publishable_key
    @user.stripe_user_id = response.extra.raw_info.stripe_user_id
    @user.secret_key = response.credentials.token
    if @user.save
      flash[:success] = "Account linked successfully, you can now start selling!"
    else
      flash[:danger] = "Account not linked, something went wrong."
    end
    redirect_to user_path(@user)
  end

  def access_denied
    flash[:danger] = "Account not connected, you need to create and/or give us access to your Stripe account."
    redirect_to user_path(current_user)
  end

end