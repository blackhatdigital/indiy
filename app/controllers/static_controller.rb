class StaticController < ApplicationController
  before_action :logged_out_only, except: :thank_you
  
  def thank_you
  end

  def pricing
    @user = User.new
  end

  def how_it_works
  end

  def landing
    @user = User.new
  end

end