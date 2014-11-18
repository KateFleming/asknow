class LandingController < ApplicationController
  def index
    @communities = Community.all
  end
end
