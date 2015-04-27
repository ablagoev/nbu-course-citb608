class UsersController < ApplicationController
  layout 'login'

  def login
  end

  def authenticate
    @user = User.where(email: params[:email], password: User.encrypted_password(params[:password])).first

    if @user
      redirect_to '/welcome'
      session[:user_id] = @user.id
    else
      redirect_to '/'
    end
  end

  def logout
    reset_session
    redirect_to '/'
  end
end
