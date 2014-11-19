class VoteController < ApplicationController
  def cast
    @answer = Answer.find(params[:id])
    @question = @answer.question
    @vote = Vote.new(account: current_account, answer: @answer)
    
    if @vote.save
      redirect_to question_show_path(@question)
    else
      @page_errors = "You've already voted on that answer"
      render "question/show"
    end
  end
end
