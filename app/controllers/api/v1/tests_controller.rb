module Api
  module V1
    class TestsController < BaseController
      def index
        tests = Test.includes(:questions).all.paginate(page: params[:page], per_page: params[:per_page])
        render_result('Fetch data', true, tests, TestSerializer, build_meta_object(tests))
      end

      def show
        test = Test.includes(questions: :answers).find(params[:id])
        render_object('Test detail', test, TestDetailSerializer)
      end
    end
  end
end
