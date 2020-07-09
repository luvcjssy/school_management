module Api
  module V1
    class ApplicantsController < BaseController
      def create
        @applicant = current_user.applicants.build(applicant_params)

        if @applicant.save
          render_sucess('Saved successfully')
        else
          render_error('Unprocessable Entity', false, 422, @applicant.errors)
        end
      end

      private

      def applicant_params
        params.require(:applicant).permit(:test_id, result: [:question_id, answer_ids: []])
      end
    end
  end
end