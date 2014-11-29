class FeedController < ApplicationController
  
  def show
    @question = Question.new
    
    # Search first by tag, then ID
    @feed = Feed.find_by tag: params[:tag]
    if !@feed
      @feed = Feed.find(params[:tag])
    end
    
    @questions = @feed.question_banks.collect{ |bank| bank.question }
    set_page_data Feed.filter_by_page(params[:page], @questions)
    authorize! :read, @feed
    render layout: "full-width"
  end
  
  # What's hot
  def trending
    
    @question = Question.new
    @questions = Question.all
    @questions = @questions.sort_by do |question|
      question.rating.to_i
    end
    
    @questions.reverse!.take(@questions.count * 0.1)
    set_page_data Feed.filter_by_page(params[:page], @questions)
    render layout: "full-width"
  end
  
  # Get all recent questions
  def recent
    @question = Question.new
    @questions = Question.all.order(:created_at).reverse
    set_page_data Feed.filter_by_page(params[:page], @questions)
    render layout: "full-width"
  end
  
  def account
    if current_account.primary_feed
      redirect_to feed_show_path(current_account.primary_feed) and return
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
    authorize! :add, @feed
    @question_bank = QuestionBank.new(feed: @feed, question: @question)
    
    if @question_bank.save
      redirect_to feed_show_path(@feed.id)
    else
      flash[:error] = "You already have that question in your feed"
      render "question/show"
    end
  end
  private
  def set_page_data(page_data)
    @questions = page_data[:items]
    @total_pages = page_data[:total_pages]
    @current_page = page_data[:current_page]
  end
end
