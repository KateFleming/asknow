class QuestionController < ApplicationController
  before_filter :require_verified_account
  
  def index
    @question = Question.new
  end
  
  def ask
    @question = Question.new({
      account: current_account,
      entry: question_params[:entry],
      tags: Tag.process_all(question_params[:tags])
    })
    authorize! :create, @question
    if @question.save
      redirect_to question_show_path(@question)
    else
      flash[:errors] = @question.errors.full_messages.join(", ")
      redirect_to :back
    end
  end
  
  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
    @vote = Vote.new
    
    # Get all the answers and sort them
    @answers = @question.answers.sort_by do |answer| 
      answer.votes.count
    end.reverse
    
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "We couldn't find that question"
      redirect_to trending_path
  end
  
  def delete
    @question = Question.find(params[:id])
    authorize! :destroy, @question
    if @question.destroy
      flash[:notice] = "Good bye, dear question."
    else
      flash[:error] = "Well shoot, we couldn't delete that question."
    end
    redirect_to :trending
  end
  private
  def question_params
    params.require(:question).permit(:entry, :tags)
  end
end
