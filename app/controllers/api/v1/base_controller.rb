module Api
  module V1
    class BaseController < ApiController
      before_action :authenticate_user!
      before_action :authorize_student

      def authorize_student
        return true if current_user.student?
        raise UnauthorizedError
      end

      class UnauthorizedError < StandardError; end
      rescue_from UnauthorizedError do |e|
        error_msg = { unauthorized: ['You are not allow to do this action'] }
        render_error(:unauthorized, false, :unauthorized, error_msg)
      end
    end
  end
end
