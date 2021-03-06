class WelcomeController < AuthenticatedController
  def index
    # Parse sorting
    @sort = params[:order].to_sym if params[:order] && [:asc, :desc].include?(params[:order].to_sym)
    @sort = :asc unless params[:order]

    # Pass new sorting for view
    @order = :desc
    @order = :asc if @sort == :desc

    @statuses = UserStatus.all.order(created_at: @sort)
  end

  def status
    @status = UserStatus.create(user_id: @user.id, status: params[:status])

    # Validation failed
    # display an error to the user
    flash[:error] = 'Invalid status length.' unless @status.valid?

    redirect_to '/welcome'
  end

  def delete
    @status = UserStatus.where(user_id: @user.id, id: params[:id]).first
    if @status
      @status.destroy
      flash[:info] = 'Status deleted.'
      redirect_to '/welcome'
      return
    end

    flash[:error] = 'Status not found.'
    redirect_to '/welcome'
  end
end
