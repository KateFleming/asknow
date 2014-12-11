class FeedController < ApplicationController
  # How many items show per page
  WillPaginate.per_page = 18
  
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
    
    # Get a list of questions sorted by rating
    @questions = Question.only_public.order("rating desc").where.not(rating: nil).paginate({
      :page => params[:page]
    })
    
    render layout: "full-width"
  end
  
  # Get all recent questions
  def recent
    @question = Question.new
    @questions = Question.only_public.order("created_at desc").paginate({
      :page => params[:page]
    })

    render layout: "full-width"
  end
  
  # Get questions by tag
  def gravity
    @question = Question.new
    tag = params[:tag]
    if Tag.exists?(name: tag)
      @questions = Tag.find_by(name: tag).questions.order(:created_at).reverse
      set_page_data Feed.filter_by_page(params[:page], @questions)
      render layout: "full-width"
    else
      @questions = []
      flash[:notice] = "Bummer, '#{params[:tag]}' tag exist. Why don't you tag something with it?"
    end
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
      redirect_to :feed
    end
  end
end
