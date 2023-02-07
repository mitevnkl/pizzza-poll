class PagesController < ApplicationController
  def home
    @question = Question.new
    @questions = Question.all.order(created_at: :desc)
    @vote = Vote.new
  end

  def create_question
    @question = Question.new(question_params)
    if @question.save
      redirect_to root_path, notice: 'Question was successfully created.'
    else
      render 'home', notice: 'Question was not created.'
    end
  end

  def create_vote
    @question = Question.find(params[:vote][:question_id])
    @vote = Vote.new(vote_params)
    if @vote.save
      redirect_to root_path, notice: "Your vote was successfully recorded."
    else
      render :new
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :answers_text)
  end

  def vote_params
    params.require(:vote).permit(:question_id, :answer, :voter_ip)
  end
end
