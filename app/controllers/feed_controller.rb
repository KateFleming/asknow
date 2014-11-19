class FeedController < ApplicationController
  before_filter :require_community
  
  def index
  end
  
  def recent
    @questions = Question.all
  end
end
