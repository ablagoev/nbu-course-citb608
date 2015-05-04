class WelcomeController < AuthenticatedController
  def index
    @statuses = UserStatus.all
  end

  def status
    UserStatus.create(user_id:@user.id, status: params[:status])
    redirect_to '/welcome'
  end
end
