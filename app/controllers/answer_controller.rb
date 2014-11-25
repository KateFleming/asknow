class AnswerController < ApplicationController
  def new
    @question = Question.find(params[:id])
    @answer = Answer.new(answer_params)
    @answer.question = @question
    @answer.account = current_account
    
    authorize! :create, @answer
    
    if @answer.save
      redirect_to question_show_path(params[:id])
    else
      flash[:error] = "Could not save answer"
      render "question/show"
    end
    
  end
  
  def delete
    @answer = Answer.find(params[:id])
    authorize! :destroy, @answer
    
    if @answer.destroy
      flash[:notice] = "Good bye, dear answer."
    else
      flash[:error] = "Well shoot, we couldn't delete that answer."
    end
    redirect_to :back
  end
  private
    def answer_params
      params.require(:answer).permit(:entry)
    end
end
