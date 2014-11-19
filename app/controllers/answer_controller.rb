class AnswerController < ApplicationController
  def new
    @question = Question.find(params[:id])
    @answer = Answer.new(answer_params)
    @answer.question = @question
    @answer.account = current_account
    
    if @answer.save
      redirect_to question_show_path(params[:id])
    else
      @page_errors = "Could not save answer"
      render "question/show"
    end
    
  end
  
  private
    def answer_params
      params.require(:answer).permit(:entry)
    end
end
