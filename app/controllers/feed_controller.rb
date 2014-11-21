class FeedController < ApplicationController
  before_filter :require_community
  
  def show
    # Search first by tag, then ID
    @feed = Feed.find_by tag: params[:tag]
    if !@feed
      @feed = Feed.find(params[:tag])
    end
    
    @questions = @feed.question_banks.collect{ |bank| bank.question }
  end
  
  # What's hot
  def trending
    @question = Question.new
    
    @questions = Question.community(current_community)
    @questions = @questions.sort_by do |question|
      question.rating.to_i
    end
    
    @questions.reverse!.take(@questions.count * 0.1)
    
    # Pagination
    if params[:page]
      @page = params[:page]
    else
      @page = 1
    end
    
    items_per_page = 10
    starting = items_per_page * (@page - 1)
    @questions = @questions.slice(starting, items_per_page)
  end
  
  # Get all recent questions
  def recent
    @question = Question.new
    
    @questions = Question.community(current_community).reverse
  end
  
  def account
    if current_account.primary_feed
      redirect_to feed_show_path(current_account.primary_feed)
    end
    
    @feed = Feed.new
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
      redirect_to feed_show_path(@feed.id)
    else
      flash[:error] = "You already have that question in your feed"
      render "question/show"
    end
  end
end
