class UsersController < BaseController
  def index
    @users = User.all
  end
end
