class VoteController < ApplicationController
  def cast
    @answer = Answer.find(params[:id])
    @question = @answer.question
    @vote = Vote.new(account: current_account, answer: @answer)
    
    authorize! :create, @vote
    
    if @vote.save
      redirect_to :back
    else
      flash[:error] = "You've already voted on that answer"
      redirect_to :back
    end
  end
end
