class UsersController < BaseController
  before_action :set_user, only: [:show, :destroy, :edit, :update]

  def index
    @users = User.all
  end

  def show; end

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

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'User has been updated!'
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    if @user.applicants.present?
      flash[:error] = "This user couldn't be deleted! Because applicant link this user."
    else
      @user.destroy
      flash[:success] = 'User has been deleted!'
    end

    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    params.require(:user).permit(:email, :name, :password, :password_confirmation, :role)
  end
end
