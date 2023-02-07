class PagesController < ApplicationController
  def home
    @question = Question.new
  end

  def create_question
    @question = Question.new(question_params)
    if @question.save
      redirect_to root_path, notice: 'Question was successfully created.'
    else
      render 'home', notice: 'Question was not created.'
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :answers_text)
  end
end
