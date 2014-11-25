class QuestionController < ApplicationController
  before_filter :require_community
  
  def index
    @question = Question.new
  end
  
  def ask
    # Get keywords
    entry = question_params[:entry]
    
    # Find and replace hash tags in entry
    tag_pattern = Regexp.new(/(?:^|\s)#(\w+)/i)
    keywords = []
    entry.gsub(tag_pattern){ |tag| keywords << tag }
    
    @question = Question.new({
      account: current_account,
      community: current_account.community,
      entry: entry.gsub(tag_pattern, ''),
      keywords: keywords.join(",")
    })
    
    authorize! :create, @question
    
    if @question.save
      redirect_to question_show_path(@question)
    else
      render index
    end
  end
  
  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
    @vote = Vote.new
    
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
    params.require(:question).permit(:entry)
  end
end
