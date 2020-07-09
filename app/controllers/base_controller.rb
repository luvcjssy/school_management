class BaseController < ApplicationController
  before_action :authenticate_user!, :authorize_teacher

  private

  def authorize_teacher
    return if current_user.teacher?
    sign_out current_user
    redirect_to new_user_session_path, alert: 'Teachers only!'
  end
end