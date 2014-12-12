class QuestionController < ApplicationController
  before_filter :require_verified_account
  
  def index
    @question = Question.new
  end
  
  def ask
    # Create a new question
    new_params = question_params
    new_params[:tags] = Tag.process_all(new_params[:tags])
    if new_params[:group]
      new_params[:group] = Group.find(new_params[:group])
    end
    @question = Question.new(new_params)
    @question.account = current_account
    
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
    
    if @question.group
      unless current_account.group_member? @question.group
        flash[:error] = "You can't view that group"
        redirect_to :trending and return
      end
    end
    
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
    params.require(:question).permit(:entry, :tags, :group)
  end
end
