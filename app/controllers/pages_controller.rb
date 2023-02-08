class PagesController < ApplicationController
  def home
    @question = Question.new
    @questions = Question.eager_load(:votes).order(created_at: :desc)
    @vote = Vote.new
  end

  def create_question
    @question = Question.new(question_params)
    if @question.save
      redirect_to root_path
      flash[:notice] = "Question was recorded successfully!"
    else
      redirect_to root_path
      flash[:alert] = @question.errors.full_messages.join(', ')
    end
  end

  def create_vote
    @question = Question.find(params[:vote][:question_id])
    @vote = Vote.new(vote_params)
    if @question.voted_by_ip?(request.remote_ip)
      redirect_to root_path
      flash[:alert] = "You already voted for this question!"
    else
      if @vote.save
        redirect_to root_path, notice: 'Vote was successfully created.'
      else
        redirect_to root_path
        flash[:alert] = "You must select an answer!"
      end
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
