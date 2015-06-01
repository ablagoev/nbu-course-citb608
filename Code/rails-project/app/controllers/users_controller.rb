class UsersController < AuthenticatedController
  # Do not check for login on login form and authenticate action
  skip_before_action :authenticate!, only: [:login, :authenticate]

  # Display login form
  def login
    # Override the default layout
    render :login, layout: 'login'
  end

  # Process login form
  def authenticate
    @user = User.where(email: params[:email], password: User.encrypted_password(params[:password])).first

    if @user
      redirect_to '/welcome'
      session[:user_id] = @user.id
    else
      flash[:error] = 'Invalid email or password provided. Please try again.'
      redirect_to '/'
    end
  end

  # Destroy user session and redirect to login page
  def logout
    reset_session
    flash[:info] = 'Logged out.'
    redirect_to '/'
  end

  # Change password form
  def password
  end

  def update_password
    # TODO: return error if params are empty

    # Check users current password
    if @user.password != User.encrypted_password(params[:password])
      flash[:error] = 'Wrong password.'
      redirect_to '/users/password'
      return
    end

    # Check new password and confirm password
    if params[:new_password] != params[:confirm_password] && params[:new_password].length > 0
      flash[:error] = 'New password does not match with confirmation.'
      redirect_to '/users/password'
      return
    end

    # Everything ok update password
    @user.password = User.encrypted_password(params[:new_password])
    @user.save

    flash[:info] = 'Password updated.'
    redirect_to '/welcome'
  end

  # Change email form
  def email
  end

  def update_email
    # TODO: return error if params are empty
    if @user.password != User.encrypted_password(params[:password])
      flash[:error] = 'Wrong password.'
      redirect_to '/users/email'
      return
    end

    @user.email = params[:email]

    # If user is not valid
    # show an error
    unless @user.valid?
      flash[:error] = 'Email not valid.'
      redirect_to '/users/email'
      return
    end

    @user.save

    flash[:info] = 'Email updated!'
    redirect_to '/welcome'
  end
end
