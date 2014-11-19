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
    
    if @question.save
      redirect_to question_show_path(@question)
    else
      render index
    end
  end
  
  def show
    @question = Question.find(params[:id])
  end
    
  private
    def question_params
      params.require(:question).permit(:entry)
    end
end
