class TestsController < BaseController
  before_action :set_test, only: [:edit, :update, :destroy]

  def index
    @tests = Test.includes(:questions).all
  end

  def new
    @test = Test.new
    @test.questions.build.answers.build
  end

  def create
    @test = Test.new(test_params)

    if @test.save
      flash[:success] = 'New test has been created!'
      redirect_to tests_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @test.update(test_params)
      flash[:success] = 'Test has been updated!'
      redirect_to tests_path
    else
      render :edit
    end
  end

  def destroy
    @test.destroy
    flash[:success] = 'Test has been deleted!'
    redirect_to tests_path
  end

  private

  def set_test
    @test = Test.includes(questions: :answers).find(params[:id])
  end

  def test_params
    params.require(:test).permit(:name, :description,
                                 questions_attributes: [:id, :label, :description, :_destroy,
                                                        answers_attributes: [:id, :result, :correct, :_destroy]])
  end
end
