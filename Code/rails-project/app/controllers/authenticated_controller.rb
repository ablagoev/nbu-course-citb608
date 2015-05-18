# Base controller which takes care ot authenticatio
class AuthenticatedController < ApplicationController
  before_filter :authenticate!

  # check if user is logged in and fetch from database
  def authenticate!
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect_to '/'
      return false
    end
  end
end
