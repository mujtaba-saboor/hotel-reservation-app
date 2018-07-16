class UsersController < ApplicationController
  before_action :admin_user, only: [:destroy, :create, :new, :index]

  def index
    @users = User.where.not(role: 'admin').paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_url
  end

  def new
    @user = User.new
  end

  def show
    @reservations = Reservation.where(user_id: params[:format], booked: true).paginate(page: params[:page])
    session[:user] = params[:format]
  end

  def create
    params[:user][:role] = 'admin' if params[:user][:role] == '1'
    @user = User.new(user_params)
    # @user.confirmed_at = Time.now
    # @user.skip_confirmation_notification!
    if @user.save
      flash[:success] = 'User added!'
      redirect_to users_path
    else
      render 'new'
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :password, :email, :password_confirmation, :role)
  end

  def admin_user
    redirect_to(root_url) unless can? :manage, User
  end
end
