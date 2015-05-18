class UsersController < AuthenticatedController
  # Override default application layout
  layout 'login'

  # Do not check for login on login form and authenticate action
  skip_before_filter :authenticate!, only: [:login, :authenticate]

  # Display login form
  def login
  end

  # Process login form
  def authenticate
    @user = User.where(email: params[:email], password: User.encrypted_password(params[:password])).first

    if @user
      redirect_to '/welcome'
      session[:user_id] = @user.id
    else
      redirect_to '/'
    end
  end

  # Destroy user session and redirect to login page
  def logout
    reset_session
    redirect_to '/'
  end
end
