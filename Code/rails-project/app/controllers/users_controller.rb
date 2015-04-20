class UsersController < ApplicationController
  def login
  end

  def authenticate
    @user = User.where(email: params[:email], password: User.encrypted_password(params[:password])).first

    if @user
      redirect_to '/welcome'
    else
      redirect_to '/'
    end
  end
end
