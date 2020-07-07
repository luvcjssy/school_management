class UsersController < BaseController
  before_action :set_user, only: [:show, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'New user has been created!'
      redirect_to users_path
    else
      render :new
    end
  end

  def show; end

  def destroy
    @user.destroy
    flash[:success] = 'User has been deleted!'
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :role)
  end
end
