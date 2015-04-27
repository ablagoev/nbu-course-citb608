class AuthenticatedController < ApplicationController
  before_filter :authenticate

  def authenticate
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect_to '/'
      return false
    end
  end
end
