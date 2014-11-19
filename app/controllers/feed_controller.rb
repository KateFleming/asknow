class FeedController < ApplicationController
  before_filter :require_community
  
  def show
    # Search first by tag, then ID
    @feed = Feed.find_by tag: params[:tag]
    if !@feed
      @feed = Feed.find(params[:tag])
    end
  end
  
  def add
    question_id = params[:question_id]
    @question = Question.find(question_id)
    
    feed_id = params[:feed_id]
    
    # If no feed was supplied, check if the account has a feed.
    # If they do, add it to that, otherwise create a new one
    if !feed_id
      # Does the user have a primary feed?
      if current_account.primary_feed
        @feed = current_account.primary_feed
      else
        @feed = Feed.create({
          account: current_account,
          name: "My Feed",
          private: true,
          primary: true
        })
      end
    else
      @feed = Feed.find(feed_id)
    end
    
    @question_bank = QuestionBank.new(feed: @feed, question: @question)
    
    if @question_bank.save
      redirect_to feed_path(@feed.id)
    else
      render question_show_path(@question)
    end
  end
  
  def recent
    @questions = Question.all
  end
end
